# Third recheck of the blueprint repairs, 2026-11-09

Reviewed commit: **`a68cc533adc48bfe6d5918f521f73e7ccfe2cf73`** ("Plan parity vanishing,
constructible comparison and unital Ran setting"). It answers the report
`notes/reviews/2026-11-09-repair-recheck-2.md`, which reviewed `834cc56`. I compared
`git diff a7197ab a68cc53`. The commit changes only plan TOML, `docs/references.bib`,
`docs/papers.md`, `STATUS.md` and `notes/blueprint-gap-resolution.md`. No Lean file changed, so
no build, axiom audit or blind reading was run.

Reviewer: Claude Opus 5.5, in a fresh session. I wrote none of the plans and took part in none
of the earlier reviews. I treated the commit message, `STATUS.md` and the plan texts as claims to
test.

Paths and references:
- A plan reference `File.toml:N` is relative to `plans/GLCinLean/`. `N` is the line of the
  node's `id`.
- Paper lines are in `references/papers/<id>v<version>/src/`.
- Paper numbers come from `tools/tex-locator.awk`. There are two exceptions. MV numbers per
  section, so I read its numbers by hand. [ParabolicEisensteinFH] numbers its theorems inside
  each subsubsection: the tool gives the subsubsection, and I added the last digit by hand.

## Decision

**Request changes.**

- F3 is fixed. So are most of the small points.
- R1, F1 and F2 are only partly fixed.
  - R1: parity vanishing now has a node, but no proof route.
  - F1: the target category of Riemann–Hilbert is now planned, but the de Rham functor itself
    is not.
  - F2: the unital category is now planned, but nothing makes the Hecke action Ran-unital.
- The commit brings in two new problems.
  - The D-module parity statement (`Satake.icStalkParity`) uses the wrong degree convention.
    As written, it is false on the odd components.
  - The new Faergeman–Hayash transfer node is not a definite statement. It also conflicts with
    the twist that `SemiInfinite.parabolicIC` now uses.

## Blocker

### B. Parity vanishing over C is a leaf with no proof route (rest of R1)

- **What the plan says.** `GeometricLanglands/Satake/Spherical.toml:18`
  (`Satake.icStalkParity_complex`) states the parity of the *- and !-restrictions of $IC_\lambda$
  to the strata, over $\mathbb C$, for constructible sheaves. Its source is "[LusztigQAnalog] §11".
  - Its desc says that this is "a very large input" and that implementing it "needs either
    ℓ-adic purity with the comparison to complex coefficients, or the decomposition theorem".
  - Its only dependencies are `Constructible.perverseSheaves`, `Hecke.schubertStratification`
    and `Hecke.affineGrassmannian`.
- **What the papers say.** The proof of [MV] Lemma 7.1 (`math-0401222v5/src/Satake.tex:2621–2626`)
  only cites [Lu] §11 for this. [ParabolicEisensteinFH] §A.2 also only cites it
  (`2507.13930v2/src/main.tex:4245`).
- **What is wrong.**
  - The earlier report asked for "a written proof route and the sources that route needs".
    The node names two possible routes but plans neither. No node plans Kazhdan–Lusztig
    polynomials, purity, ℓ-adic sheaves, a comparison between ℓ-adic and complex
    coefficients, or the decomposition theorem.
  - Once `Constructible.perverseSheaves` is done, the tracker will list this node as ready. That
    is the same situation that made R1 a blocker. The only change is that the node's text is
    now honest about it.
  - The node is in the dependency closure of the main statement
    (`GLCinLean.Statement.exists_isLanglandsFunctor_and_isEquivalence`).
- **Required change.** Do one of the following:
  - plan one proof route, with nodes and sources (for example the decomposition theorem for
    the convolution resolutions, or ℓ-adic purity with its comparison to $\mathbb C$);
  - or have the owner accept the node as an explicit external boundary, recorded as such in
    the plan and in `STATUS.md`. This is part of question Q1 below.

## Must be fixed before approval

### M1. The D-module parity statement uses the wrong degree convention

- **What the plan says.** `Satake/Spherical.toml:25` (`Satake.icStalkParity`): for the
  *D-module* $IC_\lambda$ over $k$, the *- and !-restrictions to each stratum $\mathrm{Gr}^\mu$
  "are lisse with cohomology only in degrees congruent to dim Gr^λ modulo 2". It is proved
  from the constructible statement through the de Rham functor.
- **Why this is wrong.**
  - For constructible sheaves, the statement is right. $IC_\lambda|_{\mathrm{Gr}^\lambda}=\mathbb C[d_\lambda]$,
    with $d_\lambda=\dim\mathrm{Gr}^\lambda$. Lusztig's parity then puts the cohomology sheaves
    of the restriction in degrees $\equiv d_\lambda$.
  - The de Rham functor is t-exact from the D-module t-structure to the *perverse* t-structure
    (`DModules/RiemannHilbert.toml:4` says so). On a smooth stratum of dimension $d_\mu$, a
    local system $L$ in degree $j$ corresponds to a lisse D-module in D-module degree
    $j+d_\mu$. The reason is that $L[d_\mu]$ is perverse.
  - So in D-module degrees the restrictions live in degrees $\equiv d_\lambda+d_\mu$. Within one
    connected component $d_\lambda\equiv d_\mu \pmod 2$, so these degrees are always **even**.
  - On a component where $d_\lambda$ is odd, the node therefore claims odd degrees where the
    truth is even degrees. An example is the minuscule orbit for $PGL_2$, where
    $d_\lambda=1$.
  - `DModules/Perverse.toml:4` already talks about "the dimension shift convention" between a
    constructible-style t-structure and the D-module heart. So the plan itself has two
    conventions, and this node does not say which one it uses.
- **Required change.** State the degrees in D-module conventions: even degrees, or
  $\equiv d_\lambda-d_\mu$. Or name the shifted convention explicitly. Then restate step (3) of
  `Satake.sphericalHeart_semisimple` (`Spherical.toml:11`) to match. Its present phrase "have
  opposite or equal parity as needed" is not a definite statement.
- **The argument itself is correct** once the degrees are fixed. Here is the check.
  - Within one component, both restrictions are in even D-module degrees, and
    $H^*_{dR}(\mathrm{Gr}^\nu)$ is even.
  - So every term $\operatorname{Hom}(i_\nu^*IC_\lambda,i_\nu^!IC_\mu[1])$ of the open–closed
    filtration vanishes, and hence $\operatorname{Hom}(IC_\lambda,IC_\mu[1])=0$. This needs only
    the vanishing of the terms, not the degeneration of a spectral sequence.
  - Two different components have disjoint supports, so Hom vanishes there.
  - Even cohomology of the open stratum replaces MV's simple connectedness in the case
    $\lambda=\mu$.
  - The dimension parity holds because $d_\lambda=\langle\lambda,2\check\rho\rangle$, and
    $\langle\check\alpha_i,2\check\rho\rangle=2$ for each simple coroot.

### M2. Two inputs of the new semisimplicity proof are not planned

`Satake.sphericalHeart_semisimple` (`Spherical.toml:11`) now relies on two facts that no node
supplies.

- **Even de Rham cohomology of the strata.** The proof says "the de Rham cohomology of each
  stratum is even because it is an affine bundle over a partial flag variety paved by affine
  spaces". I searched all plans for "paved", "paving", "Bruhat", "flag variet", "affine bundle"
  and "homotopy invarian". The only hit is this sentence.
  - `Hecke.schubertStratification` (`AffineGrassmannian/Schubert.toml:4`) lists "closure order,
    dimension and stabilizer connectedness". It does not list the fibration
    $\mathrm{Gr}^\nu\to G/P_\nu$, the Bruhat paving, or $\mathbb A^1$-invariance of de Rham
    cohomology.
  - Add these to that node, or add a lemma node, and make the semisimplicity node depend on it.
- **Constancy, not just lisseness.** The Hom computation needs the cohomology D-modules of
  $i_\nu^*IC_\lambda$ and $i_\nu^!IC_\mu$ to be *constant*, that is, direct sums of
  $\mathcal O_{\mathrm{Gr}^\nu}$. Otherwise $\operatorname{Ext}$ between them can have odd
  terms. Over $k$, lisse does not imply constant: an irregular connection such as $e^x$ on an
  affine-space factor is lisse but not constant.
  - Constancy follows from $L^+G$-equivariance on a homogeneous space with connected
    stabilizers. The node uses that fact in step (2) but not in step (3).
  - `Satake.icStalkParity` concludes only "lisse". Say "equivariant, hence constant".

### M3. F2 is only partly fixed: the Hecke action is never made Ran-unital

- **What is now right.**
  - `Infinity.moduleOverMonoidalLocalization` (`CategoryTheory/Infinity/Module.toml:18`) is now
    stated for unital *symmetric* monoidal $A$ and $B$, as the earlier report asked.
  - The new `Hecke.unitalIndependentRepresentations` (`GeometricLanglands/Hecke/Representations.toml:32`)
    is the category that [GLC2] §15.5.1 uses (`2405.03648v3/src/Loc.tex:17431–17462`).
  - [GLC2] states both factorizations:
    $(\operatorname{Rep}(\check G)_{\rm Ran})^\star\twoheadrightarrow\operatorname{Rep}(\check G)_{\operatorname{Ran^{untl}},\rm indep}$
    for the Hecke action (`:17436–17440`), and
    $\operatorname{Loc}^{\rm spec}:\operatorname{Rep}_{\rm Ran}\twoheadrightarrow\operatorname{Rep}_{\rm indep}\to\operatorname{QCoh}(\operatorname{LS})$
    (`:17453–17462`).
  - These quotients are monoidal localizations (`Loc.tex:38111–38120`). For reductive groups
    the independent category is *not* $\operatorname{QCoh}(\operatorname{LS})$ (`:35697–35700`).
    So applying the module lemma at $A=\operatorname{Rep}_{\rm indep}$, $B=\operatorname{QCoh}(\operatorname{LS})$
    is meaningful, and it is correct.
- **What is missing or wrong.**
  - (a) **Ran-unitality of the Hecke action is not planned.**
    - [GLC2] gets the factorization from the fact that the Hecke action is a *local Ran-unital
      action* (`Loc.tex:17434–17436`; definition at §H.6.1, `:37956–37985`). The essential-image
      statement is **Corollary H.6.11** (`:38087–38095`).
    - No node defines local (lax-)Ran-unital actions. No node equips `Hecke.action`
      (`Hecke/Action.toml:4`) or `Hecke.sphericalAction` (`Hecke/Action.toml:11`) with a strict
      Ran-unital structure. A search for "Ran-unital", "untl" and "local action" finds only
      `Hecke/Representations.toml`.
    - `unitalIndependentRepresentations` assumes such an action ("such as the Hecke action")
      without saying where it comes from. Rep(Ǧ) must also be a unital factorization category
      over $\operatorname{Ran^{untl}}$, and the naive Satake functor must be unital. Neither is
      stated as an obligation.
  - (b) **The theorems are bundled into a definition, and an edge is missing.** The earlier
    report asked for three nodes: the category, the factorization of `Spectral.localization`,
    and the factorization of the Hecke action. The commit puts all three into one *definition*
    node.
    - That node "proves that Spectral.localization factors through it". But it does not depend
      on `Spectral.localization` (`Spectral/Localization.toml:4`).
    - Split it into a definition and two theorem nodes. Add the dependency on
      `Spectral.localization`; adding it creates no cycle.
  - (c) **Hypotheses of the module lemma are not checked.**
    `Spectral.actionOfVanishing` (`Spectral/Action.toml:11`) applies the lemma to
    $\operatorname{Rep}_{\rm indep}\to\operatorname{QCoh}(\operatorname{LS})$. Three steps are
    needed and none is stated anywhere.
    - The right adjoint of the induced functor is fully faithful.
      `Spectral.localization_rightAdjoint_fullyFaithful` is about the
      $\operatorname{Rep}_{\rm Ran}$ version. The deduction is easy: the quotient has a fully
      faithful right adjoint, so the counit of the composite is the counit of the second
      functor. But it has to be stated.
    - The vanishing hypothesis is about the kernel of the $\operatorname{Rep}_{\rm Ran}$
      version. It must be carried to the kernel on $\operatorname{Rep}_{\rm indep}$, which is
      the image of that kernel under the quotient.
    - The module structures have to be matched through Cor. H.6.11.
  - (d) **Rigidity of the independent category has no source and no route.**
    `Hecke.ranRepresentations_rigid` (`Representations.toml:25`) is now about
    $\operatorname{Rep}_{\rm indep}$.
    - No cited source states that this category is rigid. [GLC2] §15.5.1 and Appendix H do
      not. [GLC1] §1.2.2 (`2405.03599v3/src/functor.tex:1440–1447`) asserts rigidity only of
      $\operatorname{Rep}_{\rm Ran}$.
    - The route "from rigidity of Rep(H) and the factorization description over X^I" is the
      route for $\operatorname{Rep}_{\rm Ran}$. That category is non-unital, so dualizability
      there is not even defined.
    - Give the actual route for the quotient: the unit is the image of the vacuum at a point,
      so it is compact, and the images of generators are dualizable. Mark this as an
      adaptation obligation.
    - The name `ranRepresentations_rigid` no longer spells the conclusion. Rename it, for
      example to `unitalIndependentRepresentations_rigid`. AGENTS.md requires that a
      theorem's name spells its conclusion.
  - (e) **Locator.** `unitalIndependentRepresentations` cites "§§H.6.8–H.6.10".
    - H.6.8 (`:38057`) is the convolution action. H.6.9 (`:38065`) is a remark. H.6.10
      (`:38083`) is a one-line lead-in.
    - The result used is Cor. H.6.11 (`:38087`). Cor. H.6.4 (`:38014`) and Cor. H.6.7
      (`:38048`) are inputs to it.
    - (The earlier report wrote "Cor. H.6.10". That was its own off-by-one error, and the
      commit copied it.)

### M4. F1 is only partly fixed: the de Rham functor is still not planned

- **What is now planned.**
  - `AlgebraicGeometry/Constructible/Complex.toml:4` (`complexPoints`), `:11` (`derivedCategory`)
    and `:18` (`perverseSheaves`) plan the topological side.
  - `DModules/Holonomic.toml:11` (`regularHolonomic`) plans regular holonomicity.
  - `DModules.schubertRiemannHilbert` (`DModules/RiemannHilbert.toml:4`) depends on all four.
  - The content of `regularHolonomic` is correct. It uses the curve-test definition, is stable
    under the operations and under scalar extension, and covers equivariant modules on
    homogeneous spaces with connected stabilizers.
- **What is still missing.**
  - The earlier report also listed "analytification and the analytic de Rham functor".
    `complexPoints` gives only the topological space $Y(\mathbb C)$. Nothing plans
    $\mathcal O^{\rm an}$, analytic D-modules, the analytification of D-modules, or the
    functor $\mathrm{DR}=\Omega^{\rm an}\otimes\mathcal M^{\rm an}$. The RH node states that
    "the de Rham functor" is an equivalence, but no node defines that functor.
  - The new `regularHolonomic` node is not a dependency of the nodes whose texts use regular
    holonomicity:
    - `DModules.perverseHeart` (`DModules/Perverse.toml:4`: "constructible regular-holonomic
      objects");
    - `Satake.sphericalHeart` (`Satake/Spherical.toml:4`: "perverse regular-holonomic D-modules");
    - `DModules.boundedEquivariantExt_baseChange` (`DModules/ScalarExtension.toml:4`).
  - Adding these edges creates no cycle.
  - Minor: `Constructible.derivedCategory` lists no Mathlib supplier for sheaves on
    topological spaces or for derived categories. Its provider text says that Tau Ceti `main`
    and the roadmap were not rechecked. AGENTS.md asks for a search of `main`.

### M5. The Faergeman–Hayash transfer node is not definite and conflicts with parabolicIC

`SemiInfinite.parabolicIC_halfTwistedTransfer` (`GeometricLanglands/SemiInfinite/ParabolicIC.toml:32`)
answers question Q3 of the earlier report. Recording the obligation is right. As written, the
node has five problems.

- (a) **It is not a definite statement.**
  - The node says "Transfer the results … Prove that [the IC kernel, its Hecke and
    Drinfeld–Plücker structures and the Jacquet comparison] correspond". It does not say under
    which functor, or between which categories.
  - Over Ran there is no factorization equivalence between FH's untwisted setting and the
    half-twisted one. That is exactly B2 ([GLC2] Rem. 1.1.12, `Loc.tex:1842–1850`;
    [GLys] §9.2.2). The ratio trivialization is compatible with factorization only as a
    *super* line bundle ([GLC3] §§1.1.2–1.1.4, `2409.07051v1/src/Eis.tex:1771–1815`).
  - The tools the node cites cannot by themselves give such a comparison. They are the
    multiplicative trivializations of the gerbe on $L(N)$ and on $L^+G$ ([GLC2] §1.1.14,
    `Loc.tex:1876–1890`). These only give a meaning to equivariance in the twisted category.
  - For $G$ with $2\check\rho(-1)\neq 1$, such as $GL_2$, FH's untwisted factorization
    statements with plain $\operatorname{Rep}(\check G)_{\rm Ran}$ meet the ε-sign. FH say they
    "ignore issues about … twists" (`main.tex:764`). Their only correction is the shift
    $\mathsf S^\theta$ on the M side (`main.tex:2385`).
  - What the plan can honestly ask for is to **re-prove** the FH results it uses in the
    half-twisted setting. The node should list what changes: the ratio super line bundle, the
    shift $\langle\lambda,2\check\rho_P\rangle$ of [GLC3] §1.3.2 (`Eis.tex:1939–1958`), and
    $P$ against $P^-$. It should not claim a "transfer" by a correspondence.
- (b) **It conflicts with the setting of `parabolicIC`.**
  - The commit makes `SemiInfinite.parabolicIC` (`ParabolicIC.toml:11`) depend on
    `Satake.naiveFactorizationFunctor`. That functor is half-twisted
    (`Satake/Factorization.toml:25`).
  - So `parabolicIC` is now built in the half-twisted setting, yet the transfer node treats it
    as FH's untwisted object.
  - Decide which setting `parabolicIC`, `parabolicIC_koszulBoundary` and
    `parabolicIC_colimitDescription` live in, and say it in their texts.
- (c) **It overlaps another node.** `SemiInfinite.whittakerJacquet_matches_unipotentInvariants`
  (`SemiInfinite/WhittakerJacquet.toml:18`) already says "match the opposite-parabolic,
  half-twist, Chevalley and rho_P normalizations of GLC3". The transfer node claims the same
  half-twist matching and depends on that node. AGENTS.md forbids such restatements. Keep the
  claim in one place.
- (d) **Locators.**
  - The local comparison of gerbes is [GLC3] §§1.1.2–1.1.5 (`Eis.tex:1771–1828`; the
    trivialization is §1.1.3 at `:1791`). §1.1 is not cited.
  - §§8.1.1–8.1.4 (`Eis.tex:10236–10288`) are the *global* gerbes on $\mathrm{Bun}_P$. They are
    relevant only to the global part.
  - [GLC3]'s trivialization "depends on the choice of a square root of ω_X" (`:1780`
    footnote). The node calls it "canonical".
- (e) **Notation.**
  - The node writes $L(N_P)\cdot L^+(M)$. GLC3's category uses $L(N_P^-)\cdot L^+(M)$
    (`Eis.tex:1924–1928`).
  - It writes $\langle\lambda,2\rho_P\rangle$. GLC3 writes $\langle\lambda,2\check\rho_P\rangle$.

## Unresolved questions for the owner

1. **Field comparison and parity (Q1 of the earlier report, still open).** `STATUS.md:52–54`
   now records correctly that the owner has not decided. The comparison through $\bar{\mathbb Q}$
   and $\mathbb C$ now brings three things into the statement's closure:
   - classical topology (`Constructible.*`);
   - a not yet planned analytic de Rham functor (M4);
   - an unrouted parity theorem (B).
   Does the owner accept this, and does the owner accept `Satake.icStalkParity_complex` as an
   external boundary?
2. **Pinning choice (Q2 of the earlier reports).** Untouched and still open.
3. **The Faergeman–Hayash setting (Q3).** Answered by a node. But see M5: the node should say
   "re-prove in the half-twisted setting", not "transfer".

## Verdict on each item of the earlier report

| Item | Verdict | Evidence |
|---|---|---|
| **R1** parity vanishing not planned | **Partly fixed.** It now has a node (`Spherical.toml:18`), sourced honestly. Both consumers depend on it through `Satake.icStalkParity` (`Spherical.toml:25`): `sphericalHeart_semisimple` (`:11`) and `parabolicIC_koszulBoundary` (`ParabolicIC.toml:18`). It has no proof route (B). The D-module form uses the wrong degrees (M1). Two inputs of the new proof are unplanned (M2). | MV `Satake.tex:2615–2626`; FH `main.tex:4245` |
| **F1** RH has no planned target | **Partly fixed.** The constructible target and regular holonomicity are planned. The analytic de Rham functor is not, and the edges to `regularHolonomic` are missing (M4). | `Constructible/Complex.toml:4,11,18`; `DModules/Holonomic.toml:11` |
| **F2** unital vs non-unital | **Partly fixed.** The module lemma is now symmetric monoidal, and the unital independent category is planned. Ran-unitality of the Hecke action is unplanned. Theorems are bundled into a definition, with a missing edge to `Spectral.localization`. The lemma's hypotheses are unchecked, rigidity has no source, a name is now wrong, and a locator is off by one (M3). | GLC2 `Loc.tex:17431–17462`, `:38087` |
| **F3** "factors through ren", indefinite normalization, Cor. 1.8.1 | **Fixed.** Details below. | GLC2 `Loc.tex:2271–2292`, `:2560–2569`, `:2578–2581`, `:2616` |
| Deligne–Milne Cor. 2.22 | **Fixed** in `Satake/DualGroup.toml:4`, `docs/references.bib:402` and `docs/papers.md:55`. MV cites "corollary 2.22" at `Satake.tex:2710`. | — |
| "adjoint" in `criticalDeterminantGerbe` | **Fixed** (`Satake/Twisting.toml:4`: "the relative determinant of the adjoint bundle, det_𝔤 in [GLys]"). | — |
| Overclaim in `halfTwistedHeart_equiv_untwistedHeart` | **Fixed** (`Twisting.toml:18`). It now says only that the ω_X^{1/2} identification is incompatible with factorization (Rem. 1.1.12, `Loc.tex:1842`). | — |
| Unwritten sign computation | **Fixed.** It is marked as an explicit adaptation obligation (`Twisting.toml:18`). | — |
| Restatement `Spectral.heckeAction_factors` | **Fixed.** The node is removed. `Spectral.action` (`Spectral/Action.toml:4`) applies `actionOfVanishing` to `localizationKernel_annihilatesAutomorphic` directly. No stale reference remains outside `notes/reviews/` and the "is removed" line at `STATUS.md:49`. | — |
| Local nodes on the global `Hecke.satake` | **Fixed.** Only `Hecke.action` and `SpectralProof.globalOperLocalization` (which is global) still depend on it. `Hecke.sphericalAction` no longer depends on the renormalized category. The closure of `Hecke.action` no longer contains `Satake.renormalizedSphericalCategory` or `SpectralProof.factorizationRenormalization`. | — |
| Preorder wording | **Fixed and correct** (`ParabolicIC.toml:25`). With a central coweight λ, both λ ≤ 0 and 0 ≤ λ hold. A filtered preorder suffices. | — |
| Gap in FH Lemma A.1.5.2 | **Fixed.** The node records the filtration, higher coinduction vanishing and semisimplicity (`ParabolicIC.toml:25`). This matches the proof at `main.tex:4082–4112`, which splits $\operatorname{Res}_{\check P}$. | — |
| Uses of FH §A.2 | **Mostly fixed.** `parabolicIC_koszulBoundary` now cites Lemma 4.5.7.1 (`main.tex:2780`), proved in §A.2 (`:4186–4246`), and depends on `Satake.icStalkParity`. Small point S4 below. | — |
| Unused dependency in `sphericalHeart_semisimple` | **Fixed.** `Groups.langlandsDual` is removed. | — |
| Stale records | **Fixed.** `notes/blueprint-gap-resolution.md:237–241` and `STATUS.md:24–54` now describe the chain of reviews correctly. New stale text is listed in S2. | — |
| Q3 Faergeman–Hayash setting | **Answered by a node, but the node has problems** (M5). | — |

### F3 in detail

- **The lift** (`Satake/Renormalized.toml:18`) is now described correctly.
  - [GLC2] §1.5.2 (`Loc.tex:2271–2282`) defines $\operatorname{Sph}_G$ as the ind-completion of
    the full subcategory $C$ of objects whose image under either forgetful functor is compact.
  - The ind-extension of $C\subset\operatorname{Sph}^{\rm non\text{-}ren}$ is non-ren.
  - $L$ is the ind-extension of the naive functor restricted to compact generators, which land
    in $C$. Both $\operatorname{non\text{-}ren}\circ L$ and the naive functor are continuous
    and agree on compacts, so they are isomorphic.
  - The warning is right: ren is the left adjoint (`:2284–2292`), and $\operatorname{ren}(c)\neq c$
    whenever $c\in C$ is not compact in $\operatorname{Sph}^{\rm non\text{-}ren}$.
- **The composite** (`Spectral/DerivedSatake/Monads.toml:53`,
  `SpectralProof.naiveSatake_eq_derivedSatakeInverse`) is right.
  - [GLC2] Example 1.7.4 (`Loc.tex:2560–2569`) gives $\operatorname{Sat}_G(IC_\lambda)=\operatorname{nv}(V^{-w_0\lambda})$.
  - Then $\operatorname{Sat}_G^{-1}\circ\operatorname{nv}\circ c^*$ sends $V^\lambda$ to
    $\operatorname{Sat}_G^{-1}(\operatorname{nv}(V^{-w_0\lambda}))=IC_\lambda$. That matches the
    MV-normalized naive functor.
  - $c^*V^\mu\cong V^{-w_0\mu}$ holds for the Chevalley involution, whether it is taken
    pinning-preserving or as inversion on $\check T$; the two differ by an inner automorphism.
  - Two tensor equivalences $\operatorname{Rep}(\check G)\to\operatorname{Sph}^\heartsuit$ that
    agree on isomorphism classes of objects differ by an automorphism of $\check G$ that is
    trivial on the based root datum. Such an automorphism is inner, so the two are isomorphic
    as tensor functors. The proof plan through the regular object is therefore sound.
  - The equivalent form is $\tau_G\circ\operatorname{Sat}^{\rm nv}_G$ (§1.8.3, `Loc.tex:2633–2641`).
  - Corollary 1.8.2 is now cited correctly (`:2616`).
  - The node is now in the `SpectralProof` namespace, which matches its module.
- **Small leftovers** (S3).

## Small points

- **S1. Naming.**
  - `naiveSatake_eq_derivedSatakeInverse` states an isomorphism of functors. Mathlib naming
    would use `iso`, not `eq`.
  - `parabolicIC_halfTwistedTransfer` does not spell a conclusion.
- **S2. Stale text.**
  - `DModules/RiemannHilbert.toml:1`: "Its only uses are the field comparisons in
    Satake.sphericalHeart_semisimple and …". It is now used by `Satake.icStalkParity`, not by
    `sphericalHeart_semisimple`.
  - `Satake/Equivalence.toml:4`: "The only comparison with complex topology is the Ext^1
    vanishing of Satake.sphericalHeart_semisimple". That comparison is now the parity
    statement. `Satake.regularSheafExt_complexComparison` (`Satake/Comparison.toml:4`) also
    uses RH.
- **S3. The Chevalley involution and τ_G are not planned.** `naiveSatake_eq_derivedSatakeInverse`
  adds `Groups.dualityData`, which is a root-datum equivalence. No node defines the Chevalley
  involution of the pinned dual group, or τ_G. Name their source or their node.
- **S4. The step from parity to FH's bound is not written.** FH §A.2 needs
  $i^{\lambda+\theta,!}(IC^\lambda)$ on $\mathrm{Gr}_M^{+,\lambda+\theta}$ to be in perverse
  degrees $\geq 2$ (`main.tex:4240–4245`). This is a !-restriction to an attracting locus, not
  to an $L^+G$-stratum. Getting it from the stratum parity of `Satake.icStalkParity` takes an
  extra argument (a dimension estimate for $\mathrm{Gr}_M^{+,\nu}\cap\mathrm{Gr}^\mu$ together
  with parity). `parabolicIC_koszulBoundary` (`ParabolicIC.toml:18`) should record it.
- **S5. The !-restriction half of the complex statement.** Lusztig treats stalks
  (*-restriction). The !-half of `icStalkParity_complex` follows from Verdier self-duality of
  $IC_\lambda$. Say so.
- **S6. Finite length.** Semisimplicity from Ext^1 vanishing between simple objects also needs
  objects of finite length. Holonomic objects have finite length, but
  `sphericalHeart_semisimple` should say so.

## Graph, bibliography, lint and records

- **Plan files.** I parsed all plan TOML with Python `tomllib`.
  - There are 217 files and 464 nodes. There are no duplicate ids, no unresolved dependencies
    and no cycles.
  - The dependency closure of `GLCinLean.Statement.exists_isLanglandsFunctor_and_isEquivalence`
    has 446 nodes.
  - All ten new or renamed nodes are in that closure: `Constructible.complexPoints`,
    `Constructible.derivedCategory`, `Constructible.perverseSheaves`,
    `DModules.regularHolonomic`, `Hecke.renormalizedSphericalAction`,
    `Hecke.unitalIndependentRepresentations`, `Satake.icStalkParity_complex`,
    `Satake.icStalkParity`, `SemiInfinite.parabolicIC_halfTwistedTransfer` and
    `SpectralProof.naiveSatake_eq_derivedSatakeInverse`.
  - The closures of `Spectral.actionOfVanishing` (249 nodes) and of
    `SpectralProof.parabolicGlobalization_comparison` (339 nodes) do not contain
    `localizationKernel_annihilatesAutomorphic`. The rank induction is therefore still
    acyclic.
- **Bibliography.** Every bracketed source key in the plans resolves in `docs/references.bib`.
  The only non-matches are `[n]` (twice), `[i]` and `[t]`, which are mathematical notation.
- **Lint.** `LAKE_CONFIG=.lake-config/lake-config.toml LAKE_CACHE_DIR=.lake/cache lake exe tracker lint`
  exits with code 0. It prints 145 "superseded" notices and no other message. There is no
  `Built Mathlib.…` or `Built TauCeti.…` line.
- **`STATUS.md` counts.** These are right: 464 declarations, 217 module-plan files, and 67
  supplier nodes under `plans/Mathlib` and `plans/TauCeti`. The arithmetic is 456 + 9 new − 1
  removed. The renamed node counts once.
- **Stale ids.** `Spectral.heckeAction_factors` and `Satake.naiveRenormalized_eq_derivedSatakeInverse`
  appear only in earlier reviews and in the "is removed" sentence at `STATUS.md:49`. No plan,
  doc or Lean file refers to them.
- **Push state.** `STATUS.md:62–63` says that nothing is pushed. That is accurate: local `main`
  is 9 commits ahead of `origin/main`.

## Locators checked

Every number below was computed with `tools/tex-locator.awk`, except as noted.

- **[GLC2]** (`2405.03648v3/src/Loc.tex`). §1.1.14 = `:1876` (right). §1.5.2 = `:2271`;
  §1.5.3 = `:2284`. Ex. 1.7.4 = `:2560` (right). §1.7.6 = `:2578` (right). Cor. 1.8.2 =
  `:2616` (right). §15.5.1 = `:17431` and §15.5.2 = `:17453` (right). H.6.1 = `:37956`;
  Cor. H.6.4 = `:38014`; Cor. H.6.7 = `:38048`; H.6.8 = `:38057`; Rem. H.6.9 = `:38065`;
  H.6.10 = `:38083`; **Cor. H.6.11 = `:38087`** (not cited).
- **[GLC3]** (`2409.07051v1/src/Eis.tex`). §1.1.2 = `:1771`; §1.1.3 = `:1791`; §1.1.4 =
  `:1808`; §1.1.5 = `:1817` (none of these is cited). §1.3.1 = `:1924`; §1.3.2 = `:1939`
  (cited as "§1.3", right). §§8.1.1–8.1.4 = `:10236–10288` (global only).
- **[ParabolicEisensteinFH]** (`2507.13930v2/src/main.tex`). §1.1 = `:509` (right). Lemma
  4.5.7.1 = `:2780` (the tool gives 4.5.7; right). §A.2 = `:4186` (right). Lemma A.1.5.1 =
  `:4016`; Lemma A.1.5.2 = `:4082` (right). $\mathsf S^\theta$ = `:2385`.
- **[MV]** (by hand). Lemma 7.1 = `:2615`; Rem. 7.2 = `:2629`; the Deligne–Milne citations
  are at `:2700–2712`, with Cor. 2.22 at `:2710`.
- **[GLC1]** (`2405.03599v3/src/functor.tex`). §1.2.2 = `:1440–1447`; Thm. 1.2.4 = `:1459`;
  §1.2.5 = `:1464` (right).

## What this review did and did not do

- **Did:**
  - read every new or changed node against the TeX above;
  - checked the semisimplicity argument, the transfer of parity, the Satake composite, the
    lift, and the module lemma in the unital setting;
  - parsed the plan graph, checked closures and stale ids;
  - reran the lint.
- **Did not:**
  - build anything, run an axiom audit, or do a blind reading, because no Lean file changed;
  - check the locators of the unpinned books (HTT, Lusztig, Deligne–Milne, Lurie);
  - check Tau Ceti `main` beyond the pin.
- **Files:** I wrote only this report. I changed no other file, and committed and pushed nothing.

## Conclusion

**Request changes.**

- **Fixed:** F3 and most of the small points of the earlier report.
- **Blocking:** parity vanishing over $\mathbb C$ is now a node, but it has no proof route (B).
  The owner should either have a route planned or accept the node as an external boundary
  (Q1).
- **Must fix before approval:**
  - M1: the D-module parity statement uses the wrong degree convention, so it is false on odd
    components;
  - M2: even de Rham cohomology of the strata and the constancy of the restrictions are not
    planned;
  - M3: F2 is only partly fixed. The Hecke action is never made Ran-unital, the theorems are
    bundled into a definition with a missing edge, the hypotheses of the module lemma are
    unchecked, rigidity of the independent category is unsourced, and the locator misses
    Cor. H.6.11;
  - M4: F1 is only partly fixed. The analytic de Rham functor is not planned, and the new
    regular-holonomic node is not a dependency of the nodes that use it;
  - M5: the FH transfer node is not a definite statement, conflicts with the half-twisted
    `parabolicIC`, duplicates part of `whittakerJacquet_matches_unipotentInvariants`, and has
    wrong or missing locators.
- **Small:** S1–S6.
- None of these findings changes the Lean statement. All of them are in the blueprint that the
  statement's definitions will be built on.
