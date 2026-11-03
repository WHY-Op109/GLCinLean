**Goal:** combine all the ideas so far into one feasible, concrete plan for the automated GLCinLean formalisation workflow. Base its feasibility on testing, searching and checking current sources, not on assumption.

**Done when:** `plans/<date>-implementation-plan.md` exists, is committed, and states the following. Use the date you write it.
- the chosen design and its components;
- the build order, with first concrete steps, following the goal order of D30;
- for each component, what was tested or checked, the result and the date;
- the risks, costs and dependencies;
- what remains undecided and needs my input;
- as its last section, a ready-to-run prompt for the first implementation session (D36).

**How to plan:** Before acting, figure out what I really want to achieve, not just the approach I described. If my plan looks like a detour, first point out the more fundamental approach and ask me whether I have the conditions for it. If I confirm I don't have the conditions or insist on the original plan, then carry out the original plan carefully. A plan that eliminates steps takes priority over a plan that automates cumbersome steps.

**Inputs, in priority order:**
1. `plans/2026-11-design-discussion-log.md`. The design discussion is finished; my decisions there override everything else.
2. `plans/2026-11-02-design-brainstorm.md`.
3. `reports/`. The 2 Nov recheck supersedes the archived October reports where they conflict.
4. `references/`.
5. `private/archive/`: the superseded October reports and AI assessments, including the project structure proposal. `private/` is a clone of the private repository `GLCinLeanPrivate` (D37); if it is missing, clone it there first.

If my decisions conflict with each other or with the evidence, point it out rather than silently choosing.

**Context:** this session runs on the base Mac mini M4 that will run the implementation 24/7 (D4, D20, D36). Measure this machine and propose the machine-specific settings (V8). The review, key-definition and blueprint system is to be reusable by other projects and may later move to its own repository (D35), so the plan keeps it separate from GLC-specific content. `AGENTS.md` will also be the loop's instructions, so the plan says what it must gain before the loop starts.

**Feasibility checks:** test and search where it matters, starting with the open items V1–V9 in the log. Examples:
- whether a Lake project can depend on the current Tau Ceti release tag and build;
- what doc-gen4 or Lean metaprogramming offers for build-derived status, fingerprints and the transitive impact list;
- realistic costs of the scheduled loops;
- whether any upstream state the plan relies on has changed since 3 Nov (Tau Ceti moves about 800 merges a day; read its commit log and code, not its STATUS files).

Put experiments in a scratch directory. Prefer `lake exe cache get` to building Mathlib from source.
