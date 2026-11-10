# Next steps

Six sessions, run in this order, each started fresh with its own prompt: 1, 2, 3a, 3b, 4, 5. Each session checks the prompt of the session after it and changes it where its result calls for that. Session 5 deletes this file.

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
- The prompts run on Claude Fable 5.2. Its prompting guide is https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-fable-5-2.
- The goal review is in `notes/review-goal.md`.

## Session 4: changes

Model: Opus 5.5 or Fable 5.2, effort `high`.

**Goal.** Apply the findings of `notes/review-goal.md` and `notes/review-workflow.md` that the owner approved.

**Done when**
- each approved finding is applied, and the other findings are left as they are;
- a change to the statement, or to a definition it reaches, is reviewed by a fresh agent with `prompts/review.md`, then put to the owner with the review, and is not pushed until the owner approves it;
- `lake build`, the done check in `AGENTS.md` and `lake exe tracker lint` pass;
- once every finding is applied or declined, the two reports are deleted, and `STATUS.md` records what was decided;
- the next session's prompt in `prompts/next-steps.md` is checked against this session's result and changed where it no longer fits;
- the work is committed and pushed.

**Context**
- The owner's decision on each finding: <fill in before starting>.

## Session 5: dependency-graph page

Model: Opus 5.5, effort `medium`.

**Goal.** Give the owner a web page on which to review the dependency graph of the plan.

**Done when**
- the page is built from the output of `lake exe tracker graph` (JSON, described in `tools/tracker/README.md`) and published as a private Claude Artifact;
- on the page the owner can search for a declaration and see what it depends on and what depends on it, filter by module and by state, see the placeholders, and read each node's description and source;
- no file is added to the repository;
- `prompts/build.md` is checked: if the build step should refresh the page after it changes `plans/`, it says so in one line;
- `prompts/next-steps.md` is deleted, because the six sessions are done;
- the work is committed and pushed.
