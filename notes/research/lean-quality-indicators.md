# Lean Quality Indicators

- **Source:** `RemyDegenne/lean-quality-indicators`, "Sampled, LLM-judged quality indicators for
  Lean libraries" (repository description).
- **URL:** <https://github.com/RemyDegenne/lean-quality-indicators> @
  `09c11a92a869045066fc003517031e96534b5d89` (2026-11-06, the latest commit on `main` when checked).
- **Checked 2026-11-08.** Cloned into `.lake/research/lean-quality-indicators/` (Git ignores it).
  Read: `README.md`, `RUNNING.md` (first 200 of 574 lines), `AUDIT_METHODS.md`,
  `AUDIT_APPENDIX.md`, `AUDIT_RESULTS.md` (all judges, all audits), the whitepaper
  `reports/formalization-quality-whitepaper.md`, the prompts and configs of `indicators/unnecessary-hypotheses`, `indicators/duplicates-mathlib-inclusive`
  and `indicators/definition-fidelity`, `audits/file-quality-v1/{README,common}.md` and three of
  its six rubrics (vacuity, generality, concept reinvention), the head of `libraries.toml`, the
  cost table `runs/main/api-equivalent-costs.md`, the static-metric reports
  (`runs/def-unfolds-2026-11-02/library-comparison.md`, `runs/compression-2026-11-03/results.md`),
  the Opus test-retest page, the Opus `definition-fidelity` report of `runs/defs1`, and parts
  of `scripts/{judge,fetch,leanscan,fetch_cfsg}.py`. The tens of thousands of per-target result files under `runs/` were not read.
- **Licence:** Apache 2.0 (added 2026-11-06 in `09c11a9`). This matters: the prompts can be copied
  into the review system's repository, with a provenance header and the licence notice.
- **Also read for this note**, because they say who uses the metric and how:
  - the Tau Ceti blog post "Simple quality indicators for Lean libraries" (Kim Morrison and Remy
    Degenne, 2026-10-28, edited 2026-11-05), source file
    `TauCetiProject/TauCeti:web/Site/Blog/QualityIndicators.lean` @ `83b84968573c` (the file's
    last change, "docs(blog): add AxiomMath Stacks quality audit results (#28088)", by Kim
    Morrison, 2026-11-05; the first version is `9638264d83ac`, PR #22389, also hers; both read
    through `gh api` on 2026-11-08, and the file text read in a clone of Tau Ceti `d2083f0f`,
    unchanged since); published at
    <https://taucetiproject.org/blog/2026-10-28-simple-quality-indicators-for-lean-libraries/>;
  - `TauCetiProject/TauCetiReview` `README.md` and `rubrics/README.md` @ `abb44392` (for the
    comparison only; the Tau Ceti Review note covers it in full);
  - `facebookresearch/atlas-lean:scripts/QUALITY_EVAL.md` @ `18d1aa39` (first 40 lines), an
    outside project that runs these indicators on its own library. Its title is "Tau Ceti
    quality indicator evaluation" [R], so at least one outside user treats them as Tau Ceti's
    [J].

Tags: [R] read directly in the source on 2026-11-08; [S] a source's claim about itself; [E]
estimate; [J] judgement. A tag covers the sentence or bullet it ends.

---

## 1. What it is

- A research repository that **measures** the quality of whole Lean libraries by sampling
  theorems, definitions or files and asking an LLM judge one narrow question about each. It
  reports, per library, the share of sampled targets the judge flags, with a Wilson 95% interval.
  [R]
- It compares Mathlib, Tau Ceti, Lean Pool, Anthropic's FLT, the 43 Formal Frontier libraries,
  OpenAI Math and AxiomMath's CFSG, each pinned to a commit. [R]
- It is a measurement, not a review process: it gives no verdict on a pull request, keeps no
  per-declaration review status, and says it measures "nothing about the importance, difficulty
  or coverage of a formalization". [R]
- It is a large harness: 85 files under `scripts/` (71 Python scripts, 14 systemd units), plus
  about 76,000 files of samples and verdicts under `runs/`. The core pipeline uses only the
  Python standard library. [R]
- **Authorship.** The repository is under Rémy Degenne's account, but 187 of its 198 commits are
  by Kim Morrison (`git log`, 2026-11-08); the systemd units set `PATH=/home/kim/...`. Degenne
  wrote the other 11, among them the first two (2026-10-20: `unnecessary-hypotheses` and
  `duplicates-mathlib`), the `definition-fidelity` indicator (2026-10-20) and the licence
  (2026-11-06). [R] The subscription runs use "only the `lean-fro` OAuth credential"
  (`RUNNING.md`) [R], which suggests the judging was paid through the Lean FRO's subscription
  [J].

## 2. What it says that matters for GLCinLean

### The indicators (what is measured)

Theorem indicators (one sampled `theorem`/`lemma` at a time) [R]:

- **`unnecessary-hypotheses`**: a hypothesis (a binder, or one taken from `variable`) "can be
  deleted, leaving a statement that is still true and provable, possibly with a different proof".
  Redundant typeclass instances count; weakening a hypothesis does not. The prompt asks the judge
  to check degenerate cases and Mathlib's junk values before flagging.
- **`duplicates-mathlib`** / **`duplicates-mathlib-inclusive`**: the theorem is already in
  Mathlib, Batteries or Lean core, as the same statement up to presentation (`duplicate`) or as an
  instantiation "provable from it in one or two short lines" (`special_case`). Generic principles
  (`Eq.subst`, `map_add`, ext lemmas) applied to the library's own definitions do not count. The
  inclusive version is also applied to Mathlib itself.

Definition indicator [R]:

- **`definition-fidelity`**: the definition does not faithfully formalise the object its
  docstring describes: `incorrect` (it defines something else) or `too_narrow` (the right object
  in less than its natural generality). A definition without a docstring is flagged
  `no_docstring` by rule, without a judge. Definitions judged "technical devices with no
  mathematical counterpart" are left out of the rate.

File audits (one whole file against one rubric, at most five findings, each quoting the file)
[R]:

- **`statement-generality`** (a useful more general statement exists),
  **`vacuity-and-misstatement`** (a result is vacuous or misses its documented purpose),
  **`repeated-proof-machinery`** (nontrivial reasoning repeated in two proofs),
  **`readable-proof-simplification`**.
- Two more, **`concept-reinvention`** (a competing version of a Mathlib concept) and
  **`simp-interface`**, are "not ready for use": a hand review of flags "found permitted wrappers
  and deliberate representations flagged". [R]

Static measures, no LLM [R]:

- **Explicit unfoldings**: how often each definition is unfolded (`unfold`, `simp [f]`, `rw [f]`,
  `f.eq_def`) outside its file. A source backend, checked against Lean's own name resolution from
  `.ilean` files for Mathlib and Tau Ceti.
- **Compression ratio** (zstd) and the share of code lines repeated verbatim in another file.

### How it is computed and run

- **Sampling.** `scripts/leanscan.py` is "a syntactic scanner that assumes top-level commands
  start at column 0. It does not need the library to be built." Eligible theorems are `theorem`
  and `lemma`; eligible definitions are `def`, `abbrev`, `structure`, `class`, `irreducible_def`
  (`DEFINITION_KW`). `opaque` and `axiom` are recognised as declarations but are not eligible.
  Deprecated and `private` declarations are skipped. [R]
- **Judge protocol.** "One fresh session per target and audit, with no memory of other targets
  or of earlier verdicts"; read-only Read, Grep and Glob over the library, Mathlib, Batteries and
  Lean core; "No Lean, shell, web access or writing"; the answer follows a JSON schema and is
  validated; file-audit quotes and line ranges are checked against the sources. [R] The Claude
  runner calls `claude -p ... --tools Read,Grep,Glob --permission-mode dontAsk --safe-mode
  --restricted --no-session-persistence --system-prompt-file <prompt.md> --json-schema ...`
  (`scripts/judge.py`, lines 140–147). [R]
- **Provenance.** Each judge run records model, effort, CLI version and hashes of prompt, schema,
  corpus lock and runner (`judge.json`), "so that verdicts from different protocols are never
  mixed". Failed calls are retried and "never count as negative verdicts". [R]
- **What is committed.** "Raw transcripts and operational logs stay local; prompts, snapshots and
  judgments can be versioned." [R]
- **Running it on a new library**: add it to `libraries.toml`, `python3 scripts/fetch.py --deps`,
  `sample.py --run NAME --n N --seed S`, `judge.py --run NAME --jobs 8`, `report.py`. Needs
  Python ≥ 3.11, git, a logged-in Claude Code ("no API key needed with a subscription"; "tested
  with 2.1.304") or Codex CLI. Nothing is built. [R] `judge.py --export` writes the system
  prompt, schema and one message per target, so any agent can be the judge. [R]
- **Dependencies the judge can read.** `fetch.py --deps` clones only Mathlib and Batteries
  (`DEPS = ("mathlib", "batteries")`). The CFSG corpus, which depends on Tau Ceti, uses its own
  fetcher (`fetch_cfsg.py`) that clones all pinned packages. [R]

### Checks of the judges, and their limits

- Opus test-retest on `unnecessary-hypotheses`: overall κ = 0.92 on 1,500 theorems; Tau Ceti
  14/15 flags re-flagged, κ = 0.96. [R] Opus/Sonnet flag correlation 0.86 on 1,600 shared targets,
  but "model independence is less established for the other measures". [R]
- An adversarial verifier "confirmed every claim it was shown, so it is not used as a filter".
  [R]
- `definition-fidelity` has a sensitivity test and a **mutation test**: definitions judged
  faithful are made wrong by "a one-line, type-preserving change, keeping their docstrings", mixed
  with unchanged controls, to see whether the judge notices. [R]
- Limitations stated by the source: "A flag is the judge's claim. Flags were checked by hand only
  on small samples, and no proposed change was compiled in Lean." [R] The exact rates depend on
  the model ("more expensive models report more issues"), but "the groups and relative gaps are
  consistent across models" (blog). [S]

### Results that bear on the order of sources

All Opus 5.5 high unless marked; flagged / sampled, rate. [R]

| Measure | Mathlib | Tau Ceti | Stacks (AxiomMath) |
|---|---:|---:|---:|
| Unnecessary hypotheses (Opus) | 31/1,000 · 3.1% | 68/1,000 · 6.8% | 103/1,000 · 10.3% (blog only) |
| Unnecessary hypotheses (Sonnet) | 6/300 · 2.0% | 12/300 · 4.0% | — |
| Already in Mathlib (Opus, first prompt, Mathlib not judged) | — | 50/1,000 · 5.0% | 64/1,000 · 6.4% (blog only) |
| Already in Mathlib, inclusive prompt (Sonnet) | 263/1,000 · 26.3% | 35/1,000 · 3.5% | — |
| Already in Mathlib, inclusive prompt (Sol) | 689/1,000 · 68.9% | 142/1,000 · 14.2% | — |
| Repeated proof machinery (Sonnet, files) | 60/372 · 16.1% | 64/372 · 17.2% | 118/372 · 31.7% (blog only) |
| Definition fidelity (Opus) | 10/1,000 · 1.0% | 11/1,000 · 1.1% | — |
| Definitions unfolded outside their file (Lean backend) | 17.4% | 2.0% | — |
| Code lines repeated in another file | 3.8% | 10.5% | — |

- **Mathlib does not lead on every measure.** [R] for the numbers above, from
  `AUDIT_RESULTS.md` and the static reports:
  - On the inclusive duplicate question, every judge that ran it on Mathlib flags Mathlib far
    more often than Tau Ceti (Sonnet 26.3% against 3.5%, Sol 68.9% against 14.2%, Luna 59.6%
    against 15.0%). For Mathlib the question is whether a theorem follows in one or two lines
    from another Mathlib declaration, which Mathlib's API style (many small special-case lemmas)
    produces on purpose [J]. The blog and the whitepaper leave Mathlib out of their duplicate
    tables, so their "Mathlib leads" covers only unnecessary hypotheses and repeated machinery.
    [R]
  - Tau Ceti unfolds its definitions outside their file about eight times less often than
    Mathlib (2.0% against 17.4%, Lean's own name resolution). The source counts this but does
    not say which direction is better. [R] Fewer explicit unfoldings usually means a better API
    around each definition [J].
  - In the 10-file pilot of the file audits, Sonnet flagged 6/10 Mathlib files and 3/10 Tau
    Ceti files for `statement-generality`, and 3/10 against 0/10 for
    `vacuity-and-misstatement`. [R] With ten files these intervals overlap widely and say
    little [J].
  - The whitepaper's own wording is "Mathlib is the clear leader on the measures studied",
    meaning its three headline measures. [R]
- The Stacks rows come only from the blog post's 2026-11-05 edit; the repository at `09c11a9`
  lists seven corpora, not Stacks, and has no Stacks run that I found. [R] Stacks is clearly
  behind Tau Ceti on unnecessary hypotheses (10.3% [8.6, 12.3] against 6.8% [5.4, 8.5]) and
  repeated machinery (31.7% [27.2, 36.6] against 17.2% [13.7, 21.4]); on duplicates the
  intervals overlap (6.4% [5.0, 8.1] against 5.0% [3.8, 6.5]), so that gap is not established.
  [R] (intervals as printed in the blog)
- FLT's definition-fidelity rate is 1000/1000, all from the rule-based `no_docstring` flag:
  the run report lists 1,000 `no_docstring`, 0 `incorrect`, 0 `too_narrow`, judge cost $0.00.
  [R]
- Of Tau Ceti's 11 definition-fidelity flags, 10 are `too_narrow` (the right object in less
  than its natural generality) and 1 is `incorrect`. [R] (`runs/defs1/.../report.md`)

### Costs

API-equivalent cost per 1,000 judgments (`runs/main/api-equivalent-costs.md`) [R]:
unnecessary hypotheses, Opus $74.49, Sonnet $38.80; duplicates, Opus $54.36, Sonnet $26.17;
definition fidelity, Opus $67.23; file audits, Opus $214–336, Sonnet $86–136 per 1,000 files.
These are what the tokens would cost at API rates, "whether or not a subscription paid for them".
[R]

### Relation to Tau Ceti Review

- **Shared ground.** Both use LLM agents with one narrow rubric each, a shared common preamble,
  evidence from the sources, and several models. The questions overlap: Tau Ceti Review's
  `reuse` ("Does it reuse Mathlib / TauCeti instead of reinventing?") against
  `duplicates-mathlib` and `concept-reinvention`; `generality` ("Weakest assumptions; natural
  level?") against `unnecessary-hypotheses` and `statement-generality`; `correctness` against
  `definition-fidelity` and `vacuity-and-misstatement`; `proof-quality` against the two proof
  audits. [R] (both rubric lists) [J] (the pairing)
- **Differences.** Tau Ceti Review gates single pull requests after green CI, posts `approve` /
  `request_changes` / `block` verdicts, and lets only integrity angles block. [R] The indicators
  run after the fact on random samples of a pinned snapshot and produce one rate per library; the
  judge cannot run Lean and never edits. [R] The indicators check duplication against Mathlib,
  Batteries and core only, while Tau Ceti Review's `reuse` also checks against Tau Ceti. [R]
- **No direct link found.** The Tau Ceti Review README does not mention the indicators, and the
  indicators' documents do not mention Tau Ceti Review. [R] The connection is through people and
  venue: the blog post introducing the indicators is published on Tau Ceti's website and says
  Tau Ceti and Formal Frontier "are actively trying to take the lessons learned in Mathlib to
  guide the AI formalization process, and our takeaway from the results is that those efforts,
  while not perfect, are paying off". [R]

## 3. What it means for GLCinLean

1. **"Code quality as high as possible" (ideas.md, formalisation point 2) gets a yardstick.**
   These are the only published, reproducible numbers I found that put Mathlib's quality bar into
   rates. A target such as "GLCinLean's flag rates no worse than Tau Ceti's, aiming at Mathlib's"
   becomes checkable. [J]
2. **The order Mathlib → Tau Ceti → Stacks (ideas.md, point 3) is consistent with the headline
   numbers, not with every number.** On the three headline measures Mathlib leads; Tau Ceti is
   close on repeated machinery and definition fidelity but about twice Mathlib on unnecessary
   hypotheses; Stacks (blog only) is clearly behind Tau Ceti on two measures and level within
   the intervals on the third. [R] for the numbers, [J] for the reading. Tau Ceti does better
   than Mathlib on explicit unfoldings and on the inclusive duplicate question, and worse on
   verbatim repeated lines (10.5% against 3.8%). [R] So the order is a sound default but not a
   ranking on every axis. Code taken from Tau Ceti should still be checked for removable
   hypotheses and for definitions stated less generally than they could be, the places where
   it lags Mathlib. [J]
3. **For the review system (its own repository), these prompts are a ready, licensed starting
   point.** The six reliable prompts are short, precise, and say what does not count; they are
   Apache 2.0. A per-declaration review in the new review system could reuse
   `unnecessary-hypotheses`, `duplicates-mathlib-inclusive`, `definition-fidelity` and the file
   rubric `vacuity-and-misstatement` as review angles. [J]
4. **The judge protocol fits workflow step 4 ("Fresh agents check changed declarations").** One
   fresh session per declaration, read-only tools, a JSON schema, quotes checked against the
   sources, and a record of model and prompt hash per verdict. The last point fits the owner's
   wish to track the commit at which a declaration was reviewed: a verdict would carry both the
   declaration's commit and the rubric's hash. [J]
5. **What it does not give the review system.** No per-declaration status, no dependency graph,
   no "reviewed / re-review needed" tracking, no web page. Those must come from tracker,
   NumLib-Auto or new code. The indicators are a periodic library audit beside the review, not
   the review itself. [J]
6. **For GLCinLean as it is now, the rates would mean little.** The two files have 4 theorems
   (all in `Abstract.lean`), 16 eligible definitions (`def`/`structure`/`class`, attributes
   allowed) and 15 `opaque` declarations, which the scanner does not sample ([R], `grep` at
   column 0 on `GLCinLean/*.lean`, 2026-11-08). With 0 flags out of 4, the Wilson 95% interval
   is [0%, 49%]. [E] The indicators become useful as a measurement once
   the library has hundreds of declarations; before that, the same prompts can be run on every
   declaration as a review rather than a sample. [J]
7. **The placeholder design is invisible to the indicators.** `opaque` is not an eligible
   definition, so the `@[placeholder] opaque` objects of `Abstract.lean` and `Foundations.lean`
   would never be sampled. [R] The `@[placeholder] def DGCat : Type := DGCatPt.type` wrappers
   would be sampled, and a fidelity judge would most likely class them as technical devices or
   flag them as incorrect against their docstrings. [J] This is a reason to keep placeholders
   clearly marked and counted separately in any review page, as the indicators do with
   certificates and deprecated declarations. [J]
8. **The duplication check must include Tau Ceti for this project.** ideas.md makes Tau Ceti the
   second source, so "already in Tau Ceti" is a defect here too. The indicator only checks
   Mathlib, Batteries and core, and its fetcher only clones those two dependencies. [R] Running it
   here needs Tau Ceti added to the readable sources and to the duplicate criteria. [J]
9. **The "no Lean" limitation is a choice made for cost at scale, not a principle.** The
   whitepaper says it "is necessary for cheaply auditing the large libraries". [R] For a small
   repository's per-declaration review, letting a second agent compile the proposed change would
   remove the main stated weakness ("no proposed change was compiled"). [J]
10. **Reviewer calibration.** The mutation test (make a faithful definition wrong in one line and
    see if the judge notices) is a cheap way to test GLCinLean's own reviewers of the statement,
    which matters because the owner cannot check the mathematics (AGENTS.md). [J]
11. **Committing research and review output.** The repository commits prompts, samples, verdicts
    and reports, and keeps raw transcripts and logs local. [R] That is a working precedent for
    where notes and summaries live (open question 6). [J]
12. **Running it is feasible but not "simple".** The pipeline needs only Python and a logged-in
    Claude Code, and `atlas-lean` already runs it on its own library from "an external pinned
    checkout" without vendoring it. [R] But the whole harness (rate guards, systemd monitors,
    dashboards) is the kind of system ideas.md wants to avoid in this repository. Using the
    prompts with fresh subagents, or the external pinned checkout, keeps the repository simple.
    [J]
13. **Compare against a control, not against the blog's numbers.** `atlas-lean` runs the same
    indicators on "the exact Mathlib version Atlas pins" as a control arm, reports "per root,
    never as one composite Atlas quality score", and says "The article's historical
    percentages are context, not a controlled comparison with this run". [R] If GLCinLean ever
    adopts a target such as "Tau Ceti's rates or better", the comparison should be run with the
    same judge and prompt on Mathlib and Tau Ceti at GLCinLean's pins, since rates depend on the
    model. [J]

## 4. Conflicts

- **ideas.md: "Kim Morrison uses this metric".** Supported, and an understatement: Kim Morrison
  wrote 187 of the 198 commits, co-signed the blog post that introduced the metric, and herself
  committed both versions of that post to Tau Ceti (PRs #22389 and #28088); Rémy Degenne started
  it and owns the repository. [R] I found no source saying that Kim Morrison uses it to gate or
  steer Tau Ceti work: the Tau Ceti Review clone (`abb4439`) never mentions it, and its commits
  since 2026-10-20 show no change attributed to it. It is a measurement she runs and publishes.
  [R] (absence in what I read) [J]
- **The blog and whitepaper against the full results.** Their "Mathlib leads" holds for the
  three headline measures; the repository's other results (inclusive duplicates, explicit
  unfoldings, the small file pilot) put Tau Ceti ahead of Mathlib on some axes. [R] A summary
  that cites "Mathlib is best on these indicators" should say which indicators. [J]
- **ideas.md: "quite like Tau Ceti Review".** Partly. The rubric questions overlap a lot, but the
  purpose differs: Tau Ceti Review decides on one pull request; the indicators estimate rates for
  a whole library from a sample. Neither cites the other. [R] [J]
- **ideas.md: "without any complex system or harness".** The repository is a large harness. Its
  prompts fit the owner's way of working; its machinery does not. [J]
- **ideas.md's review-system design (per-declaration status by commit) and this source.** Not a
  contradiction but a gap: the indicators have no notion of a declaration's review status over
  time; each run is a fresh snapshot. [R]
- **Within the source.** The blog says the indicators "do not measure anything about the quality
  of definitions, for a start", while the repository has had `definition-fidelity` (1,000
  definitions per library, Opus) since 2026-10-20, before the post. [R] The blog has Stacks
  results that the repository at `09c11a9` does not contain, so those cannot be reproduced from
  the repository. [R]
- **Between corpora and dependencies.** `unnecessary-hypotheses` "reads Mathlib master at the
  commit pinned for the corpus" (one Mathlib for all libraries); the other indicators and the
  file audits read the Mathlib and Batteries each library pins, "so that a lemma added to
  Mathlib later does not count". [R] For GLCinLean, which follows a Tau Ceti pin,
  the pinned version is the right one; a lemma added to Mathlib later would otherwise count
  against the project. [J]
- **With workflow.md decisions.** None found. The decisions "Tau Ceti contributions fully
  automated" and "keeping up with Mathlib automated" are untouched by this source. [J]

## 5. Input for the open questions

- **What goes into `AGENTS.md`.** One line could name the quality bar in measurable terms: no
  removable hypotheses, no duplicates of Mathlib or Tau Ceti, definitions that match their
  docstring at their natural generality, no repeated proof machinery. These are the indicators'
  questions and they match Tau Ceti Review's angles. The prompts themselves belong in the review
  system, not in `AGENTS.md`. [J]
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.** The
  indicators exclude `opaque`, and the `@[placeholder] def X := XPt.type` wrappers would confuse
  a fidelity judge. If the pattern stays, the review system should list placeholders as their own
  class rather than review them as definitions. [J] Running `vacuity-and-misstatement` on
  `Abstract.lean` would also test whether the statement as written is vacuous, which is the risk
  AGENTS.md names for axioms and trivial witnesses. [J]
- **What happens to existing files (`reviews/`, the ReviewKit requirement).** Nothing in this
  source replaces `reviews/statement-pin.toml` or `reviews/sorry-budget.toml`; it measures a
  different thing. If ReviewKit is rewritten on tracker, the indicator prompts can be the review
  angles. [J]
- **Who reviews the mathematics, and to what standard.** This source suggests that fresh agents
  with narrow single-question prompts are consistent with themselves (κ = 0.92) and, on the best
  studied question, with each other (0.86); an adversarial second agent agreed with everything,
  so it adds little; and some rubrics (concept reinvention, simp interface) over-flag. [R] So:
  fresh agents can carry the routine standard (hypotheses, duplication, generality), with several
  models; whether the GLC definitions mean what the papers mean is the part the source has least
  evidence for, since fidelity is judged against the docstring, not the paper. That part points
  to an outside expert at least for the statement's surface. [J]
- **Where research notes and session summaries live.** The source commits prompts, inputs,
  verdicts and reports, and keeps transcripts and logs out of Git. [R] The same split would suit
  `notes/research/`. [J]

## 6. Questions for the owner

1. Should GLCinLean adopt these indicators as its measurable quality bar (for example "Tau Ceti's
   rates or better"), run as a periodic audit once the library is large enough to sample?
2. Should the new review system take its review angles from these Apache-2.0 prompts (adapted to
   check duplicates against Tau Ceti as well as Mathlib), or from Tau Ceti Review's rubrics, or
   both?
3. May review agents run Lean to check proposed changes (more reliable, slower), or should they
   stay read-only as in this source?
4. Is reviewing the GLC definitions against their docstrings by agents enough, or do you want an
   outside expert to check that the docstrings, and the definitions, match the papers?
