# Langlands knowledge base (Langlandsproject/Langlands)

- **Source:** https://github.com/Langlandsproject/Langlands, read at `main` =
  [`64203c5`](https://github.com/Langlandsproject/Langlands/tree/64203c5ffe43d9cb599d3b13b68237fbae150c77)
  (2026-08-19); the only other branch, `origin/gpt/tori-proof-pass` (`665f284`, 2026-08-23), adds
  one proof step in `Tori/Classification.lean`.
- **Tooling it depends on:** mdblueprint, public at
  [`gametheoryinlean/mdblueprint@acbbb06`](https://github.com/gametheoryinlean/mdblueprint/tree/acbbb0696e5c85844aee1d8b6a90591a29690606)
  (the Langlands README links only to a local file path on the author's machine).
- **Checked 2026-11-08.** Clone in `.lake/research/Langlands/` (ignored by Git).
- **Licence: none.** The GitHub API reports `license: null`, and the repository has no LICENSE
  file [R 2026-11-08]. The same is true of mdblueprint [R]. Without a licence the code cannot be
  copied into GLCinLean or Tau Ceti (Apache 2.0) without the author's permission [J].

Tags: [R] read directly, [S] the source's claim about itself, [E] estimate, [J] judgement. All
checked 2026-11-08.

## 1. What it is

- A "Stacks Project for the Langlands program" with two coupled deliverables: a DAG of Markdown
  + KaTeX nodes published as a static site, and a Lean 4 library (`lean/LanglandsLean/`) that
  formalises selected nodes [S README].
- One rule for both layers: "**AI writes**, … **Humans review**". "nothing becomes an admitted
  node without a mathematician having read it" [S README].
- Size and activity [R, git and GitHub API]: 168 commits on `main`, all under one person's Git
  identity (Jia-Jun Ma, two name spellings). The agents commit under that identity; messages
  mark the human's part as "(owner directive)" or "(owner review)" (e.g. `7f885c8`, `536544f`).
  262 node files in 12 topic directories; 34 Lean files under `lean/LanglandsLean/`, 5157 lines;
  3 stars, 1 fork; 49 issues, all opened by the author; 3 open pull requests from one outside
  contributor (`kernelpanic888`, "AI4Math student" tasks). Created 2026-05-21, last push
  2026-08-23. 49 of the 168 commits are from a single day, 2026-08-19. No CI (no `.github/`).
- Pins: Lean `v4.33.0`, Mathlib `v4.33.0` (`lean/lean-toolchain`, `lean/lakefile.lean`) [R].
  GLCinLean is on `v4.36.0-rc2` [R `lean-toolchain`].
- Scope: 14 themes in `docs/00-project-outline.md`. Theme 13 is "Geometric Langlands and
  Geometric Relative Langlands", but only the algebraic-groups theme is expanded. The active work
  is Bruhat–Tits theory and algebraic tori (`docs/TODO.md`) [R].

## 2. What it says that matters for GLCinLean

### 2.1 Content: what exists and what does not

- **Theme 13 is a title only.** No topic directory or node is about geometric Langlands, and no
  node mentions D-modules. Geometric objects come up only in "role in Langlands" remarks:
  `Bun_G` in 3 nodes (`Forms/torsors.md`, `ReductiveGroups/semisimple_groups.md`,
  `ReductiveGroups/levi_subgroups_and_unipotent_radicals.md`), perverse sheaves in 5, and geometric
  Satake in 8. The longest is a section on Mirković–Vilonen geometric Satake in
  `nodes/AlgebraicGroups.RootData/langlands_dual_groups.md`. None of these is a definition
  [R, grep of all 262 nodes, 2026-11-08].
- **The Langlands dual group is prose only.** `root_data.langlands_dual_groups` is a `kind: topic`
  node with no `lean:` field. It defines `Ĝ` as the reductive group over `ℂ` (or any
  algebraically closed field of characteristic 0) with the dual root datum `(X_*, Φ^∨, X^*, Φ)` [R].
  The roadmap item "G0.9 — Dual side" (dual torus, L-group of a torus) is unchecked [R `docs/TODO.md`].
  None of the 45 `AlgebraicGroups.RootData` nodes has a `lean:` field [R]. Only 42 of the 262
  nodes have one, and almost all are in `AffineGroupSchemes` (27) and `Tori` (11) [R].
- **A root-datum survey that bears on GLCinLean's gap.**
  `docs/superpowers/research/2026-07-17-root-system-root-datum-mathlib-state.md` (84 lines)
  checks Mathlib v4.32.0 by compiling a probe file. It finds that Mathlib already has `RootPairing`,
  `RootDatum ι X₁ X₂` (= `RootPairing ι ℤ X₁ X₂`), `IsRootSystem`, `IsCrystallographic` and
  `IsReduced`. Its conclusion is that "the remaining Langlands-side work is not to redefine them,
  but to build bridges from reductive groups, character/cocharacter lattices … to the existing
  Mathlib objects". It also warns that semisimplicity means the roots span *after tensoring with
  ℚ*: "integral spanning would incorrectly depend on the isogeny form" [R]. No such bridge exists
  in its Lean code [R].
- **Lean content** [R, file list and grep]: affine group schemes through Hopf algebras (the
  `hopfSpec` Yoneda chain, comodules, points functor), the examples `𝔾ₐ`, `𝔾ₘ`, `μₙ`, `GL_n`,
  `GL(V)`, diagonalizable groups and Cartier duality, tori (character and cocharacter groups,
  character lattices, rank, duality pairing, the classification of tori by Galois lattices),
  and Galois descent. `AlgebraicGroups/ReductiveGroups/` holds only `Diagonalizable.lean`: no
  reductive group, root datum of a group or Langlands dual group in Lean.
- **26 live `sorry`s** in 6 files (`Tori/Torus`, `CharacterGroup`, `Duality`,
  `Classification`, `Rank`, `Forms/GaloisDescentStatements`) [R grep, excluding comments].
- **Tau Ceti already has most of this Lean content, and further along.** The Tau Ceti pinned in
  GLCinLean (`e0610cce`, Apache 2.0) has `Algebra/AlgebraicGroup/DiagonalizableGroup/`
  (29 entries, including `CharacterLattice.lean`, `Cocharacter.lean`), `MultiplicativeType/`
  (including `GaloisModule.lean`), `Torus/CharacterLattice/` and `SplitTorus/RootDatum/` (the
  coordinate-difference root datum and its Weyl group) [R, file list and docstrings]. The classification
  of tori is *complete* there: `Torus/CharacterLattice/Equivalence.lean` proves
  `characterLatticeFunctor_isEquivalence`, the equivalence between tori over a perfect field and
  continuous Galois lattices (Milne, Thm 12.23). `Faithful.lean` and `EssentialImage.lean` hold
  over any field. No file in Tau Ceti's `Torus/`, `MultiplicativeType/`, `DiagonalizableGroup/`
  or `SplitTorus/` contains `sorry` [R grep]. The Langlands counterpart, `toriClassification`,
  still has 8 of its 26 `sorry`s [R]. I did not compare the rest theorem by theorem [J: the
  overlap is large, and on tori Tau Ceti is ahead].

### 2.2 Process: the mechanisms

- **`AGENTS.md` is 322 lines.** One of its sections is headed "Where the rules live (map, not
  content)" (l.134), but most of the file states rules itself. The binding rules live in
  `docs/01-design-conventions.md` (the contract), `docs/03-review-checklist.md`,
  `docs/04-design-ledger.md` and `docs/02-agent-workflow.md` [R].
- **Four-step pipeline per unit** (Identify → Blueprint → Issue → Execute) [R
  `docs/02-agent-workflow.md`]:
  1. a mandatory **Mathlib survey** first, through the Lean LSP search tools and grep, ending in a
     one-paragraph "Mathlib state" entry: what exists, categorical alternatives, and "genuine
     gaps". It "distinguishes engineering gaps from mathematical gaps";
  2. Markdown nodes with YAML frontmatter (`id`, `kind`, `uses`, `verification`, `generality`,
     `source` spans) and "a real natural-language proof in the body — not 'see Lean'";
  3. one GitHub issue per node, "Blocked by #N" mirroring the `uses` edges;
  4. Lean, then the node's `lean.declarations` and `verification.alignment: aligned` are filled.
- **The transcription procedure** ("definitions are transcriptions, not translations") [R
  `AGENTS.md`, conventions §6]: copy the textbook definiens into the docstring first; every Lean
  object must answer to a word of it; "If the Lean spelling contains an object the sentence does
  not mention … the definition is wrong — *by default, before any argument*"; a convenient
  equivalent form enters only as a "bridge theorem" with its own node; "Simplifying
  substitutions in definitions are review-blockers, even when provably equivalent"; "Plans do not
  override conventions".
- **Transcribe the hierarchy**: a special case is "the general notion plus a condition"
  (a torus is a diagonalizable group with a free, finite character lattice) [R conventions §6].
- **Statements that cannot be formed**: "get a `BLOCKED` comment at the definition site, not a
  weakened fake statement"; "never a sorry'd instance or sorry'd data used downstream" [R
  checklist §4].
- **Statements before proofs**: "For definition-layer commits (new public defs), also show the
  statements to the owner before the proof pass" [R checklist preamble]. A new or contested
  design surface is "shown to the owner … and only then implemented" [R `AGENTS.md` working
  order].
- **Why a checklist** [R checklist preamble]: "one working day produced seven owner-caught
  defect classes … Every one had a rule; several rules were written *the same day* and violated
  hours later. The failure mode is not ignorance but **generation-order bias** … prose rules far
  back in context do not fire at the moment of writing. A checklist … runs AFTER generation".
- **Design ledger** (`docs/04-design-ledger.md`): one row per contested design surface (textbook
  sentence, Lean form, working carrier, bridge, names). "A review that touches a settled row
  **amends this ledger first** (with owner approval), then the code". It exists "because the X^*
  stack was redesigned three times in one day … each rotation satisfying only the newest
  constraint" [R].
- **Mechanised review rules**: `scripts/lint_design.py` (115 lines of regexes: banned
  re-spellings, structure-quantifying `∃`, `: Type _ :=` ascriptions, stray `universe`, module
  `## Blueprint` sections, file placement by topic). "new findings in touched files are blockers"
  [R].
- **Lean ↔ node links both ways**: a node lists `lean.declarations`; each principal Lean
  declaration starts a docstring line with `Blueprint: <node ids>`; `lean_reverse_check` (in
  mdblueprint) fails on any mismatch. "Never link a node to a declaration that only covers a
  special case of its statement" [R conventions §4].
- **Review status lives in the node, not in Git**: `verification: {definition, proof,
  alignment}` and `generality: {reviewed, prompt, verdict}` fields; no reviewer name, date or
  commit is recorded [R, frontmatter; grep for `reviewed_by|reviewer:` finds 0 nodes]. Current
  counts: 24 `alignment: aligned`, 16 `pending` [R].
- **Independent review prompt**: `docs/superpowers/prompts/kb-formalization-plan-review.md`, an
  adversarial reviewer that checks, in order, mathematical correctness, DAG soundness, Lean
  feasibility ("verify by grepping … do not trust the plan"), completeness, conventions and
  risk. Output: findings tagged BLOCKER / MAJOR / MINOR / NIT with a concrete fix, ending in
  "VERDICT: (approve | approve-with-fixes | rework)" [R]. Independent review, by "owner, or a
  second model with" this prompt, is "mandatory for definition-layer commits, optional
  elsewhere" [R checklist]. Either one is enough.
- **Commits carry an audit**: "After every change-set, audit it against the rules in this file
  and record the audit outcome … in the commit message" [R `AGENTS.md`]. The rule dates from
  2026-08-19; 13 of the 168 commit messages mention an audit [R `git log`].
- **Proof passes go through a skill**: `lean-sorry-crusher` is "**Mandatory for every proof
  pass**", a plan/prover/review loop with state files (`.sorry-crusher/PROGRESS.md` is committed)
  [R `AGENTS.md` l.198].
- **Burn log**: `AGENTS.md` ends with "Things that have burned us before", each a dated failure
  and its fix (avatar definitions three times in a day; a parallel TeX blueprint; declaring work
  "blocked on Mathlib" too early; `lake build` as the inner loop) [R].
- **Lean idioms** [R conventions §7–8]: a group scheme over `S` is
  `(G S : Scheme) [G.Over S] [GrpObj (Scheme.asOver G S)]`, "**Never** introduce bundled types
  like `GroupScheme S := Grp (Over S)`"; no `ULift` in public statements; no `∃` over types with
  instances; Mathlib naming; files 200–400 lines, 1000-line hard cap.
- **What the code and the ledger actually do** [R]: `CharacterGroup` takes
  `G : Grp (Over (Scheme.Spec.obj (op R)))`, the bundled category object, without a named alias
  (`Tori/CharacterGroup.lean` l.87). Tori and diagonalizable groups are *Hopf-algebra properties*:
  `class IsDiagonalizableAlgebra R A`, `class IsTorusAlgebra k E A` (ledger, "The torus stack";
  `Tori/Torus.lean` l.62). So the ban is on a *named alias* for the bundled type and on
  *defining characters* through Hopf homs or group-like elements. It is not a ban on bundled
  objects or on Hopf-side definitions of tori.
- **Lean version moves are manual.** One bump in the history, `b88beca` (2026-08-19,
  v4.28.0 → v4.33.0), with a commit message listing each API-drift fix [R].

### 2.3 The repository's own inconsistencies

- `README.md` says "Mathlib `v4.28.0`"; `AGENTS.md` and the lakefile say `v4.33.0` [R].
- `docs/TODO.md` says "**the Lean library is sorry-free**" (2026-08-19, third pass); the code
  now has 26 `sorry`s [R]. The roadmap prose was not updated as the work moved.
- `README.md` lists `references/` (PDFs) and `docs/knowledge/references/`. `references/` is
  in `.gitignore`, so it is local only, like GLCinLean's papers. `docs/knowledge/references/`
  does not exist, although `docs/TODO.md` links to a file in it [R].
- Conventions §6 still gives as its example that `X^*(Spec A)` "is *defined* as Hopf-algebra
  homomorphisms `R[ℤ] →ₐc[R] A`". The ledger and `AGENTS.md` rule 5 (same day) settle the
  opposite, `G ⟶ 𝔾ₘ R`, and call Hopf homs "a re-encoded carrier". `Conventions.lean` calls the
  typeclass form canonical, while the ledger's `CharacterGroup` uses bundled `Grp (Over …)` [R].
  The rules were rewritten faster than the files that state them.

## 3. What it means for GLCinLean

- **Not a library to build on** [J]. Its Lean layer is below Tau Ceti in the owner's order of
  sources (ideas.md §3), largely duplicated by Tau Ceti, has open `sorry`s, sits three Lean
  versions behind GLCinLean, and has no licence. Importing it would break "Avoid duplication" and
  "Stay up to date" (ideas.md §1). Nothing in it fills GLCinLean's known gap, the root datum of a
  general reductive group behind `RootDatumDuality` (`GLCinLean/Abstract.lean` l.37–42).
- **Its root-datum survey is useful input for step 2** [R, J]. It says what a filled
  `RootDatumDuality` would target: Mathlib's `RootDatum` (a `RootPairing` over `ℤ`), reached by a
  bridge from a reductive group with a maximal torus to its character and cocharacter lattices,
  roots and coroots. It does not invent a new root-datum type. Tau Ceti's
  `SplitTorus/RootDatum/` already builds concrete Mathlib root data on split-torus lattices (the
  coordinate-difference datum `e_i − e_j`, and special isogenies of the pinned `B₂`, `G₂`, `F₄`
  data). In the pinned Tau Ceti, no file under `Algebra/AlgebraicGroup/` attaches a root datum to a
  general reductive group [R grep, 2026-11-08]. The plan should check whether a Tau Ceti roadmap
  item covers that bridge [J]. The survey was made at
  Mathlib v4.32.0 and should be rechecked at GLCinLean's pin [J].
- **Little overlap with the planned GRT library today** [R, J]. Theme 13 has no nodes, and the
  author's roadmap (`docs/TODO.md`) goes to Bruhat–Tits theory and the Kottwitz map, not to
  sheaves on stacks. Collaboration would mean adding a new theme to someone else's
  knowledge base, which does not fit the plan of writing GRT code in this repository or in Tau Ceti
  (ideas.md §4) [J].
- **Its process is a close, worked example of what the owner wants, and of where it fails**
  [J]. The useful parts, each tied to a step:
  - *Step 2 (plan / blueprint).* The "Mathlib state" survey is the mapping step 2 asks for
    (Mathlib / Tau Ceti / roadmap / missing), plus a useful distinction: engineering gap versus
    mathematical gap.
  - *Step 2, fresh-agent review.* The adversarial plan-review prompt, with its severity tags and
    its three-way verdict, could serve, lightly adapted, as the reviewer prompt for "A fresh agent
    reviews it".
  - *Steps 3–4 (build, review).* The transcription procedure is a check that an agent can apply
    and that someone who cannot judge the mathematics can audit: the docstring quotes the
    paper's sentence, and each Lean object must answer to a word of it. This fits the owner, who
    cannot check the mathematics (`AGENTS.md`), and ideas.md §1 "Link to the
    existing literature".
  - *Placeholders.* "BLOCKED, not a weakened fake statement" is the rule GLCinLean already
    follows with `@[placeholder] opaque` (`AGENTS.md` "Placeholders"). This is independent
    support for keeping the design.
  - *The review system.* Bidirectional Lean ↔ node links (`Blueprint:` markers plus a reverse
    check) are one way to get the dependency graph and tags that the review system should
    output. Its review status is a field in the node, with no commit hash, so it cannot tell
    "reviewed, unchanged" from "reviewed, changed since". The owner's per-declaration commit-hash
    pinning (ideas.md, "Review status") goes further than this source.
- **A warning about "prompts alone"** [S, J]. The author's own record: rules written in prose
  were broken within hours, so the project added a checklist, a ledger, a linter and an audit in
  each commit message, all on one day (2026-08-19). Its human reviewer is the owner; the README
  says the project is "built for — and by — **mathematicians**" [S]. The review records only
  "owner-caught" defects. GLCinLean's owner cannot play that part. The
  project is evidence that a pure-prompt workflow drifts unless something checks it after
  generation (ideas.md "Work in a very simple way").
- **A long `AGENTS.md` is a counter-example** to the decision that `AGENTS.md` is short
  (workflow.md, Decisions) [J]. It grew by accretion of rules and burn-log entries. Its own
  version number is right, but the README, `TODO.md` and conventions around it already
  contradict it (§2.3).

## 4. Conflicts

- **With ideas.md §3 and §1 (order of sources, avoid duplication):** the project re-derives
  algebraic-group material that Tau Ceti has [R §2.1]. It is not a source to draw code from.
- **With ideas.md §1 "Publish freely… open source":** no licence [R].
- **With ideas.md §1 "Stay up to date":** one manual Lean/Mathlib bump in three months of
  activity (2026-05-21 to 2026-08-23), no CI
  [R]. Workflow.md decides that keeping up is fully automated here; this source offers no
  mechanism for that.
- **With ideas.md "very simple way … without any complex system or harness":** the source began
  with a simple four-step pipeline and grew a linter, a checklist, a ledger, mdblueprint's checks
  and a sorry-crusher skill after repeated failures [R, J].
- **With workflow.md "`AGENTS.md` is short":** its `AGENTS.md` is 322 lines [R].
- **With GLCinLean's `Foundations.lean` (a narrow point):** the Langlands conventions forbid a
  *named alias* for a bundled group-scheme type ("Never introduce bundled types like
  `GroupScheme S := Grp (Over S)`", also a burn-log entry) [R conventions §7, `AGENTS.md`].
  GLCinLean's `abbrev ReductiveGroup (k) := TauCeti.ReductiveAffineGroupSchemeCat k`
  (`GLCinLean/Foundations.lean` l.42) is exactly such an alias [R]. The disagreement is smaller
  than it first looks. Langlands itself uses the bundled `Grp (Over (Spec R))` in
  `CharacterGroup`, and defines tori as Hopf-algebra properties (`IsTorusAlgebra`), as Tau Ceti
  does (`TauCeti.torusCommHopfAlgProperty`, `Torus/Basic.lean`) [R §2.2]. Its own files are
  inconsistent on this point (§2.3). Under the owner's order of sources Tau Ceti's bundled
  category wins [J]. What is left is a question of style for step 2: keep the re-export alias,
  or write `TauCeti.ReductiveAffineGroupSchemeCat k` directly [J].
- **With GLC I on the dual group's base field** [R node, J]: the node defines `Ĝ` over `ℂ` or an
  algebraically closed field of characteristic 0. GLCinLean's `Setting` puts `Ǧ` over the same
  `k` (`Abstract.lean` l.66). For the statement the two agree when `k` is algebraically closed of
  characteristic 0. They differ for the general Langlands dual the node describes; the
  difference does not matter for GLCinLean.
- **Internal:** README v4.28.0 versus v4.33.0; TODO's "sorry-free" versus 26 `sorry`s;
  a README directory that does not exist; conventions §6 versus the ledger on how `X^*` is
  defined [R §2.3].

## 5. Input for the open questions (workflow.md)

- **What goes into `AGENTS.md`, and where "update the next prompt" lives.** Suggests [J]: keep
  `AGENTS.md` short, but keep binding rules in one named place and put after-generation checks
  in the prompts ("before committing, check each new definition against the sentence it
  transcribes"), since prose rules "far back in context do not fire". A short burn log ("what
  went wrong, the rule that now prevents it, date") is a natural home for lessons, as long as it
  is pruned. The source has no rule for updating prompts; its nearest mechanism is the audit
  written into each commit message, which could also be where a session says whether it changed
  the next prompt.
- **Whether `PLAN.md` is needed.** Suggests [J]: the source keeps a roadmap (`TODO.md`) and a
  settled-decisions ledger apart from the prompts, and its roadmap went stale (§2.3). A small
  ledger of settled design decisions (statement shape, placeholder rule, which provider each
  object comes from) is worth keeping even if the plan moves into prompts. Status that changes
  often is better derived from the code than written in prose.
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.**
  Supports the placeholder design (the "BLOCKED, not a weakened fake statement" rule) [R, J].
  Adds two checks for step 2 [J]: each placeholder's docstring quotes the GLC I sentence it
  stands for (the transcription rule), and when a placeholder is replaced, the replacement is the
  paper's definition, with any convenient equivalent form as a separate bridge lemma. The
  `ReductiveGroup` re-export alias breaks the letter of this source's "no named bundled alias"
  rule but follows Tau Ceti's bundled category, which ranks higher; this is a style question
  only (§4). For `RootDatumDuality` [R survey, J]: when it is filled, it should state an
  isomorphism between Mathlib `RootDatum`s (attached to each group through a maximal torus), not
  a new root-datum type. Over an algebraically closed `k`, as GLCinLean assumes, every reductive
  group is split, so only the split case is needed [J].
- **What happens to each existing file.** For `blueprint/`: mdblueprint (Markdown nodes, a
  `uses:` DAG, a Lean reverse check, a static site) is a working alternative to a TeX
  blueprint, but it is unlicensed and almost single-author (GitHub: `jiajunma` 171
  contributions, one other contributor with 1) [R, J]. For the
  review system: the Lean ↔ node link check is worth borrowing as an idea; the review status
  model is weaker than the owner's commit-hash design. Nothing here bears on
  `references/papers/manifest.toml`; the source's own reference directory is missing.
- **Who reviews the mathematics, and to what standard.** The source's rule is that independent
  review by the "owner, or a second model" with the adversarial prompt is mandatory for
  definition-layer commits. Either one is enough, and the owner sees new statements before the
  proof pass [R checklist]. In its history the defects were "owner-caught": the owner caught
  faithfulness errors that the generating agent made repeatedly [S]. The history does not show
  the second-model review catching them [J, from the commit messages and burn log]. Suggests [J]: fresh-agent review alone is weakest exactly on definitions, so GLCinLean
  should (a) use the transcription rule so that faithfulness can be checked mechanically against
  the paper's text, (b) give definitions and the statement surface a separate adversarial review,
  and (c) seek an outside expert for the definitions of the statement, if possible.
- **Where research notes and session summaries live.** The source commits dated research notes,
  specs and plans under `docs/superpowers/{research,specs,plans}/` (e.g.
  `research/2026-07-17-root-system-root-datum-mathlib-state.md`), and also the proof skill's
  state file `.sorry-crusher/PROGRESS.md`. Inside the knowledge base, only `nodes/` is "durable
  truth"; `staged/`, `reviews/` and the others are "pipeline working dirs" [R `AGENTS.md`
  l.126–127]. Suggests committing research notes with dates in their file names, and keeping them
  apart from the files that hold the project's current state [J].

## 6. Questions for the owner

1. **Adopt the transcription rule?** Should "each definition's docstring quotes the paper's
   definiens, and each Lean object answers to a word of it; convenient forms are bridge lemmas"
   be a standing rule in the new `AGENTS.md` or in the build prompt?
2. **A small settled-decisions ledger?** Should the rebuild keep one (in `PLAN.md` or its
   replacement), changed only with your approval, even if the plan itself moves into the prompts?
3. **After-generation checks versus "prompts alone".** This source needed a checklist and a linter
   after prose rules failed. Are a short checklist inside the prompts, and possibly a small lint
   script, still within "a very simple way", or should the workflow stay prompt-only and accept
   the risk?
