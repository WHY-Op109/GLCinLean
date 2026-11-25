/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5
-/
module

public import Mathlib.CategoryTheory.Monoidal.Braided.Basic
public import Mathlib.CategoryTheory.Monoidal.NaturalTransformation
public import Mathlib.CategoryTheory.Monoidal.Types.Basic
public import TauCeti.CategoryTheory.Monoidal.Braided.TensorPow
public import TauCeti.CategoryTheory.Monoidal.TensorPow.Basic

/-!
# The tensor power functor

For a monoidal category `C` and `n : ℕ`, the `n`-th tensor power is a functor
`GLCinLean.CategoryTheory.tensorPowFunctor C n : C ⥤ C`, which sends `X` to
`TauCeti.tensorPow X n` and `f` to `TauCeti.tensorPowMap f n`. The tensor powers are nested to
the right: $X^{\otimes 0} = 𝟙$ and $X^{\otimes (n+1)} = X \otimes X^{\otimes n}$.

When `C` is braided, the functor is monoidal, with unit comparison
$ε_n : 𝟙 \to 𝟙^{\otimes n}$ and tensor comparison
$μ_n : X^{\otimes n} \otimes Y^{\otimes n} \to (X \otimes Y)^{\otimes n}$. Both are defined by
recursion on `n`: for `n = 0` the functor is the constant functor at `𝟙_ C`, with `ε₀ = 𝟙` and
`μ₀` the left unitor of `𝟙_ C`; for `n + 1` the functor is the pairing of the identity functor
with the functor for `n`, followed by the tensor product `tensor C : C × C ⥤ C`, which is monoidal
for a braided `C` (`MonoidalCategory.tensorMonoidal`). This gives
$$μ_{n+1}(X, Y) = \mathrm{tensorμ}(X, X^{\otimes n}, Y, Y^{\otimes n}) ≫ (X ⊗ Y) ◁ μ_n(X, Y),$$
where `tensorμ` exchanges the two middle factors of $(X ⊗ X^{\otimes n}) ⊗ (Y ⊗ Y^{\otimes n})$
by the braiding $β_{X^{\otimes n}, Y}$. When `C` is symmetric, the functor is braided.

The unit comparison $ε_n$ is the inverse of `TauCeti.tensorPowUnitIso n`. The tensor comparison
$μ_n(X, Y)$ is the inverse of `TauCeti.tensorPowTensorIso X Y n` formed for the reverse braiding
`CategoryTheory.reverseBraiding C`, since the inverse of `TauCeti.tensorPowTensorIso X Y (n + 1)`
exchanges the middle factors by $β_{Y, X^{\otimes n}}^{-1}$, where $μ_{n+1}(X, Y)$ uses
$β_{X^{\otimes n}, Y}$. So when `C` is symmetric, $μ_n(X, Y)$ is the inverse of
`TauCeti.tensorPowTensorIso X Y n`; when `C` is braided and not symmetric, the two can differ.

The functor commutes with every braided monoidal functor `G : C ⥤ D`: there is an isomorphism
$G(X^{\otimes n}) \cong G(X)^{\otimes n}$, natural in `X` and monoidal. It sends an object with a
tensor inverse to an object with a tensor inverse, and $(X^{\otimes n})^{-1} \cong
(X^{-1})^{\otimes n}$.

[GLys] §1.4.2 uses the `n`-th tensor power of line bundles to define the gerbe of `n`-th roots of a
line bundle `L`, whose values are the pairs of a line bundle `L'` and an isomorphism
$L'^{\otimes n} \cong L$. The monoidal structure of this file is what the tensor product and the
dual of such pairs need.

## Main definitions

* `GLCinLean.CategoryTheory.tensorPowFunctor C n`: the `n`-th tensor power functor `C ⥤ C`, for
  any monoidal category `C`.
* `GLCinLean.CategoryTheory.tensorPowFunctorMonoidal`: its monoidal structure for a braided `C`,
  with the formulas `tensorPowFunctor_ε_zero`, `tensorPowFunctor_μ_zero`,
  `tensorPowFunctor_ε_succ` and `tensorPowFunctor_μ_succ` (and the same for `η` and `δ`); it is
  braided for a symmetric `C`.
* `GLCinLean.CategoryTheory.tensorPowFunctor_εIso`,
  `GLCinLean.CategoryTheory.tensorPowFunctor_μ_eq_reverseBraiding_tensorPowTensorIso_inv` and
  `GLCinLean.CategoryTheory.tensorPowFunctor_μIso`: the comparisons are the inverses of
  `TauCeti.tensorPowUnitIso` and, for a symmetric `C`, of `TauCeti.tensorPowTensorIso` (for a
  braided `C`, with the reverse braiding).
* `GLCinLean.CategoryTheory.tensorPowFunctorZeroIso`, `tensorPowFunctorSuccIso` and
  `tensorPowFunctorOneIso`: the functor for `0` is the constant functor at the unit, the functor
  for `n + 1` is the pairing with the identity followed by the tensor product, and the functor for
  `1` is isomorphic to the identity functor; each is a monoidal isomorphism for a braided `C`.
* `GLCinLean.CategoryTheory.tensorPowFunctorCompIso G n`: the isomorphism
  `tensorPowFunctor C n ⋙ G ≅ G ⋙ tensorPowFunctor D n` for a monoidal functor `G`, monoidal when
  `G` is braided.
* `GLCinLean.CategoryTheory.tensorPowTensorIsoUnit`: the functor sends an isomorphism
  `X ⊗ M ≅ 𝟙_ C` to an isomorphism `tensorPow X n ⊗ tensorPow M n ≅ 𝟙_ C`, so it preserves tensor
  inverses.
* `GLCinLean.CategoryTheory.tensorPowInverseIso`: the comparison
  $(X^{\otimes n})^{-1} \cong (X^{-1})^{\otimes n}$.

The first part of the file contains the general constructions on monoidal functors and
symmetric monoidal categories that the module uses:

* `CategoryTheory.Functor.constTensorUnitCoreMonoidal` and the instance
  `CategoryTheory.Functor.Monoidal.constTensorUnit`: the monoidal structure of the constant
  functor at the unit;
* `CategoryTheory.SymmetricCategory.tensorμ_comp_braiding_tensorHom_braiding`: `tensorμ` commutes
  with the braidings in a symmetric category;
* `CategoryTheory.MonoidalCategory.isoOfTensorIsoUnit`: a left tensor inverse is isomorphic to a
  right tensor inverse;
* `CategoryTheory.Functor.Monoidal.mapTensorIsoUnit`: a monoidal functor sends an isomorphism
  `X ⊗ M ≅ 𝟙_ C` to an isomorphism `F.obj X ⊗ F.obj M ≅ 𝟙_ D`.

## Implementation notes

`TauCeti.tensorPowMap` is not exposed outside its module, so `tensorPowFunctor C (n + 1)` is equal
to `(𝟭 C).prod' (tensorPowFunctor C n) ⋙ tensor C` only up to a natural isomorphism with identity
components (`tensorPowFunctorSuccIso`). The monoidal structure is transported along these
isomorphisms (`Functor.Monoidal.transport`).

The examples in the category of types stay in this module, since the repository has no test
library; the import `Mathlib.CategoryTheory.Monoidal.Types.Basic` serves only them.

## References

* [GLys] D. Gaitsgory and S. Lysenko, *Parameters and duality for the metaplectic geometric
  Langlands theory*, §1.4.2.
-/

@[expose] public section

universe v v₁ v₂ u u₁ u₂

namespace CategoryTheory

open MonoidalCategory Functor.LaxMonoidal Functor.OplaxMonoidal

namespace Functor

variable (C : Type u₁) [Category.{v₁} C] [MonoidalCategory C]
  (D : Type u₂) [Category.{v₂} D] [MonoidalCategory D]

/-- The constant functor `C ⥤ D` at the unit object `𝟙_ D` is monoidal: its unit comparison
`𝟙_ D ≅ 𝟙_ D` is the identity, and its tensor comparison `𝟙_ D ⊗ 𝟙_ D ≅ 𝟙_ D` is the left unitor
of `𝟙_ D` for all objects of `C`. -/
def constTensorUnitCoreMonoidal : ((Functor.const C).obj (𝟙_ D)).CoreMonoidal where
  εIso := Iso.refl _
  μIso _ _ := λ_ (𝟙_ D)
  associativity _ _ _ := by simp [unitors_equal]
  left_unitality _ := by simp
  right_unitality _ := by simp [unitors_equal]

instance Monoidal.constTensorUnit : ((Functor.const C).obj (𝟙_ D)).Monoidal :=
  (constTensorUnitCoreMonoidal C D).toMonoidal

@[simp] lemma const_tensorUnit_ε : ε ((Functor.const C).obj (𝟙_ D)) = 𝟙 (𝟙_ D) := rfl

@[simp] lemma const_tensorUnit_η : η ((Functor.const C).obj (𝟙_ D)) = 𝟙 (𝟙_ D) := rfl

@[simp] lemma const_tensorUnit_μ (X Y : C) :
    μ ((Functor.const C).obj (𝟙_ D)) X Y = (λ_ (𝟙_ D)).hom := rfl

@[simp] lemma const_tensorUnit_δ (X Y : C) :
    δ ((Functor.const C).obj (𝟙_ D)) X Y = (λ_ (𝟙_ D)).inv := rfl

end Functor

/-- In a symmetric monoidal category, exchanging the middle factors of
$(X_1 ⊗ X_2) ⊗ (Y_1 ⊗ Y_2)$ by `tensorμ` and then braiding $X_1$ with $Y_1$ and $X_2$ with $Y_2$
equals braiding $X_1 ⊗ X_2$ with $Y_1 ⊗ Y_2$ and then exchanging the middle factors of
$(Y_1 ⊗ Y_2) ⊗ (X_1 ⊗ X_2)$. The right side braids $X_1$ past $Y_2$ and then $Y_2$ past $X_1$;
the proof uses that this double braiding is the identity. -/
@[reassoc]
theorem SymmetricCategory.tensorμ_comp_braiding_tensorHom_braiding {C : Type u₁}
    [Category.{v₁} C] [MonoidalCategory C] [SymmetricCategory C] (X₁ X₂ Y₁ Y₂ : C) :
    tensorμ X₁ X₂ Y₁ Y₂ ≫ ((β_ X₁ Y₁).hom ⊗ₘ (β_ X₂ Y₂).hom) =
      (β_ (X₁ ⊗ X₂) (Y₁ ⊗ Y₂)).hom ≫ tensorμ Y₁ Y₂ X₁ X₂ := by
  calc _ = 𝟙 _ ⊗≫ X₁ ◁ (β_ X₂ Y₁).hom ▷ Y₂ ⊗≫ (β_ X₁ Y₁).hom ▷ X₂ ▷ Y₂ ⊗≫
          Y₁ ◁ X₁ ◁ (β_ X₂ Y₂).hom ⊗≫ Y₁ ◁ ((β_ X₁ Y₂).hom ≫ (β_ Y₂ X₁).hom) ▷ X₂ ⊗≫ 𝟙 _ := by
        rw [SymmetricCategory.symmetry]
        simp only [tensorμ, tensorHom_def, MonoidalCategory.whiskerLeft_id, id_whiskerRight]
        monoidal
    _ = _ := by
        simp only [tensorμ, BraidedCategory.braiding_tensor_left_hom,
          BraidedCategory.braiding_tensor_right_hom]
        monoidal

namespace MonoidalCategory

variable {C : Type u₁} [Category.{v₁} C] [MonoidalCategory C]

/-- **A left tensor inverse is isomorphic to a right tensor inverse.** For isomorphisms
`e : X ⊗ M ≅ 𝟙_ C` and `f : N ⊗ X ≅ 𝟙_ C`, the isomorphism
$N \cong N ⊗ 𝟙 \cong N ⊗ (X ⊗ M) \cong (N ⊗ X) ⊗ M \cong 𝟙 ⊗ M \cong M$ built from the unitors,
the associator, `e` and `f`. -/
@[simps!]
def isoOfTensorIsoUnit {X M N : C} (e : X ⊗ M ≅ 𝟙_ C) (f : N ⊗ X ≅ 𝟙_ C) : N ≅ M :=
  (ρ_ N).symm ≪≫ whiskerLeftIso N e.symm ≪≫ (α_ N X M).symm ≪≫ whiskerRightIso f M ≪≫ λ_ M

end MonoidalCategory

namespace Functor.Monoidal

variable {C : Type u₁} [Category.{v₁} C] [MonoidalCategory C]
  {D : Type u₂} [Category.{v₂} D] [MonoidalCategory D]

/-- **A monoidal functor preserves tensor inverses.** For a monoidal functor `F : C ⥤ D` and an
isomorphism `e : X ⊗ M ≅ 𝟙_ C`, the isomorphism
$F(X) ⊗ F(M) \cong F(X ⊗ M) \cong F(𝟙) \cong 𝟙$ given by the tensor comparison of `F`, `F.mapIso e`
and the inverse of the unit comparison of `F`. Mathlib's `CategoryTheory.unitOfTensorIsoUnit` is
the same formula for a monoidal functor into a category of endofunctors. -/
@[simps!]
def mapTensorIsoUnit (F : C ⥤ D) [F.Monoidal] {X M : C} (e : X ⊗ M ≅ 𝟙_ C) :
    F.obj X ⊗ F.obj M ≅ 𝟙_ D :=
  μIso F X M ≪≫ F.mapIso e ≪≫ (εIso F).symm

end Functor.Monoidal

end CategoryTheory

namespace GLCinLean.CategoryTheory

open _root_.CategoryTheory MonoidalCategory Functor.LaxMonoidal Functor.OplaxMonoidal TauCeti

variable (C : Type u) [Category.{v} C] [MonoidalCategory C]

-- Reducible, as `TauCeti.tensorPow` is: statements use `(tensorPowFunctor C n).obj X` and
-- `tensorPow X n` interchangeably, and `simp` and `rw` need the two to agree at reducible
-- transparency. The cost: the instances on `tensorPowFunctor C n` have the discrimination tree key
-- `Functor.mk *`, so instance search tries them on every functor that is a structure literal
-- after reducible unfolding.
/-- The `n`-th tensor power functor of a monoidal category `C`: it sends an object `X` to
`TauCeti.tensorPow X n` and a morphism `f` to `TauCeti.tensorPowMap f n`, so that
$X^{\otimes 0} = 𝟙$, $X^{\otimes (n+1)} = X ⊗ X^{\otimes n}$, $f^{\otimes 0} = 𝟙_{𝟙}$ and
$f^{\otimes (n+1)} = f ⊗ f^{\otimes n}$. -/
@[reducible, simps]
def tensorPowFunctor (n : ℕ) : C ⥤ C where
  obj X := tensorPow X n
  map f := tensorPowMap f n
  map_id X := tensorPowMap_id X n
  map_comp f g := tensorPowMap_comp f g n

/-- The zeroth tensor power functor is the constant functor at `𝟙_ C`: the natural isomorphism
with identity components. -/
@[simps!]
def tensorPowFunctorZeroIso : (Functor.const C).obj (𝟙_ C) ≅ tensorPowFunctor C 0 :=
  NatIso.ofComponents (fun _ ↦ Iso.refl _) (by simp)

/-- The `(n + 1)`-th tensor power functor is the pairing of the identity functor with the `n`-th
tensor power functor, followed by the tensor product `C × C ⥤ C`: the natural isomorphism with
identity components. -/
@[simps!]
def tensorPowFunctorSuccIso (n : ℕ) :
    (𝟭 C).prod' (tensorPowFunctor C n) ⋙ tensor C ≅ tensorPowFunctor C (n + 1) :=
  NatIso.ofComponents (fun _ ↦ Iso.refl _) (by simp [tensorPowMap_succ])

section Braided

variable [BraidedCategory C]

/-- The monoidal structure of the `n`-th tensor power functor of a braided monoidal category `C`,
by recursion on `n`. For `n = 0` it is the monoidal structure of the constant functor at `𝟙_ C`
(`Functor.constTensorUnitCoreMonoidal`), transported along `tensorPowFunctorZeroIso`. For `n + 1`
it is the monoidal structure of `(𝟭 C).prod' (tensorPowFunctor C n) ⋙ tensor C`, built from the
structure for `n` and `MonoidalCategory.tensorMonoidal`, transported along
`tensorPowFunctorSuccIso`. The resulting comparisons are given by `tensorPowFunctor_ε_zero`,
`tensorPowFunctor_μ_zero`, `tensorPowFunctor_ε_succ` and `tensorPowFunctor_μ_succ`. -/
@[instance_reducible]
def tensorPowFunctorMonoidal : (n : ℕ) → (tensorPowFunctor C n).Monoidal
  | 0 => Functor.Monoidal.transport (tensorPowFunctorZeroIso C)
  | n + 1 =>
    letI := tensorPowFunctorMonoidal n
    Functor.Monoidal.transport (tensorPowFunctorSuccIso C n)

instance (n : ℕ) : (tensorPowFunctor C n).Monoidal := tensorPowFunctorMonoidal C n

/-- The unit comparison $𝟙 → 𝟙^{\otimes 0}$ is the identity. -/
@[simp] lemma tensorPowFunctor_ε_zero : ε (tensorPowFunctor C 0) = 𝟙 (𝟙_ C) :=
  (Functor.Monoidal.transport_ε (tensorPowFunctorZeroIso C)).trans (by simp)

/-- The inverse unit comparison $𝟙^{\otimes 0} → 𝟙$ is the identity. -/
@[simp] lemma tensorPowFunctor_η_zero : η (tensorPowFunctor C 0) = 𝟙 (𝟙_ C) :=
  (Functor.Monoidal.transport_η (tensorPowFunctorZeroIso C)).trans (by simp)

/-- The tensor comparison $X^{\otimes 0} ⊗ Y^{\otimes 0} → (X ⊗ Y)^{\otimes 0}$ is the left
unitor of `𝟙_ C`. -/
@[simp] lemma tensorPowFunctor_μ_zero (X Y : C) :
    μ (tensorPowFunctor C 0) X Y = (λ_ (𝟙_ C)).hom :=
  (Functor.Monoidal.transport_μ (tensorPowFunctorZeroIso C) X Y).trans (by simp)

/-- The inverse tensor comparison $(X ⊗ Y)^{\otimes 0} → X^{\otimes 0} ⊗ Y^{\otimes 0}$ is the
inverse left unitor of `𝟙_ C`. -/
@[simp] lemma tensorPowFunctor_δ_zero (X Y : C) :
    δ (tensorPowFunctor C 0) X Y = (λ_ (𝟙_ C)).inv :=
  (Functor.Monoidal.transport_δ (tensorPowFunctorZeroIso C) X Y).trans (by simp)

/-- The unit comparison for `n + 1` is $𝟙 ≅ 𝟙 ⊗ 𝟙 \xrightarrow{𝟙 ◁ ε_n} 𝟙 ⊗ 𝟙^{\otimes n}$. -/
lemma tensorPowFunctor_ε_succ (n : ℕ) :
    ε (tensorPowFunctor C (n + 1)) = (λ_ (𝟙_ C)).inv ≫ 𝟙_ C ◁ ε (tensorPowFunctor C n) :=
  (Functor.Monoidal.transport_ε (tensorPowFunctorSuccIso C n)).trans (by simp [tensorHom_def])

/-- The inverse unit comparison for `n + 1` is
$𝟙 ⊗ 𝟙^{\otimes n} \xrightarrow{𝟙 ◁ η_n} 𝟙 ⊗ 𝟙 ≅ 𝟙$. -/
lemma tensorPowFunctor_η_succ (n : ℕ) :
    η (tensorPowFunctor C (n + 1)) = 𝟙_ C ◁ η (tensorPowFunctor C n) ≫ (λ_ (𝟙_ C)).hom :=
  (Functor.Monoidal.transport_η (tensorPowFunctorSuccIso C n)).trans (by simp [tensorHom_def])

/-- The tensor comparison for `n + 1`: exchange the middle factors of
$(X ⊗ X^{\otimes n}) ⊗ (Y ⊗ Y^{\otimes n})$ by `tensorμ`, then apply the tensor comparison for
`n` to $X^{\otimes n} ⊗ Y^{\otimes n}$. -/
lemma tensorPowFunctor_μ_succ (n : ℕ) (X Y : C) :
    μ (tensorPowFunctor C (n + 1)) X Y =
      tensorμ X (tensorPow X n) Y (tensorPow Y n) ≫ (X ⊗ Y) ◁ μ (tensorPowFunctor C n) X Y :=
  (Functor.Monoidal.transport_μ (tensorPowFunctorSuccIso C n) X Y).trans (by simp [tensorHom_def])

/-- The inverse tensor comparison for `n + 1`: apply the inverse tensor comparison for `n` to
$(X ⊗ Y)^{\otimes n}$, then exchange the middle factors back by `tensorδ`. -/
lemma tensorPowFunctor_δ_succ (n : ℕ) (X Y : C) :
    δ (tensorPowFunctor C (n + 1)) X Y =
      (X ⊗ Y) ◁ δ (tensorPowFunctor C n) X Y ≫ tensorδ X (tensorPow X n) Y (tensorPow Y n) :=
  (Functor.Monoidal.transport_δ (tensorPowFunctorSuccIso C n) X Y).trans (by simp [tensorHom_def])

instance : NatTrans.IsMonoidal (tensorPowFunctorZeroIso C).hom :=
  Functor.Monoidal.natTransIsMonoidal_of_transport _

instance (n : ℕ) : NatTrans.IsMonoidal (tensorPowFunctorSuccIso C n).hom :=
  Functor.Monoidal.natTransIsMonoidal_of_transport _

end Braided

section Symmetric

variable [SymmetricCategory C]

/-- In a symmetric monoidal category, the tensor comparison of the `n`-th tensor power functor
commutes with the braiding: $μ_n(X, Y) ≫ (β_{X,Y})^{\otimes n} =
β_{X^{\otimes n}, Y^{\otimes n}} ≫ μ_n(Y, X)$. -/
lemma tensorPowFunctor_μ_comp_map_braiding (n : ℕ) (X Y : C) :
    μ (tensorPowFunctor C n) X Y ≫ (tensorPowFunctor C n).map (β_ X Y).hom =
      (β_ (tensorPow X n) (tensorPow Y n)).hom ≫ μ (tensorPowFunctor C n) Y X := by
  induction n with
  | zero => simp [unitors_equal, unitors_inv_equal]
  | succ n ih =>
    calc _ = tensorμ X (tensorPow X n) Y (tensorPow Y n) ≫
          ((β_ X Y).hom ⊗ₘ (μ (tensorPowFunctor C n) X Y ≫ tensorPowMap (β_ X Y).hom n)) := by
          simp [tensorPowFunctor_μ_succ, tensorPowMap_succ, ← id_tensorHom]
      _ = tensorμ X (tensorPow X n) Y (tensorPow Y n) ≫
          ((β_ X Y).hom ⊗ₘ (β_ (tensorPow X n) (tensorPow Y n)).hom) ≫
            (Y ⊗ X) ◁ μ (tensorPowFunctor C n) Y X := by
          rw [← tensorPowFunctor_map, ih, ← id_tensorHom, tensorHom_comp_tensorHom,
            Category.comp_id]
      _ = _ := by
          rw [SymmetricCategory.tensorμ_comp_braiding_tensorHom_braiding_assoc,
            tensorPowFunctor_μ_succ]

instance (n : ℕ) : (tensorPowFunctor C n).Braided where
  braided := tensorPowFunctor_μ_comp_map_braiding C n

end Symmetric

/-! ### Comparison with the isomorphisms of `TauCeti.tensorPow` -/

section Comparison

variable [BraidedCategory C]

/-- In a braided monoidal category, the unit comparison $ε_n : 𝟙 → 𝟙^{\otimes n}$ of the `n`-th
tensor power functor is the inverse of `TauCeti.tensorPowUnitIso n : tensorPow (𝟙_ C) n ≅ 𝟙_ C`.
-/
theorem tensorPowFunctor_ε (n : ℕ) : ε (tensorPowFunctor C n) = (tensorPowUnitIso n).inv := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [tensorPowFunctor_ε_succ, ih, tensorPowUnitIso_succ_inv, leftUnitor_inv_naturality]

/-- In a braided monoidal category, the unit isomorphism $𝟙 ≅ 𝟙^{\otimes n}$ of the `n`-th tensor
power functor is the inverse of `TauCeti.tensorPowUnitIso n`. -/
theorem tensorPowFunctor_εIso (n : ℕ) :
    Functor.Monoidal.εIso (tensorPowFunctor C n) = (tensorPowUnitIso n).symm :=
  Iso.ext (tensorPowFunctor_ε C n)

/-- In a braided monoidal category, the inverse unit comparison $η_n : 𝟙^{\otimes n} → 𝟙$ of the
`n`-th tensor power functor is `TauCeti.tensorPowUnitIso n`. -/
theorem tensorPowFunctor_η (n : ℕ) : η (tensorPowFunctor C n) = (tensorPowUnitIso n).hom := by
  rw [← Functor.Monoidal.εIso_inv, tensorPowFunctor_εIso, Iso.symm_inv]

/-- In a braided monoidal category `C`, the tensor comparison
$μ_n(X, Y) : X^{\otimes n} ⊗ Y^{\otimes n} → (X ⊗ Y)^{\otimes n}$ of the `n`-th tensor power
functor is the inverse of `TauCeti.tensorPowTensorIso X Y n` formed for the reverse braiding
`CategoryTheory.reverseBraiding C`, whose braiding $X ⊗ Y ≅ Y ⊗ X$ is $β_{Y,X}^{-1}$. The reason:
for `n + 1`, `μ` braids $X^{\otimes n}$ past `Y` by $β_{X^{\otimes n}, Y}$
(`tensorPowFunctor_μ_succ`), while the inverse of `TauCeti.tensorPowTensorIso X Y (n + 1)` uses
$β_{Y, X^{\otimes n}}^{-1}$ (`TauCeti.tensorPowTensorIso_succ_inv`). -/
theorem tensorPowFunctor_μ_eq_reverseBraiding_tensorPowTensorIso_inv (n : ℕ) (X Y : C) :
    μ (tensorPowFunctor C n) X Y =
      (@tensorPowTensorIso C _ _ (reverseBraiding C) X Y n).inv := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [tensorPowFunctor_μ_succ, ih, @tensorPowTensorIso_succ_inv C _ _ (reverseBraiding C)]
    rfl

end Comparison

section SymmetricComparison

variable [SymmetricCategory C]

/-- In a symmetric monoidal category, the tensor comparison
$μ_n(X, Y) : X^{\otimes n} ⊗ Y^{\otimes n} → (X ⊗ Y)^{\otimes n}$ of the `n`-th tensor power
functor is the inverse of `TauCeti.tensorPowTensorIso X Y n`.

In a braided monoidal category that is not symmetric, the two can differ: `μ_n(X, Y)` is the
inverse of `TauCeti.tensorPowTensorIso X Y n` for the reverse braiding
(`tensorPowFunctor_μ_eq_reverseBraiding_tensorPowTensorIso_inv`). For `n + 1`, the comparison
`μ` uses the braiding $β_{X^{\otimes n}, Y}$, and the inverse of
`TauCeti.tensorPowTensorIso X Y (n + 1)` uses $β_{Y, X^{\otimes n}}^{-1}$. The two are equal
when `C` is symmetric. -/
theorem tensorPowFunctor_μ (n : ℕ) (X Y : C) :
    μ (tensorPowFunctor C n) X Y = (tensorPowTensorIso X Y n).inv := by
  rw [tensorPowFunctor_μ_eq_reverseBraiding_tensorPowTensorIso_inv,
    SymmetricCategory.reverseBraiding_eq]

/-- In a symmetric monoidal category, the tensor isomorphism
$X^{\otimes n} ⊗ Y^{\otimes n} ≅ (X ⊗ Y)^{\otimes n}$ of the `n`-th tensor power functor is the
inverse of `TauCeti.tensorPowTensorIso X Y n`. As for `tensorPowFunctor_μ`, the two
can differ when `C` is braided and not symmetric. -/
theorem tensorPowFunctor_μIso (n : ℕ) (X Y : C) :
    Functor.Monoidal.μIso (tensorPowFunctor C n) X Y = (tensorPowTensorIso X Y n).symm :=
  Iso.ext (tensorPowFunctor_μ C n X Y)

/-- In a symmetric monoidal category, the inverse tensor comparison
$δ_n(X, Y) : (X ⊗ Y)^{\otimes n} → X^{\otimes n} ⊗ Y^{\otimes n}$ of the `n`-th tensor power
functor is `TauCeti.tensorPowTensorIso X Y n`. As for `tensorPowFunctor_μ`, the two
can differ when `C` is braided and not symmetric. -/
theorem tensorPowFunctor_δ (n : ℕ) (X Y : C) :
    δ (tensorPowFunctor C n) X Y = (tensorPowTensorIso X Y n).hom := by
  rw [← Functor.Monoidal.μIso_inv, tensorPowFunctor_μIso, Iso.symm_inv]

end SymmetricComparison

/-- The first tensor power functor is isomorphic to the identity functor, by the right unitors
$X ⊗ 𝟙 ≅ X$. For a braided `C` this is a monoidal isomorphism. -/
@[simps!]
def tensorPowFunctorOneIso : tensorPowFunctor C 1 ≅ 𝟭 C :=
  NatIso.ofComponents (fun X ↦ ρ_ X) (fun f ↦ by simp [tensorPowMap_succ])

instance [BraidedCategory C] : NatTrans.IsMonoidal (tensorPowFunctorOneIso C).hom where
  unit := by simp [tensorPowFunctor_ε_succ, unitors_inv_equal]
  tensor X Y := by simp [tensorPowFunctor_μ_succ, rightUnitor_monoidal]

section Comp

variable {C} {D : Type u₁} [Category.{v₁} D] [MonoidalCategory D] (G : C ⥤ D)

section Monoidal

variable [G.Monoidal]

/-- For a monoidal functor `G : C ⥤ D`, the isomorphism $G(X^{\otimes n}) ≅ G(X)^{\otimes n}$,
natural in `X`, by recursion on `n`: for `n = 0` it is the inverse of the unit comparison
$𝟙 ≅ G(𝟙)$ of `G`, and for `n + 1` it is
$G(X ⊗ X^{\otimes n}) ≅ G(X) ⊗ G(X^{\otimes n}) ≅ G(X) ⊗ G(X)^{\otimes n}$, the inverse of the
tensor comparison of `G` followed by the isomorphism for `n`. When `C`, `D` and `G` are braided
it is a monoidal isomorphism (`isMonoidal_tensorPowFunctorCompIso_hom`). -/
def tensorPowFunctorCompIso : (n : ℕ) → tensorPowFunctor C n ⋙ G ≅ G ⋙ tensorPowFunctor D n
  | 0 => NatIso.ofComponents (fun _ ↦ (Functor.Monoidal.εIso G).symm) (by simp)
  | n + 1 => NatIso.ofComponents
      (fun X ↦ (Functor.Monoidal.μIso G X (tensorPow X n)).symm ≪≫
        whiskerLeftIso (G.obj X) ((tensorPowFunctorCompIso n).app X))
      (fun {X Y} f ↦ by
        have h := (tensorPowFunctorCompIso n).hom.naturality f
        dsimp at h ⊢
        simp only [tensorPowMap_succ, Category.assoc, whiskerLeftIso_hom, Iso.app_hom,
          ← id_tensorHom, tensorHom_comp_tensorHom, Category.id_comp]
        rw [← δ_natural_assoc, tensorHom_comp_tensorHom, Category.comp_id, h])

@[simp] lemma tensorPowFunctorCompIso_hom_app_zero (X : C) :
    (tensorPowFunctorCompIso G 0).hom.app X = η G := rfl

@[simp] lemma tensorPowFunctorCompIso_inv_app_zero (X : C) :
    (tensorPowFunctorCompIso G 0).inv.app X = ε G := rfl

@[simp] lemma tensorPowFunctorCompIso_hom_app_succ (n : ℕ) (X : C) :
    (tensorPowFunctorCompIso G (n + 1)).hom.app X =
      δ G X (tensorPow X n) ≫ G.obj X ◁ (tensorPowFunctorCompIso G n).hom.app X := rfl

@[simp] lemma tensorPowFunctorCompIso_inv_app_succ (n : ℕ) (X : C) :
    (tensorPowFunctorCompIso G (n + 1)).inv.app X =
      G.obj X ◁ (tensorPowFunctorCompIso G n).inv.app X ≫ μ G X (tensorPow X n) := rfl

end Monoidal

section Braided

variable [BraidedCategory C] [BraidedCategory D] [G.Braided]

/-- For a braided monoidal functor `G` between braided monoidal categories, the isomorphism
$G(X)^{\otimes n} ≅ G(X^{\otimes n})$ is monoidal. -/
instance isMonoidal_tensorPowFunctorCompIso_inv (n : ℕ) :
    NatTrans.IsMonoidal (tensorPowFunctorCompIso G n).inv := by
  induction n with
  | zero =>
    refine { unit := by simp, tensor X Y := ?_ }
    simp only [Functor.comp_obj, tensorPowFunctor_obj, comp_μ, tensorPowFunctor_μ_zero,
      tensorPowMap_zero, tensorPowFunctorCompIso_inv_app_zero, Category.comp_id]
    rw [tensorHom_def', Category.assoc, ← Functor.LaxMonoidal.left_unitality,
      leftUnitor_naturality]
  | succ n ih =>
    refine { unit := ?_, tensor X Y := ?_ }
    · have h := ih.unit
      simp only [comp_ε, Functor.comp_obj, tensorPowFunctor_obj, Category.assoc] at h
      calc _ = (λ_ (𝟙_ D)).inv ≫ (ε G ⊗ₘ (ε (tensorPowFunctor D n) ≫
            tensorPowMap (ε G) n ≫ (tensorPowFunctorCompIso G n).inv.app (𝟙_ C))) ≫
              μ G (𝟙_ C) (tensorPow (𝟙_ C) n) := by
            simp only [comp_ε, tensorPowFunctor_ε_succ, tensorPowFunctorCompIso_inv_app_succ,
              Functor.comp_obj, tensorPowFunctor_obj, tensorPowMap_succ, Category.assoc,
              ← id_tensorHom, tensorHom_comp_tensorHom_assoc, Category.id_comp,
              Category.comp_id]
        _ = (λ_ (𝟙_ D)).inv ≫ (ε G ⊗ₘ (ε G ≫ G.map (ε (tensorPowFunctor C n)))) ≫
              μ G (𝟙_ C) (tensorPow (𝟙_ C) n) := by
            rw [h]
        _ = _ := by
            rw [comp_ε, tensorPowFunctor_ε_succ, ← leftUnitor_inv_naturality, Functor.map_comp,
              ← left_unitality_inv]
            simp only [tensorHom_def', MonoidalCategory.whiskerLeft_comp, Category.assoc,
              leftUnitor_inv_naturality_assoc]
    · have h := ih.tensor X Y
      simp only [comp_μ, Functor.comp_obj, tensorPowFunctor_obj, Category.assoc] at h
      calc _ = tensorμ (G.obj X) (tensorPow (G.obj X) n) (G.obj Y) (tensorPow (G.obj Y) n) ≫
            (μ G X Y ⊗ₘ (μ (tensorPowFunctor D n) (G.obj X) (G.obj Y) ≫
              tensorPowMap (μ G X Y) n ≫ (tensorPowFunctorCompIso G n).inv.app (X ⊗ Y))) ≫
                μ G (X ⊗ Y) (tensorPow (X ⊗ Y) n) := by
            simp only [comp_μ, tensorPowFunctor_μ_succ, tensorPowFunctorCompIso_inv_app_succ,
              Functor.comp_obj, tensorPowFunctor_obj, tensorPowMap_succ, Category.assoc,
              ← id_tensorHom, tensorHom_comp_tensorHom_assoc, Category.id_comp,
              Category.comp_id]
        _ = tensorμ (G.obj X) (tensorPow (G.obj X) n) (G.obj Y) (tensorPow (G.obj Y) n) ≫
            (μ G X Y ⊗ₘ (((tensorPowFunctorCompIso G n).inv.app X ⊗ₘ
              (tensorPowFunctorCompIso G n).inv.app Y) ≫ μ G (tensorPow X n) (tensorPow Y n) ≫
                G.map (μ (tensorPowFunctor C n) X Y))) ≫
                  μ G (X ⊗ Y) (tensorPow (X ⊗ Y) n) := by
            rw [h]
        _ = _ := by
          -- `G` is braided: Mathlib's coherence `tensorμ_comp_μ_tensorHom_μ_comp_μ`.
          rw [comp_μ, tensorPowFunctor_μ_succ, tensorPowFunctorCompIso_inv_app_succ,
            tensorPowFunctorCompIso_inv_app_succ, Functor.map_comp,
            ← tensorHom_comp_tensorHom_assoc, ← tensorμ_comp_μ_tensorHom_μ_comp_μ_assoc,
            ← μ_natural_right, ← id_tensorHom (G.obj X), ← id_tensorHom (G.obj Y)]
          simp only [Functor.comp_obj, tensorPowFunctor_obj]
          rw [tensorμ_natural_assoc]
          simp only [← id_tensorHom, tensorHom_comp_tensorHom_assoc, Category.id_comp,
            Category.comp_id, id_tensorHom_id]

/-- For a braided monoidal functor `G` between braided monoidal categories, the isomorphism
$G(X^{\otimes n}) ≅ G(X)^{\otimes n}$ is monoidal. -/
instance isMonoidal_tensorPowFunctorCompIso_hom (n : ℕ) :
    NatTrans.IsMonoidal (tensorPowFunctorCompIso G n).hom :=
  have : NatTrans.IsMonoidal (tensorPowFunctorCompIso G n).symm.hom :=
    isMonoidal_tensorPowFunctorCompIso_inv G n
  inferInstanceAs (NatTrans.IsMonoidal (tensorPowFunctorCompIso G n).symm.inv)

end Braided

end Comp

section Inverse

variable {C} [BraidedCategory C]

/-- **The tensor power functor preserves tensor inverses.** For `e : X ⊗ M ≅ 𝟙_ C` in a braided
monoidal category, the isomorphism $X^{\otimes n} ⊗ M^{\otimes n} ≅ 𝟙$ given by the monoidal
structure of the tensor power functor (`Functor.Monoidal.mapTensorIsoUnit`): the tensor comparison
$μ_n(X, M)$, then $e^{\otimes n}$, then the inverse of the unit comparison $ε_n$. For a two-sided
inverse of `X`, with isomorphisms `X ⊗ M ≅ 𝟙_ C` and `M ⊗ X ≅ 𝟙_ C`, it gives a two-sided inverse
`tensorPow M n` of `tensorPow X n` when applied to both isomorphisms. -/
@[simps!]
def tensorPowTensorIsoUnit {X M : C} (e : X ⊗ M ≅ 𝟙_ C) (n : ℕ) :
    tensorPow X n ⊗ tensorPow M n ≅ 𝟙_ C :=
  Functor.Monoidal.mapTensorIsoUnit (tensorPowFunctor C n) e

/-- The comparison $(X^{\otimes n})^{-1} ≅ (X^{-1})^{\otimes n}$ in a braided monoidal category,
for tensor inverses given by isomorphisms. For `e : X ⊗ M ≅ 𝟙_ C` and
`f : N ⊗ tensorPow X n ≅ 𝟙_ C`, the isomorphism `N ≅ tensorPow M n` is
`MonoidalCategory.isoOfTensorIsoUnit` of `tensorPowTensorIsoUnit e n` and `f`. The braiding
enters only through the tensor comparison $μ_n$ of the tensor power functor. In any monoidal
category, $X^{\otimes n}$ has the inverse $M^{\otimes n}$ by another isomorphism, built from `e`
and the associators without the braiding; this one is chosen to be compatible with the monoidal
structure of the functor. -/
def tensorPowInverseIso {X M N : C} (e : X ⊗ M ≅ 𝟙_ C) (n : ℕ) (f : N ⊗ tensorPow X n ≅ 𝟙_ C) :
    N ≅ tensorPow M n :=
  isoOfTensorIsoUnit (tensorPowTensorIsoUnit e n) f

/-- The comparison $N ≅ M^{\otimes n}$ of `tensorPowInverseIso`, as a morphism: insert
$𝟙 ≅ X^{\otimes n} ⊗ M^{\otimes n}$ on the right of `N`, reassociate, and contract
$N ⊗ X^{\otimes n}$ by `f`. -/
lemma tensorPowInverseIso_hom {X M N : C} (e : X ⊗ M ≅ 𝟙_ C) (n : ℕ)
    (f : N ⊗ tensorPow X n ≅ 𝟙_ C) :
    (tensorPowInverseIso e n f).hom =
      (ρ_ N).inv ≫ N ◁ (tensorPowTensorIsoUnit e n).inv ≫
        (α_ N (tensorPow X n) (tensorPow M n)).inv ≫ f.hom ▷ tensorPow M n ≫
          (λ_ (tensorPow M n)).hom :=
  rfl

/-- For `n = 0` the comparison $N ≅ 𝟙$ of `tensorPowInverseIso` is `f` after the right unitor. -/
@[simp]
lemma tensorPowInverseIso_zero_hom {X M N : C} (e : X ⊗ M ≅ 𝟙_ C)
    (f : N ⊗ tensorPow X 0 ≅ 𝟙_ C) :
    (tensorPowInverseIso e 0 f).hom = (ρ_ N).inv ≫ f.hom := by
  simp [tensorPowInverseIso, unitors_equal]

end Inverse

/-! ### Examples -/

/-- The tensor powers of an object with a two-sided tensor inverse have a two-sided tensor
inverse. -/
example [BraidedCategory C] {X M : C} (e₁ : X ⊗ M ≅ 𝟙_ C) (e₂ : M ⊗ X ≅ 𝟙_ C) (n : ℕ) :
    (tensorPow X n ⊗ tensorPow M n ≅ 𝟙_ C) × (tensorPow M n ⊗ tensorPow X n ≅ 𝟙_ C) :=
  ⟨tensorPowTensorIsoUnit e₁ n, tensorPowTensorIsoUnit e₂ n⟩

/-- The comparison of `tensorPowInverseIso` for `n = 0` and the inverse `𝟙_ C` of `𝟙_ C`, given
by the left unitor, is the identity of `𝟙_ C`. -/
example [BraidedCategory C] {X M : C} (e : X ⊗ M ≅ 𝟙_ C) :
    (tensorPowInverseIso e 0 (λ_ (𝟙_ C))).hom = 𝟙 (𝟙_ C) := by
  simp [unitors_equal]

/-- A composite of tensor power functors of a symmetric monoidal category is braided. -/
example [SymmetricCategory C] (m n : ℕ) :
    (tensorPowFunctor C m ⋙ tensorPowFunctor C n).Braided :=
  inferInstance

/-- In the category of types, the second tensor power of a function acts on each factor. -/
example {X Y : Type u} (f : X ⟶ Y) (a b : X) :
    (tensorPowFunctor (Type u) 2).map f (a, b, PUnit.unit) = (f a, f b, PUnit.unit) := by
  rw [tensorPowFunctor_map, tensorPowMap_succ, tensorPowMap_succ, tensorPowMap_zero]
  rfl

/-- In the category of types, the tensor comparison of the second tensor power interleaves the
factors: $((x_1, x_2), (y_1, y_2)) \mapsto ((x_1, y_1), (x_2, y_2))$. This excludes a comparison
that pairs the factors in another way. Since `Type` is symmetric, it cannot tell the braiding from
its inverse; the direction of the braiding is fixed by `tensorPowFunctor_μ_succ`. -/
example (X Y : Type u) (x₁ x₂ : X) (y₁ y₂ : Y) :
    μ (tensorPowFunctor (Type u) 2) X Y ((x₁, x₂, PUnit.unit), (y₁, y₂, PUnit.unit)) =
      ((x₁, y₁), (x₂, y₂), PUnit.unit) := by
  rw [tensorPowFunctor_μ_succ, tensorPowFunctor_μ_succ, tensorPowFunctor_μ_zero]
  rfl

/-- In the category of types, the isomorphism of the first tensor power with the identity
forgets the unit factor. -/
example (X : Type u) (x : X) : (tensorPowFunctorOneIso (Type u)).hom.app X (x, PUnit.unit) = x :=
  rfl

end GLCinLean.CategoryTheory
