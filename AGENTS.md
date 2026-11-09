# GLCinLean

A Lean library for geometric representation theory, on which a faithful
statement of the geometric Langlands conjecture is built: GLC I ([GLC1], arXiv 2405.03599v3)
Conj. 1.6.7, de Rham, characteristic 0, over any algebraically closed field `k`. Its proof comes
after the statement.

## Writing

- Use plain, understandable, structured words in all text.

## Sources of code

- Use Mathlib first, then Tau Ceti (search its `main`, not only the pinned version).
- Parts covered by a Tau Ceti roadmap go to Tau Ceti, through Tau Ceti's Worker, under Tau Ceti's own `AGENTS.md` and `COORDINATION.md`: pull requests from the fork `WHY-Op109/TauCeti`, no stacked pull requests, never writing to TauCetiRoadmap. Nothing goes to Mathlib directly.
- Everything else is written here.

## Plan

- The plan is in `plans/`, in the format of the tracker (`tools/tracker`, a git submodule; read `tools/tracker/README.md` before touching the plan). `lake exe tracker ready` lists what can be worked on now; `lake exe tracker lint` checks the plan against the code.
- Once a declaration exists, the Lean code and its docstring are the truth; the plan entry shrinks to its id.
- The tracker counts a placeholder as proved, since it has no `sorry`. Remaining placeholders are found with `grep -rn '@\[placeholder\]' GLCinLean`.

## Lean code

- Follow Mathlib's [style guide](https://mathlib.org/contribute/style.html), [naming conventions](https://mathlib.org/contribute/naming.html) and [documentation style](https://mathlib.org/contribute/doc.html): copyright header, module docstring, a docstring on every definition, American spelling in names. The `Authors:` line names the contributors and the AI models, as Tau Ceti does.
- Docstrings cite a key of `docs/references.bib` plus an exact locator, for example [GLC1] Cor. 1.6.5. They describe the code as it is: no status text, work history or agent discussion.
- No warnings, apart from the `sorry` of the main theorem.
- Search before defining: `grep` in `.lake/packages/mathlib` and `.lake/packages/TauCeti`, `exact?` and `apply?`, LeanSearch and Loogle. For a proof longer than a few lines, search for its goal and its key steps too.
- Never duplicate Mathlib or Tau Ceti, not even as a thin wrapper, a restatement or a parallel API. Factor near-copies in this repository into one construction.
- Read every statement adversarially: check quantifiers, the direction of implications and degenerate cases (empty, zero). Never move a conclusion into a hypothesis or a structure field, use a `True`-like stand-in, or weaken a statement to make it provable. A new `Prop`-valued definition needs a theorem that uses it or an example where it holds non-trivially.
- Use the natural generality: the weakest assumptions the mathematics needs, the general result first and special cases from it. No unused or over-strong hypotheses or instances, and no generality that nothing uses.
- Give each definition its characterising API (introduction and elimination lemmas, `_def` and `mem_*_iff` forms, `@[simp]` normal forms, its universal property where it has one), so that no other file unfolds it. Bundle a named concept instead of repeating its assumptions, and instantiate the Mathlib structures that emerge (module, ring, topology).
- Put each declaration in its canonical home, in subject folders as in Mathlib: one concept per file, under 1,000 lines, with minimal imports (never `import Mathlib`).
- Prefer robust automation (`simp`, `grind`, `omega`) to long rewrite chains. Comment every `change` or `show`. Split proofs over 50 lines into lemmas.
- A theorem's name spells its conclusion. Never name a declaration after its source; the source goes in the docstring.
- A rename updates every use in the same commit: no compatibility aliases or deprecated wrappers.
- Code meant for Tau Ceti also meets [Tau Ceti Review's rubrics](https://github.com/TauCetiProject/TauCetiReview/tree/main/rubrics).

## The statement

- The only `sorry` is the proof of the main theorem. Everything the statement uses (definitions, instances, lemmas, well-definedness) is fully proved. The conjecture is stated through the characterisation of `𝕃_G`: a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and every such functor is an equivalence.
- An object not defined yet is a placeholder: an `opaque` marked `@[placeholder]` (`GLCinLean/Placeholder.lean`), with a docstring naming the object it stands for. Placeholders live only in the statement, never in the library or in code meant for Tau Ceti. One is replaced only together with examples that show the new definition behaves as expected.
- Never weaken what a statement says while removing a placeholder.
- A change to the statement, or to a definition it reaches, is checked by a fresh agent with `prompts/review.md`, then waits for the owner's approval.

## Builds

- Set `LAKE_CONFIG=.lake-config/lake-config.toml` and `LAKE_CACHE_DIR=.lake/cache`. Fetch the caches before building: `lake exe cache get`, then `lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti` (no `--mappings-only`; retry on failure).
- A `Built Mathlib.…` or `Built TauCeti.…` line (not `:c.o`, not a replayed `trace:`) means a wrong pin or a missing cache: stop and report it.
- Done means: `lake build` passes, and `#print axioms` shows no `sorryAx` for any definition the statement uses, and only `propext`, `Classical.choice`, `Quot.sound` and the main theorem's `sorryAx` for the main theorem.
- Versions stay pinned. Move the Tau Ceti pin only when merged Tau Ceti contributions are needed, to a commit with a published cache.

## Git

- Commit at each important step and push to `main` of `WHY-Op109/GLCinLean`.
