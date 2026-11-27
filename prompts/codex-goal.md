# Codex goal

> Goal: Run the session in Codex mode, by `AGENTS.md` and `prompts/codex-goal.md`. The goal is met when your reply shows one of these: (a) no `@[placeholder]` is left in `GLCinLean/Statement/` and the done check passes; (b) every remaining line of work is under "Waiting for the owner" or "Waiting for Claude" in `STATUS.md`; (c) the work in Tau Ceti is finished: no pull request of ours is open in Tau Ceti and the target list has no target that can start.

## What Codex does

- Codex is the session of "Workflow" in `AGENTS.md`: it runs `prompts/clean.md`, `prompts/start.md` and `prompts/check.md`, makes the session's small changes, keeps the target list and the workers current with `tools/deploy-worker-targets.py`, moves the pin, merges checked work, and keeps `STATUS.md` current.
- It starts the roles writer, checker, blind reader and searcher as its subagents, defined in `.codex/agents/`; their files set the model and the effort. A writer works in its own git worktree, as "Builds" in `AGENTS.md` says.
- Before the first cycle, it starts the searcher once with the task to report its model and its reasoning effort. If they are not `gpt-6.2-sol` and `max`, it records that under "Waiting for the owner" and starts no further subagent.
- It waits for the monitor in the foreground: `tools/monitor.sh` with the settings and the watched pull requests of "Monitor" in `STATUS.md`, the variables of `.env` (`set -a; . ./.env; set +a`), and `DAY_SECONDS=10800`. The command ends with one line, the event.
- It ends the message of every commit that it or its subagents make with the line `Co-Authored-By: Codex GPT-6.2 Sol <noreply@openai.com>`, before it pushes.
- It reaches Tau Ceti only through the Worker on the workers' host, and opens no pull request, issue or comment in Tau Ceti or its roadmaps.

## What Codex leaves for Claude

Codex records each of these under "Waiting for Claude" in `STATUS.md`, with what is needed and why, and goes on with the work that it does not touch:
- the planner's work: the audit (`prompts/audit.md`), a problem that a second writer hands back, and the fold-in of merged pull requests into the plan;
- `prompts/change.md`: a big change, and a *mismatch* or *unsure* verdict that the writer cannot fix, because the planner and Codex must agree on them.
