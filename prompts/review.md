# Review

**Goal.** Check that the Lean definitions mean what the papers say. It is run by an agent that did not write the code: a fresh session, or a subagent that another session starts. It only reads the Lean files, and writes a report.

**Done when**
- each item in scope has a verdict: *agree*, *same object, different presentation*, *mismatch* or *unsure*, with the exact lines of the Lean code and of the paper. The scope is what the calling session names, from these kinds: definitions (planned ones and helpers), the statement of the main theorem, and the statements of theorems that serve as evidence for a definition (examples, characterisations, independence of a choice). If the session names nothing, the scope is the items of these kinds that changed since the last reviewed commit, which `STATUS.md` names;
- each verdict rests on a blind reading: a subagent given only the Lean text of the items in scope, without docstrings (no paper, no plan), writes in plain mathematics what each object is, its hypotheses and quantifiers, and which parts are placeholders. For a definition below them that was reviewed and has not changed since, or that is from Mathlib or Tau Ceti, it gets the signature and the docstring; it gets the body as well when these do not settle the meaning. The comparison is then with the paper's TeX, not with the name. The Lean text is passed inside the subagent's instructions, and the subagent opens no file of the repository or the papers: a subagent here loads `AGENTS.md`, which already names the statement;
- each definition in scope that is not an `opaque` has the "hack answer" test: is there a degenerate case (the zero category, an empty type, a trivial group) that satisfies it and makes the main theorem empty or easy? Do the examples given with it rule that case out?
- the report is in `notes/reviews/<short commit>.md`, with the commit reviewed and every *mismatch* and *unsure* listed at the top for the owner;
- a review session commits and pushes its report, and `STATUS.md` names the commit reviewed. A review subagent only writes the report; the session that started it commits it with the change.

**Context**
- The plan in `plans/` gives each object's locator in the papers (its `source` field), and `lake exe tracker show` lists what a definition depends on. `docs/papers.md` says where the papers' TeX is and how to fetch a missing paper.
