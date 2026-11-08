# AxiomMath/Stacks (the Stacks Project in Lean)

- Source: <https://github.com/AxiomMath/Stacks>, read at commit
  [`5ed82d14634e8d9576bb844c7bd4e3da66d450e7`](https://github.com/AxiomMath/Stacks/tree/5ed82d14634e8d9576bb844c7bd4e3da66d450e7)
  (2026-11-06, "chore: bump version to v4.35.0 (#7)"). Cloned to `.lake/research/stacks/`.
- Also read: the release post
  <https://axiommath.ai/research/the-stacks-project-formalized/> (dated 2026-11-04), the
  front page of <https://stacks.axiommath.ai/>, and the repository's pull requests and issues.
- Checked 2026-11-08.
- Licence: Apache-2.0 for the Lean code [R: `LICENSE`, GitHub metadata]. The Stacks Project's
  own text is under the GNU FDL [R: README]. GLCinLean and Tau Ceti are also Apache-2.0 [R:
  `LICENSE`, `THIRD_PARTY_NOTICES.md`], so copying is allowed if the licence notice is kept and
  changes are marked; licence is not an obstacle [J]. Many Frontier docstrings restate Stacks
  Project wording; whether that text carries the GFDL is not settled by the README [J, low
  risk].
- Re-checked 2026-11-08: `main` is still at `5ed82d1` [R: `gh api`].

Tags: [R] read directly, [S] the source's claim about itself, [E] estimate (my counts with
scripts or grep, approximate), [J] judgement. All dated 2026-11-08.

## 1. What it is

- A Lean 4 formalisation of the Stacks Project by Axiom Math, built on Mathlib, released on
  2026-11-04 [R: repository created 2026-11-04; blog post dated 2026-11-04]. The repository has
  three commits: the publication, one build fix and one version bump [R].
- Two tiers [R: README, CONTRIBUTING.md]:
  - **StacksCore**: "human-reviewed formalizations, checked against the Stacks Project and
    brought to Mathlib standards of naming, generality and style". 445 modules, about 37,000
    lines [E: file and line count].
  - **StacksFrontier**: "formalizations written by AI agents ... where review is most needed".
    62,527 modules [E: file count]. All lines together: about 18.1 million, comments and blanks
    included [E: `wc -l`]; Frontier alone without blank lines is about 15.7 million [E]. The
    blog says "some 16 million lines of code" [S], which matches the second count.
- How it was made: "generated collaboratively between human formalisers at Axiom Math and
  AxiomProver, their in-house theorem proving system"; most of StacksFrontier was "formalised
  autonomously" [S: `formalization.yaml`]. The blog describes "coordinated swarms of AI agents"
  with "multi-agent auditing" for statement faithfulness [S].
- Claims: "We have formalized every tag of the Stacks Project with formalizable content";
  "There is no `sorry` and no `native_decide`"; proofs use only `propext`, `Classical.choice`,
  `Quot.sound` [S: README]. A grep for `sorry`, `admit`, `native_decide` and `axiom` as code
  found only prose matches [R: grep; not a full `#print axioms` check, which needs a build].
- Versions: `lean-toolchain` is `leanprover/lean4:v4.35.0` and `lakefile.toml` requires Mathlib
  `rev = "v4.35.0"` (manifest commit `56a00585…`) [R]. The README still says "Lean 4
  (v4.34.0-rc2)" [R], which was the version before PR #7.
- Maintainers: Kenny Lau, Brian Nugent, Ashvin A. Swaminathan, Yunzhou Xie, who review "every
  pull request, to either tier" [R: CONTRIBUTING.md].

## 2. What it says that matters for GLCinLean

### Coverage relevant to GLC

- **All algebraic geometry is in StacksFrontier, so none of it is human-reviewed.** StacksCore
  has no `AlgebraicGeometry` folder. Its folders are Algebra, Analysis, CategoryTheory,
  FieldTheory, GroupTheory, LinearAlgebra, NumberTheory, Order, RingTheory, SetTheory, Topology
  and a few others [R: directory listing].
- StacksFrontier/AlgebraicGeometry has 43,974 modules. The largest parts [E: module counts] are
  `Spaces` (algebraic spaces) 9,759, `EtaleCohomology` 4,228, `Stacks` (algebraic stacks) 2,699,
  `Chow` 2,048, `Quot` 1,636, `Descent` 1,069, `Duality` 1,049, `DeRham` 858, `Topologies` 672,
  `Groupoids` 285, `Cohomology` 157, `Artin` 143 and `DerivedQCoh` 108. Outside AG there are
  `CategoryTheory` 5,339 (including stacks and fibred categories on sites), `Homology` 1,034 and
  `Deformation` 1,601.
- **Algebraic stacks** [R: `StacksFrontier/AlgebraicGeometry/Stacks/AlgebraicStack.lean`]:
  - `AlgebraicGeometry.Stack.IsAlgebraicStack` (`@[stacks 026O]`) is an `abbrev` for a `Prop`
    about a `BasedCategory` over `BigFppfOver B S hS`. It says: the category is fibred in
    groupoids, it is a stack (two renderings of the stack condition, conjoined), its diagonal is
    representable by algebraic spaces, and it has a smooth surjective presentation by a scheme.
  - `AlgebraicStacks` (`@[stacks 03YP]`) is the 2-category of algebraic stacks, defined as an
    `InducedBicategory`.
  - Its implementation note admits a universe workaround: one conjunct "is retained because Lean
    admits no unused universe parameter".
  - The import closure of this one module is about 100 Stacks modules and 23,600 lines (5 of
    them in StacksCore) [E: my script over `import` lines].
- **Sites follow the Stacks Project's set theory literally** [R:
  `StacksFrontier/AlgebraicGeometry/Topologies/Fppf.lean`]. `BigFppfSite` (`@[stacks 021R]`) is
  a structure with a cardinal `cutoff`, `aleph0_lt_cutoff`, `cutoff_isStrongPrelimit`, chosen
  initial schemes and coverings, and so on. In other words the big site is bounded by a
  cardinal, as in Stacks Tags 000J and 000X.
  - Algebraic spaces use the same site: `structure IsAlgebraicSpace (B : BigFppfSite.{u})
    (S : Scheme.{u}) ...` [R: `Spaces/Basic.lean`]. `BigFppf` appears in 9,227 of the 9,759
    `Spaces` files and 2,486 of the 2,699 `Stacks` files, but only in 245 of the 1,069 `Descent`
    files [E: grep]. So the descent folder is the part least tied to the bounded site [J].
- **Stacks keeps its own stack predicate beside Mathlib's** [R:
  `StacksFrontier/CategoryTheory/Sites/Descent/IsStack/Defs.lean`]. `CategoryTheory.Functor.IsStack`
  is a structure on a functor `p : 𝒳 ⥤ 𝒮` (a fibred category). Its docstring says "Mathlib's
  `CategoryTheory.Pseudofunctor.IsStack` states the same conditions for a pseudofunctor" and
  "Mathlib has no cleaving construction turning a fibred category into a pseudofunctor" [S about
  Mathlib; not checked]. So, by Stacks' own account, Mathlib has no bridge today between the
  fibred-category side (Stacks) and the pseudofunctor side (Mathlib, Tau Ceti).
- **DG categories** [R: `StacksFrontier/Algebra/DGA/DGCategory.lean`]: a root-namespace
  `structure DGCategory (R) [CommRing R]` with explicit graded Hom types and degree equalities.
  These are the classical dg categories of Stacks §22.26 (Tags 09L4 to 09L8). They are not the
  presentable stable ∞-categories that GLC's `DGCat` stands for [J].
- **Not covered**, judged by grep counts over StacksFrontier [E] and by the Stacks Project's
  scope [J]:
  - ∞-categories (0 files mention "∞-categor"; Mathlib's `Quasicategory` appears only as an
    import);
  - derived algebraic geometry and derived stacks;
  - D-modules and crystals in characteristic 0 (the "D-module" hits are "associated-module",
    "localized-module" and similar);
  - ind-coherent sheaves (0 files), the Ran space (0), ind-schemes (0);
  - `Bun_G` (0 identifier hits), and `LocSys` as a stack.
  So none of the objects in `GLCinLean/Abstract.lean` (`DmodHalf`, `QCohLS`, `IndCohNilp`,
  `Psi`, `LCoarse`) and none of the `DGCat`/`LinFun` placeholders in `Foundations.lean` has a
  counterpart in Stacks [J].
- **A Langlands-adjacent example of "assumed theory as data"** [R:
  `StacksFrontier/NumberTheory/TraceFormula/GeometricMonodromyFiniteness.lean`]:
  - `structure FSheafFormalism` is a record of a sheaf type per scheme, `Perverse`, the six
    operations and a Frobenius trace. `structure ExtendedGeometricSatake` is a record including
    a placeholder affine Grassmannian `grassmannian : ℕ → Scheme`. The first's docstring says
    "None of this is available in the library, so it is recorded here as assumed data; nothing
    below constructs an instance of it"; the second's says "the library has no construction of
    it; like the formalism it is relative to, this is a record of assumed data".
  - Tags 03VZ and 03W0 (de Jong's and Gaitsgory's theorems) are "formalized" as theorems that
    take the source's conclusion as a hypothesis (`hdeJong`, `hGaitsgory`) and only derive the
    final shape from it. The docstrings say so plainly ("not proved here"). Only 03W0 carries
    an `@[stacks]` attribute, and its comment lists what is assumed; 03VZ is named only in the
    docstring.
  - The Stacks Project does not prove these tags either: both proofs read "See [dJ-conjecture]"
    and "See [Gaitsgory]" [R: stacks.math.columbia.edu/tag/03VZ and /tag/03W0, 2026-11-08].
  So "every tag formalized" includes tags whose content is assumed, not proved; for these two
  that mirrors the source, which only cites them, and the code discloses it [J].

### Quality

- **Independent audit** [R: Tau Ceti's site source
  `web/Site/Blog/QualityIndicators.lean` at Tau Ceti commit `d2083f0f`, a post by Kim Morrison
  and Remy Degenne dated 2026-10-28, "Edit (2026-11-05): we've extended the audits to include
  Axiom's Stacks library"]. Each figure is the share of sampled items an AI judge flagged:

  | Indicator | Mathlib | Tau Ceti | AxiomMath Stacks |
  |---|---|---|---|
  | Theorems with a removable hypothesis (Opus judge) | 3.1% | 6.8% | 10.3% (103/1,000) |
  | Theorems that duplicate Mathlib (Opus judge) | (n/a) | 5.0% | 6.4% (64/1,000) |
  | Files with repeated proof machinery (Sonnet judge) | 16.1% | 17.2% | 31.7% (118/372) |

  - 95% intervals: removable hypotheses 8.6–12.3% for Stacks against 5.4–8.5% for Tau Ceti;
    repeated machinery 27.2–36.6% against 13.7–21.4%. The intervals do not overlap [R].
  - In context: Stacks is flagged less often than Lean Pool, Anthropic FLT, OpenAI Math and
    AxiomMath CFSG on all three indicators, and less than Formal Frontier (34.4%) on repeated
    machinery. The post puts it "in the middle" on that indicator [R]. So it is weaker than
    Mathlib and Tau Ceti but among the better AI-written libraries.
  - The audit does not say whether its Stacks sample came from Core or Frontier, and the
    `lean-quality-indicators` repository (head `09c11a9`, 2026-11-06) has no Stacks run to check
    [R: `runs/` listing]. Since Frontier holds more than 99% of the modules, the sample is
    almost certainly mostly Frontier [J].
- **My own style samples** [E: scripts]:
  - Lines over 100 characters (Mathlib's limit, URLs excluded): 6 of 445 StacksCore files;
    609 of 2,699 files in `StacksFrontier/AlgebraicGeometry/Stacks`; 1,905 of 9,759 in `Spaces`.
  - 83 Frontier files use a "# Problem Description" / "-- Main Definition(s)" template instead
    of Mathlib's module docstring (for example `DGCategory.lean`).
  - None of the 2,699 files in Frontier `Stacks/` carry a copyright header, and only 6 of the
    445 StacksCore files do.
  - The lakefile turns off `linter.style.header` and `linter.overlappingInstances` and makes
    `linter.flexible` weak [R].
  - Many Frontier files, for example `AlgebraicStack.lean`, do have full Mathlib-style docstrings
    with "Main definitions", "Implementation notes" and "References" [R]. The quality varies.
- Clean-up has begun from outside: Kim Morrison opened PRs #9 to #12 on 2026-11-06 ("refactor:
  reuse Mathlib's K-projective null-homotopy theorem", and others) that replace Frontier proofs
  with Mathlib results [R: `gh pr list`; none merged at the time checked].

### How it moves to new Lean and Mathlib versions

- One bump so far: PR #7 by Kenny Lau, merged 2026-11-06. It took Lean v4.34.0-rc2 (Mathlib at
  commit `16edf57d…`) to v4.35.0 and changed 6,856 files (+41,892 / −24,538) [R: `git show
  --stat`].
- No CI workflow in `.github/` (only issue templates) [R]. There is no stated policy for
  following releases [R: README, CONTRIBUTING.md].
- Building: "about 63,000 modules, so a full build takes a long time and a lot of memory; a
  cache service for the compiled Stacks modules is planned" [S: README]. There is no cache today
  [S].
- GLCinLean is on Lean `v4.36.0-rc2` through Tau Ceti [R: `lean-toolchain`, `lakefile.toml`],
  one release ahead of Stacks.

### How to contribute

- Claim first [R: CONTRIBUTING.md, `.github/ISSUE_TEMPLATE/claim.yml`]:
  1. Open a claim issue with a blueprint: the statement, the proposed Lean statement, the
     existing work, and a proof outline.
  2. Wait for a maintainer to label it `blueprint-approved`.
  3. Then open a PR. Small fixes need no claim.
- Conventions [R]: `@[stacks TAG]` on the declaration, `add_to_stacks` for tags Mathlib already
  covers; "State the result the Stacks Project states, in its generality. Do not weaken a
  statement to make it provable"; "reuse existing definitions rather than introducing parallel
  ones"; no `sorry`, `admit`, `native_decide` or new `axiom`; Mathlib naming and style.
- Website: "eventually to upstream as much of it as is reasonable to Mathlib" [S].
- The blog reports that on 2026-10-21 de Jong asked that AI-generated comments and pull requests
  not be submitted to the upstream Stacks Project for now, and that Axiom keeps its work in its
  own repository [S: blog; the announcement itself not read].

### Relation to Tau Ceti

- No Tau Ceti roadmap mentions AxiomMath/Stacks [R: grep over `TauCetiRoadmap` at `7bf4638`, and
  the diff to its newer head `fb99861` (2026-11-08), which touches only `ProfiniteProPGroups`;
  grep over Tau Ceti `main` at `d2083f0f`]. In Tau Ceti `main` it appears only in the
  quality-indicators blog post. Other Axiom repositories are mentioned, for example
  AxiomMath/Weil in the ModularCurves roadmap.
- Tau Ceti does copy from Axiom's Apache-2.0 repositories, with a `## Provenance` section in the
  module docstring [R: `TauCeti/GroupTheory/SpecificGroups/CFSG/SpecialLinearFrobenius.lean`]:
  "This file adapts `CFSG/Adapters/SpecialLinearFrobenius.lean` from
  `https://github.com/AxiomMath/CFSG` (Apache-2.0), commit `69cb972f…`". The WienerIkehara files
  do the same for PrimeNumberTheoremAnd.
- **The two projects formalise stacks differently** [R]:
  - Tau Ceti's carriers are `SchPseudofunctor := Pseudofunctor (LocallyDiscrete Scheme.{u}ᵒᵖ)
    Cat.{u, u + 1}` (Mathlib's `Pseudofunctor.IsStack`) and `SchemePresheaf := Scheme.{u}ᵒᵖ ⥤
    Type u`.
  - Its roadmap `SchemeAndStackFoundations` (Layer 1) says: "where the Stacks Project bounds a
    site by a cardinal, the universe takes its place".
  - The same paragraph says "Fibres of stacks need not be groupoids; stacks in groupoids are
    required where the source requires them" [R].
  - Stacks uses fibred categories (in groupoids, for algebraic stacks) over a cardinal-bounded
    `BigFppfSite` instead.
  - So Stacks declarations about stacks do not typecheck against Tau Ceti's objects. Adapting
    one means restating it, not just copying it [J].
- Tau Ceti's stacks layer is small for now: 1 file in `AlgebraicGeometry/Stack`, 2 in
  `AlgebraicSpace`, 13 in `Descent` [R: listing]. Layer 1 of `SchemeAndStackFoundations` *plans*
  fppf/fpqc descent, algebraic spaces, algebraic and Deligne–Mumford stacks, and quasi-coherent
  modules on stacks [R]. Most of this is what Stacks Frontier already has in its own convention
  [J].

### What the existing repository already says about Stacks

- `PLAN.md`: missing foundations come from Mathlib, else Tau Ceti, "else copy the needed
  declarations from `AxiomMath/Stacks` (statements first, into `GLCinLean/Stacks/`, with
  provenance; its closure class and import rule are added to `glc/project.toml` with the first
  copy)". Its open questions include "Tau Ceti's stacks, Stacks' stacks, or functors of points"
  [R].
- `glc/project.toml` comment: a `stacks` closure class is added when the first copy lands.
  `Foundations.lean` mentions "copied Stacks declarations". `prompts/statement.md` lists "copy
  from Stacks" among the provider choices. `prompts/proof.md`: "Copied Stacks theorems get their
  proofs ported here too". `AGENTS.md`: start a copied file with a provenance header [R].

## 3. What it means for GLCinLean

- **For the statement, Stacks is almost certainly not needed** (ideas.md item 3) [J].
  - What GLC's statement is missing is the ∞-categorical/DG layer (`DGCat`, `LinFun`, D-modules
    on `Bun_G`, `QCoh` and `IndCoh_Nilp` on `LocSys`). Stacks has none of it.
  - What Stacks does have, classical algebraic stacks over a cardinal-bounded fppf site, would
    give at most a classical `Bun_G`. That is not the form GLC I uses: prestacks as functors to
    ∞-groupoids [J].
  - So the owner's suspicion holds for step 2's object map, but for a different reason than
    "Tau Ceti has enough" (see Conflicts).
- **As a Lake dependency it is impractical** [J]:
  - It must share one Mathlib with Tau Ceti, and it is a release behind (v4.35.0 against
    v4.36.0-rc2).
  - It has no build cache, so a build would compile about 63,000 modules locally. AGENTS.md
    treats compiling upstream modules (there, Mathlib or Tau Ceti) as a sign of a wrong pin
    that "takes hours"; a Stacks build would be that situation by design, and larger.
  - It would block the decision "Keeping up with Mathlib and Tau Ceti is fully automated" every
    time Stacks lags.
- **As a mine for proofs and statements it may be useful later** [J]:
  - It could serve step 3 (Build) and step 6 (Proof) for classical facts about algebraic stacks,
    descent, base change, perfect complexes and quasi-coherent cohomology.
  - Under ideas.md item 4, those parts fall under Tau Ceti's `SchemeAndStackFoundations`
    roadmap. So the route would be: read Stacks, write a Tau Ceti PR in Tau Ceti's conventions,
    and add a `## Provenance` section as Tau Ceti already does for CFSG. The route would not be
    copying into `GLCinLean/Stacks/`.
  - Adaptation is a rewrite more than a port: stacks and spaces sit on the bounded site and on
    fibred categories, for which Mathlib has no bridge to pseudofunctors (Stacks' own account).
    The `Descent` folder, mostly free of the bounded site, is the likeliest part to adapt with
    little change [J].
- **Quality bar (ideas.md items 1 and 2)**:
  - Frontier code is AI-written, unreviewed, and audited at about 1.5× Tau Ceti's rate for
    removable hypotheses and about 2× for repeated proof machinery.
  - Taking it without rework would go against "Set standards, and meet them" and "Defer to
    human-curated libraries". StacksCore meets the bar but covers no algebraic geometry [J].
- **Faithfulness lesson for step 4 (Review)**: a tagged declaration is not proof that the tag's
  content was proved. Tags 03VZ and 03W0 take their conclusion as a hypothesis. A fresh-agent
  review should check what a cited Stacks declaration actually proves before relying on it [J].
- **Workflow mechanics worth borrowing** [J]:
  - "claim with a blueprint, approved before the PR";
  - each declaration carries the tag it formalizes (a tag may sit on several declarations),
    with a comment when it covers only part of the tag, or, as for 03W0, what it assumes;
  - the EGA/SGA tagging rule ("more general", "(ii)", "affine case").
  These match the owner's review-status idea and the "Link to the existing literature"
  principle. The same pattern could tag GLCinLean declarations with GLC I numbers (for example
  `Conjecture 1.6.7`).

## 4. Conflicts

- **With ideas.md item 3** ("Stacks's code may never be needed, as Tau Ceti has enough"):
  - Tau Ceti does *not* yet have a stacks layer in code (1 + 2 + 13 files). It has one in its
    roadmap [R].
  - For GLC's own objects, neither Tau Ceti nor Stacks has enough: the DG/∞ layer is missing in
    both [J].
  - The conclusion (Stacks not needed for the statement) still holds [J].
- **With PLAN.md and ideas.md item 4**: PLAN.md routes Stacks copies into `GLCinLean/Stacks/`.
  ideas.md item 4 sends parts that a Tau Ceti roadmap covers to Tau Ceti, and algebraic spaces
  and stacks are covered by `SchemeAndStackFoundations` Layer 1 [R]. The decision on
  automated Tau Ceti contributions points the same way [J].
- **Between Stacks and Tau Ceti/Mathlib conventions**: cardinal-bounded `BigFppfSite` and
  fibred categories, against universes and Mathlib's `Pseudofunctor.IsStack` [R]. Copying
  conflicts with "Avoid duplication" and with Tau Ceti's rule to follow Mathlib's design [J].
- **Inside the source**:
  - The README says Lean v4.34.0-rc2; the toolchain is v4.35.0 [R].
  - "Every tag ... formalized" sits beside tags whose content is a hypothesis (03VZ, 03W0) [R].
    The Stacks Project only cites proofs for these two, and the code says what it assumes, so
    this is a matter of wording, not a hidden gap [J].
  - `formalization.yaml` says each Frontier statement "was checked against its Stacks tag" but
    "has not yet had human review"; review status is "self-assessed" [S].
- **With the workflow decision on keeping up with Lean and Mathlib**: Stacks has no CI and one
  manual bump so far [R]. As a dependency it would hold the project back [J].

## 5. Input for the open questions

- **What goes into `AGENTS.md`**: one line on the source order is enough [J]. For example:
  "Mathlib, then Tau Ceti, then a Tau Ceti roadmap; AxiomMath/Stacks only as a reference to read
  and adapt, with a provenance note, never as a dependency." The provenance-header note already
  in AGENTS.md covers the mechanics.
- **Whether `Abstract.lean`, `Foundations.lean` and their placeholders are reasonable**:
  - Stacks shows the other design, "assumed theory as a structure hypothesis"
    (`FSheafFormalism`, `ExtendedGeometricSatake`). For a *statement* that design is weaker:
    a theorem quantified over any such record says nothing about the real objects unless the
    record's fields pin them down.
  - The `@[placeholder] opaque` design in `Foundations.lean` names one intended object and does
    not let the statement range over arbitrary data. Stacks' example supports keeping
    placeholders over hypothesis-records for the GLC objects [J].
  - The comment in `Foundations.lean` about "copied Stacks declarations" can go if the owner
    accepts the route through Tau Ceti [J].
- **What happens to existing files**:
  - Drop PLAN.md's `GLCinLean/Stacks/` copy route, the planned `stacks` closure class in
    `glc/project.toml`, "copy from Stacks" in `prompts/statement.md`, and the "Copied Stacks
    theorems" line in `prompts/proof.md`.
  - Replace them with "adapt into Tau Ceti PRs, with provenance" [J].
  - `glc/project.toml` is the owner's file, so step 1 should propose this change rather than
    make it.
- **Who reviews the mathematics, and to what standard**: Stacks' model is AI audits plus a
  human maintainer who approves a blueprint *before* the work and reviews every PR, with a
  separate tier for unreviewed AI code [R].
  - The "tier" idea maps onto the owner's reviewed/unreviewed status per declaration.
  - The audit numbers above show that AI self-auditing alone leaves a measurable gap from
    Mathlib quality [J].
- **Where research notes live**: Stacks publishes a machine-readable `formalization.yaml`
  (schema `mathlib-initiative/formalization.yaml`, v0.4). It covers sources, the sorry count,
  axioms, automation methods, review status and alignment of key statements [R]. A file like
  this could be the committed, owner-readable project summary, and could partly replace
  `PLAN.md` or `references/papers/manifest.toml`. The `sources` block records the source and the
  commit it was taken from [J].

## 6. Questions for the owner

1. Should AxiomMath/Stacks be ruled out as a Lake dependency, and kept only as a reference that
   agents may read and adapt with a provenance note? I suggest yes.
2. When Stacks material is adapted, should it go into Tau Ceti PRs under the
   `SchemeAndStackFoundations` roadmap, as ideas.md item 4 suggests, or into
   `GLCinLean/Stacks/`, as PLAN.md says?
3. Is StacksFrontier (AI-written, unreviewed) an acceptable source at all, or only StacksCore,
   which has no algebraic geometry? If Frontier is accepted, must every adapted declaration
   first be re-checked against its Stacks tag by a fresh agent?
4. Should GLCinLean adopt a tagging convention like `@[stacks TAG]` and the EGA/SGA comments
   for its own declarations (for example GLC I numbers), and a `formalization.yaml`?

## Not reached

- The interactive parts of <https://stacks.axiommath.ai/> (library, graph, task board and the
  declaration and line counters) are rendered by scripts; I read only the static text. The
  fetch tool refused the site; `curl` worked.
- De Jong's 2026-10-21 announcement on AI contributions to the Stacks Project, cited in the
  blog post, was not read.
- I did not build Stacks. The axiom and no-`sorry` claims are taken from the README and from
  grep, not from `#print axioms`.
- The raw data of the Morrison–Degenne audit for Stacks is not in `lean-quality-indicators`
  (head `09c11a9`), so which tier its sample came from could not be checked.
- The claim that Mathlib has no cleaving construction (fibred category to pseudofunctor) is
  Stacks' own; I did not search Mathlib for it.
