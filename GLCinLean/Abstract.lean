/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5
-/
module

public import GLCinLean.Foundations

/-!
# The formal abstract

It states [GLC1] Conj. 1.6.7 and the definitions its statement needs, and
imports only Mathlib, Tau Ceti and `GLCinLean.Foundations`. The categories and functors of the
`𝕃_G` chain appear as placeholders.
-/

@[expose] public noncomputable section

namespace GLCinLean.Abstract

open CategoryTheory GLCinLean.Foundations
open AlgebraicGeometry hiding Scheme

universe u

/-! ## Standing hypotheses ([GLC1] §1, conventions as in [AGKRRV])

`k` is algebraically closed of characteristic 0; `X` is a smooth, proper, connected curve over
`k`; `G` is a reductive group over `k`. The statement is made for every square root of `ω_X`,
taken as data, and for every pinning.

"Algebraically closed" and "connected" come from the conventions [GLC1] cites
([AGKRRV] §0.9.1, §14.1.1) and from the proof in [GLC2] (§0.4.1, Rem. H.2.5), not from
[GLC1]'s opening sentence (§0.1.1), which says only "a field of characteristic 0". -/

/-- An identification of the root datum of `Gd` with the dual of the
root datum of `G` ([GLC1] §1.3: the Langlands dual group). No library defines the root datum of a
general reductive group yet, so this has content only once it is defined. Deliberately a plain
`opaque` type, not `NonemptyType`: whether an identification exists is the content. -/
@[placeholder] opaque RootDatumDuality {k : Type u} [Field k] :
    ReductiveGroup k → ReductiveGroup k → Type u

/-- The standing data of [GLC1] §1 (the hypothesis block):
a smooth proper connected curve `X` over `k`, a reductive group `G` with a pinning, a square
root of `ω_X` as data (a line bundle with a chosen isomorphism from its square to `ω_X`, [GLC1]
§1.3.2), and the Langlands dual group `Ǧ` as an input with a root-datum identification. -/
structure Setting (k : Type u) [Field k] [CharZero k] [IsAlgClosed k] where
  /-- The curve. -/
  X : Scheme.{u}
  [over : X.Over (SpecField k)]
  [smooth : SmoothOfRelativeDimension 1 (X ↘ SpecField k)]
  [proper : IsProper (X ↘ SpecField k)]
  [connected : ConnectedSpace X]
  /-- The reductive group. -/
  G : ReductiveGroup k
  /-- The rank of the split maximal torus of the pinning. -/
  rank : ℕ
  /-- The pinning ([GLC1] §1.3). -/
  pinning : Pinning G rank
  /-- The square root `ω_X^{1/2}`: a line bundle ... -/
  sqrtOmega : LineBundle X
  /-- ... with a chosen isomorphism from its square to `ω_X`. -/
  sqrtOmegaIso : (sqrtOmega.tensor sqrtOmega).obj ≅ canonicalSheaf k X
  /-- The Langlands dual group `Ǧ`, as an input. -/
  dualGroup : ReductiveGroup k
  /-- The identification of `Ǧ`'s root datum with the dual of `G`'s. -/
  dualIdentification : RootDatumDuality G dualGroup

attribute [instance] Setting.over Setting.smooth Setting.proper Setting.connected

/-- A Langlands dual group exists ([GLC1] §1.3). Stated so that a wrongly stated identification
shows up as a false existence claim instead of making the main statement vacuous. -/
theorem exists_dualGroup {k : Type u} [Field k] [CharZero k] [IsAlgClosed k]
    (G : ReductiveGroup k) : ∃ Gd : ReductiveGroup k, Nonempty (RootDatumDuality G Gd) := sorry

variable {k : Type u} [Field k] [CharZero k] [IsAlgClosed k]

/-! ## The categories and functors of the `𝕃_G` chain -/

/-- `Dmod_{1/2}(Bun_G)`: half-twisted D-modules on the moduli stack
of `G`-bundles on `X` ([GLC1] §1.1, twist by `ω_X^{1/2}`). -/
@[placeholder] opaque DmodHalf (S : Setting k) : DGCat

/-- `QCoh(LS_Ǧ)`: quasi-coherent sheaves on the stack of de Rham
`Ǧ`-local systems on `X` ([GLC1] §1.4); it acts on both sides of the conjecture. -/
@[placeholder] opaque QCohLS (S : Setting k) : DGCat

/-- `IndCoh_Nilp(LS_Ǧ)` ([GLC1] §1.6). -/
@[placeholder] opaque IndCohNilp (S : Setting k) : DGCat

/-- `Ψ : IndCoh_Nilp(LS_Ǧ) → QCoh(LS_Ǧ)`, a `QCoh(LS_Ǧ)`-linear
functor ([GLC1] §1.6). -/
@[placeholder] opaque Psi (S : Setting k) : LinFun (QCohLS S) (IndCohNilp S) (QCohLS S)

/-- `𝕃_{G,coarse} : Dmod_{1/2}(Bun_G) → QCoh(LS_Ǧ)`, a
`QCoh(LS_Ǧ)`-linear functor ([GLC1] §1.6). -/
@[placeholder] opaque LCoarse (S : Setting k) : LinFun (QCohLS S) (DmodHalf S) (QCohLS S)

/-! ## The functor `𝕃_G` (chosen from Cor. 1.6.5's existence statement) -/

/-- The two properties of [GLC1] Cor. 1.6.5, of a continuous `QCoh(LS_Ǧ)`-linear functor
`F : Dmod_{1/2}(Bun_G) → IndCoh_Nilp(LS_Ǧ)` in the enhanced sense: `F` sends compact objects to
eventually coconnective ones, and `Ψ ∘ F` is isomorphic (an `A`-linear natural isomorphism,
never an equality) to `𝕃_{G,coarse}`. -/
def IsLanglandsFunctor (S : Setting k) (F : LinFun (QCohLS S) (DmodHalf S) (IndCohNilp S)) :
    Prop :=
  (∀ c : (DmodHalf S).Obj, DGCat.IsCompact c → DGCat.IsEventuallyCoconnective (F.obj c)) ∧
    Nonempty (LinIso (F.comp (Psi S)) (LCoarse S))

/-- [GLC1] Cor. 1.6.5, existence: a functor with the two properties exists. -/
theorem exists_isLanglandsFunctor (S : Setting k) :
    ∃ F : LinFun (QCohLS S) (DmodHalf S) (IndCohNilp S), IsLanglandsFunctor S F := sorry

/-- [GLC1] Cor. 1.6.5, uniqueness in the enhanced sense: two functors with the two properties
are isomorphic as `QCoh(LS_Ǧ)`-linear functors. -/
theorem isLanglandsFunctor_unique (S : Setting k)
    {F F' : LinFun (QCohLS S) (DmodHalf S) (IndCohNilp S)}
    (hF : IsLanglandsFunctor S F) (hF' : IsLanglandsFunctor S F') :
    Nonempty (LinIso F F') := sorry

/-- `𝕃_G : Dmod_{1/2}(Bun_G) → IndCoh_Nilp(LS_Ǧ)` ([GLC1] Cor. 1.6.5): *the* functor with the
two properties, chosen from the existence statement. Nothing is known about it
beyond the two properties. -/
def LG (S : Setting k) : LinFun (QCohLS S) (DmodHalf S) (IndCohNilp S) :=
  Classical.choose (exists_isLanglandsFunctor S)

/-! ## The conjecture -/

/-- **[GLC1] Conj. 1.6.7** (proved in [GLC1]–[GLC5]): the functor `𝕃_G` is an equivalence.
Its proof is the open goal. -/
theorem main (S : Setting k) : (LG S).IsEquivalence := sorry

end GLCinLean.Abstract

end
