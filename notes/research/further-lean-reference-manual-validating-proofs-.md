# Lean reference manual, "Validating a Lean Proof", with `lake check` and `lake comparator`

- **Main source:** Lean Language Reference, chapter "Validating a Lean Proof",
  <https://lean-lang.org/doc/reference/4.36.0-rc2/ValidatingProofs/> (the `latest` URL serves the
  same page: built from reference-manual commit `d26b8c527633fad0f50b676679230cc623cee8a7`,
  2026-10-28; I compared the two texts and they are identical).
- **Also read:**
  - Lake chapter, section 25.1.5.8 "Challenges and External Checkers",
    <https://lean-lang.org/doc/reference/4.36.0-rc2/Build-Tools-and-Distribution/Lake/>;
  - Lean 4.35.0 release notes (2026-10-12), <https://lean-lang.org/doc/reference/4.35.0/releases/v4.35.0/>
    (page built from commit `54e83e8e886c960ae86deb160e52c8f234290364`);
  - `lake check --help` and `lake comparator --help`, run locally under this repository's
    toolchain `leanprover/lean4:v4.36.0-rc2` (Lake `5.0.0-src+b35cb10`);
  - the core implementation `src/lake/Lake/CLI/Check.lean` and `src/lake/Lake/Check/Compare.lean`
    at tag `v4.36.0-rc2` of `leanprover/lean4`; on re-check also `Lake/Check/Axioms.lean`,
    `Lake/CLI/Main.lean` (`checkExport`) and `LeanExport/Basic.lean` (`dumpEnv`), read from the
    toolchain's own `src/` (`src/lean/` in the elan toolchain directory);
  - the standalone comparator, <https://github.com/leanprover/comparator/tree/865edc14486c3388e9225daa971da8e157488c3e>
    (README, `Comparator/Compare.lean`, `Comparator/Axioms.lean`, tests);
  - for comparison, Mathlib's `.github/workflows/daily.yml` and `build_template.yml` (Mathlib
    `1b1ccf4b`) and Tau Ceti's `.github/workflows/nightly-verify.yml` (Tau Ceti `e0610cce`, tag
    `v4.36.0-rc2`), as pinned in this repository's `lake-manifest.json`.
- **Checked 2026-11-08.**
- **Licence:** the reference manual and Lean core are Apache-2.0 [R, GitHub API, 2026-11-08]; only
  short quotes are used here.
- **Access:** the `fetch` tool refused lean-lang.org (it resolved to a non-public address); I
  downloaded the pages with `curl` and read their text. I did not read the individual Lean pull
  requests (#14990, #14885, #15146 and so on), only the release notes, help texts and source.
- **Re-check (2026-11-08, second reader):** re-downloaded the three manual pages, confirmed the
  `latest` and `4.36.0-rc2` texts of the chapter are identical, re-read the quotes and the core
  source, and built a three-line probe project (`.lake/research/vp-probe/`, no Mathlib). A
  sandboxed `lake comparator` was run; an unsandboxed run
  (`--inadvisably-no-sandbox`) was **not** run, because the session's permission system refused
  it, so nothing below about unsandboxed behaviour is tested.

## 1. What it is

The reference manual's official "ladder of trust" for a Lean result: four checks, each stronger
than the last, with what each protects against and what one must still trust. Since Lean 4.35.0
the strongest rung is built into Lake as two commands:

- `lake check`: builds the project, exports it, replays it through the kernel, and fails on any
  non-standard axiom;
- `lake comparator`: checks a solution module against a trusted challenge module (same
  statements, permitted axioms only, accepted by the kernel).

The standalone comparator repository now says it is deprecated in favour of these commands [R,
README, 2026-11-08].

## 2. What it says that matters for GLCinLean

### 2.1 Honest versus malicious, and statement versus proof

- The manual distinguishes an **honest** proof attempt (benign mistakes only) from a
  **malicious** one, and says malicious "includes un-reviewed AI-generated proofs and programs"
  [R, 2026-11-08].
- It separates two questions: "does the theorem have a valid proof" and "what does the theorem
  statement mean" [R]. The "Trust" paragraphs of the first three rungs begin "This check is
  meaningful if one believes the formal theorem statement corresponds to its intended informal
  meanings"; the gold standard's reads "This check is meaningful if the theorem statement in the
  trusted challenge file is correct and the sandbox used to build the possibly-malicious code is
  safe" [R, 2026-11-08]. So at the top rung the statement question moves into the challenge file.

### 2.2 The four rungs

| Rung | How | Protects against (cumulative) |
|---|---|---|
| Blue double ticks / `lake build +Module` without errors or warnings | editor or build | incomplete proof or `sorry` in the theorem itself, honest tactic bugs, proofs still being checked |
| `#print axioms thm` | expect only `propext`, `Classical.choice`, `Quot.sound` | `sorry` in dependencies (shows as `sorryAx`), custom axioms; `_native` axioms flag native evaluation |
| `lean4checker --fresh` | replays the `.olean` files through the kernel | bugs in Lean's handling of kernel state; meta-code that adds unchecked theorems |
| "Gold standard": `lake comparator` with external checkers | trusted challenge file, sandboxed build | actively malicious proofs; bugs present in some but not all checkers |

[R, 2026-11-08]. Further points:

- Rung 1 alone does **not** catch `sorry` in dependencies: "The blue double check marks appear
  even when there are explicit uses of sorry or incomplete proofs in the dependencies" [R].
- For `lean4checker` the manual recommends running it in CI; `lean-action` has
  `lean4checker: true` [R]. The toolchain now ships it as `leanchecker` (also
  `leanchecker-paranoid`) [R, `ls` of the v4.36.0-rc2 `bin/`].
- The gold standard "should only be necessary for high risk scenarios (proof marketplaces,
  high-reward proof competitions, unaligned AI)" [R].
- The chapter lags the tools: it says "At the time of writing, comparator supports using the
  official Lean kernel and the external checker nanoda", while the v4.36.0-rc2 toolchain bundles
  five external checkers (2.3) [R, 2026-11-08].
- What remains to be trusted even then: Lean's logic, the comparator plumbing, the sandbox, no
  bug shared by all checkers, and "No human error or misleading presentation of the theorem
  statement in the trusted challenge file. If there are doubts that the theorem means what it
  appears to mean, its statement and all referenced definitions must be investigated carefully,
  in particular with regard to custom notation and type classes." [R]
- `Lean.trustCompiler` was removed in Lean 4.35.0; since 4.29.0, `decide +native` and
  `bv_decide` add one axiom per native computation [R].

### 2.3 `lake check`

- "builds the root package's default targets, exports them, and replays the result through
  Lean's kernel. It then reports the axioms that the checked code uses, and fails if any of them
  is not one of the standard axioms." [R, Lake manual]
- The permitted set is hard-coded: `standardAxioms := #[propext, Classical.choice, Quot.sound]`,
  with no option to extend it [R, `Lake/CLI/Check.lean` at v4.36.0-rc2]. So `sorryAx` makes it
  fail, with a message "Axiom 'sorryAx' is not permitted; it is used by '<decl>'" [R, same file].
- `--paranoid` also runs every bundled checker: `leanchecker-paranoid`, `lean4lean`, `nanoda`,
  `con-leche`, `con-ron`; all must accept [R, `lake check --help`]. (The 4.35.0 release note for
  #15145 lists four of these, without `con-ron` [R]; the help text, which is newer, lists five.)
- **What it exports and scans: the whole environment, not only this project.** Inside the
  sandbox it builds the default targets, imports their modules, and calls `LeanExport.dumpEnv env`
  with no constant list, which exports "every non-internal constant in scope" [R,
  `Lake/CLI/Main.lean` `checkExport`, `LeanExport/Basic.lean`]. The axiom check then walks every
  constant of that export (`usedAxioms`, `Lake/Check/Axioms.lean`) [R]. So everything imported
  from Mathlib and Tau Ceti is replayed through the kernel(s), and a single `sorryAx` or native
  axiom anywhere in the imported closure fails the run, not just one in GLCinLean's own files [R
  for the code, J for the consequence].
- `lake comparator`, by contrast, passes the named theorems, holes and permitted axioms to the
  exporter (`withSafeExport module decls`), so it exports only those constants and what they use
  [R, `Check.lean` `compareIt`; J that the exporter follows dependencies, from
  `LeanExport/Basic.lean`]. It is therefore much smaller than a `lake check` export [J].
- `--from-export FILE` checks a ready NDJSON export, for example one built in a VM [R].
- Exit codes: 0 accepted, 1 rejected or build failed, 2 could not start (no `bwrap`, no
  `lake-manifest.json`, or no default targets) [R].

### 2.4 `lake comparator`

- Configuration, by default `comparator.json` in the current directory [R, help text]:

  ```json
  {
    "challenge_module": "Challenge",
    "solution_module": "Solution",
    "theorem_names": ["imo2024_p1"],
    "definition_names": [],
    "permitted_axioms": ["propext", "Quot.sound", "Classical.choice"],
    "external_kernels": {"nanoda": ["nanoda_bin"]}
  }
  ```

  `permitted_axioms` "is deliberately not defaulted: it is what the verdict means, so the
  challenge author states it" [R].
- The Lake manual defines `theorem_names` as "An array of theorem names. These theorems should be
  complete in the solution, but sorry in the challenge" [R, Lake manual 25.1.5.8.1]. The command
  is built to give one verdict on a finished proof, not to watch a statement during the work.
- What it compares [R, `Lake/Check/Compare.lean` at v4.36.0-rc2, the same algorithm as the
  standalone `Comparator/Compare.lean`]:
  - each name in `theorem_names` must be a theorem in both modules with the same type and
    universe parameters;
  - then it walks **transitively** through every constant the statements use: each non-target
    constant must be **identical** (whole `ConstantInfo`, so definition bodies too) in challenge
    and solution;
  - each name in `definition_names` (a "definition hole") must be a `def` in both, with the same
    name, type, universe levels and safety; its body is free. Holes must be written in the
    challenge as `def x : T := sorry`; an `opaque` is rejected ("Challenge constant is not a
    definition") [R, source].
  - The README warns that holes "can be gamed" (`def ChallengeSolution : Prop := RiemannHypothesis`)
    and that "all definition hole solutions **must** always be checked with an additional
    (potentially human) verifier" [R, comparator README].
- The axiom check covers only the listed theorems and holes (and what they use), against
  `permitted_axioms`; nothing in the code stops `sorryAx` from being listed [R, standalone
  `Comparator/Axioms.lean` and core `Lake/Check/Axioms.lean` `checkAxioms`, which has no special
  case for any axiom name].
- Order and exit codes: the statement comparison runs first, then the axiom check, then the
  kernels (`verifyMatch` in `Check.lean`) [R]. A statement mismatch and a forbidden axiom both
  exit with code 1; only the error text tells them apart ("Challenge and solution theorem
  statement do not match" or "Const does not match …" versus "Illegal axiom detected") [R,
  source].
- Non-target constants in the closure are compared whole, proofs included. So every sorried
  theorem that the statement reaches must itself be in `theorem_names`, or its real proof will
  differ from the challenge's `sorry` and the comparison fails [R, `Compare.lean` `loop`; J for
  the consequence].
- A test in the comparator repository has exactly GLCinLean's pattern: a sorried existence
  theorem `hex`, a definition `w := Classical.choose hex`, and a theorem about `w`; listing both
  theorems in `theorem_names` is accepted (`tests/projects/theorem_hole_issue`) [R]. Compare
  `exists_isLanglandsFunctor`, `LG := Classical.choose (exists_isLanglandsFunctor S)` and `main`
  in `GLCinLean/Abstract.lean` [R, lines 112–133]. By the previous point,
  `exists_isLanglandsFunctor` must be listed next to `main` [J].

### 2.5 The sandbox: Linux only

- Both commands treat the workspace as untrusted and build and export it inside `bwrap`; "the
  sandbox is available only on Linux" [R, Lake manual]. On any other platform, without the flag
  below, they refuse to run: "`lake {cmd}` sandboxes the code it checks with `bwrap`, which needs
  Linux namespaces." [R, `Check.lean`].
- `--inadvisably-no-sandbox` runs everything unsandboxed; "the result is not trustworthy. It is
  intended only for experts who provide isolation by other means." [R]
- Only dependency resolution gets network; build, export and kernels run with no network [R,
  HARDENING section]. The comparator README says running `lake exe cache get` beforehand is
  acceptable if one trusts the cache [R]; the build inside the sandbox then reuses `.lake` [J].
- On a machine that is not Linux and has no `bwrap` [R, `lean --version`, `which bwrap`,
  2026-11-08], on the probe project `lake comparator` printed "error: `lake
  comparator` sandboxes the code it checks with `bwrap`, which needs Linux namespaces." and exited
  with code 2 [R, run 2026-11-08].

### 2.6 How Mathlib and Tau Ceti use these checks

- Mathlib: "We no longer run `lean4checker` in regular CI, as it is quite expensive for little
  benefit. Instead we run it in a cron job on master" (`build_template.yml`); `daily.yml` runs
  `lake env leanchecker --fresh Mathlib` and `... Batteries` on `ubuntu-latest` [R, 2026-11-08].
- Tau Ceti: a nightly from-source verification; "A clean build alone now exceeds GitHub-hosted
  runners' six-hour platform limit", so it runs on a 16-core Namespace runner with a 720-minute
  timeout; its own "comparator" there is a byte-comparison script, not `lake comparator` [R,
  `nightly-verify.yml`]. I found no use of `lake check` or `lake comparator` in either [R, grep,
  2026-11-08].
- But Tau Ceti already runs its own equivalent of `lake check`'s axiom part: `lake exe axioms`
  (`scripts/Axioms.lean`, "Human-owned governance" in its lakefile), which requires that "Every
  TauCeti declaration must depend only on `propext`, `Classical.choice`, and `Quot.sound`",
  catching `sorry`, native-decision axioms and custom axioms; the nightly runs it on the
  from-source build [R, Tau Ceti `e0610cce`]. Mathlib forbids `native_decide` by a linter [R,
  `Mathlib/Tactic/Linter/DeprecatedSyntaxLinter.lean`]. So the imported upstream closure should
  pass `lake check`'s whole-environment scan [J].

## 3. What it means for GLCinLean

1. **The toolchain already has both commands.** `lean-toolchain` is `v4.36.0-rc2` and `lake check
   --help` works under it [R]. No pin decision is needed to get them [J].
2. **By the manual's own words, GLCinLean is at the "malicious" end until reviewed**: it is
   written by agents, and "un-reviewed AI-generated proofs" count as malicious [R]. For the proof
   (workflow step 6) the gold standard is the fitting final check, not an extra [J].
3. **The statement freeze can be a comparator challenge, but only for the statement level.**
   - Today `reviews/statement-pin.toml` has two levels: `statement` (hard) and `digest`
     (transitive, soft) [R]. A `Challenge.lean` plus `comparator.json`, owned by the owner, would
     replace the hard level with a mechanism built into Lean and readable as plain Lean in a Git
     diff [J]. That fits ideas.md "Set standards, and meet them" and "work in a very simple way":
     no custom tool is needed [J].
   - It covers part of the digest level, not all of it. Comparator checks every constant in the
     statement's closure, bodies included (2.4), so with a separate challenge copy it also catches
     changes to the project's own definitions (`Foundations.lean`, the placeholders), which the
     `statement` level ("the declaration's own statement with named references") does not [R
     for the pin's wording, J for the comparison]. What it cannot see is upstream drift:
     challenge and solution are built in the same workspace against the same Mathlib and Tau
     Ceti, so an upstream change to a definition the statement uses changes both sides and the
     comparator still accepts [J, from the algorithm in 2.4]. Detecting upstream drift would need
     a stored challenge export (`--challenge-from-export`), which would then fail on every bump
     that touches anything in the statement's closure [J].
   - **During the work it needs a second configuration.** With the standard axioms only, it
     rejects (exit 1, "Illegal axiom detected") as long as any listed theorem is sorried (2.4), so
     it cannot watch the statement before the proof is done. A statement-only configuration that
     adds `sorryAx` to `permitted_axioms` would make it compare statements and closures and
     ignore missing proofs [R for the code, J for the use; not run, 2026-11-08]. The final
     configuration, with the standard axioms only, is then the "proved" verdict. Both files would
     be the owner's.
   - It only means something if the challenge is **separate source**: if the solution imports the
     same `Foundations.lean` as the challenge, an agent's change there changes both sides
     unnoticed [J]. So the challenge should be a self-contained copy of the abstract that imports
     only Mathlib and Tau Ceti. Today's `Abstract.lean` imports `GLCinLean.Foundations` [R]. Such
     a copy cannot carry `@[placeholder]` without importing ReviewKit; attributes are not part of
     the compared `ConstantInfo`, so dropping them there changes nothing in the verdict [J].
4. **The placeholders meet comparator's definition holes.** A placeholder that later becomes a
   real definition is exactly a hole. But holes must be `def … := sorry` in the challenge, not
   `opaque` (2.4); and a filled hole's body is checked by nobody, so each one needs review [R,
   README]. Alternatively, keep placeholders as ordinary constants in the challenge: replacing one
   then makes the comparator fail until the owner updates the challenge, which turns every
   replacement into an owner-visible event [J]. Either way this bears on step 2's decision about
   `Abstract.lean`, `Foundations.lean` and `@[placeholder]`.
5. **`lake check` fails on this repository until the proof is finished.** The statement surface
   has four sorried theorems (`Abstract.lean` l.76, 114, 121, 133) [R], and `lake check` accepts
   only the three standard axioms with no option [R]. So it cannot be a pass/fail gate in the
   automated bumps (workflow decision "Keeping up with Mathlib and Tau Ceti is fully automated")
   for the whole project now [J]. Since it scans the whole imported environment (2.3), it can be
   a gate for a sorry-free library part (the geometric-representation-theory backbone of ideas.md
   point 1) only if that part has its own default target or its own small workspace that does not
   import the sorried abstract, and its imports are sorry-free too [J]; Tau Ceti's own audit
   suggests they are (2.6) [J]. Library code meant for Tau Ceti must be sorry-free anyway: Tau
   Ceti's `lake exe axioms` rejects anything beyond the three standard axioms [R, 2.6].
6. **Running it needs Linux.** On macOS the commands do not run without
   `--inadvisably-no-sandbox` (2.5). In an honest setting with the project's own code, running
   unsandboxed locally is defensible, but the manual says the result is then "not
   trustworthy" [R]. A trustworthy run needs a Linux machine or a GitHub Actions job, and the last
   commit (`0feeb6f`) dropped CI [R, git log]; adding one back conflicts with "without any complex
   system or harness" (ideas.md) [J].
7. **Cost: run it at milestones, not on every bump.** Mathlib moved its kernel replay out of
   regular CI because of cost; Tau Ceti's clean build no longer fits a 6-hour GitHub runner [R].
   A `lake check` export of GLCinLean includes every constant it imports from Mathlib and Tau
   Ceti [R, 2.3], so a `--paranoid` run over five extra kernels is likely hours [E, not measured].
   A `lake comparator` run exports only the statement's closure and is much cheaper [J, 2.3]. A cheap per-bump
   check is `lake build` plus `#print axioms` on the main declarations (rung 2); `lake check`
   and `lake comparator` fit the end of a phase: the statement's approval, and the proof's
   completion [J].
8. **Statement faithfulness stays a human question.** The manual is explicit (2.2). This supports
   ideas.md "Link to the existing literature. A mathematician should be able to trust and verify
   that the concepts … have the expected meaning", and it means the checks above say nothing about
   whether `Setting`, `LG` or the placeholders match GLC I [J]. The challenge file is exactly the
   object an outside expert should read [J].
9. **For `AGENTS.md` (workflow step 1):** a short rule fits there: a result is "done" only when
   `#print axioms` shows no `sorryAx` beyond the budget, and "proved" only when `lake comparator`
   accepts it against the owner's challenge [J].

## 4. Conflicts

- **With the brief that found this source.** It says the commands need "a toolchain of at least
  v4.35.0, a pin decision for the owner". The repository is already at `v4.36.0-rc2` [R], so there
  is no pin decision for this reason [J]. It also says to "run `lake check` in the automated
  Lean/Mathlib bumps"; with four sorried theorems that run fails every time (3.5), and Mathlib's
  experience argues against running kernel replay on every change (3.7) [J].
- **The brief's "replaces a hand-made statement pin"** holds only for the statement level of
  `reviews/statement-pin.toml`, not its transitive digest (3.3) [J].
- **With ideas.md "Work in a very simple way … without any complex system or harness".** The
  commands themselves are simple and built in [J], but a trustworthy run needs Linux, which means
  a CI job or a Linux machine, after commit `0feeb6f` dropped CI [R/J].
- **With ideas.md "Stay up to date. Ensure continuous compatibility with every release"** and the
  workflow decision to automate bumps: a self-contained challenge copy written against Mathlib
  and Tau Ceti names breaks whenever an upstream rename touches it, and then the owner's file must
  change [J]. Every bump that touches the statement's names becomes an owner decision.
- **With the current placeholder design** (`AGENTS.md`: placeholders as `@[placeholder]` on an
  `opaque`): comparator's definition holes must be `def … := sorry`, so opaque placeholders cannot
  be holes (3.4) [R/J].
- **With the manual itself, in tone:** it calls the gold standard necessary "only" for high-risk
  cases, yet classes unreviewed AI output as malicious [R]. For an all-agent project the second
  sentence is the one that applies [J].
- No conflict found with the other notes' sources on the facts above. Mathlib and Tau Ceti do not
  use these commands yet [R], though Tau Ceti enforces the same standard-axioms rule with its own
  `lake exe axioms` (2.6) [R].
- **Cache use inside the sandbox (2.5) is reconciled** with `further-lake-comparator-lake-check-lean-core-suc.md` in that note's §7 "Reconciliation" (2026-11-08).

## 5. Input for the open questions (notes/workflow.md)

- **What goes into `AGENTS.md`.** One short validation rule (3.9): which rung is required when
  (build plus `#print axioms` always; `lake comparator` against the owner's challenge before
  calling anything proved). Reason: agents otherwise stop at rung 1, which misses `sorry` in
  dependencies [R/J].
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.** The
  abstract's shape (imports Mathlib, Tau Ceti, and one foundations file; sorried existence,
  `Classical.choose`, main theorem) works with comparator as it stands [R, test
  `theorem_hole_issue`]. What would change: (a) the trusted challenge should not import the live
  `Foundations.lean`; (b) decide whether placeholders are definition holes (`def … := sorry`,
  bodies reviewed by hand) or ordinary constants (every replacement updates the challenge) [J].
- **What happens to each existing file.**
  - `reviews/statement-pin.toml` → candidate replacement for its `statement` level:
    `Challenge.lean` + `comparator.json`, both owner's files. Its `digest` level has no
    replacement here [J].
  - `reviews/sorry-budget.toml` and ReviewKit's `review axioms` → `#print axioms` and `lake check`
    output name each `sorryAx` user, but neither has a "budget" with approvals; comparator's
    `theorem_names` (the sorried theorems of the challenge) is the closest built-in equivalent,
    but it is a list of what must be proved at the end, with no per-entry approval, and in the
    final configuration none of them may stay sorried (2.4) [R/J].
  - The `@[placeholder]` attribute (ReviewKit) → `definition_names` in `comparator.json` could
    serve as the list of placeholders, if they become `def … := sorry` [J].
  - `lakefile.toml`: a challenge module needs to be buildable (a `lean_lib` for it, or a separate
    small workspace) [J]; this is an owner's file.
- **Who reviews the mathematics, and to what standard.** The manual says this is human work: the
  statement "and all referenced definitions must be investigated carefully, in particular with
  regard to custom notation and type classes" [R]. Suggestion: fresh agents can review, but the
  challenge file, being the single trusted object, is where an outside expert's time is best spent
  [J].
- **Where notes and session summaries live:** this source says nothing.

## 6. Questions for the owner

1. Should the frozen GLC statement become a `lake comparator` challenge (`Challenge.lean` +
   `comparator.json`, your files), replacing the `statement` level of
   `reviews/statement-pin.toml`? If yes: (a) should a second, statement-only configuration
   (with `sorryAx` permitted) run during the work, and the standard-axioms one only at the end;
   (b) should something keep watching upstream drift in the statement's closure, which comparator
   does not see?
2. Where should these checks run: locally with `--inadvisably-no-sandbox` (simple, but "not
   trustworthy" by the manual's words), on a Linux machine, or in a GitHub Actions job (which
   brings CI back)?
3. When should they run: at every automated bump (expensive, and `lake check` fails while any
   sorry remains), or at milestones only (statement approval, proof completion, perhaps a weekly
   run)?
4. Should placeholders be comparator definition holes (`def … := sorry`, each filled body
   reviewed by hand), or ordinary constants of the challenge, so that every replacement needs
   your update of the challenge?
5. Is `--paranoid` (all five extra kernels) wanted for the final proof check, accepting a run of
   probably several hours [E]?
