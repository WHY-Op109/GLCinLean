# GLCinLean

A Lean library for geometric representation theory, on which a faithful statement of the geometric Langlands conjecture is built: GLC I ([GLC1], arXiv 2405.03599v3) Conj. 1.6.7, de Rham, characteristic 0, over any algebraically closed field `k`. Its proof comes after the statement.

## Writing

- Use plain, understandable, structured words in all text. Use one term for each concept.
- In text that agents read (`AGENTS.md`, `prompts/`, `STATUS.md`, the plan, `docs/`, and the briefs given to subagents), state the current facts, the actions to take, and the reasons needed to act. Leave out who the text is for or not for, what it replaces, how it came about, and what changed since an earlier version. Keep what the next session needs: the questions waiting for the owner, the decisions still in force, and the last checked and audited commits.
- In Lean doc comments and comments, follow Mathlib's [documentation style](https://mathlib.org/contribute/doc.html), and:
  - every definition has a doc comment;
  - a doc comment that uses a paper cites its bracketed key of `docs/references.bib` and the paper's own numbering;
  - a doc comment states the mathematics so that it matches the Lean code exactly: every hypothesis, including type classes with mathematical content, the same strength of conclusion, the same order of quantifiers, and the same degenerate cases;
  - each difference from the paper is recorded in the declaration's doc comment, with its kind (correction, reading, restriction, reformulation or generalization) and the reason. The module doc comment of `GLCinLean.Statement.Conjecture` lists, one line each, every difference that affects the statement, including those in the library definitions that the statement uses;
  - the doc comment of a placeholder states the object it stands for;
  - doc comments and comments describe the code as it is: no status text, work history, or mention of agents, sessions, the plan or reviews.

## Prompts

- `prompts/work.md`: a session that implements the plan. Its step 3 says how it chooses the work.
- `prompts/check.md`: a fresh agent checks each change of a work session, on a local commit, before the change goes to `main` or to the owner.
- `prompts/audit.md`: a session of its own, when the owner asks for one, before the first placeholder is replaced, when a Tau Ceti roadmap that owns plan nodes is merged, changed or replaced, and otherwise after about ten work sessions.
- `prompts/clean.md`: the owner starts a cleanup session. An audit may recommend one.
- The session that updates `STATUS.md` records in "Next" the next task and any audit that is due.

## Sources of code

- Use Mathlib first, then Tau Ceti. Search both before defining anything, and before a proof longer than a few lines (its goal and its key steps): Mathlib at the pin, Tau Ceti at the pin and on its `main`.
- Parts covered by a Tau Ceti roadmap go to Tau Ceti, through Tau Ceti's Worker, under Tau Ceti's own `AGENTS.md` and `COORDINATION.md`, from the fork `WHY-Op109/TauCeti`. The roadmap owns these parts, so a second copy here would compete with it. Everything else is written here.

## Subagents

- The session gives each subagent its goal, its brief, the sources it needs, the expected scope and the expected time. A subagent that writes code works in its own git worktree, and its work is squash-merged as one commit.
- A subagent may finish without completing its task if the task is ill-specified, impossible, or far larger than expected, and may raise suspicions about its task or nearby code.

## Plan

- The plan is in `plans/`, in the format of the tracker (`tools/tracker`, a git submodule; read `tools/tracker/README.md` before touching the plan). `lake exe tracker ready` lists what can be worked on now; `lake exe tracker lint` checks the plan against the code.
- Once a declaration exists, the Lean code and its doc comment are the truth.
- `plans-proof/` holds the nodes that only the proof of the main theorem needs (`plans-proof/README.md`). The tracker does not read it, and no node in `plans/` depends on it.
- The tracker counts a placeholder as proved, since it has no `sorry`. Remaining placeholders are found with `grep -rn '@\[placeholder\]' GLCinLean`.

## Small and big changes

- Correct the nodes needed for the current work: the nodes a session is about to write and the nodes these use. Leave the other nodes until the work reaches them.
- A session makes small changes itself and names each one in its commit message. Small changes are: the wording, `deps` or `source` of a node; splitting, merging or moving modules; a new helper declaration or node; a lemma stated in a form that still proves what it is used for; a rename, with every use updated.
- A big change needs the owner's decision, even when it only edits a node's `desc`, `deps` or `source`. Big changes are:
  - any change to `GLCinLean/Statement/`;
  - a change to the meaning of a definition that the statement uses or will use (the object it is, its generality or its hypotheses), unless a check with `prompts/check.md` finds its meaning unchanged;
  - a change of route: a different construction or source for an object, or a claim of the source that the plan drops or cannot prove;
  - dropping or weakening a theorem or an example that the plan asks for;
  - a change of provider: work moved between this project and Tau Ceti;
  - the removal of a planned definition (a roadmap node whose declaration is now at the pin is removed as `prompts/work.md` says), and holding or releasing a node under "Held" in `STATUS.md`.
- When unsure whether a change is big, treat it as big. A change that the owner has already decided, as `STATUS.md` records it, needs no new decision within that scope.
- A node found false or unprovable as stated is marked `wrong`, with the reason (`tools/tracker/README.md`). Changing its claim is a big change.
- For a big change, or a change with an open *mismatch* or *unsure* verdict, the session stops that line of work. It writes the question under "Waiting for the owner" in `STATUS.md`, in at most ten lines: what and why, the options, and its recommendation. The change, its check report and any code go on a branch `proposal/<topic>`, which the question names; `main` gets the change only after the owner's decision. The session then continues with other ready work.

## Lean code

- Follow Mathlib's [style guide](https://mathlib.org/contribute/style.html) and [naming conventions](https://mathlib.org/contribute/naming.html); doc comments follow "Writing". The `Authors:` line names the contributors and the AI models, as Tau Ceti does.
- No warnings, apart from the `sorry` of the main theorem.
- Never duplicate Mathlib or Tau Ceti, not even as a thin wrapper, a restatement or a parallel API: what they have need not be written again. The one exception is an object with which the goal cannot be reached even in principle. Then write the new object, and its doc comment says why the existing one cannot serve. Factor near-copies in this repository into one construction.
- Read every statement adversarially: check quantifiers, the direction of implications and degenerate cases (empty, zero). In the statement and in every definition it reaches, never move a conclusion into a hypothesis or a structure field, use a `True`-like stand-in, or weaken a statement to make it provable or to remove a placeholder: each of these makes the statement weaker than the paper's. A lemma used in a proof may be weaker than the paper's, as long as it still proves what it is used for. A new `Prop`-valued definition needs a theorem that uses it or an example where it holds non-trivially.
- Use the natural generality: the weakest assumptions and the weakest structure the mathematics needs, the general result first and special cases from it. No unused or over-strong hypotheses or instances, and no abstraction that nothing uses.
- Give each definition the API that lets other files use it without unfolding it, including its universal property where it has one. Bundle a named concept instead of repeating its assumptions, and instantiate the Mathlib structures that emerge (module, ring, topology).
- Put each declaration in its canonical home, in subject folders as in Mathlib: one concept per file, under 1,000 lines, with minimal imports (never `import Mathlib`).
- Prefer robust automation (`simp`, `grind`, `omega`) to long rewrite chains, and split long proofs into lemmas.
- A theorem's name spells its conclusion. Never name a declaration after its source; the source goes in the doc comment.
- A rename updates every use in the same commit, including the ids in `plans/`, the text in `docs/` and `prompts/`, and `tools/check-statement-axioms.lean`.
- Code meant for Tau Ceti also meets [Tau Ceti Review's rubrics](https://github.com/TauCetiProject/TauCetiReview/tree/main/rubrics).

## The statement

- The only `sorry` is the proof of the main theorem. Everything the statement uses (definitions, instances, lemmas, well-definedness) is fully proved. The conjecture is stated through the characterisation of `𝕃_G`: a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and every such functor is an equivalence. The second property is stated with the Hecke action of `Rep(Ǧ)_Ran`, which needs no action of `QCoh(LS_Ǧ)`. By [GLC1] Thm. 1.2.4 it is the paper's property in an equivalent form for the underlying functors of ∞-categories.
- An object not defined yet is a placeholder: an `opaque`, or a definition built over one, marked `@[placeholder]` (`GLCinLean/Placeholder.lean`); its doc comment follows "Writing". Placeholders live only in the statement, never in the library or in code meant for Tau Ceti: library code must be real mathematics, or a gap would hide below the statement. One is replaced only together with examples that show the new definition behaves as expected.
- A fresh agent checks every new or changed definition, planned or helper, with `prompts/check.md`. A *mismatch* or *unsure* verdict goes to the owner, as "Small and big changes" says.

## Builds

- Set `LAKE_CONFIG=.lake-config/lake-config.toml` and `LAKE_CACHE_DIR=.lake/cache`. Fetch the caches before building: `lake exe cache get`, then `lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti` (no `--mappings-only`; retry on failure).
- The first build of a checkout may print `Built TauCeti.…` lines: when the pin has no published cache of its own, Tau Ceti's cache falls back to an older commit, and Lake rebuilds the difference. This is expected. A `Built Mathlib.…` line means the Mathlib cache was not fetched: run `lake exe cache get` again.
- The done check passes when `lake build` and `lake lint` pass, and `lake env lean tools/check-statement-axioms.lean`, which lists every declaration of the statement, shows `sorryAx` only for the main theorem, and for it only `propext`, `Classical.choice`, `Quot.sound` and `sorryAx`.
- At the start of each session, check Tau Ceti's tags (`git ls-remote --tags https://github.com/TauCetiProject/TauCeti`) and the `lean-toolchain` of its `main`.
- A session may move the Tau Ceti pin forward, to a newer `main` commit or tag on the same Lean toolchain, when the done check passes there. Prefer a tag. Mathlib moves to the commit that Tau Ceti names. The pin move is a commit of its own.
- The Lean toolchain changes only to a Tau Ceti tag `vX` of a Lean release (not a release candidate), and then to the newest such tag. Tau Ceti's tag promises a full published cache.
- If the tracker or this project fails to build at a new pin, keep the old pin and report the failure in `STATUS.md`.

## Git

- Commit at each important step and push to `main` of `WHY-Op109/GLCinLean`. A change that waits for the owner's decision goes to its branch, as "Small and big changes" says.
