# Review

**Goal.** Check that the Lean definitions mean what the papers say, and that the code meets the
standards in `AGENTS.md`. The owner cannot check the mathematics, so this review is the evidence.
It is run by an agent that did not write the code: a fresh session, or a subagent that the plan
or build session starts. It only reads the Lean files, and writes a report.

**Done when**
- each definition in scope has a verdict: *agree*, *same object, different presentation*,
  *mismatch* or *unsure*, with the exact lines of the Lean code and of the paper. The scope is
  what the calling session names; if it names nothing, the definitions the statement uses that
  changed since the newest report in `notes/reviews/` (all of them if there is none);
- each verdict rests on a blind reading: a subagent given only the Lean text of the definition
  and of the definitions it uses (no paper, no docstrings, no blueprint) writes in plain
  mathematics what the object is, its hypotheses and quantifiers, and which parts are
  placeholders; the comparison is then with the paper's TeX, not with the name;
- each placeholder in scope has the "hack answer" test: would a trivial choice (the zero
  category, the empty type) make the main theorem easy?
- the report is in `notes/reviews/YYYY-MM-DD.md`, with the commit reviewed and every *mismatch*
  and *unsure* listed at the top for the owner;
- the report is committed and pushed. When the review runs on its own, `STATUS.md` notes it.

**Context**
- `blueprint.md` gives each object's locator in the papers; the TeX is in the git-ignored
  `references/papers/<id>v<version>/src/`, with versions in `docs/references.bib`.
- Code standards: Mathlib's style, naming and documentation pages linked in `AGENTS.md`, and Tau
  Ceti Review's rubrics (https://github.com/TauCetiProject/TauCetiReview) for reuse of Mathlib and
  no duplication.
