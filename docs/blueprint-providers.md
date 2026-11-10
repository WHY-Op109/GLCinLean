# Provider audit, 2026-11-09

## Evidence revisions and access

- Mathlib pinned: `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`.
- Tau Ceti pinned: `e0610cce4004d628cbd9d2aafdbbb5459fe72938`.
- Original Tau Ceti code audit: `7ca783d4c8d324c9c74efaacd641c8a40f69f284`.
- Revision-session main snapshot: `1e668f5e55bc20f2eb87f4ba49b48833470290d1`. New and repaired nodes record that search; unchanged nodes retain their original audit commit.
- Original roadmap audit: `f7dd719a392f7b65ad30ef45b26c344d08ba5f91`; revision-session snapshot: `000abc149867f86a79d9708294c89af6b42c37a6`.
  The README files for ReductiveGroups, ReductiveGroupsPartII, EnhancedDerivedSheaves, BordismFormalGroups, SchemeAndStackFoundations, DGAInfinity and JacobianChallenge are byte-identical between those snapshots.
- Full source snapshots at these revisions were searched, not merely tree filenames. The open-roadmap query returned 476 pull requests. No pins changed and no external writes.
- Read Tau Ceti `AGENTS.md` and `COORDINATION.md`. New mathematics must advance an existing roadmap target or its genuine prerequisite; no new roadmap PR/issue may be opened by the agent. Improvements to existing code are allowed. Main contributions through Worker, from the user's fork, under those rules.

## Existing leaves written

`plans/Mathlib/**` and `plans/TauCeti/**` name 70 existing upstream declarations in their actual defining modules, never wrappers, each with its paper locator and checked revisions. Their `desc` says where each falls short of the paper's enhanced object. A leaf that GLCinLean does not import shows as open in the tracker although it exists upstream.

- Three leaves exist on Tau Ceti main but not at the pin: `TauCeti.adjointInvariantPolynomials` and `TauCeti.nilpotentConeIdeal` (`Algebra/AlgebraicGroup/Tangent/Lie/Adjoint/NilpotentCone.lean`), and `TauCeti.CurrentAlgebra.smoothModulesEquivalence` (`Algebra/Lie/Current/CompletedModules.lean`). Using them needs a pin move to a commit with a published cache. The first two keep scheme-theoretic invariant zero fibres, including central invariants; they do not show that nilpotence equals ad-nilpotence for every reductive group.
- Three Tau Ceti leaves were checked at the pin `e0610cce4004d628cbd9d2aafdbbb5459fe72938` only, not on main: `TauCeti.reductiveCommHopfAlgProperty_iff_linearlyReductive`, `TauCeti.simplyConnectedSemisimpleCommHopfAlgProperty` and `TauCeti.Pinning.comapOfIso`.

Important existing interfaces:

- `Field`, `CharZero`, `IsAlgClosed`; `AlgebraicGeometry.Scheme`, `Spec`, `SmoothOfRelativeDimension`, `IsProper`; `ConnectedSpace` includes nonemptiness.
- `TauCeti.ReductiveAffineGroupSchemeCat`, `FiniteTypeCommHopfAlgCat`, `finiteTypeCommHopfAlgCatOpEquivFiniteTypeAffineGroupSchemeCat`, `SplitMaximalTorus`, `Pinning`.
- `TauCeti.AlgebraicGeometry.InvertibleSheaf`, `.tensorProduct`, `AlgebraicGeometry.Scheme.relativeDifferentials`.
- `RootPairing`, `RootDatum`, `RootPairing.flip`, `.Equiv`, `.Base`, `.Base.flip`. These provide abstract root data, not extraction/classification of arbitrary reductive groups. Concrete families have root data (GL, SL, PGL, symplectic, exceptional families); do not mistake these for general extraction.
- `SheafOfModules.IsQuasicoherent` and `AlgebraicGeometry.Scheme.Modules` are ordinary sheaves.
- `CategoryTheory.Pseudofunctor.IsStack`, `TauCeti.AlgebraicGeometry.SchPseudofunctor`, `CategoryTheory.Sheaf.Torsor` (last defined in Tau Ceti) provide ordinary stack/torsor precursors.
- `CochainComplex`, `DerivedCategory`, `DerivedCategory.TStructure.t`, `CategoryTheory.Triangulated.TStructure`.
- `SSet.Quasicategory`, `SSet.QCat` and its existing bicategory.
- `TauCeti.DGCategory` is strict enrichment in cochain complexes, `TauCeti.dgHomComplex` its Hom complex.
- **Already implemented at the pin:** `TauCeti.dgNerve` (`AlgebraicTopology/DGNerve/Basic.lean`), its quasicategory instance (`Quasicategory.lean`), `TauCeti.dgNerve.homotopyCategoryEquiv`, `TauCeti.KInjectiveDGCategory`, `TauCeti.KInjectiveDGCategory.dgNerveHomotopyCategoryEquiv`, `SSet.rightMappingSpace`. Do not plan to construct these again.

## Roadmap ownership, exact useful sections

All below are on roadmap main unless explicitly marked open PR. Existence of a roadmap is not existence of code.

| Ingredient | Provider / target | Remaining gap |
|---|---|---|
| General reductive root datum, Borel, pinning, Chevalley existence | `ReductiveGroups` Layers 7, 8, 9B | General extraction and classification still needed; concrete family implementations insufficient |
| Dual based root datum and actual dual group | `ReductiveGroupsPartII` RG2.5.1, targets `dual-based-root-datum`, `langlands-dual-group`; consumes ReductiveGroups Layers 7–9 | Construct integral dual, base-change to k, prove root-datum identification and examples |
| Curve differentials and canonical bundle | `AlgebraicCurves` Layer 9 (Kahler differentials, residues, comparison), plus JacobianChallenge and existing Modules/Differentials/Canonical.lean | Theta characteristic as data is possible now; geometric square roots and determinant constructions are further work |
| Sheaf torsors and contracted products | `SchemeAndStackFoundations` §§1.15–1.16 | Upgrade actual sheaf torsor API to moduli and twisting needed by Bun |
| Ordinary algebraic stacks, atlases, quotients | `SchemeAndStackFoundations` §§1.18–1.22 | Stackification/2-fiber products, algebraic stack conditions, QCoh on stacks; ordinary precursors do not give derived stacks |
| Scheme derived QCoh | `SchemeAndStackFoundations` §2.18, `DQCoh`, `DQCoh.affineEquiv`, `DQCoh.restrict`, `torIndependent_baseChange` | Ordinary derived-category API and proof contracts |
| Generic quasicategory operations | `BordismFormalGroups` §F6.5, as explicitly cited by EnhancedDerivedSheaves E0.1–E0.5 | Existing quasicategories, mapping spaces, DG nerve are available; many coherent universal constructions remain |
| Enhancement and DG nerve comparisons | `EnhancedDerivedSheaves` E0.6, E1.1–E1.4; E0.8 for accessibility | Reuse already present DG nerve/K-injective comparison rather than rebuild |
| Enhanced scheme QCoh and Perf | `EnhancedDerivedSheaves` E1.8, `QuasicoherentDerived`, `PerfectDerived`, `quasicoherentDerived_affine` | Not a provider of QCoh on arbitrary derived prestacks |
| Stable colimits, continuity, adjoints | `EnhancedDerivedSheaves` E3.1–E3.3; `exact_preservesColimits_iff_coproducts`, `rightAdjoint_preservesCoproducts_iff` | Enhanced proofs and compactness comparisons |
| Coherent symmetric monoidal categories, algebras/modules | `EnhancedDerivedSheaves` E5:abstract.1–.4 | Needed for k-linearity, QCoh-module categories and linear functors |
| Ind-completion, presentability, compact generation, tensor | `EnhancedDerivedSheaves` E5:presentability.1–.4 | The paper's DGCat needs these structures, not ordinary enrichment alone |
| Animated commutative algebras | `EnhancedDerivedSheaves` E5:animation.1–.4 | Must retain derived structure; discrete algebras are not enough |
| Cotangent complex of animated rings | `EnhancedDerivedSheaves` E5:cotangent-export.1–.2; supplier `DerivedModuleAlgebra` and open #868 | Needed for quasi-smoothness and scheme of singularities |
| Global derived prestacks, de Rham prestack, QCoh by right Kan extension | Missing as a global GLC provider | #1630 explicitly says QCoh on prestacks is NOT owned by EnhancedDerivedSheaves; new board target name is not an accepted roadmap |
| IndCoh, Ψ, singular support on quasi-smooth derived stacks | Missing as a GLC provider | No matching code found; must develop here unless accepted precise roadmap target covers it |
| Bun_G, global de Rham LS, half-twisted Dmodules | Missing global constructions | Ordinary stack foundations may route prerequisite work to Tau Ceti, but global GLC constructions stay here |
| Geometric Satake / spectral action for de Rham curve | Missing applicable global provider | Open #1235 is integral p-adic Satake, not automatically de Rham Satake; #1202 is local ℓ-adic parameter stacks |
| Whittaker evaluation, exponential Dmodule, vacuum Poincare, coarse Langlands | Missing GLC constructions | GeometricRepresentationCategories R1–R5 addresses a local critical-level categorical lift; explicitly excludes unqualified global GLC |

## Open roadmap proposals checked

- #908 EnhancedDerivedSheaves is **merged**, closed.
- #785 ReductiveGroupsPartII is **merged**, closed. Its dual-group scope applies even though other layers concern local fields.
- #1901 HigherToposTheory is open, head `2176cc4c9149c8695dbfdfd5bffac5e090bebb42`: HTT and HA Chapter 1. It proposes ownership consolidation with EnhancedDerivedSheaves/BordismFormalGroups; it does not yet amend those owners. Treat it as an ownership candidate, not competing code to implement in parallel.
- #1630 EnhancedDerivedSheaves amendment is open, head `ae7b6e6ab35c7f479b869e3d120765d452b7b77e`: DG nerve is primary, module spectra comparison is later; QCoh on prestacks explicitly excluded.
- #1330 EnhancedDerivedSheaves regularity supplier amendment is open, head `856fe7ab4dd4005dbc2344f29ebd172779ba80ee`; not a prerequisite for the characteristic-zero statement's generic enhancement merely by being related.
- #868 DerivedDeRhamCohomology is open, head `2f774a945602f234b84b93257736209b3c1d63df`: explicit models for cotangent/derived de Rham, compatible ordinary derived-category contracts; useful future supplier, not present enhanced de Rham stacks.
- #1056 FormalConnectionsOpers is open, head `d4bae7ce50e8fa1e08d9e1b91abacc4beacb721a`: formal/local connection and oper geometry. Do not count it as the global LS_G construction.
- #1202 LanglandsParameterStacks open, head `1e9f8e83ff3b2bae5e764e108c29309e597e905c`: local ℓ-adic parameter stacks. #1235 GeometricSatakeAndFusion open, head `140b5a7ef0911741962fc87bc1f5b32c7e372e0d`: integral p-adic Satake. Generic reusable pieces need scope and comparison checks, not title matching.

The final review observed #1056 advance from `ccaed5e19b5e7e0d5e967ce24b2d1f8ca5f20201`
to `d4bae7ce50e8fa1e08d9e1b91abacc4beacb721a` on 2026-11-09 and inspected the
[intervening diff](https://github.com/TauCetiProject/TauCetiRoadmap/compare/ccaed5e19b5e7e0d5e967ce24b2d1f8ca5f20201...d4bae7ce50e8fa1e08d9e1b91abacc4beacb721a).
It remains a local/formal proposal. Its intrinsic oper groupoids retain central automorphisms;
Drinfeld–Sokolov coefficient functors are distinct, even for a torus. The current normalized
local-oper plan does not identify these two notions. The amendment also limits its Kac–Moody
comparison to complex points and distinguishes coefficient-etale from coefficient-fpqc
triviality. None of this supplies global local-system stacks or changes an accepted provider.

The original audit's immutable source links use https://github.com/TauCetiProject/TauCeti/blob/7ca783d4c8d324c9c74efaacd641c8a40f69f284/... and https://github.com/TauCetiProject/TauCetiRoadmap/blob/f7dd719a392f7b65ad30ef45b26c344d08ba5f91/TauCetiRoadmap/... . PR links are https://github.com/TauCetiProject/TauCetiRoadmap/pull/<number> .

## Limits of existing providers

- The existing Tannakian reconstruction API starts from a supplied Hopf algebra. Constructing the Hopf algebra from the spherical category is a separate Satake obligation.
- A local or p-adic Satake roadmap is not a de Rham provider.
- A planned theorem is not evidence that its proof source is complete.
