# Answers to the second reports on `proposal/critical-twist-clauses`

Codex's second report (`notes/checks/critical-twist-clauses-codex-2.md`) has no open blocking objection. The checker's second report (`notes/checks/critical-twist-clauses-check-2.md`) finds M1, M2 and M3 resolved, confirms the correction of the sign sentence, and has one mismatch, N1, and one exact wording for the sign sentence. Both are applied with the checker's wording.

- **N1, the refinement identification** (`plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml`, `Satake.criticalTwistBunDeterminantEquiv`). Before "Prove that the identifications above agree under common refinement" the node now says how the target lines for two subbundles N₂ ⊂ N₁ are identified: by cancelling tensor product on the left by det π_*(N₁/N₂), and that the relative determinant of `Satake.criticalDeterminantGerbe` is formed with these identifications.
- **The sign sentence** (same node). It now names the two contractions: the cancellation is the inverse of the coevaluation; the evaluation after the symmetry is (−1)^d times it and is not used, because it changes sign with n when dim G · deg D is odd. This also makes the quantifier explicit that Codex's improvement asks for.
- **The note for the writers** (section 5 of the proposal): one added sentence for the writer of `Satake.criticalDeterminantGerbe`.

No node, dependency or count changes. `lake exe tracker lint` has no errors, `python3 tools/check-module-cycles.py` finds no cycle, and `python3 tools/check-upstream-names.py` confirms every pair.
