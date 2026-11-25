# The theta characteristic of the projective line, with no choice

A proposal by `prompts/change.md` for finding B2 of the audit of 2026-11-25, in its state after round 1 of the checks (`line-bundle-routes-checker-1.md`, `line-bundle-routes-codex-1.md`, `line-bundle-routes-answers-1.md`). It is a change of route: the object stays the same and the construction of its isomorphism changes. The branch is `proposal/line-bundle-routes`.

## 1. The problem

**The node.** `GLCinLean.Curves.thetaCharacteristicProjectiveLine` (`plans/GLCinLean/AlgebraicGeometry/Curves/ProjectiveLine.toml`, source [GLC1] §1.3.2) is the example of `Curves.ThetaCharacteristic`: the square root `(𝒪(−1), φ)` of the canonical bundle of `ℙ¹`, with `φ : 𝒪(−1)^{⊗2} ≅ Ω¹`. On `main` the node takes `φ` by choice from an existence statement: `Ω¹` has degree `2g − 2 = −2`, `𝒪(−1)^{⊗2}` has degree `−2`, and `TauCeti.AlgebraicGeometry.projectiveLine.nonempty_iso_twistingSheaf_iff` says that a line bundle on `ℙ¹` over a field is isomorphic to `𝒪(n)` exactly when its degree is `n`. The node then says that `φ` is unique up to a scalar in `k^×` and that no user may depend on which one it is.

**What is wrong with it.** A chosen isomorphism has no formula, so nothing can be computed with it, and every user must be checked against the rule that it does not depend on the choice. The route also needs a field, the genus of `ℙ¹` and the degree theory of curves, none of which the object needs.

**The paper.** [GLC1] §1.3.2 (`references/papers/2405.03599v3/src/functor.tex`, line 1511): "The Langlands functor depends on the choice of the square root `ω_X^{1/2}` of the canonical line bundle on `X`, which we fix from now on." The paper fixes a square root as data and says nothing on `ℙ¹`. The node is an example of the plan, so no claim of the paper is touched.

**What is at the pin** (Tau Ceti `553f7926`, in `.lake/packages/TauCeti`).

- `TauCeti.AlgebraicGeometry.projectiveLine.relativeDifferentialsIsoTwistingSheaf` (`TauCeti/AlgebraicGeometry/Modules/Differentials/ProjectiveLine.lean`, line 332), for `(R : Type u) [CommRing R]`: an isomorphism `(projectiveLine R).relativeDifferentials R ≅ Proj.twistingSheaf 𝒜 (-2)` of module sheaves, where `𝒜` is `SymmetricAlgebra.homogeneousSubmodule R (Fin 2 → R)`. It has no other hypothesis. The lemmas `relativeDifferentialsIsoTwistingSheaf_hom_d_affineCoordinate` and `relativeDifferentialsIsoTwistingSheaf_inv_chartGenerator` fix it on the two charts: `dt ↦ X₀^{−2}` on `D₊(X₀)` and `ds ↦ −X₁^{−2}` on `D₊(X₁)`, for `t = X₁/X₀` and `s = X₀/X₁`.
- `AlgebraicGeometry.Proj.twistingSheaf.tensorProductIso` (`TauCeti/AlgebraicGeometry/ProjectiveSpectrum/TwistingSheaf/TensorProduct.lean`, line 199): `TauCeti.SheafOfModules.tensorProduct (Proj 𝒜).sheaf (twistingSheaf 𝒜 m) (twistingSheaf 𝒜 n) ≅ twistingSheaf 𝒜 (m + n)`. Its hypotheses are `{ι : Type*} (f : ι → A) (hf : ∀ i, f i ∈ 𝒜 1) (hcover : ⨆ i, basicOpen 𝒜 (f i) = ⊤) (m n : ℤ)`, for a commutative ring `A` with a grading `𝒜` by `ℕ`. In the same file, `tensorObjIso` (line 262) is the same isomorphism from the tensor product `twistingSheaf 𝒜 m ⊗ twistingSheaf 𝒜 n` of the monoidal category of module sheaves, with `tensorObjIso_hom` (the relation of the two) and `tensorObjIso_hom_app_tmulRight` (it is multiplication of sections).
- `TauCeti.AlgebraicGeometry.InvertibleSheaf.relativeDifferentials` (`…/Modules/Differentials/Rank.lean`, line 173): `Ω¹` as an invertible sheaf, for a scheme smooth of relative dimension one over `Spec R`.

**The nodes that the change touches, and every user of each** (`lake exe tracker show`).

| Node | Its users | Touched how |
|---|---|---|
| `Curves.thetaCharacteristicProjectiveLine` | `Examples.exists_setting_rank_pos` | `desc` rewritten; `deps` and `source` unchanged |
| `Curves.ThetaCharacteristic` (a dependency of the node) | `Whittaker.character`, `Whittaker.rhoTorsor`, `Curves.thetaCharacteristicProjectiveLine`, `Stacks.determinantSquareRoot`, `Satake.halfTwistedHeart_equiv_untwistedHeart` | `desc` gains, for an affine base `Spec R`, the conversion to the form of `Statement.Setting`; the definition is unchanged |
| `LineBundle.Root` (a dependency of the node) | five nodes | not touched |
| `Examples.exists_setting_rank_pos` (the user) | none | not touched |

## 2. The checks of the hypotheses

**The hypotheses of `tensorProductIso` on the projective line.** In `TauCeti/AlgebraicGeometry/ProjectiveSpectrum/ProjectiveLine.lean`: `projectiveLine R` is by definition `Proj (SymmetricAlgebra.homogeneousSubmodule R (Fin 2 → R))` (line 149, an `abbrev`); `coord R : Fin 2 → SymmetricAlgebra R (Fin 2 → R)` are the homogeneous coordinates (line 158); `coord_mem R i : coord R i ∈ 𝒜 1` (line 162); `iSup_basicOpen_coord_eq_top R : ⨆ i, Proj.basicOpen 𝒜 (coord R i) = ⊤` (line 515). These are `f`, `hf` and `hcover`, for every commutative ring `R`. Upstream uses the same three, with the index type lifted by `ULift`, for `Proj.lineBundleClass_twistingSheaf_eq_zpow` in `TauCeti/AlgebraicGeometry/LineBundle/ProjectiveLine.lean` (line 84). The exponent: `tensorProductIso … (-1) (-1)` has the target `twistingSheaf 𝒜 (-1 + -1)`, and Lean accepts it where `twistingSheaf 𝒜 (-2)` is expected (the test below).

**The three forms of `M ⊗ M`.** For an invertible sheaf `M` on a scheme `X`:

- (S) `(M.tensorProduct M).obj`, which is `TauCeti.SheafOfModules.tensorProduct X.sheaf M.obj M.obj` by `InvertibleSheaf.tensorProduct_obj` (a `rfl`). `Statement.Setting.sqrtOmegaIso` has this form: `(sqrtOmega.tensorProduct sqrtOmega).obj ≅ X.relativeDifferentials k` (`GLCinLean/Statement/Conjecture.lean`, line 219). `tensorProductIso` has this source.
- (T) `M.obj ⊗ M.obj` in the monoidal category `X.Modules`. `InvertibleSheaf.tensorProductObjIso M M : (M.tensorProduct M).obj ≅ M.obj ⊗ M.obj` compares (S) and (T); in `InvertibleSheaf X` it is `InvertibleSheaf.tensorProductIsoTensor`. `tensorObjIso` has this source.
- (R) `TauCeti.tensorPow M 2`, which is `M ⊗ (M ⊗ 𝟙)` in `InvertibleSheaf X` by definition (`tensorPow_succ`, `tensorPow_zero`). A square root in the sense of `LineBundle.Root` has this form. The right unit isomorphism of `M`, whiskered on the left by `M`, compares (R) and (T).

So `φ` in the form (R) is: the whiskered right unit isomorphism, then `tensorObjIso coord coord_mem iSup_basicOpen_coord_eq_top (-1) (-1)`, then the inverse of `relativeDifferentialsIsoTwistingSheaf R`. Converted to the form (S), it is `tensorProductIso … (-1) (-1)` followed by the same inverse: the two unit isomorphisms cancel, and `tensorProductObjIso` followed by `tensorObjIso` is `tensorProductIso` by the definitions of the two (`tensorProductObjIso_hom`, `tensorObjIso_hom`).

**A test in Lean.** The file below elaborates at the pin with `lake env lean`, after `lake build +TauCeti.AlgebraicGeometry.Modules.Differentials.ProjectiveLine +TauCeti.AlgebraicGeometry.Modules.Differentials.Rank +TauCeti.AlgebraicGeometry.ProjectiveSpectrum.TwistingSheaf.TensorProduct +TauCeti.AlgebraicGeometry.LineBundle.Power` (the cache supplies these modules). It shows that the hypotheses hold over every commutative ring, that the instances are found (the invertibility of `𝒪(n)`, the smoothness of `ℙ¹_R`), and that `-1 + -1` is accepted as `-2`.

```lean
import TauCeti.AlgebraicGeometry.Modules.Differentials.ProjectiveLine
import TauCeti.AlgebraicGeometry.Modules.Differentials.Rank
import TauCeti.AlgebraicGeometry.ProjectiveSpectrum.TwistingSheaf.TensorProduct
import TauCeti.AlgebraicGeometry.LineBundle.Power

open CategoryTheory MonoidalCategory AlgebraicGeometry TauCeti.AlgebraicGeometry

universe u

noncomputable section

variable (R : Type u) [CommRing R]

local notation "𝒜" => TauCeti.SymmetricAlgebra.homogeneousSubmodule R (Fin 2 → R)

abbrev tw (n : ℤ) : InvertibleSheaf (projectiveLine R) :=
  ⟨Proj.twistingSheaf 𝒜 n, inferInstance⟩

abbrev om : InvertibleSheaf (projectiveLine R) :=
  InvertibleSheaf.relativeDifferentials R (projectiveLine R)

-- (S) The form of `Statement.Setting`.
def settingIso : ((tw R (-1)).tensorProduct (tw R (-1))).obj ≅
    (projectiveLine R).relativeDifferentials R :=
  Proj.twistingSheaf.tensorProductIso (projectiveLine.coord R) (projectiveLine.coord_mem R)
      (projectiveLine.iSup_basicOpen_coord_eq_top R) (-1) (-1) ≪≫
    (projectiveLine.relativeDifferentialsIsoTwistingSheaf R).symm

-- (T) The monoidal form in the category of module sheaves.
def modIso : Proj.twistingSheaf 𝒜 (-1) ⊗ Proj.twistingSheaf 𝒜 (-1) ≅
    (projectiveLine R).relativeDifferentials R :=
  Proj.twistingSheaf.tensorObjIso (projectiveLine.coord R) (projectiveLine.coord_mem R)
      (projectiveLine.iSup_basicOpen_coord_eq_top R) (-1) (-1) ≪≫
    (projectiveLine.relativeDifferentialsIsoTwistingSheaf R).symm

-- (R) The form of a square root.
def rootIso : TauCeti.tensorPow (tw R (-1)) 2 ≅ om R :=
  whiskerLeftIso (tw R (-1)) (ρ_ (tw R (-1))) ≪≫ ObjectProperty.isoMk _ (modIso R)

example (X : Scheme.{u}) (M : InvertibleSheaf X) :
    TauCeti.tensorPow M 2 = M ⊗ (M ⊗ 𝟙_ (InvertibleSheaf X)) := rfl

end
```

**Not done in the test.** The equation `settingIso R = InvertibleSheaf.tensorProductObjIso (tw R (-1)) (tw R (-1)) ≪≫ modIso R` was not closed. After `ext`, `rw [settingIso, modIso, Iso.trans_hom, Iso.trans_hom, Proj.twistingSheaf.tensorObjIso_hom, InvertibleSheaf.tensorProductObjIso_hom]` the goal is `tensorProductIso.hom ≫ e.inv = (eqToHom _ ≫ T.hom ≫ U.inv) ≫ (U.hom ≫ T.inv ≫ tensorProductIso.hom) ≫ e.inv`, with `T` the isomorphism `TauCeti.SheafOfModules.tensorProductIso`, `U` the isomorphism `tensorUnderlyingIso`, `e` the isomorphism of the differentials, and `eqToHom` of a `rfl`. It is true by cancellation. `simp` did not close it, because the two sides name the same category of module sheaves in two ways (`(projectiveLine R).sheaf` and `(Proj 𝒜).sheaf`). The checker of round 1 did not close it in two attempts either; Codex reports that it checked the equality in Lean. The writer closes it; it is test lemma (b) of the node.

## 3. The options

- **A. Keep the chosen isomorphism.** It needs nothing new. It keeps a definition with no formula, the rule on its users, and the restriction to a field.
- **B. The specified isomorphism, over a field only.** It removes the choice. It keeps a hypothesis that no step of the construction uses.
- **C. The specified isomorphism, over every commutative ring `R`.** The construction above. The node becomes more general in its base, and the object over a field is the same sheaf `𝒪(−1)` with one of the isomorphisms that the old node could have chosen.
- **D. Remove the node, and let `Examples.exists_setting_rank_pos` take `sqrtOmegaIso` directly as `tensorProductIso … (-1) (-1)` followed by the inverse of `relativeDifferentialsIsoTwistingSheaf`.** That theorem would no longer wait for `LineBundle.Root`. But `Curves.ThetaCharacteristic` would lose its only example, which `AGENTS.md` ("Lean code") asks of a new definition, and the theorem waits for `Groups.dualityData` in any case.

## 4. The choice: C

**Reasons.**

- By `AGENTS.md`, "Lean code": "the weakest assumptions and the weakest structure the mathematics needs". The two upstream isomorphisms and the three hypotheses hold over every commutative ring, so a field would be an unused hypothesis. `Curves.ThetaCharacteristic` is planned over a base and not over a field.
- By `AGENTS.md`, "Sources of code": the two isomorphisms are in Tau Ceti and are used, not written again.
- The new node has a formula on each chart, so it can be tested: test lemma (a) of the node says that `φ` sends the tensor square of the generator `X_i^{−1}` of `𝒪(−1)` on `D₊(X_i)` to `dt` for `i = 0` and to `−ds` for `i = 1`. It follows from `tensorObjIso_hom_app_tmulRight` (the isomorphism is multiplication), `Proj.twistingSheaf.mul_chartGenerator` (the product of the generators `f^m` and `f^n` is `f^{m+n}`) and `relativeDifferentialsIsoTwistingSheaf_inv_chartGenerator`.
- The sentence "no user may depend on which one it is" falls away, and with it the declarations of the degree theory that only the old route used: `projectiveLine.genus_eq_zero`, `projectiveLine.nonempty_iso_twistingSheaf_iff`, `projectiveLine.eulerDegree_twistingSheaf`, `LineBundleClass.mk_tensorPow` and `eulerDegree_relativeDifferentials`.

**The users, checked.**

- `Examples.exists_setting_rank_pos` needs, for an algebraically closed field `k` of characteristic zero, an invertible sheaf `M` on `ℙ¹_k` and an isomorphism `(M.tensorProduct M).obj ≅ (projectiveLine k).relativeDifferentials k`. The node gives it for `R = k`, by test lemma (b), as `settingIso k` of the test. The universe fits: `k : Type u` gives `projectiveLine k : Scheme.{u}`, as `Statement.Setting k` asks. The other fields of the setting (proper, connected, the groups) do not depend on this node.
- `Curves.ThetaCharacteristic`: its definition is unchanged. The example is now over every commutative ring, which is within "no condition on the base". The node now states, for an affine base `Spec R`, the conversion between the forms (R) and (S), which `STATUS.md` ("Notes for the writers") and the provider record already assign to its writer; the four other users take the theta characteristic of a setting through this conversion. The conversion is stated where its input exists: `InvertibleSheaf.relativeDifferentials` is `Ω¹` as an invertible sheaf for a scheme smooth of relative dimension one over `Spec R`, and Tau Ceti has no relative differentials over a general base.
- `Statement.Setting` is not changed.

**The degenerate cases.** Over the zero ring, `ℙ¹_R` is empty and the node is the unique square root there; no user takes `R = 0`. The exponents `−1` and `−2` are integers, so no natural-number subtraction occurs.

**What the commit changes.**

- `plans/GLCinLean/AlgebraicGeometry/Curves/ProjectiveLine.toml`: the `desc` of the node (the base, the three isomorphisms, the hypotheses of (2), the two test lemmas, the upstream declarations).
- `plans/GLCinLean/AlgebraicGeometry/Curves/Theta.toml`: the `desc` of `Curves.ThetaCharacteristic` gains, for an affine base, the conversion to the form of `Statement.Setting`, and four upstream names (a small change).
- `docs/blueprint-providers.md`: the rows of `TauCeti.tensorPow`, `eulerDegree_relativeDifferentials`, `projectiveLine` and `relativeDifferentialsIsoTwistingSheaf`; the row of `nonempty_iso_twistingSheaf_iff` becomes the row of `eulerDegree_twistingSheaf`, which `Stacks.schemeRootGerbe` names; a new row for `Proj.twistingSheaf.tensorObjIso`.

**`STATUS.md` when the change is applied.** "Findings of the audit of 2026-11-25 that are not applied" loses B2, and "Decisions taken" gains the change. The note on `Curves.ThetaCharacteristic` under "Notes for the writers" stays right.

## 5. Where the planner is unsure

- The conversion in the `desc` of `Curves.ThetaCharacteristic` is new text in a node that four other nodes use. It adds API and does not change the definition. A checker may prefer to leave it to the time when that node is written.
- The equation of test lemma (b) is not closed in Lean (above). The mathematics is a cancellation; the cost for the writer is not measured.
- `Curves.ThetaCharacteristic` is planned over a base scheme `S`, and no node or upstream declaration supplies `Ω¹_{X/S}` for a base that is not affine (`STATUS.md`, "Notes for the writers"; objection 1 of Codex in round 1). This is older than the change and the change does not settle it. The node here and the new conversion are over `Spec R`, the only base over which `Scheme.relativeDifferentials` exists at the pin, so they fit both answers.
