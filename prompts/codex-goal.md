# Codex goal

The text to set as Codex's goal, after `prompts/codex-setup.md` replied "ready":

> Run the session in Codex mode, by `AGENTS.md` and `prompts/codex-goal.md`. The goal is met when your reply shows one of these: (a) no `@[placeholder]` is left in `GLCinLean/Statement/` and the done check passes; (b) every remaining line of work is under "Waiting for the owner" or "Waiting for Claude" in `STATUS.md`; (c) the work in Tau Ceti is finished: no pull request of ours is open in Tau Ceti and the target list has no target that can start.

## What Codex does

- Codex is the session of "Workflow" in `AGENTS.md`: it runs `prompts/clean.md`, `prompts/start.md` and `prompts/check.md`, makes the session's small changes, keeps the target list and the workers current with `tools/deploy-worker-targets.py`, moves the pin, merges checked work, and keeps `STATUS.md` current.
- It takes the roles writer, checker, blind reader and searcher. Each role is a separate `codex exec` run with the role's file in `.claude/agents/` as its brief, Codex's default model, and the effort that the file names; the run has its own context, so the checker is independent of the writer. A writer works in its own git worktree, as "Builds" in `AGENTS.md` says.
- It waits for the monitor in the foreground: `tools/monitor.sh` with the settings and the watched pull requests of "Monitor" in `STATUS.md`, the variables of `.env` (`set -a; . ./.env; set +a`), and `DAY_SECONDS=10800`. The command ends with one line, the event.
- It reaches Tau Ceti only through the Worker on the workers' host, and opens no pull request, issue or comment in Tau Ceti or its roadmaps.

## What Codex leaves for Claude

Codex records each of these under "Waiting for Claude" in `STATUS.md`, with what is needed and why, and goes on with the work that it does not touch:
- the planner's work: the audit (`prompts/audit.md`), a problem that a second writer hands back, and the fold-in of merged pull requests into the plan;
- `prompts/change.md`: a big change, and a *mismatch* or *unsure* verdict that the writer cannot fix, because the planner and Codex must agree on them.
