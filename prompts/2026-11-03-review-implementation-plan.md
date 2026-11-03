**Goal:** review the drafted implementation plan, `plans/<date>-implementation-plan.md` (the newest one), before any implementation starts on the Mac mini.

**How to review:** Before acting, figure out what I really want to achieve, not just the approach I described. If my plan looks like a detour, first point out the more fundamental approach and ask me whether I have the conditions for it. If I confirm I don't have the conditions or insist on the original plan, then carry out the original plan carefully. A plan that eliminates steps takes priority over a plan that automates cumbersome steps.

**What I want to achieve (D30 in the log):** first, a faithful Lean statement of the de Rham geometric Langlands conjecture (GLC I, arXiv 2405.03599v3, Conj. 1.6.7: $\mathbb L_G$ is an equivalence), with every definition in it real; then the full proof of GLC I–V. I cannot check the mathematics myself, so the plan's evidence for fidelity is what I rely on.

**Context:**
- `plans/2026-11-design-discussion-log.md` holds my decisions D1–D35; they override the brainstorm. The plan was written from it by `prompts/2026-11-02-synthesise-feasible-plan.md`. Where the plan departs from a decision, or a decision itself looks like a detour, say so.
- Implementation runs 24/7 on a base Mac mini M4 that starts from a fresh clone of this repository and has no memory of earlier sessions; `private/archive/` exists only on this Mac.
- Open points the plan should address, or leave clearly to me:
  - where the escalation queue, scout reports and the record of the bridgekat author's permission live, now that there is no private repository (B6.4, B7.4, C1);
  - whether the plan ends in a ready-to-run start prompt for the Mac mini or only in first steps;
  - that `AGENTS.md` carries the no-outward-signals rule (D2) before the loop starts, since it is also the loop's `AGENTS.md`.
