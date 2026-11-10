# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

A Lean 4 library for geometric representation theory, built on Mathlib and [Tau Ceti](https://github.com/TauCetiProject/TauCeti), and on it a faithful statement of the global unramified de Rham geometric Langlands conjecture: GLC I (Gaitsgory–Raskin, [arXiv 2405.03599v3](https://arxiv.org/abs/2405.03599v3)), Conjecture 1.6.7. The proof comes after the statement.

## Where it stands

The statement is in `GLCinLean/Statement/`. Its main theorem says that a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and that every such functor is an equivalence. The objects no library has yet (DG categories, D-modules on `Bun_G`, `IndCoh_Nilp(LS_Ǧ)`, …) are placeholders. The plan in `plans/` lists every object the statement uses, down to Mathlib and Tau Ceti; the parts that a Tau Ceti roadmap owns are under `plans/Roadmap/`. [`STATUS.md`](STATUS.md) has the details.

## How the work runs

Agents do the work, each session started from a prompt in `prompts/`:

| Prompt | What it does |
|---|---|
| [`build.md`](prompts/build.md) | move the plan forward by one module, from the bottom up, towards real definitions in place of the placeholders |
| [`review.md`](prompts/review.md) | check that definitions mean what the papers say (run by an agent that did not write them) |
| [`audit.md`](prompts/audit.md) | judge, from time to time, whether the statement, the plan and the workflow still reach the goal in the simplest way |
| [`next-steps.md`](prompts/next-steps.md) | one-off sessions to run before the build continues |

[`AGENTS.md`](AGENTS.md) holds the rules every session follows: Mathlib first, then Tau Ceti; parts on a Tau Ceti roadmap are contributed to Tau Ceti; Mathlib's style; and only one `sorry`, the proof of the main theorem.

## Layout

| Path | What it is |
|---|---|
| `GLCinLean/` | the Lean code: the statement (`Statement/Conjecture.lean`), its enhanced categorical placeholders (`Statement/Enhanced.lean`), and the `@[placeholder]` attribute |
| `plans/` | the plan, in the format of the [tracker](https://github.com/bridgekat/tracker): `plans/GLCinLean/` is written here, `plans/Roadmap/<area>/` belongs to a Tau Ceti roadmap |
| `tools/tracker` | the tracker, a git submodule |
| `tools/check-statement-axioms.lean` | prints the axioms of the statement's declarations (the done check) |
| `tools/tex-locator.awk` | gives the paper's number (for example Conj. 1.6.7) of a line of its TeX |
| `prompts/` | the prompts the sessions start from |
| `docs/references.bib` | the papers cited, with their arXiv versions |
| `docs/papers.md` | one line per paper on what it covers, and how to search its TeX |
| `docs/blueprint-providers.md` | the Mathlib, Tau Ceti and roadmap snapshot the plan was checked against |
| `notes/` | review and audit reports, while their findings are open |

## Build

    git clone --recurse-submodules https://github.com/WHY-Op109/GLCinLean
    cd GLCinLean
    export LAKE_CONFIG=$PWD/.lake-config/lake-config.toml LAKE_CACHE_DIR=$PWD/.lake/cache
    lake exe cache get
    lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti
    lake build
    lake exe tracker status      # progress against the plan

## Licence

Apache-2.0 ([`LICENSE`](LICENSE)).
