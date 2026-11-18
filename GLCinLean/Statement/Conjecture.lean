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

Let $k$ be an algebraically closed field of characteristic $0$, $X$ a smooth, proper and
connected curve over $k$, $G$ a connected reductive group over $k$, and $\check G$ its Langlands
dual group. [GLC1] Cor. 1.6.5 states that there is a continuous functor
$$\mathbb{L}_G : \mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G) \to
  \mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$$
with two properties, and that the two properties determine it. [GLC1] Conj. 1.6.7 states that
$\mathbb{L}_G$ is an equivalence.

This file states that a continuous functor with the two properties of `IsLanglandsFunctor`
exists, and that every such functor is an equivalence. The first property of
`IsLanglandsFunctor` is the first property of [GLC1] Cor. 1.6.5. The second property of
`IsLanglandsFunctor` is stated with mapping spaces and with the Hecke action of
$\mathrm{Rep}(\check G)_{\mathrm{Ran}}$ ([GLC1] §1.2.1), and not with the functor
$\mathbb{L}_{G,\mathrm{coarse}}$ of [GLC1] §1.4.5 as the second property of [GLC1] Cor. 1.6.5 is.
The doc comment of `IsLanglandsFunctor` compares the two.

## Main definitions

* `Setting k`: the curve $X$, the group $G$ with a pinning, a square root $\omega_X^{1/2}$ of
  the canonical line bundle of $X$, and the group $\check G$ with a duality datum for $G$ and
  $\check G$ (`RootDatumDuality`).
* `DmodHalf S`, `IndCohNilp S`, `QCohLS S` and `RepRan S`: the DG categories
  $\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$,
  $\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$,
  $\mathrm{QCoh}(\mathrm{LS}_{\check G})$ and $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$.
* `Psi S`, `Loc S` and `heckeActionRight S M`: the continuous functors
  $\Psi_{\mathrm{Nilp},\{0\}}$, $\mathrm{Loc}^{\mathrm{spec}}_{\check G}$ and $V \mapsto V \star M$.
* `vacuumPoincare S`: the vacuum Poincaré object $\mathrm{Poinc}^{\mathrm{Vac,glob}}_{G,!}$.
* `IsLanglandsFunctor S F`: the two properties of this file, for a continuous functor $F$.

## Main statements

* `exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence`: the de Rham
  geometric Langlands conjecture.

## Implementation notes

The constant `RootDatumDuality`, the structure `Setting`, the eight constants after `Setting` and
the definition `IsLanglandsFunctor` have the attribute `placeholder`. Each is an `opaque`
constant, or is built over opaque constants (`Setting` and `IsLanglandsFunctor`), and its doc
comment states the object that it stands for. What a doc comment says of that object is not
proved by the code: no axiom relates the constants, and the code knows the type of an opaque
constant and nothing more.

The main theorem is stated for each setting. The declarations construct no setting: a term of
`Setting k` has a field whose type is the opaque type `RootDatumDuality`, and the declarations
give a term of such a type only as this field of a given setting.

The doc comment of each declaration records its differences from [GLC1]. The module doc comment
of `GLCinLean` lists the differences that affect the statement.

## The ground field

[GLC1] §0.1.1 takes a field $k$ of characteristic $0$. The declarations after `Setting` ask in
addition that $k$ is algebraically closed: the eight opaque constants, `IsLanglandsFunctor` and
the two theorems. This is a restriction of [GLC1]. The reason: [GLC1] largely follows the
conventions of [AGKRRV] ([GLC1] §0.5.7), where the ground field is algebraically closed
([AGKRRV] §0.9.1), and [GLC2] §0.4.1 works over an algebraically closed field of characteristic
$0$. The constant `RootDatumDuality`, the structure `Setting` and its projections take any field.

## References

* [D. Gaitsgory, S. Raskin, *Proof of the geometric Langlands conjecture I: construction of the
  functor*][GLC1]
* [D. Arinkin, D. Beraldo, L. Chen, J. Faergeman, D. Gaitsgory, K. Lin, S. Raskin,
  N. Rozenblyum, *Proof of the geometric Langlands conjecture II: Kac-Moody localization and the
  FLE*][GLC2]
* [D. Arinkin, D. Gaitsgory, D. Kazhdan, S. Raskin, N. Rozenblyum, Y. Varshavsky, *The stack of
  local systems with restricted variation and geometric Langlands theory with nilpotent singular
  support*][AGKRRV]
* [D. Arinkin, D. Gaitsgory, *Singular support of coherent sheaves, and the geometric Langlands
  conjecture*][ArinkinGaitsgory]
* [D. Gaitsgory, *Outline of the proof of the geometric Langlands conjecture for
  GL(2)*][GaitsgoryOutline]
* [B. Conrad, *Reductive group schemes*][ConradRGS]
-/

@[expose] public noncomputable section

namespace GLCinLean.Statement

open CategoryTheory AlgebraicGeometry

universe u

/-- The type of duality data for two connected reductive groups $G$ and $G'$ over a field $k$,
which are given in this order by their coordinate Hopf algebras. A duality datum for $G$ and
$G'$ is an isomorphism from the dual of the based root datum of $G$ to the based root datum of
$G'$. The based root data are those of the groups over a separable closure $k_s$ of $k$, so a
duality datum identifies the dual root data of $G_{k_s}$ and $G'_{k_s}$. Over an algebraically
closed field, as in the statement, a duality datum makes $G'$ a Langlands dual group of $G$
([GLC1] §0.1.1), and it determines $G'$ up to isomorphism. Over a general field a duality datum
need not determine $G'$ up to isomorphism over $k$.

The based root datum of a connected reductive group $G$ over $k$ is the one of
[ConradRGS] Rem. 7.1.2. Let $k_s$ be the separable closure of $k$ in a fixed algebraic closure
of $k$. A maximal torus of $G_{k_s}$ and a Borel subgroup of $G_{k_s}$ that contains it give a
based root datum. The based root data of two such pairs are identified by a conjugation, and the
identification does not depend on the conjugating element. The based root datum of $G$ is the
limit over all pairs.

The constant takes the field and the two groups and nothing else: no torus, Borel subgroup or
pinning enters. A duality datum is an isomorphism of based root data and not an isomorphism of
groups. By [ConradRGS] Thm. 6.1.17 an isomorphism of based root data comes from exactly one
isomorphism of pinned split reductive groups. So a duality datum identifies $G'_{k_s}$ with
another Langlands dual group of $G_{k_s}$ only after pinnings of both are chosen.

For the objects described here, a duality datum for $G$ and $G'$ exists exactly when the based
root datum of $G'$ is isomorphic to the dual of the based root datum of $G$. The constant is
opaque, so the code proves neither that a type of duality data is empty nor that it has a term.

Differences from [GLC1]:

* Reading: [GLC1] §0.1.1 speaks of the Langlands dual group of $G$ and names no duality datum.
  The Langlands dual group is determined by $G$ up to isomorphism, so a group $\check G$ and a
  duality datum for $G$ and $\check G$ are chosen.
* Generalization: $k$ is any field, because the definition makes sense over every field.
  [GLC1] §0.1.1 takes $k$ of characteristic $0$, and the statement uses duality data only over
  an algebraically closed field. For a group that is not split, the based root datum can depend
  on $k_s$, and it has an action of the Galois group of $k_s$ over $k$, which can be nontrivial
  ([ConradRGS] Rem. 7.1.2). A duality datum is not asked to respect this action. So over a
  general field a duality datum need not determine $G'$ up to isomorphism over $k$. For example,
  over $\mathbb{R}$ and for $G = \mathbb{G}_m$, both $G' = \mathbb{G}_m$ and the torus $G'$ of
  elements of norm $1$ of $\mathbb{C}$ over $\mathbb{R}$ have a duality datum, and these two
  groups are not isomorphic over $\mathbb{R}$. -/
@[placeholder] opaque RootDatumDuality {k : Type u} [Field k] :
    TauCeti.ReductiveCommHopfAlgCat k → TauCeti.ReductiveCommHopfAlgCat k → Type u

/-- The data on which the statement depends, over a field $k$ ([GLC1] §§0.1.1, 1.3.2):

* a curve $X$: a scheme over $\operatorname{Spec} k$ that is smooth of relative dimension $1$,
  proper and connected, so in particular nonempty;
* a connected reductive group $G$ over $k$, given by its coordinate Hopf algebra, with a pinning
  (`TauCeti.Pinning`): a closed immersion of the split torus $\mathbb{G}_m^r$ into $G$, for
  $r$ = `rank`, whose image is a maximal torus of every geometric fibre of $G$; a Borel subgroup
  that contains this torus; and a generator of each simple root space;
* a square root $\omega_X^{1/2}$ of the canonical line bundle of $X$: an invertible sheaf with an
  isomorphism $\omega_X^{1/2} \otimes \omega_X^{1/2} \cong \Omega_{X/k}$, as [GLC1] §1.3.2 fixes;
* a connected reductive group $\check G$ over $k$, given by its coordinate Hopf algebra, with a
  duality datum for $G$ and $\check G$ (`RootDatumDuality`): an isomorphism of based root data
  over a separable closure of $k$, not an isomorphism of groups. Over an algebraically closed
  field it makes $\check G$ a Langlands dual group of $G$.

Differences from [GLC1]:

* Reading: the curve is connected. [GLC1] §0.1.1 asks for a smooth and complete curve and does
  not say that it is connected. [AGKRRV] §14.1.1 takes the curve connected, and [GLC1] §0.5.7
  largely follows the conventions of [AGKRRV].
* Reformulation: $G$ and $\check G$ are given by their coordinate Hopf algebras, which are terms
  of `TauCeti.ReductiveCommHopfAlgCat k`: the finitely generated commutative Hopf algebras over
  $k$ that are smooth and geometrically connected, and whose geometric fibre has no nontrivial
  connected normal smooth unipotent closed subgroup. Tau Ceti presents the affine group schemes
  over a field in this way.
* Reading: $G$ has a pinning. [GLC1] names no pinning. [GLC1] §1.3.1 uses a Borel subgroup $B$
  of $G$ with its unipotent radical $N$ and the torus $T = B/N$. [GLC1] §1.3.6 uses for each
  simple root a map $\chi_i : \mathrm{Bun}_{N_i,\rho_i(\omega_X)} \to \mathbb{G}_a$ that records
  the class of an extension, and names no further choice. Here the pinning is the chosen data
  with which the vacuum Poincaré object is defined (`vacuumPoincare`): its Borel subgroup is
  $B$, and its generators of the simple root spaces identify the root subgroups of the simple
  roots with $\mathbb{G}_a$, an identification with which $\chi_i$ is defined and which [GLC1]
  does not name. The pinning has more data than this: a maximal torus inside $B$, and an
  isomorphism of this torus with $\mathbb{G}_m^r$. For example, the identity and the inversion
  of $\mathbb{G}_m$ give two different pinnings of $G = \mathbb{G}_m$, with the same torus and
  the same Borel subgroup. [GLC1] §§1.3.1–1.3.7 name neither a torus inside $B$ nor such an
  isomorphism. Over an algebraically closed field every connected reductive group has a pinning.
* Reading: $\check G$ is any connected reductive group with a duality datum for $G$ and
  $\check G$. Over an algebraically closed field, as in the statement, these are the Langlands
  dual groups of $G$. [GLC1] §0.1.1 speaks of the Langlands dual group of $G$, which is
  determined by $G$ up to isomorphism, and names no duality datum.
* Generalization: $k$ is any field, because the data make sense over every field. [GLC1] §0.1.1
  takes $k$ of characteristic $0$. The declarations after `Setting` ask that $k$ is
  algebraically closed and of characteristic $0$. Over a general field only split groups have a
  pinning, and a duality datum need not determine $\check G$ up to isomorphism over $k$
  (`RootDatumDuality`). -/
@[placeholder] structure Setting (k : Type u) [Field k] where
  /-- The curve $X$, as a scheme. -/
  X : Scheme.{u}
  /-- The structure morphism $X \to \operatorname{Spec} k$. -/
  [over : X.Over (Spec (.of k))]
  /-- The curve $X$ is smooth of relative dimension $1$ over $k$. -/
  [smooth : SmoothOfRelativeDimension 1 (X ↘ Spec (.of k))]
  /-- The curve $X$ is proper over $k$. -/
  [proper : IsProper (X ↘ Spec (.of k))]
  /-- The curve $X$ is connected. In particular it is nonempty. -/
  [connected : ConnectedSpace X]
  /-- The coordinate Hopf algebra of the connected reductive group $G$. -/
  G : TauCeti.ReductiveCommHopfAlgCat k
  /-- The rank $r$ of the split torus $\mathbb{G}_m^r$ of `pinning`. -/
  rank : ℕ
  /-- The pinning of $G$: a closed immersion of the split torus $\mathbb{G}_m^r$ into $G$, for
  $r$ = `rank`, whose image is a maximal torus of every geometric fibre of $G$; a Borel subgroup
  that contains this torus; and a generator of each simple root space. The closed immersion is
  part of the data, not only its image. `TauCeti.Pinning` asks that the Hopf algebra is smooth
  over $k$, which holds because $G$ is reductive. -/
  pinning : @TauCeti.Pinning k _ G.obj.obj _ G.property.smooth _ rank
  /-- The invertible sheaf $\omega_X^{1/2}$ on $X$ ([GLC1] §1.3.2). -/
  sqrtOmega : TauCeti.AlgebraicGeometry.InvertibleSheaf X
  /-- The isomorphism $\omega_X^{1/2} \otimes \omega_X^{1/2} \cong \Omega_{X/k}$ of
  $\mathcal{O}_X$-modules, which makes $\omega_X^{1/2}$ a square root of the canonical line bundle
  of $X$. -/
  sqrtOmegaIso : (sqrtOmega.tensorProduct sqrtOmega).obj ≅ X.relativeDifferentials k
  /-- The coordinate Hopf algebra of the connected reductive group $\check G$. -/
  dualGroup : TauCeti.ReductiveCommHopfAlgCat k
  /-- The duality datum for $G$ and $\check G$: an isomorphism from the dual of the based root
  datum of $G$ to the based root datum of $\check G$. It is not an isomorphism of groups. -/
  dualIdentification : RootDatumDuality G dualGroup

attribute [instance] Setting.over Setting.smooth Setting.proper Setting.connected

variable {k : Type u} [Field k]

/-- The DG category $\mathrm{QCoh}(\mathrm{LS}_{\check G})$ of quasi-coherent sheaves on the
moduli stack $\mathrm{LS}_{\check G}$ of de Rham $\check G$-local systems on $X$, which is a
derived stack ([GLC1] §§0.1.1, 1.2.2; [ArinkinGaitsgory] §10.1), for a setting `S` over an
algebraically closed field $k$ of characteristic $0$.

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
comment gives the reason. -/
@[placeholder] opaque QCohLS [CharZero k] [IsAlgClosed k] (S : Setting k) : DGCat k

/-- The DG category $\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$ of half-twisted D-modules on
the moduli stack $\mathrm{Bun}_G$ of $G$-bundles on $X$, for a setting `S` over an algebraically
closed field $k$ of characteristic $0$: the D-modules twisted by the $\mu_2$-gerbe
$\det^{\frac{1}{2}}_{\mathrm{Bun}_G}$ of square roots of the determinant line bundle
$\det_{\mathrm{Bun}_G}$, whose fibre at a $G$-bundle $\mathcal{P}$ is
$\det \Gamma(X, \mathfrak{g}_{\mathcal{P}}) \otimes
\det \Gamma(X, \mathfrak{g}_{\mathcal{P}^0})^{\otimes -1}$
for the trivial $G$-bundle $\mathcal{P}^0$ ([GLC1] §§1.1.1–1.1.4). The square root
$\omega_X^{1/2}$ of `S` gives a square root of $\det_{\mathrm{Bun}_G}$, and with it an
equivalence of this category with $\mathrm{Dmod}(\mathrm{Bun}_G)$ ([GLC1] §§1.1.2, 1.1.5).

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
comment gives the reason. -/
@[placeholder] opaque DmodHalf [CharZero k] [IsAlgClosed k] (S : Setting k) : DGCat k

/-- The DG category $\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$ of ind-coherent
sheaves on $\mathrm{LS}_{\check G}$ with singular support in the global nilpotent cone
([GLC1] §§0.1.1, 1.6.3; [ArinkinGaitsgory] §§11.1.1, 11.1.5), with a t-structure, for a setting
`S` over an algebraically closed field $k$ of characteristic $0$. The connective objects of the
t-structure are the objects whose image under $\Psi_{\mathrm{Nilp},\{0\}}$ (`Psi`) is connective
in $\mathrm{QCoh}(\mathrm{LS}_{\check G})$.

This is the t-structure of [GLC1] §1.6.3 and Cor. 1.6.5. [GLC1] §1.6.3 does not define it, and
states that $\Psi_{\mathrm{Nilp},\{0\}}$ is t-exact and restricts to an equivalence on
eventually coconnective objects. These two statements give the description above. If the image
of an object $A$ is connective, then
$\Psi_{\mathrm{Nilp},\{0\}}(\tau^{\geq 1} A) \simeq
\tau^{\geq 1} \Psi_{\mathrm{Nilp},\{0\}}(A) = 0$,
and so $\tau^{\geq 1} A = 0$, because $\tau^{\geq 1} A$ is eventually coconnective. The converse is
the t-exactness. [ArinkinGaitsgory] §4.4.1 defines the t-structure in this way on
$\mathrm{IndCoh}_Y(Z)$, for a quasi-smooth affine DG scheme $Z$ and a conical Zariski-closed
subset $Y$ of $\mathrm{Sing}(Z)$ that contains the zero-section.

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
comment gives the reason. -/
@[placeholder] opaque IndCohNilp [CharZero k] [IsAlgClosed k] (S : Setting k) :
    TStructuredDGCat k

/-- The continuous functor
$$\Psi_{\mathrm{Nilp},\{0\}} : \mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G}) \to
  \mathrm{QCoh}(\mathrm{LS}_{\check G})$$
of [GLC1] §1.6.3, for a setting `S` over an algebraically closed field $k$ of characteristic $0$:
the right adjoint of the functor $\Xi_{\{0\},\mathrm{Nilp}}$, by which
$\mathrm{QCoh}(\mathrm{LS}_{\check G})$ is a full subcategory of
$\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$ ([GLC1] §5.4.4;
[ArinkinGaitsgory] §11.1.5 for the embedding). [GLC1] §1.6.3 states that
$\Psi_{\mathrm{Nilp},\{0\}}$ is t-exact and that it restricts to an equivalence between the full
subcategories of eventually coconnective objects.

[GLC1] §1.6.3 cites [ArinkinGaitsgory] Prop. 4.4.5 for these two statements. That proposition
and the pair of adjoint functors
$\Xi_Z^Y : \mathrm{QCoh}(Z) \rightleftarrows \mathrm{IndCoh}_Y(Z) : \Psi_Z^Y$ of
[ArinkinGaitsgory] §4.3.7 are about a quasi-smooth affine DG scheme $Z$ and a conical
Zariski-closed subset $Y$ of $\mathrm{Sing}(Z)$ that contains the zero-section.

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
comment gives the reason. -/
@[placeholder] opaque Psi [CharZero k] [IsAlgClosed k] (S : Setting k) :
    DGFun (IndCohNilp S).toDGCat (QCohLS S)

/-- The DG category $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$, for a setting `S` over an
algebraically closed field $k$ of characteristic $0$: the de Rham version of the category
$\mathrm{Rep}(\check G)$ of representations of $\check G$, spread over the Ran space of $X$
([GLC1] §1.2.1). [GaitsgoryOutline] §4.2.4 defines it as the category of quasi-coherent sheaves
on the prestack $(\mathrm{pt}/\check G)_{\mathrm{Ran}(X)}$.

Reformulation: this constant is the DG category alone. In [GLC1] §1.2.1 the category
$\mathrm{Rep}(\check G)_{\mathrm{Ran}}$ acts on $\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$, so
it has a monoidal structure ([GaitsgoryOutline] §§4.2.3–4.2.4: a symmetric monoidal structure
without unit). The reason: `IsLanglandsFunctor` uses the action only through the functors
`heckeActionRight S M`.

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
comment gives the reason. -/
@[placeholder] opaque RepRan [CharZero k] [IsAlgClosed k] (S : Setting k) : DGCat k

/-- The spectral localization functor
$$\mathrm{Loc}^{\mathrm{spec}}_{\check G} : \mathrm{Rep}(\check G)_{\mathrm{Ran}} \to
  \mathrm{QCoh}(\mathrm{LS}_{\check G})$$
([GLC1] §1.2.2; [GaitsgoryOutline] §4.3.3), as a continuous functor, for a setting `S` over an
algebraically closed field $k$ of characteristic $0$.

Differences from [GLC1]:

* Correction: the display of [GLC1] §1.2.2 writes the source of this functor as
  $\mathrm{Rep}(\check G)$. The source is $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$:
  [GLC1] §1.2.2 obtains the right adjoint of the functor from the compact generation of
  $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$, [GLC1] Thm. 1.2.4 states that the action of
  $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$ factors through the functor, and
  [GaitsgoryOutline] §4.3.3 defines the functor on $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$.
* Reformulation: this constant is the continuous functor alone. In [GLC1] §1.2.2 the functor is
  symmetric monoidal. The symmetric monoidal structure is not part of the constant. The reason:
  `IsLanglandsFunctor` uses only the continuous functor.
* Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
  comment gives the reason. -/
@[placeholder] opaque Loc [CharZero k] [IsAlgClosed k] (S : Setting k) : DGFun (RepRan S) (QCohLS S)

/-- The continuous functor $V \mapsto V \star M$ from $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$ to
$\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$, for a setting `S` over an algebraically closed
field $k$ of characteristic $0$ and an object $M$ of
$\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$. Here $\star$ is the Hecke action of
$\mathrm{Rep}(\check G)_{\mathrm{Ran}}$ on $\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$, which
the naive geometric Satake functor and the Hecke functors define ([GLC1] §1.2.1;
[GaitsgoryOutline] §§4.4.2–4.4.4, for the category $\mathrm{Dmod}(\mathrm{Bun}_G)$ without the
twist).

Reformulation: this constant is one continuous functor for each object $M$. [GLC1] §1.2.1 has
an action of the monoidal category $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$. The monoidal
structure of $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$, the functoriality in $M$ and the
associativity of the action are not part of the constant. The reason: `IsLanglandsFunctor` uses
only the functor $V \mapsto V \star M$ for the vacuum Poincaré object $M$.

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
comment gives the reason. -/
@[placeholder] opaque heckeActionRight [CharZero k] [IsAlgClosed k] (S : Setting k)
    (M : (DmodHalf S).Obj) : DGFun (RepRan S) (DmodHalf S)

/-- The vacuum Poincaré object
$\mathrm{Poinc}^{\mathrm{Vac,glob}}_{G,!} = \mathfrak{p}_! \chi^*(\exp)$ of
$\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$ ([GLC1] §1.3.7), for a setting `S` over an
algebraically closed field $k$ of characteristic $0$. Here:

* $\mathrm{Bun}_{N,\rho(\omega_X)} = \mathrm{Bun}_B \times_{\mathrm{Bun}_T} \mathrm{pt}$
  ([GLC1] §1.3.1), where $B$ is the Borel subgroup of the pinning of `S`, $N$ is its unipotent
  radical, $T = B/N$, and the point of $\mathrm{Bun}_T$ is the $T$-bundle $\rho(\omega_X)$ of
  [GLC1] Cor. 1.3.4, which uses the square root $\omega_X^{1/2}$ of `S` ([GLC1] §1.3.2);
* $\mathfrak{p} : \mathrm{Bun}_{N,\rho(\omega_X)} \to \mathrm{Bun}_G$ is the projection, and
  $\mathfrak{p}^! : \mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G) \to
  \mathrm{Dmod}(\mathrm{Bun}_{N,\rho(\omega_X)})$
  is the functor of [GLC1] §1.3.5, from half-twisted D-modules to D-modules without twist, which
  the square root of [GLC1] Cor. 1.3.4 defines;
* $\mathfrak{p}_!$ is the partially defined left adjoint of $\mathfrak{p}^!$ ([GLC1] §1.3.5);
* $\chi : \mathrm{Bun}_{N,\rho(\omega_X)} \to \mathbb{G}_a$ is the map of [GLC1] §1.3.6, defined
  with the generators of the simple root spaces of the pinning of `S`;
* $\exp$ is the exponential D-module on $\mathbb{G}_a$, normalized so that
  $\mathrm{add}^*(\exp) \simeq \exp \boxtimes \exp$, that is,
  $\exp \in \mathrm{Dmod}(\mathbb{G}_a)^{\heartsuit}[-1]$ ([GLC1] §1.3.7);
* $\mathfrak{p}_!$ is defined on $\chi^*(\exp)$, because this object is holonomic
  ([GLC1] §1.3.7).

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
comment gives the reason. -/
@[placeholder] opaque vacuumPoincare [CharZero k] [IsAlgClosed k] (S : Setting k) : (DmodHalf S).Obj

variable [CharZero k] [IsAlgClosed k]

/-- The two properties of a continuous functor that this file uses in place of the two properties
of [GLC1] Cor. 1.6.5, which characterize the Langlands functor. Let `S` be a setting over an
algebraically closed field $k$ of characteristic $0$, and let
$F : \mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G) \to
\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$
be a continuous functor. Then `IsLanglandsFunctor S F` states that both properties hold:

1. For every compact object $c$ of $\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$, the object
   $F(c)$ is eventually coconnective for the t-structure of
   $\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$. The bound may depend on $c$.
   This property asks nothing about $F(c)$ for an object $c$ that is not compact.
2. There exists an equivalence of mapping spaces
   $$\mathrm{Maps}(V \star \mathrm{Poinc}, M) \simeq
     \mathrm{Maps}(\mathrm{Loc}(V), \Psi(F(M)))$$
   that is natural in the objects $V$ of $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$ and $M$ of
   $\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$ together (`DGFun.MapsEquiv`). Here $\star$ is the
   Hecke action (`heckeActionRight`), $\mathrm{Poinc}$ is the vacuum Poincaré object
   (`vacuumPoincare`), $\mathrm{Loc}$ is the spectral localization functor (`Loc`) and $\Psi$ is
   the functor $\Psi_{\mathrm{Nilp},\{0\}}$ (`Psi`). The object $M$ runs over all objects,
   compact or not.

Property 1 is the first property of [GLC1] Cor. 1.6.5.

Reformulation: property 2 takes the place of the second property of [GLC1] Cor. 1.6.5, which is
an equivalence $\Psi_{\mathrm{Nilp},\{0\}} \circ F \simeq \mathbb{L}_{G,\mathrm{coarse}}$ of
continuous functors. The reason: property 2 needs neither the action of
$\mathrm{QCoh}(\mathrm{LS}_{\check G})$ on $\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$ nor the
functor $\mathbb{L}_{G,\mathrm{coarse}}$, which both rest on [GLC1] Thm. 1.2.4. The two
properties compare as follows.

* The second property of [GLC1] Cor. 1.6.5 gives property 2. By [GLC1] Thm. 1.2.4 the Hecke
  action factors through $\mathrm{Loc}$. This gives the action of
  $\mathrm{QCoh}(\mathrm{LS}_{\check G})$, with $\mathrm{Loc}(V) \star M \simeq V \star M$
  ([GLC1] §1.2.5). The functor $\mathbb{L}_{G,\mathrm{coarse}}$ is the right adjoint of
  $E \mapsto E \star \mathrm{Poinc}$ ([GLC1] §§1.4.2, 1.4.5). So there is an equivalence
  $\mathrm{Maps}(V \star \mathrm{Poinc}, M) \simeq
  \mathrm{Maps}(\mathrm{Loc}(V), \mathbb{L}_{G,\mathrm{coarse}}(M))$
  that is natural in $V$ and $M$ together, and an equivalence
  $\Psi_{\mathrm{Nilp},\{0\}} \circ F \simeq \mathbb{L}_{G,\mathrm{coarse}}$ turns it into
  property 2.
* Property 2 gives an equivalence
  $\Psi_{\mathrm{Nilp},\{0\}} \circ F \simeq \mathbb{L}_{G,\mathrm{coarse}}$ of the underlying
  functors of $\infty$-categories, because the right adjoint of $\mathrm{Loc}$ is fully faithful
  ([GLC1] §1.2.2). This comparison supplies no compatibility of the equivalence with the module
  structures over $\mathrm{Vect}_k$, which an equivalence of continuous functors has. It is not
  claimed here that property 2 gives the second property of [GLC1] Cor. 1.6.5, or that it does
  not.
* The main theorem does not depend on that question. The functor $\mathbb{L}_G$ of
  [GLC1] Cor. 1.6.5 has properties 1 and 2. For a continuous functor $F$ with properties 1 and
  2, the underlying functors of $\infty$-categories of $F$ and of $\mathbb{L}_G$ are equivalent,
  by the argument of [GLC1] §1.6.4: for a compact object $c$ both $F(c)$ and $\mathbb{L}_G(c)$
  are eventually coconnective, $\Psi_{\mathrm{Nilp},\{0\}}$ restricts to an equivalence on
  eventually coconnective objects ([GLC1] §1.6.3), and
  $\mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G)$ is compactly generated ([GLC1] §1.6.4). A
  continuous functor is an equivalence exactly when its underlying functor of $\infty$-categories
  is an equivalence. So a continuous functor with properties 1 and 2 is an equivalence exactly
  when $\mathbb{L}_G$ is.

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask. The module doc
comment gives the reason. -/
@[placeholder] def IsLanglandsFunctor (S : Setting k)
    (F : DGFun (DmodHalf S) (IndCohNilp S).toDGCat) : Prop :=
  (∀ c : (DmodHalf S).Obj,
    DGCat.IsCompact c → (IndCohNilp S).IsEventuallyCoconnective (F.obj c)) ∧
      Nonempty (DGFun.MapsEquiv (heckeActionRight S (vacuumPoincare S)) (Loc S)
        (F.comp (Psi S)))

/-- Let `S` be a setting over an algebraically closed field $k$ of characteristic $0$. A
continuous functor
$F : \mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G) \to
\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$
has the two properties of `IsLanglandsFunctor` if and only if $F(c)$ is eventually coconnective
for every compact object $c$, and there exists an equivalence
$\mathrm{Maps}(V \star \mathrm{Poinc}, M) \simeq \mathrm{Maps}(\mathrm{Loc}(V), \Psi(F(M)))$ of
mapping spaces that is natural in $V$ and $M$ together. This unfolds the definition of
`IsLanglandsFunctor`.

Restriction: $k$ is algebraically closed, which [GLC1] §0.1.1 does not ask, as in
`IsLanglandsFunctor`. The module doc comment gives the reason. -/
theorem isLanglandsFunctor_iff (S : Setting k)
    (F : DGFun (DmodHalf S) (IndCohNilp S).toDGCat) :
    IsLanglandsFunctor S F ↔
      (∀ c : (DmodHalf S).Obj,
        DGCat.IsCompact c → (IndCohNilp S).IsEventuallyCoconnective (F.obj c)) ∧
          Nonempty (DGFun.MapsEquiv (heckeActionRight S (vacuumPoincare S)) (Loc S)
            (F.comp (Psi S))) := Iff.rfl

/-- **The de Rham geometric Langlands conjecture** ([GLC1] Conj. 1.6.7, with the existence part
of [GLC1] Cor. 1.6.5). Let `S` be a setting over an algebraically closed field $k$ of
characteristic $0$. Then:

* there exists a continuous functor
  $F : \mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G) \to
  \mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$
  with the two properties of `IsLanglandsFunctor`; and
* every continuous functor
  $F : \mathrm{Dmod}_{\frac{1}{2}}(\mathrm{Bun}_G) \to
  \mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$
  with the two properties of `IsLanglandsFunctor` is an equivalence (`DGFun.IsEquivalence`).

The theorem is about each setting `S`. It gives a functor for each setting, and it gives no
setting.

Differences from [GLC1]:

* Reformulation: no functor is chosen. [GLC1] Cor. 1.6.5 states that a continuous functor
  $\mathbb{L}_G$ with its two properties exists and that these properties determine it, and
  [GLC1] Conj. 1.6.7 states that $\mathbb{L}_G$ is an equivalence. Here the first part follows
  from [GLC1] Cor. 1.6.5, because $\mathbb{L}_G$ has the two properties of `IsLanglandsFunctor`.
  The second part holds exactly when [GLC1] Conj. 1.6.7 holds, because a continuous functor with
  the two properties of `IsLanglandsFunctor` is an equivalence exactly when $\mathbb{L}_G$ is.
  The doc comment of `IsLanglandsFunctor` gives the argument for both. The uniqueness in
  [GLC1] Cor. 1.6.5 is not stated. The reason: this form needs no construction of
  $\mathbb{L}_G$. The first part is there because the second part alone would hold if no functor
  had the two properties.
* Reformulation: the second property of `IsLanglandsFunctor` is stated with mapping spaces and
  the Hecke action of $\mathrm{Rep}(\check G)_{\mathrm{Ran}}$. The doc comment of
  `IsLanglandsFunctor` gives the reason and compares it with the second property of
  [GLC1] Cor. 1.6.5.
* Restriction: $k$ is algebraically closed. [GLC1] §0.1.1 takes a field of characteristic $0$.
  The reason: [GLC1] largely follows the conventions of [AGKRRV] ([GLC1] §0.5.7), where the
  ground field is algebraically closed ([AGKRRV] §0.9.1), and [GLC2] §0.4.1 works over an
  algebraically closed field of characteristic $0$.
* The doc comment of `Setting` records the differences in the data: the curve is connected, the
  groups are given by their coordinate Hopf algebras, $G$ has a pinning, and $\check G$ is
  chosen with a duality datum for $G$ and $\check G$. -/
theorem exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence
    (S : Setting k) :
    (∃ F : DGFun (DmodHalf S) (IndCohNilp S).toDGCat, IsLanglandsFunctor S F) ∧
      ∀ F : DGFun (DmodHalf S) (IndCohNilp S).toDGCat,
        IsLanglandsFunctor S F → F.IsEquivalence := sorry

end GLCinLean.Statement

end
