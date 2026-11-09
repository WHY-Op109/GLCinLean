# Status

Updated 2026-11-09.

## Done

- **Research** (2026-11-08): its findings for the next steps are in `prompts/plan.md` and
  `prompts/build.md`; the full notes, the owner's ideas (`notes/ideas.md`) and the decisions of
  2026-11-08 (`notes/workflow.md`) are in commit `728da79`.
- **Rebuild** (2026-11-09): a plain Lean project driven by prompts. The review harness, the
  paper manifest and the old plan are gone; `AGENTS.md`, this file, `docs/references.bib` and
  the prompts for steps 2–4 are new. The tracker (`tools/tracker`, a git submodule at `c223b67`)
  reads the plan in `plans/`, which step 2 writes.

## Now

- `GLCinLean/Abstract.lean` and `GLCinLean/Foundations.lean` still have the old design: four
  `sorry`s (the dual group's existence, Cor. 1.6.5's existence and uniqueness, the main
  theorem) and style warnings (no `module` line, the module docstring before the imports). Step 2
  redesigns them.
- Tau Ceti pull requests in flight: none.

## Next

1. **Plan** (`prompts/plan.md`): the plan in `plans/`, and the redesigned statement.
2. **Build** (`prompts/build.md`) and **review** (`prompts/review.md`), repeated until the
   statement has no placeholders.

## Later

- A **refactor** prompt, when merged Tau Ceti contributions need adopting or reviews ask for
  restructuring; a **proof** prompt, once the statement is done. The proof is done when it builds
  with only `propext`, `Classical.choice` and `Quot.sound`; whether the statement matches the
  paper is human work.
- A Tau Ceti roadmap for geometric representation theory: none for now; ask Tau Ceti once a
  first layer (for example D-modules on schemes) exists here.
- **The review system**, in its own repository, with its own prompt written when it starts. The
  owner wants: a tool built on [tracker](https://github.com/bridgekat/tracker) (a rewrite of
  [reviewkit](https://github.com/WHY-Op109/reviewkit), or a new one) that takes a Lean project
  documented in Mathlib style and generates a web page with the dependency graph and review tags.
  Each declaration that needs review is tracked by the Git commit at which it was reviewed: it
  shows as reviewed while unchanged, and as needing review again once a refactor changes it.
  Open: its rubrics, what resets a review, and what it is built on. Research for it (tracker,
  reviewkit, NumLib-Auto, NLAlib, Verso Blueprint, LeanArchitect, Lean Metrics, Lean Quality
  Indicators, Tau Ceti Review) is in commit `728da79`.

## For the owner

- Allow `TauCetiProject/TauCeti` and your fork for Claude Code's auto mode in your own settings,
  so sessions can open Tau Ceti pull requests.
