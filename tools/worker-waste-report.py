#!/usr/bin/env python3
"""Reports where the model tokens of the Tau Ceti workers went, and how much of them was lost.

It runs on the host of the workers, by hand or from cron once a week. It reads only: it changes
no file of the Worker and runs no model. It needs Python 3 and its standard library.

Usage:
  worker-waste-report.py [--days N] [--until TIME] [--github] [--json FILE]
                         [--prices FILE] [--codex-model NAME]

  --days N           the length of the period in days (default 7). The Worker deletes its logs
                     after a few days, so the report names the days whose logs are gone.
  --until TIME       the end of the period, in UTC, as YYYY-MM-DD or YYYY-MM-DDTHH:MM
                     (default: now).
  --github           ask `gh` for the state of each pull request. Without it the states come
                     from the activity database, which often has none.
  --json FILE        also write the report as JSON, with one record per run.
  --prices FILE      the price table (default: prices.json of the installed tauceti_worker).
  --codex-model NAME the model of the Codex runs. Their logs do not name it, so without this
                     option the Codex runs have no price.

Install on the workers' host as ~/.local/bin/worker-waste-report, with this crontab line:
  0 6 * * 1 mkdir -p "$HOME/.local/state/tauceti/waste" && python3 "$HOME/.local/bin/worker-waste-report" --github --json "$HOME/.local/state/tauceti/waste/report.json" > "$HOME/.local/state/tauceti/waste/report.txt" 2>&1

What it reads:
  - ~/.local/share/tauceti/logs/<worker>/agent-<provider>-<date>-<time>-telemetry.json: the token
    totals of one agent run, from the provider. The run starts at the time in the name (UTC) and
    ends at the modification time of the file. A run with a log and no telemetry file was killed,
    or still runs.
  - agent-<provider>-<date>-<time>.log, while it exists: its first lines name the model.
  - prices.json of the package tauceti_worker: the price of each model, in USD per million tokens.
  - ~/.local/state/tauceti/activity/activity.sqlite (opened read-only): the round of each run (its
    phase and outcome) and the pull requests that the round created or worked on.
  - ~/.local/state/tauceti/workers/logs/<worker>/work-*.log: why a run ended early (a lost claim,
    `API Error: 401`, exit -9) and how long the workers waited for quota.

What it prints: the period and the days with data; the totals per provider, per worker and per
phase (runs, agent-hours, tokens, cost); the classes of the runs with their share of the cost; the
hours that the workers waited, by reason; the runs without a price; and one last line
`lost share: X% of $Y`.

The cost is the price of the tokens at the price table, not an amount that was paid. The tokens
that a run wrote to the prompt cache have the price of the five-minute cache. A Codex run has the
price of the normal context length. A run without token totals has an estimated cost: its length
times the mean cost per hour of the runs of the same phase.
"""

import argparse
import collections
import datetime
import glob
import json
import os
import re
import sqlite3
import subprocess
import sys

UTC = datetime.timezone.utc
HOME = os.path.expanduser("~")
DATA = os.path.join(os.environ.get("XDG_DATA_HOME") or HOME + "/.local/share", "tauceti")
STATE = os.path.join(os.environ.get("XDG_STATE_HOME") or HOME + "/.local/state", "tauceti")
CONFIG = os.path.join(os.environ.get("XDG_CONFIG_HOME") or HOME + "/.config", "tauceti")

# The classes of the runs: key, text, and whether the cost of the class counts as lost.
CLASSES = [
    ("merged", "created or updated a pull request that merged", False),
    ("open", "created or updated a pull request that is open", False),
    ("closed", "created or updated a pull request that was closed without merge", True),
    ("unknown", "created or updated a pull request, state not known (use --github)", False),
    ("nothing", "roadmap run of under ten minutes without a pull request (nothing to do)", True),
    ("e401", "ended by API Error: 401", True),
    ("claim", "killed by a lost claim", True),
    ("kernel", "killed by the kernel (exit -9)", True),
    ("failed", "other failed runs", True),
    ("no_result", "other runs without a pull request", True),
    ("running", "still running", False),
]
WAITS = [
    ("weekly", "weekly quota used up"),
    ("r429", "usage endpoint refused the request (429)"),
    ("no_reading", "no usage reading (the usage service was not reached)"),
    ("pace", "ahead of pace"),
    ("other", "other reasons"),
]


def stamp_time(stamp):
    return datetime.datetime.strptime(stamp, "%Y%m%d-%H%M%S").replace(tzinfo=UTC).timestamp()


def day_of(t):
    return datetime.datetime.fromtimestamp(t, UTC).strftime("%Y-%m-%d")


def find_prices(path):
    """The price table: {model: [window, ...]}, each window with `effective` and the prices."""
    candidates = [path] if path else sorted(glob.glob(
        DATA.replace("/tauceti", "") + "/uv/tools/tauceti/lib/python*/site-packages/"
        "tauceti_worker/prices.json"))
    if not path:
        try:
            import importlib.util
            spec = importlib.util.find_spec("tauceti_worker")
            if spec and spec.origin:
                candidates.insert(0, os.path.join(os.path.dirname(spec.origin), "prices.json"))
        except (ImportError, ValueError):
            pass
    for candidate in candidates:
        try:
            return json.load(open(candidate))["models"], candidate
        except (OSError, ValueError, KeyError):
            continue
    return {}, None


def price_window(prices, model, t):
    """The newest price window of the model that is in effect on the day of the run."""
    windows = [w for w in prices.get(model or "", []) if w.get("effective", "") <= day_of(t)]
    return max(windows, key=lambda w: w["effective"]) if windows else None


def run_tokens(usage):
    if "cached_input_tokens" in usage or "reasoning_output_tokens" in usage:  # Codex totals
        return usage.get("input_tokens", 0) + usage.get("output_tokens", 0)
    return sum(usage.get(k, 0) for k in ("input_tokens", "output_tokens",
                                         "cache_read_input_tokens", "cache_creation_input_tokens"))


def run_cost(usage, window):
    if "cached_input_tokens" in usage or "reasoning_output_tokens" in usage:  # Codex totals
        cached = usage.get("cached_input_tokens", 0)
        parts = ((usage.get("input_tokens", 0) - cached) * window["input"]
                 + cached * window.get("cache_read", window["input"])
                 + usage.get("output_tokens", 0) * window["output"])
    else:
        parts = (usage.get("input_tokens", 0) * window["input"]
                 + usage.get("output_tokens", 0) * window["output"]
                 + usage.get("cache_read_input_tokens", 0) * window.get("cache_read", window["input"])
                 + usage.get("cache_creation_input_tokens", 0)
                 * window.get("cache_write_5m", window.get("cache_write", window["input"])))
    return parts / 1e6


def collect_runs(since, until):
    """One record per agent run that started in the period."""
    runs = {}
    name_form = re.compile(r"agent-([a-z]+)-(\d{8}-\d{6})(-telemetry\.json|\.log)$")
    root = os.path.join(DATA, "logs")
    for worker in sorted(os.listdir(root)) if os.path.isdir(root) else []:
        folder = os.path.join(root, worker)
        if not os.path.isdir(folder):
            continue
        for name in sorted(os.listdir(folder)):
            m = name_form.match(name)
            if not m:
                continue
            provider, stamp, kind = m.groups()
            start = stamp_time(stamp)
            if not since <= start < until:
                continue
            run = runs.setdefault((worker, provider, stamp), dict(
                worker=worker, provider=provider, stamp=stamp, start=start, end=None, usage=None,
                model=None, has_log=False))
            path = os.path.join(folder, name)
            try:
                if kind == ".log":
                    run["has_log"] = True
                    run["log_end"] = os.path.getmtime(path)
                    with open(path, errors="replace") as f:
                        m = re.search(r"^\[session\].*\bmodel=(\S+)", f.read(4000), re.M)
                    run["model"] = m.group(1) if m else None
                else:
                    run["end"] = os.path.getmtime(path)
                    run["usage"] = json.load(open(path)).get("usage") or {}
            except (OSError, ValueError):
                continue
    out = []
    for run in runs.values():
        if run["end"] is None:
            run["end"] = run.get("log_end", run["start"])
        run["hours"] = max(0.0, run["end"] - run["start"]) / 3600
        out.append(run)
    return sorted(out, key=lambda r: (r["start"], r["worker"]))


def read_activity(runs, since):
    """Adds to each run its round (phase, outcome), the pull requests of the round and the pull
    requests that the run created. Returns the states of the pull requests that the database has,
    and a note when the database cannot be read."""
    for run in runs:
        run.update(phase=None, outcome=None, round_open=False, prs=[], created=[])
    path = os.path.join(STATE, "activity", "activity.sqlite")
    try:
        db = sqlite3.connect(f"file:{path}?mode=ro", uri=True, timeout=20)
        rounds = collections.defaultdict(list)
        for row in db.execute("select id, worker, kind, outcome, started, finished from rounds "
                              "where started is not null and started >= ? order by started",
                              (since - 2 * 86400,)):
            rounds[row[1]].append(row)
        round_prs = collections.defaultdict(list)
        for round_id, repo, number in db.execute("select round_id, repo, number from round_prs"):
            round_prs[round_id].append((repo, number))
        created = db.execute("select repo, number, worker, created from prs "
                             "where created is not null").fetchall()
        states = {}
        for table in ("prs", "pr_observations"):
            for repo, number, state, landed in db.execute(
                    f"select repo, number, state, landed from {table}"):
                word = str(state or "").lower()
                if landed is not None or word == "merged":
                    states[(repo, number)] = "merged"
                elif word in ("open", "closed"):
                    states.setdefault((repo, number), word)
    except sqlite3.Error as e:
        return {}, f"The activity database was not read ({e}): the phases, outcomes and pull requests of the runs are not known."
    workers = {run["worker"] for run in runs}
    for run in runs:
        fits = [r for r in rounds.get(run["worker"], [])
                if r[4] <= run["start"] + 1 and (r[5] is None or r[5] >= run["start"] - 1)]
        if fits:
            round_id, _, run["phase"], run["outcome"], _, finished = fits[-1]
            run["round_open"] = finished is None
            run["prs"] = sorted(round_prs.get(round_id, []))
    for repo, number, worker, at in created:
        if worker not in workers:  # a name of the form ACCOUNT/WORKER/ID
            worker = next((part for part in str(worker).split("/") if part in workers), worker)
        fits = [r for r in runs if r["worker"] == worker and r["start"] - 60 <= at <= r["end"] + 600]
        if fits:
            min(fits, key=lambda r: abs(at - r["end"]))["created"].append((repo, number))
    return states, None


def loop_records(worker):
    """The lines of the loop logs of a worker, in the order of their times. A line without a time
    belongs to the line with a time before it."""
    records = []
    for path in sorted(glob.glob(os.path.join(STATE, "workers", "logs", worker, "work-*.log"))):
        try:
            lines = open(path, errors="replace").read().split("\n")
        except OSError:
            continue
        for line in lines:
            m = re.match(r"(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d) (?:tauceti: )?(.*)", line)
            if m:
                t = datetime.datetime.strptime(m.group(1), "%Y-%m-%d %H:%M:%S").replace(tzinfo=UTC)
                records.append([t.timestamp(), m.group(2), ""])
            elif records:
                records[-1][2] += line + "\n"
    records.sort(key=lambda r: r[0])
    return records


def read_loop_logs(workers, runs, since, until):
    """Returns the causes {(worker, stamp): set of 'e401', 'claim', 'kernel'}, the waits
    {(worker, reason): seconds}, and the days that have lines in the loop logs. A line about a
    401 error names the log of its run. A line about a lost claim or about exit -9 belongs to the
    run of the worker that was in progress at the time of the line."""
    causes = collections.defaultdict(set)
    waits = collections.defaultdict(float)
    days = set()
    names_run = re.compile(r"agent-[a-z]+-(\d{8}-\d{6})\.log")
    runs_of = collections.defaultdict(list)
    for run in runs:
        runs_of[run["worker"]].append(run)

    def run_at(worker, t, margin):
        fits = [r for r in runs_of[worker] if r["start"] <= t <= r["end"] + margin]
        return max(fits, key=lambda r: r["start"])["stamp"] if fits else None

    for worker in workers:
        records = loop_records(worker)
        for i, (t, text, more) in enumerate(records):
            days.add(day_of(t))
            found = []
            if "API Error: 401" in text + more:
                named = names_run.search(text)
                found.append(("e401", named.group(1) if named else run_at(worker, t, 15)))
            if "lease lost" in text:
                found.append(("claim", run_at(worker, t, 15)))
            if re.match(r"round rc=-9\b", text):
                found.append(("kernel", run_at(worker, t, 60)))
            for cause, stamp in found:
                if stamp:
                    causes[(worker, stamp)].add(cause)
            m = re.search(r"sleeping (\d+)s", text)
            if m and text.startswith("quota:") and since <= t < until:
                following = records[i + 1][0] if i + 1 < len(records) else t + int(m.group(1))
                seconds = max(0.0, min(int(m.group(1)), following - t))
                if "weekly exhausted" in text:
                    reason = "weekly"
                elif "HTTP 429" in text:
                    reason = "r429"
                elif "unreachable" in text or "usage fetch failed" in text:
                    reason = "no_reading"
                elif "ahead of pace" in text:
                    reason = "pace"
                else:
                    reason = "other"
                waits[(worker, reason)] += seconds
    return causes, waits, days


def load_network_env():
    """Takes the network settings of the host (a proxy, when it has one) from
    ~/.config/tauceti/network-env.sh, because cron loads none."""
    path = os.path.join(CONFIG, "network-env.sh")
    if os.path.isfile(path):
        try:
            out = subprocess.run(["bash", "-c", '. "$1" >/dev/null 2>&1; env -0', "bash", path],
                                 capture_output=True, timeout=30).stdout
        except (OSError, subprocess.TimeoutExpired):
            out = b""
        for item in out.split(b"\0"):
            name, found, value = item.partition(b"=")
            if found and name:
                os.environ[name.decode(errors="replace")] = value.decode(errors="replace")
    os.environ["PATH"] = HOME + "/.local/bin:" + os.environ.get("PATH", "")


def github_states(wanted):
    """The state of each pull request of `wanted`, a set of (repo, number), from `gh`."""
    def state(p):
        if p.get("state") == "MERGED" or str(p.get("title", "")).startswith("[Merged by Bors]"):
            return "merged"
        return "open" if p.get("state") == "OPEN" else "closed"

    def gh(args):
        try:
            r = subprocess.run(["gh"] + args, capture_output=True, text=True, timeout=180)
            return json.loads(r.stdout) if r.returncode == 0 else None
        except (OSError, ValueError, subprocess.TimeoutExpired):
            return None

    states, failed = {}, 0
    for repo in sorted({repo for repo, _ in wanted}):
        mine = gh(["pr", "list", "-R", repo, "--author", "@me", "--state", "all", "--limit", "1000",
                   "--json", "number,title,state"])
        for p in mine or []:
            states[(repo, p["number"])] = state(p)
    for repo, number in sorted(wanted):
        if (repo, number) not in states:
            p = gh(["pr", "view", str(number), "-R", repo, "--json", "state,title"])
            if p is None:
                failed += 1
            else:
                states[(repo, number)] = state(p)
    return states, failed


def classify(run, causes, states, now):
    """The key of the class of a run (see CLASSES)."""
    def pr_class(prs):
        found = {states.get(pr) for pr in prs}
        return next((s for s in ("merged", "open", "closed") if s in found), "unknown")

    if run["usage"] is None and run["round_open"] and now - run["end"] < 900:
        return "running"
    if run["created"]:
        return pr_class(run["created"])
    cause = causes.get((run["worker"], run["stamp"]), set())
    for key in ("e401", "claim", "kernel"):
        if key in cause:
            return key
    if run["phase"] == "roadmap":
        if run["usage"] and run["outcome"] != "failed" and run["hours"] < 1 / 6:
            return "nothing"
    elif run["outcome"] == "completed" and run["prs"]:
        return pr_class(run["prs"])
    if run["outcome"] == "failed" or not run["usage"]:
        return "failed"
    return "no_result"


def table(title, head, rows, out):
    """Prints a table: the first column is text, the others are right-aligned."""
    out.append("")
    out.append(title)
    rows = [head] + [[str(c) for c in row] for row in rows]
    widths = [max(len(row[i]) for row in rows) for i in range(len(head))]
    for row in rows:
        out.append("  " + "  ".join(
            c.ljust(widths[i]) if i == 0 else c.rjust(widths[i]) for i, c in enumerate(row)).rstrip())


def money(x):
    return f"${x:,.2f}"


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--days", type=float, default=7)
    parser.add_argument("--until")
    parser.add_argument("--github", action="store_true")
    parser.add_argument("--json")
    parser.add_argument("--prices")
    parser.add_argument("--codex-model")
    args = parser.parse_args()

    now = datetime.datetime.now(UTC).timestamp()
    until = now
    if args.until:
        form = "%Y-%m-%dT%H:%M" if "T" in args.until else "%Y-%m-%d"
        until = datetime.datetime.strptime(args.until, form).replace(tzinfo=UTC).timestamp()
    since = until - args.days * 86400
    out, notes = [], []

    runs = collect_runs(since, until)
    prices, prices_path = find_prices(args.prices)
    if not prices:
        notes.append("No price table was found (see --prices): no run has a price.")
    states, note = read_activity(runs, since)
    if note:
        notes.append(note)
    workers = sorted({r["worker"] for r in runs} | set(
        os.listdir(os.path.join(STATE, "workers", "logs"))
        if os.path.isdir(os.path.join(STATE, "workers", "logs")) else []))
    causes, waits, loop_days = read_loop_logs(workers, runs, since, until)
    if args.github:
        load_network_env()
        found, failed = github_states({pr for r in runs for pr in r["prs"] + r["created"]})
        states.update(found)
        if failed:
            notes.append(f"`gh` gave no state for {failed} pull requests.")

    # The model of a run without a log: the model of the nearest run of the same worker and
    # provider that has one, or else of the same provider.
    for run in runs:
        if run["provider"] == "codex" and args.codex_model:
            run["model"] = args.codex_model
        if run["model"] is None:
            near = [r for r in runs if r["model"] and r["provider"] == run["provider"]
                    and r["has_log"] and not (r["provider"] == "codex" and args.codex_model)]
            same = [r for r in near if r["worker"] == run["worker"]] or near
            if same:
                run["model"] = min(same, key=lambda r: abs(r["start"] - run["start"]))["model"]
                run["model_assumed"] = True
    for run in runs:
        window = price_window(prices, run["model"], run["start"])
        run["priced"] = window is not None
        run["tokens"] = run_tokens(run["usage"] or {})
        run["cost"] = run_cost(run["usage"], window) if window and run["usage"] else None
        run["class"] = classify(run, causes, states, now)
    # A run without token totals: its length times the mean cost per hour of its phase.
    priced = [r for r in runs if r["priced"]]
    with_cost = [r for r in priced if r["cost"] is not None]

    def rate(rs):
        hours = sum(r["hours"] for r in rs)
        return sum(r["cost"] for r in rs) / hours if hours else None

    overall = rate(with_cost) or 0.0
    estimated = 0
    for run in priced:
        run["estimated"] = run["cost"] is None
        if run["estimated"]:
            same = rate([r for r in with_cost if r["phase"] == run["phase"]])
            run["cost"] = (same if same is not None else overall) * run["hours"]
            estimated += 1
    total_cost = sum(r["cost"] for r in priced)

    # The period and the days with data.
    form = "%Y-%m-%d %H:%M"
    out.append("Worker waste report")
    out.append(f"Period: {datetime.datetime.fromtimestamp(since, UTC).strftime(form)} to "
               f"{datetime.datetime.fromtimestamp(until, UTC).strftime(form)} UTC "
               f"({args.days:g} days)")
    out.append(f"Price table: {prices_path or 'none'}")
    days = []
    t = since
    while day_of(t) <= day_of(until - 1):
        days.append(day_of(t))
        t += 86400
    runs_of_day = collections.Counter(day_of(r["start"]) for r in runs)
    logs_of_day = collections.Counter(day_of(r["start"]) for r in runs if r["has_log"])
    table("Days of the period", ["day", "runs", "runs with an agent log", "loop logs"],
          [[d, runs_of_day[d], logs_of_day[d], "yes" if d in loop_days else "no"] for d in days], out)
    gone = [d for d in days if runs_of_day[d] and d not in loop_days]
    if gone:
        notes.append("The loop logs of these days are gone: " + ", ".join(gone) + ". For the runs of "
                     "these days the report cannot tell a 401 error, a lost claim or a kill by the "
                     "kernel from other failed runs, and it counts no wait.")
    empty = [d for d in days if not runs_of_day[d]]
    if empty:
        notes.append("No run has a file for these days (no run started, or the Worker deleted the "
                     "files): " + ", ".join(empty) + ".")
    assumed = sum(1 for r in runs if r.get("model_assumed"))
    if assumed:
        notes.append(f"{assumed} runs have no agent log; each has the model of the nearest run "
                     "with a log.")
    if estimated:
        notes.append(f"{estimated} runs have no token totals; their cost is an estimate, "
                     f"{money(sum(r['cost'] for r in priced if r['estimated']))} in all.")

    def totals(rs):
        return [len(rs), f"{sum(r['hours'] for r in rs):.1f}",
                f"{sum(r['tokens'] for r in rs) / 1e6:,.0f}", money(sum(r['cost'] for r in rs))]

    def by(key, rs):
        groups = collections.defaultdict(list)
        for r in rs:
            groups[key(r)].append(r)
        return sorted(groups.items(), key=lambda kv: -sum(r["cost"] for r in kv[1]))

    head = ["runs", "agent-hours", "tokens (M)", "cost"]
    providers = collections.defaultdict(list)
    for r in runs:
        providers[r["provider"]].append(r)
    table("Totals per provider", ["provider"] + head,
          [[p] + (totals(rs) if all(r["priced"] for r in rs) else
                  [len(rs), f"{sum(r['hours'] for r in rs):.1f}",
                   f"{sum(r['tokens'] for r in rs) / 1e6:,.0f}", "no price"])
           for p, rs in sorted(providers.items())], out)
    out.append("")
    out.append(f"The tables below hold the {len(priced)} runs with a price.")
    table("Totals per worker", ["worker"] + head,
          [[k] + totals(rs) for k, rs in by(lambda r: r["worker"], priced)]
          + [["all"] + totals(priced)], out)
    table("Totals per phase", ["phase"] + head,
          [[k or "not known"] + totals(rs) for k, rs in by(lambda r: r["phase"], priced)]
          + [["all"] + totals(priced)], out)

    class_rows, class_data, lost = [], [], 0.0
    for key, text, is_lost in CLASSES:
        rs = [r for r in priced if r["class"] == key]
        if not rs:
            continue
        cost = sum(r["cost"] for r in rs)
        lost += cost if is_lost else 0.0
        share = 100 * cost / total_cost if total_cost else 0.0
        class_rows.append([text, len(rs), f"{sum(r['hours'] for r in rs):.1f}", money(cost),
                           f"{share:.1f}%", "yes" if is_lost else "no"])
        class_data.append(dict(key=key, text=text, lost=is_lost, runs=len(rs),
                               hours=sum(r["hours"] for r in rs), cost=cost, share=share))
    table("Classes of the runs", ["class", "runs", "agent-hours", "cost", "share", "lost"],
          class_rows, out)

    wait_rows, wait_data = [], []
    wait_total = sum(waits.values())
    for key, text in WAITS:
        seconds = sum(v for (_, reason), v in waits.items() if reason == key)
        if seconds:
            wait_rows.append([text, f"{seconds / 3600:.1f}",
                              f"{100 * seconds / wait_total:.1f}%"])
            wait_data.append(dict(key=key, text=text, hours=seconds / 3600))
    if wait_rows:
        table("Hours that the workers waited for quota, by reason", ["reason", "hours", "share"],
              wait_rows + [["all", f"{wait_total / 3600:.1f}", "100.0%"]], out)
        table("Hours that the workers waited for quota, by worker", ["worker", "hours"],
              [[w, f"{sum(v for (x, _), v in waits.items() if x == w) / 3600:.1f}"]
               for w in workers if any(x == w for x, _ in waits)], out)
    else:
        notes.append("The loop logs of the period show no wait for quota.")

    unpriced = [r for r in runs if not r["priced"]]
    if unpriced:
        groups = collections.defaultdict(list)
        for r in unpriced:
            groups[(r["worker"], r["provider"], r["model"] or "not known")].append(r)
        names = sorted({k for r in unpriced for k in (r["usage"] or {})})
        table("Runs without a price", ["worker", "provider", "model", "runs", "agent-hours"] + names,
              [[w, p, m, len(rs), f"{sum(r['hours'] for r in rs):.1f}"]
               + [f"{sum((r['usage'] or {}).get(k, 0) for r in rs):,}" for k in names]
               for (w, p, m), rs in sorted(groups.items())], out)

    if notes:
        out.append("")
        out.append("Notes")
        out.extend("  - " + note for note in notes)
    share = 100 * lost / total_cost if total_cost else 0.0
    out.append("")
    out.append(f"lost share: {share:.1f}% of {money(total_cost)}")
    print("\n".join(out))

    if args.json:
        folder = os.path.dirname(os.path.abspath(args.json))
        os.makedirs(folder, exist_ok=True)

        def group(key):
            return [dict(name=k or "not known", runs=len(rs), hours=sum(r["hours"] for r in rs),
                         tokens=sum(r["tokens"] for r in rs), cost=sum(r["cost"] for r in rs))
                    for k, rs in by(key, priced)]

        report = dict(
            period=dict(since=since, until=until, days=args.days,
                        days_with_loop_logs=sorted(d for d in days if d in loop_days),
                        days_without_loop_logs=gone, days_without_runs=empty),
            totals=dict(runs=len(priced), hours=sum(r["hours"] for r in priced),
                        tokens=sum(r["tokens"] for r in priced), cost=total_cost,
                        estimated_runs=estimated),
            providers=[dict(name=p, runs=len(rs), hours=sum(r["hours"] for r in rs),
                            tokens=sum(r["tokens"] for r in rs),
                            cost=sum(r["cost"] for r in rs) if all(r["priced"] for r in rs) else None)
                       for p, rs in sorted(providers.items())],
            workers=group(lambda r: r["worker"]), phases=group(lambda r: r["phase"]),
            classes=class_data, waits=wait_data,
            waits_by_worker={w: sum(v for (x, _), v in waits.items() if x == w) / 3600
                             for w in workers if any(x == w for x, _ in waits)},
            lost_cost=lost, lost_share=share, notes=notes,
            runs=[{k: r.get(k) for k in (
                "worker", "provider", "stamp", "start", "end", "hours", "model", "usage", "tokens",
                "cost", "estimated", "priced", "phase", "outcome", "prs", "created", "class")}
                for r in runs])
        with open(args.json, "w") as f:
            json.dump(report, f, indent=1)


if __name__ == "__main__":
    sys.exit(main())
