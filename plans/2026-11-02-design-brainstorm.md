# GLCinLean: design brainstorm for an automated formalisation workflow

*Consolidated from the discussion with Claude Code on 2 November 2026. Planning input, not yet a decided design. Evidence and strategy are in `reports/` (especially `2026-10-29-claude-glc-strategy-review.md`, `2026-10-29-claude-project-structure-proposal.md`, `2026-11-02-claude-recheck-and-revisions.md`).*

## 1. Goal and stance

- **Target:** a faithful Lean 4 statement of GLC I, Conjecture 1.6.7 (de Rham, unramified, algebraically closed field of characteristic 0, Gaitsgory–Rozenblyum categorical conventions). Long-term goal: the full proof from GLC I–V.
- **Automation:** as much as possible. Formalisation may be fully autonomous, and need not be rooted in Mathlib; Tau Ceti or other public projects are acceptable foundations.
- **The human role:** the user reviews and checks **key definitions**. Review is a **tag, not a gate**. Agents may formalise and build on definitions the user has not yet checked.
- **Public communication** (Zulip posts, Tau Ceti roadmap PR text) stays in the user's own words, as Tau Ceti and Mathlib require.

## 2. Options considered

These range from least to most autonomous.

1. **Automated watcher.** A scheduled agent pulls Tau Ceti's commit log, roadmap PRs and claims, plus Mathlib PRs, the other repositories and arXiv. It updates the atlas and writes dated change reports. It reads code, not Tau Ceti STATUS files, which were stale on 2 Nov.
2. **Code-derived status.** Status comes from the build: declaration exists, type, and an axiom/`sorry` check against a pinned Tau Ceti tag. No status is written by hand.
3. **Target-picking worker.** Finds the lowest unclaimed open node on the GLC path, claims it through Tau Ceti's intentions mechanism, runs agents on it, and logs costs and rubric results.
4. **Gap-to-roadmap pipeline.** Drafts Tau Ceti-format roadmaps for unowned layers, attacked by an adversarial second agent. The user reads and posts them. Add this once the stack layer lands.
5. **Statement-first sketch.** The full GLC statement exists early, with explicit named placeholders. Agents replace placeholders bottom-up, and the remaining count is a progress measure.
6. **Fully autonomous FLT-style run.** Rejected for now. GLC's endpoint is not independently checkable, so this risks a large unreviewable library.

**Chosen direction:** combine 1, 2, 3 and 5, add 4 later, and add the user's requirements in §§3–6.

## 3. Repository architecture and the Tau Ceti split

- **Do not fork or copy Tau Ceti.** It merges hundreds of changes a day and breaks backward compatibility by policy.
- **GLCinLean is its own git repository and Lake project** depending on Tau Ceti at a pinned `vX` release tag. Mathlib comes in transitively.
- **Three libraries:**
  - `GLCinLean.Staging`: foundational material intended for Tau Ceti (for example D-module categories, Bun_G), written to Tau Ceti's style rules so upstreaming is a copy, not a rewrite.
  - `GLCinLean.Core`: the GLC-specific layer that stays here (the Langlands functor, Conjecture 1.6.7, later the proof).
  - `GLCinLean.Sketch`: the full statement with placeholders; never imported by Core.
- **Separation rule:** Tau Ceti's own split (README "Collaboration"). Foundational material, meaning what a graduate student in the area would know, goes to Staging and then upstream. Frontier results from GLC I–V go to Core. An agent classifies new items; the user decides borderline cases.
- **Upstreaming loop:** the agent opens a Tau Ceti PR, or a roadmap first if none covers the item; it is tagged with the registered intention. After merge, the next pin bump brings the upstream version in, and a script deletes the Staging copy, rewrites imports, and requires a green build.
- **Weekly pin bump:** try the newest Tau Ceti tag, let an agent repair breakages, and merge when green.

## 4. Blueprint

- **Yes, have one.** It is the backbone for tracking and review.
- **Each node** is one definition or theorem, with:
  - natural-language statement and source (paper, arXiv version, section);
  - Lean declaration, if any;
  - dependencies;
  - owner: Mathlib, Tau Ceti, Staging, Core, or none;
  - status computed from the build;
  - `key: true/false`;
  - review tag (§6);
  - hypotheses, such as typeclass assumptions like `[HasKInjectiveResolutions C]`.
- **Format options:** a YAML atlas validated by JSON Schema (easiest for agents and the website), or the standard Lean `leanblueprint` LaTeX tool. Leaning YAML, generating pages from it.
- **Status vocabulary:** absent / proposed / planned / interface / partial / constructed / proved / reviewed.

## 5. Progress website

- **Hosting:** a static site generated from the build and blueprint, refreshed on every commit or daily; private or GitHub Pages. Much simpler than Tau Ceti's explorer.
- **Headline:** separate percentages for the **statement** and the **proof**. Each has two bars: *formalised* (sorry-free, axiom-clean) and *reviewed* (formalised, with every key definition beneath it reviewed).
- **Dependency graph** coloured by status; nodes are clickable.
- **Library pages** for every node, with natural language and Lean side by side.
- **Search** over names, natural-language text and Lean names.
- **"What changed" feed** from the watcher, including upstream merges that advanced the graph.
- **Warning badges** on anything resting on `unreviewed` or `disputed` definitions.

## 6. Definition cards and review tags

- **One card per key definition**, slide-style:
  - left: natural-language definition with source;
  - right: the Lean definition and an unfolded version in familiar terms;
  - below: the agents' comparison (what matches, what deliberately differs) and proved sanity tests (torus case, $\mathbb P^1$, known answers).
- **Review tags:** `unreviewed`, `checked` (the user read it and it looks right), `reviewed` (detailed or expert check), `disputed`, each with date and note.
- **Non-blocking:** agents may use any definition whatever its tag.
- **Review queue:** ordered by how much depends on each definition. Expected key-definition list: about 15–25 items (Bun_G, half-twist, D-modules on stacks, LocSys, QCoh/IndCoh, singular support, Hecke/Satake, the Langlands functor, …).

## 7. Change propagation

1. **Fingerprints.** Each review stores a hash of the definition's Lean statement and of what it unfolds to. Any later change, whether a user edit, an agent refactor or a Tau Ceti or Mathlib update, resets the tag to `unreviewed`, with a "changed since you checked" diff on the card.
2. **User changes.** A user change to a definition is recorded as a dated decision note.
3. **Impact list.** A script computes, from the compiled project, every declaration that transitively uses the changed definition, and marks those nodes "impacted" on the website.
4. **Breakage handling.** Anything that no longer compiles is a known issue. Anything that still compiles but depends on the change is flagged for re-check, never silently accepted.
5. **Repair agent.** It fixes proofs, downstream definitions, sanity tests and cards. Whatever it cannot fix stays red.
6. **Branches.** All changes go through branches, merging only on a green build.
7. **Pin bumps.** The same mechanism runs on every Tau Ceti or Mathlib pin bump.

## 8. The combined agent loop

1. **Watcher** (daily): updates owners and statuses from upstream.
2. **Planner:** picks the next open node, checks claims, and assigns it to Staging or Core.
3. **Builders:** formalise the node and prove sanity tests; generate cards for key definitions.
4. **Upstreamer:** moves Staging work into Tau Ceti PRs and cleans up after pin bumps.
5. **Impact and repair:** runs on any definition change or pin bump.
6. **Roadmap drafter** (later): Tau Ceti-format drafts with adversarial review, for the user to read and post.
7. **Reporter:** rebuilds the website; weekly summary including costs.

## 9. Risks

- **Collisions with Tau Ceti's own agent fleet** (≈800 merges/day around 29 Oct–2 Nov). Mitigation: strict claims before building.
- **Tau Ceti declining Staging work.** It then stays here; nothing is lost.
- **Review bottleneck.** Keep the key list short; order the queue by impact.
- **Cost.** Set per-loop budgets and report them weekly.
- **Silent semantic drift** through upstream changes. Mitigation: fingerprints and impact checks.
- **Unreviewable volume.** The website must keep *formalised* and *reviewed* visibly separate.

## 10. Proposed build order

1. `git init`; repository skeleton (§3); Lake project pinned to the current Tau Ceti tag.
2. Blueprint schema and initial atlas for the ~12 statement ingredients.
3. Watcher and build-derived status checker.
4. First website: progress bars, graph, node pages, search.
5. Card generator, review tags, fingerprints, impact check.
6. Planner and builder loop on the first open nodes; upstreamer.
7. Statement sketch with placeholders.
8. Roadmap drafter, once algebraic stacks land in Tau Ceti.

## 11. Open questions for planning

- YAML atlas or `leanblueprint` as the source of truth, or YAML that generates a blueprint?
- Website hosting and access (private vs public)?
- Budget per month for agent runs?
- Which agent harness runs the loops: Tau Ceti's worker, Claude Code scheduled agents, or custom?
- Exact list of key definitions, and whether an outside expert reviews any of them?
- When to register the project's intention publicly?

---

## 12. Repository layout and long-term evolution (added 2 Nov 2026)

### 12.1 One repository or several?

The system has two kinds of parts. **GLC-specific content**: the Lean code, the blueprint data, and review records. **Generic machinery**: the website generator, watcher, card generator, fingerprint and impact tools, and agent loops. The machinery could serve any large formalisation project.

| Option | Layout | Pros | Cons |
|---|---|---|---|
| A. Monorepo | One repo: Lean + blueprint + tools + website | Simplest; one CI; atomic changes across code and tracking; easiest for agents | Tools hard to reuse elsewhere; Lean CI slowed by tooling changes; repo grows large |
| B. Two repos | `GLCinLean` (Lean + blueprint data + review records) and `formalisation-tracker` (generic tools + site generator, installed as a package or GitHub Action) | Clean reuse; tools versioned independently; GLC repo stays mathematical | Changes spanning both need two PRs; must define a stable data format between them |
| C. Three or more repos | Add `GLCinLean-site` (built website only) and possibly `GLCinLean-staging` (Tau Ceti-bound work) | Website deploys without touching Lean; staging can follow Tau Ceti's style and CI exactly | More coordination; risk of drift between repos |

**Suggested path:** start with **A**. Keep the tools in a clearly separated `tools/` directory with no GLC-specific code, driven only by the blueprint data format. Extract them into repo B once the format stabilises, or once a second project wants them; that is a mechanical move. Publish the built site from CI to GitHub Pages or a `gh-pages` branch rather than a separate source repo. Keep Staging inside the GLC repo until upstreaming volume justifies a separate repo.

**The key enabler for any of these is a documented, versioned data format.** That covers the blueprint/atlas schema, review records with fingerprints, and status output from the build. Tools and website read only this format. Then the tools work for any project, and any repo split is cheap.

### 12.2 Depending on a changing ecosystem

Tau Ceti grows daily. Other teams may publish stack or foundations libraries (for example a future audited Stacks Project formalisation). Mathlib may absorb material. The design should assume **every foundation can move, be replaced, or appear later**.

- **Adapter layer.** GLCinLean never imports foundation declarations directly in its GLC-specific code. It goes through a thin `GLCinLean.Foundations` layer that re-exports or wraps the chosen definitions (`Foundations.AlgebraicStack`, `Foundations.DModule`, …). Swapping Tau Ceti's stacks for another library, or for Mathlib's, then means changing one layer and proving comparison lemmas there.
- **Comparison lemmas instead of duplication.** When two libraries define the same object, prove an equivalence in the adapter layer and record both in the blueprint. This also gives an independent fidelity check: two independent formalisations that agree are strong evidence of correctness.
- **Provider field.** Each blueprint node records `provider` (Mathlib, Tau Ceti, external repo X, Staging, Core) and `alternatives`. The watcher flags when a new provider appears for a node you currently build yourself, so you can stop duplicating and switch.
- **Multiple dependencies and version conflicts.** Lean allows only one Mathlib version per build. External libraries on different Mathlib pins cannot be imported together. Options:
  1. **Wait** for the library to catch up.
  2. **Port** the needed parts into Staging, with attribution and licence check.
  3. **Encourage it upstream** into Tau Ceti or Mathlib.

  The watcher should record each candidate library's toolchain and Mathlib pin, so compatibility is visible.
- **Pin discipline.** Pin everything (Tau Ceti tag, any external libraries by commit). Bump on a schedule with an agent repair step and the impact check of §7. Keep a `DEPENDENCIES.md` log of every bump and what broke.
- **Exit strategy.** If Tau Ceti stalls or changes policy, the pinned version keeps working. Staging plus the adapter layer means you can continue alone or move to another foundation.

### 12.3 Reusability

- **Generic tools from day one.** Nothing in `tools/` mentions GLC. Configuration (project name, sources, key-definition list, providers to watch) lives in one config file. The same system could track any Tau Ceti-downstream project, for example a future "Geometric Satake" or "local Langlands" project.
- **Standard formats where they exist.** Use Lean's `doc-gen4` output for formal declarations, `leanblueprint`-compatible exports if possible, JSON Schema for data, and plain static HTML for the site. The site generator could output both its own site and a `leanblueprint` LaTeX, so people used to blueprints can read it.
- **Share upstream.** Tools that prove generally useful (impact analysis, fingerprinting, review cards) could be offered to the Lean community or Tau Ceti. Tau Ceti already runs a similar explorer and progress system, so check overlap before building.

### 12.4 Maintainability

- **Content and tooling versioned separately.** The tools have semantic versions; the GLC repo pins a tools version, like any dependency.
- **CI tiers:**
  - fast checks on every commit: schema validation, build of changed modules;
  - nightly full build, fingerprint and impact check, website rebuild;
  - weekly dependency bump attempt.
- **Agents as replaceable workers.** Every loop is a script plus a prompt in the repo. Swapping Claude, Codex or Tau Ceti's worker changes one config value, not the system.
- **Human-readable records.** Decisions, reviews and dependency bumps are dated Markdown or YAML in git, so the project history is auditable without the tools.
- **Size control.** Generated artefacts (site, caches, agent logs) are kept out of the main branch. Logs go to CI artefacts or a separate storage branch.

### 12.5 Other considerations for a large, long-lived system

- **Attribution and licences:** record provenance for every ported declaration, and the licence of each provider. Choose a licence for GLCinLean early (Apache-2.0 matches Tau Ceti and Mathlib).
- **Public vs private:** keep the repo private while the specification is unreviewed, but plan the switch to public so you can register intentions, upstream work and invite reviewers.
- **Cost tracking:** a structured per-loop cost log feeding the website.
- **Reproducibility:** every website number links to the commit and build that produced it.
- **Security:** agents with push access only to branches, never to `main`. Secrets live in CI, not in prompts.
- **Bus factor:** documentation good enough that an expert collaborator or another agent harness can pick up the project without you.

### 12.6 Additional open questions

- Monorepo first and extract later (recommended), or split tools out from day one?
- Licence for GLCinLean and for the tools?
- Build on Tau Ceti's existing progress/explorer tooling, or build our own?
- Rules for which external libraries may become providers (audit level, activity, licence, toolchain)?

---

## 13. How much of Tau Ceti's tooling can be reused (checked 2 Nov 2026)

*Sources: GitHub repositories and READMEs listed below, read on 2 Nov 2026. Tags: [R] inspected; [S] the tool's own claim; [J] judgement. Nothing was installed or run.*

### 13.1 What exists

| Tool | What it does | Licence | Reusable for GLCinLean? |
|---|---|---|---|
| **TauCetiTools** (`TauCetiProject/TauCetiTools`, Python) | "Shared configuration, CI and administration for **Lean projects using the Tau Ceti workflow**". `tauceti-tools init --repo YOUR_ORG/YOUR_PROJECT` writes a `tauceti.toml`, installs workflows, and sets up merge automation (GitHub merge queue or Bors), claims and optional services. Documented in `docs/project-setup.md`, with a complete example config. [S][R] | Apache-2.0 | **Yes, designed for it.** Other projects already use it: `kim-em/Arcturus` ("An autonomous Lean project using shared Tau Ceti tools"), `cslib-community/EpsilonEridani`, `yuma-mizuno-lean/Mei`, `LeanMachineLearning/LMLExplore` (each has a `tauceti.toml`). [R] |
| **TauCetiWorker** (`tauceti` CLI) | Bring-your-own-agent worker: queue dashboard, author, fix, review, Mathlib-bump adaptation, `--loop` mode, leases so parallel workers never collide. Works on any configured project via `--conf tauceti.toml`. [S] | **No licence file** | Use by installing (`uv tool install`); do not copy or modify its code. |
| **TauCetiReview** (`tauceti-review`) | Multi-agent review engine: one agent per rubric angle; only integrity angles block; head-bound scoreboards; runs on your own Claude/Codex/Kiro subscription. Custom rubrics come from your own `…Review` repo with a `rubrics/` directory, without forking the engine. Includes cost reporting and A/B meta-review. [S] | Apache-2.0 | **Yes.** Add GLC-specific rubrics, such as "definition matches its blueprint card" and "no unrecorded convention change". |
| **TauCetiProgress** (`tauceti-progress`) | Generates per-roadmap `STATUS.md` snapshots and append-only `PROGRESS.md` logs. Tested Python decides the facts from compiler-derived doc-gen data; a model only writes prose. [S] | Apache-2.0 | Partly. Useful as an automated narrative log. Tau Ceti's own STATUS files were 1–2 weeks stale on 2 Nov, so treat its output as a summary, not the status source of truth. [R][J] |
| **Tau Ceti Pages / Progress page** (`TauCeti/.github/workflows/pages.yml`, `api-docs.yml`) | doc-gen4 API docs plus charts of lines of code, PR statistics and per-roadmap progress, built in CI with the pinned TauCetiTools setup action. [R] | Apache-2.0 | The doc-gen4 part is directly reusable and gives the formal side of every definition card. The charts are Tau Ceti-specific. |
| **tauceti-explorer** (`CBirkbeck/tauceti-explorer`) | The interactive "universe" atlas: subjects as galaxies, roadmaps, layers and their definitions; search; offline single-file `index.html` with MathML typesetting; progress colouring; definition panels. 211 roadmaps, 646 reviewed source refinements. Scripts include `check_keydefs.py`, `definitions_page.py`, `blueprints.py`, `extractor.py`, `library_coverage.py`. [R][S] | Apache-2.0 | **Ideas and components, not the base.** It is built around Tau Ceti's roadmap corpus and Mathlib "disk" (repository ≈ 730 MB), and its rebuild pipeline is tied to Tau Ceti's snapshot. Its definition pages, offline single-file build, MathML typesetting and search are worth borrowing. Its visual metaphor is far heavier than the simple dashboard wanted here. [J] |
| **TauCetiRoadmapWorker / Jobs** | Agent planning and porting of roadmaps; humans file targets and merge. The setup doc calls downstream use "optional, work in progress". [S] | (not checked) | Later, possibly for design 4 (roadmap drafter). |
| **TauCetiCI, TauCetiData, TauCetiFleet** | CI records, review archives, fleet deployment. [S] | No licence files | Not needed at first. |

### 13.2 Important constraints

- **Public repositories only.** The setup guide says: "The supported deployment uses **public project repositories** … Private and internal projects are not currently supported." [S] This conflicts with §12.5's "keep private until the specification is reviewed". Choose between:
  - **(a)** go public from day one, with a clear "unreviewed, in progress" banner;
  - **(b)** start private with your own lighter tooling, and adopt TauCetiTools when going public.
- **The workflow assumes separate repositories.** A content repo (Lean), a human-owned roadmap repo (targets), and optionally data, CI and claims repos and a custom rubrics repo. [S] Adopting TauCetiTools therefore largely decides the §12.1 question: GLCinLean content repo + GLCinLean roadmap repo (+ claims) + optional `GLCinLeanReview` rubrics.
- **Human-owned policy files.** Configuration, workflows and the roadmap repo are human-owned; agents edit only the Lean source paths. This matches the review-tag design: blueprint data and review records stay human-controlled.
- **Pin the tools.** The tools must be pinned by immutable commit SHA in `tauceti.toml`. [S] This fits the pin discipline of §12.2.

### 13.3 What Tau Ceti's tooling does not provide (to build ourselves)

- **The blueprint/atlas** with natural-language statements, source locators, owners and providers (§4).
- **Definition cards** with your review tags, and **fingerprint-based invalidation** (§6–7). Nothing equivalent was found. `tauceti-explorer`'s `check_keydefs.py` and `definitions_page.py` should be read before building, as possible starting points [J, not inspected].
- **Transitive impact analysis** after a definition change (§7).
- **Statement/proof percentages** split into formalised versus reviewed (§5).
- **A watcher across non-Tau Ceti providers** (Mathlib PRs, other libraries, arXiv) (§12.2).

### 13.4 Revised recommendation [J]

1. **Adopt TauCetiTools for the agent and CI layer** instead of writing our own worker, review engine and merge automation. This removes the largest build item (§8 steps 2–5) and makes upstreaming to Tau Ceti natural, since the same conventions are used. Copy `kim-em/Arcturus` as the reference downstream project.
2. **Repository layout then becomes:**
   - `GLCinLean`: Lean content, `tauceti.toml`, blueprint data and review records.
   - `GLCinLeanRoadmap`: human-owned targets in Tau Ceti's roadmap format; doubles as the home for roadmap drafts destined for Tau Ceti.
   - `GLCinLean-claims`.
   - Later: `GLCinLeanReview` with custom rubrics.

   The website is published by CI to GitHub Pages from the content repo.
3. **Build only the GLC-specific layer ourselves:** atlas, cards, review tags, fingerprints, impact analysis, percentages, the external watcher, and a simple dashboard. The dashboard reads doc-gen4 output for the formal side and borrows explorer components where useful.
4. **Decide public versus private first.** It determines whether step 1 is possible now.

### 13.5 New open questions

- Public from day one (to use TauCetiTools), or private first?
- Can the blueprint/atlas live in the roadmap repository so it is human-owned under the same policy, or should it stay in the content repo?
- Check `tauceti-explorer`'s key-definition and definitions-page scripts before writing our own card generator.
- Ask Tau Ceti maintainers (in your own words, on Zulip) whether a downstream frontier project using their tools and upstreaming foundations is welcome. Their README suggests yes.
