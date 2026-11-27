# Codex setup

Start Codex in this folder with `codex -m gpt-6.2-sol -c model_reasoning_effort=high`.

**Goal.** Prepare this checkout and the workers' host so that Codex can run the session in Codex mode (`AGENTS.md`, "Codex mode"). The owner sets the goal of `prompts/codex-goal.md` after this setup replies "ready".

You run the session for a time only: the owner returns to Claude Code when Claude's usage is free again. Leave every line of work so that a Claude session can take it up from `STATUS.md`.

**Steps**
1. Read `AGENTS.md` and `STATUS.md` in full.
2. Run `prompts/clean.md`, and delete no branch or worktree that `STATUS.md` names.
3. Check the access, without changing anything:
   - `set -a; . ./.env; set +a` gives `HOST_SSH` and `TAUCETI`; `.env` is local and git ignores it. Write neither value into a tracked file.
   - `gh auth status`, and `gh pr list -R TauCetiProject/TauCeti --author WHY-Op109 --state open`.
   - `$TAUCETI workers` shows the fourteen workers; the author workers and `repair` show the agent `codex`.
   - With `LAKE_CONFIG=.lake-config/lake-config.toml` and `LAKE_CACHE_DIR=.lake/cache`: `lake build` passes with only the `sorry` of `GLCinLean/Statement/Conjecture.lean`.
4. Test the wait. Run `tools/monitor.sh` in the foreground with the settings of "Monitor" in `STATUS.md`, the variables of `.env`, and `DAY_SECONDS=300`; it must end by itself within about five minutes. If a command of yours cannot wait that long, find the longest wait that works and use it as `DAY_SECONDS` in `prompts/codex-goal.md`.
5. Make the first line of "Current state" in `STATUS.md` "Mode: Codex (since <date>)". Commit and push to `main`.

**Done when** the checks of step 3 pass, the test of step 4 ends by itself, `STATUS.md` says "Mode: Codex", the work is pushed, and the reply says "ready" with the number of placeholders, the result of the build, the number of our open pull requests and the `DAY_SECONDS` to use. When a check fails, reply with the failure instead and change nothing to work around it.
