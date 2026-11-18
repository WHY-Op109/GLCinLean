# Check

**Goal.** Check that a change of a work session means what the papers say and follows `AGENTS.md`.

**Scope.** The Lean declarations that the calling session names, including upstream declarations that replace plan nodes. If it names none, the declarations that changed since the last checked commit, which `STATUS.md` names. Three kinds are checked: definitions (planned ones and helpers), the statement of the main theorem, and theorems that serve as evidence for a definition (examples, characterisations, independence of a choice).

**Done when**
- the change is checked against each rule of "Sources of code" and "Lean code" in `AGENTS.md`, and each breach is listed with its line;
- each item in scope has a verdict: *agree*, *same object, different presentation*, *mismatch* or *unsure*, with the exact lines of the Lean code and of the paper;
- each verdict rests on a blind reading (below);
- after the blind reading, each doc comment in scope is checked against "Writing" in `AGENTS.md`: it matches the Lean code exactly, and each difference from the paper is recorded;
- each definition in scope that is not an `opaque` has the degenerate-case check: is there a degenerate case (the zero category, an empty type, a trivial group) that satisfies it and makes the main theorem empty or easy? Do its examples rule that case out?
- the report lists every *mismatch* and *unsure* at the top. The checker writes only the report. The calling session records it before the push. When there is a *mismatch* or *unsure*, or the change needs the owner's decision ("Small and big changes" in `AGENTS.md`), it commits the report as `notes/checks/<short commit>.md`, named after the commit checked, and the report goes to the owner with the change. Otherwise it puts the summary of the report in the message of the commit that updates `STATUS.md`.

**Blind reading.** A separate fresh agent gets only the Lean text of the items in scope, without doc comments, inside its instructions. It opens no file of the repository or the papers, so it cannot see the doc comments or the plan. For a definition below them that is from Mathlib or Tau Ceti, or that was checked and has not changed since, it gets the signature and the doc comment, and also the body when these do not settle the meaning. It writes in plain mathematics what each object is, its hypotheses and quantifiers, and which parts are placeholders. The checker then compares this reading with the paper's TeX, not with the names. If the checker cannot start an agent, the calling session starts the blind reader and passes its reading to the checker.

The plan gives each object's place in the papers (its `source` field), `lake exe tracker show` lists what a definition depends on, and `docs/papers.md` says where the papers' TeX is.
