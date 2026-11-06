# Fidelity review (run by hand, in goal mode, in a fresh session)

**Goal.** Check that the Lean definitions mean what the papers say. The owner cannot check the
mathematics, so this review is the evidence. Do not edit any Lean file.

1. **Scope.** List the key definitions (entries with `key = true` in `glc/extras.toml`, and the
   declarations of `GLCinLean/Abstract.lean`) changed since the newest file in `fidelity/` (all
   of them if there is none). If none changed, stop.
2. **Blind reading.** For each one, start a subagent that gets ONLY the Lean text of the
   definition and of the definitions it uses: no paper, no doc comments, no plan. It writes, in
   plain mathematics, what the object is, its hypotheses and quantifiers, and which parts are
   placeholders. It must not guess what the name "should" mean.
3. **Comparison.** Now read the source: the paper's LaTeX in `references/papers/` (fetch with
   `scripts/fetch-papers.py`), or the reference the docstring cites. Compare it with the blind
   reading, not with the name. Verdict per definition: *agree*, *same object, different
   presentation*, *mismatch* or *unsure*, with the exact lines of both sides.
4. **Output.** Write `fidelity/YYYY-MM-DD.md`: one section per definition with the blind
   reading, the source lines, the verdict and the commit reviewed; every *mismatch* and *unsure*
   listed at the top for the owner. Commit it.

For a second opinion, the owner may run step 2 with Codex as well.
