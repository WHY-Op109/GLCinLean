# Plan of the proof

This folder holds the planned declarations that only the proof of the main theorem needs, and no definition that the statement uses. The statement's plan is in `plans/`; `plans/README.md` says what it covers.

The layout and the node format are those of `plans/`: `plans-proof/GLCinLean/` for nodes to be written here, `plans-proof/Roadmap/<area>/` for nodes that a Tau Ceti roadmap owns. A module may have nodes in both folders, at the same relative path.

- The tracker does not read this folder, so `lake exe tracker ready` and `lint` do not see these nodes. Their `deps` may name nodes of `plans/`; a node in `plans/` never depends on a node here.
- Writers and the Tau Ceti workers work from `plans/` only.
- When the proof starts, a node moves back into `plans/` together with the nodes here that it depends on, and `lake exe tracker lint` checks the move.
- `Infinity.moduleOverMonoidalLocalization` may be owned by EnhancedDerivedSheaves (E5:abstract.2, E5:presentability.4). Check that roadmap before the node is written here.
- `Groups.chevalleyInvolution` may be owned by ReductiveGroupsPartII. Check that roadmap before the node is written here.

## Contents

- The spectral action of `QCoh(LS_Ǧ)` and the spectral decomposition, with their proof: `Spectral.action`, `Spectral.actionOfVanishing`, the monoidal structure and the right adjoint of `Spectral.localization`, and the `SpectralProof.*` nodes (vanishing, Kac–Moody localization at the critical level, opers, derived Satake, Eisenstein series and constant terms).
- The monoidal structures on the Hecke side: the convolution of the spherical category (`Satake.factorizationConvolution`), the monoidal structure of naive Satake (`Satake.naiveFactorizationFunctor_monoidal`, with `Ran.Representations.laxMonoidalFunctorEquivAlgebra`), the action structure of the spherical category (`Hecke.sphericalAction_associativity`), with the composition map of the Ran Hecke stack and the compatibility of the gerbe comparison with it (`Satake.criticalTwistBunDeterminantEquiv_comp`), the convolution of `Rep(Ǧ)_Ran` (`Hecke.ranConvolution`), the associativity of the Hecke action (`Hecke.action_associativity`), and the monoidal form of the independence of the pinning (`Satake.dualIdentificationChangePinningIso_monoidal`).
- The coarse functor `Langlands.coarse`, its left adjoint and its examples, and the Whittaker coefficient.
- The geometry that only these need: semi-infinite categories, Zastava spaces, renormalized Satake, factorization and chiral homology, infinite-type IndCoh, and the QCoh kernel formalism of passable stacks. One-affineness, passable stacks with their tensor base change, and the comparison of `Rep(H)_Ran` with Raskin's collision limit are in `plans/`, because the Hecke action of the statement uses them.
- The invariant theory of the coadjoint representation that only the derived Satake equivalence needs: the coadjoint quotient map `Groups.chevalleyMap` and the restriction isomorphism `Groups.chevalleyRestriction`, both owned by roadmap LanglandsParameterStacks §1.12, and the projection to the affine quotient `Groups.affineQuotientProjection`, owned by roadmap ArithmeticGaloisRepresentations §1.11, of which the coadjoint quotient map is a case. The coadjoint nilpotent cone `Groups.nilpotentCoadjointCone` is in `plans/`, because the global nilpotent cone of the statement uses it.

## Obligations of the proof

Two planned theorems in `GLCinLean/GeometricLanglands/Functor/Coarse.toml` connect the statement with [GLC1]:

- `Langlands.isLanglandsFunctor_iff_comp_psi_iso_coarse`: the second property of `Statement.IsLanglandsFunctor` holds exactly when `Ψ ∘ F ≃ 𝕃_{G,coarse}` as functors of ∞-categories ([GLC1] Thm. 1.2.4).
- `Langlands.isEquivalence_iff_of_isLanglandsFunctor`: two functors with the two properties are naturally equivalent as functors of ∞-categories, so one is an equivalence exactly when the other is. With the comparison theorem, `𝕃_G` of [GLC1] Cor. 1.6.5 is one such functor.

## Notes for the session that starts the proof

- **The uniqueness theorem has two conclusions.** `Langlands.isEquivalence_iff_of_isLanglandsFunctor` states both `F ≃ F′` and "`F` is an equivalence iff `F′` is", but its name spells only the second. When writing the uniqueness theorem, consider stating `F ≃ F′` separately.
- **Non-unital monoidal categories.** No roadmap provides non-unital monoidal categories. This concerns `plans-proof/` only (`Hecke.ranConvolution`, `Hecke.action_associativity`, `Satake.factorizationConvolution`); [GLC2] Appendix H shows a route through unital local actions.
- **Known gaps of the proof plan.** No node gives a twisted *-pushforward, which `SpectralProof.constantTerm` (along q^−) and `SpectralProof.localizationCDO_is_diagonal` (along the diagonal) use; `SpectralProof.constantTerm` reaches neither the half-twisted category nor the root gerbe; `SemiInfinite.parabolicVacuumShriek` reaches no gerbe on Gr_G. `Satake.regularSheafExt_complexComparison` may need an equivariant constructible category with convolution, which the ordinary triangulated constructible category built from Mathlib does not give. No node gives the isomorphism of the quotient of the regular locus of `𝔥*` by the group with `𝔱*/W` (Kostant), which `SpectralProof.equivariantRegularSheaf_cohomology` uses ([LoopGrassmannianExt] §6.2); roadmap FormalConnectionsOpers names a "Kostant regular/slice theorem" in §4.3. `SpectralProof.geometricCenter_operMap` uses the torsor of the tensor isomorphisms between two fibre functors, the second with values in finite projective modules over an algebra (roadmap MotivesAndAlgebraicCycles §6.8); no node gives it, and `Tannaka.neutralReconstruction` in `plans/` gives only the automorphisms of one fibre functor. The same node works over a rational model, and no node gives the Satake objects there: the Satake nodes are stated over an algebraically closed field. The generic Ran nodes of `plans-proof/` (`Hecke.ranHomology_connective`, `Hecke.ranHomology_is_unit`, `Hecke.ranSupersetPullback_fullyFaithful`) keep the `Hecke` namespace until the proof starts.
