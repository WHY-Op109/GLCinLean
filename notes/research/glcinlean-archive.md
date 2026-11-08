# GLCinLean-archive: the owner's earlier design

- **Source:** `WHY-Op109/GLCinLean-archive` (private, archived on GitHub). `main` @
  [`7a0f43c034ac5430ec1668d74b26b8aaa35f4b91`](https://github.com/WHY-Op109/GLCinLean-archive/tree/7a0f43c034ac5430ec1668d74b26b8aaa35f4b91)
  (2026-11-06). Branch `glcinlean-a2-full` @ `4be6f88` holds GLCinLean's full history up to
  stage A2.
- **Checked 2026-11-08.** Cloned read-only into `.lake/research/GLCinLean-archive/`; nothing in
  the archive was changed, and it was not unarchived.
- **Licence:** none. It is the owner's private material. It quotes the GLC papers (CC BY 4.0)
  and AGKRRV (arXiv non-exclusive licence: link only, do not copy).
- **Note:** the archive's README says "Agents working on GLCinLean should not read this
  repository". It was read here because the owner's research request names it. Nothing in it
  is in force.

**Tags.** [R] means I read it in the archive on 2026-11-08. When the archive reports a fact
about another source (Tau Ceti, Stacks, a CLI, the papers), that fact is the archive's own
claim, tagged [S] with the archive's date. It may be out of date. [E] is an estimate and [J] a
judgement, mine unless marked "archive's [J]".

**What I read.** In full: the decision log
(`glcinlean-2026-11-06/plans/2026-11-design-discussion-log.md`, 736 lines) and the design
brainstorm (`…/plans/2026-11-02-design-brainstorm.md`). Most of the implementation plan
(`…/plans/2026-11-04-implementation-plan.md`, 813 lines: §0–3, §6–11). Only the openings and
summaries of: the Astra plan review (`plan-reviews/2026-11-05-astra-plan-review.md`), the
2026-11-06 feasibility reports 1–4, N3-maths, the October reports, the A2 GitHub-setup report
and `reviewkit/README.md`. **Not read:** the other 2026-11-04 feasibility reports (N1, N2,
N4–N9, L1–L4, critic), the prototypes, the fault fixtures, the schemas, the evidence records,
the AI assessments in `archive/references/`.

**Re-checked 2026-11-08 (second pass).** The claims below that carry [R] were re-read against
the clone at `7a0f43c` (decision log in full, brainstorm §1–7, plan §1–3, §4, §9–11, report 4
§0, report 1, N3, the Astra review's F03 probe, the A2 GitHub-setup report, `CODEOWNERS`, the
`glcinlean-a2-full` history), against today's GLCinLean files, and with read-only `gh api` calls
on `WHY-Op109/GLCinLean`. Corrections are folded in where they apply.

---

## 1. What it is

A cold archive of everything removed from GLCinLean when it was simplified twice on 2026-11-06
[R, README]:

| Path | What it holds |
|---|---|
| `glcinlean-2026-11-06/plans/` | brainstorm (2 Nov), decision log, implementation plan (4 Nov, redrafted 5 Nov) |
| `glcinlean-2026-11-06/reviewkit/` | the in-repo copy of the A2 review kit: Lean `review` executable, 17 JSON schemas, Python checks, toy test project; about 5,400 lines of Lean and Python (2,326 + 3,040) [R, `wc`]. The README says the kit itself "now lives at" `WHY-Op109/reviewkit`, whose tag `a2-full` is the full version [R, README]; that is the "reviewkit" `ideas.md` links |
| `glcinlean-2026-11-06/{reports,references/tau-ceti,.github,glc,reviews}` | reports, copies of Tau Ceti roadmaps, CODEOWNERS and the policy workflow, fault fixtures, attestations |
| `glcinlean-2026-11-06-slimming/` | GLCinLean's fault fixtures, machine evidence records, `glc/extras.toml` |
| `feasibility/2026-11-04/`, `feasibility/2026-11-06/` | 13 feasibility runs with prototypes; 5 reports on Mathlib use, quality indicators, metrics, integration, the A2 decision |
| `plan-reviews/` | GPT-6 Astra's review of the plan (21 findings, F01–F21) |
| `archive/` | October 2026 strategy reports and third-party AI assessments |
| `skills/grilling/` | a copy of the owner's `grilling` skill |
| `scout/`, `permissions/` | empty (only `.gitkeep`) [R]. The README says `permissions/` holds "written permissions (for example from the bridgekat author)", but none is there; plan §1 says the C1 permission record is no longer needed because tracker, numlib-auto and metrics became Apache-2.0 and the explorer MIT [S, 2026-11-04] |

The history in short [R]:

- **28 Oct–3 Nov:** strategy reports, then a design discussion.
- **4–5 Nov:** a plan, reviewed three times.
- **5–6 Nov:** stages A1 and A2 built.
- **6 Nov:** two simplifications into today's GLCinLean (`PLAN.md`).

The log runs to **D44**: D40–D44 were added on 4–6 Nov.

The scale is part of the finding. By 6 Nov there were:

- 44 decisions (D1–D44), 11 brainstorm ideas (B1–B11), 3 parked questions and 9 items to verify;
- 21 review findings (F01–F21);
- 15 kit components (K1–K15) and 21 open questions for the owner (Q1–Q21);
- 28 recorded conflicts (C1–C28).

The real mathematics went no further than a stub: "12 project placeholders" and the statement
[S, report 1, 2026-11-06]. The count depends on what is counted: today's
`GLCinLean/Foundations.lean` and `GLCinLean/Abstract.lean` carry 16 `@[placeholder]` tags (10
and 6) [R, 2026-11-08]. Stage B1 (the Astra-drafted blueprint) never ran: the
`glcinlean-a2-full` history ends at A2 [R], and today's `blueprint/plans/` holds only a stub
tracker plan of `Abstract` and `Foundations` [R, `PLAN.md` and the files].

**What was actually set up on GitHub [R, 2026-11-08].** The A2 set-up report says none of its
own commands (ruleset, test PRs) had been run [R]. Today, read-only `gh api`: GLCinLean is
public, squash-only, auto-merge on, Issues off, and has no rulesets.

---

## 2. What it says that matters for GLCinLean

### 2.1 The owner's own ideas and points (worth keeping)

These are positions the log attributes to the owner, or principles the owner accepted.

1. **The goal (D30) [R].** In the owner's words: "The first goal is the statement of GLC, that
   all the definitions of that statement has been formalised to really faithfully express the
   statement. Next step, is the formalisation of the whole proof." When the statement is done,
   there is a checkpoint, not a gate: the owner decides when the proof starts.
2. **Review is a tag, not a gate** (brainstorm §1, §6) [R]. The tags are `unreviewed`,
   `checked` (the user read it and it looks right), `reviewed` (detailed or expert check) and
   `disputed`, each with date and note (all four are in brainstorm §6). Agents may build on
   unreviewed definitions.
   Any later change resets a tag to `unreviewed`, with a "changed since you checked" diff
   (brainstorm §7; the reset covers Tau Ceti and Mathlib updates too). This is the same idea as
   `ideas.md`'s review status: reviewed at a commit, and unreviewed again after a change.
   Brainstorm §5 also has the web page `ideas.md` wants: separate statement and proof bars,
   each split into *formalised* and *reviewed*, a dependency graph coloured by status, and
   warning badges on anything resting on `unreviewed` or `disputed` definitions [R].
3. **What "checked" means (D8) [R]:** "read, readable, consistent with its card and the
   paper's wording", not "mathematically certified". Before an outside expert has reviewed the
   5–10 most load-bearing definitions, the project claims only "unreviewed, heavily tested".
4. **A reusable review and blueprint system (D34, D35) [R].** The log records the owner's aim
   (its paraphrase, not a quotation): once finished, the system "can become a repository of
   its own, adaptable to other projects, as numlib-auto uses tracker and the graph explorer".
   The owner first said "a single private" repository (D34); D35 settled it as public from the
   start, a folder first and split later (P3 closed).
   This is `ideas.md`'s "review system in its own repository".
5. **Statement first, with named placeholders (B5, D13, D15) [R].** "Black box" means `sorry`
   proofs and named data-only placeholders, "never `axiom`s asserting properties".
   Amendment 1 matters most: "The statement cannot black-box $\mathbb L_G$". With $\mathbb L_G$
   opaque, the statement says only that "some unspecified functor is an equivalence". So the
   §1.1–1.6 construction must be real definitions down to the placeholders.
6. **The owner's working principle (D36) [R], quoted:**
   > "Before acting, figure out what I really want to achieve, not just the approach I
   > described. If my plan looks like a detour, first point out the more fundamental approach
   > and ask me whether I have the conditions for it. If I confirm I don't have the conditions
   > or insist on the original plan, then carry out the original plan carefully. A plan that
   > eliminates steps takes priority over a plan that automates cumbersome steps."

   The log kept it out of `AGENTS.md` only because "ask me first" would stall a 24/7 loop.
7. **Tau Ceti's split (D28, B5, brainstorm §3) [R].** Foundational material ("what graduate
   students in the area would know", B5 amendment 4) belongs in Tau Ceti. D28 says the GLC
   statement is frontier mathematics and "stays in GLCinLean permanently"; the brainstorm (§3)
   puts "later the proof" in the same local layer. The log credits this split to Tau Ceti's
   README "Collaboration" section [S, 2026-11-03].
8. **Order of providers [R, report 4 §0 item 1, 2026-11-06]:** "Mathlib, then Tau Ceti, then
   copied Stacks, then build locally". It applies only "where the object exists at the
   generality the paper uses and in the formalism the blueprint fixed". Report 1 found that
   nothing in the old plan told agents to prefer Mathlib, and that the blueprint fields had no
   Mathlib field [S, 2026-11-06]. Today's `PLAN.md` carries this order.
9. **Layout (D44 K4) [R].** Role folders at the top (Abstract, Foundations, Staging, Stacks).
   Inside them, Mathlib's subject folders. Names follow `GLCinLean.<Subject>.…`, and lemmas
   about an existing Mathlib or Tau Ceti type go in that type's namespace. Mathlib's linters
   run as warnings only (K5).
10. **Papers (D6) [R].** Agents use the arXiv LaTeX source (formulas, labels and numbering
    intact) and the owner reads the PDF. Neither is committed. The manifest existed to
    re-create the set on any machine and to notice new arXiv versions.
11. **Plain words and tagged evidence** run through every document [R]. D8 starts from "the
    user cannot assess the mathematics and Lean does not check definitions"; plan §1: "You
    cannot check the mathematics yourself, so the plan's fidelity evidence is what you rely
    on".

### 2.2 Findings about the statement (still valid unless the papers change)

- **Hypotheses (Q5, from N3) [S, N3 report, 2026-11-04, with file:line quotes].**
  - GLC I v3 says only "a field of characteristic 0" (`functor.tex` l.717).
  - AGKRRV assumes $k$ algebraically closed (of arbitrary characteristic, `text.tex` l.2066),
    and GLC II v3 says "a fixed algebraically closed field $k$ of characteristic $0$"
    (`glc2/Loc.tex` l.1497).
  - $X$ is connected in AGKRRV Part III (l.15123); GLC II needs it for the contractibility of
    Ran.
  - $\mathbb L_G$ "depends on the choice of the square root $\omega_X^{1/2}$" (GLC I l.1511).
  - The Whittaker datum needs a pinning.
  - These hypotheses carried over into today's `PLAN.md` [R].
- **$\mathbb L_G$ (Q6, option C) [R].** $\mathbb L_G$ is *the* functor with Cor. 1.6.5's two
  properties: one sorry'd existence theorem, with uniqueness stated. D43/F08 adds the
  contract: continuous, $\mathrm{QCoh}(\mathrm{LS})$-linear, in the enhanced sense;
  "isomorphism, never an equality of functors".
- **Size [S, N3, 2026-11-04]:** 5 standing parameters, 23 GLC-specific constructions, about 10
  families of generic foundations, and 8 theorems used inside definitions. Neither Mathlib nor
  Tau Ceti had D-modules, algebraic stacks, $\mathrm{Bun}_G$, IndCoh, the Ran space or stable
  ∞-categories. Its estimate: 20–25 key definitions [E].
- **Torus case (D40 item 6) [R].** Conj. 1.6.7 at $G=T$ "is a restatement and adds no
  evidence". Proved degenerate-case lemmas replace it as evidence.
- **Formalism first (D42) [R].** Stacks and Tau Ceti use different stack formalisms. On GLC's
  own route (prestacks and crystals, after AGKRRV and Gaitsgory–Rozenblyum), the statement may
  need $\mathrm{Bun}_G$ only as a functor of torsors (archive's [J]). So the blueprint must
  choose one formalism before anything is copied.
- **Tau Ceti is AI-written, so the review walks into it (D40 item 2) [R].** Only Mathlib and
  Lean core are trusted background.

### 2.3 Lessons from building the review kit (transferable to the new review system)

- **The fingerprint must keep declaration identity (D43/F03) [R].** The prototype's name-free
  hash serialised an opaque constant by kind and type only, so Astra's probe got identical
  hashes for `TestA → TestA` and `TestA → TestB` (two opaques of the same type). A swapped
  object would have slipped past the statement pin.
- **Two levels of pin (D43/F10) [R].** A hard pin on the main theorem's own statement fails CI
  on a change. The transitive digest only marks reviews stale. Otherwise every placeholder
  replacement or bump stops CI ("about 15–20 clerical stops").
- **An `opaque` hides a `sorry` from the kit (D44) [R].** With
  `@[placeholder] opaque taggedDataWithSorry : Nat := sorry`, `#print axioms` did report
  `sorryAx`, but the kit's `axioms` and `placeholders` commands passed silently, because its
  walk skipped opaque bodies; A2 fixed it. Separately, a sorry-free `opaque` placeholder shows
  no axiom at all, so `#print axioms` cannot count placeholders, and tracker reports opaque
  placeholders as `proved` (plan C7). That is why there is an `@[placeholder]` attribute. (C7's
  wording "`opaque` is invisible to `#print axioms`" is too strong in the light of D44's probe
  [J].)
- **Identical text can mean different things (D43/F02) [R].** A local instance changed what
  `def value : Nat := 0` evaluates to. So a diff of the text is a lexical guard only.
- **Keep machine evidence apart from human sign-off (D43/F11) [R].** Compute staleness; never
  write it into the owner's records.
- **Formal abstract (B10/D39) [R], after `edemaine/lean-wang` and `lean-canny`:**
  - one file states the theorem and every definition it needs beyond the libraries;
  - a closure check fails if the statement depends on project code outside it;
  - the closure is the key-definition list;
  - the number of placeholders in it measures progress.
- **Blind read-back (B3, D17) [R], from Prove2Me:** an agent sees only the Lean and writes it
  out as LaTeX, and the owner compares that with the paper. The log calls it the "most
  valuable import", because the owner "can compare two LaTeX statements".
- **Three questions behind "core plus surface" (B11) [R]:**
  - *trust* is the meaning of the statement's closure;
  - *generality* is numlib-auto's backbone versus surface, which agents can handle;
  - *quality* is polish for reuse and upstreaming.

  B11 recommended no human-reviewed code tier, because nobody could staff one.

### 2.4 Facts about the ecosystem (dated; re-check before use)

- **Tau Ceti cache [S, plan §4, 2026-11-04].**
  - Downstream projects can use it anonymously.
  - The 892-module Foundations closure arrived in about 5.5 minutes with 0 modules compiled.
  - Only batch-tip commits on `main` have revision maps (2 of 100), so the advice was "Pin to
    tags, or to commits that have a map". This matters for automated bumps.
- **Tau Ceti tags [S, 2026-11-03]** come every 2–3 weeks and follow Lean toolchain releases.
  Its Mathlib pin moves hourly.
- **Budget [E, plan §6, 2026-11-04]:** goal 1a would take 50–150 commits.
- **Terms (C1) [S, plan §9]:** the Consumer Terms forbid automated access "except where
  explicitly permitted", and Tau Ceti's tooling calls a 24/7 subscription reviewer "likely
  outside subscription terms". Never resolved (Q1).
- **Codex (C27a) [S, 2026-11-04]:** with the default config, `codex exec` gets server-side
  tools that can publish or share pages.
- **Prompt injection (B7.5) [S, 2026-11-03]:** an attempt was seen in a GitHub page during
  research.
- **AGENTS.md (D33) [S, archive's test, 2026-11-03, Claude Code 2.1.317]:** "Claude Code reads
  `AGENTS.md` when no `CLAUDE.md` exists".
- **Licences:** tracker, numlib-auto and metrics became Apache-2.0 and tracker-graph-explorer
  is MIT [S, plan §1, 2026-11-04]; lean-quality-indicators has no licence, so its prompts
  cannot be copied [S, report 2, 2026-11-06].

### 2.5 The machinery that made it complicated

Each item answered a real risk, but together they outgrew the mathematics [J]:

- **An unattended 24/7 loop (D20, B6, B8, D31, D32):**
  - a background service, a watchdog and reboot recovery;
  - automatic deletion of `.lake` folders;
  - storage thresholds.

  The plan later made it conditional: Stage C runs "only if Q1 is *yes* and Q2 chooses 24/7",
  and both stayed open [R]. It was never built.
- **A GitHub App identity with CODEOWNERS, rulesets and a policy workflow (D44 Q4).** It was
  designed so that agents cannot merge changes to their own rules. `CODEOWNERS` exists; the
  ruleset was never applied (§1).
- **A blind read-back harness (D17, D25, K5–K7):**
  - hardened, tool-less Claude and Codex calls;
  - a comparator;
  - a resolver that picks the "most capable" Codex model;
  - three fault-injection tests (D27).
- **Data format v0 (K3, D39 item 2, D43/F11):** 17 JSON schemas, separate evidence and
  attestation records, freshness digests covering prompt, schema, model and validator.
- **A Stacks copy tool with an upstream-diff check and a rename-alias rule (D41, D42, K15).**
- **A scout (D24):** daily scripts plus a weekly broad search by two model families.
- **A deterministic driver and a pacing rule (K8, K9).**
- **A doc-gen4 fork and card pages (K11).**
- **Private companion repositories (D37) and a separate set-up prompt (D38).**

Why it grew [J]:

- Each review (D40, D42, D43) answered findings with more mechanism.
- Decisions were revised in layers (D3 → D33 → D34 → D37), so the current rule could only be
  found by reading forward through the log.
- The kit was built (A1, A2) before any blueprint or real definition existed. So it was tuned
  against toy faults, not against the mathematics.

---

## 3. What it means for GLCinLean

- **The goal and the statement are unchanged** (`ideas.md` "the goal is still the same").
  D30's goal and the Q5/Q6/F08 statement decisions are what `PLAN.md` already says [R]. Step 1
  can carry them over as they are [J].
- **The review system (separate repository, `ideas.md`).**
  - The archive's kit is the "rewrite of reviewkit" baseline. Its lessons (§2.3) are the useful
    part; its schemas and policy machinery are not [J].
  - The owner wants review status keyed to a commit hash. The archive shows that a commit hash
    alone cannot say *whether the declaration changed*; a declaration fingerprint that keeps
    names can.
  - Suggested combination [J]: record "reviewed at commit X", and detect a change by comparing
    the declaration's fingerprint at X with the fingerprint now.
- **"Two patterns, or is one enough?" (`ideas.md`).** B11 already separated the two:
  - *trust*, which suits a single long statement: review the closure of the statement for
    meaning;
  - *quality*, which suits a library: review every declaration for Mathlib standards.

  Suggestion [J]: one tool with two review scopes, not two systems. The library scope reviews
  every declaration; the statement scope adds a meaning review of the statement's closure.
- **A library, not a one-off (`ideas.md` item 1).** This reverses B11's "no human-reviewed
  tier, quality left to upstream" and the verification-first stance of D28. The archive's
  "upstream-ready Staging" quality target (report 4 §0 item 2) becomes the default for all
  code [J].
- **Order of sources (`ideas.md` item 3).** It matches report 4's order, which the archive
  found missing from the old plan. The step-2 blueprint needs a Mathlib field per node, next to
  Tau Ceti and Stacks [J].
- **Tau Ceti (`ideas.md` item 4, workflow decision "contributions fully automated").** The
  archive's quiet phase (D1, D2, D15, D28) is what this decision ends. Kept from it [J]:
  - foundational material goes upstream and frontier material stays here (D28);
  - the blueprint fixes one formalism before any upstream work (D42).
- **Keeping up (workflow decision "fully automated").** D26's simple rule (bump at tags, one
  repair attempt; no daily bumps, canary or bisection unless bumps keep failing) and the cache
  finding (pin to tags or to commits with revision maps) are the practical basis. Only "queue
  for the user" changes [J]. Two brainstorm points fit `ideas.md`'s "stay up to date": migrate
  to new names while `@[deprecated]` aliases still exist (B1.5), and "pins are optional
  maintenance, not correctness": a pin that stays put never makes finished work wrong (B4.6)
  [R].
- **Step 1, `AGENTS.md`:**
  - the archive found it "is read by every session" and "leaks into every non-hardened model
    call", so it was kept "short and rule-only" (plan §10, D40 item 3);
  - rules for one kind of session went into that session's prompt;
  - this agrees with the workflow decision that `AGENTS.md` is short [J].
- **Step 1, prompts.** The archive ended each plan with a ready-to-run start prompt and deleted
  run prompts afterwards (D36, D42). That is close to the workflow decision "each session
  checks the prompt for the next step" [J].
- **Papers (`ideas.md` item 5).** The manifest's only reasons were re-creating the set on
  another machine and noticing new arXiv versions (D6, F20). A list of arXiv ids with versions
  in one line of `AGENTS.md` or `README.md` would serve both [J].

---

## 4. Conflicts

**With `notes/ideas.md`:**

- **"Prompts alone, without any complex system or harness"** against the archive's loop,
  driver, schemas and policy CI (§2.5). `ideas.md` replaces them.
- **"A library, not a one-off"** against B11 and D28's verification-first stance (see §3).
- **Review status by commit hash** against the archive's fingerprints. They can be combined
  (§3).
- **"I don't see the point of the manifest"** against D6 and D43/F20, which made the tracked
  manifest explicit.
- **"Contribute directly to Tau Ceti"** against D2's hard rule: "no agent ever makes an outward
  signal on its own".

**With the decisions in `notes/workflow.md` (the new decisions replace the old ones):**

- **"Agents push themselves"** replaces:
  - D44 Q4 (PRs from a GitHub App, auto-merge);
  - plan step A1.8 ("Commit locally. You push");
  - `PLAN.md`'s "the owner reads and pushes".
- **"Tau Ceti contributions are fully automated"** replaces D1, D2, D11, D15 and D28 (the
  quiet phase; D40 item 1 had already softened D28 to "nothing is sent unless the user chooses
  to"). It returns to the brainstorm's first idea (§3), in which the agent itself opened Tau
  Ceti PRs and roadmaps, before D1/D2 stopped it [R].
- **"Keeping up … fully automated, including their Lean version"** replaces D26's "on failure
  stay pinned and queue it for the user". It also replaces D44 Q10, under which the owner owns
  `lakefile.toml`, `lake-manifest.json` and `lean-toolchain`. `AGENTS.md`'s owner's-files note
  comes from D44 Q10.
- **"Prompts hold only the goal, completion criteria and context, with few constraints"**
  against the archive's 9-item `AGENTS.md` rule list (plan §10) and its worker templates.
- **Consistent with the workflow:** D33 (`AGENTS.md` only, no `CLAUDE.md`; the workflow's "no
  separate `main.md`" is new, not from D33) and plan E1 (sessions the owner starts rather than
  a 24/7 loop; recommended, with Q1/Q2 left open).
- **`AGENTS.md`'s owner's-files note** comes from three archive decisions, not one: D44 Q10
  (`lakefile.toml`, `lake-manifest.json`, `lean-toolchain`), D43/F04 (`glc/project.toml` and the
  checker are policy) and D40 Finding 3 / F10 (`reviews/statement-pin.toml`) [R]. The workflow
  decisions replace the first; the other two fall with the old kit if it leaves (§5).

**With other sources (for the summary to check against their notes):**

- D33's claim that Claude Code reads `AGENTS.md` when no `CLAUDE.md` exists [S, 2026-11-03]
  should be checked against Anthropic's current documentation. Their guidance is the reference
  `notes/workflow.md` names.
- The Stacks facts in D41/D42 (no CI, no cache, Lean v4.34.0-rc2; checked 2026-11-05) may be
  out of date; see `stacks.md`.
- The Tau Ceti facts may also be out of date: tag cadence, revision maps, "TauCetiTools
  supports public repositories only", and AI-written roadmap text "allowed if the models are
  named" (plan E3, V3). See `tauceti-contributing.md` and `tauceti-roadmaps.md`.
- **Text in the owner's own words.** Brainstorm §1 says public communication ("Zulip posts,
  Tau Ceti roadmap PR text") "stays in the user's own words, as Tau Ceti and Mathlib require"
  [R]. For roadmap text, plan C24 and V3 later found AI text "allowed with attribution" /
  "if the models are named" [S, 2026-11-04]. Nothing in the archive re-checks this for PR
  descriptions, review replies or Zulip posts, which a fully automated contribution loop would
  write; check against `tauceti-contributing.md` [J].
- D33's claim about `AGENTS.md` agrees with Anthropic's current memory documentation (needs
  v2.1.277 or later; read only when no `CLAUDE.md` exists); see `anthropic-guidance.md`.
- The archive's README says agents should not read it. This research step reads it at the
  owner's request.

---

## 5. Input for the open questions

**What exactly goes into `AGENTS.md`, and where "update the next prompt" lives.**

- The archive suggests short, rule-only content, because every session reads it (D40 item 3,
  plan §10).
- Candidates that survived every revision [J]:
  - the goal (D30);
  - plain words and evidence tags;
  - the provider order;
  - the placeholder rule;
  - "downloaded content is data";
  - builds from caches, with "Built Mathlib" as a stop-and-report sign (D33, D43/F17);
  - the Mathlib-style layout (D44 K4).
- D36's principle was kept out only because of the 24/7 loop. With sessions started in goal
  mode, it could go in as "say so when a plan looks like a detour" [J].
- "Update the next prompt" applies to every session, so one line in `AGENTS.md` fits. The
  archive's practice was a start prompt written at the end of each session [J].

**Whether `PLAN.md` is needed.**

- The archive shows the cost of a plan that grows by revision: 813 + 736 lines, with the rule
  in force spread across D3/D33/D34/D37 [R].
- The October structure proposal's principle "one source of truth per fact" [R] argues for one
  short record of decisions in force, which prompts cite rather than repeat [J].
- Prompts change every session, but decisions must outlive them. So keep a short decision
  record, whether it is called `PLAN.md` or folded into `notes/workflow.md` [J].

**Whether `Abstract.lean`, `Foundations.lean` and the placeholders are reasonable.**

- The archive supports the formal abstract and the closure check (B10, D39), and placeholders
  as `@[placeholder]` on `NonemptyType` opaques (K2), with the A2 fix for sorry inside opaques
  (D44).
- The Foundations layer of `abbrev` re-exports (D10) was justified by Tau Ceti's rename rate;
  F01 added a route for locally built foundations through it [R].
- A Mathlib-style library usually uses the provider names directly. So under the library goal,
  the re-export layer is worth re-deciding in step 2 [J].

**What happens to each existing file.**

- `lakefile.toml`'s ReviewKit requirement, `glc/project.toml` and the `reviews/` formats all
  belong to the old kit. Their `approved` fields were blank at A1 (D44) and are still blank in
  today's `reviews/` files (six entries) [R, 2026-11-08].
- Leftovers outside the files [R]: the squash-only, auto-merge repository settings (§1). They
  need a decision once agents push directly.
- If the review system moves to its own repository built on tracker, these can leave
  GLCinLean. The `@[placeholder]` attribute is then the one piece needing a new home [J]: a
  tiny local attribute, or the new review tool.
- `blueprint/` (tracker plans) fits the tracker-based system and can stay [J].
- `references/papers/manifest.toml`: see §3.

**Who reviews the mathematics, and to what standard.**

- The archive's answer (D8, D17, D43/F06), with tiers:
  - mechanical checks;
  - two blind read-backs from different model families;
  - a comparator against the paper's LaTeX;
  - the owner comparing read-back and paper once per key definition;
  - an outside expert before any claim of faithfulness. The expert gates nothing else, and who
    it is stays open (P1).
- The cost estimate for a full pass (plan §6 [E]) argues for fresh-agent review
  of *changed* declarations only, as `notes/workflow.md` step 4 already says [J].

**Where research notes and session summaries live, and whether they are committed.**

- The archive kept some material out of the public repository [R]:
  - third-party AI assessments, and reports "with judgements about other people's projects and
    a named individual" (D34);
  - feasibility reports, because "they contain account and usage details" (plan header;
    `feasibility/2026-11-04/README.md`; placed by D40 item 5 / Q20).
- That suggests committing `notes/research/` publicly only after checking for personal
  details and judgements about named people [J].
- Session summaries in the archive were the decision log plus deleted run prompts. A short
  committed summary per session would replace the log [J].

---

## 6. Questions for the owner

1. **Quiet phase:** does the workflow decision "Tau Ceti contributions are fully automated"
   end the quiet phase (D1, D2)? That would let agents open Tau Ceti pull requests and claims,
   and post where Tau Ceti requires it, without asking you first.
2. **Owner's files:** may agents now change `lakefile.toml`, `lake-manifest.json` and
   `lean-toolchain` for automated bumps (replacing D44 Q10)? Which files, if any, stay yours
   (`reviews/`, `glc/project.toml`, `AGENTS.md`)?
3. **Unattended running:** does "fully automated" mean sessions you start (plan E1), or an
   unattended loop? The archive left Q1 open: whether a 24/7 loop on a subscription fits the
   terms.
4. **Your principle (D36):** should "figure out what I really want … a plan that eliminates
   steps takes priority" go into `AGENTS.md` now that there is no 24/7 loop?
5. **Review status:** is "reviewed at commit X, detected as changed by a declaration
   fingerprint" what you meant by tracking review by commit hash?
6. **Which review evidence to keep:** the formal abstract with its closure check, blind
   read-backs by two model families, your one-time comparison of each key definition, an
   expert before any claim of faithfulness. All, some, or none?
7. **Public notes:** may research notes that judge other people's projects (as several
   October reports did) be committed to the public repository, or should such material go to
   the archive as before?
8. **The archive's README rule:** "Agents working on GLCinLean should not read this
   repository". Keep it, now that its useful points are in this note?
9. **Repository settings:** with agents pushing directly, keep the auto-merge and squash-only
   settings?
