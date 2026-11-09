# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

A Lean 4 library for geometric representation theory, built on
[Tau Ceti](https://github.com/TauCetiProject/TauCeti) and Mathlib, and on it a faithful statement
of the global unramified de Rham geometric Langlands conjecture (GLC I, arXiv 2405.03599v3,
Conjecture 1.6.7); the proof comes after the statement. See [`STATUS.md`](STATUS.md).

| Path | What it is |
|---|---|
| `GLCinLean/` | the Lean code: the statement (`Abstract.lean`) and what it is built from |
| `blueprint.md` | every object the statement uses, where it comes from, and its state |
| `prompts/` | one prompt per step of the work (plan, build, review) |
| `docs/references.bib` | the papers cited, with their arXiv versions |
| `notes/` | research notes and review reports |

Build:

    export LAKE_CONFIG=$PWD/.lake-config/lake-config.toml LAKE_CACHE_DIR=$PWD/.lake/cache
    lake exe cache get
    lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti
    lake build

Apache-2.0 (`LICENSE`).
