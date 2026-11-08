# Step 0: research

**Goal.** Before the project is rebuilt, gather all the context the rebuild needs: read every reference in `notes/ideas.md`, search for further references that would help, and audit what this repository already contains. The findings feed step 1 of `notes/workflow.md`, so they should make clear what each source means for this project, where sources disagree with each other or with `notes/ideas.md`, and what the owner must decide.

**Done when**
- `notes/research/` has a note for each reference in `notes/ideas.md`, for each further reference found, and for the audit of this repository;
- `notes/research/summary.md` says what the findings change in the plan, lists contradictions, says what the findings suggest for each question under "Questions for after the research" in `notes/workflow.md`, and ends with the questions for the owner;
- the work is committed and pushed.

**Context**
- `notes/ideas.md`: the owner's goals, principles and references. `notes/workflow.md`: the order of work, the decisions already taken, and the open questions. `AGENTS.md`: working notes.
- Besides the references in `notes/ideas.md`, the rebuild needs:
  - Anthropic's official guidance on agent instruction files (`AGENTS.md`/`CLAUDE.md`) and on writing prompts;
  - Tau Ceti's contribution requirements and how it moves to new Lean and Mathlib versions, since both are to be fully automated here.
- The audit covers `GLCinLean/Abstract.lean`, `GLCinLean/Foundations.lean` and their placeholder design, `PLAN.md`, `prompts/`, `blueprint/`, `reviews/`, `glc/project.toml`, the ReviewKit and tracker requirements in `lakefile.toml`, and `references/papers/manifest.toml`.
- The GLC papers are not in the repository. Their TeX sources can be downloaded from arXiv into `references/papers/`, which Git ignores.
- Subagents may work in parallel, for example one per reference.
