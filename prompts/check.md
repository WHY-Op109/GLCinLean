# Check

**Goal.** Judge independently whether one change means what the papers say and follows `AGENTS.md`. Return only the report.

**Scope.** The commit or branch that the session names. In it: new or changed definitions (planned ones and helpers), the statement of the main theorem, theorems that serve as evidence for a definition (examples, characterisations, independence of a choice), upstream declarations that replace plan nodes, and changed plan nodes.

**Done when** the report has, with the exact lines of the Lean code or the plan node and of the paper:
- every *mismatch* and *unsure* at the top;
- each breach of "Sources of code", "Lean code" and "Writing" in `AGENTS.md`;
- a verdict for each item: *agree*, *same object, different presentation*, *mismatch* or *unsure*;
- for each Lean item, a verdict that rests on a blind reading (below), and then a check that its doc comment matches the code;
- for each definition that is not an `opaque`: whether a degenerate case (the zero category, an empty type, a trivial group) satisfies it and makes the main theorem empty or easy, and which example rules that case out.

**Blind reading.** A blind reader gets only the Lean text of the items, without doc comments, inside its instructions, and opens no file. For a definition below them that is from Mathlib or Tau Ceti, or that was checked and has not changed, it gets the signature and the doc comment, and the body when these do not settle the meaning. It writes in plain mathematics what each object is, its hypotheses and quantifiers, and which parts are placeholders. Compare this reading with the paper's TeX. If you cannot start a blind reader, the session starts it and passes you its reading.

**Sources.** The `source` field of each plan node, `lake exe tracker show`, and `docs/papers.md`.

**The report.** The session commits it as `notes/checks/<short commit>.md` when it has a *mismatch* or *unsure*, or when the change is big. Otherwise it puts the summary in its commit message.
