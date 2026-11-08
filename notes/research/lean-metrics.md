# Lean Metrics (bridgekat/metrics)

- **Source:** `bridgekat/metrics`, a tool that measures the quality of Lean code from compiled
  `.olean` files. Written for the `numlib` project; copyright Great Bay University.
- **URL:** <https://github.com/bridgekat/metrics/tree/55248898784e6bca981fcf96faea8657cad62c75>
  (commit `5524889`, 2026-11-04).
- **What changed on main since the pin:** nothing. On 2026-11-08 `main` is at `5524889`, the
  pinned commit. The repository has one branch, no tags, no issues and 6 commits in all; the last
  push was 2026-11-04. [R]
- **Checked 2026-11-08.** I read the whole README, `Main.lean`, `run.sh`, `lakefile.toml`,
  `lean-toolchain`, the CI workflow, `Metrics/Leak.lean`, `Metrics/Replace.lean`, and in
  `analysis/` the files `report.py`, `load.py`, `view.py`, `source.py`, the header of
  `worklist.py`, the header of `validate.py`, and the list of functions in `metrics.py`. I did not
  read `Metrics/Analyze.lean`, `Basic.lean`, `Hash.lean`, `Visit.lean` or the rest of `metrics.py`
  line by line. A local clone is in `.lake/research/lean-metrics/` (Git ignores it).
- **Also read for this note:** `bridgekat/numlib-auto` @ `9daf9e7` (2026-11-05), which pins this
  tool as a submodule; `bridgekat/tracker` @ `c223b67` (the `graph` section of its README);
  `TauCetiProject/TauCetiReview` @ `abb4439` (2026-11-08), `rubrics/`; and the README of
  `RemyDegenne/lean-quality-indicators` @ `09c11a9`, for comparison.
- **Second check, 2026-11-08.** An independent pass re-read `README.md`, `Main.lean`, `run.sh`,
  `Metrics/Replace.lean`, `Metrics/Leak.lean`, the CI workflow, all of `analysis/report.py`,
  `load.py`, `view.py`, `source.py`, the headers of `validate.py`, `sample.py`, `precision.py`,
  `worklist.py`, `semantic.py`, the R, P and A functions of `metrics.py`, `analysis/labels.json`,
  the commit history, numlib-auto's `.gitmodules` and CI, the tracker README's `graph` section and
  `tracker-graph-explorer` @ `bbd8cc6` (`src/lib/derive.js`). Corrections from that pass are
  folded into the text below.
- **Not run.** I did not build or run the tool on GLCinLean. Everything about running it below
  comes from reading the code and the README.
- **Licence:** Apache-2.0 (`LICENSE`, plus headers in the Lean files). Copying or adapting it is
  allowed if the licence and the notices are kept.

How the tags are used: [R] read directly in the source on 2026-11-08; [S] a source's claim about
itself; [E] estimate; [J] judgement. A tag covers the sentence or bullet it ends.

---

## 1. What it is

- A command-line tool in two halves [R]:
  - **`metrics`** (Lean, about 1,240 lines). It imports a built project and writes JSON lines.
    It has three commands:
    - `dump`: one record per declaration;
    - `replace`: does one earlier lemma close this theorem?
    - `leak`: does this proof still check when the definitions it mentions are made irreducible?
  - **`analysis/`** (Python, standard library only, about 1,800 lines). It turns those records
    into *findings* (a declaration plus the evidence) and library-wide *indices* (the share of
    written theorems with a finding).
- It reads types and proof terms, not source text: "what it reports is what the proofs do, not
  what they look like". [S]
- No language model is involved. Every number comes from the compiled terms, or from Lean
  re-checking a term. [R]
- "Nothing here edits the measured project or needs the network." [S]
- Origin: the commit `3a0eb32` is titled "Proof-term metrics for Lean libraries, moved from
  numlib's tools/census". The defaults are numlib's: backbone `Numlib`, surface `NumlibSurface`,
  and one Mathlib module in four as the baseline. [R]

## 2. What it says that matters for GLCinLean

### The metrics

The README says "The letters follow the review angles of the Tau Ceti rubrics that the metric is
evidence for." [R] They are:

| Group | Metrics (a short form of the README's definitions) | Tau Ceti rubric it gives evidence for |
|---|---|---|
| **S** size | S1: source lines per theorem (median, 90th and 99th percentile, share over 50 lines). S2: size of the proof term as a graph (DAG), and the number of lemmas applied. | `proof-quality` ("Long proofs (more than 50 lines)…") |
| **R** reuse | R1 `duplicate`: same statement as another theorem, up to binder names, instances or the order of hypotheses. R3 `wrapper`: the proof applies one lemma. R4 `clone`: same lemma sequence as another proof. R5 `subproof`: a shared tree of at least 5 nested lemma applications. R6 `replaceable`: one earlier lemma closes the statement ("what `exact?` would find"). | `reuse` |
| **G** generality | G1 unused hypothesis. G2 unused class binder. G4 unused variable. G3 `overstrong_class`: a class assumed but only used through a weaker one (`normed>algebraic`, `normed>topological`, `topological>algebraic`). | `generality` |
| **P** proof quality | P1 `dead_have`: a `have` the rest of the proof never uses. P2 `long_proof`: S1 over 50 lines. | `proof-quality` |
| **A** API design | A1 `private_general`: a private theorem that mentions nothing of its own module or project. A2 `misplaced_general`: a public theorem that mentions nothing of the project. A3: the API of each definition. A4 `unused`/`unreached`. A5 `leak`. A7 `repeated_hypothesis`: one hypothesis written out the same way in 6 or more theorems ("a concept without a name"). `simp`: share of `@[simp]`. H1: a file marked "Upstreaming candidate" that imports a file that is not marked. | `api-design`, `placement` |

All rows: [R] from the README. The rubric column is my matching of the README's letters to the
rubric files. [J]

Tau Ceti Review's wording that two of the tests implement [R]:

- `Replace.lean`: "This is the mechanical form of the reuse rubric's blocking condition, 'a new
  declaration that a located existing declaration directly replaces'." The phrase is in
  `TauCetiReview/rubrics/reuse.md` line 5, and line 45 says to `block` on it.
- `Leak.lean`: "This is the mechanical form of the API rubric's test, 'try to use the new API
  without unfolding'." The phrase is in `rubrics/api-design.md` line 19.

### How it works

- **Three conventions decide what a proof step is** [R]:
  1. Auxiliary theorems (`foo._proof_1`) are inlined.
  2. "Glue" lemmas do not count as steps: theorems declared in a module under `Init`, `Std`,
     `Lean`, `Batteries`, `Aesop`, `Qq`, `Plausible`, `ProofWidgets`, `Mathlib.Tactic`,
     `Mathlib.Logic`, `Mathlib.Util`, `Mathlib.Lean`, `Mathlib.Init` or `Mathlib.Order.Defs`
     (the default of `--glue` in `Main.lean`), instances, and theorems whose conclusion is a class.
     Tau Ceti is not on the list, so its theorems count as steps.
  3. Only explicit arguments are followed.

  The README says "the first version without them measured mostly elaboration noise". [S]
- **`replace`** [R]:
  - It asks Lean's library search for lemmas matching the conclusion.
  - It applies each candidate, then `solve_by_elim` to depth 4.
  - A candidate from the project or from a fully measured module counts only if it is declared
    earlier (in the order of modules, then lines). Any other imported constant (unsampled
    Mathlib, Tau Ceti when it is not in `--full`) is always admissible, because `admissible`
    returns `true` for a name it has not located.
  - Statements true by `rfl` are recorded as `rfl` and not as hits. Deprecated theorems,
    instances and theorems whose conclusion is a class are skipped.
  - Defaults in `Main.lean`: 300 candidates, `solve_by_elim` depth 4, a budget of 400000
    heartbeats per theorem (the unit of the `maxHeartbeats` option); the README's example run
    uses `--max-cand 100 --heartbeats 40000`.
- **`leak`** [R]:
  - It re-checks a proof term with `Meta.check`, first as written and then with the candidate
    definitions made irreducible.
  - Only plain semireducible `def`s of the same library are candidates (`Main.lean`; the whole
    of `--roots` counts as one library). So `abbrev`s (reducible), `opaque`s, instances and
    projections are never tested.
  - It uses `Meta.check`, not the kernel.
  - The docstring of `Leak.lean` says "definitions from other modules made irreducible", but
    `Main.lean` picks definitions of the same library, own module included; the README's A5
    then flags a definition when another module leaks or when every user (three or more) does.
    The code is what runs.
- **Validation:** independent readers judged 20 random findings per metric. [S] The README sorts
  the metrics by the result [S]:
  - *act on the list* (two in three or better are real): P1, G2, R6 `reproved`, G1, R1;
  - *review the list* (about half): R4, R5, A1 `mathlib`, A7, A5, A2;
  - *an index, not a list*: G3, R6 `wrapper`, G4, A4, A1 `foreign`.

  The table with these results is in a "research report" that the repository does not contain. I
  could not reach it: a GitHub code search for `review-report-202610` finds only `labels.json`,
  and bridgekat has no public `numlib` repository (only `numlib-auto`). The only ground truth in
  the repository is `analysis/labels.json`: 54 labelled findings on 7 numlib modules, from the
  "October 2026 manual review" (`review-report-202610`); `validate.py` calls it "one review of ten
  files". [R]
- The machinery for the precision check is in the repository even though its results are not:
  `sample.py` draws 20 findings per metric as JSON worksheets, a checker fills in a `verdict`
  (`confirmed`, `benign`, `wrong`, `unsure`), and `precision.py` tabulates them. [R] So the
  check could be repeated on GLCinLean, with fresh agents as the checkers. [J]
- **A baseline is needed.** Mathlib is measured the same way. Some plausible metrics (R3,
  same-family G3) are as common or more common in Mathlib, so they are kept as descriptions only.
  Rates are per theorem. [S]
- **Limits** stated by the source [S]:
  - It sees only terms, so a clumsy proof that elaborates to a clean term looks clean.
  - `replace` finds only one-lemma closures within a budget.
  - Uses that leave no name in a term (`rfl` lemmas, instances, simp lemmas) are invisible.

### Running it on a Lean project

1. **Same toolchain.** The tool has no dependencies (`lake-manifest.json` has an empty package
   list) and pins `leanprover/lean4:v4.36.0-rc2`. It must be built with the measured project's
   exact toolchain: "change both together". [R] GLCinLean and Tau Ceti both pin `v4.36.0-rc2` on
   2026-11-08, so at this pin the tool matches GLCinLean. [R]
2. **Build both.** `lake build` in the tool, then `lake build` in the project. [R]
3. **Run the commands.** `bash run.sh PROJECT OUT/dump 4 [dump|replace|leak] [args…]` starts one
   `lake env …/metrics <cmd> --shard i/n` per shard, from the project's root. [R]
   - Arguments given after the command override the Numlib defaults, because the parser keeps
     the last value it sees. [R]
   - For GLCinLean that would be something like
     `bash run.sh path/to/GLCinLean OUT/dump 4 dump --roots GLCinLean --full GLCinLean,Mathlib --stmt Mathlib,TauCeti`.
     I have not tested this command. [J] `--roots GLCinLean` imports the root module
     `GLCinLean.lean`, which imports `GLCinLean.Foundations` and `GLCinLean.Abstract`, so Tau Ceti
     and Mathlib come in through them. [R] For `replace` and `leak`, `run.sh` prepends
     `--roots Numlib,NumlibSurface`, so `--roots GLCinLean` must be passed again there. [R]
4. **Make the report.**
   `python analysis/report.py OUT/dump PROJECT OUT/report [--replace DIR] [--leak DIR]` writes
   `summary.json`, `findings.jsonl`, `files.csv` and `defs.csv`. [R]
5. **Expect to edit the Python first.** The extractor accepts any project, but `analysis/` does
   not yet:
   - `report.py` loops over the fixed libraries `("Numlib",)`, `("NumlibSurface",)`,
     `("Mathlib",)`, and writes findings for `"Numlib"` only.
   - `view.py` has `PROJECT = ("Numlib", "NumlibSurface")`.
   - The metric functions default to `libs=("Numlib",)`, and `surface_reach` defaults to
     `back="Numlib", surface="NumlibSurface"`.
   - `worklist.py` hard-codes numlib's module clusters.
   - R1's pool of partner theorems is `("Numlib", "Mathlib")` (`report.py`, `all_findings`), so
     a duplicate of a Tau Ceti theorem is not found until `TauCeti` is added to the pool.
   - A library is "the first component of its module name" (`load.py`). So `GLCinLean.Abstract`
     and `GLCinLean.Foundations` are one library, `GLCinLean`; a backbone/surface split needs two
     top-level prefixes, not two folders. [R]
6. **Conventions the analysis reads from the source tree** [R]:
   - A4 `unused` counts a declaration as planned when an `id = "…"` line in a TOML file under
     `plans/` names it (the tracker's plan format, with `namespace`).
   - A4 `unreached` and the backbone/surface split need two top-level libraries.
   - H1 and A2 look for the text "Upstreaming candidate" in the first 4,000 characters of a file.
7. **Cost** (numlib, October 2026) [S]:
   - Each shard imports the whole project: 3 to 8 GB of memory.
   - `dump` on 4 shards: about 3 minutes.
   - On 5 shards on an idle machine: `replace` 54 minutes, `leak` 14 minutes. About three times
     as long while the project was being built.
8. **CI** is `lean-action` building the tool. There are no tests. [R]

### Its relation to the tracker and to numlib-auto's web page

- `numlib-auto` pins `tools/metrics` at the same commit `5524889`, next to `tools/tracker` at
  `c223b67`. [R]
- Its CI does **not** run this tool. The published page is built from
  `lake exe tracker graph --all --metrics > numlib.json`, rendered by
  `bridgekat/tracker-graph-explorer`. [R]
- The tracker's own `--metrics` adds only `lines`, `chars` and `size` (nodes of the compiled terms)
  to each graph node. [R] That covers about what S1/S2 cover here. [J]
- `worklist.py` turns the "act on the list" findings into worklists for refactor rounds, one
  per module cluster. Round 1 holds what a compiler can check alone (R6, R1, G1, G2, tested P1
  patches); round 2 what needs a judgement per item (P1, R4, A1 `mathlib`, A7). Items whose fix
  stays in one file go to that cluster's `local` list; items that need edits in other files go
  to one `cross` list, "to be done after the clusters are merged". [R] (docstring)
- No prompt in `numlib-auto/prompts/` mentions the tool. In `numlib-auto` it is used by hand
  (findings, then `worklist.py` lists for refactor rounds), not in the pipeline. [R] for the grep
  of `prompts/`, `README.md`, `CONTRIBUTING.md`, `notes/`, `scripts/`; [J] for "by hand".

### Tau Ceti Review and Lean Quality Indicators, for comparison

- **Tau Ceti Review** sends one AI agent per rubric to read a pull request. No file in
  `TauCetiReview` mentions this tool or any mechanical metric of this kind (a grep for
  `metrics`, `bridgekat`, `quality-indicators` finds only an unrelated comment in
  `runner/review.py`). [R]
- **Lean Quality Indicators** asks an LLM judge one question about each sampled target, reading
  the source "but cannot run Lean", and reports flag rates with confidence intervals against
  Mathlib. [R] (README) This tool is the opposite way to measure: from terms, no LLM. [J]

## 3. What it means for GLCinLean

- **Idea 2, "Code quality as high as possible", and the Xena lines "Set standards, and meet them"
  and "Avoid duplication. Generalize theorems for maximal reuse".** R1, R6, G1 and G2 are cheap,
  exact checks of exactly these, and the README rates them "act on the list". [J] They are a good
  mechanical gate for the library part (step 3, Build, and step 5, Refactor), run before the
  review agents. Tau Ceti Review's design does the same: mechanical checks first, "Agents run only
  after CI is green". [R] for the quote, [J] for the fit.
- **Idea 3, order of sources (Mathlib, then Tau Ceti, then Stacks).** R1 and R6 test this
  mechanically: does a GLCinLean statement duplicate, or follow in one step from, a Mathlib or
  Tau Ceti lemma? [J] R6 already sees Tau Ceti: library search covers every imported constant,
  and an unlocated one is always admissible. [R] R1 needs Tau Ceti in `--stmt` (or `--full`)
  and `TauCeti` in the duplicate pool of `report.py`, which the code has not got yet. [R]
- **Idea 4, contributing to Tau Ceti.** Tau Ceti blocks on duplication (`reuse.md`). Running
  R1/R6 against Tau Ceti before opening a pull request would catch the most common blocking
  reason early. [J] The "Upstreaming candidate" header with check H1 (a marked file may import
  only marked files) is a ready-made convention for the files meant for Tau Ceti. [J]
- **Workflow step 2, "backbone versus surface".** The tool expects exactly numlib's split: a
  backbone library and a surface library as two top-level module prefixes (`Numlib`,
  `NumlibSurface`). [R] If the rebuild splits GLCinLean the same way (say a library prefix and a
  statement-surface prefix), A4 `unreached` and the per-library indices work with few edits. [J]
- **The current statement layer.** On 2026-11-08 the two files hold 15 `@[placeholder]`
  declarations (6 in `Abstract.lean`, 9 in `Foundations.lean`; 12 `opaque`s and 3 `def`s over a
  `NonemptyType` opaque: `DGCat`, `DGCat.Obj`, `LinFun`), many `abbrev`s, and four theorems
  (`exists_dualGroup`, `exists_isLanglandsFunctor`, `isLanglandsFunctor_unique`, `main`), all
  proved by `sorry`. [R] Nearly every metric is about theorems and proofs, and a `sorry` proof
  term carries no steps, so on today's repository the output would be close to empty, and the
  per-module bootstrap intervals would mean nothing. [J] Only the three placeholder `def`s are
  `leak` candidates; the `abbrev`s and `opaque`s never are. [R] for the rule in `Main.lean`. The tool becomes useful once a library exists (step 3).
  `consts.tsv` marks opaques as kind `o`, so a count of placeholders would be a small addition.
  [R] for `o`, [J] for the addition.
- **Workflow decision "Keeping up with Mathlib and Tau Ceti is fully automated, including their
  Lean version".** The tool must be rebuilt at the project's exact toolchain [R], so a toolchain
  bump also means bumping the tool. Upstream bumps when numlib does (commit `c06f8fe`, "Lean
  v4.36.0-rc2, as numlib"). [R] That bump, from `v4.35.0-rc2`, changed only the
  `lean-toolchain` line. [R] It depends on Lean internals (`importModules`,
  `LibrarySearch.*`, `setIrreducibleAttribute`), so a later bump may still break it. [J] Possible ways out:
  vendor a copy and bump it in the same step, pin a fork, or run it only when the toolchains
  match. [J]
- **The review system (idea: web page with dependency graph and review tags).**
  - `findings.jsonl` has one row per finding: `metric`, `decl` (the user-facing name), `module`,
    `line`, `end`, plus evidence such as `partner`. [R]
  - The tracker's graph JSON identifies nodes by declaration `id`. [R]
  - So the two can be joined by declaration name, and each node on the page could show badges
    such as "duplicate of X" or "unused hypothesis". [J] That is feasible, but not without code:
    - `tracker-graph-explorer` (numlib-auto's page) has a fixed list of node figures in
      `src/lib/derive.js`: `decls`, `lines`, `chars`, `size`, summed over each module. [R] A
      count of findings per declaration fits that shape (a number, summed per module); badges
      with text need new code in the explorer. [J]
    - `findings.jsonl` names a private declaration without its `_private` prefix, and with
      `--all` the tracker's edges pass "through the constants that are neither (auxiliary and
      private ones)", so private declarations have no node. [R] A1 findings, which are all on
      private theorems, would then have nowhere to attach. [J]
  - Two cautions [J]:
    - Findings belong to a commit snapshot. They are a different thing from the owner's
      "reviewed at commit H" status, so the page should show them beside the review tags, not
      fold them into them.
    - `replace` and `leak` take about an hour per run at numlib's size [S], so in CI only `dump`
      and the cheap metrics are realistic. The rest would run on a schedule or by hand.
- **Review-system question "two patterns, or is one enough?"** The tool shows the difference
  concretely [J]:
  - For the library pattern, the indices against a Mathlib baseline matter.
  - For the single-statement pattern, A4 `unreached` ("no surface declaration depends on it,
    even indirectly") is the useful check: in a proof of one statement, everything should be
    reached.
  - The same tool serves both, with different metrics shown.
- **Workflow step 5, Refactor.** `worklist.py`'s split into per-cluster `local` lists and one
  `cross` list done after the merge [R] is a ready-made way to hand refactor work to parallel
  agents without edit conflicts. [J] Its clusters are numlib's and would have to be rewritten.
  [R]
- **Prompts stay simple (decision "Prompts hold only the goal, the completion criteria and the
  context").** One sentence in a build or refactor prompt ("run the metrics; act on R1, R6, G1,
  G2, P1 findings") would be enough. It needs no harness in this repository. [J]

## 4. Conflicts

- **With `notes/ideas.md`, "the metrics come from Tau Ceti Review".** Partly true. The angles
  and two test conditions are taken from Tau Ceti Review's rubrics [R], but Tau Ceti Review has no
  mechanical metrics and does not use this tool [R]. The tool was written for numlib (moved from
  `numlib/tools/census`). [R]
- **With `notes/ideas.md`, "more general, usable for any Lean project".** True for the Lean
  extractor, which takes `--roots` and `--full`. [R] It is not yet true for `analysis/`, which
  hard-codes `Numlib`, `NumlibSurface`, numlib's clusters, a `plans/` folder and the "Upstreaming
  candidate" header. [R] Making it general takes small edits to a handful of defaults. [E]
- **With the workflow decision on full automation of version bumps.** The tool is locked to one
  toolchain [R]. Upstream follows numlib's schedule and has had no activity since 2026-11-04 [R],
  so GLCinLean cannot assume upstream will bump in time. [J]
- **With the tracker.** The tracker's `--metrics` and this tool's S1/S2 overlap in purpose, but
  count different things [R]:
  - tracker `size`: type and value together;
  - S2 here: the proof term only, plus the number of lemmas applied.

  A page should use one of them, not both under one name. [J]
- **With Lean Quality Indicators.** They agree on method (Mathlib baseline, rates, intervals) [R]
  but measure differently: LLM judges reading the source, against terms here. Their numbers are
  not directly comparable. [J]
- **Within the source.** The worth of the metrics rests on a "research report" that is not in the
  repository, and on one small labelled review. The docstring of `validate.py` says to "read the
  output as a list of hits and misses rather than as a rate". [R] So the "act on the list" ratings
  are [S], not checked.
- **Within the source, `leak`.** `Leak.lean`'s docstring ("definitions from other modules") and
  `Main.lean`'s candidate rule (definitions of the same library, own module included) disagree.
  [R] The code is what runs; the README's A5 flag rule matches the code. [J]
- **Toolchain drift, measured.** The one bump so far (`v4.35.0-rc2` to `v4.36.0-rc2`) changed
  only `lean-toolchain` [R], so the conflict above is a risk rather than a known cost. [J]

## 5. Input for the open questions

- **What goes into `AGENTS.md`.** At most one line: where the metrics tool lives and that R1,
  R6, G1, G2 and P1 findings are fixed before review. The run command belongs in the prompt
  for the step that uses it, not in `AGENTS.md`. Reason: the workflow's decision says `AGENTS.md`
  is short, and the tool is not needed at every step. I did not read Anthropic's guidance for
  this note. [J]
- **What happens to each existing file: the ReviewKit requirement and `@[placeholder]`.** This
  tool replaces neither [R]:
  - It has no attribute and no checks run at build time.
  - It measures code quality, not whether a statement is honest.
  - It does not read the `@[placeholder]` attribute: placeholders appear in its records as
    ordinary constants, kind `o` for the `opaque`s and `d` for the three placeholder `def`s.

  So the decision on ReviewKit does not depend on it. If the review system is rebuilt on the
  tracker, this tool fits beside it as an optional layer, as in `numlib-auto`'s `tools/`. [J]
- **Who reviews the mathematics, and to what standard.** Not this tool. It has no `correctness`
  angle, and Tau Ceti's `correctness` rubric ("Do the statements and definitions say what they
  should?") has no mechanical counterpart here. [R] It can lower the reviewers' load on reuse,
  generality and proof quality, so that fresh agents or an outside expert spend their time on
  meaning. [J]
- **Where research notes and session summaries live.** The raw output is large and per commit:
  `decls.*.jsonl` covers a quarter of Mathlib in full and the rest of Mathlib as statement
  hashes. [R] It belongs in an ignored folder (for example `.lake/metrics/`). At most
  `summary.json`, or a short table of indices per release, would be worth committing. [J]
- **Review system: one pattern or two** (from `ideas.md`). See section 3: the same tool, with
  library indices for the library pattern and A4 `unreached` for the single-statement pattern.
  [J]

## 6. Questions for the owner

1. Should the rebuilt project use this tool at all, and if so as a gate (findings in the
   "act on the list" group must be fixed before review) or only as information?
2. How should it be kept at GLCinLean's toolchain? Choices: vendor a copy into this repository or
   the review system's repository, pin a fork (for example under `WHY-Op109`), or pin upstream
   and skip it while the toolchains differ.
3. Should the review system's page show metric findings next to the review tags? If yes, should
   it compute only the cheap ones (`dump`) on each commit, or also `replace` and `leak` (about an
   hour each at numlib's size) on a schedule?
4. Should the rebuild split the code into two top-level libraries, a backbone and a GLC statement
   surface, as numlib does? This tool's `analysis/` and numlib-auto assume that split [R]; the
   tracker's README does not mention a backbone or a surface (checked 2026-11-08) [R].
5. Should files meant for Tau Ceti carry an "Upstreaming candidate" header, so that check H1 can
   watch their imports?
