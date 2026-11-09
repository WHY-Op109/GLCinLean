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
- a fresh agent has reviewed every new or changed definition with `prompts/review.md`, and a
  change to the statement waits for the owner's approval;
- `blueprint.md` and `STATUS.md` are updated, the prompt for the next step has been checked and
  updated if needed, and the work is committed and pushed.

**Context**
- `blueprint.md` and `STATUS.md`: what is done, what is next, and what is in flight.
- Tau Ceti's Worker (https://github.com/TauCetiProject/TauCetiWorker) runs outside this
  repository; `notes/research/further-tau-ceti-worker-the-agent-harness-and-it.md` and
  `notes/research/tauceti-contributing.md` describe how to run it (for example
  `--agent claude` and one pinned roadmap area) and Tau Ceti's rules: tend open pull requests at
  least weekly, or Tau Ceti's 7-day rules close them.
- No reviews of other people's Tau Ceti pull requests for now.
- The papers' TeX is in the git-ignored `references/papers/<id>v<version>/src/`.
