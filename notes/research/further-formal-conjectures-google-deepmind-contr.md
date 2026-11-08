# Formal Conjectures (google-deepmind): CONTRIBUTING.md, AGENTS.md, STATEMENTS.md

- Source: <https://github.com/google-deepmind/formal-conjectures>, read at commit
  [`2055e5a`](https://github.com/google-deepmind/formal-conjectures/tree/2055e5adadae0b2e392365938faa82ef6f1464f0)
  (2026-11-06; still the head of `main` on 2026-11-08 [R GitHub API]). Local clone:
  `.lake/research/formal-conjectures/` (ignored by Git).
- Files read in full: `AGENTS.md` (107 lines), `STATEMENTS.md` (57), `CONTRIBUTING.md` (444),
  `PROOFS.md`, `README.md`. Also read: `lakefile.toml`, `FormalConjecturesUtil/Linters/StubLinter.lean`,
  the header of `ExistsImplicationLinter.lean`, `FormalConjectures/Millennium/BSD.lean`, parts of
  `Wikipedia/HasseWeil.lean` and `Wikipedia/EllipticCurveRank.lean`, `site/README.md`, CI workflow
  `build-and-docs.yml` (grep only), `lean-release-tag.yml`, and bump PR #5074 via the GitHub API.
  Re-checked on 2026-11-08 by a second reader: the same files, plus
  `FormalConjecturesForMathlib/AlgebraicGeometry/EllipticCurve/Regulator.lean` (the `regulator`
  signature), the repository's tag list and its bump PRs via the GitHub API, and GLCinLean's
  `Abstract.lean` and `Foundations.lean` for the comparisons.
- Checked 2026-11-08.
- Licence: code Apache-2.0, other material CC-BY 4.0 [R README]. Nothing is copied into
  GLCinLean; if a linter or checklist text is copied later, it needs a provenance header and the
  Apache-2.0 notice.

## 1. What it is

- A Lean 4 + Mathlib repository of formal **statements** of open problems: "a statement
  repository, not a proof repository: almost every problem is `sorry`". [R AGENTS.md]
- Purpose: a benchmark for automated provers, clarifying what conjectures mean, and showing
  Mathlib which definitions are needed. [S README]
- Size at this commit: 1832 problem files in `FormalConjectures/`, 253 files in
  `FormalConjecturesForMathlib/`. The strings `category research open`, `category test` and
  `category API` occur about 1878, 2815 and 705 times. [R, grep counts, 2026-11-08]
- Maintained by Google DeepMind with outside contributors; a paper is arXiv 2605.13171. [R README]
- Accuracy rests on "careful human review of contributions", with plans "to periodically leverage
  AlphaProof to help identify potential misformalisations". [S README]

## 2. What it says that matters for GLCinLean

### 2.1 The agent instruction file (`AGENTS.md`)

- 107 lines. It says what the repository is in two sentences, then points to the reference
  documents: `CONTRIBUTING.md` for conventions, `STATEMENTS.md` for statements, `PROOFS.md` for
  proofs, plus "any `README.md` in the directory that you change". [R]
- Sections are short imperatives: start with existing code; state the source faithfully; write
  clear documentation; keep the Lean simple; build the changed scope; write a readable pull
  request; a pre-review checklist. [R]
- Language rule: "Write documentation in simple, concise technical English. Prefer short
  sentences, common words, and one instruction or claim per sentence." It applies to issues, pull
  requests, reviews and comments too. [R]
- "Do not put review notes or a proposed proof of an open problem in a Lean file." "Put reviewer
  notes in the pull request, not in Lean comments." [R]
- Builds: build only the changed modules, with `lake --wfail build <module>`; `--wfail` turns
  warnings into failures, "as CI does". [R]

### 2.2 The statement-review checklist (`STATEMENTS.md`)

"The main question is whether the Lean statement says what its cited source says." [R] It asks
the reviewer to:

- read the cited source, including remarks and variants; the module docstring is "part of the
  change under review", not an independent source;
- read every non-standard definition used by the statement, confirm names with `#check`, and see
  what they return on empty or smallest inputs;
- compare: order and scope of quantifiers; strict and non-strict bounds; hypotheses and domain
  restrictions; equality, asymptotic equivalence and order relations; direction of implications;
  every variant and special case; the category and answer recorded by the source;
- check that `@[question]` is used exactly when the source asks rather than claims, and that a
  value question's statement constrains its `answer` and is not "true for every possible
  answer";
- beware `∃ x, P x → Q` (usually meant `∃ x, P x ∧ Q`; the first is trivially true);
- check boundary cases (empty types, `ZMod 0`, `x / 0`, `sInf ∅`); a default value is a defect only
  if the statement can reach it and it changes the claim;
- "For each hypothesis, ask whether any object can satisfy it. An impossible hypothesis makes an
  implication vacuously true." [R]

### 2.3 No placeholders, enforced by a linter

- `STATEMENTS.md`: "Never add an `axiom`, `opaque`, or `constant` declaration anywhere in the
  repository." [R]
- `CONTRIBUTING.md`, style guidelines: "Do not introduce placeholder definitions (e.g.
  `def foo : Type := sorry` or `opaque foo : Type*`), incomplete type annotations, holes, or new
  axioms. All referenced definitions must exist, and all imports must be correct." [R]
- This is enforced, not just advised. `StubLinter.lean` flags every `opaque`, every `axiom`, and
  every `def`/`abbrev`/`instance`/`structure` whose body contains `sorry`. It is switched on for the
  whole repository by `weak.linter.style.stubs = true` in `lakefile.toml`, and CI builds with
  `--wfail`. [R]
- The one exception: the unknown of a value question, a definition named `<theorem>.answer` whose
  value is `sorry` until the question is answered. [R StubLinter.lean, CONTRIBUTING.md] The
  linter implements this by name only: any definition whose last name component is `answer`
  passes. [R StubLinter.lean `isAnswerDef`]
- How far the linter reaches. [R StubLinter.lean]
  - It is syntactic: it looks for the `sorry`/`admit`/`sorryAx` tokens inside the declaration
    itself. A definition that depends on a sorried **theorem** (for example through an instance)
    passes. BSD relies on exactly this (§2.5).
  - It has no case for `constant`; `STATEMENTS.md` still names it. [R] (Lean 4 has `opaque` in
    place of Lean 3's `constant`. [J])
  - It can be switched off with `set_option linter.style.stubs false`; no file in
    `FormalConjectures/` or `FormalConjecturesForMathlib/` does so. [R, grep 2026-11-08]
- "No `sorry` in the staging layer" is enforced by the build, not only by the linter: sorry
  warnings stay on for `FormalConjecturesForMathlib`, and CI builds it with
  `lake --wfail build FormalConjecturesForMathlib FormalConjecturesUtil`, so a `sorry` there fails
  CI. [R lakefile.toml, `build-and-docs.yml` line 211]
- In practice: no `opaque`, `axiom` or `constant` declarations occur in `FormalConjectures/` or
  `FormalConjecturesForMathlib/` (the only grep hits are the English word "constant" in
  docstrings). [R, grep 2026-11-08]
- So: **theorems may be `sorry`; definitions may not.** Sorry warnings are switched off for the
  problem library (and the tooling-test library `FormalConjecturesTest`) only
  (`warn.sorry = false` in their `lean_lib` blocks). [R lakefile.toml]
- More precisely, the line falls between **propositions and data**. A missing proof of a
  proposition may feed a definition (BSD, §2.5); a missing type, object or function may not.
  [J, from the rules and from BSD.lean] In Lean a proposition's proofs are interchangeable, so a
  definition's value cannot depend on which proof is missing; an `opaque` type has no value at
  all to check. [J]

### 2.4 The two-layer split: problems and a sorry-free staging library

- Reusable mathematics goes in `FormalConjecturesForMathlib/`, which "follow[s] mathlib's
  directory structure", is "potentially suitable to be upstreamed", and "must not contain
  `sorry`". [R README, AGENTS.md]
- `PROOFS.md`: every theorem there "must have a complete kernel-checked proof"; no `sorry`,
  placeholder definitions or `native_decide`; "Keep the code at Mathlib quality and import only
  the Mathlib modules that it needs." [R]
- Sanity checks for a shared definition live in the file that defines it, not in a separate test
  folder. [R AGENTS.md]
- In problem files, bespoke definitions are allowed "when they help clarify problem statements;
  add basic API tests for them". Unit tests are tagged `@[category test]`; basic theory around a
  new definition is `@[category API]`. Every theorem has exactly one category, checked by a
  linter. [R CONTRIBUTING.md]
- Tests are not always proved: "A long proof may remain `by sorry` in `FormalConjectures/`" for a
  `test` or `API` declaration. [R PROOFS.md] In practice almost all are proved: a crude count of
  attribute blocks finds `sorry` in about 70 of about 2808 `test` blocks and about 35 of about 705
  `API` blocks. [E, script over `FormalConjectures/`, 2026-11-08] A sorried test is no evidence;
  only proved tests count.

### 2.5 A worked example of a deep statement on real definitions: BSD

`FormalConjectures/Millennium/BSD.lean` is the closest analogue to GLC in the repository. [J]

- It states weak and strong BSD over any number field using real definitions: the L-series and
  its meromorphic continuation, `meromorphicOrderAt`, the Mordell–Weil rank, the period, the
  regulator, the Tate–Shafarevich group and the Tamagawa product. [R]
- The heavy objects were built in the staging layer:
  `FormalConjecturesForMathlib/AlgebraicGeometry/EllipticCurve/TateShafarevich.lean` (106 lines),
  `.../EllipticCurve/Tamagawa.lean`, and
  `.../RepresentationTheory/Homological/ContCohomology/Sha.lean` (112 lines). [R, line counts]
- Facts it needs but cannot prove are separate sorried **theorems**, each a stated conjecture or
  known result with its own category, for example `mordell_weil` (research solved) and
  `exists_hasMeromorphicContinuation` (the Hasse–Weil conjecture, research open). [R]
- A sorried theorem feeds a definition here. `regulator` requires an instance
  `Module.Finite ℤ (W.Point ⧸ Submodule.torsion ℤ W.Point)` [R Regulator.lean line 79]. BSD.lean
  supplies the finiteness by `attribute [local instance] EllipticCurveRank.mordell_weil`, where
  `mordell_weil : Module.Finite ℤ E.Point` is proved by `sorry` (tagged research solved, with a
  `formal_proof` link to a formalisation by Stoll). `bsdQuotient` and `StrongBSD` therefore
  depend on a sorried proposition, and the stub linter does not object. [R BSD.lean,
  EllipticCurveRank.lean] The rank itself is `Module.finrank ℤ E.Point`, which needs no
  instance. [R]
- `HasMeromorphicContinuation` and the Hasse–Weil statements live in the problem file
  `FormalConjectures/Wikipedia/HasseWeil.lean`, not in the staging layer. [R]
- The docstring compares readings across sources: Dokchitser–Dokchitser assert the continuation;
  Tate and Gross assume it; "the two readings differ exactly by the Hasse–Weil conjecture". [R]
- A small `@[category API]` theorem `StrongBSD.weakBSD` checks that the strong form implies the
  weak one. [R]

### 2.6 Other mechanisms

- **Linters as encoded review rules**: stubs, category, AMS tag, module docstring, LaTeX in
  docstrings, copyright header, namespace, imports, and `∃ x, P x → Q`. [R file list,
  ExistsImplicationLinter.lean header]
- **Long proofs are kept out**: "Longer proofs (i.e. more than 25-50 lines) are not to be included";
  a `@[formal_proof using <kind> at "<url>"]` attribute links to an external proof, and for research
  problems the link must be a Palomar registry entry. [R CONTRIBUTING.md]
- **Proof claims are checked with `#print axioms`**; `sorryAx` means not proved. A linked proof is
  checked by opening the exact declaration and confirming it implies the repository statement. "A
  repository name, a successful build, or a theorem with a similar name is not enough evidence."
  [R PROOFS.md]
- **Versioning**: the repository "will track the monthly tagged releases of mathlib ... rather than
  tracking mathlib master" (now `v4.33.1`). A workflow tags each `lean-toolchain` change as
  `v4.X.Y`. Benchmark snapshots are tagged `bench-v{N}-lean4.X.Y` and are immutable; a corrected
  misformalisation goes into `v{N+1}`. [R README, lakefile.toml, lean-release-tag.yml]
- **Bumps are maintainer pull requests**, not automated: for example #5074 "chore: bump to v4.33.1"
  by a maintainer, merged 2026-08-24, 60 files changed, depending on four earlier bump PRs. [R
  GitHub API]
- **"Monthly" is the stated aim, not the practice.** [S README] The bump to `v4.27.0` (#1896)
  merged on 2026-02-19; the next bumps, `v4.28.1` to `v4.33.1` (#2356, #3691, #4025, #4356,
  #4428, #5074), all merged on 2026-08-23 and 2026-08-24 as one catch-up; a bump to `v4.34.0`
  (#6425) was still open on 2026-11-08. [R GitHub API, PR search 2026-11-08] So the repository
  lagged about six months behind Mathlib's tags before catching up. Only one benchmark snapshot
  tag exists, `bench-v1-lean4.27.0`. [R tag list]
- **A web page from attributes**: `lake exe extract_names` reads the `@[category]` and `@[AMS]`
  attributes and writes JSON (name, module, category, AMS codes, statement, docstring); a static
  site (sources in `site/`) is built from that JSON. Marked "experimental". [R site/README.md]
- **Contributor terms**: a Google CLA is required; AI use follows Mathlib's conventions. [R
  CONTRIBUTING.md] This matters only if GLCinLean ever contributes there.

## 3. What it means for GLCinLean

- **A model for the short `AGENTS.md`** (decision "Shared context lives in `AGENTS.md` ... short
  and written for agents ... plain, understandable, structured words"). [J] Their file is the
  shape that decision describes: purpose in two sentences, links to longer guides, short
  imperatives, a language rule that also covers PR and review text, and a pre-review checklist.
  GLCinLean can copy the shape: goal, links to the style guides, the statement checklist, the
  build command, the push rule.
- **A ready statement-review standard** (workflow step 4, "fresh agents check changed
  declarations against the papers"; open question "who reviews the mathematics, and to what
  standard"). [J] `STATEMENTS.md` is written to be followed by a reviewer who did not write the
  statement, which is what a fresh agent is. Most items carry over to GLC: quantifier scope over
  `G`, `X`, the square root of `ω_X` and the pinning; direction of implications; "can any object
  satisfy each hypothesis?"; read every non-standard definition. Boundary cases translate to
  trivial objects: the zero category, `G` a torus, the trivial group.
- **The same two-layer architecture as the owner's plan** (ideas.md §1 "a library, not a one-off";
  §4 "parts that neither Mathlib nor Tau Ceti has: write them in my repository first"; workflow
  step 3 "backbone, then the GLC statement surface"). [J] `FormalConjecturesForMathlib/` is a
  working precedent for a sorry-free, Mathlib-quality, Mathlib-shaped staging layer under a
  statement layer. For GLCinLean, the backbone is the staging layer, with upstream targets Tau
  Ceti and Mathlib.
- **Tests as part of definition design** (ideas.md §2 "code quality as high as possible";
  Xena value "Link to the existing literature. A mathematician should be able to trust and verify
  that the concepts ... have the expected meaning"). [J] `@[category test]` and `@[category API]`
  theorems give a reviewer who cannot read the maths something checkable: "for `G = 𝔾ₘ` this
  category is ...", "this functor is an equivalence for the trivial group". The owner relies on
  such evidence.
- **Encode review rules as linters**, which suits "work in a very simple way ... prompts alone"
  (ideas.md). [J] A linter is a few dozen lines of Lean in the project, not a harness. A stub
  linter with an allowlist could replace ReviewKit's `@[placeholder]` attribute and the sorry
  budget: it reports or forbids `opaque` and sorried definitions, with a named exception. Their
  linter is syntactic (§2.3), so it needs `#print axioms` beside it to see what a declaration
  depends on.
- **Sorried facts as stated theorems, not as placeholders.** BSD shows the pattern: build the
  objects really, state the deep facts they need (Mordell–Weil, Hasse–Weil) as separate sorried
  theorems with their own docstrings, and say in the docstring where sources differ. [J] GLC's
  `exists_isLanglandsFunctor` and `isLanglandsFunctor_unique` in `Abstract.lean` follow
  this pattern in form for `𝕃_G`; the pattern does not cover `DGCat`, `QCohLS`, `IndCohNilp` or `DmodHalf`.
  [R Abstract.lean] One difference: BSD feeds a sorried *proposition* (an instance) into a
  definition, while `LG` extracts *data* with `Classical.choose` from a sorried existence theorem.
  `LG` is then well defined, but if the existence statement were mis-stated, `main` would speak
  about an arbitrary functor. [J] Formal Conjectures' linter would accept `LG` (no `sorry` in its
  body) and reject every `opaque` beneath it. [J, from StubLinter.lean]
- **Review notes in the PR, not in the Lean file** (ideas.md "fully in Mathlib's documentation
  style"). [J] `Abstract.lean` and `Foundations.lean` docstrings carry status and review notes
  ("Status: STUB written 2026-11-05 ... Unreviewed", "Budgeted sorry"). [R GLCinLean files] Under
  this rule those notes move to commits, PRs or `notes/`.
- **A Lean-generated web page from attributes** is a small precedent for the review system's
  "web page generated directly from it" (ideas.md, review system). [J] It covers categories only:
  no dependency graph and no review status by commit, so tracker remains the main model.
- **Not applicable**: the 25–50-line proof limit and the Palomar link are about a benchmark that
  stores no long proofs. GLCinLean must hold the whole proof, so these do not carry over. [J]

## 4. Conflicts

1. **`opaque` placeholders (main conflict).** [R both sides]
   - Formal Conjectures: no `opaque`, `axiom`, `constant` or sorried definition anywhere, enforced
     by a linter; "All referenced definitions must exist". A definition may still rest on a
     sorried theorem (a proposition), as BSD's regulator does (§2.5).
   - GLCinLean: `Foundations.lean` builds `DGCat`, `DGCat.Obj` and `LinFun` on
     `opaque ... : NonemptyType`, and declares `LinIso`, `LinFun.obj`, `LinFun.comp`, `LinFun.id`,
     `DGCat.IsCompact` and `DGCat.IsEventuallyCoconnective` as plain `opaque` constants
     [R Foundations.lean]; `Abstract.lean` has `@[placeholder] opaque` for `DmodHalf`,
     `QCohLS`, `IndCohNilp`, `Psi`, `LCoarse` and `RootDatumDuality`. `AGENTS.md` recommends
     the pattern ("A missing object works well as `@[placeholder]` on an `opaque`").
   - Their reason, in my reading: a statement about an opaque object has no checkable meaning,
     because nothing can be unfolded, tested or compared with the source. [J] For GLCinLean,
     `theorem main (S : Setting k) : (LG S).IsEquivalence` over opaque categories cannot be checked
     against GLC I by any review; it only becomes meaningful when the placeholders are replaced.
   - The scale differs: BSD needed a few hundred lines of new definitions; GLC needs DG categories,
     ind-coherent sheaves on stacks, D-modules on `Bun_G` and the roughly 23 constructions of the
     `𝕃_G` chain. These are far beyond Mathlib and Tau Ceti. [E] So the rule, applied strictly,
     would postpone any GLC statement until the backbone exists.
2. **With the Xena value quoted in ideas.md**: "Producing low-quality or unaudited code and
   claiming or hoping to 'clean it up later' is counterproductive." [R ideas.md] Formal
   Conjectures' rule is that value applied to statements; GLCinLean's placeholders are a "clean it
   up later" design. [J] ideas.md's "first the statement, then the whole proof" is compatible only
   if "the statement" means one built on real definitions.
3. **With the Annals Challenge** (see `annals-challenge.md`). [R that note] The Annals Challenge
   allows `def … := sorry` holes pinned by sorried characterising theorems (the algebraic Jacobian
   file). Formal Conjectures forbids exactly that. The two curated statement projects disagree;
   GLCinLean's current design is weaker than either, since its placeholders carry no
   characterising properties. [J]
4. **With Tau Ceti's versioning** (see `tauceti-contributing.md`). [R that note] Formal
   Conjectures tracks monthly tagged Mathlib releases; Tau Ceti tracks Mathlib `master` with
   hourly bump PRs. GLCinLean depends on Tau Ceti, so it cannot follow Formal Conjectures here; its
   cadence is set by Tau Ceti's pin. [J] Formal Conjectures' bumps are also done by maintainers,
   not automated, so it offers no model for the decision "keeping up with Mathlib and Tau Ceti is
   fully automated". [R PR #5074] It is also a warning: with manual bumps it fell about six
   months behind its own "monthly" aim before one catch-up in August 2026 (§2.6). [R GitHub API;
   J on the lesson]
5. **With the sorry budget and statement pin** (`reviews/sorry-budget.toml`,
   `reviews/statement-pin.toml`). [J] Formal Conjectures has neither. It controls sorries by
   layer (none in the library, any in theorems, none in definitions) with linters and `--wfail`
   builds, and fixes the benchmark as a whole by immutable snapshot tags rather than
   per-statement fingerprint files. [R README] A tag pins the whole problem set at once; it says
   nothing about which single statement changed, which is what the statement pin and the owner's
   planned review status track. [J] So the tags are a simpler mechanism for part of the same goal,
   not a replacement.

## 5. Input for the open questions

- **What goes into `AGENTS.md`, and where "update the next prompt" lives.** Suggests: a short file
  in their shape (purpose, links to the Mathlib guides and a statement checklist, language rule
  covering PR and review text, build command, pre-commit checklist). [J] Reason: it is a working
  agent file for a statement repository at scale. It says nothing about updating prompts; that
  rule needs another source.
- **Whether `PLAN.md` is needed.** No direct input: Formal Conjectures has no plan file and uses
  issues and milestones, but it has no long single goal. [J]
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.**
  Suggests change. [J] Reason: the largest statements-first Lean repository forbids the design and
  enforces this with a linter; BSD shows the alternative of building real definitions in a sorry-free
  layer and stating needed facts as sorried theorems. The realistic options are listed in §6, Q1.
  Whatever is chosen, the existing `AGENTS.md` note recommending `opaque` should not stand
  unqualified.
- **What happens to each existing file.**
  - ReviewKit's `@[placeholder]` attribute: could be replaced by a project linter like
    `StubLinter` (forbid `opaque`/sorried definitions, with a named allowlist), which keeps the
    project free of an external tool. [J]
  - `reviews/sorry-budget.toml`: could be replaced by layer rules plus `#print axioms` checks
    (`PROOFS.md`). These are the owner's files, so this is a proposal only. [J]
  - `reviews/statement-pin.toml`: the nearest Formal Conjectures analogue is an immutable tag per
    benchmark version, covering the whole repository, not one statement. It does not replace a
    per-declaration pin. [J]
- **Who reviews the mathematics, and to what standard.** Suggests: adopt `STATEMENTS.md` (adapted
  to GLC) as the written standard that fresh agents follow, and keep reviewer notes in PRs or
  `notes/`, not in Lean files. [J] Formal Conjectures still treats human review as the final check
  and plans automated misformalisation searches on top [S README]; for GLC that argues for at
  least one outside expert at the statement milestone. [J]
- **Where research notes and session summaries live.** Weak input: Formal Conjectures puts
  review and formalisation notes in PR descriptions, never in Lean files. [R AGENTS.md] That fits
  committed notes outside the Lean tree. [J]

## 6. Questions for the owner

1. **May the GLC statement stand on `opaque` placeholders at all?** Options:
   - (a) keep `opaque` placeholders, tracked and counted, and accept that the statement says
     nothing checkable until each is replaced;
   - (b) forbid them, as Formal Conjectures does, and state GLC only once every object is
     really defined (the backbone first, with test theorems). Under Formal Conjectures' actual
     line, missing *propositions* (deep facts such as existence or finiteness results) could
     still be sorried theorems feeding definitions; only missing *data* is ruled out;
   - (c) a middle way: forbid `opaque` and sorried definitions in the library (backbone),
     allow them only in the statement surface during the build, and add sorried characterising
     theorems for each (the Annals Challenge pattern).
2. **Should the GLC statement checklist be an adapted `STATEMENTS.md`?** If yes, the Apache-2.0
   text needs attribution where it is copied.
3. **Should test and API theorems be required for every new definition** (for example "for the
   trivial group this is ...")? They give the owner evidence that does not depend on reading the
   maths.
4. **Should review rules be enforced by small project linters** (stubs, `∃ x, P x → Q`, docstrings)
   in place of ReviewKit's attribute and the TOML budget files? Those files belong to the owner.
5. **Should status and review notes come out of Lean docstrings** (the "Status: STUB ...
   Unreviewed" lines) and move to commits or `notes/`?
