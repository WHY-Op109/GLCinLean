# Independent review of the whole statement plan

Reviewed plan: **d6d74e0**, 239 nodes in 120 TOML files. Comparison review: `notes/reviews/d6d74e0-principles.md` at **d51c200**. Reviewer: Codex (GPT-6), 2026-11-11.

**Owner attention:** the plan needs revision before implementation. I confirm the five file-dependency cycles and much of the earlier review's generality and reuse criticism, but do not accept all its claims or proposed repairs. Additional findings N1–N11 below include incorrect mathematical contracts, missing interfaces, and reuse obligations absent from that review. N1–N3 are definite mismatches in the written descriptions. N4, N5, N7 and N11 need explicit contracts before implementation. E15's full proposed scope and part of E23 remain unsure. Nothing in this report changes Lean, the plan, the approved conjecture, dependency pins or owner decisions.

The 24 verdicts below concern the earlier review's **core claim**, with qualifications stated explicitly. They are not endorsements of every sentence or of every suggested fix. “Agree” on an underspecified plan means repair the contract, not that an unimplemented Lean definition has already been proved wrong.

## Method and evidence

I personally read every node's description, dependencies and source field, in path order, before opening the earlier review. I recorded 27 candidate observations in a first-pass working note, then checked sources and opened the comparison review. Source-support agents looked up upstream signatures and principles; they did not assess the plan or read the earlier review. The coverage appendix lists all 239 nodes, including those with no additional finding. This is a plan/principles review, not the blind Lean-definition meaning review prescribed by `prompts/review.md`; no new definition is being approved here.

`git diff d6d74e0 -- plans AGENTS.md` is empty at starting HEAD `d51c200f9b9cb05d2c78aec3647fbc795bf7f721`. The local packages match the manifest: Mathlib **1b1ccf4b088b32fa3f23f2de1127433254a81e1e**, Tau Ceti **e0610cce4004d628cbd9d2aafdbbb5459fe72938**. Current remote Tau Ceti `main`, read for the two cited nilpotent-cone declarations, was **3895f92441d8563ba581d11c807798e2492250d7**. TauCetiReview was **b10925f02bf48d7624fc958cf7e067bc1efb79cd**. Its principles are cited at that immutable revision. Tau Ceti's AGENTS and COORDINATION were unchanged between the pin and that main snapshot.

I searched both pinned source trees for the relevant constructions, not just filenames: Weyl groups and length, torsors/stacks/gerbes, t-structures, Tannaka reconstruction, enhanced categories and support. Exact existing replacements are identified below; absence of a search hit alone is not a proof of absence. For paper checks I used the repository's TeX and the GRQCoh PDF, following `docs/papers.md`. HTT, BBD, Kumar, Deligne–Milne and LurieHA are not pinned there. I do not claim to have checked their complete theorems. Where this limits a proposed widening, I say so.

### Principle key

These links are the citations for the codes in every finding. `A31`, for example, means line 31 of [this project's AGENTS.md at d6d74e0](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/AGENTS.md#L31). The line numbers remain unchanged at review time.

| Code | Principle and source |
|---|---|
| G | [Tau Ceti generality, lines 6–13](https://github.com/TauCetiProject/TauCetiReview/blob/b10925f02bf48d7624fc958cf7e067bc1efb79cd/rubrics/generality.md#L6-L13): weakest appropriate assumptions, general result first, no unused abstraction. |
| R | [Reuse, lines 13–41](https://github.com/TauCetiProject/TauCetiReview/blob/b10925f02bf48d7624fc958cf7e067bc1efb79cd/rubrics/reuse.md#L13-L41): search existing APIs and near-copies; identify an actual replacement. |
| C | [Correctness, lines 12–37](https://github.com/TauCetiProject/TauCetiReview/blob/b10925f02bf48d7624fc958cf7e067bc1efb79cd/rubrics/correctness.md#L12-L37): check assumptions, quantifiers, degenerate cases and real prerequisites. |
| P | [Placement, lines 9–29](https://github.com/TauCetiProject/TauCetiReview/blob/b10925f02bf48d7624fc958cf7e067bc1efb79cd/rubrics/placement.md#L9-L29): canonical subject files. |
| API | [API design, lines 9–27](https://github.com/TauCetiProject/TauCetiReview/blob/b10925f02bf48d7624fc958cf7e067bc1efb79cd/rubrics/api-design.md#L9-L27): expose reusable characteristic interfaces. |
| N | [Naming, lines 8–20](https://github.com/TauCetiProject/TauCetiReview/blob/b10925f02bf48d7624fc958cf7e067bc1efb79cd/rubrics/naming.md#L8-L20), and [Mathlib naming](https://mathlib.org/contribute/naming.html): names track the type and conclusion. |
| D | [Documentation, lines 8–18](https://github.com/TauCetiProject/TauCetiReview/blob/b10925f02bf48d7624fc958cf7e067bc1efb79cd/rubrics/documentation.md#L8-L18), and [Mathlib documentation](https://mathlib.org/contribute/doc.html): accurate mathematical descriptions. |
| S | [Scope, lines 17–30](https://github.com/TauCetiProject/TauCetiReview/blob/b10925f02bf48d7624fc958cf7e067bc1efb79cd/rubrics/scope.md#L17-L30), and [Tau Ceti AGENTS, lines 8–21](https://github.com/TauCetiProject/TauCeti/blob/e0610cce4004d628cbd9d2aafdbbb5459fe72938/AGENTS.md#L8-L21): actual roadmap use; modest generalization is allowed, not unlimited scope expansion. |
| M | [Mathlib style](https://mathlib.org/contribute/style.html), especially “Conjunctions, disjunctions”: separate reusable conclusions; an existence theorem can yield a chosen construction. |

Repository rules used: A11–12 (search and roadmap ownership); A22 (Lean supersedes plan); A23 (proof-only work); A28–29 (style and documentation); A31 (no duplication); A32 (faithfulness and examples); A33 (generality); A34 (API); A35 (placement/imports); A37–38 (names and coordinated renames); A43–50 (statement, placeholders, review and approval).

## Verdicts on all 24 earlier problems

### E1 — File cycles: agree

Locations: the five groups in the earlier report are reproduced independently in the coverage appendix. Example edges: [`Derived.deRhamCechNerve_formalCompletion`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Derived/DeRham.toml#L18) depends on `formalCompletion`, while that construction depends on `deRhamPrestack` in the first file. The nine-file D-module group and seven-file Satake group are also real. These are cycles in the **suggested future module graph**, not cyclic Lean imports already present: nearly all those modules do not exist yet. The current project still builds.

**Principles:** P, API; A35. **Fix:** topologically layer the declarations, moving comparisons after both constructions. Split basic crystals, Υ, crystal comparisons, untwisted operations, twisted operations and duality; split spherical category, Cousin algebra and functor; move statement-dependent pinning invariance to a later comparison module. Acyclicity of the node graph makes an acyclic refinement possible without new mathematics. Do not solve this by putting everything in one enormous file. Check both node and module graphs after each move.

### E2 — Untwisted pullback routed through gerbes: agree, with a counting qualification

Locations: [`DModules.extraordinaryPullback`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Operations.toml#L4), [`DModules.rightCrystals`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Crystals.toml#L4), [`DModules.kashiwara`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Crystals.toml#L46). Untwisted pullback is already part of the crystal functor; importing twisted pullback forces the gerbe construction into basic operations. I reproduce **65 proper downstream nodes** of `Stacks.etaleGerbe`. The split “27 genuinely twisted / 38 others” is an interpretation, not a graph invariant; I do not certify all 38 as removable without inspecting each revised contract.

**Principles:** G, R, P; A31, A33, A35. **Fix:** use the existing planned untwisted crystal pullback and give the twisted extension its own name/module. Rewire only untwisted consumers. Its compatibility under trivialization already supplies the comparison, so no duplicate construction is needed. This removes an artificial prerequisite, not the gerbes genuinely needed for the automorphic category.

### E3 — Iwahori/Weyl reuse: agree, but upstream is not the whole answer

Location: [`Hecke.iwahoriWeylGroup`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/IwahoriWeyl.toml#L4). At the pin, Tau Ceti supplies `RootPairing.affineWeylGroup` (`Weyl/Affine/Basic.lean:211`), `extendedAffineWeylGroup` and `extendedAffineWeylGroupQuotientEquiv` (`Weyl/ExtendedAffine/Basic.lean:98,240`). Over **ℤ**, `coweightLattice` is the actual cocharacter module (`RootSystem/CoweightLattice.lean:296–304`), retaining the central torus. Over ℝ it must not silently replace the group's lattice by a maximal coweight lattice. Mathlib `CoxeterSystem.length` (`GroupTheory/Coxeter/Length.lean:59`) supplies length once the affine Coxeter structure is constructed.

**Principles:** R, API; A11, A31, A34. **Fix:** reuse the integral combinatorics and prove the geometric comparison and length extension. Tau Ceti's `fundamentalAlcoveStabilizer` still has nonempty-root and ordered-field hypotheses; its file explicitly says injectivity of the map to the lattice quotient is unproved. Thus tori, reducible systems, the full Ω identification and geometric orbit theorem remain obligations. N2 records a separate error the earlier review missed.

### E4 — Two Hecke-action nodes: agree

Locations: [`Hecke.action`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Hecke/Action.toml#L4) and [`Hecke.satake`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Hecke/Satake.toml#L4). Both describe naive Satake composed with the spherical action; the second is not the actual Satake functor, which is already `Satake.naiveFactorizationFunctor`.

**Principles:** R, N; A31, A37. **Fix:** keep one action construction and its coherent action laws, remove the redundant node and update all consumers. There is no lost mathematics. If implementation discovers a distinct curried functor worth exposing, make it an API of this action, not a second foundational object.

### E5 — Theta/root data overlap: agree

Locations: [`Curves.thetaCharacteristic`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Curves/Theta.toml#L4) and [`Stacks.rootGerbe`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Stacks/Gerbe.toml#L11). The same pair “line bundle plus power isomorphism” occurs twice; properness and connectedness are unnecessary to specify that pair.

**Principles:** G, R; A31, A33–34. **Fix:** one line-bundle-root object in line-bundle geometry, parameterized by a line bundle and exponent; theta characteristics use the canonical line on a smooth relative curve. The gerbe organizes these objects and their isomorphisms over test schemes. Do **not** make the elementary theta definition wait for the whole gerbe/prestack theory. Properness, connectedness and algebraic closure stay in the existence theorem where needed. The two actual consumers justify the shared object.

### E6 — Representation/QCoh comparison: agree

Locations: [`Hecke.representationCategory`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Hecke/Representations.toml#L4), [`Hecke.spreadClassifyingStack`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Hecke/Spread.toml#L4) and [`Hecke.ranRepresentations`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Hecke/Representations.toml#L11). The ordinary finite-dimensional heart, enhanced category of all representations, and QCoh on BH must be linked explicitly. `langlandsDual` is not required to define representations of H.

**Principles:** G, R, API; A31, A33–34. **Fix:** construct the generic enhanced representation category for affine algebraic H from the existing comodule API and prove its descent equivalence with QCoh(BH), including tensor structure and the finite-dimensional heart. Specialize to the specified dual group afterwards. This is a genuine comparison, not a claim that ordinary representations already provide an enhancement. Claim dualizability for finite-dimensional/perfect objects, not for every representation.

### E7 — Coadjoint invariant quotient: agree; upstream field scope now checked

Location: [`Groups.chevalleyMap`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Group/Nilpotent.toml#L4) and [`Groups.nilpotentCoadjointCone`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Group/Nilpotent.toml#L11). Current [Tau Ceti NilpotentCone.lean](https://github.com/TauCetiProject/TauCeti/blob/3895f92441d8563ba581d11c807798e2492250d7/TauCeti/Algebra/AlgebraicGroup/Tangent/Lie/Adjoint/NilpotentCone.lean#L82-L158) defines the adjoint invariant subalgebra and zero-fiber ideal over **any field**, with finite-dimensional cotangent space. These polynomial and ideal definitions are not complex-only. The plan says that the cited roadmap quotient target is complex-only; that is a different claim, which these generic definitions do not settle. The full coadjoint quotient and its comparison still need checking. The upstream Killing-form comparison does not cover a reductive center and must not be used there.

**Principles:** G, R, S; A11–12, A31, A33. **Fix:** factor invariant-polynomial algebra and its augmentation ideal for an actual finite-dimensional comodule; instantiate adjoint and coadjoint representations and prove the required geometric comparison. Keep the classical construction independent of `Derived.affineScheme`; add a derived embedding only where used. Extend existing Tau Ceti machinery through its Worker where its roadmap owns the work. “Modest generalization is allowed” does not authorize a new unrelated invariant-theory development. Merge/cache availability is required before changing this project's pin.

### E8 — Reductive/pinning assumptions on generic geometry: agree

Locations: [`LocalSystems.classifyingStack`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/LocalSystems/DeRham.toml#L4), [`LocalSystems.deRham`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/LocalSystems/DeRham.toml#L11) and [`Hecke.loopArcGroups`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/LoopGroups/Basic.toml#L4). [ArinkinGaitsgory] §10 explicitly starts with an arbitrary affine algebraic group; §11 introduces reductivity. Loop and arc functors require a group functor, not a Borel and root vectors.

**Principles:** G, P; A33, A35. **Fix:** BH in stack geometry for affine algebraic H, mapping local systems on the stated geometric input, loop/arc functors for group schemes; add smoothness, reductivity and pinning to the later results actually using them. Existing sheaf torsors are ingredients, not an already implemented BH. Separate representability and ind-properness from the raw functor definitions.

### E9 — Formal completion too narrow: agree

Locations: [`Derived.formalCompletion`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Derived/FormalCompletion.toml#L4) and [`Derived.deRhamCechNerve_formalCompletion`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Derived/DeRham.toml#L18). [DGIndschemes] §6.1 defines completion for a map on reduced test prestacks, and in particular for **any** map Y→X by X ×_{X_dR} Y_dR. Closedness is not needed for that fiber product or its base-change identity.

**Principles:** G; A33–34. **Fix:** general completion and Čech fiber-product identities first. Keep closedness, separatedness and finiteness on the theorem identifying the terms as the particular closed formal completions/indschemes used for crystals. A general identity does not automatically give representability. This repair follows the source construction directly.

### E10 — QCoh formal-completion localization: agree

Location: [`Sheaves.qcoh_formalCompletion_localization`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Sheaves/FormalCompletion.toml#L4). [DGIndschemes] §7.1.3 assumes the conditions of §6.6.1: a DG scheme, a qcqs closed subset represented by an ideal locally finitely generated. It is not restricted to a classical finite-type scheme. The asserted **pullback from the supported subcategory** is correct; one must not confuse it with ordinary extension by zero or unrestricted restriction-of-scalars.

**Principles:** G, C; A32–33. **Fix:** state the source hypotheses explicitly, including the finitely generated ideal condition, then derive the finite-type case. Do not widen the accompanying IndCoh theorem beyond its own almost-finite-type domain. The source's localization proof provides the route; the extra derived interfaces still have to be built.

### E11 — Pinning torsor and rational lifting: agree

Location: [`Groups.pinnings_torsor`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Group/Pinning.toml#L11). For a specified split T⊂B the simple-root coordinates make pinnings a torsor under T_ad without algebraic closure. The surjectivity T(k)→T_ad(k) is a separate assertion; it can fail over a general field (square roots for SL₂ are the elementary obstruction).

**Principles:** G, M; A33–34. **Fix:** general torsor theorem and separate rational lifting theorem under suitable hypotheses, then the application over algebraically closed k. The coordinate action proves the first; surjectivity on geometric points proves the second. Put classification-related work under the actual reductive-group roadmap once ownership is checked, not under an assumed blanket exemption.

### E12 — Scalar extension: agree on desired scope; proof route needs repair

Location: [`DModules.holonomicHom_fieldBaseChange`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/ScalarExtension.toml#L4). Field extension is flat whether or not either field is algebraically closed; algebraic closure should not be inserted into the basic comparison merely because the Satake application uses it. The node also bundles t-exactness, regularity, operations and Hom base change.

**Principles:** G, M, API; A33–34, A37. **Fix:** distinct scalar-extension functor and comparison lemmas over characteristic-zero field extensions, with regularity's precise definition and hypotheses checked. N11 corrects the claimed global embedding argument. The source book is unpinned, so this is a justified repair target, not a certified completed proof of every asserted compatibility.

### E13 — Associated adjoint bundle: disagree that a specialization is itself a defect

Location: [`Stacks.associatedAdjointBundle`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Stacks/Bundles.toml#L11), using [`Stacks.groupTorsor`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/Roadmap/SchemeAndStackFoundations/Torsors.toml#L4). A named universal adjoint bundle is an actual object used by the determinant line. The generic associated-bundle operation belongs to `groupTorsor`, so the planned construction can simply apply it. No duplicated generic proof or independent construction is required by the text.

**Principles:** R, API; A31, A34. **Action:** make the dependency/application explicit and reuse the generic API. Do not delete a useful mathematical object solely because it is a specialization. If implementation repeats the descent construction, that would become a real A31 defect. Neither pinned library currently supplies the full algebraic associated-bundle implementation; topological associated bundles are not replacements.

### E14 — Two Ran constructions without a general interface: agree

Locations: [`Hecke.ranSpace`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Hecke/Ran.toml#L4), [`Hecke.ranPseudoProper`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Ran/Homology.toml#L4), [`Hecke.correspondence_pseudoProper`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Hecke/Correspondence.toml#L11). Both Ran(X) and Ran(X_dR) occur. The latter is the approved statement convention, not an error.

**Principles:** G, R, API; A31, A33–34. **Fix:** one Ran construction with its nonempty-finite-configuration API, specialize to classical X and X_dR and prove the de Rham comparison. For space-valued inputs specify whether this is the finite-powers/surjections colimit and prove the claimed pointwise description in its valid domain; do not blindly take finite subsets of π₀ and erase automorphisms. This supports two real consumers without changing the statement's Ran source.

### E15 — Constructible/RH/decomposition generality: unsure as one combined claim

Locations: [`Constructible.derivedCategory`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Constructible/Complex.toml#L10), [`DModules.perverseHeart`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Perverse.toml#L4), [`DModules.schubertRiemannHilbert`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/RiemannHilbert.toml#L4), [`Constructible.decompositionTheorem`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Constructible/Decomposition.toml#L4). Schubert-only definitions of perverse structure and RH are unnecessary specializations. Basic constructible sheaves should allow suitable stratified spaces and coefficients. But “any stratified topological space” is not enough for all finiteness and six-operation claims, and the full decomposition theorem's coefficient/purity hypotheses must be read, not guessed. The smooth-source statement is a genuine proof input permitted by A32; it is not automatically a misstatement of BBD. HTT and BBD are missing from the pinned sources.

**Principles:** G, C, API; A32–34. **Fix:** select and record the actual source theorem and proof route; separate the ordinary/enhanced constructible theory, perverse theory, general algebraic RH and the exact proper-pushforward decomposition lemma needed. Use natural hypotheses for each established result, with Schubert corollaries. Do not assume decomposition as a field of the category. N1, N4 and N7 must be repaired regardless of the owner's scope choice.

### E16 — Hyperbolic geometry does not support its consumer: agree

Locations: [`Actions.hyperbolicInterpolation`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/GroupActions/Hyperbolic.toml#L4) and [`DModules.hyperbolicRestriction`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Hyperbolic.toml#L4). [BradenDG] §§1–2 treats finite-type algebraic spaces; the geometric provider promises only locally linear scheme actions while its user asks for arbitrary finite-type algebraic spaces. This is a contract mismatch, not just a hypothetical broader use.

**Principles:** G, C; A32–34. **Fix:** provide representability and interpolation in the consumer's algebraic-space scope, using the source's general proof and descent. The affine/locally linear construction is a useful stage. State separate comparisons for that stage; do not silently narrow Braden's stated consumer or assume all actions admit such charts.

### E17 — Smaller unnecessary assumptions and vague domains: agree

Locations: [`DModules.deRhamPushforward`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/DirectImage.toml#L4), [`Derived.artinStack`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Derived/Stack.toml#L4) and [`Sheaves.indcohTStructure`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Sheaves/IndCoh.toml#L25). Finite-type schemes over a field are noetherian, so a morphism between them is quasi-compact. “Include almost finite type hypotheses” risks baking finiteness into being an Artin stack. “In scope” does not specify a mathematical class.

**Principles:** G, D, API; A29, A33–34. **Fix:** drop the redundant quasi-compact assumption in that theorem; define Artin geometry independently and use the existing `locallyAlmostFiniteType` property at IndCoh constructions; write the precise scheme/stack hypotheses for the t-structure. These are interface changes, not claims that IndCoh exists with every desirable property on arbitrary stacks.

### E18 — Enhanced foundation too specialized: agree, with an existence distinction

Locations: [`Infinity.monoidalCategory`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/Roadmap/BordismFormalGroups/Monoidal.toml#L4), [`Infinity.moduleCategory`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/Roadmap/BordismFormalGroups/Module.toml#L4), [`Infinity.rightAdjoint`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/Roadmap/EnhancedDerivedSheaves/Adjunction.toml#L4), [`Infinity.rightKanExtension`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/Roadmap/BordismFormalGroups/KanExtension.toml#L4), [`Groups.pinning_exists`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/Roadmap/ReductiveGroups/PinnedRootData.toml#L17). Symmetric monoidal is too strong for the non-symmetric spherical action. An adjunction is not inherently k-linear, and a Kan extension does not inherently require presentability. However, existence of a right adjoint to every continuous functor **does** use presentability; deleting that hypothesis would be false. A chosen right adjoint need not itself preserve colimits.

**Principles:** G, C, API; A32–34. **Fix:** generic coherent monoidal/adjunction/Kan notions first; symmetry and presentability as additional structures or sufficient existence criteria. Separate general Ind-completion from its presentability result as well. Keep the roadmap as provider. State pinning existence for split reductive groups and deduce the algebraically closed-field case, without characteristic zero; the theorem requires split/maximal-torus existence, not merely the observation that the reductive predicate has no characteristic assumption.

### E19 — Fixed gerbe band: agree as an interface improvement, not as a revocation of approval

Location: [`Stacks.etaleGerbe`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Stacks/Gerbe.toml#L4). [GLys] §1.3 uses a commutative group object/band; pullback, products, inverses and trivialization torsors do not use the formula μ_n. The existing owner decision deliberately chose μ_n.

**Principles:** G, R; A31, A33. **Fix recommendation:** use an abelian sheaf band in the core gerbe API and μ_n for root gerbes and their character twist. Retain local triviality and band-preserving morphisms explicitly. No nonabelian theory or H² classification is required. This is a recommended new owner decision; it is not permission to implement an unmerged roadmap proposal. Reuse accepted upstream machinery and resolve ownership first.

### E20 — Setting's field assumptions: agree on the unused parameters, not on widening the conjecture

Locations: [`Statement.Setting`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/Statement/Conjecture.toml#L9) and `GLCinLean/Statement/Conjecture.lean:50–67`. Its current fields use `Field k`, but not `CharZero k` or `IsAlgClosed k`; the opaque duality datum also takes only `Field k`. These two assumptions belong to the geometric Langlands theorem and constructions, not the raw record as currently written.

**Principles:** G; A22, A33; approval A48–49. **Fix recommendation:** when the real setting is introduced, make the reusable data record depend only on the hypotheses its fields need, and keep characteristic zero/algebraic closure on the theorem and on constructions that use them. Leave today's approved placeholder signature in place until that coordinated replacement is ready. Removing assumptions from a data type is not a proof that the conjecture holds in positive characteristic.

### E21 — Proof-only clauses: agree

Locations: [`Hecke.ranInclusions`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Ran/Inclusions.toml#L4), [`Hecke.ranPseudoProper`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Ran/Homology.toml#L4), [`Groups.chevalleyInvolution`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Group/Pinning.toml#L4), [`Satake.dualIdentification`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Satake/DualGroup.toml#L11), [`Hecke.sphericalAction`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Hecke/Action.toml#L11). Ran inclusion fibers enter only the second clause of pseudo-properness; the Chevalley involution enters the statement closure through a comparison needed only in the proof; the Levi sentence is another application of the generic spherical action. I reproduce **14 proper downstream nodes** of `chevalleyInvolution`.

**Principles:** S, G, API; A23, A33, A35. **Fix:** split out inclusion pseudo-properness and involution compatibility into `plans-proof/`, keeping base Ran pseudo-properness and dual identification here. Treat a Levi action as an application of the general reductive-group construction, with its proof-only comparison there. Update all dependencies; a move must not leave a dangling reference. The general constructions retain their natural scope.

### E22 — Passability in the statement plan: agree, with a source-backed replacement

Locations: [`Sheaves.passable`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Sheaves/Passable.toml#L4), [`Sheaves.passable_tensorBaseChange`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Sheaves/Passable.toml#L11), [`Spectral.localization`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Spectral/Localization.toml#L4). The promised example is outside `plans/`. More decisively, [GRQCoh] **Proposition 3.1.7** directly proves QCoh(Y₁)⊗QCoh(Y₂) ≃ QCoh(Y₁×Y₂) if QCoh(Y₁) is dualizable, for arbitrary Y₂. The plan cites the later relative theorem, Proposition 3.5.3, and brings its passability machinery into a product calculation.

**Principles:** G, S, API; A23, A33–34. **Fix recommendation:** use Proposition 3.1.7 in its full generality. Take Y₁=(X^I)_dR, whose QCoh is dualizable through the crystal equivalence and compact generation, and Y₂=LS_H; use symmetry for the displayed order. Move passability and the relative theorem to `plans-proof/`, where they have actual relative consumers. This avoids a new predicate with an external example without narrowing the product theorem to this particular LS. Keeping passability with an explicit point example would be correct, but is unnecessary for the chosen construction.

### E23 — Names and kinds: agree on naming/placement; unsure on blanket kind errors

Locations: all node identifiers are listed in the appendix; representative cases are [`Derived.prestack`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Derived/Prestack.toml#L4), [`Derived.quasiSmooth`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Derived/QuasiSmooth.toml#L4), [`DModules.leftToRightCrystals`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Crystals.toml#L11), [`DModules.kashiwara`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Crystals.toml#L46) and [`Examples.nonemptySetting`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Examples/Setting.toml#L4). Source-named theorems and generic geometry in `Hecke` need repair. Υ belongs in Sheaves, with left-to-right crystals its specialization. Generic predicates should have predicate names, and type-valued constructors use UpperCamelCase.

But `qcoh` may return a bundled category rather than a sort; lowerCamelCase is then correct. A theorem may prove `Nonempty Setting`, an existential stratification or `IsEquivalence F`; choice can recover data. Thus the earlier statement “a Lean theorem cannot carry data” does not settle the kind of these unspecified nodes.

**Principles:** N, P, M; A28, A35, A37–38. **Fix:** decide the intended signature before renaming or changing kind. Explicit equivalences/functors get `definition`; existential statements stay theorems with conclusion names. Separate reusable constituent results rather than one multi-conclusion theorem. Update references in plans, proof plan, docs, prompts and the axiom tool in one coordinated change. Do not rename approved Statement declarations without the required review/approval.

The explicit theorem-name audit also includes the following topic/camelCase names. Choose conclusion names after fixing the signatures (for example `exists_setting`, an `isEquivalence_...` statement, or `..._cohomology_eq_zero_of_odd`); a single topic name cannot name several unrelated conclusions. These are E23 locations, not additional mathematical counterexamples.

| Planned theorem name | Location |
|---|---|
| `DModules.kashiwara` | `plans/GLCinLean/AlgebraicGeometry/DModules/Crystals.toml:46` |
| `DModules.schubertRiemannHilbert` | `plans/GLCinLean/AlgebraicGeometry/DModules/RiemannHilbert.toml:4` |
| `Constructible.decompositionTheorem` | `plans/GLCinLean/AlgebraicGeometry/Constructible/Decomposition.toml:4` |
| `Stacks.qcaStratification` | `plans/GLCinLean/AlgebraicGeometry/Stacks/Finiteness.toml:11` |
| `LocalSystems.quasiSmooth` | `plans/GLCinLean/AlgebraicGeometry/LocalSystems/DeRham.toml:18` |
| `Hecke.ranPseudoProper` | `plans/GLCinLean/AlgebraicGeometry/Ran/Homology.toml:4` |
| `Satake.icStalkParity` | `plans/GLCinLean/GeometricLanglands/Satake/Spherical.toml:18` |
| `Satake.icStalkParity_complex` | `plans/GLCinLean/GeometricLanglands/Satake/Spherical.toml:18` |
| `Satake.factorizationFunctorFromRegularComodule` | `plans/GLCinLean/GeometricLanglands/Satake/Factorization.toml:18` |
| `Examples.nonemptySetting` | `plans/GLCinLean/GeometricLanglands/Examples/Setting.toml:4` |
| `Examples.pointQCohIndCoh` | `plans/GLCinLean/GeometricLanglands/Examples/Point.toml:4` |
| `Examples.singularAffineSupport` | `plans/GLCinLean/GeometricLanglands/Examples/SingularAffine.toml:4` |

Generic namespace relocation includes the nodes in `AlgebraicGeometry/{LoopGroups,AffineGrassmannian,Ran}` currently named `Hecke.*`, as well as `LocalSystems.classifyingStack` and the Υ functor. Retain `Hecke.*` for actual Hecke modifications/actions. Predicate-like nodes `Derived.quasiSmooth`, `Derived.locallyAlmostFiniteType`, `Derived.pseudoProper`, `Stacks.qca`, `Sheaves.passable`, `Infinity.compactObject`, `Infinity.compactGeneration` and `Infinity.eventuallyCoconnective` require an explicit predicate/subcategory signature before their final capitalization is fixed. The appendix gives every location. Mathematical constructions returning a bundled category must not be capitalized merely because English calls them “categories.”

### E24 — Generic module descriptions: agree on documentation quality; disagree with two incidental claims

Locations: line 1 of each of the **22** files marked E24 in the appendix. I reproduce the counts: 16 copies of the generic Satake description, and 2 each of the generic examples, finiteness and coherent-D-module descriptions. These do not explain their modules and can be misleading after the proof-plan cut.

**Principles:** D, P; A29, A35. **Fix:** write a mathematical summary for each actual module after the split. A tracker `desc` is superseded by a real module docstring; it does **not automatically become** that docstring. Plan descriptions may legitimately contain provider/work instructions. An empty untracked directory is not a mathematical defect and Git does not store it. Neither point justifies deleting useful planning guidance.

## Additional findings from the independent pass

### N1 — Complex points need separatedness for Hausdorffness

Location: [`Constructible.complexPoints`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Constructible/Complex.toml#L4). The line with doubled origin over ℂ is a finite-type scheme whose analytic space is not Hausdorff: the two origins cannot be separated by disjoint neighborhoods. The current universal Hausdorff claim is false.

**Principles:** C; A32. **Fix:** construct complex points in the appropriate generality, then prove Hausdorffness under separatedness. Put separated finite-type hypotheses on the six-functor setting where needed; Schubert varieties are projective, so the intended application satisfies them. This corrects the claim without weakening that application or adding separatedness to unrelated constructions.

### N2 — The Iwahori-orbit index sets are reversed

Location: [`Hecke.iwahoriWeylGroup`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/IwahoriWeyl.toml#L4). The text assigns W̃ and W̃/W to Gr_G and LG/I, respectively. The correct order is **LG/I indexed by W̃**, and **Gr_G indexed by W̃/W_f**, with minimal representatives when using Schubert varieties. [PappasRapoport] §8 and [MV] §2 give the geometry; the plan's own Bott–Samelson node uses the correct quotient. For SL₂, the finite simple reflection and the identity give different flag cells but the same right coset modulo W_f.

**Principles:** C, D; A29, A32. **Fix:** correct the order and explicitly name the finite Weyl subgroup and right-coset convention. Reuse E3's combinatorics. This is a text-level correction, followed by the two distinct geometric orbit theorems.

### N3 — The connectedness criterion excludes even the trivial subcategory

Location: [`Satake.tannakaRootDatum_equiv_dual`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Satake/DualGroup.toml#L4). “No tensor subcategory has finitely many simple objects” is false: the tensor subcategory generated by the unit has one simple object. It also fails for the trivial group, a mandatory example. [MV] §7 contains similarly abbreviated language; copying it literally does not survive A32.

**Principles:** C; A32. **Fix:** exclude **nontrivial finite-quotient tensor subcategories**, or state the connectedness criterion directly in terms of finite quotient groups. Prove the weight argument for every nontrivial candidate. Record the precise Deligne–Milne criterion before implementation. The unit subcategory is allowed and the desired connectedness conclusion remains unchanged.

### N4 — Fixed-stratification constructibility is not preserved by arbitrary listed maps

Location: [`Constructible.derivedCategory`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Constructible/Complex.toml#L10), including its proper-pushforward promise. Give ℂ the one-stratum stratification. The proper inclusion {0}→ℂ sends a constant sheaf to a skyscraper, which is not locally constant on that stratum. Thus a category fixed to a supplied stratification does not have all the listed operations without compatibility/refinement.

**Principles:** C, API; A32, A34. **Fix:** distinguish constructible with respect to some algebraic stratification from constructible with respect to a fixed stratification. State compatible-map or refinement hypotheses for the fixed version and prove closure in the unrestricted constructible category. Keep coefficient finiteness and boundedness hypotheses explicit. This resolves the actual counterexample and supports the stratified parity argument.

### N5 — The star-pullback contract lacks its domain of definition

Location: [`DModules.starPullback`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Operations.toml#L18); consumers include [`DModules.hyperbolicRestriction`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Hyperbolic.toml#L4) and [`Whittaker.vacuumPoincare`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Whittaker/Poincare.toml#L4). The description says simply “Star pullback of D-modules.” In the unbounded D-module context it is generally only a partially defined left adjoint; [BradenDG] introduction and §3.1 explicitly warn about this. The hyperbolic node acknowledges pro-categories but the foundational node does not.

**Principles:** C, API; A32, A34. **Fix:** specify the pro-valued/partially defined operation and its representing subcategory. Prove representability on holonomic objects for the finite-type scheme maps covered by the six operations, and separately on the monodromic composites actually used; record smooth pullback separately. Establish the needed extension for the particular stack morphism χ in the vacuum construction, rather than inferring it from holonomicity for arbitrary prestack maps. This can support the application without falsely making the functor total. This is a missing contract, not a claim that the intended holonomic operation is invalid.

### N6 — The determinant line needs relative perfect pushforward

Locations: [`Stacks.determinantBundle`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Stacks/Determinant.toml#L4), [`Sheaves.qcohGlobalSections`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Sheaves/QCoh.toml#L11), [`Sheaves.determinant`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Sheaves/Determinant.toml#L11) and [`Satake.criticalDeterminantGerbe`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml#L4). The determinant node already requests proper perfect pushforward, but gives no explicit provider/dependency for its relative interface. A line on Bun_G is formed from **relative** Rπ_* along X×Bun_G→Bun_G, with perfectness and base change; mapping from the unit to global sections over k does not by itself supply this interface. The displayed normalized determinant also omits `det` on its first RΓ factor. The Grassmannian additionally needs relative determinant/factorization and signs, not just a determinant of a bounded complex without comparisons.

**Principles:** C, API, S; A12, A32, A34. **Fix:** add a named provider/dependency for proper perfect pushforward with base change and its descent to the relevant stack, reuse the EnhancedDerivedSheaves target where it owns that work, then construct the normalized determinant of the resulting perfect complex. Specify the relative-lattice determinant and gluing comparison for the Grassmannian. These are standard constructions and have concrete consumers, but they are real proof obligations, not hypotheses to insert into `Setting`.

### N7 — The constructible category mixes an ordinary derived category with enhanced inputs

Location: [`Constructible.derivedCategory`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Constructible/Complex.toml#L10). It says to build from Mathlib `DerivedCategory`, while depending on enhanced stable categories and t-structures. The ordinary triangulated derived category does not retain the coherent diagrams needed for an enhanced six-functor statement. Conversely, the parity calculation can be formulated on an ordinary derived category. The current text does not choose.

**Principles:** R, C, API; A31–34. **Fix:** choose an enhanced construction from the accepted enhanced-sheaf roadmap and prove its homotopy-category comparison with Mathlib, or explicitly keep this auxiliary constructible proof calculation ordinary and state the ordinary RH comparison it uses. Do not claim the ordinary category itself is an enhancement. The comparison allows existing ordinary APIs to remain useful.

### N8 — Bounded-below and t-structure APIs need a reuse bridge

Locations: [`Infinity.tStructure`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/Roadmap/BordismFormalGroups/TStructure.toml#L4) and [`Infinity.eventuallyCoconnective`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/Roadmap/EnhancedDerivedSheaves/TStructure.toml#L4). Mathlib `CategoryTheory.Triangulated.TStructure.plus` already is `∃ n : ℤ, t.IsGE X n` (`TStructure/Basic.lean:259`), with isomorphism and shift closure. The plan cites `TStructure` but not this existing bounded-below API.

**Principles:** R, API; A11, A31, A34. **Fix:** identify the homotopy category of the enhanced stable category with its canonical triangulated model, transport/use the existing t-structure and `plus` predicate where sufficient, and prove the enhanced truncation/mapping-space comparisons that the ordinary API cannot supply. No separate synonymous boundedness theory is needed. This does not justify replacing the enhanced category by its homotopy category.

### N9 — Generic categorical support infrastructure is placed under sheaves

Locations: [`Sheaves.hochschildCochains`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Sheaves/Hochschild.toml#L4) and [`Sheaves.gradedSupport`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Sheaves/GradedSupport.toml#L4). Endomorphisms of the identity of a suitable enhanced category and support for a graded central action are not sheaf-specific. `hochschildCochains` also depends on `Sheaves.indcoh` even though its description is generic. There are actual consumers, so these are not unused abstractions.

**Principles:** G, P, API; A33–35. **Fix:** give generic Hochschild/central-action and support APIs canonical category/algebra homes, with IndCoh as an application. Search and compare the pinned DG/A∞ Hochschild objects rather than inventing a parallel algebra; an E₂ enhancement still needs proof. Route any roadmap-covered prerequisite to its owner. Drop the application dependency from the generic definition.

### N10 — Several cross-domain prerequisites are unsupported by the definitions

Locations: [`LocalSystems.nilpotentCone`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/LocalSystems/Nilpotent.toml#L4) (`Groups.rootDatum`), [`Groups.simplyConnectedCover`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/Group/SimplyConnectedCover.toml#L4) (`Groups.langlandsDual`), [`Satake.criticalTwist_matchesBunDeterminant`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml#L11) (`Stacks.determinantSquareRoot`). The nilpotent coadjoint cone is invariant-theoretic; once it exists the global horizontal-nilpotence locus needs no selected root datum. The simply connected cover needs classification/existence for its own root datum, not a Langlands dual construction. The gerbe comparison is canonical and explicitly must not untwist by the chosen theta root.

**Principles:** G, P, API; A33–35. **Fix:** replace those dependencies by the actual generic invariant, classification and determinant-comparison interfaces; document any genuine remaining use. This removes implementation coupling, not mathematical prerequisites. Suggested graph edges alone do not establish that a future Lean theorem has unused arguments; the problem is the current implementation brief.

### N11 — The scalar-extension proof assumes a global smooth embedding

Location: [`DModules.holonomicHom_fieldBaseChange`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/ScalarExtension.toml#L4). It treats every finite-type scheme by “a Kashiwara embedding into a smooth ambient scheme.” Such a global embedding is not supplied for arbitrary schemes in that scope. Non-quasi-projective schemes cannot simply be placed in an affine or projective ambient scheme. This observation alone does not rule out an embedding into some other smooth scheme; the defect is the missing embedding hypothesis or local-to-global argument. The crystal/D-module comparison currently supplies only the **given-embedding** case ([`DModules.rightCrystals_equiv_dModules`](https://github.com/WHY-Op109/GLCinLean/blob/d6d74e0/plans/GLCinLean/AlgebraicGeometry/DModules/Crystals.toml#L32)).

**Principles:** C, API; A32, A34. **Fix:** prove the comparison on affine charts embedded in affine space, establish independence of embedding and compatibility on overlaps, and descend the operations and Hom/base-change statement. Alternatively explicitly restrict an intermediate lemma to supplied embeddings and use descent for the general theorem. Do not add global embeddability to every Satake-facing definition to bypass the missing glue. The local embedding is available for finite-type affine schemes; descent is the real remaining work.

## Fix sequence and evaluation of the earlier six steps

These are proposed repairs, not edits already applied. For every semantic change, use a fresh review under A46; unresolved meaning goes to the owner. Changes to the statement or meaning of its existing dependencies follow A48–50. Report-only work needs no such approval.

| Earlier step | Verdict | Concrete repair and completion test |
|---|---|---|
| 1. Separate twisted pullback | Agree | E2: expose the already planned untwisted functor, split twisted API, inspect every edge. Verify unneeded gerbe paths disappear while twisted Hecke action retains its real dependency. |
| 2. Break cycles | Agree, incomplete as a list of moves | E1: split all five strongly connected groups, not only the examples listed. Υ and crystal comparison need separate layers; data and their later theorems may need separate files. Rerun node and file acyclicity checks. This is feasible since the node graph is acyclic; review scope changes introduced while splitting. |
| 3. Reuse and merge | Agree with corrections | E3–E7 and N8–N9: use integral Weyl data, one action, shared elementary root data, representation/QCoh comparison, and comodule invariants. Do not claim alcove infrastructure or Tannaka points reconstruction already proves missing results. Confirm exact signatures, roadmap ownership and pin/cache before implementation. |
| 4. Widen to source generality | Agree with the aim; disagree that every edit needs no new mathematics | E8–E12, E14, E16–E18: separate definitions from existence/representability results. Retain the hypotheses those proofs actually require. Derived localization, space descent and arbitrary-field comparison need interfaces and proofs; an informal citation does not make these free. E13 is an application, not compulsory deletion/generalization. |
| 5. Move proof-only parts | Agree | E21 and E22: split clause-level consumers, move the relative passability machinery once general product Künneth replaces it. Recompute closure from statement plus authorized examples/comparisons and verify no `plans/` dependency points into `plans-proof/`. |
| 6. Rename/document | Agree with signature and approval qualifications | E23–E24: decide data versus proposition first, then canonical homes and names. Update all references together, including proof-plan consumers. Do not mechanically capitalize bundled-category terms or turn existence theorems into definitions. Fresh review/owner gates still apply where stated in AGENTS. |

Before those structural edits, correct **N1–N3**, whose written claims fail explicit tests. During the foundational split repair **N4–N7** and **N11**, so the operations and their domains line up. Add the reuse bridges and remove unsupported dependencies in **N8–N10** before implementation. These steps have concrete proof routes above; none permits an axiom, placeholder in library code, or a conclusion moved into a field. Preserve the nontrivial examples and add the small boundary checks named here (doubled origin, unit subcategory, flag/Grassmannian cosets, fixed-stratification skyscraper).

### Four owner decisions

1. **E15–E16:** choose natural reusable statements with their actual hypotheses and stage their proofs. In particular, general algebraic-space interpolation is required by its existing consumer. Keep the decomposition node held until a precise source and proof route are selected; do not commit to every variant of the decomposition theorem from a book that has not been checked. This is preferable to blanket Schubert-only foundations, which repeat definitions, and to an unbounded “all topological spaces/all coefficients” program, whose hypotheses are false or unsupported. A32's proof-lemma permission remains useful for intermediate steps; it is not permission to narrow the definition of a named general object.
2. **E19:** approve an abelian-band core gerbe interface, specialized to μ_n in root gerbes and twisting. Its operations already ignore the special formula for μ_n, so the parameter removes a duplicate without a new theory. Keeping μ_n fixed is mathematically sound and was approved, but would invite a second almost identical implementation when using the general banded API. Do not add nonabelian gerbes or H² classification.
3. **E20:** keep today's approved placeholder signature until the replacement is reviewable; then remove the two unused assumptions from the reusable data bundle while retaining them at all actual uses requiring them. Immediate isolated editing would churn the approved statement without settling its real interfaces. Keeping unused assumptions permanently would violate A33. This agrees with the earlier recommendation to defer, with a concrete endpoint.
4. **E22:** move passability/relative base change to the proof plan and use **GRQCoh Proposition 3.1.7**, for arbitrary prestacks with one dualizable QCoh factor. This is already the natural general product theorem, not a special LS lemma. The alternative of keeping the full relative machinery is correct if a point example is added, but creates avoidable dependencies and its current example is outside the plan.

## Checks and limits

All 120 TOMLs parse; 239 unique node IDs; no missing suggested dependency; node graph acyclic. The file graph has the five groups shown below. The only nodes without dependents are the main theorem, two implemented unfolding lemmas, the intended examples and comparison endpoints; therefore I found no wholly orphaned extra theory merely by graph inspection. Some unused **clauses** survive inside used nodes (E21), which is why reachability alone is insufficient.

Validation results are recorded at the end of this file. They concern the existing Lean statement, not the correctness or feasibility of future planned proofs. The report does not certify every unpinned paper reference or every unspecified quantifier; the explicit unsure cases above identify the remaining source/scope decisions. Earlier review's blanket conclusion that none of its proposed fixes can affect meaning is too strong: widening domains, choosing an enhancement, changing bands, and modifying Setting all need their specified reviews.

## Coverage appendix

The table inventories every node read, grouped by its planned file. Cross-cutting E1/E23/E24 apply where indicated even when an individual row has no separate finding. “No additional finding” means no further plan-level issue established in this review; it is not a proof certification. Statement nodes were also checked against the existing Lean contract under A22. The import-only `plans/GLCinLean.toml` has no node.

### `plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/Basic.toml` — E1 file cycle, E24 description

| Node | Location | Findings |
|---|---|---|
| `Hecke.affineGrassmannian` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/BottSamelson.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.bottSamelsonResolution` | line 4 | No additional finding |
| `Hecke.bottSamelsonPushforward_parity` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/Components.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.affineGrassmannian_reducedComponents` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/IwahoriWeyl.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.iwahoriWeylGroup` | line 4 | E3, N2 |

### `plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/Schubert.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Hecke.schubertStratification` | line 4 | No additional finding |
| `Hecke.schubertStratum_deRhamCohomology_even` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Constructible/Complex.toml`

| Node | Location | Findings |
|---|---|---|
| `Constructible.complexPoints` | line 4 | N1 |
| `Constructible.derivedCategory` | line 10 | E15, N4, N7 |
| `Constructible.perverseSheaves` | line 17 | No additional finding |
| `DModules.analyticDeRham` | line 24 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Constructible/Decomposition.toml`

| Node | Location | Findings |
|---|---|---|
| `Constructible.decompositionTheorem` | line 4 | E15 |

### `plans/GLCinLean/AlgebraicGeometry/Curves/Theta.toml`

| Node | Location | Findings |
|---|---|---|
| `Curves.thetaCharacteristic` | line 4 | E5 |

### `plans/GLCinLean/AlgebraicGeometry/Curves/ThetaExistence.toml`

| Node | Location | Findings |
|---|---|---|
| `Curves.thetaCharacteristic_exists` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Coherent.toml` — E1 file cycle, E24 description

| Node | Location | Findings |
|---|---|---|
| `DModules.coherent` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/CompactGeneration.toml`

| Node | Location | Findings |
|---|---|---|
| `DModules.crystalInduction` | line 4 | No additional finding |
| `DModules.qcaDMod_compactlyGenerated` | line 11 | No additional finding |
| `DModules.indscheme_compactlyGenerated` | line 18 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Crystals.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `DModules.rightCrystals` | line 4 | E2 |
| `DModules.leftToRightCrystals` | line 11 | E23 |
| `DModules.leftCrystalsEquivRightCrystals` | line 18 | No additional finding |
| `DModules.crystals_descent_of_classicallyFormallySmooth` | line 25 | No additional finding |
| `DModules.rightCrystals_equiv_dModules` | line 32 | N11 |
| `DModules.rightCrystals_hDescent` | line 39 | No additional finding |
| `DModules.kashiwara` | line 46 | E2, E23 |
| `DModules.crystals_rightKanExtension_of_affine` | line 53 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/DirectImage.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `DModules.deRhamPushforward` | line 4 | E17 |

### `plans/GLCinLean/AlgebraicGeometry/DModules/EquivariantIndscheme.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `DModules.equivariantIndscheme` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Exponential.toml`

| Node | Location | Findings |
|---|---|---|
| `DModules.exponential` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Holonomic.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `DModules.holonomic` | line 4 | No additional finding |
| `DModules.regularHolonomic` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Hyperbolic.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `DModules.hyperbolicRestriction` | line 4 | E16, N5 |
| `DModules.hyperbolicRestriction_isIso` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Monodromic.toml`

| Node | Location | Findings |
|---|---|---|
| `DModules.monodromic` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Operations.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `DModules.extraordinaryPullback` | line 4 | E2 |
| `DModules.holonomicShriek` | line 11 | No additional finding |
| `DModules.starPullback` | line 18 | N5 |
| `DModules.shriekTensor` | line 25 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Perverse.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `DModules.perverseHeart` | line 4 | E15 |
| `DModules.intermediateExtension` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/RiemannHilbert.toml`

| Node | Location | Findings |
|---|---|---|
| `DModules.schubertRiemannHilbert` | line 4 | E15 |

### `plans/GLCinLean/AlgebraicGeometry/DModules/ScalarExtension.toml`

| Node | Location | Findings |
|---|---|---|
| `DModules.holonomicHom_fieldBaseChange` | line 4 | E12, N11 |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Twisting.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `DModules.twistedCrystals` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/DModules/Verdier.toml` — E1 file cycle, E24 description

| Node | Location | Findings |
|---|---|---|
| `DModules.verdierDuality` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Derived/Cotangent.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.cotangentComplex` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Derived/DeRham.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Derived.deRhamPrestack` | line 4 | No additional finding |
| `Derived.deRhamPrestack_locallyAlmostFiniteType` | line 11 | No additional finding |
| `Derived.deRhamCechNerve_formalCompletion` | line 18 | E1, E9 |

### `plans/GLCinLean/AlgebraicGeometry/Derived/FormalCompletion.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Derived.formalCompletion` | line 4 | E9 |

### `plans/GLCinLean/AlgebraicGeometry/Derived/Indscheme.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.indscheme` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Derived/Mapping.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.mappingPrestack` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Derived/Prestack.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.prestack` | line 4 | E23 |
| `Derived.locallyAlmostFiniteType` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Derived/QuasiSmooth.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.quasiSmooth` | line 4 | E23 |

### `plans/GLCinLean/AlgebraicGeometry/Derived/Stack.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.artinStack` | line 4 | E17 |

### `plans/GLCinLean/AlgebraicGeometry/Derived/Truncation.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.classicalReduction` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Group/Nilpotent.toml`

| Node | Location | Findings |
|---|---|---|
| `Groups.chevalleyMap` | line 4 | E7 |
| `Groups.nilpotentCoadjointCone` | line 11 | E7 |

### `plans/GLCinLean/AlgebraicGeometry/Group/Pinning.toml`

| Node | Location | Findings |
|---|---|---|
| `Groups.chevalleyInvolution` | line 4 | E21 |
| `Groups.pinnings_torsor` | line 11 | E11 |

### `plans/GLCinLean/AlgebraicGeometry/Group/SimplyConnectedCover.toml`

| Node | Location | Findings |
|---|---|---|
| `Groups.simplyConnectedCover` | line 4 | N10 |

### `plans/GLCinLean/AlgebraicGeometry/GroupActions/Hyperbolic.toml`

| Node | Location | Findings |
|---|---|---|
| `Actions.hyperbolicInterpolation` | line 4 | E16 |

### `plans/GLCinLean/AlgebraicGeometry/LocalSystems/DeRham.toml`

| Node | Location | Findings |
|---|---|---|
| `LocalSystems.classifyingStack` | line 4 | E8 |
| `LocalSystems.deRham` | line 11 | E8 |
| `LocalSystems.quasiSmooth` | line 18 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/LocalSystems/IndCoh.toml`

| Node | Location | Findings |
|---|---|---|
| `LocalSystems.indcohNilpotent` | line 4 | No additional finding |
| `LocalSystems.psiNilpotent` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/LocalSystems/Nilpotent.toml`

| Node | Location | Findings |
|---|---|---|
| `LocalSystems.nilpotentCone` | line 4 | N10 |
| `LocalSystems.nilpotentCone_contains_zero` | line 11 | No additional finding |
| `LocalSystems.nilpotentCone_closed_conical` | line 18 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/LocalSystems/Singularities.toml`

| Node | Location | Findings |
|---|---|---|
| `LocalSystems.singularities` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/LoopGroups/Basic.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Hecke.loopArcGroups` | line 4 | E8 |

### `plans/GLCinLean/AlgebraicGeometry/Prestacks/PseudoProper.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.pseudoProper` | line 4 | No additional finding |
| `DModules.pseudoProperShriek` | line 11 | No additional finding |
| `DModules.twistedPseudoProperShriek` | line 18 | No additional finding |
| `DModules.twistedPseudoProperShriek_iso_of_trivialization` | line 25 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Ran/Homology.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.ranPseudoProper` | line 4 | E14, E21 |

### `plans/GLCinLean/AlgebraicGeometry/Ran/Inclusions.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.ranInclusions` | line 4 | E21 |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/Coherent.toml`

| Node | Location | Findings |
|---|---|---|
| `Sheaves.coherent` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/Determinant.toml`

| Node | Location | Findings |
|---|---|---|
| `Sheaves.perfectComplex` | line 4 | No additional finding |
| `Sheaves.determinant` | line 11 | N6 |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/FormalCompletion.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Sheaves.qcoh_formalCompletion_localization` | line 4 | E10 |
| `Sheaves.indcoh_formalCompletion_localization` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/GradedSupport.toml`

| Node | Location | Findings |
|---|---|---|
| `Sheaves.gradedSupport` | line 4 | N9 |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/Hochschild.toml`

| Node | Location | Findings |
|---|---|---|
| `Sheaves.hochschildCochains` | line 4 | N9 |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/IndCoh.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Sheaves.indcohAffine` | line 4 | No additional finding |
| `Sheaves.indcohShriekOnSchemes` | line 11 | No additional finding |
| `Sheaves.indcoh` | line 4 | No additional finding |
| `Sheaves.indcohTStructure` | line 25 | E17 |
| `Sheaves.indcohQCohAction` | line 32 | No additional finding |
| `Sheaves.psi` | line 39 | No additional finding |
| `Sheaves.upsilon_isEquivalence_of_smooth` | line 46 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/Passable.toml`

| Node | Location | Findings |
|---|---|---|
| `Sheaves.passable` | line 4 | E22 |
| `Sheaves.passable_tensorBaseChange` | line 11 | E22 |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/QCAFiniteness.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Sheaves.qcaGlobalSections_continuous` | line 4 | No additional finding |
| `Sheaves.qcaIndCoh_compactlyGenerated` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/QCoh.toml`

| Node | Location | Findings |
|---|---|---|
| `Sheaves.qcoh` | line 4 | No additional finding |
| `Sheaves.qcohGlobalSections` | line 11 | N6 |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/SingularSupport.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Sheaves.singularities` | line 4 | No additional finding |
| `Sheaves.hochschildAction` | line 11 | No additional finding |
| `Sheaves.singularSupport` | line 18 | No additional finding |
| `Sheaves.indcohWithSupport` | line 25 | No additional finding |
| `Sheaves.zeroSupport_equiv_qcoh` | line 32 | No additional finding |
| `Sheaves.psi_eventuallyCoconnective_equiv` | line 39 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Sheaves/SupportTStructure.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Sheaves.supportTStructure` | line 4 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Stacks/Bundles.toml`

| Node | Location | Findings |
|---|---|---|
| `Stacks.bundleStack` | line 4 | No additional finding |
| `Stacks.associatedAdjointBundle` | line 11 | E13 |

### `plans/GLCinLean/AlgebraicGeometry/Stacks/Determinant.toml`

| Node | Location | Findings |
|---|---|---|
| `Stacks.determinantBundle` | line 4 | N6 |
| `Stacks.determinantSquareRoot` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Stacks/Finiteness.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Stacks.qca` | line 4 | No additional finding |
| `Stacks.qcaStratification` | line 11 | No additional finding |

### `plans/GLCinLean/AlgebraicGeometry/Stacks/Gerbe.toml`

| Node | Location | Findings |
|---|---|---|
| `Stacks.etaleGerbe` | line 4 | E19 |
| `Stacks.rootGerbe` | line 11 | E5 |

### `plans/GLCinLean/GeometricLanglands/Automorphic/Category.toml`

| Node | Location | Findings |
|---|---|---|
| `Automorphic.halfTwistedDModules` | line 4 | No additional finding |
| `Automorphic.halfTwisted_equiv_untwisted` | line 11 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Examples/Point.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Examples.pointQCohIndCoh` | line 4 | No additional finding |
| `Examples.trivialGroup_isLanglandsFunctor_id` | line 11 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Examples/Setting.toml`

| Node | Location | Findings |
|---|---|---|
| `Examples.nonemptySetting` | line 4 | E23 |

### `plans/GLCinLean/GeometricLanglands/Examples/SingularAffine.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Examples.singularAffineSupport` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Examples/Torus.toml`

| Node | Location | Findings |
|---|---|---|
| `Examples.torusNilpotent_is_zero` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Hecke/Action.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Hecke.action` | line 4 | E4 |
| `Hecke.sphericalAction` | line 11 | E21 |

### `plans/GLCinLean/GeometricLanglands/Hecke/Correspondence.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Hecke.correspondence` | line 4 | No additional finding |
| `Hecke.correspondence_pseudoProper` | line 11 | E14 |

### `plans/GLCinLean/GeometricLanglands/Hecke/FormalDisc.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.formalDisc` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Hecke/Ran.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.ranSpace` | line 4 | E14 |
| `Hecke.ranUnion` | line 11 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Hecke/Representations.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.representationCategory` | line 4 | E6 |
| `Hecke.ranRepresentations` | line 11 | E6 |

### `plans/GLCinLean/GeometricLanglands/Hecke/Satake.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Hecke.satake` | line 4 | E4 |

### `plans/GLCinLean/GeometricLanglands/Hecke/Spread.toml`

| Node | Location | Findings |
|---|---|---|
| `Hecke.spreadClassifyingStack` | line 4 | E6 |

### `plans/GLCinLean/GeometricLanglands/Satake/Convolution.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.convolution` | line 4 | No additional finding |
| `Satake.convolution_preserves_perversity` | line 11 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/Cousin.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Satake.chiralCousinComplex_concentrated` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/DualGroup.toml` — E1 file cycle, E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.tannakaRootDatum_equiv_dual` | line 4 | N3 |
| `Satake.dualIdentification` | line 11 | E21 |
| `Satake.tannakaPinning` | line 18 | No additional finding |
| `Satake.dualIdentificationChangePinningIso` | line 25 | No additional finding |
| `Satake.isLanglandsFunctor_iff_of_changePinning` | line 32 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/Equivalence.toml` — E1 file cycle, E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.geometricSatakeHeartEquivalence` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/Factorization.toml` — E1 file cycle, E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.factorizationSphericalCategory` | line 4 | No additional finding |
| `Satake.chiralHeckeAlgebra` | line 11 | No additional finding |
| `Satake.factorizationFunctorFromRegularComodule` | line 18 | No additional finding |
| `Satake.naiveFactorizationFunctor` | line 25 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/FiberFunctor.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.cohomologyFiberFunctor` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/Fusion.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.fusion` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/Reconstruction.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.weightProjectives` | line 4 | No additional finding |
| `Satake.tannakaGroup` | line 11 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/Spherical.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.sphericalHeart` | line 4 | No additional finding |
| `Satake.sphericalHeart_semisimple` | line 11 | No additional finding |
| `Satake.icStalkParity_complex` | line 18 | No additional finding |
| `Satake.icStalkParity` | line 18 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.criticalDeterminantGerbe` | line 4 | N6 |
| `Satake.criticalTwist_matchesBunDeterminant` | line 11 | N10 |
| `Satake.halfTwistedHeart_equiv_untwistedHeart` | line 18 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Satake/Weights.toml` — E24 description

| Node | Location | Findings |
|---|---|---|
| `Satake.semiInfiniteOrbits` | line 4 | No additional finding |
| `Satake.semiInfiniteIntersection_dimension` | line 11 | No additional finding |
| `Satake.weightFunctors` | line 18 | No additional finding |
| `Satake.weightFunctors_exact_faithful` | line 25 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Spectral/Evaluation.toml`

| Node | Location | Findings |
|---|---|---|
| `Spectral.evaluation` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Spectral/Localization.toml`

| Node | Location | Findings |
|---|---|---|
| `Spectral.localization` | line 4 | E22 |

### `plans/GLCinLean/GeometricLanglands/Whittaker/Character.toml`

| Node | Location | Findings |
|---|---|---|
| `Whittaker.character` | line 4 | No additional finding |

### `plans/GLCinLean/GeometricLanglands/Whittaker/Poincare.toml`

| Node | Location | Findings |
|---|---|---|
| `Whittaker.vacuumPoincare` | line 4 | N5 |

### `plans/GLCinLean/GeometricLanglands/Whittaker/Reduction.toml`

| Node | Location | Findings |
|---|---|---|
| `Whittaker.rhoTorsor` | line 4 | No additional finding |
| `Whittaker.reductionStack` | line 11 | No additional finding |
| `Whittaker.twistTrivialization` | line 18 | No additional finding |

### `plans/GLCinLean/Statement/Conjecture.toml` — E1 file cycle

| Node | Location | Findings |
|---|---|---|
| `Statement.RootDatumDuality` | line 3 | No additional finding |
| `Statement.Setting` | line 9 | E20 |
| `Statement.QCohLS` | line 15 | No additional finding |
| `Statement.DmodHalf` | line 21 | No additional finding |
| `Statement.IndCohNilp` | line 27 | No additional finding |
| `Statement.Psi` | line 33 | No additional finding |
| `Statement.RepRan` | line 39 | No additional finding |
| `Statement.Loc` | line 45 | No additional finding |
| `Statement.heckeActionRight` | line 51 | No additional finding |
| `Statement.vacuumPoincare` | line 57 | No additional finding |
| `Statement.IsLanglandsFunctor` | line 63 | No additional finding |
| `Statement.isLanglandsFunctor_iff` | line 69 | No additional finding |
| `Statement.exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence` | line 75 | No additional finding |

### `plans/GLCinLean/Statement/Enhanced.toml`

| Node | Location | Findings |
|---|---|---|
| `Statement.DGCatCarrier` | line 3 | No additional finding |
| `Statement.DGCat` | line 3 | No additional finding |
| `Statement.TStructuredDGCatCarrier` | line 15 | No additional finding |
| `Statement.TStructuredDGCat` | line 15 | No additional finding |
| `Statement.DGCat.objCarrier` | line 27 | No additional finding |
| `Statement.DGCat.Obj` | line 33 | No additional finding |
| `Statement.DGCat.IsCompact` | line 39 | No additional finding |
| `Statement.TStructuredDGCat.toDGCat` | line 45 | No additional finding |
| `Statement.TStructuredDGCat.IsEventuallyCoconnective` | line 51 | No additional finding |
| `Statement.DGFunCarrier` | line 57 | No additional finding |
| `Statement.DGFun` | line 57 | No additional finding |
| `Statement.DGFun.obj` | line 69 | No additional finding |
| `Statement.DGFun.comp` | line 75 | No additional finding |
| `Statement.DGFun.id` | line 81 | No additional finding |
| `Statement.DGNatIso` | line 87 | No additional finding |
| `Statement.DGFun.MapsEquiv` | line 93 | No additional finding |
| `Statement.DGFun.IsEquivalence` | line 99 | No additional finding |
| `Statement.DGFun.isEquivalence_iff` | line 105 | No additional finding |

### `plans/Roadmap/BordismFormalGroups/Compact.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.compactObject` | line 4 | No additional finding |

### `plans/Roadmap/BordismFormalGroups/KanExtension.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.rightKanExtension` | line 4 | E18 |

### `plans/Roadmap/BordismFormalGroups/Limits.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.limits` | line 4 | No additional finding |

### `plans/Roadmap/BordismFormalGroups/Linear.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.continuousLinearFunctor` | line 4 | No additional finding |
| `Infinity.linearEquivalence` | line 11 | No additional finding |

### `plans/Roadmap/BordismFormalGroups/Mapping.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.mappingSpaces` | line 4 | No additional finding |

### `plans/Roadmap/BordismFormalGroups/Module.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.moduleCategory` | line 4 | E18 |

### `plans/Roadmap/BordismFormalGroups/Monoidal.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.monoidalCategory` | line 4 | E18 |

### `plans/Roadmap/BordismFormalGroups/Stable.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.stableCategory` | line 4 | No additional finding |

### `plans/Roadmap/BordismFormalGroups/TStructure.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.tStructure` | line 4 | N8 |

### `plans/Roadmap/EnhancedDerivedSheaves/AdjointableDiagrams.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.adjointableDiagram_limitAdjunction` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Adjunction.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.rightAdjoint` | line 4 | E18 |

### `plans/Roadmap/EnhancedDerivedSheaves/AnimatedRings.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.commutativeAlgebra` | line 4 | No additional finding |
| `Derived.affineScheme` | line 11 | No additional finding |
| `Derived.affineModules` | line 18 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Compact.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.compactGeneration` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Cotangent.toml`

| Node | Location | Findings |
|---|---|---|
| `Derived.affineCotangentComplex` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Dualizable.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.dualizableCategory` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Ind.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.indCompletion` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Linear.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.linearCategory` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Module.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.internalHom` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Presentable.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.presentableCategory` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/Rigid.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.rigidMonoidalCategory` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/SchemeQCoh.toml`

| Node | Location | Findings |
|---|---|---|
| `Sheaves.schemeQCoh` | line 4 | No additional finding |

### `plans/Roadmap/EnhancedDerivedSheaves/TStructure.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.eventuallyCoconnective` | line 4 | N8 |

### `plans/Roadmap/EnhancedDerivedSheaves/Vect.toml`

| Node | Location | Findings |
|---|---|---|
| `Infinity.derivedVect` | line 4 | No additional finding |

### `plans/Roadmap/JacobianChallenge/Jacobian.toml`

| Node | Location | Findings |
|---|---|---|
| `Curves.picard_degree` | line 4 | No additional finding |
| `Curves.picardZero_isAbelianVariety` | line 10 | No additional finding |
| `Curves.abelianVariety_multiplication_surjective` | line 16 | No additional finding |

### `plans/Roadmap/JacobianChallenge/SerreDuality.toml`

| Node | Location | Findings |
|---|---|---|
| `Curves.serreTrace` | line 4 | No additional finding |
| `Curves.degree_canonical` | line 10 | No additional finding |

### `plans/Roadmap/ReductiveGroups/PinnedRootData.toml`

| Node | Location | Findings |
|---|---|---|
| `Groups.pinnedData` | line 4 | No additional finding |
| `Groups.twoRho` | line 10 | No additional finding |
| `Groups.pinning_exists` | line 17 | E18 |
| `Groups.rootDatum` | line 23 | No additional finding |
| `Groups.basedRootDatum` | line 29 | No additional finding |

### `plans/Roadmap/ReductiveGroupsPartII/DualGroup.toml`

| Node | Location | Findings |
|---|---|---|
| `Groups.langlandsDual` | line 4 | No additional finding |
| `Groups.dualityData` | line 11 | No additional finding |
| `Groups.dualityData_changePinning` | line 18 | No additional finding |
| `Groups.coweightParity` | line 25 | No additional finding |

### `plans/Roadmap/SchemeAndStackFoundations/AlgebraicStacks.toml`

| Node | Location | Findings |
|---|---|---|
| `Stacks.algebraicStack` | line 4 | No additional finding |

### `plans/Roadmap/SchemeAndStackFoundations/Torsors.toml`

| Node | Location | Findings |
|---|---|---|
| `Stacks.groupTorsor` | line 4 | E13 |

## Reproduced module cycles

1. `GLCinLean/AlgebraicGeometry/AffineGrassmannian/Basic`; `GLCinLean/GeometricLanglands/Hecke/Correspondence`.
2. `GLCinLean/AlgebraicGeometry/DModules/Coherent`; `GLCinLean/AlgebraicGeometry/DModules/Crystals`; `GLCinLean/AlgebraicGeometry/DModules/DirectImage`; `GLCinLean/AlgebraicGeometry/DModules/Holonomic`; `GLCinLean/AlgebraicGeometry/DModules/Operations`; `GLCinLean/AlgebraicGeometry/DModules/Twisting`; `GLCinLean/AlgebraicGeometry/DModules/Verdier`; `GLCinLean/AlgebraicGeometry/Sheaves/FormalCompletion`; `GLCinLean/AlgebraicGeometry/Sheaves/IndCoh`.
3. `GLCinLean/AlgebraicGeometry/Derived/DeRham`; `GLCinLean/AlgebraicGeometry/Derived/FormalCompletion`.
4. `GLCinLean/AlgebraicGeometry/Sheaves/SingularSupport`; `GLCinLean/AlgebraicGeometry/Sheaves/SupportTStructure`.
5. `GLCinLean/GeometricLanglands/Hecke/Action`; `GLCinLean/GeometricLanglands/Hecke/Satake`; `GLCinLean/GeometricLanglands/Satake/Cousin`; `GLCinLean/GeometricLanglands/Satake/DualGroup`; `GLCinLean/GeometricLanglands/Satake/Equivalence`; `GLCinLean/GeometricLanglands/Satake/Factorization`; `GLCinLean/Statement/Conjecture`.

## Checked suspicions not promoted to defects

- [DGIndschemes] Proposition 7.1.3 really does identify supported QCoh with QCoh on the completion by pullback; confusing this with ordinary restriction of scalars would give a false objection.
- [ArinkinGaitsgory] defines closed conical singular support also in the IndCoh setting used here. I did not replace that source's notion with a different support convention and then flag it.
- The pinned Tannaka points theorem requires an already supplied Hopf algebra. `Satake.tannakaGroup` explicitly says to construct that Hopf algebra first, so it does not claim the points theorem constructs one. The missing generic reconstruction work should be factored and routed appropriately when implemented, but no existing general neutral-Tannakian replacement was located at the pins.
- Bott–Samelson/parity over the simply connected neutral component is used by an explicit reduction back to arbitrary reductive groups. This is a legitimate proof stage, not evidence that the final Satake theorem is restricted to simply connected groups.
- Stable/enhanced categories, presentability, compact generation, rigidity and Ind-completion are genuinely used. An ordinary-category keyword match is not a substitute for their enhanced universal properties. `Infinity.mappingSpaces` already names upstream mapping spaces; it must extend those, but its planned coherent composition work is not automatically a duplicate.
- The statement's placeholders are permitted by A44. Their presence is not a new finding of this review. Their replacement still requires the stated nontrivial examples and fresh review.

## Reproduction and validation

The module-cycle computation uses the full suggested graph, including placeholder replacement edges; the tracker otherwise supersedes some of those edges with the current opaque Lean objects. Hence tracker lint alone does not validate this future module layout. The following read-only script reproduces the counts, detects unknown dependencies and node cycles, and computes the file groups without third-party packages:

```python
from pathlib import Path
import tomllib

nodes = {}
files = sorted(Path("plans").rglob("*.toml"))
for path in files:
    for node in tomllib.loads(path.read_text()).get("node", []):
        assert node["id"] not in nodes
        nodes[node["id"]] = (str(path), node.get("deps", []))
assert len(files) == 120 and len(nodes) == 239
assert all(d in nodes for _, ds in nodes.values() for d in ds)

def closure(start, graph):
    seen, todo = set(), list(graph.get(start, []))
    while todo:
        v = todo.pop()
        if v not in seen:
            seen.add(v)
            todo.extend(graph.get(v, []))
    return seen

ng = {n: set(ds) for n, (_, ds) in nodes.items()}
assert all(n not in closure(n, ng) for n in ng)
mg = {f: set() for f, _ in nodes.values()}
for f, deps in nodes.values():
    mg[f].update(nodes[d][0] for d in deps if nodes[d][0] != f)
reachable = {f: closure(f, mg) | {f} for f in mg}
remaining = set(mg)
while remaining:
    f = min(remaining)
    component = {g for g in reachable[f] if f in reachable[g]}
    remaining -= component
    if len(component) > 1:
        print(sorted(component))
```

Validation on the unchanged plan and Lean code, with the required `LAKE_CONFIG` and `LAKE_CACHE_DIR`:

- Both cache-fetch commands completed successfully; no Mathlib or Tau Ceti library rebuild occurred.
- `lake build`: passed; only the allowed main-theorem `sorry` warning.
- `lake lint`: passed.
- `lake env lean tools/check-statement-axioms.lean`: passed; `sorryAx` occurs only for the main theorem, whose axiom list is exactly `propext`, `Classical.choice`, `Quot.sound`, `sorryAx`.
- `lake exe tracker lint`: no errors; the expected superseded statement-plan fields remain.
- Static plan audit: 120 files, 239 unique nodes, no missing dependencies, no node cycles, five module cycles.
- Report coverage: 239 node rows in the coverage appendix, all 24 comparison verdicts, six fix-step verdicts and four owner recommendations.
