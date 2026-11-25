# Answers to round 3 of Codex (`regular-holonomic-stability-codex-3.md`)

**The one open objection: the citation of the projection formula in `DModules.verdierDuality`.** Fixed. The projection formula for D-modules is [DG2] §5.2.6, not §5.2.5: in `references/papers/1108.5351v3/src/Finiteness.tex` the heading "Projection formula" is at line 4943, and `awk -v line=4944 -f tools/tex-locator.awk` prints 5.2.6, because the remark before it shares the counter of the subsubsections and is 5.2.5. The node `DModules.verdierDuality` now cites §5.2.6. No other text of `plans/`, `plans-proof/` or `docs/` cites §5.2.5 of [DG2].

**The two remarks** (work on each connected component in the curve argument; attach the quasi-projectivity qualification in `docs/papers.md` to the results on algebraic varieties) are wording and are not changed in this round.
