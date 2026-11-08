# Tau Ceti: the library code relevant to GLC

- **Source:** the Tau Ceti library repository, `TauCetiProject/TauCeti`.
- **Pinned version (what this project builds against):** tag `v4.36.0-rc2`, commit
  `e0610cce4004d628cbd9d2aafdbbb5459fe72938` (2026-11-02),
  <https://github.com/TauCetiProject/TauCeti/tree/e0610cce4004d628cbd9d2aafdbbb5459fe72938>.
  Local copy: `.lake/packages/TauCeti/`.
- **Current main, compared against the pin:** commit `d2083f0f1dd2136d02467ba36efbbe1af612e89c`
  (2026-11-08 09:37 UTC), shallow clone in `.lake/research/TauCeti-main/` (Git ignores it).
- **Roadmap repository**, read only for context: `TauCetiProject/TauCetiRoadmap` @ `fb998610`
  (2026-11-08). For the roadmap route, also `TauCetiProject/TauCetiRoadmapWorker` @ `e1830ae6`
  (README) and `TauCetiProject/TauCetiRoadmapJobs` @ `82516970` (README); the Tau Ceti tag list,
  the commit history of `lake-manifest.json`, and the state of roadmap PRs #1056, #1828, #999,
  #908, read through `gh api` on 2026-11-08 (second check).
- **Checked 2026-11-08.**
- **Licence:** Apache-2.0 (README and `formalization.yaml`). Code can be copied with attribution.

How the tags are used: [R] read directly in the source on 2026-11-08; [S] a source's claim about
itself (a docstring or README saying what the code does, which I did not check by building or
reading proofs); [E] estimate; [J] judgement. A tag covers the sentence or bullet it ends.

**Method and its limits.** I read the README, `AGENTS.md`, `COORDINATION.md` (first part),
`formalization.yaml`, `tauceti.toml`, `lakefile.toml`, `docs/toolchain-tags.md` and the module
docstrings and key declarations of the files named below. I found the files by directory listings
and case-sensitive `grep` over all 23,391 (pin) and 27,553 (main) `.lean` files. Nothing was built.
A concept under an unexpected name can be missed by `grep`, so "absent" below means "not found by
these searches". [R]

**Second check (2026-11-08).** The rules in §2.1, the definitions behind the table rows for
reductive groups, pinnings, curves, ω_X, stacks and Chevalley groups, the file counts, the names
used by `Foundations.lean` and the absence searches were re-read in the source. Corrections from
that check are marked "(corrected)". [R]

---

## 1. What it is

- **Its own description.** "A repository of formal mathematics with human-directed and
  human-reviewed roadmaps, implemented and maintained by AI contributors, subject to adversarial
  review." Incubated by the Lean FRO and the Mathlib Initiative. [S, README]
- **Three repositories:** `TauCeti` (AI-authored Lean code), `TauCetiRoadmap` (human-owned
  roadmaps: Markdown plus `sorry`-allowed Lean target signatures), `TauCetiReview` (rubrics and
  review machinery). [S, README; `formalization.yaml`]
- **Its stated aim:** "building an open library, at a quality level sufficient that others can
  reuse and build on top of it, and at a large enough scale that building on top of it allows
  downstream projects to reach the research frontier". It says it is explicitly *not* aiming at
  Bourbaki-style curation: "those are explicitly human activities, and should happen in libraries
  like Mathlib". [S, README "What Tau Ceti is, and is not"]
- **Relation to Mathlib:** it depends on Mathlib `master`, "always defers to design decisions made
  in Mathlib", and "won't push material upstream from Tau Ceti to Mathlib". [S, README]
- **Size and speed.** 23,391 Lean files at the pin; 27,553 on main six days later: 4,437 files
  added and 275 removed between the two. Both commits use Lean `v4.36.0-rc2` and the same Mathlib
  commit `1b1ccf4b`, so all of this growth happened without a Mathlib bump. [R]

## 2. What it says that matters for GLCinLean

### 2.1 Rules for code in Tau Ceti (from `AGENTS.md` at the pin; unchanged on main)

- **Roadmap gate.** "Only add a new mathematical declaration (definition, theorem, instance,
  notation) or file when it advances a specific roadmap target, or supplies a prerequisite that a
  specific target needs. If something you want to build is not on the roadmap — whether a human
  asked for it or you found the gap yourself — select a target supported by the existing roadmaps
  instead." [R]
- **Agents never touch the roadmap repository:** "Never open a PR or an issue in TauCetiRoadmap
  yourself." [R]
- **Refactors are always in scope**, with no roadmap entry needed. [R]
- **Every PR carries a line `Roadmap: CanonicalAreaName` or `Roadmap: none`.** [R]
- **CI forbids** `sorry`, axioms beyond `propext`, `Classical.choice`, `Quot.sound` (so no
  `native_decide`), `meta import`, any `set_option` in library code, metaprogramming
  (elaborators, `#eval`, non-local macros), and Mathlib linter failures (`warningAsError = true`).
  New files are limited to 1000 lines, existing ones to 1500. [R, `AGENTS.md`, `lakefile.toml`]
- **Every file opts into the Lean module system** (a leading `module`, `public import`), checked by
  `lake exe module-system`. [R, `lakefile.toml`; every file read has `module`]
- **No backwards compatibility.** "Tau Ceti does not preserve backwards compatibility. When
  declarations or modules are moved, renamed, replaced, or deleted … remove the obsolete names and
  module paths in the same PR. Do not add or retain … aliases, … deprecated shims." "External users
  of an older revision must update to the canonical API on current `main`." [R]
- **One topic per PR; stacked PRs are prohibited**, including drafts. [R]
- **Merging:** a PR touching only `TauCeti/` merges automatically when CI is green and every rubric
  approves; a forward-only bump of `lake-manifest.json`/`lean-toolchain` can also auto-merge. [S]
  (corrected) The README qualifies this: the infrastructure to fire reviews automatically on each
  PR "is currently switched off. For now, reviews are run from the command line." `AGENTS.md`
  instead says "re-review runs automatically on new commits". [R, both texts; J that they
  disagree]
- **Coordination (corrected):** concurrent agents push only with `--force-with-lease`
  (`COORDINATION.md` §1, `[HARD]`). Two mechanisms are separate: *task claims* are git refs
  `refs/tauceti-claims/<key>` holding a JSON lease, a `[COOP]` "dedup only" mechanism
  (`COORDINATION.md` §3); *intentions* use `leanprover-community/intentions` and the public
  registry `leanprover-community/project-intentions`, which the reference worker
  `TauCetiProject/TauCetiWorker` reads. [R, README and `COORDINATION.md`]
- **Frontier versus foundational (added).** The README: "There is so much 'frontier mathematics'
  … that Tau Ceti can simply disavow interest here … if someone registers a credible intention
  to work on a frontier project, Tau Ceti can make sure the relevant results are not included in
  its roadmaps". It hopes frontier projects "direct their AIs to send the foundational material
  they build to Tau Ceti, and then announce the 'research result' as an independent downstream
  project", and "anticipate[s] that many people working on frontier projects may actually submit
  Tau Ceti roadmaps for them". For "foundational mathematics" it does not wait. [R, README
  "Collaboration"]
- **Versions:** "`vX` is the first commit on `main` whose `lean-toolchain` is `leanprover/lean4:X`";
  tags are made only for Lean releases from `v4.33.0-rc1` on, and published tags never move. An
  hourly updater bumps Mathlib. [R, `docs/toolchain-tags.md`; S, README]
- **What the tags and bumps look like in practice (added).** Ten tags exist, `v4.33.0-rc1`
  (2026-07-31) to `v4.36.0-rc2` (2026-11-02); `v4.35.0-rc1` and `v4.35.0-rc2` have no tag (a
  release main "went past without stopping" is reported `unreachable` and is not tagged). New tags
  also need the commit to lie behind the security-audit cursor, and tag creation is admin-only.
  Mathlib bumps actually landed on 2026-10-22 and 2026-11-02 (the pin itself is the bump commit
  `chore: bump Mathlib to 1b1ccf4b (#26414)`), and none since, despite the "hourly" updater.
  [R, `gh api` tag list and `lake-manifest.json` history, 2026-11-08; `docs/toolchain-tags.md`]

### 2.2 What exists toward the objects of GLC I, Conj. 1.6.7

Paths are under `TauCeti/` and exist at the pin unless marked "main only". All namespaces are
`TauCeti` or `AlgebraicGeometry`. "Builds on" names the Mathlib declarations the file imports or
names in its docstring.

| GLC object | At the pin (`e0610cce`) | New on main (`d2083f0f`) | Builds on Mathlib |
|---|---|---|---|
| **Reductive group over a field** | `reductiveCommHopfAlgProperty k` (Hopf-algebra side; smooth, geometrically connected, no nontrivial connected normal smooth unipotent closed subgroup after base change to `AlgebraicClosure k`), `Algebra/AlgebraicGroup/Reductive/Basic.lean`; `ReductiveAffineGroupSchemeCat k`, `AlgebraicGeometry/AffineGroupScheme/Reductive/Basic.lean`, through an anti-equivalence with Hopf algebras [R] | no change found | `Grp (Over (Spec S))` (Mathlib group objects), `CommHopfAlgCat`, `Algebra.Smooth`, `AlgebraicClosure` [R] |
| **Reductive group over a ring** | `reductiveCommHopfAlgPropertyOver R`, `Reductive/Over.lean` (Conrad Def. 3.1.1) [S] | — | as above |
| **Pinning** | `structure Pinning R H r`, `Algebra/AlgebraicGroup/Pinning/Basic.lean`: reductivity, split maximal torus of rank `r`, a Borel (as a Hopf ideal), and an `R`-linear isomorphism onto each simple root space; simple roots are read off from torus and Borel; base `Spec R` connected [R]. Transport along isomorphisms (`Pinning.comapOfIso`, `Isomorphism.lean`), base change [R]. Pinnings built for GL, SL, Sp [R]. No general existence theorem found [R, grep] | — | `Derivation`, Hopf ideals [R] |
| **Root datum** | Mathlib's `RootPairing`/`RootDatum` are used [R]. Root data constructed only for specific groups: `SplitTorus.coordinateRootDatum`, `diagonalRootDatum` for GL, SL, Sp, PGL [R]. **No root datum of a general split reductive group found** [R, grep] | (corrected) `Algebra/AlgebraicGroup/Chevalley/` (7 files, main only): `DynkinType.ChevalleyDatum` and its `groupScheme` over ℤ (Chevalley's construction from a faithful representation and an admissible lattice), and the *simply connected* Chevalley group scheme `G_sc(t)` = `DynkinType.chevalleyGroupScheme` for each valid Dynkin type (`SimplyConnected.lean`). These are semisimple, not general reductive, groups. `SimplyConnected.lean`'s docstring: "No identification of the resulting group scheme with an independently constructed reductive group is asserted here" [R, docstrings] | `RootPairing`, `RootPairing.flip` [R] |
| **Langlands dual group** | Dual Dynkin types: `DynkinType.dual` (`LinearAlgebra/RootSystem/Duality.lean`) [S]. No dual *group* of a reductive group found [R, grep] | — | `RootPairing.flip` |
| **Root systems, Weyl groups, Lie theory** | Large: `LinearAlgebra/RootSystem/` (Weyl groups, classification, affine Cartan matrices, dual Coxeter number), `Algebra/Lie/` (863 files: highest weight, Killing form, enveloping algebras, Kostant ℤ-forms) [R counts] | grows | Mathlib `RootPairing`, `LieAlgebra` |
| **Curve** | `class IsCurveOver k` (integral, proper, dimension 1), `AlgebraicGeometry/Curves/Basic.lean` [R]; `RegularProperCurveCat`, `RegularProjectiveCurveCat` (`Curves/Category.lean`) [R]; `Scheme.genus` (`Cohomology/Genus.lean`, needs a `FiniteDimensional` instance) [R] | — | `IsProper`, `IsIntegral`, `topologicalKrullDim` [R] |
| **Line bundles** | `InvertibleSheaf X` (`AlgebraicGeometry/LineBundle/Basic.lean`), tensor product, dual, pullback, degree, Serre duality [R] | — | `X.Modules`, `SheafOfModules` [R] |
| **Differentials, ω_X** | `Scheme.relativeDifferentials R X` with universal derivation (`Modules/Differentials/Basic.lean`) [R]; finite locally free for smooth schemes (`LocallyFree.lean`) [S]; **`isInvertible_relativeDifferentials`** for smooth relative dimension 1 and `InvertibleSheaf.relativeDifferentials` (`Rank.lean`; instance argument `[SmoothOfRelativeDimension 1 (X ↘ Spec (.of R))]`) [R, declarations]; canonical divisor, `deg Ω = 2g − 2`, Riemann–Roch (`Canonical.lean`) [S] | — | `PresheafOfModules…relativeDifferentials'`, `KaehlerDifferential`, sheafification [S] |
| **Square root of ω_X** | not found [R, grep] | — | — |
| **Torsors, G-bundles** | fppf quotient `G → G/V(I)` as a torsor (`Algebra/AlgebraicGroup/Fppf/Quotient/Torsor.lean`) [S]; finite-group torsors [R, path]. No general G-torsor over a scheme found [R, grep] | `CategoryTheory/Groupoid/Torsor.lean`, `Algebra/Torsor/Sigma.lean` [R, paths] | — |
| **Stacks** | `SchPseudofunctor` only: an `abbrev` for `Cat`-valued pseudofunctors on schemes (`AlgebraicGeometry/Stack/Basic.lean`, one file) [R]. Algebraic spaces: predicates only (`AlgebraicSpace/Basic.lean`) [S]. (corrected) Quasi-coherent modules as a pseudofunctor, `Descent.qcohPseudofunctor` (`T ↦ QuasicoherentSheaf T`), so that fpqc descent "can be stated as `Descent.qcohPseudofunctor.IsStack Scheme.fpqcTopology`", is already at the pin (`AlgebraicGeometry/Descent/QuasicoherentSheaf.lean`, one file; no `IsStack` theorem in it) [R] | The descent file split into a directory `Descent/QuasicoherentSheaf/` (`Affine`, `Basic`, `Morphisms`); big-site modules, Nisnevich site, `AlgebraicSpace/Category.lean` [R, paths; S for contents] | `Pseudofunctor.IsPrestack`, `Pseudofunctor.IsStack` (Mathlib `CategoryTheory/Sites/Descent/IsStack.lean`) [R] |
| **Bun_G** | not found [R, grep] | not found | — |
| **LS_Ǧ (de Rham local systems), opers** | not found [R, grep]. Topological local systems and DG local systems over the Moore loop space exist (`AlgebraicTopology/DGLocalSystem/`, `LocalCoefficient/`) [S], unrelated to the algebraic stack LS [J] | not found; the opers roadmap is an open roadmap PR (§2.3) | — |
| **D-modules, perverse sheaves** | not found (`DModule`, `D-module`, `Perverse`: zero hits) [R] | (added) No D-modules, but the first ingredient: Grothendieck's differential operators of finite order, `differentialOperators R A M N m` for modules over a commutative `R`-algebra `A`, with composition, order one = derivation plus multiplication, jets (`RingTheory/Derivation/DifferentialOperator.lean`, `PrincipalSymbol.lean`; cites EGA IV §16.8). Ring-level only, not a sheaf of differential operators on a scheme [R, docstring] | `Derivation`, `FilteredAlgebra` [R, imports] |
| **DG categories** | `CategoryTheory/DG/` (35 files): DG categories as categories enriched in cochain complexes, DG functors, homotopy category `H⁰`, quasi-equivalences [S] | Karoubi envelope, twisted functors [R, paths] | Mathlib enriched categories, `CochainComplex.HomComplex` [S] |
| **∞-categories** | `AlgebraicTopology/Quasicategory/` (3 files), DG nerve as a quasicategory (`AlgebraicTopology/DGNerve/`) [S, roadmap STATUS] | 12 more files: `Cat∞` (`CatInfty.lean`), limits, slices, fibrations [S] | `SSet.Quasicategory` [R] |
| **Stable/presentable ∞-categories, IndCoh, QCoh of a stack** | not found [R, grep for `Presentable`, `IndCoh`]. QCoh of a *scheme* exists (`QuasicoherentSheaf T`, an abelian category, not a DG category) [R] | not found; (corrected) on main `Presentable` has 4 hits, all `IsFinitelyPresentable` (objects of ordinary categories, simplicial sets, ring maps), not presentable ∞-categories [R] | — |
| **Triangulated/derived** | Verdier localization facts, `CategoryTheory/Triangulated/` (9 files) [S] | — | Mathlib `DerivedCategory`, `Pretriangulated` [R] |
| **Affine Lie algebras at level κ** | `Algebra/Lie/Current/` (23 files): formal currents `L((t))`, residue central extension (Mathlib's `LieAlgebra.ofTwoCocycle`), vacuum module `V_κ(𝔤)`, completed enveloping algebra `Û_κ`; critical level `κ_c = −h^∨ κ₀` (`Algebra/Lie/Killing/DualCoxeterNumber.lean`); smooth modules (`Algebra/Category/ModuleCat/Smooth/`) [S]. Cites Frenkel, *Langlands Correspondence for Loop Groups* [R] | (corrected) `Algebra/Lie/Current/` goes from 23 to 34 files (12 added, 1 removed): extended affine algebra, normal ordering, module category of `ĝ`, completed modules, vacuum module with vector fields [R, paths] | `LieAlgebra.LoopAlgebra.twoCocycleOfBilinear` (Mathlib `Algebra/Lie/Loop.lean`) [R] |
| **Categorical loop-group actions over local Langlands parameters** | `TauCeti.EquivariantGroupoidLift` (`CategoryTheory/Bicategory/Functor/EquivariantGroupoidLift/`) [S] | grows | Mathlib pseudofunctors, `LocallyDiscrete`, `Cat` [S] |
| **Affine Grassmannian, loop groups G((t)), Hecke/Satake** | not found (the "affine Grassmannian" hits are only citations of Bhatt–Scholze) [R] | not found | — |

### 2.3 The roadmaps behind this code (headings only; read in a separate note)

- Roadmap directories that name GLC-adjacent topics [R, listing @ `fb998610`]:
  `GeometricRepresentationCategories`, `AffineLieAlgebras`, `KacMoody`, `EnhancedDerivedSheaves`,
  `SchemeAndStackFoundations`, `ReductiveGroups`, `ReductiveGroupsPartII`, `ChevalleyGroups`,
  `FlagVarieties`, `SchubertGeometry`, `NilpotentOrbits`, `AlgebraicCurves`, `DGAInfinity`,
  `DerivedModuleAlgebra`, `JacobianChallenge`.
- `GeometricRepresentationCategories` (README, first ~70 lines): coherent transport of smooth
  affine-Lie-algebra module categories at the critical level over the groupoid of opers; "Its
  local Langlands endpoint is the precise categorical-lift conjecture". This is the
  Frenkel–Gaitsgory *local* programme, not global GLC. [R, quote; J for the identification]
- `EnhancedDerivedSheaves` (README, first ~70 lines): dg and quasicategorical enhancements of
  derived categories of sheaves, `Dqc(X)`, `Perf(X)`, presentability, Barr–Beck–Lurie. Its status
  file (2026-11-06) says "No layer is complete". [R]
- `SchemeAndStackFoundations` (README, first ~70 lines): descent, algebraic spaces, torsors,
  algebraic and Deligne–Mumford stacks, Picard stacks. Status (2026-10-25): Layer 0 partial. [R]
- Opers, loop groups and dual opers are planned in the roadmap PR "Formal connections, opers and
  Drinfeld–Sokolov geometry" (`TauCetiRoadmap#1056`), **open, not merged**, updated 2026-11-08. [R]
- I did not see a roadmap item for D-modules, `Bun_G`, `LS_Ǧ`, or `IndCoh_Nilp` in these headings;
  I did not read the roadmaps in full, so this is not proof of absence. [R for what I read; J]
  (added) The separate note `tauceti-roadmaps.md` finds such items in *open* roadmap PRs:
  D-modules on schemes in #1828 (SpringerResolutionAndCharacteristicCycles) and `Bun_G` on a
  curve in #999 (EndoscopicTransferAndUnitaryTraceComparison). I confirmed only that #1056,
  #1828 and #999 are open and unmerged on 2026-11-08, and that #908 (EnhancedDerivedSheaves,
  cited in `Foundations.lean`) is merged. [R for the PR states via `gh api`; contents per that
  note]
- (added) **Roadmaps can be requested, and AI-drafted.** TauCetiRoadmapWorker "plans Tau Ceti
  roadmaps with agents": "Humans file targets on the job board; workers triage them, design the
  roadmaps, write the roadmap packages, review each other's work independently, and port accepted
  packages to TauCetiRoadmap as draft pull requests. Nothing merges into the roadmap repository
  without a human." The job board TauCetiRoadmapJobs: "Humans file targets with the **Target**
  issue template". [R, both READMEs] Who counts as a human filer (for example only the
  TauCetiProject `humans` team) is in `tauceti-contributing.md`, not re-checked here.

### 2.4 How GLCinLean uses it today

- `GLCinLean/Foundations.lean` imports four Tau Ceti modules:
  `AlgebraicGeometry.AffineGroupScheme.Reductive.Basic`, `Algebra.AlgebraicGroup.Pinning.Basic`,
  `AlgebraicGeometry.LineBundle.TensorProduct`, `AlgebraicGeometry.Modules.Differentials.Basic`.
  All four still exist on main, and the four names it uses (`ReductiveAffineGroupSchemeCat`,
  `Pinning`, `InvertibleSheaf`, `relativeDifferentials`) still occur there. [R]
  (corrected) It uses more than four Tau Ceti names: also `FiniteTypeCommHopfAlgCat`,
  `finiteTypeCommHopfAlgCatOpEquivFiniteTypeAffineGroupSchemeCat`,
  `reductiveCommHopfAlgProperty_iff`, `reductiveAffineGroupSchemeProperty_iff` and
  `InvertibleSheaf.tensorProduct`. Each is still declared on main (grep for the declaration;
  nothing was built). [R]
- The Tau Ceti dependency is `rev = "v4.36.0-rc2"` in `lakefile.toml`, with the comment "Mathlib
  comes through Tau Ceti. Bumps are the owner's decision." [R]
- The surface placeholders `RootDatumDuality`, `DmodHalf`, `QCohLS`, `IndCohNilp`, `Psi`,
  `LCoarse` are in `Abstract.lean`; `DGCat`, `LinFun`, `LinIso` and their predicates are in
  `Foundations.lean`. The curve in `Abstract.lean` carries
  `[SmoothOfRelativeDimension 1 (X ↘ SpecField k)]` and `[IsProper (X ↘ SpecField k)]`, which is
  the instance `InvertibleSheaf.relativeDifferentials` asks for (if `SpecField k` unfolds to
  `Spec (.of k)`, not checked). [R for the texts; E for the match]
- `canonicalSheaf` is defined as an `X.Modules` (`relativeDifferentials`), not as a line bundle,
  although Tau Ceti has `InvertibleSheaf.relativeDifferentials` for smooth curves. [R]
- `Foundations.lean` does not use Tau Ceti's file conventions (no `module`, plain `import`,
  different header). [R]

## 3. What it means for GLCinLean

- **Source order (ideas.md §3).** Tau Ceti supplies most of the *base data* of the statement:
  reductive group, pinning, curve, line bundles, ω_X, and much Lie theory, all built on Mathlib's
  carriers (`Grp (Over (Spec k))`, `X.Modules`, `RootPairing`). The *surface objects* (Bun_G,
  LS_Ǧ, D-modules, QCoh/IndCoh on stacks, presentable DG categories) are absent at the pin and on
  main. [R for presence/absence by grep; J for the split]
- **Library goal (ideas.md §1).** The missing objects are exactly geometric representation theory.
  Tau Ceti's own representation-theoretic work points at *local* geometric Langlands (Kac–Moody at
  the critical level, opers), which is adjacent and reusable but does not cover the global objects.
  [J]
- **Tau Ceti contributions (ideas.md §4; decision "Tau Ceti contributions are fully automated").**
  Automation is possible only for items on an existing roadmap. For anything else, Tau Ceti tells
  agents to pick a different target, and code agents may never open roadmap PRs or issues.
  (corrected) A GRT roadmap need not be hand-written, though: a human files a target on
  TauCetiRoadmapJobs, AI roadmap workers draft it and open a draft PR, and a human merges it. The
  human steps (filing, merging) cannot be automated by this project. [R for the rules; J for the
  consequence]
- **Frontier material (added).** By the README's own split, the GLC statement and proof are
  frontier mathematics, which Tau Ceti "can simply disavow interest" in; the foundations (D-modules,
  stacks, IndCoh) are what it wants contributed. This matches ideas.md §4 (foundations to Tau Ceti,
  the rest here) and suggests registering GLCinLean as a frontier project in
  `project-intentions`. [R for the README; J]
- **Keeping up (decision "Keeping up with Mathlib and Tau Ceti is fully automated").** Tau Ceti
  removes and renames without deprecations, and changed by about 4,400 files in six days, so each
  bump may break GLCinLean's imports and names. The automated bump has to include repair, not just
  `lake update`. Tags exist only per Lean release, so following tags means bumping rarely and
  jumping far; following main means frequent small repairs. [R for the rules and counts; E/J for
  the consequence] (added) The ten tagged commits are 1 to 25 days apart (commit dates
  2026-07-31 to 2026-11-02; tag creation dates not checked), and some Lean releases got none
  (`v4.35.0-rc1`, `-rc2`). Moving GLCinLean to current main today would not change Mathlib,
  because no Mathlib bump has landed since the pin. [R for the dates; J]
- **Plan step 2 (blueprint).** The table in §2.2 is a first draft of "each object mapped to Mathlib,
  Tau Ceti, a roadmap item, or missing". Because Tau Ceti moves fast, the mapping should record
  the Tau Ceti commit it was checked at and be refreshed at every pin bump. [J]
- **Code style for later migration (ideas.md §4: "write the Tau Ceti version").** Code written
  here that is meant to move into Tau Ceti later is cheaper to move if it already follows Tau
  Ceti's conventions: `module`, `public import`, the copyright header, no `set_option`, no
  `sorry`, ≤ 1000 lines per new file. [R for the rules; J]
- **Placeholders.** Tau Ceti's CI and roadmap gate rule out placeholders, `sorry`s and the
  ReviewKit attribute (meta code, a non-Mathlib dependency) inside Tau Ceti. So
  `@[placeholder]` objects can only live in GLCinLean. [R for the rules; J]

## 4. Conflicts

- **ideas.md §3: "Stacks's code may never be needed, as Tau Ceti has enough."** Tau Ceti does not
  have enough for the surface of GLC: no algebraic stacks beyond a carrier `abbrev`, no Bun_G, no
  D-modules, no LS, no IndCoh. Whether Stacks has them is for the Stacks note. [R for Tau Ceti's
  absence by grep; J]
- **ideas.md §4: writing a GRT roadmap.** Tau Ceti `AGENTS.md`: agents must "never open a PR or an
  issue in TauCetiRoadmap", and must not build off-roadmap mathematics in Tau Ceti "whether a human
  asked for it or you found the gap yourself". (corrected) So a roadmap needs a human step: the
  owner (or another human) writes and posts it, or files a target on TauCetiRoadmapJobs for the
  AI roadmap workers; a human merges in either case. The owner already notes "I might not be able
  to review a roadmap fully". [R for the rules; J for the routes]
- **workflow.md decision "Tau Ceti contributions are fully automated".** This holds only for parts
  a roadmap covers. Today that is mainly base material (reductive groups, curves, stacks
  foundations, enhanced derived sheaves), not the GLC surface. [J]
- **`AGENTS.md` "`lake update` … best left to the owner" and `lakefile.toml` "Bumps are the
  owner's decision"** conflict with the automated-bump decision, and Tau Ceti's no-compatibility
  rule makes manual, rare bumps more expensive. (corrected) Only the `AGENTS.md` text is listed
  under "Known conflicts" in workflow.md; the `lakefile.toml` comment is a further conflict not
  listed there. [R for the texts; J]
- **Tau Ceti README vs Tau Ceti `AGENTS.md` (added):** automatic review is "currently switched
  off" (README) versus "re-review runs automatically on new commits" (`AGENTS.md`). An automated
  contributor should not assume reviews arrive by themselves. [R; J]
- **`Foundations.lean`, comment on DG categories:** "No provider has this enhanced theory yet".
  This is still true in the strong sense (presentable stable k-linear DG categories), but Tau Ceti
  does have plain DG categories, quasi-equivalences and quasicategories, which the blueprint
  should mention when it decides what `DGCat` becomes. [R for the comment and Tau Ceti files; J]
- **Tau Ceti README vs ideas.md §1 (Xena, "defer to human-curated libraries").** Tau Ceti says it is
  itself not a curated library, and that curation belongs in Mathlib-like human libraries. Building
  on it is consistent with Xena's "defer to Mathlib", but Tau Ceti code is AI-reviewed only, so it
  does not carry Mathlib's level of human audit. [S for Tau Ceti's claim; J]

## 5. Input for the open questions (workflow.md, "Questions for after the research")

- **What goes into `AGENTS.md`.** Suggest three short facts: (a) the source order Mathlib → Tau
  Ceti → Stacks, with "search Tau Ceti main, not only the pin, before writing anything"; (b) Tau
  Ceti removes names without deprecations, so a pin bump includes repairing imports and names;
  (c) contributions to Tau Ceti follow Tau Ceti's own `AGENTS.md` and need a roadmap target. These
  are the facts an agent here cannot guess and gets wrong otherwise. [J]
- **Whether `PLAN.md` is needed.** The object-to-provider mapping (§2.2) changes with every Tau Ceti
  bump, so it needs a home that prompts can point to and that carries the Tau Ceti commit it was
  checked at. That can be the blueprint rather than `PLAN.md`. [J]
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.**
  - The base layer is sound: it re-exports real Tau Ceti objects, and those still exist on main.
    [R]
  - `RootDatumDuality` as a placeholder is justified: no general root datum of a reductive group
    exists in Tau Ceti. [R by grep]
  - Two adapter improvements: `canonicalSheaf` could be the line bundle
    `InvertibleSheaf.relativeDifferentials`, and the curve hypotheses could be compared with Tau
    Ceti's `IsCurveOver`. [R for the names; J]
  - The surface placeholders (`DmodHalf`, `QCohLS`, `IndCohNilp`, `DGCat`) have no provider in Tau
    Ceti at the pin or on main, so the placeholders remain needed. [R by grep; J]
- **What happens to the ReviewKit requirement and `@[placeholder]`.** Tau Ceti has no counterpart,
  and its CI would reject such meta code in library files. If GLCinLean code is to migrate into
  Tau Ceti, placeholders must stay in GLCinLean-only files (as now, in `Foundations.lean` and
  `Abstract.lean`). [R for Tau Ceti's rules; J]
- **Who reviews the mathematics.** For the parts contributed to Tau Ceti, Tau Ceti's adversarial
  AI rubrics review them; its README says AI-formalised definitions are "a priori,
  untrustworthy". For GLCinLean's own code nothing outside is provided. Tau Ceti's model of
  trust (human roadmaps, AI review, trust from building theory on top) is one option to compare
  with. [S; J] (added) The README also says the automatic per-PR review "is currently switched
  off" and reviews are run from the command line (`tauceti-review`), so a contributor may have to
  trigger or run the review itself. [R; J]

## 6. Questions for the owner

1. **Pin policy.** The pin (`v4.36.0-rc2`, 2026-11-02) is already about 4,400 files behind main.
   Should the automated bump follow Tau Ceti's Lean-release tags (rare, large jumps) or main
   commits (frequent, small repairs)?
2. **Roadmap for geometric representation theory.** No merged roadmap I read covers D-modules,
   Bun_G, LS_Ǧ or IndCoh (open PRs #1828 and #999 touch D-modules on schemes and Bun_G), and
   Tau Ceti code agents may not open roadmap PRs. Will you write a roadmap yourself, file a
   target on TauCetiRoadmapJobs so that AI roadmap workers draft one (a human still merges), or
   keep those parts in this repository?
3. **Tau Ceti style here.** Should code in this repository that may later move to Tau Ceti be
   written in Tau Ceti's conventions from the start (module system, `public import`, header, no
   `set_option`, ≤ 1000-line files)?
4. **Intentions.** Tau Ceti's worker reads intentions (`leanprover-community/intentions`, public
   registry `project-intentions`); task claims are separate git refs. Should this project register
   intentions publicly when it starts on a roadmap item, or register GLC as a frontier project, which
   by the README would keep GLC-specific results out of Tau Ceti's roadmaps, so that others do not
   duplicate the work?
