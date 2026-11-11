# Next steps

One-off sessions, each started fresh with its own prompt. Sessions 1 to 4c are done; their prompts are in git history at `e8e1a6c`. Session 5 is the last one. Each session checks the prompt of the session after it and changes it where its result calls for that. Session 5 deletes this file.

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
- **W12.** Start narrow roadmap scoping now. Check #1687 first, then scope the first general layer that no roadmap covers, for the owner to propose. This is its own session, not part of Session 4. `STATUS.md` records it as a next task. Deferred by the owner on 2026-11-11 (`STATUS.md`, "Decisions taken").

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

**Context**
- `lake exe tracker graph` covers `plans/`, the statement's plan (238 nodes). The tracker does not read `plans-proof/` (197 nodes), whose `deps` point into `plans/`. Show it on the page as a separate layer, read from its TOML files and marked as not tracked, so that the owner can see where the cut runs.
