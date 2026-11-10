/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5, GPT-6
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

The statement combines existence in [GLC1] Cor. 1.6.5, linearity in Prop. 1.7.2 and
Conj. 1.6.7: a functor with the two characterizing properties exists, and every such
functor is an equivalence. Its mathematical objects include explicit placeholders.

The ground field is algebraically closed of characteristic zero and the curve is connected,
as in [AGKRRV] §§0.9.1, 14.1.1 and [GLC2] §0.4.1. Reductive groups use Tau Ceti's
coordinate Hopf algebra presentation. A pinning and a theta characteristic are chosen data.
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

/-- The monoidal DG category `QCoh(LS_Ǧ)` of the derived stack of de Rham local systems
([GLC1] §§0.1.1, 1.2.2). -/
@[placeholder] opaque QCohLS (S : Setting k) : MonoidalDGCat k

/-- Half-twisted D-modules on `Bun_G`, with its spectral `QCoh(LS_Ǧ)`-action
([GLC1] §§1.1.1–1.1.4, Thm. 1.2.4). The twist is the gerbe of square roots of
`det_BunG`; the chosen theta characteristic trivializes it. -/
@[placeholder] opaque DmodHalf (S : Setting k) : DGModule (QCohLS S)

/-- Ind-coherent sheaves with nilpotent singular support on the derived local-system stack,
with their `QCoh(LS_Ǧ)`-action and standard t-structure
([GLC1] §1.6.3; [ArinkinGaitsgory] §11.1.5). -/
@[placeholder] opaque IndCohNilp (S : Setting k) : TStructuredDGModule (QCohLS S)

/-- The continuous linear coarsening functor `Ψ_Nilp,{0}`
([GLC1] §1.6.3; [ArinkinGaitsgory] Prop. 4.4.5). -/
@[placeholder] opaque Psi (S : Setting k) :
    LinFun (IndCohNilp S).toModule (QCohLS S).regularModule

/-- The coarse Langlands functor, right adjoint to the spectral action on the vacuum
Poincaré object ([GLC1] §§1.4.1–1.4.5). -/
@[placeholder] opaque LCoarse (S : Setting k) :
    LinFun (DmodHalf S) (QCohLS S).regularModule

/-- The two characterizing properties of [GLC1] Cor. 1.6.5, for the continuous linear
functors of Prop. 1.7.2: compact objects have bounded-below images and coarsening
is naturally equivalent to the coarse Langlands functor. The bound may depend on the object. -/
@[placeholder] def IsLanglandsFunctor (S : Setting k)
    (F : LinFun (DmodHalf S) (IndCohNilp S).toModule) : Prop :=
  (∀ c : (DmodHalf S).toDGCat.Obj,
    DGCat.IsCompact c → (IndCohNilp S).IsEventuallyCoconnective (F.obj c)) ∧
      Nonempty (LinIso (F.comp (Psi S)) (LCoarse S))

/-- Introduction and elimination of the two characterizing properties
([GLC1] Cor. 1.6.5 and Prop. 1.7.2). -/
theorem isLanglandsFunctor_iff (S : Setting k)
    (F : LinFun (DmodHalf S) (IndCohNilp S).toModule) :
    IsLanglandsFunctor S F ↔
      (∀ c : (DmodHalf S).toDGCat.Obj,
        DGCat.IsCompact c → (IndCohNilp S).IsEventuallyCoconnective (F.obj c)) ∧
          Nonempty (LinIso (F.comp (Psi S)) (LCoarse S)) := Iff.rfl

/-- The de Rham geometric Langlands conjecture, in its characterized-functor form:
a continuous linear functor with the properties of [GLC1] Cor. 1.6.5 exists, and every
such functor is an equivalence ([GLC1] Conj. 1.6.7 and Prop. 1.7.2). -/
theorem exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence
    (S : Setting k) :
    (∃ F : LinFun (DmodHalf S) (IndCohNilp S).toModule, IsLanglandsFunctor S F) ∧
      ∀ F : LinFun (DmodHalf S) (IndCohNilp S).toModule,
        IsLanglandsFunctor S F → F.IsEquivalence := sorry

end GLCinLean.Statement

end
