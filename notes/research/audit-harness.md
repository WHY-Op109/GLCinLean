# Audit: the rest of the repository (everything except the Lean files)

- **Source:** this repository, `https://github.com/WHY-Op109/GLCinLean` at commit
  `0feeb6fa88b31cf418fe1ecc304e358faf7b88f6` (local `HEAD` = `origin/main`), plus the
  uncommitted working tree of 2026-11-08 (`notes/workflow.md`, `prompts/research.md` modified;
  `THIRD_PARTY_NOTICES.md` and `notes/research/` untracked).
- **Checked 2026-11-08.** Licence of the repository: Apache-2.0 (`LICENSE`, the full standard
  text) [R].
- **How it was checked.** Every file below was read in full. The build (`lake build`), the
  ReviewKit checks (`lake exe review --config glc/project.toml all`) and the tracker
  (`lake exe tracker --dir blueprint/plans status|lint`) were run locally at the current pins.
  Upstream state of Tau Ceti, tracker and reviewkit came from `gh api` the same day.
- **Not covered here:** `GLCinLean/Abstract.lean` and `GLCinLean/Foundations.lean` themselves
  (only how they tie into the files below), and the GLCinLean-archive repository (private and
  archived, by `gh api` 2026-11-08).
- **Independent re-check, 2026-11-08.** A second agent re-ran `lake build`, `lake lint`,
  `review … all`, `tracker … lint|status` (with and without `--dir`), re-read every file, the
  commit stats and messages, ReviewKit's `Attr.lean`, `Fingerprint.lean` and `lakefile.toml` at
  `3fd3bfa`, Tau Ceti's `lakefile.toml` at `e0610cce`, and the upstream state by `gh api`.
  Corrections are worked into the text below.

## 1. What it is

Besides the two Lean files, the repository holds three kinds of things [R]:

| Kind | Files |
|---|---|
| Build set-up | `lakefile.toml`, `lake-manifest.json`, `lean-toolchain`, `.lake-config/lake-config.toml`, `.gitmodules` + `tools/tracker` (submodule), `GLCinLean.lean`, `.gitignore` |
| The old review machinery ("harness") | `glc/project.toml`, `reviews/sorry-budget.toml`, `reviews/statement-pin.toml`, `blueprint/plans/GLCinLean/*.toml`, the ReviewKit requirement, `references/papers/manifest.toml` |
| Text for people and agents | `README.md`, `AGENTS.md`, `PLAN.md`, `prompts/{statement,proof,review,research}.md`, `notes/{ideas,workflow}.md`, `LICENSE`, `THIRD_PARTY_NOTICES.md` (untracked) |

The git history (33 commits, 2026-11-03 to 2026-11-08) shows the project growing a large harness
and then removing it in steps [R]:

| Commit | Date | What happened |
|---|---|---|
| `eb23eec` … `f6c3693` | 11-03 to 11-05 | planning only: design log (decisions D1–D43), implementation plan, start prompts (initial commit 5341 lines) |
| `ade5089` | 11-05 | "Stage A1": Lake skeleton, ReviewKit inside the repo, abstract stub, tracker submodule, papers manifest, fault fixtures, `check.sh` (+3583 lines, 76 files) |
| `8b6e339`, `a83d227` | 11-06 | D44; set-up for PRs |
| `7265f9a` | 11-06 | "Simplify": ReviewKit moved to its own repo, `references/tau-ceti/`, `reports/` removed (−6799 lines); `PLAN.md`, goal-mode prompts and a CI workflow (`.github/workflows/ci.yml`, running `scripts/check.sh`) created |
| `7ce7bc0` | 11-06 | old `plans/` moved to GLCinLean-archive (−1792 lines) |
| `f6242cf` | 11-06 | `check.sh` made to run under bash for CI |
| `a6de757` | 11-06 | fault fixtures, evidence records, `glc/extras.toml` removed (−942 lines) |
| `0feeb6f` | 11-08 | `scripts/check.sh`, `scripts/fetch-papers.py`, CI workflow and `THIRD_PARTY_NOTICES.md` removed; notes and research prompt added. The commit message names the scripts and CI ("nothing is enforced") but not `THIRD_PARTY_NOTICES.md` |

So the trend is already "prompts only, no harness" [J]; what is left of the harness is the
ReviewKit requirement and its data files, which now nothing runs automatically (no CI, no
script) [R].

## 2. What it says that matters, file by file

For each file: what it is, what uses it, what breaks if it goes. All [R] 2026-11-08 unless
tagged otherwise.

### Build set-up

**`lean-toolchain`** — `leanprover/lean4:v4.36.0-rc2`.
- Used by elan for every build; must equal Tau Ceti's toolchain, and tracker and ReviewKit are
  built with it too (both have `v4.36.0-rc2`).
- If it goes: nothing builds. It stays; the question is only who moves it.

**`lakefile.toml`** (30 lines).
- `reservoir = false` ("public but unannounced"); `lintDriver = "batteries/runLinter"`;
  `[leanOptions] weak.linter.mathlibStandardSet = true` (warnings only, "never a gate").
- Requires: `TauCeti` at tag `v4.36.0-rc2` (comment: "Bumps are the owner's decision"),
  `tracker` by path `tools/tracker`, `ReviewKit` from `github.com/WHY-Op109/reviewkit` at
  `3fd3bfa7…` (= reviewkit's current `main`; the repo is public, last pushed 2026-11-06).
- Compared with Tau Ceti's own lakefile (at `e0610cce`): Tau Ceti sets `warningAsError = true`,
  `weak.linter.style.header = true` and `longFile = 1500`, plus `platformIndependent = true`.
  GLCinLean sets none of these explicitly (the header linter still fires here, through
  `mathlibStandardSet`, as the build log shows). Tau Ceti's lakefile also says its header option
  is "inert during ordinary builds" there, and that the copyright/Authors header and the leading
  `module` keyword are enforced by separate audits (`scripts/HeaderStyle.lean`,
  `lake exe module-system`) [S]; one sampled Tau Ceti file
  (`Algebra/AlgebraicGroup/Pinning/Basic.lean`) has both [R]. It also says "Dependency
  automation must update only that manifest pin and the matching toolchain" [S].
- The current build passes ("Build completed successfully (8178 jobs)", about 7–10 s from
  caches) with 27 warnings: 17 from `linter.style.header` (15 about the copyright/Authors header,
  which neither Lean file has, plus 2 "module doc-string should be the first command after the
  imports"), 6 "imports … designed for use with the module system; consider adding `module`"
  (3 imports of `Foundations.lean`, each printed twice; `Abstract.lean` imports only
  `GLCinLean.Foundations`, so it gets none, though it lacks `module` too), and 4 "declaration uses
  `sorry`". (Re-check: the first version of this note counted the 2 doc-string warnings twice.)
- `lake lint` (Batteries' `runLinter`) passes: "Linting passed for GLCinLean" (re-check run,
  about 60 s).
- If the ReviewKit require goes: `GLCinLean/Foundations.lean` line 14 `import ReviewKit.Attr`
  fails, and with it every `@[placeholder]` (9 in Foundations, beside 3 untagged `opaque`
  carriers, and 6 in Abstract, by `grep`; 3 of the Foundations ones are `def`s over the
  carriers, not `opaque`s). ReviewKit's `lakefile.toml` has no `require` at all, so it depends
  only on core Lean, but it reads kernel terms and `.olean` files [R]; whether it compiles on a
  new Lean without changes is untested [E].
- The doc comments of `Abstract.lean` also name ReviewKit and `reviews/` ("enforced by `review
  imports`", the sorry budget, the statement pin), so they need editing if ReviewKit goes.
- If the tracker require goes: `lake exe tracker` is gone; nothing else uses it.

**`lake-manifest.json`** — the exact pins: ReviewKit `3fd3bfa`, tracker (path), Tau Ceti
`e0610cce` (input rev `v4.36.0-rc2`), Mathlib `1b1ccf4b` and its dependencies, all inherited
from Tau Ceti. Written by `lake update`; needed for reproducible builds and for the caches to
match.

**`.lake-config/lake-config.toml`** — a default-service line and a four-key entry defining the `tauceti-public` cache service
(`https://cache.taucetiproject.org/…`), copied from `TauCetiProject/TauCetiTools @ b49bb4f`
(Apache-2.0), with a provenance header.
- Used whenever `LAKE_CONFIG` points to it (the commands in `AGENTS.md` and `README.md`).
- If it goes: Tau Ceti's modules would be compiled locally, which `AGENTS.md` says "takes hours".
- Its header still says "Scripts and CI set LAKE_CONFIG…"; scripts and CI were removed in
  `0feeb6f`.

**`.gitmodules` + `tools/tracker`** — `bridgekat/tracker` at `c223b672`, which is still the
upstream `main` (0 commits ahead) [R]. The tracker's README requires that it "must build on the
project's toolchain" [S]. Commit `ade5089` says the submodule's push URL was disabled; the
current clone's `origin` push URL is `https://github.com/bridgekat/tracker` again, with no
`pushurl` set.

**`GLCinLean.lean`** — imports `Foundations` and `Abstract`; the library root that `lake build`,
ReviewKit and the tracker load.

**`.gitignore`** — ignores `.lake/` (so `.lake/research/` clones are safe), `private/` (an old
clone, now stale), `scratch/`, `tmp/`, `.claude/settings.local.json`, `CLAUDE.local.md`, and for
papers `references/papers/*` with the exception `!references/papers/manifest.toml`, plus
`*.pdf`, `*.tex`, `*.tar.gz`, `*.zip` everywhere in the repository.

### The old review machinery

**`glc/project.toml`** — ReviewKit's configuration ("Only the owner changes this file"):
closure classes (`abstract`, `foundations`, `staging`, `tauceti`), allowed axioms (`propext`,
`Classical.choice`, `Quot.sound`), the sorry budget path, import rules (Abstract may import only
`Init`, `Mathlib`, `TauCeti`, `GLCinLean.Foundations`), fingerprint settings, the pinned
declarations (`main`, `Setting`), and a `[papers] manifest = …` entry.
- Used only by `lake exe review`. ReviewKit's `Config.lean` lists `papers` as a reserved table
  "read by other tools" — ReviewKit itself never reads the manifest.
- Running `review … all` today: every check passes (`"ok": true`), in about 60–85 s (two
  runs). The closure visits 1283 constants and lists 219 key definitions (172 Tau Ceti, 25
  abstract, 22 foundations); 40 of them are reached directly from project code. The
  placeholder census counts 15, the axiom check 4 budgeted sorry sources.
- `[fingerprint] unfold_abbrevs = ["GLCinLean.Foundations"]`: the statement fingerprint looks
  through the Foundations `abbrev`s, so the pinned `Setting` is hashed against the Tau Ceti and
  Mathlib names behind them (`TauCeti.ReductiveAffineGroupSchemeCat`, `TauCeti.Pinning`,
  `InvertibleSheaf`, …). ReviewKit's `Fingerprint.lean` says the statement level references
  other constants "by its qualified name only", so a *rename* changes the hard pin while a change
  *inside* a referenced definition only changes the digest [S].
- The import rule lets `Abstract`, `Foundations` and `Staging` import Tau Ceti; every other
  `GLCinLean` module may import only `Init`, `Mathlib`, `GLCinLean` ("no Tau Ceti directly").
- If it goes: `review` cannot run; nothing else breaks.

**`reviews/sorry-budget.toml`** — four entries (`exists_dualGroup`, `exists_isLanglandsFunctor`,
`isLanglandsFunctor_unique`, `main`), each bound to a SHA-256 statement fingerprint and a
transitive digest. Every `approved` field is empty; the header says "NOT YET APPROVED".
**`reviews/statement-pin.toml`** — pins `main` and `Setting` at two levels: `statement` (hard:
"CI fails on a mismatch until the owner re-approves") and `digest` (Tau Ceti bodies included;
only "stale"). Also never approved.
- Used only by `review axioms` and `review pin`. With CI gone, "CI fails" no longer happens;
  the pin is checked only when someone runs `review` by hand.
- If they go: nothing breaks except those two checks.

**`blueprint/plans/GLCinLean/{Abstract,Foundations}.toml`** — tracker plans that mirror the 31
existing declarations (13 + 18 nodes), with only `id`, `source` and a few `deps`; no `desc`, no
`kind`. Their headers call them a "stub plan … the blueprint replaces it".
- Used by the tracker, but only with `--dir blueprint/plans` (the tracker's default is
  `plans/`). Without the flag the tracker reports no plan; the flag was recorded only in the
  removed `scripts/check.sh` (`lake exe tracker --dir blueprint/plans --roots GLCinLean`) and is
  now written nowhere in the repository.
- `tracker lint` passes ("ok"). `tracker status` reports "26 proved, 5 stated, 0 open": the
  `@[placeholder]` `opaque` definitions count as **proved** [R], so the tracker's progress
  numbers say nothing about whether a definition is real.
- If they go: nothing breaks; the tracker still describes the library without a plan (re-check
  run without `--dir`: "planned declarations: 0 … 38 declarations (30 definitions, 8
  theorems)") [R].

**`references/papers/manifest.toml`** — six papers (GLC I–V and AGKRRV, arXiv id, version,
title, role, licence, SHA-256 of source and PDF). Its only reader, `scripts/fetch-papers.py`
(which downloaded and verified the checksums), was removed in `0feeb6f`. Today it is referred to
by `AGENTS.md`, `PLAN.md` (line 78), `README.md`, `prompts/statement.md`, `prompts/review.md`,
`glc/project.toml` and `THIRD_PARTY_NOTICES.md` (seven files, by `git grep`; the first version of
this note missed `PLAN.md`), plus the `!` exception in `.gitignore`, and read by no program.
Worth keeping from it: the pinned versions (GLC I v3, II v3, III v1, IV v1, V v3, AGKRRV v2) and
AGKRRV's licence note ("arXiv non-exclusive distribution licence 1.0 … never copy, link only");
the others are CC BY 4.0. At the time of the re-check, `references/papers/` held sources for
three of the six (`2405.03599v3`, `2405.03648v3`, `2010.01906v2`), fetched during this research
step.

### Text for people and agents

**`AGENTS.md`** (277 words) — one line of goal, a pointer to `PLAN.md`, then notes: the cache
commands (`LAKE_CONFIG`, `LAKE_CACHE_DIR`, `lake exe cache get`, `lake cache get --service
tauceti-public …`), the sign of a wrong pin ("Built Mathlib.…" without `:c.o`), the placeholder
pattern, the abstract's import rule, the owner's files, papers and provenance headers, and the
[R]/[S]/[E]/[J] claim tags. The re-checking session (Claude Code 2.1.319) was given it as
project instructions with no `CLAUDE.md` in the repository [R], so the file
name works here; whether other versions or tools do the same was not checked.

**`PLAN.md`** (728 words) — goal, what exists, how sessions run, "Decisions in force"
(statement, code, checks, project), open questions, next step. Its statement decisions are
**also recorded in the doc comments of `GLCinLean/Abstract.lean`**, in more detail (the
hypotheses with TeX line numbers, the square root as data, every pinning, the dual-group
existence theorem and its reason, `LG` chosen from Cor. 1.6.5 with uniqueness, "an `A`-linear
natural isomorphism, never an equality", the conjecture) [R, re-check; the first version of this
note said they appear "nowhere else … except partly" in the Lean]. The statement decisions:
- `k` algebraically closed of characteristic 0; `X` smooth, proper, connected; `G` reductive
  (Tau Ceti's); "algebraically closed" and "connected" taken from AGKRRV and GLC II, not from
  GLC I's first sentence;
- every square root of `ω_X`, as data; every pinning;
- the dual group as an input with an identification of root data, plus a sorry'd existence
  theorem "so a wrong identification shows up as a false claim, not a vacuous statement";
- `𝕃_G` chosen from Cor. 1.6.5's existence statement, uniqueness stated too; "isomorphic" is
  always an isomorphism, never an equality; the conjecture is that `𝕃_G` is an equivalence.
- What is in `PLAN.md` only: the code decisions (provider order Mathlib → Tau Ceti → copy from
  Stacks into `GLCinLean/Stacks/` → build in `GLCinLean/Staging/`, naming), the project rules
  ("Subscriptions only; no API billing", "public but unannounced", papers), and the open
  questions (formalism for stacks; wait, copy or build per missing foundation; who the outside
  expert is and when the quiet phase ends).
- It calls GLCinLean-archive "the private repository"; `gh api` confirms it is private and
  archived, so the link in `notes/ideas.md` works only for the owner.
- Typo: line 12 "partialevidence".

**`README.md`** — status banner ("unreviewed, agent-generated"), a table of paths, the build
commands, links to `PLAN.md` and reviewkit, and a mention of `THIRD_PARTY_NOTICES.md` (as code
text, not a link). Its table describes `reviews/` as "(approved by the owner)", although no entry
is approved.

**`THIRD_PARTY_NOTICES.md`** — removed from git in `0feeb6f`, but present in the working tree
as an untracked file. `README.md` on `origin` still names it, so the reference points at nothing
there. The untracked copy is not the removed file verbatim: it differs only in dropping the
mention of `scripts/fetch-papers.py` [R, `diff`]. With the commit message silent about it, the
removal looks unintended [J].
It lists tracker, the cache-service lines, ReviewKit, Tau Ceti, Mathlib and the toolchain with
pins and licences (all Apache-2.0), and says the papers are not redistributed.

**`prompts/`**
- `statement.md` (Goal / Read first / Steps / Notes / Done when): depends on ReviewKit
  (`review placeholders`, `review … axioms --toml`), the sorry budget, `PLAN.md`, `manifest.toml`,
  `GLCinLean/Staging/`. Done when `review placeholders` reports none.
- `proof.md`: depends on `PLAN.md` ("Read first"), the blueprint, the sorry budget and
  `#print axioms`.
- `statement.md` also calls `AGENTS.md` one of "the owner's files", which `AGENTS.md`'s own
  list does not include.
- `review.md`: the fidelity review (numbered steps, no "Notes" section). Scope from ReviewKit's `closure` (`direct_from_project`
  entries: 40 today) plus the abstract's declarations changed since the newest `fidelity/` file
  (the folder does not exist yet). Method: a blind reading by a subagent that sees only the Lean
  text, then a comparison with the paper's LaTeX, verdicts *agree* / *same object, different
  presentation* / *mismatch* / *unsure* with exact lines, output `fidelity/YYYY-MM-DD.md`,
  committed.
- `research.md`: this step, already in the goal / done when / context form.

## 3. What it means for GLCinLean

- **"Prompts only, no harness"** (ideas.md "What I want"; workflow decision on prompts). The
  harness is already mostly gone; what remains (ReviewKit require, `glc/`, `reviews/`) is run by
  nothing. Keeping it means a second Lean package to bump on every Lean release, and a
  60–85 s check whose pins need the owner's approval; dropping it means one code change (a
  replacement for `@[placeholder]` in the Lean files) plus editing the doc comments of
  `Abstract.lean` that name ReviewKit and `reviews/` [J].
- **The `@[placeholder]` mark is the one thing worth keeping from ReviewKit** [J]. The tracker
  counts placeholder `opaque`s as proved, so without some mark nothing distinguishes a
  placeholder from a real definition. A two-line local tag attribute (what `ReviewKit/Attr.lean`
  is: `registerTagAttribute \`placeholder …`) or a `grep`-able doc-comment convention would do;
  the review system (ideas.md, its own repository) could read the same mark [J].
- **Fingerprints match the owner's review-status idea** (ideas.md "Review status"). ReviewKit
  already computes, per declaration, a statement fingerprint and a transitive digest. A
  commit hash says *when* a declaration was reviewed; a content fingerprint says *whether it
  changed* since. The review system could store both [J].
- **The fidelity review in `prompts/review.md` is the most reusable piece** for step 4 (Review)
  of workflow.md: blind reading, then comparison with the TeX, verdicts with exact lines [J]. Its
  scope step depends on ReviewKit's closure and would need another way to list changed
  declarations (for example `git diff` plus the tracker's `graph`) if ReviewKit goes [J].
- **Mathlib style is not yet met** (ideas.md "Code quality"): the header linter fires 17 times,
  neither file starts with the `module` keyword (Mathlib's imports warn about it), and the
  linters are warnings only. Tau Ceti builds with `warningAsError = true` and audits headers and
  `module` separately, so any code meant for a Tau Ceti PR (ideas.md point 4) has to pass these
  anyway [R for the facts, S for Tau Ceti's audits, J for the conclusion].
- **Keeping up is cheap right now, and will not stay cheap.** The pinned tag `v4.36.0-rc2`
  (`e0610cce`, 2026-11-02) is 4986 commits behind Tau Ceti `main`, but `main` still uses the same
  Mathlib (`1b1ccf4b`) and toolchain [R]. Tau Ceti tags follow Lean releases (`v4.35.0`
  2026-10-15, `v4.36.0-rc1` 10-17, `v4.36.0-rc2` 11-02) [R]. Every toolchain move also needs
  tracker (upstream, not ours) and ReviewKit to build on the new Lean [S: tracker README "must
  build on the project's toolchain"; ReviewKit's lakefile "always built by the project's own
  toolchain"; E that either actually breaks: both read Lean internals, ReviewKit needs only core
  Lean]. An automated bump (workflow decision) therefore has to handle tracker and ReviewKit
  besides Tau Ceti and the toolchain, unless they leave this repository [J]. Because Tau Ceti is
  required by a tag, a bump means editing `rev` in `lakefile.toml` (or switching to a branch),
  not only `lake update` [R the file; J the consequence]. Whether the `tauceti-public` cache
  covers untagged `main` commits was not checked.
- **Builds depend on two pieces of local knowledge** that must survive any rewrite of
  `AGENTS.md`: the cache commands with `.lake-config/lake-config.toml`, and the "Built Mathlib…"
  warning sign [J]. If the tracker stays, the `--dir blueprint/plans` flag must be written down
  too (it is currently nowhere) [R].
- **Papers as TeX, untracked** (ideas.md point 5): `.gitignore` already ignores
  `references/papers/*`, `*.tex` and `*.pdf`, so dropping the manifest needs only the removal of
  its `!` exception line. The pinned versions should still be written somewhere one line each,
  because the statement cites "GLC I v3" throughout [J].
- **`PLAN.md`'s statement decisions are already kept in `Abstract.lean`'s doc comments** [R], so
  removing `PLAN.md` (workflow question 2) loses them only if those comments are rewritten
  carelessly. What would be lost is what `PLAN.md` alone holds: the provider order and code
  layout (`Stacks/`, `Staging/`), "subscriptions only", and the open questions [J].

## 4. Conflicts

With the decisions in `notes/workflow.md` [R the text; J that it conflicts]:
- **Pushing.** `PLAN.md`: "Sessions commit locally; the owner reads and pushes" (already listed
  in workflow.md).
- **Sending to other projects.** `PLAN.md`: "Public but unannounced; nothing is sent to other
  projects unless the owner chooses" vs. fully automated Tau Ceti contributions (listed). Also
  `reservoir = false` and "unannounced" in `lakefile.toml`: a Tau Ceti PR from this project
  announces it in practice (not listed).
- **Automated bumps.** Not only `AGENTS.md` ("`lake update` … best left to the owner") and its
  owner's-files list (listed), but also `lakefile.toml` line 12 ("Bumps are the owner's
  decision") and `PLAN.md` ("Tau Ceti is pinned to a tag") — **not listed** in workflow.md's
  "Known conflicts".
- **Statement pin vs. automation.** `reviews/statement-pin.toml` makes a changed statement
  fingerprint fail "until the owner re-approves". Because `glc/project.toml` unfolds the
  Foundations `abbrev`s in fingerprints [R], `Setting`'s hard pin names the Tau Ceti objects
  behind `ReductiveGroup`, `Pinning`, `LineBundle` and Mathlib's `IsProper`,
  `SmoothOfRelativeDimension`, …; a rename of any of them in an automated bump would change it
  and so require the owner, while changes inside their bodies only mark the digest stale
  [S: ReviewKit's `Fingerprint.lean` doc; E: not tested]. With CI gone, the failure is no
  longer enforced anyway.
- **Prompt form.** `prompts/statement.md` and `proof.md` have "Steps" and "Notes" sections, and
  `review.md` four numbered steps, all with procedure and constraints; workflow.md says prompts hold "only the goal, the
  completion criteria and the context, with few constraints".
- **`AGENTS.md` content.** workflow.md wants it to carry "the main goal, and the requirement
  that all text uses plain, understandable, structured words"; the current file has neither the
  plain-words rule nor more than one line of goal, and points to `PLAN.md` for the rest.

With `notes/ideas.md`:
- **Manifest.** ideas.md: "I don't see the point of `references/papers/manifest.toml`". Six
  files still refer to it; no program reads it since `0feeb6f` [R].
- **Library vs. staging.** ideas.md point 1 wants a library for geometric representation theory;
  `PLAN.md` puts locally built foundations in `GLCinLean/Staging/` (a temporary-sounding name)
  behind a `Foundations` re-export layer, and `glc/project.toml` forbids every module other than
  `Abstract`, `Foundations` and `Staging` from importing Tau Ceti ("no Tau Ceti directly") [R the
  rules; J the mismatch].
- **Order of sources.** `PLAN.md` copies from Stacks into `GLCinLean/Stacks/`; ideas.md adds a
  step it lacks: contribute to Tau Ceti when a Tau Ceti roadmap covers the object.
- **Review system location.** ideas.md wants the review system in its own repository, based on
  tracker; here tracker is a submodule of this repository and ReviewKit a separate dependency.

- **Archive link.** ideas.md lists GLCinLean-archive as a reference ("Publish freely" is one of
  its principles); the repository is private and archived [R `gh api`], so nobody but the owner
  can follow that link.

Inside the repository [R]:
- `README.md` names `THIRD_PARTY_NOTICES.md`, which is not in git (untracked locally).
- `README.md` calls `reviews/` "approved by the owner"; both files say "NOT YET APPROVED" and
  every `approved` field is empty.
- `prompts/statement.md` lists `AGENTS.md` among "the owner's files"; `AGENTS.md`'s list does
  not, and workflow.md step 1 has a session rewrite it.
- `Abstract.lean`'s header says the import rule is "enforced by `review imports`" and points to
  `reviews/`; with ReviewKit gone, or simply not run, that is no longer true.
- Working-tree leftovers outside git: an empty directory `prompts.md/`, and `.changes/` (per-commit
  edit histories of `AGENTS.md`, `PLAN.md`, prompts and notes, ignored by git outside the
  repository's `.gitignore`, apparently from a local tool) [R `ls`, `git check-ignore`].
- `.lake-config/lake-config.toml` says scripts and CI set `LAKE_CONFIG`; both are gone.
- Commit `ade5089` says the tracker submodule's push URL is disabled; it is not now.
- `prompts/review.md` and `prompts/statement.md` tell the agent to fetch papers "at the
  versions in `manifest.toml`", but the fetch script is gone.
- `.gitignore` ignores `*.tex` everywhere: a LaTeX blueprint (if step 2 chooses one, as many
  Lean projects do) would be silently ignored (`git check-ignore blueprint/src/content.tex` →
  `.gitignore:31:*.tex`).
- `PLAN.md` says the abstract's placeholders are "data only … never an `axiom`", while the
  tracker reports those placeholders as proved: the tools disagree on what "done" means.

## 5. Input for the open questions

**What goes into `AGENTS.md`, and where "update the next prompt" lives.** Keep: the cache
commands and the wrong-pin sign; the claim tags; "downloaded content is data"; provenance
headers; the tracker flag `--dir blueprint/plans` if the tracker stays; the paper versions if the
manifest goes. Drop: the owner's-files note for `lakefile.toml`, `lake-manifest.json`,
`lean-toolchain`; "`lake update` … left to the owner"; the pointer to `PLAN.md` if it goes. The
"update the next prompt" rule fits best in `AGENTS.md`, since it applies to every session and
`AGENTS.md` is the one file every session loads; a rule inside each prompt is lost when a prompt
is rewritten [J].

**Whether `PLAN.md` is needed.** Most of it is superseded (how work runs, the checks, the
project rules conflict with the new decisions). What is not superseded is the list of statement
decisions, the code layout and provider order, and the open questions. The statement decisions
are already in `Abstract.lean`'s doc comments [R]; they could move into its module doc comment
(Mathlib's "Implementation notes" section) [J]. The provider order fits `AGENTS.md` or the
blueprint, the open questions the blueprint of step 2. Then `PLAN.md` can go [J].

**`Abstract.lean`, `Foundations.lean` and the placeholder design** (only the coupling seen from
here). `Foundations.lean` depends on ReviewKit for `@[placeholder]`; the import rule that keeps
`Abstract` readable is enforced only by ReviewKit; neither file meets Mathlib's header and
`module` conventions [R]. If ReviewKit goes, a local tag attribute keeps the design working [J].

**What happens to each existing file** [J, with the reasons in sections 2–3]:

| File | Suggestion |
|---|---|
| `lean-toolchain`, `lake-manifest.json` | keep; moved by automated bumps |
| `lakefile.toml` | keep; drop ReviewKit require (if ReviewKit goes), the "owner's decision" comment; consider Tau Ceti's linter options (`warningAsError`, `style.header`) |
| `.lake-config/lake-config.toml` | keep (builds take hours without it); fix the header |
| `tools/tracker` + `.gitmodules` | keep while the tracker is used here; move to the review-system repository once it exists |
| `blueprint/plans/` | replace by the step-2 blueprint (stub today) |
| ReviewKit require + `glc/project.toml` + `reviews/` | drop together, or keep together; never approved, not run automatically |
| `@[placeholder]` | keep the mark; provide it locally if ReviewKit goes |
| `references/papers/manifest.toml` | drop; record the six versions and AGKRRV's licence in one place; remove the `!` line in `.gitignore` |
| `prompts/statement.md`, `proof.md` | rewrite in the new form (they depend on ReviewKit and `PLAN.md`) |
| `prompts/review.md` | keep the method; replace the ReviewKit scope step |
| `PLAN.md` | move the statement decisions out, then remove |
| `README.md` | keep; update table and links |
| `THIRD_PARTY_NOTICES.md` | settled: the owner removed it on purpose (2026-11-08); remove the README mention |
| `.gitignore` | drop `private/`; reconsider `*.tex` if the blueprint is LaTeX |
| `LICENSE` | keep (Apache-2.0, same as Mathlib and Tau Ceti) |

**Who reviews the mathematics.** The budget and pin were built for owner approval, and no entry
was ever approved [R]; the owner says they cannot check the mathematics (AGENTS.md). Approval by
the owner is therefore a check of process, not of content [J]. `PLAN.md` already says "no claim
of faithfulness is made without an outside expert" [R]; fresh-agent blind readings
(`prompts/review.md`) are the evidence until then [J].

**Where research notes and session summaries live.** Commit messages already carry detailed
session summaries (for example `ade5089`, `7265f9a`, `a6de757`) [R]. `notes/research/` is
committed per `prompts/research.md`. A separate session-summary file would duplicate the commit
log [J]; `.gitignore` already has `scratch/` and `tmp/` for anything not to be committed.

## 6. Questions for the owner

1. **ReviewKit:** drop it (and `glc/project.toml`, `reviews/`) and keep only a local
   `@[placeholder]` mark, or keep it as the check run before each commit?
2. **Owner's files:** with automated bumps, are `lakefile.toml`, `lake-manifest.json` and
   `lean-toolchain` still yours to approve first, or is seeing the change in the commit enough?
3. **Pinned statement:** if a pinned statement (`main`, `Setting`) changes, for example by a
   Tau Ceti rename during a bump, should work stop for you, or is a note in the commit enough?
4. **Paper versions:** with the manifest gone, where should the six arXiv versions be written
   (one line each in `AGENTS.md`, or in `README.md`)?
5. **Tracker:** stay as a submodule here, or move to the review system's repository once it
   exists?
6. **"Public but unannounced":** does this end with the first Tau Ceti pull request?
7. **`THIRD_PARTY_NOTICES.md`:** settled on 2026-11-08: the owner removed it on purpose and deleted the untracked copy; the README mention goes.
8. **Tau Ceti pin:** keep requiring Tau Ceti by release tag (bumps follow Lean releases), or
   follow its `main` (4986 commits ahead, same Mathlib and toolchain today)?
