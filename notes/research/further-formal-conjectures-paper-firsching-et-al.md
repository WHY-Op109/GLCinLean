# Formal Conjectures paper (Firsching et al.)

- **Source:** M. Firsching, P. Lezeau, S. Mercuri, M. Z. Horváth, Y. Dillies, C. Sönne, E. Wieser,
  F. Zhang, T. Hubert, B. Agüera y Arcas, P. Kohli, *Formal Conjectures: An Open and Evolving
  Benchmark for Verified Discovery in Mathematics*, arXiv 2605.13171 **v1** (submitted 13 May 2026),
  <https://arxiv.org/abs/2605.13171v1>. NeurIPS 2026 preprint format.
- **Read from:** the arXiv TeX source of v1 (`https://arxiv.org/e-print/2605.13171`), unpacked into
  `.lake/research/formal-conjectures-paper/src/` (Git-ignored). Read: abstract, introduction,
  related work, §3 (Formal Conjectures), §4 opening (evaluation), discussion, conclusion,
  appendices A (details, taxonomy, examples), B (experimental details, opening), C (extended
  discussion). Not read in detail: the result tables and plots.
- **Also read, for comparison:** the repository's current `AGENTS.md` and `STATEMENTS.md` at
  commit `2055e5adadae0b2e392365938faa82ef6f1464f0` (6 Nov 2026) of
  <https://github.com/google-deepmind/formal-conjectures>, its `CONTRIBUTING.md` at that commit,
  and (through `gh api`) `CONTRIBUTING.md` and `AGENTS.md` at commit `11ba193` (11 May 2026, two
  days before the paper), to see which rules came after the paper.
- **Licence:** the arXiv listing shows CC BY 4.0 for the paper; the repository is Apache 2.0
  ([R] LICENSE at the commit above). Nothing is copied into GLCinLean; quotes are short.
- **Checked 2026-11-08.** All tags below were checked on that date.

## 1. What it is

- A paper about **Formal Conjectures**, Google DeepMind's open Lean 4 + Mathlib repository of
  formal statements of open and solved problems: 2615 statements, 1029 `research open`, 836
  `research solved`, 467 `test`, 155 `API`, 128 `textbook` [R; S as to their accuracy]. The
  paper ties only the `test`/`API` counts explicitly to the `bench-v1-lean4.27.0` release; the
  total is "currently" (abstract). All come from one generated file, so they are probably one
  snapshot [E].
- It is a *statement* repository: open problems stay `sorry`; proofs over 25–50 lines are kept
  elsewhere and linked [R].
- The part that matters here is **how they make statements faithful without a proof**: the
  review pipeline, test-based design of definitions, AI proof attempts as audits, linters, and a
  taxonomy of 291 fixed misformalisations [R].
- About 80 statements are tagged algebraic geometry (AMS 14), e.g. Hartshorne's conjecture on
  rank-2 bundles on ℙⁿ [R]. Nothing in it is close to geometric Langlands: no `.lean` file at
  commit `2055e5a` contains the word "Langlands" [R, grep of the clone]. (The paper's tables list
  only the top-10 AMS subjects, so they cannot show this.)

## 2. What it says that matters for GLCinLean

### 2.1 The review pipeline (§3.4, Fig. 4) [R]

- "every contribution undergoes mandatory code review by humans with both Lean expertise and
  relevant mathematical domain knowledge."
- "most recent submissions use AI tooling, including agentic coding assistants and
  auto-formalization systems"; the repository has an `AGENTS.md` "with structured guidance for
  these tools". (The paper does not say they are written by AI alone.)
- "reviewers use language models to cross-check formalizations against informal sources, and
  AlphaProof runs on submissions to catch potential misformalizations before merging." Gemini and
  other tools also cross-check statements against source texts and flag discrepancies for humans.
- Automated provers periodically try proofs **and disproofs** across the repository; "manually
  inspecting these results primarily reveals misformalizations". A proof of an open problem
  "triggers manual inspection for fidelity", because it may settle a misformalised statement (§4.1).
- Example: Erdős Problem 124 was initially misformalised with an unintended extra hypothesis;
  Aristotle's proof happened not to need it (Related work).
- Corrections are sent back to the informal sources (e.g. erdosproblems.com).
- Planned: move more of this into GitHub CI [S].

### 2.2 Test-based design of definitions (§3.1, §3.4) [R]

- "Any new definition introduced should be accompanied by a suite of proven `test` lemmas and
  `API` statements that are designed to establish expected behavior of the definition and
  mitigate the risk of edge-case errors." These make up 23.8% of all statements.
- "Lean and Mathlib's tooling (for example `decide`) can be employed to prove many of these
  `test` statements." The tests are cheap because the definitions are mostly combinatorial or
  number-theoretic [J].
- Easy cases are stated on purpose: "a disproof of an easy special case or known variant might
  indicate that some of the definitions used have been stated incorrectly."
- "We strive to always state the simplest open variant of a conjecture, as well as the
  conjecture in greater generality." Several formalisations of one informal claim are allowed
  and encouraged, to cover different readings (App. A.1).
- Test-based design "proactively reduces the risk of edge-case errors"; prover runs are
  "retroactive" and "capable of unearthing misformalizations across all categories" (all three
  levels).

### 2.3 Metadata and linters (§3.1–3.4) [R]

- `@[category …]`: `research open`, `research solved`, `textbook`, `API` (foundations for a new
  definition meant for reuse), `test` (sanity check).
- `@[AMS n]` subject tags; `@[formal_proof]` links a statement to its proof, either a commit on top
  of `main`, another Lean 4 project, or another proof system. A linter warns when it is used on a
  `research open` statement.
- Custom linters built on Mathlib's framework enforce AMS tags, `answer(sorry)` use, categories
  and module docstrings.
- `answer(sorry)` separates "find the value" from "prove it". It also stops Lean from changing
  the meaning of a question depending on the answer given (elaboration order) (App. A.2).

### 2.4 The misformalisation taxonomy (§3.3, App. A.4–A.5) [R]

Three levels, ordered by how much the formaliser is to blame and, for a Lean expert without
domain knowledge, by how hard they are to fix:

| Level | Meaning | Types | Fixed cases |
| --- | --- | --- | --- |
| 1 Translation | informal text accurate and explicit; the Lean is wrong | syntactic (parsing, brackets) | 9 (3.1%) |
| | | semantic (how Lean represents types/operators: `ℕ` truncated subtraction, `0`, `Partition` using `sup`) | 103 (35.4%) |
| | | misrepresentation (wrong quantifier/connective, missing hypothesis, variable scoped outside an `∃`) | 140 (48.1%) |
| 2 Underspecified | informal text accurate but leaves things implicit | implicit conventions (e.g. "for large N", "subgraph" meaning induced subgraph) | 23 (7.9%) |
| 3 Source | informal text not as intended | reporting (changed by repetition, typos) | 15 (5.2%) |
| | | mathematical (genuine error in source) | 1 (0.3%) |

Total 291 fixed misformalisations. About 87% are level 1 [R, from the table].

### 2.5 The "for Mathlib" staging pattern (App. A.3) [R]

`FormalConjecturesForMathlib/` (88 files) holds definitions and lemmas not yet in Mathlib, sent
upstream "asynchronously". Why not contribute directly:

1. A long dependency chain: "the missing results must undergo Mathlib review, the merged change
   must land in a monthly Mathlib release, and the Formal Conjectures repository must be upgraded
   to that release".
2. Some results are too specialised for Mathlib; contributing them would force immediate
   generalisation.
3. A whole new development needs time to find the right abstractions; doing that outside Mathlib
   is faster.

The pattern goes back to the `for_mathlib` directory of the Liquid Tensor Experiment.

### 2.6 Versioning (§4.1, App. B.1) [R]

- Release tags `bench-vN-lean4.X.Y`: the bench number fixes the problem set, the suffix pins the
  Mathlib tag and Lean toolchain. "dependency updates can alter statement semantics, and new
  Mathlib theorems may simplify problems."
- Frozen subsets (`FC100OpenSet1.lean`, …) import exactly their statements and compile in every
  release, so they keep compiling across Lean versions.
- Releases come "every few months". Snapshots are immutable: "misformalization fixes are never
  patched into existing versions but incorporated into the next" bench version. Results are cited
  as set plus tag, e.g. `FC100SolvedSet1@bench-v1-lean4.27.0`.
- A Lean-only bump (same bench number, new `lean4.X.Y` suffix) is promised to keep the same
  statements; only the compilation target changes.
- The discussion stresses that a statement is cited by **file name and commit hash**, "ensuring
  fixed and verifiable mathematical intent".
- Planned (App. C.1) [S]: literature references "are currently handled inconsistently across the
  repository, often requiring duplication in each file. We plan to improve this by centralizing
  reference management".

### 2.7 The repository has moved on since the paper [R, repo at `2055e5a` and `11ba193`]

At `11ba193` (11 May 2026) there was no `STATEMENTS.md`, `CONTRIBUTING.md` had no ban on `opaque`
or placeholder definitions (it already said "Bespoke definitions are allowed … add basic API
tests for them"), and `answer(sorry)` was still the documented mechanism. So the points below are
newer than the paper.

- `AGENTS.md` now says: state the unknown of a value question as a definition
  `<theorem>.answer := sorry`, and tag questions `@[question]` / `@[question value]`. This
  replaces the inline `answer(sorry)` of the paper.
- `STATEMENTS.md`: "Never add an `axiom`, `opaque`, or `constant` declaration anywhere in the
  repository." `AGENTS.md`: "Do not add placeholder definitions, incomplete types…", and
  `FormalConjecturesForMathlib/` "must not contain `sorry`". `CONTRIBUTING.md`: "Do not introduce
  placeholder definitions (e.g. `def foo : Type := sorry` or `opaque foo : Type*`) … All
  referenced definitions must exist".
- `STATEMENTS.md` is a short review checklist: quantifier order and scope, strict vs non-strict
  bounds, hypotheses, direction of implications, "every variant and special case", the smallest
  value of each parameter, and "For each hypothesis, ask whether any object can satisfy it. An
  impossible hypothesis makes an implication vacuously true."
- `AGENTS.md` asks for "simple, concise technical English. Prefer short sentences, common words,
  and one instruction or claim per sentence", for code and for PRs and reviews. Review notes go in
  the PR, "not in Lean comments".

## 3. What it means for GLCinLean

1. **Pin the statement with independent special cases** (ideas: "Link to the existing
   literature"; workflow step 2, the blueprint) [J].
   - The cheapest check of `main` is a separately stated, known case. For a torus `T`, GLC is
     the Fourier–Mukai / Laumon–Rothstein-type equivalence between D-modules on `Bun_T` and
     quasi-coherent sheaves on `LocSys_Ť`; the `GL_1` case is geometric class field theory
     [J, standard knowledge; not checked against GLC I in this session].
   - Stating `main` specialised to `T` is useless as a test: it follows by substitution. What
     helps is a theorem that `LG` for a torus *agrees with* an independently defined
     Fourier–Mukai functor, or that the categories of the `Setting` reduce to known ones
     (for example `IndCoh_Nilp = QCoh` when `Nilp` is the zero section).
   - Other candidates an expert should choose from: compatibility with Eisenstein series or
     constant terms, the Hecke eigen-property, the `G = 1` / point case [J].
2. **Every new definition comes with proven test lemmas** (ideas 2 "code quality", "Set
   standards, and meet them"; step 3 Build) [J].
   - Examples of the shape: D-modules on a point are vector spaces; `QCoh(Spec A)` is `A`-modules;
     `Bun_G` for `G` trivial is a point; `LocSys` for `GL_1` on a genus-0 curve [J].
   - This is the main tool the paper gives that does not need a domain expert, so it fits an
     owner who cannot check the mathematics.
   - Caveat: in Formal Conjectures many tests close by `decide` [R]. For GLC objects each test
     above is itself a real formalisation (for example `QCoh(Spec A) ≃ A-Mod` in the
     ∞-categorical setting), so tests cost much more and must be planned in the blueprint, not
     added as an afterthought [J].
3. **Placeholders block test-based design** (workflow question on `Abstract.lean`, step 2) [J].
   - An `@[placeholder] opaque` has no properties beyond being inhabited, so no test lemma about
     it can be proved, and nothing that depends on what it *is* can be proved or disproved. The
     placeholder design is honest (AGENTS.md: it does not make the statement say less), but it
     gives no evidence of meaning for the placeholder parts.
   - The non-placeholder parts can still be audited now: the `Setting` hypotheses, the shape of
     `IsLanglandsFunctor`, and `exists_dualGroup` [J].
   - So evidence that the placeholder parts mean what they should can only start once each
     placeholder is replaced by a real definition. The plan should say that replacing a placeholder means replacing it **together
     with its tests**.
4. **AI proof attempts as an audit** (step 4 Review) [J].
   - If a prover closes `main`, `exists_isLanglandsFunctor` or a test case unexpectedly fast,
     the statement is likely vacuous or wrong. With opaque placeholders a proof of `main` could
     only come from the non-placeholder structure, so any proof at all would be a red flag; with
     real definitions the audit covers the whole statement. A periodic "try to prove /
     disprove" run with whatever prover is available is a cheap check.
   - The `STATEMENTS.md` question "can any object satisfy this hypothesis?" applies directly to
     `Setting` and to the hypothesis block of `IsLanglandsFunctor`.
5. **Classify every review finding by level** (step 4 Review; the review system) [J].
   - Level 1 (Lean-level) findings are within reach of fresh agents. Level 2 (implicit
     conventions) is where GLC is most at risk: renormalisation (`IndCoh_Nilp`), the half-twist in
     `DmodHalf`, derived vs classical stacks, choices of t-structure, characteristic 0, the
     curve being smooth proper connected. Level 3 (an error in GLC I itself) is unlikely but
     needs an expert [J].
   - In Formal Conjectures 87% of fixes were level 1 [R]; their sources are short problem
     statements, so the share for a 1000-page proof is unknown [E].
   - The paper sends findings back to the informal source (erdosproblems.com) [R]. For GLC this
     would mean reporting any gap found in GLC I to its authors; whether and how is the owner's
     choice [J].
   - A tag for the level would let the review system (ideas: the review system) show not only
     "reviewed / unreviewed" but what kind of error was found.
6. **Tags like `@[category test]` / `API`** (the review system's input "documented in Mathlib's
   style") [J]. A category tag on each declaration would let the review page separate the
   statement surface, its tests and the backbone library, which matches the owner's two patterns
   (library vs single long statement).
7. **The staging costs bear on the order Mathlib → Tau Ceti → own repository** (ideas 3–4;
   workflow decisions on Tau Ceti and keeping up) [J].
   - Each Tau Ceti contribution has the same chain: review, merge, then a pin bump here. Writing
     here first and sending upstream later is faster, which is what the owner already plans for
     parts no roadmap covers.
   - The third cost (new developments need time to find their shape) argues for keeping the
     geometric-representation-theory backbone here until its design settles, before proposing a
     Tau Ceti roadmap.
   - The decision "keeping up is fully automated" removes most of the third step of the chain
     (upgrading to the release).
8. **Pin statements by commit, and re-check after upgrades** (ideas "Stay up to date"; step 5
   Refactor) [J]. The paper's remark that dependency updates "can alter statement semantics"
   supports the owner's review-status idea (a declaration reviewed at a commit becomes unreviewed
   when it changes). It suggests also flagging a statement when a *dependency* it uses changes,
   not only its own text.
9. **AGENTS.md style** (workflow question on `AGENTS.md`) [J]. Formal Conjectures' `AGENTS.md` is
   short, points to `CONTRIBUTING.md` and two task guides, and asks for plain, short English. That
   is close to the owner's decision for `AGENTS.md` and is a working example to compare against
   Anthropic's guidance (`anthropic-guidance.md`).

## 4. Conflicts

- **Opaque placeholders.** Formal Conjectures forbids `axiom`, `opaque`, `constant` and
  placeholder definitions [R, repo]; GLCinLean's `AGENTS.md` recommends `@[placeholder] opaque`
  and `@[placeholder]` appears 6 times in `Abstract.lean` and 10 times in `Foundations.lean`
  [R, grep of the files]. The purposes differ: they want every
  statement complete now; GLCinLean wants a readable statement before the library exists [J].
  Still, a statement with placeholders is not a statement of GLC, and Mathlib or Tau Ceti would
  likely not accept them either [J]. Tau Ceti forbids `sorry` and axioms beyond the standard
  three (see `tauceti-contributing.md`); an `opaque` is not itself an axiom, so the axiom check
  alone would not catch it, but the `sorry`-ed statements around it would be rejected [J].
- **Who reviews.** The paper treats mandatory review by humans with domain knowledge as the
  basis, with AI as help [R]. Step 4 of the workflow gives review to "fresh agents", and the
  open question lists "fresh agents, an outside expert" as options [R]; the current `PLAN.md`
  already says "no claim of faithfulness is made without an outside expert" [R].
  This paper supports `PLAN.md` on that point [J].
- **Direct contribution vs staging.** The example `/goal` prompt in `ideas.md` writes the
  preliminaries "in the Tau Ceti repository" directly and forbids stacked PRs [R]. The paper's
  cost list says that path makes the dependent work wait for review and release [R]. Not a hard
  conflict: the owner's idea 4 already stages parts with no roadmap here [J].
- **Paper vs its own repository.** `answer(sorry)` (paper) has become `<theorem>.answer := sorry`
  plus `@[question]` (repo, Nov 2026) [R]. Cite the repository files, not the paper, for current
  rules.
- No conflict with the owner's principles from the Xena post; test-based design is one way to
  meet "Set standards, and meet them" and "Link to the existing literature" [J].

## 5. Input for the open questions

- **What goes into `AGENTS.md`.** Their `AGENTS.md` is a good model: about 100 lines, plain
  English, links to task guides (`STATEMENTS.md`, `PROOFS.md`), a short pre-review checklist.
  It suggests keeping review checks in a separate guide that the review prompt loads, not in
  `AGENTS.md` [J].
- **`Abstract.lean`, `Foundations.lean` and placeholders.** Keep the opaque placeholders only as
  a temporary surface, list them, and require that each replacement brings proven test lemmas;
  add separately stated special cases (torus) to the statement surface so the statement is
  pinned from two sides [J].
- **What happens to existing files.** The `@[placeholder]` attribute from ReviewKit plays the role
  of a category tag; a general `@[category]`-style attribute (statement, test, API, backbone)
  could replace it in the new review system [J]. `reviews/statement-pin.toml` matches their
  "cite by file and commit" idea [J]. On `references/papers/manifest.toml` (ideas 5: the owner
  sees no point in it): the paper calls scattered, duplicated references a weakness and plans to
  centralise them [S]. That is a mild argument for one central list of sources with pinned
  versions, in whatever form; it does not require this particular file [J].
- **Who reviews the mathematics, and to what standard.** Their experience: Lean-level errors are
  the majority and an AI reviewer with a checklist (like `STATEMENTS.md`) catches many; implicit
  conventions and source errors need domain experts. Suggest fresh agents for level 1 with a
  checklist, AI proof/disproof runs, and an outside expert for levels 2–3 before any claim of
  faithfulness [J].
- **Where research notes and summaries live.** They keep review notes out of Lean files and in
  PRs [R]. Suggests review findings live outside the Lean sources (PRs, issues or the review
  system), tagged with the misformalisation level [J].
- `PLAN.md` and "update the next prompt": the paper says nothing about these.

## 6. Questions for the owner

1. Should every new definition be required to come with proven test lemmas (as in Formal
   Conjectures), and should the review system show them under their own tag?
2. Should the statement surface include separately stated special cases of GLC (for example the
   torus case) that pin `main` down? Which cases to state needs an expert's choice.
3. Should review findings be classified by the three-level taxonomy (translation /
   underspecified / source)?
4. Formal Conjectures requires a human reviewer with domain knowledge for every contribution. Is
   an outside expert part of the standard for the GLC statement, or only for a final claim of
   faithfulness?
5. Should AI provers be run against the statement and its tests as an audit, with any
   unexpectedly easy proof treated as a sign of misformalisation?

## Not reached

- Nothing was unreachable. The arXiv HTML page was not used; the TeX source was read instead.
