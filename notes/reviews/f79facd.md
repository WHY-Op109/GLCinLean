# Review of the plan changes in `f79facd`

Commit reviewed: `f79facd` ("plans: the owner's decisions on the example, the crystals node, theta existence and the Hecke pushforward"). Only TOML under `plans/` changed, so each node's `desc`, `deps` and `source` is compared with the papers' TeX; the blind-reading step of `prompts/review.md` does not apply. Paper line numbers refer to the TeX files named in `docs/papers.md`. No *mismatch* in the mathematics of a statement was found. The open points are gaps in `deps`, one gap in the example's hack-answer test, and one unspecified step in the twisted Hecke pushforward.

## Points for the owner (all *unsure* or gaps; none is a wrong statement)

1. **Example: a wrong Ran space passes the test (*unsure*).** `Examples.trivialGroup_isLanglandsFunctor_id` (`plans/GLCinLean/GeometricLanglands/Examples/Point.toml` line 13) compares `Loc`, the action and `Rep(1)_Ran` with objects built on the same `Hecke.ranSpace`. If the Ran space were degenerate (the point, or `X` with only one-point subsets), every listed identification would still hold: `Loc(V) ≃ p_!V`, `V ⋆ M ≃ p_!V ⊗ M`, and `Loc(δ_x) ≃ k` for a one-point sheaf. Then the identity functor would still satisfy `IsLanglandsFunctor`. A cheap extra check catches both errors: for distinct k-points `x ≠ y` of `X`, the sheaves `δ_x` and `δ_y` are orthogonal in `Rep(1)_Ran`, and the sheaf at the two-point subset `{x, y}` exists and has `Loc = k`. This needs no Ran contractibility.
2. **Example: the trivial-group `Setting` is not planned (gap).** The theorem needs a `Statement.Setting` whose group is the trivial group. Tau Ceti at the pin has no pinned trivial group, so `k` as a reductive Hopf algebra and its rank-0 `TauCeti.Pinning` must be built. The field `dualIdentification : RootDatumDuality G dualGroup` is an `opaque` placeholder of type `Type u` (`GLCinLean/Statement/Conjecture.lean` lines 42–43). So no term of it can be built until it is replaced through `Groups.dualityData`. The example's `deps` (line 14) name neither this construction nor `Groups.dualityData`. Also, "any curve and theta characteristic" is non-vacuous only when one exists. A dependency on `Examples.nonemptySetting` or `Curves.thetaCharacteristic_exists` (with its projective-line example) would record this. Apart from this, the `Setting` structure admits the trivial group: reductivity, a rank-0 split torus, the Borel equal to the whole group and an empty family of simple roots are all available in principle.
3. **Twisted pushforward in `Hecke.sphericalAction` (*unsure*).** `DModules.pseudoProperShriek` (`Prestacks/PseudoProper.toml` line 13) is defined only for untwisted D-modules. The action pushes forward `h^*det^{1/2}`-twisted objects along the projection `h` (the gerbe pulled back from `Bun_G`). `Hecke/Action.toml` line 13 says "use the twisted form of this pushforward through the trivialization of the pulled-back gerbe", but it does not say which trivialization. The only global one is the pullback of the theta-characteristic trivialization ([GLC1] §1.1.2, `functor.tex` 1332–1336, and (e:untwist) at 1404–1407; node `Automorphic.halfTwisted_equiv_untwisted`). That node is not in the `deps`. This choice works: changing the trivialization changes the result only by a rank-one local system pulled back from `Bun_G`, and the projection formula handles that. But it sits uneasily with `Satake.criticalTwist_matchesBunDeterminant`, which says "No untwisting by the theta characteristic is applied on the Hecke side". There are two possible fixes. One is to name the trivialization and add the dependency. The other is to plan a twisted pseudo-proper pushforward, built test scheme by test scheme from étale-local trivializations, with `DModules.twistedCrystals` as a dependency.
4. **Crystal descent was dropped (gap, introduced by this commit).** The old `desc` of `DModules.rightCrystals` said "descent and smooth-scheme D-module comparison". The new `desc` (`DModules/Crystals.toml` line 6) moves the comparison to `rightCrystals_equiv_dModules`, but no node now carries fppf or smooth descent for crystals ([Crystals] Prop. 3.2.2, `Crystalstext.tex` 1902). Two nodes still use it: `DModules.coherent` ("smooth-local descent to algebraic stacks") and the induction node in `DModules/CompactGeneration.toml` ("smooth descent"). The new `crystals_descent_of_classicallyFormallySmooth` is a different descent, along `Y → Y_dR`, and does not replace it.
5. **`Hecke.correspondence_pseudoProper` and the de Rham Ran space (*unsure*, wording).** `Hecke.correspondence` is built over `Hecke.ranSpace`, the de Rham Ran space, whose S-points need only `(S^cl)_red → X`. The proof in `Hecke/Correspondence.toml` line 13 ("over X^I … assembled over I with the presentation of Hecke.ranPseudoProper") presents `colim_I Hecke_{X^I}`, not the de Rham Hecke stack, as a colimit of proper schemes. The two stacks have the same de Rham prestack, so they have the same D-modules and the same `f_!`. The claim is true in either of two readings: pseudo-properness of `colim_I Hecke_{X^I} → Bun_G`, used through that identification, or literal pseudo-properness through the Čech nerves of `X^I → (X^I)_dR` ([Crystals] Lemma 1.2.4). The `desc` should say which map is shown pseudo-proper, as `Hecke.ranPseudoProper` does for Ran. Mathematically the projection is pseudo-proper: base change by `S → Bun_G` gives the `P_1`-twisted Beilinson–Drinfeld Grassmannian, which is ind-proper over `S × X^I`, and `X^I` is proper. This matches the pull-push of [GaitsgoryOutline] §§4.2.3 and 4.4.2 (`outline.tex` 2924–2927, 3001–3029).
6. **`Sheaves.upsilon_isEquivalence_of_smooth`: the duality clause has no input (gap).** `Sheaves/IndCoh.toml` line 48 also claims "Υ_S is the dual of Ψ_S under the self-dualities of QCoh(S) and IndCoh(S)". This needs Serre self-duality of `IndCoh(S)` ([IndCoh] Thm. 9.1.4, `IndCohtext.tex` 6829). No node plans it, and the `deps` (line 49) have only the generic `Infinity.dualizableCategory`. The equivalence itself needs no duality on a smooth `S`: `Ψ_S` is a `QCoh`-linear equivalence ([IndCoh] Lemma 1.1.6, 1034–1036), `Ψ_S(ω_S) ≅ Ω^n_S[n]` comes from the smooth comparison in `indcohShriekOnSchemes`, and so `Υ_S = Ψ_S^{-1}(− ⊗ Ω^n_S[n])`. Either drop the duality clause or add a Serre-duality node.
7. **Theta existence: three missing inputs and an unused hypothesis (gap).** `Curves/ThetaExistence.toml` line 6. The sketch is correct (see below), but it uses three facts that no dependency supplies. (a) Degree as a homomorphism `Pic X → ℤ` with `deg 𝒪(x) = 1`, which gives a line bundle of degree `g − 1` and `deg(ω ⊗ M^{-2}) = 0`. This is roadmap Layer A, "Degree". (b) A k-point of `X`, from the Nullstellensatz. (c) Connected implies geometrically connected over an algebraically closed field, since the roadmap nodes assume geometric connectedness. Also, `CharZero` is not used: the argument works over every algebraically closed field (`[2]` is a surjective isogeny in characteristic 2 too), so by `AGENTS.md` ("no unused or over-strong hypotheses") it should go.
8. **The roadmap providers are slightly off (minor).** `Curves.picardZero_isAbelianVariety` (`Roadmap/JacobianChallenge/Jacobian.toml` line 6) names Layer D. The roadmap puts "abelian variety, of dimension g" in Layer E, in the bullet "Abelian varieties and projectivity" (`JacobianVariety`, `dim (Jac X) = g`), and its carrier `JacobianVariety X x₀` takes a rational point `x₀`. The node should name both layers and either add the k-point hypothesis or note that Layer D gives representability without one. It should also say that the bijection of k-points with degree-zero line bundles is a group isomorphism (tensor product), because the theta proof uses that. `Curves.abelianVariety_multiplication_surjective` (line 12) correctly names Layer E, `multiplication_isogeny`, but "surjective on k-points over an algebraically closed field" is a short consequence that is not a roadmap target. It should be stated as a local lemma or flagged as such.
9. **Singular schemes (pre-existing gap, made visible by the new deps).** `deRhamPushforward`, `coherent` and `holonomic` work on finite-type schemes, which may be singular (for example the Schubert varieties under `pseudoProperShriek`). `rightCrystals_equiv_dModules` covers only smooth schemes, and no node plans Kashiwara's lemma ([Crystals] Prop. 2.5.6, `Crystalstext.tex` 1775; the reduction in §5.5 at 3574–3583). The commit did not cause this, but the new dependencies make it visible.
10. **One Υ, not three (presentation).** `leftToRightCrystals` defines Υ only on de Rham prestacks `Y_dR`. The proof of `leftCrystalsEquivRightCrystals` uses Υ on schemes (`X^I`, the open complements `U_i`) and on formal completions, and it uses its naturality (restriction along `j`, and diagram (7.11) of [DGIndschemes]). These now come from three places: `leftToRightCrystals`, `upsilon_isEquivalence_of_smooth` and `indcoh_formalCompletion_localization`. The paper has a single natural transformation `Υ_{PreStk_laft} : QCoh^* → IndCoh^!` ([Crystals] §2.4.1, `Crystalstext.tex` 1520–1524; [IndCoh] §10.3.3, `IndCohtext.tex` 7769) and applies it to `Y_dR` in §2.4.2 (1526–1534). Following `AGENTS.md` ("factor near-copies"), make `leftToRightCrystals` (or a `Sheaves.upsilon` node) that natural transformation, and take `Υ_{Y_dR}` as its value.

## Verdicts per node

### `GLCinLean.Examples.trivialGroup_isLanglandsFunctor_id` — *agree*, with points 1 and 2

TOML: `plans/GLCinLean/GeometricLanglands/Examples/Point.toml` lines 11–15.

Every identification is true for the trivial group, with the paper's normalizations:
- `Bun_1 = pt` and `LS_1 = Maps(X_dR, pt) = pt`. `Sing(LS_1) = 0`, so `IndCoh_Nilp(LS_1) = IndCoh(pt) = Vect = QCoh(pt)`, and `Ψ` is the identity.
- `det_{Bun_1}` is trivial, so its gerbe of square roots is canonically trivial ([GLC1] §1.1.4, `functor.tex` 1391–1396). Hence `Dmod_½(Bun_1) ≃ Vect`.
- `Rep(1)_Ran = QCoh((pt)_Ran) = QCoh(Ran)` ([GaitsgoryOutline] §4.2.4, `outline.tex` 2929–2933), and `QCoh(Ran) ≃ Dmod(Ran)` (2857–2858). The second step uses `leftCrystalsEquivRightCrystals` on the smooth `X^I`, so it is in scope of the narrowed node. The example reaches it only through `Spectral.localization`; a direct dependency would be clearer.
- For `Ǧ = 1`, `ev : LS × Ran → (pt)_Ran` is the identity of `Ran`, so `Loc = (id × p)_! ∘ ev^* = p_!` (`outline.tex` 2968).
- For `G = 1`, the Hecke stack is `Ran`, and `h←` and `h→` are both `p`. Then `V ⋆ M = p_!(V ⊗^! p^!M) = p_!V ⊗ M` by the projection formula, which `pseudoProperShriek` plans (`outline.tex` 3001–3029 for the pull-push).
- `Poinc = k`. For `G = 1` the stack `Bun_{N,ρ(ω_X)}` is a point, `χ` is the empty sum, so `χ = 0 : pt → 𝔾_a`, and `𝔭` is the identity. `exp` lies in `Dmod(𝔾_a)^♡[−1]` ([GLC1] §1.3.7, `functor.tex` 1647–1651). In the right (perverse) t-structure, `exp = E[−1]`, where `E = e^x` is a right D-module in the heart, so `exp` is normalized like a constant sheaf. Hence `0^* exp = k` in degree 0. The heart normalization would give `k[1]`, and using `!`-pullback would give `k[−2]`. So "Poinc ≃ k", together with "the identity functor is a Langlands functor", pins down the shift.
- For `F = id`: `Maps(p_!V ⊗ k, M) ≃ Maps(p_!V, M)`, naturally in `V` and `M`. Compact objects of `Vect` are perfect complexes, so they are bounded below. Both properties hold.

Hack-answer test:
- A zero category is ruled out for the trivial group (`Dmod_½ ≃ Vect`, `Rep(1)_Ran ≃ Dmod(Ran)`).
- `Loc = 0` or a zero action is ruled out by `Loc(δ_x) = k` and `V ⋆ M ≃ p_!V ⊗ M`.
- Using `p_*` instead of `p_!` is ruled out by the explicit `p_!` and by "the two pushforwards agree". That comparison is not automatic: `Loc` builds its pushforward from `deRhamPushforward` through left crystals, and the action uses `pseudoProperShriek`.
- Wrong shifts in `exp` or the pullback are ruled out (see above).
- A wrong Ran space is not ruled out (point 1).
- As the `desc` says, the example tests nothing that is trivial for `G = 1`.

Citations: [GLC1] §§1.2–1.3 and Cor. 1.6.5 (`functor.tex` 1833) are correct; [GaitsgoryOutline] §§4.2–4.4 are correct.

Remark: `plans-proof/GLCinLean/GeometricLanglands/Examples/Point.toml` (`Examples.trivialGroupFunctor_equiv`) repeats part of these identifications. The proof plan could reuse this example.

### `GLCinLean.DModules.rightCrystals` — *agree*, with point 4

TOML: `DModules/Crystals.toml` lines 4–8. [Crystals] §2.3.2 (`Crystalstext.tex` 1360–1370) defines `Crys^r := IndCoh^! ∘ dr` on `PreStk_laft`. The functors `f^{†,r}` are in §2.3.4 (1389–1396). The only problem is the descent that was dropped (point 4).

### `GLCinLean.DModules.leftToRightCrystals` — *same object, different presentation* (point 10)

TOML: lines 11–15. The functor `F ↦ F ⊗ ω_{Y_dR}` and its compatibility of `f^{†,l}` with `f^{†,r}`, coherently in `f`, are [Crystals] §2.4.2 (1526–1555), built from §2.4.1 (1501–1524), [IndCoh] §5.7.5 (`IndCohtext.tex` 4439) and §10.3.3. The source should read "§§2.4.1–2.4.2", because `Υ_{Y_dR}` itself appears in §2.4.2.

### `GLCinLean.DModules.leftCrystalsEquivRightCrystals` — *agree*

TOML: lines 18–22. The narrowing to smooth schemes of finite type, with compatibility along all maps between them, matches the use in `Spectral.localization` (`Spectral/Localization.toml` line 6, the schemes `X^I`). Nothing else in `plans/` depends on this node, as the `desc` says.

The proof follows [Crystals] Prop. 2.4.4 (1561–1628) with `Z = X`, `i = id`. Then `Y = X^∧_X = X`, so the step "X_dR → Y_dR is an isomorphism" is empty. The steps and the inputs that cover them:
- Descent: Lemmas 2.1.7 and 2.3.11 (1249–1253, 1455–1463), through Lemma 1.2.4 (998–1001). Covered by `crystals_descent_of_classicallyFormallySmooth`.
- The Čech terms are formal completions of `X^i` along the diagonal (1606–1608, §1.2.2 at 976–979). Covered by `deRhamCechNerve_formalCompletion`.
- The map of localization sequences ([DGIndschemes] Props. 7.1.3 and 7.4.5, 1610–1618). Covered by the two localization nodes.
- Υ is an equivalence on the smooth `X^i` and `U_i` ([IndCoh] Prop. 9.3.3 and Lemma 1.1.6, 1620–1626). Covered by `upsilon_isEquivalence_of_smooth`.

The proof also uses the naturality of Υ along `j : U_i → X^i` and along `X^{i∧} → X^i`. That comes from `leftToRightCrystals` and `indcohQCohAction` (point 10). Smoothness of `X` implies classical formal smoothness: [Crystals] 1099–1101 and 1488, citing [DGIndschemes] §8; see `IndSchemestext.tex` 7905–7910, §8.4.2. The route has no gap and no circle. The transitive closure of the node (computed from the TOML) contains neither itself nor `rightCrystals_equiv_dModules`, nor any of `deRhamPushforward`, `coherent` and `holonomic`. All numbering is correct (Prop. 2.4.4; Lemmas 1.2.4, 2.1.7, 2.3.11; [IndCoh] Lemma 1.1.6 and Prop. 9.3.3; [DGIndschemes] Props. 7.1.3 and 7.4.5).

### `GLCinLean.DModules.crystals_descent_of_classicallyFormallySmooth` — *agree*

TOML: lines 25–29. Matches Lemmas 1.2.4, 2.1.7 and 2.3.11, with the compatibility with Υ given by the naturality of §2.4.2. The sentence "Smooth schemes are classically formally smooth" is a claim with no source. Add [DGIndschemes] §8.4.2 (`IndSchemestext.tex` 7905) or [Crystals] proof of Prop. 1.3.3 (1099–1101).

### `GLCinLean.DModules.rightCrystals_equiv_dModules` — *agree*, with remarks

TOML: lines 32–36. [Crystals] §5.5 (3565–3662) proves `Crys^r(X) ≃ Dmod^r(X)` for classical finite-type `X`: it reduces to the smooth case by Kashiwara, then uses Prop. 2.4.4 to pass to left crystals, then Grothendieck's computation or Lemma 5.4.3. The narrowed statement (smooth `X`) is the smooth part, and "construct it through left crystals" is exactly the paper's route (3592–3600). There is no circle. Three remarks follow:
- The step through left crystals also needs the classical left–right equivalence `M ↦ M ⊗ Ω^n_X` of D_X-modules. Because `ω_X = Ω^n_X[n]`, `Υ` shifts degrees by `n`, so the right t-structure matches right D_X-modules with this shift.
- The paper's route uses t-structure results on crystals: [Crystals] §4.2 (the right t-structure), Prop. 4.4.2 and Prop. 4.7.3 (3077). The `deps` have only the generic `Infinity.tStructure`. The node should say that it defines the right t-structure of [Crystals] §4.2 itself, since `DModules.exponential` ("heart[−1]") needs it.
- The Grothendieck computation uses `crystals_descent_of_classicallyFormallySmooth` directly, so that node should be a direct dependency.

### `GLCinLean.Sheaves.upsilon_isEquivalence_of_smooth` — *agree* on the equivalence; gap in the duality clause (point 6)

TOML: `Sheaves/IndCoh.toml` lines 46–50. [IndCoh] Lemma 1.1.6 (1034–1036) is stated for regular classical schemes, which covers smooth schemes of finite type. Prop. 9.3.3 is at 7028–7032. The numbering is correct.

### `GLCinLean.Sheaves.qcoh_formalCompletion_localization` — *agree*

TOML: `Sheaves/FormalCompletion.toml` lines 4–8. [DGIndschemes] §7.1 (6503–6563). The hypothesis there (an ideal that is locally finitely generated, 6544–6547) holds for finite type. Prop. 7.1.3 at 6559 is correct.

### `GLCinLean.Sheaves.indcoh_formalCompletion_localization` — *agree*; citation

TOML: lines 11–15. Prop. 7.4.5 (7026–7030) is correct. The compatibility "under Υ on X, U and X^∧_Y" is in §7.5, not §7.4: diagram (7.11) at 7126–7131, and diagram (7.16) at 7234–7239, which is the one [Crystals] cites (1608). The source should read "Proposition 7.4.5 and §7.5, diagrams (7.11) and (7.16)". Naturality of Υ (diagram (7.11), "by construction") is enough for the use in `leftCrystalsEquivRightCrystals`.

### `GLCinLean.Derived.deRhamCechNerve_formalCompletion` — *agree*; citation

TOML: `Derived/DeRham.toml` lines 18–22. The identification of the Čech nerve terms with the formal completions holds for every prestack ([Crystals] §1.2.2, 976–979). The "locally almost of finite type indscheme" part is [DGIndschemes] Prop. 6.3.1 and Cor. 6.3.2 (5670, 5690), which should be added to the source. The off-by-one indexing (`n`-th term is `X^{n+1}`) is consistent with the paper's `Y^i/Y_dR` as completions of `Z^i`.

### New deps on `rightCrystals_equiv_dModules` — *agree* (point 9)

- `DModules.deRhamPushforward`: `DModules/DirectImage.toml` line 7.
- `DModules.coherent`: `DModules/Coherent.toml` line 7.
- `DModules.holonomic`: `DModules/Holonomic.toml` line 7.
- `DModules.exponential`: `DModules/Exponential.toml` line 7.

Each of these uses D_X-modules ([DG2] §5.2.1, `Finiteness.tex` 4753–4757, "the classical theory of D-modules"), so the dependency is right and creates no circle. For `exponential` on the smooth `𝔾_a` it is all that is needed. For the other three on singular schemes, see point 9.

### `GLCinLean.Curves.thetaCharacteristic_exists` — *agree* on the sketch; gaps (point 7)

TOML: `Curves/ThetaExistence.toml` lines 4–8. The sketch is correct, including `g = 0`: there `Pic⁰ = Spec k`, `M = 𝒪(−x₀)` and `N = 𝒪`. The steps are: `deg(ω ⊗ M^{−2}) = 2g − 2 − 2(g − 1) = 0`; this gives a k-point of `Pic⁰`; `[2]` is surjective on k-points, so `N^{⊗2} ≅ ω ⊗ M^{−2}`; and `(M ⊗ N)^{⊗2} ≅ ω`. The source [GLC1] §1.3.2 (`functor.tex` 1509–1512) is where the choice is made, not where existence is proved. That is acceptable as a locator.

### `GLCinLean.Curves.degree_canonical` — *agree*

TOML: `Roadmap/JacobianChallenge/SerreDuality.toml` lines 10–13. The roadmap's Layer B, titled "Layer B, coherent cohomology over `k`: genus, Riemann–Roch, Serre duality", lists `deg ω_{X/k} = 2g − 2`. The name and the content match.

### `GLCinLean.Curves.picardZero_isAbelianVariety` — *agree*, with point 8

TOML: `Roadmap/JacobianChallenge/Jacobian.toml` lines 4–7. Layer D ("the relative Picard functor and the Jacobian scheme") gives `Pic⁰` smooth, geometrically connected, proper and projective of dimension `g`. Layer E gives the abelian-variety carrier and `dim = g`.

### `GLCinLean.Curves.abelianVariety_multiplication_surjective` — *agree*, with point 8

TOML: lines 10–13. It matches Layer E, "Multiplication and characteristic p" (`multiplication_isogeny`: `[n]` finite locally free and surjective for `n ≠ 0`). The roadmap also checks dimension zero, which covers the genus-zero curve.

### `GLCinLean.Hecke.action` — *agree*

TOML: `Hecke/Action.toml` lines 4–8. Removing `extraordinaryPullback` and `holonomicShriek` is right: the pull-push now lives in `Hecke.sphericalAction`, which is reached through `Hecke.satake`. [GLC1] §1.2.1 (`functor.tex` 1426–1434).

### `GLCinLean.Hecke.sphericalAction` — *agree* on the untwisted construction; *unsure* on the twisted pushforward (point 3)

TOML: lines 11–15. "!-pullback of kernels, then the left adjoint of !-pullback along the projection" matches [GaitsgoryOutline] §§4.2.3 and 4.4.2 (`outline.tex` 2924–2927: "the left adjoint of the functor (id × ∪)^!"; 3001–3029). With `pseudoProperShriek` the action is defined on all objects, which the paper needs: the Hecke functors are endofunctors of the whole `Dmod_½(Bun_G)`.

### `GLCinLean.Hecke.correspondence_pseudoProper` — *agree* on the mathematics; *unsure* on the wording (point 5)

TOML: `Hecke/Correspondence.toml` lines 11–15. The definition matches [GaitsgoryAtiyahBott] §§1.5.1 and 1.5.3 (`Tamagawa.tex` 1840–1846, 1899–1902). The source should also cite [GaitsgoryOutline] §4.4.1 (`outline.tex` 2991–2999) for the Hecke stack, because [GLC1] §1.2.1 does not describe it.

### `GLCinLean.DModules.pseudoProperShriek` — *agree*

TOML: `Prestacks/PseudoProper.toml` lines 11–15. Moved unchanged. It matches [GaitsgoryAtiyahBott] Prop. 1.5.2 (`Tamagawa.tex` 1849–1897: the left adjoint as the colimit of the `(f_a)_!` of proper pieces, and base change) and Cor. 1.5.4 (1908–1929). The projection formula is not stated in §1.5, but it follows the same way, from scheme testing. It now belongs in `plans/`, since `Hecke.sphericalAction` and the example use it. It covers untwisted D-modules only (point 3).

## Scope and time

All 18 nodes in scope were reviewed against the TeX. The roadmap was read from `TauCetiProject/TauCetiRoadmap` (`TauCetiRoadmap/JacobianChallenge/README.md`, the current `main`). Nothing was much larger than expected. Not checked in depth: the [GLC2] §1.5.1 and §H.6.8 and [GLC3] §8.2.1 sources of `Hecke.sphericalAction`, which this commit did not change.
