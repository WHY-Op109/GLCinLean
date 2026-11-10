# Step 3: build

**Goal.** Replace placeholders of the GLC statement by real definitions, working through
the plan in `plans/` from the bottom up. Read `plans/README.md` before choosing a task.
Use `lake exe tracker ready` to find candidates, then inspect their provider, paper locator and
suggested dependencies: placeholders count as proved, and existing upstream declarations that
are not imported can appear open. Write missing library code, then use it in the statement. Parts a Tau Ceti roadmap covers go to Tau Ceti
through Tau Ceti's Worker; the rest is written here.

**Done when**
- the objects taken on in this session are defined, each with examples or test lemmas showing it
  behaves as expected, and the placeholders they replace are gone;
- Tau Ceti pull requests opened or tended in this session are listed in `STATUS.md`, and merged
  ones are used here (moving the Tau Ceti pin as `AGENTS.md` says);
- the done check in `AGENTS.md` passes, including `lake env lean tools/check-statement-axioms.lean`
  after updating that audit for any renamed or added statement declarations; no definition may
  depend on `sorryAx`, and only the main theorem may use it;
- a fresh agent has reviewed every new or changed definition with `prompts/review.md`;
- a change to the statement, or to a definition it reaches, is not pushed until the owner has
  approved it: it is put to the owner together with the review, and the session waits;
- `plans/` and `STATUS.md` are updated (`lake exe tracker lint` passes), the prompt for the next step has been checked and
  updated if needed, and the work is committed and pushed.

**Context**
- The current statement is `GLCinLean/Statement/Conjecture.lean`; its enhanced placeholders are
  in `GLCinLean/Statement/Enhanced.lean`. The main theorem states existence and equivalence of
  every characterized functor; preserve that shape.
- `docs/blueprint-providers.md` records exact provider revisions, accepted roadmap targets and
  open proposal heads. Recheck upstream main and proposal state before implementation. The
  three policy answers in `STATUS.md` are proposals until the owner decides.
- Existing Mathlib quasicategories and Tau Ceti DG nerves, mapping spaces and K-injective
  comparisons must be reused. Ordinary derived categories are not replacements for enhanced
  categories. Field, universes, module actions and t-structures must remain explicit.
- Every placeholder replacement needs a nontrivial example. In particular test a nonempty
  geometric setting, a singular derived affine, zero singular support and torus normalization
  as appropriate; a zero-category interpretation is not an implementation of GLC.
- `plans/` (read with `lake exe tracker status`, `ready` and `show`) and `STATUS.md`: what is done, what is next, and what is in flight.
- Tau Ceti's Worker (https://github.com/TauCetiProject/TauCetiWorker; installed with
  `uv tool install`) runs outside this repository, under the owner's `gh` account, and opens pull
  requests from the fork `WHY-Op109/TauCeti`. Tau Ceti's README and the Worker's README are the authority; as
  read on 2026-11-08:
  - `--agent claude` must be set (the default prefers Codex); `--roadmap-only <area>` pins one
    roadmap area;
  - run a bare `tauceti work` round before ever using `--loop`; Tau Ceti discourages
    `--only roadmap`, which leaves existing pull requests untended;
  - a pull request labelled `awaiting-author` with no activity for 7 days is closed
    automatically, so open pull requests are tended at least weekly;
  - without the `--bubble` sandbox (which needs an Incus runtime) the agent runs with the owner's
    full credentials.
- No reviews of other people's Tau Ceti pull requests for now.
- When a paper is wrong, mark the planned declaration `wrong` and amend the plan.
- The papers' TeX is in the git-ignored `references/papers/<id>v<version>/src/`. A missing paper is fetched from arXiv as `https://arxiv.org/e-print/<id>v<version>` (the versions are in `docs/references.bib`) and unpacked into `src/`.
