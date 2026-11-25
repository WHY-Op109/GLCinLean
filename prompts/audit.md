# Audit

**Goal.** Judge whether the statement, the plan and the workflow still reach the project's goal (the first paragraph of `AGENTS.md`) in the simplest way.

**Done when**
- Tau Ceti and its roadmaps are compared with the plan, from the last compared commit to the pin, and `docs/blueprint-providers.md` records the result in place: the current providers, each open pull request that supplies a plan node, competes with one or changes its owner, and the new last compared commit;
- the report `notes/audit-<date>.md` answers the five questions below with reasons and exact references, ranks its findings by their effect on the goal, and marks each finding as a small or a big change ("Small and big changes" in `AGENTS.md`);
- `STATUS.md` names the audit's commit, and the work is committed and pushed.

**Questions**
1. Is the statement still faithful to the paper, also after the placeholders replaced since the last audit?
2. Does the plan still reach a fully defined statement? Which nodes are wrong, missing, held, or more than the statement needs?
3. Is there a simpler faithful formulation or route, and what would it save?
4. Which rule, prompt or tool got in the way, and what simpler one would do? Which files and which parts of `STATUS.md` are no longer needed?
5. For each roadmap candidate in `docs/blueprint-providers.md`, "Roadmap candidates (deferred)": do all four triggers hold? Update its column "State", and put a candidate whose triggers all hold under "Waiting for the owner" in `STATUS.md`.

**Sources.** Tau Ceti takes pull requests on GitHub and on its Forgejo site (`git.taucetiproject.org`); both land on the same `main`, so read the open pull requests of both. For the files that a range of Tau Ceti's history added, deleted or renamed, clone Tau Ceti without file contents into a scratch folder (`git clone --filter=blob:none --no-checkout`) and use `git log --name-status` there: the checkout under `.lake/packages` has no history.
