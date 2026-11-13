# Plan of the proof

This folder holds the planned declarations that only the proof of the main theorem needs, and no definition that the statement uses. The statement's plan is in `plans/`; `plans/README.md` says what it covers.

The layout and the node format are those of `plans/`: `plans-proof/GLCinLean/` for nodes to be written here, `plans-proof/Roadmap/<area>/` for nodes that a Tau Ceti roadmap owns. A module may have nodes in both folders, at the same relative path.

- The tracker does not read this folder, so `lake exe tracker ready` and `lint` do not see these nodes. Their `deps` may name nodes of `plans/`; a node in `plans/` never depends on a node here.
- Build sessions and Worker rounds work from `plans/` only.
- When the proof starts, a node moves back into `plans/` together with the nodes here that it depends on, and `lake exe tracker lint` checks the move.
- `Infinity.moduleOverMonoidalLocalization` may be owned by EnhancedDerivedSheaves (E5:abstract.2, E5:presentability.4). Check that roadmap before the node is written here.
- `Groups.chevalleyInvolution` may be owned by ReductiveGroupsPartII. Check that roadmap before the node is written here.

## Contents

- The spectral action of `QCoh(LS_Ǧ)` and the spectral decomposition, with their proof: `Spectral.action`, `Spectral.actionOfVanishing`, the monoidal structure and the right adjoint of `Spectral.localization`, and the `SpectralProof.*` nodes (vanishing, Kac–Moody localization at the critical level, opers, derived Satake, Eisenstein series and constant terms).
- The coarse functor `Langlands.coarse`, its left adjoint and its examples, and the Whittaker coefficient.
- The geometry that only these need: semi-infinite categories, Zastava spaces, renormalized Satake, factorization and chiral homology, infinite-type IndCoh, 1-affineness, and the QCoh kernel formalism of passable stacks.

## Obligations of the proof

Two planned theorems in `GLCinLean/GeometricLanglands/Functor/Coarse.toml` connect the statement with [GLC1]:

- `Langlands.isLanglandsFunctor_iff_comp_psi_iso_coarse`: the second property of `Statement.IsLanglandsFunctor` holds exactly when `Ψ ∘ F ≃ 𝕃_{G,coarse}` as functors of ∞-categories ([GLC1] Thm. 1.2.4).
- `Langlands.isEquivalence_iff_of_isLanglandsFunctor`: two functors with the two properties are naturally equivalent as functors of ∞-categories, so one is an equivalence exactly when the other is. With the comparison theorem, `𝕃_G` of [GLC1] Cor. 1.6.5 is one such functor.
