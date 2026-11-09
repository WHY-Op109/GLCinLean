# Status

Updated 2026-11-09.

## Now

- `GLCinLean/Abstract.lean` and `GLCinLean/Foundations.lean` still have the old design: four
  `sorry`s (the dual group's existence, Cor. 1.6.5's existence and uniqueness, the main
  theorem) and style warnings (no `module` line, the module docstring before the imports). Step 2
  redesigns them.
- `plans/` is empty; step 2 writes it.
- Tau Ceti pull requests in flight: none.

## Next

1. **Plan** (`prompts/plan.md`): the plan in `plans/`, and the redesigned statement.
2. **Build** (`prompts/build.md`) and **review** (`prompts/review.md`), repeated until the
   statement has no placeholders.

## Later

- A **refactor** prompt, when merged Tau Ceti contributions need adopting or reviews ask for
  restructuring; a **proof** prompt, once the statement is done. The proof is done when it builds
  with only `propext`, `Classical.choice` and `Quot.sound`.
- A Tau Ceti roadmap for geometric representation theory: none for now; ask Tau Ceti once a
  first layer (for example D-modules on schemes) exists here.
- The review system: its own repository later; requirements in `notes/ideas.md` at commit
  `728da79`.
