# Xena blog: "How to Formalize All of Mathematics"

- **Source:** guest post on the Xena Project blog by Jeremy Avigad, Kevin Buzzard, Johan Commelin,
  Rémy Degenne, Kim Morrison, Oliver Nash and Adam Topaz.
- **URL:** <https://xenaproject.wordpress.com/2026/10/16/how-to-formalize-all-of-mathematics/>.
  A blog post has no commit, so the version is fixed by its timestamps: published
  2026-10-16T09:54:00Z, last modified 2026-10-16T17:47:23Z (from the page's `article:` metadata).
- **Checked 2026-11-08.** Whole post read, including its four footnotes and the 12 "Responses"
  (11 comments and 1 pingback). A local copy of the page is in `.lake/research/xena-blog/` (Git
  ignores it). An independent re-fetch on 2026-11-08 (`.lake/research/xena-blog-check/`) showed
  the same text and the same timestamps.
- **Licence:** the page states none. The usual copyright applies, so this note quotes short
  passages and does not copy the post.
- **Also read for this note**, because the post points to them:
  - Mathlib's values page, which the post calls "the starting point for our own list". Its source
    is `leanprover-community/mathlib-landing`, `community/templates/contribute/values.md` @
    `50f9f1a9` (2026-11-02).
  - The READMEs of `mathlib-initiative/formalization.yaml` @ `99c678e5` (and its template
    `formalization.yaml`, v0.4, same commit), `leanprover/comparator` @ `865edc14` and
    `TauCetiProject/TauCetiWorker` @ `ae6b1c9b`.
  - `lake help comparator` and `lake help check` of the local `v4.36.0-rc2` toolchain, because
    the Comparator README says it has moved into core Lean.

How the tags are used: [R] read directly in the source on 2026-11-08; [S] a source's claim about
itself; [E] estimate; [J] judgement. A tag covers the sentence or bullet it ends.

---

## 1. What it is

- A position piece by seven Lean and Mathlib people. It answers "recent calls to formalize
  everything as quickly as possible" after "last week's big OpenAI release", and uses AI labs'
  large autoformalisations as examples: Math, Inc.'s sphere packing, Anthropic's 13-million-line
  Fermat's Last Theorem, and OpenAI's Navier–Stokes work and `openai/math` dump. [R]
- Its stance is not against AI: "We are generally optimistic about the role AI can play", and its
  vision is "Humans, AIs, and the Lean language work in concert". The worry is speed without
  quality: "Done poorly, it will be, at best, a waste of resources; more likely, it will do
  lasting damage." [R]
- It has five parts [R]:
  1. **The concerns.** A formal artefact nobody uses is worth little.
  2. **The positives.** Some lab results were done well.
  3. **Lessons so far.** Short descriptions of Mathlib, Formal Conjectures, the Annals Challenge,
     Tau Ceti, Formal Frontier and Palomar.
  4. **The ten values.** The list quoted in `notes/ideas.md`.
  5. **The way forward.** Six calls to action.
- The authors say it speaks for themselves, not for "any of the organizations or communities with
  which we are associated". [R]
- The list in `notes/ideas.md` matches the post word for word for all ten values. I compared them
  line by line. [R]

## 2. What it says that matters for GLCinLean

### 2.1 The central claim: a formalisation is worth only what others can build on

- "a formal artifact is not worth much if nobody uses it." [R]
- Sphere packing: the original team found that "cleaning up the AI-generated code was more trouble
  than it was worth; it turned out it was better to throw the code away and do it right, still with
  ample help from AI." [R]
- Anthropic's FLT (13 million lines in 11 days): "this piece of AI-generated code probably has
  little ongoing value." [R]
- For results whose correctness is not in doubt, the value "lies solely in what we get beyond mere
  correctness". The full sentence is conditional: "The theorems were not seriously in doubt, so the
  value of the formal artifacts lies solely in what we get beyond mere correctness." What lies
  beyond is generalisation, connections, refactoring and "our ability to use and interact with the
  data". [R]
- The contrast case is Navier–Stokes, where "the correctness signal played a key role", yet "even
  here, the unadorned formal artifact is a mixed blessing". [R]
- What "done well" means, from "The positives": the work "demonstrated impressive new
  capabilities, contributed to understanding, and the community subsequently built on their
  work". [R]
- OpenAI's `openai/math`: "many of the informal/formal pairs diverge in subtle or significant
  ways". [R]
- "A lousy formalization of existing results is worse than no formalization at all." [R]
- AI-assisted formalisation is framed as "a special case of the alignment problem, namely, ensuring
  that formal libraries fulfill the community's mathematical goals". [R]

### 2.2 The ten values, in full, and what each asks of a project like GLCinLean

Each quoted value is [R], word for word from the post. The "Asks of GLCinLean" lines are [J].

1. **"Defer to human-curated libraries, particularly Mathlib; follow their design principles and
   code rules, and continuously refactor to adopt their decisions."**
   - Asks of GLCinLean:
     - Mathlib's conventions are the standard.
     - Whenever Mathlib (or Tau Ceti, which itself defers to Mathlib) gains something we built
       locally, refactor onto theirs.
     - This is a recurring duty (workflow step 5), not a one-off.
2. **"Prefer thoroughness and breadth. These must come before depth, but ultimately enable it."**
   - Asks of GLCinLean: build general theory (DG categories, sheaves on stacks, D-modules, perverse
     sheaves, `Bun_G`, `LS_G`) with full API before pushing the GLC-specific "surface". This
     matches the order in workflow step 3: backbone, then statement surface.
3. **"Avoid duplication. Generalize theorems for maximal reuse."**
   - Asks of GLCinLean:
     - No local copy of what Mathlib, Tau Ceti or another library has.
     - Definitions stated in the widest reasonable generality (any base, any stack), not only for
       the curve `X` and group `G` of the conjecture.
     - Mathlib's values page adds "General definitions", "Weak hypotheses" and "Strong
       conclusions" [R].
4. **"Review additions publicly, according to agreed standards."**
   - Asks of GLCinLean:
     - Every addition gets a review against a written, shared standard (Mathlib style, the Tau
       Ceti review rubric).
     - The review record is visible, not private to a session.
5. **"Publish freely. Libraries should be open source, interoperable, and explorable."**
   - Asks of GLCinLean:
     - Open licence. The repository already has Apache 2.0 [R, `LICENSE`].
     - Interoperable: it builds against released Mathlib and Tau Ceti, not forks.
     - Explorable: generated docs, a dependency graph, and a browsable review status.
6. **"Stay up to date. Ensure continuous compatibility with every release of Lean and Mathlib."**
   - Asks of GLCinLean: move the pins with each release, automatically (workflow decision "Keeping
     up with Mathlib and Tau Ceti is fully automated").
7. **"Stay open-minded about changes. If a better approach is discovered, it's never too late."**
   - Asks of GLCinLean:
     - The design must stay revisable, including the Abstract and Foundations design and the
       statement pin.
     - Checks must not freeze a design. They should only make every change visible.
8. **"Document and organize. Files should be coherent, systematically organized, and their contents
   must be documented."**
   - Asks of GLCinLean:
     - Mathlib's documentation style.
     - Subject folders as in Mathlib.
     - Each file about one subject, with a module docstring.
9. **"Link to the existing literature. A mathematician should be able to trust and verify that the
   concepts described in the library have the expected meaning."**
   - Asks of GLCinLean:
     - Every key definition cites its source precisely (paper, version, numbered item).
     - Every key definition can be checked by a mathematician against that source.
10. **"Set standards, and meet them. Producing low-quality or unaudited code and claiming or hoping
    to 'clean it up later' is counterproductive."**
    - Asks of GLCinLean:
      - Code meets the final standard when it lands.
      - No "Staging" code of lower quality kept in the hope of upstreaming it later.

- How the values are carried out: "Mathlib implements these values through its review process and
  community discussions. Tau Ceti and Formal Frontier instantiate these values in the code and
  prompts that drive them, as well as in community-written planning documents." [R]
- This supports the owner's plan to carry the values in prompts and `AGENTS.md`. [J]

### 2.3 What the post says about the projects it endorses

- **Mathlib** [R]:
  - "curated by a team of 65 reviewers and 950 contributors to date".
  - "grows steadily, but more slowly than AI-generated libraries".
  - "the primary place where we learn how to formalize better". [S, for the numbers]
- **Formal Conjectures** [R]:
  - Collects vetted formal statements of open problems.
  - "We should encourage projects announcing formalizations to use the existing vetted statements
    of problems wherever possible."
- **Annals Challenge** (arXiv 2610.18301) [R]:
  - States, but does not prove, the theorems of recent Annals issues.
  - "The blocker here is missing definitions."
  - The project "incentivises good formalizations of definitions which are being used in practice
    by leaders of the field".
- **Tau Ceti.** All of the following is [R] for what the post says, [S] as claims about Tau Ceti:
  - "incubated by the Lean FRO and the Mathlib Initiative"; "structurally similar to Mathlib".
  - "all contributions are written by AIs, and then adversarially reviewed by other AIs using
    standard rubrics".
  - Contributions follow "roadmaps curated by mathematicians and formalization experts".
  - Review criteria: "appropriate generality, avoiding duplication by reusing existing material,
    documentation, and naming conventions".
  - "Tau Ceti extends Mathlib without any duplication, and defers to all design decisions made
    there."
  - You can contribute "either by writing roadmaps or by supplying inference".
  - "now slightly larger than Mathlib (3 million lines of code)".
  - Recent results include Riemann–Roch, Schur–Weyl duality, Jordan–Brouwer separation,
    Rellich–Kondrakov compactness and Chebotarev density (links pinned to TauCeti commit
    `b989dec1`).
  - Footnote 2: anyone can help with `uv tool install
    git+https://github.com/TauCetiProject/TauCetiWorker` then `tauceti work --loop`, which needs
    `claude` or `codex` and an authenticated `gh`.
- **TauCetiWorker README**, read to make sense of footnote 2 [R]:
  - The worker is "hardwired to `TauCetiProject/TauCeti`" and authors PRs from your own fork.
  - Each round does one job, in priority order: rebase; bump (adapt a red `bump-mathlib/` PR
    opened by the review bot); lint repair; progress; fix CI; fix review findings; review others'
    PRs; Mathlib-overlap fix and scan; and otherwise "open a new PR advancing a roadmap target".
  - Mathlib bumps: the review bot opens `bump-mathlib/` PRs, and community workers (run by
    contributors) adapt them; "The worker never opens a bump itself." [R] So a contributor does
    not move Tau Ceti's Mathlib pin by hand. [J]
  - Steering, beyond `--only` (kind of work) and `--pr` (which PRs) [R]:
    - `--roadmap-only <area>` pins roadmap rounds to one subdirectory of `TauCetiRoadmap`;
      unpinned, "each round picks a fresh random area".
    - `--extra-roadmap-prompt <text>` "steers the choice of target within the designated
      roadmap" (its example: "Work on the material relevant to Higher Topos Theory").
    - `--source <path-or-url>` "adapts compatible material from an existing repository". It is
      "supplementary: the agent prioritizes the roadmap as written, then review-quality library
      code, and only then migration of the source."
    - Roadmap workers avoid targets others have claimed on the `leanprover-community/intentions`
      board.
- **Formal Frontier** [R]:
  - A Mathlib Initiative "source-to-library pipeline" with an agent swarm and a build server,
    "designed with scalability in mind, so it can ingest thousands of textbooks".
  - 41 released libraries, about 200k lines.
  - "Formal Frontier and Tau Ceti both use agents and adversarial review, but they differ in their
    drivers and output structure. Tau Ceti uses roadmaps curated by experts and builds a single
    coherent library."
  - "Both insist that a formalization is only valuable if others can build on top of it."
- **Palomar** [R]:
  - A registry of projects "aimed at particular results, but not necessarily aspiring to be part of
    a general library".
  - It requires two things of every project:
    1. a `formalization.yaml`, a self-assessed description of what was formalised, how ("solely
       by humans, in conjunction with AIs, or autonomously by AIs"), relations to other work, and
       the involvement of the original authors;
    2. "a Comparator setup, which makes it easier to audit exactly what the statement proves".
- **formalization.yaml README and template (v0.4)** [R]:
  - Required fields in the template: `project.name`, `project.authors`, `project.license`,
    `sources` (each with a `title`), `automation.methods` (each with a `method`: `manual |
    copilot | agent | autonomous | other`) and `review.status` (`unchecked | agent-reviewed |
    self-assessed | peer-reviewed | author-verified | other/freeform`). The README singles out
    "`sources` is required".
  - A source entry has `id` (URL, DOI, arXiv ID, …), `location` (theorem, section, page),
    `relationship` (`formalizes | adapts | …`) and `author_endorsement`.
  - Optional parts that touch GLCinLean: `alignment` (a table from source statements to Lean
    declarations and modules, with a status), `fidelity.divergences`, `main_results[].
    comparator_config`, `literature_dependencies` (results relied on but not proved), and
    `status.sorry_in_definitions`, which excludes "deliberate definition holes in Comparator
    challenge modules".
  - The file deliberately does not repeat what the repository already encodes (toolchain, pins,
    CI).
  - It is checked with `check-jsonschema` against a published schema.
- **Comparator README** [R]:
  - "merged into core as of Lean release v4.35.0 in the form of `lake comparator` and the
    accompanying `lake check`".
  - Given a trusted `Challenge` module and a `Solution` module, it guarantees that the listed
    theorems prove the same statement, use only the permitted axioms, and pass the kernel.
  - It supports **definition holes** (sorried definitions the solution fills). It warns that these
    "can be gamed" and "**must** always be checked with an additional (potentially human)
    verifier".
  - Its holes are `sorry`ed `def`s listed in `definition_names`; for them it guarantees only the
    axioms, kernel acceptance, and that "name, type, universe levels and safety levels" match.
  - GLCinLean's toolchain is `v4.36.0-rc2` [R, `lean-toolchain`]. Its `lake --help` lists
    `comparator` ("judge a solution against a challenge") and `check` ("check this project against
    external checker(s)") [R, local toolchain, 2026-11-08].
  - `lake check` builds the default targets, exports them and replays them through the kernel,
    "erroring on any use of non-standard axioms"; `--paranoid` adds the bundled external kernels.
    [R, `lake help check`]
  - Both run the project inside a `bwrap` (bubblewrap) sandbox: "`bubblewrap` is required", and
    without it they exit with code 2. [R, `lake help`] Bubblewrap is a Linux tool [E]. The ways round it are to
    build the export elsewhere and pass it in (`--from-export`, "e.g. in virtual machines for extra
    isolation") or `--inadvisably-no-sandbox`, which "can compromise the result fully" [R].

### 2.4 The way forward (six calls to action) [R]

1. Curate and contribute to Mathlib.
2. "Provide the resources needed for the shovel-ready projects, Tau Ceti and Formal Frontier, to
   grow by an order of magnitude in a matter of months".
3. "Write the expert roadmaps and blueprints that guide the implementation of large formal
   libraries", and hold subject-specific workshops.
4. Model the costs of scaling (footnote 4: models "based on Tau Ceti and Formal Frontier" are
   planned).
5. "Advocate for control by mathematicians of the tools and resources required for
   autoformalization".
6. Set up non-profit or academic hosting with governance.

- The post also forecasts: "Within three years, and possibly much sooner, most of mathematics can
  be formalized…". [R; it is an estimate by the authors]

### 2.5 Mathlib's values page (the post's starting point): points beyond the ten [R]

- **Trust.** Mathlib code is reviewed "by both experts in that domain of mathematics and by experts
  in Lean development".
- **Maintainability.** "zero `sorry`s is a starting point, not an end point".
- **"Is the author a human?"** "many reviewers are unwilling to perform their service unless the
  author is a human."
- **"Are the definitions 'correct'?"** "perhaps the most important function of review as Lean can
  only tell you that you have defined *something*". Non-trivial definitions get the most
  attention.
- **API for new definitions.** Lemmas that characterise a definition also "increase confidence that
  the definition means what is intended".
- **Downstream projects.** Mathlib writes general definitions partly to avoid breaking changes,
  and inserts migration hints such as `deprecated` for downstream projects.
- **Accessibility.** "we require human-readable comments (aka "doc strings") on all definitions".
- Also checked in review: right files and a wide import tree, naming, performance (no
  `maxHeartbeats` tweaks), data-carrying instance diamonds, automation attributes (`simp`,
  `gcongr`, `fun_prop`, `grind`), and the `public`/`private` modifiers.

### 2.6 Responses to the post (11 comments, 1 pingback) [R]

- On autonomous runs, the blog's own account `xenaproject` replied to Jason Starr, who had asked
  why AI should not also "master organizing a repository of formalized mathematics in a
  human-useful way": "If the systems really get
  so good that all you have to do is to write /goal formalize all mathematics … and it works first
  time then brilliant, problem solved. If however it fails and takes another $10^8 to fix then it's
  a catastrophe." (That the account is Kevin Buzzard writing is my inference from the blog [J].)
- Ben Green disputed that Anthropic's zeta-zeros note was "done well", saying it was hardly
  readable.
- Other comments are about foundations (dependent types, other logics) and prove2.me. None bear on
  GLCinLean.

## 3. What it means for GLCinLean

All [J] unless tagged.

- **Library first, not a one-off (ideas.md item 1).**
  - The post's whole argument supports the owner's choice.
  - A GLC statement and proof that nobody can build on would be the kind of artefact the authors
    call of "little ongoing value".
  - So the general backbone (D-modules, perverse sheaves, DG categories) is the main product, not a
    by-product.
- **Order of sources (ideas.md item 3).**
  - "Defer to human-curated libraries, particularly Mathlib" fits "Mathlib first".
  - Tau Ceti is AI-written, yet the post holds it up as a lesson to learn from, and lists that its
    roadmaps are expert-curated and that it "defers to all design decisions made" in Mathlib [R].
    The post gives no explicit reason for listing it; reading those features as the reason is my
    judgement. So "Tau Ceti second" fits.
  - The post does not mention `AxiomMath/Stacks` [R].
  - The post's logic puts code that is neither human-curated nor coherently reviewed last.
  - Copying Stacks declarations into `GLCinLean/Stacks/` (PLAN.md) is duplication by design and
    must be refactored away when Mathlib or Tau Ceti gains the object.
- **This repository and Tau Ceti both (ideas.md item 4).**
  - Writing Tau Ceti versions of roadmap items is exactly the "supplying inference" the post
    endorses.
  - A geometric representation theory roadmap is an endorsed contribution too ("Write the expert
    roadmaps and blueprints").
  - But the post says roadmaps are "curated by mathematicians and formalization experts" [R], and
    the owner says he may not be able to review a roadmap fully. An AI-drafted roadmap with no
    expert curator may not meet Tau Ceti's expectations. This needs checking against Tau Ceti's own
    roadmap rules (another note's job).
- **Fully automated Tau Ceti contributions (workflow decision).**
  - This is consistent with Tau Ceti's model: "all contributions are written by AIs" [S].
  - TauCetiWorker exists to automate this [R]. But its default loop picks whatever work the queue
    needs, not GLC-relevant items.
  - Using it for GLCinLean means either targeting (`--roadmap-only <area>` plus
    `--extra-roadmap-prompt "Work on the material relevant to geometric Langlands"`, or
    `--only` / `--pr`; it has these dials [R]) or accepting that some of the effort goes into
    general Tau Ceti maintenance and review. The example `/goal` prompt in ideas.md asks for the
    latter as well ("to be a good citizen").
  - `--source <path-or-url>` is the worker's own route for moving material from an existing
    repository (such as this one) into Tau Ceti, but only after "the roadmap as written" and
    "review-quality library code" [R]. This fits ideas.md item 4 ("write them in my repository
    first"). Whether it works across Tau Ceti and Mathlib conventions for GLCinLean's code is
    untested [E].
- **Fully automated keeping up (workflow decision) and "Stay up to date".**
  - The post asks for compatibility with "every release of Lean and Mathlib".
  - GLCinLean gets Mathlib through Tau Ceti, and Tau Ceti's bumps are bot-driven [R, worker
    README]. So GLCinLean's realistic target is to follow each Tau Ceti tag promptly.
  - The current `AGENTS.md` line "`lake update` … best left to the owner" conflicts with this
    (already listed in workflow.md).
- **Statement first (PLAN.md, workflow step 2).**
  - The Annals Challenge, which the post lists among projects that "help us focus effort where it
    has the highest payoffs", states theorems without proofs. It names "missing definitions" as the
    blocker, and says it "incentivises good formalizations of definitions" [R].
  - The post does not discuss statement-first as the first stage of a project that then proves the
    result [R]. Reading it as support for GLCinLean's order is my judgement: stating is worthwhile
    on its own, provided the definitions are real and good.
  - The conditional sentence in 2.1 applies to GLC too: its proof is published, so most of the
    value of GLCinLean lies beyond the correctness check, in the definitions and library others can
    use. How far the GLC proof is "seriously in doubt" is not something this note can judge.
  - In GLCinLean the placeholders (`DGCat`, `LinFun`, … in `GLCinLean/Foundations.lean`; 10
    `@[placeholder]` there and 6 in `Abstract.lean` [R, grep]) are exactly those missing
    definitions.
- **Placeholders and "Set standards, and meet them".**
  - Opaque placeholders are honest, visible holes, not "low-quality code to clean up later".
  - But the post's warning applies to anything built over them: API proved over a placeholder, or
    a fast `Staging/` definition meant to be replaced later.
  - Comparator's warning on definition holes ("can be gamed", needs an extra verifier [R]) is the
    precise risk. Replacing a placeholder by a definition can make the statement say less than it
    seems. Each replacement needs an independent fidelity check.
  - The mechanisms differ, though. Comparator's holes are `sorry`ed `def`s [R]; GLCinLean's
    placeholders are `opaque` constants, or `def`s over an `opaque` `NonemptyType` [R,
    `Foundations.lean`]. Whether `lake comparator` accepts an `opaque` in the challenge replaced by
    a `def` in the solution was not tested; its "safety levels must match" rule suggests care is
    needed [E].
- **Re-exports in `Foundations.lean`.**
  - `abbrev Scheme := AlgebraicGeometry.Scheme`, `abbrev ReductiveGroup := TauCeti.…` and so on
    [R] give a second name to an upstream object.
  - That is a mild form of what "Avoid duplication" and "Document and organize" (coherent,
    systematic files) warn against. In a library meant for reuse, downstream users would rather
    see the Mathlib and Tau Ceti names directly.
  - The re-exports exist for readability of the abstract. Whether that is worth it is a step-2
    decision.
- **Review publicly, to agreed standards (ideas.md "review system"; workflow step 4).**
  - The planned review system (web page, dependency graph, per-declaration tags pinned to commits)
    is a direct way to make review public and explorable.
  - "Agreed standards" means a written rubric shared with Tau Ceti and Mathlib (TauCetiReview,
    Mathlib style). A project-private standard falls short.
- **Link to the literature (ideas.md item 5, papers).**
  - The principle needs each definition to cite its source precisely, so a mathematician can check
    it.
  - That needs the paper version, but not necessarily `references/papers/manifest.toml`. The arXiv
    id and version can sit in each docstring (for example `arXiv:2405.03599v3, Def. 1.6.2`), and a
    `formalization.yaml` `sources` entry can list the papers once.
  - This supports the owner's doubt about the manifest.
- **Palomar / formalization.yaml / Comparator.**
  - GLCinLean is a public repository whose goal is a particular result, which is the kind of
    project Palomar indexes [R].
  - Adding a `formalization.yaml` (sources, "autonomously by AIs", relation to Tau Ceti) costs
    little and serves "Publish freely".
  - A `lake check` / `lake comparator` setup, with `Abstract.lean` as challenge and the proof as
    solution, serves "Link to the literature" and statement auditing.
  - It may also cover part of what ReviewKit's statement pin and axiom check do now: `lake check`
    already errors on non-standard axioms [R, `lake help check`].
  - formalization.yaml's `alignment` table (paper item → Lean declaration → status) overlaps what
    `blueprint/` and the paper manifest try to record [J].
  - Cost: both `lake` tools need `bwrap` [R], a Linux tool [E]. Running them means a Linux
    machine, a VM or CI, which sits against "without any complex system or harness" (ideas.md) and
    the removal of CI in commit `0feeb6f` [J].
- **Prompts-only, no complex harness (ideas.md "What I want").**
  - The post notes that Tau Ceti and Formal Frontier carry the values in "code and prompts", with
    real infrastructure (agent swarms, build servers, adversarial review bots) [R].
  - GLCinLean can stay simple by using Tau Ceti's infrastructure for the Tau Ceti part, and by
    keeping its own part small and held to the same standards.
- **Goal-mode runs.**
  - Buzzard's comment is a direct caution about `/goal`-style autonomous runs [R]. They are fine if
    they work first time, and costly if their output must later be fixed.
  - This supports values 10 and 4: reviews during the work, not after it.

## 4. Conflicts

All [J] unless tagged.

- **With `notes/ideas.md`.**
  - No direct conflict. The owner's quote is verbatim [R].
  - **Tension 1.** ideas.md item 4 allows writing a roadmap the owner "might not be able to review
    fully". The post describes roadmaps as expert-curated [R].
  - **Tension 2.** ideas.md's "very simple way … prompts alone" sits beside the post's picture of
    Tau Ceti and Formal Frontier as heavily engineered systems. This is resolved if GLCinLean leans
    on Tau Ceti's tooling.
  - **Tension 3.** ideas.md item 3 keeps Stacks as a source of code. The post's "Avoid duplication"
    and "Defer to human-curated libraries" make copied Stacks code a temporary duplicate at best.
- **With the decisions in `notes/workflow.md`.**
  - None. "Commit and push", "Tau Ceti contributions are fully automated" and "Keeping up … fully
    automated" all fit the post.
- **With the project's set-up.**
  - Palomar's Comparator requirement, and core `lake comparator` / `lake check`, need a Linux
    sandbox (`bwrap`) [R]. The project has no CI. Adopting them adds machinery that
    ideas.md wants to avoid.
- **With current files, beyond those already listed in workflow.md.**
  - `PLAN.md` decision: copy Stacks declarations into `GLCinLean/Stacks/` and build missing pieces
    in `GLCinLean/Staging/`. Both risk "clean it up later" code and duplication unless held to the
    final standard.
  - `PLAN.md`: "Public but unannounced". This sits uneasily with "Review additions publicly" and
    "Publish freely" (explorable), although it is not strictly a breach.
  - `GLCinLean/Foundations.lean`: re-export aliases and a mixed file (re-exports plus
    placeholders). This is in tension with "Avoid duplication" and with "coherent, systematically
    organized" files.
- **With other sources.**
  - The post praises Anthropic's zeta-zero work as "done well". Commenter Ben Green disputes that
    [R]. This does not matter for GLCinLean.
  - Mathlib's values page notes that many Mathlib reviewers will not review non-human PRs [R]. So
    "fully automated contributions" should mean Tau Ceti, never Mathlib directly. This is
    consistent with ideas.md, which only asks to *use* Mathlib first.

## 5. Input for the open questions (workflow.md, "Questions for after the research")

All [J].

- **What goes into `AGENTS.md`, and where "update the next prompt" lives.**
  - Suggestion: put the ten values in `AGENTS.md` as the project's standard. Quote them, since
    their wording is the agreed standard. Point to Mathlib's values page for the review questions
    behind them (definitions correct, API, right files, naming, performance).
  - The post has no input on where the "update the next prompt" rule lives.
- **Is `PLAN.md` needed?**
  - The post values "expert roadmaps and blueprints" and "community-written planning documents".
    So some plan document is worth having.
  - It works best shaped like a Tau Ceti roadmap (objects, dependencies, status), so the parts
    covered by Tau Ceti can move there. A session log does not fill that role.
  - Whether that is `PLAN.md` or `blueprint/` is open. The post does not choose.
- **Are `Abstract.lean`, `Foundations.lean` and the placeholder design reasonable?**
  - Statement-first is endorsed (Annals Challenge).
  - Opaque placeholders are acceptable as visible holes.
  - Three changes are suggested:
    1. Every placeholder replacement gets an independent fidelity check (Comparator's
       definition-hole warning).
    2. Nothing durable is built over placeholders (value 10).
    3. Re-export aliases and the mixed Foundations file are reconsidered against "Avoid
       duplication" and "Document and organize". For example, use upstream names directly, and
       move each real definition to a Mathlib-style subject file.
- **What happens to each existing file.**
  - `references/papers/manifest.toml`: replaceable by citations in docstrings plus a
    `formalization.yaml` `sources` list (each entry has an `id` such as an arXiv ID with version,
    and a `location`) [R for the fields, J for the replacement].
  - ReviewKit's statement pin and axiom check: compare with core `lake check` / `lake comparator`
    (in core since Lean v4.35.0 [S]; present in the local `v4.36.0-rc2` toolchain [R]) before
    rebuilding them. They need `bwrap` (Linux) [R], so they do not replace a check that must run
    where no Linux sandbox is available.
  - `reviews/statement-pin.toml`: analogous to a Comparator challenge.
  - The rest (`glc/project.toml`, `blueprint/`, `prompts/`): no specific input from this source.
- **Who reviews the mathematics, and to what standard.**
  - The post's standard is that "a mathematician should be able to trust and verify" the
    concepts.
  - Tau Ceti's model is AI adversarial review against standard rubrics, with expert-curated
    roadmaps [R].
  - Mathlib's model is review by domain experts and Lean experts [R].
  - Suggestion: fresh-agent adversarial review against a written rubric for every change, *plus*
    an outside expert for the key definitions and the final statement. This matches PLAN.md's
    existing "no claim of faithfulness … without an outside expert".
- **Where research notes and session summaries live, and whether they are committed.**
  - "Review additions publicly" and "Publish freely" lean towards committing them in the public
    repository.
  - formalization.yaml also has fields for how AI was used (`prompting_notes`, automation `notes`)
    [R].

## 6. Questions for the owner

1. **Palomar-style metadata.** Should GLCinLean add a `formalization.yaml` and a `lake check` /
   `lake comparator` setup, so that the statement can be audited in the way the post's authors
   endorse? Should this replace parts of ReviewKit and `references/papers/manifest.toml`? The
   `lake` tools need a Linux sandbox (`bwrap`): is a Linux machine, VM or CI acceptable for them?
2. **Roadmap curation.** The post says Tau Ceti roadmaps are curated by mathematicians and
   formalisation experts. If GLCinLean proposes a geometric representation theory roadmap, will
   you look for an expert co-curator, or only propose items under existing roadmaps?
3. **Stacks code.** Given "Avoid duplication", should GLCinLean depend on `AxiomMath/Stacks` as a
   package, copy single declarations (current PLAN.md), or avoid it and write the Tau Ceti version
   instead?
4. **Good citizenship.** Should automated sessions also run general Tau Ceti work (reviews, bumps)
   through TauCetiWorker, as the ideas.md example prompt suggests? Or should they do only work
   GLCinLean needs?
5. **Outside expert.** The post asks that a mathematician can "trust and verify" the definitions.
   Is finding an outside expert for the key GLC definitions part of the plan, and when?
6. **Re-export aliases.** Should `Foundations.lean` keep its own names for upstream objects
   (readability of the abstract), or use Mathlib and Tau Ceti names directly (no duplication)?
