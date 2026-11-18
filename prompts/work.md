# Work

**Goal.** Move the formalisation forward: read where the project stands, then write the next piece of the plan in Lean.

**Done when**
- the chosen work is written, checked and reviewed (steps 3–5);
- `STATUS.md` records the current state, the open decisions, and the next work;
- the work is committed and pushed.

**Steps**
1. **Read the status.** Read `STATUS.md` and run `lake exe tracker ready`. Check Tau Ceti's tags and its `main`, as `AGENTS.md` ("Builds") says.
2. **Fold in upstream.** Check each Tau Ceti pull request that `STATUS.md` lists, and whether Tau Ceti merged other work that the plan uses. If so, move the pin as `AGENTS.md` says; if the done check fails at the new pin, keep the old pin and say so in `STATUS.md`. Delete a node of `plans/Roadmap/` only when its declaration is at the pin, its interface is checked, and a fresh agent has checked its meaning with `prompts/check.md`. In the same commit, the nodes that used it name the upstream declaration and its module in their `desc`.
3. **Choose the work**, in this order:
   - the first item of "Next" in `STATUS.md` that a work session can do now, skipping an item that is held, blocked or an audit;
   - if that item is small, the next such item as well;
   - if there is no such item, one ready module under `GLCinLean` other than the main theorem's (`GLCinLean.Statement.Conjecture`), or a few small ones, or a bounded part of a large one; `lake exe tracker show <module>` is its brief;
   - if no module under `GLCinLean` is ready, write in `STATUS.md` which roadmap targets block the plan, and end.

   Leave the nodes under "Held" alone.
4. **Write it.** Follow `AGENTS.md`. Give each new definition examples or test lemmas that show it behaves as expected. Where the code shows that the plan is wrong, correct it as "Changing the plan" in `AGENTS.md` says. Replace a placeholder only when every node below it is proved and none of them is a placeholder (check with `lake exe tracker show <id>`: the tracker counts a placeholder as proved), and only together with the examples of the plan that rule out a trivial reading.
5. **Check it.** The done check of `AGENTS.md` passes, `lake exe tracker lint` has no errors, and `python3 tools/check-module-cycles.py` finds no cycle. Commit the change locally. Then a fresh agent checks that commit with `prompts/check.md`. Fix its findings.
6. **Record and push.** A big change, or a change with an open *mismatch* or *unsure* verdict, goes to the owner as "Changing the plan" in `AGENTS.md` says. Everything else is pushed to `main`, and `STATUS.md` names the last checked commit. Record in "Next" the next task and any audit that is due ("Prompts" in `AGENTS.md`).

**Context**
- `docs/papers.md` says where the papers' TeX is and how to fetch a missing paper.
- The owner runs the Tau Ceti Worker for the nodes of `plans/Roadmap/`, with the command lines in `STATUS.md`. A session here does not start it.
