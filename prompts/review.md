# Review

**Goal.** Check, in a fresh session, that the Lean definitions mean what the papers say, and that
the code meets the standards in `AGENTS.md`. The owner cannot check the mathematics, so this
review is the evidence. It only reads the Lean files, and writes a report.

**Done when**
- each definition in scope (those the statement uses that changed since the newest report in
  `notes/reviews/`, or all of them if there is none) has a verdict: *agree*, *same object,
  different presentation*, *mismatch* or *unsure*, with the exact lines of the Lean code and of
  the paper;
- each verdict rests on a blind reading: a subagent given only the Lean text of the definition
  and of the definitions it uses (no paper, no docstrings, no blueprint) writes in plain
  mathematics what the object is, its hypotheses and quantifiers, and which parts are
  placeholders; the comparison is then with the paper's TeX, not with the name;
- each placeholder in scope has the "hack answer" test: would a trivial choice (the zero
  category, the empty type) make the main theorem easy?
- the report is in `notes/reviews/YYYY-MM-DD.md`, with every *mismatch* and *unsure* listed at the
  top for the owner and the commit reviewed;
- the prompt for the next step has been checked and updated if needed, and the work is committed
  and pushed.

**Context**
- `blueprint.md` gives each object's locator in the papers; the TeX is in the git-ignored
  `references/papers/<id>v<version>/src/`, with versions in `docs/references.bib`.
- Code standards: Mathlib's style, naming and documentation pages linked in `AGENTS.md`, and Tau
  Ceti Review's rubrics (https://github.com/TauCetiProject/TauCetiReview) for reuse of Mathlib and
  no duplication.
