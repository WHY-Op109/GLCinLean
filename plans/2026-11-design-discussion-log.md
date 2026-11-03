# Design discussion log, November 2026

Running record of the design discussion that continues `plans/2026-11-02-design-brainstorm.md` (prompt `prompts/2026-11-02-continue-design-discussion.md`, deleted 3 Nov 2026 after the discussion finished). Decisions recorded here override the brainstorm. When a decision overturns part of the brainstorm, the entry names the brainstorm section.

Each entry records: date · question · decision or position · reasoning · rejected alternatives · follow-up for planning.

## Status and coverage (2026-11-03)

The discussion is complete: every question named in the prompt is decided or parked.

| Prompt item | Where settled |
|---|---|
| Conflict: §12.5 private vs §13.2 TauCetiTools public-only | D1 (public, unannounced), D2 |
| Conflict: §12.1 monorepo vs §13.4 separate repositories | D3, superseded by D34 (one repository); D16; D35 (reusable system) |
| Conflict: §13 partly answers §11 harness and §12.6 explorer tooling | D16, D20 (harness); D12 (tracker + explorer instead of tauceti-explorer) |
| §11 YAML atlas or `leanblueprint` | D12 (bridgekat tracker) |
| §11 Website hosting and access | D1, D12 (public GitHub Pages from CI, unannounced) |
| §11 Budget | D7 |
| §11 Agent harness | D16, D20, D21, D24, D25 |
| §11 Key-definition list; outside expert | D29 (rule), D8; P1 (expert parked) |
| §11 When to register intention publicly | D2 (the user decides) |
| §12.6 Monorepo or split tools | D3 |
| §12.6 Licence | D22 |
| §12.6 Tau Ceti progress/explorer tooling or own | D12, D16 |
| §12.6 Rules for external providers | D23 |
| §13.5 Public from day one | D1 |
| §13.5 Atlas in roadmap or content repository | D9 |
| §13.5 Check tauceti-explorer scripts first | superseded by D12 |
| §13.5 Ask Tau Ceti maintainers on Zulip | D2 (the user's call; public text in the user's own words) |
| New: target statement | D14 (V5 on the field hypothesis) |
| New: overall strategy and phases | D13, D15, D18, D28, D29, D30, D31, D32, D33, D34, D35, D36, D37; P2 parked |
| New: fidelity and review | D8, D17, D19, D27 |
| New: Tau Ceti pace | D26 |
| New: other machines, papers, models | D4, D6, D25 |

Brainstorm status: B1 and B4 are superseded by D26 except where D26 keeps them; B2 is adopted in D12; B3 is adopted in D17 and D13; B5 is adopted as D13; B6 is adopted in D20 and D27; B7 is adopted in D24.

## Facts checked during the discussion

- **2026-11-03 [R]** `TauCetiProject/TauCetiTools` `docs/project-setup.md`, "Repositories" section, still says: "The supported deployment uses **public project repositories**, including content, roadmap, archives, claims and custom rubrics. Private and internal projects are not currently supported." It also warns that adding a token does not make a deployment private. The §13.2 constraint is unchanged since 2 Nov.
- **2026-11-03 [R]** arXiv API and abstract pages. The GLC papers and their latest versions are: I `2405.03599v3` (30 Sep 2025), II `2405.03648v3` (11 Sep 2024), III `2409.07051v1`, IV `2409.08670v1`, V `2409.09856v3` (16 Jan 2026). All five are licensed **CC BY 4.0**, so they may be stored and redistributed with attribution.

- **2026-11-03 [R]** Tau Ceti tags: the newest is now **`v4.36.0-rc2`** (`rc1` on 2 Nov); `main`'s `lean-toolchain` is `leanprover/lean4:v4.36.0-rc2`.
- **2026-11-03 [R]** `bridgekat/tracker` @ `4cee55e`, `bridgekat/tracker-graph-explorer` @ `af37572`, `bridgekat/numlib-auto` @ `0d82a15` (shallow clones in the session scratchpad, read, not built or run). **None has a licence file**; numlib-auto's README says "pending a move to Apache 2.0". tracker and numlib-auto are on `v4.36.0-rc2`, the same toolchain as Tau Ceti. tracker: 18 commits since 5 Sep 2026; numlib-auto: 30 commits since 26 Oct 2026; all three last pushed 3 Nov 2026.
  - **tracker** (Lean executable): per-module TOML plans name the planned (key) declarations with `desc`, `deps`, `source`, `wrong`, `deprecated`; states `open`/`stated`/`proved`/`axioms`/`wrong` are read from the compiled `.olean`s; real versus suggested dependencies; `ready` modules; regressions between checks; `lint`; graph export as JSON or DOT with size metrics. Content-hash cache, never committed. Unknown plan keys are errors, so extra fields cannot be added to its TOML. It counts only declarations in the project's own modules and stops at anything outside (Mathlib, core).
  - **tracker-graph-explorer**: single-file Svelte + ELK page drawing the tracker graph (module boxes opening into declarations, proved share, wrong/extra-axiom outlines, neighbourhood cones, search, URL anchors). A CI build can bake a graph in and link each node to a **doc-gen4** site (`TRACKER_GRAPH`, `TRACKER_DOCS`).
  - **numlib-auto**: an LLM-generated library with a general **backbone** and a source-faithful **surface** ("every numbered item in a book maps to a planned declaration"; surface proofs mostly specialise backbone results). Prompts: `main.md` (orchestrator and sub-agents, git worktrees, squash merges, sub-agents may reject tasks), `plan.md` / `plan-rubrics.md`, `proof.md` / `proof-rubrics.md` (including semantic-alignment checks: quantifiers, degenerate cases, no conclusion hidden in hypotheses or structure fields), `refactor.md` (deprecate-and-migrate). Plans are reviewed by a fresh agent with little of the author's context.

- **2026-11-03 [R]** Re-check after the user said the bridgekat repositories are licensed: the GitHub API reports **no licence** for `tracker`, `tracker-graph-explorer`, `numlib-auto` and `metrics`, and none of their root directories contains a LICENSE/COPYING file. See conflict C1.
- **2026-11-03 [R]** Tau Ceti tag cadence (commit dates): `v4.34.0` 25 Sep, `v4.35.0-rc3` 26 Sep, `v4.35.0` 15 Oct, `v4.36.0-rc1` 17 Oct, `v4.36.0-rc2` 2 Nov. `main` is **7,804 commits ahead of rc1** and **450 ahead of rc2** (about one day). Tags follow Lean toolchain releases, every 2–3 weeks. Tau Ceti's README: an **hourly** dependency updater moves its Mathlib pin to the newest Mathlib master commit with a verified cache; "Downstream-reports remains external reporting and does not control these updates". Its `lakefile.toml` declares `platformIndependent = true` (cached outputs reusable across platforms).
- **2026-11-03 [R]** Prove2Me, arXiv `2608.28433v1`/`v2` (Chen, Marwaha, Lu, Yuen, Peng; 28–31 Aug 2026; arXiv non-exclusive licence, so link, do not copy), sections "Basic design" and "Multi-agent collaboration" read. Mechanisms: statements separate from proofs and **immutable** once submitted; theorem cards (description, preamble, formal statement, source, tags); pinned verification environments; **proof-sketches** that import open statements, so a parent is verified once its imported children are; **milestones**, captain-curated canonical sub-targets that stop duplicate or incompatible formalizations; **audited missions**, where humans audit only the core (goal, its definitions, milestones) and agents add unaudited intermediate lemmas freely; **sub-agent read-back**, where an independent agent sees only the Lean (not the source) and renders it as LaTeX, and the human compares that with the source statement; disproofs as proofs of the negation; a discussion channel for lessons learned.

- **2026-11-03 [R]** GLC I LaTeX source `2405.03599v3` (`functor.tex`, fetched to the session scratchpad). The de Rham conjecture (`\label{c:GLC dR}`, numbered 1.6.7 in the paper) reads in full: "The functor $\mathbb L_G$ is an equivalence." $\mathbb L_G$ is built in §1.1–1.6 (automorphic category, spectral action, vacuum Poincaré sheaf, the coarse functor $\mathbb L_{G,\mathrm{coarse}}$, then its lift to $\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$), and the lift uses Theorem `t:compact to bdd below dr`, which is proved in §2.

- **2026-11-03 [R]** GLC V LaTeX source `2409.09856v3` (`multone.tex`). Abstract: "the final paper in the series of five, in which we prove the geometric Langlands conjecture". Introduction: "we will prove the geometric Langlands conjecture (GLC) by showing that $\mathbb L_G$ is an equivalence", noting that "a version of GLC with this precise functor included appears as [GLC1, Conjecture 1.6.7]". GLC V restates it as `\label{c:GLC}`: "The functor $\mathbb L_G$ is an equivalence", for $\mathbb L_G:\mathrm{Dmod}_{1/2}(\mathrm{Bun}_G)\to\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$ as constructed in GLC I §1. The proof is not uniform: it reduces to almost simple, simply connected $G$ and treats genus 0–1 separately. GLC I Theorem 3.5.2 shows that the de Rham version implies the Betti version.
- **2026-11-03 [R]** Standing hypotheses in GLC I v3 (§0, line 717): "Let $k$ be a field of characteristic $0$. Let $X$ be a smooth and complete curve and $G$ a connected reductive group over $k$." The words "algebraically closed" do not occur in GLC I v3 or GLC V v3. Conventions "largely follow those adopted in [AGKRRV]" (GLC I); GLC V follows GLC I–IV. **This differs from the earlier reports' "algebraically closed field of characteristic 0"**; see V5.

- **2026-11-03 [R]** Codex on this computer: `codex-cli 0.164.0`, ChatGPT login (`auth_mode: chatgpt`), with a non-interactive `codex exec` mode. Its model cache (fetched 3 Nov 2026) lists **`gpt-6-astra`** ("GPT-6-Astra"). Test: `codex exec -m gpt-6-astra --sandbox read-only --skip-git-repo-check` in an empty scratch folder holding one Lean file returned a correct LaTeX read-back (4,148 tokens). The session log confirms `"model":"gpt-6-astra"` and `"sandbox_policy":{"type":"read-only"}`.

- **2026-11-03 [R]** The user's Weyl algebra (Mathlib PR 1) and itpplasma's define the same classical object; the user's is more general. Its GLC value is modest (GLC needs D-modules on stacks), and it reaches GLCinLean through Mathlib and Tau Ceti. See `reports/2026-11-03-claude-external-libraries-for-glc.md`.

- **2026-11-03 [R]** Scope of `itpplasma/algebraic-analysis` @ `22b3946` (164 Lean files, about 34,000 lines; `docs/contents.md` read, `DifferentialOperators/Basic.lean` header read). **Differential operators, ring level only:** Grothendieck's finite-order differential operators $D_k(R)$ for a commutative $k$-algebra $R$ (iterated commutators, after Stacks tag 09CH); generation by coordinate derivations; localisation; the order filtration; the symbol presentation $R[\xi]\twoheadrightarrow\mathrm{gr}\,D_k(R)$; $D_k(k[x_1,\dots,x_n])\cong A_n(k)$ in characteristic 0; for smooth $A$ in characteristic 0, $D_k(A)$ is left and right Noetherian, and simple with infinite centre for a smooth domain; projective frames ($\Omega_{R/k}$ projective). Also: Ore extensions and localisation; good filtrations, Hilbert functions, GK dimension (the Bernstein inequality is stated as a `Prop`, not proved); Goldie theory; filtered complexes; polynomial maps and Hessians. [S] for the claims, from its contents guide. **Not present:** D-modules as categories, sheaves of differential operators on schemes, holonomic modules, characteristic varieties, the de Rham functor, anything on stacks.

- **2026-11-03 [R]** itpplasma has no Mathlib PRs or upstreaming plan and builds parallel APIs to Mathlib, so its content is not expected to reach GLCinLean through Mathlib; as a direct dependency it is a later candidate (D23). See `reports/2026-11-03-claude-external-libraries-for-glc.md`.

- **2026-11-03 [R]** Codex model list (cache fetched 3 Nov 2026, `visibility: list`): `gpt-6.1-sol` "Latest workhorse model for coding and everyday work"; **`gpt-6-astra` "Frontier intelligence for the most demanding work"**; `gpt-6.1-terra`; `gpt-6-sol` "Previous generation workhorse"; `gpt-6-luna` "Fast and affordable"; older `gpt-5.6-*`. Reasoning levels: low, medium, high, xhigh, max, **ultra** (ultra not offered on the luna models). Test: `codex exec -m gpt-6-astra -c model_reasoning_effort=ultra --sandbox read-only` succeeded in 23 s (5,193 tokens); the session log confirms `"model":"gpt-6-astra"`, `"reasoning_effort":"ultra"`. Note that "newest" and "most capable" differ today: `gpt-6.1-sol` is newer, `gpt-6-astra` is the frontier model.

- **2026-11-03 [R]** This Mac: 460 GB disk with 197 GB free; 10 CPU cores; 17 GB RAM; `~/.elan` 19 GB with 4 toolchains (about 4–5 GB each); a Mathlib checkout's `.lake` 8.3 GB; `~/.cache/mathlib` 1.5 GB. The second Mac's specifications are not known.

## Decisions

### D1. Visibility: public but unannounced (2026-11-03)

- **Question:** public from day one (to use TauCetiTools) or private first? This resolves the conflict between §12.5 (keep private) and §13.2 (TauCetiTools is public-only).
- **Decision:** the repositories are **public from the start but unannounced**. During a quiet phase there is no Zulip post, no `project-intentions` entry, and no Tau Ceti claims or PRs. Agents may *read* Tau Ceti's claims to avoid collisions. The quiet phase ends at a milestone, decided separately (see D2).
- **Reasoning:** the user's reason for wanting privacy was not wanting attention while there is little meaningful work, not secrecy. In this ecosystem attention comes from deliberate signals (Zulip, intentions, upstream claims and PRs, inbound links), not from a repository being public [J]. Staying public keeps TauCetiTools available and avoids building throwaway private tooling and a later history review.
- **Rejected:** (b) private first with home-made tooling, which means duplicate tooling, no claims and a later visibility switch; (c) a private sandbox plus public work, which has the costs of both.
- **Overturns:** brainstorm §12.5 "Public vs private" (keep private while the specification is unreviewed).
- **Consequence:** during the quiet phase, work concentrates on what stays in the repository (Core, Sketch, atlas, website). Staging work for Tau Ceti may be written but is not claimed or upstreamed, so it can duplicate Tau Ceti's fleet. Mitigate by reading Tau Ceti's claims and commit log first.
- **Follow-up for planning:** a README banner ("unreviewed, agent-generated, in progress"); check that TauCetiTools setup itself does not announce anything (for example, registering with Tau Ceti services or hosted dashboards).

### D2. Ending the quiet phase: the user decides, with no preset milestone (2026-11-03)

- **Question:** which milestone ends the quiet phase (statement skeleton, first upstreamable foundation, first key definitions checked, or a date)?
- **Decision:** no preset milestone. The user alone decides when and how to announce, register intentions, claim Tau Ceti nodes or open upstream PRs, as the project develops.
- **Reasoning:** the quiet phase is about announcing, and announcing is a personal call, not a process rule.
- **Rejected:** (i) statement skeleton, (ii) first upstreamable Staging item, (iii) first key definitions checked, (iv) a backstop date; all were proposed as automatic triggers.
- **Consequence (hard rule for agents):** no agent ever makes an outward signal on its own: no Zulip post, intention, Tau Ceti claim or Tau Ceti PR. Agents may *prepare* drafts and *suggest* that a point looks like a natural moment (for example, when the statement sketch compiles or a Staging item is ready to upstream); the user acts.
- **Follow-up for planning:** put this rule in `AGENTS.md` and enforce it technically where possible (no tokens with write access to Tau Ceti or `project-intentions` in agent environments).

### D3. Repositories: two public plus one private notes repository, one local workspace (2026-11-03)

> **Superseded by D34 (2026-11-03):** one public repository `GLCinLean`; no notes or roadmap repository for now.

- **Question:** one repository (§12.1) or several (§13.4)? The user asked whether content and roadmap could be a single repository for a cleaner workspace.
- **Facts checked [R], 2026-11-03:** TauCetiTools `docs/project-setup.md` at commit `451109e` requires only a content and a roadmap repository; data, CI, claims and custom rubrics are optional extras. The roadmap is a separate Lake package depending on the content package, with separate human-owned protection, and the guide says "Do not merge the two repositories merely to avoid the dependency update." `kim-em/Arcturus` runs on exactly two repositories (`Arcturus`, `ArcturusRoadmap`), with data, CI and claims commented out in its `tauceti.toml`.
- **Decision:**
  - GitHub, public: **`GLCinLean`** (content: Lean libraries, generic `tools/`, atlas, review records, CI-built website) and **`GLCinLeanRoadmap`** (human-owned targets in Tau Ceti format).
  - GitHub, **private: a notes repository** holding `plans/`, `reports/`, `prompts/`, `references/`. It is not part of the TauCetiTools deployment, so D1 does not apply to it.
  - Locally, **one workspace folder** containing the clones of all three repositories.
  - Claims, custom-rubrics and tools repositories are added only when needed.
- **Reasoning:** a single repository is unsupported by TauCetiTools and would remove the permission split that keeps targets human-owned. The tidiness the user wants is achieved at the workspace level. The private notes repository versions the reasoning without publishing strategy reports or third-party AI assessments.
- **Rejected:** a single combined repository (unsupported by TauCetiTools); planning notes in the public content repository; planning notes local only and unversioned.
- **Overturns:** brainstorm §12.1's suggested path (monorepo first); refines §13.4 (claims repository deferred).
- **Follow-up for planning:** the workspace layout and names; whether the notes repository is a git submodule or simply a sibling clone (sibling clone suggested, as the workspace folder is not itself a repository).

### D4. Two computers: discussion here, all implementation on a second Mac (2026-11-03)

- **Position (user):** the discussion and the plan are finished on this computer. All formalisation and other work happen on another Mac afterwards.
- **Consequences [J]:**
  - Everything the second Mac needs must live in git: the three repositories of D3. Nothing may live only in this folder.
  - Claude Code's auto-memory on this machine (`~/.claude/projects/<this path>/memory/`) is tied to this computer and path, so it **will not transfer**. Durable context must go into `AGENTS.md` / `CLAUDE.md` in the repositories and into the notes repository.
  - The plan needs a **second-Mac setup checklist**: elan/Lean toolchain, `gh` login with the `workflow` scope, `uv` and the pinned TauCetiTools, Claude Code with its MCP servers (for example lean-lsp), Codex, and secrets for CI and the automation App.
- **Follow-up for planning:** the implementation plan must be executable from a fresh clone on the second Mac, with no reference to paths on this machine.

### D5. Tool split: roadmaps written with Codex by the user; formalisation with Claude (2026-11-03)

- **Position (user):** the user writes roadmap content with Codex / GPT ("GPT Astra"), in their own Codex sessions with prompts they send themselves. The formalisation agents are Claude.
- **Consequences [J]:** the roadmap is not written by an automated loop, which fits the human-owned roadmap repository of D3. Brainstorm option 4 and §8 step 6 (an automated roadmap drafter) become a manual Codex workflow, at least for now. The automated harness only needs to run Claude.
- **Open:** see "To verify" on Tau Ceti's rules for model-assisted roadmap text.

### D6. The GLC I–V papers: LaTeX source and PDF, local only, fetched by a pinned script (2026-11-03)

- **Question:** store the five papers as PDF, Markdown, JSON or several of these, and where?
- **Decision:**
  - Keep the **arXiv LaTeX source** (for agents) and the **PDF** (for the user). No Markdown conversion.
  - **Neither is committed to any GitHub repository.** They live in a git-ignored folder (suggested: `references/papers/` in the content repository's checkout).
  - A committed **fetch script plus manifest** (arXiv ID, pinned version, checksum) recreates the set on any machine (D4). It lives in the content repository, where the formalisation agents work.
  - The atlas's `source` field cites version-pinned locators, for example `2405.03599v3 §1.6, Conj. 1.6.7`. JSON or YAML is used only for this index of statements, not for whole papers.
- **Reasoning:** LaTeX keeps exact formulas, labels and numbering for agents; Markdown is a lossy copy. The papers are CC BY 4.0, so redistribution would be allowed, but the user prefers not to host them. A pinned manifest keeps the set reproducible across machines and detects new arXiv versions.
- **Rejected:** Markdown conversions; whole papers as JSON; papers committed to the public content repository or to the private notes repository.
- **Overturns:** nothing in the brainstorm. This adds a references component.
- **Follow-up for planning:** the watcher checks arXiv for new versions and agents diff the LaTeX for changed statements the atlas uses; the fetch script uses arXiv's `e-print` (source) and `pdf` endpoints with polite rate limits; provenance goes in the manifest, since the files themselves carry no header. The fetch-script location was recommended, and the user's reply ("both should not be in the public GitHub repo") was taken as accepting it; confirm when the plan is reviewed.

### D7. Budget: subscriptions only (2026-11-03)

- **Question:** subscriptions and a monthly ceiling for agent runs (§11 "Budget").
- **Decision:** all agent runs use the user's subscriptions; no pay-per-token API billing. The user considers budget unimportant and set no further ceiling.
- **Consequence:** the harness must work on subscription logins (TauCetiWorker and TauCetiReview are designed for that [S]); throughput is bounded by subscription usage limits, not money. Cost reporting (§12.5) reduces to tracking usage against those limits.
- **Follow-up for planning:** record which subscription each loop uses, and how the loops behave when a usage limit is hit (pause and resume rather than fail).

### D8. Fidelity: automated evidence throughout, outside expert review before any claim of faithfulness (2026-11-03)

- **Question:** what makes the Lean statement trustworthy, given that the user cannot assess the mathematics and Lean does not check definitions?
- **Decision:** option **(b)**:
  - **Throughout:** automated evidence. This means sanity theorems (torus case, $\mathbb P^1$, known answers), comparison lemmas against independent definitions (§12.2), and **cross-model review**: Codex/GPT reviewing Claude's definitions against the paper LaTeX.
  - **Before any claim that the statement is faithful:** an **outside expert** (a geometric representation theorist) reviews a short list of the most load-bearing definitions (about 5–10). The user decides when and whom (consistent with D2).
- **Reasoning:** a wrong key definition (for example IndCoh or the half-twist) yields a provable but meaningless statement; only human expertise can close that gap, and an expert reviewing early would conflict with the quiet phase (D1, D2).
- **Rejected:** (a) automated evidence only, never claiming faithfulness; (c) an expert from the start, which requires announcing early.
- **Consequences:**
  - The meaning of the user's `checked` tag must be written down: "read, readable, consistent with its card and the paper's wording", **not** "mathematically certified". The expert's verdict is the `reviewed` tag (refines brainstorm §6).
  - Before expert review the project may only claim "unreviewed, heavily tested", in the README and on the website.
  - Cross-model review becomes a standard step for every key definition.
- **Follow-up for planning:** the short list for expert review (a subset of the 15–25 key definitions of §6); the cross-model review procedure (Codex is run manually by the user, D5, or automated through TauCetiReview's Codex support; decide in planning).

### D9. Atlas and review records: content repository, mixed ownership (2026-11-03)

- **Question:** where do the atlas and review records live and who edits them (§13.5 "Can the blueprint/atlas live in the roadmap repository …")?
- **Facts checked [R], 2026-11-03:** in TauCetiTools `docs/project-setup.md` at `451109e`, agents may edit only the configured source scope of the content repository; other paths are made human-owned through `.github/CODEOWNERS` and need human review; "Ordinary content PRs cannot change the policy that judges their own changes."
- **Decision:** option **(a)**: everything in the content repository, with ownership by kind:
  - **Atlas nodes** (statement, source locator, dependencies, Lean name, owner/provider, hypotheses): inside the agents' source scope.
  - **Key-definition list** (`key: true`): agents may propose; the user merges (human-owned).
  - **Review records** (tags, expert verdicts, fingerprints, decision notes): human-owned through CODEOWNERS, written by a small `review` command the user runs, which stores the fingerprint automatically.
- **Reasoning:** agents keep the atlas current with the code, while only the user (or the expert through the user) can mark anything `checked`/`reviewed` or change what counts as key, which is the separation "review is a tag, not a gate" needs.
- **Rejected:** (b) the atlas in the roadmap repository (agents cannot update it, so it falls behind); (c) everything human-owned (a review PR for every atlas change bottlenecks the user).
- **Answers:** brainstorm §13.5, second question.
- **Follow-up for planning:** the exact directory split (for example `atlas/` agent-editable, `atlas/keys.yaml` and `reviews/` human-owned); the `review` command; a CI check that agent PRs never touch human-owned paths.

### D10. Adapter layer: thin, enforced by CI (2026-11-03)

- **Question:** should GLC-specific code reach its foundations through an adapter layer (§12.2)?
- **Decision:** option **(a)**: a thin `GLCinLean.Foundations` layer. Every foundational object Core uses gets a `Foundations` name, by default an `abbrev` or re-export. Wrap only where the provider's version carries a hypothesis that must be made explicit (for example `[HasKInjectiveResolutions C]`). A CI check enforces that Core imports only Foundations (and Mathlib basics). Comparison lemmas are added only when a second provider actually appears.
- **Reasoning:** Tau Ceti breaks compatibility by policy at about 800 merges a day; a thin layer confines renames and provider switches to one place and gives atlas fingerprints a stable target, at the cost of a little boilerplate.
- **Rejected:** (b) a heavy adapter with its own interfaces (speculative abstraction, real mathematical cost, drift from what providers give); (c) no adapter (upstream changes ripple through Core).
- **Confirms:** brainstorm §12.2 "Adapter layer", in its thin form.
- **Follow-up for planning:** the import-check script; whether Staging also goes through Foundations (suggested: Staging defines; Foundations re-exports Staging or upstream).

### D11. Quiet-phase work: statement first, build only unowned layers, consume owned ones (2026-11-03)

- **Question:** what do agents build while they may not claim Tau Ceti nodes or open Tau Ceti PRs (D1, D2)?
- **Decision:** option **(a)**:
  1. Full Conj. 1.6.7 statement in `Sketch` with named placeholders, plus the atlas and website, first.
  2. Staging work only on layers **no Tau Ceti roadmap covers** (as of the 2 Nov recheck: D-module categories on stacks, IndCoh, LocSys, Bun_G of a curve, the Langlands functor; re-verify in planning).
  3. Layers Tau Ceti owns (∞-categorical enhancement, stacks, reductive groups, …) stay placeholders in `Foundations` until a pin bump brings Tau Ceti's version in.
  4. The watcher re-checks ownership weekly and reclassifies layers that gain a Tau Ceti roadmap.
- **Reasoning:** statement-first gives the first meaningful milestone and the progress measure; unowned layers are where GLCinLean adds value; owned layers move too fast to duplicate usefully.
- **Rejected:** (b) also building ahead on owned layers (likely duplication of Tau Ceti's fleet); (c) statement and tooling only, with no foundational Lean work.
- **Caveat:** unowned layers rest on owned ones (D-modules on stacks need stacks), so early Staging work builds on placeholders or on what Tau Ceti has already merged.
- **Follow-up for planning:** the user also asked for a mechanism to cooperate and adapt with Tau Ceti upgrades (brainstormed below, B1).

### D12. Atlas and website basis: bridgekat tracker and tracker-graph-explorer (2026-11-03)

- **Question:** use `tracker` + `tracker-graph-explorer` (with doc-gen4) as the atlas, status and website basis, rather than a home-made YAML atlas or `leanblueprint` (brainstorm §11 first question)?
- **Decision:** option **(a)**: adopt them. GLC-specific extras that tracker's TOML does not accept (key flag, owner/provider, hypotheses, review tags, fingerprints) go in a separate file keyed by declaration id (D9). We build the definition cards and review badges on top.
- **Licence:** GitHub shows no licence file; the user has the author's permission and contributes to numlib-auto (C1, resolved). Prompts and rubrics from numlib-auto may therefore be adapted, with attribution.
- **Rejected:** (b) own YAML atlas; (c) `leanblueprint`.
- **Overturns:** brainstorm §4 "leaning YAML" and §5's home-made website (now explorer + doc-gen4 + cards).

### D13. Overall strategy: statement first, then decide how much foundation work goes into Tau Ceti (2026-11-03)

- **Question:** the user's proposal (B5): blueprint and statement first, everything else as black boxes; then use the blueprint to decide whether to do all GLC-relevant foundations inside Tau Ceti first, continuing downstream afterwards.
- **Clarification (user):** "black box" means what was already discussed: formalise the statement first, with `sorry` proofs and named placeholders (D11 step 1, B3 proof-sketches), not opaque axioms.
- **Decision:** adopted as the main plan. **Phase 1:** blueprint plus the faithful statement with placeholders. **Phase 2:** an evidence-based decision, node by node, on what to formalise inside Tau Ceti; then continue downstream. B5 amendments 1–2 (the construction of $\mathbb L_G$ stated as real definitions down to placeholders; placeholders data-only, no property axioms) are consistent with the clarification and are adopted. Amendments 3–4 (blueprint depth; phase-2 criteria) are being settled in the following questions.
- **Overturns:** D11 step 2 (Staging work on unowned layers during the quiet phase) is deferred to phase 2. Q11 / B4 (update strategy) is not yet decided and matters mainly from phase 2.

### D14. Target statement confirmed: the main theorem of GLC I–V (2026-11-03)

- **Question (user):** what is the main theorem of the five papers? That is what the user wants formalised and stated first.
- **Answer [R]:** the main theorem is GLC in the de Rham setting: **the Langlands functor $\mathbb L_G:\mathrm{Dmod}_{1/2}(\mathrm{Bun}_G)\to\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$ is an equivalence**, for $X$ a smooth complete curve and $G$ a connected reductive group over a field $k$ of characteristic 0. It is stated as GLC I Conj. 1.6.7 and GLC V `c:GLC`, and proved by GLC V using GLC I–IV.
- **Decision:** phase 1 states exactly this theorem first (as a Lean `theorem` with a `sorry` proof, since the papers prove it), with the construction of $\mathbb L_G$ from GLC I §1 as real definitions down to placeholders (D13). This confirms the existing target; nothing changes.
- **Open:** the exact field hypothesis (V5).

### D15. Phase-1 depth: shallow placeholders (2026-11-03)

- **Clarification given:** phase 1 is the statement only: the main theorem with a `sorry` proof, the $\mathbb L_G$ construction as real definitions, placeholders below, and the full natural-language blueprint. It includes **no contribution to Tau Ceti** (read-only use; quiet phase). Contributions, if the user chooses, start in phase 2.
- **Question:** where do the Lean placeholders stop?
- **Decision:** option **(i), shallow.** Placeholders sit at the level of the objects GLC I §1 names ($\mathrm{Dmod}_{1/2}(\mathrm{Bun}_G)$, $\mathrm{IndCoh}_{\mathrm{Nilp}}(\mathrm{LS}_{\check G})$, the spectral action, the Poincaré sheaf's ingredients, …). Below them the blueprint is natural language only, as input to the phase-2 decision.
- **Rejected:** (ii) deep Lean placeholders down to Mathlib and Tau Ceti (agents would guess interfaces for layers phase 2 may hand to Tau Ceti).
- **Recommended, not explicitly confirmed:** the torus case $G=T$ (GLC I §1.5) as an optional fidelity check; the phase-1 done criteria: (1) compiles on a pinned Tau Ceti commit; (2) `tracker lint` clean, every placeholder a planned declaration with a source locator; (3) no property axioms; (4) blind read-back of every definition in the $\mathbb L_G$ chain, compared by the user with the paper; (5) a natural-language blueprint below the placeholders complete enough for the phase-2 decision. Confirm at plan review.

### D16. Phase-1 agent machinery: numlib-auto style; TauCetiTools deferred to phase 2 (2026-11-03)

- **Question:** TauCetiTools from day one (§13.4), or a lighter numlib-auto-style setup for phase 1 (§11 "Which agent harness")?
- **Decision:** option **(a)**: a Claude Code orchestrator on the second Mac following adapted numlib-auto prompts (plan with tracker, one git worktree per sub-agent, squash merges, fresh-agent review), with plain GitHub CI (build, `tracker lint`, Foundations import rule, axiom check). TauCetiTools is adopted when phase 2 needs scale, parallel workers or upstreaming to Tau Ceti.
- **Reasoning:** phase 1 is small (statement, $\mathbb L_G$ chain, blueprint) and needs no fleet or Tau Ceti claims; tracker is designed for one orchestrator; TauCetiTools' setup (automation App, merge queue or Bors, branch rules, roadmap package) costs more than it gives in phase 1.
- **Rejected:** (b) TauCetiTools from day one; (c) (a) plus TauCetiReview in phase 1.
- **Revises:** brainstorm §13.4 point 1 (adopt TauCetiTools for the agent layer) is postponed to phase 2. D1 still holds (public and quiet), so later adoption stays possible. The `GLCinLeanRoadmap` repository (D3) is only needed when TauCetiTools is adopted, so it can be created in phase 2.
- **Follow-up for planning:** which numlib-auto prompts to adapt and how (backbone ≈ Staging/Foundations, surface ≈ Sketch/Core); the CI checks.

### D17. Review pipeline: tiered, blind read-backs by Claude and GPT-6-Astra; the user checks every key definition once (2026-11-03)

- **Question:** who does the blind read-back (B3), and when does the user personally check a card? The user asked for the balance between automation and correctness, and required Codex to use GPT Astra even through `codex exec`.
- **Decision:**
  - **Tiers:** (0) mechanical: build, axiom check, sanity theorems such as the torus case; (1) automatic **Claude** blind read-back on every fingerprint change of a key definition; (2) automatic **Codex `gpt-6-astra`** blind read-back via `codex exec`, run by the orchestrator, for every key definition on change; (3) a fresh **comparator** agent with the paper applies numlib-auto's semantic-alignment checklist and marks the card *agree*, *mismatch* or *models disagree*; (4) the **user**; (5) the **expert** for the short list (D8).
  - **User rule (option (a)):** the user checks **every key definition once** (about 15–25 in phase 1); afterwards only on a meaning-changing fingerprint change or a *mismatch* / *models disagree* flag. *Models disagree* goes to the top of the queue.
  - **Strict blindness:** a script extracts the declaration and its dependent definitions, with doc comments and source-hinting text stripped, into an empty directory; read-back agents run there without repository or network access.
- **Reasoning:** cross-model independence where it matters, fully automatic; one human pass per key definition keeps `checked` meaning "a person compared the statements"; disagreement between models is the cheapest signal of a subtle error.
- **Rejected:** (b) the user checks only flagged cards; (c) the user checks every card on every change; Claude-only or manual-Codex-only read-back.
- **Refines:** D5 (Codex is also used automatically, for read-back only; roadmaps stay manual) and brainstorm §6 (definition cards).
- **Follow-up for planning:** the extraction script; read-back and comparator prompts; how a meaning-changing fingerprint change is told from a cosmetic one (V7).

### D18. Phase-1 blueprint scope and author: statement blueprint plus a coarse proof blueprint, drafted by GPT Astra on the user's prompts (2026-11-03)

- **Question:** does phase 1 include a blueprint of the proof (GLC II–V), not only the statement?
- **Decision:** option **(b)**: the statement blueprint (full depth, D15) **plus a coarse proof blueprint**: one node per major result of GLC II–V (for example the FLE, ambidexterity, multiplicity one), each with the main foundations it needs, in natural language only. No proof Lean in phase 1.
- **Author (user):** the blueprint is **drafted by GPT Astra (`gpt-6-astra`) in Codex sessions the user prompts**, not by the Claude orchestrator. When the time comes, the prompt is drafted with the `prop` skill.
- **Reasoning:** the phase-2 Tau Ceti decision is about everything GLC needs, and the proof needs far more foundations than the statement; a coarse proof blueprint is cheap and reveals foundations shared by statement and proof.
- **Rejected:** (a) statement blueprint only; (c) a full proof blueprint in phase 1.
- **Revises:** numlib-auto's workflow, where the orchestrator writes the plans (D16). Here planning is done by GPT Astra and formalisation by Claude, a cross-model split like D17.
- **Follow-up for planning:** the blueprint prompt (via `prop`); the output format and review of the blueprint (next question).

### D19. Blueprint handover: GPT Astra writes tracker TOML plus a Markdown blueprint; cross-model review; flagged edits (2026-11-03)

- **Question:** what does GPT Astra deliver, and how is it checked before Claude builds on it?
- **Decision:** option **(a)**:
  - Astra writes **tracker TOML plans directly** for the Lean-level part (main theorem, $\mathbb L_G$ chain, placeholders); `tracker lint` must pass. Below the placeholders, and for the coarse proof blueprint, Astra writes a **Markdown blueprint with stable node ids** that the plans can reference.
  - **Review before formalisation:** a fresh Claude agent reviews the blueprint against the papers' LaTeX with numlib-auto's plan rubrics plus a coverage check of every numbered result GLC I §1 cites. Disagreements go to the user, who settles them by prompting Astra to revise.
  - **Later edits:** Claude sub-agents may edit plans (tracker workflow), but edits to statements or descriptions of *key* or $\mathbb L_G$-chain planned declarations are **flagged into the user's review queue**; helper and internal structure may change freely.
- **Rejected:** (b) Astra writes natural language only and Claude converts it to TOML (a translation step where meaning can drift).
- **Follow-up for planning:** a CI check that detects edits to flagged plan entries; the Markdown blueprint's schema (node id, statement, source locator, needs, classification for phase 2).

### D20. Run mode: the second Mac runs 24/7; high-autonomy local loop (2026-11-03)

- **Question:** who starts Claude's work on the second Mac: the user per session, a scheduled local loop, or cloud agents?
- **Position (user):** the second Mac runs around the clock and is never turned off; automation may be very high.
- **Decision:** a **continuous local loop** on the second Mac (option (b)), with a high degree of autonomy. Design under B6. A short supervised bootstrap (the first cycles started by hand while prompts and guards are tuned) is recommended but not yet confirmed. *Settled by D27: no supervised bootstrap.*
- **Rejected:** (a) user-started sessions only; (c) cloud scheduled agents (blindness rule D17, Codex and the Tau Ceti cache are harder off the local machine).

### D21. Blueprint revisions in the 24/7 loop: user for the initial blueprint and restructuring, the loop calls Astra for local repairs (2026-11-03)

- **Question:** D18/D19 (the user prompts Astra) conflict with a 24/7 loop (D20), which would stall on every blueprint problem.
- **Decision:** option **(b)**: the user prompts GPT Astra for the **initial blueprint and any major restructuring**. The loop calls Astra itself (`codex exec -m gpt-6-astra`) for **local revisions** (fixing a wrong planned statement, splitting a node, adding a missing intermediate node), using a standing revision prompt the user approves once (drafted with `prop`). Revisions touching key or $\mathbb L_G$-chain entries still go to the user's queue (D19).
- **Reasoning:** the user keeps authorship of the plan's shape and of everything that matters for fidelity; routine repairs do not block the loop; the planner/builder split across model families is kept.
- **Rejected:** (a) every blueprint change via the user (bottleneck); (c) the loop also writes the initial blueprint (drops D18).
- **Revises:** D18 "Author" (now: initial and major by the user's prompts, local repairs by the loop).
- **Follow-up for planning:** a precise definition of "local" versus "major" (for example: major = adds or removes a module, changes the main theorem or a key definition's statement, or changes more than N nodes).

### D22. Licence: Apache-2.0 for the public content repository (2026-11-03)

- **Question:** licence for GLCinLean and its tools (§12.5, §12.6).
- **Decision:** option **(a)**: **Apache-2.0** for everything in the public content repository (Lean, tools, atlas data, website generator). The private notes repository carries no licence. The bridgekat code keeps its own terms (used with the author's permission, C1).
- **Reasoning:** matches Tau Ceti and Mathlib, so upstreaming is a plain copy; tools stay reusable; blueprint text derived from the CC BY 4.0 papers carries attribution through its source locators.
- **Rejected:** (b) Apache-2.0 for code plus CC BY 4.0 for prose and data; (c) no licence yet.

### D23. Third-party libraries: a dependency is allowed under criteria, with the user's approval (2026-11-03)

- **Question:** may GLCinLean depend on Lean libraries other than Mathlib, Tau Ceti and the bridgekat tools (§12.6 "Rules for which external libraries may become providers")?
- **Decision:** option **(b)**: a library may become a Lake dependency when it meets the criteria and **the user approves it**. Proposed criteria: an Apache-2.0-compatible licence; active within the last 3 months; CI green on a toolchain matching the current Tau Ceti pin (or a demonstrated port); no `sorry` or non-standard axioms in the parts used; used only through `Foundations` (D10).
- **Reasoning (user's preference):** avoids copying good existing work. Cost: an extra pin to coordinate at every bump (B4).
- **Rejected:** (a) never a dependency, port only; (c) no rule.
- **Example:** itpplasma's ring-level differential operators would be a candidate once on a compatible toolchain (today `v4.35.0-rc3` versus Tau Ceti `v4.36.0-rc2`), and they overlap the open Tau Ceti roadmaps ComplexComparisonPartII C5.1 (#848) and FormalConnectionsOpers Layer 2 (#1056).
- **Follow-up for planning:** the exact criteria; what happens when a dependency falls behind Tau Ceti's toolchain (pin hold, port, or drop).

### D24. Scout agent: daily structured checks plus a weekly broad search by Claude and GPT Astra; fully automated (2026-11-03)

- **Question:** scout cadence and who runs the broad search (B7).
- **Decision:** option **(b) with (iii)**: **daily** cheap structured checks (Tau Ceti commits on watched paths, Mathlib PRs, new arXiv listings, new versions of GLC I–V) and a **weekly** broad web and GitHub search, done **independently by Claude and by GPT Astra** (`codex exec`), results merged and matched against the blueprint by Claude. **As automated as possible (user):** part of the 24/7 loop (D20), no manual steps; only *same object* / *special case* hits on key nodes reach the user's queue.
- **Rejected:** (a) everything daily; (c) everything weekly; a single-model broad search.

### D25. Codex model rule: always the most capable available OpenAI model at the highest reasoning level (2026-11-03)

- **Position (user):** every `codex exec` call (read-backs, blueprint revisions, scout) uses the usable, newest, biggest, most powerful OpenAI model with the strongest reasoning, not a hard-coded GPT Astra.
- **Decision [J on the mechanism]:** no hard-coded model name. A small resolver picks the model at run time from Codex's own model list: the listed model of the **most capable tier** ("frontier"), and the newest within that tier; reasoning effort set to the **highest level that model supports** (today `gpt-6-astra` with `ultra`, tested). The resolved model and effort are recorded with every result, so read-backs stay attributable. A user override in the config takes precedence.
- **Why tier before date:** today the newest model (`gpt-6.1-sol`) is a "workhorse", not the frontier model; "newest" alone would choose a weaker model.
- **Revises:** D17, D18, D21, D24 wherever they say GPT Astra / `gpt-6-astra`: read "the resolved most capable model".
- **Follow-up for planning:** how the resolver identifies the frontier tier robustly (description text, an explicit allow-list kept by the user, or Codex's `priority` field); how it behaves when the top model is at its usage limit (wait, rather than silently downgrade, for read-backs).

### D26. Tau Ceti update strategy: simple and on demand (2026-11-03)

- **Question (Q11, revisited after the user asked whether B4 costs more than it gives):** how GLCinLean keeps up with Tau Ceti.
- **Explanation given:** B4's purpose is to stay current cheaply enough to pick up new Tau Ceti foundations (replacing placeholders), avoid a rewrite-sized catch-up, and keep phase-2 upstreaming compatible. Drift never makes finished work wrong.
- **Decision:** option **(a)**: bump at Tau Ceti **tags** (every 2–3 weeks, toolchain-aligned), or early to a specific `main` commit **only when phase 2 needs an object that just landed**. One repair attempt per bump; on failure stay pinned and queue it for the user. **No daily bumps, canary or automatic bisection** at first; add them only if bumps keep failing. Third-party dependencies (D23) move only when compatible; otherwise the pin holds and the scout reports the lag.
- **Reasoning:** the small Foundations surface (D10), not bump frequency, controls breakage; failed repairs are the expensive part, and daily machinery mostly spends usage the formalisation loop needs.
- **Rejected:** (b) the full B4 strategy.
- **Revises:** B4 points 2, 4, 5 and B1 points 1–2 are not adopted for now. V4 (Tau Ceti cache) still matters, for build time at each bump.

### D27. Starting the loop: three fault-injection tests, then fully autonomous (2026-11-03)

- **Question:** a supervised bootstrap before the 24/7 loop (D20)? The user noted they might not catch real problems by watching, trusts Claude Code, and wants only the checks that really matter.
- **Decision:** no supervised bootstrap and no staged ramp-up. The loop starts **fully autonomous once three fault-injection tests pass**, and the tests stay in CI permanently:
  1. a planted `sorry` or property `axiom` must fail CI;
  2. **blindness:** a secret marker string placed in the repository and the papers must never appear in a read-back agent's output (Claude and Codex);
  3. **comparator sensitivity:** a definition with a deliberately swapped quantifier or dropped hypothesis must be flagged *mismatch* (D17).
- **Rejected:** (a) a human-watched bootstrap; a staged ramp-up with an auditor; tests for human-owned paths, loop detection, and network access to Tau Ceti or Zulip.
- **Clarification (user), refining D2:** **reading** Tau Ceti, Zulip and the web is allowed and necessary (the scout, D24, depends on it). D2 forbids only **outward signals**: posting, claiming, opening PRs, registering intentions. The earlier wording "no tokens with write access to Tau Ceti or `project-intentions`" stays as a technical safeguard for writes only.
- **Revises:** B6 point 5 (no-progress detection) is kept as a runtime guard but not tested up front.

### D28. Phase-1 finish line confirmed, with the torus check; no Tau Ceti PR in phase 1 (2026-11-03)

- **Decision:** the five D15 done criteria are **confirmed**, and the **torus case $G=T$** (GLC I §1.5) is **added** as a stated sanity theorem:
  1. the main theorem compiles on a pinned Tau Ceti commit (proof `sorry`);
  2. `tracker lint` clean, every placeholder a planned declaration with a source locator;
  3. no property axioms;
  4. every definition in the $\mathbb L_G$ chain has passed D17 (both read-backs, comparator, the user's one-time check);
  5. the blueprint below the placeholders plus the coarse proof blueprint (D18) is complete enough to classify every node for phase 2;
  6. the torus case is stated (proof may be `sorry`) and passes the same review.
- **Clarification (user asked whether phase 1 ends with a Tau Ceti PR of the statement):** **no.** Phase 1 sends nothing to Tau Ceti. The GLC statement is frontier mathematics, which Tau Ceti's README says belongs in independent downstream projects, so it stays in GLCinLean permanently. Only foundational material may go to Tau Ceti, in phase 2, if the user chooses (D13). Publishing the statement elsewhere (for example in formal-conjectures, an option in the earlier reports) is a later decision for the user and an outward signal (D2).

### D29. Phase-2 criteria and key definitions: decide the data and the rule now, the details later (2026-11-03)

- **Clarification given:** "compiles on a pinned Tau Ceti commit" means GLCinLean's own Lean files type-check against one fixed Tau Ceti commit used as a library dependency (as one uses Mathlib); no PR is involved.
- **Decision, phase-2 criteria (B5 amendment 4):** the blueprint (D18, D19) records for **every node**: *foundational or frontier*; *which Tau Ceti roadmap covers it, if any*; *estimated size*; *needed by the statement, the proof, or both*. The **rules** deciding what goes to Tau Ceti are **parked until phase 1 ends** (P2).
- **Decision, key definitions (§6, §11):** **rule:** every definition in the $\mathbb L_G$ chain plus every placeholder object named in GLC I §1 is key; anything else becomes key only with the user's approval (D9). The list itself is generated from the blueprint. The outside expert stays parked (P1).
- **Rejected:** parking both items entirely; fixing the phase-2 rules now.

### D30. Goal hierarchy: the statement with every definition real, then the proof (2026-11-03)

- **User's goal:** "The first goal is the statement of GLC, that all the definitions of that statement has been formalised to really faithfully express the statement. Next step, is the formalisation of the whole proof."
- **Decision (user accepted the proposed structure):**
  - **Goal 1a:** phase 1 exactly as in D15, D28 and D29 (skeleton, placeholders, nothing sent to Tau Ceti). Unchanged.
  - **Goal 1b:** every placeholder replaced by a real definition, so the statement is fully faithful. The Tau Ceti choices (P2) are made here.
  - **Checkpoint, not a gate:** when goal 1b is done, with the key definitions reviewed (D17) and the torus case *proved*, the loop pauses and notifies the user, who decides whether and when to start the proof (with or without outside expert review, P1). This keeps D8: review is a tag the user weighs, never an automatic gate.
  - **Goal 2:** the full proof.
- **Rejected:** expert approval as a hard gate before the proof.

### D31. Automatic cleaning may delete other inactive projects' build folders (2026-11-03)

- **Decision (user chose the alternative):** when cleaning inside GLCinLean (B8.5, steps before the last) is not enough, the loop may **automatically** delete the `.lake` build folders of other Lean projects untouched for **N days (default 30; the exact value set at Mac setup, V8)**, except projects on a user-maintained **never-touch list**. Only `.lake` folders: never sources, git history or uncommitted work. Each deletion is logged with project, size and date, and reported to the user.
- **Rejected:** asking the user before touching other projects.

### D32. Adopt automatic throttling while the user is active (2026-11-03)

- **Decision:** use the modes of B8.7 (`full`, `shared`, `pause`, `auto`, with `auto` the default), switched by input idle time, plus a local manual override command or menu-bar or Shortcuts button. No control from the public website. The numbers (threads per mode, idle timeout, agent caps) are set at Mac setup (V8).

### D33. Notes repository, AGENTS.md and where the plan is written (2026-11-03)

- **Decision:** this workspace becomes the private notes repository of D3, named **`GLCinLeanNotes`**, and moves to the Mac mini through git. The implementation plan (`prompts/2026-11-02-synthesise-feasible-plan.md`) is drafted and committed on the discussion Mac; everything after it runs on the Mac mini.
- **`AGENTS.md` only, no `CLAUDE.md`:** Claude Code reads `AGENTS.md` when no `CLAUDE.md` exists [R, tested 2026-11-03 with Claude Code 2.1.317 in an empty folder; S, support added in 2.1.277]; Codex reads it natively. It is written now, kept light (standing rules only); the content repositories get their own on the Mac mini.
- **Source builds:** a preference, not a rule: prefer `lake exe cache get` to building Mathlib from source. A hard ban would block cases where no cache exists (Tau Ceti's cache is open item V4).
- **Constraints dropped from the prompt as unnecessary (user's judgement):** "do not post publicly or register intentions" and "do not create the real GLCinLean repository". D2 still governs outward signals.

### D34. One repository from the start: `GLCinLean`, to become public (2026-11-03)

- **Decision (user):** a single repository **`GLCinLean`** from the start, holding the planning material now and the Lean code, blueprint and roadmap later. The user wants it public now. **Amends D3 and D33:** no separate notes repository and no `GLCinLeanRoadmap`. The private-notes repository is dropped (it was renamed from `GLCinLeanNotes` to `GLCinLean` on 2026-11-03, still private until the archive question below is settled).
- **Consequence:** if phase 2 adopts TauCetiTools (D16), which needs a separate roadmap package, the roadmap folder is split out then (`git subtree split`). Human ownership of the roadmap and key-definition files in phase 1 comes from `CODEOWNERS` and branch protection (D9).
- **Archive (user chose option 1):** `archive/` (third-party AI assessments; reports with judgements about other people's projects and a named individual) stays out of the public repository. It was moved to a git-ignored `private/archive/` on the discussion Mac and the initial commit was rewritten so it never appears in public history. An Apache-2.0 `LICENSE` (D22) was added; files in `references/` keep their own licences.
- **Not a strict rule (user, 2026-11-03):** one repository is the starting point, not a constraint. Once finished, the review, key-definition and blueprint system can become a separate repository of its own (the user said "a single private" one), reusable for other projects, as numlib-auto uses tracker and the graph explorer as separate tools.

### D35. Make the review, key-definition and blueprint system reusable (2026-11-03)

- **User's aim:** once finished, the review and key-definition system combined with the blueprint system can become a repository of its own, adaptable to other projects, as numlib-auto uses tracker and the graph explorer.
- **Decision:** adopt brainstorm §12.3 ("generic tools from day one"), which no earlier decision had settled:
  - **Generic part** (no GLC-specific code): the `review` command and fingerprints (D9, V7), definition cards and badges on the explorer (D12), the blind read-back harness and comparator (D17), the Foundations-boundary CI check parameterised by namespace (D10), the fault-injection tests (D27), the Codex model resolver (D25), the dependency-bump repair step (D26), and the prompt templates for blueprint drafting, read-backs, the orchestrator and the scout (D18, D19, D21, D24).
  - **GLC-specific part**, in one project config plus data: papers manifest (D6), target statement (D14), key-definition rule (D29), atlas data, key list and review records (D9), Tau Ceti pin, scout sources.
  - **Machine-level settings** (D31 never-touch list and inactivity days, D32 modes, B8 thresholds) belong to the Mac mini, not to either part.
  - **Interface:** a documented, versioned data format (brainstorm §12.1) for the extras file beside tracker's TOML (D12) and the review records. Splitting out the system later is then a mechanical move.
  - tracker and tracker-graph-explorer stay **external dependencies**, not vendored; adapted numlib-auto prompts carry attribution (C1).
- **Files changed now:** only `prompts/2026-11-02-synthesise-feasible-plan.md` (one sentence asking the plan to keep the system separate). `AGENTS.md` gets a "no project-specific code in the system folder" rule once that folder exists on the Mac mini.
- **Conflict found:** the user wrote that the separated system could be "a single private" repository. A public `GLCinLean` whose CI and website depend on a **private** repository cannot fetch it without a secret, and nobody outside could rebuild the site. Open as P3.
- **Resolved (user, 2026-11-03, option 1):** the system is **public from the start**: it begins as a folder inside public `GLCinLean` and becomes its own public repository once its data format settles. P3 closed.

### D36. Prompt review by the user's principle: scope kept, plan written on the Mac mini (2026-11-03)

- **Principle (user):** "Before acting, figure out what I really want to achieve, not just the approach I described. If my plan looks like a detour, first point out the more fundamental approach and ask me whether I have the conditions for it. If I confirm I don't have the conditions or insist on the original plan, then carry out the original plan carefully. A plan that eliminates steps takes priority over a plan that automates cumbersome steps."
- **Detour 1, raised:** planning the full machinery before goal 1a, which is small (D16). **User:** the reusable system is a goal in itself (D35), so the full scope stays.
- **Detour 2, raised:** feasibility tests on the discussion Mac would be repeated on the Mac mini (Tau Ceti build and cache, V4; `codex exec`, V6; hardware, V8). **User:** the Mac mini becomes usable today. **Decision:** the plan prompt runs on the Mac mini, which also measures itself and proposes the V8 settings. **Revises D33** ("drafted on the discussion Mac").
- **Review endpoint (user, option 1):** the review session raises findings with the user one at a time; once agreed, it revises the plan file, commits and pushes. No separate fixing session.
- **Start prompt (user, option 1):** the plan ends with a ready-to-run prompt for the first implementation session, reviewed with the rest of the plan.
- **Not in `AGENTS.md`:** the principle includes "ask me first", which would stall the 24/7 loop (D20). It goes only in prompts the user runs interactively.

### D37. One private companion repository, cloned into `private/` (2026-11-03)

- **Decision (user, option 1):** a private repository **`GLCinLeanPrivate`** (https://github.com/WHY-Op109/GLCinLeanPrivate, created 2026-11-03), cloned into the git-ignored `private/` folder of the `GLCinLean` checkout. It holds `archive/` (the October reports and AI assessments, now backed up and reachable from the Mac mini), `scout/` (scout reports, B7.4) and `permissions/` (the bridgekat author's permission, C1). The **escalation queue** (B6.4) stays in the public repository as plain files, not GitHub issues.
- **Revises:** B6.4 and B7.4 ("notes repository"), C1's follow-up, D34 (the one exception to a single repository).
- **Rejected:** local-only `private/` on the Mac mini; everything public.

## Conflicts

- **C1 (2026-11-03): bridgekat licences. Resolved the same day [S, user]:** the user has the author's permission to use `tracker`, `tracker-graph-explorer`, `numlib-auto` and `metrics`, and is a contributor to numlib-auto. Follow-up: record the permission in writing (for example an issue comment or email, quoted with date in the notes repository) and a provenance note in GLCinLean, since the public repository will depend on unlicensed code; a licence file upstream (numlib-auto's pending Apache-2.0) would remove the need. Original finding: The user says the repositories are licensed; GitHub reports no licence and no licence file in any of the four, and numlib-auto's README says a move to Apache-2.0 is pending. Until resolved: read and borrow ideas only; no copying of code or prompts, and no public dependency. Ask the user where the licence is stated (for example a written permission or another branch).

## Ideas

### B1. Brainstorm: cooperating with and adapting to Tau Ceti upgrades (2026-11-03, open)

Raised by the user with D11. Options, which can combine:
1. **Pinned weekly bump (brainstorm §3, §12.2).** Try the newest Tau Ceti tag on a branch; a repair agent fixes breakages in Foundations first; merge on green; log in `DEPENDENCIES.md`. Tags are toolchain-aligned (`v4.36.0-rc2`, 3 Nov), so a bump is also a toolchain bump.
2. **Early-warning canary.** A nightly CI job builds GLCinLean against Tau Ceti `main` (not the tag), never merged, only reporting what would break. Breakage is then seen in small daily pieces instead of one large weekly diff.
3. **Upstream-change feed (watcher).** For each Tau Ceti path Foundations re-exports, run `git log` since the pinned commit and list renames, deprecations and new declarations matching placeholder names. This turns "a provider appeared for a placeholder" into an automatic suggestion (§12.2 provider field).
4. **Placeholder-to-upstream switch.** When Tau Ceti merges an object GLCinLean has as a placeholder or a Staging copy, the agent replaces it in Foundations (one file, D10), runs the impact check (§7), and the old review tag resets (fingerprints).
5. **Deprecation-aware migration.** Tau Ceti and Mathlib use `@[deprecated]` aliases; the bump agent migrates to the new names while the aliases still exist, rather than waiting for removal.
6. **Cooperation after the quiet phase (user's call, D2).** Upstream Staging work in Tau Ceti's format, so Tau Ceti carries the maintenance burden of foundations from then on; this is the real long-term cooperation.

### B2. Brainstorm: reuse of bridgekat tracker, graph explorer and numlib-auto (2026-11-03, open)

Raised by the user. Findings in "Facts checked".
- **tracker could replace the home-made atlas status layer.** Its TOML plans plus build-derived states cover most of brainstorm §4 (nodes, desc, source, deps, status from the build, regressions, `ready`). The GLC-specific extras (key flag, owner/provider, hypotheses, review tags, fingerprints) cannot go into tracker TOML (unknown keys are errors), so they would live in a separate file keyed by declaration id. That is exactly D9's split: tracker plans agent-editable, `reviews/` human-owned.
- **The thin Foundations layer (D10) makes Tau Ceti objects visible to tracker**, which only counts the project's own declarations: an `abbrev` in Foundations is a project declaration.
- **tracker-graph-explorer plus doc-gen4** gives the interactive dependency graph and Lean-documentation-style pages the user wants (§5) with little new code. Natural-language comments come from doc comments and plan `desc`. The definition cards and review badges of §6 are what would be added.
- **numlib-auto's backbone/surface split maps onto GLCinLean:** backbone ≈ Staging + Foundations (general foundations), surface ≈ Sketch/Core (the faithful statements of GLC I–V, numbered items as planned declarations). Its prompts and rubrics, especially the semantic-alignment checks and the fresh-agent review, fit D8's automated evidence.
- **Licence blocker:** none of the three repositories has a licence. Reading them and taking ideas is fine; copying code or prompts, or depending on tracker as a submodule in a public repository, should wait for a licence (numlib-auto says Apache-2.0 is pending) or the author's permission. Asking the author is an outward contact, so it is the user's call (D2).
- **Overlap with TauCetiTools:** TauCetiProgress also derives status from compiled data; tracker is lighter and closer to the atlas. Both could run. To decide in planning.


### B3. Brainstorm: Prove2Me's human-collaboration design applied to agents (2026-11-03, open)

The user's idea: Prove2Me organises many *humans with agents*; read its roles as roles for *sub-agents*. Mapping [J]:

| Prove2Me | GLCinLean |
|---|---|
| Captain (proposes a mission, audits its core) | The user |
| Mission core: goal, its definitions, milestones (human-audited) | Conj. 1.6.7 + the key definitions (D8, D9) + tracker planned declarations |
| Unaudited intermediate lemmas | Everything not planned/key; agents add freely |
| Milestones: canonical, idempotent targets | tracker planned declarations with fixed ids; prevents two sub-agents formalising the same thing differently |
| Proof-sketch importing open statements | `Sketch` with placeholders; tracker `stated` nodes; "parent verified once children are" is the tracker's dependency rule |
| Immutable statements | Audited statements are protected: fingerprint + CODEOWNERS; changing one is a new review (§7) |
| Moderator | Orchestrator agent |
| Contributors | Worker sub-agents in their own worktrees (numlib-auto `main.md`) |
| Read-back auditor | An independent agent, ideally Codex (cross-model), given only the Lean |
| Disproof | A sub-agent may mark a planned declaration `wrong` only with a Lean proof of its negation or a recorded counterexample |
| Discussion channel | A committed `notes/lessons.md` (or tracker module `desc`) where agents record findings for later agents |
| Search before submit | Agents search Mathlib/Tau Ceti/project (LeanSearch, `lean_local_search`) before adding a declaration |

**Most valuable import: read-back auditing.** The user cannot read Lean or fully judge the mathematics, but can compare two LaTeX statements. A blind read-back (agent sees only Lean, renders LaTeX with every binder and hypothesis explicit) beside the paper's LaTeX makes the `checked` tag meaningful and gives the expert (D8) a fast review format. It would be the core of the definition card (§6).

**What does not transfer:** decentralised submission without git (we use git and worktrees); credit and incentives; per-statement isolated environments (we have one pinned build).

### B4. Brainstorm: keeping up with Tau Ceti's pace (2026-11-03, open; revises B1)

The user doubted that B1 copes with Tau Ceti's speed. Measurements above: tags every 2–3 weeks, about 7,000+ commits between tags, about 450 a day on `main`, Mathlib pin moved hourly. So **B1's "weekly tag bump" is wrong in its premise**: there is no weekly tag, and a tag-to-tag bump spans thousands of commits. Revised ideas [J]:
1. **Breakage scales with what we import, not with Tau Ceti's commit count.** Only Foundations imports Tau Ceti (D10). Track a "Tau Ceti surface" metric: the number of Tau Ceti declarations Foundations uses, and the commits touching their files per day. Keep it small.
2. **Pin to a `main` commit SHA, not a tag, and bump often in small steps** (daily, or several times a day), so each repair is small. Lake accepts any commit as `rev`.
3. **This needs a downloadable build cache for Tau Ceti commits.** Building Tau Ceti from source at every bump is probably infeasible on one Mac [E]. Only bump to commits whose cache is available. Must verify (V4).
4. **Automatic bisection.** When a bump breaks, find the first bad Tau Ceti commit, so the repair agent sees one small diff.
5. **Canary on `main`** (B1.2) stays, as the early warning.
6. **Pins are optional maintenance, not correctness.** As in Prove2Me's pinned environments, a statement proved against a pinned Tau Ceti commit stays valid at that commit. If bumping is too expensive for a while, stay pinned; nothing already done becomes wrong.
7. **Long term: upstream** (after the quiet phase, D2). Foundations inside Tau Ceti are repaired by Tau Ceti's own fleet. Tau Ceti also runs "downstream-reports"; being listed would be an outward signal, so it is the user's call.

### B5. Evaluation: blueprint and statement first, black boxes, then decide how much to do inside Tau Ceti (2026-11-03, proposed by the user)

**Proposal:** (1) draft the whole blueprint; formalise only the statement, treating everything else as black boxes; (2) using the blueprint, evaluate whether to formalise all GLC-relevant foundations inside Tau Ceti first; (3) then continue downstream from Tau Ceti for the rest.

**Assessment [J]: sound, and better than D11 as it stands, with four amendments.**

Strengths:
- It is Prove2Me's mission-core model and numlib-auto's plan-then-prove order: the blueprint is the plan, the statement is the audited core.
- It turns the Tau Ceti question into an evidence-based decision: the blueprint lists every foundation node, so each can be classified (already in Mathlib/Tau Ceti, on a Tau Ceti roadmap, foundational but unowned, frontier).
- During phase 1 the Tau Ceti surface is almost empty, so Tau Ceti's pace (B4) barely matters until the decision.
- Doing foundations inside Tau Ceti matches Tau Ceti's own stated split (README "Collaboration": foundational material in Tau Ceti, frontier results as independent downstream projects), and Tau Ceti's fleet then maintains them.

Amendments:
1. **The statement cannot black-box $\mathbb L_G$.** Conj. 1.6.7 is literally "$\mathbb L_G$ is an equivalence". With $\mathbb L_G$ an opaque constant the Lean statement is "some unspecified functor is an equivalence", which has no content and cannot be reviewed. The **definition chain down to $\mathbb L_G$** (the §1.1–1.6 construction) must be stated as real definitions in terms of lower ingredients. Black boxes are allowed *below* that chain (D-modules, IndCoh, Bun_G, LocSys, stable ∞-categories) and for *proofs*.
2. **How to black-box safely.** Proofs: `sorry` (tracker state `stated`). Missing objects: data-only placeholders (`opaque`, or a structure with named fields), **never `axiom`s asserting properties**, which can make the theory inconsistent and every statement trivially true. Theorems used inside definitions (like `t:compact to bdd below dr` for the lift) are `sorry`'d theorems, so $\mathbb L_G$ is `stated`, not `proved`. Each placeholder is a tracker planned declaration with source and description, so it is visible on the website.
3. **Blueprint depth.** Full depth for the statement's dependency tree, down to what Mathlib and Tau Ceti already have. For the proof (GLC II–V), a coarse blueprint first (paper-level milestones), refined later; a full proof blueprint of five long papers is months of agent work [E] and would be speculative before the statement layer settles.
4. **Fix the phase-2 decision criteria now.** For each foundation node: does Tau Ceti count it as foundational ("what graduate students in the area would know")? Does a Tau Ceti roadmap cover it, or would one be needed (written by the user with Codex, D5, subject to V3)? How large is it? It also requires ending the quiet phase for that work (D2): contributing to Tau Ceti means claims and PRs.

Effects on earlier decisions: D11 step 2 (Staging work on unowned layers during the quiet phase) is deferred until the phase-2 decision; B4 (update strategy) matters mainly from phase 2 on.

Fidelity caveat: with black boxes below $\mathbb L_G$, the read-back review (B3) can check the *shape* of the construction against GLC I §1, but key definitions such as $\mathrm{IndCoh}_{\mathrm{Nilp}}$ or $\mathrm{Dmod}_{1/2}(\mathrm{Bun}_G)$ cannot be reviewed until they are real. The statement is "faithful modulo named placeholders" until then.

### B6. Brainstorm: a 24/7 high-autonomy loop (2026-11-03, open)

1. **Supervision:** a `launchd` agent keeps the orchestrator running; a watchdog restarts it on crash or stall (no heartbeat for N minutes); power settings stop sleep; it survives macOS updates and reboots (auto-login, or a LaunchDaemon).
2. **Usage-limit awareness:** both subscriptions (Claude, ChatGPT/Codex) have rolling limits. The loop reads limit errors, sleeps until the reset, and resumes; work is checkpointed in git, so nothing is lost.
3. **Merge policy:** agents work on branches and open PRs; **auto-merge on green CI** (build, `tracker lint`, import rule, axiom check, no new flagged-entry edits without approval). `main` protected; no force-push; the user can revert any merge.
4. **Escalation queue:** anything needing the user (models disagree, flagged plan edits, repeated failures, blueprint conflicts) goes into one queue, and the loop works on other ready nodes meanwhile. The queue lives in the private notes repository or local files, not public issues, to keep the quiet phase quiet.
5. **No-progress detection:** each cycle compares `tracker status` with the last; a node failing K attempts is marked blocked with a report and escalated; a cycle making no progress for a set time pauses the loop and notifies.
6. **Stop switch and notifications:** a `STOP` file or GitHub label halts the loop at the next checkpoint; a daily digest (progress bars, merges, queue length, usage), and an immediate notice on stop or blocking events.
7. **Safety boundaries:** tokens scoped to the GLCinLean repositories only; no write access to Tau Ceti, `project-intentions` or Zulip (D2); read-backs isolated (D17, V6); prompts, CI and policy files human-owned through CODEOWNERS, so agents can propose but not merge changes to their own rules.
8. **Remote oversight:** the user watches from this Mac or a phone through GitHub, the digest, and Claude Code remote access to the second Mac's sessions.
9. **Phase 2 additions:** pin bumps and bisection (B4), and TauCetiTools when adopted (D16).

### B7. Brainstorm: a scout agent searching online for relevant material (2026-11-03, raised by the user)

Extends brainstorm option 1 (watcher), which covered Tau Ceti, Mathlib and arXiv.
1. **Sources:** Tau Ceti (commits on watched paths, roadmap PRs, claims); Mathlib PRs; GitHub code search for Lean files with blueprint keywords (`DModule`, `IndCoh`, `LocSys`, `Bun`, `AlgebraicStack`, …); Lake package indexes (Reservoir, Lean Pool); `project-intentions`; formal-conjectures; Prove2Me's searchable theorem corpus; arXiv new listings (math.AG, math.RT, and Lean-related cs.LO); the public Lean Zulip archive; new arXiv versions of GLC I–V (D6).
2. **Query source:** generated from the blueprint. Each node's names, keywords and natural-language statement become queries, so the search follows the project as it grows.
3. **Triage:** each hit is matched to blueprint nodes and classified as *same object*, *special case*, *prerequisite* or *related*, with licence, toolchain, activity and sorry/axiom status (the D23 criteria).
4. **Outputs:** a dated report in the notes repository; new provider candidates in the watchlist; only *same object* or *special case* hits for key nodes go to the user's queue; everything else goes in the digest.
5. **Safety (reinforced 3 Nov after a prompt-injection attempt was seen in a GitHub page during research):** fetched pages and downloaded code are untrusted data, never instructions; downloaded code is untrusted: it is read in an isolated directory, built only in a sandbox, never executed in the main environment. The scout never contacts anyone (D2).
6. **Cadence options:** daily structured checks (Tau Ceti, Mathlib, arXiv: cheap, API-based) plus a weekly broad web and GitHub search with model triage (expensive, noisier).

### B8. Brainstorm: storage and keeping the Mac usable during formalisation (2026-11-03, raised by the user)

User's notes: the formalisation Mac normally has 50–100 GB free; the user wants to keep using the Mac smoothly; formalisation should be as fast as possible; never build Mathlib from source, always use `lake exe cache get`; warn, and clean automatically when storage gets low enough to affect progress.
1. **What uses storage [R/E]:** Lean toolchains (about 4–5 GB each, accumulating over bumps); a Mathlib dependency's `.lake` (about 8 GB per checkout); Tau Ceti's build outputs on top (size unknown, V4); and, the largest risk, **one `.lake` per sub-agent git worktree**, which multiplies everything by the number of parallel agents.
2. **Avoiding the multiplication:** share one dependency build across worktrees (symlinked `.lake/packages`, or Lake's shared artifact cache if the toolchain supports it, to verify); cap concurrent worktrees; delete a worktree and its `.lake` as soon as its work is merged.
3. **Never build Mathlib (or Tau Ceti) from source:** always `lake exe cache get` (Mathlib) or Tau Ceti's cache (V4); a guard aborts a build that starts compiling Mathlib modules. *Revised by D33: a preference, not a ban, and no abort guard.*
4. **Thresholds (proposal):** warn below 40 GB free; clean automatically below 25 GB; pause the loop below 10 GB and notify.
5. **What automatic cleaning may delete (proposal):** only **rebuildable** artefacts, in this order: finished worktrees; stale GLCinLean build outputs; toolchains no project references (`elan toolchain gc`); old Mathlib cache archives; scratch directories; then the `.lake` directories of **other, inactive** Lean projects (untouched for N days). Never source files, git history, uncommitted work, papers or notes.
6. **Keeping the Mac responsive:** run builds and agents at background priority (macOS `taskpolicy -b` / `nice`); detect when the user is active (input idle time) and then cap Lean threads and parallel agents; run at full speed when idle; watch memory pressure (Lean with Mathlib uses several GB per process).

7. **Feasibility check of "throttle while the user is active" (2026-11-03) [R on this Mac, S for Lake]:** not hard. Pieces:
   - *Detecting activity:* `ioreg -c IOHIDSystem` reports `HIDIdleTime`, the time since the last keyboard or mouse input [R, works here]. A launchd agent can poll it every ~30 s.
   - *Thread control for new builds:* `lean` has `-j/--threads` [R]; `lake` has no `-j` flag [R, `lake --help`]; Lake and Lean honour the environment variable `LEAN_NUM_THREADS` [S, Lean Zulip, Oct 2024; recheck on the pinned toolchain].
   - *Already-running processes:* thread counts cannot change mid-build, but `taskpolicy -b -p <pid>` / `-B -p <pid>` moves a running process into or out of background mode [R, this Mac's `taskpolicy` usage]. Background mode on Apple Silicon runs on efficiency cores only and slows disk access, so use it only while the user is active, not permanently.
   - *Proposed modes:* `full` (idle >5 min: all cores, maximum agents), `shared` (user active: running work in background mode, new builds with fewer threads, no new parallel agents), `pause` (stop starting work; optionally suspend), `auto` (switch between full and shared by idle time; the default).
   - *Manual override:* a local command (e.g. `glc-mode shared`) or a menu-bar or Shortcuts button that writes the mode file. **Not a button on the project website:** the site is a public static page and cannot safely control the Mac; adding a local web server for it brings risk for little gain.

## Parked questions

- **P2 (from D29), 2026-11-03:** the rules for which foundation nodes are formalised inside Tau Ceti in phase 2. Parked until phase 1 ends, so they can be set with the blueprint's real node data. Draft starting point: B5 amendment 4.
- **P1 (from D8), 2026-11-03:** who the outside expert is, and how to find one. Not answered; left until expert review approaches. The user decides (D2).
- **P3 (from D35), 2026-11-03:** closed the same day: public, a folder first, split later (D35).

## To verify when planning

- **V1 (from Q3):** whether TauCetiWorker leases need a separate claims repository even with a single worker.
- **V2 (from D1):** that TauCetiTools setup and its optional services do not announce the project (no automatic registration with Tau Ceti services or listings).
- **V4 (from B4):** whether Tau Ceti publishes a downloadable build cache per `main` commit (or per tag) usable by downstream projects, and how long a cold build of the needed Tau Ceti modules takes on the second Mac.
- **V5 (from D14):** the field hypothesis. GLC I v3 says only "a field of characteristic 0" and defers to AGKRRV (arXiv 2010.01906) for conventions; earlier reports said "algebraically closed". Read AGKRRV's conventions (and GR's book if cited) for whether $k$ is algebraically closed, whether $X$ is connected, and similar silent assumptions. Stating the theorem over algebraically closed $k$ is weaker but safe; the faithful version follows the papers' actual conventions.
- **V6 (from D17):** on the second Mac: `codex exec -m gpt-6-astra` with the ChatGPT login, its usage limits, and the real isolation of `--sandbox read-only` (it blocks writes; check whether it can still *read* the repository or papers elsewhere on disk, and whether network is off). If reads are not confined, run read-backs as a separate macOS user or in a container holding only the extracted slice. The same for the Claude read-back agent.
- **V7 (from D17):** separating cosmetic from meaning-changing fingerprint changes (for example, hash the elaborated type and value after unfolding the project's own abbreviations, ignoring names and doc comments).
- **V3 (from D5):** Tau Ceti's rules on model-assisted roadmap text. The brainstorm (§1) says Tau Ceti roadmap PR text must be in the user's own words. A Codex-written roadmap in `GLCinLeanRoadmap` is the user's own business, but sending it to Tau Ceti may need rewriting. Check the roadmap repository's `CONTRIBUTING`.
- **V8 (from B8), 2026-11-03:** the formalisation Mac is a base-model Mac mini M4 (Apple's base configuration: 10-core CPU, 4 performance + 6 efficiency cores, 16 GB memory, 256 GB SSD [S, Apple specs; confirm on the machine]). **User's decision:** machine-specific settings are fixed when the start-up prompt first runs on that Mac, not now. These include the number of parallel agents and worktrees, `LEAN_NUM_THREADS` per mode, the idle timeout, and the storage thresholds (B8.4, B8.7). The start-up prompt must measure the hardware, free disk, Tau Ceti's build size (V4) and the memory one Lean worker uses, and then propose values to the user. Expectation [J]: with 16 GB, about 2 parallel Lean workers.
- **V9 (from D18, D21), 2026-11-03 [R]:** the user's skills live on the discussion Mac only. `prop` (used for the blueprint and revision prompts, D18, D21) is the git repository `WHY-Op109/prop`, cloned at `~/.codex/skills/prop` and symlinked into `~/.claude/skills/prop`. `grilling` is a plain local folder in `~/.claude/skills/`. The Mac mini setup must clone `prop` and copy `grilling` the same way, or those prompts cannot be drafted there.
