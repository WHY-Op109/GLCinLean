# Anthropic guidance on instruction files and prompts

- **Source:** Anthropic's official documentation for Claude Code and for prompting Claude, plus
  four posts on Anthropic's engineering blog.
- **Checked 2026-11-08.** The docs have no commit or version number, so each page is fixed by
  its URL, the retrieval date and the first 12 hex digits of the SHA-256 of the Markdown copy
  fetched that day. Local copies are in `.lake/research/anthropic-guidance/` (Git ignores it).
  The installed Claude Code is v2.1.319.

  | Page | URL | SHA-256 (12) |
  | --- | --- | --- |
  | How Claude remembers your project (CLAUDE.md, AGENTS.md, auto memory) | <https://code.claude.com/docs/en/memory.md> | `275fe39e8501` |
  | Best practices for Claude Code | <https://code.claude.com/docs/en/best-practices.md> | `fe692b7566e6` |
  | Keep Claude working toward a goal (`/goal`) | <https://code.claude.com/docs/en/goal.md> | `752950e95dee` |
  | Create custom subagents | <https://code.claude.com/docs/en/sub-agents.md> | `db8a532d4c04` |
  | Extend Claude with skills | <https://code.claude.com/docs/en/skills.md> | `977bb9f8d6a0` |
  | Extend Claude Code (features overview) | <https://code.claude.com/docs/en/features-overview.md> | `41ddb642f22c` |
  | Prompting best practices (all current models) | <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices.md> | `fb1ad4a72da8` |
  | Prompting Claude Opus 5.5 | <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5.md> | `0203e04ee828` |
  | Prompting Claude Opus 5 | <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5.md> | `b34cb10619cc` |
  | Prompting Claude Fable 5.1 | <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-fable-5-1.md> | `8f323d954727` |
  | Prompting Claude Fable 5 (added in the check) | <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-fable-5.md> | `d809aae83b41` |
  | Permission modes, auto mode (added in the check) | <https://code.claude.com/docs/en/permission-modes.md> | `edb867988c95` |
  | Configure auto mode (added in the check) | <https://code.claude.com/docs/en/auto-mode-config.md> | `ed00ec1d8731` |
  | Settings reference (added in the check) | <https://code.claude.com/docs/en/settings-reference.md> | `93c77ec892dd` |
  | Context window, what survives compaction | <https://code.claude.com/docs/en/context-window.md> | `2450823ff399` |
  | Run Claude Code programmatically (`-p`, `--bare`) | <https://code.claude.com/docs/en/headless.md> | `62359e4f8585` |

  An independent check on 2026-11-08 fetched the first ten pages again: every hash above
  matched, and the quotes in §2 were compared against those copies and against fresh copies of
  the four blog posts. Pages marked "added in the check" were read for the first time then. [R]

  Engineering blog posts, fixed by their publication dates:
  - "Effective context engineering for AI agents", 2025-09-29,
    <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>.
  - "Effective harnesses for long-running agents", 2025-11-26,
    <https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents>.
  - "Harness design for long-running application development", 2026-03-24,
    <https://www.anthropic.com/engineering/harness-design-long-running-apps>.
  - "How we built our multi-agent research system", 2025-06-13,
    <https://www.anthropic.com/engineering/multi-agent-research-system> (skimmed).
  - The old post `anthropic.com/engineering/claude-code-best-practices` now gives HTTP 308 to
    `code.claude.com/docs/en/best-practices`, so the docs page replaces it. [R]
- **Licence:** none is stated for copying. This note quotes short passages only.
- **Not read:** "Building effective agents" (Dec 2024), which the 2026 harness post cites for
  "find the simplest solution possible"; the prompt-engineering tutorial on GitHub (written for
  Claude 3, and the docs say to follow the newer page where the two differ). [R]

Tags: [R] read directly on 2026-11-08; [S] a source's claim about itself; [E] estimate; [J]
judgement. A tag covers the sentence or bullet it ends.

---

## 1. What it is

- **Claude Code docs** (code.claude.com): how Claude Code loads `CLAUDE.md` and `AGENTS.md`,
  what to put in them, what to move into skills, hooks or settings, how `/goal` decides that a
  task is done, what context a subagent starts with, and what auto mode lets a session push
  or open without asking. [R]
- **Prompting docs** (platform.claude.com): general prompting rules for current Claude models
  (clear and direct, give context, structure, long-horizon state), plus one page per model on
  how it differs from the one before. [R]
- **Engineering posts**: Anthropic's own experiments with agents that run for hours across many
  context windows, and with keeping the agent that does the work apart from the agent that
  judges it. [R]

## 2. What it says that matters for GLCinLean

### 2.1 Claude Code reads `AGENTS.md` directly

- "Claude Code can read `AGENTS.md` as your project instructions, so a repository already set
  up for other coding agents works without adding a `CLAUDE.md`, an import, or a setting." This
  needs v2.1.277 or later. [R] (memory.md, "AGENTS.md")
- By default it reads `AGENTS.md` **only when there is no `CLAUDE.md`, `.claude/CLAUDE.md` or
  `CLAUDE.local.md`** in the working directory or any directory above it. `~/.claude/CLAUDE.md`,
  a managed `CLAUDE.md` and `.claude/rules/` don't count for that check. [R]
- The docs warn that "Because `CLAUDE.local.md` counts, adding one … stops Claude from reading
  `AGENTS.md` for you." Running `/init` writes a `CLAUDE.md`. Either would quietly turn
  `AGENTS.md` off. [R]
- `@path` imports work inside `AGENTS.md`. `AGENTS.local.md`, `AGENTS.override.md` and anything
  under `.agents/` are never read. [R]
- If a session can't read `AGENTS.md` directly, the documented fix is a `CLAUDE.md` holding
  `@AGENTS.md`, or a symlink. A `CLAUDE.md` that only *tells* Claude in words to read
  `AGENTS.md` doesn't work reliably: "Claude sees `AGENTS.md` only if it decides to open the
  file." [R]
- A second safeguard exists: setting **Project instructions** to `claude-md-and-agents-md`
  makes Claude read both files, so a stray `CLAUDE.md` or `CLAUDE.local.md` no longer hides
  `AGENTS.md`. It is set with `/config` or under `pluginConfigs` →
  `cc-plugin-agents-md@builtin` in `~/.claude/settings.json`; Claude Code "ignores it in project
  and local settings files", so it cannot be committed to the repository. [R]
- `InstructionsLoaded` hooks don't fire for an `AGENTS.md` read directly (they do for one
  imported from a `CLAUDE.md`). This matters only if the project adds hooks. [R]
- **This repository today:** there is no `CLAUDE.md` in the repository. The installed version is 2.1.319, so `AGENTS.md` loads
  directly. It did in this session: its text arrived as project instructions. [R]
- `claude -p --bare` skips "hooks, skills, … subagents, installed plugins, MCP servers, auto
  memory, and CLAUDE.md". [R] (headless.md) The built-in reader for `AGENTS.md` is a plugin, so
  bare runs probably skip `AGENTS.md` too. [E]

### 2.2 What an instruction file should hold, and how long it should be

- **Length:** "target under 200 lines per CLAUDE.md file. Longer files consume more context and
  reduce adherence." Imports help you organise a file but don't lower its cost. Claude Code
  skips a file over 4 MiB. [R] (memory.md)
- **Content test** (best-practices.md, "Tell Claude what it can't see"): "Only write down what
  Claude can't find by reading the repo, or what it would otherwise spend time rediscovering
  every session." The check is two questions: "Could it find this by reading the code? Would it
  actually go and look? If both are yes, leave it out." [R]
- **What belongs** ("Keep CLAUDE.md short") [R]:
  - how to confirm work: "the exact test, typecheck, and lint commands";
  - places where the code is misleading;
  - "Decisions that aren't in the repo";
  - "Anything you've had to correct twice already".
- **What to leave out:** the docs list "Describe your architecture and file layout in
  `CLAUDE.md`" as advice you can stop following ("Claude reads the repo itself"). `/doctor`
  proposes cutting "directory layouts, dependency lists, and architecture overviews" and keeping
  "pitfalls, rationale, and conventions that differ from tool defaults". [R]
- **Wording:** instructions should be concrete enough to check ("Run `npm test` before
  committing", not "Test your changes"). Group them under headers and bullets. If two
  instructions contradict each other, "Claude may pick one arbitrarily". [R]
- **No emphasis:** "Add IMPORTANT or ALL CAPS" is listed as outdated, because "piling on
  emphasis mostly makes Claude over-apply the rule." If a line keeps getting missed, the file is
  too long or the line belongs in a hook. [R]
- **Give the reason:** the prompting guide says "Providing context or motivation behind your
  instructions … can give Claude more information about your goals", and "Claude can generalize
  from the explanation." [R]
- **The single most useful line:** "If your repo already has one of these [checks], the single
  most useful line in your `CLAUDE.md` is the command that runs it." [R]
- **Where other kinds of instruction go** [R]:
  - multi-step procedures, or rules for one part of the code → a skill
    (`.claude/skills/<name>/SKILL.md`, loaded only when used) or a path-scoped rule
    (`.claude/rules/*.md` with `paths:`);
  - rules that may never have an exception → a hook, a deny rule or a managed setting, because
    "CLAUDE.md is for guidelines, and Claude is allowed to decide a guideline doesn't apply";
  - but "keep the enforced set small … If you ever find yourself at forty of them, most are
    probably preferences that Claude could have weighed on its own."
- **Checking the file:** `/doctor prompt-audit` (v2.1.283 or later) reports instructions
  written for older models, references to missing files, and contradictions between instruction
  files, including `AGENTS.md`. It changes nothing until asked. `/context all` lists which
  instruction files loaded. [R]
- **Who gets the file:** project instructions reach every non-fork subagent ("any `AGENTS.md`
  files loaded as project instructions"), except the built-in Explore and Plan agents and
  subagents whose definition sets `omitClaudeMd: true`. Auto memory does **not** reach
  subagents. [R] (sub-agents.md, "What loads at startup")
- **Auto memory** (`~/.claude/projects/<project>/memory/`) is "machine-local … not shared
  across machines or cloud environments". Only the first 200 lines or 25 KB of `MEMORY.md`
  load. [R]
- A project-root `CLAUDE.md` survives `/compact`: Claude Code re-reads it from disk. An
  instruction given only in the conversation can be lost at compaction. [R] The compaction
  table names only "Project-root CLAUDE.md and unscoped rules"; it doesn't say whether an
  `AGENTS.md` read directly is re-injected the same way. It probably is, but that is not
  documented. [E]

### 2.3 Prompts: goal, done when, context

- **Be clear and direct:** "Think of Claude as a brilliant but new employee who lacks context on
  your norms and workflows." The test: show the prompt to a colleague with little context; "If
  they'd be confused, Claude will be too." Use numbered steps only "when the order or
  completeness of steps matters". [R] (prompting best practices)
- **Name what you want:** "If you want Claude to do more than the task strictly requires,
  explicitly request it." Claude Code's best practices add that "be ambitious" still helps,
  because Claude "tends to read a request conservatively and build the smallest thing that
  satisfies it". [R]
- **Pitch it at the right level:** system prompts should sit at "the right altitude", between
  "hardcoding complex, brittle logic" and "vague, high-level guidance that … falsely assumes
  shared context". Aim for "the minimal set of information that fully outlines your expected
  behavior", and note that "minimal does not necessarily mean short". [R] (context engineering
  post)
- **Constrain the deliverables, not the path.** The 2026 harness post kept its planner to
  product context and high-level design because errors in a detailed upfront spec "would cascade
  into the downstream implementation"; "It seemed smarter to constrain the agents on the
  deliverables to be produced". [R]
- **Done when, as a check:** "Claude stops when the work looks done. If it has nothing to run
  that tells it whether the work actually *is* done, 'looks done' is all it has to go on." Give
  it something that "comes back pass or fail", and ask for *evidence*: "the command it ran and
  its output". [R] (best-practices.md)
- **`/goal`** (goal.md) [R]:
  - After every turn, a small fast model checks the condition against the conversation. It
    "doesn't run commands or read files independently, so write the condition as something
    Claude's own output can demonstrate."
  - A good condition has "One measurable end state", "A stated check" and "Constraints that
    matter".
  - The condition can be at most **4,000 characters**. A turn clause such as "or stop after 20
    turns" bounds the run.
  - Background subagents defer the check. The goal survives `--resume`. It works under
    `claude -p "/goal …"`.
  - "A goal doesn't change your permission mode. To let goal turns run unattended, run `/goal`
    in auto mode." It is a prompt-based `Stop` hook, so it needs workspace trust and is off
    when `disableAllHooks` is set.
  - The evaluator judges only what Claude has written in the conversation. A claim such as
    "the build passes" without the command's output is all it has to go on, so the "done when"
    should ask for the output itself (see "Ground progress claims" below). The second sentence
    is [J].
- **Before an unattended run**, five questions: does it know what done looks like; can it check
  its own work; what may it touch; what stops it (`--max-turns`, `--max-budget-usd`); where does
  the result go, and who signs off. [R]
- **Instructions that current models no longer need** [R]:
  - "think hard", "be thorough" (effort is the control; Claude Code best practices);
  - "keep going, loop until done, don't be lazy" ("more likely to cause over-work than fix a
    stall"; same page, which adds that "Giving Claude a check to pass is different, and still
    worth doing");
  - explicit verification steps, **on Opus 5 only**: "If your prompt contains explicit
    verification instructions (… 'use a subagent to verify'), remove them: instructions like
    these cause over-verification on Claude Opus 5", and the same goes for "double-check your
    answer". The Opus 5.5 page lists only differences from Opus 5 and does not reverse this, so
    it probably still holds for Opus 5.5 [E]. The Fable 5 page says the opposite for long runs
    (see §2.5 and §4), so this is model-specific advice, not a rule for "current models".
- **Long unattended runs (Opus 5.5, Fable 5.1):**
  - Opus 5.5 sometimes ends a turn with a progress report while work is still open. The
    suggested fix is a checklist the model updates, plus a completion condition checked each
    turn (what `/goal` does), stopping "after two or three automatic continuations". [R]
  - Fable 5.1 suggests a standing block that begins "You are operating autonomously. The user is
    not watching in real time…". [R]
  - Two pages offer a scope block: Opus 5 ("Deliver what was asked, at the scope intended …
    rather than quietly narrowing, widening, or transforming it") and Fable 5.1 ("# Delivering
    work … don't quietly narrow, widen, or swap it"; extras are "a suggestion to make at the
    end"). The Opus 5.5 page has no such block. [R]
- **Ground progress claims (Fable 5):** on long autonomous runs, tell the model to "audit each
  claim against a tool result from this session. Only report work you can point to evidence
  for"; in Anthropic's testing this "nearly eliminated fabricated status reports". [R]/[S] This
  is the same idea as asking for the command and its output in a "done when", and it matters
  most under `/goal`, whose evaluator sees only the transcript. [J]
- **Length of written files:** Opus 5 writes longer documents; the suggested line is "Match the
  length of written documents to what the task needs … do not pad". [R]
- **Plain prose:** Fable 5.1 can write dense, "mannered prose"; the short fix "Please remove all
  mannered prose" also tends to work. [R] This matches the owner's "plain, understandable,
  structured words". [J]
- **Format:** XML tags or Markdown headers both work to separate sections, "although the exact
  formatting of prompts is likely becoming less important as models become more capable". [R]
  (context engineering post, not the prompting docs) For long documents (20k+ tokens), put the
  documents first and the question last ("Queries at the end can improve response quality by up
  to 30 percent"), and ask for quotes first. [R] (prompting best practices) This applies when a
  review prompt includes paper text. [J]

### 2.4 Work that spans sessions

- Recommended state across sessions [R] (prompting best practices; 2025 harness post):
  - git, which "provides a log of what's been done and checkpoints";
  - a free-text progress file (`claude-progress.txt`, `progress.txt`);
  - a structured list of what remains (`feature_list.json`, `tests.json`), each item marked
    passing or failing.
- The 2025 harness used JSON for that list because "the model is less likely to inappropriately
  change or overwrite JSON files compared to Markdown files". [R]
- Its failure modes were trying to do everything at once, and a later session that "would look
  around, see that progress had been made, and declare the job done". The fixes were working
  "on only one feature at a time", a commit plus a progress note at the end of each session,
  and a startup routine: `pwd`, read the progress file and the git log, run a basic test. [R]
  These experiments used Opus 4.5 and Sonnet 4.5; the 2026 post reports that Opus 4.5 "largely
  removed" the context anxiety that made context resets necessary. [R]
- **A memory file (Fable 5):** the model "performs particularly well when it can record lessons
  from previous runs"; the suggested note rule is "one lesson per file … Don't save what the repo
  or chat history already records … delete notes that turn out to be wrong". [R] In this
  project such a file would have to be committed, since auto memory is machine-local. [J]
- "Use a different prompt for the very first context window" (set-up), then a recurring prompt
  for later windows. [R] This is the split between the research and rebuild prompts and the
  recurring prompts in `notes/workflow.md`. [J]
- **The harness should shrink as models improve:** "every component in a harness encodes an
  assumption about what the model can't do on its own, and those assumptions are worth stress
  testing … they can quickly go stale as models improve." With Opus 4.6 the author removed the
  sprint structure and moved the evaluator to a single pass at the end. [R]

### 2.5 Review by a separate agent

- **Self-review is lenient:** "When asked to evaluate work they've produced, agents tend to
  respond by confidently praising the work." Keeping the agent doing the work apart from the
  agent judging it "proves to be a strong lever", and tuning a separate evaluator to be
  skeptical "turns out to be far more tractable". [R] (2026 harness post)
- **Untuned reviewers are weak:** "Out of the box, Claude is a poor QA agent": it found real
  issues, then "talk[ed] itself into deciding they weren't a big deal". The fix was to read the
  evaluator's logs, find where its judgment differed from the author's, and update its prompt;
  this took several rounds. [R]
- **Reviewers find something:** "A reviewer that's asked to find problems will always find
  *something*", so tell it what to skip (for example "skip style"). [R] (best-practices.md)
- **Same model, fresh eyes:** a subagent is the same model; "A fresh reviewer does help, because
  it hasn't seen your reasoning, which is a different thing from delegating." [R]
- **Read-only reviewer:** a custom subagent in `.claude/agents/` with only
  `tools: Read, Grep, Glob` can't edit anything, and Claude Code enforces that. [R]
- **Judge the end state:** the multi-agent research post recommends judging whether the agent
  "achieved the correct final state" rather than whether it followed a set process. [R]
- **Fresh verifiers beat self-critique (Fable 5):** under "Recommended scaffolding changes":
  "Make self-verification explicit in long-run prompts. Separate, fresh-context verifier
  subagents tend to outperform self-critique." [R] This is the opposite of the Opus 5 advice in
  §2.3; see §4.
- **What a custom subagent still sees:** even with `omitClaudeMd: true` it gets the git status
  snapshot (branch, `git status`, recent commits), and "You can't change which subagents receive
  git status. Only Explore and Plan skip it." With `Read`/`Grep`/`Glob` it can also open any
  file in the repository, `AGENTS.md` included. [R]

### 2.6 Subagents and cost

- Subagents start with a fresh context window. They see only the delegation message, their own
  system prompt, the project instructions (see 2.2) and a git status snapshot, not the parent
  conversation. [R]
- Limits [R]:
  - nesting depth defaults to 3 (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`);
  - 20 subagents can run at once (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`);
  - a startup warning appears when custom subagent descriptions together pass 15,000 tokens.
- Recent models delegate readily. The Opus 5 guide offers a damping line: "Delegate to a
  subagent only for large tasks that are genuinely independent and parallelizable". [R]
- Each delegation must state "an objective, an output format, guidance on the tools and sources
  to use, and clear task boundaries"; otherwise agents duplicate work or leave gaps. [R]
  (multi-agent post)
- Anthropic measured multi-agent systems using about 15× the tokens of a chat. [S]

### 2.7 Pushing, pull requests and auto mode (added in the check)

- **The built-in git rule.** Claude Code puts its own commit and PR instructions in the Bash
  tool's description. In this session they read "Commit or push only when the user asks. If on
  the default branch, branch first." [R] The setting `includeGitInstructions: false` removes
  those instructions together with the git status snapshot. [R] (settings-reference.md)
- **Project instructions outrank that default.** In this session `AGENTS.md` arrived wrapped
  in the line "These instructions OVERRIDE any default behavior and you MUST follow them exactly
  as written." [R] So a plain `AGENTS.md` line that says when to commit, push and open PRs
  should be enough for the agent itself. [J]
- **Auto mode's classifier is a separate check.** Its documented defaults [R]
  (permission-modes.md, "What the classifier blocks by default"):
  - *allowed:* "Pushing to any branch of the repository you're working in, including the
    default branch", and creating a pull request that matches the request;
  - *blocked:* "Opening a pull request against a different repository or organization,
    forking with `gh repo fork`, or pushing to a third-party repository, unless you named that
    external target";
  - *blocked:* "Merging a pull request no human has approved, approving Claude's own pull
    request, or disabling CI checks";
  - *blocked:* "Launching an autonomous agent loop that runs without human approval or a
    sandbox, such as one started with `--dangerously-skip-permissions` … running a third-party
    agent or eval harness with isolation and per-action approval disabled";
  - *blocked:* `git commit --amend` on a pushed commit, force pushes, and changing remotes with
    `git remote add` / `set-url` unless you named the new remote.
- **What the classifier reads.** "The classifier reads the same CLAUDE.md content Claude itself
  loads" (auto-mode-config.md), plus user messages and tool calls. [R] Whether an `AGENTS.md`
  read directly counts as that content, and whether naming Tau Ceti in it counts as "you named
  that external target", is not stated. [E] Approvals stated in conversation can be lost at
  compaction. The durable route is `autoMode.environment` or `autoMode.allow` (always keeping
  `"$defaults"`) in `~/.claude/settings.json`, since "the classifier ignores `autoMode` in
  project settings". [R] After three blocks in a row, or twenty in total, auto mode pauses and
  goes back to asking. [R]

## 3. What it means for GLCinLean

1. **Keep one file, `AGENTS.md`, and never add `CLAUDE.md` or `CLAUDE.local.md`.** This fits
   the decision "Shared context lives in `AGENTS.md`". Claude Code reads it directly, and so
   does Codex, which `prompts/review.md` mentions. The pitfall is that one stray `CLAUDE.md`
   (for example from `/init`) or `CLAUDE.local.md` silently stops `AGENTS.md` from loading.
   Worth one line in `AGENTS.md`, or a note in the step-1 prompt. [J]
2. **Size.** The current `AGENTS.md` is 30 lines, well under 200. The guidance supports the
   decision "`AGENTS.md` is short and written for agents". [R]/[J] Running the content test on
   today's file [J]:
   - **Keep:** the build and cache commands (a check Claude can't easily rediscover), the
     placeholder convention and the reason for it (a decision with its rationale), the paper
     rule and the provenance header, the evidence tags.
   - **Drop or move:** "The abstract imports Mathlib, Tau Ceti and `GLCinLean.Foundations`"
     (Claude can read the imports); the "owner's files" note, which conflicts with full
     automation (see §4).
   - **Add:** the main goal in one or two sentences; the plain-words rule (a preference Claude
     can't infer); and the exact command that tells a session it is done (`lake build` with the
     environment variables, or the build plus `#print axioms` on the main theorem).
3. **Rules that apply to every session go in `AGENTS.md`; procedures do not.** A multi-step
   procedure that runs only sometimes is better as a skill than as `AGENTS.md` text: moving to a
   new Lean, Mathlib or Tau Ceti version, or opening a Tau Ceti pull request. The other option
   is to keep it in the prompt for that step. This is relevant to "Keeping up with Mathlib and
   Tau Ceti is fully automated" and "Tau Ceti contributions are fully automated". [J] The
   owner's "very simple way … prompts alone" fits better with keeping them in `prompts/`; a
   skill only pays off if the procedure is run from many different sessions. [J]
4. **Prompts with only goal, done when and context are what the guidance recommends.** [J]
   - Clear goal plus motivation: "Be clear and direct", "Add context".
   - A checkable "done when": `/goal`, "Give Claude a check to run".
   - Constraints on deliverables, not steps: the 2026 harness post.
   - No "think hard" or "keep going" lines: outdated advice. No "verify again" lines either,
     at least on Opus 5 and probably Opus 5.5 (the Fable 5 page differs; §4).

   Two shaping rules follow if the prompts are run with `/goal` [J]:
   - Each "done when" should be demonstrable from the transcript (a build exit code, `#print
     axioms` output, a placeholder count printed by a command), because the evaluator reads only
     the conversation.
   - The condition passed to `/goal` must fit in 4,000 characters, so the "done when" block is
     what goes there, not the whole prompt.
5. **The current prompts have parts the guidance would drop.** [J]
   - `prompts/statement.md` and `prompts/proof.md` have numbered "Steps" and "Read first"
     lists. Both are constraints on the path, and a session can find most "read first" files
     itself.
   - "Done when … every new key definition has had a fidelity review" is good: it is a
     checkable end state.
6. **"Update the next prompt"** is an always-rule, so it fits `AGENTS.md` (one line). To make it
   checkable, it can also appear in each recurring prompt's "done when" ("the prompt for the
   next step has been checked and, if needed, updated in the same commit"). [J] See §5.
7. **Pushing must be authorised in writing, and Tau Ceti PRs also need the owner's machine
   settings.** Claude Code's built-in git rule says "Commit or push only when the user asks. If
   on the default branch, branch first." (§2.7 [R]) So the decision "Agents push themselves"
   needs an explicit `AGENTS.md` line saying when to commit and that pushing to `main` of
   `WHY-Op109/GLCinLean` is wanted; otherwise sessions stop and ask, or open a branch. [J] For
   this repository auto mode already allows the push. [R] For "Tau Ceti contributions are
   fully automated", auto mode blocks PRs to another organisation, `gh repo fork` and pushes to
   a third-party repository by default unless the target is named (§2.7 [R]). The reliable fix
   is an `autoMode.environment` / `autoMode.allow` entry naming `TauCetiProject/TauCeti` and the
   owner's fork, in the owner's `~/.claude/settings.json`; an `AGENTS.md` line may or may not
   be enough. [E]/[J] Merging those PRs stays with Tau Ceti's maintainers, which auto mode
   requires anyway. [R]
8. **Blind review leaks context.** `prompts/review.md` wants a subagent that gets "ONLY the Lean
   text". A normal subagent also loads `AGENTS.md`, which names GLC I Conj. 1.6.7 and the
   placeholder design. A custom subagent with `omitClaudeMd: true` (for example
   `.claude/agents/blind-reader.md`) drops `AGENTS.md`, but it still gets the git status snapshot
   with recent commit messages, and with `Read` it can open `AGENTS.md`, `PLAN.md` or the
   papers. [R] So "blind" needs the Lean text passed in the delegation message and the reader
   kept from the repository files, or else a looser standard ("not told the source") that the
   owner accepts. [J]
9. **The plan and session state should live in the repository, not in auto memory.** Auto
   memory is machine-local, so a note kept there does not reach a session on another machine.
   Decisions and progress therefore belong in
   committed files (git plus a progress file), which is what the harness posts recommend. [R]/[J]
10. **Expect to cut the scaffolding down as models improve.** That is the owner's "Stay
    open-minded about changes" applied to the prompts themselves. A recurring "refactor" step
    could include re-reading the prompts and `AGENTS.md` with `/doctor prompt-audit`. [J]

## 4. Conflicts

- **With `notes/workflow.md` decisions:**
  - "Agents push themselves" conflicts with Claude Code's built-in default ("Commit or push
    only when the user asks. If on the default branch, branch first."). It is not a conflict
    with Anthropic's guidance as such: the guidance says to state such preferences explicitly.
    Until stated, the default wins. [R]/[J] (The prompting guide's sample block that lists
    "pushing code, commenting on PRs/issues" as actions to confirm is an opt-in sample written
    for Opus 4.6 — "If you want Claude Opus 4.6 to confirm before taking potentially risky
    actions, add guidance" — so it is no conflict. [R]) Auto mode itself allows pushes to the
    repository being worked in. [R]
  - "Tau Ceti contributions are fully automated": auto mode blocks by default "Opening a pull
    request against a different repository or organization, forking with `gh repo fork`, or
    pushing to a third-party repository, unless you named that external target". [R] So a Tau
    Ceti PR run will stop unless the target is named; the durable way is an `autoMode` entry
    in `~/.claude/settings.json` ("the classifier ignores `autoMode` in project settings"). [R]
    That is the owner's machine configuration, and full automation depends on it. [J]
  - "Keeping up with Mathlib and Tau Ceti is fully automated": the classifier allows "Installing
    dependencies declared in your lock files or manifests" [R]; whether `lake update` (which
    rewrites the manifest and downloads new code) is judged that way is not stated. [E]
- **With `notes/ideas.md`:**
  - "do the whole formalisation with prompts alone, without any complex system or harness"
    sits a little against Anthropic's advice that rules which must always hold belong in hooks
    or deny rules, not text. Anthropic also says to keep that set small and that "Most of the
    time, you want Claude to decide". The two agree if the project uses at most a couple of
    deterministic checks, or none. [J]
  - The first example prompt's "keep a file STATUS up to date" agrees with the harness posts'
    progress file. [J]
  - The second example prompt's "launch a codex agent in yolo mode (in a tmux shell)" matches
    an auto-mode default block: "running a third-party agent or eval harness with isolation and
    per-action approval disabled". [R] That pattern would need the owner's approval or settings
    each time; it does not fit an unattended Claude Code session as is. [J]
  - The example prompts name models and effort levels ("Opus (high)", "Sonnet subagent").
    Anthropic's model pages say effort is the main control and that effort names "don't
    correspond to the same amount of thinking across models" (Opus 5.5). [R] Pinning a model
    and effort in a prompt is therefore a choice to revisit when models change. [J]
- **With the current files:**
  - `prompts/review.md` (blind subagent) against subagents loading `AGENTS.md` (§3.8). [R]/[J]
  - `AGENTS.md` says "`PLAN.md` holds the goal, the decisions and the open questions", while
    `notes/workflow.md` now holds the decisions. Anthropic warns that contradicting instruction
    files make Claude "pick one arbitrarily". [R]/[J] Step 1 should leave a single home for
    decisions.
  - The `AGENTS.md` "owner's files" note covers `lakefile.toml`, `lake-manifest.json` and
    `lean-toolchain`, which the full-automation decision needs agents to change. This is already
    listed in `notes/workflow.md`. [R]
- **Between Anthropic sources:**
  - The Opus 5 guide says to remove verification instructions, naming "use a subagent to
    verify" as one to remove, and its delegation sample says "do not use subagents to verify or
    double-check your own work". [R] The Fable 5 guide says the opposite for long runs: "Make
    self-verification explicit in long-run prompts. Separate, fresh-context verifier subagents
    tend to outperform self-critique." [R] The 2026 harness post finds a separate evaluator
    worth its cost when "the task sits beyond what the current model does reliably solo". [R]
    So the advice depends on the model. A way to reconcile them for this project: no "verify
    your work" lines in the build prompts, and the fidelity review kept as its own step with
    its own prompt. That review is a deliverable (a check of the mathematics against the
    papers that the owner cannot do), not the model re-checking itself. [J]
  - The Fable 5.1 "operating autonomously" block and the Opus 5.5 unattended-run block are
    extra standing text. They are aimed at API harnesses without `/goal`, and in Claude Code
    `/goal` does the same job. [J]

## 5. Input for the open questions

- **What goes into `AGENTS.md`, and where "update the next prompt" lives.** The guidance says
  it should hold only what an agent can't find by reading the repository, or would spend time
  rediscovering every session. [R] Applied here, that suggests [J]:
  - the main goal (statement first, then proof, in Mathlib style, as a library);
  - the plain-words rule;
  - the check commands;
  - the decisions not visible in the code (source order Mathlib → Tau Ceti → Stacks; placeholder
    convention; commit and push points, that pushes go to `main`, and the authority to open Tau
    Ceti PRs; papers as untracked TeX; evidence tags);
  - the warning against adding a `CLAUDE.md` or `CLAUDE.local.md`.

  Target well under 200 lines; the current 30 is about right. [J] For "update the next prompt",
  one line in `AGENTS.md` is the documented place for an always-rule. Repeating it as a "done
  when" item in each recurring prompt makes `/goal` check it. Suggestion: the `AGENTS.md` line
  alone is enough unless sessions are seen skipping it; then add it to "done when", not a hook.
  [J]
- **Whether `PLAN.md` is needed.** Anthropic's long-running examples keep three things in the
  repository [R]:
  - a written definition of done (`SPEC.md`, a feature list);
  - a progress file;
  - git.

  The prompts can carry the goal and done-when. What they can't carry is *state*: which
  definitions are real, what is next, what was decided this week. That suggests replacing
  `PLAN.md` with a short status file (the example prompt's `STATUS`), with the blueprint as the
  structured list of what remains. Stable decisions go in `AGENTS.md` or `notes/workflow.md`,
  not in three places. [J]
- **Abstract, Foundations, placeholders.** This source does not bear on it.
- **What happens to each existing file.**
  - `prompts/`: reshape each into goal, done when and context. Drop "Steps" and "Read first".
    Make "done when" a transcript-visible check under 4,000 characters. [J]
  - `prompts/review.md`: keep its blind-reading idea, but run it through a custom subagent with
    `omitClaudeMd: true`, the Lean text in the delegation message and no access to the
    repository files; even then the git status snapshot reaches it. [R]/[J]
  - This source does not bear on `lakefile.toml`, `glc/project.toml`, `reviews/`, `blueprint/`
    or `manifest.toml`.
- **Who reviews the mathematics, and to what standard.**
  - A fresh agent is useful because "it hasn't seen your reasoning". Self-review "confidently
    prais[es]" the work. Claude "out of the box … is a poor QA agent" until its prompt is tuned
    against cases where a human disagreed with it. [R]
  - So fresh-agent reviews are a good first line, but their standard has to be written down
    (agree / same object / mismatch / unsure, as `review.md` does). Their verdicts should be
    sampled against a human expert's at least occasionally, or the tuning loop has nothing to
    tune against. [J]
  - The `/goal` evaluator is a small model that reads only the transcript. It is no reviewer of
    mathematics. [R]
  - Anthropic's model pages disagree on whether to ask for separate verifier subagents (Opus 5:
    remove; Fable 5: add for long runs; §4). A fidelity review written as its own step, with its
    own standard, sidesteps that disagreement. [J]
- **Where research notes and session summaries live, and whether they are committed.**
  Committed, in the repository. Auto memory is machine-local and limited to 200 lines / 25 KB of
  index. Git history plus a progress file is the pattern Anthropic found works across sessions.
  [R]/[J] Research notes like this one are reference material, so `notes/` is fine. A session
  summary that the next session must read is state, so it belongs in the status file or the
  commit message rather than in a growing pile of notes. [J]

## 6. Questions for the owner

1. **`AGENTS.md` only?** Keep `AGENTS.md` as the only instruction file, with a line warning
   agents never to create `CLAUDE.md` or `CLAUDE.local.md`, which would stop it loading? The
   alternatives are a one-line `CLAUDE.md` holding `@AGENTS.md`, for sessions that can't read
   `AGENTS.md` directly, or setting **Project instructions** to `claude-md-and-agents-md` in
   your own `~/.claude/settings.json` on each machine, which keeps `AGENTS.md` loading even if
   a `CLAUDE.md` appears.
2. **How to authorise pushes and Tau Ceti PRs.** May `AGENTS.md` state outright that sessions
   commit and push to `main` of `WHY-Op109/GLCinLean` at the agreed points, and open pull
   requests on `TauCetiProject/TauCeti` from your fork? Auto mode blocks PRs to another
   organisation and `gh repo fork` by default unless the target is named, so full automation
   also needs `autoMode.environment` or `autoMode.allow` entries naming Tau Ceti and your fork
   in your own `~/.claude/settings.json`, on each machine that runs sessions. Do you want them?
   Only you can add those.
3. **Deterministic checks?** None, keeping to "prompts alone"? Or one or two hooks, for example
   a `Stop` hook that runs `lake build` or a deny rule on `lean-toolchain`?
4. **Recurring prompts under `/goal`?** If yes, every "done when" must be provable from the
   transcript and fit in 4,000 characters.
5. **A custom blind-reader subagent, and how blind?** It would be one `.claude/agents/` file
   with `omitClaudeMd: true`, given the Lean text in its delegation message and no access to the
   repository files. Even so it sees the git status snapshot (recent commit messages), which
   cannot be turned off for one subagent. Is that blind enough, or should the blind reading run
   in a separate session outside the repository? This adds a small piece of configuration to
   the repository.
6. **What replaces `PLAN.md`?** A short committed status file, with stable decisions kept in
   one place only (`AGENTS.md` or `notes/workflow.md`)?
