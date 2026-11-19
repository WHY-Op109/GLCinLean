# Second check of `proposal/dmodules-smooth-schemes` at `299a2d0` (against `54a0e9f`)

**Result.** B1, B2 and B3 are resolved, and the four *unsure* points are resolved or reduced to marked readings. Two small *mismatches* remain: each is a claim or a proof input whose owner is not below its user, and each is fixed by one sentence and one dependency. I changed no file. I reran the tracker lint (0 errors), the cycle check (192 module plans, 308 nodes, 0 cycles) and the upstream name check (252 pairs, 0 unconfirmed). I did not rerun `lake build` or `lake lint`.

"D/" is `plans/GLCinLean/AlgebraicGeometry/DModules/`.

## Mismatches

**M1. The proof of `DModules.IsHolonomic` (d) needs a fact that is stated above it.** D/`Holonomic.toml:6–7`. Clause (d) says that !-pullback along every map preserves the holonomic complexes.
- For a closed immersion i with open complement j, the proof is the triangle i_* i^! M → M → j_* j^! M. It needs that j_* preserves holonomic complexes.
- The plan states this fact only in D/`HolonomicShriek.toml:6` ("de Rham pushforward along a locally closed immersion … by DModules.holonomicDModule (6) and the comparison of DModules.deRhamPushforward").
- `DModules.holonomicShriek` depends on `DModules.IsHolonomic`, and `DModules.deRhamPushforward` is not below `DModules.IsHolonomic`. This is a cycle of meaning, of the kind of Codex's objection 6.
- Replacement: after "preserves the holonomic complexes." in (d), add "For a closed immersion i with open complement j, the proof uses the triangle i_* i^! M → M → j_* j^! M and that j_* sends a holonomic complex to a holonomic complex; on smooth separated schemes of pure dimension this is DModules.holonomicDModule (6), through the comparison of DModules.deRhamPushforward."
- Add `'GLCinLean.DModules.deRhamPushforward'` to `deps`. I checked that this makes no tracker cycle: `DModules.IsHolonomic` is not below `DModules.deRhamPushforward`.

**M2. No node owns the k-linear structure on the classical side (Codex 4(c)).** D/`DirectImage.toml:6` claims as a theorem that the transfer functor "is k-linear". No node says for which k-linear structure on Dmod^r_qc(X), nor that the equivalence of `DModules.rightCrystals_equiv_dModules` is k-linear. The proposal, line 197, says that both nodes "state what they need of these as their own work"; `DModules.rightCrystals_equiv_dModules` does not state it.
- Replacement in D/`DifferentialOperators.toml:6`, after "with the t-structure of that node.": "Dmod^r_qc(X) is k-linear (Infinity.linearCategory): complexes of k-vector spaces act on the complexes of sheaves of right D_X-modules by the tensor product over k, which preserves quasi-isomorphisms in each variable and so passes to the localization. The equivalence of this node is k-linear. This structure and this statement are part of the node."
- Replacement in D/`DirectImage.toml:6`: "and is k-linear" becomes "and is k-linear for the structure of DModules.rightCrystals_equiv_dModules".
- `Infinity.linearCategory` is already below `DModules.rightCrystals_equiv_dModules`, so no new dependency is needed.

## Item 1: B1, B2, B3 and the four unsure points

- **B1: *match*.** D/`Holonomic.toml:6` (d) states the theorem; D/`Verdier.toml:6` states the stability under duality; section 5 names the three owners. M1 is a new point on its dependencies.
- **B2: *match*.** The pullback clause is restricted to bounded cohomology on one side and to quasi-coherent cohomology on the other. `TransferModules.toml:6` (2) names the bounded domain and gives the reason.
- **B3: *match*.** I recounted every figure of section 5: 308 nodes, 192 module plans, 222 written here (31 of the statement), 86 roadmap nodes in 14 areas, 221 of 222 with a roadmap node below, 195 nodes in 74 module plans of `plans-proof/`, 28 placeholders, 16 ready roadmap modules.
- **Unsure 1 (two forms of regular): *match*.** The curve criterion is a theorem of the node; see item 4.
- **Unsure 2 (chapter numbers): *match*.** I read the book's table of contents: Chapter 1 has the direct and inverse images and Kashiwara's equivalence (1.3–1.6), Chapter 2 good filtrations, characteristic varieties and duality (2.1–2.2, 2.6), Chapter 3 holonomic modules, finiteness and minimal extensions (3.1–3.4), Chapter 6 regular holonomic modules, §7.1 the de Rham functors. Every chapter in the `source` fields is right.
- **Unsure 3 (`DModules.holonomicDModule` (6)): unchanged, still a marked reading.** Acceptable.
- **Unsure 4 (bimodule contract): reduced, still *unsure* in one place.** `DerivedBimodules.toml:6` says clause (2) "is the direct image of the named target `enhancedPushforward`". E1.4 (README line 611) states it as one half of an adjunction with `Lf^∗K = S ⊗ᴸ_{f⁻¹R} f⁻¹K`, and line 508 says "Additive comparisons allow noncommutative O". That the target covers ring sheaves that are not commutative is a reading. The sentence "If the review of Tau Ceti declines (1), (3) or (4)" could also name (2) for such rings. It can wait.

## Item 2: nodes changed outside the eight

- **`DModules.exponential`: *match*.** Same object. The new clause is true: the module is coherent over O, and an object of heart[−1] is a holonomic complex in the sense of (b).
- **`Whittaker.vacuumPoincare`: *match*.** Same object. [GLC1] §1.3.7 (`functor.tex` line 1653) says "The functor 𝔭_! is well-defined on χ^*(exp), since the latter is holonomic". The reason given is supplied: `DModules.starPullback` states holonomic values, for stacks by smooth descent, and both inputs of D f^! D are now below it. The sentence does not need χ smooth, which is right: for a torus χ is the zero map from a point.
- **`Infinity.derivedVect`, `Sheaves.schemeQCoh`: *match*.** Each phrase is true (vector spaces and `SheafOfModules O_X` are Grothendieck abelian). The new dependency adds `Infinity.tStructure` and `Infinity.homotopyCategoryPretriangulated` below `Infinity.derivedVect`. This is right, because its text already names the standard t-structure.
- **`DModules.indHolonomicShriek` (`plans-proof/…/IndHolonomic.toml:13`): *match* for the law, *unsure* in one place.** The corrected law is true, and the old unrestricted one was false (Codex's example is correct). No node defines the *-pullback along a map of indschemes; `DModules.starPullback` covers schemes and stacks of finite type. Optional wording: "against the *-pullback, where it is defined on ind-holonomic objects". It can wait.

## Item 3: the five disagreements with Codex

- **Codex 1, the two nodes of `plans-proof/`: the planner is right.** "diagonal !-base change" in `SemiInfinite.parabolicIC_koszulBoundary` and `SemiInfinite.parabolicVacuumShriek` names squares of particular objects, with their own proof hints. Neither is shown false, so `wrong` does not apply. Their former supplier no longer gives the law, and the open item records exactly that. `AGENTS.md` ("Leave the other nodes until the work reaches them") allows the wait.
- **Codex 3, the shift by components: the planner is right.** No clause of `DModules.rightCrystals_equiv_dModules` has a shift on a scheme that is not of pure dimension. The equivalence is from right crystals to right modules, and the side change and the pullback clause are stated for pure dimension only.
- **Codex 4(b), internal Hom and associativity: the planner is right.** `DModules.transferModule` (5) and (6) are named targets of Springer §9.1, so the plan has a supplier for them. What Tau Ceti needs to build them is a dependency between two roadmaps, like F2.2. The node, the provider row and an open item record it as a condition of readiness. No node written here uses these operations.
- **Codex 4(c), k-linearity: right in part.** The planner is right that the two enhanced roadmap nodes need no k-linear structure, because EnhancedDerivedSheaves states none. With the category defined as a localization and the functors given on K-flat and K-injective complexes, the structure can be built here. One claim is left without an owner: M2.
- **Codex 8, strong equivariance: the planner is right.** The theorem has an owner (`DModules.IsRegularHolonomic`). The sentence on its classical input is true (README line 1127: "the component-group classification of strongly equivariant connections on an orbit"), and the open item names what is to be decided. The sentence is older than this change and no node of this change uses it.

## Item 4: the curve criterion

**The numbers are right: *match*.** I read a copy of the English edition from the address in Codex's report; it is not in `references/`.
- Definition 6.1.1 (p. 161): a holonomic module is regular if "any composition factor of M is isomorphic to the minimal extension L(Y, N) of some regular integrable connection N on a locally closed smooth subvariety Y of X such that the inclusion Y → X is affine".
- Theorem 6.1.6 "(Curve testing criterion)" (p. 162): for a bounded holonomic complex on a smooth algebraic variety, regularity is equivalent to "i_C^† M ∈ D^b_rh(D_C) for any locally closed embedding i_C : C → X of a smooth algebraic curve C", and to the same for every morphism from a smooth curve.
- Theorem 6.1.5 is the stability under 𝔻, the two direct images and the two inverse images.
- The book works over the complex numbers and says that almost all arguments hold over an algebraically closed field of characteristic 0.

The criterion of D/`RegularHolonomic.toml:6` is right as stated. c^! corresponds to i_C^† with no shift. The step to a singular Y of finite type is sound: a curve in a smooth ambient chart either lies in Y or meets it in finitely many points, where every module is regular. The hypothesis of an algebraically closed field is the right one, and the node proves the step from the complex numbers here.

Optional rewording, since "the numbers are not checked" is no longer true for these two: `docs/papers.md:59` "no number is checked against the book" becomes "Definition 6.1.1, Theorem 6.1.6 and the chapter contents were compared with the English edition on 2026-11-19; the book is not in `references/`". The same row still omits Chapter 4, which three `Constructible` nodes cite.

## Item 5: the merge of `docs/blueprint-providers.md`

***Match.*** I compared the merge commit `a4e4857` and the head line by line with `54a0e9f` and `4aa51ad`.
- Snapshot rows: both kept (FormalConnectionsOpers; the D-module nodes).
- Upstream declaration rows: every new row of either side is present.
- The paragraph "These are accepted roadmaps": the two sentences of `main` on the loop groups are kept. The sentence of `main` with "no `IsDifferentialOperator`" and its sentence "#43231 … is the first code toward C5.1" are replaced by the corrected sentences of the branch, as intended.
- The only lines of `main` that are missing are those the branch replaces on purpose (the EnhancedDerivedSheaves row with 24, the Springer row of "Accepted roadmaps that cover nodes written here", the old row of #43231). No line longer than 40 characters occurs twice.

## Other points

- **`GLCinLean.lean` entry: *match*.** [DG2], the introduction of §5: "this material is well-known at the level of triangulated categories", and "all DG schemes … are assumed locally almost of finite type". No line exceeds 100 characters; only the comment changed.
- **D/`DifferentialOperators.toml:6`: *match*.** [Crystals] §4.2.2 is the definition of the right t-structure and Proposition 4.2.5 the t-exactness of the closed pushforward (counted in the TeX). The argument that Ψ_X is an equivalence for a smooth X is correct.
- **`EnhancedDerived.toml`, `DerivedBimodules.toml`: *match*.** The new quotes are at README lines 508, 553, 561 and 611; the four clauses are true at a point and for the identity.
- **D/`Perverse.toml:17`: *match* for the statement, *unsure* for the route.** The comparison is true. The route "The proof uses (2) of that node" needs that the object has no boundary subobject or quotient among all holonomic modules on X, and the object is built in the smaller heart of lisse regular modules. A second route is direct: i_* is t-exact and fully faithful, so it carries the image of H⁰j_! → H⁰j_* to that of H⁰(i∘j)_! → H⁰(i∘j)_*. No change is required.
- **Limits: *match*.** `DModules.perverseHeart`, `DModules.analyticDeRham`, `DModules.analyticDeRham_isEquivalence`, the `Constructible.*` nodes, the held nodes, `STATUS.md` and `tools/` are unchanged against `54a0e9f`.
- **Worker entry: *match*.** 1,323 plain characters; one target; both examples are true as stated.

The copy of the book is at `/Users/why/.claude/projects/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/tool-results/webfetch-1795096921345-v2bvcr.pdf`, with its text at `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/htt/htt.txt`.

