# GLCinLean

A Lean library for geometric representation theory, on which a faithful statement of the geometric Langlands conjecture is built: GLC I ([GLC1], arXiv 2405.03599v3) Conj. 1.6.7, de Rham, characteristic 0, over any algebraically closed field `k`. Its proof comes after the statement.

## Writing

- Use plain, understandable, structured words in all text.

## Sources of code

- Use Mathlib first, then Tau Ceti. Search both before defining anything, and before a proof longer than a few lines (its goal and its key steps): Mathlib at the pin, Tau Ceti at the pin and on its `main`.
- Parts covered by a Tau Ceti roadmap go to Tau Ceti, through Tau Ceti's Worker, under Tau Ceti's own `AGENTS.md` and `COORDINATION.md`, from the fork `WHY-Op109/TauCeti`. The roadmap owns these parts, so a second copy here would compete with it. Everything else is written here.

## Subagents

- The main agent gives each subagent its goal, its brief (`lake exe tracker show <module>` for a module, `prompts/review.md` for a review), the sources it needs, the expected scope and the expected time. A subagent that writes code works in its own git worktree, and its work is squash-merged as one commit.
- A subagent may finish without completing its task if the task is ill-specified, impossible, or far larger than expected, and may raise suspicions about its task or nearby code.

## Plan

- The plan is in `plans/`, in the format of the tracker (`tools/tracker`, a git submodule; read `tools/tracker/README.md` before touching the plan). `lake exe tracker ready` lists what can be worked on now; `lake exe tracker lint` checks the plan against the code.
- Once a declaration exists, the Lean code and its docstring are the truth.
- The tracker counts a placeholder as proved, since it has no `sorry`. Remaining placeholders are found with `grep -rn '@\[placeholder\]' GLCinLean`.

## Lean code

- Follow Mathlib's [style guide](https://mathlib.org/contribute/style.html), [naming conventions](https://mathlib.org/contribute/naming.html) and [documentation style](https://mathlib.org/contribute/doc.html), with a docstring on every definition. The `Authors:` line names the contributors and the AI models, as Tau Ceti does.
- Docstrings cite a bracketed key of `docs/references.bib` and the paper's own numbering, not TeX lines. They describe the code as it is: no status text, work history or agent discussion.
- No warnings, apart from the `sorry` of the main theorem.
- Never duplicate Mathlib or Tau Ceti, not even as a thin wrapper, a restatement or a parallel API: what they have need not be written again. The one exception is an object with which the goal cannot be reached even in principle, such as an ordinary category where the paper needs an enhanced one. Then write the new object, and its docstring says why the existing one cannot serve. Factor near-copies in this repository into one construction.
- Read every statement adversarially: check quantifiers, the direction of implications and degenerate cases (empty, zero). In the statement and in every definition it reaches, never move a conclusion into a hypothesis or a structure field, use a `True`-like stand-in, or weaken a statement to make it provable or to remove a placeholder: each of these makes the statement weaker than the paper's. A lemma used in a proof may be weaker than the paper's, as long as it still proves what it is used for. A new `Prop`-valued definition needs a theorem that uses it or an example where it holds non-trivially.
- Use the natural generality: the weakest assumptions the mathematics needs, the general result first and special cases from it. No unused or over-strong hypotheses or instances, and no generality that nothing uses.
- Give each definition the API that lets other files use it without unfolding it, including its universal property where it has one. Bundle a named concept instead of repeating its assumptions, and instantiate the Mathlib structures that emerge (module, ring, topology).
- Put each declaration in its canonical home, in subject folders as in Mathlib: one concept per file, under 1,000 lines, with minimal imports (never `import Mathlib`).
- Prefer robust automation (`simp`, `grind`, `omega`) to long rewrite chains, and split long proofs into lemmas.
- A theorem's name spells its conclusion. Never name a declaration after its source; the source goes in the docstring.
- A rename updates every use in the same commit, including the ids in `plans/`, the text in `docs/` and `prompts/`, and `tools/check-statement-axioms.lean`.
- Code meant for Tau Ceti also meets [Tau Ceti Review's rubrics](https://github.com/TauCetiProject/TauCetiReview/tree/main/rubrics).

## The statement

- The only `sorry` is the proof of the main theorem. Everything the statement uses (definitions, instances, lemmas, well-definedness) is fully proved. The conjecture is stated through the characterisation of `𝕃_G`: a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and every such functor is an equivalence.
- An object not defined yet is a placeholder: an `opaque`, or a definition built over one, marked `@[placeholder]` (`GLCinLean/Placeholder.lean`), with a docstring naming the object it stands for. Placeholders live only in the statement, never in the library or in code meant for Tau Ceti: library code must be real mathematics, or a gap would hide below the statement. One is replaced only together with examples that show the new definition behaves as expected.
- Review and approval:
  - a fresh agent reviews every new or changed definition, planned or helper, with `prompts/review.md`;
  - a *mismatch* or *unsure* verdict goes to the owner;
  - a change to `GLCinLean/Statement/` needs the owner's approval;
  - a change to a definition that the main theorem already depends on in Lean also needs it, unless the review finds its meaning unchanged;
  - a change that waits for approval is on a branch `proposal/<topic>`, and `STATUS.md` on `main` names the branch.

## Builds

- Set `LAKE_CONFIG=.lake-config/lake-config.toml` and `LAKE_CACHE_DIR=.lake/cache`. Fetch the caches before building: `lake exe cache get`, then `lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti` (no `--mappings-only`; retry on failure).
- A `Built Mathlib.…` or `Built TauCeti.…` line (not `:c.o`, not a replayed `trace:`) means a wrong pin or a missing cache: stop and report it.
- Done means: `lake build` and `lake lint` pass, and `lake env lean tools/check-statement-axioms.lean`, which lists every declaration of the statement, shows `sorryAx` only for the main theorem, and for it only `propext`, `Classical.choice`, `Quot.sound` and `sorryAx`.
- Versions stay pinned until the owner upgrades Lean, Mathlib and Tau Ceti to newer releases. A session moves the Tau Ceti pin only when it needs merged Tau Ceti contributions, and then to a commit with a published cache. Mathlib moves with it. If the new commit needs another Lean toolchain, the session stops and asks the owner, because the tracker must build on the project's toolchain.

## Git

- Commit at each important step and push to `main` of `WHY-Op109/GLCinLean`. A change that waits for the owner's approval is pushed to its branch `proposal/<topic>`, not to `main`.
