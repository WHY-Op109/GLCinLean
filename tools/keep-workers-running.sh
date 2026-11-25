#!/bin/bash
# Keeps the Tau Ceti workers running on the host where they run (AGENTS.md, "Workflow").
# The Worker's manager restarts a worker that fails. This script starts the manager again when
# it is not running, or when an enabled worker has no process, and writes one line per run to
# its log. It also ends a Lean process of a worker that sleeps without end, and removes the
# stale scratch files of the workers' agents from /tmp. It runs no model.
#
# Install on the workers' host as ~/.local/bin/keep-workers-running, with these crontab lines:
#   */30 * * * * "$HOME/.local/bin/keep-workers-running"
#   @reboot sleep 60; "$HOME/.local/bin/keep-workers-running"
# Log: ~/.local/state/tauceti/keep-workers-running.log (the last 2000 lines are kept).

# The network settings of the host (a proxy, when it has one). Cron loads none, and the profile of
# a host can set them for some logins only. So the host states them in
# ~/.config/tauceti/network-env.sh (`export` lines), and this script reads that file. Without them
# the Worker cannot renew the login of its agents, and every worker waits.
[ -f "$HOME/.profile" ] && . "$HOME/.profile" >/dev/null 2>&1
NETWORK_ENV="${XDG_CONFIG_HOME:-$HOME/.config}/tauceti/network-env.sh"
[ -f "$NETWORK_ENV" ] && . "$NETWORK_ENV"
export PATH="$HOME/.local/bin:$HOME/.elan/bin:$PATH"

# The stack limit of the manager and of every worker it starts: 1 GiB, soft and hard. The Worker
# raises its soft limit to the hard limit. With the hard limit "unlimited", `leantar` 0.1.21 of
# Lean v4.37.0-rc1 ends with SIGABRT when it unpacks a large olean, and no round of a worker
# starts; with a large finite limit it works.
ulimit -Hs 1048576 2>/dev/null
ulimit -Ss 1048576 2>/dev/null

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

# The agents of the workers leave scratch files in /tmp that are named after a pull request
# (`pr45823-body.md`, `tauceti-45823-local-checks.log`, `t44507/`). On a host that keeps /tmp in
# memory they take memory until someone deletes them. Remove those that this account owns and
# that are older than three days. Only these name patterns are removed; every other entry of
# /tmp stays, also when another program of the same account made it.
remove_stale_scratch() {
  local n
  n=$(find /tmp -maxdepth 1 -user "$(id -un)" -mtime +3 \( -name 'pr[0-9]*' -o -name 'tauceti-[0-9]*' \
        -o -name 'body[0-9]*' -o -name 'verify[0-9]*' -o -name 'reply[0-9]*' -o -name 'diag[0-9]*' \
        -o -name 't[0-9][0-9][0-9][0-9][0-9]*' -o -name 'local-checks-*' \) -print -exec rm -rf -- {} + 2>/dev/null | wc -l)
  [ "$n" -gt 0 ] && echo "$(now) removed $n stale scratch entries of the workers from /tmp" >> "$LOG"
  return 0
}
remove_stale_scratch

# A manager that was started without the proxy of the host gives none to its workers. Stop it;
# the check below then starts a manager with the settings of this script.
stop_manager_without_proxy() {
  local pid
  [ -n "${https_proxy:-}" ] || return 0
  pid=$(tauceti workers status --json 2>/dev/null | python3 -c '
import json, sys
try:
    m = json.load(sys.stdin).get("manager")
    print(m.get("pid") or "" if isinstance(m, dict) else "")
except Exception:
    pass')
  [ -n "$pid" ] && [ -r "/proc/$pid/environ" ] || return 0
  tr '\0' '\n' < "/proc/$pid/environ" | grep -qi '^https_proxy=' && return 0
  echo "$(now) the manager (pid $pid) runs without the proxy of the host: tauceti workers manager-stop" >> "$LOG"
  tauceti workers manager-stop >> "$LOG" 2>&1
  sleep 5
}
stop_manager_without_proxy

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
