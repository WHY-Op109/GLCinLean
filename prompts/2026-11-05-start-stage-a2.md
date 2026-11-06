# Start prompt for stage A2

Written 2026-11-05 with `prop`. Paste the block below into a new Claude Code session opened in the GLCinLean checkout on the Mac mini, after A1 (`ade5089`) has been pushed. Run `/effort high` first. Delete this file after the session has run (README: prompts that have been run are deleted).

```text
**Goal:** carry out stage A2 of `plans/2026-11-04-implementation-plan.md`. That means:
- CI (K14);
- data format v0 and the JSON Schemas (K3);
- the K4 checks over tracker output;
- the `review` command of D9 that writes records with fingerprints.

**Done when:**
- `.github/workflows/` runs on every pull request and on every push to `main`:
  - the build from caches, failing if it prints "Built Mathlib";
  - `review all`;
  - the fault job: `lake build GLCinLeanFaults`, `review faults glc/faults.toml`, and the kit's own toy tests in `reviewkit/test/`;
  - `tracker check && tracker lint` with `--dir blueprint/plans`, failing hard on tracker's "plan has errors / stale cache" warning;
  - the K4 checks: the extras join, owned paths, flagged entries (D19);
  - a pin-policy check: `lake-manifest.json` and `lean-toolchain` agree with the Tau Ceti tag in `lakefile.toml`, and a manifest change without a lakefile change is flagged (D44);
  - Mathlib's linters, warning-only, never a gate (D44, K5): `weak.linter.mathlibStandardSet = true` in `lakefile.toml`, `lintDriver = "batteries/runLinter"` and a text style job, as FLT, Carleson and PFR do; they are meant for Staging and Foundations, and the abstract's warnings are informational;
  - each job first frees the runner's unused preinstalled toolchains (verify the disk margin, §2.2 K14);
  - lean-action, if used, pinned to v1.7.0 (`fe408643ea7367d8c0404a8be3975bb145f5fb64`); its `axiom-audit` belongs to goal 2 only.
- On a pull request, CI runs the checker (`reviewkit/`) and `glc/project.toml` taken from the approved base revision, never from the pull request's own tree (D43/F04).
- `.github/CODEOWNERS` covers the human-owned paths named in `AGENTS.md` item 2, including `lakefile.toml`, `lake-manifest.json` and `lean-toolchain` at all times (Q10, D44). `GLCinLean/Abstract.lean` is not owned (D40 Finding 3).
- The audit gap from Codex's review of A1 is closed (D44): the sorry trace and the direct-sorry scan skip opaque bodies (`depsOf` and `directSorry` in `reviewkit/ReviewKit/Core.lean`), so `@[placeholder] opaque x : Nat := sorry` passes `review axioms` although `#print axioms` shows `sorryAx`. Both follow opaque bodies now, with a fault fixture (expected diagnostic and passing control) in `glc/faults.toml` and in the kit's toy tests. Say in the report whether the transitive digest should also cover opaque bodies.
- The sorry budget's description of `exists_dualGroup` is corrected (nothing uses it inside the statement; `Setting` takes the dual group as data), and the budget and pin records are regenerated after the changes, with evidence records from the record command.
- Data format v0 is written and versioned:
  - the project config, the extras file `glc/extras.toml` keyed by absolute declaration id (D12) with a `provider` field per declaration (mathlib / tauceti / stacks / staging / placeholder; D44, K8), the sorry budget and the statement pin;
  - machine evidence records in `evidence/` and human attestation records in `reviews/` as separate classes; an attestation is bound to fingerprints and evidence ids, and its staleness is computed from those bindings, never written into `reviews/` (D43/F11);
  - JSON Schemas for every agent output: task record, worker result, read-back, comparator verdict, blueprint revision, scout digest. Verdict fields keep specification agreement, source independence, my check and the expert's review apart (D43/F06).
- The `review` record command writes evidence records holding each fingerprint (SHA-256 over the canonical text) and the canonical text.
- The new checks have fault fixtures, each with an expected diagnostic and a passing control, as in A1 (D43/F21).
- Everything I must do on GitHub is written out in one place as exact commands, for what is not yet in place:
  - the repository settings (N7 report §6.1);
  - the ruleset, with the final names of the required checks (§6.3);
  - the GitHub App for Q4's option (a) (D44): I created it on 2026-11-06 (`glcinlean-agent`, App ID `5640446`, installation id `179214298`, installed on GLCinLean only; private key at `~/glc-machine/glcinlean-agent.pem`, mode 600). Check its permissions and installation read-only and write commands only for what is missing (§6.4; step 5 is superseded by D40 Finding 4: both tokens stay, and workers are sandboxed instead);
  - a one-time test pull request showing that code-owner review is required with zero required approvals (N7 conflict C-N7-3).
- `scripts/check.sh --faults` passes locally. If I push during the session, read the CI runs with `gh` (read-only) and fix what fails.
- The work is in local commits on `main`. Your report says what was done, what did not work, and what is left for A3.

**Context:**
- Read the plan's §2.1–2.6, §3 A2, §8 and §10, and in `plans/2026-11-design-discussion-log.md` D9, D12, D19, D39, D40, D43 and D44.
- A1 is commit `ade5089`:
  - the Lake skeleton on Tau Ceti `v4.36.0-rc2`;
  - the kit (`reviewkit/README.md`; data formats `reviewkit-config/0`, `reviewkit-sorry-budget/0`, `reviewkit-statement-pin/0`, `reviewkit-faults/0`);
  - the Foundations and abstract stub;
  - `glc/project.toml` and `glc/faults.toml`;
  - the tracker submodule and a minimal plan;
  - `scripts/check.sh`.
- The `approved` fields in `reviews/` stay blank (D44): I approve a provisional goal-1a baseline only after this stage's fixes and B1's review of the assembled statement. The kit does not read them. If data format v0 gives `approved` a structure, plan for the date and initials in that field and the scope wording in a linked owner attestation (D44 has the wording).
- The 16 Foundations-name warnings that `review imports` prints are B1's to decide. Leave them.
- Layout and namespaces (D44, K4; plan §2.1): any new file follows them. Staging is still empty.
- GitHub state on 2026-11-06 (read-only `gh api`): I applied N7's §6.1 settings (squash-only, auto-merge, delete merged branches, no Issues or wiki, read-only workflow token that cannot approve PRs, approval required for all outside contributors' CI); the repository is public; `allow_update_branch` is off: turn it on in your commands if the ruleset requires up-to-date branches. The ruleset (§6.3) is not applied. Check again before writing commands.
- Starting material in `private/feasibility/2026-11-04/` (if `private/` is missing, clone GLCinLeanPrivate there):
  - `reports/N7-github.md` §4–§7: identity, required checks, rulesets, CODEOWNERS, the workflow outline;
  - `reports/L2.md` §4.2–4.6 and `prototypes/L2/tools/join_extras.py`: the extras join, tracker's stale cache, the no-progress snapshots;
  - `prototypes/scripts/N7-github/mint-app-token.py`: the App token mint script.
  - Scripts there hold paths into the deleted `scratch/` tree: treat them as recipes (D43/F19).
- Pages and the site (K11) are A3's work. The Stacks diff check (K15) exists only if B1b sends a node to Stacks (D42).

**Boundaries:**
- No outward signals (D2). Do not push, open pull requests or issues, change GitHub settings or create the App; I do those. Reading GitHub with `gh` is fine.
- If a build prints "Built Mathlib", stop it and report.
- Put no project-specific code under `reviewkit/`.
- Do not fill in or change `approved` fields.
```
