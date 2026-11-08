# Outside mathematical review: how comparable projects get it, and what it would take here

- **What this note is.** A cross-source note, not a note on one reference. It closes a gap: almost
  every other note recommends "an outside expert" for the GLC statement and the backbone
  definitions, but none says how such a review is obtained. Nobody was contacted for this note.
- **Sources read for this note** (all checked 2026-11-08):
  1. V. Ilin, B. Nugent, *Sorries Are Not the Hard Part: An Expert-Review Case Study of a
     Semi-Autonomous Formalization*, [arXiv 2606.13925 v1](https://arxiv.org/abs/2606.13925v1)
     (11 June 2026, ICML 2026). CC BY 4.0. TeX source `main.tex` read in full, in
     `.lake/research/sorries-expert-review/` (ignored by Git).
  2. T. Browning et al., *A dataset of formalised theorem statements from the Annals of
     Mathematics*, [arXiv 2610.18301 v1](https://arxiv.org/abs/2610.18301v1): §2 (methodology,
     manual review, AI audit), §5 (outlook), Acknowledgements, App. B. Read in
     `.lake/research/annals-paper/x/main.tex`.
  3. google-deepmind/formal-conjectures at
     [`2055e5a`](https://github.com/google-deepmind/formal-conjectures/tree/2055e5adadae0b2e392365938faa82ef6f1464f0):
     `README.md` (trust paragraph), `STATEMENTS.md` (opening), `CONTRIBUTING.md` ("Code reviews"),
     `.github/ISSUE_TEMPLATE/misformlization_report.md`. Through `gh api`: its label list, counts of
     `misformalization` and `ai-audit` items, and the reviews and inline comments on PR
     [#28](https://github.com/google-deepmind/formal-conjectures/pull/28) (its only merged PR
     labelled `ams-14: Algebraic geometry`). Apache-2.0 code, CC-BY 4.0 other material.
  4. TauCetiProject/TauCetiRoadmap at
     [`7bf4638c`](https://github.com/TauCetiProject/TauCetiRoadmap/tree/7bf4638c3b94bcd25137be0d5ec4310f93bc8a00):
     `CONTRIBUTING.md`, lines 1–130 (authors' guidance, "Reviewing a roadmap"). PR counts through
     `gh api` search.
  5. TauCetiProject/TauCeti at
     [`d2083f0f`](https://github.com/TauCetiProject/TauCeti/tree/d2083f0f1dd2136d02467ba36efbbe1af612e89c):
     `README.md` (who reviews what).
  6. ImperialCollegeLondon/FLT at
     [`a321020`](https://github.com/ImperialCollegeLondon/FLT/tree/a3210204ad8876e851e32f73dd97d882bf1ccd0a)
     (2026-10-22): `README.md`, `GENERAL.md`, `CONTRIBUTING.md`, `FermatsLastTheorem.lean`,
     `FLT/Assumptions/KnownIn1980s.lean`, `blog.md`. Apache-2.0. Copies in `.lake/research/FLT/`.
  7. P. Scholze, *Half a year of the Liquid Tensor Experiment: Amazing developments*, guest post,
     [Xena blog, 2021-06-05](https://xenaproject.wordpress.com/2021/06/05/half-a-year-of-the-liquid-tensor-experiment-amazing-developments/),
     read in full (fetched with curl; the page has no version pin). Also the LTE blog posts
     `lte-final.md` and `lte-examples.md` from the community blog at `cb846d50` (local copies in
     `.lake/research/lte-blog/`; see `further-liquid-tensor-experiment-the-src-example.md`).
  8. Mathlib community website (source repo
     [leanprover-community.github.io](https://github.com/leanprover-community/leanprover-community.github.io),
     head `3ad7ec4`, 2026-11-06): [How to contribute](https://leanprover-community.github.io/contribute/index.html),
     section "Use of AI" (`templates/contribute/index.md`, last changed at `dd3758e`, 2026-08-19),
     and the [Mathlib reviewers](https://leanprover-community.github.io/teams/reviewers.html) page,
     both read live.
  9. The Lean Zulip public archive index, <https://leanprover-community.github.io/archive/>
     ("Last updated: Feb 28 2026"), and one archived thread, `#maths > A thought on Langlands etc.`
  10. leanprover/comparator `README.md` at
      [`865edc1`](https://github.com/leanprover/comparator/tree/865edc14486c3388e9225daa971da8e157488c3e).
  11. GLCinLean's own `PLAN.md`, `GLCinLean/Abstract.lean`, `GLCinLean/Foundations.lean`, and the
      other notes in `notes/research/` that recommend an expert (cited by file name).
- **Could not reach:**
  - the live list of Lean Zulip channels. The API needs a login ("Not logged in: API
    authentication or user session required"), and the public archive is from February 2026 and
    lists only the 96 web-public channels. So the Tau Ceti channel (`#Tau Ceti`, id 610393,
    linked from Tau Ceti's CONTRIBUTING) and its topic "Getting started: roadmaps" were not read.
  - the Hugging Face dataset with the two expert reviews from source 1
    (`uw-math-ai/grothendieck-vanishing-logs`). Not opened, so the wording of those reviews is
    known only from the paper.
  - Scholze's original LTE challenge post (2020-12-05). Not read.
  - Whether any GLC I author is active on the Lean Zulip or in any Lean project. Not checked, and
    not guessed below.
- **Tags:** [R] read directly on 2026-11-08; [S] a source's claim about itself; [E] estimate;
  [J] judgement. "[R, other note]" marks a fact another note in `notes/research/` read, which I
  did not re-read.

## 1. What it is

Five patterns for getting human mathematical review of formal statements and definitions, taken
from the projects the task names:

| Pattern | Who reviews | Example |
|---|---|---|
| A. The team's own Lean-literate mathematicians | the formalisers, then narrow questions to the paper's authors | Annals Challenge |
| B. A domain expert leads or advises the project | the project lead, or the source's author on Zulip | FLT, LTE, Infinity-Cosmos, Stacks-and-Moduli |
| C. Mandatory public code review | maintainers and reviewers of the repository | Formal Conjectures, Mathlib |
| D. Human review of the plan only; AI review of the code | roadmap reviewers, plus a subject expert if one is found | Tau Ceti |
| E. One expert review of a finished development, turned into a checklist for agents | one expert, about a week | Ilin–Nugent case study |

This note sets out, for each, what is asked of the reviewer, what it costs in time, and what the
reviewer receives. It then works out what GLCinLean would have to do, and which steps only the
owner can take.

## 2. What the sources say that matters for GLCinLean

### 2.1 Annals Challenge: internal review, then narrow questions to the paper's authors

- "We formalised the statements manually over the course of ten months." 50 statements. [R §2]
- The manual review checked "incorrect edge cases, inconsistencies with the paper, missing
  hypotheses, or errors in our interpretation of the paper". It was done by the team itself:
  "Our team included mathematicians with expertise across a range of fields and prior experience
  with Lean formalisation." [R §2.3]
- Authors were asked only when the paper itself had a gap: "we consulted the authors to confirm
  the intended interpretation and that the further hypotheses neither altered the meaning of their
  intended result nor its correctness." The design principles say: "When the intended statement
  was unclear, we asked the authors of the paper." Twelve authors are thanked "who answered
  questions about their work". [R §2, §2.3, Acknowledgements]
- So the question put to an author was a yes/no question about one hypothesis. App. B gives
  examples: "We must impose n ≥ 3"; "The sets X and Y are intended to be measurable … This was
  caught during human review and clarified with the authors." [R App. B]
- Three people outside the author list are thanked for "help with formalising and reviewing the
  statements". [R Acknowledgements]
- Funding: "This project is funded by Renaissance Philanthropy's 2025 AI for Math Fund." [R]
- On definitions from an AI-managed library: relying on Tau Ceti "would still need careful
  review, or the dataset would lose its trustworthiness". [R §5]
- The AI audit came after the human review and still found mistakes in 11 of 50 formalisations.
  [R §2.4; details in `annals-challenge.md`]

### 2.2 FLT: the project lead's own expert judgement, made explicit

- "The project is currently being led by Kevin Buzzard … funded by grant EP/Y022904/1". "The
  route … was planned out essentially entirely by Richard Taylor in discussions with Buzzard."
  [R README]
- The main statement file `FermatsLastTheorem.lean` is 37 lines. It states FLT for `ℕ+` and pins
  its axioms with `#guard_msgs in #print axioms`, which lists `knownin1980s` and `sorryAx`. [R]
- `knownin1980s` is an `axiom` that proves anything. Its docstring sets the human standard:
  "KMB will allow uses of `knownin1980s` in the FLT repo, but only when it is used to prove a
  result which he is convinced that he is able to prove on paper using only results which were
  well-known pre-1990." Each use "must always be accompanied by comments which indicate how one
  might prove this theorem" from the pre-1990 literature. [R `KnownIn1980s.lean`]
- The later plan is to replace it by "a much smaller list of mathematical statements (perhaps
  around ten), each of which will have a clear reference". [R]
- Review of PRs: "The project maintainers will review the PR." Work is split into claimed GitHub
  issues. [R CONTRIBUTING]
- So FLT's mathematical review is the project lead's own judgement, recorded as an explicit,
  named rule. It cannot be copied by a project whose owner is not a specialist. [J]

### 2.3 LTE: the source's author on Zulip, reading definitions and statements

From Scholze's guest post (2021-06-05) [R, his own account, so also S]:

- "I joined the Zulip chat to answer any mathematical questions that may arise, but also as an
  interested spectator."
- On reading Lean: "The definitions and theorems are surprisingly readable, although I did not
  receive any training in Lean. But I cannot read the proofs at all".
- The formalisation went lemma by lemma; when "even on paper it does not seem clear how to
  proceed, … the issue was brought to attention in the chat, where it was usually quickly
  resolved."
- His role in the hard parts: "Answering the questions in the Zulip chat felt like I would give
  instructions of the form 'put your foot here, then your hand there'".
- The project "relied on continuous mathematical support from Scholze" [R `lte-final.md`]. After
  the proof, an examples folder was written "approximately readable by mathematicians who have
  minimal experience with Lean", so that "non-experts" could check the definitions and then the
  short `challenge.lean`. [R `lte-examples.md`]
- So a domain expert without Lean training can check **definitions and statements**, not
  proofs, if they are written readably and backed by examples. LTE had the source's own author
  doing that, over months. [J]

### 2.4 Formal Conjectures: mandatory review, mostly about the Lean

- "All submissions, including submissions by project members, require review. We use GitHub pull
  requests for this purpose." [R CONTRIBUTING]
- The paper says review is "by humans with both Lean expertise and relevant mathematical domain
  knowledge" [R, other note: `further-formal-conjectures-paper-firsching-et-al.md`]. The README
  says accuracy rests on "careful human review of contributions" [R].
- The reviewer's main question: "whether the Lean statement says what its cited source says". The
  module docstring is not an independent source: "It is part of the change under review." [R
  STATEMENTS.md]
- Corrections after merging come through a public issue template, "Report misformalization". It
  asks for a permalink, a "Trivial proof/disproof" if there is one, and a suggested fix. [R]
- Volume as of 2026-11-08: 254 issues and 533 PRs carry the `misformalization` label (19 issues
  open); 175 items carry `ai-audit`; 486 `misformalization` items were opened since 2026-08-01.
  [R, `gh api` search counts]
- The one merged algebraic-geometry statement (PR #28, Hartshorne's conjecture on vector bundles)
  was open from 2025-05-27 to 2025-07-16, about seven weeks. Two reviewers approved it. The
  inline comments I read are about the Lean: universe levels, names, unused variables, `notation3`.
  One suggested comment keeps a TODO: "here we would really need some sanity checks and easier
  results." [R, `gh api …/pulls/28/comments`]
- So public review of a specialised statement in a big statement repository gives careful
  **Lean** review. Domain review of the mathematics depends on who happens to review. [J, from one
  PR, so weak evidence]
- Formal Conjectures forbids opaque placeholders: "Never add an `axiom`, `opaque`, or `constant`
  declaration anywhere in the repository." [R STATEMENTS.md]

### 2.5 Tau Ceti: humans review roadmaps, AI reviews code

- "Review of implementation PRs is entirely driven by AIs. These operate according to a fixed
  open source rubric. Humans write the rubric". Humans own the roadmaps, which change "via
  human-reviewed pull requests". [R TauCeti README]
- What a human roadmap review is: "Human review is often closest to a journal's 'quick opinion':
  is the mathematics worth developing, is the scope appropriate, and is the overall approach
  sound? AI review can do much of the detailed work". [R Roadmap CONTRIBUTING]
- A human may assess only scope and approach, and should then comment, not approve, "Because an
  approval from a roadmap reviewer merges the PR once the build is green". [R]
- Of the four aspects of a review, aspect 1 ("What is included") is the one where "A human
  subject-matter expert is key". [R]
- Scarcity, in the project's own words: "Substantive review, especially from a subject-area
  expert, is the thing we are shortest of." "Reviewers are frequently working outside their
  mathematical expertise. If you can name or recruit someone who knows your area, whether or not
  they know Lean, say so on the PR or in the Zulip topic. That is often the difference between a
  roadmap merging and sitting." [R]
- A reviewer must say what was and was not checked: "When reporting a review, say what you
  checked and what remains outside its scope." The example given: ":robot: AI-assisted review
  using [model]: I checked the layer dependencies … I have not reviewed the choice of
  mathematical scope." [R]
- "Nobody should post a roadmap or a review comment they have not read carefully themselves." [R]
- Scale on 2026-11-08: 468 merged and 481 open roadmap PRs. [R, `gh api` search]

### 2.6 Mathlib: reviewers by area, and strict rules on AI

- The reviewer team "helps the mathlib maintainers with the daily reviewing of PRs to mathlib";
  reviewers place ready PRs on a queue for maintainers. [R reviewers page]
- Area tags on the reviewers page (151 entries by my count): `t-algebraic-geometry` 11,
  `t-category-theory` 13, `t-algebraic-topology` 5, `t-condensed` 3. No reviewer lists a
  representation-theory tag. [R, counted by script; the count of entries is approximate, E]
- These reviewers review Mathlib PRs. Nothing on the page offers review of other repositories.
  [R; J that this is the reading]
- From "Use of AI" [R]:
  - "Using an LLM when writing comments on GitHub or Zulip is not allowed: use your own words."
  - "As of mid-2026, code written by an AI without the supervision of a Lean subject expert fails
    to meet that bar by a large margin."
  - Members of the review team "will summarily close without comment any low quality PR produced
    using LLMs, especially if the author has made little effort to directly engage in the
    community".
  - "It is essential that you understand all the content written by an AI."

### 2.7 Ilin–Nugent: what one expert review costs and what agents do with it

The closest evidence on cost and effect. A Claude Code formalisation of Grothendieck vanishing
(Hartshorne III.2.7), about 5,000 lines, was reviewed by one of the authors, "a Lean/Mathlib
expert". [R]

- **Who and how long.** "one of the authors performed a comprehensive review of the initial
  formalization (one week), which was converted into a checklist, and then the agent (Claude and
  Codex) iterated until the checklist was finished (two weeks)." A second review by the same
  expert followed. [R]
- **What the reviewer received.** The repository, read "as library code"; the review was "a
  structured audit with large cross-file changes and per-file comments". The statement was
  written by hand and "uses only existing mathlib definitions", which "prevents the agent from
  making custom definitions to render the theorem trivially true". [R]
- **What it found.** Of 62 definitions made by the agent, exactly one was done "the correct way";
  "The remaining 61 definitions were all done poorly". [R, the expert's own verdict, so S for the
  numbers]
- **What agents fixed, and what they did not.** Items with "crisp completion predicates" were
  fixed (renames, generalising a stated theorem, deleting a wrapper). Definitions "did not
  noticeably improve after the review"; the agent "failed to identify further changes on its
  own". [R]
- **Their advice:** "expert reviewers should spend their scarce attention on definitions, theorem
  surfaces, and global organization, and hand agents the narrow refactors that carry an explicit
  completion predicate." And as a standard: "after the proof checks, ask an expert to review the
  public definitions, theorem statements, namespaces, and API surface". [R]
- The reviews themselves were published as a dataset. [R; dataset not opened]

### 2.8 The Lean Zulip: where such requests are made

- The web-public archive (last updated 2026-02-28) lists 96 channels. Among them are `FLT`,
  `Formal conjectures`, `Infinity-Cosmos`, `condensed mathematics`, `homological algebra`,
  `Is there code for X?`, `PR reviews`, `mathlib4`, `maths`. There is **no Langlands channel and
  no algebraic-geometry channel** in it. [R, archive index]
- The only Langlands thread found (`#maths`, July 2025) is a speculative physics post. Its one
  reply asks "what does this have to do with Lean?" [R]
- Tau Ceti's CONTRIBUTING points roadmap authors to the Zulip topic "Getting started: roadmaps"
  in `#Tau Ceti`, "the right place … to ask for review once you have opened a PR". [R; the topic
  itself unreachable]
- So, as far as the archive shows, the Lean community has no standing place where geometric
  Langlands experts gather. A request would go to `#Tau Ceti` (for roadmaps), `#maths` or
  `#mathlib4` (for definitions), or to a person directly. [J; the archive may miss newer or
  non-public channels]

### 2.9 What the reviewer receives, across the sources

| Project | What the expert reads |
|---|---|
| LTE | a short `challenge.lean`, an examples folder written for non-Lean readers, a blueprint, Zulip questions as they arise [R] |
| FLT | a 37-line statement file with pinned axioms; a LaTeX blueprint; a written rule per `knownin1980s` use [R] |
| Annals | the Lean file next to the paper; for authors, one specific question [R] |
| Formal Conjectures | the PR diff, the docstring, the cited source [R] |
| Tau Ceti roadmaps | a Markdown roadmap with `Suggested.lean` prototypes; a scope statement from each reviewer [R] |
| Ilin–Nugent | the whole repository, read as library code [R] |
| comparator | the trusted `Challenge` file and everything it imports: "Note, that comparator has no way to figure out whether the statements in the challenge file …" mean what is intended, and definition holes "**must** always be checked with an additional (potentially human) verifier" [R README] |

## 3. What it means for GLCinLean

### 3.1 The pool of possible reviewers is small, and of two kinds

- **Lean-literate mathematicians outside the field** (pattern A or C): for example Mathlib's 11
  algebraic-geometry and 13 category-theory reviewers. They can check that a definition of a
  stack, QCoh or a DG category means the standard thing. They are unlikely to vouch for GLC-specific
  objects (`Nilp`, the half-twisted D-modules, the Langlands functor's characterisation). [J]
- **Experts in geometric Langlands without Lean** (pattern B). Scholze's account says such a
  reader can check definitions and statements if they are readable. But in his GLC survey he also
  writes that he cannot read the AGKRRV papers "beyond a superficial level" [R, other note:
  `further-scholze-geometric-langlands-after-gaitsg.md`]. So even mathematicians outside this
  subfield may not be able to judge the sheaf-theoretic layer. [J]
- Neither kind has any reason to help a private project unless asked well and asked narrowly.
  Tau Ceti, with a whole community, calls subject experts "the thing we are shortest of". [R/J]

### 3.2 Realistic forms of outside review, from cheapest to dearest [J, costs E]

| Form | What is asked | Reviewer's time [E] | Precedent |
|---|---|---|---|
| 1. Narrow author question | yes/no on one interpretation or hypothesis (e.g. "is Conj. 1.6.7 meant for `G` connected reductive over `k` of char 0, with this `Nilp`?") | minutes to an hour per question | Annals author consultation |
| 2. Statement-surface read | read `Abstract.lean` (137 lines today) plus docstrings and an examples file; say whether it says what GLC I says | a few hours | LTE (Scholze read definitions), Tau Ceti "quick opinion" |
| 3. Definition review of one layer | read the backbone definitions of one layer (e.g. stacks, QCoh, IndCoh) as library code | about a week per ~5,000 lines | Ilin–Nugent |
| 4. Ongoing adviser | answer questions on Zulip as they arise, over months | open-ended | LTE, FLT (lead), Infinity-Cosmos (source authors) |

- Form 1 is the only one with a precedent of strangers saying yes: the Annals team got answers
  from 12 authors. But those were authors of their own theorem being asked about their own
  wording, by the team formalising it. [R for the count; J for the comparison]
- Forms 3 and 4 had, in every precedent, a reviewer who was a co-author, the project lead or the
  source's author. No precedent found of a stranger doing a week-long review for free. [J, from
  the sources above; not an exhaustive search]

### 3.3 What GLCinLean should prepare, whatever form is chosen [J]

From §2.9 and the owner's ideas ("Link to the existing literature. A mathematician should be
able to trust and verify …", ideas.md item 1):

1. **One short trusted file**: the statement surface (today `Abstract.lean`), with every
   hypothesis tied to a numbered place in GLC I v3. It doubles as the comparator challenge file.
2. **Docstrings that a non-Lean reader can follow**, in Mathlib style, with the paper location
   and every deviation (`Note:`), as LTE's examples and Annals' files do.
3. **An examples file per ingredient** (LTE), sorry-free, so a reviewer checks behaviour, not
   code.
4. **A rendered view**: doc-gen pages or a blueprint, so the reviewer needs no Lean install
   (`further-leanarchitect-blueprint-data-extracted-f.md`).
5. **A one-page brief**: what is asked, what is not asked (proofs, code style), the list of open
   placeholders, and the specific questions, in the Tau Ceti manner of stating scope.
6. **A record of the outcome**: reviewer, date, commit, scope, verdict. The review system
   (ideas.md, "Review status") needs exactly this to mark a declaration **reviewed** at a commit.

Agents can do all of this. They cannot send it.

### 3.4 When to ask

- **Not before the placeholders are real or characterised.** An expert cannot check an `opaque`
  object: today `DGCatPt`, `DGCat.ObjPt`, `LinFunPt` and the other placeholders in
  `Foundations.lean` (15 lines mention `placeholder` there, 8 in `Abstract.lean`) carry no
  content. Comparator says the same of definition holes. [R for the files; J]
- **Possible earlier:** a form-1 question about the *meaning* of Conj. 1.6.7 (which version of
  `Nilp`, which twist, which category on each side), answered against the LaTeX. This helps step 2
  (the blueprint) and needs no Lean. [J]
- **After the backbone of one layer is built**: form 2 or 3 on that layer, if someone can be
  found. Ilin–Nugent shows that this is where agent work is weakest (definitions). [R/J]

### 3.5 Steps only the owner can take

1. **Decide whether outside review is sought at all**, and at which milestone. PLAN.md already
   says "no claim of faithfulness is made without an outside expert" and lists "Who the outside
   expert is, and when to end the quiet phase" as open. [R PLAN.md]
2. **Choose whom to ask.** A judgement about people. Agents can list public roles (paper authors,
   Mathlib area reviewers, roadmap reviewers) but should not pick or approach anyone. [J]
3. **Write and send the request in their own words, from their own account.** Mathlib's rule:
   "Using an LLM when writing comments on GitHub or Zulip is not allowed: use your own words."
   Tau Ceti's: "Nobody should post … a review comment they have not read carefully themselves."
   Both rule out an agent posting the request. [R]
4. **Read the package before sending it**, at least the brief and the questions, since the
   request goes out under the owner's name. [J]
5. **Decide what to offer**: acknowledgement, co-authorship of a write-up, nothing. Annals was
   grant-funded; in Ilin–Nugent the reviewer was a co-author. [R/J]
6. **Hold the conversation**: answer follow-ups and pass findings back to the agents. Agents can
   turn the findings into a checklist (Ilin–Nugent). [J]
7. **Decide what the project claims if nobody agrees**, for example "agent-reviewed; not checked
   by an expert" in the README and on the review page. [J]

## 4. Conflicts

- **Full automation versus who may post.** The workflow decisions "Tau Ceti contributions are
  fully automated" and "Agents push themselves" do not extend to asking people. Mathlib forbids
  LLM-written GitHub and Zulip comments, and Tau Ceti asks that nobody posts a review comment
  without reading it carefully. Any outside-review step therefore has a human (the owner) in it.
  [R the rules; J the conflict]
- **"Review additions publicly" (ideas.md item 1) versus who is actually there.** Public review
  of a specialised statement gave Lean-level review in the one Formal Conjectures AG PR read
  (§2.4). The Zulip archive shows no Langlands or AG channel. Public review alone is unlikely to
  give mathematical review of GLC objects. [R/J]
- **Deferring to Tau Ceti does not bring human review of definitions.** Tau Ceti's code is
  AI-reviewed only; humans review the roadmap's scope. The Annals paper says Tau Ceti definitions
  "would still need careful review". This tempers the suggestion in
  `further-infinity-cosmos-project-riehl-carneiro-v.md` that taking definitions from Tau Ceti
  "moves that burden to Tau Ceti's review": it moves Lean review there, not expert review.
  [R/J]
- **The owner may not review a roadmap fully (ideas.md item 4)** versus Tau Ceti's "Nobody
  should post a roadmap … they have not read carefully themselves". Already noted in
  `tauceti-roadmaps.md`. A job-board target avoids it; a direct roadmap PR does not. [R/J]
- **A question to a paper's authors on Zulip** (`annals-challenge.md` §5) assumes they are on
  Zulip. Not checked. Email or a public issue may be the only route, and either is the owner's
  call. [J]
- **Fresh agents as reviewers (workflow step 4)** versus Ilin–Nugent: agents fixed the local
  items an expert listed but "did not noticeably improve" definitions, and found no further
  generality problems by themselves. Fresh agents can carry the detailed checks; they do not
  replace the expert's judgement on definitions. [R/J]
- **Formal Conjectures as a route** (submitting the GLC statement there for its mandatory human
  review) conflicts with GLCinLean's design: Formal Conjectures forbids `opaque` and `axiom`
  declarations [R], and GLC's definitions would have to live in its `FormalConjecturesForMathlib`
  folder. Not practical before the backbone exists. [J]
- **PLAN.md's "quiet phase"** versus any outside contact. Asking anyone ends it. [R/J]

## 5. Input for the open questions (notes/workflow.md)

- **Who reviews the mathematics (fresh agents, an outside expert), and to what standard.**
  Suggestion [J], built on §2:
  1. *Fresh agents* do all detailed passes: the Annals checks (edge cases, consistency with the
     paper, missing hypotheses, interpretation), Formal Conjectures' main question ("whether the
     Lean statement says what its cited source says"), and examples files. Each report says what
     was and was not checked (Tau Ceti).
  2. *An outside expert* is asked only for what agents cannot give, in the narrowest form that
     works: form-1 questions on the meaning of Conj. 1.6.7 early; a form-2 read of the statement
     surface, docstrings and examples once placeholders are real; a form-3 review of definitions
     for one layer if someone suitable is willing.
  3. *The standard*: a declaration is **expert-reviewed** only with a named reviewer, a commit and
     a stated scope. Otherwise it is **agent-reviewed**, and the project claims no more. This
     matches PLAN.md's "no claim of faithfulness … without an outside expert".
  Reasons: precedents with real expert review had an expert inside the project (§3.2); agents
  are weakest on definitions (§2.7); and the owner cannot fill the gap (AGENTS.md).
- **What goes into `AGENTS.md`, and where "update the next prompt" lives.** One rule [J]: agents
  never contact people or post in other projects' threads in the owner's name. They prepare review
  packages and questions, and the owner sends them. Also: every review report states its scope.
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.** For
  outside review, the short statement file is right: it is what LTE, FLT and comparator give a
  reviewer. Opaque placeholders cannot be reviewed for meaning, so expert review of the statement
  waits until they are real or characterised. [J]
- **What happens to each existing file.** [J]
  - `reviews/statement-pin.toml`: could record outside reviews (who, date, commit, scope) beside
    the owner's approval.
  - `blueprint/`: the natural package for a reviewer who reads LaTeX rather than Lean.
  - `references/papers/manifest.toml`: a reviewer needs the exact paper version; a citation with
    arXiv id and version in each docstring is enough for that.
- **Where research notes and session summaries live, and whether they are committed.** Commit
  outside reviews and their resolutions (Ilin–Nugent published theirs), with the reviewer's
  consent; the review system reads them to set **reviewed** tags. [J]
- **Whether `PLAN.md` is needed.** Only for the owner-level items: whom to ask and when. These
  could equally sit in the owner's questions list. [J]

## 6. Questions for the owner

1. **Outside review at all?** Will you seek outside mathematical review, knowing that every
   precedent with real expert review had the expert inside the project? Or will GLCinLean claim
   only "agent-reviewed" until someone offers?
2. **Which kind and when?** Narrow questions on the meaning of Conj. 1.6.7 early (before the
   blueprint), a read of the statement surface once placeholders are real, a definition review of
   one layer, or several of these?
3. **Sending.** Are you willing to write and send requests yourself, in your own words and under
   your name, as Mathlib's and Tau Ceti's rules require? Agents would prepare the package and the
   questions.
4. **Channel.** Email to paper authors, a Zulip post (`#Tau Ceti`, `#maths`), a public GitHub
   issue, or none? Each ends the quiet phase.
5. **What to offer.** Acknowledgement, co-authorship of a write-up, or nothing?
6. **Recording.** May outside reviews be committed (reviewer, date, commit, scope, verdict) and
   shown on the review page, subject to the reviewer's consent?
