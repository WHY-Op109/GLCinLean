# Tau Ceti roadmaps relevant to GLC

- **Source:** the Tau Ceti roadmap repository, <https://github.com/TauCetiProject/TauCetiRoadmap>,
  read at commit
  [`7bf4638c`](https://github.com/TauCetiProject/TauCetiRoadmap/tree/7bf4638c3b94bcd25137be0d5ec4310f93bc8a00)
  (2026-11-08 20:07 UTC). That commit's `lake-manifest.json` pins Tau Ceti `2fd255d9`, Mathlib
  `1b1ccf4b` and Lean `v4.36.0-rc2`. Open roadmap pull requests were read at their head commits,
  listed in the table in §2.4. The Tau Ceti source tree was listed at `main` = `d2083f0f`
  (2026-11-08 09:37 UTC). By the re-check (2026-11-08, about 21:00 UTC) roadmap `main` had moved
  one commit to `fb998610` (#618, ProfiniteProPGroups only), which changes nothing here.
- **Also read in the re-check:** the roadmap worker's `README.md` and `docs/DESIGN.md`
  (<https://github.com/TauCetiProject/TauCetiRoadmapWorker> at `e1830ae6`), and a keyword search
  of the job board <https://github.com/TauCetiProject/TauCetiRoadmapJobs> (issues, 2026-11-08).
- **Checked 2026-11-08.** Clones are in `.lake/research/TauCetiRoadmap/` and
  `.lake/research/TauCetiRoadmapPRs/`, which Git ignores.
- **Licence:** Apache 2.0 (the repository's `LICENSE`). This note quotes short passages only.
- **What was read.** I read the repository `README.md` and `CONTRIBUTING.md` in full. I read the
  `GeometricRepresentationCategories` roadmap (README, STATUS, PROGRESS, the head of
  `Suggested.lean`) in full. For the other roadmaps I read the summary and scope sections, the
  heading list, the `STATUS.md` "At a glance" paragraph, and whatever sections a keyword search
  over all 153 active READMEs turned up. Many READMEs are very long (SchemeAndStackFoundations
  7,500 lines, ReductiveGroupsPartII 7,343, EnhancedDerivedSheaves 2,981), so "not found"
  below means "not found by keyword search", not "read every line". I did not read the Lean Zulip
  topic that `CONTRIBUTING.md` points to.

## 1. What it is

- Tau Ceti is "an AIs-welcome Lean 4 library downstream of Mathlib". The roadmap repository is
  its "human-controlled" side: each roadmap's `README.md` is "the definitive specification of its
  area", and `Suggested.lean` holds suggested Lean signatures, "never ... an exhaustive
  checklist". [R 2026-11-08]
- There are 153 active roadmaps under `TauCetiRoadmap/` and 30 completed ones under `Completed/`.
  [R 2026-11-08] The 153 are the top-level folders with a `metadata.toml`. Some are families
  with sub-roadmaps that have no `metadata.toml` of their own: `RepresentationTheory/` has 14
  (for example `LieHighestWeight`, `RootSystems`), `OperatorTheory/` 9 and `SymplecticGeometry/`
  5. [R 2026-11-08]
- There are also many proposed roadmaps that are still open pull requests: 468 open pull
  requests that are not progress reports (469 earlier the same day). Their median age is 17 days
  and the oldest is 100 days old; 275 of them are by one author (CBirkbeck) and 90 by kim-em.
  419 carry `awaiting-review`, 369 `awaiting-dependencies`, 288 `ai-approved` (a label
  authors may not set themselves, CONTRIBUTING; a merge still needs a `roadmap-reviewers`
  approval) and 244 `roadmap-worker` (written by the automated roadmap pipeline of §2.2). [R 2026-11-08, counted with `gh pr list`]
- `STATUS.md` and `PROGRESS.md` are written by a bot (TauCetiProgress). The README warns that
  "their prose is not security-validated" and that the human-owned `README.md` is the authority.
  The status claims below are therefore [S], the roadmap system's claim about itself.
  [R 2026-11-08]

## 2. What it says that matters for GLCinLean

### 2.1 Rules for writing a roadmap (README, "Writing a roadmap") [R 2026-11-08]

- **Build the library, don't race to the theorem.** "A definition with no lemmas about it is not
  a contribution."
- **No gaps.** "Every milestone must rest on existing Mathlib or Tau Ceti material, on earlier
  material in the same roadmap, or on an explicitly cited dependency in another roadmap."
- **Make contact with existing material** (CONTRIBUTING): "A roadmap whose lowest rung is still
  far above what has been formalized just makes agents thrash and produce bad code."
- **Clear boundaries.** Roadmaps are kept "non-overlapping as far as we can", and "where one
  depends on material from another, that dependency is stated". The stronger wording "The
  following objects have one owner; this roadmap states comparisons to them and never a second
  carrier" is not in the repository README; it is the practice of individual roadmaps (quoted
  from SchemeAndStackFoundations l.77–78; ProfiniteArithmetic and others say the same).
- **Be definite.** Nothing is "optional", "deferred" or "for later".
- **Defer to Mathlib on shape, never on timing; never push work to Mathlib.** "Mathlib owns its
  API decisions"; "Nothing on a roadmap is ever 'pending upstream'"; Tau Ceti material "stays
  there".
- **Honest `sorry` in prototypes.** A condition you cannot state "is still a `sorry`, never a
  `Prop`-typed field or a `def _ : Prop := sorry`"; "omit a condition you cannot state rather
  than name an empty one".
- **Pin conventions** ahead of time.
- **Each roadmap has a `metadata.toml`** with one arXiv `topic` (for example `math.RT`); the
  build check fails without it.

### 2.2 How a roadmap gets in (README "How changes are made", CONTRIBUTING) [R 2026-11-08]

- Anyone may open a roadmap PR. It "merges automatically once it has an approving review from a
  member of the `@TauCetiProject/roadmap-reviewers` team" and the `build` check passes.
- A first PR earns an invitation to `roadmap-triage`; two merged roadmap PRs earn
  `roadmap-reviewers`.
- Review has four aspects: what is included (a "human subject-matter expert is key"), how it is
  done, Tau Ceti format, and repeated detailed review (where AI helps). "Substantive review,
  especially from a subject-area expert, is the thing we are shortest of."
- AI assistance must be attributed, in PR descriptions and in review comments (a :robot:
  prefix). "Nobody should post a roadmap or a review comment they have not read carefully
  themselves."
- A roadmap PR touches only its own directory. Roadmap lists are regenerated by a bot.
- **Intentions and claims:** before substantial work, open an `[Intention]: ...` issue listing
  the targets and comment `claim`. Claims expire (30 days by default, 90 at most). "Automated
  roadmap workers **respect these claims**."
- **The automated roadmap pipeline** (TauCetiRoadmapWorker `README.md` and `docs/DESIGN.md`,
  `e1830ae6`) [R 2026-11-08]. "Humans file targets on the job board; workers triage them,
  design the roadmaps, write the roadmap packages, review each other's work independently, and
  port accepted packages to TauCetiRoadmap as draft pull requests. Nothing merges into the
  roadmap repository without a human." A target is one issue on
  `TauCetiProject/TauCetiRoadmapJobs` with the "Target" template (statement or topic, why it
  matters, known sources, suggested name): "That is the whole hand-off". The human touch points
  (DESIGN §7) are: file a target or intention, answer `needs-references` requests, optionally
  review designs, "Review and merge the roadmap PR", and maintain the worker configuration.
  Workers are run by operators on their own machines under their own GitHub accounts; the
  244 `roadmap-worker` PRs are posted by CBirkbeck (135), kim-em (83) and roed-math (25).
- **GLC-relevant traffic on the job board** (keyword search, 2026-11-08) [R]: a target
  `QuasicoherentSheavesOnPrestacks` (#2534, filed 2026-10-27 by CBirkbeck) asks for QCoh of a
  prestack "defined by Kan extension from affine schemes", as the limit of `Mod_R(Sp)` over the
  points `Spec R → X`, citing Lurie SAG and Gaitsgory–Rozenblyum Vol. I Ch. 3. Its design job
  (#7411) was authored by a worker and accepted on the board on 2026-11-08; it is not yet a
  roadmap PR. Searches for IndCoh, "de Rham prestack", "singular support", Bun_G, oper and
  "loop Grassmannian" found nothing; "ind-coherent" matched only the unrelated
  `EtaleHomotopyTypes` package (#393, not opened). "Geometric Langlands" matched only
  `FourierDeligneTransform` (#7346, an ℓ-adic target).

### 2.3 Roadmaps on `main` that bear on GLC

GLC objects below refer to `GLCinLean/Abstract.lean` and `Foundations.lean`: the curve `X`, the
reductive group `G` and its dual `Ǧ`, `Bun_G`, the half twist, `Dmod_{1/2}(Bun_G)`, `LS_Ǧ`,
`QCoh(LS_Ǧ)`, `IndCoh_Nilp(LS_Ǧ)`, the DG-category carrier `DGCat` with `LinFun`, and the
functor `𝕃_G`. Status lines are [S] with the date of the `STATUS.md` they come from; scope lines
are [R 2026-11-08].

| Roadmap (topic) | Scope (what it owns) | GLC objects it would supply | Status [S] |
|---|---|---|---|
| **GeometricRepresentationCategories** (math.RT) | Coherent categorical group actions (monoidal actions ↔ pseudofunctors), invariant full subcategories, critical-level smooth affine Lie-algebra module categories `Ccrit(p)` over local opers, equivariant groupoid transport, descent, and an outer-derivation/Ext bridge. Its endpoint is the *local* "critical categorical-lift conjecture" (Frenkel–Gaitsgory), stated as a type of lift data, "the conjecture's existence is not an unconditional theorem target". "An unqualified global geometric Langlands theorem is not this conjecture." Its parameter groupoid is built from *formal* dual local systems on the punctured disc, `Loc_{G∨}(D×)` and `IsomOp` (R5.1), supplied by the unmerged FormalConnectionsOpers (#1056). | None of the GLC statement objects (the formal-disc `Loc_{G∨}(D×)` is not the global stack `LS_Ǧ` of a curve [J]). Generic bicategorical action API (`EquivariantGroupoidLift`, pseudofunctor comparisons) may be reusable. Local critical-level material matters only for the proof (GLC III-style Kac–Moody localisation) [J]. | 2026-10-26: R1 done except one linearity statement; R2, R4, R5 partial; R3 untouched. |
| **EnhancedDerivedSheaves** (math.AG) | dg nerve inside Mathlib's quasicategories, enhanced `D∞(O)` on ringed sites, Kan extensions, presentable / dualizable / rigid categories, Ind, the tensor product of presentable categories, Barr–Beck–Lurie, spectra, animated rings, cotangent complex. Built on BordismFormalGroups F6.5's generic ∞-categorical model. | The natural home of `DGCat` (presentable stable `k`-linear ∞-categories), `LinFun`, compactness, and `QCoh` as an enhanced category; animated rings are the first step towards derived stacks such as `LS_Ǧ` [J]. | 2026-11-06: dg nerve with horn filling, homotopy category and mapping spaces exists; "No layer is complete"; stability, finality and presentability "still absent"; E3 and E5:abstract untouched. The generic framework it consumes (stability, Ind, presentable categories, straightening) is "supplied by `BordismFormalGroups` F6.5" [R], and BordismFormalGroups reports "F2 (Quillen's theorem) through F6 have not begun" (2026-10-25). |
| **SchemeAndStackFoundations** (math.AG) | Descent, algebraic spaces, stacks in groupoids, stackification, algebraic and Deligne–Mumford stacks, quotient stacks, `Stacks.QCoh` (abelian, §1.22), site cohomology, `DQCoh`/`DCoh` inside Mathlib's `DerivedCategory` (§2.18), coherent duality, curves and Picard stacks (Layer 3), deformation theory, Hilbert and Quot schemes (§4.14). | Algebraic stacks and their QCoh, the prerequisites for `Bun_G` (§1.18 has the classifying stack `BG` of `G`-torsors; §1.21 quotient stacks [R]); Picard stacks (`Bun_{GL_1}`); Quot schemes for charts of `Bun_G` [J]. No derived stacks, no IndCoh, no D-modules (keyword search). | 2026-10-25: Layer 0 partial but substantial; Layer 4 partial; **Layers 1, 2, 3 and 5 untouched**. Tau Ceti has `SchPseudofunctor` (`TauCeti/AlgebraicGeometry/Stack/Basic.lean`) and `AlgebraicSpace/Basic.lean` [R, source tree]. |
| **DGAInfinity** (math.CT) | Koszul signs, dg algebras and dg categories, `A∞` objects, Hochschild cochains, twisted objects, dg Morita theory. | dg-category models (`TauCeti.DGCategory` already exists, per EnhancedDerivedSheaves). | 2026-10-24: Layers 0–5 and 8 partial; "nothing triangulated or derived". |
| **DerivedModuleAlgebra** (math.AC) | Cotangent complex, derived powers, unbounded derived tensor and Hom in `D(R)`, completion, Koszul complexes. | Cotangent complexes and derived tensor for the deformation theory of `LS_Ǧ` [J]. | 2026-10-25: Koszul and tower foundations nearly complete; nothing yet on K-injectives or the cotangent complex. |
| **AlgebraicCurves** (math.AG) | Function fields, divisors, Riemann–Roch, Riemann–Hurwitz, regular projective models, the curve/function-field anti-equivalence. | The curve `X` and its basic theory. | 2026-11-08: through Riemann–Roch and Riemann–Hurwitz complete; projective anti-equivalence complete. |
| **JacobianChallenge** (math.AG) | Coherent cohomology of curves, Picard functor, Jacobian, Abel–Jacobi. | `H^*(X, -)`, Serre duality, Picard (`Bun_{GL_1}`), the canonical sheaf. | 2026-11-06: curve case of Riemann–Roch and Serre duality in place; no Jacobian scheme. |
| **AlgebraicVectorBundles** (math.AG) | Locally free sheaves, tensor/dual/determinant, relative Spec, geometric vector bundles. | Vector bundles on `X × S` (the `GL_n` case of `Bun_G`), determinant lines [J]. | 2026-10-25: L0A, L1A, L1B done; L2A partial; L2B not begun. |
| **ReductiveGroups** (math.AG) | Reductive groups over a field: structure, Bruhat, root data, Chevalley–Demazure groups over `ℤ` (Layer 9), highest weights. | `G`; already used by `Foundations.lean` (`TauCeti.ReductiveAffineGroupSchemeCat`). | 2026-11-07: foundations complete; structure theory partial. |
| **ReductiveGroupsPartII** (math.RT) | Local structure over nonarchimedean fields; **RG2.5: the dual based root datum (`autFlip`, `dualGaloisAction`) and the Langlands dual group `Ĝ` over `ℤ` by Chevalley–Demazure**. | `Ǧ` and the `RootDatumDuality` placeholder (the flip itself is field-independent) [J]. RG2.5 builds `Ĝ` over `ℤ` as "the pinned split reductive group" attached to the flipped absolute based root datum [R]; it needs the root datum of `G`, which the GLC placeholder docstring says no library yet defines for a general reductive group. | No `STATUS.md`; no `LanglandsDual` file in the Tau Ceti tree [R]; probably not started [E]. What does exist: Mathlib's `RootPairing.flip`, and Tau Ceti's `LinearAlgebra/RootSystem/Flip.lean` and `Duality.lean` (Dynkin-type duality, `Bₙ ↔ Cₙ`) [R, source tree]; these are root-system level, not a dual group. |
| **ChevalleyGroups** (math.GR), **FlagVarieties** (math.AG), **SchubertGeometry** (math.AG) | Simply connected Chevalley–Demazure groups and their points; parabolics and `G/P` projective iff parabolic (merged 2026-10-30); Schubert varieties, Demazure, flag K-theory. | Flag varieties for Beilinson–Bernstein-type arguments in the proof [J]. | Chevalley and Flag: no `STATUS.md`. Schubert 2026-10-26: only combinatorics; "Nothing geometric exists yet". |
| **NilpotentOrbits** (math.RT) | Jacobson–Morozov, Kostant, Slodowy slices, nilpotent cone, Springer resolution. | The nilpotent cone of `ǧ`, needed for the singular support condition `Nilp` in `IndCoh_Nilp` [J]. | 2026-10-26: "no nilpotent cone as a scheme" yet. |
| **AffineLieAlgebras** (math.RT), **KacMoody** (math.RT) | Currents, smooth modules, completed enveloping algebras, vacuum vertex algebras, Feigin–Frenkel at critical level; symmetrizable Kac–Moody theory. "no categorical-lift or global Langlands theorem is requested here." | Proof-side only (localisation at critical level) [J]. KacMoody names "FormalConnectionsOpers Layer 3A" (the open PR #1056) as owner of "loop Grassmannians and positive orbits" and therefore uses none of it [R]. | ALA 2026-11-08: A1 and A4.1 done; Feigin–Frenkel "not started". KacMoody: no `STATUS.md`. |
| **RepresentationTheory** family (math.RT), notably **LieHighestWeight** | Index of 14 sub-roadmaps: semisimple algebras, characters, root systems, Lie highest weight (enveloping algebras, PBW, Verma and simple modules, central characters, Weyl character formula), Lie groups, classical groups. It excludes "affine or general Kac-Moody theory" and quantum groups. | Proof-side only: #1828's category O and Beilinson–Bernstein consume LieHighestWeight's Verma modules and central characters [R for the citation in #1828, J for the use]. | Index has a `STATUS.md`; sub-roadmaps not checked. |
| **FormalLaurentPuiseux** (math.AC) | `K((t))`, Newton–Puiseux, Galois group of `K((t))`. | Formal disc calculus behind loop groups [J]. | 2026-11-06: summit reached. |
| **EtaleCohomologyFoundations** (math.AG) | Étale cohomology with ℓ-adic and torsion coefficients, duality, field perverse t-structures. | Perverse sheaves, but **étale/ℓ-adic**, not D-modules [J]. | 2026-10-23: entry points partial; perverse sections not started. |
| **ComplexKahlerGeometry**, **SmoothBundlesConnections** (math.DG) | Flat holomorphic/smooth bundles ↔ local systems (analytic); connections, holonomy. | Topological/analytic local systems, not the de Rham stack `LS_Ǧ` [J]. | Not checked. |

Keyword search found **no** active roadmap that uses "D-module" in the sense of modules over
differential operators on a complex or characteristic-zero variety (the one hit, in
AdicSpacesPartIV, is p-adic "dagger" D-modules), "ind-coherent", "IndCoh", "Whittaker" (except
one unrelated hit in EllipticIntegrals), "de Rham prestack" or "derived stack". "Singular support"
occurs only in the analytic or distributional sense (PseudodifferentialOperators,
StandardDistributions and others), never for coherent sheaves. "Bun_G" occurs once, in
AdicEtaleGeometry, as a pointer to the open "`Bun_G` and Newton-strata" PR (#1241). Perverse
sheaves on `main` are only étale (EtaleCohomologyFoundations §F.8, "Perverse t-structures over a
field"). [R 2026-11-08]

### 2.4 Open roadmap pull requests that bear on GLC (not merged)

These are proposals, not roadmaps yet. All carry `awaiting-review` and `awaiting-dependencies`;
all except #848, #1547 and #1743 also carry `ai-approved`. None has the human approval that would
merge it. [R 2026-11-08]

| PR (head) | Roadmap | What it would supply for GLC |
|---|---|---|
| [#1828](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1828) (`f8ea4db6`) | SpringerResolutionAndCharacteristicCycles | **The only algebraic D-module theory found.** Layers 8–10, for "every smooth separated finite-type characteristic-zero scheme": coherent D-modules, good filtrations, characteristic variety and cycle, transfer modules and operations, Kashiwara equivalence, Bernstein inequality, holonomic and regular holonomic modules, intermediate extension `j_!*`, strong equivariance, Beilinson–Bernstein localisation, category O. Abelian categories of modules on **schemes**, not DG categories on **stacks**. Its `Suggested.lean` "declares nothing" because no headline is statable at the pins. |
| [#1056](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1056) (`19335eca`) | FormalConnectionsOpers | Algebraic connections, differential operators (symbols, Atiyah sequence, Lie–Rinehart PBW, `gr D ≅ Sym T`, §2.2), formal and polynomial loop groups, **the loop Grassmannian** and affine flags (Layer 3A), local opers, Drinfeld–Sokolov reduction. Formal disc only. Base: the formal calculus and differential operators over arbitrary commutative rings, most algebra over a characteristic-zero field `k`, but the loop Grassmannian and affine flags (§3A.5, "ind-schemes over `ℂ`") and the oper-reduction theorem (Layer 6) over `ℂ`. Review state: one formal review, CHANGES_REQUESTED by roed-math (2026-10-19), itself marked ":robot:" (GPT-6 Astra Pro); later AI-assisted comments approve, the latest on the current head `19335eca` (2026-11-07). No human approving review. |
| [#848](https://github.com/TauCetiProject/TauCetiRoadmap/pull/848) | ComplexComparisonPartII | Owns the ordinary differential-operator sheaf (C5.1) that #1056 and #1828 consume; analytification; de Rham–Betti comparison. Read only through the citations in #1056 and #1828. |
| [#999](https://github.com/TauCetiProject/TauCetiRoadmap/pull/999) (`72057320`) | EndoscopicTransferAndUnitaryTraceComparison | **§3.1 constructs `Bun_G`** on a fixed smooth projective curve: groupoids of `G`-torsors on `X×S`, fppf descent, algebraic and locally of finite type, universal torsor, "Quasi-compactness is neither required nor asserted". §3.2: the local loop Grassmannian as an ind-scheme. Its purpose is Ngô's fundamental lemma, and its Conventions say: "For the equal-characteristic geometry, `k` is finite", with `char(k)` not dividing the Weyl-group order [R]. So this `Bun_G` is over a finite field; `G` is a "smooth affine quasi-split reductive `X`-group". The construction itself (torsors, fppf descent, Quot charts, Artin's criterion) looks field-independent [J], but a characteristic-zero version would have to be a separate, generalised statement. It cites Artin's criterion from #853 §7.1, also unmerged. |
| [#853](https://github.com/TauCetiProject/TauCetiRoadmap/pull/853) (`4f0ad34e`) | AlgebraicModuliForArithmeticGeometry | Representability machinery: Grassmannians, Hilbert and Quot functors, Hom and Isom schemes, gerbes, and Artin representability (§7.1, "Formal points, gluing and module obstructions"). The algebraicity proof of `Bun_G` in #999 §3.1 rests on it. Summary and §7.1 heading read only. |
| [#1490](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1490) (`ede1562a`) | GlobalShtukasAndFunctionFieldLanglands | `Bun_𝒢` for curves over `𝔽_q` with level structure and HN data, Beilinson–Drinfeld Grassmannians and Hecke stacks over `X^I`, ℓ-adic geometric Satake over finite fields, V. Lafforgue's theorem. The arithmetic (function-field) analogue. |
| [#1202](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1202) (`1e9f8e83`) | LanglandsParameterStacks | Derived stack of *local* L-parameters, cotangent complex, singularity stack, **nilpotent singular support** of coherent complexes (Fargues–Scholze VIII.2, Arinkin–Gaitsgory cited), perfect complexes on quotient stacks. The closest analogue of `LS_Ǧ` and `IndCoh_Nilp`, but for Weil-group parameters over `ℤ_ℓ` [J]. |
| [#1235](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1235) (`140b5a7e`), [#1241](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1241), [#1252](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1252) | GeometricSatakeAndFusion, BunGAndNewtonStrata, HeckeStacksAndLocalShtukas | Fargues–Scholze geometrisation: geometric Satake over the Fargues–Fontaine curve, `Bun_G` of the Fargues–Fontaine curve (v-stacks), Hecke stacks. ℓ-adic and p-adic; not the de Rham setting [J]. |
| [#1040](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1040), [#1743](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1743) | EtaleDualityAndPerverseSheaves (I, II) | Étale perverse sheaves, refined duality. Titles and file lists only. |
| [#1547](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1547), [#1814](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1814) | CountingBundlesAndHallAlgebrasOfCurves, TopologicalMirrorSymmetryForHitchinSystems | Bundles and Higgs bundles on curves (finite-field counts, SL/PGL Hitchin mirror symmetry). The latter cites "general Higgs stacks" in #999 §§3.6–3.14. |

### 2.5 A precedent worth noting

`GeometricRepresentationCategories` was merged on 2026-10-19 (PR #1130, one approval by
roed-math) although its prerequisites are cited as an unmerged PR (#1056) and as a branch
`roadmap/affine-lie-algebras-20261018`. [R 2026-11-08] The branch held AffineLieAlgebras
(#1129), which merged at the same moment (both `mergedAt` 2026-10-19T04:04:53Z), so it is not a
real exception. #1056 is: it is still open three weeks later. [R 2026-11-08] So in practice "an
explicitly cited dependency in another roadmap" can be an open proposal. [J]

## 3. What it means for GLCinLean

- **Owner's item 4, "perhaps write a roadmap for geometric representation theory (one may
  already exist)".** A roadmap named "geometric representation categories" exists, but it is not
  a geometric representation theory library in the owner's sense. It covers coherent categorical
  actions and the *local*, critical-level categorical-lift conjecture of Frenkel–Gaitsgory. It has
  no D-modules, perverse sheaves or stacks of bundles, and its only local systems are formal ones
  on the punctured disc, borrowed from the unmerged #1056. [R] for its contents, [J] for the
  conclusion.
- **No merged roadmap covers the core of the GLC statement.** `Bun_G` (in characteristic zero),
  D-modules on stacks as DG categories, the half twist, the de Rham stack of local systems
  `LS_Ǧ`, IndCoh, nilpotent singular support and the Whittaker coefficient all have no owner on
  `main`. [R, keyword search] Under the owner's rule (ideas item 4), these fall in "parts that
  neither Mathlib nor Tau Ceti has": they would be written in this repository first. [J]
- **Where GLC's prerequisites would fit** [J]:
  - *the base (curve, group, dual group, line bundles)*: AlgebraicCurves, JacobianChallenge,
    ReductiveGroups, ReductiveGroupsPartII RG2.5. These are existing owners; contributions go
    there. This matches workflow step 3 ("Tau Ceti roadmap items become Tau Ceti pull requests").
  - *the DG-category carrier (`DGCat`, `LinFun`, compactness, Ind, Lurie tensor product)*:
    EnhancedDerivedSheaves E0 and E5:presentability (with BordismFormalGroups F6.5). This is an
    existing owner, but only the dg nerve is built so far.
  - *stacks and QCoh*: SchemeAndStackFoundations Layer 1 (untouched so far). `Bun_G` would sit
    on it; PR #999 §3.1 is a ready-made specification of `Bun_G` if it merges, but over a
    finite field, and its algebraicity proof needs #853 (also open).
  - *QCoh of prestacks as presentable stable categories* (the setting of `QCoh(LS_Ǧ)`, and one
    standard route to D-modules through the de Rham prestack): the
    `QuasicoherentSheavesOnPrestacks` job already in the roadmap pipeline (§2.2), if it becomes a
    roadmap. It sits on EnhancedDerivedSheaves E5. Whether its scope (classical and animated or
    connective rings) reaches the derived, laft prestacks GLC needs is not settled by the target
    text. [J]
  - *D-modules on smooth schemes*: PR #1828 Layers 8–9, if it merges. Its abelian, scheme-level
    theory is a natural first rung for the DG, stack-level `Dmod(Bun_G)` [J].
  - *everything above that*: D-modules on stacks as DG categories, twisted D-modules, the de
    Rham prestack, `LS_Ǧ` as a derived stack, IndCoh and singular support, de Rham geometric
    Satake and Hecke functors, Whittaker models. No owner, so these are the candidate content of
    a new roadmap. Its title must avoid clashing with GeometricRepresentationCategories ("Clear
    boundaries"). [J]
- **How far along.** Every foundation GLC needs is at an early stage. The ∞-categorical layer has
  "No layer ... complete" (2026-11-06) and the generic framework it waits for (BordismFormalGroups
  F6.5) has not begun (2026-10-25), stacks are "untouched" (2026-10-25), and the D-module
  roadmap is not merged. The "lowest rung" rule ("A roadmap whose lowest rung is still far above
  what has been formalized just makes agents thrash") means that a GLC-level roadmap written now
  would fail review, or would have to start at the D-modules-on-schemes rung. [S] for the
  statuses, [J] for the consequence.
- **Workflow step 2 (Plan).** The blueprint maps each object to "Mathlib, Tau Ceti, a Tau Ceti
  roadmap item, or missing". The tables in §2.3–2.4 are a first draft of that column. A fourth
  value is needed: "an open roadmap PR". [J]
- **Workflow step 3 (Build) and the "fully automated" decision.** The intention-and-claim system
  is how automated contributors avoid collisions, and "Automated roadmap workers respect these
  claims". The recurring build prompt should therefore file an intention, claim it, and respect
  other people's claims before opening Tau Ceti PRs. [R] for the mechanism, [J] for the advice.
- **Owner's item 4, "it depends on how hard it is to contribute to Tau Ceti's roadmap".** The
  cheapest route Tau Ceti offers is one `[Target]` issue on the job board (§2.2): statement,
  motivation, sources, name. Operators' workers then design, write and cross-review the roadmap,
  and a Tau Ceti roadmap reviewer merges it. GLCinLean does not need to write or review the
  roadmap text itself on that route; whether operators pick the target up, and when, is outside
  its control. [R] for the mechanism, [J] for the assessment.
- **Workflow step 5 (Refactor).** Roadmaps follow "Defer to Mathlib on shape, never on
  timing": build now, name and shape things the way an active Mathlib PR does, then delete and
  adopt when it lands. This is the same stance as the Xena principle "continuously refactor to
  adopt their decisions" (ideas item 1). [J]
- **Owner's principle "Link to the existing literature" (ideas item 1).** Tau Ceti roadmaps cite
  sources down to page and equation (for example "Ngô, §4.1, p. 62"). A GLCinLean roadmap or
  blueprint would be held to the same standard. [R] for the practice.
- **Placeholders.** GRC requires that "The conjecture must be represented by the complete type of
  lift data, never by an empty `Prop` field or by an unconditional existence theorem". Tau Ceti's
  prototyping rule forbids `Prop`-typed fields and `def _ : Prop := sorry`, and says "omit a
  condition you cannot state rather than name an empty one". GLCinLean's `@[placeholder] opaque`
  objects are a third pattern; the rule does not mention it, and the Tau Ceti source tree has no
  `opaque` declarations at all (search of `TauCeti/`, `d2083f0f`). See §5. [R] for the rules and
  the search, [J] for the comparison.

## 4. Conflicts

- **Full automation versus human-curated roadmaps.** The workflow decision "Tau Ceti
  contributions are fully automated, following Tau Ceti's own requirements" works for code PRs.
  For *roadmap* PRs, Tau Ceti's own requirements include "Nobody should post a roadmap or a review
  comment they have not read carefully themselves", attribution of AI help, and "Humans direct the
  mathematical scope and approve roadmap changes". The owner says (ideas item 4) "I might not be
  able to review a roadmap fully". A fully automated roadmap submission would break this rule.
  [R] for both texts, [J] for the conflict.
  The conflict is narrower than it first looks. Tau Ceti itself runs an automated roadmap
  pipeline (§2.2) in which the human role is to file a target and, at the end, for a Tau Ceti
  roadmap reviewer to review and merge; 244 open roadmap PRs came out of it. What stays human is
  (a) the decision to file a target, a public act under the owner's account, and (b) the "read
  carefully" rule for anyone who posts a roadmap PR or review comment directly. A GLCinLean
  session posting roadmap PRs itself would still be covered by (b); filing a target and leaving
  the writing to the pipeline would not. [R] for the pipeline, [J] for the reading.
- **Ideas item 4 ("parts that a Tau Ceti roadmap covers: ... contribute it directly to Tau
  Ceti") versus where the coverage is.** The coverage that matters most for GLC (D-modules,
  `Bun_G`, loop Grassmannian, parameter-stack singular support) is in *open roadmap PRs*, not in
  merged roadmaps. Ideas item 4 does not say whether an open PR counts as "covered". [J]
- **Base field.** GLCinLean's `Setting` takes an algebraically closed field `k` of characteristic
  zero (GLC I §1). The relevant local roadmaps fix `ℂ` (GRC: "complex algebraic group";
  AffineLieAlgebras: "specialize to 𝕜 = ℂ" for classification, integration and centers;
  FormalConnectionsOpers: a characteristic-zero `k` for most of its calculus, but `ℂ` for the loop
  Grassmannian and for oper reduction). D-modules in PR #1828 are over any characteristic-zero
  field. `Bun_G` in PR #999 is over a finite field. For the statement this is harmless; for the
  proof the `ℂ`-only pieces would need generalising or a base-change argument. [R] for the
  roadmap conventions, [J] for the consequence.
- **"Defer to human-curated libraries" (ideas item 1) versus Tau Ceti's nature.** The Tau Ceti
  *code* is AI-authored ("The AI-authored mathematics lives in the code repo"); only the
  roadmaps are human-curated. The order "Mathlib, then Tau Ceti" in ideas item 3 is still
  consistent with the Xena text, which names Mathlib first. [R] for the quote, [J] for the
  reading.
- **No conflict found** with "never push work to Mathlib" for GLCinLean itself: ideas.md never
  asks to upstream to Mathlib. [J]

## 5. Input for the open questions (notes/workflow.md)

- **What goes into `AGENTS.md`.** Suggested content, with reasons [J]:
  - "Before building an object, look it up in Mathlib, Tau Ceti, the Tau Ceti roadmaps, the
    open roadmap PRs *and* the roadmap job board." The open PRs are where most of the
    GLC-relevant specification currently lives (§2.4); the board shows what is about to be
    specified (for example QCoh of prestacks, §2.2).
  - "Before a Tau Ceti PR, file and claim an intention; respect others' claims." This is the
    mechanism automated workers are expected to follow (§2.2).
  - "Treat `STATUS.md`/`PROGRESS.md` as a machine's account; the roadmap README is the
    authority." This is the README's own warning.
- **Whether `PLAN.md` is needed.** Tau Ceti separates a human-owned specification (`README.md`)
  from generated status (`STATUS.md`, `PROGRESS.md`). That suggests a GLCinLean plan file is
  worth keeping as the *specification* (the blueprint: each object, its owner, its source),
  while status lives elsewhere or is regenerated. Prompts carry the steps, not the
  specification. [J]
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholders are reasonable.**
  - The placeholders avoid the two patterns Tau Ceti forbids: they are uninterpreted `opaque`
    objects, not `True`-satisfiable `Prop` fields or `sorry`-valued `Prop` definitions. But the
    rule's spirit, "omit a condition you cannot state rather than name an empty one", fits the
    `Prop`-valued placeholders `DGCat.IsCompact` and `DGCat.IsEventuallyCoconnective` less well
    than the type-valued ones: they name conditions that cannot yet be stated. They are used in
    one clause of the statement (`Abstract.lean` l.109: compact objects go to eventually
    coconnective ones). They cannot be proved or refuted, so the clause is not trivial, but it
    says nothing checkable until the definitions exist. The rule binds Tau Ceti roadmaps, not
    GLCinLean. [R] for the file, [J] for the reading. Each placeholder can be tied to its future owner:
    `DGCat`/`LinFun` → EnhancedDerivedSheaves E5:presentability; `RootDatumDuality` →
    ReductiveGroupsPartII RG2.5 (`autFlip`, `dualGroup`); `Bun_G` inside `DmodHalf` → PR #999
    §3.1 or SchemeAndStackFoundations Layer 1; `DmodHalf`, `QCohLS`, `IndCohNilp`, `Psi`,
    `LCoarse` → no owner. Recording this owner in each placeholder's docstring would make the
    Refactor step mechanical: when the owner lands, swap. [J]
  - `GLCinLean.ReductiveGroup` already reuses `TauCeti.ReductiveAffineGroupSchemeCat`, which is
    in line with "never a second carrier". [R] for the file, [J] for the assessment.
- **Who reviews the mathematics.** Tau Ceti's model: AI does the detailed checks, a human
  subject-matter expert judges scope and soundness, and that expert "is the thing we are shortest
  of". That suggests GLCinLean also needs an outside expert at least for the statement and for
  any roadmap it proposes; fresh agents alone match Tau Ceti's aspects 2–4, not aspect 1. [R] for
  the model, [J] for the suggestion.
- **Where research notes and session summaries live.** Tau Ceti commits its generated status
  files beside the specification and marks them as unvalidated. GLCinLean could do the same:
  commit session summaries, marked as machine-written, beside the human-checked plan. [J]

## 6. Questions for the owner

1. **New roadmap or not, and by which route.** No merged roadmap owns the GLC backbone. Do you
   want GLCinLean to seek a new Tau Ceti roadmap for it (D-modules on stacks, `LS_Ǧ`, IndCoh,
   singular support, de Rham Satake, Whittaker)? There are two routes. (a) File one or more
   `[Target]` issues on the job board and let Tau Ceti's roadmap workers write it (§2.2); you
   would not have to write or review the text, but you would not control the timing. (b) Write
   the roadmap PR here; then someone must have "read it carefully" and a subject-area expert is
   wanted, and you said you might not be able to review a roadmap fully.
2. **Does an open roadmap PR count as "covered"?** D-modules (#1828), the loop Grassmannian
   (#1056) and `Bun_G` (#999) are specified only in open PRs. Should GLCinLean (a) wait for them
   to merge, (b) build on them as specifications and contribute to Tau Ceti once they merge, or
   (c) write its own versions here now?
3. **Public actions in your name.** Filing job-board targets, filing intentions, claiming targets
   and opening roadmap PRs happen under your GitHub account and carry Tau Ceti's AI-attribution
   rules. Do you approve the build prompt doing these unattended, or only code PRs?
4. **Base field.** Keep GLC I's general algebraically closed `k` of characteristic zero, or accept
   `ℂ` where the Tau Ceti local roadmaps (GRC, AffineLieAlgebras, parts of
   FormalConnectionsOpers) fix it? The only `Bun_G` specification (#999) is over a finite field,
   so a characteristic-zero `Bun_G` needs either a generalised #999 §3.1 or a new specification.
5. **Contribute to the ∞-categorical foundations?** GLC's `DGCat` needs presentable stable
   ∞-categories, which EnhancedDerivedSheaves owns and has barely started. Should GLCinLean put
   effort into that roadmap (large and shared), or keep `DGCat` a placeholder until it lands?
