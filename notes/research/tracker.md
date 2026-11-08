# tracker (bridgekat/tracker)

- Source: https://github.com/bridgekat/tracker/tree/c223b672b26179322ca61f321bcfa8aabedaba79
  (the pin in `notes/ideas.md`, and the submodule `tools/tracker` here). Also read: the companion
  viewer https://github.com/bridgekat/tracker-graph-explorer/tree/bbd8cc67d68415b220f9fc3500cb1eb0ceea5e5d.
- Checked 2026-11-08.
- Licence: tracker Apache-2.0 (copyright Great Bay University); graph explorer MIT. Both allow a
  fork or a rewrite with attribution. [R 2026-11-08]
- What was read: tracker `README.md`, `Main.lean`, `Tracker/Types.lean`, `Cache.lean`,
  `Check.lean`, `Plan.lean`, the DOT part of `Commands.lean`, `examples/`, CI; explorer `README.md`,
  `package.json`, `.github/workflows/pages.yml`, parts of `src/lib/derive.js`; numlib-auto's
  `.github/workflows/lean_action_ci.yml` (commit 9daf9e7), which publishes a page. The tracker
  was built on a copy in `.lake/research/tracker-run/` (identical to `tools/tracker`, checked
  with `diff -r`) and run on its `examples/` project, and its prebuilt binary was run on
  GLCinLean's own stub plan. The GLCinLean cache `.lake/tracker/check.json` (Git-ignored) was
  already fresh, written 2026-11-06 from the 2026-11-06 build, so the 2026-11-08 runs (with
  `--no-check` on the re-check) wrote nothing; no tracked file changed.

## 1. What it is

- A command-line tool, written in Lean 4 (about 2,050 lines: `Main.lean` 174 and `Tracker/`
  1,876; the README is another ~16 KB), that tracks the progress of a Lean
  formalisation. The plan is a set of hand-written TOML files naming the declarations that should
  exist; the progress is read from the compiled `.olean` files. [R]
- Its own description: "Progress tracking tool for large-scale autoformalization projects." [S]
- It records no reviews, does not use Git, and draws no pictures. It exports the dependency graph
  as JSON or Graphviz DOT; the separate `tracker-graph-explorer` turns the JSON into a web page.
  [R]
- Upstream state: `main` is still at c223b67 (2026-11-04); there are no other branches, no tags,
  no issues, no pull requests, no releases, no forks and no stars. So nothing has changed since
  the pin. 20 commits in all, 19 by one author (Zhanrong Qiao), several co-authored with Claude.
  [R 2026-11-08, GitHub API and `git log`]
- Users seen: GLCinLean (`tools/tracker`, required by path in `lakefile.toml`) and numlib-auto
  (`tools/tracker` at the same commit c223b67, next to `tools/metrics`). [R]

## 2. What it says that matters for GLCinLean

### Plan format [R]

- One TOML file per module, at the module's source path under the plan directory (default
  `plans/`): the plan of `Numbers.Odd` is `plans/Numbers/Odd.toml`.
- Module keys: `namespace` (ids resolve relative to it), `desc`, and `[[node]]` tables.
- Node keys: `id`, `kind` (`definition` | `theorem`; aliases `def`, `thm`, `lemma`), `desc`,
  `deps` (suggested dependencies), `source`, `wrong` (why the statement is false), `deprecated`
  (why it is going and what replaces it).
- "Any other key is an error, so a misspelt or outdated field cannot pass unnoticed." The code
  enforces this (`unknownKeys` in `Plan.lean`). A `reviewed = …` field cannot be added to a plan
  without changing the tracker.
- "The library supersedes the plan": `kind` and `desc` are needed only while the declaration is
  open; once it exists with a doc comment, the plan's copy is "superseded" and `lint` asks for it
  to be removed. "A finished, documented planned declaration needs nothing in the plan but its id."
- Which declarations are planned "is a judgement — the book's numbered results, the key
  definitions and theorems, not every helper".
- Style rule: descriptions as literal strings (`'…'`, `'''…'''`); each new node appended after a
  blank line "so files merge cleanly under git".

### States [R]

| state | meaning (from the compiled library) |
|---|---|
| `open` | the id does not resolve |
| `stated` | exists and depends on `sorryAx` |
| `proved` | no `sorry`; axioms only among `propext`, `Classical.choice`, `Quot.sound` |
| `axioms` | depends on another axiom, or is one |
| `wrong` | the plan marks it `wrong` |

- The order of the tests matters (`CacheEntry.state` in `Types.lean`): `sorryAx` is tested
  first, so a declaration that uses both `sorry` and a nonstandard axiom shows `stated`, not
  `axioms`. Regressions use the rank open < stated < axioms < proved.
- A module is *done* when every planned declaration in and under it is proved, *ready* when its
  own open or stated declarations have all outside dependencies proved, else *blocked*.
- Dependencies in force: suggested ones while open; suggested and real while stated; real only
  once proved. Real dependencies are computed from the compiled terms (type and value), passing
  through unplanned project constants and stopping at Mathlib/core.

### Commands [R]

```
tracker [--root DIR] [--dir DIR] [--roots A,B] [--no-exts] [--no-check] <command>
check [--force]     make the cache fresh
status [module] [--json]
ready [--json]      modules that can be worked on now
show <module | id>  a module's brief for a sub-agent, or everything about one declaration
lint                plan errors, cycles, mismatches, deprecations, superseded fields
graph [--under M] [--all] [--dot] [--metrics[=lines,chars,size]]
```

- There is no `init` any more (removed in 20d85d6, 2026-09-28) and no `review` command.
- Every command first refreshes the cache if it is stale. `lint` exits non-zero on errors, and "no
  check runs while the plan has any".
- Real output on the example project (run 2026-11-08):

  ```
  module        proved  stated  open  wrong  axioms  decls  state
  Numbers       8       1       2     1      0       11
    Odd         1       1       1     0      0       1      ready
    Parity      6       0       0     0      0       8      done
    Products    0       0       1     0      0       0      blocked
    Wrong       1       0       0     1      0       2

  planned declarations: 12 (8 proved, 1 stated, 2 open, 1 wrong, 0 axioms)
  11 declarations (3 definitions, 8 theorems)
  ```

  `show IsOdd.add_odd` prints kind, state, description, source, each dependency with its state,
  signature and whether it is suggested or real, and "needed by".

### Graph output [R]

- JSON: `{"modules": [...], "nodes": [...]}`, entries refer to each other by index; fields at
  their default are omitted. Module fields: `name`, `parent`, `desc`, `exists`, `plan`, `done`,
  `ready`. Node fields: `id`, `module`, `planned`, `kind`, `state`, `desc`, `source`, `wrong`,
  `deprecated`, `deps`, `suggested`, and with `--metrics` also `lines`, `chars`, `size` (the
  number of distinct subterms of the compiled type and value).
- `--all` includes every declaration, not only planned ones.
- DOT: one cluster per module, `rankdir=BT`, nodes filled by state (`palegreen` proved, `khaki`
  stated, `white` open, `orange` axioms, `lightcoral` wrong), real dependencies solid, suggested
  ones dashed. "The tracker itself does not draw."

### The web page (tracker-graph-explorer) [R]

- One self-contained HTML file (Svelte + Vite, layout by ELK in a Web Worker, plain SVG canvas).
  Load a `graph.json` by drag-and-drop, or bake one in at build time:
  `TRACKER_GRAPH=graph.json TRACKER_DOCS=docs npm run build`. `TRACKER_DOCS` links each
  declaration to a doc-gen4 site.
- Modules open in place into containers; a declaration's "neighbourhood" shows its full cone
  (dependencies and dependents); the URL fragment names the selected node.
- Colour is by kind (definition/theorem) and by area; the filled share of a box is the share
  proved; outlines mark planned (solid) vs unplanned (dashed), and wrong or extra-axiom nodes.
- Its own `pages.yml` publishes only the empty page; a project's CI must build the page with its
  own graph baked in.
- numlib-auto does exactly that [R 2026-11-08, its `lean_action_ci.yml` at 9daf9e7]: on every
  push, after `leanprover/lean-action` builds, it runs `lake exe tracker check` and
  `lake exe tracker graph --all --metrics > numlib.json`, builds the explorer with
  `TRACKER_GRAPH` and `TRACKER_DOCS=docs`, copies it to `docs/index.html`, and then lets
  `leanprover-community/docgen-action` put the API docs under `docs/docs/` and publish `docs/`
  to GitHub Pages. The explorer is checked out at its default branch, unpinned (the workflow's
  own comment: "pin with `ref:`"). https://bridgekat.github.io/numlib-auto/ answered HTTP 200
  on 2026-11-08. This is a working template for GLCinLean's page.
- It reads exactly the five states above (`STATES` in `derive.js`), and `normState` turns any
  other state into `open`: a new state such as `placeholder` or `reviewed` written into the
  `state` field would silently show as open. It has no notion of review. [R]
- Edges are drawn after a transitive reduction per container (`reduce` in `derive.js`), so
  the picture shows fewer edges than the JSON holds. [R]

### Cache and hashes [R]

- `.lake/tracker/check.json`, "never committed". It records, for every declaration: id, kind,
  module, start line (`line`, counting the doc comment), nonstandard axioms, `refs` (reachable
  entries), pretty-printed signature, doc comment, `lines`, `chars`, `size`. It stores no end
  position and no source text; the full range is read at check time (`findDeclarationRanges?`)
  but only the line count and character count are kept. [R, `CacheEntry` in `Types.lean`]
- **Hashes are per module, not per declaration**: each project module stores its olean
  fingerprint (Lake's `.olean.hash`, else a hash of the olean), used only to decide whether the
  cache is stale. No declaration has a hash of its source or its terms.
- **Regressions** compare only with the previous cache (one step back), not with any Git commit.
- The cache "records nothing the plan says".

### Workflow the README proposes [R]

- "The tracker adds no coordination machinery." One orchestrator on `main` runs `lake build`,
  `check`, `lint`, `ready`; each sub-agent gets a worktree and the output of `show <module>`; "No
  two sub-agents write the same module."
- "A task is done when main's check says every planned declaration is proved, never when a report
  says so."
- Setup advice: add it as a Git submodule, and add one line to the agent instructions: "read
  `tools/tracker/README.md` before touching the plan."

### Toolchain coupling [R]

- It reads oleans, so "it must build on the project's toolchain". c223b67 pins
  `leanprover/lean4:v4.36.0-rc2`, the same as GLCinLean's Tau Ceti rev `v4.36.0-rc2`.
- It uses Lean internals: `isAutoDeclOrPrivate_Internal` (the name itself says internal),
  `env.header.moduleData`, `importModules … (loadExts := …)`. [R] These are the kind of APIs
  that change between Lean releases. [J]
- Upstream's toolchain history [R, `git log -- lean-toolchain`]: v4.33.1 (2026-09-05),
  v4.34.0-rc1 (2026-09-05), v4.34.0-rc2 (2026-09-06), then nothing until v4.36.0-rc2
  (2026-11-03); v4.35 was skipped. Upstream bumps when its own user (numlib-auto, also on
  v4.36.0-rc2) needs it, not on every Lean release. [J]
- As a `path` require, the tracker is compiled by Lake with GLCinLean's toolchain, not its own
  `lean-toolchain`; what can break is only whether its code still compiles and still reads the
  oleans on the new Lean. [J, from how Lake treats dependencies; not tested on another
  toolchain]
- It also exposes a library `Tracker` (`lean_lib`), so another Lean package can import
  `Tracker.Check`, `Tracker.Cache`, `Tracker.Graph` and reuse `checkEnv`. [R]
- CI only builds the tool (`leanprover/lean-action`); it does not run the example project. [R]

### Run on GLCinLean's stub plan (2026-11-08) [R]

```
tracker --dir blueprint/plans status
GLCinLean        26 proved  5 stated  0 open
  Abstract        8         5                ready
  Foundations    18         0                done
```

- This reads the 2026-11-06 build; the cache's module fingerprints match the current
  `.olean.hash` files (e.g. Foundations `56615f78fd1167e7`), so it is up to date with that
  build. The five `stated` are the five `sorry`s of `Abstract.lean` (`exists_dualGroup`,
  `exists_isLanglandsFunctor`, `isLanglandsFunctor_unique`, `LG`, `main`); `ready` lists exactly
  these.
- `show DGCat.IsCompact` gives `[definition, proved]` for the `@[placeholder] opaque`. Every
  placeholder in `Foundations.lean` and `Abstract.lean` counts as **proved**, and Foundations,
  which is all placeholders, is **done**. `lint` prints `ok`.
- GLCinLean keeps its plan in `blueprint/plans/`, not the default `plans/`, so every call needs
  `--dir blueprint/plans`. The stub plan's header says "Key definitions are computed by `review
  closure`; review records live in reviews/", i.e. it leans on ReviewKit.

## 3. What it means for GLCinLean

- **A base for the review system (ideas.md, "The review system").** The tracker already gives the
  inputs the owner wants on the page: every declaration, its module, doc comment, signature,
  real dependencies, state and size, and a viewer for the dependency graph. What it lacks is
  exactly the review half. [R/J]
- **What the review system has to add on top** [J, from the code read 2026-11-08]:
  1. *A per-declaration fingerprint.* The tracker only hashes whole oleans. A review needs, per
     declaration, a hash that changes when what was reviewed changes. Options:
     - hash of the source text range (the tracker reads the ranges and the sources at check
       time, but keeps only start line and counts, so the hash must be computed there):
       catches every edit, including doc comments and formatting;
     - hash of the compiled type (and value for definitions): ignores formatting and proofs.
     - In both cases, for a *statement*, a change in a definition it uses changes its meaning, so
       the fingerprint should be a Merkle hash over the declaration and the fingerprints of its
       project dependencies (the tracker's `refs` give that graph).
     - The tracker's searches stop at the project boundary (Mathlib, Tau Ceti, core). A Merkle
       hash over project dependencies alone would not change when a Tau Ceti or Mathlib bump
       changes a definition a reviewed statement uses. The fingerprint must also cover the
       upstream constants reached (their compiled terms), or the record must store the upstream
       pins and treat any bump as a possible change. [R for the boundary; J for the consequence]
     - Records keyed by id lose their link on a rename; the tracker sees a rename only as a
       regression to `open`. A rename needs handling (a fingerprint match, or a rename note).
       [R for the tracker; J for the need]
  2. *Review records pinned to Git commits*: per declaration, the commit, the fingerprint at that
     commit, the verdict, the reviewer, and a link to notes. Storing the fingerprint in the record
     makes "changed since review?" a comparison, with no need to check out and rebuild the old
     commit. These records must be committed, unlike the tracker's cache.
  3. *Review states*: `reviewed` (fingerprint unchanged), `unreviewed`, and "reviewed before,
     changed since" (the owner's "unreviewed again, but showing that it was reviewed before").
  4. *Where the records live*: not in the plan TOML (unknown keys are errors, and the tracker's
     rule is that the plan is superseded by the library). Separate files, or a fork.
  5. *The page*: the explorer reads only five states; it needs a review field in the JSON and a
     way to show it (colour or outline). Either a fork of the explorer (MIT) or a new page.
  6. *Placeholders*: a state or marker for `@[placeholder]` declarations, since the tracker shows
     them as `proved` (see conflicts).
  7. *Build and publish*: a CI job that builds the project, runs the check, writes graph + review
     status, and bakes it into the page (the explorer's `TRACKER_GRAPH` pattern; numlib-auto's
     `lean_action_ci.yml` already does everything except the review status).
- **How to build it** [J]: the review system can be a Lean package that requires `tracker` as a
  library and imports `Tracker.Check`/`Tracker.Cache`, rather than copying it. That keeps the
  tracker unchanged and upstream-compatible. The cost is that it inherits the tracker's toolchain
  coupling (below).
- **Prompts alone, no harness (ideas.md "What I want").** The tracker's workflow is
  orchestrator + worktrees + `show <module>` briefs, with "no coordination machinery". It fits the
  example `/goal` and orchestrator prompts in `ideas.md`, and the plan → build → review steps of
  `workflow.md`. [J]
- **Step 2 (Plan) of workflow.md.** The plan's `desc`, `deps` and `source` fields can carry the
  blueprint (each GLC object, where it comes from, what it depends on). `source` is a free string,
  so "Mathlib", "Tau Ceti", "Tau Ceti roadmap #…", "missing" would have to be a convention in the
  `source` or `desc` text; the tracker has no field for provider. [R/J]
- **Step 5 (Refactor).** `deprecated` and the regression report support refactors; `lint` names
  everything that still depends on a deprecated declaration. [R]
- **Library goal (Xena principle "Document and organize").** `lint` warns about planned
  declarations and modules with neither a doc comment nor a plan `desc` (a plan `desc` alone
  silences it), and warns that a plan `desc` is superseded once a doc comment exists, which
  pushes the description into the Lean source. It does not check Mathlib's documentation style
  itself, and says nothing about unplanned declarations. [R/J]
- **Metrics.** `graph --metrics` gives lines, characters and term size per declaration; the
  `metrics` tool (separate note) builds on similar data. [R/S]

## 4. Conflicts

- **Placeholders count as proved.** AGENTS.md: a placeholder `opaque` is used so the statement
  does not "say less than it appears to". The tracker nonetheless reports every placeholder
  `proved`, Foundations `done`, and the explorer would fill those boxes as proved. Progress shown
  by the tracker overstates the formalisation. [R 2026-11-08]
- **Decision "Keeping up with Mathlib and Tau Ceti is fully automated, including their Lean
  version" vs. the tracker's toolchain coupling.** The tracker must build on the project's
  toolchain and uses internal Lean APIs; upstream is one author's repository with no releases.
  A Lean bump may break the tracker before upstream fixes it, which would block the automated
  bump. Upstream skipped v4.35 and went two months without a bump, so GLCinLean can be ahead of
  upstream. [R for the coupling and the history; E for the risk]
- **Decision "Keeping up with Mathlib and Tau Ceti is fully automated" vs. review status.**
  Because the tracker's dependencies stop at the project boundary, an automated Tau Ceti or
  Mathlib bump that changes a definition under a reviewed statement leaves no trace in a
  project-only fingerprint; the page would still say **reviewed**. The review system must
  decide how bumps affect review status. [R for the boundary; J for the consequence]
- **"Cache never committed" vs. review records that must be committed and pinned to commits.**
  Not a contradiction, but the review system cannot store its state in the tracker's cache. [R/J]
- **Unknown plan keys are errors** vs. any idea of writing review tags into the plan files. [R]
- **ideas.md: "Input: a Lean project documented in Mathlib's style. Output: a web page generated
  directly from it."** The tracker also accepts no plan at all (`graph --all` describes the
  library), so "directly from the Lean project" is possible; but it needs a built project, and
  the page is a second tool (the explorer). No real conflict, only one more component. [R/J]
- **Current repo vs. tracker defaults**: plans live in `blueprint/plans/` (tracker default
  `plans/`), and the stub plan header refers to ReviewKit's `review closure`. Both tie the
  current layout to ReviewKit. [R]
- **ideas.md pin**: no conflict; upstream `main` is the pinned commit as of 2026-11-08. [R]

## 5. Input for the open questions

- **What goes into AGENTS.md.** The tracker README asks for one line: "read
  `tools/tracker/README.md` before touching the plan." That keeps the tracker rules out of
  AGENTS.md and in the pinned README. [R/J]
- **Is PLAN.md needed?** The tracker's module plans already hold the per-module plan
  (`desc`: "anything a sub-agent should know before writing it") and the per-declaration plan.
  Only the goal and the cross-module decisions are left for PLAN.md or AGENTS.md. Suggests PLAN.md
  can shrink to the goal and decisions, or go. [J]
- **Abstract.lean, Foundations.lean, placeholder design.** The `NonemptyType`/`opaque` pattern
  keeps placeholders out of the `axioms` state, which is good, but makes them `proved`. If the
  pattern stays, something must mark them: the review system reading the `@[placeholder]`
  attribute (it would need its own environment extension, today provided by ReviewKit), or a
  convention in the doc comment ("PLACEHOLDER", already used), or `sorry`-based placeholders
  (which the tracker would report `stated`, but which AGENTS.md argues against). [R/J]
- **What happens to each existing file.**
  - `tools/tracker` and its `lakefile.toml` require: keep if the project keeps using the tracker;
    the tracker must be built with the project's toolchain, so a `require` (or `lake env` on a
    separately built clone) stays necessary. [R]
  - `blueprint/plans/`: moving to the default `plans/` removes `--dir` from every prompt; the
    header line about `review closure` goes with ReviewKit. [J]
  - ReviewKit requirement and `@[placeholder]`: the tracker does not provide the attribute, so if
    ReviewKit goes, the attribute needs a new home (the review system's package, or this
    repository). [R/J]
- **Who reviews the mathematics, and to what standard.** The tracker has nothing on this; it only
  guarantees "no sorry, standard axioms". It makes clear that "proved" is not "reviewed". [R/J]
- **Where research notes and session summaries live.** The tracker's README insists the progress
  of record is main's `check`, "never when a report says so", which argues for short session
  summaries and against long progress files that duplicate `tracker status`. [R/J]
- **ideas.md open question: two patterns or one?** The tracker suggests one mechanism with two
  fingerprints [J]:
  - library pattern: review every (or every planned) declaration for code quality; fingerprint =
    hash of the source text;
  - single-statement pattern: review only the statement and the definitions it reaches; the
    proofs are checked by the kernel, so the fingerprint is the Merkle hash of types and
    definition bodies, ignoring theorem proofs.
  Both are the same records and page, with a different hash and a different set of declarations.

## 6. Questions for the owner

1. Should the review system **reuse the tracker as a Lean library** (require it, import
   `Tracker.Check`), **fork it**, or **rewrite it**? Reuse keeps upstream fixes; a fork lets the
   plan carry review fields and lets you fix toolchain breakage yourself.
2. What should "changed since review" mean: **any edit to the declaration's source**, or **a change
   to its meaning** (its type, definition bodies and the definitions it uses, ignoring proofs)?
   Or both, one per pattern? And does a Mathlib or Tau Ceti bump that changes an upstream
   definition a reviewed statement uses count as a change (it is invisible to the tracker)?
3. How should **placeholders** show on the page and in `status`: as their own state, or as
   `stated`? (Today they show as `proved`.)
4. When a Lean or Mathlib bump breaks the tracker and upstream has not fixed it yet, may the
   automation **patch a fork** of the tracker, or should the bump wait?
5. Should the page be a **fork of tracker-graph-explorer** (Svelte, MIT) with a review layer, or a
   new page?
6. Should the plan move from `blueprint/plans/` to the tracker's default **`plans/`**?
