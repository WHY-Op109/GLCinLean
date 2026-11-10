# Next steps

One-off sessions, run in this order, each started fresh with its own prompt: 1, 2, 3a, 3b, 4a, 4b, 4c, 5. Sessions 1 to 4a are done. Each session checks the prompt of the session after it and changes it where its result calls for that. Session 5 deletes this file.

## Session 1: clean-up

Model: Opus 5.5, effort `high`.

**Goal.** Leave the workspace with only what the next sessions need, so that no outdated note, rule or caution steers them.

**Done when**
- the owner has approved a list of what to delete or shorten, and it is done: review reports and working notes in `notes/` whose findings are resolved (git history keeps them); `STATUS.md` cut to the current state and the open decisions; empty or stray folders such as `.claude/worktrees/`; stray worktrees and branches; build outputs of deleted files;
- `AGENTS.md`, the prompts and the memory files keep no rule or caution whose reason no longer holds, and each absolute rule that stays says its scope and reason;
- the superseded-field warnings of `lake exe tracker lint` are settled with the owner: removed, or kept with the reason written once;
- `lake build` passes and `lake exe tracker lint` has no errors;
- the next session's prompt in `prompts/next-steps.md` is checked against this session's result and changed where it no longer fits;
- the work is committed and pushed.

**Context**
- Nothing is deleted before the owner approves the list. `.lake/` (the build cache); material that is still unresolved stays, however old.

## Session 2: upstream check

Model: Opus 5.5, effort `high`.

**Goal.** Find what has changed outside this project that could supply, replace or block a node of the plan in `plans/`.

**Done when**
- for Tau Ceti `main` and the Tau Ceti roadmap: what has merged, and which roadmap items were added, accepted or changed, since the snapshots recorded in `docs/blueprint-providers.md`;
- every open pull request in Tau Ceti and TauCetiRoadmap that touches a plan node is listed with its head commit and its effect: it supplies a node, competes with one, or changes who owns it;
- AxiomMath Stacks (https://github.com/AxiomMath/Stacks) and Weil (https://github.com/AxiomMath/Weil) are checked for declarations that Mathlib and Tau Ceti lack and that a plan node could use, each with its Lean version gap, its `sorry`s, its licence and its porting cost;
- the findings are in one note, `notes/upstream-<date>.md`, each with the plan nodes it affects;
- the next session's prompt in `prompts/next-steps.md` is checked against this session's result and changed where it no longer fits;
- the work is committed and pushed.

**Context**
- This session only reads upstream: it opens no pull request, issue or comment, and moves no pin.
- This project's Lean version is in `lean-toolchain`, and its Tau Ceti commit is in `lake-manifest.json`.

## Session 3a: review of the goal and the blueprint

Model: Fable 5.2, effort `high`.

**Goal.** Judge whether the statement and the plan reach the owner's goal faithfully and in the simplest way, and challenge the current approach wherever a better one exists.

The owner's goal: a faithful Lean statement of [GLC1] Conj. 1.6.7 (de Rham, characteristic 0, over any algebraically closed field), with every object it uses fully defined, built on Mathlib and Tau Ceti; the proof comes later. The owner wants the formalisation as simple as possible: simple tools, and a workflow that runs on prompts.

**Done when**
- a report in `notes/review-goal.md` answers each question below, with reasons and exact references to the papers and the code, and ranks its findings by their effect on the goal:
  - is the statement in `GLCinLean/Statement/` faithful to [GLC1] Conj. 1.6.7, including its hypotheses and the characterisation of `𝕃_G`?
  - does the plan in `plans/` reach a fully defined statement? Is any part missing, wrong, or more than the statement needs?
  - is there a simpler or more direct faithful formulation or route, and what would it save?
  - is the tracker the right way to hold the plan?
  - which suggestions in §7 of the newest `notes/upstream-*.md` should change the plan (providers, owners, locators), and is code from AxiomMath Stacks or Weil worth porting into Tau Ceti as prior art?
- nothing else in the repository changes, apart from the next session's prompt;
- the next session's prompt in `prompts/next-steps.md` is checked against this session's result and changed where it no longer fits;
- the work is committed and pushed.

**Context**
- The papers are listed in `docs/papers.md`, and their TeX is in `references/papers/`. The upstream state is in the newest `notes/upstream-*.md`; it supplements the provider record in `docs/blueprint-providers.md`. Open roadmap pull requests change quickly: before a finding rests on one, check its state and head commit again.
- `lake exe tracker status`, `show` and `graph` read the plan; see `tools/tracker/README.md`.

## Session 3b: review of the workflow

Model: Fable 5.2, effort `high`.

**Goal.** Judge whether the rules and prompts can carry the project to the owner's goal, and propose simpler ones wherever they get in the way.

The owner's goal: a faithful Lean statement of [GLC1] Conj. 1.6.7 (de Rham, characteristic 0, over any algebraically closed field), with every object it uses fully defined, built on Mathlib and Tau Ceti; the proof comes later. The owner wants the formalisation as simple as possible: simple tools, and a workflow that runs on prompts.

**Done when**
- a report in `notes/review-workflow.md` answers each question below, with reasons, the exact lines, and the proposed text or change:
  - would `prompts/build.md` work from the current state of the project, and what must change?
  - which rules in `AGENTS.md` and the prompts are too forced, unclear, or in conflict with each other or with the tracker?
  - should `prompts/review.md` also check the coding standards of `AGENTS.md` in the same report, or is review better split into several prompts? Is a separate prompt for a periodic review of the whole project against the goal worth having?
  - would rebuilding or simplifying the project, its prompts or its tools serve the goal better?
- nothing else in the repository changes, apart from the next session's prompt;
- the next session's prompt in `prompts/next-steps.md` is checked against this session's result and changed where it no longer fits;
- the work is committed and pushed.

**Context**
- The goal review is in `notes/review-goal.md`. Its decisions 1 to 3 propose another form of the statement's second property, which would move about half of the plan from the statement to the proof. The owner has not decided them: judge `prompts/build.md` and the rules for both outcomes.
- Its Finding 2 and its answer to question 4 already propose changes to `prompts/build.md` and to how the plan uses the tracker (the first work is Tau Ceti Worker rounds on the ∞-category roadmaps; upstream leaves as plan nodes; placeholders counted as proved; provider text in each `desc`). Take them as input, and do not repeat them.

## The owner's decisions, 2026-11-10

Three reports led to these decisions: `notes/review-goal.md` (decisions 1 to 10), `notes/review-workflow.md` (W1 to W12) and the independent opinion `notes/review-independent-2026-11-10.md`. The owner accepted every finding, with the amendments below. Where the reports differ, the text below rules.

**Statement** (Session 4b)
- **1.** Restate the second property with the Hecke action of `Rep(Ǧ)_Ran`: one equivalence `Maps_D(V ⋆ P, M) ≃ Maps_Q(Loc V, Ψ(F M))` of mapping-space functors, natural in `V` and `M` together. The docstring says that this form equals the paper's form by [GLC1] Thm. 1.2.4. That comparison becomes a planned theorem of the proof.
- **2.** The functors are continuous, `k`-linear and enhanced, but not `QCoh(LS_Ǧ)`-linear, and the t-structure stays. The linear placeholders go. The monoidal and module constructions that the library still needs stay in the plan.
- **10.** The module docstring says that `IsAlgClosed` is the owner's scope, not a hypothesis of [GLC1].

**Plan**
- **3.** Only after the owner approves the statement: compute the cut from the approved statement, and keep what the examples and comparison results need. Move the nodes that only the spectral action needs to `plans-proof/`, a folder that the tracker does not read. The figure of 174 remaining nodes is an estimate.
- **4.** `STATUS.md` names the concrete upstream targets that block the plan, including BordismFormalGroups F6.5, to which EnhancedDerivedSheaves delegates.
- **5.** Delete `plans/Mathlib` and `plans/TauCeti`, and update every dependency on them. The node that uses an upstream declaration names that declaration and its import module in its `desc`. A `desc` keeps only "Provider: here" or "Provider: roadmap ⟨area⟩ ⟨target⟩", with no layer numbers and no commits. The one snapshot is in `docs/blueprint-providers.md`. This also settles the ReductiveGroups locators that roadmap #1676 (merged 2026-11-10) changed.
- **6.** Ask the tracker's author for a separate placeholder state, not `stated`. It is not a prerequisite. The session drafts the request in `STATUS.md`, and the owner sends it.
- **7.** `QCohLS` depends on `Sheaves.qcoh` on `LocalSystems.deRham` with its monoidal structure, not on rigidity. Correct the providers of `Sheaves.determinant` (PadicMeasuresIwasawaAlgebras §5.1, AlgebraicVectorBundles L0C) and of `Hecke.schubertStratum_deRhamCohomology_even` (SchubertGeometry, and FlagVarieties for the cells). Do not narrow the scope of `Sheaves.determinant` yet. It has two users, `Stacks.determinantBundle` and `Satake.criticalDeterminantGerbe`, and it is narrowed only after both are checked.
- **8.** Record #1734, #1687 and #848 in `docs/blueprint-providers.md` as owner candidates, with the limits that `notes/review-goal.md` gives. Their nodes go on the "Held" list.
- **9.** AxiomMath Stacks and Weil are prior art for Worker ports, case by case. No port now.

**Workflow**
- **W1.** The owner runs the Tau Ceti Worker. A session here does not start it; it folds in the Worker's results. `STATUS.md` holds the command lines.
- **W2.** Replace `prompts/build.md` by the text in §1.5 of `notes/review-workflow.md`, with three changes. The unit of work is one ready module, or a bounded part of a large one. The Worker's brief comes from a specific module or node, because `tracker show` prints a module's own nodes and not those of the modules under it. The approval line follows W4.
- **W3.** Move the roadmap-owned nodes to `plans/Roadmap/<area>/`, with their ids unchanged, after a trial on one area. A node that lands upstream is deleted only when its declaration is at this project's pin, its interface is checked, and a fresh agent has reviewed its meaning with `prompts/review.md`. The nodes that use it are updated in the same commit.
- **W4.** Replace `AGENTS.md:47` and the second sentence of `AGENTS.md:58` with this rule:
  - a fresh agent reviews every new or changed definition, planned or helper, with `prompts/review.md`;
  - a *mismatch* or *unsure* verdict goes to the owner;
  - a change to `GLCinLean/Statement/` needs the owner's approval;
  - a change to a definition that the main theorem already depends on in Lean also needs it, unless the review finds its meaning unchanged;
  - a change that waits for approval is on a branch `proposal/<topic>`, and `STATUS.md` on `main` names the branch.
- **W5.** Keep `prompts/review.md` for meaning only, with the five changes of §2.3 of `notes/review-workflow.md`. Its scope is the definitions (planned and helpers), the statement of the main theorem, and the statements of theorems that serve as evidence for a definition (examples, characterisations, independence of a choice). A dependency that was reviewed and has not changed since is read through its signature and docstring.
- **W6.** `prompts/build.md` asks a fresh agent to check the diff against "Sources of code" and "Lean code" in `AGENTS.md`, before the meaning review. `lake lint` joins the done check in `AGENTS.md`.
- **W7.** Add `prompts/audit.md` with the text of §3.3 of `notes/review-workflow.md`. It may write `docs/blueprint-providers.md`, its report and `STATUS.md`. List it in `README.md`.
- **W8.** Change `AGENTS.md:19` as §2.4 says and `AGENTS.md:54` as §2.5 says. Keep `AGENTS.md:14` as it is: proofs are also searched on Tau Ceti `main`, against one snapshot per session.
- **W9.** Keep each caution in one home, as §2.8 says. `STATUS.md` gets a "Held" list, with a reason and a release condition for each entry. Fixed rule text leaves the `desc` of the module plans. Mathematical cautions that define an object stay.
- **W10.** Keep `tools/check-statement-axioms.lean` and `#print axioms`. The tracker is only a second check, because it calls a declaration `stated` even when the declaration also uses a forbidden axiom. A later task replaces the hand-kept list by a script that lists every declaration itself and fails on a bad axiom. `STATUS.md` records this task.
- **W11.** The three open decisions in `STATUS.md` are accepted as written, and they move to "Decisions taken".
- **W12.** Start narrow roadmap scoping now. Check #1687 first, then scope the first general layer that no roadmap covers, for the owner to propose. This is its own session, not part of Session 4. `STATUS.md` records it as a next task.

## Session 4a: workflow and plan changes

Model: Opus 5.5, effort `high`.

**Goal.** Apply the owner's decisions that hold whatever the owner decides on the statement: 4 to 9 and W1 to W11.

**Done when**
- each of these decisions is applied as the section above says;
- the changes to `plans/` are made in this order: the deletion of `plans/Mathlib` and `plans/TauCeti` (5); the move of the roadmap-owned nodes (W3), first for one area and then for the rest; the shorter `desc` texts (5 and W9); the corrections of 7. `lake exe tracker lint` has no errors after each step;
- nothing in `GLCinLean/` changes;
- `STATUS.md` records the decisions, the upstream targets that block the plan, the "Held" list, the Worker command lines, the tracker request of 6, the later tasks of W10 and W12, and that Session 4b comes next;
- the done check in `AGENTS.md` passes;
- the next session's prompt in `prompts/next-steps.md` is checked against this session's result and changed where it no longer fits;
- the work is committed and pushed.

**Context**
- The new `prompts/build.md` of §1.5 assumes decision 1, so it drops "module actions". Keep the line "module actions stay explicit" until Session 4c, because the owner has not yet approved the new statement.
- After the moves, `lake exe tracker ready` should list `Roadmap.…` modules and the few `GLCinLean.…` modules that can start. If it does not, `STATUS.md` says why.
- If the trial of W3 shows a problem, stop the move and report it to the owner.

## Session 4b: the statement

Model: Fable 5.2, effort `high`.

**Goal.** Write the statement of decisions 1, 2 and 10, and put it to the owner.

**Done when**
- the new statement is on a branch `proposal/hecke-form`: decisions 1, 2 and 10 are applied in `GLCinLean/Statement/` and in its plan in `plans/GLCinLean/Statement/`, `tools/check-statement-axioms.lean` lists the new declarations, and the first rule of "The statement" in `AGENTS.md` says that the second property is in its equal form with the Hecke action;
- each new placeholder names the object it stands for, and its plan node has suggested `deps` to the existing plan nodes (for example `Hecke.ranRepresentations`, `Hecke.action`, `Spectral.localization`, `Whittaker.vacuumPoincare`) and a `desc` in the form that `plans/README.md` gives ("Provider: here");
- on the branch, `lake build`, the done check in `AGENTS.md` and `lake exe tracker lint` pass;
- a fresh agent has reviewed the new statement with `prompts/review.md`, and its report is on the branch;
- `STATUS.md` on `main` names the branch and the reviewed commit under "Waiting for the owner";
- the next session's prompt in `prompts/next-steps.md` is checked against this session's result and changed where it no longer fits;
- `main` and the branch are pushed.

**Context**
- The form of the equivalence and the argument for it are in Finding 1 of `notes/review-goal.md` and in decision 1 of `notes/review-independent-2026-11-10.md`. `Loc^R` is continuous only by a theorem, so the property is stated with mapping spaces, not with `Loc^R`.
- The plan is not cut in this session.
- The review report is named `notes/reviews/<short commit>.md`, as `prompts/review.md` says.

## Session 4c: the plan cut

Model: Opus 5.5, effort `high`.

**Goal.** Bring the plan to the statement that the owner decided on, and close the three reports.

**Done when**
- if the owner approved the branch `proposal/hecke-form`: it is merged into `main`; the cut of decision 3 is made, also under `plans/Roadmap/` (a roadmap node that only the proof needs moves to `plans-proof/Roadmap/<area>/`); `plans/README.md` is rewritten where the spectral decomposition is no longer inside the statement's plan; `prompts/build.md` drops "module actions"; and the blocking targets, the Worker command lines and the "Held" list in `STATUS.md` are computed again from the cut plan;
- if the owner declined it: the branch is deleted, and the spectral-action nodes whose written proof is incomplete go on the "Held" list, each with the proof that is missing;
- `lake build`, the done check in `AGENTS.md` and `lake exe tracker lint` pass;
- the three reports in `notes/` are deleted, and `STATUS.md` records what was decided. `notes/upstream-2026-11-10.md` is deleted too if the owner agrees, since `docs/blueprint-providers.md` now holds its findings;
- the next session's prompt in `prompts/next-steps.md` is checked against this session's result and changed where it no longer fits;
- the work is committed and pushed.

**Context**
- The owner's answer on the statement: <fill in before starting>.

## Session 5: dependency-graph page

Model: Opus 5.5, effort `medium`.

**Goal.** Give the owner a web page on which to review the dependency graph of the plan.

**Done when**
- the page is built from the output of `lake exe tracker graph` (JSON, described in `tools/tracker/README.md`) and published as a private Claude Artifact;
- on the page the owner can search for a declaration and see what it depends on and what depends on it, filter by module and by state, see the placeholders, and read each node's description and source;
- no file is added to the repository;
- `prompts/build.md` is checked: if the build step should refresh the page after it changes `plans/`, it says so in one line;
- `prompts/next-steps.md` is deleted, because the one-off sessions are done;
- the work is committed and pushed.
