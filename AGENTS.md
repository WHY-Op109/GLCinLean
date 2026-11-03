# GLCinLean

GLCinLean: a Lean formalisation of the geometric Langlands conjecture: first the statement (GLC I, arXiv 2405.03599, Conjecture 1.6.7), then the proof. So far this repository holds only the planning; the Lean code will be added here.

- `plans/2026-11-design-discussion-log.md` holds the settled decisions (D…); they override `plans/2026-11-02-design-brainstorm.md` and the reports. `private/` (git-ignored) is a clone of the private repository `GLCinLeanPrivate`: `archive/` holds superseded material kept as evidence; scout reports and permissions go there too.
- Tag claims [R] inspected directly, [S] a source's claim about itself, [E] estimate, [J] judgement, and give sources with the date checked. The owner cannot check the mathematics independently and relies on these tags.
- Every external file saved here starts with a provenance header: source, URL pinned to a commit or version, retrieval date, licence. Link to unlicensed material instead of copying it.
- The five GLC papers (PDF, LaTeX) are never committed to any repository (D6).
- Prefer `lake exe cache get` to building Mathlib from source.
