# Review of the workflow, 2026-11-10

Commit reviewed: `e84596c`. This report changes no rule, prompt, plan or code. Each finding waits for the owner's decision. The decisions are in a table at the end, numbered W1 to W12.

## Key points

1. **`prompts/build.md` would not work today.** One definition can be written in this repository now. Every placeholder has at least three unfinished Tau Ceti roadmap nodes below it. A build session would find nothing that meets its "Done when". This holds for both outcomes of decisions 1 to 3 of `notes/review-goal.md`.
2. **The first work is run by a command, not by a prompt of this repository.** The Tau Ceti Worker starts its own agent with Tau Ceti's prompts. `prompts/build.md` gives it cautions but no goal, and omits the one option that steers it to a plan node.
3. **The rules are sound, and a few will not scale.** The largest one: owner approval for every change to "a definition the statement reaches" will stop routine library work once the library is connected to the statement.
4. **Keep `prompts/review.md` for meaning only.** The standards check is a separate step, done first, and it needs no prompt file: `AGENTS.md` is its checklist.
5. **A standing prompt for a review of the whole project is worth having.** The goal review found that half of the plan could move out of the statement. No build session would find that.
6. **Do not rebuild.** Simplify in three places: show the owner of a node by its folder, keep each caution in one file, and let the tracker do the axiom audit.

## How the review was done

- All rules and prompts were read line by line: `AGENTS.md`, `prompts/`, `plans/README.md`, `STATUS.md`, `README.md`, `tools/tracker/README.md`, `docs/blueprint-providers.md`.
- The commands that `prompts/build.md` names were run at `e84596c`: `lake build` (passes, one `sorry` warning), `lake lint` (passes), `lake exe tracker status`, `ready`, `lint` (88 warnings, no errors) and `graph`. The numbers below come from the graph.
- The owner of a node ("here" or "roadmap") was read from the `Provider:` text of its `desc`.
- The Worker's README (TauCetiWorker `main`, read on 2026-11-10) and Tau Ceti's `README.md`, `AGENTS.md` and `COORDINATION.md` (at this project's pin) were read for what a Worker round does.
- One small test: a subagent can start its own subagent, and a subagent loads `AGENTS.md`. So the two-level reading of `prompts/review.md` works when a build session starts the review.
- **Limits.** No build session and no Worker round was run as a trial. Of Tau Ceti Review's rubrics, only the index was read. The Worker facts in `prompts/build.md:20–24` were not all checked again (the 7-day closing rule was not found in the files read).

## Question 1. Would `prompts/build.md` work from the current state?

No. It needs the changes below. The reasons come first.

### 1.1 There is almost nothing to build here

- The plan has 314 open nodes that say "implement here". Only 3 of them have no open roadmap-owned node below them: `Curves.thetaCharacteristic`, `Curves.thetaCharacteristic_exists` and `Constructible.complexPoints`. The second one needs three layers of the JacobianChallenge roadmap by its own `desc`. The third one is held back by `notes/upstream-2026-11-10.md` §7, suggestion 2. So one definition can be written today.
- Every placeholder has open roadmap-owned nodes below it: at least 3 (`MonoidalDGCat`, `DGModule`), 6 for `DGCat` and for `RootDatumDuality`, 58 for `DmodHalf`.
- Tau Ceti forbids stacked pull requests (its `AGENTS.md:75–78`): a prerequisite must merge before the pull request that needs it is opened. The longest chain of roadmap-owned nodes is 3 below `DGModule` and `MonoidalDGCat`, 4 below `RootDatumDuality`, 5 below `DGCat` and 13 below `DmodHalf`. So the first placeholder can be replaced only after at least 3 merge cycles upstream, one after the other, and a node is often more than one pull request.

`prompts/build.md:3` sets the goal "Replace placeholders", and line 6 asks that "the placeholders they replace are gone". No session can meet this for a long time. A session that tries will either stop, or write code that `AGENTS.md:15` sends to Tau Ceti.

### 1.2 `lake exe tracker ready` hides the real first step

`ready` lists 37 modules. 34 are Mathlib or Tau Ceti leaves that exist. One is the main theorem. One is `Curves.Duality`, which a roadmap owns. One is `Curves.Theta`. The goal review reported the first two effects (its question 4, points 1 and 2). A third effect is new:

- **Leaves that are not imported block the modules above them.** A module is ready only when its outside dependencies are proved, and a leaf that this project does not import shows as `open`. 8 modules are blocked only by such leaves. One of them is `GLCinLean.CategoryTheory.Infinity.Mapping`, the root of the whole ∞-category layer. So the tracker will never list the real first step, however the plan advances.

This makes decision 5 of the goal review (delete `plans/Mathlib` and `plans/TauCeti`) a precondition of the build step, not a tidy-up.

### 1.3 The prompt does not fit a Worker round

The Worker's README says what a round is. Four facts matter, and `prompts/build.md` has none of them:

- **A round does one unit of work, and roadmap work is the last choice.** The order is: rebase, Mathlib bump, lint repair, progress report, fix CI, fix review findings, review another pull request, Mathlib overlap work, and only then a new roadmap pull request. One round is often a review of someone else's pull request. Progress on the plan needs many rounds.
- **`--extra-roadmap-prompt <text>` is the only way to steer a round to a target** inside the area that `--roadmap-only <area>` pins. `prompts/build.md:21` names only `--roadmap-only`.
- **The Worker starts its own agent** in a Tau Ceti checkout, with Tau Ceti's prompts and rubrics. A session of this repository does not write that code. So lines 6, 8, 9 and 10 of the "Done when" (definitions, done check, `prompts/review.md`, owner approval) do not apply to a round. Only line 7 does.
- **Tau Ceti asks that an intention is registered** on its intentions board before substantial roadmap work (Tau Ceti `README.md`, "Only one roadmap area").

It is also unclear who starts the Worker. Line 20 says it "runs outside this repository, under the owner's `gh` account", and line 24 says that without the sandbox it has the owner's full credentials. Nothing says whether a session may start it.

**Proposal (W1).** The owner runs the Worker in a terminal, as its README intends (a persistent worker with its own pacing). A session here does not start it. A session folds in the results: it checks the listed pull requests, moves the pin, and updates the plan. `STATUS.md` holds the command lines. Reason: a session that wraps the Worker adds only a second agent around the Worker's agent, and it acts with the owner's credentials outside this repository.

### 1.4 Other lines that fail or are unclear

| Line | Problem | Change |
|---|---|---|
| 3, 6 | No unit of work. "The objects taken on" can be one lemma or a whole layer. | The unit is one ready module of the plan, as in `tools/tracker/README.md` ("Workflow"). |
| 9 | Asks a review of every new definition. `AGENTS.md:47` asks it only for the statement and what it reaches. | See 2.1. |
| 10 | "the session waits". A session ends; it cannot wait for days. `prompts/review.md:10` also asks that the report is pushed, and the change may not be pushed. | Commit the change and its report on a branch `proposal/<topic>`. `STATUS.md` on `main` names the branch. |
| 11 | "the prompt for the next step". After `prompts/next-steps.md` is deleted, that prompt is `build.md` itself. | `STATUS.md` says what the next session takes on. `build.md` changes only when one of its lines proved wrong. |
| 11 | "`lake exe tracker lint` passes". It exits 0 with 88 warnings. | "has no errors", as `prompts/next-steps.md:15` says. |
| 15 | "The three policy answers in `STATUS.md` are proposals until the owner decides." A session cannot tell whether to act on them. | The owner decides them before the first build session (W11). Then this sentence goes. |
| 17 | One held node is named in prose. Eleven more are held in `notes/upstream-2026-11-10.md` §7. | One list "Held" in `STATUS.md`, each entry with its reason and what releases it. `build.md` points to it. |
| 18 | The list of examples is also in `plans/README.md:76–80`, with other items, and as 6 nodes in `plans/GLCinLean/GeometricLanglands/Examples`. | Keep the plan nodes. Delete both lists. |
| 20–24 | A dated copy of two upstream READMEs. | Two lines: the command, and "read the Worker's README first". |

### 1.5 Proposed text of `prompts/build.md`

This text assumes decisions 4 and 5 of the goal review, and W1, W3, W4 and W6 of this report.

```markdown
# Build

**Goal.** Move the plan in `plans/` forward by one module, from the bottom up, until each placeholder of the GLC statement can be replaced by a real definition.

**Done when**
- upstream is folded in first: each Tau Ceti pull request listed in `STATUS.md` is checked. For a merged one, the Tau Ceti pin is moved as `AGENTS.md` says, its nodes are deleted from `plans/Roadmap/`, and the nodes that used them name the upstream declaration in their `desc`;
- one ready module under `GLCinLean` (or a few small ones) is written: `lake exe tracker ready` names it, and `lake exe tracker show <module>` is its brief. If no module under `GLCinLean` is ready, the session writes in `STATUS.md` which roadmap targets block the plan, and ends;
- each new definition has examples or test lemmas that show it behaves as expected. A placeholder is replaced only when every node below it is proved, and with the example nodes of `plans/` that rule out a trivial reading;
- the done check in `AGENTS.md` passes, and `lake exe tracker lint` has no errors;
- a fresh agent has checked the diff against each rule of "Sources of code" and "Lean code" in `AGENTS.md`, and its findings are fixed;
- after that, a fresh agent has reviewed every new or changed definition with `prompts/review.md`;
- a change to `GLCinLean/Statement/` is committed with its review report on a branch `proposal/<topic>`, and `STATUS.md` on `main` names the branch under "Waiting for the owner". `main` gets the change only after the owner approves it;
- `STATUS.md` is updated and says what the next session takes on (a build, or an audit when a trigger of `prompts/audit.md` holds), and the work is committed and pushed.

**Context**
- The statement is in `GLCinLean/Statement/`. The main theorem says that a characterized functor exists and that every such functor is an equivalence; preserve that shape.
- Nodes under `plans/Roadmap/<area>/` belong to Tau Ceti. The owner runs Tau Ceti's Worker for them, with the command lines in `STATUS.md`: `tauceti work --agent claude --roadmap-only <area> --extra-roadmap-prompt "<targets>"`, where `lake exe tracker show Roadmap.<area>` gives the targets. A session here does not start the Worker.
- A node listed under "Held" in `STATUS.md` is not started.
- Ordinary derived categories are not replacements for enhanced categories. Field, universes and t-structures stay explicit.
- When a paper is wrong, mark the planned declaration `wrong` and amend the plan.
- `docs/papers.md` says where the papers' TeX is and how to fetch a missing paper.
```

## Question 2. Which rules are too forced, unclear, or in conflict?

Ranked by effect on the goal.

### 2.1 Review and approval of "a definition it reaches" (conflict, and too forced later)

- `AGENTS.md:47`: "A change to the statement, or to a definition it reaches, is checked by a fresh agent with `prompts/review.md`, then waits for the owner's approval." Line 58 repeats it for the push.
- `prompts/build.md:9`: "a fresh agent has reviewed every new or changed definition".

**Conflict.** While the placeholders are `opaque`, the statement reaches only the 33 declarations of `GLCinLean/Statement/`. Library code is not reached. So `AGENTS.md` asks no review of library code, and `prompts/build.md` asks it for all.

**What goes wrong later.** On the day a placeholder is replaced, every library definition below it becomes "reached" at once. Under `AGENTS.md:47` they all need a first review then, in one large pass. From then on, every change to any of them (also a change of generality) waits for the owner before it is pushed. Routine library work stops.

**Proposal (W4).** Replace `AGENTS.md:47` by:

> - Every definition planned in `plans/` is checked by a fresh agent with `prompts/review.md` when it is written and when its type or body changes. A *mismatch* or *unsure* verdict goes to the owner. A change to `GLCinLean/Statement/` also waits for the owner's approval.

and the second sentence of `AGENTS.md:58` by:

> A change to `GLCinLean/Statement/` reaches `main` only after the owner approves it; until then it is on a branch `proposal/<topic>`.

The owner then approves each replacement of a placeholder, with the reviews of what lies below it already done. A branch lets the owner read the change on GitHub, and `main` never carries an unapproved statement.

### 2.2 `AGENTS.md:15` and `:24` against the tracker (conflict)

- Line 24: "`lake exe tracker ready` lists what can be worked on now". It does not (1.2).
- Line 15 gives a node its owner, but the plan records the owner only as free text in `desc`. 60 roadmap-owned nodes have ids and folders under `GLCinLean`, mixed with nodes written here: 27 module plans hold only roadmap-owned nodes, 12 hold both kinds.
- `plans/README.md:29–32` says that a roadmap-owned node moves to the plan of its upstream module when it is implemented. Decision 5 of the goal review deletes the plans of upstream modules. The two do not fit.

**Proposal (W3).** After decision 5, move the roadmap-owned nodes to `plans/Roadmap/<area>/<file>.toml`, with their ids unchanged. The folder then says who owns a node:

- `lake exe tracker ready` lists `Roadmap.<area>.…` modules for the Worker and `GLCinLean.…` modules for a session here. The tracker then shows that the first work is in Tau Ceti. This answers Finding 2 of the goal review by structure, without a caution.
- `<area>` is the value of `--roadmap-only`, and `lake exe tracker show Roadmap.<area>` is the text for `--extra-roadmap-prompt`.
- When a node lands upstream, it is deleted, and the nodes that used it name the upstream declaration. Replace `plans/README.md:29–32` by this rule.
- "Provider:" then leaves every `desc` under `GLCinLean`.
- With decision 5, `AGENTS.md:24` becomes true and needs no change.

Cost: 27 files move and 12 files are split. No Lean code changes.

### 2.3 `prompts/review.md` (conflicts inside the prompt)

| Line | Problem | Change |
|---|---|---|
| 3 | The goal includes "the code meets the standards in `AGENTS.md`". No item of "Done when" asks for it. | Remove the half sentence (see question 3). |
| 3, 10 | "It only reads the Lean files" against "the report is committed and pushed, and `STATUS.md` names the commit". A review subagent of a build session would push, and the change it reviewed may not be pushed. | "A review session commits and pushes its report. A review subagent only writes the report; the session that started it commits it with the change." |
| 7 | The blind reader gets "the Lean text of the definition and of the definitions it uses". Today that is under 300 lines. Later it is the whole library, with Mathlib and Tau Ceti below. | "…the Lean text of the definitions in scope, without docstrings. For a definition below them that is already reviewed, or is from Mathlib or Tau Ceti, it gets the signature and the docstring." |
| 8 | The "hack answer" test is asked of each placeholder. For an `opaque` the answer is always yes, as `STATUS.md:29–33` already says. The test says nothing. | "for each definition in scope that is not an `opaque`: is there a degenerate case (zero category, empty type, trivial group) that satisfies it and makes the main theorem empty or easy? Do the examples given with it rule that case out?" |
| 9 | `notes/reviews/YYYY-MM-DD.md`: several reviews ran on 2026-11-10 (see `git log`), so the name is not unique. | `notes/reviews/<short commit>.md`. |

The scope "definitions" is right and should stay. A lemma that is stated wrongly is either unprovable or harmless; a definition that is wrong makes the statement wrong.

### 2.4 `AGENTS.md:19`, subagents (too forced, and unclear)

"Each subagent works in its own git worktree, and its work is squash-merged as one commit." A review subagent and its blind reader write no code; the blind reader may not open a file at all (`prompts/review.md:7`). "with its prompt file" is unclear: only `build.md` and `review.md` exist, and `build.md` is a prompt for a session, not for a subagent that writes one module.

**Proposal (W8).** Replace line 19 by:

> - The main agent gives each subagent its goal, its brief (`lake exe tracker show <module>` for a module, `prompts/review.md` for a review), the sources it needs, the expected scope and the expected time. A subagent that writes code works in its own git worktree, and its work is squash-merged as one commit.

### 2.5 `AGENTS.md:54`, the pins (conflict)

"Versions stay pinned until the owner upgrades Lean, Mathlib and Tau Ceti" against "A session moves the Tau Ceti pin … when it needs merged Tau Ceti contributions". Mathlib and Lean come through Tau Ceti (`lakefile.toml`). So a move of the Tau Ceti pin moves Mathlib, and it moves Lean when Tau Ceti `main` has a newer toolchain. The tracker must build on the same toolchain.

**Proposal (W8).** Add after the second sentence: "Mathlib moves with it. If the new commit needs another Lean toolchain, the session stops and asks the owner, because the tracker must build on the project's toolchain."

### 2.6 `AGENTS.md:53`, the done check (incomplete)

`lakefile.toml` sets up Batteries' linter, and `lake lint` passes today. No rule or prompt asks for it. It checks mechanically a part of `AGENTS.md:30` (for example a docstring on every definition). **Proposal (W6).** Add `lake lint` to the done check.

### 2.7 `AGENTS.md:14`, the search rule (too forced in one part)

"Search both … before a proof longer than a few lines …: Mathlib at the pin, Tau Ceti at the pin and on its `main`." A lemma that is only on Tau Ceti `main` cannot be used in a proof without a pin move. The search of `main` serves definitions and stated theorems, where a second copy would compete with upstream. **Proposal (W8).** "…before defining anything (Mathlib at the pin, Tau Ceti at the pin and on its `main`), and before a proof longer than a few lines (its goal and its key steps, at the pins)."

### 2.8 The same caution in several files (unclear which one rules)

- "A placeholder counts as proved": `AGENTS.md:26`, `prompts/build.md:3`, `plans/README.md:34–40` and `:71–74`.
- "Examples with each replacement": `AGENTS.md:46`, `prompts/build.md:18`, `plans/README.md:76–80`, `STATUS.md:29–33`. The lists of examples differ.
- "Roadmap-owned work goes through Tau Ceti Worker" (73 module plans) and "No placeholders belong in this module" (77 module plans): fixed text in the `desc` of the module.
- Four different commits of Tau Ceti and of the roadmap, 777 times in the `desc` texts.

**Proposal (W9).** One home for each kind of text. `AGENTS.md` holds the rules. `STATUS.md` holds the state, the decisions and the "Held" list. `plans/README.md` says only how to read the plan. A prompt holds only the goal of its session. A `desc` says only what the object is. Delete the repeats. The last two items extend point 3 of question 4 of the goal review.

### 2.9 Smaller points

- `STATUS.md:46–62`: three "open decisions" that `prompts/build.md:15` calls proposals. A session cannot know whether to follow them. The owner should decide them (W11).
- `AGENTS.md:40` and `prompts/build.md:8` ask each rename to update `tools/check-statement-axioms.lean`. See question 4, point 3.
- `README.md:44` names `notes/reviews/`, which does not exist now. No change needed.

## Question 3. One review prompt or several? A periodic review of the whole project?

### 3.1 Keep `prompts/review.md` for meaning only

The standards check should not be in the same report. Four reasons:

1. **Order.** A standards finding ends in a change to the code (a rename, a more general type, a moved file). The meaning review must read the final text. So the standards check comes first, and the meaning review after its fixes.
2. **Reader.** A *mismatch* goes to the owner. A standards finding goes back to the session that wrote the code. One report for both hides the few lines the owner must read.
3. **Scope.** The meaning review covers definitions that have a source in a paper. The standards cover all code: lemmas, proofs, files, imports.
4. **Method.** The meaning review is read-only and rests on a blind reading. The standards check needs searches in Mathlib and Tau Ceti and ends in fixes.

### 3.2 The standards check needs no prompt file

`AGENTS.md` is loaded by every agent, and its sections "Sources of code" and "Lean code" are the checklist. They cover the same angles as Tau Ceti Review's rubrics (correctness, reuse, API design, generality, placement, naming, documentation, proof quality). So one line in `prompts/build.md` is enough; it is in the text of 1.5. The mechanical part goes to `lake lint` (2.6). Code for Tau Ceti is checked upstream by the rubrics themselves (`AGENTS.md:41`).

So the answer is: two checks, one prompt file. If the one line proves too thin in use, it becomes a prompt file then.

### 3.3 A standing prompt for the whole project: yes, one, run on events

**Why.** A build session works on one module. Nobody then looks at the whole. The goal review did, once, and found that an equal form of the statement removes about half of the plan. The plan also has 427 open nodes written before any code, and Tau Ceti changes quickly. So the plan will drift, and only a whole-project review finds it. `prompts/next-steps.md` holds the texts of such reviews (sessions 2, 3a and 3b), and session 5 deletes that file.

**When.** Not on a calendar. Run it when a layer of the plan is finished; before the first replacement of a placeholder is put to the owner; when a roadmap that owns plan nodes is merged, amended or replaced; and after ten build sessions with none of these.

**Proposed text of `prompts/audit.md` (W7).**

```markdown
# Audit

**Goal.** Judge whether the statement, the plan and the workflow still reach the owner's goal faithfully and in the simplest way, after what changed here and upstream since the last audit.

The owner's goal: a faithful Lean statement of [GLC1] Conj. 1.6.7 (de Rham, characteristic 0, over any algebraically closed field), with every object it uses fully defined, built on Mathlib and Tau Ceti; the proof comes later. The owner wants the formalisation as simple as possible: simple tools, and a workflow that runs on prompts.

**Done when**
- `docs/blueprint-providers.md` is brought up to date in place: what merged in Tau Ceti and what changed in the roadmaps since its snapshot, and each open pull request that supplies a plan node, competes with one, or changes who owns it;
- a report in `notes/audit-<date>.md` answers each question below, with reasons and exact references, and ranks its findings by their effect on the goal:
  - is the statement still faithful to the paper, also after the placeholders replaced since the last audit?
  - does the plan still reach a fully defined statement? Which nodes are now wrong, missing, held, or more than the statement needs?
  - is there now a simpler faithful formulation or route, and what would it save?
  - which rule, prompt or tool got in the way since the last audit, and what simpler one would do?
- the report ends with a table of decisions for the owner, and nothing else in the repository changes;
- the work is committed and pushed, and `STATUS.md` names the audit's commit.

**Context**
- Run it when a layer of the plan is finished; before the first replacement of a placeholder is put to the owner; when a roadmap that owns plan nodes is merged, amended or replaced; and after ten build sessions with none of these.
- This session only reads upstream: it opens no pull request, issue or comment, and moves no pin.
- The last audit is the commit that `STATUS.md` names. `lake exe tracker status`, `show` and `graph` read the plan.
```

It replaces the dated notes `notes/upstream-<date>.md` by an update of `docs/blueprint-providers.md`, so the upstream state has one home.

## Question 4. Would rebuilding or simplifying serve the goal better?

**Rebuilding: no.** The Lean code is 294 lines, and the goal review found the statement faithful. The plan is the main asset. Under decisions 1 to 3 it is cut, not rewritten. The tools are small: the tracker (about 2,000 lines, a submodule), one audit file and one awk script.

**Simplifying: yes, in five places.**

1. **The owner of a node is its folder** (W3, in 2.2). It removes the provider text and makes `tracker ready` true.
2. **One home for each caution** (W9, in 2.8).
3. **The tracker can do the axiom audit (W10, optional).** `tools/check-statement-axioms.lean` is a hand-kept list of 33 names. A declaration that is forgotten in it is not checked, and the `sorry` of the main theorem would hide a `sorry` below it. The tracker already computes the same closure for every declaration: `lake exe tracker status` ends with "55 proved, 1 stated, … 0 axioms", and `graph --all` gives 39 proved and 1 stated for the 40 declarations of this project. The done check can be: `lake build` has one warning, the `sorry` of the main theorem; `lake lint` passes; `lake exe tracker status` shows `1 stated` and `0 axioms`. Then the file goes, and so do the clauses in `AGENTS.md:40` and `prompts/build.md:8`. The cost: the check rests on the tracker's code, not on Lean's `#print axioms`.
4. **Three prompts after `prompts/next-steps.md` is gone:** `build.md`, `review.md`, `audit.md`. `STATUS.md` says under "Next" which one runs next.
5. **Do not maintain the far layers of the plan.** The goal review noted that 427 nodes are detailed before any code exists. Rewriting them now is not worth it. The rule is the tracker's own: a session edits only the plan of the module it writes, and reports the rest. An audit plans the next layer again when the layer below it is done.

**One larger option for later (W12).** Of the 314 nodes written here, 151 are general algebraic geometry (derived prestacks, sheaves, D-modules, local systems) and 160 are specific to geometric Langlands. Tau Ceti accepts new mathematics only on a roadmap, and only a person may propose a roadmap. If the owner proposed roadmaps for the general part, Tau Ceti's workers and rubrics would carry it, and this project would keep only the specific part. The cost is less control over the shape of those definitions, and the roadmap must be accepted first. Decide this when work reaches the first such layer (derived prestacks), not now.

## Both outcomes of decisions 1 to 3 of the goal review

Everything above holds for both outcomes, because the ∞-category layer is below every placeholder in both. The differences:

| Item | Decisions 1 to 3 approved (property 2′) | Not approved |
|---|---|---|
| `AGENTS.md:45` | Change "with the two properties of [GLC1] Cor. 1.6.5" to "with the two properties of [GLC1] Cor. 1.6.5, the second one in its equal form with the Hecke action". | No change. |
| `prompts/build.md:16` | "module actions" goes, because the statement has plain functors. The text in 1.5 assumes this. | Keep "module actions" in that line. |
| The moved nodes | They must leave `plans/`, or `tracker ready` will offer them as work on the statement. A folder that the tracker does not read (`plans-proof/`) is enough until the proof starts. | Not needed. |
| Nodes with an incomplete written proof | They leave with the spectral action. | `SpectralProof.*` nodes stay, some with a source that is only a conjecture or an expectation. `wrong` does not fit them. They go on the "Held" list of `STATUS.md`, each with its missing proof. |
| `plans/README.md:3–12` and `:42–67` | Rewrite: the spectral decomposition is no longer inside the statement's plan. | No change. |
| Size of the work here | About 174 library nodes. | 369 library nodes; the first replacement of a placeholder is equally far. |

## Decisions for the owner

| # | Decision | Proposal |
|---|---|---|
| W1 | The owner runs the Tau Ceti Worker; a session here only folds in its results | yes |
| W2 | Replace `prompts/build.md` by the text in 1.5 | yes |
| W3 | Move the roadmap-owned nodes to `plans/Roadmap/<area>/`; a landed node is deleted | yes, after decision 5 of the goal review |
| W4 | Review every planned definition when it is written; owner approval only for `GLCinLean/Statement/`, on a branch `proposal/<topic>` | yes |
| W5 | Keep `prompts/review.md` for meaning only, with the five changes in 2.3 | yes |
| W6 | Standards check as one line in `prompts/build.md`; `lake lint` in the done check | yes |
| W7 | Add `prompts/audit.md` with the text in 3.3; list it in `README.md` | yes |
| W8 | Change `AGENTS.md:14`, `:19` and `:54` as in 2.7, 2.4 and 2.5 | yes |
| W9 | One home for each caution; a "Held" list in `STATUS.md`; no fixed rule text in `desc` | yes |
| W10 | Replace `tools/check-statement-axioms.lean` by the tracker's states | optional |
| W11 | Decide the three open decisions in `STATUS.md:46–62` before the first build session | yes |
| W12 | Propose Tau Ceti roadmaps for the general part of the library | later, when work reaches derived prestacks |
