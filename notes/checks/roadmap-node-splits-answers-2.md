# Answers to Codex's second report on `proposal/roadmap-node-splits`

Codex's second report (`notes/checks/roadmap-node-splits-codex-2.md`) finds its five objections of round 1 and the checker's corrections resolved, and has four blocking objections with exact replacements and two improvements that can wait. All four are applied with its wording; the deviations are named.

1. **The check over 𝔽_2 concerns the comparison functor** (`plans/Roadmap/EnhancedDerivedSheaves/AnimatedRings.toml`, `Derived.commutativeAlgebra`). The sentence that began "Over a base that is not a ℚ-algebra" is replaced by: "Outside the ℚ-algebra case the comparison functor can fail to be an equivalence, as the check over 𝔽_2 shows. The plan uses the equivalence over the characteristic-zero ground field."
2. **The affine node and the paper's `Vect_k`** (same file, `Derived.affineScheme`). The sentence that began "That, over a commutative ℚ-algebra" is replaced by Codex's two sentences. One sentence is kept after them, because the old sentence stated it: "This node does not depend on Derived.commutativeAlgebraToConnectiveCommAlg."
3. **`SpectralProof.factorizationVacuum_almostULA` depends on `Groups.RepresentationCategory`** (`plans-proof/GLCinLean/GeometricLanglands/Spectral/DerivedSatake/Construction.toml`). The `deps` line is Codex's. `GLCinLean.Groups.RepresentationCategory` is a node of `plans/GLCinLean/AlgebraicGeometry/Group/Representations.toml`; no cycle arises. The sentence of the decision in section 5 of the proposal is Codex's.
4. **The row of Higher Algebra in `docs/papers.md`.** The clause is Codex's text: Proposition 7.1.4.11 for all commutative algebra objects, Proposition 7.1.4.20 for the connective ones, Warning 7.1.4.21 for the animated model.

Improvements that can wait: the open item on homotopy groups now says "with base point zero". The root entry is left as it is: it names the stacks of `QCohLS` and `IndCohNilp`, and a change of a Lean file would need the done check again for one word.

A search of `plans/`, `plans-proof/`, `docs/` and sections 5 and 6 of the proposal for "need not be equivalent", "not over 𝔽_2" and "connective commutative algebras in Vect_k" finds no other sentence with the replaced claims that this change wrote.

No count changes. `lake exe tracker lint` has no errors, `python3 tools/check-module-cycles.py` finds no cycle, and `python3 tools/check-upstream-names.py` confirms every pair.

## Round 3

Codex's third report (`notes/checks/roadmap-node-splits-codex-3.md`) has one blocking objection: the last sentence of the row of Higher Algebra in `docs/papers.md` lacked its full stop. It is added. Its improvement that can wait is applied too: the entry of `GLCinLean.lean` names the stack `LS_Ǧ` of `QCohLS` and `IndCohNilp`. The done check was run after this change of a comment.

## Round 4

Codex's fourth report (`notes/checks/roadmap-node-splits-codex-4.md`) confirms the full stop and has one blocking objection: the entry of `GLCinLean.lean` said that the stack "is tested" on animated affine schemes, which presents the evaluation as part of the present definitions, while `QCohLS` and `IndCohNilp` are opaque declarations. Its exact wording replaces the first three lines of the entry: the entry now names the stack of de Rham local systems of [GLC1] §0.1.1, as the doc comments of `QCohLS` and `IndCohNilp` do, and says that this stack can be evaluated on spectra of animated commutative `k`-algebras. The number §0.1.1 was checked with `tools/tex-locator.awk` (line 732 of the TeX). The done check was run after the change.
