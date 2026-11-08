# ReviewKit (WHY-Op109/reviewkit)

- Source: https://github.com/WHY-Op109/reviewkit at commit
  [`3fd3bfa7`](https://github.com/WHY-Op109/reviewkit/tree/3fd3bfa7ebcf6afb68101df4932c6ce8cfdec0c6)
  (2026-11-06, "Prune to the core statement checks (0.3.0)"). This is the pin in `lakefile.toml`
  and `lake-manifest.json`, and also the head of `main` on GitHub. [R, `gh api`, 2026-11-08]
- Read from the local copy `.lake/packages/ReviewKit` (identical to the pin, clean tree). [R]
- Checked 2026-11-08.
- Licence: Apache-2.0 (`LICENSE`; GitHub reports `Apache-2.0`). All five commits are authored by
  the owner with Claude as co-author. [R, `git log`] So reuse or deletion is unrestricted. [J]
- Read in full: `README.md`, `FORMATS.md`, `lakefile.toml`, `ReviewKit/{Attr,Config,Core,Checks,Fingerprint,Evidence,Main}.lean`,
  `test/project.toml`, `test/RKToy/{Abstract,Foundations}.lean`, `.github/workflows/ci.yml`.
  Read in part: the docstrings and headers of `scripts/rk_extras.py`, `rk_faults.py` and
  `rk_common.py`. Counted but not read case by case: `test/faults.toml` (21 cases) and
  `test/extras/faults.toml` (10 cases). Not read: `ReviewKit/Sha256.lean` (only its role is noted).
- I also ran the kit on GLCinLean as it stands (§2.6). The run was read-only and wrote no files.
- Second check (2026-11-08, independent): re-read `Attr`, `Core`, `Checks`, `Config`,
  `Fingerprint`, `Evidence`, `Main` and the head of `Sha256.lean` against this note; re-ran
  `review … all`; read the tracker's axiom walk (`tools/tracker/Tracker/Check.lean` at `c223b67`)
  and Lean's `ConstantInfo.getUsedConstantsAsSet` (v4.36.0-rc2) for the opaque-`sorry` claims.
  Corrections are in place below.

## 1. What it is

- It is a Lake package (`ReviewKit`, version 0.3.0, toolchain `leanprover/lean4:v4.36.0-rc2`) with
  no dependencies beyond core Lean and `Lake.Toml`. It provides: [R]
  - a Lean library holding the `@[placeholder]` attribute and the check logic;
  - an executable `lake exe review`, which loads the project's `.olean` files and runs the
    checks;
  - two standard-library Python scripts (`rk_extras.py`, `rk_faults.py`).
- Its stated purpose: "Checks that protect a formal statement in a Lean project". It names no
  project; every prefix, rule and path comes from a TOML config. [S, README]
- Size: about 1,860 lines of Lean in `ReviewKit/` and about 620 of Python in `scripts/`
  (`wc -l`). [R] The version before 0.3.0 (`4be1b2f`) was larger, about 5,400 lines of Lean and
  Python with 17 JSON schemas. The
  0.3.0 prune removed the PR/merge-loop tooling, the schemas and the attestations
  (`git log --stat`). [R]
- It has its own CI (`.github/workflows/ci.yml`). The CI builds the toy library, runs the
  Lean fault fixtures and runs the Python fault fixtures. The last run, on `3fd3bfa7`, was a
  success. [R, `gh api`]
- It is the second of the two patterns in `ideas.md`, "a single statement whose verification
  involves very long Lean code". Everything is organised around one *abstract* module and its
  closure. [J]

## 2. What it says that matters for GLCinLean

### 2.1 The checks (`lake exe review --config <toml> <command>`) [R, `Main.lean`, `Checks.lean`]

| Command | What it does (from the code) | Fails on |
|---|---|---|
| `closure` | Walks types, definition bodies and constructors from every constant of the abstract module, but not proofs or opaque bodies. It stops at the `background` prefixes and lists each user-facing constant with its class tag (`key_list`, with `direct_from_project`). | Project code outside every class (`closure-outside-allowed`); a module matching no prefix (`closure-unclassified-module`) |
| `axioms` | Takes the project's constants plus everything reachable from them with proofs, through every non-background module. It traces each direct `sorryAx` use, opaque values included, to its owning declaration and checks it against the sorry budget, which is bound to statement fingerprints. It also gives per-root axiom traces at statement level and with proofs, plus debt counts. | Project `axiom`; a non-standard axiom; a `sorry` in a background constant; a sorry source missing from the budget (or no budget file while sources exist); a budget statement mismatch; an unexpected dependency cycle (`checker-cycle`). A changed digest or an unused entry gives only a warning. A *sorry source* is a declaration that uses `sorryAx` itself; a definition that only inherits a `sorry` (here `LG`, chosen from a sorried theorem) is not one, which is why the kit counts 4 sources where the tracker shows 5 `stated` (`tracker.md`). |
| `placeholders` | Census of `@[placeholder]` declarations, `opaque` constants and sorry-valued `def`s in `placeholders.modules`. | An untagged `opaque` or sorry-valued def that is not the carrier of a tagged one; a theorem tagged `@[placeholder]`. A sorry-valued def or a `sorry` witness in an opaque gives a warning. |
| `imports` | Import rules by module prefix (first match wins), plus the "Foundations-name" warnings: the abstract uses a library object directly instead of its Foundations re-export. | A module with no rule; an import that the rule does not allow |
| `pin` | Statement pin with two levels (§2.3) for each declaration in `pin.decls`. | A changed own statement (`pin-statement-mismatch`); a missing entry, declaration or pin file. A changed digest gives only a warning (`pin-digest-stale`). |
| `evidence` | Checks the integrity of the machine-written fingerprint records, and the links from the budget and pin to them. | A malformed record; an id or hash mismatch; a broken link |
| `record`, `fingerprint`, `impact`, `faults`, `selftest` | Write evidence records; print fingerprints with `--text`; list reverse dependencies with proofs; run the fault fixtures (one process per case); run the SHA-256 vectors | — |

- Output is JSON in the format `reviewkit-report/0`. Exit 0 means no errors, 1 means errors, 2
  means a setup failure. Every data file carries a `format = "reviewkit-<name>/0"` field. Unknown
  keys are errors, so a misspelt field "is an error, not a silent default". [R, `FORMATS.md`]
- `axioms --toml` and `pin --toml` print entries for the owner to approve. They never write the
  owner's files. [R]

### 2.2 The `@[placeholder]` attribute [R, `Attr.lean`, `Core.lean`]

- It is a 13-line file, a plain `registerTagAttribute` with the docstring: "marks a deliberate,
  data-only placeholder declaration: an `opaque` constant or a definition over one".
- The check is self-declared. `placeholderKind?` recognises only a tagged declaration, an
  `opaque`, or a `def` whose value uses `sorryAx`. A placeholder written as `def X : Type := Unit`,
  or as an ordinary structure, is not detected unless it is tagged. That case is exactly the
  trivial witness that AGENTS.md warns against, so catching it depends on review, not on the
  checker. [R code; J consequence]
- The tag itself is barely checked: the only error is a *theorem* tagged `@[placeholder]`
  (`placeholder-not-data`). A tagged `def X : Type := Unit` passes; nothing verifies that a tagged
  `def` really sits "over an opaque", as the docstring says. An untagged `opaque` passes if it is
  used by the statement of a tagged declaration (it is then a "carrier", like `DGCatPt`). [R,
  `runPlaceholders`]
- Why the attribute exists: a sorry-free `opaque` placeholder rests on no axiom, so `#print axioms`
  cannot see it, and the tracker counts it as `proved` (`tracker.md`: `show DGCat.IsCompact` gives
  `[definition, proved]`). So without a tag, a statement resting on placeholders looks finished.
  [R, `tracker.md` and the archive note on D44] Correction (second check): an earlier version of
  this note said that `#print axioms` ignores opaque bodies. It does not: in D44's probe
  `#print axioms` did report the `sorryAx` inside `opaque … := sorry`; it was the old kit's walk
  that skipped opaque bodies (`glcinlean-archive.md`, D44). [R, that note]
- GLCinLean imports it in exactly one place: `GLCinLean/Foundations.lean` line 14,
  `import ReviewKit.Attr`. `Abstract.lean` gets it through Foundations. [R, `git grep`]

### 2.3 Fingerprints: statement and digest [R, `Fingerprint.lean`, `FORMATS.md`]

- A canonical serialisation of kernel terms: de Bruijn indices, no binder names, binder kinds
  kept, no metadata, universe parameters by position, and the configured notation constants
  unfolded (default and GLCinLean: `GT.gt`, `GE.ge`). It is hashed with the kit's own SHA-256
  (`Sha256.lean`, so hashes do not depend on Lean's unversioned `hash`; format
  `reviewkit-canonical/0`).
- **Statement fingerprint.** It covers the declaration's own type, the value of a `def`, or an
  inductive's whole block. Other constants count **by qualified name only**. So it changes when the
  statement changes or when *which* objects it names changes, but not when a referenced definition
  changes internally.
- **Transitive digest** (Merkle). Content-module constants (`fingerprint.content`, here
  `GLCinLean` and `TauCeti`) count by name plus their own digest, definition bodies included
  (but not proofs or opaque values, see below). Background constants (Mathlib, core) count by
  name plus a 16-hex hash of their type only. Abbrevs in `unfold_abbrevs` are unfolded in the
  digest only, so there "through Foundations" and "the provider directly" hash alike; the
  statement fingerprint still names the Foundations abbrev.
- **Consequence: a Mathlib body change is invisible.** If a Mathlib bump changes what a Mathlib
  definition means but keeps its type, no digest changes. Only Tau Ceti and GLCinLean bodies are
  tracked. [R, `constRef`/`shallowOf`; J consequence]
- **What it ignores.** A theorem is serialised as `T <levels> <type>`, and an opaque as
  `O <levels> <type>`. So **a proof change never changes either fingerprint**. Doc comments,
  attributes and source text are not part of it either. [R, `serMember`]
- A declaration's own name is not in its own hash. Reviews are keyed by name, and renaming changes
  every referrer's hash. [S, file header]

### 2.4 The statement pin and the sorry budget [R, `Checks.lean`, `reviews/*.toml`]

- Both are human-owned TOML files with `decl`, `statement`, optional `digest` and `evidence`, and
  `approved` (the owner's "YYYY-MM-DD <initials>", which the kit "never reads").
- **Pin** (`reviews/statement-pin.toml`) covers `GLCinLean.Abstract.main` and
  `GLCinLean.Abstract.Setting`. A changed statement fails; a changed digest gives only a warning.
- **Budget** (`reviews/sorry-budget.toml`) has 4 entries: `exists_dualGroup`,
  `exists_isLanglandsFunctor`, `isLanglandsFunctor_unique` and `main`, each with `source` and
  `kind` text that cites GLC I v3.
- **Neither file was ever approved.** Every `approved = ""`, and both headers say "NOT YET
  APPROVED" (generated 2026-11-06). No entry has an `evidence` field. [R]
- The stored hashes are still current: the 2026-11-08 runs give `statement_ok` and `digest_ok`
  true for both pins and no budget mismatch. [R, run]

### 2.5 Evidence, extras, faults [R]

- **Evidence records** (`evidence/fingerprint/<decl>/<s12>.<d12>.json`) store both canonical
  texts, so a later reader can diff what was fingerprinted. In the kit's words: "Evidence never
  says that a person checked anything". [S, FORMATS.md]
- **`rk_extras.py`** joins `tracker graph --all` output with a per-declaration extras file
  (`provider`, `key`, `upstream`, `blueprint`, ...) and fails on stale ids. It is the kit's only
  tracker integration.
- **Fault fixtures** plant faults in a toy library (`test/RKToy/Bad/*.lean`: a swapped statement,
  an opaque `sorry`, a theorem tagged as a placeholder, a Prop axiom, an import leak, ...). Each
  fault fixture checks that the expected diagnostic code fires and that no *other error* does
  (unexpected warnings are allowed); a control must produce no unexpected error. The 21 Lean
  cases are 16 faults, 4 controls and 1 `fpcompare` (two declarations must hash the same or
  differ); there are 10 Python cases. Each Lean case runs in its own process. [R, `Main.lean`,
  `test/faults.toml`]

### 2.6 How GLCinLean depends on it today [R, files and a run on 2026-11-08]

- **`lakefile.toml`**: `[[require]] name = "ReviewKit"`, git, rev `3fd3bfa7…`. It sits next to
  `tracker` (path `tools/tracker`, a submodule at `c223b67`).
- **`glc/project.toml`** (`reviewkit-config/0`, an owner's file) configures:
  - closure classes `abstract`, `foundations`, `staging` (empty) and `tauceti`;
  - import rules for `Abstract`, `Foundations`, `Staging` and the rest;
  - `fingerprint.content = ["GLCinLean","TauCeti"]`;
  - the pin decls and `[papers] manifest = …`.
  It has **no `[evidence]` and no `[foundations_names]` table**. So `record` stops with a setup
  error (exit 2) unless `--evidence-dir` is given, the `evidence` check passes vacuously (no
  records, no links), and the Foundations-name warnings are off. PLAN.md says the GLCinLean
  fixtures, evidence records and extras file moved to `GLCinLean-archive`. [R, `Main.lean`,
  `Evidence.lean`, `PLAN.md`]
- **`reviews/`**: the two files of §2.4.
- **Prompts and docs** that name it:
  - `prompts/statement.md`: "review placeholders", "axioms --toml";
  - `prompts/review.md`: scope from `closure`'s `key_list` with `direct_from_project = true`,
    "changed since the newest file in `fidelity/`" (no `fidelity/` exists yet). So today's
    review prompt detects change by the date of its last report and records "the commit
    reviewed"; it does not use the fingerprints. [R]
  - `prompts/proof.md`: "`reviews/` is the owner's" (budget entries of proved theorems);
  - `PLAN.md` §"The checks";
  - `README.md`;
  - AGENTS.md's placeholder note and owner's-files note.
- **Nothing runs it automatically.** Commit `0feeb6f` (2026-11-08) removed GLCinLean's CI and
  `scripts/check.sh`.
- **A run of `review --config glc/project.toml all`** (the prebuilt binary, under `lake env`,
  nothing rebuilt): `ok: true` on all six checks, with no errors or warnings.
  - The closure walk visits 1,283 constants from 41 roots; 770 of them are background constants
    (counted, not entered). The key list has 219 entries: 25 `abstract`, 22 `foundations` and
    172 `tauceti`; 6 of the Tau Ceti entries are used directly by project code.
  - Debt: 15 placeholders and 4 sorry sources.
  - The census shows 15 tagged placeholders (6 in Abstract, 9 in Foundations) and 3 opaque
    carriers (`DGCatPt`, `DGCat.ObjPt`, `LinFunPt`).
  - The `placeholders` check alone took about 93 s of wall time, but only 2 s of user CPU, so
    nearly all of the time goes to importing the Mathlib/Tau Ceti environment. [R timing; E
    reason]
  - Re-run on 2026-11-08 (second check, `all`, same binary): `ok: true`, every number above
    reproduced; 121 s wall, 7.8 s user, 12.7 s system CPU; the working tree was unchanged
    afterwards. [R]

## 3. What it means for GLCinLean

The owner's options are a rewrite, or deletion plus a new system on tracker (`ideas.md`, "The
review system"). Item by item:

| Part | Keep the idea? | Why (tied to ideas/workflow) |
|---|---|---|
| **Fingerprints** (statement + digest) | **Carry over: this is the core.** [J] | "Review status": "after each refactor … tell whether the declaration has changed". The tracker hashes only whole oleans, not declarations (`tracker.md`). A commit hash alone cannot say whether one declaration changed. "Reviewed at commit H with fingerprint F", compared with F now, gives exactly *reviewed* / *unreviewed again, reviewed before*. |
| Two levels, own vs transitive | Carry over [J] | The owner's two states need a rule for "a dependency changed". The digest gives a third, softer state, *stale*, so a Tau Ceti bump or a placeholder replacement does not reset every review (archive lesson D43/F10). |
| Proofs excluded from fingerprints | **Change** for the library pattern [J] | For statement fidelity this is right. But the library pattern reviews code quality and Mathlib style ("Code quality as high as possible", "Set standards"), so a proof refactor must reset that review too. That needs a third hash (proof and source, perhaps the docstring). The Mathlib doc style also makes docstrings part of what is reviewed. |
| `@[placeholder]` attribute | Keep the *concept*; move the attribute [J] | Library code that may move to Tau Ceti cannot import a review tool: Tau Ceti's CI forbids `sorry`, initialisers and other meta code in library files (`tauceti-contributing.md`), and the attribute is an `initialize` declaration; a Tau Ceti file importing a review package is also not something that note reports Tau Ceti allowing [J]. It also makes `Foundations.lean` depend on ReviewKit. A 13-line attribute can live in GLCinLean itself, or in the new review tool as an optional import. Either way the review page must show placeholders, because the tracker shows them as `proved`. |
| Statement pin and sorry budget | Fold into review status [J] | Both are "a human approved this fingerprint". A per-declaration review record (commit, fingerprint, reviewer, verdict) covers both: a sorried theorem that was reviewed and is unchanged is *reviewed*, and anything changed is *unreviewed again*. The old files were never approved, so only reproducible hashes are lost. |
| Axiom audit with opaque bodies | Mostly already in the tracker; keep only the budget idea [J] | Correction (second check): the tracker's axiom walk uses Lean's `ConstantInfo.getUsedConstantsAsSet`, which follows opaque values (`value? (allowOpaque := true)`), so an `opaque … := sorry` should already come out `stated` there [R code, `Tracker/Check.lean` `used`/`axioms` at `c223b67`; not tested by a run]. The D44 gap was in the *old kit*, not the tracker. What the tracker lacks is (a) any view of sorry-free placeholders, which count as `proved` (hence the tag), and (b) a reviewed list of allowed `sorry` sources bound to a fingerprint. Worth a fault fixture in the new system to confirm (a) and the opaque case. |
| Closure from the abstract, `key_list` | Keep for the GLC statement pattern only [J] | It gives the scope of the fidelity review (`prompts/review.md`) and shows that 172 Tau Ceti constants sit under the statement. In the library pattern there is no abstract; each planned declaration is reviewed on its own. |
| Import rules, Foundations-name warnings | Probably delete [J] | They enforce the Abstract/Foundations/Staging layering, which step 2 of `workflow.md` will revisit. A plain Mathlib-style layout (`ideas.md` §1, "Document and organize") may not need them. The warnings are already off. |
| Evidence records | Delete as a separate store [J] | They are not used now. Keeping the canonical text next to a review record is useful for diffing, but the review record can hold the hash and the text can be recomputed at that commit. |
| `rk_extras.py` / extras file | Delete [J] | The extras file has already left GLCinLean. The tracker plan's `desc`/`source` fields cover most of it. |
| Fault fixtures | Keep the method, not the files [J] | Planting a fault and expecting a named diagnostic is the only evidence that a check works. The owner cannot check the code, so this is the owner's evidence for the review system. |
| JSON report, stable codes | Keep [J] | The new web page ("Output: a web page … with the dependency graph and review tags") needs machine-readable input. The tracker's `graph --all` JSON plus a review-status JSON is a natural pair. |
| Strict formats (unknown key = error) | Keep [J] | The tracker follows the same rule ("Any other key is an error"), so the two tools agree. |

- **Maintenance and automation.** ReviewKit uses Lean internals: `Environment.header.moduleData`,
  `importModules`, `Lake.Toml`. It must be built by the project's toolchain. So every Lean bump can
  break it, and `workflow.md` decides that bumps are "fully automated, including their Lean
  version". Each extra Lean tool is one more thing to repair at a bump. One tool (the tracker plus
  a small review layer) is cheaper than two. [R internals; J consequence] Today this cost is
  inside GLCinLean's own build, because `Foundations.lean` imports `ReviewKit.Attr`: if
  ReviewKit fails to compile on a new Lean, GLCinLean does not build. [R import; J]
- **Automated bumps and kernel-term fingerprints.** A Lean, Mathlib or Tau Ceti bump can change
  the elaborated terms of unchanged source (a renamed or deprecated Mathlib constant, a different
  instance path), and the statement fingerprint names every referenced constant. So an
  automated bump can turn reviews into *unreviewed again* with no mathematical change, while a
  Mathlib body change with the same type changes nothing (§2.3). The new system needs a rule for
  re-review after bumps, and a diff of the canonical text (what the evidence records stored)
  helps a reviewer see that a change is clerical. [J]
- **"Work in a very simple way … without any complex system or harness"** (`ideas.md`). This
  applies to *this* repository. The review system is meant to live in its own repository. So
  GLCinLean can drop `glc/project.toml`, `reviews/` and the ReviewKit require, and keep at most the
  attribute. [J]

## 4. Conflicts

- **Commit hash vs content fingerprint.** `ideas.md` asks for review status "tracked by the Git
  commit hash at which it was reviewed". ReviewKit tracks by content fingerprint and never records
  a commit. These are complementary, not exclusive: a commit alone cannot tell whether one
  declaration changed without re-deriving its hash at that commit. The archive note
  (`glcinlean-archive.md`) and `numlib-auto.md` reach the same conclusion. [J]
- **"Changed during a refactor → unreviewed"** (`ideas.md`). ReviewKit's fingerprints do *not*
  change on a proof-only or docstring-only refactor. For a code-quality review that is a gap; for
  a statement review it is the intended behaviour. [R code; J]
- **The owner has only two states** (*reviewed*, *unreviewed but reviewed before*). ReviewKit has a
  third, *stale* (a dependency changed). The owner has not said what happens when only a
  dependency changes. [J]
- **`workflow.md` decisions vs ReviewKit's human gate.** ReviewKit makes the owner approve pins and
  budget entries ("Only the owner changes this file"). `workflow.md` step 4 has "Fresh agents
  check changed declarations against the papers and the standards", lists "Who reviews the
  mathematics (fresh agents, an outside expert)" as an open question, and decides that pushes,
  Tau Ceti contributions and bumps are automated. [R] If a fresh agent reviews, the "owner
  approves" step either goes away or changes meaning. [J]
- **Stale wording in `reviews/`.** The pin file's header says "CI fails on a mismatch", but
  GLCinLean has had no CI since `0feeb6f`. [R] Nothing enforces the pin or the budget today.
- **`prompts/statement.md` vs the code.** The prompt equates "no placeholders in the closure of
  the abstract" with `review placeholders`. The `placeholders` census covers all of
  `placeholders.modules` (here all of `GLCinLean`), not the closure; the closure's `key_list`
  marks placeholders per entry. Today they agree: the key list holds all 15 tagged placeholders
  and the 3 carriers, and no Tau Ceti entry is a placeholder. [R code, run] Once project code
  outside the closure gains placeholders (the library pattern), they will differ. [J]
- **AGENTS.md owner's-files note.** It lists `reviews/statement-pin.toml`,
  `reviews/sorry-budget.toml` and `glc/project.toml`. Removing them is a change to owner's files,
  so `workflow.md` step 1 says to *propose* it rather than make it. [R]
- **`PLAN.md`** says the fault fixtures "live in ReviewKit". That stays true only if ReviewKit
  survives. [R]
- **ReviewKit README vs repository.** The README describes `record`/`evidence` as part of
  normal use, but GLCinLean configures neither. This is a small inconsistency that matters only if
  the kit is kept. [R]

## 5. Input for the open questions (`workflow.md`, "Questions for after the research")

- **What happens to each existing file.**
  - *ReviewKit require in `lakefile.toml`*: remove it once the attribute has a new home. Nothing
    else in GLCinLean imports ReviewKit. [R grep; J]
  - *`@[placeholder]`*: keep the idea. Define the tag locally (for example in a small
    `GLCinLean/Placeholder.lean`, or whatever step 2 decides), or provide it from the new review
    tool as an optional dependency. Placeholders must stay visible somewhere because the tracker
    calls them `proved`. [J]
  - *`glc/project.toml`*: retire it with ReviewKit. The closure classes and the pin list can become
    configuration of the new review tool if the GLC-statement pattern is kept. [J]
  - *`reviews/`*: retire it. The hashes can be regenerated, and nothing in it was approved. Replace
    it with per-declaration review records in the format the new tool defines. [J]
  - *`references/papers/manifest.toml`*: ReviewKit accepts the `[papers]` table without
    validation and never reads it (`reservedTables` in `Config.lean`), so the kit puts no
    constraint on this file. [R] The owner "doesn't see the point" of the manifest (`ideas.md`
    §5); dropping it needs at most one line removed from `glc/project.toml`. [J]
- **Whether Abstract/Foundations and the placeholder design are reasonable.**
  - ReviewKit's closure, import rules and Foundations-name warnings are what *enforce* that
    layering. If the layering goes, those checks go with it.
  - The run shows that the design works mechanically: 15 tagged placeholders, no untagged ones, and
    no sorry hidden in an opaque. It says nothing about whether the placeholders are
    mathematically right. [R run; J]
- **Who reviews the mathematics, and to what standard.**
  - ReviewKit has no notion of a reviewer. It only detects change. The `approved` field is free
    text that is never read.
  - The new system needs a reviewer field (owner, fresh agent with model and date, outside
    expert) on each record, so the page can show *who* reviewed what. This matters because the
    owner cannot check the mathematics (AGENTS.md). [J]
- **Where research notes and session summaries live.** ReviewKit does not bear on this.

## 6. Questions for the owner

1. **Delete or rewrite?** ReviewKit's useful core is the fingerprint: `Fingerprint.lean` (258
   lines, about 40 of them evidence-id helpers), `Sha256.lean` (107) and a few helpers from
   `Core.lean` (`blockOf`, `moduleOf?`), plus its tests. Should the new tracker-based review system copy and adapt that code (Apache-2.0,
   your own), or start from scratch? Either way, archive or delete `WHY-Op109/reviewkit`
   afterwards? [J: copying the fingerprint saves rediscovering the D43/D44 pitfalls]
2. **What resets a review?**
   - (a) only the declaration's own statement;
   - (b) also any change in what it depends on, which today is a warning-level *stale*;
   - (c) also proof or docstring changes.
   Possibly different for the statement pattern and the library pattern. Related: should a
   change caused only by a Lean/Mathlib/Tau Ceti bump reset a review, given that bumps are to
   be automated (§3)?
3. **Where does `@[placeholder]` live** once ReviewKit is gone? In GLCinLean itself, in the new
   review tool, or replaced by a docstring convention that the review page reads?
4. **Do the statement pin and the sorry budget survive** as separate gates, or become ordinary
   review records? If agents review, is any owner approval still required, for example for the main
   theorem's statement?
5. **May step 1 remove the owner's files** `glc/project.toml`, `reviews/statement-pin.toml` and
   `reviews/sorry-budget.toml`, and the ReviewKit `[[require]]` in `lakefile.toml`, once the
   attribute has moved? (AGENTS.md asks to hear about these first.)
