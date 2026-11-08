# Rebuilding GLCinLean: order of work and decisions

Agreed with the owner on 2026-11-08. The owner's ideas and references are in [`ideas.md`](ideas.md); the research is in [`research/`](research/) (start with [`research/summary.md`](research/summary.md)). This file holds the order of work, the decisions, and the questions still open.

## Order of work

0. **Research.** Done on 2026-11-08 (`prompts/research.md`, output in `notes/research/`); the owner answered the questions the same day (below).
1. **Rebuild** (one session; prompt `prompts/rebuild.md`). Write the short `AGENTS.md`, `STATUS.md` and the recurring prompts with `/prop` (goal, done when, context), and handle each existing file, following the decisions below and `notes/research/summary.md` §4.
   → The owner reads the diff.
2. **Plan** (recurring). The blueprint: each object of the GLC statement mapped to Mathlib, Tau Ceti, a Tau Ceti roadmap item, or missing; library versus statement. Redesign `Abstract.lean` and `Foundations.lean` (decision below). A fresh agent reviews it.
   → The owner reads the verdict.
3. **Build** (recurring). Tau Ceti roadmap parts go to Tau Ceti through Tau Ceti's Worker; the rest goes into this repository's library, then the GLC statement.
4. **Review** (recurring). Fresh agents check changed declarations against the papers and the standards.
5. **Refactor** (recurring). Adopt merged Tau Ceti contributions (moving the pin), act on reviews.
6. **Proof** (after the statement). The same plan → build → review loop.

Later, in its own repository: **the review system**, with its own prompt written when that repository is started.

## Decisions

**Files and instructions**
- **`AGENTS.md`** is short, written for agents in plain, understandable, structured words, following Anthropic's guidance. It holds (summary §4.1, items as numbered there): the goal (1); the writing style (2); the source order and Tau Ceti rules (3); links to Mathlib's style, naming and documentation pages plus the project's own facts (4); the placeholder rule, and never weakening what a statement says while removing a sorry or a placeholder (5); the build commands and the "done" check (6); when to commit, that pushing to `main` is wanted, and that agents may open Tau Ceti pull requests from the owner's fork (7). Not in it: contacting people (8), downloads and provenance (9), `CLAUDE.md` (10).
- **Prompts** hold only the goal, the completion criteria and the context, written with `/prop`. Every recurring prompt's "done when" includes: check the prompt for the next step and update it in the same commit (item 11; not in `AGENTS.md`).
- **`notes/workflow.md`** (this file) is deleted in step 1, once its content lives in `AGENTS.md`, `STATUS.md` and the prompts.
- **`PLAN.md`** is deleted; its content moves as summary §4.2 says, and a short committed `STATUS.md` records what is done, what is next, and Tau Ceti pull requests in flight.
- **No harness and no tools.** This is a plain, simple Lean project driven by prompts. Step 1 removes `glc/project.toml`, `reviews/`, the ReviewKit requirement and `tools/tracker`; `@[placeholder]` becomes a local attribute.
- **Papers:** `references/papers/manifest.toml` is dropped; a committed `docs/references.bib` records the arXiv id and version of every cited paper. The TeX files stay untracked.
- **Copyright and `Authors:` lines:** the contributors and the AI models, following Tau Ceti and Mathlib's documentation rules.
- **Evidence tags** ([R] read directly, [S] a source's claim about itself, [E] estimate, [J] judgement, with the date checked) stay. They are written in Markdown text about sources (notes, review reports, `STATUS.md`, commit messages), never in Lean code, where docstrings cite by BibTeX key and locator.
- **Research notes** are committed and public, without judgements about named people or the owner's private set-up details.

**The statement**
- **Scope:** GLC I Conj. 1.6.7: de Rham, characteristic 0, any algebraically closed field `k`; library interfaces keep the ground field and the coefficient field apart.
- **Placeholders** only in the statement surface: marked, shown as their own state, with characterising theorems where possible, replaced only together with examples; none in the library or in code meant for Tau Ceti.
- **Statement goal:** a sorry is not enough for what must be proved to state the final goal faithfully (well-definedness and the like); those results are proved in the statement phase. This covers the theorems needed to define 𝕃_G (the existence in Cor. 1.6.5, the spectral action, the bound from compact to coconnective objects).
- **Redesign:** step 2 may change the statement itself (drop the re-exports, rename, refine `LCoarse`, `IndCohNilp`, `IsEventuallyCoconnective`, `RootDatumDuality`, `DGCat`, `Setting`) as one change, with a fresh-agent review; the owner sees the diff.
- **Later changes to the statement** or to definitions it reaches: a fresh agent checks them with the review prompt, then the change waits for the owner's approval.
- **No warnings** in any Lean code, with one exception: a `sorry` warning on the proof of a lemma or theorem during the formalisation of the statement. What faithfulness of the statement requires (well-definedness and the like) never has a `sorry`.
- **Final check of the proof:** everything mechanical (it builds, no `sorry`, only `propext`, `Classical.choice` and `Quot.sound`, the kernel accepts it). Whether the statement matches the paper is human work.

**Versions and Tau Ceti**
- **Versions:** pin once to the newest existing Lean, Mathlib and Tau Ceti versions. Agents move the Tau Ceti pin only when merged Tau Ceti contributions are needed, choosing a commit with a ready-built cache. After the project is finished, the owner does any further upgrade.
- **Tau Ceti contributions:** roadmap parts go to Tau Ceti through Tau Ceti's Worker, run outside this repository; after they merge, GLCinLean uses them through its Tau Ceti dependency. No reviews of other people's pull requests for now.
- **Pushing:** sessions push to `main` of `WHY-Op109/GLCinLean` at important steps and open Tau Ceti pull requests from the owner's fork. The owner allows this for Claude Code's auto mode in their own settings.
- **Roadmaps:** none for now; ask Tau Ceti later, once a first layer exists here.
- **Never** open pull requests to Mathlib.

## Questions still open

- **After the blueprint is drafted:** how to use the open Tau Ceti roadmap pull requests (#1828, #999, #1056, #1202); how other Lean libraries may be used (AxiomMath/Stacks, stacks-and-moduli, the Langlands knowledge base, infinity-cosmos); the ∞-categorical layer.
- **When the review system is built:** its rubrics, what resets a review, and what it is built on (summary Q18–Q20).
- **For step 1:** the format of the blueprint, now that `tools/tracker` leaves this repository.
