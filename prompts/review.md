# Review

**Goal.** Check that the work means what the papers say, and that the project still reaches its goal in the simplest way.

The goal: a faithful Lean statement of [GLC1] Conj. 1.6.7 (de Rham, characteristic 0, over any algebraically closed field), with every object it uses fully defined, built on Mathlib and Tau Ceti; the proof comes later. The formalisation stays as simple as possible: simple tools, and a workflow that runs on prompts.

A fresh agent runs "Check new work" for each change of a work session (`prompts/work.md`, step 5). "Audit" is a session of its own.

## Check new work

**Scope.** The Lean declarations that the calling session names, including upstream declarations that replace plan nodes. If it names none, the declarations that changed since the last reviewed commit, which `STATUS.md` names. Three kinds are checked: definitions (planned ones and helpers), the statement of the main theorem, and theorems that serve as evidence for a definition (examples, characterisations, independence of a choice). Plan text is not reviewed on its own: it is corrected when the work reaches it.

**Done when**
- the change is checked against each rule of "Sources of code" and "Lean code" in `AGENTS.md`, and each breach is listed with its line;
- each item in scope has a verdict: *agree*, *same object, different presentation*, *mismatch* or *unsure*, with the exact lines of the Lean code and of the paper;
- each verdict rests on a blind reading (below);
- after the blind reading, each doc comment in scope is checked against "Writing" in `AGENTS.md`: it matches the Lean code exactly, and each difference from the paper is recorded;
- each definition in scope that is not an `opaque` has the "hack answer" test: is there a degenerate case (the zero category, an empty type, a trivial group) that satisfies it and makes the main theorem empty or easy? Do its examples rule that case out?
- the report lists every *mismatch* and *unsure* at the top. If there is one, or if the change needs the owner's approval (`AGENTS.md`, "Changing the plan"), the report is saved as `notes/reviews/<short commit>.md` and goes to the owner with the change. Otherwise its summary goes into the commit message, and no file is kept. The reviewer writes only the report; the calling session commits it.

**Blind reading.** A separate fresh agent gets only the Lean text of the items in scope, without docstrings, inside its instructions. It opens no file of the repository or the papers, so it cannot see the docstrings or the plan. For a definition below them that is from Mathlib or Tau Ceti, or that was reviewed and has not changed since, it gets the signature and the docstring, and also the body when these do not settle the meaning. It writes in plain mathematics what each object is, its hypotheses and quantifiers, and which parts are placeholders. The reviewer then compares this reading with the paper's TeX, not with the names. If the reviewer cannot start an agent, the calling session starts the blind reader and passes its reading to the reviewer.

The plan gives each object's place in the papers (its `source` field), `lake exe tracker show` lists what a definition depends on, and `docs/papers.md` says where the papers' TeX is.

## Audit

**When.** The owner asks for one; before the first placeholder is replaced; when a Tau Ceti roadmap that owns plan nodes is merged, changed or replaced; and otherwise after about ten work sessions. The last audit is the commit that `STATUS.md` names.

**Done when**
- `docs/blueprint-providers.md` is brought up to date in place, with only the current state: what merged in Tau Ceti and what changed in its roadmaps since its snapshot, and each open pull request that supplies a plan node, competes with one, or changes who owns it;
- a report in `notes/audit-<date>.md` answers each question below, with reasons and exact references, ranks its findings by their effect on the goal, and ends with a table of decisions for the owner:
  1. Is the statement still faithful to the paper, also after the placeholders replaced since the last audit?
  2. Does the plan still reach a fully defined statement? Which nodes are wrong, missing, held, or more than the statement needs? Judge the plan as a whole and the nodes near the work; do not polish nodes that no ready work needs.
  3. Is there now a simpler faithful formulation or route, and what would it save?
  4. Which rule, prompt or tool got in the way, and what simpler one would do? Files that are no longer needed and a long `STATUS.md` are for `prompts/clean.md`, which the owner can run as a separate session; the report only names them.
  5. For each roadmap candidate in `docs/blueprint-providers.md`, "Roadmap candidates (deferred)": do all four triggers now hold? Update its column "State", and put each candidate whose triggers all hold to the owner.
- every question for the owner is under "Waiting for the owner" in `STATUS.md`;
- the session writes only `docs/blueprint-providers.md`, its report and `STATUS.md`. It deletes no file without the owner's approval. It only reads upstream: it opens no pull request, issue or comment, and moves no pin;
- the work is committed and pushed, and `STATUS.md` names the audit's commit. Once the owner's decisions are applied, the report is closed, and `prompts/clean.md` removes it.

`lake exe tracker status`, `show` and `graph` read the plan.
