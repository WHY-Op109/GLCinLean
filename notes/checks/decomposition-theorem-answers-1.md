# Answers to round 1 of the checks of `proposal/decomposition-theorem`

The reports are of commit `93e5cb3`: `notes/checks/decomposition-theorem-codex-1.md` (Codex) and `notes/checks/decomposition-theorem-check-1.md` (the checker). Both agree with the provider and the route. This file answers each finding. "Fixed" names the place of the correction. "Not changed" gives the evidence or the reason. Paths are relative to the repository. `plans/Roadmap/EtaleDualityAndPerverseSheaves/` is written `R/`.

**Count.** 23 findings: Codex 1 to 8, the checker's U1 and U2, its two "Sources of code" points, and eleven smaller points. 20 are fixed. 3 are not changed: the separate definition node for geometric origin, the numbers of [BBD] (the number of [JuteauMautnerWilliamson] is checked), and the Deligne–Milne criteria, which belong to audit finding B6. Codex 4 is counted as fixed; two of its four parts are not changed and are proposed open items, because they are outside the scope of this change.

## Points on which the two reports agree, settled once

**A. The stratified node (Codex 3 and 5, checker U1). Fixed.** The checker is right that an accepted target needs the fixed-stratification categories in Tau Ceti. SpringerResolutionAndCharacteristicCycles §11.3 says: "construct the de Rham functor DR from strongly B-equivariant regular holonomic D_F-modules to complexes on F(C) constructible along the Schubert cells C_v=BvB/B ...; prove that it is exact for the perverse t-structure and faithful, that it commutes with the extensions j_!, j_* and j_!* along the inclusion of each cell". Its supplier section takes "constructible complexes on its complex points" from EtaleDualityAndPerverseSheaves §3.5. So my sentence "the part that no roadmap needs stays here" was wrong, and by the reasoning that moved the two carriers the generic part moves too. The node of `93e5cb3` is split in three:

- `R/AnalyticStratified.toml`, `Constructible.StratifiedDerivedCategory`, a roadmap node in a module of its own: `D^b_S`, goodness, the induced perverse t-structure, its heart, the functors along a locally closed union of strata, the summand fact. It names Mathlib's `ObjectProperty.HasInducedTStructure` and `ObjectProperty.tStructure`, as Codex asks, and `TauCeti.FiniteStratification`. The claim on subquotients is stated with its proof route, as Codex asks: the heart has finite length, its simple objects `IC(T̄, L)` are simple among all perverse sheaves, and `D^b_S` is closed under extensions.
- `plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/SchubertConstructible.toml`, `AffineGrassmannian.isGood_schubertStratification`, written here: the Schubert examples, with `deps` on `AffineGrassmannian.schubertStratification` and `AffineGrassmannian.iwahoriStratification`. The tracker can no longer offer the generic module before the stratifications exist. The parity users (`AffineGrassmannian.isEven_bottSamelsonPushforward`, `Satake.icSheaf_restriction_isParity`) depend on it.
- `plans/GLCinLean/AlgebraicGeometry/Constructible/StratifiedMaps.toml`, `Constructible.IsStratifiedMap`, written here: the conditions on maps. No roadmap target uses them: §11.3 needs the extensions along cells, not pushforward along stratified maps.

`DModules.analyticDeRham` is in a module of the D-module folder, `plans/GLCinLean/AlgebraicGeometry/DModules/AnalyticDeRham.toml`, so the generic category is not coupled to D-modules. The area of the roadmap node is EtaleDualityAndPerverseSheaves, because the category is a full subcategory of its `D^b_c` and §11.3 takes its constructible complexes from that roadmap.

On Codex 5, "use the upstream stratumwise constructibility predicate wherever its coefficient regime agrees": the node is that predicate for the analytic side, and it says so. The restricted categories `D^b_{T,L}` of §5.9 are étale and ℓ-adic, with a condition on the constituents of the reduction modulo ℓ; they are a different category, and the node says that they are not this node.

**B. The two missing hypotheses (Codex 2, checker items 2 and 3). Fixed.**

- `R/AnalyticPerverse.toml`: the check reads "for Y smooth and connected of dimension d and L a local system of finite rank on Y, L[d] is perverse and equals IC(Y, L)", with the componentwise shift and Codex's example of a line and a point.
- `R/AnalyticStratified.toml`, item (4): "For a locally closed union U of strata", with Codex's example of a union that is not locally closed. The `source` adds [BBD] §§2.1.13–2.1.16, as both reports ask.

**C. The wording on rational descent (Codex 6, checker item 1). Fixed.** `R/DecompositionComplex.toml` reads "No descent of the splitting to a smaller coefficient field is asserted", which is the roadmap's statement. The sentence "the splitting need not descend" is gone.

## Codex

**1. Base change in the six-operations node. Fixed.** `R/AnalyticConstructible.toml` says that the maps are maps of schemes over ℂ, and states the identities with their functors: "(4) base change for Rf_!: for f : X → Y, every g : Y′ → Y, and the base changes f′ and g′ in the Cartesian square, g^* Rf_! ≅ Rf′_! g′^*; for a proper f this is base change for Rf_*; (5) the projection formula Rf_!(K ⊗ f^*L) ≅ Rf_!K ⊗ L. Base change for Rf_* along an arbitrary Cartesian square is false", with Codex's example. The node does not mention the comparison of analytic and étale `Rf_*` of §3.5 as one of its claims.

**2.** See B.

**3.** See A.

**4. The de Rham comparison. Fixed in part; two parts are not changed and are proposed open items.**

- Separatedness: fixed. `DModules.analyticDeRham` reads "For a separated scheme Y of finite type over C". The word was missing on `main`.
- The dependency in the prose of `DModules.perverseHeart`: fixed. The node reads "over C it corresponds to goodness with coefficients C of Constructible.StratifiedDerivedCategory, a comparison that is stated and proved in DModules.analyticDeRham_isEquivalence and is not used by this node". The later theorem already states the comparison ("The D-module goodness of DModules.perverseHeart is goodness with coefficients C under this equivalence").
- The singular case: not changed. The finding is right as far as I can check: the nodes are stated for every separated scheme of finite type and their user needs singular Schubert unions, and they do not say how the singular case is reached. [HottaTakeuchiTanisaki] is not in `references/`, so I did not check that its §4.7 and Theorem 7.2.2 are for smooth varieties. The gap is on `main`: the two nodes have the same statement and source there (`git show d73f8b3:plans/GLCinLean/AlgebraicGeometry/DModules/RiemannHilbert.toml`), and this change edits only names in them. The nodes are far from ready, and the repair is a route, not a wording. It is the first proposed open item in section 5 of the proposal, with `DModules.analyticDeRham` and `DModules.analyticDeRham_isEquivalence` as owners, to be settled with audit finding B4.
- The independent inputs of the Schubert example of `DModules.perverseHeart`: not changed, for the same reasons. It is the second proposed open item, with `DModules.perverseHeart` as owner.

**5. The suppliers. Fixed.** `R/AnalyticConstructible.toml` and `docs/blueprint-providers.md` ("Roadmaps that own plan nodes", EtaleDualityAndPerverseSheaves) name EnhancedDerivedSheaves §§0.1–0.4, Hyperfunctions HF3a and the agreement that §C6.1 requires, and the declarations at the pin. They state what is left for the node: "boundedness and constructibility of the six operations for algebraic maps, f^!, and duality". I checked the pin: `TauCeti/CategoryTheory/Sites/ExtensionByZero.lean` has the namespace `TauCeti.CategoryTheory.SheafExtensionByZero` with `isRightAdjoint_sheafPushforwardContinuous_forget`; `TauCeti/Algebra/Category/ModuleCat/Sheaf/ExtensionByZero.lean` has `SheafOfModules.isRightAdjoint_pushforward_over`. The claim of the proposal that no roadmap needs the fixed-stratification part is removed; see A.

**6. Three assertions. Fixed.** Descent: see C. The route: `R/DecompositionComplex.toml`, section 2.2 of the proposal and the provider record say that purity is a statement over the finite field and that the splitting holds after extension to its algebraic closure. The doubt on §3.5: they say that the comparison carries the finite construction of an object of geometric origin, not an arbitrary analytic complex, because for `E` coefficients its essential image is the complexes with monodromy-stable lattices; the doubt is removed from section 7. I did not add Codex's statement that a rational decomposition exists for the constant sheaf: the plan does not use it.

**7. Step (4) of the parity proof. Fixed.** `Satake.icSheaf_restriction_isParity` argues degree by degree: each cohomology sheaf of the `*`-restriction is locally constant on the connected orbit and vanishes when one stalk vanishes; "it does not claim that the restriction is a sum of its shifted cohomology sheaves". The `!`-statement is deduced by Verdier self-duality with the shift by `2d_μ`. Step (4) was on `main`; it is corrected here because the node is the user of the theorem and the correction is small.

**8. Section 8 and the cost statement. Fixed.** Section 8 is rewritten: connectedness comes before the lemma of Tau Ceti (step 2), the kernel of `G̃ → G_X` and the meaning of `Satake.dualIdentification` and `Satake.tannakaPinning` are named as open, and the route to the root datum is that of [MV] §12. The condition on the workers is removed from the proposed open item and from section 6. The cost statement reads "in the last section of Layer 5", and names `relativeHardLefschetzComplex` as the target that follows.

## The checker

**U1.** See A. The de Rham functor of §11.3 is also recorded in `docs/blueprint-providers.md`, in the row of SpringerResolutionAndCharacteristicCycles and under EtaleDualityAndPerverseSheaves, and as the third proposed open item (it belongs to audit finding B4).

**U2. Step 4 of section 8. Fixed.** The checker is right. [MV] Proposition 3.10 is about `I_!(λ)` and `I_*(λ)`, and the statement (a2) of §7 uses it together with Lemma 7.1; [MV] §12 says of its own case "we cannot immediately conclude this fact here, as we only have a containment". Section 8 states what is established (steps 1 to 4, with the checker's derivation of the torus, the Weyl group and the directions of the roots) and what is open (the root datum, with the two possible routes; the step of §12 that uses the case of characteristic 0), and no longer says "word for word".

**"Sources of code", the declarations at the pin. Fixed.** `R/AnalyticStratified.toml` names `TauCeti.FiniteStratification` (`TauCeti.Topology.Stratification`), and `R/AnalyticConstructible.toml` names the two extension-by-zero declarations, each under "Upstream declarations used". The proposal no longer uses the roadmap's name `SheafExtensionByZero` as a module name.

**"Sources of code", Hyperfunctions HF3a. Fixed.** The node names HF3a as an input. The sentence "No accepted roadmap names them as a target for ℂ" is replaced, in the proposal (2.3) and in the provider record, by two lists: what other accepted roadmaps supply (with `Rf_!`, base change and the projection formula of HF3a), and what none names (the category, constructibility of the operations, `f^!`, duality, the perverse t-structure).

**Item 1, the definition of geometric origin inside a theorem node. Not changed.** The checker says that it is allowed. The definition has one user in the plan, the theorem, and Tau Ceti decides how its target lands. Section 7 of the proposal records it.

**Item 5, the note on the carrier. Fixed.** The provider record reads: "The roadmap does not fix the Lean carrier of the category: §3.5 names the enhanced analytic categories of EnhancedDerivedSheaves §§0.1–0.4, and the plan intends Mathlib's derived category of sheaves on that space. The plan uses only the triangulated category, so either serves." The node says the same.

**Item 5, the area. Fixed.** The node quotes that ComplexComparisonPartII "supplies algebraically constructible analytic coefficient categories" for finite and ℓ-adic coefficients, and names it as a supplier.

**Item 5, "the node asks for no more than §5.9 uses: partly". Fixed.** The node has a sentence "What uses what": §5.9 uses the four functors, `⊗` and `RHom`; `Constructible.PerverseSheaves` uses duality; base change, the projection formula, Hom by global sections, the external product and a general field are used by nodes of this plan only. The risk for Tau Ceti's review is in the proposed decision and in doubt 1.

**Item 6, the numbers. Not changed, with evidence for one.** [JuteauMautnerWilliamson] Theorem 3.7: the paper numbers all theorem-like environments by one counter within a section; `thm-intformsgeneral` is the seventh such environment of section 3 (TeX lines 1911 to 2402). The same count gives 4.11 for `prop:BSparity`, the number that the plan cites. The numbers of [BBD] stay unchecked: the book is not in `references/` (doubt 4 of the proposal).

**Other suspicion, the de Rham functor of §11.3 and audit finding B4. Fixed** in the provider record; see U1.

**Other suspicion, the Deligne–Milne criteria and MotivesAndAlgebraicCycles §6.3. Not changed in the nodes.** It belongs to audit finding B6, which is not part of this change. Section 8 names it under "What is open".

## Where I disagree

- **Codex 4, the singular case and the inputs of the Schubert example.** I do not disagree with the mathematics. I disagree that this change must repair them: they are gaps of nodes on `main` that this change renames in, they are not about to be written, and the repairs are not small.
- **Codex 5, the predicate of §5.9.** The analytic predicate is one node. The étale category `D^b_{T,L}` is not the same object and is not a node of the plan.
- **Checker item 1, a definition node for geometric origin.** Kept inside the theorem node.

## State of the branch after the answers

`lake exe tracker lint` has no errors. `python3 tools/check-module-cycles.py`: 171 module plans, 285 nodes, no cycle. `plans/` has 215 nodes under `plans/GLCinLean/` and 70 under `plans/Roadmap/`, in nine roadmaps. No Lean file, no file of `GLCinLean/Statement/` and not `STATUS.md` changed.
