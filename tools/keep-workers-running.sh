#!/bin/bash
# Keeps the Tau Ceti workers running on the host where they run (AGENTS.md, "Workflow").
# The Worker's manager restarts a worker that fails. This script starts the manager again when
# it is not running, or when an enabled worker has no process, and writes one line per run to
# its log. It also ends a Lean process of a worker that sleeps without end. It runs no model.
#
# Install on the workers' host as ~/.local/bin/keep-workers-running, with these crontab lines:
#   */30 * * * * "$HOME/.local/bin/keep-workers-running"
#   @reboot sleep 60; "$HOME/.local/bin/keep-workers-running"
# Log: ~/.local/state/tauceti/keep-workers-running.log (the last 2000 lines are kept).

# The network settings of a login shell (a proxy, when the host has one); cron does not load them.
[ -f "$HOME/.profile" ] && . "$HOME/.profile" >/dev/null 2>&1
export PATH="$HOME/.local/bin:$HOME/.elan/bin:$PATH"

LOG="${XDG_STATE_HOME:-$HOME/.local/state}/tauceti/keep-workers-running.log"
mkdir -p "$(dirname "$LOG")"
exec 9>"$LOG.lock"
flock -n 9 || exit 0

# Prints "ok <summary>" when the manager runs and each enabled worker has a process, and
# "bad <summary>" otherwise.
check() {
  tauceti workers status --json 2>/dev/null | python3 -c '
import collections, json, sys
try:
    d = json.load(sys.stdin)
except Exception:
    print("bad no answer from the Worker")
    sys.exit()
manager = d.get("manager")
manager_ok = bool(manager.get("ok")) if isinstance(manager, dict) else bool(manager)
enabled = [w for w in d.get("workers", []) if w.get("desired") != "stopped"]
dead = [w["id"] for w in enabled if not w.get("alive")]
states = collections.Counter(str(w.get("actual")) for w in enabled)
summary = "manager %s; %d enabled workers: %s" % (
    "runs" if manager_ok else "is offline", len(enabled),
    ", ".join("%d %s" % (n, s) for s, n in sorted(states.items())))
if dead:
    summary += "; without a process: " + " ".join(dead)
print(("ok " if manager_ok and not dead else "bad ") + summary)'
}

now() { date -u +%Y-%m-%dT%H:%M:%SZ; }

# A `lean` process that an agent of a worker started can sleep without end; the agent then waits
# for it, and the round of the worker does not end. A Lean process that works uses CPU time. So
# end each `lean` process in the Worker's folders that is older than 45 minutes and has used
# less than one minute of CPU time; the agent then gets its command back.
end_sleeping_lean() {
  local root="${XDG_DATA_HOME:-$HOME/.local/share}/tauceti/" pid age cpu comm cwd
  ps -eo pid=,etimes=,cputimes=,comm= | while read -r pid age cpu comm; do
    [ "$comm" = lean ] && [ "$age" -ge 2700 ] && [ "$cpu" -lt 60 ] || continue
    cwd=$(readlink "/proc/$pid/cwd" 2>/dev/null) || continue
    case "$cwd/" in "$root"*) ;; *) continue ;; esac
    kill "$pid" 2>/dev/null &&
      echo "$(now) ended a sleeping lean process: pid $pid, ${age} s old, ${cpu} s of CPU time, in $cwd" >> "$LOG"
  done
}
end_sleeping_lean

result=$(check)
if [ "${result%% *}" = ok ]; then
  echo "$(now) ${result#ok }" >> "$LOG"
else
  echo "$(now) ${result#bad }: tauceti workers apply" >> "$LOG"
  tauceti workers apply >> "$LOG" 2>&1
  sleep 20
  result=$(check)
  echo "$(now) after the start: ${result#* }" >> "$LOG"
fi
tail -n 2000 "$LOG" > "$LOG.tmp" && mv "$LOG.tmp" "$LOG"
