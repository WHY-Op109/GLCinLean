# Goal: the statement, with every definition real

**Goal.** Every definition that GLC I Conj. 1.6.7 uses, as stated in `GLCinLean/Abstract.lean`,
is real: no placeholders in the closure of the abstract (`review placeholders`), and the sorry
budget holds only theorems (statements of results from the papers), never data.

**Read first:** `PLAN.md` (decisions in force), `AGENTS.md`, `GLCinLean/Abstract.lean`,
`GLCinLean/Foundations.lean`, `blueprint/plans/`. Papers: `references/papers/` (fetch them
from arXiv at the versions in `manifest.toml`).

**Steps.**
1. If `blueprint/` does not yet list every definition the statement needs, write that first:
   for each, the paper's locator (section, equation, line), what it depends on, and the
   provider choice (Mathlib, Tau Ceti, copy from Stacks, or build in `GLCinLean/Staging/`).
   Record the formalism chosen for stacks in `PLAN.md`. A formalism choice that changes the statement's
   shape is worth checking with the owner before building on it.
2. Then repeat: take the next placeholder whose dependencies are real, replace it by a real
   definition (or a re-export), keep its interface unless the source says otherwise, build, update
   the blueprint, commit.
3. Theorems the definitions need are stated with `sorry`, with the paper's locator, and get a
   sorry-budget entry (`lake exe review --config glc/project.toml axioms --toml`) with
   `approved` left blank: the owner approves it when reading the commit.

**Notes.** The pinned statements (`main`, `Setting`) and the owner's files (`AGENTS.md`) are
the owner's to change; an `axiom` would make the statement weaker than it looks. If a definition
is unclear in the source, the question can go into `PLAN.md` under "Open questions" while work
moves to another one.

**Done when** `review placeholders` reports none in the closure, the build
passes, and every new key definition has had a fidelity review (`prompts/review.md`).
