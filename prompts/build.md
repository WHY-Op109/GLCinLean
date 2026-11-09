# Step 3: build

**Goal.** Replace placeholders of the GLC statement by real definitions, working through
`blueprint.md` from the bottom up: take the objects whose dependencies are done, write them as
library code, and then use them in the statement. Parts a Tau Ceti roadmap covers go to Tau Ceti
through Tau Ceti's Worker; the rest is written here.

**Done when**
- the objects taken on in this session are defined, each with examples or test lemmas showing it
  behaves as expected, and the placeholders they replace are gone;
- Tau Ceti pull requests opened or tended in this session are listed in `STATUS.md`, and merged
  ones are used here (moving the Tau Ceti pin as `AGENTS.md` says);
- the done check in `AGENTS.md` passes;
- a fresh agent has reviewed every new or changed definition with `prompts/review.md`;
- a change to the statement, or to a definition it reaches, is not pushed until the owner has
  approved it: it is put to the owner together with the review, and the session waits;
- `blueprint.md` and `STATUS.md` are updated, the prompt for the next step has been checked and
  updated if needed, and the work is committed and pushed.

**Context**
- `blueprint.md` and `STATUS.md`: what is done, what is next, and what is in flight.
- Tau Ceti's Worker (https://github.com/TauCetiProject/TauCetiWorker; installed with
  `uv tool install`) runs outside this repository, under the owner's `gh` account, and opens pull
  requests from the owner's fork. Tau Ceti's README and the Worker's README are the authority; as
  read on 2026-11-08 [R]:
  - `--agent claude` must be set (the default prefers Codex); `--roadmap-only <area>` pins one
    roadmap area;
  - run a bare `tauceti work` round before ever using `--loop`; Tau Ceti discourages
    `--only roadmap`, which leaves existing pull requests untended;
  - a pull request labelled `awaiting-author` with no activity for 7 days is closed
    automatically, so open pull requests are tended at least weekly;
  - without the `--bubble` sandbox (which needs an Incus runtime) the agent runs with the owner's
    full credentials.
- No reviews of other people's Tau Ceti pull requests for now.
- The papers' TeX is in the git-ignored `references/papers/<id>v<version>/src/`.
