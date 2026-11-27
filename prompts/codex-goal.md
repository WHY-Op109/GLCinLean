# Codex goal

The text to set as Codex's goal, after `prompts/codex-setup.md` replied "ready":

> Run the session in Codex mode, by `AGENTS.md` and `prompts/codex-goal.md`. The goal is met when your reply shows one of these: (a) no `@[placeholder]` is left in `GLCinLean/Statement/` and the done check passes; (b) every remaining line of work is under "Waiting for the owner" or "Waiting for Claude" in `STATUS.md`; (c) the work in Tau Ceti is finished: no pull request of ours is open in Tau Ceti and the target list has no target that can start.

## One cycle

1. **Wait.** Run `tools/monitor.sh` in the foreground with the settings and the watched pull requests of "Monitor" in `STATUS.md`, the variables of `.env` (`set -a; . ./.env; set +a`), and `DAY_SECONDS=10800` (or the value that the setup found). It ends with one line, the event.
2. **Act on the event.**
   - *A worker fault:* find it in the list of faults under "Workers" in `STATUS.md` and do its repair. A fault that is not in the list, or whose repair needs a change of the Worker's code, goes under "Waiting for the owner".
   - *`PR #N CLOSED` by the Worker after six repair rounds:* do the repair of fault 11. This is the first edit of the target list that Codex makes: set the item back to `[ ]`, without `in flight:`, and add one sentence that names the kept branch and the points of the last review that are not approved.
   - *A pull request of ours merged* (the last comment says "Pull request successfully merged into main"): this is the second edit: mark the item `[x]` and replace `in flight: #N` by `done: #N`. If the pull request carries the marker `partial`, or its text says that a part remains, record the open part under "Waiting for Claude".
   - *Low memory or a full `/tmp` on the host:* the repair of fault 7 or 8. *Low disk space here:* `prompts/clean.md`.
   - *One day, or three hours, without an event:* also check the open pull requests of ours, as above, since the monitor does not report every merge.
   Deploy the list at most once per cycle: `python3 tools/deploy-worker-targets.py --check`, then the same without `--check`. Change `workers.tsv` only to turn off a worker whose area has no target that can start, or to turn it on again.
3. **The pin.** At most once a day: when Tau Ceti's `main` or a newer tag has pull requests of ours that the pin lacks, move the pin as "Builds" in `AGENTS.md` says, in a commit of its own, only when the done check passes there and `python3 tools/check-upstream-names.py` confirms every pair. Otherwise keep the pin, and record under "Waiting for Claude" what failed.
4. **Record.** Update in `STATUS.md` only the state: the open pull requests and their table, the merged ones that wait for the fold-in under "Waiting for Claude", the faults met, the pins and the build checks. Commit and push to `main`. Reply with the number of placeholders left, the result of the done check, and each remaining line of work with what it waits for.

## What Codex does not do

Codex makes no change of the plan or of a module and starts no subagent ("Codex mode" in `AGENTS.md`). A fold-in of merged work into the plan, a check, a new target, a change of the notes and a module that is ready all go under "Waiting for Claude", with what is needed and why. A big change goes under "Waiting for the owner"; the work that it does not touch goes on. Codex opens no pull request, issue or comment in Tau Ceti or its roadmaps.
