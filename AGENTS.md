# GLCinLean

A Lean library for geometric representation theory, in Mathlib style, on which a faithful
statement of the geometric Langlands conjecture is built: GLC I ([GLC1], arXiv 2405.03599v3)
Conj. 1.6.7, de Rham, characteristic 0, over any algebraically closed field `k`. Its proof comes
after the statement. The work follows the principles of
[How to formalize all of mathematics](https://xenaproject.wordpress.com/2026/10/16/how-to-formalize-all-of-mathematics/).
`STATUS.md` says where the work stands; `prompts/` holds the prompt for each step.

## Writing

- Use plain, understandable, structured words in all text: Lean documentation, prompts, notes.
- Claims about sources in Markdown text (notes, reviews, `STATUS.md`, commit messages) carry a
  tag with the date checked: [R] read directly, [S] a source's claim about itself, [E] estimate,
  [J] judgement. The owner cannot check the mathematics and relies on these tags. Lean
  docstrings cite instead: a key of `docs/references.bib` plus an exact locator, for example
  [GLC1] Cor. 1.6.5.

## Sources of code

- Use Mathlib first, then Tau Ceti (search its `main`, not only the pinned version). Other Lean
  libraries are references, not dependencies.
- Parts covered by a Tau Ceti roadmap go to Tau Ceti, through Tau Ceti's Worker, under Tau
  Ceti's own `AGENTS.md` and `COORDINATION.md`: pull requests from the owner's fork, no stacked
  pull requests, never writing to TauCetiRoadmap. Once merged, GLCinLean uses them through its
  Tau Ceti dependency. Nothing goes to Mathlib directly.
- Everything else is written here, in subject folders as in Mathlib.

## Lean style

- Follow Mathlib's [style guide](https://mathlib.org/contribute/style.html),
  [naming conventions](https://mathlib.org/contribute/naming.html) and
  [documentation style](https://mathlib.org/contribute/doc.html): copyright header, module
  docstring, a docstring on every definition, American spelling in names, no status text in
  docstrings. The `Authors:` line names the contributors and the AI models, as Tau Ceti does.
- No warnings, apart from the `sorry` of the main theorem.

## The statement

- The only `sorry` is the proof of the main theorem. Everything the statement uses (definitions,
  instances, lemmas, well-definedness) is fully proved. The conjecture is stated through the
  characterisation of `𝕃_G`: a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and
  every such functor is an equivalence.
- An object not defined yet is a placeholder: an `opaque` marked `@[placeholder]`
  (`GLCinLean/Placeholder.lean`), with a docstring naming the object it stands for. Placeholders
  live only in the statement, never in the library or in code meant for Tau Ceti. One is
  replaced only together with examples that show the new definition behaves as expected.
- Never weaken what a statement says while removing a placeholder.
- A change to the statement, or to a definition it reaches, is checked by a fresh agent with
  `prompts/review.md`, then waits for the owner's approval.

## Builds

- Set `LAKE_CONFIG=.lake-config/lake-config.toml` and `LAKE_CACHE_DIR=.lake/cache`. Fetch the
  caches before building: `lake exe cache get`, then `lake cache get --service tauceti-public
  --repo TauCetiProject/TauCeti --package TauCeti` (no `--mappings-only`; retry on failure).
- A `Built Mathlib.…` or `Built TauCeti.…` line (not `:c.o`, not a replayed `trace:`) means a
  wrong pin or a missing cache, and hours of compiling: stop and report it.
- Done means: `lake build` passes, and `#print axioms` shows no `sorryAx` for any definition the
  statement uses, and only `propext`, `Classical.choice`, `Quot.sound` and the main theorem's
  `sorryAx` for the main theorem.
- Versions stay pinned (Tau Ceti `v4.36.0-rc2`, which fixes Mathlib and Lean). Move the Tau Ceti
  pin only when merged Tau Ceti contributions are needed, to a commit with a published cache.

## Git

- Commit at each important step and push to `main` of `WHY-Op109/GLCinLean`; the owner reads
  the commits.
