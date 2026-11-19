/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5, GPT-6, Claude Fable 5.2
-/
module

public import GLCinLean.CategoryTheory.Monoidal.TensorPow
public import GLCinLean.Placeholder
public import GLCinLean.Statement.Enhanced
public import GLCinLean.Statement.Conjecture

/-!
# The geometric Langlands statement

This file imports the statement of the de Rham geometric Langlands conjecture
([GLC1] Conj. 1.6.7, with the existence part of [GLC1] Cor. 1.6.5): the theorem
`GLCinLean.Statement.exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence`.
The theorem is about each setting (`GLCinLean.Statement.Setting`) over an algebraically closed
field of characteristic $0$: for each setting, a continuous functor with the two properties of
`GLCinLean.Statement.IsLanglandsFunctor` exists, and every such functor is an equivalence.

The objects of the statement have the attribute `placeholder`: each is an `opaque` constant or
is built over opaque constants. The declarations construct no setting, so the theorem cannot yet
be applied to an example.

## Differences from the sources

### Differences of the statement from [GLC1]

Each item names the kind of the difference and the declaration of `GLCinLean.Statement` whose doc
comment records the difference with its reason.

* Restriction, in the main theorem and in the declarations after `Setting` (the eight opaque
  constants, `IsLanglandsFunctor` and `isLanglandsFunctor_iff`): the ground field $k$ is
  algebraically closed. [GLC1] §0.1.1 takes a field of characteristic $0$.
* Reformulation, in the main theorem: no functor $\mathbb{L}_G$ is chosen. The theorem states
  that a continuous functor with the two properties of `IsLanglandsFunctor` exists, and that
  every such functor is an equivalence. The uniqueness in [GLC1] Cor. 1.6.5 is not stated.
* Reformulation, in `IsLanglandsFunctor`: the second property is the existence of an equivalence
  $\mathrm{Maps}(V \star \mathrm{Poinc}, M) \simeq \mathrm{Maps}(\mathrm{Loc}(V), \Psi(F(M)))$
  of mapping spaces, natural in $V$ and $M$ together. It takes the place of the equivalence
  $\Psi_{\mathrm{Nilp},\{0\}} \circ F \simeq \mathbb{L}_{G,\mathrm{coarse}}$ of continuous
  functors in [GLC1] Cor. 1.6.5. The property of [GLC1] gives it. In the other direction it gives
  this equivalence for the underlying functors of $\infty$-categories, with no compatibility
  with the module structures over $\mathrm{Vect}_k$. A continuous functor with the two
  properties of `IsLanglandsFunctor` is an equivalence exactly when $\mathbb{L}_G$ is.
* Reformulation, in `RepRan`, `Loc` and `heckeActionRight`: the statement keeps the DG category
  $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$, the continuous functor
  $\mathrm{Loc}^{\mathrm{spec}}_{\check G}$ and, for each object $M$, the continuous functor
  $V \mapsto V \star M$. [GLC1] §§1.2.1–1.2.2 has a monoidal category, a symmetric monoidal
  functor and an action.
* Correction, in `Loc`: the source of the spectral localization functor is
  $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$. The display of [GLC1] §1.2.2 writes
  $\mathrm{Rep}(\check G)$.
* Reading, in `Setting`: the curve is connected. [GLC1] §0.1.1 does not say so.
* Reading, in `Setting`: the group $G$ has a pinning. The pinning contains a maximal torus
  inside its Borel subgroup and an isomorphism of this torus with a split torus
  $\mathbb{G}_m^r$. [GLC1] names no pinning, no such torus and no such isomorphism.
* Reading, in `Setting` and `RootDatumDuality`: the group $\check G$ is any connected reductive
  group with a chosen duality datum for $G$ and $\check G$, which is an isomorphism from the dual
  of the based root datum of $G$ to the based root datum of $\check G$ and not an isomorphism of
  groups. Over the algebraically closed field of the statement, these are the Langlands dual
  groups of $G$. [GLC1] §0.1.1 speaks of the Langlands dual group of $G$ and names no duality
  datum.
* Reformulation, in `Setting`: the groups $G$ and $\check G$ are given by their coordinate Hopf
  algebras (`TauCeti.ReductiveCommHopfAlgCat`).

### Differences in the definitions that the statement uses

* Reformulation of the derived affine tests for $\mathrm{LS}_{\check G}$, the stack of de Rham
  $\check G$-local systems of [GLC1] §0.1.1 named in the doc comments of `QCohLS` and
  `IndCohNilp`. This stack can be evaluated on spectra of animated commutative $k$-algebras.
  [AGKRRV] §0.9.6 uses
  the connective commutative algebra objects of $\mathrm{Vect}_k$, and [Crystals] §0.6.4 uses the
  connective commutative DG algebras. Over the ground field, which has characteristic $0$, these
  models are equivalent by [LurieHA] Theorem 7.1.2.13, Propositions 7.1.4.11 and 7.1.4.20 and
  Warning 7.1.4.21. Animation gives the category of the affine schemes without the derived tensor
  product and without module categories.

### Errors and gaps found in the sources

* [RaskinCPSI] §6.10: the proof that the factorization functors of the category `C_{X^I}` are
  equivalences over the disjoint locus is one sentence ("a cofinality argument"). It interchanges a
  tensor product of categories with two limits. This interchange holds for a compactly generated
  rigid category `C` (Lemma 6.18.1); for another category the source has no proof.
* [RaskinCPSI] Corollary 6.18.2: the self-duality of `C_{X^I}` as a module category over the
  D-modules on `X^I` is stated without proof. Dualizability follows from Lemma 6.18.1; the pairing
  and its perfectness do not.
* [RaskinCPSII] Lemma 9.8.1 and Appendix A.5, Step 2: the reduction from a general curve to the
  affine line is one sentence, which invokes étale descent for sheaves of categories. The source
  does not carry out this descent for the categories over the powers of the curve.
* [IndCoh] Theorem 5.6.3, on which the symmetric monoidal structure of the `!`-tensor product
  rests, is stated without proof.
* [DG2] §§5.2.1–5.2.3: the de Rham direct image of D-modules along a quasi-compact map of DG
  schemes locally almost of finite type is quoted from the classical theory; the introduction
  of §5 calls this material well known at the level of triangulated categories. The functor of
  ∞-categories on the correspondences of schemes, which holds the direct images, the
  `!`-pullbacks and their base change together, is used without a construction: §5.2.3 states
  that the literature had no reference for it when the paper was written. [Crystals] constructs
  the pullback of crystals and leaves the direct image along a general map to a later work
  (Introduction, §0.3).
* [OneAffineness] Theorem 2.6.3: the gluing step over a finite affine open cover is left to the
  reader.
* [CompactGeneration] §§1.1.7 and 1.2.2 identify detection of zero by degree-zero `Hom` from a
  specified family with generation as a full stable subcategory closed under small colimits. For
  a family of compact objects, the detection criterion agrees with stable generation when it tests
  every integer shift of every member. In the derived category of a field `k`, the smallest full
  stable subcategory closed under small colimits and containing `k` is the whole category,
  although `Hom(k, k[1]) = 0` and `k[1]` is nonzero.
* [MV] §11, the end of the proof of Proposition 11.1: on the objects of the spherical category
  whose total cohomology is a projective module over the coefficient ring, the source defines the
  anti-involution `A ↦ 𝔻(i^*A)` (Verdier duality after pullback along the inversion of the loop
  group). It states without proof that this makes the category of the representations of the
  group scheme of Proposition 11.1 on finitely generated projective modules a rigid tensor
  category. It gives no evaluation map, no coevaluation map and no triangle identity. Over a
  field, every object of the spherical category has projective total cohomology. For a field of
  characteristic 0, [MV] §7 obtains rigidity from [DeligneMilne] Proposition 1.20 instead.
* [GLys] §7.1.3: the section says that the prestacks `𝔏⁺(Z)` and `𝔏(Z)` of arcs and loops over the
  Ran space are factorization prestacks for every prestack `Z`. This needs that `Z` sends the
  disjoint union of two affine schemes to the product of its values, because the disc of the union
  of two disjoint points is the disjoint union of the two discs, which is one affine scheme. For
  the constant functor with value a set of two elements the claim is false. [GLC2] §§B.3.2 and
  B.4.1 state the condition.

## Not formalized

No claim of the sources is given up.
-/
