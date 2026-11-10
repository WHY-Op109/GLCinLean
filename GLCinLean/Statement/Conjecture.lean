/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5, GPT-6, Claude Fable 5.2
-/
module

public import GLCinLean.Statement.Enhanced
public import Mathlib.AlgebraicGeometry.Morphisms.Smooth
public import Mathlib.AlgebraicGeometry.Morphisms.Proper
public import Mathlib.FieldTheory.IsAlgClosed.Basic
public import TauCeti.Algebra.AlgebraicGroup.Pinning.Basic
public import TauCeti.AlgebraicGeometry.LineBundle.TensorProduct
public import TauCeti.AlgebraicGeometry.Modules.Differentials.Basic

/-!
# The de Rham geometric Langlands statement

The statement combines existence in [GLC1] Cor. 1.6.5 with Conj. 1.6.7: a continuous functor
with the two characterizing properties exists, and every such functor is an equivalence.
The second property is stated with the Hecke action of `Rep(Ǧ)_Ran` ([GLC1] §1.2.1), in a
form that agrees with the paper's by [GLC1] Thm. 1.2.4; see `IsLanglandsFunctor`.
The mathematical objects of the statement include explicit placeholders.

[GLC1] §0.1.1 asks only for a ground field of characteristic zero; its conventions follow
[AGKRRV] ([GLC1] §0.5.7), whose ground field is algebraically closed ([AGKRRV] §0.9.1).
Algebraic closedness here is the scope of this project, as in [GLC2] §0.4.1, and not a
hypothesis that [GLC1] §0.1.1 states. The curve is connected, as in [AGKRRV] §14.1.1.
Reductive groups use Tau Ceti's coordinate Hopf algebra presentation. A pinning and a theta
characteristic are chosen data.
-/

@[expose] public noncomputable section

namespace GLCinLean.Statement

open CategoryTheory AlgebraicGeometry

universe u

/-- Identification of the root datum of `Gd` with the dual root datum of `G`
([GLC1] §0.1.1). Both groups are represented by their coordinate Hopf algebras. -/
@[placeholder] opaque RootDatumDuality {k : Type u} [Field k] :
    TauCeti.ReductiveCommHopfAlgCat k → TauCeti.ReductiveCommHopfAlgCat k → Type u

/-- Standing geometric data for [GLC1] §§1.1–1.3: a smooth proper connected curve,
a pinned reductive group, a theta characteristic and an identified Langlands dual group.
The theta characteristic is a line bundle together with its squaring isomorphism. -/
@[placeholder] structure Setting (k : Type u) [Field k] [CharZero k] [IsAlgClosed k] where
  /-- The curve. -/
  X : Scheme.{u}
  [over : X.Over (Spec (.of k))]
  [smooth : SmoothOfRelativeDimension 1 (X ↘ Spec (.of k))]
  [proper : IsProper (X ↘ Spec (.of k))]
  [connected : ConnectedSpace X]
  /-- The coordinate Hopf algebra of the reductive group. -/
  G : TauCeti.ReductiveCommHopfAlgCat k
  /-- The rank of the split maximal torus of the pinning. -/
  rank : ℕ
  /-- The pinning, with smoothness supplied by reductivity. -/
  pinning : @TauCeti.Pinning k _ G.obj.obj _ G.property.smooth _ rank
  /-- The chosen theta characteristic. -/
  sqrtOmega : TauCeti.AlgebraicGeometry.InvertibleSheaf X
  /-- Its squaring isomorphism with the canonical line bundle of the curve. -/
  sqrtOmegaIso : (sqrtOmega.tensorProduct sqrtOmega).obj ≅ X.relativeDifferentials k
  /-- The coordinate Hopf algebra of the Langlands dual group. -/
  dualGroup : TauCeti.ReductiveCommHopfAlgCat k
  /-- The chosen dual-root-datum identification. -/
  dualIdentification : RootDatumDuality G dualGroup

attribute [instance] Setting.over Setting.smooth Setting.proper Setting.connected

variable {k : Type u} [Field k] [CharZero k] [IsAlgClosed k]

/-- The DG category `QCoh(LS_Ǧ)` of quasi-coherent sheaves on the derived stack of de Rham
local systems ([GLC1] §§0.1.1, 1.2.2). -/
@[placeholder] opaque QCohLS (S : Setting k) : DGCat k

/-- The DG category `Dmod_½(Bun_G)` of half-twisted D-modules on `Bun_G`
([GLC1] §§1.1.1–1.1.5). The twist is the gerbe of square roots of `det_BunG`; the chosen
theta characteristic trivializes it. -/
@[placeholder] opaque DmodHalf (S : Setting k) : DGCat k

/-- Ind-coherent sheaves with nilpotent singular support on the derived local-system stack,
with their standard t-structure ([GLC1] §1.6.3; [ArinkinGaitsgory] §11.1.5). -/
@[placeholder] opaque IndCohNilp (S : Setting k) : TStructuredDGCat k

/-- The continuous coarsening functor `Ψ_Nilp,{0} : IndCoh_Nilp(LS_Ǧ) → QCoh(LS_Ǧ)`
([GLC1] §1.6.3; [ArinkinGaitsgory] Prop. 4.4.5). -/
@[placeholder] opaque Psi (S : Setting k) : DGFun (IndCohNilp S).toDGCat (QCohLS S)

/-- The DG category `Rep(Ǧ)_Ran`: the de Rham version of the category `Rep(Ǧ)` spread over
the Ran space of the curve ([GLC1] §1.2.1; [GaitsgoryOutline] §4.2). -/
@[placeholder] opaque RepRan (S : Setting k) : DGCat k

/-- The spectral localization functor `Loc_Ǧ^spec : Rep(Ǧ)_Ran → QCoh(LS_Ǧ)`
([GLC1] §1.2.2; [GaitsgoryOutline] §4.3). -/
@[placeholder] opaque Loc (S : Setting k) : DGFun (RepRan S) (QCohLS S)

/-- The Hecke action of `Rep(Ǧ)_Ran` on `Dmod_½(Bun_G)`, defined by the naive geometric
Satake functor and the Hecke functors ([GLC1] §1.2.1), on a fixed object `M`:
the continuous functor `V ↦ V ⋆ M`. -/
@[placeholder] opaque heckeActionRight (S : Setting k) (M : (DmodHalf S).Obj) :
    DGFun (RepRan S) (DmodHalf S)

/-- The vacuum Poincaré object `Poinc^{Vac,glob}_{G,!} = 𝔭_! χ^*(exp)` of `Dmod_½(Bun_G)`
([GLC1] §1.3.7). -/
@[placeholder] opaque vacuumPoincare (S : Setting k) : (DmodHalf S).Obj

/-- The two characterizing properties of [GLC1] Cor. 1.6.5, for a continuous functor `F`
from `Dmod_½(Bun_G)` to `IndCoh_Nilp(LS_Ǧ)`.

1. `F` sends compact objects to bounded-below objects. The bound may depend on the object.
2. There is an equivalence `Maps(V ⋆ Poinc, M) ≃ Maps(Loc V, Ψ (F M))` of mapping spaces,
   natural in `V` in `Rep(Ǧ)_Ran` and `M` in `Dmod_½(Bun_G)` together, where `Poinc` is the
   vacuum Poincaré object.

The second property is the paper's `Ψ ∘ F ≃ 𝕃_{G,coarse}`, as an equivalence of functors of
∞-categories, in an equal form. The two forms agree by [GLC1] Thm. 1.2.4: the Hecke action
factors through `Loc`, so that `V ⋆ Poinc ≃ Loc V ⋆ Poinc` for the action of `QCoh(LS_Ǧ)`
([GLC1] §1.2.5); `𝕃_{G,coarse}` is right adjoint to `E ↦ E ⋆ Poinc` ([GLC1] §§1.4.1–1.4.5);
and the right adjoint of `Loc` is fully faithful ([GLC1] §1.2.2). This form uses neither the
action of `QCoh(LS_Ǧ)` nor `𝕃_{G,coarse}`.

Mapping spaces do not record `k`-linearity. An equivalence `Ψ ∘ F ≃ 𝕃_{G,coarse}` of
`k`-linear functors gives the second property, and the second property gives it back as an
equivalence of functors of ∞-categories. Each functor with the two properties is naturally
equivalent, as a functor of ∞-categories, to the functor `𝕃_G` of [GLC1] Cor. 1.6.5, so it is
an equivalence exactly when `𝕃_G` is. -/
@[placeholder] def IsLanglandsFunctor (S : Setting k)
    (F : DGFun (DmodHalf S) (IndCohNilp S).toDGCat) : Prop :=
  (∀ c : (DmodHalf S).Obj,
    DGCat.IsCompact c → (IndCohNilp S).IsEventuallyCoconnective (F.obj c)) ∧
      Nonempty (DGFun.MapsEquiv (heckeActionRight S (vacuumPoincare S)) (Loc S)
        (F.comp (Psi S)))

/-- Introduction and elimination of the two characterizing properties
([GLC1] Cor. 1.6.5). -/
theorem isLanglandsFunctor_iff (S : Setting k)
    (F : DGFun (DmodHalf S) (IndCohNilp S).toDGCat) :
    IsLanglandsFunctor S F ↔
      (∀ c : (DmodHalf S).Obj,
        DGCat.IsCompact c → (IndCohNilp S).IsEventuallyCoconnective (F.obj c)) ∧
          Nonempty (DGFun.MapsEquiv (heckeActionRight S (vacuumPoincare S)) (Loc S)
            (F.comp (Psi S))) := Iff.rfl

/-- The de Rham geometric Langlands conjecture, in its characterized-functor form:
a continuous functor with the two properties of [GLC1] Cor. 1.6.5 exists, and every such
functor is an equivalence ([GLC1] Conj. 1.6.7). The second property is in its equal form
with the Hecke action; see `IsLanglandsFunctor`. -/
theorem exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence
    (S : Setting k) :
    (∃ F : DGFun (DmodHalf S) (IndCohNilp S).toDGCat, IsLanglandsFunctor S F) ∧
      ∀ F : DGFun (DmodHalf S) (IndCohNilp S).toDGCat,
        IsLanglandsFunctor S F → F.IsEquivalence := sorry

end GLCinLean.Statement

end
