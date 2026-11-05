# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

**GLCinLean**: a planned Lean 4 formalisation of the global unramified de Rham geometric Langlands conjecture: first a faithful statement (GLC I, arXiv 2405.03599 v3, Conjecture 1.6.7), then the five-paper proof. Stage A1 (5 Nov 2026) added the Lake skeleton on Tau Ceti `v4.36.0-rc2`, the review kit and a stub formal abstract; the blueprint and the real definitions come next (D34).

## Contents

| Path | What it is |
|---|---|
| `GLCinLean/Abstract.lean` | The formal abstract (D39): the hypotheses and Conj. 1.6.7 over placeholders. A stub. |
| `GLCinLean/Foundations.lean` | The adapter layer (D10): re-exports of Mathlib and Tau Ceti objects, placeholders. |
| `GLCinLean/Faults/` | Fault-injection fixtures, built only by the fault job (`glc/faults.toml`). |
| `reviewkit/` | The reusable review kit (D35): `lake exe review` and its own toy tests. |
| `glc/project.toml` | The project configuration the kit reads. |
| `reviews/` | Human-owned: the sorry budget and the statement pin (awaiting the owner's approval). |
| `blueprint/plans/` | tracker plans (a minimal A1 plan; B1's blueprint replaces it). |
| `references/papers/manifest.toml` | The papers manifest (D6); `scripts/fetch-papers.py` fetches the papers locally. |
| `tools/tracker/` | bridgekat/tracker, a git submodule. |
| `scripts/check.sh` | Build plus all checks (`--faults` adds the fault fixtures). |
| `THIRD_PARTY_NOTICES.md` | Third-party licences. |
| `plans/2026-11-02-design-brainstorm.md` | The first consolidated design. |
| `plans/2026-11-design-discussion-log.md` | Decisions D1–D43, ideas, parked questions and items to verify. **Overrides the brainstorm.** |
| `plans/2026-11-04-implementation-plan.md` | The implementation plan, reviewed 4 Nov 2026 and redrafted 5 Nov 2026 to use the formalised Stacks project (D41), and reviewed again the same day (D42) and cross-model-reviewed by GPT-6 Astra (D43); ends with the start prompt. |
| `reports/` | Current assessments (2–3 Nov 2026). |
| `references/tau-ceti/` | Copies of Tau Ceti roadmap files, with provenance headers. |
| `private/` | Git-ignored; clone of the private companion repository `GLCinLeanPrivate` (archive, feasibility evidence, scout reports, permissions; D37). |
| `AGENTS.md` | Standing rules that Claude Code and Codex load automatically. |

## Next steps on the Mac mini

Done: the Mac mini set-up (D38), the implementation plan and its three reviews (D40, D42, D43), and stage A1 (5 Nov 2026).

**Next:** approve `reviews/sorry-budget.toml` and `reviews/statement-pin.toml` (fill in `approved`), then stage A2 of the plan (CI, data format v0, the `review` record command). Clone with `git clone --recurse-submodules`; build with `scripts/check.sh`.

Prompts that have been run are deleted; the log records what they settled.

## Licence

Apache-2.0 (`LICENSE`, D22). Files in `references/` keep the licence stated in their provenance headers.
