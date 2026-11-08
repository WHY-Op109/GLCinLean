# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

A Lean 4 formalisation of the global unramified de Rham geometric Langlands conjecture: first a
faithful statement (GLC I, arXiv 2405.03599 v3, Conjecture 1.6.7) with every definition real,
then the five-paper proof. Built on [Tau Ceti](https://github.com/TauCetiProject/TauCeti) and
Mathlib. See [`PLAN.md`](PLAN.md).

| Path | What it is |
|---|---|
| `GLCinLean/Abstract.lean` | the statement: hypotheses and Conj. 1.6.7, currently over placeholders |
| `GLCinLean/Foundations.lean` | re-exports of Mathlib and Tau Ceti objects, and placeholders |
| `blueprint/plans/` | tracker plans of the declarations |
| `reviews/` | the sorry budget and the statement pin (approved by the owner) |
| `glc/project.toml` | configuration of the review checks |
| `prompts/` | goal-mode prompts: the statement, the proof, the fidelity review |
| `references/papers/manifest.toml` | the papers, fetched locally, never committed |

Build and check (clone with `--recurse-submodules`):

    export LAKE_CONFIG=$PWD/.lake-config/lake-config.toml LAKE_CACHE_DIR=$PWD/.lake/cache
    lake exe cache get
    lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti --mappings-only
    lake build

The review checks come from [reviewkit](https://github.com/WHY-Op109/reviewkit), which also holds
their fault-injection tests.

Apache-2.0 (`LICENSE`); third-party material in `THIRD_PARTY_NOTICES.md`.
