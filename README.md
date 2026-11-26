# GLCinLean

> **Status:** unreviewed, agent-generated, in progress. Nothing here is checked by an expert yet.

A Lean 4 library for geometric representation theory, built on [Mathlib](https://github.com/leanprover-community/mathlib4) and [Tau Ceti](https://github.com/TauCetiProject/TauCeti), and on it a faithful statement of the global unramified de Rham geometric Langlands conjecture: GLC I (Gaitsgory–Raskin, [arXiv 2405.03599v3](https://arxiv.org/abs/2405.03599v3)), Conjecture 1.6.7. The proof comes after the statement.

## Where it stands

The statement is in `GLCinLean/Statement/`. Its main theorem says that a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and that every such functor is an equivalence. The objects no library has yet (DG categories, D-modules on `Bun_G`, `IndCoh_Nilp(LS_Ǧ)`, …) are placeholders. The plan in `plans/` lists every object the statement uses, down to Mathlib and Tau Ceti; the parts that a Tau Ceti roadmap owns are under `plans/Roadmap/`. [`STATUS.md`](STATUS.md) has the details.

## How the work runs

Agents do the work. The owner starts a session on Fable 5.2, in auto mode, with one goal:

    /goal Run the workflow of `AGENTS.md`. The goal is met when the session's reply shows either (a) that no `@[placeholder]` is left in `GLCinLean/Statement` and the done check passes, or (b) that every remaining line of work is under "Waiting for the owner" in `STATUS.md`.

"Workflow" in [`AGENTS.md`](AGENTS.md) gives the first goal, the order of the steps, the roles with their models, and when the session stops. Each step has a prompt in `prompts/`:

| Prompt | What it does |
|---|---|
| [`audit.md`](prompts/audit.md) | when due, judge whether the statement, the plan and the workflow still reach the goal in the simplest way |
| [`clean.md`](prompts/clean.md) | delete the files that are no longer needed, and keep `STATUS.md` thin |
| [`start.md`](prompts/start.md) | bring the Tau Ceti workers in line with the plan, fold in merged upstream work, and write each ready module |
| [`check.md`](prompts/check.md) | a checker judges each commit against the papers and the rules before the push |
| [`change.md`](prompts/change.md) | a big change of the plan: the planner proposes, Codex checks, and the change is applied when both agree |

[`AGENTS.md`](AGENTS.md) holds the rules every session follows, for every agent ([`CLAUDE.md`](CLAUDE.md) imports it for Claude Code): Mathlib first, then Tau Ceti; parts on a Tau Ceti roadmap are contributed to Tau Ceti; Mathlib's style; and only one `sorry`, the proof of the main theorem.

## Layout

| Path | What it is |
|---|---|
| `GLCinLean/` | the Lean code: the statement (`Statement/Conjecture.lean`), its enhanced categorical placeholders (`Statement/Enhanced.lean`), and the `@[placeholder]` attribute |
| `plans/` | the plan, in the format of the [tracker](https://github.com/bridgekat/tracker): `plans/GLCinLean/` is written here, `plans/Roadmap/<area>/` belongs to a Tau Ceti roadmap |
| `plans-proof/` | the nodes that only the proof of the main theorem needs, in the same format; the tracker does not read it |
| `tools/tracker` | the tracker, a git submodule |
| `tools/check-statement-axioms.lean` | prints the axioms of the statement's declarations (the done check) |
| `tools/check-module-cycles.py` | checks that no module plan of `plans/` imports another in a cycle, which the tracker does not check |
| `tools/check-upstream-names.py` | checks that each Mathlib or Tau Ceti declaration that the plan names is in the module it names, at the pins |
| `tools/monitor.sh` | the monitor of the workflow: wakes the session when a worker has a fault that persists, when a watched pull request changes state, when the disk is nearly full, when the workers' host is short of memory or its `/tmp` is nearly full, and once a day |
| `tools/keep-workers-running.sh` | runs on the host of the Tau Ceti workers every half hour: starts the Worker's manager when it is not running, starts it again when it runs without the host's proxy, ends a Lean process of a worker that sleeps without end, ends a process of the Worker that is in a loop without a pause, and removes the stale scratch files of the workers' agents from `/tmp` |
| `tools/deploy-worker-targets.py` | validates the target list and the author workers of `docs/worker-targets/` on the workers' host and puts them there |
| `tools/tex-locator.awk` | gives the paper's number (for example Conj. 1.6.7) of a line of its TeX |
| `prompts/` | the prompts of the steps of the workflow |
| `AGENTS.md` | the rules of the project, read by every agent |
| `CLAUDE.md` | one line, `@AGENTS.md`: Claude Code reads `CLAUDE.md`, and this import gives it the same rules |
| `STATUS.md` | the current state of the work |
| `.claude/agents/` | the subagent roles of the workflow, each with its model and effort |
| `docs/references.bib` | the papers cited, with their arXiv versions |
| `docs/papers.md` | one line per paper on what it covers, and how to search its TeX |
| `docs/blueprint-providers.md` | the Mathlib, Tau Ceti and roadmap snapshot the plan was checked against |
| `notes/` | check and audit reports, while their findings are open |

## Build

    git clone --recurse-submodules https://github.com/WHY-Op109/GLCinLean
    cd GLCinLean
    export LAKE_CONFIG=$PWD/.lake-config/lake-config.toml LAKE_CACHE_DIR=$PWD/.lake/cache
    lake exe cache get
    lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti
    lake build                   # the first build may compile some Tau Ceti modules (see AGENTS.md, "Builds")
    lake exe tracker status      # progress against the plan

## Licence

Apache-2.0 ([`LICENSE`](LICENSE)).
