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

## How to use the prompts

Everything runs on the Mac mini (D36). Open Claude Code in the repository root (so it loads `AGENTS.md`) and say `Process the prompt in prompts/<file>`.

0. **Setup:** `git clone` this repository, then `git clone https://github.com/WHY-Op109/GLCinLeanPrivate.git private` inside it. Install the `prop` and `grilling` skills as on the discussion Mac (V9 in the log).
1. **`prompts/2026-11-02-synthesise-feasible-plan.md`** at effort `high`, optionally in plan mode (`claude --permission-mode plan`). It tests, searches, measures the machine and writes `plans/<date>-implementation-plan.md`, ending with a start prompt; it commits the plan. Then `git push`.
2. **`prompts/2026-11-03-review-implementation-plan.md`** in a fresh session at effort `xhigh` or `max`. It goes through its findings with you, revises the plan, commits and pushes.
3. **Implementation:** paste the start prompt from the end of the plan into a new session.

Prompts that have been run are deleted; the log records what they settled.

## Licence

Apache-2.0 (`LICENSE`, D22). Files in `references/` keep the licence stated in their provenance headers.
