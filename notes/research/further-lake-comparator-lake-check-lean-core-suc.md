# `lake comparator` and `lake check` (Lean core; successor of leanprover/comparator)

- **Sources read:**
  - the standalone repository: [leanprover/comparator @ `865edc1`](https://github.com/leanprover/comparator/tree/865edc14486c3388e9225daa971da8e157488c3e)
    (last commit 2026-10-14, "doc: migration notice"): `README.md`, `LICENSE`;
  - the core version: [leanprover/lean4 master @ `da4295a`](https://github.com/leanprover/lean4/tree/da4295ad1dd83a62bf4acadeec58da06852b19b2)
    (2026-11-07): `src/lake/Lake/CLI/Help.lean` (`helpComparator`, `helpCheck`),
    `src/lake/Lake/CLI/Check.lean`, `src/lake/Lake/Check/{Compare,Axioms,Util}.lean`, and the tests
    `tests/lake/tests/{challenge-*,check-*,comparator-*}`;
  - `Help.lean` at the tags `v4.35.0` and `v4.36.0-rc2` (`b35cb10`, this project's toolchain), to
    see what the pinned toolchain actually ships;
  - `src/lake/Lake/Check/{Compare,Axioms,Util}.lean` and `Check.lean` at `v4.36.0-rc2`, diffed
    against master (added by the check of 2026-11-08);
  - the history of `Check.lean`, `Compare.lean` and `Help.lean` (`gh api .../commits?path=...`).
  - `v4.36.0-rc2` is a release-branch tag (commit date 2026-10-27). It has **diverged** from master
    (master 350 commits ahead, 4 behind), so master features are not in the pinned toolchain unless
    checked [R, `gh api .../compare`].
- **Checked 2026-11-08.** Clones in `.lake/research/comparator/` and `.lake/research/lean4-lake/`
  (a sparse checkout of `src/lake`, `tests/lake`, `doc`).
- **Licence:** Apache 2.0 (comparator `LICENSE`; `Check.lean` header "Released under Apache 2.0").
  Nothing is copied into the project, so the licence does not matter yet.
- **Could not reach:** the Lean v4.35.0 release notes page
  (`lean-lang.org/doc/reference/latest/releases/v4.35.0/`): the fetch tool refused the address.
  The GitHub release text only links to that page. So the core merge date rests on the comparator
  README [S] and the tag contents [R], not on the release notes.
- **Not run:** a local test of how comparator treats placeholders was set up (four tiny projects in
  `.lake/research/comparator-probe/`). The permission system refused the run without the sandbox, and
  the sandboxed run cannot start outside Linux (see 2.5). The check of 2026-11-08 tried the
  unsandboxed run once more and was refused again. So every claim below about comparison
  behaviour comes from **reading the code and tests**, not from running them.

Tags: [R] read directly on 2026-11-08; [S] a source's claim about itself; [E] estimate;
[J] judgement.

---

## 1. What it is

- **Comparator** is "a trustworthy judge for Lean proofs" [S README]. Its inputs:
  - a trusted **challenge** module (statements, proofs may be `sorry`);
  - an untrusted **solution** module (the same statements with proofs);
  - a JSON configuration (`theorem_names`, `permitted_axioms`, optionally `definition_names` and
    `external_kernels`).

  It decides whether the solution really proves the challenge. [R README]
- The Lean FRO built it for the AIMO competitions, "to enable trustworthy LLM Lean evaluation on
  Kaggle" [S README]. The Annals Challenge and LeanEval use it (see `annals-challenge.md`).
- **Merged into core.** "This project has been merged into core as of Lean release v4.35.0 in the
  form of `lake comparator` and the accompanying `lake check`. Users are advised to migrate"
  [S README]. Confirmed in the code: `Help.lean` at tag `v4.35.0` already lists both commands [R].
  The local toolchain `v4.36.0-rc2` (Lake 5.0.0-src+b35cb10) has them too [R, `lake --version`,
  `Help.lean @ v4.36.0-rc2`]. Henrik Böving wrote the core code (header of `Check.lean`) [R].
- **Two commands** [R `Help.lean` master]:
  - `lake comparator`: "Judge a solution against a challenge". It checks that "every named theorem
    in a solution Lean file proves the same statement as in a challenge Lean file, uses no axiom
    outside the permitted list, and is accepted by the kernel."
  - `lake check`: "Check this project against external checker(s)". It "Builds the default build
    targets, exports them, and replays the result through the kernel, erroring on any use of
    non-standard axioms."
- **Still changing quickly** [R, `Check.lean` history]:
  - 2026-09-09: `bwrap` replaces `landrun` as the sandbox;
  - 2026-09-13: renamed from `lake challenge` to `lake comparator`;
  - 2026-09-14: `--paranoid`, `--inadvisably-no-sandbox` and `--*-from-export` added;
  - 2026-10-19: unpermitted axioms are reported before the checkers run;
  - 2026-10-19: definition holes must be `sorry` in the challenge (#15775, `Compare.lean`). It is
    on master, **not** in `v4.36.0-rc2` [R, diff of the two `Compare.lean` files; `gh api
    .../compare` shows the commit is not in the tag];
  - 2026-10-27: `--json` added (#16019). It is on master, **not** in `v4.36.0-rc2` [R, diff of the
    two `Help.lean` files];
  - 2026-10-30: the REQUIREMENTS list and the "no way to figure out … meaning" note added to the
    help (#16096). Master only; the `v4.35.0` and `v4.36.0-rc2` help texts have neither (they are
    identical to each other for `lake comparator`) [R, both tags' `Help.lean`].

## 2. What it says that matters for GLCinLean

### 2.1 What `lake comparator` guarantees, and what it cannot

- The guarantee, for every name in `theorem_names` [R README; `Help.lean`]:
  1. it proves the same statement as in the challenge;
  2. it uses no axiom outside `permitted_axioms`;
  3. the kernel accepts it.
- **The limit, in its own words** (master only, added after `v4.36.0-rc2`) [R `Help.lean` master]:
  > "Note, that comparator has no way to figure out whether the statements in the challenge file
  > properly correspond to the meaning intended by their author. It can only establish that the
  > statements as written down are correct with a very high degree of certainty."
- **Trust assumptions** [R `Help.lean` master, REQUIREMENTS; master only, see the history in 1]:
  - everything imported by the challenge, transitively, is trusted;
  - `lakefile.*`, `lake-manifest.json` and all their dependencies are trusted;
  - the run starts from a clean build ("no pre-existing `.lake` directory");
  - `bubblewrap` is installed ("currently only available on Linux systems so comparator can only
    be safely used on Linux");
  - it is not run as a privileged user;
  - the kernel (with `--paranoid`, at least one of the kernels used) is sound;
  - the solution uses no unknown exploits against the machine.

  The standalone README was softer about the clean-build point: "running `lake exe cache get` to
  download a Mathlib cache is acceptable … if you trust the cache" [R README].
- **`permitted_axioms` must be stated.** It "is deliberately not defaulted: it is what the verdict
  means, so the challenge author states it. The three above are the ones `#print axioms` treats as
  a clean proof." Those three are `propext`, `Quot.sound` and `Classical.choice`. [R `Help.lean`]
- **Exit codes** [R `Help.lean`]:
  - 0: accepted;
  - 1: rejected (mismatch, forbidden axiom, kernel rejection or failed build);
  - 2: could not start.

### 2.2 How "the same statement" is decided (the mechanism)

[R `Lake/Check/Compare.lean`, `Util.lean`]

- For each target theorem, the challenge's constant and the solution's constant must have the
  **same kind** (both theorems, or both axioms) and an **equal `ConstantVal`**: name, universe
  parameters, type.
- Every constant that the statement's type uses then goes on a worklist, together with a fixed
  list of primitives from `Init`.
- For each constant on the worklist, the challenge's `ConstantInfo` must **equal the solution's
  exactly**. Then all the constants it uses go on the worklist too: its type, its **value** (for
  definitions and `opaque`s too, since `allowOpaque := true`), constructors and recursor rules.
- **The one exception:** a name listed in `theorem_names` or `definition_names`. For those, only
  the type is followed, and the body may differ.
- So the **whole definitional closure of the statement must be identical, body for body**, in
  challenge and solution. That closure includes the Mathlib and Tau Ceti definitions it reaches.
  [J from the code] Both are built in the same project with one `lake-manifest.json`, so library
  code agrees automatically at one pin. What the check catches is a solution that **redefines**
  anything the statement depends on.
- **Definition holes** (`definition_names`) [R `Compare.lean`; README]:
  - the challenge's definition must be a `def` whose body is `sorry` ("Challenge definition is not
    sorried" otherwise). **On master only.** At `v4.36.0-rc2` (this project's toolchain) the hole
    must be a `def` in both files, but its challenge body is not checked [R, `Compare.lean` at the
    tag]; the README already asked for a sorried hole [R README];
  - in the solution, only the name, type, universe levels and safety must match.
  - The README warns that holes "can be gamed" (its example: `def ChallengeSolution : Prop :=
    RiemannHypothesis`), so "all definition hole solutions **must** always be checked with an
    additional (potentially human) verifier".
- **An `opaque` cannot be a hole** [R `Compare.lean`]. A hole must be `.defnInfo`, and an `opaque`
  is `.opaqueInfo`. An `opaque` in the statement's closure is therefore compared exactly. A
  solution that turns `opaque P : Type` into `def P : Type := …` fails with "Const does not match".
  [J from the code; not run, see header; a second attempt at the unsandboxed run on 2026-11-08 was
  also refused by the permission system]
- **Not every placeholder here is an `opaque`.** [R `Foundations.lean`] `DGCat`, `DGCat.Obj` and
  `LinFun` are `@[placeholder] def`s whose bodies are fields of unmarked `opaque … : NonemptyType`
  carriers (`DGCatPt`, `DGCat.ObjPt`, `LinFunPt`). Their bodies are not `sorry`, so on master they
  cannot be holes either. On `v4.36.0-rc2`, which does not check hole bodies, they could be listed
  in `definition_names`, and a solution could then set `DGCat := Unit` or anything else. [J from
  the code] That is the "gameable" case, without even the master safeguard.
- **Attributes are invisible.** The comparison works on the kernel export (NDJSON from
  `leanexport`), and attributes are not part of a kernel `ConstantInfo` [J]. So an attribute such
  as ReviewKit's `@[placeholder]` means nothing to comparator.
- **Axioms** [R `Axioms.lean`; test `challenge-opaque-value`]. The check walks the solution's
  targets through types, values and opaque values. The test hides `axiom f : False` behind
  `opaque v : False := f` and is caught: "Illegal axiom detected: 'f'". `sorryAx` is an axiom and
  is not permitted, so any `sorry` reachable from a target fails.

### 2.3 `lake check`

[R `Help.lean`; `Check.lean`; tests `check-sorry`, `check-audit`, `check-multi`]

- It builds the project's **default targets**, exports their **whole import closure**, and replays
  it through the kernel. The tests keep `Init` out "because `lake check` re-checks everything in
  scope".
- The permitted axioms are **fixed**: `standardAxioms := #[propext, Classical.choice, Quot.sound]`.
  There is no configuration.
- **A `sorry` fails the check.** The test `check-sorry` expects "Axiom 'sorryAx' is not permitted;
  it is used by 'bad'", with exit code 1. Its comment: "The kernel accepts `sorryAx`, so only the
  axiom report catches this."
- It prints the axioms used, for example "Uses axioms: propext, Classical.choice, Quot.sound".
- It needs a `lake-manifest.json`, and exits with code 2 without one.
- The test `check-audit-reject` has a solution that smuggles a bad natural-number literal in
  through `addDecl` and `implemented_by`. `lake check` rejects it.

### 2.4 Extra kernels (`--paranoid`)

- `--paranoid` also runs `leanchecker-paranoid`, `lean4lean`, `nanoda`, `con-leche` and `con-ron`
  [R `Help.lean`; `Check.lean` `bundledKernels`].
- The local `v4.36.0-rc2` toolchain bundles all five, plus `leanchecker` and `leanexport`
  [R, `ls` of the toolchain's `bin` directory].
- Comparator's `external_kernels` adds any other checker.

### 2.5 Platform and cost

- **Linux only.** Without `--inadvisably-no-sandbox`, `mkContext` refuses on any other platform. On
  the non-Linux machine used, it printed: "Error: `lake comparator` sandboxes the code it checks with `bwrap`, which
  needs Linux namespaces." (Lake prints it with the prefix `error:`.) Exit code 2. [R, run
  2026-11-08 on a toy project; re-run by the check the same day on
  `.lake/research/comparator-probe/opaque-replaced`, same message and exit code 2] `which bwrap`
  finds nothing on that machine [R].
- `--inadvisably-no-sandbox` skips the sandbox. It prints "WARNING: Sandbox disabled, this run is
  not trustworthy." [R `Check.lean`]
- **Network and files** [R `Check.lean`; `Help.lean` HARDENING]:
  - only dependency resolution has a network;
  - the build, the export and the kernels run in an empty network namespace;
  - the environment is cleared (`--clearenv`). Comparator's sandboxed build gets only `PATH` and
    `LEAN_ABORT_ON_PANIC`; `lake check`'s build-and-export step also passes `HOME`, but `HOME` is
    then reset to an empty `/tmp/home` inside the sandbox;
  - `/home`, `/root`, `/run/user` and `/tmp` are covered with an empty `tmpfs`; the project, the
    toolchain and Lake's own home are bound back read-only, and only the project's `.lake` is
    writable.

  [J] So a Lake cache kept under `~` is not seen, and `LAKE_CACHE_DIR`/`LAKE_CONFIG` (AGENTS.md
  "Builds") are not passed in. Unless `.lake` is pre-populated (which master's REQUIREMENTS rule
  out for a trustworthy run), a sandboxed run builds Mathlib and Tau Ceti from source.
- **Cost** [E, not measured]:
  - a clean build of Mathlib plus Tau Ceti takes hours;
  - replaying their whole closure through the kernel (`lake check`, or the solution export) adds
    more time;
  - `--paranoid` multiplies the replay time by up to six kernels.
- **Ways round the cost** [R `Help.lean` EXPORTS]: `--challenge-from-export`,
  `--solution-from-export` and `lake check --from-export` take NDJSON exports "built in virtual
  machines … by third parties … or through means other than a standard `lake build`". The help
  warns that this "does not check that the provided export matches" the project.

### 2.6 Who uses it

- The Annals Challenge and LeanEval use comparator (see `annals-challenge.md`) [R that note].
- In Tau Ceti, a code search for "comparator" found [R]:
  - `.github/workflows/nightly-verify.yml`, where "comparator" means **its own byte comparison**
    of a clean build against a cache-restored build, not `lake comparator`. That workflow runs the
    cache-restored build under a pinned `bwrap` 0.9.0;
  - a blog page (`web/Site/Blog/QualityIndicators.lean`) that names "Comparator challenges" as a
    community norm for quality.

  No Tau Ceti CI step running `lake comparator` or `lake check` was found. [R, GitHub code search;
  confirmed by the check with a full-tree `grep` of the local clone `.lake/research/TauCeti-main` at
  `d2083f0` (2026-11-08) for `lake comparator`, `lake check`, `leanchecker` and `comparator.json`:
  no hits outside the blog sentence]

## 3. What it means for GLCinLean

1. **"First the statement, then the whole proof"** (ideas.md, "What I want"). [J] Comparator is the
   standard Lean mechanism for this split. The statement is frozen as a trusted challenge, and the
   proof (step 6 of workflow.md) is later judged against it. Nobody has to re-read a proof of any
   length; humans and fresh agents review only the challenge and its import closure.
2. **It does not check meaning.** [R, its own note] Comparator certifies "as written down", not
   "as intended". So the statement review (workflow.md step 4: fresh agents check declarations
   against the papers; the open question "who reviews the mathematics") is still the main work.
   Read this with `annals-challenge.md`, whose statement-fidelity audit covers meaning. [J]
3. **Placeholders and comparator do not mix.** [J from 2.2] This bears on the open question about
   `Abstract.lean`, `Foundations.lean` and their placeholder design.
   - The two files hold 15 `@[placeholder]` declarations: 6 in `Abstract.lean`, 9 in
     `Foundations.lean` (a plain `grep -c` says 10 there because the module docstring mentions the
     attribute) [R, `grep -c '^@\[placeholder\]'`, 2026-11-08]. 12 are `opaque`s; 3 (`DGCat`,
     `DGCat.Obj`, `LinFun`) are `def`s over opaque carriers (2.2).
   - **`main` reaches all 15.** [R, traced by hand through the source 2026-11-08; not
     machine-checked] Its type uses `LinFun.IsEquivalence` (hence `LinFun`, `LinFun.comp`,
     `LinFun.id`, `LinIso`) and `LG`'s type (`DmodHalf`, `QCohLS`, `IndCohNilp`, `Setting`, hence
     `RootDatumDuality`); `LG`'s value reaches `exists_isLanglandsFunctor` and through it
     `IsLanglandsFunctor` (`DGCat.IsCompact`, `DGCat.IsEventuallyCoconnective`, `LinFun.obj`, `Psi`,
     `LCoarse`); `DGCat` and `DGCat.Obj` sit under all of these. Every one is compared exactly, and
     none can be a sound definition hole.
   - Replacing a placeholder with a real definition changes the challenge. A challenge with
     placeholders still in it would be met by a "proof" about uninterpreted constants. That proof
     is impossible for non-trivial claims, and meaningless for the conjecture.
   - So comparator becomes useful **only once the statement's closure has no placeholders**. The
     challenge is frozen at the end of the statement phase, not before.
   - Turning placeholders into `def … := sorry` definition holes would make them "gameable" (the
     README's warning). That is the same weakness AGENTS.md names for "a definition with a trivial
     witness".
4. **How the statement would be split.** [J from 2.2]
   - The solution cannot import the challenge and re-declare `main`. So the definitions that
     `main` uses (`Setting`, the `𝕃_G` chain, `IsLanglandsFunctor`, `LG`) must sit in modules that
     **both** import.
   - The challenge is then a small file: those imports plus `theorem main … := sorry`.
   - `LG` is defined by `Classical.choose (exists_isLanglandsFunctor S)` [R `Abstract.lean`
     l.126]. The comparison follows `LG`'s value into `exists_isLanglandsFunctor`, so that theorem
     must also be listed in `theorem_names`. Otherwise the solution's proof of it differs from the
     challenge's `sorry` and the check fails.
   - Step 2 (Plan) should keep the statement in a form that splits this way.
   - [J from 2.2] In this split the shared modules are, by construction, the same code on both
     sides, so the closure check passes for them automatically. What comparator then adds is: the
     solution does not redefine anything the statement uses, `main`'s type is unchanged, the axioms
     are permitted, and the kernel accepts the proof, all in a sandbox. Everything the statement
     *means* sits in the shared modules, which comparator trusts ("everything (transitively)
     imported by the challenge file is trusted"). The review effort therefore has to cover those
     modules, not only the challenge file.
5. **Statement pin and sorry budget.** Both are owner's files (`reviews/statement-pin.toml`,
   `reviews/sorry-budget.toml`). [J]
   - **The hard `statement` pin:** comparator does this job at proof time, if the challenge file
     and its imports are frozen in Git, for example in a tagged commit or a protected path. The
     sha256 in the TOML then repeats what Git already pins.
   - **The `digest` level** (warn when something the statement uses changes): comparator does
     **not** cover this. It compares the solution with the challenge at **one** dependency pin. A
     Tau Ceti or Mathlib bump that changes a definition the statement uses changes the challenge
     and the solution together, silently. Detecting such drift needs something else, for example
     diffing the challenge's export or `#print`-ed closure across bumps, or the review system's
     "reviewed at commit X" tracking (ideas.md, "Review status").
   - **The sorry budget:** this belongs to the statement phase, which has sorries by design.
     `lake check` fails on any `sorry`, so it cannot replace the budget then. At the end, a passing
     `lake check` (or comparator) **is** the "zero sorries" certificate.
6. **Axiom audit.** [J] ReviewKit's axiom check (`review axioms`) is duplicated by `lake check`'s
   fixed three-axiom rule and comparator's `permitted_axioms`. Both are maintained by the Lean FRO
   and move with every Lean release. That fits "Defer to human-curated libraries" and "Stay up to
   date" (Xena principles, ideas.md §1), and "work in a very simple way" (ideas.md): no own checker
   to maintain.
7. **It needs Linux.** [R 2.5; J] This conflicts with the setup: commit `0feeb6f` dropped CI.

   A trustworthy run needs a Linux machine or CI (a GitHub Actions Ubuntu runner with `bwrap`, as
   Tau Ceti does). That is one CI job, but it is machinery. It is needed only at proof time (step
   6) and perhaps for the library, not during the statement phase.
8. **Automation of Lean and Mathlib bumps** (workflow.md decision "fully automated"). [J] The
   commands ship with the toolchain, so bumping `lean-toolchain` brings the matching
   `leanexport`/kernel automatically ("deliberately not configurable: the export format has to
   match the compiler" [R `Help.lean`]). There is no extra pin to move. But the flags and the
   rules still change (`--json` and the sorried-hole rule are newer than `v4.36.0-rc2`), so
   scripts should use only stable flags or follow the toolchain. [E] The sorried-hole rule should
   reach this project with the first toolchain after `v4.36.0-rc2` cut from master after
   2026-10-19 (not checked: no such tag existed on 2026-11-08).
9. **Library side** (ideas.md §1, "A library, not a one-off"). [J] `lake check` on the library's
   default targets is a cheap-to-describe, expensive-to-run audit: kernel replay plus "no
   non-standard axioms". Library code has no sorries, so it can pass. A nightly or per-release job
   would serve "Set standards, and meet them". The statement module, which has sorries, would have
   to sit outside the default targets checked, or in a separate run.

## 4. Conflicts

- **With the current `@[placeholder] opaque` design** (AGENTS.md "Placeholders";
  `Foundations.lean`). [J from 2.2] Comparator compares opaques exactly and allows holes only as
  `def`s (on master: `def … := sorry`). So:
  - no placeholder can *usefully* survive into a comparator challenge: comparator would accept it
    (compared exactly), but `main` would then have to be proved about uninterpreted constants;
  - the `NonemptyType` pattern is fine during the statement phase, but every placeholder must be
    replaced before freezing.

  AGENTS.md says `def` with a trivial witness "would make the statement say less". Comparator's
  README says the same of definition holes ("can be gamed"). The two agree in spirit; the README
  adds that holes need an extra verifier, which AGENTS.md does not discuss.
- **With `reviews/statement-pin.toml` and ReviewKit** (an owner's file; the `lakefile.toml`
  requirement). [J] They overlap with core tooling, which is grounds to drop or shrink them in step
  1 ("Avoid duplication", "Defer to human-curated libraries"). They are not identical, though: the
  `digest` level has no comparator counterpart (3.5).
- **With ideas.md "without any complex system or harness"**, and with the removal of CI (commit
  `0feeb6f`). [J] A trustworthy comparator run needs Linux and `bwrap`. This agrees with the
  `xena-blog.md` note, which reached the same conclusion from `lake help` [R that note].
- **With the comparator README itself (version drift).** [R]
  - The standalone README describes `landrun`, `lean4export` and `systemd-run`.
  - Core uses `bwrap` and the bundled `leanexport`.
  - The README allows a pre-downloaded Mathlib cache; core master's REQUIREMENTS assume "no
    pre-existing `.lake` directory".

  Notes that quote the README (for example `annals-challenge.md` §2.5) describe the old tool. Core
  is the one to follow.
- **With `annals-challenge.md` §2.5.** That note says comparator checks "that the Lean kernel
  accepts it (optionally nanoda as well)". In core, the extra kernels are five bundled checkers
  under `--paranoid`, plus any `external_kernels`. This is not a contradiction, only an older
  description. [R]
- **Freezing the challenge vs. continuous refactoring** (ideas.md §1 "continuously refactor to
  adopt their decisions" and "Stay up to date"; workflow.md steps 3 and 5: Tau Ceti pull requests,
  pin bumps, adopting upstream code). [J] A frozen challenge assumes the statement's definitions
  stay put. If a definition the statement uses later moves upstream (into Tau Ceti or Mathlib), is
  renamed, or is generalised, the challenge file and its imports change, and the freeze has to be
  re-reviewed and re-approved. Comparator itself is fine with this (it compares at whatever pin is
  current), but the "freeze once" picture is really "freeze, and re-freeze after every change to the
  statement's closure", which is the same tracking the `digest` level and ideas.md "Review status"
  aim at.
- **With other sources.** None found. Tau Ceti does not appear to run `lake comparator` or
  `lake check` in CI [R, search only].

## 5. Input for the open questions (workflow.md, "Questions for after the research")

- **What goes into `AGENTS.md`.** [J] One short line is enough: the final proof is accepted only
  when `lake comparator` accepts it against the frozen challenge, with the three standard axioms,
  on Linux; agents never edit the challenge or its imports. Details belong in the proof-phase
  prompt, not in `AGENTS.md`.
- **Whether `GLCinLean/Abstract.lean`, `GLCinLean/Foundations.lean` and the placeholder design are
  reasonable.** [J]
  - Placeholders are fine during the statement phase.
  - They must all be gone before the statement is frozen (3.3).
  - Plan now for the split "statement definitions (imported by both) / challenge file (`main` and
    `exists_isLanglandsFunctor` with `sorry`) / proof" (3.4).
  - `Abstract.lean` imports Mathlib, Tau Ceti and `Foundations` only. That fits comparator's
    "everything imported by the challenge is trusted": a small trusted base is what you want.
    ReviewKit (`import ReviewKit.Attr` in `Foundations.lean`) would also become trusted, which is
    one reason to drop that import.
- **What happens to each existing file.** [J]
  - `reviews/statement-pin.toml`: its hard level can be replaced by a frozen challenge module plus
    `lake comparator` at proof time. Its `digest` level needs another answer (the review system's
    commit tracking, or dropping it).
  - `reviews/sorry-budget.toml`: needed only during the statement phase. `lake check` takes over
    at the end.
  - The ReviewKit requirement and its axiom check: replaceable by `lake check` / comparator, which
    come with Lean itself. The `@[placeholder]` attribute would need a home if ReviewKit goes, for
    example a one-line attribute in this repository, or a docstring convention. Comparator ignores
    attributes either way.
  - `glc/project.toml`, `blueprint/`, `prompts/`, `references/papers/manifest.toml`: this source
    has nothing on them.
- **Who reviews the mathematics, and to what standard.** [R its note; J] Comparator says outright
  that it cannot check meaning. Its README says definition holes need "an additional (potentially
  human) verifier". So the review effort belongs on the challenge's closure: the statement and the
  definitions it uses. A fresh agent or an expert reviews that closure once, against the papers,
  and comparator makes the proof itself need no review for correctness. Proof code still needs a
  quality review under the library goals.
- **Whether `PLAN.md` is needed; where notes live.** This source has nothing on these.

## 6. Questions for the owner

1. **Comparator as the acceptance test for the proof.** Should the final GLC proof count as done
   only when `lake comparator` accepts it against a frozen challenge, with `propext`, `Quot.sound`
   and `Classical.choice`? If yes, step 2 should plan the statement/challenge/proof split now.
2. **Linux.** A trustworthy run needs Linux with `bwrap`. Do you accept one CI job (for example a
   GitHub Actions Ubuntu runner) or a Linux machine for this, at least for the proof phase and
   perhaps a nightly `lake check` of the library? Or should it stay a manual, occasional check?
   This touches the "no complex system" wish and the removal of CI.
3. **Statement pin and ReviewKit.** May step 1 propose to:
   - replace the hard level of `reviews/statement-pin.toml` with a frozen challenge module;
   - replace ReviewKit's axiom check with `lake check`?

   And what should happen to the pin's `digest` level, which warns when a Tau Ceti or Mathlib bump
   changes a definition the statement uses and which comparator does not cover: keep it, move it
   to the review system, or drop it?
4. **When to freeze.** The challenge can be frozen only once no placeholder is left in the
   statement's closure. Who approves the freeze (you, after a fresh-agent review against the
   papers)? And how is it protected from later edits by agents: a Git tag, a protected path, or
   CODEOWNERS?
   And when a later refactor or upstreaming changes a definition in the statement's closure (see
   the conflict "Freezing the challenge vs. continuous refactoring" in 4), does that need your
   re-approval of a new freeze, or only a fresh-agent review?

## 7. Reconciliation: dependency caches inside the sandbox, and where a trustworthy run could happen (checked 2026-11-08)

Added because 2.5 here and `further-lean-reference-manual-validating-proofs-.md` §2.5 seemed to
disagree. This note (2.5) says that without a pre-populated `.lake` the sandbox builds Mathlib and
Tau Ceti from source, and that master rules out a pre-populated `.lake`. The other note says the
comparator README accepts `lake exe cache get` beforehand and that the sandboxed build then reuses
`.lake`. This section supersedes the last [J] paragraph of 2.5. The rest of this note is unchanged.

- **Read for this section** (all on 2026-11-08):
  - Lake at tag `v4.36.0-rc2`, from the toolchain's own sources
    (the toolchain's `src/lean/lake/Lake/`): `CLI/Check.lean`,
    `CLI/Help.lean`, `Config/Env.lean`, `Config/InstallPath.lean`, `Config/PackageConfig.lean`,
    `Config/Monad.lean`, `Build/Module.lean`;
  - Lake at master `da4295a` (clone `.lake/research/lean4-lake/`): `CLI/Check.lean`,
    `CLI/Help.lean`, `Config/Env.lean`, `Build/Module.lean`;
  - the comparator README @ `865edc1`, lines 59–67;
  - Mathlib's `lakefile.lean` and Tau Ceti's `lakefile.toml` as pinned here (Tau Ceti `e0610cc`, in
    `.lake/packages/`);
  - Tau Ceti `.github/workflows/nightly-verify.yml` at main `d2083f0` (clone
    `.lake/research/TauCeti-main/`);
  - the local `.lake/` of this repository (file counts only).
- **Nothing was run.** The machine used has no `bwrap`, and the sandbox refuses to start there (2.5). No
  unsandboxed run was tried. Every statement below about what the sandboxed build does is read
  from the code, not observed.

### 7.1 The answer in short

- **Both notes are right, about different things.** [J]
  - *Mechanism:* a pre-populated `.lake` **is** used. The sandboxed `lake build` reuses any
    dependency build outputs that already sit in `.lake/packages/*/.lake/build` (7.3).
  - *Trust:* master's help text makes "no pre-existing `.lake` directory" an **assumption of its
    guarantee**. It is not a rule the code enforces (7.4). The standalone README accepts a trusted
    Mathlib cache. The pinned toolchain's help text says nothing either way.
- **Correction to 2.5 here.** "builds Mathlib and Tau Ceti from source" holds only when the
  dependency build directories are empty. Whether `LAKE_CACHE_DIR` and `LAKE_CONFIG` reach the
  sandbox does not matter once the artifacts are in those directories. [J from the code]
- **Correction to the other note's §2.5.** "the sandboxed build then reuses `.lake`" holds for
  outputs already restored into the build directories. It does not hold for Tau Ceti outputs that
  so far exist only as mappings in the Lake cache, for example straight after
  `lake cache get --mappings-only` and before any `lake build` (7.3). [J from the code]

### 7.2 What the sandbox passes in (tag `v4.36.0-rc2`; master has the same lines)

- **Mounts** [R, tag `CLI/Check.lean` l.170–190; master l.311–331, identical]:
  - `"--ro-bind", "/", "/"`, then `"--tmpfs", "/home"`, `"--tmpfs", "/root"`,
    `"--tmpfs", "/run/user"`, `"--tmpfs", "/tmp"`, then `"--clearenv"`;
  - then the `readablePaths` are bound back read-only, and the `writablePaths` read-write;
  - last, `"--setenv", "HOME", "/tmp/home"`, with the comment "the invoking user's `HOME` is no
    longer there to point at, and `git` and Lake's caches want somewhere writable".
- **The build step** (`safeLakeBuild`) [R, tag l.356–376; master l.506–526]:
  - `envPass := #["PATH", "LEAN_ABORT_ON_PANIC"]`;
  - `readablePaths := #[projectDir, ← getLeanPrefix, ← getLakeHome]`;
  - `writablePaths := #[dotLakeDir]`, the project's own `.lake`;
  - no `network := true`, and the default is `network : Bool := false` (tag l.95).

  So the whole project tree is visible read-only, and its `.lake`, **including
  `.lake/packages/*`**, is visible and writable. Only dependency resolution (`lake env` /
  `lake resolve-deps`) has a network (tag l.290 and l.326).
- **Where the build looks for the Lake artifact cache** [R, tag `Config/Env.lean` l.103–115 and
  l.151–159, and the `addCacheDirs` code at l.191–196; `Config/InstallPath.lean` l.217–224; J for
  how the pieces combine]:
  - `LAKE_CACHE_DIR` is cleared, so the first choice falls away;
  - the toolchain cache needs an elan install, which Lake finds only through `ELAN_HOME`. That is
    not passed in either;
  - so Lake uses the system cache `$XDG_CACHE_HOME`, or failing that `$HOME/.cache`, plus `lake`.
    Inside the sandbox that is `/tmp/home/.cache/lake`, on an empty tmpfs.

  This project's cache directory `.lake/cache` (AGENTS.md "Builds") is physically visible inside
  the sandbox, because it lies inside the writable `.lake`. But nothing points Lake at it. [J]
- **`LAKE_CONFIG`** names the cache-service configuration (`Env.lean` l.179: `LAKE_CONFIG`,
  otherwise `~/.lake/config.toml`). Only `lake cache get` needs it, and that runs before
  comparator, outside it. The sandboxed build does not need it. [R for the variable; J for the
  rest]

### 7.3 Is a pre-populated `.lake` used? Yes, if the outputs are in the build directories

- **How the build decides** [R, tag `Build/Module.lean` l.1223–1235; master l.1250–1251 has the
  same cache branch]:
  - the artifact cache is writable only when `enableArtifactCache` or `LAKE_ARTIFACT_CACHE` is set
    (`Config/Monad.lean`: "If not configured at all, this defaults to false"). Neither is set here
    or in the sandbox, so the build takes the non-writable branch;
  - there, if the saved `.trace` is up to date and the artifacts exist
    (`checkArtifactsExist`), the module is **reused as is**, and the cache is never consulted
    (l.1224–1232);
  - only when the trace is not up to date does it try the cache (`isArtifactCacheReadable`,
    default `true`), with `fetchFromCache? presetup savedTrace true` (l.1234–1235). Inside the
    sandbox that cache is the empty `/tmp/home/.cache/lake`, there is no network, and so the module
    is built from source. [J for the sandbox case]
- **Mathlib** [R]:
  - `lake exe cache get` writes Mathlib's oleans into `.lake/packages/mathlib/.lake/build`. Here
    that directory holds 8,715 `.olean` files, 7.2 GB [R, `find`, `du`].
  - Mathlib's `lakefile.lean` (as pinned) has `platformIndependent := true` ("Mathlib oleans are
    built on Linux CI and used across platforms") and `restoreAllArtifacts := true` ("Mathlib
    currently expects artifacts to be in the build directory").
  - So the sandbox reuses them. [J from the code]
- **Tau Ceti** [R]:
  - `lake cache get --service tauceti-public … --mappings-only` downloads "only … the mappings
    and delay[s] downloading artifacts until they are needed" (tag `CLI/Help.lean` l.611 and
    l.644–646). After that command alone, no Tau Ceti olean is in the build directory.
  - The next ordinary `lake build`, run with `LAKE_CACHE_DIR` and `LAKE_CONFIG` set, fetches them
    and restores them into `.lake/packages/TauCeti/.lake/build`. The restore is the `true` argument
    at l.1235.
  - Here that directory holds 352 `.olean` files, 174 MB. Their `.trace` files list hash-named
    outputs, for example `"o":["f71b260b66386b73.olean",…]` [R, `find`, `du`, one `.trace` read].
  - Tau Ceti's `lakefile.toml` has `platformIndependent = true` (l.8) and no
    `restoreAllArtifacts` setting.
  - So the sandbox reuses them if they have been restored, and rebuilds them from source if only
    the mappings are present. [J from the code]
- **A preparation that would work** [J; not tested]. Outside the sandbox, with the AGENTS.md
  environment set:
  1. `lake exe cache get`;
  2. `lake cache get --service tauceti-public …`, without `--mappings-only`, or followed by a
     build of the Tau Ceti modules that the statement imports (for example
     `lake build TauCeti.AlgebraicGeometry.LineBundle.TensorProduct …`), so that the outputs land in
     the build directory;
  3. remove the project's **own** `.lake/build`, so that nothing built outside the sandbox from
     this repository's code (above all the solution) is reused;
  4. then run `lake comparator`.

  Whether step 2 without `--mappings-only` also restores into the build directory, without a
  build, was not checked.

### 7.4 Does master forbid it? It is an assumption, not a check

- **The text** [R, master `CLI/Help.lean` l.434–441]:
  > "REQUIREMENTS: Comparator is only able to provide these guarantees under the following
  > assumptions: … 3. The project operates from a clean build, that is, there is no pre-existing
  > `.lake` directory."

  The pinned toolchain's help has no REQUIREMENTS section for `lake comparator` [R, tag
  `Help.lean`: its only REQUIREMENTS heading, l.923, belongs to another command], as 1 already
  says.
- **The code does not enforce it** [R]. Both master (`Check.lean` l.512–515) and the tag (l.361–364)
  only create `.lake` when it is missing (`if !(← System.FilePath.pathExists dotLakeDir) then
  IO.FS.createDir dotLakeDir`) and otherwise use what is there. There is no error and no warning.
- **The standalone README** [R, l.61–67]:
  > "Note that running `lake exe cache get` to download a Mathlib cache is acceptable before running
  > the comparator if you trust the cache to not be modified as to, e.g. contain different
  > definitions from the one you would expect."

  It adds that with "a fully pre-built `.lake` directory [obtained] through other means and
  without compromising your checking environment, `Solution.lean` will not be rebuilt".
- **Tau Ceti's practice** [R, `nightly-verify.yml` l.143–147 and l.149–159]. Even its "hard
  signal", the from-source nightly build, first runs `lake exe cache get || lake exe cache get!`
  ("Fetch Mathlib oleans for the clean build"). Only Tau Ceti's own modules are built from source,
  with `LAKE_RESTORE_ARTIFACTS: "false"`, `LAKE_NO_CACHE: "true"` and a fresh workspace-local
  `LAKE_CACHE_DIR`. So Tau Ceti's own strongest check trusts Mathlib's cache.
- **What that means** [J]:
  - A run with no `.lake` at all is trustworthy in master's strict sense. It builds the
    statement's whole Mathlib and Tau Ceti closure inside the sandbox.
  - A run with the dependency outputs taken from the Mathlib and Tau Ceti caches is trustworthy
    **on one extra assumption**: the caches contain the definitions their sources say. That adds
    Mathlib's cache (Mathlib's CI) and `cache.taucetiproject.org` (Tau Ceti's CI) to the trusted
    base.
  - A tampered dependency olean would look the same to the challenge and the solution. Comparator
    would therefore not notice a changed definition. That is exactly the README's warning. The
    kernel and the axiom checks still run on whatever is exported, so the extra assumption bears on
    what the trusted definitions *mean*, not on whether the proof checks.
  - The project's own `.lake/build` must never be reused for a solution run (7.3, step 3). That is
    the part of requirement 3 that matters whatever one decides about the caches.

### 7.5 Where a trustworthy run could happen

- **Constraints.**
  - The sandbox needs Linux and `bwrap`. Without `--inadvisably-no-sandbox`, `mkContext` refuses
    on any other platform [R, tag `Check.lean` l.602–609].
  - `bwrap` needs "either unprivileged user namespaces or a `bwrap` installed setuid root" [R,
    `missingSandboxError`].
  - This repository has had no CI since commit `0feeb6f`, which deleted `.github/workflows/ci.yml` [R, `git show --stat 0feeb6f`].
  - Tau Ceti: "A clean build alone now exceeds GitHub-hosted runners' six-hour platform limit"
    [R, `nightly-verify.yml` l.64].
- **What the six-hour figure measures** [R, same file]:
  - a clean build of all of Tau Ceti `main`, with Mathlib's oleans taken from the cache
    (l.143–147);
  - on a 16-core Namespace runner (`nscloud-ubuntu-24.04-amd64-16x32-…`, l.73), with
    `timeout-minutes: 720` (l.76);
  - Tau Ceti `main` has 27,553 `.lean` files under `TauCeti/` at `d2083f0`, and the pinned
    `e0610cc` has 23,391 [R, `find`].

  GLCinLean needs only the 352 Tau Ceti modules that its imports reach (the oleans in its build
  directory, 7.3). So **the six-hour figure does not apply to this project**. [J] What does
  dominate a fully clean run here is the Mathlib closure of the statement's imports, which takes
  hours [E, not measured].
- **The options** [J unless tagged]:
  1. **A Linux virtual machine on the owner's own machine.**
     - Lean `v4.36.0-rc2` ships `linux_aarch64` builds [R, `gh api …/releases/tags/v4.36.0-rc2`].
     - Mathlib's and Tau Ceti's caches are platform-independent (7.3), so an arm64 Linux machine can
       use them.
     - `bwrap` needs unprivileged user namespaces in the VM [R, as above]. Whether a given
       distribution allows them by default was not checked.
     - No CI, a manual and occasional run, all under the owner's control. The cost is setting up
       and maintaining the VM.
  2. **One GitHub-hosted Ubuntu job, with the dependency caches.**
     - The sandboxed build then compiles only this repository's modules and the challenge and
       solution, which is far below six hours [E].
     - `bwrap` can be installed as Tau Ceti does, from a pinned `.deb` on `ubuntu-24.04` [R,
       `nightly-verify.yml` l.296–301].
     - It means bringing back one workflow after `0feeb6f`: an owner decision.
  3. **A fully clean run (master's strict reading), sandboxed.** This builds the Mathlib closure and
     352 Tau Ceti modules from source.
     - Whether this fits in six hours on a standard GitHub-hosted runner was not measured [E:
       uncertain].
     - The safer places are a large or self-hosted Linux runner, or the VM of option 1 left
       running for as long as it takes.
     - It removes the extra assumption on the caches (7.4).
  4. **Export files built elsewhere** (`--challenge-from-export`, `--solution-from-export`; help
     EXPORTS, master l.545–555: "Using export files built in virtual machines for extra
     isolation").
     - This moves the build somewhere else. But the judging run still goes through `mkContext`'s
       Linux check before it looks at the export files (tag l.602–609).
     - So a trustworthy verdict still needs Linux, unless one passes `--inadvisably-no-sandbox`
       and "provide[s] isolation by other means" (the other note §2.5).
     - It does not remove the need for Linux.
- **When it is needed** [J, as in 3.7]: at proof time (step 6) and for an occasional `lake check`
  of the library. It is not needed during the statement phase, whose `sorry`s fail both commands
  anyway.

### 7.6 What this changes, and the questions it adds for the owner

- **2.5 and 3.7 of this note.** A trustworthy run does not have to cost hours of rebuilding
  Mathlib and Tau Ceti, if the owner accepts the dependency caches as trusted. Without CI, it can
  run in a Linux VM on the owner's own machine. [J]
- **Question 6.2** (Linux) gains a concrete low-machinery answer: option 1, a Linux VM on the owner's machine.
  Option 2 is the CI alternative.
- **New question for the owner.** For the final comparator run, do you accept the Mathlib and Tau
  Ceti caches as trusted? That is the README's position and Tau Ceti's own practice for Mathlib.
  Or do you require master's strict "no pre-existing `.lake`", a full from-source build of the
  statement's closure inside the sandbox, which takes hours and needs a long-running Linux
  machine? Either way, the project's own `.lake/build` is removed before the run.
