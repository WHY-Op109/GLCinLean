# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

**GLCinLean**: a planned Lean 4 formalisation of the global unramified de Rham geometric Langlands conjecture: first a faithful statement (GLC I, arXiv 2405.03599 v3, Conjecture 1.6.7), then the five-paper proof. For now this repository holds the planning; the Lean code, blueprint and roadmap will be added here (D34).

## Contents

| Path | What it is |
|---|---|
| `plans/2026-11-02-design-brainstorm.md` | The first consolidated design. |
| `plans/2026-11-design-discussion-log.md` | Decisions D1–D37, ideas, parked questions and items to verify. **Overrides the brainstorm.** |
| `prompts/` | Prompts still to run (see below). |
| `reports/` | Current assessments (2–3 Nov 2026). |
| `references/tau-ceti/` | Copies of Tau Ceti roadmap files, with provenance headers. |
| `private/` | Git-ignored; clone of the private companion repository `GLCinLeanPrivate` (archive, scout reports, permissions; D37). |
| `AGENTS.md` | Standing rules that Claude Code and Codex load automatically. |

## Next steps on the Mac mini

Work on the discussion Mac ended on 3 Nov 2026. Everything from here runs on the Mac mini (D36).

### 0. Setup (once)

1. Install and log in to the tools (interactive, so do these yourself):
   - Claude Code, then log in;
   - GitHub CLI: `brew install gh`, then `gh auth login` (add the `workflow` scope);
   - Codex CLI, then `codex login` (ChatGPT login);
   - Lean: `curl https://elan.lean-lang.org/elan-init.sh -sSf | sh`.
2. Clone both repositories:
   ```sh
   git clone https://github.com/WHY-Op109/GLCinLean.git
   cd GLCinLean
   git clone https://github.com/WHY-Op109/GLCinLeanPrivate.git private
   ```
3. Install the two skills the prompts rely on (V9):
   ```sh
   mkdir -p ~/.codex/skills ~/.claude/skills
   git clone https://github.com/WHY-Op109/prop.git ~/.codex/skills/prop
   ln -s ~/.codex/skills/prop ~/.claude/skills/prop
   cp -R private/skills/grilling ~/.claude/skills/
   ```
4. Make sure no `CLAUDE.md` sits in this folder or any folder above it, or Claude Code will ignore `AGENTS.md` (D33).
5. Save the bridgekat author's permission (screenshot or dated text) in `private/permissions/` and commit it there (C1).

### 1. Write the plan

Open Claude Code in this folder, run `/effort high` (optionally start with `claude --permission-mode plan`), and say:

> Process the prompt in prompts/2026-11-02-synthesise-feasible-plan.md

It tests, searches, measures the Mac mini, writes `plans/<date>-implementation-plan.md` ending with a start prompt, and commits it. Then `git push`.

### 2. Review the plan

In a fresh session, run `/effort xhigh` (or `max`) and say:

> Process the prompt in prompts/2026-11-03-review-implementation-plan.md

It goes through its findings with you one at a time, revises the plan, commits and pushes.

### 3. Start implementing

Paste the start prompt from the end of the plan into a new session.

Prompts that have been run are deleted; the log records what they settled.

## Licence

Apache-2.0 (`LICENSE`, D22). Files in `references/` keep the licence stated in their provenance headers.
