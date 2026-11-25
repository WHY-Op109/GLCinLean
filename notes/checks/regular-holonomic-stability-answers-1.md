# Answers to round 1 on `proposal/regular-holonomic-stability`

The reports of round 1 are `regular-holonomic-stability-checker-1.md` (the checker) and `regular-holonomic-stability-codex-1.md` (Codex). Both judge the commits `91a933f` and `57c28c7`. The fixes are in commit `98b98c8`. Each entry below says "fixed" or "not changed", with the evidence.

**The proposal in one paragraph.** The plan needs the theorem that the operations on D-modules carry regular holonomic complexes to regular holonomic complexes. For left modules on smooth schemes this theorem becomes two roadmap nodes of SpringerResolutionAndCharacteristicCycles, both prerequisites and not named targets. The first, `DModules.regularHolonomicDModule_directImage_inverseImage_complex`, is the request `gap:regular-holonomic-stability` of the accepted roadmap MixedHodgeModulesAndIrregularHodgeTheory, over ℂ. The second, `DModules.regularHolonomicDModule_directImage_inverseImage`, is the same statement over every field of characteristic 0; this document calls it the stability node. Written here, in `DModules.IsRegularHolonomic`, is only the passage from left modules on smooth schemes to crystals on schemes of finite type, in steps (a) to (g).

Files: the two roadmap nodes are in `plans/Roadmap/SpringerResolutionAndCharacteristicCycles/RegularHolonomicStability.toml`; `DModules.IsRegularHolonomic` is in `plans/GLCinLean/AlgebraicGeometry/DModules/RegularHolonomic.toml`.

## 1. Step (a) of the route (checker M1, Codex 1)

**Fixed. Both objections are right, and the new step (a) answers both.**

The old step (a) proved that the direct image along a closed embedding of smooth schemes preserves and reflects regularity by matching simple modules and by `i_+(j_!*E) = (i ∘ j)_!*E`. Its defects:

- Clause (b) of `DModules.regularHolonomicDModule` defines regular simple modules over an algebraically closed field only. Over a general field the argument needs `(i_+M)_{k̄} ≅ (i_{k̄})_+(M_{k̄})`, an extension of the base field (checker).
- "Regularity is Zariski-local, by its definition" was not by definition (checker).
- The equivalence of Kashiwara for one closed embedding of smooth schemes does not compare two embeddings of a scheme that is not smooth. Steps (b), (c) and (g) need that comparison, and so do the two de Rham nodes, for every smooth ambient scheme that they allow (Codex).

The new step (a) proves that the definition is well posed, in four parts. Each part uses only the statements (1) and (2) of the stability node, (1) of `DModules.regularHolonomicDModule` (closure under submodules), and the comparisons of the crystal functors with the classical ones.

- **(a1) Closed embeddings of smooth schemes** (the checker's wording). `i_+` preserves regularity by (1) of the stability node. It reflects regularity by (2), because `M ≅ H⁰(i^† i_+ M)` (`DModules.transferModule` (7)).
- **(a2) Open covers of smooth schemes** (the checker's wording). The restriction to an open preserves regularity by (2). Conversely `M` is a submodule of the direct sum of the `H⁰(u_{c+} u_c^† M)`, which is regular by (1).
- **(a3) Two embeddings** (Codex's route). For closed embeddings `i_1`, `i_2` of a scheme `Y` of finite type into smooth separated schemes `A_1`, `A_2` of pure dimensions, `g = (i_1, i_2)` is a closed embedding into `A_1 × A_2`. If `g_*M` is regular, `i_{r*}M ≅ p_{r*} g_* M` is regular by (1). If `i_{r*}M` is regular, `g_*M ≅ g_* g^! p_r^! i_{r*} M` is the fibre of `K → u_* u^! K` for `K = p_r^! i_{r*} M` and the open complement `u` of `g(Y)`, and it is regular by (1) and (2). The ambient schemes are any smooth separated schemes of finite type of pure dimension, not only affine spaces.
- **(a4) Charts.** Independence of the embeddings is (a3). Independence of the cover uses (a2) and (a3). Agreement with the definition on a smooth scheme is (a2) and (a1). Consequence, which the two de Rham nodes use: for a closed embedding `i` of `Y` into a smooth separated `X` of pure dimension, `M` is regular exactly when `i_*M` is.

Further changes that follow:

- The sentence "The passage uses no extension of the base field" is now true for every field of characteristic 0. It stays in `DModules.IsRegularHolonomic`, with the reason added, and in `docs/blueprint-providers.md` (the row of SpringerResolutionAndCharacteristicCycles). No other step used a field extension; the checker confirms this for (b) to (g).
- Step (a) no longer uses simple modules or the intermediate extension. The dependency `DModules.holonomicIntermediateExtension` is removed from `DModules.IsRegularHolonomic`, and that roadmap node is as on `main`.
- `DModules.analyticDeRham` (construction (b)) and `DModules.analyticDeRham_isEquivalence` (the equivalence) now cite the consequence of (a4).

## 2. The functor comparisons of steps (e) and (g) (Codex 2)

**Fixed. The three comparisons are named lemmas.**

- **Duality and closed embeddings.** New lemma of `DModules.verdierDuality` (`plans/GLCinLean/AlgebraicGeometry/DModules/Verdier.toml`): for a closed embedding `i : Y → Z` of schemes of finite type, `i_*` preserves `DModules.Coherent` and `𝔻_Z i_* M ≅ i_* 𝔻_Y M`, natural in `M`. The proof is the one Codex names: the duality formula on `Y` and on `Z`, the adjunction of `i_*` and `i^!`, and the projection formula. The projection formula is [DG2] §5.2.5 ("Projection formula", `references/papers/1108.5351v3/src/Finiteness.tex`, line 4943), which derives it from base change. The lemma is in `DModules.verdierDuality` and not in `DModules.IsRegularHolonomic`, because the theorem of `DModules.verdierDuality` on holonomic complexes needs it on the charts of a scheme that is not smooth. It is a small change (a lemma of a node that the changed node uses).
- **Duality and open restriction.** Step (e) now cites the case `d = 0` of the exchange of `f^!` and `f^![−2d]`, which `DModules.verdierDuality` already states.
- **(g1) External product and closed embeddings.** New lemma of `DModules.IsRegularHolonomic`: `(i × i′)_*(M ⊠ M′) ≅ i_*M ⊠ i′_*M′`. The proof is the one Codex names: the external product commutes with `!`-pullback, so the right side is supported on `Y × Y′` and its `!`-pullback there is `M ⊠ M′`; then the equivalence of Kashiwara for `i × i′`.
- **(g2) External products of right crystals and of left D-modules.** The lemma that the first commit moved from `DModules.analyticDeRham_isEquivalence`. Its text now says that the comparison identifies the two actions of the differential operators and not only the underlying sheaves, that the shifts of the passage between left and right crystals are additive in the dimensions, and that the isomorphism is natural in both variables.
- (g1) and (g2) are in `DModules.IsRegularHolonomic` and not in `DModules.shriekTensor`, which defines the external product of crystals. The reason: (g1) needs the de Rham pushforward and (g2) needs the external product of left D-modules, which a roadmap node defines; `DModules.shriekTensor` is the monoidal structure of the D-modules on every prestack and must not wait for either. The checker's remark on item 2 agrees. Each is "stated as a lemma of its own", because `DModules.analyticDeRham_isEquivalence` uses both; that node now cites them by name.

## 3. The users of the stability (Codex 3, Codex's remark "User coverage", checker item 3, checker item 5.4)

**The table is completed. Two older defects are not part of this change; the texts for `STATUS.md` are in section 9.**

- **Missing users (checker item 3): fixed** in the table of `regular-holonomic-stability.md`, section 3. Added: `Satake.weightFunctors`, `Satake.chiralCousinComplex_concentrated`, `SemiInfinite.whittakerJacquet_compose`, `Whittaker.borelSemiInfiniteIC_zastavaComparison`. All are over the ground field, on quasi-projective schemes, with immersions, smooth maps or proper maps. The two Whittaker nodes of the next point are listed below the table as nodes that are not users.
- **`DModules.boundedEquivariantExt_baseChange` (Codex's remark): fixed.** The first note said that a field that is not algebraically closed occurs only with outputs on the point. That was too short: the node spreads the equivariant complexes and their convolution maps out to a field that is finitely generated over ℚ. The table and point 2 of that section now say so. This use is served only by the stability node over every field of characteristic 0, and it is named among the users of that node.
- **Satake convolution (Codex 3, first part): no text of this change changes.** The objection is right. The convolution product descends `A ⊠ B` along a torsor to the twisted product, and the stability gives only that the pullback of a regular complex is regular, not the converse. The converse follows from the stability under `!`-pullback when the torsor has sections locally in the Zariski topology: for a section `s` of `q` over an open `U`, `N|_U ≅ s^! q^! N`. So `DModules.IsRegularHolonomic` needs no new clause. Codex cites [MV] §4 for the local sections; the statement is in [MV] §2 (`references/papers/math-0401222v5/src/Satake.tex`, line 895), and §4 is the convolution product. The brief that must name the sections is `Satake.convolution`. That node is under "Held" in `STATUS.md` (roadmap PR #1734 would own it), so it is not edited now; section 9 has the open item.
- **The two Whittaker nodes (Codex 3, second part; checker item 5.4): no text of this change changes.** The defect is real and predates the change. `DModules.perverseHeart` and `DModules.intermediateExtension` are defined for regular holonomic complexes. `Whittaker.nonzeroZastava_whittakerCohomology_vanishes` depends on the first for a pushforward of "the Zastava IC sheaf tensored with its Whittaker exponential", and `Whittaker.pointwiseCasselmanShalika` depends on the second for the clean extensions of the exponential module. The exponential D-module is not regular (`DModules.regularHolonomicDModule`, check on the affine line). No stability theorem repairs this; the two nodes need the t-structure and the `!`- and `*`-extensions of holonomic complexes. Both nodes are in `plans-proof/`, which this change does not edit. Section 9 has the open item.

## 4. The node over every field (Codex 4, Codex's remark "Provider and scope", checker items 4 and 5.2)

**Fixed. The roadmap node is split in two, the route over a general field is recorded, and neither node reads as ready on its `deps`.**

- **Two nodes (Codex's remark on staging): accepted.** `DModules.regularHolonomicDModule_directImage_inverseImage_complex` is the request as the roadmap states it, over ℂ. `DModules.regularHolonomicDeRham` depends on it and not on the general field, so the correspondence over ℂ can use the complex theorem when it lands. `DModules.regularHolonomicDModule_directImage_inverseImage` states the same three clauses over every field of characteristic 0 and depends on the complex node; `DModules.IsRegularHolonomic` depends on it. Reasons for two nodes and not two clauses of one node: the tracker orders work by nodes, so only two nodes let `DModules.regularHolonomicDeRham` wait for less; and the part beyond the request is now one whole node, so a refusal of Tau Ceti concerns that node alone.
- **The route (Codex 4): recorded** in the stability node as three obligations inside Tau Ceti, none of which is a plan node:
  - (a) base change along an extension `K/k` of the field for `f_+`, `f^†` and `⊠`, on bounded complexes with quasi-coherent cohomology;
  - (b) reflection: a module is coherent, holonomic or regular exactly when its base change is (for regularity by the definition over a general field and by (4) of `DModules.regularHolonomicDModule`);
  - (c) descent of the schemes, the morphism and a bounded complex with coherent cohomology to a field that is finitely generated over ℚ, whose algebraic closure embeds into ℂ.
  
  The node says that Springer §9.7 supplies only the third part of (b), that `DModules.scalarExtension` cannot supply (a) to (c) without a cycle, and that a proof which does not pass through ℂ needs none of them.
- **Readiness (Codex 4): fixed.** Both nodes have a passage "Readiness": the node is not ready when its dependencies are in Tau Ceti, and `lake exe tracker ready` does not see the other inputs. For the complex node the inputs are those of the proof of [HottaTakeuchiTanisaki] §6.2, which I read in the English edition: the classification of simple holonomic modules (Theorem 3.4.2), a theorem of Hironaka, the theorem of Deligne (Theorem 5.3.7), the regularity of Gauss–Manin connections, and before them the stability of holonomic complexes (Theorem 3.2.3, Proposition 3.2.2). `docs/blueprint-providers.md` has the same under "Readiness in Tau Ceti". The sentence of the first note that the Worker gets the node "once its three dependencies are in Tau Ceti" was wrong; the note now points here.
- **Consequence for the first goal (checker item 4): recorded.** `DModules.IsRegularHolonomic`, and through it `DModules.perverseHeart` and `Satake.sphericalHeart`, depend on the stability node, which is beyond the request. `docs/blueprint-providers.md` says that the statement plan waits for it. Section 9 has the sentence for "Decisions taken".
- **One more fallback (checker item 5.2): accepted as the first fallback.** If Tau Ceti declines the stability node, the natural candidate is to write its content here: the passage (a) to (c) for left modules on smooth separated schemes only, with steps (a) to (g) of `DModules.IsRegularHolonomic` unchanged. With the split this is exactly "the stability node written here". It avoids the obligations of candidate A about crystals, about maps that are not separated, and about the order of the nodes around `DModules.scalarExtension`. The other candidates are A and D of the first note. The decision is for the change that the refusal would start.

## 5. The source of the external product (checker U1, Codex's last remark)

**Fixed. The node now records a route from compared numbers of the book.**

I compared the numbers that Codex names with the English edition of [HottaTakeuchiTanisaki]. The `source` of the complex node now has this route for clause (3):

- Proposition 3.2.2: the external product of holonomic complexes is holonomic.
- Theorem 6.1.6, condition (iii): a holonomic complex is regular when its inverse image under every morphism `k` from a smooth curve `C` is.
- For `k = (k_1, k_2) : C → X × X′`, `k^†(M ⊠ N)` is, up to a shift, the derived tensor product over `O_C` of `k_1^†M` and `k_2^†N`. These are regular by Theorem 6.1.5, and their tensor product is holonomic by Corollary 3.2.4.
- On a dense open subset of `C` their cohomology modules are regular integrable connections, and the tensor product of regular integrable connections is regular (Proposition 5.3.5).
- A holonomic module on a curve is regular when its restriction to a dense open subset is (Definition 5.1.21 and Remark 6.1.4).

The route is not circular: the proof of Theorems 6.1.5 and 6.1.6 in §6.2 of the book does not use the external product of regular complexes. No number of the book states clause (3) itself, and the node still says so. `docs/papers.md` records the numbers compared on 2026-11-25. The checker's sketch (generation by the `j_+E`, and a Künneth isomorphism) is a second route; the node does not need both.

## 6. Holonomic complexes that are not regular (checker U2 and item 5.1, Codex's remark on E)

**Not changed on the branch; the trigger for `STATUS.md` is in section 9.**

Both reports agree that this is a separate decision. The evidence that it is pressing, checked: the proof of the book puts Theorem 3.2.3 (the direct and inverse images preserve holonomic complexes, for every morphism) before the regular case; Springer §9.1 defines `f_! = 𝔻 f_+ 𝔻` on holonomic modules (its line 861); the requesting roadmap uses `s_+(M ⊠ N)` on holonomic complexes (its line 198). The complex node now names Theorem 3.2.3 and Proposition 3.2.2 under "Readiness" as inputs that no accepted roadmap states for a general morphism. Both stability nodes still say that they do not ask for the holonomic case.

## 7. Wording (checker items 1, 2 and 6)

All fixed in `98b98c8`.

- "it asks for no new functor" (item 1): now "apart from the external product it asks for no new functor".
- "over the complex numbers alone the node would serve only `DModules.regularHolonomicDeRham`" (item 1): the sentence is gone with the split; the users of each node are listed in that node.
- The external product stated in two roadmap nodes (item 1): the complex node defines it, for every field of characteristic 0, and clause (5) of `DModules.regularHolonomicDeRham` refers to it.
- "the roadmap node" is ambiguous (item 2): `DModules.IsRegularHolonomic` introduces "the stability node" once and names it or `DModules.regularHolonomicDModule` at every use.
- `docs/blueprint-providers.md`, "Limits of existing providers" (item 6): the list of comparisons now has the proof obligation of `DModules.IsRegularHolonomic` for the external product.
- `DModules.regularHolonomicDModule` (item 6): its summary of the request now has the external product and the restriction to the diagonal.
- The checker's remark that the writer must export the comparison as a lemma (item 2): (g1) and (g2) say "stated as a lemma of its own".

## 8. Remarks of the reports that need no change

- **The argument for maps that are not separated (Codex's remark).** Step (d) now names its two inputs as Codex states them: the base change of `DModules.deRhamPushforward` for the restriction to an affine open of the target, and the Zariski descent of crystals (`DModules.rightCrystals_hDescent`, a new direct dependency) with the open adjunction for the triangle of two opens.
- **The converse of the curve criterion (Codex's remark).** It stays a proof obligation of `DModules.IsRegularHolonomic` with no route, as before the change. New evidence: the book proves Theorems 6.1.5 and 6.1.6 together, by one induction on the dimension of the support (§6.2, Steps 5 to 8). So a proof of the complex node along the book also gives the curve criterion for left modules on smooth complex schemes. The complex node says this under "Readiness". Whether the curve criterion on smooth schemes joins the roadmap nodes belongs to the open item of section 9, point 3.
- **Acceptance over ℂ only (checker item 5.2).** Section 4, last point.
- **A difference between the roadmap and the book, found while comparing.** Definition 6.1.1 of the book asks that the inclusion of the smooth subvariety be affine; Springer §9.7 and `DModules.regularHolonomicDModule` (b) do not. `docs/papers.md` records it. I did not check that the two definitions agree, and the change does not depend on it.

## 9. Texts for `STATUS.md`

The planner does not edit `STATUS.md`. These are the texts for the session.

**"Held".** Remove the row of `DModules.regularHolonomicDeRham` and of the stability theorem of `DModules.IsRegularHolonomic` when the change is applied. The tracker then orders the work through the two roadmap nodes.

**"Decisions taken", new entry (the facts to record).** The stability of regular holonomic complexes on smooth schemes is provided by Tau Ceti, through two roadmap nodes of SpringerResolutionAndCharacteristicCycles that are prerequisites and not named targets: `DModules.regularHolonomicDModule_directImage_inverseImage_complex` (the request `gap:regular-holonomic-stability` of MixedHodgeModulesAndIrregularHodgeTheory, over ℂ; `DModules.regularHolonomicDeRham` depends on it) and `DModules.regularHolonomicDModule_directImage_inverseImage` (the same over every field of characteristic 0, beyond the request; `DModules.IsRegularHolonomic` depends on it). Written here: the passage to crystals on schemes of finite type and to all maps of finite type, with no extension of the base field. This revises the decision of 2026-11-19 for this theorem. The statement plan (`DModules.perverseHeart`, `Satake.sphericalHeart`) now waits for a node that Tau Ceti has not accepted. If Tau Ceti declines the second node, it comes back through `prompts/change.md`; the first candidate is then to write that node here, for left modules on smooth schemes only.

**"Open items", three texts.**

1. **Regularity of the convolution product on the twisted product.** `Satake.convolution` descends the external product `A ⊠ B` along a torsor to the twisted product. The stability theorem of `DModules.IsRegularHolonomic` gives that the pullback of a regular complex along the torsor map is regular, and not the converse. Before `Satake.convolution` is written, its brief names one of two inputs: the sections of the loop-group torsor that exist locally in the Zariski topology ([MV] §2: "The morphism π : G_K → Gr is locally trivial in the Zariski topology"; the convolution diagram of [MV] §4 uses it), carried to the torsor of finite type that the construction uses, so that the descended complex is locally `s^! q^! N` for a section `s` and is regular by the stability under `!`-pullback; or a proof that regularity descends along a smooth surjective map. The node is under "Held".
2. **Two nodes of `plans-proof/` use the regular perverse heart for complexes that are not regular.** `Whittaker.nonzeroZastava_whittakerCohomology_vanishes` depends on `DModules.perverseHeart`, and `Whittaker.pointwiseCasselmanShalika` on `DModules.intermediateExtension`, for objects twisted by the exponential D-module, which is holonomic and not regular. Both nodes of the statement plan are defined for regular holonomic complexes only. Before either Whittaker node moves into `plans/`, give it the t-structure and the `!`- and `*`-extensions of holonomic complexes: either widen `DModules.perverseHeart` and `DModules.intermediateExtension` to holonomic complexes with a good stratification (a change of the meaning of two definitions, so a big change), or add nodes for the holonomic case.
3. **Trigger, to add to the existing item "Theorems on holonomic and regular holonomic complexes that no accepted roadmap states".** Decide with `prompts/change.md`, before the Worker takes `DModules.regularHolonomicDModule_directImage_inverseImage_complex` and before the theorems of `DModules.IsHolonomic` (d) or `DModules.holonomicShriek` are written, whether the stability of holonomic complexes under `f_+`, `f^†` and the external product for a general morphism of smooth schemes becomes a roadmap node, an extension of SpringerResolutionAndCharacteristicCycles §9.1. Reason: the proof of the complex node uses it ([HottaTakeuchiTanisaki] Theorem 3.2.3 and Proposition 3.2.2 come before Theorem 6.1.5), Springer §9.1 defines `f_!` on holonomic modules, and the requesting roadmap uses `s_+(M ⊠ N)` on holonomic complexes; so Tau Ceti proves the smooth case, and a proof here would be a copy. The same change decides the curve criterion on smooth schemes, which the book proves together with Theorem 6.1.5. In the same item, the six operations for regular complexes are decided by this change.

**Before the Worker takes the complex node.** Check which inputs of its passage "Readiness" are in Tau Ceti.

## 10. Checks

After `98b98c8`: `lake exe tracker lint` has no errors; `python3 tools/check-module-cycles.py` reports 200 module plans, 314 nodes, 0 cycles; `python3 tools/check-upstream-names.py` confirms all 359 pairs. No Lean file changed, so there was no build.

Not done: I did not check the Tau Ceti tags or its `main`, and I did not search Tau Ceti again for existing declarations. The book [HottaTakeuchiTanisaki] was read in a public copy of the English edition; it is not in `references/`.
