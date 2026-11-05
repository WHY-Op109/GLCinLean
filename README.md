# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

**GLCinLean**: a planned Lean 4 formalisation of the global unramified de Rham geometric Langlands conjecture: first a faithful statement (GLC I, arXiv 2405.03599 v3, Conjecture 1.6.7), then the five-paper proof. For now this repository holds the planning; the Lean code, blueprint and roadmap will be added here (D34).

## Contents

| Path | What it is |
|---|---|
| `plans/2026-11-02-design-brainstorm.md` | The first consolidated design. |
| `plans/2026-11-design-discussion-log.md` | Decisions D1–D43, ideas, parked questions and items to verify. **Overrides the brainstorm.** |
| `plans/2026-11-04-implementation-plan.md` | The implementation plan, reviewed 4 Nov 2026 and redrafted 5 Nov 2026 to use the formalised Stacks project (D41), and reviewed again the same day (D42) and cross-model-reviewed by GPT-6 Astra (D43); ends with the start prompt. |
| `reports/` | Current assessments (2–3 Nov 2026). |
| `references/tau-ceti/` | Copies of Tau Ceti roadmap files, with provenance headers. |
| `private/` | Git-ignored; clone of the private companion repository `GLCinLeanPrivate` (archive, feasibility evidence, scout reports, permissions; D37). |
| `AGENTS.md` | Standing rules that Claude Code and Codex load automatically. |

## Next steps on the Mac mini

Done: the Mac mini set-up (D38), the implementation plan, its review (D40, 4 Nov 2026), its Stacks redraft (D41, 5 Nov 2026), its second review (D42, 5 Nov 2026) and the cross-model review by GPT-6 Astra (D43, 5 Nov 2026).

**Start implementing:** open a new Claude Code session in this checkout, run `/effort high`, and paste the start prompt from §12 of `plans/2026-11-04-implementation-plan.md`.

Prompts that have been run are deleted; the log records what they settled.

## Licence

Apache-2.0 (`LICENSE`, D22). Files in `references/` keep the licence stated in their provenance headers.
