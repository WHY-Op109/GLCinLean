**Goal:** combine all the ideas so far into one feasible, concrete plan for the automated GLCinLean formalisation workflow. Base its feasibility on testing, searching and checking current sources, not on assumption.

**Done when:** `plans/<date>-implementation-plan.md` exists, is committed, and states the following. Use the date you write it.
- the chosen design and its components;
- the build order, with first concrete steps, following the goal order of D30;
- for each component, what was tested or checked, the result and the date;
- the risks, costs and dependencies;
- what remains undecided and needs my input.

**Inputs, in priority order:**
1. `plans/2026-11-design-discussion-log.md`. The design discussion is finished; my decisions there override everything else.
2. `plans/2026-11-02-design-brainstorm.md`.
3. `reports/`. The 2 Nov recheck supersedes the archived October reports where they conflict.
4. `references/`.
5. `private/archive/` (git-ignored, local to this Mac): the superseded October reports and AI assessments, including the project structure proposal.

If my decisions conflict with each other or with the evidence, point it out rather than silently choosing.

**Context:** the plan is written on the discussion Mac. All implementation then runs 24/7 on a base Mac mini M4 that clones this repository (D4, D20). Machine-specific settings are decided there at setup (V8), so the plan says what to measure on the Mac mini rather than fixing values. The review, key-definition and blueprint system is to be reusable by other projects and may later move to its own repository (D35), so the plan keeps it separate from GLC-specific content.

**Feasibility checks:** test and search where it matters, starting with the open items V1–V8 in the log. Examples:
- whether a Lake project can depend on the current Tau Ceti release tag and build;
- what doc-gen4 or Lean metaprogramming offers for build-derived status, fingerprints and the transitive impact list;
- realistic costs of the scheduled loops;
- whether any upstream state the plan relies on has changed since 3 Nov (Tau Ceti moves about 800 merges a day; read its commit log and code, not its STATUS files).

Put experiments in a scratch directory. Prefer `lake exe cache get` to building Mathlib from source.
