# Provider record

The one snapshot of what Mathlib, Tau Ceti and the Tau Ceti roadmaps supply to the plan. A plan node names its provider only as "here" or as a roadmap area and target; the revisions and the detail are here. `prompts/audit.md` brings this file up to date in place.

## Snapshot

| Repository | Revision | Read on |
|---|---|---|
| Mathlib (pinned) | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` | |
| Tau Ceti (pinned) | `e0610cce4004d628cbd9d2aafdbbb5459fe72938` | |
| Tau Ceti main | `4d91513e4d30746eb1fa96658c18e051c772e55e` (Lean `v4.36.0-rc2`, as at the pin; Mathlib `2ddf59c8f1`) | 2026-11-13 |
| TauCetiRoadmap main | `7342e8fdd66944f4b6774ca84fc3ba304b4f7299`, for the provider check and the target titles in `plans/Roadmap/` | 2026-11-13 |
| TauCetiWorker main | `d981e0aafb21357ec31ab7de5f0aa8b06f45c0d4` (the flags `--roadmap-only` and `--extra-roadmap-prompt` are unchanged) | 2026-11-13 |

The previous snapshot (2026-11-10) was Tau Ceti main `7a6772d920699412927989888cd1c7b61ac67cee`, TauCetiRoadmap main `651d08225204b26a3ef0ce99599ae7c006dc734e` (titles at `4ec889e8f0480e2cdb21a524eb76e48215c9ad94`) and TauCetiWorker `f65aafb2ed0c93c31f2be3ecdc4fc01ee57c439a`. The audit of 2026-11-13 (`notes/audit-2026-11-13.md`) compared against it.

Tau Ceti's `AGENTS.md` and `COORDINATION.md` (at the pin) say that new mathematics must advance an existing roadmap target or its genuine prerequisite, and that an agent opens no new roadmap pull request or issue. Contributions go through the Worker, from the fork `WHY-Op109/TauCeti`.

## Upstream declarations the plan uses

These exist. The node that uses one names it and its module in its `desc`. The note says where it falls short of the paper's object. Five are on Tau Ceti main but not at the pin; using them needs a pin move to a commit with a published cache. All 45 Tau Ceti rows were checked on 2026-11-13: each still exists on Tau Ceti main in the same module. The rows marked "(no node names it yet)" were found on 2026-11-13 and supply nodes that the plan still plans (`notes/audit-2026-11-13.md`).

| Declaration | Module | Note |
|---|---|---|
| `SheafOfModules.IsQuasicoherent` | `Mathlib.Algebra.Category.ModuleCat.Sheaf.Quasicoherent` | Ordinary quasicoherent module sheaf predicate; enhancement still required. |
| `CharZero` | `Mathlib.Algebra.CharZero.Defs` | Characteristic zero of the ground field. |
| `Field` | `Mathlib.Algebra.Field.Defs` | Field structure of the ground field. |
| `DerivedCategory` | `Mathlib.Algebra.Homology.DerivedCategory.Basic` | Ordinary localized derived category, only the homotopy-category boundary of the enhancement. |
| `DerivedCategory.TStructure.t` | `Mathlib.Algebra.Homology.DerivedCategory.TStructure` | Standard cohomological t-structure on the ordinary derived category. |
| `CochainComplex` | `Mathlib.Algebra.Homology.HomologicalComplex` | Cochain complexes, used as strict models for the enhanced coefficient category. |
| `LieAlgebra.ofTwoCocycle` | `Mathlib.Algebra.Lie.Extension` | Lie algebra carrier of the central extension supplied by a Lie algebra two-cocycle. |
| `killingForm` | `Mathlib.Algebra.Lie.TraceForm` | Trace form of the adjoint representation. It need not be nondegenerate for a reductive Lie algebra with center. |
| `AlgebraicGeometry.Scheme.Modules` | `Mathlib.AlgebraicGeometry.Modules.Sheaf` | Ordinary module sheaves on a scheme, not the enhanced QCoh category. |
| `AlgebraicGeometry.IsProper` | `Mathlib.AlgebraicGeometry.Morphisms.Proper` | Properness of the curve structure morphism. |
| `AlgebraicGeometry.SmoothOfRelativeDimension` | `Mathlib.AlgebraicGeometry.Morphisms.Smooth` | Smoothness of fixed relative dimension; use dimension one for the curve. |
| `AlgebraicGeometry.Scheme` | `Mathlib.AlgebraicGeometry.Scheme` | Classical schemes; a boundary for classical geometry, not derived schemes. |
| `AlgebraicGeometry.Spec` | `Mathlib.AlgebraicGeometry.Scheme` | Affine spectrum of a commutative ring. |
| `AlgebraicGeometry.Scheme.smallEtaleTopology` | `Mathlib.AlgebraicGeometry.Sites.Etale` | Small etale topology on schemes etale over X. Use the actual topology without redefining the site. |
| `SSet.Quasicategory` | `Mathlib.AlgebraicTopology.Quasicategory.Basic` | Inner-horn filling predicate for simplicial sets; this alone does not provide presentable stable categories. |
| `SSet.QCat` | `Mathlib.AlgebraicTopology.Quasicategory.StrictBicategory` | Bundled quasicategories with the existing bicategorical comparison API; this is not the complete presentable stable layer. |
| `CategoryTheory.EnrichedCategory` | `Mathlib.CategoryTheory.Enriched.Basic` | Categories enriched over a monoidal category; applied to cochain complexes. (used by no node) |
| `CategoryTheory.EnrichedFunctor` | `Mathlib.CategoryTheory.Enriched.Basic` | Strict enriched functors; does not replace continuous functors of enhanced categories. (used by no node) |
| `CategoryTheory.MonoidalCategory` | `Mathlib.CategoryTheory.Monoidal.Category` | Ordinary monoidal categories, a boundary for strict constructions; coherent enhanced monoidal structure remains required. (used by no node) |
| `CategoryTheory.Pseudofunctor.IsStack` | `Mathlib.CategoryTheory.Sites.Descent.IsStack` | Ordinary categorical descent for pseudofunctors; derived infinity-stacks are not supplied. |
| `CategoryTheory.Sheaf.H` | `Mathlib.CategoryTheory.Sites.SheafCohomology.Basic` | Cohomology of an abelian sheaf on a site as Ext from the constant integer sheaf; retain HasSheafify and HasExt requirements. |
| `CategoryTheory.Triangulated.TStructure` | `Mathlib.CategoryTheory.Triangulated.TStructure.Basic` | Ordinary triangulated t-structure; enhanced comparison still required. |
| `CategoryTheory.Triangulated.TStructure.plus` | `Mathlib.CategoryTheory.Triangulated.TStructure.Basic` | Bounded-below objects for a t-structure, `∃ n, t.IsGE X n`, closed under isomorphisms and shifts; used by `Infinity.eventuallyCoconnective` on the homotopy category. |
| `IsAlgClosed` | `Mathlib.FieldTheory.IsAlgClosed.Basic` | Algebraic closedness of the ground field. |
| `CoxeterSystem.length` | `Mathlib.GroupTheory.Coxeter.Length` | Length in a Coxeter system; the Coxeter system of the affine Weyl group is constructed in `Groups.iwahoriWeylLength`. |
| `RootPairing.Base` | `Mathlib.LinearAlgebra.RootSystem.Base` | Bases of root pairings, used for based root data. |
| `RootPairing.Base.flip` | `Mathlib.LinearAlgebra.RootSystem.Base` | Dual base in the flipped root pairing. |
| `RootDatum` | `Mathlib.LinearAlgebra.RootSystem.Defs` | Integral root pairing abbreviation, with finiteness and reducedness supplied separately when needed. |
| `RootPairing` | `Mathlib.LinearAlgebra.RootSystem.Defs` | Root pairing with character and cocharacter lattices; does not extract one from a reductive group. (used by no node) |
| `RootPairing.flip` | `Mathlib.LinearAlgebra.RootSystem.Defs` | Dualization interchanging roots and coroots and the two lattices. |
| `RootPairing.Equiv` | `Mathlib.LinearAlgebra.RootSystem.Hom` | Isomorphisms of root pairings. |
| `ConnectedSpace` | `Mathlib.Topology.Connected.Basic` | Connected, nonempty underlying space of the curve. |
| `TopCat.Sheaf` | `Mathlib.Topology.Sheaves.Sheaf` | Sheaves with values in a category on a topological space. |
| `TauCeti.FiniteTypeCommHopfAlgCat` | `TauCeti.Algebra.AlgebraicGroup.FiniteType.CommHopfAlgCat` | Finite-type commutative Hopf algebras, the coordinate-algebra model used by pinnings. (used by no node) |
| `TauCeti.Pinning` | `TauCeti.Algebra.AlgebraicGroup.Pinning.Basic` | Pinning: split maximal torus, Borel and simple-root trivializations. |
| `TauCeti.SplitMaximalTorus.IsSimpleRoot` | `TauCeti.Algebra.AlgebraicGroup.Pinning.Basic` | Simple positive roots determined by the Borel and split maximal torus. |
| `TauCeti.Pinning.comapOfIso` | `TauCeti.Algebra.AlgebraicGroup.Pinning.Isomorphism` | Transport of a pinning along an isomorphism of coordinate Hopf algebras, with the same simple roots and root vectors given by the differential. It does not construct an isomorphism from an identification of based root data. |
| `TauCeti.ReductiveCommHopfAlgCat` | `TauCeti.Algebra.AlgebraicGroup.Reductive.Basic` | Reductive finite-type commutative Hopf algebras, used directly for the group and its pinning without duplicate wrappers. |
| `TauCeti.reductiveCommHopfAlgProperty_iff_linearlyReductive` | `TauCeti.Algebra.AlgebraicGroup.Reductive.CompleteReducibility` | For a geometrically connected finite-type affine group over a field of characteristic zero, reductivity is equivalent to complete reducibility of all finite-dimensional rational representations. It needs finite type and geometric connectedness as inputs; it does not construct the Tannakian group. |
| `TauCeti.Tannaka.pointsFunctorIsoTensorAutFunctor` | `TauCeti.Algebra.AlgebraicGroup.Representation.Tannaka.GroupFunctor` | Natural group-functor reconstruction of a GIVEN commutative Hopf algebra from tensor automorphisms of its finite comodules. It does not construct the Hopf algebra of an arbitrary neutral Tannakian category; that prerequisite remains explicit in Satake.tannakaGroup. |
| `TauCeti.simplyConnectedSemisimpleCommHopfAlgProperty` | `TauCeti.Algebra.AlgebraicGroup.SimplyConnected.Basic` | Simple connectivity of a semisimple affine group in Hopf coordinates: every central isogeny onto it from a semisimple group is an isomorphism. It is a property; it does not construct the simply connected cover. |
| `TauCeti.SplitMaximalTorus` | `TauCeti.Algebra.AlgebraicGroup.SplitTorus.Maximal` | Split maximal torus in the Hopf-algebra model. |
| `TauCeti.adjointInvariantPolynomials` | `TauCeti.Algebra.AlgebraicGroup.Tangent.Lie.Adjoint.NilpotentCone` | Invariant polynomial functions of the actual adjoint action. This is the adjoint precursor, not the whole coadjoint construction. (on Tau Ceti main only, not at the pin) |
| `TauCeti.nilpotentConeIdeal` | `TauCeti.Algebra.AlgebraicGroup.Tangent.Lie.Adjoint.NilpotentCone` | Scheme-theoretic zero-fibre ideal of the adjoint quotient, generated by invariants vanishing at zero. Keeps central invariants, unlike ad-nilpotence alone. (on Tau Ceti main only, not at the pin) |
| `Derivation.adjointComodule` | `TauCeti.Algebra.AlgebraicGroup.Tangent.Representation` | Adjoint comodule on the dual augmentation cotangent space. |
| `TauCeti.smoothModules` | `TauCeti.Algebra.Category.ModuleCat.Smooth.Basic` | Full subcategory of modules smooth for a filtration of annihilator ideals. This ordinary category is not the derived Kazhdan–Lusztig category. |
| `TauCeti.Comodule.dual` | `TauCeti.Algebra.Coalgebra.Comodule.Dual` | Contragredient comodule on the dual of a finite projective module, for the coadjoint action. |
| `HomologicalComplex.isIso_homologyKunneth_of_isSplitMono_of_isSplitEpi` | `TauCeti.Algebra.Homology.Monoidal.Homology.Kunneth.Basic` | The Kunneth map is an isomorphism for module complexes whose cycles and homology split off, in particular complexes over a field. Geometric D-module Kunneth remains a separate planned theorem. |
| `TauCeti.currentAlgebra` | `TauCeti.Algebra.Lie.Current.Basic` | Formal Laurent currents R((t)) tensor L. (used by no node) |
| `TauCeti.CurrentAlgebra.smoothModulesEquivalence` | `TauCeti.Algebra.Lie.Current.CompletedModules` | Ordinary smooth level modules are equivalent to discrete modules over the completed enveloping algebra. This is not a derived factorization equivalence. (on Tau Ceti main only, not at the pin) |
| `TauCeti.CurrentAlgebra.CompletedEnveloping` | `TauCeti.Algebra.Lie.Current.Completion` | Completed enveloping algebra of the current central extension at the specified central value. |
| `TauCeti.CurrentAlgebra.twoCocycleOfBilinear` | `TauCeti.Algebra.Lie.Current.ResidueCocycle` | Residue cocycle Res(f dg) times an invariant symmetric form. For the level kappa in [GLC2], supply the form -kappa. |
| `TauCeti.CurrentAlgebra.IsSmooth` | `TauCeti.Algebra.Lie.Current.SmoothAction` | Vectorwise eventual annihilation by positive-order formal currents. |
| `TauCeti.finiteTypeCommHopfAlgCatOpEquivFiniteTypeAffineGroupSchemeCat` | `TauCeti.AlgebraicGeometry.AffineGroupScheme.FiniteType` | Anti-equivalence between finite-type commutative Hopf algebras and affine group schemes. |
| `TauCeti.ReductiveAffineGroupSchemeCat` | `TauCeti.AlgebraicGeometry.AffineGroupScheme.Reductive.Basic` | Reductive affine group schemes of finite type, with smoothness and geometric connectedness. |
| `TauCeti.AlgebraicGeometry.cohomologyBaseChangeLinearEquiv` | `TauCeti.AlgebraicGeometry.Cohomology.FlatBaseChange` | For a quasi-compact scheme with affine diagonal over R, quasi-coherent M and a flat R-algebra R′, the canonical equivalence R′ tensor H^n(X,M) ≃ H^n(X_R′,M_R′). Every k-algebra is flat over the field k, so this supplies arbitrary affine test families for the fixed vector bundles on X. |
| `AlgebraicGeometry.Scheme.Modules.finiteDimensional_cohomology_of_smooth` | `TauCeti.AlgebraicGeometry.Curves.Cohomology` | For a smooth proper connected curve over any field k and every quasi-coherent finite-type sheaf M, H^n(X,M) is finite-dimensional in every degree. Apply to each vector bundle in the twisted unipotent filtration, not only the canonical line bundle. |
| `AlgebraicGeometry.Scheme.Modules.subsingleton_cohomology_of_two_le_of_smooth` | `TauCeti.AlgebraicGeometry.Curves.Cohomology` | For a smooth proper connected curve over any field and every quasi-coherent sheaf M, H^n(X,M) vanishes for all n≥2. This is the obstruction-vanishing input for additive vector-bundle torsors. |
| `TauCeti.AlgebraicGeometry.InvertibleSheaf` | `TauCeti.AlgebraicGeometry.LineBundle.Basic` | Invertible module sheaves on a classical scheme. |
| `TauCeti.AlgebraicGeometry.InvertibleSheaf.tensorProduct` | `TauCeti.AlgebraicGeometry.LineBundle.TensorProduct` | Tensor product of invertible sheaves, used to specify the theta characteristic. |
| `TauCeti.AlgebraicGeometry.InvertibleSheaf.tensorPow` | `TauCeti.AlgebraicGeometry.LineBundle.Power` | The tensor power `L^{⊗n}` for `n : ℕ`, with the exponent laws and pullback compatibility up to isomorphism (Tau Ceti #37414, 2026-11-11). It is the `M^{⊗n}` of `LineBundle.Root`. (on Tau Ceti main only, not at the pin; no node names it yet) |
| `TauCeti.AlgebraicGeometry.LineBundleClass.eulerDegreeHom` | `TauCeti.AlgebraicGeometry.WeilDivisor.Scheme.PicZero` | The degree `Pic X →+ ℤ`, `deg L = χ(L) − χ(𝒪_X)`, of a proper Noetherian integral curve with discrete valuation rings in codimension one and finite-dimensional `H¹(X, 𝒪_X)`; `LineBundleClass.picZero` is its kernel. A smooth proper connected curve satisfies the hypotheses (`LineBundleClass.eulerDegree_mul_of_smooth` in `TauCeti.AlgebraicGeometry.Curves.Degree` derives them). This is `Curves.picard_degree`. (no node names it yet) |
| `TauCeti.AlgebraicGeometry.eulerDegree_toLineBundleClass_ofPoint_of_section` | `TauCeti.AlgebraicGeometry.RationalPoint.Degree` | `deg 𝒪_X(x₀) = 1` for a `k`-rational point `x₀`, under the same hypotheses. Part of `Curves.picard_degree`. (no node names it yet) |
| `TauCeti.AlgebraicGeometry.eulerDegree_relativeDifferentials` | `TauCeti.AlgebraicGeometry.Modules.Differentials.Canonical` | `deg Ω_{X/k} = 2g − 2` for a proper integral curve over an exact constant field (`IsFunctionField`, `IsIntegrallyClosedIn`) with invertible differentials, discrete valuation rings in codimension one and the valuative existence criterion. A smooth proper geometrically connected curve satisfies them, but no Tau Ceti theorem states the smooth case. This is `Curves.degree_canonical`. The same file gives `dim H¹(X, Ω) = 1` and Serre duality only as a noncanonical equivalence: no trace, so `Curves.serreTrace` stays open. (no node names it yet) |
| `TauCeti.SchemePointTopology.topology` | `TauCeti.Topology.Algebra.PointTopology.Scheme` | The chart topology on the `R`-points of a `k`-scheme for a topological `k`-algebra `R`; for `k = R = ℂ` it is the classical topology on complex points. The scheme-level properties (charts are open embeddings, functoriality, immersions, Hausdorff, locally compact, proper maps) are ReductiveGroups Layer 3A.5b–c targets, not library facts. Carrier of `Constructible.ComplexPoints`. (no node names it yet) |
| `TauCeti.AlgebraicGeometry.StackInGroupoids` | `TauCeti.AlgebraicGeometry.Stack.StackInGroupoids` | Stacks in groupoids over schemes for the fppf topology, with morphisms and fibrewise equivalences: the first definition of SchemeAndStackFoundations §1.18, toward `Stacks.algebraicStack`. (on Tau Ceti main only, not at the pin; no node names it yet) |
| `AlgebraicGeometry.Scheme.relativeDifferentials` | `TauCeti.AlgebraicGeometry.Modules.Differentials.Basic` | Sheaf of relative Kahler differentials; for the smooth curve it is the canonical sheaf. |
| `TauCeti.AlgebraicGeometry.SchPseudofunctor` | `TauCeti.AlgebraicGeometry.Stack.Basic` | Category-valued pseudofunctors on classical schemes; an ordinary stack precursor, not derived prestacks. |
| `TauCeti.dgNerve` | `TauCeti.AlgebraicTopology.DGNerve.Basic` | The DG nerve of a strict DG category, providing an existing concrete enhancement model. |
| `TauCeti.dgNerve.homotopyCategoryEquiv` | `TauCeti.AlgebraicTopology.DGNerve.HomotopyCategory` | Equivalence between the homotopy category of a DG nerve and H0 of its DG category. (used by no node) |
| `SSet.rightMappingSpace` | `TauCeti.AlgebraicTopology.Quasicategory.RightMappingSpace` | Right mapping spaces for simplicial sets; used for compactness in the enhanced sense. |
| `TauCeti.DGCategory` | `TauCeti.CategoryTheory.DG.Basic` | Strict categories enriched in complexes over a specified coefficient ring; not yet the paper DGCat of presentable stable infinity-categories. |
| `TauCeti.dgHomComplex` | `TauCeti.CategoryTheory.DG.Basic` | Mapping cochain complex in a strict DG category. |
| `TauCeti.KInjectiveDGCategory` | `TauCeti.CategoryTheory.DG.CochainComplex.KInjective` | Full DG category of K-injective complexes, a concrete enhancement input. |
| `TauCeti.KInjectiveDGCategory.dgNerveHomotopyCategoryEquiv` | `TauCeti.CategoryTheory.DG.CochainComplex.KInjective` | Comparison of the K-injective DG nerve homotopy category with Mathlib DerivedCategory, assuming K-injective resolutions. |
| `CategoryTheory.Sheaf.Torsor` | `TauCeti.CategoryTheory.Sites.NonabelianCohomology.Torsor` | Locally inhabited sheaf torsors for a sheaf of groups on a site; use fppf descent for principal bundles. |
| `TauCeti.AInfinityCategory.PositiveHochschild.complex` | `TauCeti.CategoryTheory.AInfinity.Hochschild.Basic` | Positive-arity Hochschild cochains of an A∞-category. Related to `Infinity.hochschildCochains`, not a replacement: no arity zero and no E₂-structure. (used by no node) |
| `RootPairing.coweightLattice` | `TauCeti.LinearAlgebra.RootSystem.CoweightLattice` | Coweights on which every root is an integer; over ℤ it is the whole cocharacter lattice, so the central torus is kept. |
| `RootPairing.affineWeylGroup` | `TauCeti.LinearAlgebra.RootSystem.Weyl.Affine.Basic` | The affine Weyl group Q∨ ⋊ W as a group of affine maps of the coweight space. |
| `RootPairing.extendedAffineWeylGroup` | `TauCeti.LinearAlgebra.RootSystem.Weyl.ExtendedAffine.Basic` | The extended affine Weyl group P∨ ⋊ W; over ℤ for a root datum, the Iwahori–Weyl group N ⋊ W. |
| `RootPairing.extendedAffineWeylGroupQuotientEquiv` | `TauCeti.LinearAlgebra.RootSystem.Weyl.ExtendedAffine.Basic` | W_ext / W_aff ≃ P∨ / Q∨ for a crystallographic pairing. |
| `RootPairing.fundamentalAlcoveStabilizer` | `TauCeti.LinearAlgebra.RootSystem.Weyl.ExtendedAffine.Alcove` | Stabilizer of the fundamental alcove in W_ext; needs a nonempty irreducible system over an ordered field, and its map to P∨ / Q∨ is shown surjective, not injective. |
| `TauCeti.coroot'_twoWeylVector_eq_two_mul_height_flip` | `TauCeti.LinearAlgebra.RootSystem.Weyl.Vector` | The positive-root sum pairs with any coroot to twice its height in the flipped base, hence to an even integer over Z. This supplies parity descent through the coroot lattice. |
| `TauCeti.twoWeylVector` | `TauCeti.LinearAlgebra.RootSystem.Weyl.Vector` | Sum of the positive roots in the root lattice module; defined over integral coefficients without halving. Apply it to the flipped datum for positive coroots; do not confuse the two lattices. |

## Roadmaps that own plan nodes

Each area has a folder `plans/Roadmap/<area>/` for the nodes that the statement needs, and `plans-proof/Roadmap/<area>/` for those that only the proof needs. Existence of a roadmap is not existence of code.

| Area | Nodes in `plans/` | What it owns in the statement's plan | Nodes in `plans-proof/` | What it owns in the plan of the proof |
|---|---|---|---|---|
| EnhancedDerivedSheaves | 16 | presentable, linear, dualizable and rigid categories, compact generation, Ind-completion, right adjoints, bounded-below parts, `Vect_k`; animated rings, derived affine schemes and their modules; the affine cotangent complex; QCoh of classical schemes | 5 | continuity and linearity of right adjoints, gluing of dualizable categories, monadicity |
| BordismFormalGroups | 10 | F6.5: mapping spaces, coherent limits, Kan extensions, compact objects, stable and t-structured, monoidal and module categories, linear functors | 0 | |
| ReductiveGroups | 5 | pinned data, pinnings and their existence (Layer 9D), root data, 2ρ | 1 | parabolics and Levi quotients |
| ReductiveGroupsPartII | 4 | RG2.5.1 dual based root datum and Langlands dual group, change of pinning, coweight parity | 2 | RG2.1.5 z-extensions |
| SchemeAndStackFoundations | 2 | §§1.15–1.16 torsors, §§1.18–1.20 algebraic stacks | 2 | §§2.11, 2.15–2.16 étale units and Tsen |
| JacobianChallenge | 5 | Layer A: the degree on Pic X; Layers B–C: the Serre duality trace and the degree of the canonical bundle; Layer D: Pic⁰ of a curve as an abelian variety; Layer E: multiplication by n on abelian varieties | 0 | |
| AffineLieAlgebras | 0 | | 1 | A2.2: the critical level |

Checked on 2026-11-13 against TauCetiRoadmap main `7342e8fd`. The READMEs of EnhancedDerivedSheaves, BordismFormalGroups, ReductiveGroupsPartII and JacobianChallenge did not change; only their generated `STATUS.md` and `PROGRESS.md` did. ReductiveGroups was amended by #1332 (merged 2026-11-11), which deleted its seven companion `*Targets.lean` files (no node cites them) and added text inside sections; its headings, and so Layers 5, 7, 8.2, 9A–9B and 9D, are unchanged. SchemeAndStackFoundations was amended by #1656 (2026-11-11), which only adds §0.7a; §§1.15–1.21, 2.11 and 2.15–2.16 keep their numbers, titles and content. Every title quoted in `plans/Roadmap/` was found in its README at `7342e8fd`. Three ownership facts are new since the snapshot of 2026-11-10:

- **ReductiveGroups Layer 3A.5** ("Properness and the complex comparison", added by #1676 on 2026-11-10, after `651d0822`) is "the single owner of complex points, their classical topology". 3A.5b–c give exactly what `Constructible.ComplexPoints` plans: the classical topology on `Y(ℂ)` from the pinned `TauCeti.SchemePointTopology.topology`, functoriality, open and closed embeddings, Hausdorff for separated `Y`, local compactness, and proper maps. It names ComplexComparisonPartII C-1.1 (#848) a consumer of 3A.5c–3A.5e.
- **JacobianChallenge Layer A is done for curves, and the curve case of Layer B is in Tau Ceti** (its `STATUS.md` of 2026-11-12). The degree homomorphism on `Pic X`, `Pic⁰ = ker deg`, `deg 𝒪(x₀) = 1` and `deg Ω = 2g − 2` are Tau Ceti theorems at the pin (the table above). Layers D and E have no Jacobian scheme and no `[n]` for `n ≠ 0`; a natural Serre duality trace is missing.
- **ReductiveGroups** owns, in Layer 9D, the construction of "the simply-connected and adjoint semisimple forms" with their central isogenies; its coverage report lists "simply connected covers" as missing. ReductiveGroupsPartII RG2.5.1 (*pinned-automorphisms*, item 3) states that `(T/Z)(k)` acts simply transitively on the pinnings with given `(B, T)`, but only for the dual group `Ĝ` and only in its README (no Lean). Neither roadmap states that `T(k) → T_ad(k)` is surjective over an algebraically closed field.

No accepted roadmap or open proposal mentions non-unital monoidal categories or their modules, which `Infinity.monoidalCategory` and `Infinity.moduleCategory` ask for since `edaeafd`.

EnhancedDerivedSheaves takes its generic quasicategory constructions from BordismFormalGroups F6.5 (its table "From other roadmaps"): the categorical model and functor spaces, marked fibrations and Kan extensions, coherent model diagrams and stable enhancements, and the monoidal, fibration, quotient and Ind sub-lanes.

## Roadmaps that nodes here use as inputs

These roadmaps supply part of a node that is written here; the node's `desc` names them.

| Area | Used by |
|---|---|
| PadicMeasuresIwasawaAlgebras §5.1 "Determinant lines of perfect complexes" (`detLine`); AlgebraicVectorBundles Layer 3 "symmetric and exterior powers, determinant" | `Sheaves.determinant` |
| SchubertGeometry (root-coordinate cells); FlagVarieties (parabolics and projective homogeneous spaces) | `AffineGrassmannian.deRhamCohomology_schubertStratum_eq_zero_of_odd` |
| ReductiveGroups, ReductiveGroupsPartII, NilpotentOrbits, AffineLieAlgebras, DerivedModuleAlgebra | the nodes whose `desc` names them |

QCoh on derived prestacks, IndCoh, Ψ and singular support, `Bun_G`, `LS_G`, half-twisted D-modules, geometric Satake over the Ran space, the Whittaker and Poincaré constructions have no roadmap owner. They are written here. Open #1630 says explicitly that EnhancedDerivedSheaves does not own QCoh on prestacks.

## Owner candidates

Four open roadmap pull requests would, if accepted, own nodes that the plan writes here. Their nodes are on the "Held" list of `STATUS.md`. On 2026-11-13 all four were still open, with the heads below (unchanged since 2026-11-10), no review and the labels `awaiting-review`, `awaiting-dependencies` and `ai-approved` (#1734 and #1687 also `roadmap-worker`).

| Pull request | Head | Would own | Limits |
|---|---|---|---|
| #1734 SheafTheoreticSmithTheory §3.0 | `918421742b2f159a00663d66272a7206a62b2280` | the loop Grassmannian of a split reductive group over any field: `LoopGroups.LoopGroup`, `GLCinLean.AffineGrassmannian`, `AffineGrassmannian.reducedNeutralComponent_iso_simplyConnectedCover`, `AffineGrassmannian.schubertStratification`, `AffineGrassmannian.iwahoriStratification`, `AffineGrassmannian.bottSamelsonResolution`, `Satake.semiInfiniteOrbits`, `Satake.semiInfiniteIntersection_dimension`, the geometric part of `Satake.convolution`; partly `Satake.fusion` and `Hecke.Correspondence` | it builds the Beilinson–Drinfeld Grassmannians over `𝔸^J`, not over powers of the curve, so fusion over the chosen curve is not supplied |
| #1687 AnalyticStacks Layers 0–1 | `8b3b4cb179817b67d536ccb7c09aa509bce312cc` | `Sheaves.QCoh`, `Sheaves.qcohGlobalSections`; partly `Derived.FormalCompletion` and `Stacks.ClassifyingStack` | it defines sheaves on stacks in the !-topology, not as the plan's right Kan extension along all affine maps; check that `LS_G` and `Bun_G` are in its class of stacks |
| #848 ComplexComparisonPartII §C-1.1 | `a021e44d9bebb9e766285215c49d7a14fc28ce8c` | partly `DModules.analyticDeRham` (its analytification of schemes). `Constructible.ComplexPoints` is no longer its: since 2026-11-10 the accepted ReductiveGroups Layer 3A.5c owns complex points with their classical topology, and names C-1.1 a consumer | it serves only the complex-analytic part (parity of IC stalks); it covers connections, not holonomic D-modules on singular spaces, so `DModules.analyticDeRham_isEquivalence` is not served |
| #853 AlgebraicModuliForArithmeticGeometry Layer 4 | `e5f9c4c7b4ed6c861c956af6459053f84e9ad679` | gerbes on a site, abelian bandings, band-preserving equivalences, neutralizations, and in §4.3 the root gerbe of a line bundle on a scheme: the scheme-level parts of `Stacks.EtaleGerbe` and `Stacks.rootGerbe` | its gerbes are on an arbitrary site and its root gerbe is on the small étale site of a scheme; gerbes on prestacks (the limit over test schemes, pullback along maps of prestacks) stay here. A text search of Layer 4 at this head found `changeBand`, which gives the inverse gerbe, but no tensor product of gerbes and no formula for `R_n(L ⊗ M)` or `R_n(L^{-1})`; unless the proposal adds them, these stay here too. SchemeAndStackFoundations already names it as the owner of banded gerbes; its §1.21 root stack of a line bundle with a section is a different object |

## Open roadmap proposals checked

Recorded with their heads on 2026-11-10 and checked again on 2026-11-13: every open one below has the same head. The accepted roadmap stays the authority until a proposal merges.

- #1676 ReductiveGroups: **merged** on 2026-11-10. Layer 8 is now "split groups and pinnings"; existence and classification of split groups are Layer 9D "classification, relative groups and forms". The plan names these targets by title. It also added Layer 3A.5, the owner of complex points (above).
- #1332 ReductiveGroups: **merged** on 2026-11-11. Layers 9A–9B are the single producer of the Chevalley construction; it adds orbit, complex-comparison and braid targets and deletes the seven `*Targets.lean` files. No cited title changed.
- #1656 SchemeAndStackFoundations: **merged** on 2026-11-11; adds §0.7a (linear Noether normalization). No effect.
- #1901 HigherToposTheory (draft, now also `awaiting-author`), head `2176cc4c9149c8695dbfdfd5bffac5e090bebb42`: HTT and HA Chapter 1. It proposes to consolidate ownership with EnhancedDerivedSheaves and BordismFormalGroups; it does not yet amend them, and the author announced major revisions on 2026-11-12. An ownership candidate for the `Roadmap/BordismFormalGroups` and `Roadmap/EnhancedDerivedSheaves` nodes. It does not mention non-unital monoidal categories.
- New since 2026-11-10, checked, no effect: #2131 ReductiveGroupsPartIII (head `b10dfae25a93299f2bf6e004800661f18f349ac1`; semisimple conjugacy quotients and tori over number fields), #2132 FourierDeligneTransform (head `ec08a189e7a128e8e08d1ee90528e18042b183ce`; ℓ-adic, characteristic `p`), #2229 RealSemisimpleLieGroups (real groups).
- #1630 EnhancedDerivedSheaves amendment, head `0514180906fd196b8c53163d24feb7fd07e8f7df`: the DG nerve is primary; QCoh on prestacks is excluded.
- #1330 EnhancedDerivedSheaves E1.6 (draft), head `856fe7ab4dd4005dbc2344f29ebd172779ba80ee`: no effect.
- #868 DerivedDeRhamCohomology, head `2f774a945602f234b84b93257736209b3c1d63df`: explicit models of the cotangent complex and derived de Rham cohomology; a future supplier, not enhanced de Rham stacks.
- #1225 JacobianChallengePartII §1.3a, head `2354d712410964d9da8266bc3c75742623d97a16`: the determinant of curve cohomology in families, the scheme-level input of `Stacks.determinantBundle` (`det RΓ(X, ad P)` in families). `Stacks.determinantSquareRoot` still needs its own construction.
- #1056 FormalConnectionsOpers, head `4b3f57b0212124b73d2908b191cf03686f193550`: local and formal opers for simple complex groups; not the global `LS_G`. Its §3A.5 builds the loop Grassmannian over ℂ only, so it does not serve a general `k`.
- #1202 LanglandsParameterStacks, head `1e9f8e83ff3b2bae5e764e108c29309e597e905c`, and #1235 GeometricSatakeAndFusion, head `140b5a7ef0911741962fc87bc1f5b32c7e372e0d`: local ℓ-adic and integral p-adic; not de Rham providers.

PR links are `https://github.com/TauCetiProject/TauCetiRoadmap/pull/<number>`.

## Prior art: AxiomMath Stacks and Weil

AxiomMath Stacks (`5ed82d14634e8d9576bb844c7bd4e3da66d450e7`) and Weil (`27cdb2049be62ee2911429b47f54774078450e32`) are Apache-2.0 and have no `sorry` or `axiom`. They are on older Lean versions (`v4.35.0` and `v4.34.0-rc2`) and cannot be dependencies. They are prior art for ports into Tau Ceti through the Worker, case by case, against an accepted roadmap target, with attribution. No port is made now. When a target becomes ready, check the minimal dependency closure, the actual hypotheses (StacksFrontier is not reviewed, and some of its theorems take unproved inputs as hypotheses), the axioms and the licence.

| Candidate | For | When |
|---|---|---|
| cotangent complex (`StacksFrontier/Cotangent/`, core closure about 9,600 lines) | DerivedModuleAlgebra §0.4, below `Derived.affineCotangentComplex` | when work reaches it |
| two-term determinant `TwoTermDeterminant.det` (about 18,200 lines) | `Stacks.determinantBundle` | when work reaches it |
| complex points `AlgebraicGeometry.Scheme.ComplexPoints` (Weil, about 40 lines) | `Constructible.ComplexPoints`, owned since 2026-11-10 by ReductiveGroups Layer 3A.5c on the pinned `TauCeti.SchemePointTopology.topology` | prior art for that Worker target, if its carrier is compatible |
| Stacks 03RM (vanishing of `H^q(X_et, 𝐆_m)`, closure about 1.2 million lines) | `Etale.curve_splitTorus_h2_zero` (plan of the proof) | no port; a proof route |
| algebraic stacks `AlgebraicGeometry.Stack.IsAlgebraicStack` (Stacks 026O, 03YP; closure about 23,600 lines) | `Stacks.algebraicStack`, owned by SchemeAndStackFoundations §1.19 | through the Worker, if its carrier matches the roadmap's §1.18 stacks in groupoids |
| algebraic de Rham cohomology (`StacksFrontier/AlgebraicGeometry/DeRham/`, about 300 files, with Künneth and the projective-bundle formula) | part of `AffineGrassmannian.deRhamCohomology_schubertStratum_eq_zero_of_odd` | when work reaches it |
| gerbes `CategoryTheory.IsGerbe` (closure about 1,250 lines; no root gerbe) | the scheme-level part of `Stacks.EtaleGerbe`, which #853 would own (SchemeAndStackFoundations leaves banded gerbes to AlgebraicModuliForArithmeticGeometry; its §1.21 is root stacks, a different object) | when #853 is resolved |
| formal algebraic spaces (`StacksFrontier/AlgebraicGeometry/FormalSpace/`; no loop Grassmannian) | classical precursor of `Derived.IsIndscheme` and `GLCinLean.AffineGrassmannian` | when work reaches it |

Not found in Stacks or Weil: D-modules, ∞-categories, `Bun_G`, loop groups and the affine Grassmannian, theta characteristics, reductive groups and root data beyond group schemes.

## Upstream changes checked on 2026-11-13

Against the snapshot of 2026-11-10 (Tau Ceti main `7a6772d9`, 3,742 commits and about 11,400 changed files since; TauCetiRoadmap main `651d0822`, 139 commits since).

- **Tau Ceti main, toward plan nodes.** `InvertibleSheaf.tensorPow` (#37414), needed by `LineBundle.Root`; `StackInGroupoids`, toward `Stacks.algebraicStack`; `TauCeti/AlgebraicGeometry/Descent/QuasicoherentSheaf/Prestack.lean` and `TauCeti/CategoryTheory/Sites/Descent/IsPrestack.lean` (ordinary descent); the Picard group of `ℙ¹` (`projectiveLine.picardDegreeEquiv`, for the ℙ¹ examples); the field-point degree of `Pic⁰_{X/S}` (`PicardFunctor/PicZero/FieldPoint.lean`); zero objects in the DG nerve (`DGNerve/Zero.lean`, #35208), toward `Infinity.stableCategory`; much Chevalley-group work (`TauCeti/Algebra/AlgebraicGroup/Chevalley/`, with #27696, #33575 and #33957 merged), toward `Groups.splitReductiveGroup` and `Groups.langlandsDual`. `TauCeti/AlgebraicGeometry/Curves/Degree.lean` (at the pin) is `Curves/Degree/Basic.lean` on main, with the same declarations. No added file supplies an ∞-categorical node, a gerbe, a loop group or an affine Grassmannian.
- **Tau Ceti pull requests listed on 2026-11-10.** Merged since: #35208, #35214, #35782, #33208, #35708, #27696, #33575, #33957, #32777, #35469, #31601, #35156, #34264. Still open: #28684 (morphism spaces of simplicial sets) and #28845 (coCartesian edges and fibrations), toward `Infinity.mappingSpaces`.
- **Found at the pin, missed on 2026-11-10.** The degree homomorphism on `Pic`, `Pic⁰`, `deg 𝒪(x₀) = 1` and `deg Ω = 2g − 2` (table above). They were at the pin then too.
- **TauCetiRoadmap main.** Amendments of ReductiveGroups (#1332) and SchemeAndStackFoundations (#1656, #2148) and the generated `STATUS.md`/`PROGRESS.md` of BordismFormalGroups, JacobianChallenge, NilpotentOrbits, DerivedModuleAlgebra and SchubertGeometry; their effect is under "Roadmaps that own plan nodes". BordismFormalGroups' report: F1 done, F6 (and so F6.5) untouched. NilpotentOrbits' report: `nilpotentConeIdeal` is the zero fibre as an ideal; its scheme theory is not developed. New accepted roadmaps outside the plan's subjects only.

## Other upstream changes checked on 2026-11-10

Against the earlier snapshots (Tau Ceti main `1e668f5e`, TauCetiRoadmap main `000abc14`). None supplies a plan node.

- **Tau Ceti main.** No added file supplies a node; no module of a declaration the plan uses changed, apart from refactors. Precursors of providers that the plan already uses: Chevalley groups by Dynkin type (`TauCeti/Algebra/AlgebraicGroup/Chevalley/Root/Scheme.lean`, `.../Chevalley/Torus/Comparison.lean`), toward ReductiveGroups Layer 9 and `Groups.langlandsDual`; `(G/N)(k) = G(k)/N(k)` over an algebraically closed field (`.../Fppf/Quotient/Homogeneous/RationalPoints.lean`, `TauCeti/AlgebraicGeometry/Sites/FppfAlgClosed.lean`); fpqc descent of affine schemes (`TauCeti/AlgebraicGeometry/Descent/Fpqc.lean`), toward `Stacks.groupTorsor`; `D⁺` of an exact category and Verdier quotients by orthogonal classes (ordinary triangulated tools); the cobar construction of a DG coalgebra. #34746 deleted `TauCeti/LinearAlgebra/Dual/Contraction.lean`, which no node uses.
- **TauCetiRoadmap main.** DerivedModuleAlgebra was rewritten into layers (#1701, `4452ffa3`); §§0.4, 0.6 and 0.8–0.11 keep their numbers and content under "Layer 2: cotangent calculus", so the locator of `Derived.affineCotangentComplex` stays valid. New accepted roadmaps: RootSystemsPartII (#1731) and EquivariantIntersectionTheory (#1685; `Pic [X/G]` for global quotients only, so not `Stacks.determinantBundle`, since `Bun_G` is not a global quotient), and six outside the plan's subjects.
- **Restructuring pull requests that keep the cited layer numbers:** #1807, #1808 (drafts), #1854, #1276 (SchemeAndStackFoundations), #1892 (JacobianChallenge). BordismFormalGroups §F6.5 would become "Layer 6: F6".
- **Roadmap pull requests checked, no effect** (over finite fields, p-adic or local, ℓ-adic, 1-categorical, K-theory, or naming no plan object): #999, #1490, #1845, #1547, #1836, #1241, #1832, #1252, #1844, #1040, #1743, #1926, #1229, #1741, #1522, #1224, #2114, #1656, #1220.
- **Open Tau Ceti pull requests toward plan targets.** Toward `Infinity.mappingSpaces`, straightening and `Infinity.stableCategory`: #28684, #28845, #35208, #35214. Toward SchemeAndStackFoundations: #35782 (torsor classes, for `Etale.unitsSheaf`), #33208, #35708. Toward the Chevalley construction and `Groups.langlandsDual`: #27696, #33575, #33957. Segal–Sugawara modes, central at the critical level (#32777, AffineLieAlgebras A6.2), for `SpectralProof.vacuumCenter` in the plan of the proof. Small precursors: #35469 (for `AffineGrassmannian.iwahoriStratification`), #31601 and #35156 (Kac–Moody algebras), #34264 (`𝒪(k)` on projective space, for the ℙ¹ examples). Four more touch modules of used declarations (#32911, #34462, #35336, #26591) but change no used declaration.

## Roadmap candidates (deferred)

The owner deferred on 2026-11-11 the decision to write or submit Tau Ceti roadmaps for the parts of the plan that no roadmap owns. The candidates are recorded here so that a later decision can rest on the state of this project, of Tau Ceti and of the roadmaps at that time. Each audit (`prompts/audit.md`) checks the triggers below and updates the column "State"; the decision is the owner's.

A candidate is put to the owner only when all four triggers hold:

1. Tau Ceti main has merged code, not only roadmap text, for the roadmaps in its column "Rests on".
2. No accepted roadmap or open roadmap proposal covers its scope.
3. Its nodes are what blocks the next work here: no module under `GLCinLean` is ready apart from modules that it would own.
4. A reviewer who knows the subject is known.

How Tau Ceti roadmaps are shaped, as read on 2026-11-11 from the TauCetiRoadmap README and `CONTRIBUTING.md`:

- A roadmap covers a whole subject with its full basic theory, not only what one project needs. So each candidate is larger than the plan nodes it would take.
- It has one arXiv subject class (`metadata.toml`), a `README.md` that is the specification, and a `Suggested.lean` file that builds against the pinned Mathlib and Tau Ceti.
- Its lowest step must rest on material that is already formalized.
- A large subject is split into parts ("Part I", "Part II").
- Merged roadmaps near this plan have 300 to 9,000 lines of README: small (FlagVarieties, NilpotentOrbits, JacobianChallenge), medium (AffineLieAlgebras, about 1,200), large (EnhancedDerivedSheaves, DerivedModuleAlgebra, BordismFormalGroups, about 3,000), very large (ReductiveGroups, SchemeAndStackFoundations).
- A proposal may be written with AI help: the pull request names the models, and the person who submits it has read it. It merges when one member of the roadmap-reviewers team approves it and the build passes. A proposal that cites an unmerged proposal waits with the label `awaiting-dependencies`.
- An agent never opens a roadmap pull request or issue (Tau Ceti `AGENTS.md`); the owner submits.

The column "Nodes" counts nodes written here, in `plans/` and `plans-proof/`, by subject folder. The split between candidates 1 and 4 is approximate.

| # | Candidate (arXiv class) | Size | Nodes: statement / proof | Rests on | Neighbors to cite | State |
|---|---|---|---|---|---|---|
| 1 | Algebraic D-modules on smooth varieties: rings of differential operators, coherent and holonomic modules, direct and inverse images, duality, Kashiwara's theorem, regular holonomic modules and Riemann–Hilbert over ℂ (math.AG) | medium to large | about 20 / about 5, from `DModules/` and `Constructible/` | Mathlib (Kähler differentials, derivations, schemes), SchemeAndStackFoundations | #848, TopologicalSheafCohomology, #1040 (an ℓ-adic decomposition theorem) | 2026-11-13: triggers 1 and 2 hold (Mathlib and SchemeAndStackFoundations have merged code; no roadmap or proposal on D-modules found); 3 fails (`LineBundle.Root` is ready and is not its); 4 unknown. Not put to the owner |
| 2 | Derived prestacks and formal geometry: prestacks, the de Rham prestack, formal completions, ind-schemes, pseudo-proper maps, mapping stacks (math.AG) | large | 15 / 10, from `Derived/`, `Prestacks/`, `Stacks/` | EnhancedDerivedSheaves (E5:animation), BordismFormalGroups F6.5, DerivedModuleAlgebra | #868 | 2026-11-13: trigger 1 fails (EnhancedDerivedSheaves E5:animation and BordismFormalGroups F6.5 have no code; F6 is untouched); 3 fails |
| 3 | Quasi-coherent and ind-coherent sheaves on prestacks, with Ψ and singular support (math.AG) | large | 24 / 21, from `Sheaves/` | 2 | #1630 (EnhancedDerivedSheaves leaves out QCoh on prestacks), #1687 | 2026-11-13: 1 fails (rests on 2); 2 fails while #1687 is open (no review since 2026-10-28); 3 fails |
| 4 | Crystals: D-modules on prestacks and stacks (math.AG; possibly Part II of 1) | medium | about 9 / about 9, from `DModules/` | 1, 2, 3 | 2026-11-13: waits for 1 to 3 |
| 5 | The Ran space and factorization: contractibility, factorization categories, chiral homology (math.AG) | medium | 2 / 12, from `Ran/`, `Factorization/`, `Algebra/Homology/` | 3, 4 | 2026-11-13: waits for 3 and 4 |
| 6 | Bundles and local systems on a curve: `Bun_G`, its determinant line and square root, `LS_G`, the global nilpotent cone (math.AG) | medium | 16 / 11, from `Stacks/`, `LocalSystems/`, `Automorphic/`, `Curves/` | 2, 3, ReductiveGroups, JacobianChallenge | #1225; #1241 and #1547 treat other bases | 2026-11-13: waits for 2 and 3 |
| 7 | Geometric Satake over a curve, de Rham. Part I: loop groups and Beilinson–Drinfeld Grassmannians over `X^I`. Part II: the Satake equivalence, fusion and the Hecke action (math.RT) | large, in two parts | 52 / 15, from `AffineGrassmannian/`, `LoopGroups/`, `Group/`, `GroupActions/`, `Satake/`, `Hecke/` | 1, 4, 5, 6 | #1734 (the Grassmannian over `𝔸^J`), #1235 and #1836 (local and integral), #1040 | 2026-11-13: 2 fails while #1734 is open (no review since 2026-10-29); waits for 1, 4, 5 and 6 |
| 8 | Whittaker models, semi-infinite geometry and Eisenstein series (math.RT) | medium to large | 5 / 22, from `Whittaker/`, `SemiInfinite/` | 4, 6, 7 | 2026-11-13: waits for 7 |
| 9 | Proof of the de Rham geometric Langlands conjecture: Kac–Moody localization and opers at the critical level, the spectral decomposition, the equivalence (math.AG) | one to three roadmaps | 6 / 82, from `Spectral/`, `Functor/`, `Examples/` | all of the above | AffineLieAlgebras, #1056 | 2026-11-13: waits for all of the above |

The statement alone needs candidates 1 to 7, of which 5 and 8 only in small parts (`Rep(Ǧ)_Ran` and the vacuum Poincaré object). The statement, `Spectral.localization` and the examples stay here in any case (about 10 nodes). The order of submission follows the column "Rests on": a candidate is submitted after the candidates it rests on have merged. Merging 2, 3 and 4 into one roadmap would match Tau Ceti's preference for broad roadmaps, but at the size of SchemeAndStackFoundations.

## Limits of existing providers

- The Tannakian reconstruction API starts from a given Hopf algebra. Constructing the Hopf algebra from the spherical category is a separate Satake obligation.
- A local or p-adic Satake roadmap is not a de Rham provider.
- A planned theorem is not evidence that its proof source is complete.
