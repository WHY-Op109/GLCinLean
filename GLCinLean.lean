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
* [OneAffineness] Theorem 2.6.3: the gluing step over a finite affine open cover is left to the
  reader.
* [MV] §11, the end of the proof of Proposition 11.1: on the objects of the spherical category
  whose total cohomology is a projective module over the coefficient ring, the source defines the
  anti-involution `A ↦ 𝔻(i^*A)` (Verdier duality after pullback along the inversion of the loop
  group). It states without proof that this makes the category of the representations of the
  group scheme of Proposition 11.1 on finitely generated projective modules a rigid tensor
  category. It gives no evaluation map, no coevaluation map and no triangle identity. Over a
  field, every object of the spherical category has projective total cohomology. For a field of
  characteristic 0, [MV] §7 obtains rigidity from [DeligneMilne] Proposition 1.20 instead.

## Not formalized

No claim of the sources is given up.
-/
