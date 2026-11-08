# Tau Ceti: contribution requirements and version moves

- **Source:** the TauCetiProject organisation on GitHub, read at these commits:
  - TauCeti `d2083f0f1dd2136d02467ba36efbbe1af612e89c` (README.md, AGENTS.md, `.claude/CLAUDE.md`,
    COORDINATION.md, `docs/toolchain-tags.md`, `docs/mathlib-shim-registry.md`,
    `docs/security-audit.md`, `bors.toml`, `.github/CODEOWNERS`, `.github/pull_request_template.md`,
    `tauceti.toml`, `lakefile.toml`, `formalization.yaml`, git history and tags)
  - TauCetiRoadmap `7bf4638c3b94bcd25137be0d5ec4310f93bc8a00` (README.md, CONTRIBUTING.md, AGENTS.md)
  - TauCetiWorker `ae6b1c9b19017a11e646d47e41e5f62b2eb24edc` (README.md, `docs/reference.md`,
    `prompts/roadmap.md`, `docs/redesign/specs/ai-merge-queue.md`, `docs/queue/rehearsal.md`,
    `docs/forgejo-preparation.md`)
  - TauCetiRoadmapWorker `e1830ae6ad1055d3e7211a982f22d6c0b18c8fb6` (README.md, `docs/DESIGN.md`)
  - TauCetiTools `2c1ad61f472442b503f442e034921d3576660365` (README.md, `docs/review-coordination.md`,
    `docs/project-setup.md`, `docs/forgejo-preparation.md`,
    `tauceti_tools/assets/scripts/housekeeping.py`, `tauceti_tools/assets/project/.github/workflows/`)
  - TauCetiReview `abb443922e8dc13156cfff0c8703647be93f549a` (REVIEWING.md, `runner/admission_policy.py`)
  - TauCetiFleet `3aed465796debecb9187208bbbca35bc784fdf93` (README.md, opening only)
  - TauCetiProject/bors-ng `0147a23ef7b169bea8700022a2055a4ecac69503` (`deploy/manual-approval.md`)
  - tauceti-claims and TauCetiRoadmapJobs (READMEs); leanprover-community/intentions `7d75116`
    and leanprover-community/project-intentions `9a41615` (READMEs)
  - Pull-request data through the GitHub API; Mathlib's tags through the GitHub API.
- **Checked 2026-11-08.** An independent re-check on 2026-11-08 (about 21:30 UTC) went back to the
  same commits and the API. It corrected the merge mechanism (2.2), the owner's record (2.4), the
  tag history (2.5), and added TauCetiTools' downstream updater (2.6) and the planned Forgejo move.
- **Licence:** Tau Ceti is Apache-2.0, as is GLCinLean, so code can move between them. Tau Ceti
  files carry the header "Copyright (c) 2026 The Tau Ceti contributors … Authors: The Tau Ceti
  contributors".
- Other notes cover the library's contents (`tauceti-library.md`), the review rubrics
  (`tauceti-review.md`) and the roadmaps (`tauceti-roadmaps.md`). This note covers the process:
  who may contribute and how, and how versions move.

## 1. What it is

Tau Ceti is a Lean library downstream of Mathlib. Its code is written by AI agents, roadmaps
written by humans say what it should contain, and AI agents review it against rubrics written by
humans. It is spread over many repositories:

| Repository | Role |
|---|---|
| TauCeti | the Lean code (`TauCeti/`, 27,553 `.lean` files [R]) |
| TauCetiRoadmap | the roadmaps written by humans; intentions and claims are issues here |
| TauCetiReview | the rubrics and the `tauceti-review` engine |
| TauCetiWorker | the reference worker CLI `tauceti` (it authors, fixes, reviews and repairs bumps) |
| TauCetiRoadmapWorker, TauCetiRoadmapJobs, tauceti-roadmap-claims | AI-planned roadmaps; a human merges them |
| tauceti-claims | Git-ref leases between workers, and nothing else |
| TauCetiTools | shared CI and configuration, which other Lean projects can also use |
| bors-ng (fork), TauCetiFleet, TauCetiCI, TauCetiData, TauCetiProgress, TauCetiWebsite | the old merge bot (replaced in production by the AI merge queue, see 2.2), CI runners, records, progress reports, website |
| forgejo (fork), TauCetiQueueScratch, forgejo-preparation-rehearsal-… | preparation for moving development to a self-hosted Forgejo server; rehearsal of the AI merge queue |

[R 2026-11-08, from `gh repo list TauCetiProject`]

## 2. What it says that matters for GLCinLean

### 2.1 Who writes code, and what they say about AI agents

- "Our goal is to formalize as much mathematics as we can … subject to the constraint that
  everything is written by AIs." "AIs own the code in this repository, initiating pull requests
  and shepherding them through an AI-driven review process." Humans "can raise issues against the
  code, and leave implementation (and review) to AIs." [R TauCeti README, 2026-11-08]
- COORDINATION.md: "many independent agents, not one blessed bot, may review, fix, and author PRs
  concurrently … Anyone can run their own agent. You do not have to use any particular script."
  [R]
- `formalization.yaml`: `automation.method: "autonomous"`. [R]
- Contributors pay for the code they generate: "expect that contributors will cover the costs of
  generating the code included in their PRs." Tau Ceti runs CI and (for now) some reviews. [R README]
- Contributors are ordinary GitHub accounts. The worker "runs as your authenticated `gh` account
  … You author through **your own fork** … you do **not** need write access to the canonical repo."
  It supports several accounts (`--github-account`). No bot account is required. [R TauCetiWorker README]
- Of the 5,883 commits that reached `main` from 2026-11-01 to 2026-11-08, 50 distinct authors
  made them. The largest were `tauceti-ai-for-science` (1,610), `tauceti-redteam[bot]` (962) and
  `sqrt-of-2`/"√2" (1,274). [R git log]

### 2.2 How a contribution is made

**What may be added.**
- "The roadmap gates *new* mathematics: only add a new mathematical declaration … when it
  advances a specific roadmap target, or supplies a prerequisite that a specific target needs. If
  something you want to build is not on the roadmap — whether a human asked for it or you found
  the gap yourself — select a target supported by the existing roadmaps instead." [R AGENTS.md]
- Improving existing code (refactors, golfing, modest generalisation, moves, documentation) is
  "always in scope". [R AGENTS.md]
- For agents: "Never open a PR or an issue in TauCetiRoadmap yourself." The worker's authoring
  prompt repeats this: "**Never write to the roadmaps.**" and adds "if none is suitable, finish
  without opening a PR". [R AGENTS.md; R `prompts/roadmap.md`]
- If a PR's roadmap fit "remains contested after its bounded repair attempts", its author should
  "close it with an explanation so a fresh attempt can try again". [R AGENTS.md]

**PR format.**
- Every PR body has exactly one line `Roadmap: <CanonicalAreaName>` or `Roadmap: none` (from the
  template). New mathematics must also cite the exact roadmap file and target. [R
  `pull_request_template.md`, AGENTS.md]
- A machine-readable marker `<!--tauceti-target:v1 {"focus":"<area>","id":"<slug>"}-->` lets the
  duplicate sweeper see which target a PR is for. COORDINATION.md marks it `[COOP]` (optional),
  but the worker prompt says "the PR will be rejected without it". [R]
- One topic per PR. The worker prompt aims for "~500–1200 lines of genuine, non-vacuous content".
  A new file may have at most 1,000 lines, and an existing file at most 1,500. [R AGENTS.md;
  `prompts/roadmap.md`; lakefile comment]
- **Stacked PRs are prohibited**, drafts and labelled PRs included: "Wait for each prerequisite to
  land on main before opening its dependent PR". A trusted policy comments on stacks and closes
  them. [R AGENTS.md, README]
- Tau Ceti "does not preserve backwards compatibility". A rename deletes the old name in the same
  PR: no aliases, no `deprecated` shims, no forwarding modules. [R AGENTS.md]

**Code rules enforced by CI.** [R AGENTS.md, lakefile.toml]
- No `sorry`. No axioms beyond `propext`, `Classical.choice` and `Quot.sound`, so no
  `native_decide`. Mathlib's standard linter set with `warningAsError = true`.
- No `set_option` anywhere in library code, no `maxHeartbeats` overrides, no `meta import`, no
  elaborators, `#eval`, `run_cmd`, initialisers or non-local macros. Lean meta code is
  human-owned and lives in `scripts/`.
- Every file uses the module system (it begins with `module` and uses `public import`, checked by
  `lake exe module-system`) and carries the Tau Ceti copyright header (checked by
  `scripts/HeaderStyle.lean`).
- Declarations go in `namespace TauCeti` by default, or in an existing Mathlib namespace when
  dot notation needs it. [R `prompts/roadmap.md`]
- Code goes only under `TauCeti/`. `scripts/`, `.github/` and the lakefile are human-owned.
  `lake-manifest.json` and `lean-toolchain` may change only as a forward-only bump that the
  `bump-guard` check validates. [R AGENTS.md, CODEOWNERS]

**Review.**
- After CI passes, an AI review is run against the rubrics (correctness, reuse, scope,
  attribution, api-design, generality, placement, naming, documentation, proof quality,
  deprecation). It posts a "scoreboard" comment whose state is approved, changes requested or
  blocked. [R README, AGENTS.md]
- Tau Ceti's automatic CI review is "currently switched off". Reviews come from "the trusted
  operator-run worker and from ad hoc command-line runs" (`uvx --from
  git+https://github.com/TauCetiProject/TauCetiReview tauceti-review <PR> --post`). [R README;
  REVIEWING.md]
- Anyone may write a scoreboard, and the PR author's own scoreboard counts for merging.
  `current_scoreboards` in `runner/admission_policy.py`: "There is deliberately no author access
  bar: ordinary contributors' posted reviews count". The merge gate takes the newest completed
  scoreboard for the current head, and only if it records the current merge base. The housekeeping
  script says "The reviewer and the PR author are frequently the same account". REVIEWING.md: the
  tool is "for people the project already trusts … nothing stops a reviewer from rubber-stamping —
  the safeguard is social, not technical." [R]
- REVIEWING.md on subscriptions: "Driving a personal Claude/ChatGPT/Kiro subscription as an
  automated reviewer is fine for occasional, interactive, human-initiated runs like this. Standing
  it up as a 24/7 self-hosted auto-reviewer is closer to API-tier usage and likely outside
  subscription terms — for always-on review, enable Tau Ceti's CI path and use `--auth api` with
  API keys." [R]
- When two findings contradict each other, contest one thread, link the other and quote both;
  do not silently satisfy one of them. [R AGENTS.md]

**Merge.**
- A PR that changes only `TauCeti/` (plus `TauCeti.lean`, `docbuild/docs/references.bib` or a
  bump-guarded pin) is admitted for merging automatically once every rubric is green on the
  current head and the `build`, `scope` and (for pins) `bump-guard` checks pass. A PR touching
  `scripts/`, `.github/` or the lakefile needs a repository admin's `bors r+`. [R `decide_merge` in
  `admission_policy.py`; README; bors `manual-approval.md`]
- **The merge engine is no longer bors-ng.** Since 2026-11-04 an "AI merge queue" (the
  `tauceti_queue` package in TauCetiWorker, bot `tauceti-queue[bot]`) "has owned production
  merging", and "automatic admission since November 6". It keeps the bors commands, labels and
  the "[Merged by Bors]" title as a compatibility surface; `bors.toml` (squash, batches of up to
  128) describes the retired engine. [R `docs/redesign/specs/ai-merge-queue.md`, status line dated
  2026-11-07; R PR #32067, landed by `tauceti-queue[bot]`]
- **The queue may change a PR while landing it.** It builds batches of approved PRs; when a
  batch conflicts or fails, agents repair it. "Once a PR enters staging, the default is to land the
  AI's best effort at merging/fixing its content … If the original author or a reviewer
  subsequently finds a problem, they address it in a follow-up PR." Each landed commit carries
  `Source-PR:`, `Accepted-Head:` and, if repaired, a `Rebase-repair:` trailer, and the landing
  comment gives "a diff against the accepted head". An author can opt out with the label
  `dont-repair-in-queue`; such a PR is withdrawn instead of edited. [R ai-merge-queue.md; R
  commit messages on `main`, for example Source-PR #26962]
- Do not `--admin`-merge AI-authored PRs. [R AGENTS.md]
- A landed PR shows on GitHub as *closed*, with the title "[Merged by Bors] - …", not as
  *merged*. Some landed PRs keep their old title (bump #16333 is on `main` but not so titled), so
  the reliable landing evidence is the `(#n)` suffix or the `Source-PR:` trailer on `main`. [R PR
  #32067; R git log]

**Housekeeping: when a PR is closed automatically** (the defaults). [R `housekeeping.py`]
- `stale`: labelled `awaiting-author` with no activity for 7 days (unresolved merge conflicts
  count).
- `red`: `ci-failed` continuously for 7 days.
- `budget`: 10 review rounds (`REVIEW_BUDGET`, "Lifetime review rounds", read from the
  scoreboard's `full_rounds`) and still blocking at the current head.
- `dedup`: a newer PR with the same target marker as an older open one.
- `empty`: the diff is already on `main`.
- A `keep`/`hold`/`wip`/`human`/`do-not-close` label exempts a PR, except from the stacking
  policy. The owner's PR #16869 was closed by the 7-day stale rule on 2026-10-22. [R]

**Merge conflicts.** `main` moves very fast (see 2.4). When a PR stops merging, the bot labels it
`merge-conflict`/`awaiting-author`, and the author must rebase, or drop parts that `main` now
supplies. [R PR #32067 timeline]

**Planned move to Forgejo.** TauCetiTools' `docs/forgejo-preparation.md`: "Forgejo owns source,
PRs, reviews, issues, and merges … The main branch mirrors back to GitHub." "Agents retain
familiar `gh` commands through a process-local compatibility layer." Preparation "does not
activate production Forgejo bindings"; no date is given. [R, 2026-11-08] So the place where PRs
are opened may change; a pin to the GitHub URL should keep working through the mirror. [J]

### 2.3 Claims and intentions

There are two separate mechanisms.

1. **Intentions (human-facing, on TauCetiRoadmap).** Open an issue titled `[Intention]: …` with
   the Intention template, naming the area and the specific targets, then comment `claim` (or
   `claim 3 weeks`). A claim lasts 30 days by default and at most 90, and opening a PR with
   `Closes #<issue>` refreshes it. Workers "will not author a target that someone else has
   claimed". 268 intention issues exist (2026-11-08, 21:30 UTC), filed by named people (for example #1934 "FlagVarieties
   Layer 1, the GL case", 2026-11-07). [R TauCetiRoadmap README; GitHub search]
   - An `administrative-hold` label applied by a maintainer binds every worker. [R TauCetiWorker README]
   - Steering a worker: `--roadmap-only <area>` pins the area; `--extra-roadmap-prompt <text>`
     "steers the choice of target within the designated roadmap"; `--source <path-or-url>`
     "adapts compatible material from an existing repository" (supplementary: roadmap first, then
     quality, then migration). `--roadmap-extra-identities` lists logins whose claims count as your
     own. [R TauCetiWorker README]
2. **Leases (between agents, on tauceti-claims).** `refs/tauceti-claims/<key>` is a ref pointing at an
   orphan commit with a JSON lease, taken by `git push --force-with-lease` (compare-and-swap). The
   keys are `branch/<pr>` while fixing a PR and `author/<area>/<target-slug>` while authoring.
   They are optional (`[COOP]`). An account gets push access automatically once it has had a PR
   merged into TauCeti; until then, leases live in its own fork. [R COORDINATION.md;
   tauceti-claims README; TauCetiWorker `docs/reference.md`]
3. **Rules every agent must follow (`[HARD]`).** Push to a PR branch only with
   `--force-with-lease=<ref>:<observed_oid>`, and create a new branch with an empty expected
   value. Merge only when a visible review shows every rubric green on the current head. Close a
   PR only on visible evidence (`review-budget-spent`, or stale with changes requested). [R
   COORDINATION.md §§1, 5]

On frontier work, the Tau Ceti README says a "credible intention to work on a frontier project"
lets Tau Ceti keep its results out of the roadmaps. It hopes such projects "direct their AIs to
send the foundational material they build to Tau Ceti, and then announce the 'research result' as
an independent downstream project", and recommends registering at
leanprover-community/project-intentions. That registry is "purely informational", any GitHub
account may use it, and a search for "Langlands" there found no issues. [R README; R
project-intentions README; search 2026-11-08]

### 2.4 How long review and merge take in practice

- **Volume.** 5,883 commits landed on `main` (first parent) from 2026-11-01 to 2026-11-08 (about
  735 a day). PRs opened per day: 550 on 10-28, 546 on 11-02, 853 on 11-05, then 2,165 on 11-06
  and 1,288 on 11-07. At 21:27 UTC on 11-08, 2,956 PRs were open, 2,705 of them opened since 11-06,
  so a backlog is growing fast. [R git log; GitHub search by creation date]
- **Landing rate.** Of the PRs opened on each day, the share titled "[Merged by Bors]" was 477/550
  (87%) for 10-28, 512/546 (94%) for 11-02 and 749/853 (88%, 73 still open) for 11-05. The re-check
  counted the same days from `main` instead (PR numbers in each day's number range that appear in
  a commit subject or `Source-PR:` trailer): 479/551, 515/563 and 751/854, which agrees. GitHub's
  `closed:<date>` search is unreliable at this volume (it found 186 PRs closed on 11-07, while
  `main` gained 1,104 PR commits that day). [R search counts; R git log]
- **Open to landed** (a random sample of 300 PRs that landed from 2026-11-05 on): median 22 h,
  p10 7 h, p25 15 h, p75 31 h, p90 46 h, maximum 130 h. `feat` PRs: median 27 h; `refactor`: 18 h.
  [R computed from the API; E it counts only PRs that landed, so it is optimistic] The re-check
  took the whole 11-05 cohort instead (all 751 landed PRs opened that day): median 23 h, p10 10 h,
  p25 19 h, p75 28 h, p90 35 h, maximum 61 h, with 73 of 854 still open after three days. [R
  GraphQL API; E the open 9% will raise the tail]
- **Example** (#32067, by fzaiser): opened 11-07 15:24, merge conflict 17:54, rebased, approved by
  a contributor's (sqrt-of-2's) posted scoreboard at 20:58, landed by `tauceti-queue[bot]` on 11-08
  10:58. That is 19.5 h, most of it after approval, in the merge queue. [R timeline]
- **The owner's own record:** 11 PRs in `roadmap/CombinatorialHeegaardFloer` (2026-09-30 to
  10-16). **10 of the 11 landed on `main`**: 7 were merged on GitHub directly (#10286, #10287,
  #10298, #10401, #10971, #11998, #12013, within 2–25 h, before bors took over), and 3 landed through
  bors (#12415 in about 7 days, #12427 in 3 h, #17136 in 4 h). Only #16869 was closed, by the 7-day
  stale rule, after a changes-requested scoreboard on 10-15. The owner's account has a fork
  (`WHY-Op109/TauCeti`) and write permission on tauceti-claims. [R GitHub API; R git log]

### 2.5 How Tau Ceti moves to new Mathlib and Lean versions

- **It tracks Mathlib `master`.** The lakefile has `rev = "master"`, and only
  `lake-manifest.json` records the exact commit. "AIs are encouraged to make PRs to Tau Ceti that
  bump the pin". [R lakefile.toml, README]
- **The bump flow.** An hourly workflow (`update.yml`, cron `23 * * * *`) picks "the newest
  successfully built Mathlib master commit whose full cache it can verify". The review bot opens one
  `bump-mathlib/` PR and keeps that target fixed while workers repair TauCeti. Full CI, the axiom
  audit, review and bors must pass. "The worker never opens a bump itself." [R README;
  update.yml; TauCetiWorker README]
- **Cadence in practice.** A bump landed every one to three days in September and about daily from
  late September to 10-13; from 10-14
  to 10-19 several a day, usually 2–24 h after they were opened. Then none landed between #18871
  (10-22 04:08) and #26414 (11-02 18:08), 11 days; bump #19872 (opened 10-22) was closed unmerged
  after 11 days. #26780 had been open for 6 days on 11-08. Bot bumps are exempt from the 7-day
  closing rules. So Mathlib can be days to about two weeks behind. The current pin is Mathlib
  `1b1ccf4b` (a Mathlib commit of 2026-11-02 01:57 UTC), about 6.7 days behind Mathlib master on
  11-08. [R GitHub API; R `housekeeping.py`]
- **The toolchain follows Mathlib.** `scripts/check-bump.sh` requires TauCeti's `lean-toolchain`
  to equal Mathlib's at the pinned commit. [R `docs/toolchain-tags.md`]
- **Toolchain tags.** "`vX` is the first commit on `main` whose `lean-toolchain` is
  `leanprover/lean4:X`." A tag promises that post-merge CI passed and the oleans are in the Lake
  cache. It also has to lie at or behind the protected security-audit cursor. Tags are admin-only
  and immutable. [R `docs/toolchain-tags.md`]
  - Tags so far: v4.33.0-rc1, -rc2, v4.33.0, v4.34.0-rc1, -rc2, v4.34.0, v4.35.0-rc3, v4.35.0,
    v4.36.0-rc1, v4.36.0-rc2. Mathlib has five releases in that span that Tau Ceti does not tag:
    v4.35.0-rc1, -rc2 and -rc4 (`main` went from v4.34.0 straight to v4.35.0-rc3, then to v4.35.0)
    and the patch releases v4.33.1 and v4.34.1. [R git tags; R Mathlib tags; R `git log
    lean-toolchain`] The document names two causes of an "unreachable" release: the bump "stepped
    over the release's window on Mathlib master", or "Mathlib cut the release on its `stable`
    branch, which `check-bump.sh` will not let this repository pin at all". [R
    `docs/toolchain-tags.md`] The patch releases are probably of the second kind. [E]
  - Three tags (v4.33.0-rc1, -rc2, v4.34.0-rc1) were created together on 2026-08-20, 9–20 days after
    their commits, and v4.33.0 on 08-21. v4.33.0 is the exception to the rule: "a commit off
    `afb1aacb` changing only the two pin files, built from source", not a commit on `main`; the
    document says new tags must use audited `main` history. Since then the delay from the commit to
    its tag has been 1–11 days, for example v4.36.0-rc2: commit 11-02, tag 11-03; v4.35.0: 10-15 →
    10-22. Tagged commits are 2–25 days apart. Every `lean-toolchain` change on `main` since
    v4.33.0-rc1 has been tagged. [R git tags with tagger dates; R `docs/toolchain-tags.md`]
- **Mathlib shim registry.** `TauCeti/mathlib-shims.json` lists Tau Ceti code that is waiting for
  an exact Mathlib replacement. Each entry gives the declarations or modules to look for in the
  pinned Mathlib. When a Mathlib bump finds an exact match, `build` goes red, and the bump worker
  has to migrate to Mathlib's version in that PR. [R `docs/mathlib-shim-registry.md`]
- **Overlap scan.** Worker phases `overlap-scan`/`overlap-fix` read new Mathlib commits for
  material that duplicates Tau Ceti, and refactor Tau Ceti onto it. [R TauCetiWorker README]
- **The cache.** `lake exe cache get` fetches Mathlib's oleans. `scripts/lake-cache-get.sh` (or
  `lake cache get --service tauceti-public …`) fetches Tau Ceti's, which are stored per revision.
  The script "looks back through ancestors of your checkout to find the nearest published one".
  After a `lean-toolchain` bump, expect a full rebuild until a revision on the new toolchain has
  been published. [R README]

### 2.6 What a downstream project that pins Tau Ceti must do

Tau Ceti's own repository says nothing aimed at downstream users beyond the tag promise and the
statement that "External users of an older revision must update to the canonical API on current
`main`". [R AGENTS.md] TauCetiTools does offer an updater for projects that depend on Tau Ceti (see
below). What follows is what the mechanisms imply:

- **Two ways to pin.**
  - (a) **A tag** (`rev = "v4.36.0-rc2"`, which GLCinLean uses now): it builds from the cache and
    is audited, but it moves only when Lean moves. The pinned tag `e0610cce` (11-02) is already
    thousands of commits behind `main`. [R]
  - (b) **`rev = "main"` with the manifest holding the commit**, as Tau Ceti does with Mathlib:
    the newest content, and per-revision caches through the ancestor lookup, but no audit promise
    and more breakage per step. [R README; J]
- **Updating.** `lake update TauCeti` moves TauCeti's commit in the manifest. Mathlib and the other
  packages come with it ("inherited": true in GLCinLean's manifest). [R lake-manifest.json] Lake
  v4.36.0-rc2's `Workspace.updateToolchain` also raises the root `lean-toolchain` to the newest
  toolchain among the direct dependencies, unless the root's toolchain is fixed; if a dependency
  with a fixed toolchain disagrees, it only warns ("toolchain not updated; multiple toolchain
  candidates"). [R Lake source `Lake/Load/Resolve.lean` in the installed toolchain] Then fetch both
  caches and build. A build that recompiles Mathlib or Tau Ceti means the pin or the cache is wrong.
- **GLCinLean's other direct dependencies move with the toolchain.** ReviewKit (pinned by commit)
  and tracker (a path dependency, a Git submodule) each carry their own `lean-toolchain`
  (`v4.36.0-rc2`) and are Lean meta code. After a Lean bump they are compiled by the new Lean, so
  an automated bump must also keep them building, or the bump stalls on them. [R `lakefile.toml`,
  `.lake/packages/ReviewKit/lean-toolchain`, `tools/tracker/lean-toolchain`; J]
- **A ready-made updater exists.** TauCetiTools ships, for "a project using the shared Tau Ceti
  workflow", an `[[upstreams]]` configuration in `tauceti.toml`, the command `tauceti-tools
  upstreams update --conf tauceti.toml --checkout . --apply`, and a daily workflow "Update
  configured upstreams" that opens a dependency PR. The document names the case directly: "A
  project may depend on both CSLib and TauCeti; Mathlib can be a transitive dependency. Set `update
  = true` only for direct dependencies already present in the manifest. For inherited Mathlib set
  `update = false`." What it does: it "selects forward commits on the configured branches, keeps
  other direct dependencies fixed", "chooses the newest official Lean release or release candidate
  declared by the base or any direct dependency; it never downgrades Lean", resolves in a sandbox,
  does not fetch caches, and "does not edit lakefiles". A guard re-resolves the PR's pins and
  compares the whole manifest; "Lakefile edits still require a human". Limits: public repositories
  only; the document is "Up to date as of 2026-10-21" and calls itself WIP. [R TauCetiTools
  `docs/project-setup.md`, workflow template `update-upstreams.yml`; S for its date] Tau Ceti uses
  the same table for Mathlib (`branch = "master"`, `update = true`). [R `tauceti.toml`] It moves a
  dependency along a *branch*, so it fits `rev = "main"`, not a tag pin. Whether it can be used
  without adopting the rest of TauCetiTools' CI, and how it treats the path dependency `tracker`,
  was not checked. [J; not reached]
- **Expect breakage without warning.** Tau Ceti deletes renamed or superseded names in the same
  PR, so downstream code gets "unknown identifier" errors with no `deprecated` hint. Repairing it
  means looking at Tau Ceti's history (the PR that removed the name). [R AGENTS.md; J]
- **Order of steps.** An automated bump should (1) choose the target (the newest tag, or the newest
  `main` commit with a published cache); (2) run `lake update TauCeti`; (3) check that
  `lean-toolchain` equals Tau Ceti's; (4) fetch both caches; (5) build and repair (GLCinLean,
  ReviewKit and tracker); (6) commit manifest, toolchain and repairs together. With `rev = "main"`,
  TauCetiTools' updater could do steps 1–3 and open the PR. [J]

## 3. What it means for GLCinLean

1. **Automated contribution to Tau Ceti implementation PRs fits Tau Ceti's rules** (decision
   "Tau Ceti contributions are fully automated"). Tau Ceti *requires* its code to be written by
   AI, and the reference worker (`tauceti work --loop`) already automates authoring, fixing,
   rebasing and reviewing. The owner's account already has a fork, 10 landed PRs and write access
   to tauceti-claims. The worker can be steered to GLC-relevant targets with `--roadmap-only` and
   `--extra-roadmap-prompt`, and `--source` can feed it material already written in GLCinLean.
   [R; J]
2. **The roadmap gate decides the split in ideas.md §4.** Only material that advances a target of
   an existing roadmap may be added to Tau Ceti. Everything GLC-specific, and every foundation no
   roadmap covers, has to stay in GLCinLean until a roadmap exists. Step 2 ("each object … mapped
   to Mathlib, Tau Ceti, a Tau Ceti roadmap item, or missing") is exactly the test Tau Ceti applies.
   Relevant roadmaps exist, for example `GeometricRepresentationCategories`,
   `EnhancedDerivedSheaves`, `SchemeAndStackFoundations`, `ReductiveGroups` and `FlagVarieties`
   (see `tauceti-roadmaps.md`). [R directory listing; J]
3. **Roadmaps and intentions need a human** (ideas.md §4, "perhaps write a roadmap"). Agents must
   never open a PR or an issue in TauCetiRoadmap. A roadmap PR merges only when a member of
   `roadmap-reviewers` approves it, and "Nobody should post a roadmap or a review comment they have
   not read carefully themselves". On TauCetiRoadmapJobs, targets are "for now" filed only by
   members of the TauCetiProject `humans` team. A GLCinLean agent can draft a roadmap or an
   intention; the owner has to read it and post it, or ask a `humans` member to file a target.
   [R; J]
4. **No stacked PRs, and each PR takes about a day, so deep chains are slow** (step 3). A chain of
   n dependent Tau Ceti PRs takes about n × 22 h of merge latency [E], plus rebases. GLCinLean has
   to work breadth-first (many independent PRs at once, as the ideas.md /goal prompt already says:
   "don't open stacked PRs"). Meanwhile it can use material that has not landed yet: only from its
   own repository, and never from an unmerged Tau Ceti branch. [J]
5. **Tending PRs is part of "fully automated".** PRs close after 7 days awaiting the author, 7 days
   red, or 10 review rounds. An automated contributor has to rebase and answer findings within a
   few days. This needs a recurring job (the worker's `--loop`, or a scheduled session), not a
   one-off session. The process itself also changes quickly: the merge engine was replaced on
   11-04, and a move of PRs to Forgejo is being prepared. An automation that relies on Tau Ceti's
   own worker and documents, rather than on hand-written `gh` calls, follows such changes more
   easily. [R; J]
   - **What lands may differ from what was approved.** The merge queue may repair a PR while
     landing it. Before GLCinLean builds on its own landed Tau Ceti code, it should read the landed
     commit on `main` (or the landing comment's diff), not the PR branch. The label
     `dont-repair-in-queue` exists for authors who prefer withdrawal to repair; the default seems
     fine for GLCinLean. [R ai-merge-queue.md; J]
6. **Rules for code written for Tau Ceti.** Code written in GLCinLean to be moved to Tau Ceti later
   should already follow Tau Ceti's rules: the `module` header, `namespace TauCeti`, no
   `set_option`, no `sorry`, no meta code, files under 1,000 lines. Then moving it is a copy, not a
   rewrite (ideas.md §1, "Set standards, and meet them"). GLCinLean's own placeholders
   (`@[placeholder]` on `opaque`), the ReviewKit attribute and any `sorry` can never go into Tau
   Ceti. [R; J]
7. **The `Roadmap:` line and the target marker are mechanical.** A GLCinLean prompt for Tau Ceti
   work can simply point to Tau Ceti's AGENTS.md and the worker's `prompts/roadmap.md` rather than
   restate them. Tau Ceti's rules change daily (thousands of PRs, CI changes on 11-08), so a copy
   would go stale (decision on prompts: "goal, completion criteria and context, with few
   constraints"). [J]
8. **Following Tau Ceti automatically** (decision "Keeping up with Mathlib and Tau Ceti is fully
   automated"). This fits Tau Ceti's model; Tau Ceti itself does this with Mathlib. Two choices
   matter:
   - **What to pin** (2.6): tags are safer, but the content lags weeks behind, including the
     owner's own merged Tau Ceti PRs. `main` gets content within hours.
   - **Which file changes:** with `rev = "main"`, a bump changes only `lake-manifest.json` and
     `lean-toolchain`, never `lakefile.toml`. This copies Tau Ceti's own rule ("Mathlib's lakefile
     `rev` must always remain `master`") and keeps bumps out of the lakefile, which is the owner's
     file. With a tag pin, every bump edits `lakefile.toml`.
   - **Who does it:** TauCetiTools' upstream updater already implements this policy (forward-only,
     never edits the lakefile, raises Lean to the newest release any direct dependency declares). It
     could be adopted rather than rebuilt; it does not repair breakage, so a session still has to
     fix GLCinLean, ReviewKit and tracker on the bump PR.
   [R; J]
9. **Patterns worth copying for ideas.md §1** ("continuously refactor to adopt their decisions",
   "Avoid duplication"). Tau Ceti's shim registry and its overlap scan turn "adopt upstream when it
   lands" into a check that fails the build. GLCinLean could keep a small registry of local
   declarations that wait for Mathlib or Tau Ceti, with the upstream name to look for, and check it
   on each bump. [J]
10. **Reviewing other people's PRs.** The ideas.md /goal prompt asks to run "commensurately many
    reviews on other people's PRs". This is welcome: the worker's `--only review` and the review
    lottery exist for it. But REVIEWING.md says always-on review from a subscription is "likely
    outside subscription terms", while PLAN.md says "Subscriptions only; no API billing". [R; J]

## 4. Conflicts

- **"Fully automated" (workflow.md decision) vs TauCetiRoadmap's human-only rules.**
  Implementation PRs can be fully automated. Intention issues, roadmap PRs, roadmap review and
  target filing on TauCetiRoadmapJobs cannot, under Tau Ceti's rules (AGENTS.md: "Never open a PR or
  an issue in TauCetiRoadmap yourself"; CONTRIBUTING: posted roadmaps must be read by their poster).
  [R]
- **ideas.md §4 ("I might not be able to review a roadmap fully") vs CONTRIBUTING.** A roadmap
  author must have read the roadmap carefully. Roadmap reviewers are asked to say which aspects
  they checked, so a scope-only human review plus marked AI review is allowed. But a roadmap
  posted unread is not. [R; J]
- **Subscriptions only (PLAN.md) vs automated review (TauCetiReview REVIEWING.md).** Occasional,
  human-initiated `tauceti-review` runs on a subscription are fine. A 24/7 loop is "likely outside
  subscription terms". The same caution plausibly applies to a 24/7 authoring loop
  (`tauceti work --loop` on a subscription), although the worker README itself paces subscriptions
  and does not raise the point. [R REVIEWING.md; J about authoring]
- **AGENTS.md ("`lake update` … left to the owner"; `lakefile.toml`, `lake-manifest.json` and
  `lean-toolchain` are the owner's files) vs the decision to automate keeping up.** workflow.md
  already lists this conflict. Pinning `rev = "main"` would confine automated bumps to the two
  pin files. [R; J]
- **PLAN.md ("Tau Ceti is pinned to a tag") vs following Tau Ceti closely.** Tags appear only with
  Lean releases, every 2–25 days, and some releases are skipped. Code GLCinLean contributes to Tau
  Ceti is not usable from GLCinLean until the next tag. [R; J]
- **PLAN.md ("Public but unannounced") vs Tau Ceti's collaboration model.** Tau Ceti suggests
  registering frontier projects at project-intentions, and contributing to Tau Ceti makes the
  account's activity public anyway. The registration is optional. [R; J]
- **COORDINATION.md vs the worker prompt on the target marker.** COORDINATION.md calls the
  `tauceti-target` marker `[COOP]` (optional). The authoring prompt says a PR "will be rejected
  without it". Treat it as required. [R]
- **Self-review.** Tau Ceti allows it technically: the merge gate accepts the newest scoreboard
  for the current head from any author ("deliberately no author access bar"), so an automation that
  posts an all-green `tauceti-review --post` on its own PR makes it mergeable. But REVIEWING.md says
  the safeguard is social and the tool is for trusted people, and TauCetiRoadmap's CONTRIBUTING
  asks reviews to distinguish "an author's self-review from a review by another contributor". A
  GLCinLean automation that reviews its own Tau Ceti PRs into the merge queue would follow the
  letter but not the spirit. [R; J]
- **Tau Ceti's README and `bors.toml` vs the merge-queue specification.** The README still describes
  merging through bors, and `bors.toml` still sets batches of 128, but the queue "has owned
  production merging since November 4" and keeps bors only as a command surface. Any GLCinLean
  text that describes Tau Ceti merging as bors batches is out of date. [R]

## 5. Input for the open questions (workflow.md, "Questions for after the research")

- **What goes into `AGENTS.md`, and where "update the next prompt" lives.** Tau Ceti suggests a
  short contract in `AGENTS.md`, identical to `.claude/CLAUDE.md`, that points to longer documents
  rather than repeating them. GLCinLean's `AGENTS.md` could hold:
  - one line: "Before any Tau Ceti work, read Tau Ceti's `AGENTS.md`, the relevant roadmap
    `README.md`, and `COORDINATION.md`";
  - the two Tau Ceti rules that bind GLCinLean's own behaviour: never write to TauCetiRoadmap,
    and no stacked PRs;
  - how to bump the pin and fetch both caches.
  The rest belongs in the step-3 and step-5 prompts. [J]
- **Is `PLAN.md` needed?** Tau Ceti uses human-owned roadmaps as its plan and machine-written
  `STATUS.md`/`PROGRESS.md` for status. The ideas.md /goal prompt asks for a `STATUS` file listing
  the PRs opened and landed, with an estimate of when the work will be done. Something like that is
  needed somewhere, because Tau Ceti PRs live for days and a session must find them again. That
  argues for one status file (PRs in flight, last bump), whether or not `PLAN.md` stays. [J]
- **Are Abstract/Foundations and the placeholder design reasonable?** This source bears on it
  only indirectly. Tau Ceti forbids `sorry`, `Prop`-typed placeholders and meta code, so none of
  that design can move to Tau Ceti. The TauCetiRoadmap README warns against `Prop`-valued stand-ins
  ("a `Prop` field is satisfiable by `True`"), in the same spirit as GLCinLean's `opaque` rule. [R; J]
- **What happens to each existing file.** For `lakefile.toml`: think about `rev = "main"` for
  TauCeti, so that automated bumps touch only the pins (§3.8), possibly driven by TauCetiTools'
  upstream updater. ReviewKit and tracker each add their own Lean code that every Lean bump must
  keep building, which is a cost of keeping them as direct dependencies. ReviewKit and its `@[placeholder]`
  attribute are compatible with Tau Ceti only as long as they stay in GLCinLean. TauCetiTools
  offers Tau Ceti's CI, review and merge setup "for Lean projects using the Tau Ceti workflow"
  (`tauceti-tools init --repo YOUR_ORG/YOUR_PROJECT`), which matters for the separate
  review-system repository. [S TauCetiTools README; J]
- **Who reviews the mathematics, and to what standard.** For the parts that go to Tau Ceti, Tau
  Ceti's adversarial rubrics review them, and Tau Ceti's own approach to trust is "building the
  theory downstream". The README admits that "AI formalized definitions are, a priori,
  untrustworthy". This does not replace an expert check of the GLC statement. [R; J]
- **Where research notes and session summaries live.** Not addressed by this source.

## 6. Questions for the owner

1. **The Tau Ceti pin:** keep pinning a tag (safe, audited, weeks behind) or pin `main` with the
   manifest holding the commit (current, automated bumps touch only `lake-manifest.json` and
   `lean-toolchain`)? Should automated bumps be allowed to change `lakefile.toml` at all? And
   should GLCinLean adopt TauCetiTools' upstream updater (a `tauceti.toml` and a scheduled
   workflow, which needs a GitHub App token) or run its own bump session?
2. **Roadmap work:** for a geometric-representation-theory roadmap or intentions, will you read
   and post them yourself, ask a `humans`-team member to file a target on TauCetiRoadmapJobs, or
   leave roadmaps aside and contribute only to existing ones?
3. **Billing:** Tau Ceti's own guidance puts always-on automated review on API keys, not
   subscriptions. Keep "subscriptions only", which limits automation to sessions you start or to a
   paced loop, or allow API billing for a standing worker?
4. **Reviewing others' PRs:** should GLCinLean's automation review other people's Tau Ceti PRs, as
   the ideas.md prompt suggests, and should it ever post reviews on its own PRs?
5. **Visibility:** register GLCinLean (the frontier project) at leanprover-community/project-intentions,
   or stay unannounced?
6. **Tending PRs:** how often may an automated job run to keep open Tau Ceti PRs alive (the 7-day
   stale rule needs at least weekly attention), and on which machine?

## Not reached

- The rubric texts themselves (covered in `tauceti-review.md`), the Lean Zulip "Tau Ceti" channel,
  TauCetiData, TauCetiCI, TauCetiProgress and TauCetiWebsite were not read.
- `scripts/stack-policy.md`, `docs/ci-performance-gate.md` and `docs/cache-infrastructure.md` were
  only grepped. TauCetiFleet was read only up to its install section.
- tauceti-roadmap-claims has no `main` branch (it holds only refs), so it has no README.
- TauCeti has no CONTRIBUTING file. Its `.claude/` folder holds only `CLAUDE.md`, identical to
  `AGENTS.md`. [R]
- How auto-merge picks the scoreboard when several accounts post one: traced in the re-check. It
  takes the newest completed scoreboard bound to the current head and merge base, from any author
  (`latest_current_scoreboard` and `decide_from_comments` in `runner/admission_policy.py`). Only the
  housekeeping budget-close trusts repository-associated accounts alone. [R]
- The AI merge queue's operations runbook and live status page (`queue.taucetiproject.org/status`)
  were not read; nor was the Forgejo tracker (TauCetiWorker #602).
