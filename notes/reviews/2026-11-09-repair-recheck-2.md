# Second recheck of the blueprint repairs, 2026-11-09

Reviewed commit: **`834cc56c755f4c3b9d01159e5d66067e99cce1e4`** ("Repair Satake and
spectral-decomposition plans after recheck"). It answers the recheck report
`notes/reviews/2026-11-09-repair-recheck.md` (written at `df60ff1`, reviewing `76abe97`).
I compared `git diff df60ff1 834cc56`. No Lean file changed, so no build, axiom audit or blind
reading was run.

Reviewer: Claude Opus 5.5, in a fresh session. I wrote none of the plans and took part in none
of the earlier reviews. I treated the commit message, `STATUS.md` and the plan texts as claims to
test.

Paths and references:
- Plan paths are relative to `plans/GLCinLean/` unless they start with `plans/`. A plan line
  number is the line of the node's `id`.
- Paper lines are in `references/papers/<id>v<version>/src/`.
- Paper numbers come from `tools/tex-locator.awk`, except for MV, which numbers per section.
  MV numbers were read by hand.

## Decision

**Request changes.**

- B2, N1 and N2 are fixed. M1 and M2 are fixed, but the new nodes for M1 bring two new
  problems (F3).
- B1 is only partly fixed. Semisimplicity of the heart now has a node and a proof route. But
  that route rests on parity vanishing of IC stalks, which still has no node (R1). It also rests
  on a Riemann–Hilbert node whose target category is not planned (F1).
- M3 is only partly fixed. The new lemma needs a *unital* monoidal category. But the plan's
  $\operatorname{Rep}(\check G)_{\rm Ran}$, its localization functor and the Hecke action are
  all built on the *non-unital* convolution structure (F2).
- The commit takes the owner question about the field comparison (question 1 of the earlier
  report) as answered. The owner has not answered it (Q1).

## Blocker

### R1. Parity vanishing of IC stalks is still not planned (rest of B1)

- **What the plan says.** `GeometricLanglands/Satake/Spherical.toml:11`
  (`Satake.sphericalHeart_semisimple`), step (4): over $\mathbb C$,
  $\operatorname{Hom}(IC_\lambda, IC_\mu[1])$ "vanishes by the proof of [MV] Lemma 7.1: parity
  vanishing of IC stalks [LusztigQAnalog] §11 and simple connectedness of the orbits".
- **What MV says.** The proof of Lemma 7.1 (`math-0401222v5/src/Satake.tex:2621–2626`) is two
  lines long. It rests entirely on "the parity vanishing of the stalks of
  $\mathcal I_{!*}(\lambda)$, proved in [Lu], section 11".
- **What is missing.**
  - No plan node states parity vanishing. I searched every node `id` and `desc` for "parity
    vanish", "Kazhdan", "purity" and "decomposition theorem". The only hit is the text of
    `sphericalHeart_semisimple` itself.
  - Lusztig's §11 is not a short lemma. It computes IC stalks on the affine Grassmannian by
    Kazhdan–Lusztig polynomials of the affine Weyl group. That computation needs purity (Weil II)
    or the decomposition theorem. In this plan it would be one of the largest single inputs.
  - Parity vanishing is used a second time. [ParabolicEisensteinFH] §A.2 proves Lemma 4.5.7.1
    with it: "the result follows from the parity vanishing of $\operatorname{IC}^\lambda$"
    (`2507.13930v2/src/main.tex:4245`). The plan uses that lemma through
    `SemiInfinite.parabolicIC_koszulBoundary` (`GeometricLanglands/SemiInfinite/ParabolicIC.toml:18`,
    source "§§4.5.4–4.5.7").
- **Why it blocks.** The earlier report's B1 named this gap ("No node plans semisimplicity of
  the heart or parity vanishing of IC stalks"). Half of it is still open. Once its five inputs
  exist, `sphericalHeart_semisimple` would show as ready in the tracker. But its proof would
  still need an unplanned theorem about as large as the rest of the Satake chain.
- **Required change.**
  - Add a node for parity vanishing of IC stalks on finite Schubert unions over $\mathbb C$, for
    constructible sheaves. Give it a written proof route and the sources that route needs
    ([LusztigQAnalog] §11 and its inputs). Then make `sphericalHeart_semisimple` and the node
    that proves [ParabolicEisensteinFH] Lemma 4.5.7.1 depend on it.
  - Or plan another proof of semisimplicity that avoids it.

## Must be fixed before approval

### F1. The Riemann–Hilbert node has no planned target category (B1 route)

- `AlgebraicGeometry/DModules/RiemannHilbert.toml:4` (`DModules.schubertRiemannHilbert`)
  compares regular holonomic D-modules with "bounded complexes of sheaves of C-vector spaces on
  Y(C) constructible along the strata", with perverse sheaves, $j_{!*}$, the six operations and
  Hom in every degree.
- Its dependencies are `holonomic`, `intermediateExtension`, `perverseHeart`,
  `schubertStratification` and `deRhamPushforward`. No node plans any of the following:
  - sheaves on $Y(\mathbb C)$ in the classical topology;
  - the constructible derived category, its perverse t-structure and its six operations;
  - analytification and the analytic de Rham functor;
  - regular holonomicity as a notion of its own. It appears only inside the text of
    `DModules.perverseHeart`.
- This was already implicit in `Satake.regularSheafExt_complexComparison`. The new node makes
  it a named dependency, but with none of its own inputs. Add nodes for the topological side,
  or record it as an external boundary, as the owner decides (Q1).

### F2. The module lemma needs a unit, but the plan's monoidal structure has none (rest of M3)

- **What the plan says.**
  - `CategoryTheory/Infinity/Module.toml:18` (`Infinity.moduleOverMonoidalLocalization`) is
    stated for a monoidal functor $F: A\to B$ of presentable stable *monoidal* (unital)
    categories.
  - `Spectral.localization` (`GeometricLanglands/Spectral/Localization.toml:4`) is symmetric
    monoidal for `Hecke.ranConvolution`. `Hecke.ranConvolution`
    (`GeometricLanglands/Hecke/Representations.toml:18`) is "the non-unital symmetric monoidal
    product".
  - `Hecke.ranRepresentations_rigid` (`Hecke/Representations.toml:25`) claims rigidity "in the
    unital Ran setting where the convolution structure needs a unit". No node builds that
    unital setting. Its dependencies are `ranRepresentations`, `ranConvolution`,
    `representationCategory`, `rigidMonoidalCategory` and `compactGeneration`.
- **What the papers say.**
  - [GaitsgoryOutline] §4.2.3 makes $\operatorname{Rep}(\check G)_{\rm Ran}$ a "(non-unital)
    symmetric monoidal category" (`1302.2506v3/src/outline.tex:2893–2933`). Cor. 4.5.5
    (`:3099–3102`) asserts the factorization with no proof.
  - [GLC2] §15.5.1 shows how to handle this. The convolution action of
    $(\operatorname{Rep}(\check G)_{\rm Ran})^\star$ factors through
    $\operatorname{Rep}(\check G)_{\operatorname{Ran}^{\rm untl},\rm indep}$. The spectral
    localization factors in the same way (`2405.03648v3/src/Loc.tex:17431–17462`). This uses
    Ran-unitality of the Hecke action (Cor. H.6.10, `Loc.tex:38083ff`).
- **Why it matters.** `Spectral.actionOfVanishing` (`Spectral/Action.toml:18`) applies the unital
  lemma to the non-unital functor. As planned, that step does not type-check.
- **Required change.**
  - Add nodes for $\operatorname{Rep}(\check G)_{\operatorname{Ran}^{\rm untl},\rm indep}$, for
    the factorization of `Spectral.localization` through it, and for the factorization of
    `Hecke.action` through it ([GLC2] §15.5.1, §§H.6.8–H.6.10).
  - State the rigidity node for that unital category.
  - Also restrict `moduleOverMonoidalLocalization` to the generality its source covers.
    [LurieHA] §4.8.2 treats idempotent objects in *symmetric* monoidal categories. The
    application only needs symmetric monoidal $A$ and $B$. With only one-sided linearity of the
    right adjoint, the $E_1$ statement is not covered by the cited source. Either state it for
    symmetric monoidal $A$ and $B$, or require the right adjoint to be linear on both sides.
- **What is now correct.**
  - The rank induction is set up explicitly (`GeometricLanglands/Spectral/Generation.toml:11`).
  - Semisimple rank drops for proper Levis. Rank zero is handled.
  - The graph has no cycle. The dependency closure of `Spectral.actionOfVanishing` (244 nodes)
    and of `SpectralProof.parabolicGlobalization_comparison` (330 nodes) contains neither
    `localizationKernel_annihilatesAutomorphic` nor `heckeAction_factors`.
  - The rigidity node is sourced honestly. It says that [GLC1] §1.2.2
    (`2405.03599v3/src/functor.tex:1440–1447`) only asserts rigidity.
- **Is the module lemma true?** Yes, for symmetric monoidal $A$ and $B$. A continuous, fully
  faithful and $A$-linear right adjoint $G$ makes $R=G(1_B)$ an idempotent algebra with
  $GF(a)\simeq a\otimes R$. Then $B$-modules are exactly the $A$-modules on which
  $K_0=\operatorname{fib}(1\to R)$ acts by zero. The kernel of $F$ is $K_0\otimes A$, so this
  agrees with "the kernel acts by zero".

### F3. Two statements in the new M1 nodes are wrong or not definite

- `GeometricLanglands/Satake/Renormalized.toml:18` (`Satake.naiveFactorizationFunctor_renormalized`)
  says that "the naive functor factors through ren".
  - That is false. $\operatorname{ren}$ is the fully faithful *left* adjoint
    ([GLC2] §1.5.3, `Loc.tex:2289–2295`).
  - $\operatorname{ren}(\delta_1)$ is not the compact unit of $\operatorname{Sph}_G$, since
    $\delta_1$ is not compact in $\operatorname{Sph}^{\rm non\text{-}ren}_G$.
  - What is needed, and what the rest of the text builds, is a *lift along non-ren*: a functor
    $L$ with $\operatorname{non\text{-}ren}\circ L\simeq$ the naive functor. It is defined on the
    loc.c objects and extended to the ind-completion. Fix the wording before it becomes a
    docstring.
- `GeometricLanglands/Spectral/DerivedSatake/Monads.toml:53` (`Satake.naiveRenormalized_eq_derivedSatakeInverse`)
  identifies $L$ with $\operatorname{Sat}_G^{-1}\circ\operatorname{nv}$ "up to the explicit
  Chevalley and flip normalizations of [GLC2] §1.8".
  - As written, it is not a definite statement.
  - By [GLC2] Example 1.7.4 (`Loc.tex:2560–2569`), $\operatorname{Sat}_G(IC_\lambda)=\operatorname{nv}(V^{-w_0\lambda})$.
    So $\operatorname{Sat}^{\rm nv}_G(V^\mu)=IC_{-w_0\mu}$, while the MV-normalized naive
    functor sends $V^\mu$ to $IC_\mu$.
  - The node must name the exact composite ($\tau_G\circ\operatorname{Sat}^{\rm nv}_G$, or
    whichever one Example 1.7.4 forces) that is isomorphic to $L$.
  - Its source cites "Corollary 1.8.1". The corollary at `Loc.tex:2616` is **1.8.2**; the
    unnumbered subsubsection at `:2611` takes 1.8.1.
  - The node is in the namespace `Satake` but lives in the module
    `Spectral/DerivedSatake/Monads.toml`. Move it to its canonical home (AGENTS.md).

## Unresolved questions for the owner

1. **Field comparison (question 1 of the earlier report).** The earlier report asked the owner
   whether a comparison through $\bar{\mathbb Q}$ and $\mathbb C$ is acceptable for the heart.
   The commit adopts it without a recorded answer. It rewrites
   `Satake.geometricSatakeHeartEquivalence` (`GeometricLanglands/Satake/Equivalence.toml:4`) so
   that "the only comparison with complex topology is the Ext^1 vanishing". Together with R1
   and F1, this choice brings classical topology, Riemann–Hilbert and parity vanishing into
   the statement's dependency closure. The owner should confirm it.
2. **Pinning choice (question 2 of the earlier report).** It is untouched and still open.
3. **Faergeman–Hayash's untwisted setting.** [ParabolicEisensteinFH] works with untwisted
   $D(\operatorname{Gr}_G)$ and with naive Satake from plain
   $\operatorname{Rep}(\check G)_{\rm Ran}$. Its introduction says it ignores twists
   (`main.tex:764`, `:3974`, §B at `:4248ff`). The plan now uses the half-twisted category, as
   [GLC3] does (`2409.07051v1/src/Eis.tex:1927–1930`). That is the right setting by B2. But
   applying the FH proofs there is an adaptation that no node records. For $GL_n$ the
   untwisted claim with plain $\operatorname{Rep}(\check G)_{\rm Ran}$ meets the sign problem
   of [GLys] §8.2.4. Should `SemiInfinite.parabolicIC` record the transfer to the half-twisted
   setting as an explicit obligation?

## Verdict on each finding

| Finding | Verdict | Evidence |
|---|---|---|
| **B1** reductivity of the Tannakian group | **Partly fixed.** Semisimplicity now has a node, and the Tau Ceti criterion is used correctly. Parity vanishing (R1) and the topological side of Riemann–Hilbert (F1) are not planned. | Below, "B1 in detail" |
| **B2** twist of factorization Satake | **Fixed.** | Below, "B2 in detail" |
| **M1** one spherical action, and a route to Sph-linear Eisenstein series | **Fixed.** New problems in the added nodes are F3. | Below, "M1 in detail" |
| **M2** the dropped Faergeman–Hayash hypothesis | **Fixed.** Small points below. | Below, "M2 in detail" |
| **M3** module structure and rank induction | **Partly fixed.** Unital and non-unital structures do not match (F2). | F2 |
| **N1** Outline Prop. 11.1.3 | **Fixed.** `Spectral/Parabolic/Enhancement.toml:39` and `:46` now cite 11.1.3. That number is right: `outline.tex:6939` gives 11.1.3, and `:6874` gives 11.1.1. `notes/blueprint-gap-resolution.md:76` is updated. No "11.1.4" remains for the Outline. | — |
| **N2** `indcohTStructure` depends on `artinStack` | **Fixed.** `AlgebraicGeometry/Sheaves/IndCoh.toml:25`. | — |

### B1 in detail

- **The Tau Ceti criterion.**
  - `TauCeti.reductiveCommHopfAlgProperty_iff_linearlyReductive` is at
    `.lake/packages/TauCeti/TauCeti/Algebra/AlgebraicGroup/Reductive/CompleteReducibility.lean:118–126`.
    The package is at the pin `e0610cce`.
  - Hypotheses: a field `k` with `CharZero k`; `H : FiniteTypeCommHopfAlgCat.{u,u} k`; and
    `geometricallyConnectedCommHopfAlgProperty k H.obj`.
  - "Linearly reductive" means that every finite-dimensional comodule is completely reducible
    (`TauCeti/Algebra/AlgebraicGroup/LinearlyReductive.lean:61`).
  - The plan file `plans/TauCeti/Algebra/AlgebraicGroup/Reductive/CompleteReducibility.toml:4`
    describes this correctly.
  - `Satake.tannakaRootDatum_equiv_dual` (`GeometricLanglands/Satake/DualGroup.toml:4`) supplies
    finite type and connectedness first, as the theorem requires. Both are explicit obligations
    in its text.
- **The field comparison, step by step.**
  - (1) Q̄-models: correct. Intermediate extension commutes with flat scalar extension.
  - (2) $\operatorname{Ext}^1$ in a full exact abelian subcategory injects into
    $\operatorname{Ext}^1$ in the larger one. $\operatorname{Ext}^1$ in a heart is
    $\operatorname{Hom}(-,-[1])$. So this step is correct, provided forgetting
    $L^+G$-equivariance is fully faithful on the heart. That is the D-module analogue of [MV]
    Prop. 2.1 (`Satake.tex:1162–1167`; MV proves it for sheaves in its Appendix A). The node
    uses it but does not state it as a step. The same holds for the claim that the simple
    objects are the $IC_\lambda$: this needs connected stabilizers.
  - (3) Base change of Hom: correct. Vanishing over $\mathbb C$ gives vanishing over
    $\bar{\mathbb Q}$, and then over `k`.
  - (4) Regularity is handled correctly. $D^b_{\rm rh}$ is a full subcategory of
    $D^b_{\rm hol}$, so Hom is the same in both. $IC_\lambda$ is regular, and $L^+G$-equivariance
    excludes irregular connections on the strata. The proof of MV Lemma 7.1 gives what the node
    claims, using simple connectedness for $\lambda=\mu$ and parity for $\lambda\ne\mu$. But it
    rests on R1.
- **Deligne–Milne locator.** The plan and `docs/references.bib` cite "[DeligneMilne]
  Propositions 2.20, 2.22 and 2.23". MV cite 2.22 as a *corollary* (`Satake.tex:2710`). Fix the
  locator.
- **An unused dependency.** `sphericalHeart_semisimple` lists `Groups.langlandsDual`. Its proof
  does not use it.

### B2 in detail

- **The chosen fix.** The fix is option 1 of the earlier report. `Satake.factorizationSphericalCategory`
  (`GeometricLanglands/Satake/Factorization.toml:4`), `Satake.renormalizedSphericalCategory`
  (`Satake/Renormalized.toml:4`) and `Satake.naiveFactorizationFunctor` (`Factorization.toml:25`)
  are now half-twisted. `Satake.criticalDeterminantGerbe` (`Satake/Twisting.toml:4`) is in the
  closure of each. Both spherical categories now use the same twist.
- **It agrees with GLys.**
  - [GLys] §9.1.1, formula (9.1) (`1608.00284v7/src/text.tex:6262–6264`): $\operatorname{Sph}_{\mathcal G^G}$
    is twisted by $\mathcal G^G\otimes\det_{\mathfrak g}^{1/2}$.
  - For trivial $\mathcal G^G$, the dual datum is $(\check G,\text{trivial},\text{trivial})$
    (§6.3, `:5240–5244`). For $\mathcal G^G=\det^{1/2}_{\mathfrak g}$, $\epsilon=2\check\rho(-1)$
    (`:5246–5262`).
  - So plain $\operatorname{Rep}(\check G)_{\rm Ran}$ goes to the half-twisted category, and the
    untwisted category receives the $\epsilon$-twisted source (§9.2.2, `:6349–6357`).
- **It agrees with GLC2.** [GLC2] Rem. 1.7.5 (`Loc.tex:2571–2576`), Rem. 1.1.4 with its footnote
  (`:1732–1738`), Rem. 1.1.7 (`:1771–1778`), Rem. 1.1.12 (`:1843–1849`) and §1.1.6 (`:1760–1769`)
  all match the new nodes. All these locators are right.
- **The pointwise heart comparison.** `Satake.halfTwistedHeart_equiv_untwistedHeart`
  (`Twisting.toml:18`) is correct. At one point, the square root of $\omega_X$ trivializes the
  gerbe as an ungraded multiplicative line bundle. That gives a monoidal equivalence for
  convolution, because the associativity data does not see the grading. The fusion constraint
  is computed over $X^2$, where only the $\mathbb Z/2$-graded factorization holds. So the
  constraint changes by the sign $(-1)^{p(\lambda)p(\mu)}$, with $p(\lambda)=\langle\lambda,2\check\rho\rangle \bmod 2$.
  That is MV's modification in §6 (`Satake.tex:2318ff`, especially `:2330–2430`). So the
  half-twisted fusion constraint corresponds to MV's corrected one. This agrees with GLys:
  the untwisted category with the unmodified constraint corresponds to $\operatorname{Rep}^\epsilon$.
- **Small points.**
  - None of the cited sources writes out this sign computation. Mark it in the node as an
    explicit adaptation obligation.
  - "Over Ran no factorization equivalence of the two categories exists" claims more than
    [GLC2] Rem. 1.1.12 and [GLys] §8.2.4 say. They say only that the specific identification is
    not compatible with factorization. Reword it.
  - `criticalDeterminantGerbe` now says "the determinant factorization line bundle". It dropped
    the word "adjoint". [GLys] uses $\det_{\mathfrak g}$, the determinant of the adjoint
    representation. Say which determinant it is.

### M1 in detail

- **One action.**
  - `Hecke.sphericalAction` (`GeometricLanglands/Hecke/Action.toml:11`) builds the action of
    $\operatorname{Sph}^{\rm non\text{-}ren}$. The renormalized category acts through
    $\operatorname{non\text{-}ren}$.
  - `Hecke.satake` (`Hecke/Satake.toml:4`) composes the naive functor with that action.
  - `Hecke.action_viaRenormalized` (`Action.toml:18`) then follows from
    $\operatorname{non\text{-}ren}\circ L\simeq$ naive.
  - This matches [GLC2] §§1.5.1–1.5.3 (`Loc.tex:2261–2295`: "non-ren monoidal … monoidal
    colocalization"). It also matches the integrated actions of §H.6.8 (`:38058–38066`) and the
    $\operatorname{Sph}_M$-module structure used in [GLC3] §8.2.1 (`Eis.tex:10370–10376`).
  - `SpectralProof.derivedSatakeTransform` (`Spectral/DerivedSatake/Construction.toml:32`) now
    depends on the renormalized category and on the local lift. `SpectralProof.enhancedEisenstein`
    (`Spectral/Parabolic/Enhancement.toml:25`) uses `Hecke.sphericalAction`.
- **The claim "naive = $\operatorname{Sat}^{-1}\circ\operatorname{nv}$ up to normalization".**
  It is true. [GLC2] §1.7.6 (`Loc.tex:2578–2581`) defines $\operatorname{Sat}^{\rm nv}_G$ this
  way. Example 1.7.4 fixes its values on IC objects. But the normalization must be stated
  exactly (F3).
- **Leftovers of the same kind.**
  - Several local nodes still depend on the *global* `Hecke.satake`, which now pulls in the
    action on $\operatorname{Bun}_G$: `SemiInfinite.parabolicIC`,
    `SpectralProof.sphericalWhittaker_equiv_representations`, `Whittaker.pointwiseCasselmanShalika`
    and the critical-center nodes.
  - `Hecke.action`, which the statement uses, now reaches `renormalizedSphericalCategory` and
    `SpectralProof.factorizationRenormalization` only because `sphericalAction` bundles the
    renormalized restriction.
  - Splitting `sphericalAction`, and pointing the local nodes at the local naive functor, would
    keep the statement's closure minimal.

### M2 in detail

- **The two replacement properties.** I read [ParabolicEisensteinFH] §A.1 (`main.tex:3961–4184`).
  The plan replaces the hypothesis "semisimple and simply connected" (§A.1.3, `:3986`) by two
  properties. Both hold for every connected reductive $G$.
  - (a) $\Lambda_M^+$ is a submonoid, so any $\lambda_1,\lambda_2$ have the upper bound
    $\lambda_1+\lambda_2$.
  - (b) Take $\lambda_0=\sum_{i\notin J_M}\check\omega_i$ in the coweight lattice of $G_{\rm ad}$.
    Some multiple $d\lambda_0$ lies in the coroot lattice, which is inside $X_*(T)$. Then
    $md\lambda_0+\nu$ is dominant for large $m$, and $\langle\alpha,md\lambda_0\rangle\ge md$ for
    every root of $N_P$. Adding $md\lambda_0$ to any $\lambda'$ shows that such large $\lambda$
    are cofinal. That is what Lemma A.1.5.1 (`:4016–4080`, "sufficiently large" at `:4045ff`) and
    Lemma A.1.7.2 (`:4155–4172`) use.
- **Where the simply connected derived group is used.** The plan places it in A.1.8.1
  (`:4178–4184`, the lift of $\theta$). That is right: surjectivity of
  $\Lambda\to\Lambda_{G,P}$ is §2.3.1's use (`:1171`, `:1215`). The hypothesis is recorded in
  the node, and `SpectralProof.parabolicZExtension_descent` still removes it.
- **Small points.**
  - When $G$ has a central torus, $\le$ on $\Lambda_M^+$ is a preorder, not a partial order.
    It is still filtered. Say "preorder".
  - The proof of Lemma A.1.5.2 (`:4082–4112`) splits $\operatorname{Res}_{\check P}(V)$ into
    $\check M$-isotypic parts. That restriction is not semisimple. The proof really needs a
    filtration, vanishing of higher coinduction for dominant $\lambda+\nu$, and semisimplicity
    of $\operatorname{Rep}(\check G)$ to split the result. Record this in the node.
  - §A.2 (`:4186–4246`), the proof of Lemma 4.5.7.1, also uses Lemma A.1.5.1 and parity
    vanishing (R1). `parabolicIC_colimitDescription` (`SemiInfinite/ParabolicIC.toml:25`)
    names only §§A.1.3–A.1.8.

## Graph, bibliography, lint and records

- **Plan files.** I parsed all plan TOML files with Python `tomllib`.
  - There are 216 files and 456 nodes, with no duplicate ids and no unresolved dependencies.
  - The dependency graph has no cycle.
  - The dependency closure of `GLCinLean.Statement.exists_isLanglandsFunctor_and_isEquivalence`
    has 438 nodes. All 13 new nodes are in it, including the Tau Ceti boundary node.
- **Bibliography.** Every bracketed source key in the plans is in `docs/references.bib`. The
  only non-matches are `[n]`, `[i]` and `[t]`, which are mathematical notation. The new entries
  `HottaTakeuchiTanisaki`, `LusztigQAnalog`, `DeligneMilne` and `LurieHA` are all marked "not
  pinned". Their locators could not be checked against TeX.
- **Lint.** `LAKE_CONFIG=.lake-config/lake-config.toml LAKE_CACHE_DIR=.lake/cache lake exe tracker lint`
  exits with code 0. It prints 145 "superseded" notices and no other message. There is no
  `Built Mathlib.…` or `Built TauCeti.…` line.
- **`STATUS.md` counts.** These are right: 456 declarations, 216 module-plan files, 67 direct
  upstream suppliers.
- **Stale records.**
  - `notes/blueprint-gap-resolution.md:237–239` still says that the repair review "approves the
    repairs at `76abe97`". The earlier report asked for this to be updated (P7).
  - `STATUS.md:44–45` says that the result of "the fresh review of these fixes is recorded".
    It was written before any such review existed. It should point to this report.
- **A restatement.** `Spectral.heckeAction_factors` (`Spectral/Action.toml:4`) is now "this is
  `SpectralProof.localizationKernel_annihilatesAutomorphic` for the given G". That is a
  restatement, which AGENTS.md forbids. Its name also no longer spells its conclusion, which is
  annihilation and not factoring. Remove it, and let `Spectral.action` use the general theorem
  through `Spectral.actionOfVanishing`. Or rename it.

## Locators checked

Every number below was computed with `tools/tex-locator.awk`, except MV.

- **[GLC2]** (`2405.03648v3/src/Loc.tex`). §1.1 = `:1705`; Rem. 1.1.4 = `:1732`;
  §1.1.6 = `:1760`; Rem. 1.1.7 = `:1771`; Rem. 1.1.12 = `:1843`; §§1.5.1–1.5.4 =
  `:2263–2307`; Ex. 1.7.4 = `:2560`; Rem. 1.7.5 = `:2571`; §1.7.6 = `:2578`;
  Cor. 1.8.2 (cited as **1.8.1**, wrong) = `:2616`; §H.6.8 = `:38058`; §15.5.1 = `:17431`.
- **[GLys]** (`1608.00284v7/src/text.tex`). §8.2.4 = `:6040`; §9.1.1 = `:6262`;
  §9.2.1 = `:6316–6347`; §9.2.2 = `:6350`.
- **[MV]** (by hand). §2 starts at `:867`, Prop. 2.1 = `:1162`; §6 = `:2318`; §7 = `:2605`,
  with Lemma 7.1 = `:2615`, Rem. 7.2 = `:2629` and Thm. 7.3 = `:2660`.
- **[ParabolicEisensteinFH]** (`2507.13930v2/src/main.tex`). §A.1.3 = `:3986`;
  Lemma A.1.5.1 = `:4016`; Lemma A.1.5.2 = `:4082`; Lemma A.1.7.2 = `:4155`;
  Lemma A.1.8.1 = `:4178`; §2.3.1 = `:1153`.
- **[GaitsgoryOutline]** (`1302.2506v3/src/outline.tex`). Prop. 11.1.3 = `:6939`;
  Cor. 4.5.5 = `:3099`.
- **[GLC3]** (`2409.07051v1/src/Eis.tex`). §8.2.1 = `:10370`.

## What this review did and did not do

- **Did:**
  - read every node the commit added or changed, against the TeX above;
  - read [ParabolicEisensteinFH] Appendix A in full;
  - checked the Tau Ceti declaration in the pinned package;
  - parsed the plan graph, checked closures and reran the lint.
- **Did not:**
  - build anything, run an axiom audit, or do a blind reading, because no Lean file changed;
  - check the locators of the unpinned books (HTT, Lusztig, Deligne–Milne, Lurie);
  - check Tau Ceti `main` beyond the pin.
- **Files:** I wrote only this report. I changed no plan, Lean or other file, and committed and
  pushed nothing.

## Conclusion

**Request changes.**

- B2, M1, M2, N1 and N2 are repaired.
- **Blocking:** parity vanishing of IC stalks has no node, so B1 is only half repaired (R1).
- **Must fix before approval:**
  - F1: the Riemann–Hilbert node has no planned target category;
  - F2: the module lemma needs a unital structure, but the plan's Rep(Ǧ)_Ran structure is
    non-unital, so M3 is only partly repaired;
  - F3: the new M1 nodes contain a wrong claim ("factors through ren") and a statement that is
    not definite ("up to normalizations"), and cite the wrong corollary number (1.8.1 instead
    of 1.8.2).
- **The owner should decide** whether the field comparison is acceptable (Q1). It is what
  brings R1 and F1 into the statement's dependency closure.
- **Small fixes:** none affects the Lean statement.
  - the Deligne–Milne corollary number;
  - the word "adjoint" in `criticalDeterminantGerbe`;
  - the overclaim in `halfTwistedHeart_equiv_untwistedHeart`;
  - the unwritten sign computation;
  - the restatement `heckeAction_factors`;
  - local nodes that depend on the global `Hecke.satake`;
  - the preorder wording;
  - the gap in the proof of FH Lemma A.1.5.2, and the uses of §A.2;
  - the unused dependency in `sphericalHeart_semisimple`;
  - the stale records.
