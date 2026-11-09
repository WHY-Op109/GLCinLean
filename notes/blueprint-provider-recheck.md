# Static provider audit, 2026-11-09

Read-only checks of new supplier declarations against the checked source snapshots; no upstream build was run. Project pins were confirmed from both `lake-manifest.json` and package Git HEAD: Mathlib `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`, Tau Ceti `e0610cce4004d628cbd9d2aafdbbb5459fe72938`. Main source snapshot: `/tmp/glc-revision-tauceti` at `1e668f5e55bc20f2eb87f4ba49b48833470290d1` (extracted snapshot, without Git metadata); roadmap `000abc149867f86a79d9708294c89af6b42c37a6`.

## Exact declarations

All 14 new upstream leaves in the 340-node working-tree snapshot have the stated declaration name in the actual module. Source line numbers below are declaration starts. Tau Ceti rows use a path relative to TauCeti; Mathlib rows relative to Mathlib.

| Declaration | Module file | Pin line | Main line |
|---|---|---:|---:|
| `LieAlgebra.ofTwoCocycle` | `Algebra/Lie/Extension.lean` (Mathlib) | 135 | — |
| `killingForm` | `Algebra/Lie/TraceForm.lean` (Mathlib) | 374 | — |
| `TauCeti.Tannaka.pointsFunctorIsoTensorAutFunctor` | `Algebra/AlgebraicGroup/Representation/Tannaka/GroupFunctor.lean` | 138 | 138 |
| `TauCeti.currentAlgebra` | `Algebra/Lie/Current/Basic.lean` | 67 | 74 |
| `TauCeti.CurrentAlgebra.twoCocycleOfBilinear` | `Algebra/Lie/Current/ResidueCocycle.lean` | 285 | 308 |
| `TauCeti.CurrentAlgebra.IsSmooth` | `Algebra/Lie/Current/SmoothAction.lean` | 103 | 109 |
| `TauCeti.CurrentAlgebra.CompletedEnveloping` | `Algebra/Lie/Current/Completion.lean` | 132 | 135 |
| `TauCeti.smoothModules` | `Algebra/Category/ModuleCat/Smooth/Basic.lean` | 96 | 96 |
| `TauCeti.CurrentAlgebra.smoothModulesEquivalence` | `Algebra/Lie/Current/CompletedModules.lean` | absent | 78 |
| `TauCeti.twoWeylVector` | `LinearAlgebra/RootSystem/Weyl/Vector.lean` | 120 | 119 |
| `TauCeti.coroot'_twoWeylVector_eq_two_mul_height_flip` | `LinearAlgebra/RootSystem/Weyl/Vector.lean` | 172 | 171 |
| `AlgebraicGeometry.Scheme.Modules.finiteDimensional_cohomology_of_smooth` | `AlgebraicGeometry/Curves/Cohomology.lean` | 158 | 159 |
| `AlgebraicGeometry.Scheme.Modules.subsingleton_cohomology_of_two_le_of_smooth` | `AlgebraicGeometry/Curves/Cohomology.lean` | 148 | 149 |
| `TauCeti.AlgebraicGeometry.cohomologyBaseChangeLinearEquiv` | `AlgebraicGeometry/Cohomology/FlatBaseChange.lean` | 241 | 288 |

The root-level `killingForm` name is correct: `section LieAlgebra` at TraceForm.lean:369 is a section, not a namespace. The source distinguishes `LieAlgebra.ofTwoCocycle` (carrier, Extension.lean:135) from `LieAlgebra.Extension.ofTwoCocycle` (bundled extension, line243).

## Issues found and routed

1. The earlier new `SpectralProof.affineExtension` node would have been a local wrapper around the existing residue cocycle and Mathlib `LieAlgebra.ofTwoCocycle`. `SpectralProof.smoothLevelModules` also repeated existing ordinary smooth-module APIs. Sent exact providers to the owning spectral agent. At the last read, that agent removed both nodes and added the genuine supplier leaves above. `sphericalKL` remains the missing enhanced factorization category, which these ordinary suppliers do not provide.
2. At first read `TauCeti.currentAlgebra` deferred its pin availability to tracker. Actual source verifies it at the pin. This and the residue cocycle can be described explicitly as pinned. No pin movement is needed for them. The completed smooth-module equivalence is genuinely main-only and is labeled so.
3. Bibliography keys missing during the concurrent snapshot were `GenVan`, `GeometricConstantTerm`, `FactorizableDerivedSatake`, `LoopGrassmannianExt`. Those four keys and `StacksProject` have now been added to the bibliography.

No duplicate local wrapper remains among the checked provider consumers at the final read. No nonexistent declaration or wrong module was found.

## All-plan metadata and graph scan

At that intermediate scan: 340 declarations, 138 new relative to the baseline HEAD. Every node has nonempty `desc` and `source`, an explicit `deps` field, a `Provider:` marker and a 40-digit source-check hash. Every new node is reachable from `Statement.exists_isLanglandsFunctor_and_isEquivalence` through the planned dependency graph. No duplicate IDs, unresolved plan dependency IDs or cycles were found in the preceding full graph scan. Existing example/API nodes outside the main theorem's direct closure were not treated as disconnected errors.

## Fresh P1 reviewer repair

Root requested a repair after the fresh reviewer noticed that `Stacks.unipotentTorsorFiltration` cited `Curves.serreTrace` for arbitrary vector-bundle cohomology. That objection is correct. The trace of H1(omega) does not supply H0/H1 finiteness or H2 vanishing for all quotient bundles.

I added the three existing provider declarations in the last three rows above to two supplier module plans, and replaced the `Curves.serreTrace` dependency in `plans/GLCinLean/AlgebraicGeometry/Stacks/UnipotentTorsors.toml`. Its description now explicitly uses arbitrary coefficient sheaves, ordinary/enhanced cohomology comparison and flat base change on affine test schemes, so the finite-dimensional calculation governs families of torsors rather than only k-points. No local theorem duplicates the suppliers.

The curve results apply over every field, with smoothness, properness and connectedness; finiteness assumes quasi-coherence and finite type, while degree≥2 vanishing needs only quasi-coherence. The base-change supplier assumes quasi-compactness, affine diagonal and flat base-ring map, all satisfied for a proper curve and any k-algebra. Both curve suppliers and base change already exist at the project pin.

Searched the roadmap too: JacobianChallenge Layer B owns curve finiteness/vanishing; Layer C owns the stronger proper-Noetherian-base finiteness (not yet in the checked `Cohomology/Proper.lean`, which does not exist). SchemeAndStackFoundations §2.5 owns general Noetherian dimension vanishing, and §2.6 the flat base-change contract. Those broader missing targets need not be rebuilt for this curve application.

Primary sources checked online: Stacks Project Lemma30.19.2 (02O6), Prop20.20.7 (02UZ), Lemma30.5.2 (02KH). New bibliography metadata: key `StacksProject`, author `{The Stacks Project Authors}`, title `{The Stacks Project}`, URL `https://stacks.math.columbia.edu/`, note `Tags 02O6, 02UZ, 02KH; accessed 2026-11-09`. Official pages: https://stacks.math.columbia.edu/tag/02O6 , https://stacks.math.columbia.edu/tag/02UZ , https://stacks.math.columbia.edu/tag/02KH .

No Lean changes or pushes. The completed-tree validation is recorded in STATUS.md.

## Final Ran supplier addition

The revision also adds `HomologicalComplex.isIso_homologyKunneth_of_isSplitMono_of_isSplitEpi`
in `TauCeti/Algebra/Homology/Monoidal/Homology/Kunneth/Basic.lean`, line 272 at both pin and
checked main. Its split-cycle and split-homology hypotheses hold for complexes of vector
spaces. This supplies the algebraic homology-of-tensor step in the Ran contractibility proof,
not geometric integration. The fresh reviewer independently checked both source revisions.
At this stage there were 15 new direct suppliers, 64 total; the 340-node scan above is a historical
intermediate snapshot, not the final blueprint count. Final graph and tracker results are
recorded in STATUS.md.

## Etale-cohomology suppliers for reductive descent

The z-extension repair adds two existing Mathlib interfaces, independently checked by the
author and fresh reviewer at the unchanged Mathlib pin:

| Declaration | Actual Mathlib module | Line | Scope |
|---|---|---:|---|
| `CategoryTheory.Sheaf.H` | `CategoryTheory/Sites/SheafCohomology/Basic.lean` | 57 | Ext cohomology of an abelian sheaf, retaining sheafification/Ext assumptions |
| `AlgebraicGeometry.Scheme.smallEtaleTopology` | `AlgebraicGeometry/Sites/Etale.lean` | 50 | topology on the small etale site |

The multiplicative-group sheaf and Tsen/higher curve vanishing are still roadmap work under
SchemeAndStackFoundations §§2.11, 2.15–2.16. These leaves do not provide those theorems. There
are now 17 new supplier declarations and 66 in total. Earlier counts in this note identify
intermediate snapshots. No dependency pin changed.
