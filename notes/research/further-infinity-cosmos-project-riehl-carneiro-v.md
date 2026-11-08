# Infinity-Cosmos project (Riehl, Carneiro, Verity)

- **Source:** [`emilyriehl/infinity-cosmos`](https://github.com/emilyriehl/infinity-cosmos/tree/89d7dc3ed861824535e540da489a46469dcc8e56)
  at commit `89d7dc3ed861824535e540da489a46469dcc8e56` (`main`, 2026-11-02). I also read the
  website and dependency graph at https://emilyriehl.github.io/infinity-cosmos/ (blueprint index and
  `blueprint/dep_graph_document.html`), and the repository's issues, pull requests and Actions runs
  through `gh`. For the bump automation I also read `leanprover-community/downstream-reports`
  at `4d536ae0b96357cb480876e21f820f92fbc81a26` (2026-10-29: `README.md`,
  `ci/inventory/downstreams.json`, `scripts/models.py`,
  `scripts/select_downstream_regression_window.py`) and its status page
  https://leanprover-community.github.io/downstream-reports/ (2026-11-08).
- **Checked 2026-11-08.**
- **Licence:** Apache 2.0 (`LICENSE`) [R, 2026-11-08]. This is the same as Mathlib and Tau Ceti, so
  code could be adapted with attribution.
- **Local clone** (Git-ignored): `.lake/research/infinity-cosmos/`.
- **For comparison** I read Mathlib and Tau Ceti at GLCinLean's pins in `.lake/packages/`: Tau Ceti
  `v4.36.0-rc2` (`e0610cc`, 2026-11-02) and Mathlib `1b1ccf4`.
- **Not read:** the Zulip channel `#Infinity-Cosmos`, the GitHub project dashboard
  (`users/emilyriehl/projects/2`), `blueprint.pdf`, and Riehl–Verity's book *Elements of
  ∞-Category Theory*, which the blueprint excerpts.

## 1. What it is

- **A Lean 4 project for the formal theory of ∞-categories.** It works through ∞-cosmoi: an
  ∞-cosmos is a simplicially enriched category whose hom-spaces are quasicategories, with a class
  of "isofibrations" and some enriched limits. Riehl is the project manager; Verity and Carneiro
  are co-leads [S `ANNOUNCEMENT.md`, 2026-11-08]. The repository is "A blueprint for a
  formalization of infinity-cosmos theory in Lean" [S GitHub description]. It has 123 stars, 14 open
  issues and 15 open pull requests [R GitHub API and `gh issue/pr list`, 2026-11-08; the API's
  `open_issues_count` of 29 counts both].
- **Size.** 32 tracked Lean files, 4,745 lines: 30 files (4,646 lines) under
  `InfinityCosmos/ForMathlib/`, plus the root `InfinityCosmos.lean` (34 lines) and
  `InfinityCosmos/Init.lean` (65 lines). No file contains `sorry` [R `git ls-files`, `wc`, grep,
  2026-11-08]. The largest file is `AlgebraicTopology/Quasicategory/TwoTruncated.lean` (901
  lines). The ∞-cosmos files proper (`ForMathlib/InfinityCosmos/`, five files) total 814 lines
  [R].
- **Pins.** Lean `v4.34.0-rc1`, Mathlib `1fe0a51` (2026-08-19), `LeanArchitect` `v4.33.0-rc1`,
  and `checkdecls` unpinned (`lakefile.toml`) [R].
- **Activity.** The last code commit is the Mathlib/`--wfail` bump on 2026-08-20 (#210). Every
  commit since then bumps a CI action [R `git log`, 2026-11-08]. Feature PRs are waiting, not
  missing: #218 (hoFunctor preserves small products, 2026-09-17), #217 (conical limits from
  tensors, 2026-09-03), and seven community PRs from 2026-06-26 to 2026-07-27 (#180, #181, #183,
  #190, #191, #194, #195, among them "equivalences are homotopy equivalences (Lemma 1.5.9)") are
  open [R `gh pr list`, 2026-11-08]. So "active, last pushed 2026-11-02" holds for the
  repository, but no new mathematics has been merged since August, although contributions keep
  arriving: the bottleneck is review and merging [J].
- **A blueprint migration is pending.** Draft PR #193 (2026-07-19, no comments) would replace
  LeanArchitect/leanblueprint with Verso Blueprint (`lake exe vbp check`), keeping the old
  sources under `blueprint/legacy/`; it reports "94 statements, 43 proofs" [R PR body; S for the
  numbers].
- **Its own medium-term goals.** `InfinityCosmos/ForMathlib/InfinityCosmos/Goals.lean`, headed
  "2025 Goals", compares two ways to build quasicategory theory [R, quoted]:
  - "(i) The 'analytic' approach: Follow Joyal or Lurie and give all the definitions directly in
    the language of quasicategories. ... Disadvantage: formalizing any theorems is very
    difficult."
  - "(ii) The 'axiomatic' or 'formal category theory' approach: Build a 2-category (strict
    bicategory) of quasicategories ... The ∞-cosmos project follows approach (ii)."

## 2. What it says that matters for GLCinLean

### 2.1 Mathematical content and scope

- **The definition.** `class InfinityCosmos extends PreInfinityCosmos K` in
  `ForMathlib/InfinityCosmos/Basic.lean` has these axioms: products, pullbacks of isofibrations,
  limits of towers, cotensors with simplicial sets, the closure properties of isofibrations, and
  `local_isoFibration`. `PreInfinityCosmos` is a `SimplicialCategory` with
  `has_qcat_homs : SSet.Quasicategory (Hom X Y)` and `IsIsofibration : MorphismProperty K` [R].
- **No example yet.** No `instance … InfinityCosmos` exists in the repository [R grep]. The
  blueprint says of the main example, "The full subcategory qCat ⊂ sSet of quasi-categories
  defines an ∞-cosmos", that "The following theorem should be quite difficult to formalize"
  (`blueprint/src/content.tex`, §"Examples of ∞-cosmoi") [R]. The announcement says the project
  does not intend "to attempt the difficult theorem of proving that the cartesian closed category
  of quasi-categories defines an example of an ∞-cosmos" for now, and calls the theorems that
  would follow a "bounty" [S `ANNOUNCEMENT.md`].
- **Scope: (∞,1)-formal category theory, nothing linear or stable.** The blueprint has one chapter
  with eight sections: an overview, then simplicial sets, the homotopy category of a quasicategory, enriched limits,
  ∞-cosmoi, change of base, examples, and the homotopy 2-category [R website index]. A grep of
  `content.tex` for "stable", "presentable" and "linear" finds only unrelated uses, such as
  "stable under pullback" [R]. The stated broader aim is "the core basic theory of ∞-categories,
  covering those aspects that can be defined in the homotopy 2-category" [R `content.tex`
  Overview].
- **Equivalences and adjunctions are 2-categorical.** "the existing Mathlib notions of
  equivalences and adjunctions in a bicategory specialize to define equivalences and adjunctions
  between ∞-categories when interpreted in the homotopy 2-category" [S `ANNOUNCEMENT.md`]. In
  Lean this is
  `abbrev Adjunction : Type := CategoryTheory.Bicategory.Adjunction (B := QCat) f u`
  in `Goals.lean` [R].

### 2.2 What has reached Mathlib

- **Merged.** Mathlib (at GLCinLean's pin) has `SSet.Quasicategory`
  (`AlgebraicTopology/Quasicategory/Basic.lean:41`), `QCat` and its strict bicategory
  (`Quasicategory/StrictBicategory.lean:51`), 2-truncated quasicategories
  (`TwoTruncated.lean`, `TwoTruncatedQuasicategory.lean`), `CoherentIso`, `HomotopyCat`,
  `NerveAdjunction`, and enriched conical limits (`CategoryTheory/Enriched/Limits/`) [R]. Merged
  PRs from this line of work include #31552 (2-truncated quasicategories, 2025-11-12), #31101
  (the strict bicategory of quasicategories, 2025-11-23), #31630 (homotopy category of a
  2-truncated quasicategory, 2025-12-02) and #35287 (coherent isomorphism, 2026-07-09) [R `gh`,
  2026-11-08]. In all, 59 Mathlib PRs carry the label `infinity-cosmos`: 31 are titled "[Merged
  by Bors]", 3 are open, the rest were closed otherwise [R GitHub search, 2026-11-08]. (#20963,
  conical products, was closed unmerged on 2025-03-14 with the label `blocked-by-other-PR`;
  `HasConicalProducts.lean` reached Mathlib by a PR I did not trace [R].) `Goals.lean` notes that `QCat.strictBicategory`
  has been "in mathlib as of November 23, 2025" [R].
- **Still open in Mathlib:** #35411 (cotensors in an enriched category) and #35144 (tensor product
  of enriched categories) [R titles].
- **Dependency graph** (2026-11-08) [R, counted from the Graphviz source of
  `dep_graph_document.html` against its legend]: 85 nodes. 32 have the dark-green border ("this
  is in Mathlib"). 18 have a dark-green background ("the proof of this result and all its
  ancestors are formalized"). 27 have a green background (proof formalised). 15 have a blue
  background (proof ready to formalise). 25 have no fill.
- **Mathlib's own `SimplicialNerve.lean`** still lists as "Projects" that the simplicial nerve of a
  Kan-enriched category is a quasicategory, and that the quasicategory of anima should be defined
  [R, Mathlib at GLCinLean's pin].

### 2.3 How the repository is organised (a model for upstreaming)

- **Files sit at their intended Mathlib path.** `ForMathlib/README.md` says: "This folder contains
  `.lean` files with new declarations to be upstreamed to Mathlib, as well as Mathlib results
  tagged with `[blueprint]`". `Mathlib/README.md` says: "we are ... using the directory structure
  and file names in the ForMathlib folder to indicate where things belong in Mathlib. The code that
  was formerly found in `.lean` files over here is now either in actual Mathlib or in the local
  ForMathlib." [R]
- **A hybrid blueprint built with LeanArchitect** [R]:
  - 21 `@[blueprint "label" (statement := /-- … -/) (proof := …)]` attributes on the project's
    own declarations;
  - 33 `attribute [blueprint …]` lines that attach blueprint text to declarations that already
    live in Mathlib (for example `Nerve.quasicategory` in `InfinityCosmos/Init.lean`);
  - 45 `\inputleannode{…}` lines in `content.tex` that pull these nodes in;
  - hand-written TeX environments for material that is not formalised yet: 47 statement
    environments (12 `definition`, 1 `defn`, 17 `lemma`, 2 `lem`, 11 `proposition`,
    1 `theorem`, 3 `corollary`) plus examples and remarks, with 46 `\uses{…}` and only one
    `\leanok` [R grep, 2026-11-08].
  - `Init.lean` says: "This file contains imports and `@[blueprint]` attributes which are needed
    for the blueprint ... Eventually, this file should be empty again."
- **Build rules** (`lakefile.toml`) [R]:
  - `warningAsError = true` ("Fail a module upon warnings");
  - `warn.sorry = false` ("The blueprint tracks this anyways");
  - `autoImplicit = false`, `relaxedAutoImplicit = false`.
- **CI** (`.github/workflows/`) [R]:
  - `blueprint.yml`: `lean-action` with `build-args: :blueprint --wfail`, then
    `docgen-action` with `blueprint: true` and the home page.
  - `lint.yml`: two shell checks, no line over 100 characters (URLs excepted) and no
    `import Mathlib`.
  - `create-release.yml`: `lean-release-tag` on every `lean-toolchain` change.
  - `intentions.yml`: the `leanprover-community/intentions` workflow for task claiming.
- **Task process** (`CONTRIBUTING.md`) [R]: tasks are GitHub issues on a project board. A
  contributor comments `claim`, `disclaim`, `propose #PR` or `withdraw #PR`, and may hold only
  one task at a time. The contributor list includes "Aristotle (Harmonic)", an AI prover, beside
  the human contributors.

### 2.4 How it follows Mathlib (automated bumps)

- **`update.yml`** runs daily (`cron: "0 17 * * *"`) with
  `leanprover-community/downstream-reports` actions [R]:
  1. `query-latest` with `first-known-bad`: has Mathlib's downstream service reported an
     incompatibility for this project?
  2. If not, `bump-to-latest` builds against the **last-known-good** Mathlib commit, and
     `open-bump-pr` opens or updates a PR on the branch `hopscotch/lkg-bump`.
  3. `track-incompatibility` opens an issue, plus a PR pinned at the first-known-bad commit, and
     closes the last-known-good PR "so maintainer attention should go to the PR pinned at the
     first-known-bad commit".
- **The bot only proposes; people merge.** The PR body says: "`lake build` was run against the new
  commit before this PR was opened and succeeded, so it should be mergeable as-is. Only
  `lake build` is checked, though — if your own CI does more ..." [R PR #215].
- **Observed lag** [R, 2026-11-08]:
  - Bot PRs #172–#200 (2026-06-09 to 2026-08-06) were all merged by hand by Riehl, within 0 to 16
    days; one (#189) needed "fix breaking changes".
  - PR #215 (to `v4.34.0-rc2`) has been open since 2026-08-20, last updated 2026-08-22, with a
    green build.
  - The 2026-11-08 run reports `LKG commit: 85e3a25…` (`v4.34.0-rc2`) and `FKB commit: <none>`.
    The status page says: "Its pin can be safely advanced by 33 commits to the last known good
    revision v4.34.0-rc2" and "last known good = target".
  - **Why the target does not move.** The service's default `target_mode` is `"next-release"`:
    it "bound[s] the target at the next release tag after the current pin, so the downstream
    steps through releases and never jumps over one" (`scripts/select_downstream_regression_window.py`;
    default in `scripts/models.py`) [R]. Infinity-cosmos's inventory entry sets no `target_mode`
    [R]. So, as long as the pin stays at `1fe0a51`, the service tests nothing newer than
    `v4.34.0-rc2`. The stall is not the service failing: the one unmerged PR blocks every later
    step [J, from the code]. Reaching `v4.36.0-rc2` from here takes one merged PR per release
    tag in between [J].
  - GLCinLean is at `v4.36.0-rc2`.
- **Scope of the service.** "At the moment the service validates the mathlib dependency only"
  [S `README.md`]. Its README also warns: "A registered project is expected to reasonably stay
  up-to-date with mathlib" [R quote]. Tau Ceti is in the inventory but `"enabled": false`, with
  `"target_mode": "master"` [R `downstreams.json`, 2026-11-08].
- **History.** `chore: drop the superseded update_mathlib.sh` (#205, 2026-08-14) shows that a
  hand-written bump script was replaced by this shared service [R commit title].

### 2.5 Tau Ceti's model of ∞-categories (for comparison)

- Tau Ceti, at GLCinLean's pin, builds on **Mathlib's `SSet.Quasicategory` directly**, that is,
  the analytic approach (i) [R]:
  - `TauCeti/AlgebraicTopology/DGNerve/Quasicategory.lean:211`:
    `instance dgNerve.quasicategory (R) [CommRing R] (C) [DGCategory R C]`, "the differential
    graded nerve is a quasicategory" (Lurie, HA 1.3.1.10);
  - `TauCeti/CategoryTheory/DG/Simplicial.lean`: `DGSimplicialCategory`, a simplicial enrichment
    of a DG category with `SSet.KanComplex` hom-objects (HA 1.3.1.13);
  - `TauCeti/AlgebraicTopology/Quasicategory/` has `FullSubcategory`, `RightMappingSpace` and
    `LocallySmall`.
- A grep of Tau Ceti's source for `InfinityCosmos`, `infinity-cosmos` or `Riehl` finds nothing
  [R, 2026-11-08]. Tau Ceti's EnhancedDerivedSheaves roadmap puts "dg nerve inside Mathlib's
  quasicategories" and plans presentable, dualizable and rigid categories on that basis [S, via
  `tauceti-roadmaps.md`].

## 3. What it means for GLCinLean

1. **It will not supply GLC's categories.** GLC needs presentable stable `k`-linear ∞-categories
   (`DGCat`, `LinFun`, `DGCat.IsCompact`, `DGCat.IsEventuallyCoconnective` in
   `GLCinLean/Foundations.lean`). Infinity-cosmos has no stable, presentable or linear notions. It
   does not even have the ∞-cosmos of quasicategories, its own first example [R, §2.1]. Removing
   these placeholders therefore depends on Tau Ceti (EnhancedDerivedSheaves on the dg nerve) and
   Mathlib, not on this project [J]. This bears on workflow step 2 ("each object of the GLC
   statement mapped to Mathlib, Tau Ceti, a Tau Ceti roadmap item, or missing"): for the
   ∞-categorical objects, the answer is "Tau Ceti roadmap item (early) or missing", never
   "infinity-cosmos".
2. **The shared base is Mathlib's quasicategories.** Infinity-cosmos feeds `SSet.Quasicategory`,
   `QCat` and the nerve into Mathlib, and Tau Ceti's dg nerve lands in that same class [R].
   Whatever GLCinLean writes about ∞-categories should therefore be stated for
   `SSet.Quasicategory`, or for Tau Ceti's dg-nerve objects. A third model of its own would
   duplicate them (ideas.md 1, "Avoid duplication"; "Defer to human-curated libraries") [J].
3. **It cannot be a dependency, and need not be.** Its pins are two Lean releases behind
   GLCinLean's (`v4.34.0-rc1` against `v4.36.0-rc2`) [R]. Lake could not resolve both against one
   Mathlib [J, from how Lake resolves a single Mathlib]. It also sits outside the order of sources
   in ideas.md 3 (Mathlib, then Tau Ceti, then Stacks). Its results reach GLCinLean only after they
   land in Mathlib [J].
4. **`LinFun.IsEquivalence` already follows its pattern.** In the homotopy-2-category view, an
   equivalence of ∞-categories is an equivalence in a 2-category, and Mathlib's bicategorical
   notions supply it [S §2.1]. `LinFun.IsEquivalence` (two-sided inverse up to `LinIso`) has that
   shape [J]. When providers arrive, the natural Mathlib-style replacement is an equivalence or
   adjunction in a `Bicategory` (as with `QCat.Adjunction`), or `≅` in a functor category, not a
   custom predicate [J]. This is input for workflow step 2, "Decide whether `Abstract.lean`,
   `Foundations.lean` and their placeholders stay or change".
5. **A model for "this repository first, upstream later"** (ideas.md 4). Laying out
   `ForMathlib/…` by intended Mathlib path, then deleting files once upstream has them, is a
   working pattern [R, §2.3]. GLCinLean could lay out its non-Tau-Ceti backbone at its intended
   Tau Ceti or Mathlib path in the same way, which makes "continuously refactor to adopt their
   decisions" (ideas.md 1) a matter of deleting files [J].
6. **A model for the review system's input** ("Input: a Lean project documented in Mathlib's
   style. Output: a web page ... with the dependency graph", ideas.md, review system). The hybrid
   blueprint has three useful features [R, §2.3]:
   - it keeps statement text in Lean, in `@[blueprint]`;
   - it tags upstream declarations with `attribute [blueprint]`;
   - it keeps unformalised nodes in TeX.

   One gap matters for GLCinLean. LeanArchitect marks "in Mathlib" only for Mathlib, Batteries and
   core modules, not Tau Ceti (`further-leanarchitect-blueprint-data-extracted-f.md`). GLCinLean's
   upstream is mostly Tau Ceti, so its review system would need a "Tau Ceti" state [J].
7. **A model, and a warning, for "Keeping up with Mathlib and Tau Ceti is fully automated"**
   (workflow decision). `downstream-reports` gives the detect, bump, open-PR and track-incompatibility
   loop off the shelf [R, §2.4]. Infinity-cosmos shows the weak point: the bot proposes but people
   merge, and the project has stood at its `v4.34.0-rc1` pin since 2026-08-20 [R]. For GLCinLean "fully
   automated" must include merging and fixing breakage, which fits "Agents push themselves" [J].
   The stall is mechanical: in the default `next-release` mode each bump PR must be merged before
   the next release is even tested [R code, §2.4; J]. And `downstream-reports` cannot simply be
   reused here: GLCinLean requires `TauCeti` and gets Mathlib through it, while the service
   "validates the mathlib dependency only" [S README; J]. Although the actions take a
   `dependency-name` input, a Tau Ceti bump would need GLCinLean's own loop (bump the Tau Ceti
   tag, build, fix, merge), with the infinity-cosmos workflow as a template [J].
8. **"Set standards, and meet them"** (ideas.md 1). Infinity-cosmos makes warnings fail the build
   (`warningAsError = true`, `--wfail`) and lints line length and `import Mathlib` in CI [R].
   That is a cheap, enforceable standard of the kind ideas.md asks for [J].
9. **Its claim/propose process does not fit here.** The process is built for many human
   contributors on a public board [R]. GLCinLean has one owner and agents, so the `intentions`
   workflow adds nothing [J]. The `Aristotle (Harmonic)` entry shows that an established
   human-led project accepts AI-written contributions [R contributor list; J reading].

## 4. Conflicts

- **With GLCinLean's `lakefile.toml`.** Its comment says Mathlib's linters are used "as FLT,
  Carleson and PFR use them: warnings in the build log, never a gate" [R]. Infinity-cosmos makes
  warnings a gate [R]. These are two different standards. ideas.md 1 ("Set standards, and meet
  them") points towards a gate [J].
- **With the description under which this source was found.** It was called "the main Lean effort
  to formalise ∞-category theory", one that "shapes how the rebuild can state GLC without
  placeholders". That is true for the axiomatic theory. But Tau Ceti has its own quasicategory
  development (dg nerve, mapping spaces, full subcategories) that never cites it, and that line,
  not ∞-cosmoi, leads to GLC's DG categories [R §2.5; J]. "Active" holds for CI maintenance; the
  last mathematics landed in August [R].
- **Two models of ∞-categories in the ecosystem.** Infinity-cosmos uses the axiomatic approach
  (ii), a strict 2-category with isofibrations. Tau Ceti uses the analytic approach (i), working
  directly in quasicategories [R]. They share `SSet.Quasicategory`, but their higher-level
  vocabularies may diverge [J]. GLCinLean does not have to choose now. It should follow whichever
  vocabulary Mathlib adopts (ideas.md 1, "continuously refactor") [J].
- **With the workflow decision on automated bumps.** No conflict in principle. But the one
  automated-bump downstream I checked has stalled for 2.5 months while its build stayed green [R].
  Because the service steps one release at a time, one unmerged PR stops the whole chain [R code;
  J]. This is evidence that bump automation without automated merging does not keep a project up
  to date [J]. The same holds for feature PRs there (§1): without someone who merges, nothing
  lands [J].
- **`Goals.lean` is stale.** It is headed "2025 Goals" and speaks of "by the end of the year"
  (2025) [R]. It should not be cited as the current plan.

## 5. Input for the open questions (workflow.md)

- **Whether `Abstract.lean`, `Foundations.lean` and their placeholder design are reasonable.**
  - Keep placeholders for the ∞-categorical objects. No provider is near: this project lacks even
    the ∞-cosmos of quasicategories, and Tau Ceti's presentability layer is "still absent"
    [R/S, §2.1, §2.5; J].
  - When they change, align the interface with Mathlib's vocabulary: `SSet.Quasicategory` or
    Tau Ceti's `dgNerve` for objects, `Bicategory.Adjunction` or equivalences in a bicategory,
    and `≅` rather than `LinIso` [J, from §2.1 and §3.4].
  - This agrees with `audit-lean.md` §2.4, which found that the current names do not match
    Mathlib's.
- **What happens to each existing file** (`blueprint/`, the ReviewKit requirement and its
  `@[placeholder]`).
  - Infinity-cosmos has no Lean placeholders. Unformalised material lives as blueprint-only TeX
    nodes with `\uses`, and everything in Lean is real and `sorry`-free [R].
  - GLC's statement must typecheck, so GLCinLean needs Lean-side stand-ins that infinity-cosmos
    never needs [J]. Its pattern still suggests keeping the number of Lean placeholders minimal
    and tracking the rest in the blueprint [J].
  - For `blueprint/`, it is evidence that a LeanArchitect hybrid works at 85 nodes with
    Mathlib-tagged nodes [R]. But the project itself has a pending draft migration to Verso
    Blueprint (#193), so LeanArchitect is not settled even there [R; J]. Whether either beats
    tracker is for the review-system design.
- **Who reviews the mathematics, and to what standard.**
  - Here the reviewers are the authors of the source text: Riehl and Verity wrote the book the
    blueprint excerpts [S].
  - GLCinLean has no such reviewer for the ∞-categorical layer. If the definitions are written
    in GLCinLean rather than taken from Tau Ceti, an outside expert in higher category theory
    would be needed to check that they mean what the papers mean [J].
  - Taking them from Tau Ceti moves that burden to Tau Ceti's review [J].
- **What goes into `AGENTS.md`.**
  - Minor point: infinity-cosmos's `CONTRIBUTING.md` build section ("Without
    `lake exe cache get`, `lake build` compiles Mathlib from source, which takes hours. Run it again
    after any change to `lake-manifest.json`") matches the "Builds" note in GLCinLean's `AGENTS.md`
    [R].
  - It suggests that the cache rule is worth keeping as one line [J].
- **Whether `PLAN.md` is needed; where research notes and session summaries live.** This source
  does not bear on these.

## 6. Questions for the owner

1. **The ∞-category foundation.** Should GLCinLean take Mathlib's quasicategories plus Tau Ceti's
   dg nerve and EnhancedDerivedSheaves as the only foundation for its ∞-categorical objects, and
   use infinity-cosmos only through what it upstreams to Mathlib (never as a dependency)?
2. **Warnings as a gate.** Should GLCinLean's build fail on warnings (`warningAsError` /
   `--wfail`) and lint line length and `import Mathlib` in CI, as infinity-cosmos does? The
   current "warnings in the build log, never a gate" would then go.
3. **Merging bump PRs.** For "fully automated" bumps, may agents merge their own bump PRs once the
   build and checks are green? Infinity-cosmos shows that a bot that only opens PRs leaves the
   project months behind.
4. **Upstream layout.** Should the non-Tau-Ceti backbone be laid out at its intended Tau Ceti or
   Mathlib path, so that upstreaming later means moving and deleting files?
