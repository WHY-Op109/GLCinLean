# NumLib-Auto

- **Source:** `bridgekat/numlib-auto`, an LLM-written numerical-analysis library in Lean.
- **URL:** <https://github.com/bridgekat/numlib-auto/tree/9daf9e783a4488ba2f3f9d633c17e1e736fa5d32>
  (commit `9daf9e78`, 2026-11-05, "Update tracker submodule for graph metrics"; the head of `main`
  when cloned and still on 2026-11-08 by the GitHub API; 897 commits since 2026-09-04).
- **Submodules at that commit:** `tools/tracker` = `bridgekat/tracker` @ `c223b672` (the same
  commit `notes/ideas.md` links and GLCinLean's own `tools/tracker` submodule pins; GLCinLean's
  `lakefile.toml` requires it by path); `tools/metrics` =
  `bridgekat/metrics` @ `55248898` (the commit `notes/ideas.md` links).
- **Published page:** <https://bridgekat.github.io/numlib-auto/> (dependency graph) and
  <https://bridgekat.github.io/numlib-auto/docs/Numlib.html> (API docs). Last modified
  2026-11-05 14:53 GMT, built by CI run 41983446590 from commit `9daf9e78`, so the page and the
  commit read here agree.
- **Checked 2026-11-08.** Read in full: `README.md`, `CONTRIBUTING.md` (current, and the version
  of 2026-10-20, `2e0b88bf`, the last before the 2026-10-23 rewrite), all six files in `prompts/`, `plans/README.md`, `notes/README.md`,
  `notes/mathlib-migration.md`, `references/README.md`, `scripts/README.md`, the `.gitignore`
  files, the three workflows in `.github/workflows/`, `lakefile.toml`, `lean-toolchain`, the
  tracker's `README.md`, and the parts of the tracker's `Tracker/Check.lean` and
  `Tracker/Types.lean` that decide a declaration's state. Sampled: two plan files, one surface
  index file and one surface section file, the first review file in the history
  (`plans/review/backbone-review-v0.md`, deleted 2026-09-04), the README of
  `bridgekat/tracker-graph-explorer` @ `bbd8cc67`. Decoded the graph baked into the published
  page, and parsed all 1,571 plan TOML files for the keys they use. Not read: the 1,496 Lean
  files under `Numlib/` and `NumlibSurface/` beyond the samples; `tools/metrics`
  (it has its own note); the graph explorer's source.
- **Unreachable:** the working notes `notes/README.md` lists (`lessons.md`, `frontier.md`,
  `backbone.md`, the per-round briefs and ledgers) are gitignored and not in the repository.
  `plans/` and `scripts/` have no `.github` review records either.
- **Local copy:** `.lake/research/numlib-auto/` and the page at `.lake/research/numlib-auto-site/`
  (Git ignores both).
- **Licence:** Apache 2.0 (repository and tracker); the graph explorer is MIT. The Lean files
  carry "Copyright (c) 2026 Great Bay University … Released under Apache 2.0 license" (added in
  `7ebbafd5`); the prompt files have no header [R]. Prompts and rubrics can be copied or adapted
  with a notice naming that holder [J].

Tags: [R] read directly in the source on 2026-11-08; [S] a source's claim about itself; [E]
estimate; [J] judgement. A tag covers the sentence or bullet it ends.

---

## 1. What it is

- A Lean library of numerical analysis "with two layers: a general **backbone** and a
  textbook-matching **surface**" [R]. Described as "An LLM-generated numerical analysis
  library" [S].
- Size at `9daf9e78`, from the graph baked into the published page [R]:
  - 43,080 declarations in 1,676 modules; 28,219 of them are *planned* (named in a plan);
    every declaration is in state `proved` (no `sorry`, standard axioms only).
  - Backbone `Numlib`: 26,879 declarations (17,008 planned); 522,112 lines of `.lean` (`wc -l`,
    comments included).
  - Surface `NumlibSurface`: 16,201 declarations (11,211 planned); 350,535 lines; nine books
    (Atkinson–Han, Brezis, Cartis–Gould–Toint, Conn–Gould–Toint, Fong–Saunders, Golub–Van Loan,
    Quarteroni–Sacco–Saleri, Rockafellar, Saad), one directory each under `NumlibSurface/`.
  - Kinds in the graph: 36,246 theorems and 6,834 definitions; no node carries any review field
    (the keys present are `id`, `kind`, `module`, `state`, `planned`, `desc`, `source`, `deps`,
    `lines`, `chars`, `size`).
- Built in about two months (2026-09-04 to 2026-11-05) [R, from the Git log]. Commits are by
  Zhanrong Qiao (635) and Hongyu Wang (261), plus one by the Lean VS Code extension [R]. The
  co-author lines name several agents: Claude (Opus 5, Opus 5.5, Fable 5.1; 702 lines in all) and
  Codex (160) [R]. The name Hongyu Wang is also this repository's Git user [R].
- **The current prompts came late** [R]. All six files in `prompts/` were added in one commit,
  `0fb2d9b9` (2026-10-23, "misc: new prompts"), when 1,169 of today's 1,498 Lean files already
  existed; the Cartis–Gould–Toint and Conn–Gould–Toint surfaces were built after it (266 commits).
  Most of the library was therefore built under the earlier `CONTRIBUTING.md` and the gitignored
  per-round briefs and scripts, and the prompts are a distillation written afterwards [J].
- Versions [R]: `lean-toolchain` = `leanprover/lean4:v4.36.0-rc2`; Mathlib `rev = "v4.36.0-rc2"`
  (manifest commit `9d581dff`), required **directly**, with no Tau Ceti. `allowNonModules = true`
  ("Mathlib now requires the module system; this project knowingly stays on non-module files").
  GLCinLean is on the same Lean version, `v4.36.0-rc2`, with Mathlib through Tau Ceti [R, from
  GLCinLean's `lakefile.toml` and `lean-toolchain`].

## 2. What it says that matters for GLCinLean

### 2.1 Backbone and surface (`README.md`, `prompts/plan-rubrics.md`)

- **Backbone** [R]: "the *canonical* definitions and *actual* proofs for theorems, with theorem
  statements in their *natural and general* forms". "The natural level of generality at the
  backbone is often determined by *which structures are being used* downstream." The backbone
  "need not adhere to the structure of the source material"; its directory tree is
  "a Mathlib-style Lean module hierarchy" (`Numlib/Analysis/…`, `Numlib/LinearAlgebra/…`).
- **Surface** [R]: one library per book, "theorem statements faithful to the book … Every
  numbered item in a book maps to a planned declaration." Proofs are "mostly *direct uses and
  specializations* of results in the backbone". "Definitions may be created here for semantic
  alignment, but it is desirable to accompany those with equivalence proofs to the backbone
  versions." "Consider the surface as integration tests, specified by product requirements
  written in the books, that the backbone implementation must pass."
- **Surface naming** [R]: module `NumlibSurface.<source>.[Chapter<number>].[Section<number>]`
  (papers without chapters skip `Chapter`); declarations named after the source's numbering,
  e.g. `AtkinsonHan.Chapter01.theorem_1_1_10`, `definition_1_1_3`, `definition_1_1_3_iff`.
- **Surface conventions seen in a sample** (`NumlibSurface/AtkinsonHan/Chapter01/Section01.lean`)
  [R]: a module doc with `## Main definitions`, `## Main results`, `## Conventions` and
  `## Not formalized here`; a book definition that Mathlib already has is restated under the
  book's number with an `…_iff` back to the Mathlib notion; a structure the book defines (a
  linear space) becomes a `theorem` that Mathlib's class satisfies the book's axioms.
- **Surface dependencies** [R]: "within a surface library the dependencies run forwards in the
  direction of the chapter numbering, and where an earlier chapter has already restated
  something, later chapters use that restatement".
- Backbone doc comments must be self-contained: "cite the source explicitly instead of writing a
  mere number like 'Theorem 3.7'. Mere numbers may be used in surface only" [R, `CONTRIBUTING.md`
  at `2e0b88bf`, 2026-10-20; the current rubrics keep the self-contained rule].

### 2.2 Plans drive the work through the tracker (`prompts/plan.md`, `prompts/proof.md`, tracker README)

- A plan is one TOML file per Lean module under `plans/`, at the module's path
  (`plans/Numlib/Krylov/CG.toml` for `Numlib.Krylov.CG`) [R]. Each `[[node]]` is a planned
  declaration: `id`, `kind`, `desc`, `deps` (suggested dependencies), optional `source`,
  `wrong`, `deprecated`; the module has `namespace` and `desc` [R]. Any other key is an error [R].
- "**The library supersedes the plan.**" Once the declaration exists, its `kind`, doc comment
  and real dependencies replace the plan's copy, and `lint` warns that the plan's field can be
  removed [R]. Finished plans keep only ids and `source`, "as a record for which declarations are
  the most important" [R]. Parsing all 1,571 plan files: 28,219 nodes, 11,906 with `source`, 194
  still with `deps`, 36 still with `desc`, none marked `wrong` or `deprecated`; 147 files keep a
  module `desc` (design notes for directory-only groups) [R].
- States read from the compiled library [R]: `open` (id does not resolve), `stated` (depends on
  `sorryAx`), `proved` (only `propext`, `Classical.choice`, `Quot.sound`), `axioms` (any other
  axiom), `wrong` (marked in the plan).
- Commands [R]: `check`, `status`, `ready` (modules whose outside dependencies are proved),
  `show <module|id>` (the brief for a sub-agent), `lint`, `graph [--all] [--metrics] [--dot]`.
- The work loop in `prompts/proof.md` [R]:
  1. `lake exe tracker ready` lists what can be done now;
  2. parallel sub-agents, one module each, each in its own worktree, started with
     `tracker show <module>`; they may mark `wrong`, amend their own module's plan, or report a
     "negative outcome";
  3. "Before merging a sub-agent's work, have an independent reviewer check its diff";
  4. `tracker lint`, remove superseded fields; build; check standard axioms; repeat until
     `tracker status` shows no `open`, `stated` or `wrong`.
  "A task is done when main's check says every planned declaration is proved, never when a report
  says so" [R, tracker README].
- Skipping is allowed and recorded: "1%-5% numbered items in a textbook may take significantly
  more time … Such can be skipped as long as they are clearly documented" [S]; the surface
  module doc's `## Not formalized here` is where [R].
- Refactors (`prompts/refactor.md`) [R]: write a new plan "as if starting from scratch", mark
  removed nodes `deprecated`, formalize the new plan until `lint` shows no deprecated node left.

### 2.3 How reviews are done and recorded

- **Plan review** [R]: "by a fresh agent or an independent sub-agent given the source material,
  the plan itself, `main.md`, and `plan-rubrics.md`, with little context from the author's
  reasoning." "Treat the review process as a search for better (structures of) proofs."
- **Formalization review** [R]: same set-up with `proof-rubrics.md`; plus a diff review before
  every merge. The earlier `CONTRIBUTING.md` asked for "'adversarial' goals" [R].
- **Rubrics** [R]: `plan-rubrics.md` (30 lines: generality, no duplication with Mathlib or the
  project, symmetry, extensibility, Mathlib naming) and `proof-rubrics.md` (25 lines: short
  lemmas, bundled interfaces, characterising API so no other file unfolds a definition, eager
  Mathlib instances, Mathlib doc style, no work history in doc comments, and **semantic alignment
  checks**). The alignment checks matter most for GLCinLean [J]; their wording [R]:
  - "Successful compilation establishes neither source faithfulness nor the intended
    mathematical content."
  - "Inspect the definitions they depend on; matching names or prose is not sufficient."
  - "Check quantifier order, implication directions, hypotheses, and zero, empty, or other
    degenerate cases. Reject vacuous statements caused by unintended impossible assumptions or
    trivial stand-ins for the intended objects."
  - "Do not move a theorem's conclusion into an assumption, axiom, or structure field to make its
    proof succeed."
- **Where reviews are recorded** [R]: nowhere structured. Review rounds appear as commit messages
  ("refactor(review fix G1, agent/g1): …", "fix(cgt): Chapter 3 review follow-ups …") and, per
  `notes/README.md`, in gitignored notes (`gvl/review/*.md`, ledgers). One early review was
  committed as `plans/review/backbone-review-v0.md` and deleted the same day ("drop the addressed
  review"). 25 commit subjects mention a review [R].
- **Reviews found vacuous statements in proved code** [R, commit subjects]. After the
  Cartis–Gould–Toint surface was proved, review follow-ups fixed "non-vacuous full-rank
  hypotheses" (`d16538e5`) and "non-vacuity of Thm 12.2.14(ii)" (`cc7ca08f`), among others. So in
  this project `proved` for every declaration did not mean faithful, and the rubric-driven review
  caught real faults [J].
- **Per-declaration review status: not tracked** [R]. The plan schema has no review field, any
  other key is a lint error, and the tracker's cache entry holds id, kind, module, line, axioms,
  references, signature, doc comment and lines, chars and size, with no content hash and no
  reviewer or commit.
- References: agents add BibTeX entries to `references/references.bib` and "Each reference you
  add must be marked `# GENERATED` to be reviewed by the user" [R]; 16 of 51 entries carry the
  mark [R] (the bib file's own header asks that they "be reviewed by a human"). This is the one
  human-review hook in the repository [J]; whether a human did review them cannot be seen [J].

### 2.4 How the web page is generated (`.github/workflows/lean_action_ci.yml`)

On every push, on every pull request, and by hand (`workflow_dispatch`) [R]:
1. checkout with submodules; checkout `bridgekat/tracker-graph-explorer` (unpinned, "its default
   branch; pin with `ref:`");
2. `leanprover/lean-action@v1` builds;
3. `lake exe tracker check`, then `lake exe tracker graph --all --metrics > numlib.json`;
4. `npm ci && npm run build` with `TRACKER_GRAPH` set, which bakes the gzipped graph into one
   `index.html` (9.7 MB as published [R]);
5. `leanprover-community/docgen-action@main` with `api-docs: true`, `blueprint: false`,
   `references: references/references.bib`, publishing `docs/` (explorer at the root, API docs
   at `docs/docs/`) to GitHub Pages.

The explorer [R, its README]: one box per area, opening into modules and declarations; colour by
kind, fill by share proved, bold outline for planned, coloured outline for `wrong` or extra
axioms; a Count dropdown (declarations, lines, characters, term size); search; URL fragments link
to a node. It shows **no review state**, because the graph JSON has none [R]. The build jobs of
the last three successful runs took 2 h 49 min, 26 min and 2 h 1 min; 14 of the repository's 141
Actions runs failed [R, GitHub API, 2026-11-08].

### 2.5 How much harness

- [R] Six prompt files (150 lines in all), three READMEs, one committed note
  (`notes/mathlib-migration.md`), the tracker (about 2,000 lines of Lean, a submodule), the
  metrics tool (a submodule, not used by CI or the prompts), the graph explorer (external,
  built in CI), three GitHub workflows. `notes/` and `scripts/` are gitignored except their
  README: "the orchestrator prunes them between rounds so that no agent has to read history to
  work" [R].
- [R] No `AGENTS.md` or `CLAUDE.md`. The entry point is `CONTRIBUTING.md`, which tells the user to
  prompt an agent: "Formalize all numbered definitions and propositions the given textbook …
  Follow instructions in prompts/main.md", optionally as a "goal".
- [R] No custom checks in CI beyond the build and `tracker check`; no sorry budget, statement pin
  or attribute.
- [J] The repository is small in harness; the hidden harness was in gitignored notes and helper
  scripts (`brezis/checkplans.py`, `absorb.py`, `movenodes.py`, …, listed in `notes/README.md`),
  which grew per round and are not published.

### 2.6 Orchestration rules (`prompts/main.md`)

[R] The orchestrator gives each sub-agent: the goal with the prompt files, the source material,
the expected scope ("a suggestion, not a hard constraint"), and the expected working time. A
sub-agent may finish with a negative outcome when the task "is ill-specified, impossible, or …
would require far more time and effort than anticipated". Each sub-agent works in its own Git
worktree; its work is squash-merged as one commit. "Each agent should base decisions on the
overall quality of the project, rather than merely finishing the assigned tasks quickly." Tools:
Lean LSP and LeanSearch over MCP, else CLI (`https://leansearch.net/?q=`).

### 2.7 Keeping up with Lean and Mathlib

- `.github/workflows/update.yml` uses `leanprover-community/mathlib-update-action@v1`: a PR if the
  update builds, an issue if it fails; **the daily schedule is commented out**, so it runs only by
  hand, and the GitHub API shows it has **never run** (0 runs) [R]. `create-release.yml` tags a
  release when `lean-toolchain` changes; it made the one release, `v4.36.0-rc2`, on 2026-11-02
  [R].
- The last bump (v4.35.0-rc2 → v4.36.0-rc2, 2026-11-02) is recorded in
  `notes/mathlib-migration.md` [R]: about 1,450 upstream commits; 245 files changed; nine full
  builds; about 875 sites from Mathlib protecting `Matrix.mul_apply` and friends, about 55 from
  `Set` becoming a structure, about 90 from `MeasurableSet` → `NullMeasurableSet`; "No theorem
  statement changed." It lists ten proof-writing habits that would have avoided the breakage
  (qualify names in opened namespaces; eta-expand set membership; avoid `rw …; rfl`; use
  `convert … using n`; pass auto-param proofs in statements; prefer named arguments) and a recipe
  for the next bump (grep the Mathlib diff for `^+protected theorem` and `^+@[deprecated` first;
  expect several build passes; `lake env lean` does not pass `leanOptions`) [R].

## 3. What it means for GLCinLean

- **A library, not a one-off** (ideas.md "The formalisation" 1). The backbone is the library for
  geometric representation theory; the surface is the GLC I statement (and later the proof's
  numbered results) under the paper's numbering. This is the "backbone versus surface" split that
  workflow step 2 already names [J]. A GLC surface module would be, for example,
  `GLCinLeanSurface.GLC1.Section01_6` with `conjecture_1_6_7` [J].
- **Plans and the tracker.** GLCinLean already pins the same tracker commit and has
  `blueprint/plans/` [R]. The tracker's default plan directory is `<root>/plans` [R]; with
  `blueprint/plans/` every call needs `--dir blueprint/plans`, or the directory moves [J]. The
  tracker's loop (`ready` → `show` → worktree sub-agent → diff review → `status`) fits workflow
  steps 2–4 and 6 almost unchanged [J].
- **Placeholders show as `proved` in the tracker** [J, from the code read]. The tracker counts an
  `opaque` as a declaration (`isHandWritten` in `Tracker/Check.lean` accepts `.opaqueInfo`) and
  decides its state only from axioms (`Tracker/Types.lean`, `CacheEntry.state`) [R]. GLCinLean's
  pattern (`opaque DGCatPt : NonemptyType`, then `@[placeholder] def DGCat : Type :=
  DGCatPt.type`, and plain `@[placeholder] opaque DGCat.IsCompact … : … → Prop`) depends on no
  axiom at all: a copy of it run through Lean on 2026-11-08 printed "does not depend on any
  axioms" for each constant and for a theorem using them [R]. So the tracker would mark them
  `proved` and the graph would show the GLC statement resting on "proved" objects [J, following
  from the code read]. Either the placeholder needs a `sorry`-like marker the tracker sees, or
  the review system must read `@[placeholder]` and show it [J]. This bears on the AGENTS.md
  placeholder note and on step 2's "decide whether … their placeholders stay or change".
- **Reviews.** The review system the owner wants (ideas.md "Review status") is exactly what
  numlib-auto lacks: per-declaration, commit-pinned, invalidated by change. The graph JSON
  (`tracker graph --all`) is a ready input: every declaration with id, module, kind, state,
  real dependencies [R]. The review system can join it with its own record of
  `id → reviewed at commit, content hash` and colour the same explorer [J].
- **What "unchanged since review" should mean** [J]. A statement's meaning depends on the
  definitions it mentions. If only the declaration's own text is hashed, a changed definition
  upstream would leave a reviewed statement marked "reviewed". The hash for a *statement* review
  should cover its type and the definitions its type reaches; for a *proof* nothing needs review
  once it is `proved`, only its statement [J]. The tracker's `refs` give that set only inside the
  project: they stop "at anything outside the project (Mathlib, core)" [R], so a change in a Tau
  Ceti or Mathlib definition after a pin bump would not show [J].
- **Semantic-alignment rubric.** The four sentences quoted in 2.3 are the best short statement
  found so far of what a fresh reviewer must check against the paper (workflow step 4, and
  "Who reviews the mathematics") [J]. They match the AGENTS.md placeholder warning ("would make
  the statement say less than it appears to") [R both].
- **Papers.** numlib-auto keeps the source texts gitignored under `references/` and commits only
  `references/references.bib`, which docgen uses for citations like `[han2009theoretical]` [R].
  This is the owner's preference in ideas.md 5 ("TeX files directly, untracked by Git") plus a
  `.bib` that also feeds the Mathlib-style doc citations, in place of
  `references/papers/manifest.toml` [J].
- **Keeping up** (workflow decision "Keeping up with Mathlib and Tau Ceti is fully automated").
  numlib-auto shows a bump done by agents in one session with a recorded lesson file, but its
  update workflow is manual and has never run [R]. GLCinLean needs Tau Ceti's pin moved, not
  Mathlib's directly; the migration note's §2 habits and §3 recipe can be copied into the refactor prompt [J].
- **Notes and history.** numlib-auto commits only an index (`notes/README.md`) and durable
  lessons; round notes are gitignored and pruned; the Git log carries history [R]. This is one
  answer to "where research notes and session summaries live" [J].

### What GLCinLean can copy as it is [J]

- The backbone/surface definitions from `README.md` (with "textbook" → "paper").
- `prompts/plan-rubrics.md` and `prompts/proof-rubrics.md`, nearly word for word; the semantic
  alignment checks especially.
- The tracker plan format and the `proof.md` loop (`ready`, `show`, worktree per module, diff
  review before merge, "done when main's check says so").
- The CI recipe in `lean_action_ci.yml` for the web page (tracker graph + explorer + docgen), with
  the explorer pinned by `ref:`.
- The `# GENERATED` mark for agent-added references, and `notes/mathlib-migration.md` §2 as
  proof-writing advice.
- The surface module-doc layout (`Main definitions`, `Main results`, `Conventions`,
  `Not formalized here`).

### What needs adapting [J]

- **The order of sources.** numlib-auto knows only Mathlib and itself. GLCinLean needs Mathlib →
  Tau Ceti → Stacks, and "write the Tau Ceti version and contribute it" for roadmap items
  (ideas.md 3–4). The duplication rubric must name Tau Ceti.
- **One statement, a very long proof.** numlib-auto's surface is thousands of small items each
  easy from the backbone; GLC's surface is one conjecture (plus a few definitions) whose
  backbone cone is huge. The split still works, but `tracker ready` will long show only
  backbone modules; the surface is written first with `sorry` (state `stated`), which the
  tracker allows ("Planned declarations may be merged while `stated`") [R for the quote].
- **Prompt shape.** numlib-auto's prompts are procedures ("the orchestrator agent should: …").
  Workflow decision: prompts hold "only the goal, the completion criteria and the context, with
  few constraints". The rubrics fit better as context files cited by the prompts, or in
  `AGENTS.md`.
- **`main.md` into `AGENTS.md`.** The orchestration rules of `prompts/main.md` (2.6) are what
  workflow says goes in `AGENTS.md`.
- **Pushing.** numlib-auto's prompts say nothing about pushing; GLCinLean's decision is that
  agents push at each important step.
- **Placeholders** (see above): the tracker needs a way to show them as not real.
- **The CI cost.** A 2–3 hour CI on every push is affordable for numlib-auto; for GLCinLean the
  cost depends on the Tau Ceti cache [E].

## 4. Conflicts

- **With ideas.md "The review system"**: numlib-auto has no per-declaration review status, no
  commit pins and no review record beyond commit messages and gitignored notes [R]. The owner's
  description of NumLib-Auto as "a good example of how to do the review system" holds for the
  dependency graph and the review *process* (fresh agents, rubrics, diff review before merge),
  not for review *status* [J].
- **With ideas.md "Output: a web page … with the dependency graph and review tags"**: the page
  has the graph but no review tags [R].
- **With ideas.md 3–4 (Tau Ceti)**: numlib-auto requires Mathlib directly and contributes to no
  upstream [R]; its "upstreaming candidates" live in a gitignored `followups.md` [R].
- **With the workflow decision on prompt shape**: see "Prompt shape" above [J].
- **With the workflow decision "Keeping up … fully automated"**: numlib-auto's update workflow
  has its schedule commented out and has never run [R, workflow file and GitHub API]; its one
  recorded bump was an agent session (the migration note) [R], started by hand [J].
- **With GLCinLean's `AGENTS.md`**: `lake update` is left to the owner there; in numlib-auto
  agents bump the toolchain [R]. workflow.md already lists this as a known conflict [R].
- **Within numlib-auto**: `weak.linter.style.header = false` with the comment "no Mathlib
  copyright headers in this project", yet commit `7ebbafd5` (2026-11-05) added Mathlib-style
  copyright headers to the Lean files [R]. Minor: the comment is out of date, the linter merely
  stays off [J].
- **With ideas.md "do the whole formalisation with prompts alone"**: the 150 lines of prompts
  were written after most of the library existed (see section 1); the earlier rounds also relied
  on long gitignored briefs and helper scripts [R]. numlib-auto is evidence that short prompts
  plus the tracker can run later rounds, not that they alone built the library [J].
- **With Mathlib style** (ideas.md "fully in Mathlib's documentation style"): non-module files
  (`allowNonModules = true`) and surface names like `theorem_1_1_10` are outside Mathlib's naming
  convention [R]. For a surface layer this is reasonable [J].

## 5. Input for the open questions

- **What goes into `AGENTS.md`, and where "update the next prompt" lives.** numlib-auto puts
  shared rules in `prompts/main.md` and points to it from `CONTRIBUTING.md` [R]. Suggests [J]:
  `AGENTS.md` takes `main.md`'s content (backbone/surface in two sentences, sub-agents in
  worktrees with squash merges, negative outcomes allowed, "base decisions on the overall quality
  of the project", "read `tools/tracker/README.md` before touching the plan" as the tracker
  README asks [R]), and cites the two rubric files rather than copying them.
- **Whether `PLAN.md` is needed.** In numlib-auto the plan *is* `plans/*.toml`, queried with the
  tracker; prose plans are "temporary notes only as supplementary material" [R]. Suggests [J]:
  no `PLAN.md`; the tracker plans carry the plan; a short module `desc` carries the design notes;
  the goal and decisions sit in `AGENTS.md` and `notes/workflow.md`.
- **Whether `Abstract.lean`, `Foundations.lean` and their placeholders are reasonable.**
  Suggests [J]: `Abstract.lean` is a surface module (paper-faithful statement), `Foundations.lean`
  is backbone. numlib-auto's rule "Definitions may be created here [surface] for semantic
  alignment … accompany those with equivalence proofs to the backbone versions" [R] says where
  paper-shaped definitions go. Placeholders must be visible to the tracker or the review page
  (see section 3); otherwise they are "trivial stand-ins for the intended objects", which the
  proof rubrics tell reviewers to reject [R for the quote].
- **What happens to each existing file.**
  - `tools/tracker` and its `require`: keep; same commit as numlib-auto [R].
  - `blueprint/plans/`: keep the content, perhaps move to `plans/` to use the tracker default [J].
  - `references/papers/manifest.toml`: replace by a committed `references.bib` (needed by docgen
    for citations) plus gitignored TeX [J].
  - `reviews/`, `glc/project.toml`, ReviewKit: numlib-auto has no counterpart; it works without a
    sorry budget or statement pin because the tracker's `status` reports `stated` and `axioms`
    states [R]. Whether GLCinLean still needs them depends on the review system [J].
- **Who reviews the mathematics, and to what standard.** numlib-auto: fresh agents with little
  author context, given the source and the rubrics; a diff review before every merge; the only
  human check the repository asks for is on references marked `# GENERATED` [R]. Those reviews
  did find vacuous proved statements (section 2.3) [R for the commit subjects]. The standard is the semantic-alignment
  section of `proof-rubrics.md` [R]. Suggests [J]: the same for GLCinLean, with the review
  system recording the outcome per declaration so that an outside expert, if one is found, can
  see what an agent checked and when.
- **Where research notes and session summaries live, and whether they are committed.**
  numlib-auto: in `notes/`, gitignored except `README.md` (an index with "read it when") and
  durable lessons such as `mathlib-migration.md`; pruned between rounds; history in the Git log
  [R]. Suggests [J]: commit only what a future session must read (index, lessons, decisions);
  session summaries go in commit messages. Against this: the owner cannot read gitignored notes
  on another machine or on GitHub [J].

### "Two patterns, or is one enough?" (ideas.md)

[J] numlib-auto answers with **one repository, one tracker, two layers**, not two patterns:
- the *library* pattern is the backbone (general, Mathlib-organised, reusable);
- the *single statement* pattern is the surface (paper-faithful, numbered, a thin layer whose
  proofs call the backbone).
The same plan format, states and graph serve both; the difference is only which rubric section
applies. For the review system this suggests one design with a per-declaration *kind of review*:
statements on the surface reviewed against the paper (faithfulness), backbone declarations
reviewed against the library standards (generality, duplication, style) and, for definitions,
against their intended mathematical meaning. A long proof needs no review of its own once the
kernel accepts it; what needs review is the statement and the definitions it reaches [J].
numlib-auto's own review history supports this: its faults were vacuous or mis-stated
statements, found after everything was `proved` [R for the commit subjects; J for the reading].
One difference is real: numlib-auto may skip the 1–5% of hard items with a note [S], while the
single-statement pattern cannot skip its one statement, so its progress cannot be read off a
share of proved items [J]. A
second pattern would be needed only if the GLC proof is kept outside the library (a one-off
script of long Lean), which ideas.md 1 rules out [J].

## 6. Questions for the owner

1. **Layer names and layout.** Adopt numlib-auto's split literally (`GLCinLean` backbone,
   `GLCinLeanSurface` with `GLC1.Section…` modules and `conjecture_1_6_7`-style names), or keep
   one library with `Abstract.lean` as its surface file?
2. **Plan directory.** Move `blueprint/plans/` to `plans/` (the tracker default), or keep it and
   pass `--dir` everywhere?
3. **Placeholders in the tracker.** Should a placeholder count as `stated` (give it a `sorry` the
   tracker sees) or stay `proved` with the review page marking `@[placeholder]` separately?
4. **What a review pin covers.** Should "unchanged since review" mean the declaration's own text,
   or its statement together with every definition the statement reaches?
5. **Copying the prompts.** Copy `plan-rubrics.md` and `proof-rubrics.md` (Apache 2.0, with a
   notice) as GLCinLean's rubrics, adapted for Tau Ceti and the source order, or write new ones?
6. **Notes.** Keep round notes gitignored and pruned (numlib-auto's way), or commit them so they
   can be read on GitHub?
7. **CI and the web page.** Build the graph page in GLCinLean's own CI on every push (numlib-auto
   takes 0.5–3 hours per run), or only in the separate review-system repository?
