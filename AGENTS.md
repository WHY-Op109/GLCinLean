# GLCinLean

A Lean library for geometric representation theory, on which a faithful statement of the geometric Langlands conjecture is built: GLC I ([GLC1], arXiv 2405.03599v3) Conj. 1.6.7, de Rham, characteristic 0, over any algebraically closed field `k`. Its proof comes after the statement.

## Writing

- Use plain, understandable, structured words in all text. Use one term for each concept.
- This file holds every rule of the project, for every agent. `CLAUDE.md` only imports it for Claude Code, with the line `@AGENTS.md`: write each rule here, and none there.
- In text that agents read (`AGENTS.md`, `prompts/`, `.claude/agents/`, `STATUS.md`, the plan, `docs/`, and the briefs given to subagents), state the current facts, the actions to take, and the reasons needed to act. Leave out who the text is for or not for, what it replaces, how it came about, and what changed since an earlier version. In `STATUS.md`, keep the state that "Workflow" lists.
- In Lean doc comments and comments, follow Mathlib's [documentation style](https://mathlib.org/contribute/doc.html), and:
  - every definition has a doc comment;
  - a doc comment that uses a paper cites its bracketed key of `docs/references.bib` and the paper's own numbering;
  - a doc comment states the mathematics so that it matches the Lean code exactly: every hypothesis, including type classes with mathematical content, the same strength of conclusion, the same order of quantifiers, and the same degenerate cases;
  - each difference from the paper is recorded in the declaration's doc comment, with its kind (correction, reading, restriction, reformulation or generalization) and the reason. The module doc comment of the root file `GLCinLean.lean` lists, one item each, every difference that affects the statement, including those in the library definitions that the statement uses;
  - the doc comment of a placeholder states the object it stands for;
  - doc comments and comments describe the code as it is: no status text, work history, or mention of agents, sessions, the plan or reviews.

## Workflow

- The first goal is the faithful formalisation of the definitions: every placeholder of the statement is replaced by a real definition, and the done check passes.
- A session that is asked to run the workflow repeats these steps in order, one cycle after another:
  1. `prompts/audit.md`: when an audit is due: before the first placeholder is replaced, when a Tau Ceti roadmap that owns plan nodes is merged, changed or replaced, and otherwise after about ten cycles.
  2. `prompts/clean.md`: after an audit that names files or text that are no longer needed, and when the monitor reports that the free disk space of the session's host is below its limit (20 GB).
  3. `prompts/start.md`: bring the Tau Ceti workers in line with the plan, fold in merged upstream work, and write each ready module.
  4. `prompts/check.md`: a checker checks each commit of step 3 before the push.
  5. `prompts/change.md`: for each line of work where the plan is blocked or needs a big change, also when an audit finds it.
- The session stops only when the first goal is reached, or when every remaining line of work is under "Waiting for the owner" in `STATUS.md`. While work waits only for Tau Ceti, the session waits for the monitor. At the end of each cycle the session records the state in `STATUS.md` and states in its reply: the number of placeholders left, the result of the done check, and each remaining line of work with what it waits for.
- The plan says what to formalise: `lake exe tracker ready` lists the modules that can be written now, and `lake exe tracker show <module>` is the brief of one. A module under `GLCinLean.` is written here. A module under `Roadmap.<area>.` is a target of the Tau Ceti Worker. The nodes under "Held" in `STATUS.md` and the main theorem's module are left alone. `STATUS.md` records the state: the progress of the plan, the checked and audited commits, the last build checks, the pins, the workers and their pull requests, the held nodes, the open items, the questions for the owner, and the decisions in force.
- The roles are in the table. The owner starts the session on Fable 5.2 at high effort. The definitions in `.claude/agents/` set the model and the effort of each subagent, so the session passes neither when it starts one.

  | Role | Model, effort | Task |
  |---|---|---|
  | Session | Fable 5.2, high | Coordinates: chooses the work, starts the other roles, merges their results and keeps `STATUS.md` current. It writes no module itself. |
  | Planner | Fable 5.2, high | Solves a problem that a writer hands over, proposes a big change (`prompts/change.md`), and runs the audit. |
  | Writer | Opus 5.5, high | Writes one ready module of this repository. Modules that do not depend on each other have writers in parallel. A writer that fails twice on the same goal returns the goal. The session then starts a second writer on that goal. When this writer fails too, the problem goes to the planner. |
  | Checker | Fable 5.2, high | Checks one commit or branch with `prompts/check.md`. |
  | Blind reader | Opus 5.5, high | Gives the checker its blind reading. |
  | Searcher | Opus 5.5, xhigh | Searches Mathlib and Tau Ceti deeply, so that nothing they have is written again, and does other tasks with a clear scope. |
  | Codex | its most capable model, high | The second checker of a big change, read-only (`codex exec`). |
  | Author workers | Opus 5.5, high (`agent = "claude"`) | Persistent Tau Ceti workers, each pinned to one roadmap area with a ready module and guided to the targets of `lake exe tracker show`. Each repairs the open pull requests of its area first (the phases `rebase`, `fix-ci`, `fix`) and writes a new target only when none needs repair (`roadmap`). The session decides how many run at once, from the plan and the quota. |
  | Maintenance workers | `maintenance`: the Worker's default (`agent = "auto"`: GPT 6.1 Sol, high, first; Opus 5.5, high, when Codex is over its pace); `repair`: Opus 5.5, high (`agent = "claude"`) | Two persistent Tau Ceti workers that are pinned to no area. `maintenance` has every phase of the Worker except `roadmap` and `overlap-scan` (the Worker runs `overlap-scan` only with write access to Tau Ceti): it repairs and rebases our pull requests first, and then reviews pull requests of other contributors. Its phase `progress` writes the generated status files of a roadmap area, which is the only kind of pull request of ours in the roadmap repository. `repair` has only the phases `rebase`, `fix-ci` and `fix`, for our pull requests of every area, so that a repair does not wait for an author worker that is busy or disabled. |
  | Monitor | no model | A background shell task, `tools/monitor.sh`, that watches the workers, our pull requests and the watched pull requests of `STATUS.md`. It wakes the session when a worker fails or stops, when one of these pull requests is opened, merged or closed or fails CI, when the free disk space of the session's host falls below 20 GB (the session then runs `prompts/clean.md`), and after one day without an event. On the workers' host, cron runs `tools/keep-workers-running.sh` every half hour; it starts the Worker's manager when the manager is not running, starts it again when it runs without the host's proxy, and ends a Lean process of a worker that sleeps without end. The session starts it again before it waits. |
- The session gives each subagent its goal, its brief, the sources it needs, the expected scope and the expected time. Writers and the planner work in their own git worktrees, and the session squash-merges the work of each as one commit.
- A subagent may finish without completing its task if the task is ill-specified, impossible, or far larger than expected, and may raise suspicions about its task or nearby code.
- The workers act as the owner's GitHub account ("Sources of code"). The Worker's README (https://github.com/TauCetiProject/TauCetiWorker) is the authority on its commands. A persistent worker is an entry of the Worker's `workers.toml` with the fields `agent`, `only`, `roadmap_only`, `extra_roadmap_prompt`, `author_effort` and `pace` (its `docs/workers.md`) and `full_quality` (its README); `tauceti workers apply --check` validates the file, and `tauceti workers` shows the state. A target that the roadmap's generated `STATUS.md` lists as done is already in Tau Ceti and is not a target.

## Sources of code

- Use Mathlib first, then Tau Ceti. Search both before defining anything, and before a proof longer than a few lines (its goal and its key steps): Mathlib at the pin, Tau Ceti at the pin and on its `main`.
- Parts covered by a Tau Ceti roadmap go to Tau Ceti, through Tau Ceti's Worker, under Tau Ceti's own `AGENTS.md` and `COORDINATION.md`, from the fork `WHY-Op109/TauCeti`. The roadmap owns these parts, so a second copy here would compete with it. Everything else is written here. Apart from the Tau Ceti workers, agents only read Tau Ceti and its roadmaps: they open no pull request, issue or comment there.

## Plan

- The plan is in `plans/`, in the format of the tracker (`tools/tracker`, a git submodule; read `tools/tracker/README.md` before touching the plan). `lake exe tracker lint` checks the plan against the code.
- Once a declaration exists, the Lean code and its doc comment are the truth.
- `plans-proof/` holds the nodes that only the proof of the main theorem needs (`plans-proof/README.md`). The tracker does not read it, and no node in `plans/` depends on it.
- The tracker counts a placeholder as proved, since it has no `sorry`. Remaining placeholders are found with `grep -rn '@\[placeholder\]' GLCinLean`.
- A node of `plans/Roadmap/` is deleted only when its declaration is at the pin, its interface is checked, and a checker has checked its meaning. In the same commit, the nodes that used it name the upstream declaration and its module in their `desc`.
- An error or a gap found in a paper, and a claim that is given up as too hard, is recorded in the module doc comment of the root file `GLCinLean.lean`: under "Differences from the sources" or "Not formalized", with the paper's key and number, what is wrong or missing, and the declaration it concerns once that exists. A node whose claim is false or unprovable as stated is also marked `wrong`.
- Before a commit that changes the plan or adds a module, `lake exe tracker lint` has no errors and `python3 tools/check-module-cycles.py` finds no cycle.

## Small and big changes

- Correct the nodes needed for the current work: the nodes that are about to be written and the nodes these use. Leave the other nodes until the work reaches them.
- The session and the writers make small changes themselves and name each one in the commit message. Small changes are: the wording, `deps` or `source` of a node; splitting, merging or moving modules; a new helper declaration or node; a lemma stated in a form that still proves what it is used for; a rename, with every use updated.
- A big change is made with `prompts/change.md`, even when it only edits a node's `desc`, `deps` or `source`. Big changes are:
  - any change to `GLCinLean/Statement/`;
  - a change to the meaning of a definition that the statement uses or will use (the object it is, its generality or its hypotheses), unless a check with `prompts/check.md` finds its meaning unchanged;
  - a change of route: a different construction or source for an object, or a claim of the source that the plan drops or cannot prove;
  - dropping or weakening a theorem or an example that the plan asks for;
  - a change of provider: work moved between this project and Tau Ceti;
  - the removal of a planned definition (a roadmap node whose declaration is now at the pin is removed as "Plan" says), and holding or releasing a node under "Held" in `STATUS.md`.
- When unsure whether a change is big, treat it as big. A change within the scope of a decision that `STATUS.md` records needs no new agreement.
- A node found false or unprovable as stated is marked `wrong`, with the reason (`tools/tracker/README.md`). Changing its claim is a big change.
- For a big change, or a *mismatch* or *unsure* verdict that the writer cannot fix, the session stops that line of work and runs `prompts/change.md` on it. The planner proposes the change on a branch `proposal/<topic>`, and Codex checks it, until both agree that the change is right by the papers, by Mathlib's principles and by this file. The session then applies it and records it under "Decisions taken" in `STATUS.md`. Without agreement after five rounds, the question goes under "Waiting for the owner". The session continues with the other ready work.

## Lean code

- Follow Mathlib's [style guide](https://mathlib.org/contribute/style.html) and [naming conventions](https://mathlib.org/contribute/naming.html); doc comments follow "Writing". The `Authors:` line names the contributors and the AI models, as Tau Ceti does.
- No warnings, apart from the `sorry` of the main theorem.
- Never duplicate Mathlib or Tau Ceti, not even as a thin wrapper, a restatement or a parallel API: what they have need not be written again. The one exception is an object with which the goal cannot be reached even in principle. Then write the new object, and its doc comment says why the existing one cannot serve. Factor near-copies in this repository into one construction.
- Read every statement adversarially: check quantifiers, the direction of implications and degenerate cases (empty, zero). In the statement and in every definition it reaches, never move a conclusion into a hypothesis or a structure field, use a `True`-like stand-in, or weaken a statement to make it provable or to remove a placeholder: each of these makes the statement weaker than the paper's. A lemma used in a proof may be weaker than the paper's, as long as it still proves what it is used for. A new `Prop`-valued definition needs a theorem that uses it or an example where it holds non-trivially.
- Use the natural generality: the weakest assumptions and the weakest structure the mathematics needs, the general result first and special cases from it. No unused or over-strong hypotheses or instances, and no abstraction that nothing uses.
- Give each definition the API that lets other files use it without unfolding it, including its universal property where it has one. Bundle a named concept instead of repeating its assumptions, and instantiate the Mathlib structures that emerge (module, ring, topology).
- Give each new definition examples or test lemmas that show it behaves as expected.
- Put each declaration in its canonical home, in subject folders as in Mathlib: one concept per file, under 1,000 lines, with minimal imports (never `import Mathlib`).
- Prefer robust automation (`simp`, `grind`, `omega`) to long rewrite chains, and split long proofs into lemmas.
- A theorem's name spells its conclusion. Never name a declaration after its source; the source goes in the doc comment.
- A rename updates every use in the same commit, including the ids in `plans/`, the text in `docs/` and `prompts/`, and `tools/check-statement-axioms.lean`.
- Code meant for Tau Ceti also meets [Tau Ceti Review's rubrics](https://github.com/TauCetiProject/TauCetiReview/tree/main/rubrics).

## The statement

- The only `sorry` is the proof of the main theorem. Everything the statement uses (definitions, instances, lemmas, well-definedness) is fully proved. The conjecture is stated through the characterisation of `𝕃_G`: a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and every such functor is an equivalence. The second property is stated with the Hecke action of `Rep(Ǧ)_Ran`, which needs no action of `QCoh(LS_Ǧ)`. By [GLC1] Thm. 1.2.4 it is the paper's property in an equivalent form for the underlying functors of ∞-categories.
- An object not defined yet is a placeholder: an `opaque`, or a definition built over one, marked `@[placeholder]` (`GLCinLean/Placeholder.lean`); its doc comment follows "Writing". Placeholders live only in the statement, never in the library or in code meant for Tau Ceti: library code must be real mathematics, or a gap would hide below the statement. One is replaced only when every node below it is proved and none of them is a placeholder (`lake exe tracker show <id>`), and together with the examples of the plan that rule out a trivial reading.
- A checker checks every new or changed definition, planned or helper, with `prompts/check.md`. A *mismatch* or *unsure* verdict is handled as "Small and big changes" says.

## Builds

- Set `LAKE_CONFIG=.lake-config/lake-config.toml` and `LAKE_CACHE_DIR=.lake/cache`. Fetch the caches before building: `lake exe cache get`, then `lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti` (no `--mappings-only`; retry on failure).
- The first build of a checkout may print `Built TauCeti.…` lines: when the pin has no published cache of its own, Tau Ceti's cache falls back to an older commit, and Lake rebuilds the difference. This is expected. A `Built Mathlib.…` line means the Mathlib cache was not fetched: run `lake exe cache get` again.
- A new git worktree builds in under a minute when it uses the dependencies of the main checkout: run `git submodule update --init`, link `.lake/packages` and `tools/tracker/.lake` to the same folders of the main checkout (`ln -s`), and set `LAKE_CACHE_DIR` to the main checkout's `.lake/cache`. It then rebuilds no module of Mathlib or Tau Ceti.
- The done check passes when `lake build` and `lake lint` pass, and `lake env lean tools/check-statement-axioms.lean`, which lists every declaration of the statement, shows `sorryAx` only for the main theorem, and for it only `propext`, `Classical.choice`, `Quot.sound` and `sorryAx`.
- At the start of each session, check Tau Ceti's tags (`git ls-remote --tags https://github.com/TauCetiProject/TauCeti`) and the `lean-toolchain` of its `main`.
- A session may move the Tau Ceti pin forward, to a newer `main` commit or tag, when the done check passes there. Prefer a tag: Tau Ceti's tag promises a full published cache. Mathlib moves to the commit that Tau Ceti names. The pin move is a commit of its own. After it, `python3 tools/check-upstream-names.py` shows the upstream declarations that the plan names and that are no longer in their module: the session corrects a name whose module only moved, and gives a declaration whose statement changed to a planner.
- The Lean toolchain follows Tau Ceti's `main`, also onto a release candidate of Lean, so that a merged pull request of ours can be used here without a wait for a release. It changes with a pin move: first to Tau Ceti's tag of the new toolchain when that tag exists, and then to later `main` commits as the plan needs them.
- If the tracker or this project fails to build at a new pin, keep the old pin and report the failure in `STATUS.md`.

## Git

- Commit at each important step and push to `main` of `WHY-Op109/GLCinLean`. A big change stays on its branch `proposal/<topic>` until it is agreed, as "Small and big changes" says.
