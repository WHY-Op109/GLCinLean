#!/bin/bash
# The monitor of the workflow (AGENTS.md, "Workflow"): it watches the Tau Ceti workers, our pull
# requests in Tau Ceti and the watched pull requests of others. It prints the events and exits
# when one of these happens, and its exit wakes the session:
#   - a worker is not alive, has failed or has restarted, or the Worker's manager is offline;
#   - a pull request of ours is opened, merged or closed, or its CI fails;
#   - a watched pull request is merged or closed;
#   - no event happened for DAY_SECONDS (one day).
# It runs no model. The state is kept in a file, so a new run reports only what changed.
#
# Usage, from the root of the repository, as a background task of the session:
#   tools/monitor.sh [OWNER/REPO#NUMBER ...]
# The arguments are the watched pull requests that STATUS.md lists under "Workers".
# Environment: MONITOR_STATE (default .lake/monitor-state.json), POLL_SECONDS (default 900),
# DAY_SECONDS (default 86400).

STATE="${MONITOR_STATE:-.lake/monitor-state.json}"
POLL_SECONDS="${POLL_SECONDS:-900}"
DAY_SECONDS="${DAY_SECONDS:-86400}"
start=$(date +%s)

while true; do
  events=$(python3 - "$STATE" "$@" <<'EOF'
import json, subprocess, sys

state_path, watched = sys.argv[1], sys.argv[2:]
try:
    old = json.load(open(state_path))
except Exception:
    old = None  # the first run records the state and reports no pull request
new = {"workers": {}, "prs": {}, "watched": {}, "manager": True}
if old:
    new.update({k: old.get(k, new[k]) for k in new})
events = []


def run(cmd, timeout):
    return subprocess.run(cmd, capture_output=True, text=True, timeout=timeout).stdout


def pr_state(p):
    merged = p["state"] == "MERGED" or p["title"].startswith("[Merged by Bors]")
    return "MERGED" if merged else p["state"]


# A failure of a command (network, GitHub) is not an event: the old state is kept.
try:
    d = json.loads(run(["tauceti", "workers", "status", "--json"], 120))
    workers = {}
    for w in d.get("workers", []):
        bad = (not w.get("alive")) or bool(w.get("failure_reason")) or w.get("actual") in (
            "failed", "stopped", "exited", "crashed")
        prev = (old or {}).get("workers", {}).get(w["id"], {})
        workers[w["id"]] = {"bad": bad, "restarts": w.get("restart_count", 0)}
        if bad and not prev.get("bad"):
            events.append(f"WORKER {w['id']} {w.get('actual')}: {w.get('failure_reason')}")
        if old and w.get("restart_count", 0) > prev.get("restarts", 0):
            events.append(f"WORKER {w['id']} restarted ({w.get('restart_count')} restarts)")
    new["workers"] = workers
    new["manager"] = bool(d.get("manager"))
    if not new["manager"] and (old is None or old.get("manager", True)):
        events.append("MANAGER of the workers is offline")
except Exception:
    pass

try:
    prs = {}
    for p in json.loads(run(["gh", "pr", "list", "-R", "TauCetiProject/TauCeti", "--author", "@me",
                             "--state", "all", "--limit", "100",
                             "--json", "number,title,state,labels"], 120)):
        key, st = str(p["number"]), pr_state(p)
        failed = "ci-failed" in [label["name"] for label in p.get("labels", [])]
        prs[key] = {"state": st, "failed": failed}
        if old is None:
            continue
        prev = old.get("prs", {}).get(key)
        if prev is None:
            events.append(f"PR #{key} opened: {p['title']}")
        elif prev["state"] != st:
            events.append(f"PR #{key} {st}: {p['title']}")
        if failed and not (prev or {}).get("failed"):
            events.append(f"PR #{key} CI failed: {p['title']}")
    new["prs"] = prs
except Exception:
    pass

for item in watched:
    try:
        repo, number = item.split("#")
        p = json.loads(run(["gh", "pr", "view", number, "-R", repo, "--json", "state,title"], 60))
        st = pr_state(p)
        prev = (old or {}).get("watched", {}).get(item)
        if prev is not None and prev != st:
            events.append(f"WATCHED {item} {st}: {p['title']}")
        new["watched"][item] = st
    except Exception:
        pass

json.dump(new, open(state_path, "w"))
print("\n".join(events))
EOF
)
  if [ -n "$events" ]; then
    echo "$events"
    exit 0
  fi
  if [ $(( $(date +%s) - start )) -ge "$DAY_SECONDS" ]; then
    echo "DAILY no event for $DAY_SECONDS seconds: run one cycle of the workflow"
    exit 0
  fi
  sleep "$POLL_SECONDS"
done
