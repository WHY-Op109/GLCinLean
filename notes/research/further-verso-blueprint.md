# Verso Blueprint and doc-gen4 as bases for the review page

- **Sources:**
  - Verso Blueprint: [`leanprover/verso-blueprint` @ `4943d333`](https://github.com/leanprover/verso-blueprint/tree/4943d3335ffa9221a39949e60836a8ad5dc2a456)
    (2026-10-23, head of the default branch `v4.35.0`; the repository has no `main`).
  - doc-gen4: [`leanprover/doc-gen4` @ `0e9ef140`](https://github.com/leanprover/doc-gen4/tree/0e9ef1409ea645416c558ce19b59f3ae1198dfc2)
    (2026-11-03, head of `main`, toolchain `v4.36.0-rc2`, the same commit `mathlib-doc-style.md` read).
- **Checked 2026-11-08.**
- **Licences:**
  - doc-gen4: Apache-2.0 (`LICENSE` file; GitHub reports `Apache-2.0`) [R].
  - Verso Blueprint: **unclear**. There is no `LICENSE` file at this commit or anywhere in
    the Git history (`git log --all -- LICENSE` is empty), and GitHub reports no licence. Yet
    110 of its Lean files carry the header "Copyright (c) 2026 Lean FRO LLC ... Released under
    Apache 2.0 license as described in the file LICENSE" [R]. So the stated intent is
    Apache-2.0, but the file that would grant it is missing. Before copying any of its code,
    ask upstream or wait for the file [J].
- **What was read** [R 2026-11-08]:
  - Verso Blueprint: `README.md`, `lakefile.lean`, `lake-manifest.json`, `branch-policy.json`,
    `project_template/{lakefile.lean,lean-toolchain,ProjectTemplateMain.lean}`; `doc/MANUAL.md`
    (attribute matrix, existing declarations, metadata, dependency graph, completeness
    semantics, limits), `doc/API.md` (scope, choosing an API, graph data, completeness
    evidence), `doc/MAINTAINER_GUIDE.md` (release lines, toolchain bumps);
    `src/VersoBlueprint/{ProvedStatus,SorryAnalysis,Vbp,VbpMain(usage),Git(head)}.lean`, the
    status part of `Graph.lean`; `skills/verso-blueprint/SKILL.md`; the toolchain history
    (`git log -- lean-toolchain`), the branch list, open issues, contributors. For context:
    the lakefile of the reference blueprint `ejgallego/verso-flt` (via `gh api`) and the body
    and file list of infinity-cosmos draft PR #193.
  - doc-gen4: `README.md`, `lakefile.lean`, `Main.lean` (the `fromDb` command),
    `DocGen4/DB/Schema.lean` (tables), `DocGen4/Process/{Attributes,OpaqueInfo,DefinitionInfo,
    TheoremInfo,DocInfo}.lean` (parts), `DocGen4/Output/{Base,Module,ToJson}.lean` (parts),
    `DocGen4/Output.lean` (`htmlOutputResultsParallel`), the toolchain history and tags; PR #344
    (the decorator hook), the status of PR #396; the README of
    `NicolasRouquette/doc-verification-bridge` (head `933cd2b6`), which uses that hook. Also Tau
    Ceti's `docbuild/lakefile.toml` at GLCinLean's pin (`e0610cc`).
  - Clones (Git-ignored): `.lake/research/verso-blueprint/`, `.lake/research/doc-gen4/`.
- **Not done:** neither tool was built or run. Everything about behaviour comes from reading
  code and documentation, not from running them on GLCinLean. No claim here is about
  mathematics.

Tags: [R] read directly, [S] a source's claim about itself, [E] estimate, [J] judgement. All
dated 2026-11-08.

## 1. What it is

### Verso Blueprint

- A Lean package for writing a blueprint as a [Verso](https://github.com/leanprover/verso)
  document: informal statements and proofs, each a labelled node, linked to Lean declarations,
  rendered to an HTML site (and optionally a PDF) with a dependency graph and a progress
  summary [S, README].
- The successor in spirit to leanblueprint and LeanArchitect; the README credits both [R].
- Upstream state [R, `gh api` and `git log`]:
  - created 2026-02-22, 48 stars, 7 forks, 15 open issues/PRs, last push 2026-11-05;
  - 1,005 commits, 999 of them by one author (Emilio J. Gallego Arias, under three
    spellings); no tags, no releases;
  - one branch per Lean *stable* release line (`v4.28.0` … `v4.35.0`) plus many feature
    branches; `branch-policy.json` names `v4.35.0` as "the sole maintained release line".
- Users seen: reference blueprints for FLT and Sphere Packing (both by the same author,
  `ejgallego/verso-flt`, `ejgallego/verso-sphere-packing`) [R]; infinity-cosmos has a draft
  migration (PR #193, by `dagurtomas`, 2026-07-19, still a draft) "replace
  LeanArchitect/leanblueprint with Verso Blueprint v4.32.0" [R PR body]. Kim Morrison said she
  was "migrating to Verso blueprint" (LeanArchitect PR #8, quoted in
  `further-leanarchitect-blueprint-data-extracted-f.md`; not re-read here).

### doc-gen4

- The documentation generator behind Mathlib's API docs: it loads a built library and writes
  one HTML page per module, one anchor per declaration, a search index and JSON indices [R].
- Maintained under `leanprover`; most commits by Henrik Böving (349) and Kim Morrison (123)
  [R `git log`].
- Since 2026-02 it first writes everything into a **SQLite database** and then renders HTML
  from it (`feat: save documentation info to SQLite database (#347)`) [R].

## 2. What it says that matters for GLCinLean

### 2.1 Verso Blueprint: how a node links to Lean [R, README and MANUAL]

Three ways:

1. a labelled inline Lean code block in the blueprint document;
2. `@[blueprint]` or `@[blueprint "label"]` on compiled code (bare `@[blueprint]` uses the
   qualified Lean name as the label). This needs `import VersoBlueprint` in the Lean file;
3. **`(lean := "Name1, Name2")` on a statement or proof block**, pointing at declarations that
   already exist. "This links the Blueprint entry to an existing Lean declaration without
   copying the declaration body into the chapter." The Lean code carries no annotation.

Details:

- Associations are many-to-many: one label can name several declarations and one declaration
  can sit under several labels.
- A reference whose name is not found is `present: false` / "missing declaration", and this
  blocks completion. So a rename in the code shows up as a missing node until the blueprint is
  edited.
- `opaque` is "not accepted as a direct attribute target" (nor are axioms, constructors and
  recursors). The manual does not say the same for `(lean := …)`; whether a reference to an
  `opaque` works was not tested [R for the attribute; not verified for `lean :=`].
- An association "is the author's asserted correspondence with the informal node; the status
  check does not prove that its Lean type captures the intended mathematics." [R, MANUAL]

### 2.2 Verso Blueprint: does the formal project depend on it? [R]

- No, when only `(lean := …)` is used. The blueprint is its **own Lake package** that requires
  both the formal library and `VersoBlueprint`, imports the formal modules and adds a generator
  executable. Examples:
  - `verso-flt/lakefile.lean`: `require FLT from "./FLT"` (a submodule),
    `require VersoBlueprint … @ "v4.35.0"`, and `lean_exe «blueprint-gen»`;
  - `project_template/lakefile.lean`: `require VersoBlueprint … @ "v4.35.0"`, with
    `experimental.module` set to true;
  - infinity-cosmos PR #193 adds an `InfinityCosmosBlueprint` library inside the same
    repository and also edits the `InfinityCosmos/ForMathlib/*.lean` files (contents of
    those edits not read).
- Because the blueprint package and the formal library are built in one Lake workspace, they
  share one toolchain [J, from how Lake works]. So the blueprint's release line limits the
  toolchain of the project it documents.

### 2.3 Verso Blueprint: sorry, axioms and opaque placeholders [R, `SorryAnalysis.lean`, `ProvedStatus.lean`, MANUAL]

- `analyzeDeclaration` walks the **full transitive closure** of each associated declaration:
  types, values "including opaque values" (`info.value? (allowOpaque := true)`), constructor
  types and recursor rules. It does not stop at the project boundary.
- Per declaration the verdict is one of: `complete`, `incomplete` (a `sorryAx` was seen,
  located in statement or proof, direct or inherited), `unverified` (no hole seen but some
  body was hidden or missing), `missing`, `axiom-like`.
- Guarantee: "**complete implies no reachable `sorryAx` in the checked declaration closure**."
  It "means absence of admitted `sorryAx` holes, not freedom from other axioms, nor
  correctness of the intended mathematical statement. Genuine axioms are allowed as
  dependencies"; only a directly associated `axiom` is blocked as `axiom-like`.
- Bodies hidden by the module system count as `unverified`, never as clean: "Hidden proofs
  remain unverified even if their cached footprint is empty."
- The soundness of the "complete" verdict is proved in Lean inside the package
  (`certifiedNoSorry_not_reachable`, `ProvedStatus.ofInspection_not_reachable`).
- **Consequence for GLCinLean's placeholders** [J, from the code, not run]: a
  `@[placeholder] opaque` whose witness has no `sorry` (the `NonemptyType` pattern in
  `GLCinLean/Foundations.lean`) has an available, clean value. So it is `complete`, and so is
  anything built only on placeholders. This is the same overstatement as in tracker
  (`tracker.md` §4) and LeanArchitect. Verso Blueprint has no notion of a placeholder.
- Graph status has two tracks [R, MANUAL and `Graph.lean`]:
  - a statement border: `Blocked`, `Ready to formalize`, `Formalized`, `In Mathlib`;
  - a proof fill: `Not ready`, `Ready to formalize`, `Lean code incomplete`,
    `Locally formalized`, `Locally formalized + dependencies complete`.
  - "In Mathlib" is never shown today: `nodeInMathlib` is a stub that returns `false`
    ("Placeholder branch for future `(lean := "...")` Mathlib integration").

### 2.4 Verso Blueprint: `lake exe vbp` and its query output [R, `VbpMain.lean`, `Vbp.lean`, SKILL.md]

- Commands: `vbp discover`, `vbp build [--output] [--pdf] [--serve]` (writes
  `_out/site/html-multi/`), `vbp query [--site] <selector>`, and `vbp check` (checks that the
  generated files are consistent; "does not certify freshness or a hole-free proof").
- Query selectors: `labels`, `node <label>`, `status <label>`, `uses <label>`,
  `used-by <label>`, `group <label>`, `owners`, `tags`, `work-queue`, `metadata`,
  `search <text>`, `code <decl>`, `stats`.
- What each node carries in the output (`entrySummaryFields`, `entryDetailFields`): `key`,
  `label`, `title`, `kind`, `facet` (statement/proof), `href`, `parent`, `statementUses`,
  `proofUses`, `uses`, `usedBy`, `codeData`, `ownerDisplayName`, `tags`, `priority`, `effort`,
  `leanCodePreviewKeys`.
- `work-queue` adds `nextStep`, `statementStatus`, `proofStatus`.
- `status <label>` returns `asOf: "generated-snapshot"`, `verdict`, `complete`,
  `statementComplete`, `proofComplete`, and per declaration its name, facet, association
  (external or inline) and the evidence (`knownSorry`, `unverified`).
- Stability: every response carries `apiStability: "unstable"`. The README says: "Treat `vbp`
  query JSON as an unstable agent interface, not a public compatibility contract". API.md says
  of the documented data files and modules: "It does not promise compatibility across
  versions".

### 2.5 Verso Blueprint: graph output and metadata [R]

- `{blueprint_graph}` renders a **Graphviz DOT** graph in the browser with d3-graphviz. It is
  interactive: a view switcher for groups, a legend, options for direction and packing, and
  previews of nodes. The graph data is also in `blueprint-manifest.json`, and `api/graph.mjs`
  exposes `loadGraphs`, `renderGraphData` and related functions for a custom page.
- Graph nodes are **blueprint labels, not declarations**. There is no mode that makes a node
  for every declaration of a module without an attribute. `{includeBlueprintModule}` includes
  only declarations tagged `@[blueprint]` [R, MANUAL attribute matrix].
- Optional dependency inference (`autoDeps`) walks types and bodies and "follows unassociated
  helpers by default". "An empty inferred dependency list does not establish mathematical
  independence."
- Metadata a statement block can carry: `parent`, `owner`, `tags`, `effort`, `priority`,
  `pr_url`, `issue_url`. These are hand-written strings in the blueprint source. They are not
  accepted on `@[blueprint]` ("needs an ownership and validation design before it is added").
- Source provenance: `:::source_document` with a PDF path, and per node `source := { spans :=
  #[{ page, anchor, citation := "Lemma 2.1(1)" }] }`. A node then shows a chip
  "source: Lemma 2.1(1)" [R, README]. "Rich audit-interface rendering is planned separately."
- Git is used only to build source links and to stamp the build commit (`Git.lean`). There is
  **no per-declaration hash, fingerprint or "changed since" notion** anywhere in `src/`
  (search for hash/fingerprint/digest) [R].

### 2.6 Verso Blueprint: keeping up with Lean [R, `git log -- lean-toolchain`, Lean release dates from GitHub]

| Lean release (published) | Verso Blueprint toolchain commit | Lag |
|---|---|---|
| v4.34.0-rc1 (2026-08-10) | "start Lean 4.34 release line" 2026-08-27 | 17 days |
| v4.35.0-rc1 (2026-09-15) | "start Lean 4.35 release line on rc4" 2026-10-08 (rc1–rc3 skipped) | 23 days |
| v4.35.0 (2026-10-12) | "update to Lean 4.35.0 stable" 2026-10-22 | 10 days |
| v4.36.0-rc1 (2026-10-14), rc2 (2026-10-27) | none by 2026-11-08, although Verso itself has tags `v4.36.0-rc1` and `v4.36.0-rc2` | ≥ 25 days |

- Branches exist only for stable lines; RCs are used only to *start* a line. Older lines are
  retired: Noperthedron and Carleson "are outside the published catalog while they require the
  retired 4.34 line" [R, README].
- Bumps are scripted (`python3 -m scripts.blueprint_harness bump-toolchain`,
  `start-release-line`) [R, MAINTAINER_GUIDE].
- **On 2026-11-08 Verso Blueprint cannot be used with GLCinLean's toolchain
  (`v4.36.0-rc2`)** without a local bump of Verso Blueprint [R for the versions; J for the
  consequence].
- Module system [R grep; J for the risk]: every `.lean` file under Mathlib (8,696 at `1b1ccf4`)
  and under Tau Ceti (at `e0610cc`) starts with `module`; GLCinLean's files do not. If a
  blueprint build sees Mathlib proofs only as hidden bodies, its verdicts become `unverified`
  rather than `complete`. The MANUAL says "Loading the bodies with `importAll` permits
  ordinary checked inspection". The FLT reference blueprint suggests this works in practice.
  Not tested here.

### 2.7 doc-gen4: what it records per declaration [R, `DB/Schema.lean`, `Process/*`]

- SQLite tables, keyed by `(module_name, position)`: `name_info` (kind, name, type, `sorried`,
  render), `declaration_ranges` (start/end line and column), Markdown and Verso docstrings,
  `declaration_attrs`, `axioms`, `opaques`, `definitions`, `definition_equations`, `instances`,
  structures and their fields, `module_imports`, `tactics`.
- `sorried` is **direct only**: `v.value.hasSorry` for definitions and theorems. Nothing is
  transitive, and `OpaqueInfo.ofOpaqueVal` never sets it, so an `opaque` is never marked as
  using sorry.
- **No declaration-level dependency data**: no use of `getUsedConstants` or `collectAxioms`
  in `DocGen4/` or `Main.lean`. Only module imports are stored. doc-gen4 cannot draw the
  dependency graph.
- Attributes shown are a **hard-coded list** (`tagAttributes`, `enumAttributes`,
  `parametricAttributes` in `Process/Attributes.lean`: `extern`, `implemented_by`, `export`,
  `specialize`, `deprecated`, inline, reducibility and a few others). A project attribute such
  as `@[placeholder]` is not shown.
- Identity on the page is the Lean name: each declaration is `<div class="decl" id="Full.Name">`,
  and `/find/?pattern=Name#doc` resolves a name (the `docs#` mechanism) [R, README and
  `Output/Module.lean`].

### 2.8 doc-gen4: extension points [R]

- `htmlOutputResultsParallel` takes two optional hooks:
  - `sourceLinker? : Option SourceLinkerFn`;
  - `declarationDecorator? : Option DeclarationDecoratorFn`, where `DeclarationDecoratorFn :=
    Name → Name → String → Array Html` (module, declaration, kind ↦ extra HTML, inserted
    after the source link). Its docstring: "This enables external tools to add badges, links,
    or other decorations to declarations."
- The hook was added on 2026-01-16 (PR #344, by NicolasRouquette) for
  "doc-verification-bridge to add verification badges, coverage links, or other decorations to
  declarations without modifying doc-gen4 internals".
- **The stock executable does not expose it.** `Main.lean` calls `htmlOutputResultsParallel`
  with only `sourceLinker?`. Using the decorator means writing one's own executable that
  depends on the `DocGen4` library and repeats the `fromDb` step [R for the call; J for the
  consequence].
- The decorator is a pure function. Review data must be loaded beforehand and closed over [J].
- Prior art, doc-verification-bridge (README only): "DocVerificationBridge depends on Lean and
  doc-gen4 APIs that have **breaking changes** between versions. A single codebase cannot
  support all versions simultaneously." It keeps version branches and is on `v4.29.0` [S]. So a
  tool built on doc-gen4's library API inherits that churn [J].
- The composition used by numlib-auto needs no hook: a separate graph page plus
  `docgen-action` docs, linked by declaration name through `TRACKER_DOCS` (`tracker.md`,
  "The web page") [R in that note].

### 2.9 doc-gen4: keeping up with Lean [R, `git log -- lean-toolchain`, tags]

- One tag per Lean release, RCs included (`v4.34.0-rc1` … `v4.36.0-rc2`).
- The bump lands the same day or the next: v4.35.0 on 2026-10-12 (Lean 2026-10-12),
  v4.36.0-rc1 on 2026-10-15 (Lean 2026-10-14), v4.36.0-rc2 on 2026-10-27 (Lean 2026-10-27).
- Mathlib's own docs depend on it, which is why it keeps up [J].
- Tau Ceti's `docbuild/lakefile.toml` (at `e0610cc`) requires a **fork**,
  `kim-em/doc-gen4 @ d25c2842`, "with interproject linking (… pull/396), pinned to the fork
  branch until that PR lands upstream". It says the fork revision "is built against Lean
  v4.33.0-rc1" while Tau Ceti is on v4.36.0-rc2 [R]. That comment looks stale [J]. PR #396 was
  still open on 2026-11-08 [R].

## 3. What it means for GLCinLean

### 3.1 Comparison for the review system (ideas.md, "The review system")

The tracker and ReviewKit columns are taken from `tracker.md` and `reviewkit.md`. Their [R]
tags are those notes' readings, not re-read here. The Verso Blueprint and doc-gen4 columns are
this note's own readings (§2).

| | tracker (`tracker.md`) | ReviewKit (`reviewkit.md`) | Verso Blueprint | doc-gen4 |
|---|---|---|---|---|
| Per-declaration identity | Lean name (plan id) [R] | Lean name plus a statement fingerprint [R] | blueprint label, many-to-many with Lean names; a missing name is `missing` [R] | Lean name (HTML anchor, `find`) [R] |
| Change detection | one hash per module olean; regressions one step back [R] | per-declaration fingerprint (`Fingerprint.lean`, `Sha256.lean`) [R] | none; Git only for links and the build commit [R] | none [R] |
| Review tags | none [R] | statement pin, sorry budget; `approved` is free text that is never read [R] | free `tags`, `owner`, `pr_url`, `issue_url` on blueprint blocks, hand-written, not pinned to a commit [R] | none built in; can be added as HTML badges via the decorator in a custom executable [R/J] |
| Sorry / axioms | `sorryAx` and nonstandard axioms over the transitive closure, stopping at upstream [R] | per-source sorry budget, axiom checks [R] | transitive closure into upstream; proved-sound "complete"; hidden bodies `unverified` [R] | direct `sorry` only [R] |
| Placeholders (`@[placeholder] opaque`) | shown `proved` [R] | the tag's home; census and checks [R] | `complete` [J, from code] | kind `opaque`, attribute not shown [R] |
| Graph | JSON/DOT over all declarations (`--all`) or planned ones; explorer page (ELK) [R] | none (closure list) [R] | DOT via d3-graphviz over curated labels only; two status tracks [R] | none [R] |
| Input fits "a Lean project in Mathlib style" | yes: `.olean` plus an optional plan [R/J] | yes: `.olean` plus a TOML config [R/J] | no: needs a separate Verso document or `@[blueprint]` in the code [R/J] | yes: exactly that input [J] |
| Keeping up with Lean | one author; skipped v4.35; internal APIs [R] | the owner's own; on v4.36.0-rc2 [R] | stable lines only, 10–25+ days late; not on v4.36 yet [R] | same-day tags incl. RCs; library API churns [R/S] |
| Licence | Apache-2.0 [R] | Apache-2.0, the owner's [R] | intended Apache-2.0, no LICENSE file [R] | Apache-2.0 [R] |

### 3.2 What this suggests [J unless marked]

- **Neither Verso Blueprint nor doc-gen4 provides the review half.** Neither has
  per-declaration change detection or review records pinned to a commit. The parts the owner
  asked for in ideas.md ("tracked by the Git commit hash at which it was reviewed", "reviewed"
  / "unreviewed again") must come from the review system itself, built from ReviewKit's
  fingerprint idea and tracker's dependency data, whichever page renders them.
- **doc-gen4 is the natural base for the per-declaration view of the library pattern.**
  - Its input is exactly "a Lean project documented in Mathlib's style" (ideas.md).
  - Mathlib readers already know its page.
  - It keeps up with every Lean release, RCs included, which fits the workflow decision
    "Keeping up with Mathlib and Tau Ceti is fully automated, including their Lean version".
  - Two ways to add review state:
    - (a) a custom executable with `declarationDecorator?` that puts a badge (reviewed /
      changed since review / placeholder) on each declaration. This inherits doc-gen4's
      library-API churn, which doc-verification-bridge reports as real;
    - (b) the numlib-auto composition: stock `docgen-action` docs, plus the review system's own
      graph page linking to them by name. This keeps doc-gen4 unmodified and is the cheaper
      choice for automation.
  - It gives no graph, so the graph still comes from tracker-style `.olean` analysis.
- **Verso Blueprint is the natural base for the single-statement pattern, but not now.**
  - What fits:
    - curated nodes with informal statements;
    - statement and proof tracks;
    - `(lean := …)` links that need no tag in code meant for Tau Ceti (ideas.md point 4);
    - source spans that can say "source: Conjecture 1.6.7" for each GLC object (Xena
      principle "Link to the existing literature");
    - a sound "complete" check over the whole closure.
  - It suits a human or outside reviewer who reads mathematics rather than Lean
    (workflow question "Who reviews the mathematics").
  - Against it today:
    - it is not on GLCinLean's toolchain and follows only stable lines, so it would hold up
      automated bumps;
    - the licence file is missing;
    - its JSON is declared unstable;
    - it is maintained in practice by one person;
    - it shows placeholders as complete;
    - its graph shows only curated labels, so it cannot be the library pattern's
      "dependency graph" of every declaration.
- **The review page should own its graph and its status model.** Three of the four tools (tracker,
  LeanArchitect, Verso Blueprint) count `opaque` placeholders as finished. The review system
  needs a `placeholder` state of its own, read from the `@[placeholder]` attribute, and must
  not inherit a tool's "complete" as "done".
- **The review records should be keyed by Lean name, not by blueprint label.** Then the same
  records can feed a doc-gen4 badge, a tracker-style graph and, later, a Verso Blueprint
  `(lean := …)` node. If a blueprint is ever added, it consumes the records; it does not hold
  them.

### 3.3 Other links to ideas.md and workflow.md

- **Order of sources / Tau Ceti contributions (ideas.md points 3–4; workflow decision "Tau
  Ceti contributions are fully automated").** `@[blueprint]` cannot go into code meant for Tau
  Ceti; `(lean := …)` and doc-gen4 need nothing in the code [R/J]. Tau Ceti already publishes
  doc-gen4 docs from `docbuild/` [R], so a doc-gen4 based page matches how Tau Ceti presents
  code [J].
- **"Prompts alone, no harness" (ideas.md "What I want").** Verso Blueprint brings its own
  harness: Python maintainer CLIs, an agent skill in `skills/verso-blueprint/`, a generator
  executable per project [R]. Adopting it adds a component; doc-gen4 via `docgen-action` adds
  one CI step [J].
- **Workflow step 2 (Plan).** A Verso Blueprint document would be a fourth place a plan could
  live, besides `PLAN.md`, tracker TOML and LeanArchitect attributes
  (`further-leanarchitect-…` §5) [J].

## 4. Conflicts

- **With the workflow decision "Keeping up with Mathlib and Tau Ceti is fully automated,
  including their Lean version".** Verso Blueprint follows only stable Lean lines and starts
  each line 17–23 days after the first RC; GLCinLean follows Tau Ceti onto RCs
  (`v4.36.0-rc2`). A blueprint package in the same Lake workspace would block or delay every
  automated RC bump [R for the dates; J for the consequence]. doc-gen4 does not conflict [R].
- **With ideas.md, "Input: a Lean project documented in Mathlib's style. Output: a web page
  generated directly from it."** Verso Blueprint needs a separately written Verso document
  (or `@[blueprint]` attributes in the code); its graph contains only what that document
  names [R]. doc-gen4 matches the stated input [J].
- **With ideas.md, "Based on tracker".** Kim Morrison's move (LeanArchitect note) and the
  infinity-cosmos draft point towards Verso Blueprint as the community's blueprint tool, not
  tracker [R/J]. The two do different jobs: tracker reads every declaration from `.olean`
  files, Verso Blueprint renders a curated informal document. So this is a choice of
  emphasis, not a contradiction [J].
- **With `further-leanarchitect-…` §4**, which says Verso Blueprint "may be the better
  long-term base". After reading the code: for the *document* layer, possibly; for the
  *review* layer, no. It has no change detection or review records, its toolchain cadence
  conflicts with the automation decision, and its licence file is missing [J].
- **With AGENTS.md, "Placeholders"** (an `opaque` placeholder keeps the statement from
  "saying less than it appears to"). Verso Blueprint would mark placeholder-based nodes
  `complete` and "Formalized", the same overstatement as tracker [J, from code].
- **Within Tau Ceti.** Its `docbuild` comment says the doc-gen4 fork is "built against Lean
  v4.33.0-rc1" while Tau Ceti is on v4.36.0-rc2 [R]. Either the comment is stale or the docs
  build runs on an old revision. Worth knowing before GLCinLean copies that layout [J].
- **Verso Blueprint's README vs its code:** "In Mathlib" is a legend item and a documented
  status, but `nodeInMathlib` always returns `false` [R].

## 5. Input for the open questions (workflow.md, "Questions for after the research")

- **What happens to each existing file: `blueprint/`.** A Verso Blueprint would make
  `blueprint/` (or a sibling package) a Lean package of Verso chapters, a third format after
  tracker TOML and leanblueprint LaTeX. Suggests: do not add it in step 1. Keep the review
  records format independent and keyed by Lean name, so a blueprint can be added later for the
  statement pattern [J].
- **What happens to the ReviewKit requirement and `@[placeholder]`.** Neither tool reads the
  attribute: doc-gen4's attribute list is hard-coded, and Verso Blueprint has no placeholder
  notion [R]. So the attribute must keep a home that the review system reads. Showing it on a
  doc-gen4 page needs the decorator (custom executable) or a separate page [J].
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.**
  The design itself is not challenged by these tools. But every off-the-shelf status (tracker
  `proved`, Verso Blueprint `complete`, doc-gen4 "no sorry") reads placeholders as done. So the
  page must display "placeholder" as its own state, or the design misleads readers of the page
  [J].
- **Who reviews the mathematics, and to what standard.** Verso Blueprint's informal statements
  and source spans ("source: Lemma 2.1(1)") are the most readable form for an outside expert.
  Its `owner` and `issue_url` fields give a reviewer name and a discussion thread per node [R].
  Suggests: if an outside expert is wanted for the GLC statement, a small statement blueprint
  (a few dozen nodes, `(lean := …)` only) is the format to hand them, once Verso Blueprint
  supports the toolchain [J].
- **What goes into `AGENTS.md`.** Verso Blueprint ships its tool rules as an agent skill
  (`skills/verso-blueprint/SKILL.md`: "Treat all `vbp query` JSON shapes as unstable", "Build
  the current sources before claiming that a declaration is complete") [R]. This is another
  example (with tracker's one-line README pointer) of keeping tool rules in the tool, not in
  `AGENTS.md` [J].
- **The "two patterns, or is one enough?" question (ideas.md).** Suggests: **one review
  mechanism, two views** [J]:
  - one set of review records, keyed by Lean name, each with a fingerprint and a commit, and
    one status model (`reviewed`, `changed since review`, `unreviewed`, `placeholder`);
  - library pattern: every declaration in scope; the view is the doc-gen4 docs plus a
    graph of all declarations (tracker-style);
  - single-statement pattern: only the statement and the definitions it reaches; the view
    is a curated graph of the statement's objects, with optional informal text and paper
    citations (the Verso Blueprint style);
  - the patterns differ in scope and in what the fingerprint covers (`tracker.md` §5), not
    in the machinery. Building two systems would double the toolchain burden that §2.6 and
    §2.9 show is the real cost.

## 6. Questions for the owner

1. **Page base for the library view.** Should the review page reuse doc-gen4's docs:
   - (a) unmodified, linked by declaration name (the numlib-auto way); or
   - (b) through a custom doc-gen4 executable that adds review badges with
     `declarationDecorator?`, at the cost of following doc-gen4's library API on every Lean
     bump?
2. **Verso Blueprint now, later, or never?** Adopting it now means waiting for or patching its
   v4.36 line and accepting a missing licence file and unstable JSON. Should it wait until it
   supports the toolchain GLCinLean is on and has a licence file, and then be used only for a
   statement blueprint for outside reviewers?
3. **Outside reviewer format.** If an outside expert is to check the GLC statement, would you
   want them to read Lean declarations on a doc-gen4 page, or a blueprint with informal
   statements and citations to GLC I linked to the Lean names?
4. **Review records keyed by Lean name** (not by blueprint label), so any page can consume
   them. Agree?
