# Recheck of the blueprint repairs, 2026-11-09

Reviewed commit: **`76abe97114b8d757165492cb625fcee945a24dfd`** ("Expand blueprint proof
dependencies after second review"). `HEAD` is `9644a1c`. It only adds the repair review and
edits `STATUS.md` and `notes/blueprint-gap-resolution.md`, so the plans and the Lean code are
the same as at `76abe97`.

Inputs: `AGENTS.md`, the second review at `5914e73` (`notes/reviews/2026-11-09-second.md`),
the repair review at `9644a1c` (`notes/reviews/2026-11-09-repair.md`),
`notes/blueprint-gap-resolution.md`, the plans in `plans/`, and the pinned TeX in
`references/papers/`.

Reviewer: Claude Opus 5.5, in a fresh session. It wrote none of the repairs and took part in
none of the earlier reviews. The repair review was treated as a set of claims to test.

Paths and references:
- Plan paths are relative to `plans/GLCinLean/`. Line numbers are the line of the `id`.
- Paper lines are in `references/papers/<id>v<version>/src/`.
- Paper numbers come from `tools/tex-locator.awk` where it applies. MV numbers its results
  per section, which the tool does not count, so MV numbers were read by hand.

## Decision

**Request changes.** Two blockers remain in G1, the Satake construction:

- B1: the plan has no proof that the Tannakian group is reductive.
- B2: the factorizable Satake functor is planned with the wrong twist.

Three more changes are needed where the Satake plan meets the spectral-decomposition proof
(M1–M3). The G2 proof route has no circular reasoning that I could find in the sources. P1–P7
are repaired.

## Blockers

### B1. The plan does not prove that the Tannakian group is reductive (G1)

- **What the plan says.** `GeometricLanglands/Satake/DualGroup.toml:4`
  (`Satake.tannakaRootDatum_equiv_dual`) asks to "prove the reconstructed group reductive".
  It says that "the characteristic-zero proof uses the construction of §§9–11 and the
  simplified identification of §12 (Remark 7.2)". Its only dependencies are `tannakaGroup`,
  `weightFunctors_exact_faithful`, `basedRootDatum` and `langlandsDual`.
- **What MV says.**
  - In characteristic 0, reductivity comes from semisimplicity of the spherical heart:
    "as $\pg$ is semisimple, $\tii G$ is reductive, by [DM] Prop. 2.23"
    (`math-0401222v5/src/Satake.tex:2711`).
  - Semisimplicity is Lemma 7.1 (`:2615–2626`). Its proof uses the parity vanishing of IC
    stalks from [Lu] §11, and the simple connectedness of the orbits.
  - Remark 7.2 (`:2629–2633`) only says that the lemma "can be avoided", using the arguments
    of §12 "in a greatly simplified form". MV write no such argument.
  - §12 is not that argument. It starts from the characteristic-0 result at the generic point
    (`:3491`). It then needs things that a single field of characteristic 0 does not provide:
    flatness of the group over $\mathbb Z_p$, the fiber-dimension bound
    (`:3576`), Frobenius twists (`:3712ff`), and [PY] Thms. 1.2 and 1.5.
- **Why it blocks.**
  - No node plans semisimplicity of the heart or parity vanishing of IC stalks. Searching the
    plan descriptions for "semisimpl", "parity vanish", "purity" and "decomposition theorem"
    finds nothing about the heart.
  - [Lu] is not in `docs/references.bib`.
  - The cited route is a remark with no proof, so the plan does not reach a written proof of
    reductivity.
  - Semisimplicity is also used later in the plan: in the heart equivalence
    (`Satake/Equivalence.toml:4`) and in the Ext calculations of `Satake/Comparison.toml`.
- **Extra difficulty.** `Satake.geometricSatakeHeartEquivalence` requires the proof to be redone
  for algebraic D-modules over every algebraically closed `k` of characteristic 0. Lusztig's
  parity result is for ℓ-adic or complex sheaves. So a parity or semisimplicity statement for
  D-modules over `k` needs its own source, or a comparison. The plan already uses such a
  comparison for derived Satake (`Satake/Comparison.toml:4`): a model over $\bar{\mathbb Q}$,
  base change, and Riemann–Hilbert over $\mathbb C$.
- **Required change.**
  - Add a node for semisimplicity of the spherical heart, with a written proof source, and its
    bibliography entry.
  - Make `tannakaRootDatum_equiv_dual` and the heart equivalence depend on it.
  - Alternatively, write out the argument that Remark 7.2 only promises, and cite the source
    for every step.

### B2. The factorizable Satake functor has the wrong twist (G1)

- **What the plan says.**
  - `Satake/Factorization.toml:4` (`factorizationSphericalCategory`) is the category of
    *untwisted* $L^+G$-equivariant D-modules on the Beilinson–Drinfeld Grassmannians.
  - `Satake/Fusion.toml:4` builds the commutativity constraint of the heart with the MV parity
    correction.
  - `Satake/Factorization.toml:11` (`chiralHeckeAlgebra`) transports the commutative algebra
    $\mathcal O(\check G)$ through the heart equivalence. It then builds the algebra over
    every $X^I$ from the geometric collision.
  - `Satake/Factorization.toml:25` (`naiveFactorizationFunctor`) is a monoidal functor
    $\operatorname{Rep}(\check G)_{\rm Ran}\to \operatorname{Sph}_{G,\rm Ran}$, compatible with
    factorization.
  - The twist enters only afterwards. `Satake/Twisting.toml:11`
    (`criticalTwist_matchesBunDeterminant`) depends on `naiveFactorizationFunctor` and claims
    that "their representation source is the untwisted chosen dual group".
  - Neither the gerbe (`criticalDeterminantGerbe`) nor the theta characteristic is in the
    dependency closure of `naiveFactorizationFunctor`.
- **What the papers say.**
  - [GLys] §9.2.2 (`1608.00284v7/src/text.tex:6349–6357`): for the untwisted spherical
    category, "the source of geometric Satake is a *twisted* category of representations"
    of $\check G$, namely $\operatorname{Fact}(\operatorname{Rep}(\check G))^\epsilon_{\mathcal G_Z}$.
    Here $\epsilon=2\check\rho(-1)$, and $\mathcal G_Z$ is induced from the gerbe
    $\omega_X^{1/2}$ (§6.3.5, `:5246–5262`).
  - [GLys] §8.2.4 (`:6040–6058`): the $\epsilon$-modification is an equivalence of *monoidal*
    categories, but "*not* compatible with either the symmetric monoidal nor factorization
    structure". [GLys] §4.9.5 (`:4736`) gives the same sign issue for the shift by degree.
  - [GLys] §9.1.1, formula (9.1) (`:6262–6264`): the target that receives plain
    $\operatorname{Rep}(\check G)$ is the category twisted by $\det_{\mathfrak g}^{1/2}$.
  - [GLC1] Rem. 1.1.6 (`2405.03599v3/src/functor.tex:1415–1418`): without the twist,
    "instead of the usual category $\operatorname{Rep}(\check G)$ one has to consider its twist
    by a certain canonical $Z_{\check G}$-gerbe".
- **Why it blocks.**
  - As described, `naiveFactorizationFunctor` is a factorization-compatible functor from plain
    $\operatorname{Rep}(\check G)_{\rm Ran}$ into the untwisted spherical category. The sources
    say no such functor exists.
  - The chiral Hecke algebra built from the MV-modified commutative structure does not commute
    under the geometric fusion on odd-parity components.
  - A later comparison node cannot repair a functor that does not exist.
  - [RaskinCPSI] §6.29 twists the Grassmannian by
    $\mathcal P^{\rm can}_T=2\check\rho(\Omega^{-1/2})$ (`RaskinCPSI-2018-09-05/cpsi.txt:1179–1188`,
    `:3625–3631`). That is the Whittaker twist by a cocharacter. It does not address the
    parity of the character $2\rho$, and the plan does not use it either.
- **A related inconsistency.** `Satake/Renormalized.toml:4` (`renormalizedSphericalCategory`)
  says "half-twisted", but `criticalDeterminantGerbe` is not in its closure. So the plan has
  one untwisted and one half-twisted spherical category, and neither depends on the gerbe.
- **Required change.** Choose one of two fixes and change the dependencies to match:
  - build the factorization spherical category, the chiral Hecke algebra and the naive functor
    on the $\det_{\mathfrak g}^{1/2}$-twisted Grassmannian, as in [GLys] §9.1.1 with
    $\mathcal G^G$ trivial, with `criticalDeterminantGerbe` as an input; or
  - give the naive functor the source $\operatorname{Fact}(\operatorname{Rep}(\check G))^\epsilon_{\mathcal G_Z}$,
    and add a node that identifies this source with $\operatorname{Rep}(\check G)_{\rm Ran}$
    using the theta characteristic.

  If the heart equivalence over $X^I$ is used, [GLys] cites [Re] (Reich, Represent. Theory 16
  (2012); bibliography at `text.tex:8315`). It is not in `docs/references.bib`.

## Must be fixed before approval

### M1. The spherical categories used for the Hecke action and for Eisenstein series are never compared (G1–G2)

- **The Hecke side.** `Hecke.satake` (`GeometricLanglands/Hecke/Satake.toml:4`) and
  `Hecke.action` use `Satake.factorizationSphericalCategory`.
- **The Eisenstein side.** The parabolic proof uses another spherical category:
  - `SemiInfinite.parabolicInduction_factorization` uses `Satake.renormalizedSphericalCategory`
    and its rigidity;
  - `SpectralProof.derivedSatakeTransform` (`Spectral/DerivedSatake/Construction.toml:32`) uses
    `factorizationRenormalization` but not `renormalizedSphericalCategory`. It depends on the
    global `Hecke.satake` instead of the local naive functor.
- **What is missing.** No node compares the two spherical categories or their actions on
  $\operatorname{Dmod}_{1/2}(\operatorname{Bun}_G)$.
- **Why it is needed.** `SpectralProof.parabolicGlobalization_comparison`
  (`Spectral/Parabolic/Enhancement.toml:39`) must prove that the intermediate functor is
  linear over $\operatorname{Rep}(\check G)_{\rm Ran}$ for the action of `Hecke.action`. This
  is the content of [GaitsgoryOutline] Prop. 11.1.3(b) (`1302.2506v3/src/outline.tex:6939–6960`).
  Enhanced Eisenstein series are linear over the renormalized category ([GLC3] §§8.2–8.5).
  Without a comparison, that linearity does not apply to the Hecke action.
- **Required change.**
  - Add a node identifying the action of $\operatorname{Rep}(\check G)_{\rm Ran}$ through
    naive Satake with the action through renormalized Satake, after the twist of B2 is fixed
    ([GLC2] §§1.5–1.7).
  - Make `derivedSatakeTransform` depend on `renormalizedSphericalCategory` and on the local
    naive functor, not on the global `Hecke.satake`.

### M2. A hypothesis of Faergeman–Hayash was dropped (G2)

- **What the plan says.** `SemiInfinite/ParabolicIC.toml:11` (`parabolicIC`) cites
  [ParabolicEisensteinFH] §§4.3–4.4, Lemma 4.4.8.1 and Appendices A–B, and records only
  "§2.3.1 (group hypothesis)". That hypothesis is a simply connected derived group
  (`2507.13930v2/src/main.tex:1155`).
- **The dropped hypothesis.** The proof of Lemma 4.4.8.1 (`main.tex:2558`) is in the
  appendix "Colimit description of intersection cohomology sheaf" (`:3961–4186`). That
  appendix assumes more: "this poset is filtered due to the assumption that $G$ is semisimple
  and simply connected" (`:3986`).
- **Why it matters.** `SpectralProof.parabolicZExtension_descent`
  (`Spectral/Parabolic/Descent.toml:4`) only removes the simply-connected-derived-group
  hypothesis. So groups such as $GL_n$ are not covered by the cited proof of Lemma 4.4.8.1.
- **Required change.** Do one of these:
  - record the hypothesis and extend the descent to cover it;
  - give an argument, as an explicit node, that the filteredness needed holds for reductive
    $G$ with simply connected derived group;
  - find another source.

### M3. The rank induction uses an object the graph does not supply (G2)

- **What the plan says.**
  - `SpectralProof.localizationKernel_annihilatesEisenstein` (`Enhancement.toml:46`) assumes
    spectral vanishing for the Levi.
  - `parabolicGlobalization_comparison` (`:39`) says "the only global action assumed is that
    for the proper Levi M". It builds
    $\operatorname{QCoh}(\mathrm{LS}_{\check P})\otimes_{\operatorname{QCoh}(\mathrm{LS}_{\check M})}\operatorname{Dmod}(\operatorname{Bun}_M)$,
    which needs the $\operatorname{QCoh}(\mathrm{LS}_{\check M})$-*module structure* on
    $\operatorname{Dmod}(\operatorname{Bun}_M)$, not only the vanishing.
- **What is missing.**
  - In the plan, that structure is `Spectral.action` (`Spectral/Action.toml:11`). It depends
    only on `heckeAction_factors`, the theorem for the fixed $G$.
  - No node turns "the Hecke action kills the localization kernel" into "a
    $\operatorname{QCoh}(\mathrm{LS})$-action", for any group and with the vanishing as a
    hypothesis.
  - So the induction step uses an object that no dependency provides. The graph has no cycle
    only because this edge is missing.
  - The same formal step is hidden in the words "factors coherently" in `heckeAction_factors`
    (`Action.toml:4`). It needs a statement about modules over a monoidal localization, and
    rigidity of $\operatorname{Rep}(\check G)_{\rm Ran}$ ([GLC1] §1.2.2,
    `functor.tex:1440–1447`). Neither has a node: no plan node has rigidity of the Ran version
    in its description.
- **Required change.**
  - Add a node, generic in the group, that builds the module structure from a vanishing
    hypothesis.
  - Make `parabolicGlobalization_comparison` depend on it.
  - State in `localizationKernel_annihilatesAutomorphic` how the strong induction on
    semisimple rank is set up in Lean.

## Unresolved questions for the owner

1. **Field comparison for the heart (B1).** Is a comparison over $\bar{\mathbb Q}$ and
   $\mathbb C$, followed by base change to `k`, acceptable for parity or semisimplicity of the
   heart? It is the same device the plan already accepts for derived Satake
   (`Satake/Comparison.toml:4`). The heart node currently says "reprove … in the algebraic
   D-module theory", which rules this out unless it is changed.
2. **Choice in the dual identification (P6).** MV give the Tannakian group a torus and a
   based root datum, but not a pinning. So `Satake.dualIdentification_compatible`
   (`Satake/DualGroup.toml:11`) can fix an isomorphism with the pinned $\check G$ only up to
   $\check T_{\rm ad}$-conjugation, unless a pinning of the Tannakian group is built. This does
   not change the truth of the main theorem, which quantifies over all functors. But the
   definition `Hecke.satake` must make an explicit choice, and its docstring should say which.

## Verdict on each finding

| Finding | Verdict | Evidence |
|---|---|---|
| **G1**: Satake | **Not repaired.** Much is now planned: the heart, weight functors, convolution, fusion, reconstruction, the Cousin complex and the regular-comodule construction ([MV] §§2–11; [RaskinCPSI] §§6.30–6.33, `cpsi.txt:3633–3700`). The repair review's other claims hold: the Tannaka leaf only reconstructs a supplied Hopf algebra, and the heart and the full DG category are kept apart ([RaskinCPSI] Rem. 6.30.1, `cpsi.txt:3638–3641`). | Open: B1, B2 and M1. |
| **G2**: spectral decomposition | **Route repaired; three gaps remain (M1–M3).** | See "Circular reasoning" below. |
| **P1**: finiteness sources | **Agree: repaired.** `Whittaker.vacuumPoincare_compact` now reaches `exponentialPullback_compact`, `reductionStack_safe` and [DG2] Cor. 10.2.7. `LocalSystems.qcohRigid` reaches [ArinkinGaitsgory] Cor. 9.2.7, Prop. 10.6.6, Thm. 4.2.6 and [DG2] Cor. 1.4.3. | `GeometricLanglands/Whittaker/Compactness.toml`; `AlgebraicGeometry/LocalSystems/QCoh.toml` |
| **P2**: IndCoh on prestacks | **Agree: repaired.** `Sheaves.indcoh` (`AlgebraicGeometry/Sheaves/IndCoh.toml:18`) is a right Kan extension on prestacks ([IndCoh] §§10.1.2–10.1.4). `Sheaves.psi` (`:39`) keeps `Derived.artinStack`. Small gap: `indcohTStructure` (`:25`) says "Artin stacks in scope" but does not depend on `Derived.artinStack`. | — |
| **P3**: duplicate characterization | **Agree: repaired.** `GeometricLanglands/Functor/` holds only `Coarse.toml`. `Statement/Conjecture.toml:54` is the only predicate. | — |
| **P4**: scope wording | **Agree: repaired.** `plans/README.md:3–12`. | — |
| **P5**: roadmap names | **Agree: repaired.** `Statement/Conjecture.toml:5` and `AlgebraicGeometry/Group/Duality.toml` use `dual-based-root-datum` and `langlands-dual-group`. The prose "dual-root-datum identification" in `Hecke/Satake.toml:6` is not a target name. | — |
| **P6**: duality signature | **Agree, as a contract for a future signature change.** `Groups.dualityData` compares the flipped based datum of one pinning with that of the dual pinning. Question 2 above remains. | `AlgebraicGeometry/Group/Duality.toml` |
| **P7**: records | **Agree for `76abe97`.** I counted 443 declarations in 214 files. I reran `lake exe tracker lint`: exit 0, 145 "superseded" notices, nothing else, and no `Built Mathlib.…` or `Built TauCeti.…` line. But `STATUS.md` at `9644a1c` says the repairs are approved "with no new blocking mismatch", and so does the last paragraph of the G2 section in `notes/blueprint-gap-resolution.md`. This report disagrees, so both need updating. | — |

### Circular reasoning in the spectral-decomposition proof

I traced the dependency closure of `SpectralProof.localizationKernel_annihilatesAutomorphic`
(337 nodes). Neither `Spectral.action` nor `Spectral.heckeAction_factors` is in it; the only
Hecke node is `Hecke.action`. Against the papers:

- **The Kac–Moody step does not assume the conclusion.**
  - [GLC2] §15 says it supplies "a proof of [Ga1, Theorem 10.3.4], which is used in
    [Ga1, Corollary 4.5.5]", the spectral decomposition itself (`Loc.tex:16745–16750`).
  - Thm. 15.1.7(b) (`:16872–16897`) lets $\operatorname{Rep}(\check G)$ act on the source only
    through $\operatorname{Loc}^{\rm spec}$ and opers.
  - Cor. 15.5.9 (`:17542–17547`) gives compatibility over all of Ran, which Rem. 15.1.8
    (`:16900–16910`) says is needed.
  - The spectral action of $\operatorname{QCoh}(\mathrm{LS})$ on the automorphic category
    first appears in §18 (`:20333`). The plan does not use that section.
- **Localization on opens.** [GLC2] Thm. 13.4.2 (`:15723`) holds for every quasi-compact open
  and every level, and is proved in that paper. The plan applies it to each quasi-compact
  component of the open set of [GeometricConstantTerm] Prop. 1.4.6, which matches the
  hypotheses.
- **The geometric Eisenstein sections do not use local systems.** [GLC3] §§8–9
  (`Eis.tex:10214–12893`) never mention local systems on the spectral side.
  Prop. 12.7.3 (`:16765`) is a statement on the spectral side only.
- **Rank zero.** The induction includes rank zero (`Spectral/Generation.toml:11`). The open
  questions are M2 and M3, not a circular argument.

### Smaller points

- **N1. Wrong Outline locator.** The plan and `notes/blueprint-gap-resolution.md` cite
  "[GaitsgoryOutline] Proposition 11.1.4". The proposition at `outline.tex:6939` is
  **11.1.3**: Thm. 11.1.1 is at `:6874`, then an unnumbered subsubsection 11.1.2, then the
  proposition. Fix it in `Spectral/Parabolic/Enhancement.toml:39` and `:46`.
- **N2.** Add `Derived.artinStack` to the dependencies of `Sheaves.indcohTStructure` (P2).
- **N3. How independent the repair review was.** By its own account, the repair review sent
  issues to the authors before the candidate was committed. It also relied on build, axiom and
  lint logs in `/tmp` that the author session produced. So it was partly a co-author of the
  candidate. This report did not use those logs; it reran the lint itself.

## What this review did and did not do

- **Did:**
  - read every plan file under `GeometricLanglands/Satake/`, `Hecke/Satake.toml`,
    `Spectral/` and `Spectral/Parabolic/`;
  - parsed all 214 plan files to trace dependency closures;
  - read the cited TeX for each finding above;
  - reran the tracker lint.
- **Did not:**
  - run a build or an axiom audit. `git diff 76abe97 HEAD` touches no Lean file, and the
    statement is unchanged since `f6d537a`, which the second review approved;
  - do a new blind reading, for the same reason;
  - refresh the roadmap PR heads or the Tau Ceti provider snapshots;
  - check every locator among the 443 nodes. Only the ones on the Satake and spectral paths
    were checked, by content where cited above, and by number with `tools/tex-locator.awk`
    for [GLC2] 13.4.2, 15.1.7, 15.5.9, 15.6.15, [GLC3] 2.4.3, 9.6.11, 12.6.8, 12.7.3, [GLC4]
    C.1.7, [GaitsgoryOutline] 4.5.2, 4.5.5, 11.1.1 and 11.1.3.
- **Files:** no Lean code or plan was changed. `STATUS.md` was not changed; it should be
  updated to point to this report, after the owner decides. Nothing was pushed.

## Conclusion

**Request changes.**

- The G2 proof route is now real, and I found no circular reasoning in its sources.
- The Satake part of G1 still has two blocking gaps:
  - B1: reductivity of the Tannakian group rests on a remark with no proof;
  - B2: the factorizable Satake functor is planned with plain $\operatorname{Rep}(\check G)_{\rm Ran}$
    into the untwisted spherical category, which [GLys] §§8.2.4 and 9.2.2 and [GLC1]
    Rem. 1.1.6 rule out.
- The spectral proof also needs:
  - a comparison of the spherical categories used for the Hecke action and for Eisenstein
    series (M1);
  - the Faergeman–Hayash hypothesis that was dropped (M2);
  - an explicit way to set up the rank induction (M3).

All of these only add to the plan or fix it; none affects the Lean statement. P1–P7 can stay
as they are, apart from the records in P7 and the small points N1 and N2.
