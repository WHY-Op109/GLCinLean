# Build

**Goal.** Move the plan in `plans/` forward by one module, from the bottom up, until each placeholder of the GLC statement can be replaced by a real definition.

**Done when**
- upstream is folded in first: each Tau Ceti pull request listed in `STATUS.md` is checked. For a merged one, the Tau Ceti pin is moved as `AGENTS.md` says. Its nodes are deleted from `plans/Roadmap/` only when the declaration is at this project's pin, its interface is checked, and a fresh agent has reviewed its meaning with `prompts/review.md`; in the same commit, the nodes that used them name the upstream declaration and its import module in their `desc`;
- one ready module under `GLCinLean` (or a few small ones, or a bounded part of a large one) is written: `lake exe tracker ready` names it, and `lake exe tracker show <module>` is its brief. If no module under `GLCinLean` is ready, the session writes in `STATUS.md` which roadmap targets block the plan, and ends;
- each new definition has examples or test lemmas that show it behaves as expected. A placeholder is replaced only when every node below it is proved (the tracker counts the placeholder itself as proved, so check the nodes its plan entry names in `deps` with `lake exe tracker show <id>`), and with the example nodes of `plans/` that rule out a trivial reading;
- the done check in `AGENTS.md` passes, `lake exe tracker lint` has no errors, and `python3 tools/check-module-cycles.py` finds no cycle among the module plans;
- a fresh agent has checked the diff against each rule of "Sources of code" and "Lean code" in `AGENTS.md`, and its findings are fixed;
- after that, a fresh agent has reviewed every new or changed definition with `prompts/review.md`;
- a change that needs the owner's approval under "The statement" in `AGENTS.md` is committed with its review report on a branch `proposal/<topic>`, and `STATUS.md` on `main` names the branch under "Waiting for the owner". `main` gets the change only after the owner approves it;
- `STATUS.md` is updated and says what the next session takes on (a build, or an audit when a trigger of `prompts/audit.md` holds), and the work is committed and pushed.

**Context**
- The statement is in `GLCinLean/Statement/`. The main theorem says that a characterized functor exists and that every such functor is an equivalence; preserve that shape.
- Nodes under `plans/Roadmap/<area>/` belong to that Tau Ceti roadmap. The owner runs Tau Ceti's Worker for them, with the command lines in `STATUS.md`: `tauceti work --agent claude --roadmap-only <area> --extra-roadmap-prompt "<targets>"`. The targets come from one module or node: `lake exe tracker show Roadmap.<area>.<Module>` or `lake exe tracker show <node id>`, because `show Roadmap.<area>` lists only the modules under it, not their nodes. A session here does not start the Worker.
- A node listed under "Held" in `STATUS.md` is not started.
- When a paper is wrong, mark the planned declaration `wrong` and amend the plan.
- `docs/papers.md` says where the papers' TeX is and how to fetch a missing paper.
