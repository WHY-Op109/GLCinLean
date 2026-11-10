/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5, GPT-6
-/
module

public import GLCinLean.Placeholder
public import Mathlib.Algebra.Field.Defs

/-!
# Enhanced categories in the statement

The placeholders here stand for the enhanced categories of [AGKRRV] §§0.9.2–0.9.5.
They retain the ground field, monoidal category, module actions and choice of t-structure
as parameters. They impose no categorical laws and do not define an enhanced category theory.

The nonempty carriers stand for collections containing a zero category, object or functor.
No inhabitant is supplied for a specified natural isomorphism or compactness predicate.
-/

@[expose] public noncomputable section

namespace GLCinLean.Statement

universe u

/-- The carrier of presentable stable `k`-linear enhanced categories ([AGKRRV] §0.9.4). -/
@[placeholder] opaque DGCatCarrier (k : Type u) [Field k] : NonemptyType.{u + 2}

/-- Presentable stable `k`-linear enhanced categories ([AGKRRV] §0.9.4). -/
@[placeholder] def DGCat (k : Type u) [Field k] : Type (u + 2) := (DGCatCarrier k).type

instance (k : Type u) [Field k] : Nonempty (DGCat k) := (DGCatCarrier k).property

variable {k : Type u} [Field k]

/-- The carrier of objects in an enhanced category ([AGKRRV] §0.9.2). -/
@[placeholder] opaque DGCat.objCarrier (C : DGCat k) : NonemptyType.{u + 1}

/-- Objects of an enhanced category ([AGKRRV] §0.9.2). -/
@[placeholder] def DGCat.Obj (C : DGCat k) : Type (u + 1) := C.objCarrier.type

instance (C : DGCat k) : Nonempty C.Obj := C.objCarrier.property

/-- Compactness: mapping out preserves filtered colimits ([AGKRRV] §0.9.2). -/
@[placeholder] opaque DGCat.IsCompact {C : DGCat k} : C.Obj → Prop

/-- The carrier of monoidal DG categories ([AGKRRV] §0.9.4). -/
@[placeholder] opaque MonoidalDGCatCarrier (k : Type u) [Field k] : NonemptyType.{u + 2}

/-- Monoidal DG categories with their coherent monoidal structure ([AGKRRV] §0.9.4). -/
@[placeholder] def MonoidalDGCat (k : Type u) [Field k] : Type (u + 2) :=
  (MonoidalDGCatCarrier k).type

instance (k : Type u) [Field k] : Nonempty (MonoidalDGCat k) :=
  (MonoidalDGCatCarrier k).property

/-- The carrier of DG categories with a specified action of `A` ([AGKRRV] §0.9.4). -/
@[placeholder] opaque DGModuleCarrier (A : MonoidalDGCat k) : NonemptyType.{u + 2}

/-- An enhanced category with a specified coherent `A`-action ([AGKRRV] §0.9.4). -/
@[placeholder] def DGModule (A : MonoidalDGCat k) : Type (u + 2) := (DGModuleCarrier A).type

instance (A : MonoidalDGCat k) : Nonempty (DGModule A) := (DGModuleCarrier A).property

/-- The enhanced category underlying an `A`-module category ([AGKRRV] §0.9.4). -/
@[placeholder] opaque DGModule.toDGCat {A : MonoidalDGCat k} (C : DGModule A) : DGCat k

/-- A monoidal category acting on itself by tensor product. A monoidal DG category is an
associative algebra in DG categories ([AGKRRV] §0.9.4), and every algebra is a module over
itself; [GLC1] §1.4.1 uses `QCoh(LS_Ǧ)` acting on itself in this way. Its underlying enhanced
category `A.regularModule.toDGCat` stands for the category underlying `A`. -/
@[placeholder] opaque MonoidalDGCat.regularModule (A : MonoidalDGCat k) : DGModule A

/-- The carrier of `A`-module categories with a chosen t-structure
([GLC1] §1.6.3; [AGKRRV] §§0.9.4–0.9.5). -/
@[placeholder] opaque TStructuredDGModuleCarrier (A : MonoidalDGCat k) : NonemptyType.{u + 2}

/-- An `A`-module category with a chosen t-structure ([GLC1] §1.6.3).
The choice is part of the object; no t-structure on an arbitrary DG category is asserted. -/
@[placeholder] def TStructuredDGModule (A : MonoidalDGCat k) : Type (u + 2) :=
  (TStructuredDGModuleCarrier A).type

instance (A : MonoidalDGCat k) : Nonempty (TStructuredDGModule A) :=
  (TStructuredDGModuleCarrier A).property

/-- Forgetting the chosen t-structure ([GLC1] §1.6.3). -/
@[placeholder] opaque TStructuredDGModule.toModule {A : MonoidalDGCat k}
    (C : TStructuredDGModule A) : DGModule A

/-- Boundedness below for the specified t-structure, with a bound depending on the object
([GLC1] §1.6.3 and Cor. 1.6.5). -/
@[placeholder] opaque TStructuredDGModule.IsEventuallyCoconnective {A : MonoidalDGCat k}
    (C : TStructuredDGModule A) : C.toModule.toDGCat.Obj → Prop

/-- The carrier of continuous `A`-linear enhanced functors ([AGKRRV] §0.9.4). -/
@[placeholder] opaque LinFunCarrier {A : MonoidalDGCat k} (C D : DGModule A) :
    NonemptyType.{u + 2}

/-- Colimit-preserving functors linear for the specified actions, including their coherent
linearity data ([GLC1] Cor. 1.6.5 and Prop. 1.7.2; [AGKRRV] §0.9.4). -/
@[placeholder] def LinFun {A : MonoidalDGCat k} (C D : DGModule A) : Type (u + 2) :=
  (LinFunCarrier C D).type

instance {A : MonoidalDGCat k} (C D : DGModule A) : Nonempty (LinFun C D) :=
  (LinFunCarrier C D).property

/-- Evaluation of an enhanced linear functor ([GLC1] Cor. 1.6.5). -/
@[placeholder] opaque LinFun.obj {A : MonoidalDGCat k} {C D : DGModule A} :
    LinFun C D → C.toDGCat.Obj → D.toDGCat.Obj

/-- Composition, with `F.comp G` denoting `G ∘ F` ([GLC1] Cor. 1.6.5). -/
@[placeholder] opaque LinFun.comp {A : MonoidalDGCat k} {C D E : DGModule A} :
    LinFun C D → LinFun D E → LinFun C E

/-- The identity enhanced linear functor ([AGKRRV] §0.9.4). -/
@[placeholder] opaque LinFun.id {A : MonoidalDGCat k} (C : DGModule A) : LinFun C C

/-- Enhanced `A`-linear natural equivalences between functors
([GLC1] Cor. 1.6.5 and Prop. 1.7.2). No existence of such an equivalence is asserted. -/
@[placeholder] opaque LinIso {A : MonoidalDGCat k} {C D : DGModule A} :
    LinFun C D → LinFun C D → Type (u + 1)

/-- Existence of an inverse up to enhanced linear natural equivalence
([GLC1] Conj. 1.6.7 and Prop. 1.7.2). -/
@[placeholder] def LinFun.IsEquivalence {A : MonoidalDGCat k} {C D : DGModule A}
    (F : LinFun C D) : Prop :=
  ∃ G : LinFun D C,
    Nonempty (LinIso (F.comp G) (LinFun.id C)) ∧
      Nonempty (LinIso (G.comp F) (LinFun.id D))

/-- The inverse characterization of enhanced linear equivalence
([GLC1] Conj. 1.6.7 and Prop. 1.7.2). -/
theorem LinFun.isEquivalence_iff {A : MonoidalDGCat k} {C D : DGModule A}
    (F : LinFun C D) :
    F.IsEquivalence ↔ ∃ G : LinFun D C,
      Nonempty (LinIso (F.comp G) (LinFun.id C)) ∧
        Nonempty (LinIso (G.comp F) (LinFun.id D)) := Iff.rfl

end GLCinLean.Statement

end
