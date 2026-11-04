# Session plan: synthesise the feasible implementation plan (prompt 2026-11-02)

Session plan written by Claude Code on 2026-11-04 for `prompts/2026-11-02-synthesise-feasible-plan.md`; approved by the user before execution. Not the implementation plan itself.

## Context

The prompt `prompts/2026-11-02-synthesise-feasible-plan.md` asks for one committed file, `plans/2026-11-04-implementation-plan.md`, that turns decisions D1–D39 (log), the brainstorm, reports and references into a feasible build plan for the automated GLCinLean workflow, with feasibility **tested** on this Mac mini, not assumed. It must contain: chosen design and components; build order following D30 (goal 1a → 1b → checkpoint → goal 2) with first concrete steps; per component what was tested, result, date; risks/costs/dependencies; open items for the user; and, last, the start prompt for the first implementation session (D36).

**Detour check (prompt's principle):** D36 already raised the two detours for this prompt (full machinery before small goal 1a; testing on the wrong Mac) and the user settled both. I will not re-raise them. New conflicts found during the work go into the plan's "conflicts / needs your input" section, not silently resolved.

**Already measured (read-only, 2026-11-04):** Apple M4, 10 cores (4P+6E), 16 GB RAM, 228 GB disk with **61 GB free** (user's normal range 50–100); macOS 27.0.1; system sleep 0; tools present: brew 7.0.12, git 2.54, Python 3.15, node 26.13, uv 0.13.7, elan 4.2.4 (toolchains 4.35.0, 4.35.0-rc3, 4.36.0-rc1, 4.36.0-rc2; 12 GB), gh 2.103.3, codex 0.163.0 (ChatGPT login), Claude Code 2.1.318, lean-lsp MCP connected, skills `prop` and `grilling` installed. Tau Ceti newest tag still `v4.36.0-rc2`. **New since 3 Nov:** `bridgekat/numlib-auto` now reports **Apache-2.0**; `tracker` and `tracker-graph-explorer` still no licence; `private/permissions/` is still empty (C1 follow-up not done). **Safety finding:** `gh` holds a second login besides WHY-Op109, both `repo`+`workflow` scopes; neither can push to Tau Ceti/Mathlib, but both can open PRs, issues and comments anywhere public — an outward-signal channel D2 says agents must not have.

## Execution (after approval)

All experiments live in the session scratchpad (`/private/tmp/claude-501/…/scratchpad/exp/`); nothing in the repository changes except the new plan file. Time-box heavy builds; keep disk use under ~30 GB and delete large build outputs at the end (logs kept in scratch, results quoted in the plan).

### A. Hands-on tests I run myself (some in background)

1. **Tau Ceti as a Lake dependency (V4, V8).** Scratch Lake project on `leanprover/lean4:v4.36.0-rc2` requiring `TauCeti` at tag `v4.36.0-rc2` (and, for comparison, the newest `main` SHA). `lake update`; `lake exe cache get` for Mathlib; find out whether Tau Ceti's own outputs have a downloadable cache (Lake artifact cache / `lake cache get`, `platformIndependent = true`); build a test file importing GLC-path modules (DG nerve, `KInjective`, `AlgebraicSpace`, `Stack/Basic`) with `/usr/bin/time -l` for wall time, peak RSS per Lean process, and `.lake` size. Try `LEAN_NUM_THREADS` to confirm it is honoured on this toolchain.
2. **tracker on the same project (D12).** Build `bridgekat/tracker` at current HEAD; toy plan TOML with a `sorry` theorem, an `opaque` data placeholder and a proved lemma; run its status, lint, `ready`, graph export (JSON). Check whether its graph export already gives reverse dependencies (= impact list for free). Briefly `npm run build` tracker-graph-explorer with that JSON.
3. **Closure check, axiom audit, fingerprint, impact list (D39, V7, brainstorm §7).** A small Lean metaprogram (`lake exe`) in the scratch project, modelled on `edemaine/lean-canny` `scripts/CheckAbstract.lean` (read, MIT): walk constants in types and definition values of an `Abstract` module, fail on project-internal escapes, collect axioms, list placeholders (`opaque`/`sorryAx`-valued), compute a fingerprint hash of the elaborated type/value with project abbreviations unfolded and names/doc comments ignored, and a reverse-dependency list. Test that cosmetic edits keep the hash and a swapped quantifier changes it.
4. **Blind read-back isolation (V6, D17, D27 test 2).** Marker files in the repo, a fake papers folder and `$HOME`; an empty work dir with one extracted Lean slice. Run `codex exec` (resolved frontier model, highest effort) with `--sandbox read-only` and ask it to report any file it can read outside the dir and to try network; same for `claude -p` with tool allow-list and sandbox settings. If reads escape, test a `sandbox-exec` profile wrapper (no admin needed) as the fallback; note the separate-macOS-user option (needs admin).
5. **Codex resolver (D25).** Inspect the model cache fields on codex 0.163.0 (tier/description/priority/reasoning levels); prototype the selection rule; record rate-limit info from the session log of test 4.
6. **Machine settings (V8, D31, D32, B8).** `HIDIdleTime` via `ioreg`, `taskpolicy`, launchd/`caffeinate`, auto-restart after power loss (`pmset autorestart` is 0 now), memory per Lean worker from A1 → proposed numbers: parallel workers per mode, `LEAN_NUM_THREADS`, idle timeout, disk thresholds adapted to 61 GB free, D31 inactivity days and a candidate never-touch list (list other Lean projects and their `.lake` sizes, read-only).

### B. Parallel research (one Workflow, 6 read-only agents, ultracode)

Each returns findings tagged [R]/[S]/[E]/[J] with URLs pinned to commits and the check date.
1. **Tau Ceti since 3 Nov** — commit log and code (not STATUS) on GLC-path paths; new tags; new or changed roadmaps touching D-modules, IndCoh, LocSys, Bun_G, stacks (re-verify D11 ownership); FCO #1056 and #848 state; cache mechanism for downstream; roadmap CONTRIBUTING on model-written text (V3).
2. **TauCetiTools V1/V2** — claims repo needed with one worker; whether setup or optional services announce or register anything (phase-2 relevance only).
3. **Build-derived data tools** — what doc-gen4 (tag for v4.36.0-rc2) emits (declaration data, JSON, source links), Lean `Environment`/`CollectAxioms` APIs, Mathlib `ImportGraph`/`lake exe graph`, existing fingerprint/impact tools; cost of running doc-gen4 for a Tau Ceti downstream (whether it rebuilds docs for dependencies).
4. **bridgekat repos since 3 Nov** — tracker CLI and JSON schema in detail, any extras/metadata mechanism, numlib-auto licence change and prompt updates (which prompts to adapt, D16), explorer build inputs.
5. **V5 field hypothesis** — fetch AGKRRV (arXiv 2010.01906) and GLC I v3 LaTeX to scratch (never committed, D6); quote the conventions on $k$ (algebraically closed?), $X$ (connected?), $G$; conclude the faithful hypothesis.
6. **Costs and limits of the loops** — current (Nov 2026) Claude subscription usage limits and terms for headless `claude -p`/automated 24/7 use on a subscription; ChatGPT plan limits for `codex exec`; Claude Code features that replace home-made parts (scheduled/loop tasks, hooks, sandbox, `--max-turns`, worktrees). Flag any rule that forbids D7/D20 as designed.

### C. Synthesis and commit

Write `plans/2026-11-04-implementation-plan.md` (use the actual date when written), in the repository's style (tags, dated sources, D-numbers):
1. Goal recap (D30) and **design**: components split into **generic system** (folder, e.g. `system/`, no GLC names: review command, fingerprints, closure check, cards, read-back harness, comparator, Foundations import check, fault-injection tests, resolver, bump step, prompt templates, JSON schemas — D35, D39) vs **GLC-specific** (`GLCinLean/Abstract.lean`, `Foundations`, `Sketch`, config, papers manifest, atlas data, reviews) vs **machine settings** (Mac mini).
2. Repository layout and ownership (D9, D34, D37; CODEOWNERS, branch protection).
3. **Build order** by D30: step 0 (repo skeleton, pins, CI, credentials), goal 1a first steps concretely, then loop start after the three D27 tests, then 1b, checkpoint, goal 2 (outline only).
4. **Feasibility table**: component · what was tested/checked · result · date · tag.
5. Machine-specific settings proposal (V8) with the measurements.
6. Risks, costs (usage-limit model), dependencies (Tau Ceti pin, tracker, Codex, subscriptions, licences C1).
7. `AGENTS.md` additions required before the loop starts (D2 hard rule, STATUS rule, system-folder rule, untrusted-data rule, escalation queue, stop switch, …).
8. **Conflicts and decisions needed from the user** (expected: credentials/second `gh` login and a scoped token or GitHub App for the loop; C1 permission still unfiled vs numlib-auto now Apache-2.0; V5 outcome; D6 fetch-script confirmation; D15 done criteria reconfirmation; whatever tests contradict).
9. Last section: the ready-to-run start prompt for the first implementation session, drafted with the `prop` skill (D18/D21 convention), without the "ask me first" principle (D36).

Then `git add plans/2026-11-04-implementation-plan.md && git commit` (with the attribution line); no push (the README leaves `git push` to the user) and no edits to the log or `AGENTS.md`.

## Verification

- Every required section of the prompt's "Done when" present; every feasibility row has date, result and tag; each claim about upstream cites a pinned commit.
- Experiment logs exist in the scratchpad for A1–A6 and are referenced by path in my final message (not in the plan, since scratch is temporary).
- `git status` clean after commit; `git log -1` shows the plan commit; nothing under `private/`, papers or `.tex/.pdf` staged.
- Disk free re-measured at the end and large scratch build outputs removed.
