# Answers to round 2: `proposal/tannakian-reconstruction`

Step 4 of `prompts/change.md`. The report is `notes/checks/tannakian-reconstruction-codex-2.md` (Codex on `530916a`: the seven objections and three improvements of round 1 resolved; five new blocking objections on the wording of recorded facts; three improvements that can wait).

**Result.** All five objections are right and are fixed. For each one I read the source again before I wrote the corrected sentence, and I searched the branch for other sentences with the same claim. Then I checked every factual sentence that the branch adds or changes about a source (section “The check of every factual sentence”). That check found 14 more descriptions to correct, some of them in several places, all of the same kind: a description that was looser than its source. No node, construction or claim of the plan changed. `notes/checks/tannakian-reconstruction-answers-1.md` is a record of round 1 and is not edited; where this file corrects a sentence that it repeats, this file is the current one.

## The five objections

**1. The root comment gave [MV] a claim about a larger category. Right; fixed.**

- Source read: [MV] §11, TeX lines 3435–3459. The anti-involution `A ↦ A^* = 𝔻(i^*A)` is defined on `P^{k-proj}`, the objects `A` for which `H^*(Gr, A)` is `k`-projective. The sentence on rigidity is: “This involution makes `Rep^{k-proj}_{G̃_k}`, the category of representations of `G̃_k` on finitely generated projective `k`-modules, a rigid tensor category.” §7 is titled “The case of a field of characteristic zero”.
- `GLCinLean.lean`, the item under “Errors and gaps found in the sources”: it now says that the source defines the anti-involution on the objects whose total cohomology is a projective module over the coefficient ring, and states without proof that it makes the representations of the group scheme on finitely generated projective modules a rigid tensor category; that over a field every object of the spherical category has projective total cohomology; and that [MV] §7 obtains rigidity from [DeligneMilne] Proposition 1.20 “for a field of characteristic 0”.
- Same claim elsewhere, corrected in the same way: `Satake.sphericalHeartDual` (“[MV] states the duality and gives no proof” is now the qualified sentence, and the sentence on [MV] §7 begins “For a field of characteristic 0”); the proposal, section 2.6 (with Codex's example: over ℤ, for the trivial group, ℤ/2 has no dual), section 4.2 (the bullet of the node), section 4.3 (the account of the root entry, which was the line that Codex named) and doubt 3.
- Not in `plans-proof/`, `docs/` or the worker's guidance: none of them states this claim.

**2. Unit and counit were interchanged. Right; fixed.**

- Source read: Mathlib `CategoryTheory.ExactPairing X Y` has `coevaluation' : 𝟙_ C ⟶ X ⊗ Y` and `evaluation' : Y ⊗ X ⟶ 𝟙_ C` (`Monoidal/Rigid/Basic.lean`, lines 76–90). `tensorRightAdjunction (Y Y') [ExactPairing Y Y'] : tensorRight Y ⊣ tensorRight Y'` (line 464).
- `Satake.sphericalHeartDual`: the sentence “evaluation and coevaluation are its unit and counit” is replaced by: the isomorphism `Hom(A ⋆ B, C) ≅ Hom(A, C ⋆ B^∨)` is an adjunction with `− ⋆ B` on the left and `− ⋆ B^∨` on the right; its unit at `IC_0` is the coevaluation `IC_0 → B ⋆ B^∨`, and its counit at `IC_0` is the evaluation `B^∨ ⋆ B → IC_0`, both after the unit constraints. This is `tensorRightAdjunction B B^∨` for `ExactPairing B B^∨`, with `Y = B` and `Y' = B^∨`.
- Same claim elsewhere: none. The proposal and the provider record name the adjunction and the pairings, not which is the unit; I read each of these sentences again and they have the right orientation.

**3. One codomain was given for comparisons that have three. Right; fixed.**

- Source read: `Suggested.lean`, lines 102–131. `coalgebra_reconstruction` gives `Nonempty (E.functor ⋙ forget₂ _ (ModuleCat K) ≅ ω ⋙ forget₂ _ (ModuleCat K))`, with no monoidal condition. `neutralTannakian_recognition` gives `α : E.functor ⋙ forget₂ _ (SemimoduleCat K) ≅ (ω ⋙ forget₂ _ (ModuleCat K)) ⋙ (ModuleCat.equivalenceSemimoduleCat (R := K)).functor` with `NatTrans.IsMonoidal α.hom`. §6.3 has no signature; its marking is between two fibre functors, whose target is `FGModuleCat K`.
- The proposal, section 2.1 (“The signature”): the comparison of the recognition is written out, and three sentences name the three codomains. Section 2.1 (“What the sections need”): the comparison of `coalgebra_reconstruction` is “in `ModuleCat K`”. Section 4.1: the sentence that gave one codomain now gives the three and says that the step for the torus in `Satake.tannakaRootDatum_equiv_dual` is where a comparison in `SemimoduleCat k` is read as a marking, through the forgetful functor of comodules to `FGModuleCat k`. The table of section 4.1 says “in `SemimoduleCat K`” for the recognition.
- Same claim elsewhere: `Tannaka.neutralReconstruction` described `coalgebra_reconstruction` as “the coalgebra and the equivalence of (1) and (2)”; clause (2) has a braided functor, which §5.2 does not give. It now says “a coalgebra and the equivalence of (2) without its tensor structure, with a comparison of the fibre functors in `ModuleCat K`”, with the hypotheses of the signature. The other nodes were right, as Codex found: `Tannaka.neutralReconstruction` (3), `Satake.cohomologyFiberFunctor` (e), `Satake.tannakaGroup` and the row of `ModuleCat.equivalenceSemimoduleCat` in the provider record each name the comparison they mean.

**4. Three descriptions of pinned declarations. Right; fixed.**

- `SchemePoints.lean` (lines 41–49): `variable (k : Type u) [Field k] (G : AffineGroupSchemeCat (CommRingCat.of k))`. I read the `variable` lines of all 15 files: 14 start from a bialgebra or a Hopf algebra, and this one from an affine group scheme. Corrected in `Tannaka.neutralReconstruction` and in the proposal, section 2.3. The proposal also said “a commutative Hopf algebra”; several files take a bialgebra or a Hopf algebra over a semiring that need not be commutative, so the word is removed.
- `TauCeti.projectivizationFunctor` (`Projectivization.lean`, lines 196–241): `(additiveClosure M).FullSubcategory ⥤ (finiteProjectiveModules (End M)ᵐᵒᵖ).FullSubcategory`, with `instance [IsIdempotentComplete C] : (projectivizationFunctor M).IsEquivalence`. The proposal, section 2.3, now says: right modules of `End M`, written as left modules of the opposite ring; an equivalence when the category is idempotent complete. No node or provider row names this declaration.
- The matrix-coefficient theorem (`Faithful/Basic.lean`, lines 317–324): `{k H V : Type u}`, `[CommRing k] [CommRing H] [HopfAlgebra k H]`, `(b : Basis (Fin d) k V)`. The proposal, section 2.3, and `Tannaka.finiteType_iff_exists_tensorGenerator` now say “over a commutative Hopf algebra over a commutative ring, a comodule with a basis indexed by `Fin d`”. The node had “a comodule with a finite basis” and “a given commutative Hopf algebra”; it now names the base ring and the index type.

**5. The connectedness inventory. Right; fixed.**

- Source read: `Representation/LieStable.lean` (`Submodule.exists_subcomodule_iff_forall_differential_mem`, for a connected group of finite type over an algebraically closed field of characteristic 0). A search of `Algebra/AlgebraicGroup/Representation` and `Algebra/Coalgebra/Comodule` finds 28 files that mention connectedness. A search of all of Tau Ceti for “subquotient” finds 53 files; two are under `Algebra/AlgebraicGroup` (orthogonal subquotients of a space with a form), and none defines the hull of the subquotients of the finite direct sums of an object, so the hulls of the criterion are not there in any form.
- Corrected in the three places that Codex names: `Tannaka.connected_iff_not_tensorClosed_hull`, the row of `TauCeti.geometricallyConnectedCommHopfAlgProperty` in the provider record, and the proposal, section 2.3. Each now says that the pin uses connectedness for representations and that what is missing is the characterization of connectedness by the tensor closure of the hulls of finite direct sums and subquotients.
- The universe: `geometricallyConnectedCommHopfAlgProperty (k : Type u)` quantifies over `(K : Type u) [Field K] [Algebra k K]`. The same three places now say “in the universe of K” (of the base field).
- Same claim elsewhere: none. `Satake.tannakaRootDatum_equiv_dual` and the worker's guidance name the property and do not describe it.

## The improvements that can wait

Two are a single phrase in a node that the branch already changes, and are applied: the group algebra in the check of `Tannaka.reconstructionMap` is that of a commutative group “in the universe of K”; and the parity check of `Satake.tannakaGroup` names the object, “the IC object of the minuscule coweight, whose orbit is a projective line in the odd component”, with its cohomology in the degrees −1 and 1. The others are not applied; they are in the proposed “Open items” of the proposal, section 5 (the coherence identities, the §6.8 node and the rational model, the last step of the root datum).

## The check of every factual sentence

Scope: every sentence that the branch adds or changes in the four roadmap nodes, the five Satake nodes, the node and the README of `plans-proof/`, the changed rows and paragraphs of `docs/blueprint-providers.md`, `docs/papers.md`, `docs/references.bib`, the root-file item, the proposal and the worker's guidance. “Changed” below means corrected in this round; every other item was compared and is right.

### (a) Descriptions of declarations at the pin

Opened and compared, with hypotheses, universe binders, sides and conclusion:

| Declaration | Compared | Result |
|---|---|---|
| `TauCeti.Tannaka.pointsFunctorIsoTensorAutFunctor`, `fgPointTensorIsoEquiv`, `tensorAutFunctor`, `reconstructedPoint` | `(k H : Type u) [Field k] [CommRing H] [HopfAlgebra k H]`, `CommAlgCat.{u} k`, `uliftFunctor.{u + 1, u}`, `WithConv (H →ₐ[k] A) ≃* Aut (…)` | right (one universe, convolution product, lift by one universe) |
| the 15 files of `Representation/Tannaka` | the `variable` lines of each | changed (objection 4) |
| `TauCeti.FGComoduleCat` and its instances | `Finite/Basic.lean:94`; `Abelian` under Noetherian and flat; `instBraidedCategory`, `instSymmetricCategory` over a commutative bialgebra; `instRigidCategory` over a field; `instForgetBraided` to `SemimoduleCat`; `Additive`, finite limits and colimits for `forget₂` to `ModuleCat` | right |
| `TauCeti.ConvolutionDual`, `TauCeti.Comodule.convolutionActionEquiv` | the coalgebra instance needs a finite projective algebra; right coactions of a finite projective coalgebra against algebra maps from its convolution dual to the endomorphisms | right; the guidance and one row said “a finite algebra” and listed both names as “the dual coalgebra”: changed |
| `TauCeti.FGComoduleCat.corestrict` | `(f : C →ₗc[R] D) : FGComoduleCat R C ⥤ FGComoduleCat R D` | right |
| `DirectSum.IsInternal.monoidAlgebraComodule` | `{A : G → Submodule R V} (hA : IsInternal A) : Comodule R (MonoidAlgebra R G) V`, for a type `G` with decidable equality | the row said “a module with a `G`-grading” over “a group algebra”: changed to the decomposition indexed by a type and the monoid algebra |
| `TauCeti.VecTwisted` | `(k G : Type u) [Field k] [Monoid G]`, a `TwistingCocycle`; `instMonoidalCategory`; no `One` or named trivial cocycle at the pin | “with the trivial cocycle” changed in four places to “for a normalized 3-cocycle; the cocycle with constant value 1 gives the untwisted associator” |
| `TauCeti.geometricallyConnectedCommHopfAlgProperty` and its form by idempotents; `identityComponentHopfIdeal`; `componentGroupScheme` (`[IsAlgClosed k]`, finite type) | definitions and binders | changed (objection 5, the universe); the rest right |
| `TauCeti.reductiveCommHopfAlgProperty_iff_linearlyReductive` | `{k : Type u} [Field k] [CharZero k]`, `H : FiniteTypeCommHopfAlgCat.{u, u} k`, geometric connectedness | right |
| `TauCeti.Coalgebra.isLinearlyReductive_iff_forall_nonempty_splitting` | `[Field k]`, `IsLinearlyReductive.{u, v, u} k C ↔ ∀ S : ShortComplex (FGComoduleCat.{u, v, u} k C), S.ShortExact → Nonempty S.Splitting` | right |
| `TauCeti.Comodule.isFaithful_iff_matrixCoefficientSubalgebra_sup_antipode_eq_top` | see objection 4 | changed |
| `TauCeti.Comodule.exists_coordinateBialgHom_surjective` | a finite-dimensional subcomodule of the regular comodule with a basis and a surjective coordinate map | the proposal said “has a faithful finite comodule”: changed to the statement |
| `TauCeti.projectivizationFunctor` | see objection 4 | changed |
| `CategoryTheory.Functor.precomposeLaxMonoidal` | `(F : C ⥤ D) [F.LaxMonoidal] : LaxMonoidalFunctor D E ⥤ LaxMonoidalFunctor C E` | the proposal said “along a monoidal functor”: changed to the statement |
| `TauCeti.fgPointRepresentationCategoryEquivalence`, `TauCeti.AffineGroupSchemeCat.algebraPointsFunctorIsoTensorAutFunctor`, `TauCeti.Comodule.isInternal_weightSpace` | signatures | right |
| Mathlib `FGModuleCat` | `[Ring R]`; the monoidal structure under `[CommRing R]`, symmetric as a full subcategory | the row said “over a ring, with the symmetric monoidal structure”: changed to “over a commutative ring” |
| Mathlib `CategoryTheory.ExactPairing`, `HasRightDual`, `HasLeftDual`, `RigidCategory`, `tensorRightAdjunction` | fields and sides | changed (objection 2); “`ExactPairing A A^∨` makes `A^∨` a right dual, `ExactPairing A^∨ A` a left dual” is right |
| Mathlib `CategoryTheory.Functor.Braided`, `CategoryTheory.EssentiallySmall`, `ModuleCat.equivalenceSemimoduleCat`, `TannakaDuality.FiniteGroup.equiv`, the equivalence of Galois categories | definitions | right |

### (b) Sentences that say something is absent at the pin

Each was searched by content again, and the sentence now says exactly what is missing.

- No construction of a coalgebra, bialgebra or Hopf algebra from a category with a fibre functor; no structure for a neutral Tannakian category. Searched: “Tannak”, “fib(er|re) functor”, “neutral”, “coend”. Right.
- No subcategory `⟨X⟩`. Searched “subquotient” in all of Tau Ceti: 53 files (composition series, filtrations of modules, homology, two on orthogonal subquotients for group representations); none defines the full subcategory of the subquotients of the finite direct sums of an object. Right.
- No `Linear`, `MonoidalPreadditive`, `MonoidalLinear` or `EssentiallySmall` instance on `ComoduleCat` or `FGComoduleCat`; no functor from them to `FGModuleCat`. Searched the instances of these classes in `Algebra/Coalgebra` and `Algebra/AlgebraicGroup/Representation`, and “FGModuleCat” in both. Right.
- `corestrict` has no monoidal structure and no criterion. Searched “corestrict” with `Monoidal`, `Braided`, `Full`, `Faithful`. Right.
- No braiding on `VecTwisted` and no comparison with comodules. `VecTwisted` occurs in its own file only. Right.
- “No recognition of an abelian category with a projective generator as a category of modules” (the proposal): changed to say what the pin has (Morita theory for module categories of rings, and `projectivizationFunctor` for the additive closure of one object) and what it lacks.
- “No statement relates connectedness to representations”: changed (objection 5).
- No category named `Rep` for group schemes. Searched the definitions named `Rep`, `RepCat`, `FDRep` under `Algebra` and `AlgebraicGeometry`. Right.
- No work on the target in open pull requests and issues: the sentence listed the same phrases for both. The issues were searched for two phrases only. Changed in the proposal and in the provider record to say which searches were made.

### (c) Statements attributed to a paper or a roadmap

- [MV] §2 (coefficient rings), §6 (the introduction; Lemma 6.1, Propositions 6.3 and 6.4), §7 (its title, the two citations of [DM], Remark 7.2), Propositions 9.1 and 10.1, §11 (the opening, Proposition 11.1, the anti-involution), §12 (its use of Proposition 11.1): read again. Changed: the rigidity of §11 (objection 1) and the scope of §7 in two sentences.
- [DeligneMilne], version of 2022: Proposition 1.20 with footnote 5, Proposition 2.16 with footnote 12, Remarks 2.17 and 2.18, Definition 2.19, Theorem 3.2. Changed: “Proposition 1.20 is proved through the monoid scheme (Remark 2.18)” is now “the paper indicates a proof” (the paper refers to another text for a direct proof and gives this one in the remark); `docs/papers.md` said that the proof of Proposition 2.16 “is replaced”, and footnote 12 says only that the original made an incorrect claim.
- [GeometricFeiginFrenkel] §5 and [BDHitchin] 5.3.22: right.
- MotivesAndAlgebraicCycles: every quotation of the “Scope and ownership”, §§3.6, 5.2, 6.1 to 6.4, 6.8, the three “Dependencies” and “Downstream consumers” was compared with the README. Changed: the check of §6.1 on super vector spaces says that they “do not have an ordinary symmetric forgetful fiber”, which the proposal had paraphrased as “have no such functor”; §3.6 is terminology for a field of characteristic 0, not “the same definition”; and the comparisons of objection 3.
- The five consumers of §§6.1–6.3 and their section numbers (GS4 and §4.6; §RD.2.52; §5.5; §2.1; §5.3): searched again in all READMEs, with the other roadmaps that cite MotivesAndAlgebraicCycles (they take §6.8 or other layers). Right.
- “No roadmap README cites [DeligneMilne] Proposition 1.20”: searched every README for “1.20” near “DM”, “Deligne”, “Milne”, “Tannak” or “rigid”; 20 matches, none on this proposition. Right.
- GeometricSatakeAndFusion: its “Conventions” give a nonarchimedean local field and “prime-to-p torsion rings and derived-complete `ℓ`-adic coefficients, with `ℓ≠p`”; §4.7 is the Witt-vector Grassmannian with `ℚ̄_ℓ`-sheaves. The branch said “ℓ-adic sheaves … with coefficients in `ℤ_ℓ`-algebras and `ℚ̄_ℓ`”. Changed in the provider record, the proposal (section 2.7) and `Satake.sphericalHeartDual`. The proposal's option (e) said that this roadmap needs the relative reconstruction “for coefficients that are not fields”; §4.2 gives the reason exactly (`A=Rep_{W_E^I}^{fp}(Λ)`), and the sentence now says so. §§2.10, 3.4, 4.6, 4.11: right.

### (d) Adjunctions, pairings, actions and composites

Each direction was written out and checked at the unit object and for the trivial group.

- `Hom(A ⋆ B, C) ≅ Hom(A, C ⋆ B^∨)`: `(− ⋆ B) ⊣ (− ⋆ B^∨)`; unit at `IC_0` is `IC_0 → B ⋆ B^∨`, counit is `B^∨ ⋆ B → IC_0`. For the trivial group these are `k → B ⊗ B^*` and `B^* ⊗ B → k`, which are Mathlib's `FGModuleCatCoevaluation` and `FGModuleCatEvaluation`. For `B = IC_0` both are the unit isomorphisms. Changed (objection 2).
- `ExactPairing A A^∨` (coevaluation `IC_0 → A ⋆ A^∨`, evaluation `A^∨ ⋆ A → IC_0`) and the second pairing through `(A^∨)^∨ ≅ A`: right.
- `Tannaka.reconstructionMap`: `U : D → C`, `g_U : Spec B_C → Spec B_D`, `b_U : B_D → B_C`; `g_{U∘V} = g_V ∘ g_U` and `b_{U∘V} = b_U ∘ b_V` for `V : E → D`; on points, restriction of an automorphism of `ω_C` along `U`. For `C = FGModuleCat K` and `U = ω_D` the maps are the trivial subgroup and the counit. Right.
- The torus: `D` the heart, `C` the comodules of `k[X_*(T)]`, `U = F_gr`; the homomorphism goes from the dual torus to the Tannakian group; the criterion asks that every object of `C` is a subquotient of some `F_gr(Y)`. Right.
- The coaction of a grading: a vector of the summand of `g` goes to `v ⊗ g`, a right coaction, and `FGComoduleCat` is the category of right comodules. Right.
- The points: algebra maps `B → R` with the convolution product against monoidal automorphisms; the torsor of `plans-proof/`: tensor isomorphisms from the scalar extension of the standard fibre functor to the second functor, with the group acting by precomposition ([DeligneMilne] Theorem 3.2, roadmap §6.8). Right.
- The dual of `IC_λ` is `IC_{−w_0 λ}`; of `IC_0`, `IC_0`. Right.

## Checks before the commit

`lake build` passes with only the `sorry` warning of the main theorem, `lake lint` passes, and `lake env lean tools/check-statement-axioms.lean` shows `sorryAx` for the main theorem only. `lake exe tracker lint` has no errors (171 module plans, 287 nodes). `python3 tools/check-module-cycles.py` finds no cycle. `python3 tools/check-upstream-names.py` confirms all 199 pairs. Every plan file of `plans/` and `plans-proof/` parses as TOML. The worker's guidance has 3,901 characters.
