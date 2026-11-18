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

The geometric Langlands statement is about DG categories over a field $k$: presentable stable
$\infty$-categories with a module structure over $\mathrm{Vect}_k$, the symmetric monoidal
$\infty$-category of chain complexes of $k$-vector spaces ([AGKRRV] §0.9.4). This file declares
the part of their theory that the statement uses.

## Main definitions

* `DGCat k`: the DG categories over $k$, with `DGCat.Obj` (the objects of a DG category) and
  `DGCat.IsCompact` (the compact objects).
* `TStructuredDGCat k`: the DG categories over $k$ with a chosen t-structure, with
  `TStructuredDGCat.toDGCat` (the underlying DG category) and
  `TStructuredDGCat.IsEventuallyCoconnective` (the eventually coconnective objects).
* `DGFun C D`: the continuous functors $C \to D$, with `DGFun.obj` (the value on an object),
  `DGFun.comp` (composition) and `DGFun.id` (the identity functor).
* `DGNatIso F G`: the natural equivalences $F \simeq G$ between continuous functors.
* `DGFun.MapsEquiv H J T`: the equivalences
  $\mathrm{Maps}(H(b), c) \simeq \mathrm{Maps}(J(b), T(c))$ of mapping spaces, natural in $b$ and
  $c$ together.
* `DGFun.IsEquivalence F`: the continuous functor $F$ is an equivalence.

## Implementation notes

Every `opaque` constant and every definition of this file has the attribute `placeholder`. A
definition is built over opaque constants. The doc comment of each states the object that it
stands for. What a doc comment says of that object is not proved by the code: no axiom relates
the constants, and the code knows the type of an opaque constant and nothing more. For example,
no declaration states that `DGFun.comp` is associative, or that `DGFun.obj` sends `F.comp G` to
the composite of the values.

The four instances of `Nonempty`, for the types `DGCat k`, `TStructuredDGCat k`, `C.Obj` and
`DGFun C D`, do not have the attribute. Each of these types is the underlying type of an opaque
`NonemptyType`, and the instance is the nonemptiness that this constant carries. The objects
that the types stand for are nonempty too: there are the zero DG category, with its only
t-structure, the zero object and the zero functor.

No declaration gives a term of `DGNatIso F G` or of `DGFun.MapsEquiv H J T`, and none proves that
such a type is empty. No declaration states that some object is compact or eventually
coconnective, or that some object is not.

For `k : Type u`, the types `DGCat k`, `TStructuredDGCat k` and `DGFun C D` are in
`Type (u + 2)`, and the types `C.Obj`, `DGNatIso F G` and `DGFun.MapsEquiv H J T` are in
`Type (u + 1)`.

Every declaration takes an arbitrary field `k`. This is a generalization of [AGKRRV] §0.9.3,
where the field of coefficients is algebraically closed and of characteristic $0$: the notions of
this file use neither assumption. The doc comments of `DGCatCarrier` and `DGCat`, and of
`TStructuredDGCatCarrier` and `TStructuredDGCat`, record it.

A term of `TStructuredDGCat k` has any t-structure. This is a generalization of [AGKRRV] §1.4.1,
which asks as a convention that a t-structure is compatible with filtered colimits. The doc
comment of `TStructuredDGCatCarrier` records it.

## References

* [D. Arinkin, D. Gaitsgory, D. Kazhdan, S. Raskin, N. Rozenblyum, Y. Varshavsky, *The stack of
  local systems with restricted variation and geometric Langlands theory with nilpotent singular
  support*][AGKRRV]
* [D. Gaitsgory, S. Raskin, *Proof of the geometric Langlands conjecture I: construction of the
  functor*][GLC1]
-/

@[expose] public noncomputable section

namespace GLCinLean.Statement

universe u

/-- The type of DG categories over a field $k$, together with the fact that it is nonempty.
A DG category over $k$ is a presentable stable $\infty$-category with a module structure over
$\mathrm{Vect}_k$, the symmetric monoidal $\infty$-category of chain complexes of $k$-vector
spaces ([AGKRRV] §0.9.4). The nonemptiness is part of the constant. It holds for the type that
the constant stands for, because the zero category is a DG category.

Generalization: [AGKRRV] §0.9.3 takes the field of coefficients algebraically closed and of
characteristic $0$. Here $k$ is any field, because the notion uses neither assumption. -/
@[placeholder] opaque DGCatCarrier (k : Type u) [Field k] : NonemptyType.{u + 2}

/-- The type of DG categories over a field $k$ ([AGKRRV] §0.9.4): the underlying type of
`DGCatCarrier k`.

Generalization: $k$ is any field, and [AGKRRV] §0.9.3 takes it algebraically closed and of
characteristic $0$. The doc comment of `DGCatCarrier` gives the reason. -/
@[placeholder] def DGCat (k : Type u) [Field k] : Type (u + 2) := (DGCatCarrier k).type

/-- The type of DG categories over a field $k$ is nonempty: this is the nonemptiness that
`DGCatCarrier k` carries. -/
instance (k : Type u) [Field k] : Nonempty (DGCat k) := (DGCatCarrier k).property

/-- The type of pairs of a DG category $C$ over a field $k$ and a t-structure on $C$
([AGKRRV] §§0.9.4–0.9.5), together with the fact that it is nonempty. The nonemptiness is part
of the constant. It holds for the type that the constant stands for, because the zero category
has a t-structure.

Generalizations:

* The field $k$ is any field, and [AGKRRV] §0.9.3 takes it algebraically closed and of
  characteristic $0$. The doc comment of `DGCatCarrier` gives the reason.
* The t-structure is any t-structure. [AGKRRV] §1.4.1 asks as a convention that a t-structure is
  compatible with filtered colimits. The reason: the notion of an eventually coconnective
  object, for which the statement uses t-structures, makes sense for every t-structure. The
  statement uses one t-structure, that of `IndCohNilp`, which the doc comment of `IndCohNilp`
  defines. -/
@[placeholder] opaque TStructuredDGCatCarrier (k : Type u) [Field k] : NonemptyType.{u + 2}

/-- The type of DG categories over a field $k$ with a chosen t-structure
([AGKRRV] §§0.9.4–0.9.5): the underlying type of `TStructuredDGCatCarrier k`. The t-structure is
part of each term. [GLC1] §1.6.3 uses such a pair for
$\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$.

Generalizations: $k$ is any field and the t-structure is any t-structure. The doc comment of
`TStructuredDGCatCarrier` compares both with [AGKRRV] and gives the reasons. -/
@[placeholder] def TStructuredDGCat (k : Type u) [Field k] : Type (u + 2) :=
  (TStructuredDGCatCarrier k).type

/-- The type of DG categories over a field $k$ with a chosen t-structure is nonempty: this is
the nonemptiness that `TStructuredDGCatCarrier k` carries. -/
instance (k : Type u) [Field k] : Nonempty (TStructuredDGCat k) :=
  (TStructuredDGCatCarrier k).property

variable {k : Type u} [Field k]

/-- The type of objects of a DG category $C$ over a field $k$, that is, of the $\infty$-category
$C$ ([AGKRRV] §0.9.2), together with the fact that it is nonempty. The nonemptiness is part of
the constant. It holds for the type that the constant stands for, because the stable
$\infty$-category $C$ has a zero object. -/
@[placeholder] opaque DGCat.objCarrier (C : DGCat k) : NonemptyType.{u + 1}

/-- The type of objects of a DG category $C$ over a field $k$ ([AGKRRV] §0.9.2): the underlying
type of `C.objCarrier`. -/
@[placeholder] def DGCat.Obj (C : DGCat k) : Type (u + 1) := C.objCarrier.type

/-- The type of objects of a DG category $C$ over a field $k$ is nonempty: this is the
nonemptiness that `C.objCarrier` carries. -/
instance (C : DGCat k) : Nonempty C.Obj := C.objCarrier.property

/-- An object $c$ of a DG category $C$ over a field $k$ is compact if the functor
$\mathrm{Maps}_C(c, -) : C \to \mathrm{Spc}$ to the $\infty$-category of spaces preserves filtered
colimits ([AGKRRV] §0.9.2). -/
@[placeholder] opaque DGCat.IsCompact {C : DGCat k} : C.Obj → Prop

/-- The DG category that underlies a DG category with a chosen t-structure, over a field $k$:
the t-structure is forgotten ([AGKRRV] §0.9.5). -/
@[placeholder] opaque TStructuredDGCat.toDGCat (C : TStructuredDGCat k) : DGCat k

/-- An object $c$ of a DG category $C$ with a chosen t-structure, over a field $k$, is eventually
coconnective (bounded below) if it lies in $C^{>-\infty} = \bigcup_n C^{\geq -n}$, with
cohomological indexing ([AGKRRV] §0.9.5): there is an integer $n$, which may depend on $c$, with
$c \in C^{\geq -n}$. [GLC1] Thm. 1.6.2 and Cor. 1.6.5 use this notion. -/
@[placeholder] opaque TStructuredDGCat.IsEventuallyCoconnective (C : TStructuredDGCat k) :
    C.toDGCat.Obj → Prop

/-- The type of continuous functors $C \to D$ between DG categories over a field $k$, together
with the fact that it is nonempty. A continuous functor is a 1-morphism of the $\infty$-category
$\mathrm{DGCat}$ of DG categories: a functor that preserves colimits, with a compatibility with
the module structures over $\mathrm{Vect}_k$ ([AGKRRV] §0.9.4). The nonemptiness is part of the
constant. It holds for the type that the constant stands for, because the zero functor is
continuous. -/
@[placeholder] opaque DGFunCarrier (C D : DGCat k) : NonemptyType.{u + 2}

/-- The type of continuous functors $C \to D$ between DG categories over a field $k$, that is,
of 1-morphisms of $\mathrm{DGCat}$ ([AGKRRV] §0.9.4): the underlying type of `DGFunCarrier C D`.
[GLC1] Cor. 1.6.5 is about such functors. A continuous functor is linear over $\mathrm{Vect}_k$
only: a linearity over another monoidal DG category is not part of it. -/
@[placeholder] def DGFun (C D : DGCat k) : Type (u + 2) := (DGFunCarrier C D).type

/-- The type of continuous functors $C \to D$ between DG categories over a field $k$ is
nonempty: this is the nonemptiness that `DGFunCarrier C D` carries. -/
instance (C D : DGCat k) : Nonempty (DGFun C D) := (DGFunCarrier C D).property

/-- The value $F(c)$ of a continuous functor $F : C \to D$ between DG categories over a field
$k$ on an object $c$ of $C$. -/
@[placeholder] opaque DGFun.obj {C D : DGCat k} : DGFun C D → C.Obj → D.Obj

/-- The composite $G \circ F : C \to E$ of continuous functors $F : C \to D$ and $G : D \to E$
between DG categories over a field $k$, written `F.comp G`: the composition of 1-morphisms of
$\mathrm{DGCat}$ ([AGKRRV] §0.9.4). -/
@[placeholder] opaque DGFun.comp {C D E : DGCat k} : DGFun C D → DGFun D E → DGFun C E

/-- The identity functor $\mathrm{id}_C$ of a DG category $C$ over a field $k$: the identity
1-morphism of $C$ in $\mathrm{DGCat}$ ([AGKRRV] §0.9.4). -/
@[placeholder] opaque DGFun.id (C : DGCat k) : DGFun C C

/-- The type of natural equivalences $F \simeq G$ between continuous functors $F, G : C \to D$
of DG categories over a field $k$: the equivalences between $F$ and $G$ as 1-morphisms of
$\mathrm{DGCat}$ ([AGKRRV] §0.9.4), which are compatible with the module structures over
$\mathrm{Vect}_k$. Not every two continuous functors are equivalent, so some of the types that
the constant stands for are empty. The constant is opaque: the code proves neither that a type
`DGNatIso F G` is empty nor that it has a term. -/
@[placeholder] opaque DGNatIso {C D : DGCat k} : DGFun C D → DGFun C D → Type (u + 1)

/-- For continuous functors $H : B \to C$, $J : B \to D$ and $T : C \to D$ between DG categories
over a field $k$, the type of equivalences of mapping spaces ([AGKRRV] §0.9.2)
$$\mathrm{Maps}_C(H(b), c) \simeq \mathrm{Maps}_D(J(b), T(c))$$
that are natural in the objects $b$ of $B$ and $c$ of $C$ together: the natural equivalences
between the two functors $B^{\mathrm{op}} \times C \to \mathrm{Spc}$ that the two sides define.
A term is one natural equivalence of functors, not a family of equivalences that is chosen
object by object. For some $H$, $J$ and $T$ there is no such equivalence, so some of the types
that the constant stands for are empty. The constant is opaque: the code proves neither that a
type `DGFun.MapsEquiv H J T` is empty nor that it has a term.

The mapping spaces are those of the underlying $\infty$-categories, so a term records no
compatibility with the module structures over $\mathrm{Vect}_k$. When $B = D$ and $J$ is the
identity functor, the terms are the adjunctions with left adjoint $H$ and right adjoint $T$. -/
@[placeholder] opaque DGFun.MapsEquiv {B C D : DGCat k} :
    DGFun B C → DGFun B D → DGFun C D → Type (u + 1)

/-- A continuous functor $F : C \to D$ between DG categories over a field $k$ is an equivalence
if there is a continuous functor $G : D \to C$ with natural equivalences
$G \circ F \simeq \mathrm{id}_C$ and $F \circ G \simeq \mathrm{id}_D$. This is an equivalence in
$\mathrm{DGCat}$ ([AGKRRV] §0.9.4), the notion that [GLC1] Conj. 1.6.7 uses. -/
@[placeholder] def DGFun.IsEquivalence {C D : DGCat k} (F : DGFun C D) : Prop :=
  ∃ G : DGFun D C,
    Nonempty (DGNatIso (F.comp G) (DGFun.id C)) ∧
      Nonempty (DGNatIso (G.comp F) (DGFun.id D))

/-- A continuous functor $F : C \to D$ between DG categories over a field $k$ is an equivalence
if and only if there is a continuous functor $G : D \to C$ with natural equivalences
$G \circ F \simeq \mathrm{id}_C$ and $F \circ G \simeq \mathrm{id}_D$. This unfolds the
definition of `DGFun.IsEquivalence`. -/
theorem DGFun.isEquivalence_iff {C D : DGCat k} (F : DGFun C D) :
    F.IsEquivalence ↔ ∃ G : DGFun D C,
      Nonempty (DGNatIso (F.comp G) (DGFun.id C)) ∧
        Nonempty (DGNatIso (G.comp F) (DGFun.id D)) := Iff.rfl

end GLCinLean.Statement

end
