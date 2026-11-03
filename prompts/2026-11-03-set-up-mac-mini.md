**Goal:** make this Mac mini ready to run `prompts/2026-11-02-synthesise-feasible-plan.md`. Check the tools below, install what is missing, and leave me only the steps that need me.

**Done when:** everything below is present and working, or you have told me exactly which commands I must run myself (logins are interactive; give them so I can run them with the `!` prefix), and you have rechecked after I ran them.

**Needed:**
- Homebrew, git, Python 3, Node.js with npm (Codex install; building tracker-graph-explorer), `uv`.
- Lean through elan (`lean`, `lake`). The plan pins the toolchain, so do not download Mathlib or Tau Ceti now.
- GitHub CLI `gh`, logged in with the `workflow` scope.
- Codex CLI, logged in with my ChatGPT account (`codex exec` must work).
- The lean-lsp MCP server registered with Claude Code (for example `claude mcp add lean-lsp -- uvx lean-lsp-mcp`).
- `private/`: a clone of `https://github.com/WHY-Op109/GLCinLeanPrivate.git` (D37).
- My skills (V9): `git clone https://github.com/WHY-Op109/prop.git ~/.codex/skills/prop`, linked as `~/.claude/skills/prop`; `grilling` copied from `private/skills/grilling` into `~/.claude/skills/`.
- No `CLAUDE.md` in this folder or any folder above it, so Claude Code reads `AGENTS.md` (D33).

`GLCinLeanPrivate` and `prop` are private repositories, so `gh` must be logged in and set up as git's credential helper (`gh auth setup-git`) before they can be cloned.

Tools that are already installed and working stay as they are.
