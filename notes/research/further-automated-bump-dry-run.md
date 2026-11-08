# Dry run: one automated Tau Ceti bump in GLCinLean

- **Source:** an experiment in a scratch Git worktree of this repository (GLCinLean `0feeb6f`,
  branch `scratch/bump-dry-run`, removed afterwards; never on `main`, nothing pushed), plus the
  code of TauCetiTools' upstream updater at
  <https://github.com/TauCetiProject/TauCetiTools/tree/2c1ad61f472442b503f442e034921d3576660365>
  (`tauceti_tools/upstreams.py`, `cli.py`, `project.py`,
  `assets/project/.github/workflows/update-upstreams.yml`,
  `assets/scripts/ResolveDependencies.lean`, `assets/scripts/lake-cache-get.sh`,
  `docs/project-setup.md`), and Lake's source in the toolchain `leanprover/lean4:v4.36.0-rc2`
  (`src/lean/lake/Lake/Load/Resolve.lean`, `Lake/Config/PackageConfig.lean`).
- **Bump tried:** Tau Ceti `v4.36.0-rc2` (`e0610cce`, 2026-11-02) → Tau Ceti `main` commit
  `d2083f0f1dd2136d02467ba36efbbe1af612e89c` (landed 2026-11-08 09:37 UTC).
- **Checked 2026-11-08**, 22:07–22:30 UTC.
- **Licence:** TauCetiTools is Apache-2.0; nothing was copied into the repository.
- Closes gaps left by `tauceti-contributing.md` §2.6 ("was not checked"; the six-step order was
  [J]), `anthropic-guidance.md` §4 (whether auto mode allows `lake update`, [E]) and
  `audit-harness.md` (ReviewKit and tracker must build after a bump; "Whether the
  `tauceti-public` cache covers untagged `main` commits was not checked").

## 1. What it is

A test of the workflow decision "Keeping up with Mathlib and Tau Ceti is fully automated,
including their Lean version": an agent (this session, in auto mode) tried one forward bump of
the Tau Ceti pin with plain Lake commands, the way `AGENTS.md` describes the builds, and stopped
at the first sign of Mathlib or Tau Ceti being compiled from source. It also reads the code of
TauCetiTools' ready-made updater to answer whether it could do the job here.

What it could **not** test [R, 2026-11-08]: a Lean version change and a Mathlib move. No Tau
Ceti tag newer than `v4.36.0-rc2` exists, Tau Ceti `main` is still on `v4.36.0-rc2`, and Tau Ceti
`main` still pins the same Mathlib (`1b1ccf4b`) as the current tag. So this was a Tau Ceti-only
bump on an unchanged toolchain.

## 2. What it says that matters for GLCinLean

### 2.1 Choosing the target

- Tau Ceti's tags (from `gh api repos/TauCetiProject/TauCeti/tags`), newest first: `v4.36.0-rc2`
  `e0610cce`, `v4.36.0-rc1` `cebc9b60`, `v4.35.0` `1f9b4414`, … No tag after `v4.36.0-rc2`.
  [R 2026-11-08 22:07 UTC]
- Tau Ceti `main` head was `c56f4747` (2026-11-08 22:04 UTC); its `lean-toolchain` is
  `leanprover/lean4:v4.36.0-rc2`. [R]
- **Not every `main` commit has a published cache.** Lake looks up mappings at
  `https://cache.taucetiproject.org/revisions/TauCetiProject/TauCeti/tc/leanprover--lean4---v4.36.0-rc2/<sha>.jsonl`
  (the URL Lake printed, 2.5). For the 12 newest `main` commits, `curl -I` returned **200 for
  `d2083f0f` only** and 404 for the other 11 (including the head `c56f4747`, whose CI was still
  running). [R 2026-11-08 22:14 UTC] Ten of those commits share the commit time 09:37:56: the merge
  queue lands a batch at once, and only the batch head `d2083f0f` was published. [R the times; E
  the reason]
- The post-merge CI run of `d2083f0f` (run 42473382416) succeeded; its step "Probe for this exact
  cache on the public endpoint" succeeded and its publish job was skipped. [R GitHub API] So the
  exact cache had already been published, presumably by the queue's staging build [E].
- Consequence: `lake cache get` without `--rev` "will backtrack the Git history up to
  `--max-revs`" (default 100) when the exact revision has no mappings [R `lake cache help get`].
  On a commit without its own mappings, the lookup succeeds with an *ancestor's* mappings, and
  every Tau Ceti module changed since that ancestor is then compiled locally. A bump has to pick
  a commit that has its own mappings. [J]

### 2.2 Setup (exact commands)

```sh
git worktree add -b scratch/bump-dry-run .lake/research/bump-worktree HEAD
cd .lake/research/bump-worktree && git submodule update --init      # tools/tracker @ c223b672
cp -cR ../../packages .lake/packages      # copy-on-write copy of main's packages, 60 s, no re-clone
export LAKE_CONFIG=.lake-config/lake-config.toml LAKE_CACHE_DIR=.lake/cache
```

Main's `.lake/packages` was copied, not linked; main's Tau Ceti checkout stayed at `e0610cce`,
and no file under main's `.lake/packages` changed during the experiment. [R `git rev-parse`,
`find -newer`]

### 2.3 Step A: `lake update TauCeti` with the lakefile unchanged does nothing

```text
$ lake update TauCeti            # 31 s
info: TauCeti: fetching revision 'v4.36.0-rc2' from https://github.com/TauCetiProject/TauCeti
info: TauCeti: checking out revision '9c973fa75f1ef8a5093f989344d22f87d198e82e'
info: toolchain not updated; already up-to-date
info: mathlib: running post-update hooks
…
No files to download
```

`9c973fa7` is the annotated tag object; it resolves to the same commit `e0610cce`.
`lake-manifest.json` and `lean-toolchain` were unchanged. [R] **With `rev = "v4.36.0-rc2"` in
`lakefile.toml`, `lake update` can never move Tau Ceti**: a bump means changing `rev` in
`lakefile.toml`, one of the owner's files. [R the run; J the consequence; this confirms the [J] in
`audit-harness.md`]

### 2.4 Step B: the bump itself

To leave `lakefile.toml` unchanged, a scratch copy `lakefile-bump.toml` (untracked, worktree
only) differed in one line, `rev = "d2083f0f1dd2136d02467ba36efbbe1af612e89c"`, and every Lake
command used `lake -f lakefile-bump.toml …`. In a real bump this line is the edit to
`lakefile.toml`.

```text
$ lake -f lakefile-bump.toml update TauCeti      # 34 s
info: TauCeti: checking out revision 'd2083f0f1dd2136d02467ba36efbbe1af612e89c'
info: toolchain not updated; already up-to-date
info: mathlib: running post-update hooks
…
No files to download
```

- `git diff --stat`: only `lake-manifest.json`, 2 lines (Tau Ceti's `rev` and `inputRev`). Mathlib
  and the other inherited packages did not move, because Tau Ceti `d2083f0f` still pins Mathlib
  `1b1ccf4b`. [R]
- Tau Ceti moved **4,986 commits** (`git log --oneline e0610cce..d2083f0f | wc -l`). [R]
- Tau Ceti's own `lakefile.toml` changed in that range (new `testDriver = "localTest"`,
  `lintDriver = "localLint"` and two `lean_exe`s); this did not affect GLCinLean. [R]
- The four Tau Ceti modules GLCinLean imports (`Pinning.Basic`, `AffineGroupScheme.Reductive.Basic`,
  `LineBundle.TensorProduct`, `Modules.Differentials.Basic`) exist and are textually unchanged
  between the two commits; their imports did change. [R `git diff --stat`]

### 2.5 Toolchain and caches

- `lean-toolchain` stayed `leanprover/lean4:v4.36.0-rc2` ("toolchain not updated; already
  up-to-date"). [R]
- How Lake would treat a Lean move [R `Lake/Load/Resolve.lean` lines 370–427]: it takes the
  newest toolchain among the root and its *direct* dependencies (Tau Ceti, ReviewKit, tracker). A
  dependency with an older toolchain is ignored unless it sets `fixedToolchain = true` (default
  `false`; none of the three sets it [R their lakefiles]). If the newest one is newer than the
  root's, Lake writes it to `lean-toolchain` and restarts itself through elan. So a Tau Ceti
  move to Lean v4.37 would raise GLCinLean's toolchain even though ReviewKit and tracker still
  say v4.36.0-rc2; whether they then *compile* on v4.37 is a separate question this run could not
  test. [R the code; J the application]
- Mathlib's cache:

  ```text
  $ lake -f lakefile-bump.toml exe cache get       # 8 s
  Using cache from origin: (some leanprover-community/mathlib4)
  No files to download
  Already decompressed 9111 file(s)
  ```

  (Mathlib unchanged, and `~/.cache/mathlib` is shared between checkouts.) [R]
- Tau Ceti's cache, with the command from `AGENTS.md`:

  ```text
  $ lake -f lakefile-bump.toml cache get --service tauceti-public \
      --repo TauCetiProject/TauCeti --package TauCeti --mappings-only      # 7 s
  info: TauCeti: downloading build outputs for revision d2083f0f1dd2136d02467ba36efbbe1af612e89c
    local path: .lake/cache/revisions/TauCeti/d2083f0f1dd2136d02467ba36efbbe1af612e89c.jsonl
    remote URL: https://cache.taucetiproject.org/revisions/TauCetiProject/TauCeti/tc/leanprover--lean4---v4.36.0-rc2/d2083f0f1dd2136d02467ba36efbbe1af612e89c.jsonl
  ```

  The exact revision had mappings, so **the cache does cover some untagged `main` commits**. [R]

### 2.6 Building GLCinLean, ReviewKit and tracker

Command (in a watcher script that killed Lake on the first `Built Mathlib.X` or
`Built TauCeti.X` job line that is not a `:c.o` step):

```sh
lake -f lakefile-bump.toml -v build GLCinLean ReviewKit review Tracker tracker
```

Three runs [R the logs, kept locally during the session; not committed]:

1. **Run 1 (22:13 UTC): false alarm.** The first watcher also matched `lean …/packages/mathlib/….lean`
   command lines. Those were not compilations: Lake *replays* the stored log of a cached module
   ("ℹ Replayed Mathlib.Data.DFinsupp.Ext"), including the command line recorded where the olean
   was first made (here with main's paths). The log had 0 `Built` lines and no new `.olean` or `.c`
   files. **A replayed `trace:` line is not a sign of rebuilding; only a `Built Mathlib.…` /
   `Built TauCeti.…` job line is.** [R]
2. **Run 2 (22:14 UTC): stopped; Tau Ceti modules compiled from source.** After 29 Tau Ceti
   artifacts were fetched, Lake printed `ℹ [7249/7461] Built TauCeti.CategoryTheory.ObjectProperty
   (4.9s)` and 11 more `Built TauCeti.…` lines (2.5–10 s each) before the watcher stopped it.
   The cause, from the log:

   ```text
   trace: input '25a51dc' found in package artifact cache, but some output(s) have issues:
   - downloaded artifact abd399bec377f947
     remote URL: https://cache.taucetiproject.org/artifacts/TauCetiProject/TauCeti/abd399bec377f947.art
   - stderr:
   curl: (35) LibreSSL SSL_connect: SSL_ERROR_SYSCALL in connection to cache.taucetiproject.org:443
   - external command 'curl' exited with code 35
   ```

   **One** transient download failure (the only `curl` error in the log) made Lake compile that
   module from source instead of failing, and the 11 other modules compiled were very likely ones
   that depend on it [E]. With `--mappings-only` the artifacts are downloaded lazily during the
   build, so there is no retry. TauCetiTools' own `lake-cache-get.sh` fetches the artifacts
   *before* the build, retries up to 3 times, and discards a partial cache ("A cache the build
   cannot fully resolve is worse than none"). [R the script]
3. **Run 3 (22:18 UTC): see 2.7.** Before it, all artifacts were fetched eagerly, without
   `--mappings-only`:

   ```text
   $ lake -f lakefile-bump.toml cache get --service tauceti-public \
       --repo TauCetiProject/TauCeti --package TauCeti          # attempt 1, exit 0, no curl errors
   $ du -sh .lake/cache   →   950M
   ```

   and the worktree's Tau Ceti build directory (with the 12 locally compiled modules) was deleted.

### 2.7 Result of run 3

**The bump builds.** [R the build log, 2026-11-08]

```text
Sun Nov  8 22:18:42 UTC 2026
…
✔ [8594/8594] Ran GLCinLean/GLCinLean:default
Build completed successfully (8594 jobs).
lake exit=0
Sun Nov  8 22:23:19 UTC 2026
```

- **0** `Built Mathlib.…` or `Built TauCeti.…` lines: Mathlib and Tau Ceti came entirely from the
  caches. [R]
- What was compiled locally, all of it this repository's own code or its tools [R]:
  `GLCinLean.Foundations` (113 s), `GLCinLean.Abstract` (68 s), `GLCinLean` (83 s), the
  `ReviewKit` library (19 s), and the tracker library and `tracker:exe` (about 1 minute of
  modules of 16–19 s each, partly in parallel). The `review` exe was already up to date
  ("Replayed review:exe"): its inputs do not depend on Tau Ceti. Wall time 4 min 37 s. [R]
- Diagnostics: 27 warnings, no errors. Four are `declaration uses 'sorry'` in `Abstract.lean`, as
  expected for a statement. Six are "imports `Mathlib.…` from package `mathlib`, which is
  designed for use with the module system; consider adding `module`", and two are about module
  doc-strings; the rest are continuation lines of those messages. [R] Whether the same warnings
  appear at the current pin was not compared [not reached]; nothing in them names Tau Ceti.

**ReviewKit's checks also pass after the bump** (an extra check, because `audit-harness.md`
expected a Tau Ceti change could trip the statement pin):

```text
$ lake -f lakefile-bump.toml exe review --config glc/project.toml all      # 1 min 35 s, exit 0
closure ok  · axioms ok · placeholders ok · imports ok · pin ok · evidence ok   (0 errors, 0 warnings each)
pin: GLCinLean.Abstract.main     statement_ok true, digest_ok true
     GLCinLean.Abstract.Setting  statement_ok true, digest_ok true
```

So 4,986 Tau Ceti commits changed neither the statement fingerprint nor the digest of
`main` and `Setting` in `reviews/statement-pin.toml`. [R the output; J that this is luck of this
range: none of the Tau Ceti names the statement uses was renamed]

### 2.8 TauCetiTools' updater: the two unchecked questions

The updater is `tauceti-tools upstreams inspect|update|guard` (`cli.py` lines 77–131) over the
`[[upstreams]]` tables of a `tauceti.toml`. [R]

**Can it be used without TauCetiTools' CI?** Partly. [R the code, J the summary]
- The CLI runs anywhere Python and `gh` run. It needs a `tauceti.toml` that passes `project.py`'s
  validation: `schema_version = 1`, `[repositories]` with both `content` and `roadmap`, and the
  `[[upstreams]]` tables (`repo`, `package`, `branch`, `update`). [R `project.py` lines 260–405]
  GLCinLean has no roadmap repository, so a placeholder would be needed [J].
- `inspect` only calls the GitHub API (`gh api`) and prints the proposed pins. [R lines 101–121]
- `update --apply` resolves with Lake inside a **bubblewrap** sandbox: "Lake resolution requires
  bubblewrap on Linux" (line 127), and the driver is loaded as
  `--load-dynlib=/toolchain/lib/lean/libLake_shared.so` (line 145), a Linux library name. **On
  macOS it cannot apply an update.** [R; E that no macOS path exists elsewhere — none found]
- It "does not fetch caches" and does not build; it only rewrites `lake-manifest.json` and
  `lean-toolchain` (lines 188–197). [R]
- The scheduled workflow (`update-upstreams.yml`, daily `43 6 * * *`, `ubuntu-24.04`) also needs
  a GitHub App (`secrets.APP_ID`, `secrets.APP_PRIVATE_KEY`) to open the PR, and the `guard` is
  meant to run in the project's CI on that PR. [R] GLCinLean dropped its CI in `0feeb6f` [R git
  log].

**How does it treat the path dependency `tools/tracker`?** It refuses the whole update. [R]
- `repository()` (lines 73–78) raises `"<name> needs a public GitHub Git dependency pinned to a
  full SHA for automatic updates; review the human-owned Lake requirements"` for any package
  whose `type` is not `git`.
- `inspect` calls it, through `toolchain_for` (lines 81–86), for **every** direct dependency as
  soon as any pin would move (line 121). `tracker` is direct (`"inherited": false`,
  `"type": "path"` in GLCinLean's manifest), so every real update fails with "tracker needs a
  public GitHub Git dependency …". The `guard` does the same for every direct package
  (line 229). [R; J that this is the outcome, not run]

**Two further blockers in the same code** [R]:
- **Tag pins are not supported.** `inspect` requires the manifest's `inputRev` to equal the
  configured `branch` (line 112), then moves to `commits/<branch>`. GLCinLean's Tau Ceti
  `inputRev` is `v4.36.0-rc2`, so either the config is rejected ("URL or nominated branch
  differs") or, with `branch = "v4.36.0-rc2"`, nothing moves. ReviewKit, pinned by SHA, likewise
  never moves.
- **Lakefile edits are human-owned.** The guard rejects any change to `lakefile.toml`: "`{name}`
  changes are human-owned" (line 213); the docs: "Lakefile edits still require a human … there is
  no approval-based bypass". So switching from a tag to `main` is one human edit, after which the
  updater would move the manifest along `main`.

### 2.9 Auto mode and `lake update`

In this session auto mode was active, and `lake update TauCeti`, `lake -f … update TauCeti`,
both `cache get` commands and the builds ran **without a block or a prompt**, in a scratch
worktree on a scratch branch. [R this session, 2026-11-08] Not tested: the same commands on
`main`, or committing and pushing the changed manifest. [not reached]

## 3. What it means for GLCinLean

1. **A Tau Ceti-only bump works with four plain commands** (decision "Keeping up … fully
   automated"; ideas.md "Stay up to date" and "work in a very simple way … prompts alone"):
   change the pin, `lake update TauCeti`, fetch both caches, build. The update and the cache
   fetches took about a minute (34 s + 8 s + 7 s, plus the eager artifact fetch, not timed), the
   build 4 min 37 s, and ReviewKit's checks 1 min 35 s. Nothing needed repairing, and the statement
   pin still matched (2.7). No harness is needed. [R the run; J]
2. **But the pin has to be in a form Lake can move.** With a tag pin, every bump is an edit to
   `lakefile.toml` (2.3). Tags only move with Lean releases (2–25 days apart, see
   `tauceti-contributing.md` §2.5), while `main` moved 4,986 commits in six days. For "Stay up to
   date" and for adopting Tau Ceti's new code (step 5, Refactor), a commit pin chosen by the agent
   at each bump is the practical form. [R the numbers; J]
3. **Step (1) of the bump order needs a cache check, not just "the newest commit".** Only 1 of
   the 12 newest `main` commits had its own mappings (2.1). The agent should probe
   `…/revisions/TauCetiProject/TauCeti/tc/<toolchain>/<sha>.jsonl` (or run
   `lake cache get --rev=<sha> --mappings-only`) and pick the newest commit that answers 200. [J]
4. **The cache command in `AGENTS.md` is fragile.** `--mappings-only` turned one transient
   network error into 12 Tau Ceti modules compiled locally, silently except in a verbose log
   (2.6). Fetching artifacts eagerly with retries before `lake build`, as TauCetiTools' script
   does, avoided it. For the step-1 rewrite of `AGENTS.md` (workflow question 1), the build note
   should say: fetch without `--mappings-only`, retry on failure, and treat a
   `Built Mathlib.…`/`Built TauCeti.…` line (not `:c.o`, not a replayed `trace:`) as the stop
   sign. [R; J]
5. **ReviewKit and tracker built at the same toolchain** (2.7), so a Tau Ceti-only bump costs
   them only a recompile (about a minute). Whether they survive a *Lean* bump is still open; Lake will move the
   toolchain past them without asking (2.5), so the first failure would show up in their build.
   [R; J]
6. **TauCetiTools' updater does not fit this repository as it is** (2.8): Linux-only apply, a
   GitHub App and CI, a `tauceti.toml` with a roadmap repository, no tag pins, and it fails on
   the `tracker` path dependency. Adopting it would mean (a) moving tracker out of the build or to a
   Git dependency, (b) switching Tau Ceti to `rev = "main"`, (c) restoring CI with an App. That
   contradicts ideas.md's "without any complex system or harness". A prompt (step 5) that runs
   the four commands is simpler. [J]

## 4. Conflicts

- **With the current files** (already listed in workflow.md's "Known conflicts", partly):
  `lakefile.toml` "Bumps are the owner's decision" and `AGENTS.md` "`lake update` moves the pins,
  so it is best left to the owner" vs. "Keeping up … fully automated". This run adds that even
  `lake update` is not enough: the automation must edit `lakefile.toml` itself (2.3), and
  `lakefile.toml` is on `AGENTS.md`'s owner's-files list. [R]
- **With TauCetiTools' model:** its guard treats lakefile edits as "human-owned" with "no
  approval-based bypass" (2.8). Full automation with a tag pin is exactly what it forbids; with a
  `main` pin it allows only manifest and toolchain changes. [R]
- **Corrections to other notes:**
  - `tauceti-contributing.md` §2.6: "With `rev = "main"`, TauCetiTools' updater could do steps
    1–3 and open the PR" — not in GLCinLean as it stands: it fails on `tracker`, and cannot apply
    on macOS (2.8). Its six-step order holds, with two changes: step 1 must check that the target
    has its own published mappings; step 4 must fetch artifacts eagerly with retries. [R; J]
  - `audit-harness.md`: "Whether the `tauceti-public` cache covers untagged `main` commits was not
    checked" — it does, but only for some commits (batch heads), 1 of 12 on 2026-11-08 (2.1). [R]
  - `anthropic-guidance.md` §4: whether auto mode allows `lake update` "is not stated" [E] — in
    practice it ran without a block in a scratch worktree (2.9). [R, this session only]
  - `audit-harness.md` ("Statement pin vs. automation", [E: not tested]): for this bump the pin
    still passed, both fingerprint and digest (2.7). The risk it describes (a Tau Ceti rename of
    a name the statement uses) is real but did not happen in these 4,986 commits. [R; J]
- **With `AGENTS.md`'s build note:** its Tau Ceti cache command uses `--mappings-only`; this run
  shows that form rebuilds silently on a network error, unlike TauCetiTools' own script. [R]

## 5. Input for the open questions

- **"What exactly goes into `AGENTS.md` …"**: keep the two cache commands and the stop sign, but
  (a) fetch Tau Ceti's artifacts eagerly with a retry, (b) say that replayed `trace:` lines are
  not rebuilds. The bump recipe itself (choose a cached commit, edit the pin, update, fetch,
  build, repair, commit) fits the step-5 Refactor prompt better than `AGENTS.md`, since only that
  session needs it. [J, from 2.1–2.6]
- **"What happens to each existing file"**:
  - `lakefile.toml`: the Tau Ceti `rev` should become something agents can change at each bump
    (a commit SHA, or `main` with the manifest holding the commit); the "Bumps are the owner's
    decision" comment goes. [J, from 2.3]
  - `lake-manifest.json`, `lean-toolchain`: moved by every bump; if bumps are automated they can
    no longer be "owner's files" in the ask-first sense; the owner sees them in the commit. [J]
  - The tracker path dependency and the ReviewKit requirement: each is one more package that
    must build on every Lean release; they cost 19 s here [R], but they are the reason
    TauCetiTools' updater cannot be used (tracker) [R], and their behaviour on a new Lean is
    untested [not reached]. Moving them to the separate review-system repository (ideas.md, "its
    own repository") would remove both issues from GLCinLean's bumps. [J]
- **"Whether `PLAN.md` is needed"**: `PLAN.md`'s "Tau Ceti is pinned to a tag" would be wrong
  after the change in point 2 of section 3; one more statement to drop or move. [R `PLAN.md`
  per `audit-harness.md`; J]

## 6. Questions for the owner

1. **Pin form.** Keep Tau Ceti pinned to a release tag (bumps only on Lean releases, every bump an
   agent edit of `lakefile.toml`), or pin a `main` commit chosen at each bump (newest code, more
   breakage per step)? [J: the second fits "Stay up to date" and Refactor better]
2. **Owner's files.** May agents change `lakefile.toml` (the Tau Ceti `rev` line only),
   `lake-manifest.json` and `lean-toolchain` in a bump without asking first, with the change shown
   in the commit?
3. **Cadence.** How often should a bump run: at every Tau Ceti toolchain tag, weekly, or at the
   start of every Refactor session?
4. **TauCetiTools' updater.** Leave it aside (prompt-driven bumps with plain Lake commands), or
   adopt it, which needs CI with a GitHub App, a Linux runner, and tracker out of GLCinLean's
   build?
5. **ReviewKit and tracker in GLCinLean's build.** Keep them as requirements here (one more thing
   per Lean bump), or move them out with the review system?
