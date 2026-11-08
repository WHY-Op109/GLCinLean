# NLAlib

- **Source:** `tchen-research/NLAlib`, "Lean Formalization of foundational results for Numerical
  Linear Algebra" (randomized numerical linear algebra on Lean 4 and Mathlib).
- **URL:** <https://github.com/tchen-research/NLAlib/tree/77514ce42a0e437d837797a063ac161f41022730>
  (commit `77514ce4`, 2026-10-29, merge of PR #46; still the head of `main` on 2026-11-08; 129
  commits; first commit 2026-10-08).
- **Successor (found on the second check):** the project continues as `NLA-lib/NLAlib`, a rebuild
  begun 2026-10-14, at <https://github.com/NLA-lib/NLAlib/tree/02fa5cd659a8e7909d1c97b70cee43a14c579e41>
  (commit `02fa5cd6`, 2026-11-08, merge of PR #76; 1,768 commits; 745 Lean files under `NLAlib/`;
  site <https://nla-lib.org>) [R, `gh api`, clone]. Issue #11 of the old repository, "migrate to
  https://github.com/NLA-lib", is open, and the successor's design notes cite
  "`tchen-research/NLAlib`, commit `77514ce4…`" as their "formal source" [R]. The old repository is
  therefore frozen material; the live design is the successor's. Section 2.4 summarises the parts
  of the successor read on 2026-11-08; everything else in this note is about the old repository.
- **Progress site (old):** <https://research.chen.pw/NLAlib/> (answered HTTP 200 on 2026-11-08; its
  content was not inspected beyond that, the page is built from files read below).
- **Checked 2026-11-08** (written, then re-checked against both clones the same day).
- **Licence:** Apache 2.0 (both repositories) [R, `gh api`]. Its scripts and rules could be copied
  or adapted with a notice.
- **Read in full (old):** `README.md`, `AGENTS.md`, `CONTRIBUTING.md`, `docs/STANDARDS.md`,
  `atlas/README.md`, `atlas/TARGETING.md`, `docs/llms.txt`, `docs/coverage/README.md`,
  `docs/AUDIT_ASSUME_BRIEF.md`, `docs/review/MATHLIB_COMPATIBILITY_AUDIT_2026-10-13.md`,
  `docs/audit/2026-10-14-library.md`, `docs/audit/2026-10-14-moment-independent-review.md`,
  `.github/` (both workflows, PR and issue templates, `CODEOWNERS`), `lakefile.lean`,
  `lean-toolchain`, `scripts/{ExtractDecls,Audit,AuditTrusted,Lint}.lean`,
  `scripts/{check_names,check_docstrings,check_card_audit,build_site}.py`.
- **Read in part (old):** `docs/review/PUBLIC_CONTRACT_REVIEW_2026-10-13.md` (most),
  `docs/review/oddities_infrastructure.md` (first 90 lines), `docs/audit/G0.md` (first 70 lines),
  `docs/REORG_BRIEF.md` (first 60 lines), `scripts/sync_atlas.py` (header),
  `scripts/check_atlas.py` (the `depends_on` part), the head of `atlas/schema.json`, the header and
  one record of `docs/audit/2026-10-14-matrix-krylov.json`, the manifest
  `docs/audit/2026-10-14-library.json` (keys, method, report list), the tab list of
  `atlas/viewer.template.html`, `NLAlib/Matrix/Norms/Core.lean` (first 60 lines).
- **Read (successor):** `README.md`, `AGENTS.md`, `CONTRIBUTING.md` (opening and "Pull requests
  and checks" to the end), `.github/CODEOWNERS`, `.github/PULL_REQUEST_TEMPLATE.md`,
  `.github/workflows/{ci,approval}.yml`, the start of `explore.yml`, the header of
  `docs/targets.toml` and of `scripts/{Targets,Replay,Explore}.lean`, `docs/contributing/programs.md`
  (target section), the first 30 lines of `docs/rules/DIGEST.md`. Not read: the 1,370-line
  `docs/rules/rules.toml`, the other contributing guides, the design notes, the site repository
  `NLA-lib/NLA-lib.github.io` beyond its file list.
- **Not read (old):** the other ~40 historical briefs in `docs/`, the other review and audit
  reports, the remaining Python scripts, the 2,945 Lean files beyond counts and one sample.
- **Local copies:** `.lake/research/NLAlib/` and `.lake/research/NLA-lib-NLAlib/` (Git ignores
  them).

Tags: [R] read directly in the source on 2026-11-08; [S] a source's claim about itself; [E]
estimate; [J] judgement. A tag covers the sentence or bullet it ends.

---

## 1. What it is

- A Lean 4 / Mathlib library of the foundations of randomized numerical linear algebra: matrix
  analysis, Gaussian and random-matrix facts, concentration, sketching, low-rank and Krylov
  results. "The aim is reusable statements that other people's proofs can cite, not one-off
  verifications of particular algorithms." [R, README]
- Pinned to Lean `v4.33.1` and Mathlib `0df444a3` (no Tau Ceti). The pin has not moved since the
  scaffold commit of 2026-10-09: `lake-manifest.json` and `lean-toolchain` were last changed then
  [R, `git log`]. The successor uses the same toolchain and Mathlib commit [R].
- Size at `77514ce4`: 2,945 Lean files, about 386,000 lines under `NLAlib/`; 16,063 indexed public
  declarations, none depending on `sorry`; 513 catalogued results ("atlas cards"), 489 `proved`,
  23 `candidate`, 1 `assumed` [R, counted from `atlas/declarations.json` and `atlas/atlas.json`].
  Built in about three weeks (first commit 2026-10-08) [R].
- Written by AI agents under a curator. Branches are named `codex/…`; review reports name GPT
  agents ("Sol reviewed QR and the non-Matrix areas; Luna reviewed Matrix families; the
  coordinator checked …") and the ported Tropp project says its proofs "were produced with large
  language models (Anthropic's Claude, driven through Claude Code, and OpenAI's Codex), with me
  curating the targets and reviewing the results" [R, `PUBLIC_CONTRACT_REVIEW`,
  `docs/TroppMatrixConcentration.md`]. Two human GitHub accounts opened the pull requests
  (`tchen01` 25, `DiarHaidary` 17) [R, `gh pr list`].
- Two parts besides the Lean code [R]:
  1. **The atlas** (`atlas/`): a JSON catalogue of results, sources, libraries and their
     dependencies, partly hand-written, partly generated from the Lean code; rendered as a static
     web page.
  2. **Scripts and CI** (`scripts/`, `.github/`): 17 Python scripts, 10 Lean scripts, one Node
     script, unit tests, and a CI job with 15 steps.

## 2. What it says that matters for GLCinLean

### 2.1 Review guidance

There is no single "review guide" file; the guidance is spread over `docs/STANDARDS.md` (declared
"the authoritative, current policy for the library"), `CONTRIBUTING.md`, `atlas/TARGETING.md`, the
PR template and the review reports in `docs/review/` and `docs/audit/` [R].

- **Statement before proof.** "Read the cited source and settle the mathematical statement before
  optimizing for proof convenience. Check domains, hypotheses, dimensions, constants, and
  degenerate cases. Do not weaken a theorem to make it easier to prove." [R, CONTRIBUTING §2]
- **Assumptions get the same care as proofs.** "A statement used provisionally as a scaffold or an
  explicit hypothesis must be checked with the same care as a proved one, since a wrong assumption
  propagates to every consumer. Do not label a result proved merely because its proof compiles
  against an unfinished dependency." [R, STANDARDS §3]
- **Read-back.** The PR template asks for "One paragraph, in plain mathematics, of what the Lean
  statement says, written from the Lean alone." [R, `.github/pull_request_template.md`] The
  successor keeps it and says who checks it: "The reviewer checks the read-back against the design
  note and the source" [R, successor CONTRIBUTING].
- **Review records.** The whole-library review of 2026-10-14 says "All 354 atlas cards were
  reviewed against their mathematical domains, owning definitions and Lean statements" in four
  reports with 361 records ("seven cards were reviewed in overlapping areas") [R,
  `docs/audit/2026-10-14-library.md`]. Its manifest has since grown to 11 reports with 600 records
  covering all 513 cards at `77514ce4` [R, counted from `docs/audit/2026-10-14-library.json`]. A
  record holds the card id, the informal statement, hypotheses, conclusion, a `coverage_review`
  outcome (`matched`, `corrected`, `partial`, `unformalized`, `excluded`, `scaffold`, …), a
  `review_note`, a `readback`, `findings`, a `reviewed_statement_sha256`, and the
  `checked_declarations`, each with its signature, module, line, `sorry` status and an
  `index_signature_sha256`; each report also stores the `declaration_index_sha256` it was checked
  against [R, `docs/audit/2026-10-14-matrix-krylov.json`].
- **What the review checker checks.** `scripts/check_card_audit.py` (run in CI) "validates review
  coverage and traceability, not mathematical equivalence": every record is marked final and has
  a non-empty read-back, no report lists a card twice, every card is reviewed, every cited
  declaration exists in the index, reopened claims are not marked `proved` [R]. Nothing in
  `scripts/` or `.github/` reads the stored hashes, so a changed declaration does not make its
  review stale automatically [R, `grep sha256` over `scripts/` and `.github/` finds nothing]. The
  successor does compare closure hashes, but only for its registered cost targets (§2.4) [R].
- **Who wrote the reviews.** The checker's docstring says "Mathematical judgments are the human
  read-backs in the four referenced reports" [S]; the reports themselves describe agents
  ("orthogonal-polynomial cards reviewed by the polynomial agent") [R, matrix-krylov report
  `scope`]. The two do not agree; the evidence in the reports points to agent read-backs [J].
- **What reviews found.** The Mathlib-compatibility audit (2026-10-13) found, after a green build,
  a definition with the wrong meaning (the largest Ritz value returned 0 instead of −1 for
  `A = [-1]`, because the supremum included the zero vector), a trust boundary that the README
  and CI described wrongly, and "algorithm" theorems that only took a supplied certificate [R].
  Its release criterion ends: "A green build, a low count of custom names, or strict compliance
  with the current local lint rules is not sufficient by itself." [R, compatibility audit] The
  library review of 2026-10-14 reopened "Six overbroad completion claims" [R].
- **Who reviewed on GitHub.** All 42 pull requests (numbers up to #46, shared with four issues)
  show 0 reviews and 0 comments; `CODEOWNERS` lists one owner for every path, under `/RandNLA/…`
  directories that no longer exist. The PR template's "two reviewers" for `Basic.lean` changes
  left no trace on GitHub [R, `gh pr list` on 2026-11-08]. The reviews are agent reports committed
  under `docs/` [R]. The successor is the same so far: 76 pull requests, 1 review in total [R].
- **Decision rule for a new definition:** "does Mathlib already have this object; if not, is the
  new object mathematically recognizable, are its degenerate cases intentional, and can downstream
  users enter and leave its API through standard equivalences, constructors and elimination
  lemmas? Merely counting custom definitions does not answer those questions." [R, compatibility
  audit]
- **Two bars:** "'Compatible with Mathlib' and 'ready to upstream to Mathlib' are different bars."
  [R, compatibility audit]

### 2.2 What it says about Mathlib's conventions

From `docs/STANDARDS.md` [R] unless marked otherwise:

- **Names.** Mathlib's naming guide is the reference. A theorem name spells its conclusion left to
  right; standard pieces `_eq`, `_le`, `_iff`, `_of_<hyp>`, `exists_`; hypotheses `h`-prefixed.
  "Never name a declaration after its source. … The source goes in the docstring." Named constants
  are definitions named for what they are.
- **Namespaces.** Lemmas about a structure live in its namespace for dot notation. Extensions of
  Mathlib objects go in Mathlib's owning namespace (declared as `theorem _root_.Matrix.IsHermitian.foo`
  inside `namespace NLAlib`); "`NLAlib` is not required as a wrapper namespace for every
  declaration." The successor reversed this: its rule F4 reads "A file outside ForMathlib puts its
  declarations in `namespace NLAlib`" [R, successor `docs/rules/DIGEST.md`].
- **Files.** "One concept per file, under about 500 lines", a module docstring `/-! # Title … -/`
  saying what the file provides; helpers go where they belong, "A local `Aux` namespace with copies
  of library lemmas is a defect"; `private` for proof-local details; specific Mathlib imports,
  `import Mathlib` only in scratch files.
- **Upstream candidates** live in `NLAlib/ForMathlib/`, in files named after the Mathlib directory
  they would land in (`ForMathlib/Analysis/Real.lean`).
- **Statements.** Definitions are total in Mathlib's style; "the theorem, not the definition,
  carries the hypothesis that excludes the junk value …, and the docstring of the definition
  states the junk value". Redundant hypotheses are not taken. "General form first, corollaries
  after." Split a conjunction when its parts are useful alone. One spelling per concept ("Do not
  introduce a second spelling" of the listed matrix functions).
- **Docstrings.** Every public declaration has one; the first sentence says what it asserts; a
  published result gives source and label and any deviation from the printed statement; helpers
  explain meaning and use, "they do not need an invented source citation". A docstring lint bans
  commit hashes, internal audit labels and the words "actual"/"genuine" [R,
  `scripts/check_docstrings.py`], but CI does not run it [R, `ci.yml`].
- **Renames.** Direct before `v0.1`; afterwards a deprecated alias for one release; every rename
  ships a map `docs/renames/<date>-<topic>.json`.
- **Rigid local rules were a mistake.** The audit cites Mathlib's style guide as presenting
  "guidelines rather than rigid rules" and recommended revising local rules that went beyond
  Mathlib (no theorems in `Basic.lean`, never `∃ C`, everything public, namespace conflicts) [R,
  compatibility audit §7]. The current `STANDARDS.md` has relaxed the `Basic.lean` and "everything
  public" rules ("No theorem is restricted by a filename or naming heuristic") [R].
- **Limits of its own conformance.** 179 of the 2,945 Lean files have a copyright header, and
  `scripts/Lint.lean` runs three Batteries linters (`checkType impossibleInstance
  nonClassInstance`), not `docBlame` or Mathlib's standard set [R]. NLAlib states Mathlib's
  conventions more than it enforces them [J]. The successor enforces far more by script (a
  1,370-line `docs/rules/rules.toml` with a ratchet baseline; rule F1 requires the copyright
  header) [R, file sizes and DIGEST]; how close those rules are to Mathlib was not checked.

### 2.3 System design (old repository)

- **Agent instructions.** `AGENTS.md` (51 lines) says what to read first (`STANDARDS.md`,
  `CONTRIBUTING.md`, `TARGETING.md`), how to find what exists (the generated declaration index,
  the atlas, `rg` in Mathlib), the check commands, the rules (no `axiom`, no `native_decide`,
  `sorry` only in a named scaffold) and the tagging [R]. `docs/llms.txt` (57 lines) is a short
  summary for agents, deployed with the site [R].
- **Prompts.** About 40 task briefs and reports in `docs/` (19 files named `*BRIEF*` or
  `*FOLLOWUP*`, among them `ROUND1_BRIEF.md` … `ROUND9_DIRECT_BRIEF.md`, `DEDUP_BRIEF.md`,
  `REORG_BRIEF.md`, `AUDIT_ASSUME_BRIEF.md`) [R]. The briefs read: what to read first, the policy
  applied, what to produce (with fields), groups for parallel agents, and "Final message: …" [R,
  `AUDIT_ASSUME_BRIEF.md`, `REORG_BRIEF.md`]. They are committed but "Historical (agent briefs and
  reports; nothing reads them mechanically)" [R, `oddities_infrastructure.md`]; `CONTRIBUTING.md`
  now says older briefs "do not add current requirements where they conflict with the standards"
  [R].
- **Trust boundary.** `import NLAlib` excludes modules listed in `scripts/experimental_modules.txt`
  and their import dependants; `import NLAlib.Experimental` has everything [R].
  `scripts/AuditTrusted.lean` (19 lines) fails if any declaration in an `NLAlib` module reachable
  from `import NLAlib`, "including private helpers, definitions and instances", uses an axiom
  beyond `propext`, `Classical.choice`, `Quot.sound` [R]. `scripts/Audit.lean` inventories
  `sorryAx` over the whole development and fails on a direct `sorry` whose docstring does not start
  `SCAFFOLD: <id>` [R].
- **Declaration index.** `scripts/ExtractDecls.lean` (148 lines) writes
  `atlas/declarations.json`: per public declaration its name, kind, module, line, pretty-printed
  signature, docstring, transitive `sorry`, the `atlas:` tags and the library definitions used in
  its statement [R]. CI fails when the committed index is stale [R, `ci.yml`].
- **Lean is the source of truth for links.** A declaration ending its docstring with
  `atlas: <id>` (or `atlas: <id> (partial)`) formalizes that card; `sync_atlas.py` rewrites the
  card's `formalizations`, `status` and `uses_defs` from the index; the human side (title,
  informal statement, hypotheses, conclusion, sources, `depends_on`) is hand-written [R]. CI runs
  `check_atlas.py` but not `sync_atlas.py --check`, so a stale card status is not caught [R,
  `ci.yml`].
- **Statuses:** `proved`, `scaffold`, `assumed` ("consumed as an explicit hypothesis by a proved
  result"), `stated`, `planned`, `candidate` [R, `atlas/README.md`]. A `proof_family` lists
  clauses (statement + declarations) that together cover a composite card; "This annotation
  records reviewed coverage, not a substitute for a Lean proof or an automatic check of
  mathematical equivalence." [R, STANDARDS §5]
- **Dependency graph.** `depends_on` between cards is hand-written; its in-degree is the "reuse
  score" the viewer ranks by [R, `atlas/README.md`]. `check_atlas.py` only checks that each
  `depends_on` id exists [R]. It is a graph of catalogued results, not of Lean declarations [R].
  The successor derives its dependency data from Lean (§2.4).
- **Layers.** Top-level directories have numbered layers (−1 `ForMathlib` … 5 `Solvers`); a module
  imports only its layer and lower; `check_layers.py` enforces it [R]. Directory aggregators are
  generated, never hand-edited [R].
- **Book coverage.** One JSON index per textbook, one record per numbered statement, each marked
  `nlalib`, `partial`, `mathlib`, `candidate` or `out of scope`; the books' PDFs and text stay
  outside the repository [R, `docs/coverage/README.md`]. Horn–Johnson: 607 items, 166 marked
  `mathlib` [S, its coverage table].
- **Documentation site.** `scripts/build_site.py` (37 lines) inlines `atlas.json`,
  `declarations.json`, `external.json` and the coverage data into one static HTML page with d3
  7.9.0 and KaTeX 0.16.11, deployed by `pages.yml` to GitHub Pages on every push to `main` touching
  `atlas/` or the coverage data [R]. Tabs: Area map, Scaffold, Dependency graph, Table, Books,
  Sources, Lean libraries, Declarations [R]. It is not doc-gen4 API documentation [R].
- **CI** (`ci.yml`, 15 steps): `leanprover/lean-action` with the Mathlib cache, then the
  experimental build, unit tests, import surface, trusted audit, linters, downstream examples,
  full audit, a few one-off audit files, declaration-index freshness, layers, names, atlas schema
  and consistency (including `check_card_audit.py`), book coverage, site build [R].
- **Committed generated data:** about 17 MB of JSON in `atlas/` (13.7 MB `declarations.json`) [R].
- **External code** "may be used as proof sources, but are not package dependencies": restate
  with NLAlib and Mathlib interfaces, translate, keep attribution and licence [R, CONTRIBUTING §4].
- **No pin-bump process.** Nothing in the old repository describes moving to a new Lean or Mathlib
  version, and the pin has not moved [R].

### 2.4 The successor `NLA-lib/NLAlib` (read in part)

- **Agent rules** (`AGENTS.md`, 23 lines): the contributing guide is "the contract, for agents as
  for people"; then five agent-only rules: "Do not change the checks" (the check scripts, rule
  data, allowlists, ratchet baseline, `.github/`, and "the build pins (`lakefile.toml`,
  `lake-manifest.json`, `lean-toolchain`)"); "Do not register targets"; "Do not push, and do not
  commit unless you are asked to"; run the checks before reporting; "Stay in scope. Search
  Mathlib, then `NLAlib/`, before proving anything." [R] A brief to an agent "includes
  `docs/rules/DIGEST.md` whole" (a generated one-line-per-rule digest) [R, CONTRIBUTING].
- **Statement registry with owner approval.** Cost results are theorems whose type is a
  registered target in `docs/targets.toml` (14 targets, 12 program trees) [R]. For each target the
  registry stores a **closure hash**: "SHA-256 of a canonical serialisation of every library
  constant the target's statement reaches … definitions and opaques (type and value) … Every proof
  is erased" [R, `scripts/Targets.lean`], plus the printed statement, a `reviewed` date, and the
  pins (toolchain, Mathlib revision, SHA-256 of `lake-manifest.json` and `lakefile.toml`) [R].
  `docs/targets.approved` holds the SHA-256 of the registry; CI fails if they differ, and the
  `approval.yml` workflow fails unless every change to `docs/targets.approved` is a commit
  authored, committed and personally signed by the maintainer's account [R]. CODEOWNERS assigns
  the registry, the checks, CI and the pins to the maintainer [R]. The comments say this binds
  only with branch protection and "the maintainer's token … off the agent host" [S]; branch
  protection could not be read (HTTP 404 without admin rights) [R].
- **Non-vacuity witnesses.** Every target names "a non-vacuity witness … so that no target holds
  because its hypotheses cannot be met" [R, `scripts/Targets.lean` item 7].
- **Kernel replay.** `scripts/Replay.lean` re-sends every constant of the package's `.olean`
  files to the kernel, catching proofs elaborated with `debug.skipKernelTC` or added by meta code
  without checking, which an axiom audit "cannot see" [R].
- **Site from Lean.** `scripts/Explore.lean` extracts every public declaration with its signature,
  docstring, "library dependencies of its type and of its value", and `sorryAx` dependence [R].
  CI on `main` publishes the JSON as a release asset and asks a separate repository,
  `NLA-lib/NLA-lib.github.io`, to rebuild the site [R, `explore.yml`]. The generated data is no
  longer committed to the library repository [R, file list].
- **Updates.** "Mathlib bumps are their own PRs and are tagged. Releases are tagged with the Lean
  version they build against (`v4.33.1-nlalib.1`)." [R, CONTRIBUTING] No bump has happened yet [R].

## 3. What it means for GLCinLean

- **Mathlib style (ideas: "Code quality as high as possible", Xena "Document and organize").**
  STANDARDS §1–4 is a compact, mostly Mathlib-faithful digest: name by conclusion, never by
  source; owning namespaces; total definitions with documented junk values; source and deviation
  in the docstring. Worth citing in step 1 as a model, but only after the Mathlib sources
  themselves (see `mathlib-style-guide.md`, `mathlib-doc-style.md`) [J]. Its own lesson is to
  avoid local rules stricter than Mathlib [R, §2.2]; the successor's reversal of the namespace
  rule shows how quickly such local rules change [J].
- **One authoritative file (decision "Shared context lives in `AGENTS.md`", step 1).** NLAlib's
  briefs piled up and contradicted the standards until it declared one file authoritative and the
  rest history [R]. For GLCinLean: keep one live rules file (`AGENTS.md`) and make every prompt
  defer to it; treat session reports as history [J].
- **Prompt shape (decision "Prompts hold only the goal, the completion criteria and the context").**
  NLAlib's briefs fit that shape (read first, what to produce, groups, final message) and add the
  required output fields [R]. The "groups" section is a simple way to fan out subagents in one
  prompt [J].
- **Statements and placeholders (step 2; open question on `Abstract.lean`/`Foundations.lean`).**
  The rule that a scaffold or hypothesis needs the same review as a proof applies directly to
  GLCinLean's `@[placeholder]` opaques: every placeholder is part of what the GLC statement means
  [J]. NLAlib only has scaffolds for theorems (`sorry` in a `SCAFFOLD:` declaration) and the
  `assumed` status; it has no missing *objects*, so it offers no pattern for opaque definitions
  [R, `grep` finds no `opaque` declaration under `NLAlib/`]. Its trust boundary could carry over: a
  check that lists every declaration whose value transitively reaches a placeholder, as
  `Audit.lean` does for `sorryAx` [J]. Note that `collectAxioms` does not see opaques, so such a
  check needs its own walk over constants, like the successor's closure hash [J]. The successor's
  non-vacuity witness answers a risk that placeholders share: a statement that holds only because
  its hypotheses cannot be met [J].
- **Review system: what to take (ideas "The review system").**
  - The read-back paragraph "written from the Lean alone", then compared with the source, is a
    cheap, strong check for fresh-agent reviews in step 4 [J].
  - The record format (declaration, signature, signature hash, outcome, findings, read-back) is
    close to the owner's "pinned and tagged" declarations [R/J]. The old NLAlib stores hashes but
    never compares them [R]. The successor's target registry does compare: a closure hash over
    everything a statement reaches, proofs erased, checked in CI against an owner-approved file
    [R]. That is the owner's reviewed / changed-since-review status, implemented for statements;
    it is also a stronger, enforced form of GLCinLean's existing (unapproved, currently unchecked)
    `reviews/statement-pin.toml` [J].
  - Docstring tags (`atlas: <id>`) synced into a catalogue keep Lean as the source of truth and
    are a light way to attach review tags to declarations [J].
  - `ExtractDecls.lean`, `AuditTrusted.lean` and the successor's `Explore.lean` (type and value
    dependencies) could be adapted (Apache 2.0) for the review system's input: a declaration index
    with signatures, docstrings, dependencies and axioms [J].
  - The single-file static site with a d3 graph and KaTeX matches the owner's "web page generated
    directly from it, with the dependency graph and review tags" [J]. The old graph is
    hand-written between results; the successor's Lean-derived data, published by CI to a site in
    a separate repository, is closer to the owner's plan (input "a Lean project documented in
    Mathlib's style", review system in its own repository) [J].
- **Review system: what to avoid.** Seventeen Python scripts, one-off audit files in CI and 17 MB
  of committed JSON are the "complex system or harness" the owner wants to avoid in this
  repository [J]. If any of it is wanted, it belongs in the separate review-system repository [J].
  The successor moved generated data out of the library repository, which points the same way [R/J].
- **Mathematical review standard (open question "Who reviews the mathematics").** NLAlib is
  evidence that a green build does not catch a misstated definition (the Ritz case) and that
  agent reviewers can find such errors when told to check domains and degenerate cases [R].
  It also shows agent-only review with almost no human trace on GitHub, in both repositories [R].
  The successor's answer for statements is that only the maintainer approves them, by signed
  commit [R].
- **Library design (ideas 1 and "Avoid duplication").** `ForMathlib/` named after Mathlib
  directories is a convenient staging area for upstream candidates [J]. For GLCinLean the
  analogue is Tau Ceti: the owner's plan is to contribute there directly (idea 4), so a staging
  directory would only hold what Tau Ceti does not want yet [J].
- **Coverage index per paper (idea 5, papers).** NLAlib keeps books outside the repository and
  commits a per-book index of numbered statements with a status each [R]. For GLC I this would
  record, for each numbered definition and statement the conjecture uses, whether it is in
  Mathlib, Tau Ceti, a roadmap, GLCinLean or missing; it fits step 2's blueprint [J].

## 4. Conflicts

- **With idea "Stay up to date" and the decision "Keeping up with Mathlib and Tau Ceti is fully
  automated":** NLAlib has stayed on one Mathlib commit (2026-08-21 per `docs/audit/G0.md`) and Lean
  `v4.33.1` throughout; the successor has a one-line policy ("Mathlib bumps are their own PRs and
  are tagged") but no bump yet [R]. It is no model for automated updates [J].
- **With the decisions "Agents push themselves" and fully automated updates:** the successor's
  `AGENTS.md` forbids agents to push, to commit unasked, to edit the build pins, the checks or CI,
  and to change approved statements [R]. Its trust model rests on the agent being unable to
  approve its own statement changes [S]. GLCinLean has chosen the opposite for pushing and pins;
  the successor's position matches GLCinLean's current `AGENTS.md` owner's-files note, which the
  workflow plans to replace [J].
- **With idea 3 and the Tau Ceti dependency:** NLAlib forbids external Lean libraries as package
  dependencies (port and restate instead) [R]; GLCinLean depends on Tau Ceti by design [R,
  `lakefile.toml`]. The difference is a choice of scope, not an error on either side [J].
- **With idea "work in a very simple way … without any complex system or harness":** NLAlib's
  tooling is heavy (§2.3), and the successor's is heavier (CI with kernel replay, fixtures,
  signed-approval workflow, a 1,563-line `Targets.lean`) [R]. Taking its ideas is compatible;
  taking its scripts into this repository is not [J].
- **With the Xena principle "Review additions publicly, according to agreed standards":** NLAlib
  reviews are committed reports by agents; no PR in the old repository has a public review, and
  the successor has one in 76 [R]. The standards are public; the review is not peer review [J].
- **With the existing `reviews/statement-pin.toml`:** GLCinLean's pin stores a statement hash
  ("CI fails on a mismatch until the owner re-approves") and a transitive digest (a mismatch "only
  marks the entry stale") for `GLCinLean.Abstract.main` and `Setting`; its header says "NOT YET
  APPROVED", and commit `0feeb6f` removed the CI workflow, so nothing checks it now [R, the file and
  `git show 0feeb6f`]. The old NLAlib hashes signatures but checks nothing [R]. The successor does
  what GLCinLean's pin intends, more thoroughly and actually enforced (proofs erased, pins
  included, signed approval, CI) [R/J]. NLAlib is no reason to drop the pin [J].
- **Inside NLAlib:** the README and `STANDARDS.md` describe an experimental surface with
  unfinished proofs, while the index at `77514ce4` has no declaration depending on `sorry` and
  `experimental_modules.txt` has no entries [R]; the PR template still names the library
  `randnla` and asks for "two reviewers", and `CODEOWNERS` points at `/RandNLA/` paths [R]; the
  card-audit checker calls the read-backs "human" while the reports name agents [R]. This is drift,
  not a contradiction of substance. Documentation drifts quickly under agent-driven change [J].

## 5. Input for the open questions

- **What goes into `AGENTS.md`, and where "update the next prompt" lives.** NLAlib's `AGENTS.md`
  is short and procedural: what to read, how to search, what to run, the hard rules (no `axiom`,
  no `native_decide`, `sorry` only in named scaffolds), the tagging [R]. The successor's is
  shorter still (23 lines): the contributing guide is the contract, plus five agent-only rules
  about what an agent may not touch [R]. Suggests: GLCinLean's `AGENTS.md` holds the goal, the
  hard rules (including which files an agent may not change, e.g. the statement pin) and "search
  Mathlib, then Tau Ceti, before defining"; the style rules are links to Mathlib's pages rather
  than a copy [J]. NLAlib has no rule for updating the next prompt; its briefs were written fresh
  each round and then went stale [R]. This supports putting the rule in `AGENTS.md`, where every
  session reads it [J].
- **Whether `PLAN.md` is needed.** NLAlib has no plan file; the atlas (targets with status) and
  `TARGETING.md` play that role [R]. Suggests: a target list with statuses (the blueprint of step
  2) can replace a prose plan, provided it is kept by the same session that changes the code [J].
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.**
  NLAlib's rules bear on three points [J]: (a) a placeholder must be reviewed as carefully as a
  proved definition, since the statement's meaning depends on it; (b) a transitive check that
  lists what depends on each placeholder makes the statement's trust status visible, as
  `AuditTrusted.lean` does for `sorry`; (c) a non-vacuity witness, as the successor requires of
  its targets, would show the GLC statement is not trivially true for its placeholders. NLAlib has
  no direct precedent for opaque placeholder objects [R].
- **What happens to each existing file.**
  - `references/papers/manifest.toml`: NLAlib keeps sources outside Git with no manifest, but
    records each book in the atlas `sources` with its role [R]. Suggests the owner's view (TeX
    untracked) works, with the paper and version named in one committed place such as
    `AGENTS.md` or the blueprint [J].
  - `reviews/statement-pin.toml`: the successor's `docs/targets.toml` + `docs/targets.approved` is
    the same idea, matured: closure hash with proofs erased, the pins, a `reviewed` date, and an
    approval only the owner can write [R]. Suggests keeping the pin and, if anything, moving it
    towards that design [J].
  - `reviews/sorry-budget.toml`: NLAlib's equivalent is the `SCAFFOLD:` docstring tag plus an
    audit that fails on an untagged `sorry` [R]. A tag in the code is simpler than a separate
    budget file [J].
  - `prompts/`: NLAlib's briefs show the cost of many committed prompts that are never retired
    [R].
- **Who reviews the mathematics, and to what standard.** NLAlib suggests fresh agents can do
  useful statement reviews when the standard is explicit (domains, hypotheses, constants,
  degenerate cases, read-back from the Lean alone) [R/J]. It also shows the limit: its own
  checker checks traceability, "not mathematical equivalence" [R]. Its successor reserves the
  approval of statements to the maintainer [R]. For the GLC statement, whose definitions the
  owner cannot check, agent review alone is weak evidence and an owner's approval would be approval of process, not mathematics; an outside expert for the final
  statement remains worth having [J].
- **Where research notes and session summaries live, and whether they are committed.** NLAlib
  commits all briefs and reports in `docs/` (44 entries at the top level, 12 of them directories)
  and later had to declare them history [R]. The successor keeps per-topic design notes in
  `docs/design/` instead [R, file list]. Suggests: commit them, in one directory marked as
  history, never cited as rules [J].

## 6. Questions for the owner

1. Should every review in GLCinLean include a read-back paragraph written from the Lean alone,
   before the reviewer compares it with the paper?
2. For the review system, should a declaration's review be invalidated by a change to its
   signature only, by a change to anything its statement reaches (the successor's closure hash,
   proofs erased), or also by a change to its proof? (The owner's idea names the Git commit;
   GLCinLean's pin already has both a statement hash and a transitive digest.)
3. Should the review system's dependency graph be derived from Lean (as tracker and the
   successor's explorer do) or include hand-written links between results (as the old atlas does)?
4. Should GLCinLean commit a coverage index of GLC I (each numbered definition and statement the
   conjecture uses, with its status), while the TeX itself stays untracked?
5. Should changes to the GLC statement pin need an approval that only the owner can give (as the
   successor's signed `targets.approved`), even though agents push everything else? If so, which
   files besides the pin should be out of the agents' reach?
6. Should the GLC statement carry a non-vacuity check for its placeholders (a theorem that its
   hypotheses can be met), and who decides what counts as one?
