# Provider record

The one snapshot of what Mathlib, Tau Ceti and the Tau Ceti roadmaps supply to the plan. A plan node names its provider only as "here" or as a roadmap area and target; the revisions and the detail are here. `prompts/audit.md` brings this file up to date in place.

## Snapshot

| Repository | Revision | Read on |
|---|---|---|
| Mathlib (pinned) | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` | |
| Tau Ceti (pinned) | `e0610cce4004d628cbd9d2aafdbbb5459fe72938` | |
| Tau Ceti main | `7a6772d920699412927989888cd1c7b61ac67cee` | 2026-11-10 |
| TauCetiRoadmap main | `651d08225204b26a3ef0ce99599ae7c006dc734e` for the provider check; `4ec889e8f0480e2cdb21a524eb76e48215c9ad94` for the target titles in `plans/Roadmap/` | 2026-11-10 |
| TauCetiWorker main | `f65aafb2ed0c93c31f2be3ecdc4fc01ee57c439a` | 2026-11-10 |

Tau Ceti's `AGENTS.md` and `COORDINATION.md` (at the pin) say that new mathematics must advance an existing roadmap target or its genuine prerequisite, and that an agent opens no new roadmap pull request or issue. Contributions go through the Worker, from the fork `WHY-Op109/TauCeti`.

## Upstream declarations the plan uses

These exist. The node that uses one names it and its module in its `desc`. The note says where it falls short of the paper's object. Three are on Tau Ceti main but not at the pin; using them needs a pin move to a commit with a published cache.

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
| `IsAlgClosed` | `Mathlib.FieldTheory.IsAlgClosed.Basic` | Algebraic closedness of the ground field. |
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
| `TauCeti.coroot'_twoWeylVector_eq_two_mul_height_flip` | `TauCeti.LinearAlgebra.RootSystem.Weyl.Vector` | The positive-root sum pairs with any coroot to twice its height in the flipped base, hence to an even integer over Z. This supplies parity descent through the coroot lattice. |
| `TauCeti.twoWeylVector` | `TauCeti.LinearAlgebra.RootSystem.Weyl.Vector` | Sum of the positive roots in the root lattice module; defined over integral coefficients without halving. Apply it to the flipped datum for positive coroots; do not confuse the two lattices. |

## Roadmaps that own plan nodes

Each area has a folder `plans/Roadmap/<area>/`. Existence of a roadmap is not existence of code.

| Area | Nodes | What it owns in the plan |
|---|---|---|
| EnhancedDerivedSheaves | 21 | presentable, linear and rigid categories, Ind-completion, adjoints, monadicity, `Vect_k`; animated rings, derived affine schemes and their modules; the affine cotangent complex; QCoh of classical schemes |
| BordismFormalGroups | 10 | F6.5: mapping spaces, coherent limits, Kan extensions, compact objects, stable and t-structured, monoidal and module categories, linear functors |
| ReductiveGroups | 6 | pinned data, pinnings and their existence (Layer 9D after #1676), root data, 2ρ, parabolics and Levi quotients |
| ReductiveGroupsPartII | 6 | RG2.5.1 dual based root datum and Langlands dual group, change of pinning, coweight parity; RG2.1.5 z-extensions |
| SchemeAndStackFoundations | 4 | §§1.15–1.16 torsors, §§1.18–1.20 algebraic stacks, §§2.11, 2.15–2.16 étale units and Tsen |
| JacobianChallenge | 1 | Layers B–C: the Serre duality trace |
| AffineLieAlgebras | 1 | A2.2: the critical level |

EnhancedDerivedSheaves takes its generic quasicategory constructions from BordismFormalGroups F6.5 (its table "From other roadmaps"): the categorical model and functor spaces, marked fibrations and Kan extensions, coherent model diagrams and stable enhancements, and the monoidal, fibration, quotient and Ind sub-lanes.

## Roadmaps that nodes here use as inputs

These roadmaps supply part of a node that is written here; the node's `desc` names them.

| Area | Used by |
|---|---|
| PadicMeasuresIwasawaAlgebras §5.1 "Determinant lines of perfect complexes" (`detLine`); AlgebraicVectorBundles Layer 3 "symmetric and exterior powers, determinant" | `Sheaves.determinant` |
| SchubertGeometry (root-coordinate cells); FlagVarieties (parabolics and projective homogeneous spaces) | `Hecke.schubertStratum_deRhamCohomology_even` |
| JacobianChallenge Layers B, D, E | `Curves.thetaCharacteristic_exists` |
| SchemeAndStackFoundations §1.21 root stacks | `DModules.rootGerbe` |
| ReductiveGroups, ReductiveGroupsPartII, NilpotentOrbits, AffineLieAlgebras, DerivedModuleAlgebra | the nodes whose `desc` names them |

QCoh on derived prestacks, IndCoh, Ψ and singular support, `Bun_G`, `LS_G`, half-twisted D-modules, geometric Satake over the Ran space, the Whittaker and Poincaré constructions have no roadmap owner. They are written here. Open #1630 says explicitly that EnhancedDerivedSheaves does not own QCoh on prestacks.

## Owner candidates

Three open roadmap pull requests would, if accepted, own nodes that the plan writes here. Their nodes are on the "Held" list of `STATUS.md`. All three have the labels `awaiting-review` and `awaiting-dependencies`.

| Pull request | Head | Would own | Limits |
|---|---|---|---|
| #1734 SheafTheoreticSmithTheory §3.0 | `918421742b2f159a00663d66272a7206a62b2280` | the loop Grassmannian of a split reductive group over any field: `Hecke.loopArcGroups`, `Hecke.affineGrassmannian`, `Hecke.affineGrassmannian_reducedComponents`, `Hecke.schubertStratification`, `Hecke.iwahoriWeylGroup`, `Hecke.bottSamelsonResolution`, `Satake.semiInfiniteOrbits`, `Satake.semiInfiniteIntersection_dimension`, the geometric part of `Satake.convolution`; partly `Satake.fusion` and `Hecke.correspondence` | it builds the Beilinson–Drinfeld Grassmannians over `𝔸^J`, not over powers of the curve, so fusion over the chosen curve is not supplied |
| #1687 AnalyticStacks Layers 0–1 | `8b3b4cb179817b67d536ccb7c09aa509bce312cc` | `Sheaves.qcoh`, `Sheaves.qcohGlobalSections`; partly `Derived.formalCompletion` and `LocalSystems.classifyingStack` | it defines sheaves on stacks in the !-topology, not as the plan's right Kan extension along all affine maps; check that `LS_G` and `Bun_G` are in its class of stacks |
| #848 ComplexComparisonPartII §C-1.1 | `a021e44d9bebb9e766285215c49d7a14fc28ce8c` | `Constructible.complexPoints`; partly `DModules.analyticDeRham` | it serves only the complex-analytic part (parity of IC stalks); it covers connections, not holonomic D-modules on singular spaces, so `DModules.schubertRiemannHilbert` is not served |

## Open roadmap proposals checked

Recorded with their heads on 2026-11-10. The accepted roadmap stays the authority until a proposal merges.

- #1676 ReductiveGroups: **merged** on 2026-11-10. Layer 8 is now "split groups and pinnings"; existence and classification of split groups are Layer 9D "classification, relative groups and forms". The plan names these targets by title. #1332 (head `a9e6e773f35589016067d2c3a59668b3d5c9b2c0`) makes Layers 9A–9B the single producer of the Chevalley construction.
- #1901 HigherToposTheory (draft), head `2176cc4c9149c8695dbfdfd5bffac5e090bebb42`: HTT and HA Chapter 1. It proposes to consolidate ownership with EnhancedDerivedSheaves and BordismFormalGroups; it does not yet amend them. An ownership candidate for the `Roadmap/BordismFormalGroups` and `Roadmap/EnhancedDerivedSheaves` nodes.
- #1630 EnhancedDerivedSheaves amendment, head `0514180906fd196b8c53163d24feb7fd07e8f7df`: the DG nerve is primary; QCoh on prestacks is excluded.
- #1330 EnhancedDerivedSheaves E1.6 (draft), head `856fe7ab4dd4005dbc2344f29ebd172779ba80ee`: no effect.
- #868 DerivedDeRhamCohomology, head `2f774a945602f234b84b93257736209b3c1d63df`: explicit models of the cotangent complex and derived de Rham cohomology; a future supplier, not enhanced de Rham stacks.
- #1225 JacobianChallengePartII §1.3a, head `2354d712410964d9da8266bc3c75742623d97a16`: the determinant of curve cohomology in families, the scheme-level input of `Stacks.determinantBundle`.
- #1056 FormalConnectionsOpers, head `4b3f57b0212124b73d2908b191cf03686f193550`: local and formal opers for simple complex groups; not the global `LS_G`.
- #1202 LanglandsParameterStacks, head `1e9f8e83ff3b2bae5e764e108c29309e597e905c`, and #1235 GeometricSatakeAndFusion, head `140b5a7ef0911741962fc87bc1f5b32c7e372e0d`: local ℓ-adic and integral p-adic; not de Rham providers.

PR links are `https://github.com/TauCetiProject/TauCetiRoadmap/pull/<number>`.

## Prior art: AxiomMath Stacks and Weil

AxiomMath Stacks (`5ed82d14634e8d9576bb844c7bd4e3da66d450e7`) and Weil (`27cdb2049be62ee2911429b47f54774078450e32`) are Apache-2.0 and have no `sorry` or `axiom`. They are on older Lean versions (`v4.35.0` and `v4.34.0-rc2`) and cannot be dependencies. They are prior art for ports into Tau Ceti through the Worker, case by case, against an accepted roadmap target, with attribution. No port is made now. When a target becomes ready, check the minimal dependency closure, the actual hypotheses (StacksFrontier is not reviewed, and some of its theorems take unproved inputs as hypotheses), the axioms and the licence.

| Candidate | For | When |
|---|---|---|
| cotangent complex (`StacksFrontier/Cotangent/`, core closure about 9,600 lines) | DerivedModuleAlgebra §0.4, below `Derived.affineCotangentComplex` | when work reaches it |
| two-term determinant `TwoTermDeterminant.det` (about 18,200 lines) | `Stacks.determinantBundle` | when work reaches it |
| complex points `AlgebraicGeometry.Scheme.ComplexPoints` (Weil, about 40 lines) | `Constructible.complexPoints` | only if the owner keeps the complex-analytic route to parity |
| Stacks 03RM (vanishing of `H^q(X_et, 𝐆_m)`, closure about 1.2 million lines) | `Etale.curve_splitTorus_h2_zero` | no port |

## Limits of existing providers

- The Tannakian reconstruction API starts from a given Hopf algebra. Constructing the Hopf algebra from the spherical category is a separate Satake obligation.
- A local or p-adic Satake roadmap is not a de Rham provider.
- A planned theorem is not evidence that its proof source is complete.
