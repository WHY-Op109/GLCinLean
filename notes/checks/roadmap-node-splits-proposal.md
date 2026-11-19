# Proposal: splits of three roadmap nodes

Branch `proposal/roadmap-node-splits`, made from `main` at `d765a3c`. Steps 1 and 2 of `prompts/change.md`. Sources read: TauCetiRoadmap `main` at `7f401c6592e98ce8838cccac1ef6f567fc408ea4` (2026-11-19; the READMEs of EnhancedDerivedSheaves, GeneralizedCohomology and HermitianKTheoryOfPoincareCategories are the same files as at `1b7b481a`, the revision of the last audit), Tau Ceti at the pin `d91980bd` and Mathlib at `fc4f59e5` (`.lake/packages/`), and the papers in `references/papers/`. Line numbers of a README are those of the file at that revision.

Round 1 changed the branch after this text was written. `notes/checks/roadmap-node-splits-answers-1.md` lists the changes. Sections 5 and 6 are current. Sections 1 to 4 and 7 describe `3a53622`; the comparison node they name `Derived.commutativeAlgebraEquivConnectiveCommAlg` is now `Derived.commutativeAlgebraToConnectiveCommAlg`.

## Summary

Two of the three splits are made on the branch. The third is not made.

1. **`Derived.commutativeAlgebra`: split.** The node is now the category of the animated commutative k-algebras (EnhancedDerivedSheaves E5:animation.1, `animatedAlgebras`). The new node `Derived.commutativeAlgebraEquivConnectiveCommAlg` holds the comparison with the connective commutative algebra objects of the derived category (E5:animation.4, `animatedToCAlg`). The roadmap states the two as separate targets with different needs lines. `Derived.affineScheme` and `Derived.Prestack` have 6 roadmap nodes in their longest chain, in place of 9.
2. **The t-structure of the enhanced derived category: split.** The new node `Infinity.enhancedDerivedCategoryTStructure` holds the t-structure clauses of `Infinity.enhancedDerivedCategory` and of `Infinity.derivedVect`. `Infinity.tStructure` is no longer below `Infinity.enhancedDerivedCategory`. The chains through the enhanced derived category are one node shorter.
3. **`Infinity.dualizableCategory`: not split.** The roadmap states the definition and its theorems in one passage with one needs line. The split would shorten the chain of at most one node, by one. As described, it would also need a third node, because one clause of the node presupposes `Infinity.rigidMonoidalCategory`, which depends on the node.

The longest chain of roadmap nodes is 10, in place of 11. The plan has 311 planned declarations in 198 module plans, 90 of them roadmap nodes. `lake exe tracker lint` has no errors, `python3 tools/check-module-cycles.py` finds no cycle, and `python3 tools/check-upstream-names.py` confirms all 261 pairs. No Lean file changes. A checker has not yet checked the branch.

## 1. The problem

Tau Ceti forbids stacked pull requests. So each dependency between two nodes of `plans/Roadmap/` costs one wait for a merge in Tau Ceti's queue. On `main` the longest chain of roadmap nodes has 11 nodes, and 190 of the 221 nodes written here have a chain of 9 or more roadmap nodes below them.

Three roadmap nodes hold two things with different prerequisites. Every user of the cheap part then waits for the expensive part:

- `Derived.commutativeAlgebra` holds the category of derived commutative algebras and its comparison with commutative DG algebras. `Derived.affineScheme` and, through it, `Derived.Prestack` and 188 nodes written here are above it.
- `Infinity.enhancedDerivedCategory` and `Infinity.derivedVect` hold a stable category and its t-structure. The t-structure clause puts `Infinity.tStructure` below every user of the two nodes.
- `Infinity.dualizableCategory` holds a definition and three theorems. One proof uses `Infinity.internalHom`.

A split changes what a node states, so each is a big change ("Small and big changes" in `AGENTS.md`). A split is right only when the roadmap states the two parts as separate targets or passages with different needs.

## 2. Evidence

### 2.1 The node texts on `main` (`d765a3c`)

- `Derived.commutativeAlgebra` (`plans/Roadmap/EnhancedDerivedSheaves/AnimatedRings.toml`, lines 3–8): “Connective commutative derived k-algebras with actual homotopy-coherent maps; in characteristic zero compare nonpositive commutative DG algebras. Provider: roadmap EnhancedDerivedSheaves, “Sifted colimits and animation” and “Animated rings as commutative algebras and their modules”.” Dependencies: `Infinity.monoidalCategory`, `Infinity.linearCategory`, `Infinity.derivedVect`, `Infinity.moduleCategory`. Source: [AGKRRV] §§0.9.3, 0.9.6.
- `Derived.affineScheme` (same file, lines 10–15): “Opposite of connective commutative derived k-algebras, with classical truncation and the affine embedding. Provider: roadmap EnhancedDerivedSheaves, “Animated commutative algebra”.” Dependency: `Derived.commutativeAlgebra`.
- `Infinity.enhancedDerivedCategory` (`EnhancedDerived.toml`, lines 3–8), the clause on the t-structure: “For A = `SheafOfModules R`, with R a sheaf of rings on a small site, not assumed commutative, D∞(A) has in addition the t-structure (Infinity.tStructure) that this equivalence carries to the standard t-structure of `DerivedCategory A` (`DerivedCategory.TStructure.t`); its heart is A.” Its check: “for A the modules over a ring R, the homotopy category is the derived category of R-modules, and the heart is the R-modules”. Its provider text: “The t-structure is of §0.1 “Enhanced derived sheaf categories” …”. Dependencies: `Infinity.stableCategory`, `Infinity.homotopyCategoryPretriangulated`, `Infinity.tStructure`.
- `Infinity.derivedVect` (`Vect.toml`, lines 3–8): “Enhanced localization of complexes of k-vector spaces at quasi-isomorphisms, with derived tensor product and standard t-structure. …”. It has no dependency on `Infinity.tStructure` of its own; it has it through `Infinity.enhancedDerivedCategory`.
- `Infinity.dualizableCategory` (`Dualizable.toml`, lines 3–8): “Dualizable objects of presentable k-linear categories under tensor product, with evaluation/coevaluation, triangle identities and Funct_cont(C,D)=C^vee tensor D. Prove compactly generated categories dualizable and retracts dualizable; for modules over a rigid monoidal category, prove the dualizable relative-tensor functor preserves limits. Provider: roadmap EnhancedDerivedSheaves, “Dualizable, compactly assembled and rigid categories” and “Stable monoidal structures”.” Dependencies: `Infinity.presentableCategory`, `Infinity.moduleCategory`, `Infinity.internalHom`, `Infinity.compactGeneration`. Source: [DG2] §§4.1, 4.3; [GRQCoh] proof of Proposition 3.5.3.
- `Infinity.rigidMonoidalCategory` (`Rigid.toml`) depends on `Infinity.dualizableCategory`. Its text: “A is dualizable as a V-module …”, and “As a sufficient criterion over derivedVect, prove that compact generation by tensor-dualizable compact objects with compact unit implies rigidity.”

### 2.2 The roadmap, for split 1 (EnhancedDerivedSheaves README)

- Line 1937, E5:animation.1, **Animated commutative rings** (`animatedAlgebras`): “For a commutative ring `R, Poly_R` is the category of polynomial R-algebras `R[x₁, …, x_n]` (Mathlib's `MvPolynomial (Fin n) R`) and all R-algebra maps, and `AnimAlg_R = PΣ(Poly_R)`. … Ordinary R-algebras form a full subcategory (the discrete objects), whose inclusion has left adjoint `π₀`.” Line 1939: “Provide `animatedAlgebras`, `animatedDiscrete`, `animatedPiZero` and `animatedPushout`.”
- Line 1947, its needs: “`nonabelianDerived`; `animationExtension`; the supplied localization universal property; Mathlib `MvPolynomial`, `CommRingCat`, `CategoryTheory.SimplicialObject`.”
- Line 1925, the needs of `nonabelianDerived` (line 1915): “`IsSiftedInfinity`; `PrL`; `accessibleLocalization`; `leftKanExtension_restrict_trivialFibration`.” Line 1935, the needs of `animationExtension` (line 1927): “`nonabelianDerived`; `leftKanExtension_restrict_trivialFibration`.” Line 1913, the needs of `IsSiftedInfinity`: “`IsFinal`; E0.1's supplied cone categories; `final_fibre_inclusion`; `leftKanExtension_restrict_trivialFibration`; Mathlib `CategoryTheory.IsSifted`.”
- Line 1996, E5:animation.4, **Animated rings and connective commutative algebras** (`animatedToCAlg`): “There is a sifted-colimit-preserving functor `θ : AnimAlg_R → CAlg(D(R)_{≥0})` extending the inclusion of polynomial R-algebras as discrete commutative algebras. It is an equivalence when R contains `ℚ`. … strictly commutative dg algebras model the situation only in characteristic zero.”
- Line 2008, its needs: “`moduleSpectra_equiv_derived`; `animationExtension`; `animatedAlgebras`; `operadicAlgebras`; `derivedTensor_symmetricMonoidal`; `enhancedDerived`.”
- Line 1858, the needs of `moduleSpectra_equiv_derived` (line 1846): “`spectra`; `presentableTensor`; `leftModuleObjects`; `derivedTensor_symmetricMonoidal`; `stableMonoidal_homotopyCategory`; `enhancedDerived`; `IsCompactlyGenerated`.”
- Line 2010, **Modules over animated rings** (`animatedModules`): “For `B ∈ AnimAlg_R` put `Mod_B = Mod_{θB}(D(R))`”. Line 2020, its needs: “`moduleSpectra_equiv_derived`; `animatedToCAlg`; `leftModuleObjects`; `animatedAlgebras`; `enhancedDerived`.”

So `animatedAlgebras` and `animatedToCAlg` are separate targets. The needs of the first, followed down, hold no derived tensor product, no module category and no t-structure. The second needs the first.

The paper: [AGKRRV] §0.9.6 (`references/papers/2010.01906v2/src/text.tex`, lines 2205–2206) defines the derived affine schemes as “the opposite category of the category of connective commutative algebras in `Vect_e`”. This is the target of `θ`. The paper's field has characteristic 0, where `θ` is an equivalence.

Tau Ceti and Mathlib at the pin have no animated ring, no `PΣ`, no sifted ∞-category, no commutative algebra object of a quasicategory and no Eilenberg–Mac Lane ring spectrum (searched: `animated`, `nonabelianDerived`, `IsSiftedInfinity`, `presentableTensor`). Mathlib has `MvPolynomial`, `CommAlgCat` and the sifted ordinary categories (`CategoryTheory.IsSifted`).

### 2.3 The roadmap, for split 2

- EnhancedDerivedSheaves README, line 553, E1.3, **The enhanced derived category** (`enhancedDerived`): “Its homotopy category is equivalent to Mathlib's `DerivedCategory A` … `D∞(A)` is stable, with suspension and cofibres given by Mathlib's shift and mapping cone.”
- Line 565, its needs: “`replacementDGComparison`; Sections 0.1–0.2 (`ClassicalDerived.enhancedCategory`, K-injective replacement); `sheafComplexDG`; `dgNerve`; the supplied localization universal property; `dgNerve_rightMappingSpaceIso`; `dgNerve_shift_cone_comparison`; E0.4's supplied stability predicate; Mathlib `DerivedCategory`, `DerivedCategory.isIso_iff`, `DerivedCategory.isIso_Q_map_iff_quasiIso`.” It names no t-structure.
- Line 431, §0.1, **Enhanced module sheaves**: “Provide shifts, cones, mapping complexes, the standard cohomological t-structure and its `D⁺` and `Dᵇ` subcategories.” Line 439, its needs, name Mathlib, Section 0.2, E0.3, E0.4, E0.6 and E0.8, and no t-structure of a stable ∞-category.
- The README names a t-structure in no other target that the plan uses: the needs of `derivedTensor` (line 595), `enhancedPullback` and `enhancedPushforward` (line 621), `QuasicoherentDerived` (line 852) and `derivedTensor_symmetricMonoidal` (line 1522) have none.
- HermitianKTheoryOfPoincareCategories README, line 913, §6.0 (`Infinity.tStructure`): “For a supplied stable ∞-category `C`, use Mathlib's `CategoryTheory.Triangulated.TStructure` on hC.” Line 920, its check: “On enhanced derived modules these functors agree with EnhancedDerivedSheaves §0.1's standard truncations after the fixed reversal of cochain degrees.” Line 922, its needs: “Mathlib CategoryTheory.Triangulated.TStructure; GeometryOfNumbersAndQuadraticArithmetic §6.1a stable mapping spectra; EnhancedDerivedSheaves §E0.4 stable categories and §0.1 standard derived truncations.”

So in the roadmaps the general t-structure of §6.0 needs §0.1, and §0.1 and E1.3 need no general t-structure. On `main` the plan has the opposite dependency, `Infinity.enhancedDerivedCategory` on `Infinity.tStructure`, because the plan states the t-structure of §0.1 with `Infinity.tStructure`. The statement that joins the two is the check of §6.0 at line 920. It is a third statement, above both.

One limit of this evidence: §0.1 states the carrier `ClassicalDerived.enhancedCategory` and its t-structure in one passage, and E1.3 lists §0.1 under its needs. The split follows the needs lines: no needs line of §0.1 or E1.3 has the t-structure of a stable ∞-category.

Mathlib at the pin has `DerivedCategory.TStructure.t` for every abelian category with a derived category. Tau Ceti at the pin has no t-structure on a quasicategory.

### 2.4 The roadmap, for split 3 (EnhancedDerivedSheaves README)

- Line 1746, E5:presentability.4, **Dualizable and compactly assembled categories** (`IsDualizablePresentable`): “A presentable stable ∞-category C is dualizable when it is dualizable in the symmetric monoidal ∞-category of presentable stable categories: it has a dual with evaluation and coevaluation satisfying the triangle identities up to coherent homotopy. Equivalently C is a retract, by colimit-preserving functors, of a compactly generated stable category”. Line 1748: “Provide `DualPairData`, `IsDualizablePresentable`, `dualizableRetractComparison` and `assemblyLeftAdjoint`.” Line 1754, a check: “A retract, through colimit-preserving functors, of a compactly generated category is dualizable.”
- Line 1756, its needs: “`PrL`; `presentableTensor`; `IsCompactMorphism`; the supplied Ind-completion.”
- Line 1770, **Trace-class maps and rigid categories** (`IsRigid`): “C is locally rigid over a base V when it is dualizable as a V-module …”. Line 1780, its needs: “`IsDualizablePresentable`; `IsCompactMorphism`; `presentableTensor`; `leftModuleObjects`; `spectra`.”

The definition and the theorems on compactly generated categories and on retracts are one passage with one needs line. That line names no internal Hom. The README states the fourth clause of the node (tensoring with a dualizable module over a rigid monoidal category preserves limits) nowhere: it states dualizable categories only in E5:presentability.4 (lines 1732–1784), and no passage there has this theorem.

The papers: [DG2] §4.1 (`references/papers/1108.5351v3/src/Finiteness.tex`, from line 3805) defines dualizability and states “(ii) Any compactly generated DG category is dualizable” (line 3857), with the dual `Ind((C^c)^op)`; §4.3 (from line 4011; the lemma at lines 4046–4047) proves that a retract of a dualizable object is dualizable. [GRQCoh] Proposition 3.5.3 uses that, for a rigid `QCoh(Y)` and a dualizable `QCoh(Y_1)`, the functor `QCoh(Y_1) ⊗_{QCoh(Y)} −` preserves limits. That statement needs the definition of a rigid monoidal category.

### 2.5 The users

Users are the nodes that list the node under `deps`, in `plans/` and `plans-proof/`. `lake exe tracker show <id>` gives the same lists for `plans/`.

**Users of `Derived.commutativeAlgebra` (6).**

| User | What its text uses | Dependencies on the branch |
|---|---|---|
| `Derived.affineScheme` | the opposite category, `π₀` and the discrete objects | the animated algebras only |
| `Derived.affineModules` | modules over `θB` (`animatedModules`, line 2010) | both |
| `Derived.affineCotangentComplex` | “The cotangent complex of an animated algebra”; its modules come from `Derived.affineModules` | the animated algebras, and `Derived.affineModules` as before |
| `Sheaves.qcqsScheme_passable` | limits of connective commutative algebras, and “The underlying-space functor on connective commutative algebras creates limits and detects equivalences”; for animated algebras this functor is the value at `k[x]` | the animated algebras only |
| `DModules.commutativeDAlgebra` (plan of the proof) | “Commutative unital DG algebras in left D_X-modules”, “over the operadic algebras” | both |
| `SpectralProof.factorizationVacuum_almostULA` (plan of the proof) | connective commutative factorization algebras, symmetric algebras, filtrations | both |

**Users of `Infinity.enhancedDerivedCategory` (4) and of `Infinity.derivedVect` (13).** “t” is the new node `Infinity.enhancedDerivedCategoryTStructure`.

| User | What its text uses | t on the branch |
|---|---|---|
| `DModules.rightCrystals_equiv_dModules` | “with the t-structure of that node”; the heart | yes; the text names the new node |
| `Infinity.derivedBimoduleTransfer` | exact functors and equivalences with `Q`; no t-structure | no |
| `Infinity.derivedVect` | the category and its tensor product; its t-structure clause is in the new node | no |
| `Sheaves.schemeQCoh` | the full subcategory, the comparison of homotopy categories, coproducts, the unit | no |
| `Derived.commutativeAlgebra` | the animated algebras | no; the comparison node has t |
| `Derived.affineModules` | modules in the derived category | no; it has t through the comparison node |
| `Examples.pointQCohEquivVect` | “compatible with the tensor units, the coarsening Ψ and the t-structures” | yes |
| `Infinity.finiteMultiplicityProduct_isMonadic` | “t-exactness”, “both vector-space t-structures complete” | yes |
| `Satake.cohomologyFiberFunctor` | “Total cohomology”: the cohomology objects of an object of `Vect` | yes |
| `DModules.compactSupportedHomology_kunneth` (plan of the proof) | “the supplied algebraic Kunneth theorem for homology groups of complexes” | yes |
| `DModules.compactSupportedHomology` (plan of the proof) | the object `p_!(ω_Y)` of `Vect` and its colimit presentation | no |
| `Homology.commutativeLieKoszulComplex`, `Homology.commutativeLieKoszul_contracts` (plan of the proof) | complexes and their contractions | no |
| `Infinity.compactObject_iff_homotopyCategory` | shifts and Hom groups of the homotopy category | no |
| `Infinity.internalHom`, `Infinity.linearCategory` | the monoidal category | no |

`DModules.transferModule` names `Infinity.enhancedDerivedCategory` in its text and does not depend on it. It works on `DerivedCategory` with its bounded part, which is Mathlib's, so it does not use the new node.

A search of the nodes that do not list the two nodes: of the 507 nodes of `plans/` and `plans-proof/`, 41 are above `Infinity.derivedVect` or `Infinity.enhancedDerivedCategory` and not above the new node. Six of them name a t-structure, a heart, a truncation or a cohomology object: `Infinity.derivedVect` (the pointer to the new node), `DModules.transferModule` (on `DerivedCategory`), and four placeholders of the statement on a DG category with a chosen t-structure. None uses the t-structure of `Vect` or of an enhanced derived category.

**Users of `Infinity.dualizableCategory` (18).** Two are roadmap nodes: `Infinity.rigidMonoidalCategory` and `Infinity.localizationPullback_dualizable`. Sixteen are written here (11 in `plans/`, 5 in `plans-proof/`). Each of the sixteen has another dependency whose chain of roadmap nodes is at least as long as that of `Infinity.dualizableCategory` (8 on the branch; for example `Sheaves.QCoh` has 8).

### 2.6 The chains

The length of a chain is the number of roadmap nodes on it. The depth of a node is the length of the longest chain that ends at it or below it.

| | `main` | branch |
|---|---|---|
| Longest chain of roadmap nodes | 11 (`Infinity.rightAdjoint_linear`) | 10 (`Infinity.rightAdjoint_linear`) |
| Roadmap nodes at depth 11, 10, 9, 8, 7 | 1, 4, 5, 5, 5 | 0, 1, 4, 4, 5 |
| `Derived.commutativeAlgebra` | 8 | 5 |
| `Derived.affineScheme` | 9 | 6 |
| `Derived.Prestack` | 9 | 6 |
| `Sheaves.schemeQCoh` | 7 | 6 |
| `Sheaves.perfectDerived_iff_isPerfectComplex` | 8 | 7 |
| `Infinity.enhancedDerivedCategory` | 5 | 4 |
| `Infinity.derivedVect` | 6 | 5 |
| `Infinity.linearCategory` | 7 | 6 |
| `Derived.affineModules` | 9 | 8 |
| `Infinity.dualizableCategory` | 9 | 8 |
| `Infinity.rightAdjoint_linear` | 11 | 10 |
| `DModules.regularHolonomicDModule` | 10 | 9 |
| Nodes written here (221) at depth 11, 10, 9, 8, 7, 6 | 18, 51, 121, 9, 10, 0 | 0, 18, 51, 79, 9, 52 |

The chains on the branch:

- 10: `Infinity.mappingSpaces` > `Infinity.limits` > `Infinity.homotopyCategoryPretriangulated` > `Infinity.enhancedDerivedCategory` > `Infinity.derivedVect` > `Infinity.linearCategory` > `Infinity.internalHom` > `Infinity.dualizableCategory` > `Infinity.rigidMonoidalCategory` > `Infinity.rightAdjoint_linear`.
- 9, four chains: to `Infinity.rigidMonoidalCategory` and to `Infinity.localizationPullback_dualizable` (the chain above, to its ninth node); to `Derived.affineCotangentComplex` (… > `Infinity.linearCategory` > `Derived.commutativeAlgebraEquivConnectiveCommAlg` > `Derived.affineModules` > `Derived.affineCotangentComplex`); and to `DModules.regularHolonomicDModule` (… > `Infinity.enhancedDerivedCategory` > `Infinity.derivedBimoduleTransfer` > `DModules.transferModule` > `DModules.holonomicDModule` > `DModules.holonomicIntermediateExtension` > `DModules.regularHolonomicDModule`).
- `Derived.affineScheme`, 6: `Infinity.mappingSpaces` > `Infinity.limits` > `Infinity.presentableCategory` > `Infinity.rightAdjoint` > `Derived.commutativeAlgebra` > `Derived.affineScheme`.

Of the 505 nodes of `plans/` and `plans-proof/` on `main`, 416 have a smaller depth on the branch: 358 by one and 58 by three. No node has a larger depth. Of the 221 nodes written here in `plans/`, 209 have a smaller depth: 42 by three (from 9 to 6; among them `Derived.Prestack`, `Derived.IsArtinStack`, `Derived.DeRhamPrestack`, `Ran`, `LoopGroups.LoopGroup` and `Stacks.ClassifyingStack`) and 167 by one.

## 3. The options

### Split 1, `Derived.commutativeAlgebra`

- **Split into the animated algebras and the comparison (chosen).** The roadmap states them as the targets `animatedAlgebras` and `animatedToCAlg` with the needs lines 1947 and 2008. The definition of the derived affine schemes becomes the animated one. This is a reformulation of [AGKRRV] §0.9.6, and the comparison node is the theorem that the two definitions agree in characteristic 0. The comparison stays below the statement: `Sheaves.QCoh` depends on `Derived.affineModules`, which depends on the comparison. In `plans/`, 192 nodes are above `Derived.commutativeAlgebra` and 148 are above the comparison, so 43 nodes do not wait for the comparison.
- **Leave.** `Derived.affineScheme`, `Derived.Prestack` and the geometry of prestacks (the Ran space, loop groups, classifying stacks, de Rham prestacks, Artin stacks) wait for `Infinity.linearCategory`, `Infinity.derivedVect` and the module categories, which their texts do not use.
- **Another cut: keep the paper's definition in `Derived.commutativeAlgebra` and make the animated algebras the new node.** Then `Derived.affineScheme` must depend on the new node to gain, so its definition is the animated one in both cuts. The cut chosen keeps the id `Derived.commutativeAlgebra` for the category that `Derived.affineScheme` is the opposite of, and changes the dependencies of fewer users.

### Split 2, the t-structure of the enhanced derived category

- **One new node for the t-structure of both nodes (chosen).** `Infinity.enhancedDerivedCategoryTStructure` has two cases: sheaves of modules over a sheaf of rings (the clause of `Infinity.enhancedDerivedCategory`), and modules over a ring, with the vector spaces over a field as a case (the check of `Infinity.enhancedDerivedCategory` and the clause of `Infinity.derivedVect`). It depends on `Infinity.enhancedDerivedCategory` and `Infinity.tStructure`, not on `Infinity.derivedVect`, so it adds no step to a chain: its depth is 5, as that of `Infinity.derivedVect`.
- **Leave.** The plan keeps a dependency that the roadmaps have in the other direction (§6.0 needs §0.1).
- **Another cut: two new nodes, one for each old node.** The second would be a case of the first with its own pull request and no other content.
- **Another cut: state the t-structure for every Grothendieck abelian category.** `DerivedCategory.TStructure.t` exists in that generality, and the transport along the equivalence is the same. It is the natural generality. It is not chosen here because it states more than the old nodes and more than §0.1; it is under "Open doubts".

### Split 3, `Infinity.dualizableCategory`

- **Split into the definition and its theorems.** Not chosen, for three reasons. (a) The roadmap states the definition with `dualizableRetractComparison` in one passage (line 1746) with one needs line (line 1756); a pull request for the target holds both. (b) `Infinity.rigidMonoidalCategory` uses the theorem: its criterion “compact generation … implies rigidity” needs that a compactly generated category is dualizable. So it stays above the theorems, and the chain to `Infinity.rightAdjoint_linear` keeps its length. None of the sixteen users written here gains (2.5). Only `Infinity.localizationPullback_dualizable` could go from 9 to 8, if its proof needs none of the theorems. (c) The clause “for modules over a rigid monoidal category, prove the dualizable relative-tensor functor preserves limits” presupposes `Infinity.rigidMonoidalCategory`. A node that holds this clause and the theorem on compactly generated categories is in a cycle with `Infinity.rigidMonoidalCategory`. So the split needs three nodes, and the third has no target in the roadmap (2.4).
- **Leave (chosen).** The node keeps its text and its dependencies.
- **Another cut: move only the clause on modules over a rigid monoidal category to a node above `Infinity.rigidMonoidalCategory`.** It removes the circular reference of (c) and shortens no chain. It needs a provider for the clause, which the roadmap does not state; that is a question of its own ("Open doubts").

## 4. The chosen option and what the branch changes

**New nodes (2).**

- `GLCinLean.Derived.commutativeAlgebraEquivConnectiveCommAlg`, in the new module plan `plans/Roadmap/EnhancedDerivedSheaves/AnimatedModules.toml`: the functor `θ` to the commutative algebra objects of the connective part of the derived category, the equivalence when `k` contains `ℚ`, and the comparison with the nonpositive commutative DG algebras in characteristic 0. Dependencies: `Derived.commutativeAlgebra`; the four dependencies of the old node (`Infinity.monoidalCategory`, `Infinity.linearCategory`, `Infinity.derivedVect`, `Infinity.moduleCategory`); `Infinity.enhancedDerivedCategoryTStructure`, for the connective part; and `Infinity.compactGeneration`, which is `IsCompactlyGenerated` in the needs of `moduleSpectra_equiv_derived` (line 1858).
- `GLCinLean.Infinity.enhancedDerivedCategoryTStructure`, in the new module plan `plans/Roadmap/EnhancedDerivedSheaves/EnhancedDerivedTStructure.toml`. Dependencies: `Infinity.enhancedDerivedCategory`, `Infinity.tStructure`.

**Changed roadmap nodes.**

- `Derived.commutativeAlgebra`: the animated commutative k-algebras, with the properties that `nonabelianDerived`, `animationExtension` and `animatedAlgebras` provide, the difference from [AGKRRV] §0.9.6 with its kind (reformulation) and reason, and three checks of the roadmap. Dependencies: `Infinity.mappingSpaces`, `Infinity.limits`, `Infinity.presentableCategory` (`PrL`), `Infinity.rightAdjoint` (`accessibleLocalization`, and the adjunction with `π₀`), `Infinity.rightKanExtension` (`leftKanExtension_restrict_trivialFibration`).
- `Derived.affineScheme`: the text says that it uses the animated algebras only and names the comparison node. Dependencies unchanged.
- `Derived.affineModules`: moved to `AnimatedModules.toml`, so that the module `Roadmap.EnhancedDerivedSheaves.AnimatedRings` is ready without it. It depends also on the comparison node, and its text names `θ`.
- `Infinity.enhancedDerivedCategory`: without the t-structure clause, the heart in its check, the provider sentence on §0.1 and the upstream name `DerivedCategory.TStructure.t`; it names the new node. Without the dependency on `Infinity.tStructure`.
- `Infinity.derivedVect`: without “and standard t-structure” and the upstream name `DerivedCategory.TStructure.t`; it names the new node. Dependencies unchanged.
- `Infinity.finiteMultiplicityProduct_isMonadic`: one more dependency, the new t-structure node, named in its text.
- `Infinity.tStructure`: its sentence on §0.1 names the new node. Dependencies unchanged.

**Changed nodes written here.** `DModules.rightCrystals_equiv_dModules` (the new t-structure node as a dependency; two phrases name it), `Examples.pointQCohEquivVect` (dependency and one phrase), `Satake.cohomologyFiberFunctor` (dependency). In `plans-proof/`: `DModules.compactSupportedHomology_kunneth` (dependency on the t-structure node), `DModules.commutativeDAlgebra` and `SpectralProof.factorizationVacuum_almostULA` (dependency on the comparison node).

**Where each clause of the old nodes is.**

| Old clause | Node on the branch |
|---|---|
| “Connective commutative derived k-algebras with actual homotopy-coherent maps” | `Derived.commutativeAlgebra` |
| “in characteristic zero compare nonpositive commutative DG algebras” | `Derived.commutativeAlgebraEquivConnectiveCommAlg`, (3) |
| Provider “Sifted colimits and animation” | `Derived.commutativeAlgebra` |
| Provider “Animated rings as commutative algebras and their modules” | `Derived.commutativeAlgebraEquivConnectiveCommAlg`; `Derived.affineModules` as before |
| The t-structure of D∞(`SheafOfModules R`), with heart | `Infinity.enhancedDerivedCategoryTStructure`, (1) |
| The check “the heart is the R-modules” | `Infinity.enhancedDerivedCategoryTStructure`, (2) and its checks |
| “standard t-structure” of `Infinity.derivedVect` | `Infinity.enhancedDerivedCategoryTStructure`, (2) |
| The other clauses and checks of `Infinity.enhancedDerivedCategory` and `Infinity.derivedVect` | unchanged, in the same nodes |

**Other files.** `docs/blueprint-providers.md`: in the table “Roadmaps that own plan nodes”, the row of EnhancedDerivedSheaves has 28 nodes and names the two new nodes. No Lean file, no file of `GLCinLean/` and no line of `GLCinLean.lean` changes: the nodes have no declaration yet. When `Derived.commutativeAlgebra` is declared, its doc comment records the reformulation, and the root file lists it under "Differences from the sources", because the statement uses derived affine schemes.

## 5. Texts for `STATUS.md`

### Facts

- The plan: 311 planned declarations in 198 module plans. 221 are under `plans/GLCinLean/`; 31 of them are the statement. 90 are under `plans/Roadmap/<area>/`, in fifteen areas; EnhancedDerivedSheaves has 28 and HermitianKTheoryOfPoincareCategories 1. Of the 221 nodes written here, 220 have a roadmap node below them. `plans-proof/` has 196 nodes in 75 module plans.
- The longest chain of roadmap nodes has 10 nodes and ends at `Infinity.rightAdjoint_linear`. Four roadmap nodes have longest-chain depth 9. The chain to `Sheaves.perfectDerived_iff_isPerfectComplex` has 7. `Derived.affineScheme`, `Derived.Prestack` and `Sheaves.schemeQCoh` have 6.
- The nodes written here, by the number of roadmap nodes in the longest chain below them: 18 have 10, 51 have 9, 79 have 8, 9 have 7, 52 have 6, and 12 have 4 or fewer. `Derived.Prestack`, `Derived.IsArtinStack`, `Derived.DeRhamPrestack`, `Ran`, `LoopGroups.LoopGroup` and `Stacks.ClassifyingStack` are among the 52.
- 147 nodes of `plans/` are above `Sheaves.derivedQCoh`, 192 are above `Derived.commutativeAlgebra`, and 148 are above `Derived.commutativeAlgebraToConnectiveCommAlg`.
- Checks on the branch: `lake exe tracker lint` has no errors (its warnings are the superseded fields of the statement's declarations); `python3 tools/check-module-cycles.py`: 198 module plans, 311 nodes, 0 cycles; `python3 tools/check-upstream-names.py`: 262 pairs, 0 not confirmed. `GLCinLean.lean` has one new entry in its module doc comment, so the done check was run: `lake build` passes with only the `sorry` of the main theorem, `lake lint` passes, and `lake env lean tools/check-statement-axioms.lean` shows `sorryAx` only for the main theorem.

### Entry for "Decisions taken"

- **Two roadmap nodes are split, to shorten the chains** (2026-11-19, with `prompts/change.md`). (1) `Derived.commutativeAlgebra` is the category of the animated commutative k-algebras (EnhancedDerivedSheaves E5:animation.1, `animatedAlgebras`). Its comparison with the connective commutative algebra objects of the derived category is the node `Derived.commutativeAlgebraToConnectiveCommAlg` (E5:animation.4, `animatedToCAlg`): a functor for every commutative ring, and an equivalence over a commutative ℚ-algebra, so over the field of the statement. The roadmap states the two as separate targets with different needs. The animated definition is a reformulation of [AGKRRV] §0.9.6 and [Crystals] §0.6.4: over a field of characteristic 0 it is the same category in another presentation. The module doc comment of `GLCinLean.lean` records it under "Differences in the definitions that the statement uses". The first declaration written here over the animated algebras (`Derived.Prestack` or `Derived.ClassicalReduction`) names the reformulation in its doc comment. The comparison stays below the statement, through `Derived.affineModules` and `Sheaves.QCoh`. `Derived.affineScheme` and `Derived.Prestack` depend on the animated algebras only. (2) The standard t-structure of the enhanced derived category is the node `Infinity.enhancedDerivedCategoryTStructure`, stated for every Grothendieck abelian category; the sheaves of modules, the modules over a ring and `Vect_k` are cases. It depends on `Infinity.enhancedDerivedCategory` and on `Infinity.tStructure`; `Infinity.enhancedDerivedCategory` and `Infinity.derivedVect` state no t-structure and do not depend on `Infinity.tStructure`. E1.3 uses the enhancement and replacements of §§0.1–0.2. Its construction of the stable category needs no t-structure. HermitianKTheoryOfPoincareCategories §6.0 lists the standard truncations of §0.1 for its compatibility check. The plan puts the general transport below the standard t-structure and proves the compatibility at the specialization. Confirm that Tau Ceti accepts this division before scheduling the two targets as separate pull requests. §6.0 needs EnhancedDerivedSheaves E0.4 and §0.1; the new node holds the check of §6.0 that its t-structure on enhanced derived modules is the standard one of §0.1. The node is of the area EnhancedDerivedSheaves: HermitianKTheoryOfPoincareCategories names §0.1 as the supplier of the standard t-structure on enhanced derived modules. (3) `Infinity.dualizableCategory` is not split: the roadmap states its definition and its theorems in one passage with one needs line, `Infinity.rigidMonoidalCategory` uses the theorem, and no node written here would have a shorter chain. `Sheaves.QCoh` depends directly on `Infinity.rightKanExtension`. `SpectralProof.factorizationCategory` depends directly on `Infinity.stableCategory` and `Infinity.linearCategory`, and `SpectralProof.factorizationVacuum_almostULA` depends directly on `Groups.RepresentationCategory`. The longest chain of roadmap nodes is 10; `Derived.affineScheme`, `Derived.Prestack` and `Sheaves.schemeQCoh` have 6, and the chain to `Sheaves.perfectDerived_iff_isPerfectComplex` has 7. The session adds here who checked the change and with what result.

### Text for the entry "Faster within Tau Ceti's rules"

The sentence on the longest chain and the sentence on the three splits are replaced by:

"The longest chain of roadmap nodes was then 11, and the chain to `Sheaves.perfectDerived_iff_isPerfectComplex` 8 in place of 12. Two splits of nodes shorten the chains further (the decision "Two roadmap nodes are split, to shorten the chains")."

### Entries for "Open items"

The three splits are no longer an open item. Two parts of that item are not part of this change and stay open, as two items:

- **Two further changes of roadmap nodes, not started.** Moving the checks of `Infinity.compactObject_iff_homotopyCategory`, and a statement of κ-compactness on the left fibration, which is another formulation than the roadmap's. This change touches neither.
- **Roadmap targets without a plan node.** The ∞-category of spaces with straightening (EnhancedDerivedSheaves E0.5 and E0.7) and `PrL` with its tensor product (E5:presentability.2) have no node. `Infinity.presentableCategory`, `Infinity.compactObject`, `Infinity.indCompletion`, `Infinity.linearCategory` and `Derived.commutativeAlgebra` need them: `Derived.commutativeAlgebra` is a category of presheaves with values in spaces, and `nonabelianDerived` lists `PrL` under its needs. `lake exe tracker ready` does not see these waits, so the chains through these nodes are longer than the plan shows.

Two new items:

- **`Infinity.dualizableCategory` and `Infinity.rigidMonoidalCategory` refer to each other.** The node `Infinity.dualizableCategory` asks for a theorem on modules over a rigid monoidal category ([GRQCoh], proof of Proposition 3.5.3), and `Infinity.rigidMonoidalCategory` depends on `Infinity.dualizableCategory`. The dependencies show one direction only. The README of EnhancedDerivedSheaves states that theorem in no target. The theorem needs a node above `Infinity.rigidMonoidalCategory` and a provider; both are a change with `prompts/change.md`. That change states separately the promotion to relative dualizability that [GRQCoh] uses and the resulting theorem that the relative tensor product preserves limits.
- **Truncations and homotopy groups of animated algebras.** `Derived.LocallyAlmostFiniteType`, `Derived.IsIndscheme`, `Derived.IsArtinStack` and, in the plan of the proof, `Derived.formallySmooth` and `Derived.indPlacid` use the n-coconnective affine schemes and flat, étale and smooth maps of derived affine schemes. No node states the n-truncation of an animated algebra or its homotopy groups as modules over π_0, and EnhancedDerivedSheaves E5:animation has no target for them. They are defined inside the animated algebras (the n-truncated objects; the homotopy groups, with base point zero, of the value at `k[x]`). The writer of the first of these nodes states them as a helper node written here.

### Text for "Workers"

No worker changes. No author worker is on EnhancedDerivedSheaves or on HermitianKTheoryOfPoincareCategories. The targets that the guidance of `author-infinity` and `author-stable` names (GeneralizedCohomology G2.11) are not nodes of the change, and none of them depends on a node of the change. The module plans of EnhancedDerivedSheaves that the change adds or changes are `Roadmap.EnhancedDerivedSheaves.AnimatedRings` (`Derived.commutativeAlgebra`, `Derived.affineScheme`), `Roadmap.EnhancedDerivedSheaves.AnimatedModules` (the comparison, `Derived.affineModules`), `Roadmap.EnhancedDerivedSheaves.EnhancedDerived` and `Roadmap.EnhancedDerivedSheaves.EnhancedDerivedTStructure`. An author worker on EnhancedDerivedSheaves gets `Roadmap.EnhancedDerivedSheaves.EnhancedDerivedTStructure`, as the standard t-structure of §0.1, when `Infinity.enhancedDerivedCategory` and `Infinity.tStructure` are at the pin. The tracker marks `Roadmap.EnhancedDerivedSheaves.AnimatedRings` ready when `Infinity.mappingSpaces`, `Infinity.limits`, `Infinity.presentableCategory`, `Infinity.rightAdjoint` and `Infinity.rightKanExtension` are proved. Before starting the animated algebra target, check that the Worker also has the roadmap interfaces for spaces and space-valued presheaves, `PrL`, sifted colimits, accessible localization and the restriction theorem for left Kan extensions. The generic right Kan extension node supplies the dual universal property.

## 6. Worker guidance

None. No `extra_roadmap_prompt` changes.

## 7. Open doubts

1. **The reformulation of the derived affine schemes.** On the branch `Derived.affineScheme` is the opposite of the animated algebras, and the paper's definition is recovered by the comparison node. The old node named both roadmap passages as providers and did not say which category is the definition. If the definition must be the paper's `CAlg(Vect^{≤0})`, split 1 gives nothing: `Derived.affineScheme` then needs the derived tensor product and the t-structure. The checker and Codex should judge this point first.
2. **What the prestack nodes use of the algebras.** Nodes such as `Derived.LocallyAlmostFiniteType`, `Derived.IsIndscheme` and `Derived.IsArtinStack` use truncations, n-coconnective affine schemes, and étale and smooth maps of derived affine schemes. For animated algebras these are defined inside the category (truncated objects, homotopy groups of the underlying space as modules over `π₀`). Neither the old node nor the new one states them as clauses. I judged from the texts of the 57 nodes that are above the animated algebras and not above the comparison that none needs the comparison; I did not read each of them in full.
3. **The generality of the t-structure node.** It keeps the scope of the old clauses: sheaves of modules on a small site, and modules over a ring. `DerivedCategory.TStructure.t` and the transport exist for every Grothendieck abelian category, which is the natural generality ("Lean code" in `AGENTS.md`). Stating the node so is a generalization of the old nodes and of §0.1 and is not made here.
4. **Three dependencies were added on a reading of the text.** `Satake.cohomologyFiberFunctor` (“Total cohomology”), `DModules.compactSupportedHomology_kunneth` (“homology groups of complexes”) and `DModules.commutativeDAlgebra` (“Commutative unital DG algebras”) do not name the clause that moved. They get the new node because their texts use cohomology objects of `Vect` or commutative DG algebras. If a reader finds that one does not use it, the dependency is removed; none is on a longest chain.
5. **`Infinity.compactGeneration` as a dependency of the comparison node.** It comes from the needs line of `moduleSpectra_equiv_derived` (line 1858), which is a need of `animatedToCAlg`. The old node did not have it. Its depth is 4, so it changes no chain.
6. **The comparison with commutative DG algebras.** The roadmap gives it as a remark with the citation of Higher Algebra, Proposition 7.1.4.11, and names no declaration for it. [LurieHA] is not pinned, and I did not read the proposition in a local copy. The clause is the old node's; the new node keeps it and says that the roadmap names no declaration.
7. **The id of the comparison node.** `commutativeAlgebraEquivConnectiveCommAlg` names the equivalence, which holds when `k` contains `ℚ`. The functor `θ` exists for every commutative ring. Tau Ceti fixes the names of roadmap nodes; the id may be chosen otherwise.
8. **Missing nodes (not added).** The ∞-category of spaces with straightening (E0.5, E0.7) has no node. `Derived.commutativeAlgebra` is a full subcategory of the presheaves with values in spaces, as `Infinity.indCompletion` is, and is stated in the same way, over `Infinity.mappingSpaces` and `Infinity.limits`. `PrL` and its tensor product (E5:presentability.2) have no node either: `PrL` is read as part of `Infinity.presentableCategory`, and `presentableTensor` as part of `Infinity.linearCategory`, as the provider lines of these nodes say. The two splits can be stated without new nodes. A node for spaces with straightening would be a definition of roadmap GeneralizedCohomology, G2.11 (“Unmarked straightening and the categorical model”): the quasicategory of spaces, the presheaves with values in it, the Yoneda embedding and space-valued straightening, with `Infinity.mappingSpaces` below it and `Infinity.compactObject`, `Infinity.indCompletion`, `Infinity.presentableCategory` and `Derived.commutativeAlgebra` above it. It would add one node to each chain through them, so the true chains are one longer than the table of 2.6 shows.
9. **The dependency of `Infinity.dualizableCategory` on `Infinity.internalHom`.** The needs line of `IsDualizablePresentable` (line 1756) names no internal Hom; the roadmap states dualizability over spectra. The plan's node is for k-linear categories, where the proof of [DG2] §4.1 (ii) pairs `Ind((C^c)^op)` with `C` through the Vect-valued Hom. I left the dependency. A worker that proves the k-linear statement from the roadmap's by another route would not use it; then `Infinity.dualizableCategory` would have depth 7 and the longest chain 9, with no split.
10. **The checker of step 2 has not run.** `prompts/change.md` asks for a check of the branch with `prompts/check.md` before Codex.
