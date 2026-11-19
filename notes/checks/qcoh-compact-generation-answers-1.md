# Answers to round 1 on `proposal/qcoh-compact-generation`

The reports are `qcoh-compact-generation-codex-1.md` (Codex) and `qcoh-compact-generation-check-1.md` (the checker), both on commit `9f9ecb3`. Each finding was checked against the plan files, the roadmap READMEs at `fe56342a`, the pinned Tau Ceti and Mathlib, the heads of the cited pull requests and the papers. "Fixed" names the files that changed. Line numbers of roadmaps are of the READMEs at `fe56342a`.

**Result.** 24 findings are fixed. 3 are answered without a change of a node. I disagree with no finding; on one point (Codex 4, checker item 4) I follow the checker's form and not a node, and say why.

## The provider of `Sheaves.schemeQCoh_compactGeneration`

**Decision: it is written here.** The node moved from `plans/Roadmap/EnhancedDerivedSheaves/` to `plans/GLCinLean/AlgebraicGeometry/Sheaves/SchemeQCohCompactGeneration.toml`, with "Provider: here".

The reasons, by the rules:
- Tau Ceti's `AGENTS.md` at the pin: "only add a new mathematical declaration (definition, theorem, instance, notation) or file when it advances a specific roadmap target, or supplies a prerequisite that a specific target needs". The statement is not a named target of an accepted roadmap. Both reports find, and I confirm, that no accepted target needs it: in SchemeKTheoryOperations, `D_QCoh` is the triangulated category (line 13: "SchemeAndStackFoundations owns pseudo-coherent complexes, `D_QCoh` and its affine equivalence"; line 1702 writes "enhanced `D_QCoh`" where it means the enhancement); the §2.6 target (line 758) says that it is "not a second compact-generation theorem"; a route inside triangulated categories exists; and the comparison would need that compact objects are perfect, which the node does not state. The Needs line (760) names one possible route, not a need.
- "Sources of code": parts covered by a roadmap go to Tau Ceti, and everything else is written here. This statement is "everything else".
- `plans/README.md`: a node here may depend on a roadmap node, never the other way round. The node depends on three roadmap nodes; no roadmap node depends on it.
- The open #2450 §8.1 is design evidence and not an owner. The node says that its provider is decided again when a roadmap with this statement is accepted.

My first version chose a roadmap node on the reading that §2.6 applies the notions of E5:presentability to `QuasicoherentDerived X`. That reading was my doubt 1, and it does not hold. The checker's position, that a roadmap node with a fallback sentence is acceptable, is a weaker fit to the rules: it sends to Tau Ceti a declaration that Tau Ceti's own rule does not admit, in an area with no author worker.

The generic test stays upstream, as both reports say: it is the roadmap node `Infinity.compactGeneration_of_homotopyCategory`.

## Codex, blocking objections

**Codex 1. The ownership of the enhanced theorem. Right; fixed.** See the decision above. Places corrected: the node (moved and rewritten), `docs/blueprint-providers.md` (the row of EnhancedDerivedSheaves, the row of #2450), the proposal (sections 2.5, 3, 4 and 6).

**Codex 2. The coproduct universe. Right; fixed.** Confirmed at the head `3d99a097` of #43034: `def IsCompactForCoproducts (G : T) : Prop := ∀ J : Type v, PreservesColimitsOfShape (Discrete J) (preadditiveCoyoneda.obj (op G))`, for `[Category.{v} T]`. Confirmed in `Suggested.lean` lines 553–565: `HasDerivedCategory.standard` and a `Category.{u + 1}` instance on `DQCoh X`. Settled once, in `Sheaves.derivedQCoh`: for `X : Scheme.{u}`, small means indexed by a type in `Type u`; `X.Modules` is a Grothendieck abelian category for `u` (Mathlib, `Mathlib.AlgebraicGeometry.Modules.Sheaf`), and Hom sets of the derived category are u-small. `Sheaves.derivedQCoh_perfectGenerator` states that `IsCompactForCoproducts` on the standard model is not statement (1), gives the two correct forms (a model with morphisms in `Type u`, or preservation of the coproducts indexed by `Type u`), and leaves the choice to the interface check. `Infinity.compactGeneration_of_homotopyCategory` fixes one universe `w` for the coproducts, the filtered colimits and the Hom sets. `Sheaves.schemeQCoh` states that the enhanced category is closed under the small coproducts of `D∞(O_X)` and that they are the coproducts of `DQCoh X`. The same sentence is in the worker guidance, step (e), and in two rows of `docs/blueprint-providers.md`.

**Codex 3. Strictly perfect is not perfect. Right; fixed.** Confirmed in the description of #43025: "What remains for Layer 1 after this PR are §§1.2–1.7: m-pseudo-coherence, local perfectness `IsPerfectComplex`, …"; it defines `AlgebraicGeometry.Scheme.Modules.isStrictlyPerfect`. Confirmed in SchemeKTheoryOperations line 207 and `Suggested.lean` line 63. Settled once: a perfect object of `DerivedCategory X.Modules` is one that a complex with `IsPerfectComplex` represents (SchemeKTheoryOperations §1.3), and the node gives the contractible complex on a point as the example that separates the two notions. `Sheaves.schemeQCoh` now asks that the comparison identifies the perfect subcategories in both directions, and names the target of SchemeKTheoryOperations §1.3 that supplies it. `Sheaves.schemeQCoh_compactGeneration` names the step that uses the inverse direction (the choice of `P` over `P₀`). Places corrected: `PerfectGenerator.toml`, `SchemeQCoh.toml`, `SchemeQCohCompactGeneration.toml`, `docs/blueprint-providers.md` (the row of `IsPseudoCoherent`, the row of the ready module, the row of #43025), the worker guidance (step (d)), the proposal (sections 2.1, 2.2, 2.4).

**Codex 4. The comparison on derived test rings. Right; fixed by a lemma and a recorded obligation, not by a node for the comparison.** Confirmed in #2450 at `26c8a4ff`: §2.5 defines `h_X : CRing → Ŝ`, and §2.4 says of the left Kan extension "It does not preserve fibre products". My sentence "#2450 §5.3 states this equivalence as a target" was wrong for derived test schemes and is removed (the proposal, `PassableScheme.toml`, the row of #2450). New node `Sheaves.qcoh_compactGeneration_of_qcqsScheme`, written here: for a quasi-compact quasi-separated scheme over `k`, QCoh of its prestack has a compact unit, compact perfect objects, one perfect generator, and is dualizable. It serves `Sheaves.qcqsScheme_passable`, `DModules.IsULAModuleCategory` and `Sheaves.properPerfectPushforward`. It fixes the prestack of `X` as `X` as a derived scheme, and it names its two inputs that no node states: (i) that prestack, and (ii) the equivalence of its QCoh with `Sheaves.schemeQCoh X`, with the unit and the perfect objects in both directions, with the route by [GRQCoh] Proposition 1.4.4. The obligation is recorded outside the held file in three places: this node, the row of #2450 in `docs/blueprint-providers.md`, and a proposed "Open items" entry. I did not add nodes for (i) and (ii): their form depends on who provides QCoh, which is the held question, and the node that needs them depends on the held `Sheaves.QCoh`, so it cannot become ready before the hold ends. The checker's item 4 asks for the same form ("it needs a node of its own when the hold ends"). The symmetric monoidal structure is not required: the checker is right that an equivalence that sends the unit to `O_X` and matches the perfect objects is enough.

**Codex 5. Two missing prerequisites. Right; fixed.** New roadmap node `Sheaves.derivedQCoh` (SchemeAndStackFoundations §2.18: `DQCoh`, *DQCoh.isTriangulated*, *DQCoh.hasCoproducts*, `DQCoh.affineEquiv`, *DQCoh.restrict*), with no dependency; `Sheaves.schemeQCoh` and `Sheaves.derivedQCoh_perfectGenerator` depend on it. So `Sheaves.schemeQCoh` does not wait for the generator theorem. The ready module of the area is now `Roadmap.SchemeAndStackFoundations.DerivedQCoh`. The checks in `Infinity.derivedVect` moved to `Infinity.compactGeneration_of_homotopyCategory`, which depends on `Infinity.derivedVect`; the definition node keeps only the check on the zero category.

**Codex 6. `Sheaves.properPerfectPushforward` and E1.9. Right as a finding; not made on this branch.** Confirmed at EnhancedDerivedSheaves lines 1057–1071: `perfect_proper_pushforward` states "`Rf_∗E` is perfect and commutes with arbitrary base change when f is proper, flat and finitely presented", for algebraic spaces, with no Noetherian hypothesis. I restored the node to its text at `ebbb29c` and kept only the new dependency, `Sheaves.qcoh_compactGeneration_of_qcqsScheme`. The reason: naming E1.9 as the supplier of the classical part is a change of provider for that part. This change does not force it, and it needs its own evidence (algebraic spaces against prestacks, the comparison and the descent that stay here). The proposal has an "Open items" entry that names E1.9.

## Codex, improvements

**[GRQCoh] §3.3.1. Applied.** Confirmed at `QCohBook.tex` line 1034: "an object X ∈ DGSch is quasi-affine if it quasi-compact and admits an open embedding into an affine scheme". `Sheaves.passable` cites it in its text and its `source`; `Sheaves.qcqsScheme_passable` separates the classical step from the derived step of the diagonal. This closes doubt 7 of the first version.

**The cardinal in Corollary 1.4.4.2, and a small model in the Ind comparison. Applied.** `Infinity.compactGeneration_of_homotopyCategory` names a regular cardinal larger than the cardinality of `S × ℤ` and says that the coproduct is κ-compact and not compact in general. Form (c) of `Infinity.compactGeneration` takes a small category equivalent to the stable subcategory.

**The scope of `Sheaves.qcSeparatedScheme_oneAffine`, and the plane with a doubled origin. Applied.** The node keeps "separated". The plane with a doubled origin is a check of `Sheaves.qcqsScheme_passable` (its diagonal is quasi-affine and not affine) and is named in a proposed "Open items" entry.

## The checker

**M1. The tag of Definition 13.37.1. Right; fixed.** Tag 09SM is Section 13.37; Definition 13.37.1 is tag 07LS (both titles read today). My first check read the first block of the page of 09SM, which is the definition, and not the title. I then read the title of every tag that the branch cites: 06YZ, 08DT, 06Z0, 08CM, 07LS, 09IQ, 09IR, 09IS, 09IM, 09M1, 02JR are as cited. Places corrected: `PerfectGenerator.toml`, the proposal (section 8).

**M2. Perfect complexes and #43025. Right; fixed.** As Codex 3. The sentence "The pseudo-coherent and the perfect complexes of SchemeAndStackFoundations §2.18 are not there" and the row of the ready module are corrected.

**M3. The source of form (a). Right; fixed.** Confirmed in `DBunG.tex`: §1.1.7 defines `Hom_C` as `H^0` of the mapping complex, and §1.2.2 has no shifts. `Infinity.compactGeneration` now says that the plan reads the condition of the paper for the set of all shifts, and that without the shifts it is not equivalent to (b). The checker's example (`Hom(k, k[1]) = 0`) is a check of `Infinity.compactGeneration_of_homotopyCategory`. The `source` cites §§1.1.7 and 1.2.2.

**U1. "The accepted roadmap SchemeKTheoryOperations uses it". Right; fixed by the decision above.** The sentence is removed. The node now says what §2.6 is about and that it has a route inside triangulated categories.

**U2. Clause (1) as a reading. Right; the node says so more exactly.** `Sheaves.derivedQCoh_perfectGenerator` names both readings and says that the weaker one serves the users, because `O_X` is compact by `totalDirectImage_coproduct`. The interface check at the deletion of the node settles it. No change of the statement.

**Item 1a, the source of quasi-affine and "an affine derived scheme". Applied.** As Codex's first improvement.

**Item 1a, a negative example in the definition's node. Applied, with one correction.** `Sheaves.passable` names the coproduct, in prestacks, of countably many copies of `Spec k`: its QCoh is a product of copies of `Vect`, and the unit is not compact. The correction: for this prestack condition (1) fails as well, because the fibre of the diagonal over two different indices is the empty prestack, which has no point on the zero ring and so is not a scheme. So it shows that the definition is not always true, and the independence of (2) from (1) and (3) is shown by the scheme in `Sheaves.qcqsScheme_passable`.

**Item 1b, the test as a theorem node of its own. Applied.** `Infinity.compactGeneration_of_homotopyCategory`, in its own module. `Infinity.compactGeneration` lost the dependency `Infinity.homotopyCategoryPretriangulated`, so `Infinity.dualizableCategory` and the nodes above it do not wait for the test.

**Item 4, the helper lemma on quasi-affine derived schemes. Applied.** `Sheaves.qcqsScheme_passable` states it with its proof: for a quasi-compact `Z` with an affine map `f` to an open subscheme of an affine derived scheme `T`, with `j` the inclusion of a quasi-compact open that contains the image, the relative spectrum of the connective truncation of `j_* f_* O_Z` is affine and contains `Z` as an open subscheme. I give the proof and no reference: the checker's reference to Spectral Algebraic Geometry is from memory, and the book is not pinned.

**Item 4, two open points on the held node. Recorded.** As Codex 4: the proposed "Open items" entry names the home of the prestack of a classical scheme (under `Derived/`) and the node for the comparison.

**Item 5, `Stacks.determinantBundle` waits longer. Recorded.** The proposal says it in section 4 and in a proposed "Open items" entry.

**Item 5, `DModules.IsULAModuleCategory` needs generation by perfect objects of QCoh of the prestack. Right; fixed.** Its dependency is now `Sheaves.qcoh_compactGeneration_of_qcqsScheme`, which exports that statement.

**Item 6, `TauCeti.DerivedDeRham.IsPerfect`. Applied.** `Sheaves.derivedQCoh_perfectGenerator` and the table of upstream declarations name it for the affine case.

**G1. Step (c) told the worker to write perfect complexes. Right; fixed.** The guidance names `IsPerfectComplex` of SchemeKTheoryOperations §1.3 as an input to wait for and not to write.

**G2. The chain through Lemma 36.13.11. Right; fixed.** Confirmed on the page of tag 09IQ: "Proof. Special case of Lemma 36.13.11." Confirmed at SchemeKTheoryOperations lines 864–876. The node and the guidance name Lemmas 36.13.6 to 36.13.11 as inputs that SchemeKTheoryOperations §3.2 owns. One more fact for the session: the target of Lemma 36.13.11 in §3.2 lists "SchemeAndStackFoundations §2.18, perfect generators" under its needs (line 878), so the two roadmaps point at each other here; the special case that Lemma 36.15.1 uses needs no generator in Stacks.

**G3. The universe in step (e). Applied.** As Codex 2.

**G4. "One pull request for each step". Applied.** The guidance says that each piece of step (c) is a pull request of its own or more than one.

**`docs/papers.md` and `docs/references.bib`. Applied.** The lines of [LurieHA] and [StacksProject] name the cited parts and tags.

## My own reading of the nodes that the branch adds or rewrites

1. **`Sheaves.derivedQCoh_perfectGenerator`, the check on the countable disjoint union of points.** It said that quasi-compactness is needed for (1). It now also says that (2) holds there with `P = O`, so the check separates the two clauses.
2. **`Infinity.compactGeneration`, a set of generators not closed under shifts.** The node says that `S` need not be closed under shifts in (a), (b), (c), and that the empty set satisfies each form only in the zero category.
3. **`Infinity.compactGeneration_of_homotopyCategory`, the empty set and the definition of compact.** For the empty `S`, (iii) says that a category in which every object is zero is presentable. The node states what compact means there (preservation of small filtered colimits by the mapping-space functor) and that `C` is not assumed presentable.
4. **`Sheaves.schemeQCoh_compactGeneration`, the supplier of each step.** The proof now names, for each input, the node that gives it: stability, coproducts, small Hom sets and the two directions on perfect objects from `Sheaves.schemeQCoh`; (2) from part (ii) of the test; (1) from part (iii); (3) by transport of the detection of zero.
5. **`Sheaves.qcqsScheme_passable`, the product.** The diagonal maps to the product of prestacks; the node says that the classical product over the field `k` is that product.
6. **`Sheaves.properPerfectPushforward`** depends on the lemma that gives dualizability, and not on passability, which it does not use.
7. **A quotation that was a paraphrase.** `Infinity.compactGeneration` had the condition of [CompactGeneration] §1.2.2 in quotation marks in my words; the marks are removed.

## Counts

Fixed, 24: Codex 1, 2, 3, 4, 5 and its three improvements; the checker's M1, M2, M3, U1, eight improvements of its items (the source of quasi-affine, the negative example, the split of the test, the helper lemma, the ULA dependency, `IsPerfect` at the pin, the two bibliography files counted once, the record of what waits longer), G1, G2, G3, G4.

Answered without a change of a node, 3: Codex 6 (the node is restored and the finding is a proposed open item), U2 (the reading stays, stated more exactly), and the two open points on the held node (recorded as a proposed open item).

Disagreements: none on a finding. Where the two reports differ, on the provider of the enhanced corollary, I decide with Codex.
