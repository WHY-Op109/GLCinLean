# Rebuilding GLCinLean: order of work and decisions

Agreed with the owner on 2026-11-08. The owner's ideas and references are in
[`ideas.md`](ideas.md); this file holds the order of work, the decisions taken since, and the
questions left for after the research.

## Order of work

0. **Research** (one session, subagents in parallel; prompt `prompts/research.md`). Read every
   reference in `ideas.md` and search for more; audit the existing repository. Output: notes per
   reference and a summary with questions for the owner (`notes/research/`).
   → The owner reads the summary and answers the questions.
1. **Rebuild** (one session). From the research, decide what goes in `AGENTS.md`, whether
   `PLAN.md` stays, what happens to each existing file, and how a session updates the prompt
   for the next one. Write `AGENTS.md` and the recurring prompts with `/prop` (goal, done when,
   context). Propose changes to the owner's files rather than making them.
   → The owner reads the diff.
2. **Plan** (recurring). The blueprint: each object of the GLC statement mapped to Mathlib, Tau
   Ceti, a Tau Ceti roadmap item, or missing; backbone versus surface. Decide whether
   `Abstract.lean`, `Foundations.lean` and their placeholders stay or change. A fresh agent
   reviews it.
   → The owner reads the verdict.
3. **Build** (recurring). Tau Ceti roadmap items become Tau Ceti pull requests; the rest goes
   into this repository's backbone, then the GLC statement surface.
4. **Review** (recurring). Fresh agents check changed declarations against the papers and the
   standards.
5. **Refactor** (recurring). Bump the Tau Ceti pin, adopt new upstream code, act on reviews.
6. **Proof** (after the statement). The same plan → build → review loop.

Alongside, in its own repository: **the review system**, started after step 0, with its own
prompt written in step 1.

After every session: check whether the next prompt needs changing; the owner sees any change in
the commit.

## Decisions

- **Shared context** lives in `AGENTS.md`; there is no separate `main.md`. `AGENTS.md` is short
  and written for agents: the main goal, and the requirement that all text uses plain,
  understandable, structured words. It follows Anthropic's official guidance for such files.
- **Prompts** hold only the goal, the completion criteria and the context, with few
  constraints, written with `/prop`.
- **Prompts change as work goes on.** A session's output may change the next prompt, so each
  session checks the prompt for the next step and updates it if needed. (Where this rule is
  written down is decided in step 1.)
- **Commit and push** at important steps: after finishing each prompt's session, and at
  important steps during formalisation. Agents push themselves.
- **Tau Ceti contributions are fully automated**, following Tau Ceti's own requirements.
- **Keeping up with Mathlib and Tau Ceti is fully automated**, including their Lean version.

## Questions for after the research

Raised on 2026-11-08 and deliberately left open until the research is done:

- What exactly goes into `AGENTS.md`, and where the rule "update the next prompt" lives.
- Whether `PLAN.md` is needed, given that the prompts carry the plan.
- Whether `GLCinLean/Abstract.lean`, `GLCinLean/Foundations.lean` and their placeholder design
  are reasonable, or need to change.
- What happens to each existing file (the ReviewKit requirement in `lakefile.toml`, the
  `@[placeholder]` attribute it provides, `glc/project.toml`, `reviews/`, `blueprint/`,
  `prompts/`, `references/papers/manifest.toml`).
- Who reviews the mathematics (fresh agents, an outside expert), and to what standard.
- Where research notes and session summaries live, and whether they are committed.

## Known conflicts with the current files

The decisions above replace these older statements; step 1 updates the files:

- `PLAN.md`: "Sessions commit locally; the owner reads and pushes" and "nothing is sent to
  other projects unless the owner chooses".
- `AGENTS.md`: "`lake update` moves the pins, so it is best left to the owner", and the
  owner's-files note covering `lakefile.toml`, `lake-manifest.json` and `lean-toolchain`.
