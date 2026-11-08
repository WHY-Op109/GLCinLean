# Annals Challenge

- **Source:** ImperialCollegeLondon/AnnalsChallenge, release v1.0.0, commit
  [`e32eb14`](https://github.com/ImperialCollegeLondon/AnnalsChallenge/tree/e32eb1411db0d700ca874dd695aea92f78699db8)
  (the only commit; message "Release v1.0.0, Source-commit: e90d50b…", so the working history is
  in a private repository). Licence Apache-2.0.
- **Also read:**
  - the paper: T. Browning, K. Hristova, D. Ledvinka, J. Springer, H. L. Su, J. McKoen, K. Buzzard,
    *A dataset of formalised theorem statements from the Annals of Mathematics*,
    [arXiv 2610.18301 v1](https://arxiv.org/abs/2610.18301v1) (NeurIPS 2026 AI-MATH workshop). I
    read the TeX source, `main.tex`.
  - the announcement: K. Buzzard, [*The Annals Challenge*](https://xenaproject.wordpress.com/2026/08/13/the-annals-challenge/),
    Xena blog, 2026-08-13.
  - the benchmark that hosts it: [leanprover/lean-eval @ `85a88c3`](https://github.com/leanprover/lean-eval/tree/85a88c37f80170d9f08651dc63ce6b81a8a48cb9)
    (Apache-2.0): its README, `docs/catalog-metadata.md`, the hole examples and the Annals manifests.
  - the checker: [leanprover/comparator @ `865edc1`](https://github.com/leanprover/comparator/tree/865edc14486c3388e9225daa971da8e157488c3e), README.
  - an experience report: R. Kirov, [*The Jacobian Challenge Retro*](https://rkirov.github.io/posts/jacobian/), 2026-06-22.
- **Checked 2026-11-08.** Clone in `.lake/research/AnnalsChallenge/`; paper source in
  `.lake/research/annals-paper/` (neither is tracked by Git).
- **Could not reach:** the Lean Zulip threads (`#Autoformalization > Jacobian challenge`, the
  LeanEval thread). The fetch tool refused arXiv and renaissancephilanthropy.org,
  so I used `curl`. The funder's page holds only a short blurb.
- **Searched, nothing further found (2026-11-08):** a web search for talks, Zulip summaries or
  other write-ups on how the project judges a correct statement found only the paper's arXiv
  listing and unrelated threads. The paper, the README and the blog are the only primary sources
  on the method.

Tags: [R] read directly, [S] a source's claim about itself, [E] estimate, [J] judgement. All
checked 2026-11-08.

## 1. What it is

- 50 Lean 4 + Mathlib statements of the main theorems of 50 *Annals of Mathematics* papers,
  volumes 191–203 (2020 to mid-2026). The proofs are left as `sorry`, and proving them is the
  challenge. [R, README and paper]
- Who: Kevin Buzzard (grant PI, mostly code review) and four Imperial postdocs (Browning, Hristova,
  Ledvinka, Springer), with two interns. Funded by Renaissance Philanthropy's AI for Math Fund.
  Written by hand over ten months. [R paper; S blog]
- Where it is used: on [LeanEval](https://lean-lang.org/eval/), tag `annals`, since 2026-08-17. On
  2 October 2026, accepted proofs existed for 40 of the 50 (Axiom Prover 40, others 20–34).
  [R paper §5; R lean-eval manifests, 50 `annals_*` files]
- Size: 53 Lean files, 4,487 lines (the root import file `AnnalsChallenge.lean` included), 95
  `theorem`/`lemma` and about 300 definition-like declarations (my grep counts 296). One file per
  paper (50), named `AnnalsOfMathematics/<year>-<volume>-<issue>-<Title>.lean`, plus one shared
  file `Definitions/AlgebraicJacobian.lean` and a `Notation.lean`. [R, counted 2026-11-08]

## 2. What it says that matters for GLCinLean

### 2.1 Design principles (paper §2, quoted) [R]

> **Trust.** We use Mathlib whenever possible, where definitions have been reviewed by the
> community. When we introduce local definitions, they are carefully reviewed by humans and AI.
> **Faithfulness.** The formalised statement should be as close as possible to the informal source.
> **Correctness.** When the informal statement has gaps or is incorrect, we correct the statement
> to match the author's presumed intent. When the intended statement was unclear, we asked the
> authors of the paper.

- They also "preserved the generality of the original papers and followed their naming conventions
  and notation". [R §2.3]
- Where new definitions were needed, "we either added them to Mathlib in the course of the project
  or, in the rare cases where a definition was paper-specific and of no broader interest, we
  developed it locally". [R §2.3] Mathlib is the only dependency. [R `lakefile.toml`]

### 2.2 No numeric metric; the standard is a review procedure

The project has **no score for a correct statement**. A statement counts as correct when it
survives this procedure: [R paper §2.4–2.5, App. A]

1. **Triage.** Every paper gets a difficulty from 1 to 5 for *stating* (not proving) its main theorem
   with today's Mathlib. Level 1 means all definitions are in Mathlib; level 5 means the statement
   "relies on definitions which would be a major research project to formalise". Formalised: 36 of
   40 at level 1, 11 of 37 at level 2, 3 of 56 at level 3, none of the 74 at levels 4–5.
2. **Hand formalisation**, easiest first, aiming for broad coverage.
3. **Manual in-depth review** by the team itself: "Our team included mathematicians with expertise
   across a range of fields and prior experience with Lean formalisation." It checks for
   "incorrect edge cases, inconsistencies with the paper, missing hypotheses, or errors in our
   interpretation of the paper". The reviewers are the formalisers (plus Bhavik Mehta, Heather
   Macbeth and Mathias Stout, thanked for "help with formalising and reviewing"). The paper does
   not describe an independent review by a specialist in each paper's field. [R §2.3,
   Acknowledgements]
4. **Author consultation** when the paper's statement had gaps: the authors confirm that the added
   hypotheses change neither the meaning nor the correctness of their result. 12 authors are
   thanked.
5. **AI audit**, run after the human review: three passes per file (Claude Fable 5 Max Effort, then
   GPT 5.6 Sol Ultra, then Claude Fable 5 again). The prompt is in App. A. Humans reviewed every
   finding and fixed all issues before release.

What the AI audit found [S, the paper reporting its own results]:

- 32 of 50 papers: no issue of mathematical significance.
- 7 of 50: missing (mostly trivial) assumptions *in the paper* that made the theorem false.
- **11 of 50: mistakes in the team's own formalisation**, after the team's own manual review.
- The three counts add up to 50, so each paper is in exactly one group. [R §2.4]
- The human review found slips in papers too: App. B lists 10 slips in 9 papers, and says two of
  them (the λ_SSS "least"/"greatest" typo in *Algebraic integers*, measurability in *Fractal
  uncertainty*) were "caught during human review". [R App. B]
- "Since release, no further misformalisations have been found." [S] The repository has no
  issues or pull requests at all. [R, `gh api …/issues`]
- For comparison, the paper cites FormalConjectures: 3,604 statements and 511 merged
  misformalisation fixes by 2 October 2026. [S]

The AI-audit prompt asks for the following (wording kept where it matters) [R App. A]:

- the sorried results "should be equivalent to the corresponding statements in the paper, and as
  faithful to the statement in the paper as is reasonably possible";
- look for "subtle errors in the theorem statement (including any definitions that they rely on)";
- "run tests by checking special cases of definitions, or by proving or disproving special cases
  of the theorems";
- do not prove the main sorry, but a quick proof or disproof is welcome, since it "indicat[es] a
  misformalization";
- "Please do not ask any questions … make commits to the <BRANCH NAME> branch directly. Humans will
  review the suggestions afterwards. Do not push anything!"

A further, external check: once a statement is public on LeanEval, a proof that turns out
surprisingly easy is evidence of a misformalisation. [J, following the prompt's own logic]

### 2.3 How a file records faithfulness [R, Lean files]

- Module docstring: the paper's title, authors, journal, volume, issue and year.
- Theorems are named after the paper's numbering (`theorem_1_1`, `theorem_1_2_1_a`). In 48 of the
  50 paper files a docstring opens with "Statement of Theorem X.Y:" (or similar) and then gives the
  informal statement. That text is not always the paper's verbatim wording: in
  `vanDerWaerdenConjecture` the quoted statement already carries the corrected "for `n ≥ 3`",
  followed by "The degree restriction is necessary: the theorem is false as stated for `n = 2`."
- The README's rule is "Such deviations are documented in the corresponding file." There is no
  fixed `Note:` format: deviations appear as a sentence in the docstring (often "Note: …" or
  "Note that …", in 24 files), as an inline comment on a binder, or as a remark after the quoted
  statement. Examples:
  - `LargeValueEstimates`: the binder carries the comment "these assumptions are necessary but not
    stated in the paper";
  - `FractalUncertainty`: "We require `X` and `Y` to be measurable";
  - `DuffinSchaeffer`: "In the paper, `ℕ` denotes the positive integers, which are denoted `ℕ+`".
- App. B of the paper lists all 10 slips in the published theorems, each with its reason (for
  example `n ≥ 3` in van der Waerden, `A` nonempty in Marton). [R]

### 2.4 Three ways to handle a missing object [R, Lean files]

This is the part closest to GLCinLean's placeholder problem.

1. **Build it, with proofs, aiming at Mathlib.** `MotivicInvariants.lean` has a `section Mathlib`
   that defines `Scheme.BirationalMap` with its group structure and proved lemmas. This code is
   meant to go upstream. The blog says the team "built many new definitions and got them merged
   into mathlib". [R file; S blog]
2. **A "def hole" with characterising theorems.** `Definitions/AlgebraicJacobian.lean` (Christian
   Merten's algebraic version of Buzzard's Jacobian challenge) does this:
   - `genus`, `Jacobian`, the group-scheme instance and the Abel–Jacobi map `ofCurve` are
     `def … := sorry`, each marked `-- data`;
   - the properties that pin them down are sorried theorems and instances: smooth of relative
     dimension `genus C`, proper, geometrically irreducible, geometrically integral,
     `comp_ofCurve`, and the universal property `exists_unique_ofCurve_comp` ("`Jacobian C` is the
     Albanese variety of `C`");
   - the file also contains a sorried instance `Group.FG` for the `k`-points when `k` is a number
     field, which is the Mordell–Weil theorem. So a characterising file can contain deep theorems
     the solver must also prove, not only defining properties.

   `UniformMordellLang.lean` states Theorem 1.1 on top of these and says the Jacobian is not
   defined, only characterised by a file "whose sorries must be filled". On LeanEval the problem
   has **13 holes**: the 11 declarations of the Jacobian file (including `instFG`), the constant
   `c` and `theorem_1_1`. Whoever solves it must supply the Jacobian *and* prove its universal
   property. That is why a cheap stand-in cannot work. [R manifest
   `annals_uniform_mordell_lang.toml`] The manifest's notes add that LeanEval's separate port of
   the Jacobian file (`jacobian_challenge_alggeo`) "omits the four declarations at its end",
   so this problem carries its own full copy. [R]
   The docstring also names a known gap: "the characterization … is only correct when `C` has an
   `F`-point, but Theorem 1.1 is trivial when `C` has no `F`-points".
3. **An existential constant as a def hole.** `def c (g d : ℕ) : ℕ := sorry` (Mordell–Lang) and
   `def k₀ : ℕ := sorry` (Erdős). The solver supplies the witness. A faithfulness gap the tools
   cannot enforce is written down: "`k₀` should be 'effectively computable' … Unfortunately, this is
   not currently enforceable in Comparator. Note that prohibiting `noncomputable` is not
   sufficient." [R]

Buzzard's analytic Jacobian challenge (on LeanEval as `jacobian_challenge_diffgeo`) adds
`genus_eq_zero_iff_homeo` with the comment "this proof avoids the hack answer `∀ X, genus X = 0`".
and `ofCurve_inj` with "this is the lemma which stops the hack answer 'J(X)=0 for all X'".
[R lean-eval `LeanEval/Geometry/JacobianChallenge.lean`, 179 lines] Unlike the algebraic file,
the analytic file has **no universal property**: no `∃!` statement, only the group and manifold
structure, `ofCurve_self`, `ofCurve_inj`, pushforward and pullback with functoriality, and
`pushforward_pullback` (multiplication by the degree). [R] Kirov, who solved it, writes that
Buzzard attached "'universal' properties … (universal in quotes, because I don't think they're
rigorously universal in the category theory sense)", and that the challenge "was also a test of
whether the theorems listed are good enough to pin the formalization down". [R retro; his
judgement is S] A further report that Buzzard himself flagged the sorries as not pinning the
Jacobian down comes from a solver's README seen only in search results. [S; I did not read the
Zulip thread]

### 2.5 Machinery around the statements [R]

- **Comparator** checks three things: that a `Solution` proves "the same statement as provided in
  `Challenge`", that it uses only the axioms listed in the config's `permitted_axioms` (the
  README's examples list `propext`, `Quot.sound`, `Classical.choice`), and that the Lean kernel
  accepts it (optionally nanoda as well). It "has
  been merged into core as of Lean release v4.35.0 in the form of `lake comparator` and the
  accompanying `lake check`". [R comparator README]
- **LeanEval manifests** (one TOML per problem) hold `statement_revision`, a positive integer that
  "never decreases", and a `source` line. A *later* statement revision appends a
  `[[revision_history]]` row whose `statement_digest` is a sha256 of "the trusted statement
  representation"; history is append-only. [R `docs/catalog-metadata.md`] All 50 `annals_*`
  manifests are at `statement_revision = 1` with no `[[revision_history]]` row, so none carries a
  digest yet; all 50 `source` lines are pinned to "v1.0.0, e32eb14". [R, all 50 manifests at
  `85a88c3`]
- **LeanEval now pins Tau Ceti:** "This requires lean-eval to pin exactly the Lean toolchain and
  Mathlib revision of the pinned Tau Ceti commit, which the script checks." [R lean-eval README]
- **AnnalsChallenge build settings:**
  - Lean `v4.33.0-rc1`; Mathlib `d1ddae4` on `master`;
  - `autoImplicit = false`, `weak.linter.mathlibStandardSet = true`, `warn.sorry = false`;
  - CI is `leanprover/lean-action` with `lint: true` and `mk_all-check: true`;
  - `scripts/nolints.json` lists 24 exceptions, all `defsWithUnderscore`.
- **Versioning:** "(batch number).(breaking fix).(non-breaking fix, including mathlib bumps)".
- **Contributions:** "We are not accepting external contributions that add new formalised
  statements." Errors are reported as issues.

### 2.6 What the authors say about statements like GLC [R paper §3; blog]

- "theorems about symplectic geometry, Riemannian geometry, Kähler geometry, Lie theory,
  intersection theory, **infinity categories, moduli stacks, automorphic representations** … are
  often essentially impossible to even state right now." [R §3]
- Future work: "relying on definitions from Tau Ceti, an AI-managed library. Every definition would
  still need careful review, or the dataset would lose its trustworthiness." [R §6.2]
- Buzzard: "if it takes thousands of lines of Lean code before we can even state the theorem then
  the human is going to have to read that too, which is equally miserable and furthermore can only
  be done by the small subset of mathematicians who have learnt Lean." [R blog] His examples of
  such statements are "the Fukaya category associated to a symplectic manifold" and "cuspidal
  automorphic representations for a connected reductive group". [R blog]
- Buzzard's own role: "my work was mostly limited to code review and understanding the material".
  [R blog]
- Kirov's retro (one person using Claude Code, about 45k lines, solution accepted 2026-06-11) [S]:
  - early on, asked to "remove the sorries", the AI "turned them into uninstantiated type-classes —
    which of course solves nothing" ("progress-theater");
  - his most common steering comment was "did you follow the literature";
  - the agents struggled to keep a consistent view of the project beyond about 10k lines;
  - `.md` plans "drifted out of sync with the actual code".

## 3. What it means for GLCinLean

- **GLC is a level-5 statement on their scale.** [J] It needs ∞-categories, moduli stacks
  (`Bun_G`, `LS_Ǧ`), D-modules and IndCoh, which the paper names as "essentially impossible to even
  state right now". The Annals team formalised nothing above level 3. So the project offers **no
  direct precedent** for stating GLC. What carries over is its review standard and its file
  conventions. (Workflow step 2, plan; ideas.md item 1, "a library, not a one-off".)
- **Their route to a hard statement is the owner's route.** [J] Add the missing definitions to
  Mathlib first, and keep paper-specific definitions local. This matches ideas.md item 3 (Mathlib,
  then Tau Ceti) and item 4 (contribute upstream what a roadmap covers). The paper itself points to
  Tau Ceti as the next step, but adds that every definition still needs careful review.
- **Statement file conventions to adopt** (step 2 and step 3, the statement surface; ideas.md
  "Link to the existing literature") [J]:
  - the module docstring cites GLC I by arXiv id and version;
  - the theorem is named after the paper's numbering (for example `conjecture_1_6_7`);
  - its docstring gives the informal statement in the paper's words;
  - every deviation (a changed hypothesis, a convention, a gap the tools cannot enforce) is written
    in the docstring with its reason. Annals has no fixed marker for this; a fixed `Note:` prefix
    would be GLCinLean's own refinement, and makes deviations easy to list by grep.
  - quote the paper verbatim and put any correction after it. Annals sometimes edits the quoted
    statement itself (van der Waerden), which hides from a reader what the paper said.

  `GLCinLean/Abstract.lean` already does part of this: its module docstring cites "arXiv
  2405.03599v3 Conj. 1.6.7" and the main theorem's docstring opens "**GLC I Conj. 1.6.7**", but the
  theorem is called `main`. [R, 2026-11-08] The rebuild can make it a rule in `AGENTS.md`.
- **Placeholders: opaque versus def hole.** [J]
  - GLCinLean's placeholders carry no properties. Some are `@[placeholder] opaque` (`QCohLS`,
    `IndCohNilp`, `DmodHalf`, `Psi`, …); `DGCat` and `LinFun` are `@[placeholder] def`s over an
    opaque `NonemptyType`. [R `Abstract.lean`, `Foundations.lean`] A later "real" definition can be anything with the right type, so faithfulness
    rests entirely on review.
  - The Jacobian file shows the alternative: sorried characterising properties (a universal property
    or a representability statement), so that any replacement must satisfy them.
  - GLCinLean already does this in places: `exists_isLanglandsFunctor` and
    `isLanglandsFunctor_unique` characterise `LG`. The same could be done for objects that have a
    universal property, for example `LS_Ǧ` as the stack representing local systems.
  - The "hack answer" test helps here too. For each placeholder, ask whether a trivial choice (the
    zero category, the empty type) would make the main theorem easy. If it would, a characterising
    property is needed. This fits the existing AGENTS.md note on placeholders.
  - The analytic Jacobian is a warning: its list of sorried properties still did not amount to a
    universal property, and its solver was unsure it pinned
    the object down. Characterising properties need their own completeness review. [J, from R/S
    in §2.4]
  - The `Group.FG` instance shows that a characterising file can also smuggle in deep theorems.
    For GLCinLean that would raise the sorry budget with results that are not part of GLC. [J]
- **Rule out progress-theater.** [J] Kirov's agent replaced sorries with uninstantiated type
  classes. That is the same failure as a placeholder with a trivial witness. An `AGENTS.md` rule
  could say: replacing a placeholder must not weaken what the statement says. (Step 1, contents of
  `AGENTS.md`.)
- **AI audits are worth running and catch real errors.** [J, from S data] Three audit passes found
  mistakes in 22% (11/50) of statements that the team, Lean-literate mathematicians, had already
  reviewed by hand. For GLCinLean,
  whose owner cannot check the mathematics, the Review step (step 4) should use several
  fresh-agent audit passes, ideally from different model families. The audit prompt in App. A
  adapts almost word for word:
  - "equivalent to … as faithful as reasonably possible";
  - test special cases of the definitions;
  - try to prove or disprove special cases;
  - commit findings to a branch for review.
- **Pinning and checking.** [J]
  - LeanEval's `statement_revision` and `statement_digest` are the same idea as
    `reviews/statement-pin.toml`. They show the idea works with a plain TOML file, which matches
    ideas.md ("work in a very simple way"). LeanEval does check the file in CI
    (`scripts/validate_catalog.py`, append-only against the CI base), so "no harness" would be too
    strong: a small validator is still needed.
  - For the proof phase (step 6), `lake comparator` / `lake check` (in Lean core since v4.35.0)
    checks a proof against a fixed statement with a fixed list of axioms. The review-system
    repository could reuse it rather than build its own.
- **Tau Ceti pin automation.** [R / J] LeanEval had to pin exactly the toolchain and Mathlib of
  its Tau Ceti commit. GLCinLean meets the same constraint in the automated keep-up decision.
- **Papers.** [J] The citation lives in Lean docstrings (title, authors, volume, theorem number).
  LeanEval adds a `source` line pinned to version and commit. This supports the owner's doubt about
  `references/papers/manifest.toml` (ideas.md item 5): the arXiv id and version in the docstring may
  be enough.

## 4. Conflicts

- **Who reviews: expert humans versus fresh agents.** [J] The Annals standard puts an in-depth
  review by the team's Lean-literate mathematicians *first* and the AI audit *second*, with humans judging every AI
  finding and the paper's authors consulted on gaps. GLCinLean's plan (workflow step 4, "fresh
  agents check changed declarations") has no expert human, because the owner cannot check the
  mathematics. On the Annals evidence, agents alone are a weaker standard than the one the Annals
  team applied to much easier statements. Their own outlook says the same: "Every definition would
  still need careful review". Note also that the Annals human layer was the formalisers reviewing
  their own work: Lean-literate mathematicians, not necessarily specialists in each paper's field,
  with the paper's authors consulted only on gaps. "Expert review" in the Annals sense is that,
  not an independent referee. [R §2.3; J]
- **Public review versus a closed project.** [R / J] ideas.md asks to "review additions publicly".
  AnnalsChallenge was reviewed internally and released as one squashed commit; its history is in a
  private repository and it accepts no outside statements. It is a model for the *standard* of
  review, not for *open* review.
- **The audit prompt says "Do not push anything!"** [R] The workflow decision is "Agents push
  themselves". The two fit together only if an audit's findings go to a branch and something (a
  human or a further agent) accepts them before they reach `main`.
- **The placeholder note in `AGENTS.md`.** [J] The note prefers `opaque` and warns against
  definitions with trivial witnesses. AnnalsChallenge uses `def … := sorry` holes, which are
  filled by a solver rather than refined by the project. Both agree that a placeholder must not
  make the statement say less. They differ on the mechanism: Annals pins holes with characterising
  theorems, while GLCinLean mostly relies on opaqueness.
- **Small inconsistency inside the source.** [R] The blog says "around 20 percent" and counts
  "213 papers since 2020" besides "8 corrigenda/errata and two retractions". The paper counts 207
  papers in volumes 191–203 (retractions, errata and corrigenda excluded) and says 24.2%, "a
  quarter". The two may count different periods or items, so this is a rounding and counting
  difference, not a disagreement on method. [J]
- **The Jacobian characterisation.** [R / S] The analytic Jacobian challenge has no universal
  property (read), and its solver doubts its properties are "rigorously universal" (his claim);
  the algebraic version adds one. This is a warning that a characterisation must be checked for
  completeness too.

## 5. Input for the open questions

- **Who reviews the mathematics, and to what standard.** The source suggests a layered standard
  [J]:
  1. Several independent AI audit passes on every changed statement-surface declaration, using
     different model families. Each pass uses an adapted App. A prompt: faithfulness to the cited
     theorem, edge cases, special-case tests, attempted easy proofs or disproofs, findings committed
     to a branch.
  2. A "hack answer" check for every placeholder.
  3. An outside human expert for the final GLC statement and the backbone definitions it rests on:
     for example a Lean-literate geometric representation theorist.
     This mirrors the Annals team's author consultation.
  4. Each finding and its resolution recorded next to the declaration (`Note:` in the docstring).

  Reason: the paper's own data. The team's manual review still left errors in 22% of statements,
  while the human review, not the AI, caught 2 of the 10 slips in the papers, so either layer
  alone falls short. And the paper says definitions from an AI-managed library still need
  careful review.
- **`Abstract.lean`, `Foundations.lean` and the placeholder design.** Keep one readable statement
  file in the Annals style (citation, paper numbering, informal statement, `Note:` deviations).
  Review each placeholder: either give it characterising sorried properties, as the Jacobian file
  does, or justify in its docstring why none is needed. Buzzard's point about readability argues for
  keeping the statement surface short and the backbone in separate library files. [J]
- **What happens to each existing file.**
  - `reviews/statement-pin.toml` has a direct analogue in LeanEval's `statement_revision` and
    `statement_digest`, so a simple pin file is sound practice. [J]
  - `references/papers/manifest.toml`: Annals uses docstring citations instead (see §3). [J]
  - The ReviewKit `@[placeholder]` attribute: Annals marks holes only with a comment (`-- data`),
    and LeanEval with `@[eval_problem]` plus a manifest listing every hole. Either way, an explicit
    machine-readable list of holes is what lets a checker refuse a trivial fill. [R / J]
- **What goes into `AGENTS.md`.** Candidate rules drawn from this source [J]:
  - follow the paper, its generality and its notation;
  - record each deviation in the docstring;
  - never weaken a statement while removing a sorry or a placeholder ("progress-theater");
  - prefer Mathlib, then upstream, then local.
- **Where research notes and session summaries live.** Kirov reports that `.md` plans drifted from
  the code [S]. This argues for keeping facts about a declaration in its docstring, and keeping
  notes short and dated. [J]

## 6. Questions for the owner

1. **Outside expert.** Will you seek a human expert to review the final GLC
   statement and its key definitions, as the Annals team consulted paper authors? Or is a
   fresh-agent audit the accepted standard, knowing it is weaker than Annals'?
2. **Characterised placeholders.** Should placeholders get sorried characterising properties
   (Jacobian style)? This means more budgeted sorries, but a later replacement must then prove them.
   Or should they stay plain `opaque` with docstring justification?
3. **Audit models.** Which model families may the AI audits use? (Annals used both Claude and GPT
   passes.)
4. **Comparator.** Should the eventual proof be checked with `lake comparator` / `lake check`
   against a fixed `Challenge` statement? If so, step 2 should keep the statement in a form that
   can be split that way.
