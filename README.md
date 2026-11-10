# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

A Lean 4 library for geometric representation theory, built on Mathlib and
[Tau Ceti](https://github.com/TauCetiProject/TauCeti), and on it a faithful statement of the
global unramified de Rham geometric Langlands conjecture: GLC I (Gaitsgory–Raskin,
[arXiv 2405.03599v3](https://arxiv.org/abs/2405.03599v3)), Conjecture 1.6.7. The proof comes after
the statement.

## Where it stands

A first draft of the statement exists, built on placeholders for the objects no library has yet
(DG categories, D-modules on `Bun_G`, `IndCoh_Nilp(LS_Ǧ)`, …). The next step writes the plan of
every object the statement uses and changes the statement where the plan needs it. [`STATUS.md`](STATUS.md) has the details.

## How the work runs

Agents do the work, one session per step, each started from a prompt in `prompts/`:

| Prompt | Step |
|---|---|
| [`plan.md`](prompts/plan.md) | write the plan in `plans/` and change the existing code where the plan needs it |
| [`build.md`](prompts/build.md) | replace placeholders by real definitions, working up the plan |
| [`review.md`](prompts/review.md) | check that definitions mean what the papers say (run by an agent that did not write them) |

[`AGENTS.md`](AGENTS.md) holds the rules every session follows: Mathlib first, then Tau Ceti; parts on a Tau Ceti roadmap are contributed to Tau Ceti; Mathlib's style; and only one `sorry`, the proof of the main theorem.

## Layout

| Path | What it is |
|---|---|
| `GLCinLean/` | the Lean code: the statement (`Abstract.lean`), what it is built from (`Foundations.lean`), and the `@[placeholder]` attribute |
| `plans/` | the plan, in the format of the [tracker](https://github.com/bridgekat/tracker) (written in the next step) |
| `tools/tracker` | the tracker, a git submodule |
| `tools/tex-locator.awk` | gives the paper's number (for example Conj. 1.6.7) of a line of its TeX |
| `prompts/` | one prompt per step |
| `docs/references.bib` | the papers cited, with their arXiv versions |
| `docs/papers.md` | one line per paper on what it covers, and how to search its TeX |
| `notes/reviews/` | review reports (from the first review on) |

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
