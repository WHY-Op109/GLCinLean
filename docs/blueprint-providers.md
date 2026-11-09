# Provider audit, 2026-11-09

## Evidence revisions and access

- Mathlib pinned: `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`.
- Tau Ceti pinned: `e0610cce4004d628cbd9d2aafdbbb5459fe72938`.
- Tau Ceti main checked via GitHub API: `7ca783d4c8d324c9c74efaacd641c8a40f69f284`.
- TauCetiRoadmap main checked: `f7dd719a392f7b65ad30ef45b26c344d08ba5f91`.
- Full source snapshots at these revisions were searched, not merely tree filenames. The open-roadmap query returned 476 pull requests. No pins changed and no external writes.
- Read Tau Ceti `AGENTS.md` and `COORDINATION.md`. New mathematics must advance an existing roadmap target or its genuine prerequisite; no new roadmap PR/issue may be opened by the agent. Improvements to existing code are allowed. Main contributions through Worker, from the user's fork, under those rules.

## Existing leaves written

`plans/Mathlib/**` and `plans/TauCeti/**` now contain 49 declarations across their actual module paths (including two identified only on main), with paper locators, provider information, both checked revisions, and `deps=[]` at the supplied interface boundary.

These plans name upstream declarations, never wrappers. Their `desc` explicitly distinguishes the ordinary and strict APIs from the paper's enhancements. Tracker attachment depends on imports; a leaf not imported by GLCinLean may display as open despite existing in upstream source. The written `kind`/`desc`/`deps` remain deliberately available even when superseded, to meet the owner's provenance requirement.

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
| Dual based root datum and actual dual group | `ReductiveGroupsPartII` RG2.5.1, targets `dual-based-root-datum`, `dual-group`; consumes ReductiveGroups Layers 7–9 | Construct integral dual, base-change to k, prove root-datum identification and examples |
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

- #908 EnhancedDerivedSheaves is **merged**, closed. Existing Foundations prose calling it a roadmap number should identify the merged roadmap, not imply open proposal.
- #785 ReductiveGroupsPartII is **merged**, closed. Its dual-group scope applies even though other layers concern local fields.
- #1901 HigherToposTheory is open, head `2176cc4c9149c8695dbfdfd5bffac5e090bebb42`: HTT and HA Chapter 1. It proposes ownership consolidation with EnhancedDerivedSheaves/BordismFormalGroups; it does not yet amend those owners. Treat it as an ownership candidate, not competing code to implement in parallel.
- #1630 EnhancedDerivedSheaves amendment is open, head `9158199623fb90bf2d947b397ea8040839fc4352`: DG nerve is primary, module spectra comparison is later; QCoh on prestacks explicitly excluded.
- #1330 EnhancedDerivedSheaves regularity supplier amendment is open, head `856fe7ab4dd4005dbc2344f29ebd172779ba80ee`; not a prerequisite for the characteristic-zero statement's generic enhancement merely by being related.
- #868 DerivedDeRhamCohomology is open, head `2f774a945602f234b84b93257736209b3c1d63df`: explicit models for cotangent/derived de Rham, compatible ordinary derived-category contracts; useful future supplier, not present enhanced de Rham stacks.
- #1056 FormalConnectionsOpers is open, head `19335eca722c768fd2e2df83f631c05e920d2f33`: formal/local connection and oper geometry. Do not count it as the global LS_G construction.
- #1202 LanglandsParameterStacks open, head `1e9f8e83ff3b2bae5e764e108c29309e597e905c`: local ℓ-adic parameter stacks. #1235 GeometricSatakeAndFusion open, head `140b5a7ef0911741962fc87bc1f5b32c7e372e0d`: integral p-adic Satake. Generic reusable pieces need scope and comparison checks, not title matching.

Permanent source links use https://github.com/TauCetiProject/TauCeti/blob/7ca783d4c8d324c9c74efaacd641c8a40f69f284/... and https://github.com/TauCetiProject/TauCetiRoadmap/blob/f7dd719a392f7b65ad30ef45b26c344d08ba5f91/TauCetiRoadmap/... . PR links are https://github.com/TauCetiProject/TauCetiRoadmap/pull/<number> .

## Proposed owner decisions, with reasons

1. **Open roadmap PRs:** record exact PR/head and use their descriptions as design evidence. Keep the current accepted roadmap as implementation authority until the proposal merges or its scope is explicitly approved by the roadmap owner. Implement existing accepted targets and prerequisites through Tau Ceti Worker. Never import Suggested.lean or treat its sorry-containing declarations as proved. Never bump dependency pins to proposal branches. Recheck state before starting implementation; merge ownership changes first to avoid duplicate APIs.
2. **Other Lean libraries:** permit read-only discovery and reuse of ideas/proofs under compatible licenses; before adding a dependency require a concrete inventory of declarations, license, Lean/Mathlib pin compatibility, trust/axiom audit, maintenance and interoperability. Prefer porting accepted reusable mathematics through Tau Ceti where its roadmap owns it; keep other GLC material here. No new dependency is needed merely for this blueprint, and no library should become an alternate parallel Scheme/Category universe without proven comparison.
3. **Infinity layer:** retain quasicategorical semantics and construct the required presentable stable k-linear/module categories on existing Mathlib SSet and Tau Ceti DG nerve/K-injective models. Keep only explicitly marked statement placeholders while those providers are missing. Prove all mapping-space and coherent monoidal/module comparisons before removing them. Ordinary DerivedCategory and strict DG enrichment are valuable models but do not prove enhanced equivalence or uniqueness. Track #1901's ownership consolidation and #1630's concrete construction order; do not start an independent foundations project that duplicates their accepted targets.

## Findings in the former Abstract/Foundations draft (corrected in the candidate)

- Foundations re-export abbreviations violate the project's ban on thin wrappers. Use canonical provider names directly and a genuine coordinate-ring-to-pinning bridge only if absent upstream.
- `DGCat` must depend on the coefficient field; the current Type0 carrier loses k and universe information.
- A monoidal category and actions on both categories must be explicit data; `LinFun A C D` cannot encode these from a bare category A.
- A t-structure is additional data, not available for every DG category by magic. Eventual coconnectivity must use IndCoh's actual standard t-structure.
- Root datum duality of arbitrary reductive groups is missing. Adding a theorem `exists_dualGroup := sorry` introduces an extra sorry and cannot serve as nonvacuity evidence. Keep honest placeholder scope and plan the real existence theorem; any replacement requires actual examples.
- As instructed by owner, statement should assert existence of a characterized functor and equivalence for EVERY characterized functor. Choosing LG from an unproved existence theorem makes the definition depend on sorryAx.

## Follow-up library-plan audit


Edited 39 declaration records in 29 library plan files (no statement, Lean or documentation edits). Corrected roadmap ownership and exact targets for enhancement, presentability, module categories, derived vector spaces, internal Hom, animated algebras, general reductive root data, dual groups, pinning, torsors and root gerbes. Kept global derived-stack extensions explicitly separate from providers that only cover affines or classical schemes.

Added missing dependency nodes for enhanced affine modules, affine cotangent complexes, ordinary algebraic stacks, classical-scheme enhanced QCoh and the curve Serre trace. Connected concrete DG nerve/K-injective providers, t-structures, root data, pinnings, torsors and invertible sheaves to their consumers. Two planned local wrapper nodes were removed entirely: dualRootDatum now consumes RootPairing.flip/Base.flip; adjointRepresentation now consumes Derivation.adjointComodule and TauCeti.Comodule.dual directly.

Added four provider leaves, of which two are newly identified on main only: TauCeti.adjointInvariantPolynomials and TauCeti.nilpotentConeIdeal, both in Algebra/AlgebraicGroup/Tangent/Lie/Adjoint/NilpotentCone.lean. They retain scheme-theoretic invariant zero fibres including central invariants. They do not justify equating nilpotence with ad-nilpotence for all reductive groups. Both leaf records state that the project pin lacks them and a later pin move requires a published cache. No pin moved.

Validated all 200 planned IDs for duplicates, all dependency references, all dependency cycles, and all external planned module paths against pinned or explicitly checked main source. Original external declaration names and namespaces were inspected from their source; the four new names were also checked in their defining files. This is a static validation, not a replacement for tracker lint or Lean build.
