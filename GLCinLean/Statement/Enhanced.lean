/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5, GPT-6, Claude Fable 5.2
-/
module

public import GLCinLean.Placeholder
public import Mathlib.Algebra.Field.Defs

/-!
# Enhanced categories in the statement

The placeholders here stand for the enhanced categories of [AGKRRV] §§0.9.2–0.9.5:
DG categories, their objects and mapping spaces, continuous functors, natural equivalences
and t-structures. They retain the ground field and the choice of t-structure as parameters.
They impose no categorical laws and do not define an enhanced category theory.

The nonempty carriers stand for collections containing a zero category, object or functor.
No inhabitant is supplied for a specified natural equivalence, equivalence of mapping spaces
or compactness predicate.
-/

@[expose] public noncomputable section

namespace GLCinLean.Statement

universe u

/-- The carrier of presentable stable `k`-linear enhanced categories ([AGKRRV] §0.9.4). -/
@[placeholder] opaque DGCatCarrier (k : Type u) [Field k] : NonemptyType.{u + 2}

/-- Presentable stable `k`-linear enhanced categories ([AGKRRV] §0.9.4). -/
@[placeholder] def DGCat (k : Type u) [Field k] : Type (u + 2) := (DGCatCarrier k).type

instance (k : Type u) [Field k] : Nonempty (DGCat k) := (DGCatCarrier k).property

/-- The carrier of DG categories with a chosen t-structure
([GLC1] §1.6.3; [AGKRRV] §§0.9.4–0.9.5). -/
@[placeholder] opaque TStructuredDGCatCarrier (k : Type u) [Field k] : NonemptyType.{u + 2}

/-- A DG category with a chosen t-structure ([GLC1] §1.6.3; [AGKRRV] §0.9.5).
The choice is part of the object; no t-structure on an arbitrary DG category is asserted. -/
@[placeholder] def TStructuredDGCat (k : Type u) [Field k] : Type (u + 2) :=
  (TStructuredDGCatCarrier k).type

instance (k : Type u) [Field k] : Nonempty (TStructuredDGCat k) :=
  (TStructuredDGCatCarrier k).property

variable {k : Type u} [Field k]

/-- The carrier of objects in an enhanced category ([AGKRRV] §0.9.2). -/
@[placeholder] opaque DGCat.objCarrier (C : DGCat k) : NonemptyType.{u + 1}

/-- Objects of an enhanced category ([AGKRRV] §0.9.2). -/
@[placeholder] def DGCat.Obj (C : DGCat k) : Type (u + 1) := C.objCarrier.type

instance (C : DGCat k) : Nonempty C.Obj := C.objCarrier.property

/-- Compactness: mapping out preserves filtered colimits ([AGKRRV] §0.9.2). -/
@[placeholder] opaque DGCat.IsCompact {C : DGCat k} : C.Obj → Prop

/-- Forgetting the chosen t-structure ([GLC1] §1.6.3). -/
@[placeholder] opaque TStructuredDGCat.toDGCat (C : TStructuredDGCat k) : DGCat k

/-- Boundedness below for the chosen t-structure, with a bound depending on the object:
membership in `C^{>-∞}` ([GLC1] §1.6.3 and Cor. 1.6.5; [AGKRRV] §0.9.5). -/
@[placeholder] opaque TStructuredDGCat.IsEventuallyCoconnective (C : TStructuredDGCat k) :
    C.toDGCat.Obj → Prop

/-- The carrier of continuous functors between DG categories ([AGKRRV] §0.9.4). -/
@[placeholder] opaque DGFunCarrier (C D : DGCat k) : NonemptyType.{u + 2}

/-- Continuous functors between DG categories: the 1-morphisms of `DGCat`, which preserve
colimits and are `k`-linear ([AGKRRV] §0.9.4; [GLC1] Cor. 1.6.5). No linearity over a
monoidal DG category is part of the data. -/
@[placeholder] def DGFun (C D : DGCat k) : Type (u + 2) := (DGFunCarrier C D).type

instance (C D : DGCat k) : Nonempty (DGFun C D) := (DGFunCarrier C D).property

/-- Evaluation of a continuous functor on an object ([GLC1] Cor. 1.6.5). -/
@[placeholder] opaque DGFun.obj {C D : DGCat k} : DGFun C D → C.Obj → D.Obj

/-- Composition, with `F.comp G` denoting `G ∘ F` ([GLC1] Cor. 1.6.5). -/
@[placeholder] opaque DGFun.comp {C D E : DGCat k} : DGFun C D → DGFun D E → DGFun C E

/-- The identity functor of a DG category ([AGKRRV] §0.9.4). -/
@[placeholder] opaque DGFun.id (C : DGCat k) : DGFun C C

/-- Natural equivalences between continuous functors: the equivalences in the category of
1-morphisms of `DGCat` ([AGKRRV] §0.9.4; [GLC1] Conj. 1.6.7). No existence of such an
equivalence is asserted. -/
@[placeholder] opaque DGNatIso {C D : DGCat k} : DGFun C D → DGFun C D → Type (u + 1)

/-- Equivalences `Maps_C(H b, c) ≃ Maps_D(J b, T c)` of mapping spaces ([AGKRRV] §0.9.2),
natural in `b` and `c` together: the natural equivalences between the two functors
`Bᵒᵖ × C → Spc` that the two sides define. When `J` is the identity functor, these are the
adjunctions with left adjoint `H` and right adjoint `T`. No existence of such an equivalence
is asserted. -/
@[placeholder] opaque DGFun.MapsEquiv {B C D : DGCat k} :
    DGFun B C → DGFun B D → DGFun C D → Type (u + 1)

/-- Existence of an inverse up to natural equivalence ([GLC1] Conj. 1.6.7). -/
@[placeholder] def DGFun.IsEquivalence {C D : DGCat k} (F : DGFun C D) : Prop :=
  ∃ G : DGFun D C,
    Nonempty (DGNatIso (F.comp G) (DGFun.id C)) ∧
      Nonempty (DGNatIso (G.comp F) (DGFun.id D))

/-- The inverse characterization of equivalence of DG categories ([GLC1] Conj. 1.6.7). -/
theorem DGFun.isEquivalence_iff {C D : DGCat k} (F : DGFun C D) :
    F.IsEquivalence ↔ ∃ G : DGFun D C,
      Nonempty (DGNatIso (F.comp G) (DGFun.id C)) ∧
        Nonempty (DGNatIso (G.comp F) (DGFun.id D)) := Iff.rfl

end GLCinLean.Statement

end
