/-
GLCinLean.Foundations: the thin adapter layer.

Every substantial object the formal abstract uses reaches it through a name here:
* re-exports of provider objects (Mathlib, Tau Ceti), as `abbrev`s, wrapping only to expose a hypothesis;
* provider-less generic placeholders (generic foundation families), data only, in the
  `NonemptyType` pattern or as plain `opaque` constants, each tagged `@[placeholder]`.
-/
import GLCinLean.Placeholder
import Mathlib.AlgebraicGeometry.Morphisms.Smooth
import Mathlib.AlgebraicGeometry.Morphisms.Proper
import Mathlib.FieldTheory.IsAlgClosed.Basic
import TauCeti.AlgebraicGeometry.AffineGroupScheme.Reductive.Basic
import TauCeti.Algebra.AlgebraicGroup.Pinning.Basic
import TauCeti.AlgebraicGeometry.LineBundle.TensorProduct
import TauCeti.AlgebraicGeometry.Modules.Differentials.Basic

noncomputable section

namespace GLCinLean.Foundations

open CategoryTheory AlgebraicGeometry

universe u

/-! ## Re-exports of provider objects -/

/-- Schemes (Mathlib `AlgebraicGeometry.Scheme`). -/
abbrev Scheme := AlgebraicGeometry.Scheme.{u}

/-- The spectrum of a field `k`, as a scheme (Mathlib `AlgebraicGeometry.Spec`). -/
abbrev SpecField (k : Type u) [Field k] : Scheme.{u} := AlgebraicGeometry.Spec (.of k)

/-- Reductive affine group schemes of finite type over a field (Tau Ceti
`TauCeti.ReductiveAffineGroupSchemeCat`). Tau Ceti proves them smooth with geometrically connected
structure morphism (`Reductive/Basic.lean`). -/
abbrev ReductiveGroup (k : Type u) [Field k] := TauCeti.ReductiveAffineGroupSchemeCat k

/-- The coordinate Hopf algebra of a reductive group, through Tau Ceti's anti-equivalence
between finite-type affine group schemes and finite-type commutative Hopf algebras. A wrapper,
because Tau Ceti states pinnings on the Hopf-algebra side. -/
abbrev ReductiveGroup.coordinateRing {k : Type u} [Field k] (G : ReductiveGroup k) :
    TauCeti.FiniteTypeCommHopfAlgCat.{u, u} k :=
  ((TauCeti.finiteTypeCommHopfAlgCatOpEquivFiniteTypeAffineGroupSchemeCat k).inverse.obj G.obj).unop

/-- The coordinate Hopf algebra of a reductive group is smooth: Tau Ceti's reductivity
property includes smoothness. Exposes the hypothesis Tau Ceti's `Pinning` needs. -/
instance ReductiveGroup.smooth_coordinateRing {k : Type u} [Field k] (G : ReductiveGroup k) :
    Algebra.Smooth k G.coordinateRing :=
  ((TauCeti.reductiveCommHopfAlgProperty_iff k _).mp
    ((TauCeti.reductiveAffineGroupSchemeProperty_iff k G.obj).mp G.property)).1

/-- Pinnings of a reductive group with a split maximal torus of rank `r` (Tau Ceti
`TauCeti.Pinning`: a Borel containing the torus and trivialisations of the simple root spaces). -/
abbrev Pinning {k : Type u} [Field k] (G : ReductiveGroup k) (r : ℕ) : Type u :=
  TauCeti.Pinning k G.coordinateRing.obj r

/-- Line bundles (invertible sheaves) on a scheme (Tau Ceti `InvertibleSheaf`). -/
abbrev LineBundle (X : Scheme.{u}) := TauCeti.AlgebraicGeometry.InvertibleSheaf X

/-- Tensor product of line bundles (Tau Ceti `InvertibleSheaf.tensorProduct`). -/
abbrev LineBundle.tensor {X : Scheme.{u}} (L K : LineBundle X) : LineBundle X :=
  TauCeti.AlgebraicGeometry.InvertibleSheaf.tensorProduct L K

/-- The canonical sheaf `ω_X` of a scheme over `k`, as the sheaf of relative differentials
`Ω_{X/k}` (Tau Ceti `Scheme.relativeDifferentials`). For a smooth curve over `k` this is the
canonical line bundle; Tau Ceti relates it to its Weil-divisor `canonicalBundle` in
`Modules/Differentials/Canonical.lean`. -/
abbrev canonicalSheaf (k : Type u) [Field k] (X : Scheme.{u}) [X.Over (SpecField k)] :
    X.Modules :=
  X.relativeDifferentials k

/-! ## Provider-less placeholders (generic foundation families)

The categories of GLC are presentable stable `k`-linear ∞-categories (DG categories), functors
are continuous, and equivalences are equivalences in DGCat (AGKRRV conventions). No
provider has this enhanced theory yet (Tau Ceti roadmap EnhancedDerivedSheaves #908 plans
it). The placeholders below give the statement the shape it needs, so that it cannot fall back to a
bare `Functor` with propositional equality.

`DGCat`, `DGCat.Obj` and `LinFun` use the `NonemptyType` pattern: such objects exist. `LinIso`,
`DGCat.IsCompact` and `DGCat.IsEventuallyCoconnective` are plain `opaque` constants with no
known inhabitants or truth values: an isomorphism between two given functors need not exist, so
giving `LinIso` a `Nonempty` instance would make the main statement trivially provable. -/

/-- Carrier of `DGCat`. -/
opaque DGCatPt : NonemptyType.{0}

/-- Cocomplete presentable stable `k`-linear ∞-categories (DG
categories) in the enhanced sense. -/
@[placeholder] def DGCat : Type := DGCatPt.type

instance : Nonempty DGCat := DGCatPt.property

/-- Carrier of `DGCat.Obj`. -/
opaque DGCat.ObjPt : DGCat → NonemptyType.{0}

/-- The objects of an enhanced category. -/
@[placeholder] def DGCat.Obj (C : DGCat) : Type := (DGCat.ObjPt C).type

instance (C : DGCat) : Nonempty C.Obj := (DGCat.ObjPt C).property

/-- Compactness of an object of an enhanced category. -/
@[placeholder] opaque DGCat.IsCompact {C : DGCat} : C.Obj → Prop

/-- Eventual coconnectivity of an object, for the category's standard
t-structure (GLC I §1: objects in `IndCoh_Nilp(LS)^{>-∞}`). -/
@[placeholder] opaque DGCat.IsEventuallyCoconnective {C : DGCat} : C.Obj → Prop

/-- Carrier of `LinFun`. -/
opaque LinFunPt : DGCat → DGCat → DGCat → NonemptyType.{0}

/-- `LinFun A C D`: the continuous functors
`C → D` that are `A`-linear for the given actions of the monoidal category `A` on `C` and `D`,
in the enhanced sense (GLC I Cor. 1.6.5: continuous `QCoh(LS)`-linear functors). The monoidal
structure of `A` and its actions are not data yet. -/
@[placeholder] def LinFun (A C D : DGCat) : Type := (LinFunPt A C D).type

instance (A C D : DGCat) : Nonempty (LinFun A C D) := (LinFunPt A C D).property

/-- The value of an `A`-linear functor on an object. -/
@[placeholder] opaque LinFun.obj {A C D : DGCat} : LinFun A C D → C.Obj → D.Obj

/-- Composition of `A`-linear functors: `F.comp G` is `G ∘ F`. -/
@[placeholder] opaque LinFun.comp {A C D E : DGCat} : LinFun A C D → LinFun A D E → LinFun A C E

/-- The identity `A`-linear functor. -/
@[placeholder] opaque LinFun.id (A C : DGCat) : LinFun A C C

/-- `LinIso F G`: `A`-linear natural isomorphisms
`F ≅ G` in the enhanced sense. Deliberately not `Nonempty`: two functors need not be
isomorphic. Isomorphism of functors is always `Nonempty (LinIso F G)`, never an equality. -/
@[placeholder] opaque LinIso {A C D : DGCat} : LinFun A C D → LinFun A C D → Type

/-- An `A`-linear functor is an equivalence: it has a two-sided inverse up to `A`-linear natural
isomorphism (equivalence in DGCat). A real definition over the placeholders. -/
def LinFun.IsEquivalence {A C D : DGCat} (F : LinFun A C D) : Prop :=
  ∃ G : LinFun A D C,
    Nonempty (LinIso (F.comp G) (LinFun.id A C)) ∧ Nonempty (LinIso (G.comp F) (LinFun.id A D))

end GLCinLean.Foundations

end
