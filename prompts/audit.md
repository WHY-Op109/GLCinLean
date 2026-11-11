# Audit

**Goal.** Judge whether the statement, the plan and the workflow still reach the owner's goal faithfully and in the simplest way, after what changed here and upstream since the last audit.

The owner's goal: a faithful Lean statement of [GLC1] Conj. 1.6.7 (de Rham, characteristic 0, over any algebraically closed field), with every object it uses fully defined, built on Mathlib and Tau Ceti; the proof comes later. The owner wants the formalisation as simple as possible: simple tools, and a workflow that runs on prompts.

**Done when**
- `docs/blueprint-providers.md` is brought up to date in place: what merged in Tau Ceti and what changed in the roadmaps since its snapshot, and each open pull request that supplies a plan node, competes with one, or changes who owns it;
- a report in `notes/audit-<date>.md` answers each question below, with reasons and exact references, and ranks its findings by their effect on the goal:
  - is the statement still faithful to the paper, also after the placeholders replaced since the last audit?
  - does the plan still reach a fully defined statement? Which nodes are now wrong, missing, held, or more than the statement needs?
  - is there now a simpler faithful formulation or route, and what would it save?
  - which rule, prompt or tool got in the way since the last audit, and what simpler one would do?
  - for each roadmap candidate in `docs/blueprint-providers.md`, "Roadmap candidates (deferred)", do all four triggers now hold? Update its column "State", and put each candidate whose triggers all hold to the owner;
- the report ends with a table of decisions for the owner;
- the session writes only `docs/blueprint-providers.md`, its report and `STATUS.md`;
- the work is committed and pushed, and `STATUS.md` names the audit's commit.

**Context**
- Run it when a layer of the plan is finished; before the first replacement of a placeholder is put to the owner; when a roadmap that owns plan nodes is merged, amended or replaced; and after ten build sessions with none of these.
- This session only reads upstream: it opens no pull request, issue or comment, and moves no pin.
- The last audit is the commit that `STATUS.md` names. `lake exe tracker status`, `show` and `graph` read the plan.
