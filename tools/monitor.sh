#!/bin/bash
# The monitor of the workflow (AGENTS.md, "Workflow"): it watches the Tau Ceti workers, our pull
# requests in Tau Ceti and the watched pull requests of others. It prints the events and exits
# when one of these happens, and its exit wakes the session:
#   - an enabled worker has a fault that persists, or has no process, or the Worker's manager is
#     offline (a worker that workers.toml disables is not watched, and a worker that only
#     repairs and finds nothing to repair is no event);
#   - a pull request of ours is opened, merged or closed, or its CI fails;
#   - a watched pull request is merged or closed;
#   - the free disk space of the volume that holds the repository falls below MIN_FREE_GB (checked
#     every DISK_SECONDS): the session then runs prompts/clean.md;
#   - the workers' host has less than MIN_HOST_MEM_GB of memory that can be freed, or its /tmp is
#     more than MAX_HOST_TMP_PERCENT full (checked at each poll, only when HOST_SSH is set);
#   - no event happened for DAY_SECONDS (one day).
# It runs no model. The state is kept in a file, so a new run reports only what changed.
#
# The faults of a worker. An enabled worker has a fault when its state is `failed`, `stopped` or
# `backoff`, when it shows a failure reason, when it has no process, or when the Worker has
# started it again since the last poll. Most faults end by themselves within minutes: the manager
# starts a failed worker again, and a worker in `backoff` tries its next round. So a fault is an
# event only in these cases:
#   - every poll of the last WORKER_FAULT_MINUTES showed the worker with a fault;
#   - the worker shows the same failure reason for the third time within one day (the numbers in
#     a reason are not compared, and polls in a row with the same reason count once);
#   - the worker has no process and its state is not `failed` or `stopped` (for example
#     `missing`): the manager does not start such a worker again. This is an event at once.
# After its event, a worker gives a new event only after a poll that shows it without a fault.
#
# Usage, from the root of the repository, as a background task of the session:
#   tools/monitor.sh [OWNER/REPO#NUMBER ...]
# The arguments are the watched pull requests that STATUS.md lists under "Workers".
# Environment: MONITOR_STATE (default .lake/monitor-state.json), POLL_SECONDS (default 900),
# DAY_SECONDS (default 86400), TAUCETI (default tauceti): the command of the Worker; when the
# workers run on another host, a local command that runs the Worker there. MIN_FREE_GB (default
# 20): a move of the pins can need about 10 GB for a new Mathlib cache and a new Lean toolchain.
# DISK_SECONDS (default 10800): the time between two checks of the free disk space.
# CI_FAILED_EVENTS (default 1): with 0, a failed CI of a pull request of ours is no event; the
# workers repair it by themselves, and after a change of Tau Ceti's toolchain many fail at once.
# OPENED_EVENTS (default 1): with 0, a new pull request of ours is no event; the session then
# compares the new pull requests with the plan at the next event.
# WORKER_FAULT_MINUTES (default 30): the time that a fault of a worker must last. With 0, each
# fault and each new start of a worker is an event at the first poll that shows it.
# HOST_SSH (default empty): a command that runs its last argument as a shell command on the
# workers' host, for example `ssh -o BatchMode=yes USER@HOST`. When it is empty, the memory and
# the /tmp of the host are not checked. MIN_HOST_MEM_GB (default 8): the limit for MemAvailable
# minus Shmem of /proc/meminfo; a /tmp that is kept in memory counts in Shmem, and the kernel
# cannot free it. MAX_HOST_TMP_PERCENT (default 90): the limit for the used part of /tmp.

STATE="${MONITOR_STATE:-.lake/monitor-state.json}"
POLL_SECONDS="${POLL_SECONDS:-900}"
DAY_SECONDS="${DAY_SECONDS:-86400}"
start=$(date +%s)

while true; do
  events=$(python3 - "$STATE" "$@" <<'EOF'
import json, os, re, shlex, shutil, subprocess, sys, time

state_path, watched = sys.argv[1], sys.argv[2:]
try:
    old = json.load(open(state_path))
except Exception:
    old = None  # the first run records the state and reports no pull request
new = {"workers": {}, "prs": {}, "watched": {}, "manager": True, "disk_low": False,
       "disk_checked": 0, "host_mem_low": False, "host_tmp_low": False}
if old:
    new.update({k: old.get(k, new[k]) for k in new})
events = []


def run(cmd, timeout):
    return subprocess.run(cmd, capture_output=True, text=True, timeout=timeout).stdout


def pr_state(p):
    merged = p["state"] == "MERGED" or p["title"].startswith("[Merged by Bors]")
    return "MERGED" if merged else p["state"]


def is_idle(reason):
    # A worker that finds nothing to do reports "no eligible work" (no pull request needs a
    # repair) or "not due" (its periodic report is recent): its expected state, and no event.
    return "no eligible work" in reason or "not due" in reason


def worker_at_once(w, prev, restarts):
    """The new state and the events of an enabled worker, when each fault is an event at once."""
    reason = w.get("failure_reason") or ""
    bad = (not w.get("alive")) or bool(reason and not is_idle(reason)) or w.get(
        "actual") in ("failed", "stopped", "exited", "crashed")
    found = []
    if bad and not prev.get("bad"):
        found.append(f"WORKER {w['id']} {w.get('actual')}: {w.get('failure_reason')}")
    if old and restarts > prev.get("restarts", 0):
        found.append(f"WORKER {w['id']} restarted ({restarts} restarts)")
    return {"bad": bad, "restarts": restarts}, found


def worker_persistent(w, prev, restarts, now, fault_seconds):
    """The new state and the events of an enabled worker, when a fault is an event only if it
    persists. The state holds: `bad`, the present fault has had its event; `since`, the time of
    the first poll of the present row of polls with a fault; `key`, the last failure reason
    without its numbers; `times`, the times of the polls at which `key` began to show."""
    actual = w.get("actual")
    restarted = bool(old) and restarts > prev.get("restarts", 0)
    reason = w.get("failure_reason") or (str(w.get("detail") or "") if actual == "backoff" else "")
    idle = is_idle(reason)
    fault = (not w.get("alive")) or bool(reason and not idle) or (
        actual == "backoff" and not idle) or actual in (
        "failed", "stopped", "exited", "crashed") or restarted
    times = [t for t in prev.get("times", []) if now - t < 86400]
    if not fault:
        return {"bad": False, "restarts": restarts, "since": None, "key": prev.get("key", ""),
                "times": times}, []
    if restarted:
        reason = (reason + " " if reason else "") + f"(started again, {restarts} restarts)"
    key = re.sub(r"\d+", "N", reason or str(actual))
    since = prev.get("since") or now
    if key != prev.get("key"):
        times = [now]
    elif prev.get("since") is None:
        times.append(now)
    text = None
    if not prev.get("bad"):
        if not w.get("alive") and actual not in ("failed", "stopped"):
            text = f"has no process: {reason or 'no reason given'}"
        elif now - since >= fault_seconds:
            text = f"for {(now - since) / 60:.0f} minutes: {reason or 'no reason given'}"
        elif len(times) >= 3:
            text = f"for the third time in one day: {reason or 'no reason given'}"
    state = {"bad": bool(prev.get("bad") or text), "restarts": restarts, "since": since,
             "key": key, "times": [] if text else times}
    return state, ([f"WORKER {w['id']} {actual} {text}"] if text else [])


# A failure of a command (network, GitHub) is not an event: the old state is kept.
try:
    tauceti = shlex.split(os.environ.get("TAUCETI", "tauceti"))
    d = json.loads(run(tauceti + ["workers", "status", "--json"], 120))
    fault_seconds = float(os.environ.get("WORKER_FAULT_MINUTES", "30")) * 60
    workers = {}
    for w in d.get("workers", []):
        restarts = w.get("restart_count", 0)
        if w.get("desired") == "stopped":  # disabled in workers.toml: stopped on purpose
            workers[w["id"]] = {"bad": False, "restarts": restarts}
            continue
        prev = (old or {}).get("workers", {}).get(w["id"], {})
        if fault_seconds <= 0:
            workers[w["id"]], found = worker_at_once(w, prev, restarts)
        else:
            workers[w["id"]], found = worker_persistent(w, prev, restarts, time.time(),
                                                        fault_seconds)
        events.extend(found)
    new["workers"] = workers
    new["manager"] = bool(d.get("manager"))
    if not new["manager"] and (old is None or old.get("manager", True)):
        events.append("MANAGER of the workers is offline")
except Exception:
    pass

try:
    prs = {}
    for p in json.loads(run(["gh", "pr", "list", "-R", "TauCetiProject/TauCeti", "--author", "@me",
                             "--state", "all", "--limit", "300",
                             "--json", "number,title,state,labels"], 120)):
        key, st = str(p["number"]), pr_state(p)
        failed = "ci-failed" in [label["name"] for label in p.get("labels", [])]
        prs[key] = {"state": st, "failed": failed}
        if old is None:
            continue
        prev = old.get("prs", {}).get(key)
        if prev is None:
            if os.environ.get("OPENED_EVENTS", "1") != "0":
                events.append(f"PR #{key} opened: {p['title']}")
        elif prev["state"] != st:
            events.append(f"PR #{key} {st}: {p['title']}")
        if failed and not (prev or {}).get("failed") and os.environ.get("CI_FAILED_EVENTS", "1") != "0":
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

# The free space is checked every DISK_SECONDS. The event is reported once, when the free space
# falls below the limit.
try:
    if time.time() - new["disk_checked"] >= float(os.environ.get("DISK_SECONDS", "10800")):
        min_gb = float(os.environ.get("MIN_FREE_GB", "20"))
        free_gb = shutil.disk_usage(".").free / 2**30
        was_low = new["disk_low"]
        new["disk_low"], new["disk_checked"] = free_gb < min_gb, time.time()
        if new["disk_low"] and not was_low:
            events.append(f"DISK free space is {free_gb:.0f} GB, below {min_gb:.0f} GB: "
                          "run prompts/clean.md")
except Exception:
    pass

# The memory and the /tmp of the workers' host, when HOST_SSH is set. Each of the two events is
# reported once, when its value passes its limit.
try:
    host_ssh = shlex.split(os.environ.get("HOST_SSH", ""))
    if host_ssh:
        out = run(host_ssh + ["cat /proc/meminfo; df -P /tmp"], 60)
        kb = {m.group(1): int(m.group(2)) for m in re.finditer(r"^(\w+):\s+(\d+) kB", out, re.M)}
        mem_gb = (kb["MemAvailable"] - kb.get("Shmem", 0)) / 2**20
        tmp_percent = int(re.findall(r"\s(\d+)%\s+/", out)[-1])
        min_mem = float(os.environ.get("MIN_HOST_MEM_GB", "8"))
        max_tmp = float(os.environ.get("MAX_HOST_TMP_PERCENT", "90"))
        was_mem, was_tmp = new["host_mem_low"], new["host_tmp_low"]
        new["host_mem_low"], new["host_tmp_low"] = mem_gb < min_mem, tmp_percent > max_tmp
        if new["host_mem_low"] and not was_mem:
            events.append(f"HOST memory that can be freed is {mem_gb:.1f} GB, below "
                          f"{min_mem:.0f} GB, on the workers' host")
        if new["host_tmp_low"] and not was_tmp:
            events.append(f"HOST /tmp is {tmp_percent} % full, above {max_tmp:.0f} %, on the "
                          "workers' host")
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
