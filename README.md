# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

**GLCinLean**: a planned Lean 4 formalisation of the global unramified de Rham geometric Langlands conjecture: first a faithful statement (GLC I, arXiv 2405.03599 v3, Conjecture 1.6.7), then the five-paper proof. For now this repository holds the planning; the Lean code, blueprint and roadmap will be added here (D34).

## Contents

| Path | What it is |
|---|---|
| `plans/2026-11-02-design-brainstorm.md` | The first consolidated design. |
| `plans/2026-11-design-discussion-log.md` | Decisions D1–D35, ideas, parked questions and items to verify. **Overrides the brainstorm.** |
| `prompts/` | Prompts still to run (see below). |
| `reports/` | Current assessments (2–3 Nov 2026). |
| `references/tau-ceti/` | Copies of Tau Ceti roadmap files, with provenance headers. |
| `AGENTS.md` | Standing rules that Claude Code and Codex load automatically. |

## How to use the prompts

Open Claude Code in the root of this repository (so it loads `AGENTS.md`) and paste the prompt file's contents, or say: `Process the prompt in prompts/<file>`.

1. **`prompts/2026-11-02-synthesise-feasible-plan.md`**, on the discussion Mac. It runs tests and searches and writes `plans/<date>-implementation-plan.md`, then commits it. Afterwards, `git push`.
2. **`prompts/2026-11-03-review-implementation-plan.md`**, on the discussion Mac, in a fresh Claude Code session at a higher effort. It reviews the drafted plan against what the project is really for.
3. **On the Mac mini:** `git clone` this repository, open Claude Code in it, and follow the implementation plan's first steps. Machine-specific settings (parallel agents, threads, storage thresholds) are measured and decided there (V8 in the log).

Prompts that have been run are deleted; the log records what they settled.

## Licence

Apache-2.0 (`LICENSE`, D22). Files in `references/` keep the licence stated in their provenance headers.
