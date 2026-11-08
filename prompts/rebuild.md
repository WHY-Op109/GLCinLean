# Step 1: rebuild

**Goal.** Turn GLCinLean into a pure, simple Lean project like NumLib-Auto, driven only by prompts. First delete every file that is not necessary, then write what remains: a light `AGENTS.md`, a short `STATUS.md`, and only the prompts the next steps need. Now the work is formalising the statement, so tools are not needed.

**Done when**
- every file that is not necessary is gone, including:
  - `tools/` (the tracker submodule) and the ReviewKit requirement;
  - `reviews/` and `glc/project.toml`;
  - `references/papers/manifest.toml`, and papers that are not needed;
  - `PLAN.md` and `notes/workflow.md`, once their content lives in `AGENTS.md`, `STATUS.md` and the prompts;
  - notes whose content now lives sufficiently in another place;
- `AGENTS.md` is light and simple, follows the owner's answers in `notes/workflow.md` and Anthropic's official guidance, and holds only the items listed there;
- `STATUS.md` exists, `docs/references.bib` records the arXiv id and version of every cited paper, and the prompts the next steps need exist, written with `/prop` (goal, done when, context). Each recurring prompt's "done when" includes checking the prompt for the next step and updating it in the same commit;
- the project builds with `lake build`;
- the prompt for step 2 has been checked and updated if needed;
- the work is committed and pushed.

**Context**
- `notes/workflow.md`: the owner's decisions and the questions still open; it is the source of truth for this step, and is deleted at its end. One open question is for this step: the blueprint's format, now that `tools/tracker` leaves.
- `notes/research/summary.md`, §4 in particular, says where each file's content should go. The other notes in `notes/research/` hold the evidence.
- `notes/ideas.md`: the owner's goals and principles.
- NumLib-Auto (https://github.com/bridgekat/numlib-auto) is the model for the project's shape; see `notes/research/numlib-auto.md`.
- The Lean files keep their current design; step 2 redesigns them. Here they only need to build without ReviewKit (`@[placeholder]` becomes a local attribute).
