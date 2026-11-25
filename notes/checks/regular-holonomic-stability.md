# The provider and the route of the stability of regular holonomic complexes

Branch `proposal/regular-holonomic-stability`, on `main` at `536cce3`. This note is steps 1 and 2 of `prompts/change.md`. Sections 1 to 3 are the problem and its evidence. Section 4 lists the options. Sections 5 to 8 are the choice, the change on the branch, and the points that stay open.

Sections 6 and 7 describe the first commit, `91a933f`. Round 1 of the checks changed four things, and `regular-holonomic-stability-answers-1.md` has them in full: the roadmap node is now two nodes (the request over ℂ, and its extension to every field of characteristic 0); step (a) of the route is rewritten; three comparisons of functors are named lemmas; and neither roadmap node is ready on its `deps` alone. The table of section 3 is the completed one.

## 1. The problem

The stability theorem says: the operations on D-modules carry regular holonomic complexes to regular holonomic complexes. The plan has it in two places.

- `DModules.IsRegularHolonomic` (`plans/GLCinLean/AlgebraicGeometry/DModules/RegularHolonomic.toml`), written here: for the right crystals on schemes of finite type over a field of characteristic 0, the six operations along all maps of finite type. The decision of 2026-11-19 ("D-modules on smooth schemes: Tau Ceti provides the classical theory", `STATUS.md`) lists it under "Also written here, because no accepted roadmap states them".
- `DModules.regularHolonomicDeRham` (`plans/Roadmap/MixedHodgeModulesAndIrregularHodgeTheory/RegularHolonomicDeRham.toml`), a roadmap node: its clauses (1), (3) and (5) presuppose the same stability for left modules on smooth separated schemes of pure dimension over ℂ.

On smooth complex schemes the two are one theorem ([HottaTakeuchiTanisaki] Theorem 6.1.5). `AGENTS.md`, "Lean code", forbids a second proof of what Tau Ceti has, and "Sources of code" sends a part that a roadmap covers to Tau Ceti. So one provider must be chosen for the smooth case, and then a route for the rest. Until then `STATUS.md` holds `DModules.regularHolonomicDeRham` and the stability theorem of `DModules.IsRegularHolonomic` ("Held").

Nodes that the question touches (`lake exe tracker show <id>`): `DModules.IsRegularHolonomic`, `DModules.regularHolonomicDModule`, `DModules.regularHolonomicDeRham`, `DModules.scalarExtension`, `DModules.perverseHeart`, `DModules.intermediateExtension`, `DModules.analyticDeRham`, `DModules.analyticDeRham_isEquivalence`, `DModules.holonomicShriek`, `DModules.deRhamPushforward`, `DModules.verdierDuality`, `DModules.shriekTensor`.

## 2. Sources

- `STATUS.md`: "Open items", "The provider and the route of the stability of regular holonomic complexes" (candidates A, B and C); "Held"; "Decisions taken" of 2026-11-19 and 2026-11-25.
- Git history at `15e4464`: `notes/checks/riemann-hilbert-provider-answers-4.md` (the six obligations of candidate A), and `riemann-hilbert-provider-codex-2.md` to `-codex-5.md` (the objections that led here).
- The roadmap repository at `b24abdf7`. Line numbers below are of the two files `TauCetiRoadmap/SpringerResolutionAndCharacteristicCycles/README.md` (Springer) and `TauCetiRoadmap/MixedHodgeModulesAndIrregularHodgeTheory/README.md` (MixedHodge), and of the root `README.md`.
- [HottaTakeuchiTanisaki] Definition 6.1.1, Theorems 6.1.5 and 6.1.6, §1.5. The book is not in the repository; `docs/papers.md` records that these numbers were compared with the English edition.

What the roadmaps say:

1. MixedHodge, line 1144, the request: "What SpringerResolutionAndCharacteristicCycles must provide (gap:regular-holonomic-stability): stability of the bounded derived category with regular holonomic cohomology under `f_+`, `f_!`, arbitrary `f^†`, external product and restriction to the diagonal, for algebraic maps of smooth complex varieties. Duality, smooth pullback and intermediate extension are supplied by §9.7, and the composition, adjunction and proper-duality comparisons by §9.1 on holonomic complexes." §1.5 (line 141) and §5.1 (line 443) list the request under their needs.
2. Springer does not state it. §9.7 (line 963) has only: "Prove stability under duality, smooth pullback and the intermediate extensions used below." §9.1 (line 852) has for holonomic modules only the "stability of holonomicity under the operations used in intermediate extension".
3. Springer §9.7 is stated for every field of characteristic 0. Line 961: "Use geometric regularity after algebraic closure for general k; its descent and stability are separate inputs." Line 963: "First establish the stated complex-field theorem, then prove compatibility under algebraically closed characteristic-zero extensions and descend geometric regularity to arbitrary characteristic-zero k. This field comparison is a target, not an unmentioned embedding of k into C." Line 1449, scope: "Its generic constructions apply to every smooth separated finite-type characteristic-zero scheme, rather than only flag varieties."
4. The rule of the roadmap repository, root `README.md` lines 623 to 628, "No gaps": "If the roadmap needs something that doesn't exist, building it must itself be a target, here or in a roadmap you cite." So Tau Ceti must build the requested stability for its own §1.5 and §5.1, whatever this project does.
5. The plan has one precedent for a request of this kind: `Infinity.derivedBimoduleTransfer` (`plans/Roadmap/EnhancedDerivedSheaves/DerivedBimodules.toml`) is a roadmap node for `gap:derived-bimodule-sheaves`, "a prerequisite and not a named target", with the rule that a declined part comes back through `prompts/change.md`.

## 3. Who uses the stability, and how much of it

The table lists every node of `plans/` and `plans-proof/` that needs a regular holonomic complex to stay regular under an operation. "Schubert unions" are finite unions of Schubert varieties in `Gr_G`; they are projective. `k` is the ground field of the statement, algebraically closed of characteristic 0.

| Node | Operations | Maps | Schemes | Field |
|---|---|---|---|---|
| `DModules.perverseHeart` (`plans/`) | `j_*`, `j_!` from a stratum (goodness); `i^*`, `i^!` to a stratum (the bounds of the t-structure) | locally closed immersions of smooth strata | a scheme of finite type with a good stratification; the uses are Schubert unions, and in `plans-proof/` Zastava spaces and configurations over `X^I` | `k` |
| `DModules.intermediateExtension` (`plans/`) | `j_!`, `j_*` and the image of `j_! → j_*` | the inclusion of a stratum | as `DModules.perverseHeart` | `k` |
| `Satake.sphericalHeart`, `Satake.convolution`, `Satake.convolution_preserves_perversity` (`plans/`) | external product; pullback along the torsor map to the twisted product, and the converse (the descended object is regular when its pullback is), which is not one of the operations; pushforward along the convolution map | smooth and surjective; proper | Schubert unions and their twisted products | `k` |
| `Satake.weightFunctors` (`plans/`) | restriction to a semi-infinite orbit and cohomology with compact supports; the output is on the point | locally closed immersion; the map to the point | Schubert unions | `k` |
| `Satake.chiralCousinComplex_concentrated` (`plans/`) | extensions from the collision strata | locally closed immersions | Beilinson–Drinfeld Grassmannians over `X^I` | `k` |
| `Satake.sphericalHeartDual` (`plans/`) | Verdier duality, pullback along an isomorphism | isomorphism | Schubert unions | `k` |
| `Satake.fusion` (`plans/`) | intermediate extension from the disjoint locus, restriction to the diagonal | open immersion, closed immersion | Beilinson–Drinfeld Grassmannians over `X^I`, on quasi-projective pieces | `k` |
| `Satake.ic_starRestriction_isEven`, `Satake.sphericalHeart_semisimple` (`plans/`) | `i^*`, `i^!` of `IC_λ` to a stratum | locally closed immersions | Schubert unions | `k`, `ℚ̄`, ℂ |
| `DModules.analyticDeRham` (`plans/`) | `i_*`; `p_*` along a projection `X_1 × X_2 → X_1`; restriction to an open; duality | closed embedding; smooth projection that is not proper; open immersion | a separated scheme with a closed embedding into a smooth scheme | ℂ |
| `DModules.analyticDeRham_isEquivalence` (`plans/`) | proper pushforward, `*`- and `!`-pullback, `j_*`, `j_!`, external product, duality | all maps of schemes in the scope of the node | quasi-projective | ℂ |
| `DModules.regularHolonomicDeRham` (roadmap node) | `f_+`, `f_!`, `f^†`, external product, duality | all morphisms | smooth separated of pure dimension | ℂ |
| `DModules.boundedEquivariantExt_baseChange`, `Satake.regularSheafExt_complexComparison` (`plans-proof/`) | the equivariant complexes, their convolution maps and their Ext groups, spread out to a small field; internal Hom and pushforward to the point; the correspondence over ℂ on finite stages | as the Satake nodes; to the point; as `DModules.analyticDeRham_isEquivalence` | Schubert unions and their products with a finite jet quotient of `L⁺G`, quasi-projective | a field finitely generated over ℚ, `ℚ̄`, `k`, ℂ |
| `SemiInfinite.whittakerJacquet_compose` (`plans-proof/`) | convolution of kernels, and the perverse t-structure relative to `X^I` | as the Satake nodes | finite configurations over `X^I` | `k` |
| `Whittaker.borelSemiInfiniteIC_zastavaComparison` (`plans-proof/`) | intermediate extension, `!`-pullback | smooth; locally closed immersions | Zastava spaces, quasi-projective | `k` |

`DModules.scalarExtension` uses the definition of regularity and (4) of `DModules.regularHolonomicDModule`, and no stability under an operation.

Two nodes of `plans-proof/` depend on `DModules.perverseHeart` or `DModules.intermediateExtension` and are not users of the stability, because their objects are not regular: `Whittaker.nonzeroZastava_whittakerCohomology_vanishes` and `Whittaker.pointwiseCasselmanShalika` twist by the exponential D-module. This is a defect of those two nodes that the stability theorem cannot repair (section 8, point 6).

What the table shows:

1. Maps. Every kind is used: closed and open immersions, smooth maps, proper maps, a projection that is not proper, the diagonal, and over ℂ all maps of quasi-projective schemes. No user has a map or a scheme that is not separated; every scheme in a use is quasi-projective.
2. Field. The statement plan uses the stability over `k`, over `ℚ̄` and over ℂ. Only the two de Rham nodes and the roadmap node are over ℂ alone. A field that is not algebraically closed occurs only in `plans-proof/`: `DModules.boundedEquivariantExt_baseChange` spreads the equivariant complexes and their convolution maps out to a field that is finitely generated over ℚ, so it uses the stability under the operations of convolution over such a field.
3. So the plan needs the whole theorem for separated maps, over every algebraically closed field of characteristic 0, and the plan of the proof needs it over a field that is not algebraically closed. A proof over ℂ alone does not serve `DModules.perverseHeart` and the Satake nodes.
4. In the Satake nodes the objects are equivariant for `L⁺G`, with finitely many orbits and connected stabilizers. There regularity follows from the theorem of `DModules.IsRegularHolonomic` on equivariant modules: a simple equivariant holonomic module is the intermediate extension of an equivariant connection on an orbit, and (c) of `DModules.regularHolonomicDModule` defines regularity by the simple subquotients. This is the base of option D below.

## 4. The options

**A. A roadmap node over ℂ; the passage to a field of characteristic 0 is written here.** The roadmap node states the request as it is, over ℂ. The theorem here reduces to it. Its six obligations are in `riemann-hilbert-provider-answers-4.md`: descent of a complex and its maps to a field finitely generated over ℚ; that the extension of scalars reflects regularity; the compatibility of the extension of scalars of crystals with the direct image along separated maps, along maps that are not separated, and with duality; a new order of the nodes, because `DModules.scalarExtension` depends on `DModules.IsRegularHolonomic` and, through `DModules.intermediateExtension`, on `DModules.perverseHeart`; the comparison of external products; and the passage from left modules on smooth schemes to crystals. Against it: the field comparison is then built twice. Springer §9.7 makes the comparison of regularity under field extensions a target of Tau Ceti for left modules, and this option builds a second one here for crystals on schemes of finite type, with the hardest case (maps that are not separated) used by nobody.

**B. A roadmap node over every field of characteristic 0; only the passage to crystals is written here.** The node asks for the stability in the generality of Springer Layer 9. This is more than the request states. Written here: the passage from left modules on smooth separated schemes of pure dimension to crystals on schemes of finite type and to all maps of finite type, which needs no extension of the field. No node changes its place, so no cycle arises.

**C. The theorem stays here in full.** It agrees with the decision of 2026-11-19 as written. Against it: by the rule "No gaps" Tau Ceti builds the smooth complex case anyway, for §1.5 and §5.1, and Tau Ceti cannot use code of this project. So the smooth complex case is proved twice, which "Lean code" forbids.

**D. No general stability here; the statement plan uses equivariance.** By point 4 of section 3 the Satake nodes could get regularity from equivariance. Against it: `DModules.perverseHeart` is stated for every good stratification and is used in `plans-proof/` on Zastava spaces, so its meaning would change (a weakening of a planned definition); the two de Rham nodes need the general stability over ℂ in any case; and with B the general theorem costs little here, so nothing is gained.

**E. B, and the same for holonomic complexes.** `DModules.IsHolonomic` (d) and `DModules.holonomicShriek` plan here that `!`-pullback and de Rham pushforward along every map preserve holonomic complexes. The proof in Tau Ceti of the node of B contains the smooth case of these for regular modules. E would add a second roadmap node, an extension of Springer §9.1, and reduce the two theorems here to it. No roadmap requests that node, and the two theorems are on the path to `Whittaker.vacuumPoincare`. Section 8, point 1, says why this note does not choose E.

## 5. The choice: B

1. **The smooth case belongs to Tau Ceti.** An accepted roadmap requests it by name, the rule "No gaps" obliges Tau Ceti to build it, and "Sources of code" and "Lean code" of `AGENTS.md` then exclude a copy here. This excludes C. It is a change of provider for this theorem, and it revises the decision of 2026-11-19 for it.
2. **The field of the node is the field of the section it extends.** The request says "smooth complex varieties" because the requesting roadmap works over ℂ. The supplier's Layer 9 is over every field of characteristic 0, §9.7 defines regularity over every such field, and §9.7 already makes the passage from ℂ to such a field a target for its own stabilities. A node over ℂ alone would be a special case stated before the general result, against "the natural generality" of "Lean code", and it would not serve the users over `k` (section 3, point 3).
3. **B builds the field comparison once.** In A it is built in Tau Ceti for §9.7 and again here for crystals. In B the part written here uses no extension of the field: obligations 1 to 4 of candidate A do not arise, and `DModules.scalarExtension` keeps its place.
4. **The theorem here keeps its strength.** It stays for all maps of finite type, also maps that are not separated, although no user has such a map. The reason: the operations of the plan (`DModules.deRhamPushforward`, `DModules.holonomicShriek`) and its theorems on holonomic complexes are stated for all maps of finite type, a hypothesis of separation would be one that the proof does not need, and in B the maps that are not separated cost one induction (step (d) below). So nothing is dropped or weakened, and the module doc comment of `GLCinLean.lean` needs no entry.
5. **The risk of B** is that the review of Tau Ceti accepts the node over ℂ only. Then it comes back through `prompts/change.md`, as `Infinity.derivedBimoduleTransfer` would. The choice is then between A and D for the users over `k`; the table of section 3 is the input.

## 6. The change on the branch

Commit `91a933f`. No Lean file and nothing in `GLCinLean/Statement/` changes.

**New roadmap node** `DModules.regularHolonomicDModule_directImage_inverseImage`, a theorem, in `plans/Roadmap/SpringerResolutionAndCharacteristicCycles/RegularHolonomicStability.toml`. For a field `k` of characteristic 0 and smooth separated `k`-schemes `X`, `X′` of finite type of pure dimensions, with `Dᵇ_rh` the bounded complexes of left modules with regular holonomic cohomology: (1) `f_+` carries `Dᵇ_rh(D_X)` into `Dᵇ_rh(D_X′)` for every morphism `f`; (2) `f^†` carries `Dᵇ_rh(D_X′)` into `Dᵇ_rh(D_X)`; (3) `M ⊠ N` is in `Dᵇ_rh(D_{X × X′})`. The node states the external product, which neither roadmap defines. `f_!`, `𝔻 f^† 𝔻` and the restriction to the diagonal are consequences, with the duality of (3) of `DModules.regularHolonomicDModule`. It has six checks, quotes the request, names the one part beyond the request (the field), and says that a declined node comes back. `deps`: `DModules.regularHolonomicDModule`, `DModules.holonomicDModule`, `DModules.transferModule`.

**Changed nodes.**

- `DModules.regularHolonomicDeRham`: depends on the new node; (3) and (5) name it for the stability they presuppose; the text on the order of work is removed; the node now asks for one part beyond its target, clause (6).
- `DModules.IsRegularHolonomic`: the stability theorem keeps its statement and gains the external product. Its classical input is the new node, and (3) of `DModules.regularHolonomicDModule` for duality. Written here is the passage to crystals, in steps:
  - (a) regularity is Zariski-local, and the direct image along a closed embedding of smooth schemes preserves and reflects it (the equivalence of Kashiwara, and `i_+(j_!*E) = (i ∘ j)_!*E`);
  - (b) `!`-pullback: for affine `Y`, `Z` closed in affine spaces `A`, `A′`, the graph `g` of `f` in `A × A′` and the projection `p` give `g_* f^! N ≅ g_* g^! p^! i_{Z*} N`, and `g_* g^! K` is the fibre of `K → u_* u^! K` for the open complement `u`;
  - (c) de Rham pushforward for affine `Y`, `Z`: `i_{Z*} f_* M ≅ p_* g_* M`;
  - (d) de Rham pushforward along every map: the target is affine by locality; for a cover of the source by two opens, the triangle `M → u_* u^! M ⊕ v_* v^! M → w_* w^! M`; induction on the number of affine opens, first for a separated source (the intersections are affine), then for every source (the intersection of an affine open with the rest is open in an affine scheme, so it is separated). This treats the maps that are not separated;
  - (e) duality, by the route of the theorem of `DModules.verdierDuality` on holonomic complexes;
  - (f) `f_! = 𝔻 f_* 𝔻` and `f^* = 𝔻 f^! 𝔻`;
  - (g) the external product, through the comparison of the external product of right crystals with that of left D-modules, and `M ⊗^! N = Δ^!(M ⊠ N)`.
  New `deps`: the new node, `DModules.holonomicIntermediateExtension`, `DModules.transferModule`, `DModules.leftCrystalsEquivRightCrystals`. The curve criterion keeps its statement; one sentence says that its direction from `M` to `c^!M` is a case of the stability.
- `DModules.analyticDeRham_isEquivalence`: the comparison of the two external products was a proof obligation of step (f) of this node. It moves to `DModules.IsRegularHolonomic`, which is below this node and needs it for step (g). The node loses the dependency `DModules.leftCrystalsEquivRightCrystals`, which only that obligation used.
- Small changes: the lists of users in `DModules.regularHolonomicDModule`, `DModules.holonomicDModule`, `DModules.holonomicIntermediateExtension` and `DModules.transferModule`.

**`docs/blueprint-providers.md`**: the row of SpringerResolutionAndCharacteristicCycles (6 nodes, with the new node as a prerequisite and the rule for a declined node), the notes "The Riemann–Hilbert correspondence" and "Inputs", and "Limits of existing providers".

**Checks run.** `lake exe tracker lint`: no errors. `python3 tools/check-module-cycles.py`: 200 module plans, 313 nodes, 0 cycles. `python3 tools/check-upstream-names.py`: 359 pairs, 0 not confirmed.

## 7. What the session does when the change is agreed

- "Held": the row of `DModules.regularHolonomicDeRham` and of the stability theorem of `DModules.IsRegularHolonomic` is removed. The tracker then orders the work: both nodes depend on the new roadmap node.
- "Open items": "The provider and the route of the stability of regular holonomic complexes" is removed. In "Theorems on holonomic and regular holonomic complexes that no accepted roadmap states", the six operations for regular complexes are decided; the three theorems on holonomic complexes and the curve criterion stay.
- "Decisions taken": a new entry, which revises the decision of 2026-11-19 for this theorem.
- The author worker of SpringerResolutionAndCharacteristicCycles gets the new node as a target once its three dependencies are in Tau Ceti.

## 8. Points that stay open, and points where the planner is unsure

1. **The same question for holonomic complexes (option E).** A proof of the new node in Tau Ceti shows, for regular modules on smooth schemes, that `f_+` and `f^†` give holonomic complexes. The usual proofs show this for all holonomic modules first. So when the work reaches the theorems of `DModules.IsHolonomic` (d) and `DModules.holonomicShriek`, their smooth case may already be in Tau Ceti, and writing it here would be a copy. This note does not move them, for three reasons: no roadmap requests the holonomic case, so "Sources of code" gives no rule that sends it to Tau Ceti; the two nodes are not held and are not reached; and they are on the path to `Whittaker.vacuumPoincare`, so the move has its own cost. The new node says that it does not ask for the holonomic case. Recommendation: decide it with its own change before either theorem is written, and before the Worker takes the new node; the open item "Theorems on holonomic and regular holonomic complexes that no accepted roadmap states" already names the question.
2. **Whether Tau Ceti accepts the node over every field of characteristic 0.** Section 5, point 5.
3. **The stability under the external product has no compared source.** [HottaTakeuchiTanisaki] Theorem 6.1.5 covers duality and the direct and inverse images. Clause (3) of the new node rests on the request of the roadmap. It is not a formal consequence of (1) and (2).
4. **The converse of the curve criterion** (regular on all curves implies regular) has no route in the plan and no user. This change does not decide it. A route from the stability exists (induction on the dimension of the support), but it uses that a holonomic module is a connection on a dense open of its support, which no clause of `DModules.holonomicDModule` states.
5. **The id of the new node** is a label of the plan until the declaration exists upstream; it spells the two main conclusions and not the external product.
6. **Suspicion about nearby nodes, not part of this change.** `DModules.perverseHeart` is defined on regular holonomic complexes only. Two nodes of `plans-proof/` use it or `DModules.intermediateExtension` with the exponential D-module, which is not regular: `Whittaker.nonzeroZastava_whittakerCohomology_vanishes` and `Whittaker.pointwiseCasselmanShalika`.
7. **Step 2 of `prompts/change.md` also asks for a check with `prompts/check.md`.** This note does not contain one; the session starts the checker.
