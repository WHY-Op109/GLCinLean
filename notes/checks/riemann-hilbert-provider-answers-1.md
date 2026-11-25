# Answers to round 1 on `proposal/riemann-hilbert-provider`

The two reports of round 1 are `riemann-hilbert-provider-checker-1.md` (the checker) and `riemann-hilbert-provider-codex-1.md` (Codex). They judge the commits `581fbf0` and `cc49450`. This file has one entry for each finding. "Fixed" names the commit: `7cc204c` for the plan and `docs/`, `f85d581` for `GLCinLean.lean`, and the commit that adds this file for the note `riemann-hilbert-provider.md`. "Not changed" gives the evidence.

After the fixes: `lake exe tracker lint` has no errors (the same 61 warnings as on `main`), `python3 tools/check-module-cycles.py` reports 197 module plans, 310 nodes and 0 cycles, `python3 tools/check-upstream-names.py` confirms all 335 pairs, and `lake build` and `lake lint` pass with the one `sorry` of the main theorem.

## A source that both reports could not read

The reports name [HottaTakeuchiTanisaki] and say that it is not in `references/`. Codex gives numbers of the book. The English edition (Birkhäuser, 2008) was read for this round, and these statements were compared with it:

- Theorem 4.6.3: for a holonomic D-module on a complex manifold, `DR_X(M) = Ω_X ⊗ᴸ_{D_X} M` and `Sol_X(M)` are in `D^b_c(X)`. Corollary 4.6.5: `D_X(DR_X(M)) ≃ DR_X(𝔻_X M)`. Theorem 4.6.6: `DR_X(M)` is perverse. So the de Rham functor of the book has the shift of `pDR`.
- Theorem 4.7.7: for a smooth algebraic variety and `M ∈ D^b_h(D_X)`, `DR_X(M) ∈ D^b_c(X)`. Formula (7.1.1): `D_X DR_X(M) ≃ DR_X(𝔻_X M)` for these complexes. Proposition 4.7.8: external products.
- Theorem 6.1.5: on smooth algebraic varieties, duality, the two direct images and the two inverse images preserve `D^b_rh`.
- Theorem 7.1.1: for a morphism `f : X → Y` of smooth algebraic varieties, four canonical morphisms are isomorphisms on regular holonomic complexes, among them `DR_X ∘ f^† ≃ f^! ∘ DR_Y`, with `f^† = Lf^*[dim X − dim Y]`. The morphism for `f^†` is defined through the adjunctions of `∫_{f!}` with `f^†` and of `Rf_!` with `f^!`.
- Theorem 7.2.2: for a smooth algebraic variety, `DR_X : D^b_rh(D_X) → D^b_c(X)` is an equivalence. The book gives a "Sketch of proof". Remark 7.2.3: "It is not totally trivial whether the isomorphism (7.2.1) constructed in the sketch of proof coincides with the one induced by `DR_X`. To make it more precise, we need to check many relations among various functors". Theorem 7.2.5: `Mod_rh(D_X) ≃ Perv(ℂ_X)`.
- The book treats smooth algebraic varieties and complex manifolds only.

`docs/papers.md` lists these numbers with the date. The copy is not kept in the repository.

## Where the two reports disagree

### The compatibility for three embeddings (checker F1, Codex 2)

The checker would delete the sentence. Codex would keep the claim with canonical maps and a cocycle condition, and would add compatibility with composition to `DModules.regularHolonomicDeRham`.

Decision: the claim is deleted, and the pairwise isomorphism is stated with its maps named. Evidence:

1. No statement of `plans/` uses a compatibility for three embeddings. Every clause of `DModules.analyticDeRham` and of `DModules.analyticDeRham_isEquivalence` is the existence of a natural isomorphism, and `Satake.ic_starRestriction_isEven` uses the vanishing of cohomology sheaves, which is invariant under any isomorphism.
2. The definition does not need it. The closed embedding is now part of the data of the functor (`DR_i`), so the node is a definition with no choice, and statement (1) says that the functors of two embeddings are isomorphic. Before, the node spoke of one functor `DR_Y` "up to a unique isomorphism", which was wrong, as both reports say: on a point the identity functor has the scalars as automorphisms.
3. The compatibility would rest on a compatibility of `pDR ∘ f_+ ≅ Rf_* ∘ pDR` with composition, through `X_1 × X_2 × X_3`. The target §1.5 says only "compatible with `f_+` and `Rf_*`". [HottaTakeuchiTanisaki] Theorem 7.1.1 states four isomorphisms and no relation between them for a composite, and Remark 7.2.3 says that relations of this kind are not checked in the book. So the clause would ask Tau Ceti for a part beyond the target and beyond the source, with no user.
4. The one user that could want coherent comparison maps is `Satake.regularSheafExt_complexComparison` in `plans-proof/`. By Codex's own objection 1 it needs a comparison of complexes on a simplicial scheme, which a cocycle condition between isomorphisms in triangulated categories does not give. The coherent form belongs to that open item (below).

What is taken from Codex: the word "unique" is gone; the pairwise isomorphism is spelled out as a composite of four named isomorphisms (the composition isomorphism of the direct images of crystals, the isomorphism of (3) of the roadmap node for the projection with the comparison of `DModules.deRhamPushforward`, the definition of the functor, the composition isomorphism of `Constructible.DerivedCategory` (1)); and the proof of the compatibilities with maps names its adjunction step (entry "Codex 2" below). The roadmap node now says in words that it asks for one isomorphism for each map and for no compatibility with composition, with the three reasons.

### A record of the narrower scope in `GLCinLean.lean` (checker F2, Codex 4)

The checker says that the narrower scope needs no entry. Codex asks for a record of it "as a restriction of the project's extension to singular schemes".

Decision: no entry for the scope. Evidence: `AGENTS.md`, "Plan", asks for a record of "an error or a gap found in a paper, and a claim that is given up as too hard". The source of the two nodes is [HottaTakeuchiTanisaki], and it states the comparison for smooth algebraic varieties only (Theorems 7.1.1, 7.2.2 and 7.2.5, read for this round). The scope "closed in a smooth scheme" contains every smooth separated scheme of finite type, so no claim of the source is given up; the scheme with singularities is this plan's own extension, and [Crystals] Proposition 4.2.5, which the extension uses, is kept. The restriction is recorded where "Writing" puts it: in the node (its part "Restrictions, with their reasons"), which becomes the doc comment of the declaration, and in `docs/blueprint-providers.md`, "Limits of existing providers". The nodes are lemmas of proofs and the statement does not name them, so "Differences from the sources" of the root file, which lists the differences that affect the statement, does not apply either.

Both reports agree on the dropped claim; see "Checker F2" below.

## The findings of the checker

**F1. The compatibility for three embeddings.** Fixed in `7cc204c`, as decided above: the sentence is deleted, `DModules.analyticDeRham` (1) states the isomorphism for two embeddings, and the node says that it states no compatibility for three.

**F2. The entry in `GLCinLean.lean`.** Fixed in `f85d581`. The module doc comment has, under "Not formalized", an entry for [HottaTakeuchiTanisaki] Theorem 4.6.3, Corollary 4.6.5 and Theorem 4.6.6 (a holonomic D-module on a complex manifold) and Theorem 4.7.7 with formula (7.1.1) (algebraic holonomic complexes on a smooth variety): for the holonomic modules that are not regular these statements are not formalized. The numbers were compared with the book. The entry names no declaration, because none exists yet; "Plan" asks for the declaration "once that exists". The scope has no entry, as decided above.

**Item 1, `Constructible.DerivedCategory`: the composition isomorphisms belong to clause (1).** Fixed in `7cc204c`. Clause (1) names `(g ∘ f)^* ≅ f^* g^*`, `R(g ∘ f)_* ≅ Rg_* Rf_*`, `R(g ∘ f)_! ≅ Rg_! Rf_!` and `(g ∘ f)^! ≅ f^! g^!`; the comparison lists them under "the same in both" (the target says "composition"); "What uses what" names the two de Rham nodes.

**Item 1, `Constructible.PerverseSheaves`: one part beyond the target is not marked.** Fixed in `7cc204c`. The node lists, under the parts beyond the target, the two conditions on strata for every stratification by smooth connected strata along which both restrictions are lisse, where the target has the Whitney stratifications.

**Item 1, `Constructible.StratifiedDerivedCategory`: the sentence on §1.1 claims more than §1.1 states.** Fixed in `7cc204c`. The node now says that §1.1 gives the Whitney stratifications and the local triviality of a proper map over the strata of its target, and that the local triviality of a Whitney stratified space along its strata is the first isotopy lemma of Thom with control data, AlgebraicTopologyPartII §§16.1a–16.1e, which is not a plan node.

**Item 1, `DModules.regularHolonomicDeRham`: the stability in clause (3) is not marked as a part beyond the target.** Fixed in `7cc204c`. Clause (3) separates the isomorphisms from the stability that they presuppose. The node says that the target presupposes the stability, that no accepted roadmap states it as a target, quotes the request `gap:regular-holonomic-stability`, and has the rule that a declined part comes back through `prompts/change.md`. The checker's test of the shift for the smooth map `𝔸¹ → pt` is a second check of the node.

**Item 2: the wrong attribution in section 3.8 of the note.** Fixed in the commit that adds this file. The note now quotes §1.5: "the bounded derived category with regular holonomic cohomology".

**Item 2: the sentence "Every use is on a finite union of Schubert varieties" is too narrow.** Fixed in `7cc204c`. `DModules.analyticDeRham` says: the uses in the plan of the statement are on finite unions of Schubert varieties, which are projective; the plan of the proof also names their products with powers of a finite jet quotient of `L⁺G`, which are quasi-projective. `docs/blueprint-providers.md` says the same.

**Item 2: `DModules.IsHolonomic` is in the `deps` of `DModules.analyticDeRham` and is not used.** Fixed in `7cc204c`: the edge is removed.

**Item 4: sentences of `STATUS.md` that become false.** Not changed on the branch: the branch does not edit `STATUS.md`. The list of the checker is right and is for the apply step: in the decision "The decomposition theorem", the sentences "`DModules.analyticDeRham` claims an image in the complexes constructible along a stratification…", "The three are prerequisites and not named targets" and "roadmap nodes of the same area"; in the open item on the theorems that no accepted roadmap states, "the open TauCetiRoadmap #2279".

**Item 5: the note of [HottaTakeuchiTanisaki] in `docs/references.bib` names Chapters 2–3 and 6–8 only.** Fixed in `7cc204c`: the note names Chapters 1–4 and 6–8 and points to `docs/papers.md` for the compared numbers.

**"Not checked": `DModules.analyticDeRham_isEquivalence` uses ComplexComparisonPartII C5.6 directly and no plan node stands for it.** Fixed in `7cc204c`, by the form that the provider record already has for such a case (ReductiveGroups 3A.5f): a row under "Roadmaps that nodes here use as inputs" names C5.6 `deligneRiemannHilbert`, its user and what the user takes from it, and says that the tracker waits for it only through `DModules.regularHolonomicDeRham`. The node also names the second input of that step, the Poincaré lemma for a holomorphic connection.

## The objections of Codex

**1. The proof plan lacks the equivariant Ext comparison.** Not changed: it is a separate finding, and it is stated below as a new open item. Evidence that it is separate:
- The text of `Satake.regularSheafExt_complexComparison` ("Over C apply DModules.analyticDeRham_isEquivalence on each finite stage") is that of `8cde2a3`. `git diff 8cde2a3 -- plans-proof` is empty on this branch.
- Before this change, `DModules.analyticDeRham_isEquivalence` was also an equivalence of triangulated categories on schemes. The change removes nothing that the node could have used.
- The scope of this change serves the node as far as schemes go: Codex and the checker both find that the stages `H^n × Z` are quasi-projective.
- The tracker does not read `plans-proof/`, no node of `plans/` depends on it, and the first goal does not need it.

**2. Canonical maps and a precise coherence claim; the adjunction step.** Fixed in part in `7cc204c`, not changed in part.
- Fixed: "unique isomorphism" is removed, and the pairwise isomorphism is spelled out by its four steps (above).
- Not changed: the cocycle condition for three embeddings and the compatibility with composition in the roadmap node. The evidence is in "Where the two reports disagree".
- Fixed: the adjunction step. `DModules.analyticDeRham_isEquivalence` now has the proof in steps (a) to (g). (a) The direct image along every map, by the graph and the ambient projection. (b) The !-pullback along a closed embedding: `f_*` is left adjoint to `f^!` on both sides (the proper adjunction of `DModules.deRhamPushforward`; (1) of `Constructible.DerivedCategory`), the de Rham functors are equivalences, and (a) identifies the left adjoints, so the right adjoints are identified. (c) The !-pullback along the projection `X × Y′ → Y′`, from the case of the ambient projection in (3) of the roadmap node and the base change `p^! i′_* ≅ e_* q^!` on both sides. (d) A general map is a closed embedding followed by such a projection. The proof takes no mate for a general `f_!`, so `DModules.holonomicShriek` is not needed. This is the route that Codex describes; in the book the morphism for `f^†` is defined by the same adjunctions (Theorem 7.1.1, (7.1.4)).

**3, first part: the stability of regular holonomic complexes.** Fixed in part in `7cc204c`, not changed in part.
- Fixed: the missing supplier is recorded as a prerequisite. `DModules.regularHolonomicDeRham` marks the stability as a part that the target presupposes and no roadmap states as a target, with the request quoted and the rule for a declined part. Neither roadmap node depends on a node written here.
- Fixed: the overlap is recorded in both nodes. `DModules.IsRegularHolonomic` and the roadmap node say that, for the left modules on smooth complex schemes, the two stabilities are one theorem ([HottaTakeuchiTanisaki] Theorem 6.1.5), that it is not proved twice, and that its provider is decided with `prompts/change.md` before `DModules.IsRegularHolonomic` is written.
- Not changed: the edge that would make the theorem of `DModules.IsRegularHolonomic` take its complex case from Tau Ceti. Evidence. (i) The decision "D-modules on smooth schemes: Tau Ceti provides the classical theory" of 2026-11-19 assigns this theorem to this project "because no accepted roadmap states them"; that is still so: the stability is a request (`gap:`), and the text of SpringerResolutionAndCharacteristicCycles says that "the general regular holonomic Riemann–Hilbert correspondence on arbitrary smooth varieties is not part of this roadmap". To move the case is a change of provider, which is a big change of its own. (ii) An edge from `DModules.IsRegularHolonomic` to `DModules.regularHolonomicDeRham` would have the wrong direction: the stability is an input of the correspondence (it is Theorem 6.1.5 of the book and the correspondence is Chapter 7), and the nodes of the Satake category over `k` would wait for the analytic correspondence. (iii) The right form is a roadmap node of its own for the request, in the area of SpringerResolutionAndCharacteristicCycles, as `Infinity.derivedBimoduleTransfer` is for `gap:derived-bimodule-sheaves`. With it, `DModules.IsRegularHolonomic` must reduce a field of characteristic 0 to ℂ (descent of a holonomic complex to a finitely generated subfield, an embedding of that field into ℂ, and (4) of `DModules.regularHolonomicDModule`), which is a choice of route for a node that the statement's plan uses. `STATUS.md` has the open item for this decision ("Theorems on holonomic and regular holonomic complexes that no accepted roadmap states"); the session should add to it that the request `gap:regular-holonomic-stability` is now in an accepted roadmap and that the two nodes forbid a second proof.

**3, second part: the edges of `Constructible.DerivedCategory` for the stated route.** Fixed in `7cc204c`. The node depends on `Infinity.enhancedDerivedCategory` (the carrier: EnhancedDerivedSheaves E1.3, with the equivalence of its homotopy category with the `DerivedCategory` of Mathlib) and on `Infinity.derivedBimoduleTransfer` (its (2) is the direct image of E1.4 for a continuous map and sheaves of rings). The node says that the pullback, the tensor product, the internal Hom and the change of coefficients of E1.4 for commutative coefficients are not plan nodes. The precedent is `DModules.transferModule`, a roadmap node on ordinary derived categories that depends on `Infinity.derivedBimoduleTransfer` for the same reason. The effect: the tracker lists the constructible category as ready only after these two nodes.

**4. The root documentation entry.** Fixed in `f85d581` for the dropped claims (constructibility, duality and perversity for the holonomic modules that are not regular), with the numbers that Codex names, compared with the book. Not changed for the narrower scope; the evidence is in "Where the two reports disagree".

**5, `AnalyticConstructible.toml`.** Fixed in `7cc204c`. The list of the clauses of the target outside the node names the sections with support, "`RΓ_Z = i_* i^!`", with the triangle of `RΓ_Z(X, K)`, `RΓ(X, K)` and `RΓ(X ∖ Z, K)` and the checks on the affine line. The node says that the counterexample to base change for `Rf_*` and the check that `Rj_*E` is in `D^b_c` are its own checks.

**5, `AnalyticPerverse.toml`.** Fixed in `7cc204c`. The list of the clauses of the target outside the node names the truncation triangles with the long exact sequence of perverse cohomology (which every t-structure has) and the exchange of `pH⁰ j_!` and `pH⁰ Rj_*` by duality (which follows from the definition of the node with the exchange of `𝔻` in `Constructible.DerivedCategory` (3)). The node says that its checks for a smooth scheme that is not connected and for `Rj_*E[1]` on the line are not in the target.

**5, `RegularHolonomicDeRham.toml`.** Fixed in `7cc204c`. The readings of the target are numbered (i) to (vii). (iii) The boundary regularity: (a) of `DModules.regularHolonomicDModule` tests a connection at every point of the boundary of the smooth projective completion of every smooth locally closed curve, and these include the points over the boundary of a compactification; the connection with `∂e = e` is regular on the affine line and fails at infinity. (iv) The inverse: the node asks for the equivalence and for no construction of an inverse functor. (vii) Nearby and vanishing cycles: the target says "Compatibility with nearby and vanishing cycles is 4.2", and the node does not ask for it. The checks are split into those of the target and those of the node (the `i^†` test and the test for a smooth map). The stability is the first part of objection 3.

**Remark: state the source subcategory of the stratified equivalence by the lisse cohomology of `i_T^*M` throughout.** Fixed in `7cc204c`. `DModules.analyticDeRham_isEquivalence` defines `Dᵇ_{rh,S}(Y)` by this condition and uses it for the inclusion and for the equivalence.

## A new open item, from objection 1 of Codex

**The equivariant Ext comparison over ℂ in the plan of the proof.** Owner: `Satake.regularSheafExt_complexComparison` (`plans-proof/GLCinLean/GeometricLanglands/Satake/Comparison.toml`), with `DModules.boundedEquivariantExt_baseChange` (`plans-proof/GLCinLean/AlgebraicGeometry/DModules/ScalarExtension.toml`).

- What the node says: "Over C apply DModules.analyticDeRham_isEquivalence on each finite stage", for the Ext algebra of the regular Satake object, whose source [LoopGrassmannianExt] Theorem 7.6.1 computes Ext in the equivariant derived category. The stages are the schemes `H^n × Z` of the simplicial quotient, for a finite union `Z` of Schubert varieties and a finite jet quotient `H` of `L⁺G`.
- What is missing: an equivariant Ext group is the cohomology of the totalization, over `n`, of the Hom complexes of the stages. `DModules.analyticDeRham_isEquivalence` gives an isomorphism of the Ext groups of each stage, and one natural isomorphism for each face map. It gives no map between the two cosimplicial Hom complexes, so it compares the first pages of the two spectral sequences and not their limits. Example: on a point with `H = 𝔾_m`, the class of `Ext²_{𝔾_m}(ℂ, ℂ) = H²(B𝔾_m, ℂ)` is not an Ext class of the point.
- What would supply it: a de Rham comparison on the schemes `H^n × Z` as a functor of enhanced categories, compatible with the pullbacks along the face maps, with convolution and with the action of the dual group; or an equivalence of the equivariant categories built from the equivalence of the hearts. No accepted roadmap states either: MixedHodgeModulesAndIrregularHodgeTheory §1.5 is for triangulated categories.
- It does not depend on this change: the schemes `H^n × Z` are quasi-projective, so they are in the scope of `DModules.analyticDeRham`, and the gap is in the node at `8cde2a3`.
- Action: decide with `prompts/change.md` when the plan of the proof reaches the node. The compatibility of the embedding isomorphisms for three embeddings (checker F1) is decided with it.
