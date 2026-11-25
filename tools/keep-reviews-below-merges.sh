#!/bin/bash
# Keeps the number of reviews of the workers' GitHub account just below its number of merged pull
# requests, as Tau Ceti's dashboard counts them (https://taucetiproject.org/people.html). It runs
# on the host of the Tau Ceti workers. With M merges and R reviews, it enables the worker
# REVIEW_WORKER when R < M - MARGIN_HIGH, disables it when R >= M - MARGIN_LOW, and leaves it as
# it is in between. It runs `tauceti workers enable` or `tauceti workers disable` only when the
# state of the worker must change. It runs no model.
#
# The two numbers come from GitHub, because the dashboard refreshes its data only every few
# hours. They follow the rules of the dashboard (TauCetiTools, pr_stats_graphs.py):
#   - a merge is a pull request of the account in REPO that GitHub shows as merged, or whose title
#     starts with "[Merged by Bors] - ";
#   - a review is a comment of the account on a pull request of REPO that contains
#     "<!--tauceti-scoreboard-->" and a "tauceti-meta:v1" block with the kind "scoreboard" and the
#     number of that pull request. Two such comments on one pull request are two reviews.
# The pull requests that can hold a review come from two sources: GitHub's search (the pull
# requests on which the account commented), and the activity database of the Worker on this host
# (the pull requests of its review rounds). GitHub's search can miss a pull request for hours, and
# the database knows only the reviews of this host. The comments of each such pull request are
# read from GitHub. A state file keeps the result for each pull request; the comments are read
# again only when the pull request has changed.
# When GitHub or the Worker cannot be read, the script changes nothing and writes the reason.
#
# Install on the workers' host as ~/.local/bin/keep-reviews-below-merges, with this crontab line:
#   */10 * * * * MARGIN_HIGH=4 MARGIN_LOW=2 "$HOME/.local/bin/keep-reviews-below-merges"
# Usage by hand:
#   DRY_RUN=1 keep-reviews-below-merges
# With DRY_RUN=1 it prints the line of the log and the command that it would run, and it changes
# no worker and writes no file.
# Environment: REVIEW_WORKER (default reviewer): the id of the worker in workers.toml.
# MARGIN_HIGH (default 3) and MARGIN_LOW (default 1), with MARGIN_HIGH >= MARGIN_LOW.
# REPO (default TauCetiProject/TauCeti). SEARCH_PAUSE (default 2.5): the seconds before each
# request to GitHub's search, which allows 30 requests a minute for the whole account.
# The GitHub account is the one that `gh` is logged in to (`gh api user`).
# Log: ~/.local/state/tauceti/keep-reviews-below-merges.log (the last 2000 lines are kept): one
# line per run with the time, M, R, the state of the worker and the action.
# State file: ~/.local/state/tauceti/keep-reviews-below-merges.json.

# The network settings of the host (a proxy, when it has one): cron loads none, so the host states
# them in ~/.config/tauceti/network-env.sh, as for tools/keep-workers-running.sh.
[ -f "$HOME/.profile" ] && . "$HOME/.profile" >/dev/null 2>&1
NETWORK_ENV="${XDG_CONFIG_HOME:-$HOME/.config}/tauceti/network-env.sh"
[ -f "$NETWORK_ENV" ] && . "$NETWORK_ENV"
export PATH="$HOME/.local/bin:$PATH"

export REVIEW_WORKER="${REVIEW_WORKER:-reviewer}"
export MARGIN_HIGH="${MARGIN_HIGH:-3}" MARGIN_LOW="${MARGIN_LOW:-1}"
export REPO="${REPO:-TauCetiProject/TauCeti}" SEARCH_PAUSE="${SEARCH_PAUSE:-2.5}"
export DRY_RUN="${DRY_RUN:-0}"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/tauceti"
LOG="$STATE_DIR/keep-reviews-below-merges.log"
export CACHE="$STATE_DIR/keep-reviews-below-merges.json"
export ACTIVITY_DB="$STATE_DIR/activity/activity.sqlite"

if [ "$DRY_RUN" != 1 ]; then
  mkdir -p "$STATE_DIR"
  exec 9>"$LOG.lock"
  flock -n 9 || exit 0
fi

now() { date -u +%Y-%m-%dT%H:%M:%SZ; }

# Prints one line: the action (`enable`, `disable` or `none`), a space, and the text for the log.
result=$(python3 - <<'EOF'
import datetime, json, os, re, sqlite3, subprocess, time

repo, worker = os.environ["REPO"], os.environ["REVIEW_WORKER"]
dry_run = os.environ["DRY_RUN"] == "1"
MARKER = "<!--tauceti-scoreboard-->"
META = re.compile(r"<!--tauceti-meta:v1\s+(\{[\s\S]*\})\s*-->")
MERGED_TITLE = "[Merged by Bors] - "


class Unreadable(Exception):
    """GitHub or the Worker gave no usable answer."""


def command(args, what, timeout=180):
    try:
        r = subprocess.run(args, capture_output=True, text=True, timeout=timeout)
    except (OSError, subprocess.TimeoutExpired) as e:
        raise Unreadable(f"{what}: {type(e).__name__}")
    if r.returncode != 0:
        lines = (r.stderr or r.stdout).strip().splitlines()
        raise Unreadable(f"{what}: {lines[-1][:160] if lines else 'no answer'}")
    return r.stdout


def search_page(query, page):
    time.sleep(float(os.environ["SEARCH_PAUSE"]))
    d = json.loads(command(["gh", "api", "-X", "GET", "search/issues", "-f", "q=" + query,
                            "-f", "per_page=100", "-f", f"page={page}"], "GitHub search"))
    if d.get("incomplete_results"):
        raise Unreadable("GitHub search: incomplete results")
    return d


def search(query, first=datetime.date(2008, 1, 1), last=None):
    """Every pull request that matches the query, by number. GitHub's search returns at most
    1,000 results, so a larger result is read as the two halves of the range of creation dates."""
    last = last or datetime.datetime.now(datetime.timezone.utc).date() + datetime.timedelta(days=1)
    ranged = f"{query} created:{first}..{last}"
    d = search_page(ranged, 1)
    if d["total_count"] > 1000:
        if first >= last:
            raise Unreadable("GitHub search: more than 1,000 pull requests of one day")
        middle = first + (last - first) // 2
        found = search(query, first, middle)
        found.update(search(query, middle + datetime.timedelta(days=1), last))
        return found
    found, page = {item["number"]: item for item in d["items"]}, 1
    while len(found) < d["total_count"] and d["items"] and page < 10:
        page += 1
        d = search_page(ranged, page)
        found.update({item["number"]: item for item in d["items"]})
    return found


def review_rounds():
    """The pull requests of the review rounds of the workers of this host, with the time of the
    last one, from the activity database of the Worker. None when it cannot be read."""
    try:
        db = sqlite3.connect(f"file:{os.environ['ACTIVITY_DB']}?mode=ro", uri=True, timeout=10)
        rows = db.execute(
            "select number, max(at) from pr_contributions where repo = ? and activity = 'review' "
            "group by number", (repo,)).fetchall()
        rows += db.execute(
            "select p.number, max(r.started) from rounds r join round_prs p on p.round_id = r.id "
            "where r.kind = 'review' and p.repo = ? group by p.number", (repo,)).fetchall()
    except sqlite3.Error:
        return None
    found = {}
    for number, at in rows:
        found[number] = max(found.get(number, 0), at or 0)
    return found


def scoreboards(number, login):
    """The ids of the comments of the account on this pull request that the dashboard counts."""
    out = command(["gh", "api", f"repos/{repo}/issues/{number}/comments?per_page=100", "--paginate",
                   "--jq", f".[] | select(.user.login == {json.dumps(login)}) "
                   f"| select((.body // \"\") | contains({json.dumps(MARKER)})) | {{id, body}}"],
                  f"comments of #{number}")
    ids = []
    for line in out.splitlines():
        comment = json.loads(line)
        match = META.search(comment["body"])
        try:
            meta = json.loads(match.group(1)) if match else None
        except ValueError:
            meta = None
        if isinstance(meta, dict) and meta.get("kind") == "scoreboard" and \
                type(meta.get("pr")) is int and meta["pr"] == number:
            ids.append(comment["id"])
    return ids


def main():
    high, low = int(os.environ["MARGIN_HIGH"]), int(os.environ["MARGIN_LOW"])
    if high < low:
        return "none", f"MARGIN_HIGH ({high}) is below MARGIN_LOW ({low}): nothing changed"
    login = command(["gh", "api", "user", "--jq", ".login"], "GitHub account").strip()
    if not login:
        raise Unreadable("GitHub account: no login")

    closed = search(f"repo:{repo} is:pr is:closed author:{login}")
    merges = sum(1 for item in closed.values()
                 if item["title"].startswith(MERGED_TITLE)
                 or (item.get("pull_request") or {}).get("merged_at"))

    try:
        cache = json.load(open(os.environ["CACHE"]))
        known = cache["prs"] if (cache["login"], cache["repo"]) == (login, repo) else {}
    except (OSError, ValueError, KeyError, TypeError):
        known = {}
    commented = search(f"repo:{repo} is:pr commenter:{login}")
    rounds = review_rounds()
    for number in sorted(set(commented) | set(rounds or {})):
        stamp = f"{commented.get(number, {}).get('updated_at', '')} {(rounds or {}).get(number, 0)}"
        if known.get(str(number), {}).get("stamp") != stamp:
            known[str(number)] = {"stamp": stamp, "ids": scoreboards(number, login)}
    if not dry_run:
        with open(os.environ["CACHE"] + ".tmp", "w") as f:
            json.dump({"login": login, "repo": repo, "prs": known}, f)
        os.replace(os.environ["CACHE"] + ".tmp", os.environ["CACHE"])
    reviews = sum(len(entry["ids"]) for entry in known.values())
    reviewed = sum(1 for entry in known.values() if entry["ids"])

    status = json.loads(command(["tauceti", "workers", "status", "--json"], "tauceti workers status"))
    text = f"merges {merges}, reviews {reviews} on {reviewed} pull requests"
    if rounds is None:
        text += " (the activity database was not read)"
    found = [w for w in status.get("workers", []) if w.get("id") == worker]
    if not found:
        return "none", f"{text}; no worker {worker} in workers.toml: nothing changed"
    enabled = found[0].get("desired") != "stopped"
    text += f"; worker {worker} is {'enabled' if enabled else 'disabled'}"
    if reviews < merges - high:
        if enabled:
            return "none", f"{text}; reviews < merges - {high}: it stays enabled"
        return "enable", f"{text}; reviews < merges - {high}"
    if reviews >= merges - low:
        if enabled:
            return "disable", f"{text}; reviews >= merges - {low}"
        return "none", f"{text}; reviews >= merges - {low}: it stays disabled"
    return "none", f"{text}; between the two limits: no change"


try:
    print(*main())
except Unreadable as e:
    print("none", f"cannot read {e}: nothing changed")
except Exception as e:  # an answer in a form that this script does not know
    print("none", f"cannot read the answers ({type(e).__name__}: {str(e)[:120]}): nothing changed")
EOF
)

action="${result%% *}"
text="${result#* }"
[ -n "$result" ] || { action=none; text="the count gave no answer: nothing changed"; }
case "$action" in
  enable|disable) text="$text: tauceti workers $action $REVIEW_WORKER" ;;
esac

if [ "$DRY_RUN" = 1 ]; then
  echo "$(now) $text"
  case "$action" in
    enable|disable) echo "DRY_RUN: would run: tauceti workers $action $REVIEW_WORKER" ;;
    *) echo "DRY_RUN: would run no command" ;;
  esac
  exit 0
fi

echo "$(now) $text" >> "$LOG"
case "$action" in
  enable|disable)
    tauceti workers "$action" "$REVIEW_WORKER" >> "$LOG" 2>&1 ||
      echo "$(now) tauceti workers $action $REVIEW_WORKER failed" >> "$LOG"
    ;;
esac
tail -n 2000 "$LOG" > "$LOG.tmp" && mv "$LOG.tmp" "$LOG"
