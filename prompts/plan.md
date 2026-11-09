# Step 2: plan

**Goal.** Write the blueprint of the GLC statement in `plans/`, in the tracker's format: every object that [GLC1] Conj. 1.6.7 uses, down to what Mathlib and Tau Ceti already have, with where each comes from and what it depends on. While drafting, judge the existing project against the blueprint, and make the changes it needs.

**Done when**
- `plans/` holds a module plan for every module the statement needs: library modules in subject folders, and the statement's own modules;
- every object the statement uses is a planned declaration whose `source` gives its locator in the papers, whose `desc` says its provider (Mathlib, Tau Ceti, a Tau Ceti roadmap item, an open Tau Ceti roadmap pull request, or missing, with the Tau Ceti commit checked) and, for a placeholder, that it is one, and whose `deps` lists what it depends on;
- the existing Lean code has been judged against the blueprint, and every change it needs has been made;
- a change to the statement, or to a definition it reaches, is reviewed by a fresh agent with `prompts/review.md`, then put to the owner together with the review, and is not pushed until the owner has approved it: the session waits;
- `lake exe tracker lint` passes, and the done check in `AGENTS.md` passes;
- `STATUS.md` proposes answers, with reasons, to three questions for the owner: how to use the open Tau Ceti roadmap pull requests; how other Lean libraries may be used; and how to handle the ∞-categorical layer;
- `STATUS.md` is updated, `prompts/build.md` has been checked and updated if needed, and the work is committed and pushed.

**Context**
- The current statement is in `GLCinLean/` (`Statement/Conjecture.lean`, `Statement/Enhanced.lean`); its placeholders are found with `grep -rn '@\[placeholder\]' GLCinLean`. It is a first draft, so the blueprint follows the papers, not the draft.
- The papers are listed in `docs/papers.md`, and their TeX is in `references/papers/`. Add any other paper you need to `docs/references.bib`.
- The tracker's format is in `tools/tracker/README.md`; its `examples/` folder has a plan that uses every field.
