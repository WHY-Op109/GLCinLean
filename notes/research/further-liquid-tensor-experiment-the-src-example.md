# Liquid Tensor Experiment: the `src/examples/` folder

- **Source:** leanprover-community/lean-liquid, `src/examples/`, at commit
  [`ee4795874a99ea5f9d85bd0b364425f07b932377`](https://github.com/leanprover-community/lean-liquid/tree/ee4795874a99ea5f9d85bd0b364425f07b932377/src/examples)
  (master, 2026-10-02). Read alongside `src/challenge.lean`, `src/challenge_notations.lean`,
  `src/challenge_prerequisites.lean`, `README.md` and `.github/workflows/build.yml` at the same commit.
- **Companion source:** the blog post "Definitions in the liquid tensor experiment" by Adam Topaz
  (2022-10-14), read from its Markdown source
  [`posts/lte-examples.md`](https://github.com/leanprover-community/blog/blob/cb846d50e9d124063945bbee416bedcc20b979ad/posts/lte-examples.md)
  (blog repo commit `cb846d50`), plus
  [`posts/lte-final.md`](https://github.com/leanprover-community/blog/blob/cb846d50e9d124063945bbee416bedcc20b979ad/posts/lte-final.md).
  The blog links lean-liquid at commit `92f188bd` (2022-10-14). Between that commit and `ee479587`
  no file in `src/examples/` or `src/challenge*.lean` changed; the six later commits touch CI,
  the README and three library files [R, `gh api compare`, 2026-11-08].
- **Checked 2026-11-08.**
- **Licence:** GitHub reports no licence for lean-liquid, and the clone has no `LICENSE` file
  [R, 2026-11-08]. GLCinLean takes the pattern only, not code, so this does not matter in practice;
  copying files would need permission.
- Local copies (Git-ignored): `.lake/research/lean-liquid/`, `.lake/research/lte-blog/`.

## 1. What it is

- The Liquid Tensor Experiment (LTE) formalised Clausen–Scholze's theorem
  `Ext^i(ℳ_{p'}(S), V) = 0` for `i ≥ 1` in Lean 3 and mathlib 3. It was completed on 2022-07-14
  [S `lte-final.md`]. The repo pins `lean:3.48.0` and a mathlib 3 commit (`leanpkg.toml`)
  [R, 2026-11-08]. Lean 3 is no longer maintained, so none of the code can be reused directly [J].
- `src/examples/` has five files [R, 2026-11-08]:

  | File | Lines | `example`s | Topic |
  |---|---|---|---|
  | `real.lean` | 43 | 4 | ℝ, ℝ≥0 |
  | `cond.lean` | 167 | 17 | continuous maps, profinite sets, the pro-étale topology, condensed abelian groups |
  | `pBanach.lean` | 123 | 17 | `p`-Banach spaces, their condensed abelian groups, `ℓ^p(ℕ)` |
  | `radon_measures.lean` | 151 | 14 | `ℳ_p(S)` and signed `p`-Radon measures |
  | `Ext.lean` | 174 | 12 + 1 theorem | `Ext`, `Ext'`, δ-functors, `Ext¹(ℤ/n, ℤ/n) ≅ ℤ/n` |

  No file contains `sorry` [R, grep, 2026-11-08].
- **Correction to how this source was described when it was found:** `challenge.lean` sits in
  `src/`, not in `src/examples/`. It holds the main theorem *and* a short proof (about 12 tactic
  lines that call the library), not only the statement [R, 2026-11-08]. Two helper files support
  the readable statement: `challenge_notations.lean` (notation `ℳ_{p'} S`, `Γ_`, the `Ext` alias,
  coercions marked "Notation hack for LTE examples") and `challenge_prerequisites.lean` (imports
  only) [R].
- **When and why:** the examples were written from 2022-07-18 to 2022-10-13, so *after* the proof
  was finished (the first commit, "start on examples folder with file on pBanach", came four days
  after completion). Most commits are by Adam Topaz. Johan Commelin wrote the first `real.lean`
  example (2022-07-19) and the `Ext¹(ℤ/n, ℤ/n)` computation (2022-07-20); the GitHub user `adomani`
  (profile name "damiano"; Damiano Testa, by my knowledge [J]) contributed in August [R, `gh api` commit history of `src/examples`, 2026-11-08].
  (An earlier version of this note said 2022-08-15; that was wrong.) The
  blog says the `Ext` file "was arguably the original motivation": "After the liquid tensor
  experiment was completed, we joked about the fact that we could have 'accidentily' defined `Ext`
  to always be zero!" [R `lte-examples.md`].

## 2. What it says that matters for GLCinLean

### 2.1 The stated purpose [R, 2026-11-08]

- README: `src/examples/` "contains Lean files that explain the main ingredients in the statement
  of the main theorem. These files should form convincing evidence that we did not make a mistake
  in formalizing the necessary definitions."
- Blog, the problem: "How can we convince ourselves (and others) that the *definitions* we
  introduced in LTE are actually *correct*? For instance, we could have *defined* `Ext` to be 0 …
  Or, we could have made some subtle innocent mistake … that somehow *implies* that `Ext` is always
  0, or that all condensed abelian groups are trivial."
- Blog, the answer: the files are "centralized 'sanity checks' that the definitions we wrote using
  Lean actually behave as expected", written to be "(approximately) readable by mathematicians who
  have minimal experience with Lean". The intended reading path: "look through the examples folder,
  then look through the concise final statement in `challenge.lean`, and be reasonably confident
  that the challenge was accomplished."
- Blog, the limit: "For those readers who are still skeptical … it's always possible to follow and
  unravel the definitions all the way down to the axioms." The examples add confidence; they do not
  prove that the formalisation is faithful.

### 2.2 The kinds of check used [R, the five files, 2026-11-08]

Each `example` comes after a `/-! … -/` comment in plain English that says what is being checked.
The checks fall into a few kinds:

1. **Unfolding by `rfl`**: the object is literally the expected thing.
   `Condensed.{0} Ab.{1} = Sheaf proetale_topology.{0} Ab.{1}`;
   `Γ_ S V = ulift.{1} C(S,V)`; the statement's `Ext` is `Ext'` on objects (`by { intros, refl }`).
2. **Equivalence with the textbook definition**: the sheaf condition for `proetale_topology` is
   equivalent to an explicit condition on finite jointly surjective families, written out line by
   line with a comment on each hypothesis (`cond.lean`).
3. **Both directions of a structure**: every object gives the expected data, and "Conversely" the
   expected data gives an object (profinite sets ↔ compact Hausdorff totally disconnected spaces;
   sheaves ↔ objects of `Condensed`; Radon functionals with a bound `c` ↔ elements of the `c`-th
   filtration).
4. **Characterisation up to unique isomorphism**: any conditionally complete linearly ordered field
   is isomorphic to ℝ, and the isomorphism is unique (`real.lean`). `Ext'(-, Y)` is a *universal*
   δ-functor (`theorem Ext_δ_functor_is_universal_for_Hom`).
5. **A small explicit computation**: `Ext'¹(ℤ/n, ℤ/n) ≅ ℤ/n` for `n ≠ 0`, which the blog (not the
   Lean file) calls "the very first exercise one might do when first learning about Ext groups".
   The blog says the universal-δ-functor theorem and this computation were the "two computations
   that were sufficiently convincing for us" [R `lte-examples.md`].
6. **Non-triviality and a concrete instance**: `ℓ^p(ℕ)` is a `p`-Banach space and is `nontrivial`.
   This guards against an empty or trivial class that would make the theorem vacuous.
7. **Honest notes on technical choices**: universe bumps (`ulift.{1}`), the *choice* of a `p`-norm
   ("This is really a *choice* that must be made"), and the comparison of their universe approach
   with pyknotic objects (blog section "A comment on universes").

The files are not only `example`s: they also hold a few local `def`s and instances that the
examples need (for instance `pBanach.has_norm`, the chosen norm, and `embedding_into_the_weak_dual`
in `radon_measures.lean`) [R].

### 2.3 How it fits around the statement [R, 2026-11-08]

- The examples import the same notation and prerequisites as `challenge.lean`, so a reader sees
  the objects exactly as they appear in the statement.
- The blog post (about 43 kB) walks through every file for a non-Lean reader, starting with how to
  read `def` and `example`. It is a second, prose layer on top of the Lean files.
- CI compiles all of `src` (`lean --json --make src`), so the examples are checked on every build.
  A separate job checks only that `liquid_tensor_experiment` is sorry-free, via
  `#print axioms` (`scripts/print_lte_axioms.lean`, `scripts/ensure_lte_sorry_free.py`).
- CI does **not** stop a `sorry` in the examples: `scripts/detect_errors.py` skips the
  "uses sorry" warning ("Using sorry should not cause the build to fail in this repository"), and
  the axiom check covers only the main theorem. That the examples are sorry-free is a fact at this
  commit, not something CI enforces [R, 2026-11-08].

### 2.4 What the examples cost [R for dates and line counts, J for the reading, 2026-11-08]

Some examples needed new library mathematics, written after the main proof was done:

- The universal δ-functor theory (`src/for_mathlib/universal_delta_functor/`, 570 lines today)
  was started on 2022-07-18, the same day as the examples folder; the blog says δ-functors were
  "still not part of mathlib" and their definition is in the LTE repository [R].
- The comparison of `ℳ_p(S)` with signed `p`-Radon measures (`src/Radon/`, 2,489 lines today) was
  developed *inside* `src/examples/Radon/` from late July to 2022-08-15 (dozens of "kill sorry"
  commits), then moved to `src/Radon/` [R, `gh api`]. `challenge_notations.lean` now imports
  `Radon.png` [R].
- `src/pBanach/lp.lean` (419 lines), which provides the `ℓ^p` instance used by the non-triviality
  example, dates from 2022-08-23 to 2022-08-31 [R].
- [J] So about 3,500 lines of supporting library and three months of work went into making the
  examples provable. Sanity checks that compare a definition with the textbook one are not a
  cheap add-on.

## 3. What it means for GLCinLean

1. **An examples layer for the statement's ingredients** (ideas.md §1, "Link to the existing
   literature. A mathematician should be able to trust and verify that the concepts … have the
   expected meaning"; AGENTS.md: the owner cannot check the maths). [J]
   One file per ingredient of Conj. 1.6.7, each with plain-English comments, is the most direct
   precedent for this principle. A likely split: the setting (curve, reductive group, `ω_X^{1/2}`,
   dual group), `Bun_G` and `Dmod_{1/2}(Bun_G)`, `LS_Ǧ` and `QCoh(LS_Ǧ)`, `IndCoh_Nilp(LS_Ǧ)` and
   `Ψ`, DG categories and linear functors (`Foundations.lean`), `𝕃_{G,coarse}` and `𝕃_G`.
2. **The GLC analogue of "Ext could be 0".** [J] `main` says `(LG S).IsEquivalence`. If
   `DmodHalf S` and `IndCohNilp S` were both zero categories, or if `DGCat` admitted only trivial
   objects, `main` would hold for a trivial reason. Examples should therefore include
   non-triviality (a non-zero object in each category) and at least one small computation.
   Candidates, all mathematical claims of mine that a reviewer must check against the papers [J]:
   D-modules on a point are vector spaces; `QCoh(Spec A)` is `A`-modules; for `G` trivial, `Bun_G`
   and `LS_Ǧ` are points and `𝕃_G` is an equivalence `Vect ≃ Vect`; for a torus, `Nilp` is the zero
   section, so `IndCoh_Nilp = QCoh`, and the statement reduces to geometric class field theory. The
   last two are the GLC version of "the very first exercise".
3. **Opaque placeholders cannot have examples.** [J] Every category and functor of the `𝕃_G`
   chain in `Abstract.lean` is an `@[placeholder] opaque` (`DmodHalf`, `QCohLS`, `IndCohNilp`,
   `Psi`, `LCoarse`), as is `RootDatumDuality` in the setting; the `DGCat`/`LinFun` layer in
   `Foundations.lean` is opaque too (`DGCat` is a `def` over an opaque `NonemptyType`). Only
   `IsLanglandsFunctor`, `LG` and `LinFun.IsEquivalence` are real definitions, built on top of
   these [R, 2026-11-08]. An opaque constant cannot be unfolded, so the only facts provable about
   it are those true of every value of its type; "this category has a non-zero object" or
   "`Dmod(pt) ≃ Vect`" cannot even be stated, let alone proved. Not one LTE-style example can be
   written today. This bears on step 2's
   decision on placeholders: the examples file for an ingredient works best as the acceptance test
   for replacing its placeholder. A real definition lands together with its examples, sorry-free.
4. **Write the examples with the definitions, not afterwards.** [J] LTE wrote them after the proof,
   prompted by a joke. ideas.md §1 says "Set standards, and meet them … 'clean it up later' is
   counterproductive", so GLCinLean should write them in step 3 (build), alongside each definition.
   The Formal Conjectures sources point the same way (test lemmas with each new definition; see
   `further-formal-conjectures-paper-firsching-et-al.md`). Budget for it (§2.4): in LTE some
   examples needed thousands of lines of new library code. For GLC, a check such as "for `G`
   trivial, `𝕃_G` is `Vect ≃ Vect`" needs the theory of D-modules and IndCoh on a point to be
   built first, so the examples belong in the blueprint (step 2) as planned items, not as an
   afterthought. [J]
5. **A readable layer for the owner and reviewers** (workflow step 4, "check changed declarations
   against the papers"). [J] A reviewer, agent or expert, can check a short examples file against
   GLC I much faster than the whole backbone. The blog post's two layers fit the owner's need: Lean
   files that the kernel checks, plus prose that maps each example to a sentence of the paper with
   its location (file and line in the TeX source, as `Abstract.lean` already does).
6. **Regression checks when Mathlib and Tau Ceti move** (workflow decision: keeping up is fully
   automated). [J] An `rfl` or characterisation example breaks if a bump changes what a definition
   means, and a refactor (step 5) has to keep it green. The examples become part of what an
   automated bump must pass, next to the statement pin.
7. **Notation for reading.** [J] LTE added notation and coercions only so that the statement and the
   examples look like the paper. GLCinLean could do the same in one notation file shared by
   `Abstract.lean` and the examples, in Mathlib's style (scoped notation).
8. **Axiom check of the main theorem.** [R LTE CI; J for GLCinLean] LTE's CI checks
   `#print axioms` on the final theorem, but lets `sorry` pass elsewhere, examples included (§2.3).
   For GLCinLean, the same check on the examples (no `sorryAx`, no extra axioms) can run from the
   start, long before `main` is proved, and closes the gap LTE left open.

## 4. Conflicts

- **Where sanity checks live.** Formal Conjectures' AGENTS.md puts sanity checks for a shared
  definition in the file that defines it, not in a separate test folder (per
  `further-formal-conjectures-google-deepmind-contr.md` §2.4). LTE centralises them in
  `src/examples/`. [J] The two can coexist: API and test lemmas next to each definition in the
  library (Mathlib style, the backbone), plus a central, reader-facing examples folder for the
  ingredients of the statement (the surface). The owner should choose explicitly.
- **Post hoc versus up front.** LTE's examples came after the proof (§1). This conflicts with
  ideas.md's "Set standards, and meet them", not with LTE's purpose. [J]
- **The description used when this source was found** said `challenge.lean` is in `src/examples/`
  and holds only the statement. Neither is right (§1) [R]. The point it made, that the statement
  file is short and separate, still holds.
- **The current placeholder design** (`Abstract.lean`, `Foundations.lean`) leaves no way to write
  examples (§3.3). This is not a contradiction of a decision in `workflow.md`, since whether the
  placeholders stay is still open, but it is a strong argument in that open question. [J]
- **Trust model.** LTE's examples convinced experts who could read the mathematics, and Scholze gave
  "continuous mathematical support" [S `lte-final.md`]. GLCinLean's owner cannot check the
  mathematics (AGENTS.md). Examples move the trust question to "do the examples say what the paper
  says?" but do not remove it. Someone who can read GLC I still has to check the list of examples.
  [J]
- No conflict with Mathlib's documentation style: LTE's examples carry module-doc comments in
  plain English, as ideas.md asks. [J]

## 5. Input for the open questions (`notes/workflow.md`)

- **What goes into `AGENTS.md`.** [J] One short rule is enough: "Each object in the GLC statement
  has an examples file showing that it behaves as the papers say (non-triviality, one small
  computation, a comparison with the textbook definition), sorry-free, with the paper location of
  each claim."
- **Whether `PLAN.md` is needed.** No direct bearing. The list of examples per ingredient could live
  in the blueprint (step 2) instead. [J]
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholders are reasonable.** [J] Keep the
  short statement file: it is LTE's `challenge.lean`, and the owner's abstract matches that pattern.
  Treat opaque placeholders as a temporary surface: each one is replaced only together with a
  sorry-free examples file. Plan an `Examples/` folder beside the abstract. A separate Lake library
  target would keep it out of the library's import graph.
- **What happens to each existing file.** [J] `reviews/statement-pin.toml` could also pin the
  statements of the examples. The examples are part of what the statement *means*, so a silent
  change to them should need the owner's sign-off, as the main statement does. `blueprint/plans`
  could list, for each ingredient, the examples it needs.
- **Who reviews the mathematics, and to what standard.** [J] The examples give a concrete, bounded
  standard: "the examples file for X is correct, complete enough, and matches GLC I §…". A fresh
  agent can check that each example's Lean statement matches its English comment. An outside expert
  is best spent on approving the *list* of examples per ingredient, the step that needs
  understanding of the mathematics. That is a far smaller task than reviewing the backbone.
- **Where research notes and session summaries live.** [J] The blog post shows the value of a
  committed, prose explainer of the statement for non-Lean readers. It could become a document in
  the repository (for example `docs/statement.md`), written once the definitions are real.

## 6. Questions for the owner

1. Should GLCinLean keep an examples layer next to `Abstract.lean`, with one file per ingredient of
   Conj. 1.6.7, and should it be a separate Lake target or part of the main library?
2. Should every placeholder be replaced only together with its sorry-free examples file (an
   acceptance test), and should a CI check (`#print axioms`) enforce that the examples use no
   `sorry`?
3. Should the statements of the examples be pinned and reviewed like the main statement, so that
   changing one needs your sign-off?
4. Who approves the list of examples for each ingredient: fresh agents only, or an outside expert
   who can read GLC I? This is the point where an expert adds the most trust for the least time.
5. Do you want a prose companion (like the LTE blog post) explaining the statement and the examples
   for readers without Lean, and when: at the end of the statement phase, or kept up as definitions
   land?

## Unreachable

- `https://leanprover-community.github.io/blog/posts/lte-examples/` and `/lte-final/`: the fetch tool
  refused them. I read the same posts from
  their Markdown source on GitHub instead (pinned above).
- The two Zulip screenshots embedded in the blog post (`/images/lte-ext-zulip-*.png`) were not viewed.
