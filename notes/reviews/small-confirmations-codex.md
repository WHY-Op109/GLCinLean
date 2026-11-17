# Assessment of the two pending confirmations

Reviewed on 2026-11-17 at `91b6cb092d70532b5e9d8d8fcf12bbc55f961d65`.
Scope: the two decisions in the request, not a new audit of the whole statement.
Only this note is changed. Recommendations below are not implemented.

**Verdicts.**

1. **Agree with good stratifications for the fixed-stratification duality, perverse and Riemann–Hilbert package.** The condition has the right mathematical content. Make the derived functor and coefficient dependence explicit, and keep goodness off constructions that do not need it. The phrase “the constructible category … is false for an arbitrary stratification” needs correction.
2. **Agree that the two instances should leave `Setting`; recommend the record refactor after approval, without waiting for placeholder replacement.** Keep both assumptions on the main theorem. Preserve the existing opaque contracts during that narrow refactor; minimize their assumptions separately when their actual mathematical definitions are reviewed. Absence of an opaque body is not evidence that its intended object exists in arbitrary characteristic.

The standard used here is `AGENTS.md`, especially “Lean code” and “The statement”. It agrees with Mathlib's [weak-hypotheses and strong-conclusions principles](https://mathlib.org/contribute/values.html): generalize the objects and results where the mathematics supports it, without changing the intended conjecture.

## 1. Good stratifications

### What is being assumed

The current condition is in `plans/GLCinLean/AlgebraicGeometry/Constructible/Complex.toml:6`; its users are at line 13 and `DModules/RiemannHilbert.toml:6`. The corresponding D-module condition is at `DModules/Perverse.toml:6`.

Fix a separated complex scheme of finite type, a **finite algebraic stratification with the frontier condition by smooth connected locally closed strata**, and a coefficient field `E`. For the inclusion `j_T : T → Y`, the precise condition should be

\[
  \operatorname{Good}_E(S)
  \quad\Longleftrightarrow\quad
  \forall T\in S\;\forall L\in\operatorname{LocSys}_{\mathrm{fd}}(T,E),
  \quad Rj_{T*}L\in D^b_S(Y,E).
\]

Here membership means bounded cohomology, locally constant of finite rank on every stratum. The `R` matters: ordinary degree-zero direct image alone would not control higher link cohomology. Quantification is over **all** finite-rank local systems, not only constant or equivariant ones.

The plan's extra requirement on `j_{T!}L` is redundant for sheaves: extension by zero is exact, with stalks `L` on `T` and zero elsewhere. It is equivalent to the displayed definition, but should be a theorem rather than a second field of a future predicate. This observation concerns constructible sheaves; it does not say that extension by zero is exact for the perverse t-structure or for the usual D-module heart.

Goodness should be relative to `E`. Requiring it simultaneously for every field would impose more than a theorem about a single coefficient field uses. Whitney and orbit stratifications can then be proved good for every `E`; Riemann–Hilbert uses `E = ℂ`. No claim that goodness is independent of coefficients is needed.

### Why this is the right strength

There is a useful necessity-and-sufficiency test, not just a proof that Whitney stratifications suffice. In this finite, smooth-stratum setting,

\[
  \operatorname{Good}_E(S)
  \quad\Longleftrightarrow\quad
  \mathbb D_Y\bigl(D^b_S(Y,E)\bigr)\subseteq D^b_S(Y,E).
\]

Here is the argument. Every object of `D^b_S` is built by finitely many triangles from shifts of `j_{T!}L`: use the open–closed localization triangles and ordinary cohomological truncations on each stratum. On a smooth complex stratum of dimension `d`,

\[
  \mathbb D_Y(j_{T!}L)\simeq Rj_{T*}(L^\vee)[2d].
\]

Goodness therefore gives stability under duality. Conversely, if duality preserves `D^b_S`, apply it to `j_{T!}(L^\vee)` and remove the shift. This proves the displayed equivalence. It also explains why finite-rank local systems, rather than just one chosen IC sheaf, are the natural test objects.

The same condition gives the restrictions and extensions needed for recollement on unions of strata: `j^*` preserves constructibility, `j^! = 𝔻 j^* 𝔻`, and the extension functors are controlled by the generators above. Gluing the shifted standard t-structures on the strata gives the usual middle-perverse t-structure and intermediate extensions. Regular Riemann–Hilbert can then be restricted to the compatible subcategories, with the perverse structure and duality intact.

Thus goodness is **necessary for the full package that includes Verdier duality**, and sufficient for the fixed-stratification recollement and perverse theory. It is not justified to call it the weakest hypothesis for every isolated operation or for the existence of some abstract t-structure. In particular:

- `D^b_S` itself exists as a full triangulated subcategory for arbitrary such `S`; goodness is not part of its definition. Ordinary truncations also preserve it.
- The ambient `D^b_c`, constructible for some algebraic stratification, and the ambient regular Riemann–Hilbert correspondence do not require a specified good `S`.
- A pullback `f^*` preserves fixed-stratification constructibility when every source stratum maps into a target stratum. This does not require goodness or local triviality.

The current `DerivedCategory` node already makes the first two categories available in this generality. `STATUS.md:78` overstates what failed; the original review itself makes the distinction in `notes/reviews/82c8619.md`, part B, point 1.

### The counterexample and the intended examples

The umbrella really excludes arbitrary stratifications. For `X = {x² = y²z}`, let `A` be the axis and `U = X − A`. The normalization

\[
  \nu:\mathbb C^2\longrightarrow X,\qquad (y,t)\longmapsto(yt,y,t^2)
\]

is finite and an isomorphism over `U`. Near a nonzero point of `A`, the complement of `A` has two local components; at the origin it has one. Consequently `H⁰(Rj_*E_U)` has stalk ranks two and one along the same stratum `A`: this directly violates goodness. The finite normalization is small, so `IC_X = ν_*E[2]` has the same rank change. In the localization triangle for the constant sheaf, the map from its rank-one stalk to these stalks is respectively diagonal and an isomorphism; hence `H¹(i^!E_X)` has ranks one and zero. This independently checks the obstruction used in the earlier reviews.

Whitney stratifications supply local stratified triviality and finite local topology, giving the required local-system extensions. For an algebraic group with finitely many orbits, the Whitney conditions hold on a dense open subset of each smaller orbit; invariance and transitivity make them hold on the whole orbit. Connectedness of the group ensures connected orbits. For a disconnected group one can instead pass to connected orbit components; connectedness is a convenient hypothesis for the example, not a further condition in `Good_E`.

For finite Schubert unions, the finite-dimensional quotient actions reduce the assertion to these orbit examples. [MV] §2 explicitly records the finite-dimensional quotient action, describes the spherical and Iwahori orbits, and introduces its perverse category with a Whitney stratification; see [Mirković–Vilonen](https://arxiv.org/abs/math/0401222). Goodness of these actual examples must be **proved**, not added as an assumption on `Setting` or on the Langlands theorem. This is a genuine nontrivial use of the proposed predicate, as `AGENTS.md` requires, and does not restrict the fields or groups in the conjecture.

### Keep the condition on maps separate

Good source and target stratifications do not make all pushforwards preserve them. The parabola example in the plan is correct: the proper projection `ℙ¹ × 𝔸¹ → 𝔸¹` sends the sheaf on `{x² = y}` to stalk ranks two away from zero and one at zero, although the total projection is a product.

For the planned **proper** pushforwards, local trivializations must preserve the source strata. Proper base change then reduces the claim to a product over a small contractible neighborhood in a target stratum. This is sufficient and holds for the equivariant orbit maps used here. It is not asserted to be a necessary condition for every individual pushforward.

The current distinction from [Juteau–Mautner–Williamson](https://arxiv.org/abs/0906.2994), §2.4, is accurate: their definition asks for submersions on the individual strata. It does not itself state the product trivializations now required by the plan. Goodness, the condition on maps, and properness have separate jobs; none should substitute for another.

### Exact recommendation

Confirm the correction to decision 1 of 2026-11-13, with these clarifications:

1. In `Constructible/Complex.toml:6`, replace the defining sentence by: “For a finite algebraic stratification S with the frontier condition by smooth connected locally closed strata, S is good with coefficients E if, for every stratum inclusion j_T and every finite-rank E-local system L on T(C), Rj_{T*}L belongs to D^b_S(Y,E). Extension by zero j_{T!}L always belongs to D^b_S. Goodness is equivalent to preservation of D^b_S by Verdier duality.” Keep the Whitney, orbit and Schubert examples as proof obligations.
2. At line 13 use “good with coefficients E”. In `DModules/RiemannHilbert.toml:6` use “good with coefficients ℂ”. Keep the D-module formulation compatible with this one under regular Riemann–Hilbert; do not introduce two unrelated meanings of goodness over ℂ.
3. Keep the definitions of `D^b_c` and `D^b_S` unrestricted. State the ambient regular Riemann–Hilbert equivalence first and its good-stratification restriction next. Interpret the target of `analyticDeRham` at `Complex.toml:20` as the ambient category first. State `f^*` under the weaker stratum-preservation condition, and retain the stronger condition for the proper pushforward claim. Make `RiemannHilbert.toml` refer explicitly to those map conditions rather than leaving “respect the stratifications” ambiguous.
4. Replace the explanation at `STATUS.md:78` by: “For arbitrary stratifications the fixed-stratification category exists, but the claimed duality, perverse and intermediate-extension package need not preserve it. These results are stated for good stratifications, which include the Schubert cases.” Amend the “any stratification” wording at line 124 accordingly.

These are corrections to the scope of auxiliary mathematics, not a weakening of [GLC1]. In particular, imposing Whitney regularity as the definition of goodness would be unnecessarily restrictive; the cohomological condition above expresses exactly the closure needed here.

## 2. The unused instances of `Setting`

### What the record actually says

`GLCinLean/Statement/Conjecture.lean:50–70` records a smooth proper connected curve, a pinned reductive group, a chosen square root of the canonical bundle, and a chosen dual group with root-datum identification. It does not construct those choices or assert that they exist for every input.

Neither field property is required to express these data. This is also visible in the pinned upstream signatures:

- `ReductiveCommHopfAlgCat` needs a field (`TauCeti/Algebra/AlgebraicGroup/Reductive/Basic.lean:169`).
- `Pinning` is defined over a commutative ring with the indicated group and base hypotheses (`Pinning/Basic.lean:88`); the present field supplies the connected base.
- `Scheme.relativeDifferentials` is defined over a commutative ring (`Modules/Differentials/Basic.lean:67,85`), and tensor product of invertible sheaves needs no field hypotheses (`LineBundle/TensorProduct.lean:63`).
- The remaining placeholder `RootDatumDuality` already has only `[Field k]` (`Conjecture.lean:44–45`).

In particular, choosing a theta characteristic is different from proving that every curve admits one. Algebraic closedness can belong to the latter theorem without belonging to the type of chosen data. Likewise, carrying a split pinning is different from constructing one for an arbitrary reductive group.

### Where the assumptions belong

**The main theorem must retain both** `[CharZero k]` and `[IsAlgClosed k]`, with the same existential and universal quantifiers over functors and the same two characterizing properties. [GLC1] §0.1.1 explicitly works in characteristic zero; Cor. 1.6.5 and Conj. 1.6.7 give the target assertion. Algebraic closedness is the project's approved scope, as the current module documentation explains, and is explicit in [GLC2] §0.4.1. This review is not permission to enlarge or narrow that scope. See [GLC1](https://arxiv.org/html/2405.03599v3) and the locally checked TeX of both papers.

For actual library constructions, put assumptions at the first definition or theorem whose mathematics needs them, and let dependencies carry them onward. Characteristic-zero D-module and derived de Rham results must retain their required characteristic hypothesis. Algebraic closedness belongs, for example, on the planned general theta-characteristic existence theorem and on arguments obtaining rational points or passing from connectedness to geometric connectedness. It does not belong on the record merely because those arguments will later consume the record. Nor should it automatically be copied onto every D-module construction.

There is a distinction between a visibly redundant parameter of this concrete record and the scope of a still-opaque mathematical construction. A placeholder's missing body cannot establish that its intended D-module category works over every field. Thus a narrow `Setting` refactor should not silently generalize all its opaque users at the same time.

### Now or later, and the exact change

**After approval, do the record refactor now.** Waiting for `RootDatumDuality` to be replaced supplies no missing justification: its present interface already works over a field, and the other fields are inspectable. The mathematical data over the currently permitted fields remain identical. This change does not fill any placeholder or establish nonemptiness of `Setting`.

The exact conservative refactor is:

1. Change line 50 to `@[placeholder] structure Setting (k : Type u) [Field k] where`, leaving every field unchanged. Do not move the two properties into new record fields or a redundant wrapper.
2. Preserve the existing domains of the eight opaque declarations `QCohLS`, `DmodHalf`, `IndCohNilp`, `Psi`, `RepRan`, `Loc`, `heckeActionRight`, and `vacuumPoincare`. One explicit implementation is to leave only `{k} [Field k]` in the section at line 74 and give each of those opaque declarations its current `[CharZero k] [IsAlgClosed k]` binders directly. Reintroduce those section instances before `IsLanglandsFunctor` and the theorems. This is preservation of existing placeholder contracts, **not a finding that both assumptions are mathematically minimal for all eight objects**.
3. Check the elaborated main theorem: it must still quantify over fields with both instances, then every `S : Setting k`, and have exactly the present conclusion. Keep its scope explicit in the source/documentation even when dependencies also force those instances.
4. When each opaque construction is replaced or separately reviewed for generality, remove its unnecessary assumptions on mathematical grounds. That review need not wait for all placeholders to be replaced. Retain only those actually required by its construction or dependencies. This is the deferred part of decision 5; it is not a reason to defer the concrete record cleanup.
5. Update the open item and decision 5 in `STATUS.md` to distinguish the immediate record refactor from the later per-construction audit. The approved follow-up must receive the required fresh review and statement checks. Until approval, the repository's `proposal/<topic>` rule applies; this note requests no implementation.

I checked the refactor through Lean's standard input using the existing compiled dependencies, without writing a Lean file or build output. Merely deleting the two binders from `Setting` makes `QCohLS` lose both assumptions, while the main theorem retains them through section-variable inclusion and `isLanglandsFunctor_iff` gains an unused-section-variable warning. The explicit contract-preserving version above elaborates with only the existing main-theorem `sorry` warning. This is evidence that the narrow refactor is feasible now; it is not a substitute for the required full build, lint and statement-axiom check when an approved change is made.

## Evidence and limits

I read the three named reviews and the current plan and Lean declarations, rather than treating the earlier “agree” verdicts as authority. The mathematical argument for goodness above is an independent generator-and-duality argument. I checked [MV] §2, [JuteauMautnerWilliamson] §2.4, and the relevant [GLC1]/[GLC2] passages in their local TeX. I have not newly verified a precise [BBD] or [HottaTakeuchiTanisaki] locator, so this note does not certify the earlier reviews' attribution of the goodness condition to a particular subsection of those books.

The required read-only Tau Ceti version check found no `v4.36.0` release tag and found `main` still on `leanprover/lean4:v4.36.0-rc2`. No pins, plans, statement files, status records or Git history were changed, and no project build was run for this note-only task.
