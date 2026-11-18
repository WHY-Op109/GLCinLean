# Audit

**Goal.** Judge whether the statement, the plan and the workflow still reach the project's goal (the first paragraph of `AGENTS.md`) in the simplest way: every object the statement uses fully defined, built on Mathlib and Tau Ceti, with simple tools and a workflow that runs on prompts.

**Done when**
- Tau Ceti and its roadmaps are compared with the plan, from the last compared commit to the pin. `docs/blueprint-providers.md` names the last compared commit. That file then records, in place, the current providers, each open pull request that supplies a plan node, competes with one, or changes who owns it, and the new last compared commit;
- a report in `notes/audit-<date>.md` answers each question below, with reasons and exact references, ranks its findings by their effect on the goal, and ends with a table of decisions for the owner:
  1. Is the statement still faithful to the paper, also after the placeholders replaced since the last audit?
  2. Does the plan still reach a fully defined statement? Which nodes are wrong, missing, held, or more than the statement needs? Judge the plan as a whole and the nodes near the work.
  3. Is there now a simpler faithful formulation or route, and what would it save?
  4. Which rule, prompt or tool got in the way, and what simpler one would do? Name the files that are no longer needed and any part of `STATUS.md` that is too long; the owner may then start a cleanup session (`prompts/clean.md`).
  5. For each roadmap candidate in `docs/blueprint-providers.md`, "Roadmap candidates (deferred)": do all four triggers now hold? Update its column "State", and put each candidate whose triggers all hold to the owner.
- every question for the owner is under "Waiting for the owner" in `STATUS.md`;
- the session writes only `docs/blueprint-providers.md`, its report and `STATUS.md`. It only reads upstream: it opens no pull request, issue or comment, and moves no pin;
- the work is committed and pushed, and `STATUS.md` names the audit's commit. Once the owner's decisions are applied, the report is closed, and `prompts/clean.md` removes it.

The last audit is the commit that `STATUS.md` names. `lake exe tracker status`, `show` and `graph` read the plan.
