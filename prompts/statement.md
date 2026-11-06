# Goal: the statement, with every definition real

Paste into a Claude Code session in goal mode, opened in the GLCinLean checkout.

**Goal.** Every definition that GLC I Conj. 1.6.7 uses, as stated in `GLCinLean/Abstract.lean`,
is real: no placeholders in the closure of the abstract (`review placeholders`), and the sorry
budget holds only theorems (statements of results from the papers), never data.

**Read first:** `PLAN.md` (decisions in force), `AGENTS.md`, `GLCinLean/Abstract.lean`,
`GLCinLean/Foundations.lean`, `blueprint/plans/`. Papers: `scripts/fetch-papers.py`, then
`references/papers/`.

**Steps.**
1. If `blueprint/` does not yet list every definition the statement needs, write that first:
   for each, the paper's locator (section, equation, line), what it depends on, and the
   provider choice (Mathlib, Tau Ceti, copy from Stacks, or build in `GLCinLean/Staging/`).
   Record the formalism chosen for stacks in `PLAN.md`. Stop and ask the owner before building
   on a formalism choice that changes the statement's shape.
2. Then repeat: take the next placeholder whose dependencies are real, replace it by a real
   definition (or a re-export), keep its interface unless the source says otherwise, build, run
   `scripts/check.sh`, update the blueprint, commit.
3. Theorems the definitions need are stated with `sorry`, with the paper's locator, and get a
   sorry-budget entry (`lake exe review --config glc/project.toml axioms --toml`) with
   `approved` left blank: the owner approves it when reading the commit.

**Do not:** change the pinned statements (`main`, `Setting`), `reviews/statement-pin.toml`,
an existing budget entry, `glc/project.toml`, `lakefile.toml`, `lake-manifest.json` or
`lean-toolchain` without asking;
weaken a check; add an `axiom`. If a definition is unclear in the source,
write the question into `PLAN.md` under "Open questions" and move to another one.

**Done when** `review placeholders` reports none in the closure, `scripts/check.sh`
passes, and every new key definition has had a fidelity review (`prompts/review.md`).
