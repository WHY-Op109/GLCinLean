# Stacks and Moduli in Lean (JarodAlper/stacks-and-moduli)

- Source: <https://github.com/JarodAlper/stacks-and-moduli>, read at commit
  [`b3699d1342bfd3344b69d5299bf4b905c1e40afb`](https://github.com/JarodAlper/stacks-and-moduli/tree/b3699d1342bfd3344b69d5299bf4b905c1e40afb)
  (2026-09-23, "Add formalization.yaml and Reservoir package metadata"). This is still the head
  of `main`: the repository has 3 commits, 0 issues and 0 pull requests, and was last pushed
  2026-09-23 [R: `gh api`]. Cloned (shallow, head commit only) to
  `.lake/research/stacks-and-moduli/`.
- Read: `README.md`, `formalization.yaml`, `lakefile.toml`, `lean-toolchain`,
  `lake-manifest.json`, `.github/workflows/`, `stacks-project-lean/README.md`, all of
  `StacksAndModuli/mwe/AlgebraicSpacesAndStacks.lean`, and the parts named below of the
  principal-bundle, classifying-stack, quotient-stack and quasi-coherent files (including
  `Section3.1-Descent/part3.1.2-descent-quasi-coherent.lean` around its `sorry`s and
  `API/CoreCoGrothendieckStack.lean`). I did not read most of the ~1,200 files, and I did not
  build the library, so no axiom list here was recomputed.
- Not read: the book draft *Stacks and Moduli* (<https://sites.math.washington.edu/~jarod/moduli.pdf>).
  Nothing below says what the book contains beyond what the repository says about it.
- Checked 2026-11-08.
- Licence: Apache-2.0 for the Lean code (same as GLCinLean, Mathlib and Tau Ceti). Statements
  quoted or paraphrased from the Stacks Project in `stacks-project-lean/` are under the GFDL 1.2
  or later [R: `README.md`, `stacks-project-lean/README.md`]. Copying from `StacksAndModuli/` is
  allowed with the notice kept; copying docstrings from `stacks-project-lean/` brings GFDL text
  with it [J].

Tags: [R] read directly, [S] the source's claim about itself, [E] my estimate or count with
grep, [J] judgement. All dated 2026-11-08.

## 1. What it is

- A Lean 4 library on Mathlib that formalises the labelled statements of Jarod Alper's book
  draft *Stacks and Moduli*: "The aim is to state every labelled definition, lemma, proposition,
  theorem, and corollary of the book faithfully, with the same hypotheses and conclusions at the
  book's level of generality, and to prove as many of them as possible" [S: README].
- Written by agents: "written entirely by AI coding agents with very little supervision, so
  expect misformalizations" [S: README]. `formalization.yaml` names Claude Code and OpenAI Codex,
  "work from the two frameworks was merged by hand", and "Model versions, wall time and spend
  were not recorded" [S].
- Review: `review.status: "unchecked"`, no reviewers; "No systematic audit of fidelity against
  the book has been carried out, and misformalizations are expected" [S: `formalization.yaml`].
  Jarod Alper is listed as author and maintainer with `author_endorsement: "participated"` [S].
- Size and state [S: `formalization.yaml`]: 203 labelled items of the book and 37 Stacks Project
  tags; "93 theorems still contain a sorry (31 files)"; `sorry_in_definitions: 0`; about 346,000
  lines in 1,169 files plus about 11,000 lines for the Stacks tags. My counts: 1,169 files under
  `StacksAndModuli/`, 37 under `stacks-project-lean/`, about 357,000 lines in total; the word
  `sorry` appears 103 times in 36 files, comments included; the code-level ones are 93, all
  inside `theorem`s and none inside a `def`, `instance` or `structure`, which matches the
  file's 93 and its `sorry_in_definitions: 0` [E: grep, rechecked 2026-11-08].
- Coverage: book sections 2.1–2.5 (Hilbert, Quot, Grassmannians), 3.1–3.5 (descent, sites,
  sheaves, prestacks, stacks), 4.1–4.9 (algebraic spaces and stacks, their properties), 6.1–6.5
  (nodal and stable curves, `M̄_g`), A.4 and A.6 [S: README].
- Pins: Lean `v4.34.0-rc1`, Mathlib `de5ce8a9` (tag `v4.34.0-rc1`); no Tau Ceti [R:
  `lean-toolchain`, `lake-manifest.json`]. GLCinLean is at Lean `v4.36.0-rc2` with Mathlib
  `1b1ccf4b` and Tau Ceti `e0610cce` [R: GLCinLean's `lean-toolchain`, `lake-manifest.json`].
- CI: `lean_action_ci.yml`, a release-tag workflow, and `update.yml` (the
  `mathlib-update-action`) whose `schedule:` is commented out, so updates run only by hand
  [R: `.github/workflows/`].

## 2. What it says that matters for GLCinLean

### 2.1 The stack formalism: categories fibred in groupoids over Mathlib's `BasedCategory`

- A prestack is a functor `p : 𝒳 ⥤ 𝒮` with a new class
  `CategoryTheory.Functor.IsFiberedInGroupoids` (lifts exist; every morphism is strongly
  cartesian). Stacks are a new class `CategoryTheory.Functor.IsStack p J` (morphisms glue
  uniquely; descent data over a covering sieve are effective), and
  `CategoryTheory.BasedCategory.IsStack J 𝒳` bundles both [R:
  `StacksAndModuli/Section3.5-Stacks/part3.5.1-the-definition.lean:69,133`; same text in
  `mwe/AlgebraicSpacesAndStacks.lean:270,303`].
- Mathlib (at GLCinLean's pin) has `BasedCategory`, `IsHomLift`, `IsStronglyCartesian` and
  `Pseudofunctor.IsStack` (`Sites/Descent/IsStack.lean:49`), but no `IsFiberedInGroupoids` and no
  stack condition for fibred categories [R: grep of `.lake/packages/mathlib`].
- The library uses both sides: its own `BasedCategory.IsStack` for `BG`, `[U/G]` and algebraic
  stacks, and Mathlib's `Pseudofunctor.IsStack` for quasi-coherent modules
  (`API/QuasicoherentFamilyStacks.lean:32`, `isStack_familyModulesPseudofunctor`) [R].
- **There is a one-way bridge** between the two [R]: `API/CoreCoGrothendieckStack.lean`
  proves that the Grothendieck construction of a `Cat`-valued pseudofunctor satisfying
  Mathlib's `Pseudofunctor.IsStack` (after taking the pointwise core) is a
  `BasedCategory.IsStack` (`forgetBasedCategoryIsStack`, l. 1073;
  `coreForgetBasedCategoryIsStack`, l. 1092). The file has no `sorry` [R]; its axioms were not
  checked [not built]. I did not find the converse direction [J; not searched exhaustively].
  This matters because Tau Ceti's stacks are pseudofunctors of the same shape (§4) [J].

### 2.2 Algebraic spaces and stacks (Alper's definitions, `mwe/AlgebraicSpacesAndStacks.lean`)

- `AlgebraicGeometry.IsAlgebraicSpace (X : Scheme.{u}ᵒᵖ ⥤ Type u)`: a sheaf for
  `Scheme.etaleTopology` with a scheme `U` and `yoneda.obj U ⟶ X` in
  `MorphismProperty.presheaf (Surjective ⊓ Etale)` (Definition 4.1.2) [R].
- `IsDeligneMumfordStack` and `IsAlgebraicStack` on `BasedCategory Scheme.{u}`: an étale stack
  with a surjective, étale (resp. smooth), representable morphism from a scheme (Definitions 4.1.4,
  4.1.6). No condition on the diagonal: "as shown in Theorem 4.2.1, the existence of a smooth
  presentation already implies the representability of the diagonal, so no condition is imposed
  here" [R: docstring]. Theorem 4.2.1 (`IsAlgebraicStack.representable_diag`) is listed as
  proved without `sorry` [S: `formalization.yaml`].
- Everything lives over the absolute big category `Scheme.{u}` with the étale topology, not over
  a base `Sch/k` [R].
- The mwe file is self-contained, imports only Mathlib, has no `sorry`, and is "not meant to be
  imported together" with the library because it reuses the same names [R: module docstring].

### 2.3 Principal bundles, `BG` and quotient stacks: the parts closest to `Bun_G`

- Two principal-bundle structures [R]:
  - `AlgebraicGeometry.Scheme.PrincipalBundle` (`API/PrincipalBundle.lean`, 85 lines): `G` a
    group object of `Over X`, `P ⟶ X` flat, surjective, locally of finite presentation, with
    `IsIso (ModObj.leftSMul G P)`; it is stable under pullback.
  - `GlobalPrincipalBundle G T` (`API/GlobalPrincipalBundle.lean:277`): `G` a group object of
    `Over S`, `p : P ⟶ T` over `S`, invariant, flat, surjective, locally of finite presentation
    **and smooth**, with `IsIso (ModObj.torsorMap p invariant)`. "This is the form used by the
    classifying and quotient prestacks."
- `classifyingPrestack G : BasedCategory (Over S)`: objects are bundles over varying
  `S`-schemes, morphisms are equivariant cartesian squares; it is fibred in groupoids
  (`API/ClassifyingPrestack.lean:85,98`). `actionQuotientPrestack G U` is the analogue for
  `[U/G]` (l. 253) [R].
- **The headline stack property is not proved.** Proposition 3.5.13
  (`prop:quotient-stack-is-a-stack`, for `G → S` smooth and affine):
  `isStack_actionQuotientPrestack_fpqc` and `isStack_classifyingPrestack_fpqc` are `sorry`
  (`Section3.5-Stacks/part3.5.3-classifying-stacks-and-quotient-stacks.lean:66–72, 99–104`); the
  étale versions are derived from them [R]. What is proved are reductions,
  `actionQuotient_isStack_fpqc_of_underlyingGluing` (l. 29) and
  `classifyingPrestack_isStack_fpqc_of_underlyingGluing` (l. 53), which take the gluing of
  total spaces as a hypothesis (`API/ActionQuotientFpqcStack.lean`) [R]. The morphism half of
  the stack axioms comes from a separate lemma (`ActionQuotientPrestackMorphisms.morphismsGlue_fpqc`)
  whose axioms I did not check [R statement used; not built].
- **Docstrings overstate the status.** The docstring of the sorried
  `isStack_actionQuotientPrestack_fpqc` says "The Lean proof works directly with arbitrary fpqc
  covering sieves: morphisms glue by …, while objects are reduced to effective descent …",
  although the body is `sorry` [R: part3.5.3, ll. 55–72]. Proof status in this library has to be
  read from `#print axioms` (as `formalization.yaml` does for its main results), not from
  docstrings [J].
- Theorem 4.1.10 (`isAlgebraicStack_quotientPrestack_ofAction`): a stackification of the
  quotient prestack of a smooth group scheme action is an algebraic stack; listed as proved
  [S: `formalization.yaml`; R: statement at `part4.4.4-algebraicity.lean:376`]. Its group action
  is passed unbundled, as about seventeen maps and axioms (`πG`, `m`, `eG`, `ι`, `σ`, `hm_assoc`,
  …), not as Mathlib's `GrpObj`/`ModObj` used in `API/` [R]. The docstring says the book's
  affineness hypothesis "is not needed" and points to unpublished COMMENTARY notes [R].
- Vector bundles: the statement that vector-bundle families on `X ×_S T` form an étale stack
  over `Sch/S` is there (`isStack_vectorBundleFamilyPseudofunctor_etale`,
  `API/QuasicoherentFamilyStacks.lean:183`) [R], **but its proof rests on a `sorry`** [R, by
  following the proof terms; not built]: it uses `isStack_familyModulesPseudofunctor_etale` →
  `isStack_familyModulesPseudofunctor` → `isStack_quasicoherentPseudofunctor` (fpqc descent of
  quasi-coherent sheaves, `Section3.1-Descent/part3.1.2-descent-quasi-coherent.lean:1220`), and
  that one uses `isStack_quasicoherentPseudofunctor_zariskiTopology` (l. 1143), whose body is
  `sorry` ("Deferred input for Proposition 3.1.4 (the Zariski half …)"). The same file has
  further sorried "deferred inputs" (ll. 1021, 1099, 1120). So even fpqc descent of
  quasi-coherent sheaves, the base of everything in this section, is not yet sorry-free. With
  that caveat, this is the stack of vector bundles on `X`, which is the `GL_n` case of `Bun_G`
  before algebraicity [J].
- **Absent** [R: grep for `Bun`, mapping and Hom stacks, Weil restriction, reductive, derived,
  D-modules, perverse]: `Bun_G` for a curve, mapping stacks, algebraicity of `BG` via the
  principal-bundle prestack (the algebraicity results go through action groupoids), anything
  derived or ∞-categorical, quasi-coherent sheaves on an algebraic stack as a category, D-modules.

### 2.4 Conventions worth knowing

- Fidelity convention: "A declaration whose docstring opens with the book's number and label,
  such as **Proposition 3.1.1** (`prop:descent-modules`), is the designated faithful statement of
  that result. Everything else in a file is supporting material." "Numbering follows the draft of
  the book … and may drift as the book is revised; the LaTeX label is the stable key" [S: README].
- Agent rule: agents were told "to record any change of statement or proof route in commentary
  notes, and never to strengthen hypotheses or weaken conclusions to make a proof go through"
  [S: `formalization.yaml`]. The STATUS, COMMENTARY and INSIGHTS notes "are not part of this
  repository", although docstrings refer to them [S: README]. Nor are the "agent guide and a
  style guide" the agents worked from (`formalization.yaml`, `tool_setup`); `lakefile.toml`
  cites a `STYLE.md` that is not in the repository [R: root listing]. So its prompts cannot be
  reused or checked.
- Metadata: `formalization.yaml` (standard `mathlib-initiative/formalization.yaml`, v0.4) records
  sources, automation, fidelity, review status, axioms per main result and a source↔Lean
  alignment table [R]. Tau Ceti has a `formalization.yaml` too (v0.2) [R: Tau Ceti root at
  GLCinLean's pin]. I did not read the standard itself.
- Style departures from Mathlib [R, counts E]: book-shaped paths with guillemet module names
  (`StacksAndModuli.«Section4.1-Definitions».«part4.1.4-algebraicity-of-mg»`); an almost flat
  `API/` of 1,030 files (1,021 at its top level); no copyright headers;
  `set_option backward.isDefEq.respectTransparency false` file-wide in 965 files and scoped
  (`… in`) 233 more times, plus the `.types` variant file-wide in 968 files; `set_option
  maxHeartbeats` raised 193 times (186 scoped, 7 file-wide), plus 91 raises of
  `synthInstance.maxHeartbeats`; declarations in Mathlib's own namespaces
  (`CategoryTheory.Functor.IsFiberedInGroupoids`, `AlgebraicGeometry.IsAlgebraicSpace`). On the
  other side, `lakefile.toml` turns on `weak.linter.mathlibStandardSet = true` [R].
- Internal duplication [R]: two principal-bundle structures (2.3), two encodings of a group
  action (2.3), two stack notions (2.1), and the same lemma
  `etaleTopology_over_le_fpqcTopology_over` in `API/QuasicoherentFamilyStacks.lean:46` and
  `API/ActionQuotientFpqcStack.lean:72` (different namespaces).

## 3. What it means for GLCinLean

- **`Bun_G` is the gap it touches, and only part of it** (blueprint, workflow step 2). The
  current `Abstract.lean` has no `Bun_G`; it sits inside the placeholder `DmodHalf` [R:
  `Abstract.lean:82–84`]. This library would help only with the classical layer under that
  placeholder: torsors, `BG`, stack axioms, algebraicity. It gives nothing for `Dmod_{1/2}`,
  `QCoh(LS_Ǧ)` or `IndCoh_Nilp`, which need DG categories [J].
- **Design reference, not dependency** (ideas.md §2 "Code quality", §3 "Order of sources").
  It cannot be a Lake dependency: it pins Lean `v4.34.0-rc1`, GLCinLean `v4.36.0-rc2`, and a build
  has one Mathlib [R pins; J]. Its own review status is "unchecked" and it expects
  misformalizations [S], so nothing from it meets "Set standards, and meet them" without review
  [J]. It is useful as (a) a worked design of torsors and `BG` on top of Mathlib's
  `GrpObj`/`ModObj` and `BasedCategory`, and (b) a list of the lemmas the classifying stack
  needs, with an honest map of which are still `sorry` [J].
- **Tau Ceti first.** Tau Ceti's SchemeAndStackFoundations roadmap covers `BG` (§1.18) and
  quotient stacks (§1.21), with Layers 1–3 untouched on 2026-10-25 [taken from the sibling note
  `tauceti-roadmaps.md`, which marks it R; not re-read here]. Under the decision "parts that a Tau Ceti roadmap covers: contribute
  to Tau Ceti" (ideas.md §4), principal bundles and `BG` belong in Tau Ceti PRs, and this
  library is at most a reference for writing them [J].
- **Three different definitions of algebraic stack** among the candidate sources (see §4). The
  blueprint (step 2) must pick one carrier before any `Bun_G` work. This source adds weight to the
  fibred-category side, since both it and AxiomMath/Stacks use `BasedCategory` [J]. The carriers
  are not wholly unrelated: this library's sorry-free bridge from Mathlib's pseudofunctor stacks
  to fibred-in-groupoids stacks (§2.1) shows one direction can be written on Mathlib, which
  softens the choice somewhat [J]. The definitions (sites, diagonal conditions) still differ.
- **A fidelity convention GLCinLean can copy** (ideas.md "Link to the existing literature"): the
  docstring opens with the paper's number and its LaTeX label, the label being the stable key.
  The owner already wants to work from the TeX sources (ideas.md §5), so GLC I labels such as the
  one for Conjecture 1.6.7 are at hand [J].
- **A warning about hidden notes** (ideas.md "Review additions publicly", "Document and
  organize"). Its decisions on deviations live in unpublished COMMENTARY files, so the
  `[deviation]` remarks in docstrings cannot be checked. GLCinLean should commit its decision and
  deviation notes [J].
- **What "very little supervision" produces at scale**: 350,000 lines with duplicated structures,
  root-namespace declarations and widespread transparency and heartbeat overrides. It is a
  counterexample to the Xena principles "Avoid duplication" and "Set standards, and meet them",
  and it supports the owner's plan for a review system before building at scale [J].

## 4. Conflicts

- **With ideas.md §3 (order of sources):** the library is not in Mathlib > Tau Ceti > Stacks [R:
  ideas.md]. Using it in any way beyond reading is an owner decision.
- **With ideas.md "Stay up to date":** pinned two Lean releases behind GLCinLean, with the update
  workflow's schedule disabled and no push since 2026-09-23 [R]. Copied code would need porting
  [J].
- **With ideas.md §2 (Mathlib style):** file layout, missing headers, global
  `backward.isDefEq.respectTransparency false`, root namespaces and duplication (§2.4) [R].
- **With Tau Ceti:** `TauCeti.AlgebraicGeometry.IsAlgebraicSpace` is "a sheaf for the fppf
  topology, its diagonal is representable by schemes, and it admits an étale atlas (Stacks,
  Definition 65.6.1 (025Y))" [R: `TauCeti/AlgebraicGeometry/AlgebraicSpace/Basic.lean:195`]. This
  library uses an étale sheaf and an atlas representable by schemes, with no diagonal condition
  [R]. The two are expected to agree mathematically, but proving that is real work [J]. Tau Ceti's
  stacks are `Cat`-valued pseudofunctors (`SchPseudofunctor`, `Stack/Basic.lean:37`) [R]; this
  library's are fibred categories.
- **With AxiomMath/Stacks:** Stacks' `AlgebraicGeometry.Stack.IsAlgebraicStack` (`@[stacks 026O]`)
  is a `BasedCategory` over `BigFppfOver B S hS`, a site built from a `BigFppfSite`, with the
  diagonal representable by algebraic spaces and a smooth surjective atlas [R: Stacks at
  `5ed82d14`, `StacksFrontier/AlgebraicGeometry/Stacks/AlgebraicStack.lean:99`; "cardinal-bounded"
  is from the sibling note `stacks.md`, not re-read]. This library's are over `Scheme.{u}` with
  the étale topology and no diagonal condition [R]. Same carrier family (fibred categories),
  different sites and definitions [J].
- **Name clash with AxiomMath/Stacks** [R]: both define `CategoryTheory.Functor.IsFiberedInGroupoids`
  and `CategoryTheory.Functor.IsStack` (Stacks: `StacksCore/CategoryTheory/FiberedInGroupoids.lean:57`,
  `StacksFrontier/CategoryTheory/Sites/Descent/IsStack/Defs.lean:44`). The two libraries cannot be
  imported into one build without renaming, and a definition copied from one next to the other
  would collide [J]. If Mathlib later adds these names, both clash with it too [J].
- **With the search finding that prompted this note:** it says the library has "principal
  bundles with fpqc descent". Descent lemmas exist, but the stack property of `BG` and `[U/G]`
  (Proposition 3.5.13) is `sorry` at the pinned commit, and fpqc descent of quasi-coherent
  sheaves rests on a sorried Zariski gluing lemma (§2.3) [R]. Also, Mathlib has no
  `IsFiberedInGroupoids`; the library defines its own [R].

## 5. Input for the open questions (notes/workflow.md)

- **What goes into `AGENTS.md`.** Two rules from this source fit a short `AGENTS.md`: "never
  strengthen hypotheses or weaken conclusions to make a proof go through; record any change of
  statement", and "a designated statement's docstring opens with the paper's number and LaTeX
  label" [S rule; J fit]. Its failure modes (duplication, root namespaces, global option
  overrides) suggest one more line: no new structure if an equivalent one exists, and no
  `set_option backward.*` or raised heartbeats without a recorded reason [J]. Its docstrings
  that describe proofs which are still `sorry` (§2.3) suggest a further one: a docstring says
  nothing about proof status; status comes from `#print axioms` or the review system [J].
  Its own agent guide and style guide were never published (§2.4), so there is nothing of it
  to reuse for GLCinLean's `AGENTS.md` beyond these quoted rules [R absence; J].
- **Whether `Abstract.lean`, `Foundations.lean` and their placeholders are reasonable.** This
  library keeps `sorry_in_definitions: 0` and has real definitions everywhere [S]. That is the
  same principle as AGENTS.md's "an `axiom`, or a definition with a trivial witness, would make
  the statement say less". It suggests keeping placeholders where no definition can yet be
  written (`DmodHalf`, `DGCat`), and making `Bun_G`, once it appears, a real definition (the
  groupoid of `G`-torsors on `X × T`), because the classical layer can already be written over
  Mathlib [J].
- **What happens to each existing file.**
  - `references/papers/manifest.toml`: the source warns that numbering "may drift as the book is
    revised; the LaTeX label is the stable key" [S]. A record of which arXiv version a label comes
    from is still needed. It could be one line per paper in `AGENTS.md` or `README.md` rather
    than a manifest file [J].
  - `glc/project.toml`: it already plans a `stacks` closure class for copied Stacks code [R]. If
    anything from this library is ever copied, it needs its own class, kept apart from the
    `stacks` class [J].
  - Its `formalization.yaml` (also used by Tau Ceti) carries the metadata a review web page needs:
    fidelity, review status, axioms per main result, source↔Lean table. It is a candidate format
    for the new review system's input or output [J].
- **Who reviews the mathematics, and to what standard.** The library shows the result of agent
  work with no review: its own maintainer expects misformalizations [S]. For definitions such as
  torsors, `BG` and `Bun_G`, fresh-agent review alone may not be enough, and an outside expert in
  stacks would add real assurance [J]. A cheap first check any reviewer can run is `#print axioms` on each claimed
  result: here it would expose the vector-bundle stack (§2.3), whose docstring gives no hint of
  the upstream `sorry` [J].
- **Where research notes and session summaries live.** Its STATUS/COMMENTARY/INSIGHTS notes were
  left out of the public repository, and as a result its documented deviations cannot be
  checked [S, J]. This argues for committing GLCinLean's decision and deviation notes [J].

## 6. Questions for the owner

1. Is this library allowed as a source at all, given that it is outside Mathlib > Tau Ceti >
   Stacks? Options: (a) read-only design reference (my suggestion [J]); (b) copy single,
   re-reviewed definitions with a provenance header; (c) never consult it.
2. If code from it is copied, whether into GLCinLean or into a Tau Ceti PR, must it first pass the
   same review as new code? And is porting AI-written, unreviewed external code acceptable to Tau
   Ceti at all? (Not checked against Tau Ceti's contribution rules here.)
3. Do you want to contact Jarod Alper, for example about whether the library is maintained, its
   plans for Mathlib or Tau Ceti? Contacting
   people is your decision under the current PLAN.md "quiet phase" (PLAN.md's future is itself
   open in notes/workflow.md, and none of the new decisions there automates contacting people).
4. Should GLCinLean adopt `formalization.yaml` (as Tau Ceti and this library do) for its own
   metadata, and should the new review system read or produce it?
