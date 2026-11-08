# Step 0 research: summary

- **What this is.** The summary that `prompts/research.md` asks for. It feeds step 1 of [`notes/workflow.md`](../workflow.md). It draws only on the 40 notes listed in §1; each claim names the note it comes from, where the evidence and the exact sources are.
- **Tags.** [R] the note read it directly; [S] a source's claim about itself; [E] estimate; [J] judgement (in this summary, mostly a judgement that weighs several notes). All tags are dated **2026-11-08**, the day every note was written and checked.
- **How to read it.** §2 says what changes in the plan; §3 lists the contradictions; §4 gives a recommendation for each open question in `workflow.md`; §5 lists references found but not read; §6 holds the questions only you can answer, each with options and a recommended option.

---

## 1. The notes

**References named in `notes/ideas.md`**

- [xena-blog.md](xena-blog.md): the ten values match the post word for word; the post argues for library-first, AI work that others can build on, and auditable projects (Palomar, `formalization.yaml`, comparator).
- [mathlib-doc-style.md](mathlib-doc-style.md): what "Mathlib's documentation style" requires (header, `module`, `/-!` docstring, docstrings, BibTeX citations); the current files fail it.
- [mathlib-style-guide.md](mathlib-style-guide.md): style guide, naming and review guide; the `ideas.md` link points to an older copy; which linters run where.
- [mathlib-coverage.md](mathlib-coverage.md): what Mathlib has for GLC (curve hypotheses, root data, 1-categorical derived categories) and what it lacks (stacks, ∞-categories, D-modules).
- [tauceti-library.md](tauceti-library.md): Tau Ceti has the base data (reductive groups, pinnings, curves, line bundles, ω_X), and none of the objects on the GLC surface.
- [tauceti-roadmaps.md](tauceti-roadmaps.md): no merged roadmap owns the GLC backbone; the nearest specifications are open roadmap PRs; a roadmap needs a human who has read it.
- [stacks.md](stacks.md): AxiomMath/Stacks is large, mostly AI-written and unreviewed, a Lean release behind, with no cache; usable only as a read-only reference.
- [tauceti-review.md](tauceti-review.md): ten adversarial AI rubrics per PR; reusable as a standard after adaptation; its correctness rubric would block placeholders.
- [lean-quality-indicators.md](lean-quality-indicators.md): sampled LLM-judge quality rates per library; its prompts are reusable review angles; the harness is too heavy for this repository.
- [lean-metrics.md](lean-metrics.md): mechanical metrics from compiled terms; the analysis is still hard-wired to numlib; useful later, not now.
- [numlib-auto.md](numlib-auto.md): backbone/surface split, tracker loop, good rubrics; no review status per declaration.
- [nlalib.md](nlalib.md): a compact style digest, read-back reviews, and a successor with an enforced closure hash and owner-only approval of statements.
- [annals-challenge.md](annals-challenge.md): how curated statements are made and audited; AI audits found errors in 22% of hand-reviewed statements; GLC is beyond its hardest level.
- [tracker.md](tracker.md): the base for the review system; it has the graph and the states, and lacks fingerprints, review records and a placeholder state.
- [reviewkit.md](reviewkit.md): its per-declaration fingerprint is the part worth carrying over; the rest can go.

**Also required by `prompts/research.md`**

- [anthropic-guidance.md](anthropic-guidance.md): Anthropic's guidance on `AGENTS.md`, prompts, `/goal`, subagents and auto mode, applied to this project.
- [tauceti-contributing.md](tauceti-contributing.md): Tau Ceti's contribution rules, merge queue, PR timing, tags and Mathlib bumps.

**Audit of this repository**

- [audit-lean.md](audit-lean.md): the two Lean files; the statement design is sound, but the adapter layer and the categorical interface should change; a verdict per part.
- [audit-harness.md](audit-harness.md): everything else in the repository; what is unused, what conflicts with the new decisions, a suggestion per file.

**Further references found: tools, process and comparable projects**

- [further-tau-ceti-worker-the-agent-harness-and-it.md](further-tau-ceti-worker-the-agent-harness-and-it.md): Tau Ceti's own agent harness, the ready-made route for automated Tau Ceti PRs; it has no licence.
- [further-automated-bump-dry-run.md](further-automated-bump-dry-run.md): an experiment. A bump of Tau Ceti alone works with four Lake commands, but the pin form and the cache command need changes.
- [further-lake-comparator-lake-check-lean-core-suc.md](further-lake-comparator-lake-check-lean-core-suc.md): `lake comparator` and `lake check` in core Lean; how they would freeze the statement; they need Linux.
- [further-lean-reference-manual-validating-proofs-.md](further-lean-reference-manual-validating-proofs-.md): Lean's own account of how to validate a proof, from `#print axioms` to comparator.
- [further-formal-conjectures-google-deepmind-contr.md](further-formal-conjectures-google-deepmind-contr.md): the largest statements-first repository; it forbids `opaque` placeholders and has a statement checklist.
- [further-formal-conjectures-paper-firsching-et-al.md](further-formal-conjectures-paper-firsching-et-al.md): how Formal Conjectures keeps statements faithful (tests, AI audits, a taxonomy of errors).
- [further-liquid-tensor-experiment-the-src-example.md](further-liquid-tensor-experiment-the-src-example.md): examples files that let a mathematician check what the definitions mean.
- [further-leanarchitect-blueprint-data-extracted-f.md](further-leanarchitect-blueprint-data-extracted-f.md): a blueprint built from Lean attributes; not suited here.
- [further-verso-blueprint.md](further-verso-blueprint.md): Verso Blueprint and doc-gen4 as bases for the page; doc-gen4 fits now, Verso Blueprint only later and for a view aimed at experts.
- [further-outside-math-review.md](further-outside-math-review.md): how comparable projects got expert review, and what only you can do to get it.
- [further-infinity-cosmos-project-riehl-carneiro-v.md](further-infinity-cosmos-project-riehl-carneiro-v.md): the ∞-cosmos project; not the line that leads to GLC's DG categories; it treats warnings as errors.
- [further-stacks-and-moduli-in-lean-jarodalper-sta.md](further-stacks-and-moduli-in-lean-jarodalper-sta.md): Alper's book in Lean; the repository's code is AI-written, unchecked, with clashing names; read-only at most.
- [further-langlands-knowledge-base-langlandsprojec.md](further-langlands-knowledge-base-langlandsprojec.md): a Langlands project where AI writes and humans review; no licence; a useful transcription rule.
- [further-jo-l-riou-formalization-of-derived-categ.md](further-jo-l-riou-formalization-of-derived-categ.md): Mathlib's derived categories; what exists and what is still a TODO (the abelian heart).

**Further references found: the mathematics**

- [further-glc-series-proof-papers.md](further-glc-series-proof-papers.md): GLC I–V, what they prove and what they need; a citation mismatch that argues for keeping a record of paper versions.
- [further-scholze-geometric-langlands-after-gaitsg.md](further-scholze-geometric-langlands-after-gaitsg.md): Scholze's Bourbaki survey; a second reading that confirms the statement's objects and hypotheses.
- [further-agkrrv-restricted-local-systems.md](further-agkrrv-restricted-local-systems.md): AGKRRV; the source of the hypotheses' conventions; ground field versus coefficient field.
- [further-arinkin-gaitsgory-singular-support-of-co.md](further-arinkin-gaitsgory-singular-support-of-co.md): the paper that defines the spectral side, `IndCoh_Nilp`.
- [further-gaitsgory-indcoh.md](further-gaitsgory-indcoh.md): ind-coherent sheaves; its Prop. 11.7.5 gives the t-structure on `IndCoh` of a stack, but the t-structure on `IndCoh_Nilp(LS_Ǧ)` that GLC I uses is written down in no source checked.
- [further-gaitsgory-rozenblyum-a-study-in-derived-.md](further-gaitsgory-rozenblyum-a-study-in-derived-.md): the derived-geometry book; a minimal path to the statement versus the book's full route.

---

## 2. What the findings change in the plan

### 2.1 By your points in `notes/ideas.md`

**"Prompts alone, without any complex system or harness."** This holds for this repository, with two limits [J]:
- The comparable projects that ran for long all grew machinery: Tau Ceti's Worker (92,000 lines), NLAlib, the Langlands knowledge base, and NumLib-Auto's early rounds [R: the four notes; J that this generalises]. To stay simple here, keep that machinery *outside* this repository: Tau Ceti's Worker runs from its own install, and the review system has its own repository [J: tau-ceti-worker, tracker].
- A trustworthy final check of the proof (`lake comparator`) needs Linux with a sandbox. macOS has none, and CI was removed [R: lake-comparator]. That means one Linux machine or one CI job, needed only at milestones.

**"First the statement, then the whole proof."** Still the right order, but the split is not clean. Defining 𝕃_G already needs deep theorems: the spectral action, and the bound from compact to eventually coconnective objects. So the statement phase ends with named, budgeted sorries, not with zero [R that these are theorems; J the consequence: scholze, glc-series]. "Statement done" should mean: no placeholder left in the statement's closure, and only listed sorries [J].

**Item 1, a library.** Strongly supported. The Xena post says a poor formalisation is worse than none. GLC is already proved on paper, so the value lies in reusable definitions [R/J: xena-blog]. Concretely [J]:
- the geometric-representation-theory backbone is the main product, and the GLC statement a thin surface on top (NumLib-Auto's backbone/surface split) [numlib-auto];
- no `Staging/`, no copied `Stacks/` folder, no re-export layer (`abbrev Scheme`, …), since each duplicates code or postpones quality [audit-lean, xena-blog];
- library definitions (D-modules, IndCoh) live in subject folders, not in the statement file [audit-lean].

**Item 2, code quality.** It becomes checkable [J: doc-style, style-guide, tauceti-review]:
- follow the Mathlib pages at **mathlib.org**; the `ideas.md` link points to an older copy that has since diverged [R];
- header, `module`, `/-!` module docstring, docstrings on definitions, citations by BibTeX key with an exact locator, no status text in docstrings, American spelling in names [R];
- Tau Ceti Review's ten rubrics, adapted, as the review checklist [tauceti-review];
- linter warnings fail the build only for sorry-free code, because `warningAsError` also turns every `sorry` into an error [R: style-guide].

**Item 3, order of sources.** The order Mathlib → Tau Ceti → Stacks stands, with three corrections [J]:
- Tau Ceti "has enough" only for the base data. Neither Tau Ceti nor Stacks has the GLC surface: no stacks beyond a carrier, no Bun_G, local systems, D-modules, IndCoh or presentable DG categories [R: tauceti-library, stacks, tauceti-roadmaps]. Most of the backbone will be written here.
- Stacks is a read-only reference, never a dependency. It is a Lean release behind, has no cache and no CI, uses a different notion of site, and most of it is unreviewed AI code [R: stacks]. Anything adapted from it goes into Tau Ceti PRs with a provenance section.
- Search Tau Ceti **main**, not only the pinned version: main gained thousands of files in six days [R: tauceti-library].

**Item 4, this repository and Tau Ceti.** The work splits into what can be automated and what cannot [R: tauceti-contributing, tauceti-roadmaps; J]:
- *Can be automated:* implementation PRs on an existing roadmap target, through your fork, written and repaired by AI under Tau Ceti's rules. The rules: no stacked PRs, and tend each PR within 7 days. PRs land in about a day.
- *Needs you:* roadmaps (whoever posts one must have read it), roadmap targets (filed only by Tau Ceti's `humans` team), and anything posted as a review or comment under your name.
- *Covered today:* base material (reductive groups, curves, foundations of schemes and stacks). The GLC backbone has no merged roadmap. The closest specifications are open roadmap PRs:
  - #1828: D-modules on smooth schemes;
  - #999: Bun_G, but over a finite field;
  - #1056: loop Grassmannian and opers;
  - #1202: nilpotent singular support, local version.

  A job for QCoh on prestacks (#2534) is in Tau Ceti's roadmap pipeline [R: tauceti-roadmaps].
- Code meant for Tau Ceti must follow Tau Ceti's rules from the start: module header, `namespace TauCeti`, no `sorry`, no `set_option`, new files under 1,000 lines. It can never contain a placeholder or import a review tool [R: tauceti-contributing, tauceti-review].
- Mathlib is not a direct destination. Its reviewers often will not review PRs that a human did not write, and its rules forbid comments written by an LLM [R: xena-blog, outside-math-review].

**Item 5, papers.** Untracked TeX, yes, but a record of paper versions is still needed. GLC V v3 cites GLC IV by theorem numbers that match no public version, and one arXiv id it cites points to an unrelated paper [R: glc-series]. The hashes added nothing this time [R]. Licences differ: GLC I–V are CC BY 4.0; AGKRRV, Arinkin–Gaitsgory and IndCoh carry only arXiv's non-exclusive licence, so cite and link them only [R: agkrrv].
- The light form: a committed `docs/references.bib` (arXiv id and version per paper; doc-gen4 reads it for citations), plus the version in each docstring citation. `manifest.toml` can then go [J: doc-style, numlib-auto, annals-challenge].
- Papers the manifest misses: Arinkin–Gaitsgory 1201.6343 v4, IndCoh 1105.4857 v7, Gaitsgory 1302.2506, Færgeman–Raskin 2207.02955, Drinfeld–Gaitsgory 1311.2071 [R: scholze, glc-series].

**The review system.** Build it on the tracker, as you planned, and add what the tracker lacks [J: tracker, reviewkit, numlib-auto, verso-blueprint]:
- a **fingerprint** per declaration, starting from ReviewKit's code. A commit says *when* a declaration was reviewed; only a fingerprint says *whether it has changed* since.
- committed **review records**, keyed by Lean name: commit, fingerprint, reviewer (an agent with model and date, or a named person), scope, verdict.
- four states, not two: *reviewed*, *changed since review*, *unreviewed*, and **placeholder**. Every tool read shows a placeholder `opaque` as finished, because it contains no `sorry` and adds no axiom: the tracker reports it `proved` [R: tracker, run 2026-11-08]; Verso Blueprint would mark it `complete`, LeanArchitect "ready" and doc-gen4 "no sorry" [J from their code: verso-blueprint, leanarchitect].
- a fingerprint that also covers the upstream definitions a statement reaches, or a record of the pinned versions. The tracker stops at the project boundary, so a Tau Ceti bump could change the meaning of a reviewed statement without anything showing [R: tracker].
- the page: a fork of the tracker's graph explorer with a review layer, linking to the doc-gen4 docs.

**"Two patterns, or is one enough?"** One is enough: one mechanism with two scopes [J: numlib-auto, tracker, verso-blueprint].
- The library scope reviews every declaration against the library standard. Any change to the source, proofs included, resets the review.
- The statement scope reviews only the statement and the definitions it reaches, against the papers. The kernel checks the proofs, so only the statement and those definitions count.
- Both use the same records and the same page.

### 2.2 By the steps in `notes/workflow.md`

- **Step 1 (Rebuild).** It now has concrete inputs:
  - a content list for `AGENTS.md` (§4.1);
  - a suggestion per file (§4.4);
  - the prompt shape: goal, checkable "done when", context. If prompts run with `/goal`, the "done when" must be provable from the transcript and under 4,000 characters [R: anthropic-guidance].

  It must also fix two things no decision lists: the conflicts marked "not listed" in §3.3, and the fragile cache command in the build note (§2.3).
- **Step 2 (Plan).**
  - The blueprint needs a fifth value for an object's owner, "open roadmap PR", beside Mathlib, Tau Ceti, roadmap item and missing [J: tauceti-roadmaps].
  - It should record the Tau Ceti commit it was checked against [J: tauceti-library].
  - It must settle the statement redesign of §4.3, which touches the pinned statement.
- **Step 3 (Build).**
  - Work breadth-first: with no stacked PRs and about a day per PR, long chains are slow [R/J: tauceti-contributing].
  - A recurring job must tend open Tau Ceti PRs at least weekly, or Tau Ceti's 7-day rules close them [R].
  - A short status file records the PRs in flight.
- **Step 4 (Review).** Layered, as in §4.5:
  - fresh agents work from written rubrics;
  - first a blind read-back from the Lean alone, then the comparison with the TeX [J: nlalib, audit-harness; `prompts/review.md` already does this, R];
  - for each placeholder, a "hack answer" test: would a trivial choice make `main` easy? [J: annals-challenge]
- **Step 5 (Refactor).**
  - Keep the mechanical move of the pin apart from the repair of the code [J: tau-ceti-worker].
  - Pick a Tau Ceti commit that has published cache mappings; only 1 of the 12 newest had them [R: automated-bump-dry-run].
  - Tau Ceti renames without deprecations, so a bump may include repairing names [R: tauceti-library].
  - Scan new upstream code for duplicates of this project's code; Tau Ceti's overlap scan is the model [J].
- **Step 6 (Proof).**
  - The proof is accepted only when `lake comparator` accepts it against a frozen challenge with the three standard axioms. Plan the split into statement, challenge and proof in step 2 [J: lake-comparator].
  - GLC III–V argue by induction, using the statement for Levi subgroups, so `Setting` should allow that [R/J: glc-series].
- **The review system** (its own repository): as in §2.1. Copy the rubrics into it rather than into this repository [J].

### 2.3 By the decisions in `notes/workflow.md`

- **Shared context in `AGENTS.md`, short, in plain words.** Supported by Anthropic's guidance, Tau Ceti's Worker (five lines), NLAlib's successor (23 lines) and Formal Conjectures (about 100 lines) [R: anthropic-guidance, tau-ceti-worker, nlalib, formal-conjectures-paper]. The exception is the Langlands knowledge base, whose `AGENTS.md` has 322 lines and which still had to add a linter, checklists and a ledger [R: langlands-knowledge-base].
  - One trap: a stray `CLAUDE.md` or `CLAUDE.local.md` silently stops `AGENTS.md` from loading [R].
  - Today `AGENTS.md` says `PLAN.md` holds the decisions, while `workflow.md` now holds them. When instruction files contradict each other, Claude picks one arbitrarily [R].
- **Prompts hold the goal, "done when" and context.** This matches the guidance [R]. For Tau Ceti work, point to Tau Ceti's many hard rules (its `AGENTS.md`, `COORDINATION.md`) rather than copy them, because they change daily [J: tau-ceti-worker, tauceti-contributing].
- **Prompts change as work goes on.** No source has this rule. Best home: one line in `AGENTS.md`, repeated as a "done when" item so that `/goal` checks it (§4.1) [J].
- **Commit and push; agents push themselves.** Claude Code's built-in rule is "commit or push only when the user asks", so `AGENTS.md` must say explicitly that pushing to `main` is wanted [R: anthropic-guidance].
- **Tau Ceti contributions fully automated.** This holds for implementation PRs only (§2.1, item 4). Two practical blocks [R: anthropic-guidance, tauceti-review, tau-ceti-worker]:
  - auto mode blocks PRs to another organisation, and forks, unless you name the target in your own settings;
  - always-on review on a personal subscription is, in Tau Ceti's words, "likely outside subscription terms".
- **Keeping up fully automated.** It works; one bump was tested [R: automated-bump-dry-run]. Four things must change [J]:
  - the Tau Ceti pin becomes a commit that agents may move. A tag pin means editing `lakefile.toml` at every bump, and tags come only with Lean releases.
  - `lakefile.toml`, `lake-manifest.json` and `lean-toolchain` stop being files that agents must ask about first.
  - the Tau Ceti cache is fetched eagerly, with a retry. With `--mappings-only`, one network error turned into silent local compiling [R].
  - tracker and ReviewKit leave this repository's build. Each must build on every new Lean, and TauCetiTools' updater fails on the tracker's path dependency [R].

  No project read automates bumps fully except Tau Ceti itself. NumLib-Auto, NLAlib, Formal Conjectures and the Langlands knowledge base bump by hand. In infinity-cosmos, a bot opened bump PRs but nobody merged them, and the project fell months behind [R: those notes].

---

## 3. Contradictions

### 3.1 Between sources

- **How to write a missing object.**
  - Formal Conjectures forbids `opaque`, `axiom` and sorried definitions, enforced by a linter [R].
  - The Annals Challenge uses `def … := sorry` holes pinned down by sorried characterising theorems [R].
  - Comparator accepts holes only as `def … := sorry`, and its README warns that they "can be gamed" [R].
  - GLCinLean uses `opaque` with no characterising property, which is weaker than either curated project [J: formal-conjectures, annals-challenge, lake-comparator].
- **Verifier subagents.** Anthropic's Opus 5 guide says to remove "use a subagent to verify"; its Fable 5 guide says to add fresh verifier subagents for long runs [R: anthropic-guidance]. Resolved here by making the fidelity review its own step, with its own prompt [J].
- **Citations.** Mathlib's documentation page asks for `[text][key]`; Tau Ceti mostly cites in plain text; part of Mathlib is moving to Verso's `{cite}` [R: doc-style].
- **Tau Ceti's own documents** [R: tauceti-library, tauceti-contributing]:
  - the README says automatic review of each PR is switched off; `AGENTS.md` says re-review runs automatically;
  - `bors.toml` describes bors, but an AI merge queue now lands the PRs;
  - `COORDINATION.md` calls the `[COOP]` marker optional; the Worker says a PR is "rejected without it".
- **Foundations of stacks.** Three libraries define stacks differently [R: stacks, stacks-and-moduli]:
  - Tau Ceti: universes and `SchPseudofunctor`;
  - AxiomMath/Stacks: a big fppf site bounded by a cardinal, and fibred categories;
  - stacks-and-moduli: the étale topology, with no condition on the diagonal.

  The last two also clash on names.
- **Base field.** GLC I allows any algebraically closed field of characteristic 0. Tau Ceti's local roadmaps fix ℂ; #999's Bun_G is over a finite field; #1828 allows any field of characteristic 0 [R: tauceti-roadmaps]. AGKRRV keeps the ground field and the coefficient field apart [R: agkrrv].
- **Inside the GLC literature.**
  - GLC V v3 cites a revision of GLC IV that is not public [R: glc-series].
  - Scholze states GLC as "there is an equivalence"; GLC I as "𝕃_G is an equivalence". With Scholze's normalisation they say the same in substance [R/J: scholze].
  - AGKRRV's Hecke set-up is untwisted, GLC I's half-twisted. An expert should compare them [J: agkrrv].
- **Mathlib** [R: mathlib-coverage, riou]:
  - one file's TODO says the canonical t-structure is missing, while another file defines it;
  - Riou's paper says the heart is abelian, while Mathlib still lists that as a TODO.
- **The pin form.** `PLAN.md` pins Tau Ceti to a tag [R: audit-harness]. The notes then disagree on the alternative [R: tauceti-contributing, automated-bump-dry-run; J]:
  - `tauceti-contributing.md` suggests `rev = "main"`, so that a bump touches only `lake-manifest.json` and `lean-toolchain` and never `lakefile.toml`, as Tau Ceti does with Mathlib;
  - the bump test found that only 1 of the 12 newest `main` commits had published cache mappings, so it picks a commit with mappings and writes it into `rev`, which edits `lakefile.toml` at every bump.
- **Keep or retire the statement pin.** `reviewkit.md`, `lake-comparator` and `reference-manual` would retire `reviews/statement-pin.toml` (never approved, unchecked since CI went, partly replaced by comparator) [J]. `nlalib.md` would keep it and move it towards NLAlib's successor (closure hash with proofs erased, owner-only approval); `annals-challenge.md` calls a simple pin file sound practice; `liquid-tensor` would also pin the examples; `tauceti-review.md` finds it consistent with Tau Ceti's model [J: those notes]. §4.4 follows the first group; Q6 asks you.
- **Statement pins** [R: nlalib, formal-conjectures, lake-comparator]:
  - NLAlib's successor enforces a closure hash, with signed approval that only the owner can give;
  - Formal Conjectures fixes whole snapshots by tag;
  - comparator replaces the hard pin at proof time, but not the "digest" warning that upstream definitions changed.
- **Notes.** NumLib-Auto keeps round notes out of Git; NLAlib committed everything and later declared it history; Anthropic and the Worker keep state in Git and transcripts local [R]. Tau Ceti keeps review records off `main` (a `reviews` branch and TauCetiData), while most notes suggest committing them [R: tauceti-review; J].
- **Where "update the next prompt" lives.** Most notes put it in `AGENTS.md` (anthropic-guidance, audit-harness, nlalib); the Worker note puts it in each recurring prompt's "done when" instead (tau-ceti-worker) [J]. §4.1 uses both.
- **Naming reviewers.** One note first suggested a particular person as an outside reviewer; `further-outside-math-review.md` says agents should list public roles but not pick or approach anyone [J: both notes]. The suggestion was removed before publishing (the owner's decision of 2026-11-08), and the question went to the owner privately.
- **GLC I's own citations.** GLC I cites a "Sect. 17.8.4" that does not exist in AG v4, cites AG 11.1.6 for `LS^restr`, which AG do not treat, and AG Prop. 4.4.5 (affine schemes) for a t-structure on a stack; l.2312 tensors over `QCoh(LS^restr)` where AGKRRV Prop. 14.5.3 uses `QCoh(LocSys^dR)` [R: arinkin-gaitsgory, agkrrv; J that l.2312 is a typo]. Docstrings must cite the defining source, not copy GLC I's pointers.

### 3.2 Between sources and `notes/ideas.md`

- **"Stacks's code may never be needed, as Tau Ceti has enough."** The conclusion holds, the reason does not: for the GLC surface neither library has enough (§2.1, item 3).
- **"Perhaps write a roadmap … I might not be able to review a roadmap fully."** Tau Ceti requires whoever posts a roadmap to have read it. The light route is a target filed by a member of the `humans` team [R: tauceti-roadmaps, tauceti-contributing].
- **"Defer to human-curated libraries."** Tau Ceti's code is written and reviewed by AI; only its roadmaps are curated by humans [R: tauceti-library, outside-math-review].
- **"Review status tracked by the Git commit hash."** A commit alone cannot say whether one declaration changed; a fingerprint is needed beside it [J: reviewkit, tracker]. Your two states also leave open what happens when only a dependency changes, and where placeholders go. And ReviewKit's statement fingerprint does *not* change on a proof-only or docstring-only refactor, while your idea says any change during a refactor makes a declaration unreviewed again [R: reviewkit].
- **"Set standards, and meet them … 'clean it up later' is counterproductive."** Opaque placeholders, and `PLAN.md`'s `Staging/` and copied `Stacks/` folders, are a "clean it up later" design; "first the statement" fits this value only if the statement ends up on real definitions [J: formal-conjectures, xena-blog]. §4.3 and Q2 answer this by keeping placeholders visible and temporary.
- **"I don't see the point of `manifest.toml`."** The file can go, but a record of paper versions cannot (§2.1, item 5).
- **Lean Quality Indicators, "Kim Morrison uses this metric; quite like Tau Ceti Review."** She is its main author. It resembles Tau Ceti Review in its questions, not its purpose: it measures rates over a whole library, not verdicts on PRs [R: lean-quality-indicators].
- **Lean Metrics, "the metrics come from Tau Ceti Review … usable for any Lean project."** Its angles come from Tau Ceti's rubrics, which contain no metrics. The extractor is general; the analysis is hard-wired to numlib [R: lean-metrics].
- **NumLib-Auto, "a good example of how to do the review system."** True for the graph and the review process, not for review status, which it lacks [R: numlib-auto].
- **"Based on tracker."** The community is moving to Verso Blueprint for blueprints. It does a different job (a curated document), so there is no real conflict [J: verso-blueprint]. But both Verso Blueprint and LeanArchitect need text or annotations written beside the code, against your "web page generated directly from" a Lean project in Mathlib style; the tracker and doc-gen4 need neither [R: verso-blueprint, leanarchitect; J].
- **"Review additions publicly."** The Annals reviews were internal, and public review is unlikely to bring expert review of GLC objects [R/J: annals-challenge, outside-math-review].
- **The style-guide link** points to the older copy at leanprover-community.github.io [R: style-guide].
- **The example prompts.** The second one ("codex agent in yolo mode in a tmux shell") is a pattern auto mode blocks by default [R: anthropic-guidance]. The `/goal` example's "review other people's PRs" posts reviews under your login, which Tau Ceti intends for people it trusts [R: tauceti-review].

### 3.3 Between sources and the decisions in `notes/workflow.md`

- **"Tau Ceti contributions fully automated"** conflicts with [R: the §2.3 notes]:
  - roadmaps, intentions and targets need a human;
  - Mathlib and Tau Ceti forbid posting comments that are unread or written by an LLM;
  - auto mode blocks PRs to another organisation by default;
  - always-on review on a subscription;
  - self-review: Tau Ceti's merge gate accepts an all-green scoreboard from any author, so an automation could review its own PRs into the queue, but Tau Ceti's documents ask to tell self-review apart from review by others. That would follow the letter, not the spirit [R/J: tauceti-contributing].
- **"Keeping up fully automated"** conflicts with [R: audit-harness, automated-bump-dry-run]:
  - `AGENTS.md`'s note on `lake update` (listed);
  - `lakefile.toml`'s "Bumps are the owner's decision" (**not listed**);
  - `PLAN.md`'s "Tau Ceti is pinned to a tag" (**not listed**);
  - TauCetiTools' guard, which treats edits to the lakefile as human-owned;
  - every Lean-coupled tool in the build: the tracker must build on the project's toolchain and has skipped a Lean release before, so a new Lean can break it before upstream fixes it [R/E: tracker]; Lean Metrics is locked to one toolchain [R: lean-metrics]; Verso Blueprint starts each stable Lean line 17–23 days after its first RC, while GLCinLean follows Tau Ceti onto RCs, so a blueprint package in the same workspace would hold back every RC bump [R/J: verso-blueprint].
- **"Keeping up fully automated" and the statement pin.** A Tau Ceti rename of a name the statement uses would change the pinned fingerprint and stop work until you re-approve. It did not happen in the one bump tried [R/E: audit-harness, automated-bump-dry-run].
- **"Agents push themselves"** conflicts with Claude Code's default rule. NLAlib's successor forbids agents to push or touch pins, and the Annals audit prompt says "Do not push anything!" [R]. Pushing straight to `main` also leaves nothing for Tau Ceti Review to run on, since it reviews pull requests only [J: tauceti-review].
- **Step 4, "fresh agents check changed declarations"**, against the review practice of every curated precedent read: the Annals team reviewed by hand first, Formal Conjectures makes human review the final check, `PLAN.md` says "no claim of faithfulness is made without an outside expert", and in the Ilin–Nugent case study agents did not improve definitions by themselves [R: annals-challenge, formal-conjectures-paper, outside-math-review]. Tau Ceti itself relies on AI review only [R: tauceti-review]. §4.5 keeps fresh agents for the detailed checks and adds a narrow outside review.
- **"Prompts with few constraints"** conflicts with the numbered steps in the current prompts and with NumLib-Auto's procedure-style prompts [R: audit-harness, numlib-auto].
- **`PLAN.md`'s "Public but unannounced"** and `reservoir = false` end with the first Tau Ceti PR, which announces the project in practice (**not listed**) [R: audit-harness].
- **`AGENTS.md`'s "PLAN.md holds the decisions"** conflicts with `workflow.md` holding them (**not listed**) [R: anthropic-guidance].
- **"`AGENTS.md` holds the main goal and the plain-words rule."** The current file has neither the plain-words rule nor more than one line of goal (**not listed**) [R: audit-harness].

### 3.4 Inside this repository

These are not listed in `workflow.md`; step 1 can fix them while rewriting [R: audit-harness, reviewkit, tracker]:
- `README.md` calls `reviews/` "approved by the owner"; both files say "NOT YET APPROVED", and every `approved` field is empty.
- `README.md` names `THIRD_PARTY_NOTICES.md`, which is not in Git. The owner removed the file on purpose (decided 2026-11-08), so the README mention goes.
- `reviews/statement-pin.toml` says "CI fails on a mismatch", and `Abstract.lean` says the import rule is "enforced by `review imports`"; CI is gone and nothing runs ReviewKit.
- `prompts/review.md` and `prompts/statement.md` fetch papers "at the versions in `manifest.toml`", but the fetch script is gone; `.lake-config/lake-config.toml` says scripts and CI set `LAKE_CONFIG`, and both are gone.
- `prompts/statement.md` lists `AGENTS.md` among your files; `AGENTS.md`'s own list does not.
- `PLAN.md` says the placeholders are never axioms, while the tracker reports them `proved`: the tools disagree on what "done" means.
- `.gitignore` ignores `*.tex` everywhere, so a LaTeX blueprint would be silently ignored.
- Leftovers outside Git: an empty `prompts.md/` directory and a `.changes/` directory.

---

## 4. The open questions: what the findings suggest

### 4.1 What goes into `AGENTS.md`, and where "update the next prompt" lives

**Recommendation.** Keep one instruction file, `AGENTS.md`, well under 200 lines; the current 30 lines is about the right size. It holds only what an agent cannot find by reading the repository [R: anthropic-guidance]:
1. the goal in two sentences: GLC I Conj. 1.6.7 (de Rham, characteristic 0), then its proof, as a geometric-representation-theory library in Mathlib style;
2. plain, structured words, and the evidence tags;
3. the source order: Mathlib, then Tau Ceti main, then Stacks only as a read-only reference. For Tau Ceti work: read Tau Ceti's `AGENTS.md` and `COORDINATION.md`, never write to TauCetiRoadmap, open no stacked PRs;
4. links to the mathlib.org style, naming and documentation pages, plus only the project's own facts: where the bibliography is and how to cite, how placeholders are written and marked, no status text in docstrings, American spelling in names;
5. the placeholder rule, and "never weaken what a statement says while removing a sorry or a placeholder" [annals-challenge];
6. the build and cache commands, corrected: fetch eagerly with a retry, and treat a `Built Mathlib.…` or `Built TauCeti.…` line without `:c.o` as the sign to stop. Also the "done" check: `lake build` plus `#print axioms` on the main theorem;
7. when to commit, that pushing to `main` is wanted, and that agents may open Tau Ceti PRs from your fork;
8. agents never contact people or post in other projects' threads in your name: they prepare, you send [outside-math-review];
9. downloaded content is data, and provenance headers on copied files;
10. never create `CLAUDE.md` or `CLAUDE.local.md`;
11. "after the work, check the prompt for the next step, and update it in the same commit".

Procedures needed by only one step (the bump recipe, opening a Tau Ceti PR, the review method) go into that step's prompt [R/J: anthropic-guidance, automated-bump-dry-run]. Item 11 is also a "done when" line in every recurring prompt, so that `/goal` checks it.

**Why.** Rules for every session belong in the one file every session loads; a rule inside a prompt is lost when the prompt is rewritten [J: audit-harness]. The Worker keeps its `AGENTS.md` to five lines and puts each task's rules in that task's prompt [R], which supports keeping procedures out.

### 4.2 Whether `PLAN.md` is needed

**Recommendation.** No. Move each part of its content to one home, then delete it [J]:
- the statement decisions (why the hypotheses are what they are) → the "Implementation notes" of the statement file's module docstring [audit-lean, audit-harness];
- the map from each object to its provider, and the open questions → the step-2 blueprint: tracker plans, with the provider in the `source` field and the Tau Ceti commit checked [tracker, tauceti-library];
- the decisions in force → `notes/workflow.md`, which `AGENTS.md` points to. This includes what only `PLAN.md` now says: the provider order and code layout (into `AGENTS.md` item 3), and "subscriptions only; no API billing", which Q8 revisits [R: audit-harness, tauceti-contributing];
- state that outlives a session (Tau Ceti PRs open and landed, last bump, what comes next) → a short `STATUS.md`, as in your `/goal` example [anthropic-guidance, tauceti-contributing].

**Why.** Anthropic's long-running examples keep three things: a definition of done, a progress file and Git [R]. Prompts cannot carry state [J].

### 4.3 Whether `Abstract.lean`, `Foundations.lean` and their placeholder design are reasonable

**Recommendation.** Keep the statement design; change most of the rest [J: audit-lean, with the notes named below].
- **Keep:**
  - the standing data as a structure;
  - 𝕃_G chosen by its characterisation through `Classical.choose`, with existence and uniqueness;
  - isomorphisms never stated as equalities, and no axioms.

  This was checked to be sound: `sorryAx` still shows through `LG` [R: audit-lean]. The list of objects is the right one: Scholze's account and GLC III–V use the same objects [R/J: scholze, glc-series].
- **Drop:** the `abbrev` re-exports, which give upstream objects second names, and the rule "the abstract imports only `Foundations`", which suited ReviewKit, not a library [audit-lean, xena-blog].
- **Fix** [R: audit-lean, doc-style]:
  - Mathlib headers, `module`, `/-!` docstrings;
  - citations by BibTeX key with a locator, and the six wrong or imprecise citations;
  - the reformulation of Cor. 1.6.5 over linear functors, which needs Prop. 1.7.2: either state the corollary literally or flag the change.
- **Placeholders become a temporary surface that everyone can see:**
  - allowed only in the statement surface, never in the backbone or in code meant for Tau Ceti [formal-conjectures, tauceti-review];
  - each one marked so the tools see it (a two-line local tag attribute) and shown on the page as *placeholder*. Its docstring says plainly that it stands for a named, cited object [tracker, doc-style];
  - each one gets a "hack answer" test, and sorried characterising theorems where the object has a universal property [annals-challenge];
  - each one is replaced only together with sorry-free examples or test lemmas [liquid-tensor, formal-conjectures-paper].
- **Expose more meaning before freezing the statement**, so that the pinned theorem says *which* equivalence:
  - `LCoarse` as a definition built from placeholders for the spectral action and the Poincaré sheaf [scholze];
  - `IndCohNilp` as the full subcategory of `IndCoh(LS)` cut out by singular support, and `Psi` as a composite [arinkin-gaitsgory];
  - `IsEventuallyCoconnective` defined from `Psi` and a t-structure, once the interface has morphisms [gaitsgory-indcoh]. Compactness cannot be taken from Mathlib's `IsFinitelyPresentable`; an earlier draft did that, and it was corrected as an error [R: mathlib-coverage];
  - `RootDatumDuality` moved towards Mathlib's `RootDatum` and `RootPairing.flip` [mathlib-coverage];
  - `DGCat` with the field `k` and the t-structure as data [audit-lean, agkrrv];
  - `Setting` restrictable to Levi subgroups, with one existence obligation for `Setting` [glc-series, audit-lean].
- **Plan the comparator split now:** shared statement modules; a small challenge file (`main` and `exists_isLanglandsFunctor`, with `sorry`); the proof [lake-comparator].

**Why.** Every tool reads a placeholder as finished, so without a marker the page would show the statement as complete [R: tracker; J: verso-blueprint]. An expert cannot review an opaque object, and comparator cannot freeze a statement that still contains one [R/J: outside-math-review, lake-comparator]. The redesign changes the pinned statement, which is your file (§6, Q3).

### 4.4 What happens to each existing file

| File | Recommendation [J] | Notes |
|---|---|---|
| ReviewKit `[[require]]` in `lakefile.toml` | remove once `@[placeholder]` has a home in this repository | nothing runs it; one more Lean package to fix at every bump; would become trusted code under comparator; files meant for Tau Ceti cannot import it (reviewkit, audit-harness, lake-comparator) |
| `@[placeholder]` | keep the mark, as a small attribute in this repository; the review system reads it | tracker, reviewkit, audit-lean |
| `glc/project.toml` | retire it with ReviewKit | reviewkit |
| `reviews/statement-pin.toml` | retire the file: never approved, and nothing has checked it since CI went. Its job moves to review records now, and to a comparator challenge at the freeze. The comparator does not cover its `digest` level (a warning that upstream definitions changed), so the review records must | reviewkit, lake-comparator, reference-manual. Disputed: nlalib, annals-challenge and tauceti-review would keep a pin (§3.1) |
| `reviews/sorry-budget.toml` | retire it; the allowed sorries become named entries in the blueprint and the review records, checked with `#print axioms` | reviewkit, formal-conjectures |
| `blueprint/` | keep the tracker plans as the step-2 blueprint; move them to `plans/`, the tracker's default, so no `--dir` is needed anywhere | tracker, numlib-auto |
| `prompts/` | rewrite each as goal, "done when", context. Keep `review.md`'s method (blind read-back, then the TeX, verdicts with exact lines) and replace its ReviewKit scope step | anthropic-guidance, audit-harness |
| `references/papers/manifest.toml` | replace it with a committed `docs/references.bib` (id and version) and versioned citations in docstrings; remove the `!` line in `.gitignore` | §2.1, item 5 |
| `tools/tracker` submodule | keep it for now; move it to the review-system repository when that exists | automated-bump-dry-run |
| `lakefile.toml` | the Tau Ceti `rev` becomes a commit that agents move; drop "Bumps are the owner's decision"; warnings fail the build only for a sorry-free library target | automated-bump-dry-run, style-guide |
| `PLAN.md` | move its content out (§4.2), then delete it | |
| `AGENTS.md` | rewrite it (§4.1) | |
| `README.md`, `THIRD_PARTY_NOTICES.md`, `.gitignore` | update the README and drop its mention of the notices file (the owner removed the file on purpose, 2026-11-08); drop `private/`; reconsider `*.tex` if the blueprint is ever LaTeX | audit-harness |

Many of these are your files (the list in `AGENTS.md`), so step 1 proposes the changes and you see the diff (§6, Q5–Q6).

### 4.5 Who reviews the mathematics, and to what standard

**Recommendation.** Three layers, and a plain claim [J: outside-math-review, annals-challenge, tauceti-review, numlib-auto, nlalib, formal-conjectures-paper, lake-comparator].
1. **Mechanical.** Every session: `lake build` and `#print axioms`. At milestones, on Linux: `lake check` for the sorry-free library, `lake comparator` for the proof.
2. **Fresh agents, on every changed declaration, against written rubrics.**
   - Library scope: Tau Ceti Review's rubrics, adapted (paths, namespace, a scope rubric for GLC, and Tau Ceti added to the search for duplicates).
   - Statement scope: first a read-back from the Lean alone, then a comparison with the TeX at exact locations; NumLib-Auto's semantic-alignment checks; the Annals audit questions (edge cases, special cases, attempts at easy proofs or disproofs).
   - Models from two families where possible. Each report says what it checked and what it did not.
3. **An outside expert, only where agents cannot help, asked as narrowly as possible.**
   - Early: a few yes/no questions on the meaning of Conj. 1.6.7: the half twist, the t-structure step on `IndCoh_Nilp`, and `Nilp`.
   - Later, once the placeholders are real definitions: a read of the statement surface, its docstrings and its examples.
   - You choose whom to ask, and you send the request.

**The claim.** A declaration is *expert-reviewed* only with a named reviewer, a commit and a scope. Otherwise it is *agent-reviewed*, and the README says so. Your own approval is an approval of the process, not of the mathematics [J: audit-harness].

**Why.**
- AI audits found errors in 22% (11/50) of statements that mathematicians who know Lean had already checked, and the human review caught 2 of the 10 slips in the papers that the AI missed [S, the Annals paper's own data: annals-challenge].
- In the one expert case study, agents fixed what the expert listed, but did not improve the definitions by themselves [R: outside-math-review].
- Every precedent found with real expert review had the expert inside the project [J: outside-math-review, from the precedents read; not an exhaustive search].
- Comparator certifies only "as written", not "as intended" [R].

### 4.6 Where research notes and session summaries live, and whether they are committed

**Recommendation** [J: anthropic-guidance, tau-ceti-worker, numlib-auto, nlalib]:
- research notes: committed and public in `notes/research/`, read as dated reference material, never cited as rules;
- session summaries: in the commit message; state the next session needs goes in `STATUS.md`;
- review records: committed, in the review system's format;
- transcripts and logs: kept local, not committed;
- nothing with account or usage details, and no judgements about named people; several notes here do judge other projects (for example `stacks.md`, `further-langlands-knowledge-base-…`, `further-stacks-and-moduli-…`), and judgements about named people and the owner's private set-up details were removed before publishing (Q26, decided 2026-11-08).

**Why.**
- Auto memory lives on one machine; a session on another machine will not see it [R/J: anthropic-guidance].
- Notes kept out of Git cannot be read on GitHub or on another machine [J: numlib-auto].
- Committed notes pile up into contradictory "history" unless they are marked as such [R: nlalib].

---

## 5. Further references found but not read

- Ben-Zvi, *What is the geometric Langlands correspondence about?* (AMS Current Events Bulletin 2026), which Scholze recommends as a companion [scholze].
- The Lean Zulip channel `#Tau Ceti` and its topic "Getting started: roadmaps", where roadmaps are discussed (needs a login) [tauceti-roadmaps, outside-math-review].
- Tau Ceti roadmap PRs #848 (differential operators), #1040 and #1743 (étale perverse sheaves), #1547 and #1814, and the job-board design #7411 (QCoh on prestacks): read only as far as their summaries [tauceti-roadmaps].
- TauCetiData, TauCetiProgress, TauCetiCI, and Tau Ceti's planned move to a self-hosted Forgejo server [tauceti-contributing].
- Formal Frontier, an agent-driven pipeline from source texts to libraries [xena-blog].
- The `formalization.yaml` JSON schema; only the v0.4 template was read [xena-blog].
- Mathlib's library notes and its PR title conventions (`commit.md`) [style-guide].
- Open Mathlib PRs #44200 (Picard group), #41228 (relative differentials), #39989, #40831, #40194, #45801 and #44257: titles only [mathlib-coverage].
- De Jong's announcement of 2026-10-21 on AI contributions to the Stacks Project [stacks].
- The expert-review logs of the Ilin–Nugent case study, and Scholze's 2020 post setting the Liquid Tensor challenge [outside-math-review].
- The seven proofs that Loubaton–Ruit cite for the (∞,2)-categorical claims of the Gaitsgory–Rozenblyum book [gaitsgory-rozenblyum].
- Anthropic's "Building effective agents" [anthropic-guidance].

---

## 6. Questions for you

Each question gives the options and the recommended one, with the section that explains why. "Your file" means a file that `AGENTS.md` lists as the owner's.

**A. Scope and the statement**

1. **Scope.**
   - (a) GLC I Conj. 1.6.7 only: de Rham, characteristic 0, any algebraically closed field `k`. "Connected" and "algebraically closed" are the series' conventions, written down in the docstring.
   - (b) GLC I's sentence read literally: any field of characteristic 0. This needs non-split pinnings and dual groups.
   - (c) Over ℂ, to match Tau Ceti's local roadmaps.

   **Recommended: (a)**, with library interfaces that keep the ground field and the coefficient field apart, so that other sheaf theories can be added later (§3.1).
2. **Placeholders.**
   - (a) Keep plain `opaque` placeholders as they are now.
   - (b) Forbid them, and state GLC only once every object is defined.
   - (c) Allow them only in the statement surface: marked, shown as their own state, with characterising theorems where possible, replaced only together with examples, and none in the backbone or in code meant for Tau Ceti.

   **Recommended: (c)** (§4.3).
3. **Statement redesign.** May step 2 change the pinned statement and settle the technical choices itself, with a fresh-agent review and you seeing the diff? The changes: drop the re-exports; rename `main` and the other names; refine `LCoarse`, `IndCohNilp`, `IsEventuallyCoconnective`, `RootDatumDuality`, `DGCat` and `Setting`.
   - (a) Yes.
   - (b) You approve each change.
   - (c) Keep the current shape.

   **Recommended: (a)**, as one change, so the pin is re-approved only once (§4.3).
4. **Deep theorems inside the statement.** The spectral action and the bound from compact to coconnective objects are needed to define 𝕃_G.
   - (a) Treat them as named, budgeted sorries of the statement phase, so that "statement done" means no placeholder and only listed sorries.
   - (b) Wait until they are proved.

   **Recommended: (a)** (§2.1).

**B. Automation and your files**

5. **Bumps.**
   - (a) At the start of every Refactor session, agents move the Tau Ceti pin to a recent `main` commit that has a published cache. They change `lakefile.toml` (the `rev` line only), `lake-manifest.json` and `lean-toolchain` without asking; you see the change in the commit.
   - (b) `rev = "main"` in `lakefile.toml`, so a bump changes only `lake-manifest.json` and `lean-toolchain` and the lakefile stays yours; but `lake update` then takes the newest `main` commit, which often has no published cache (1 of the 12 newest had one), so a bump may compile Tau Ceti locally.
   - (c) The same as (a), but pinned to tags, so bumps happen only with Lean releases.
   - (d) You do the bumps.

   **Recommended: (a)** (§2.3, §3.1 "The pin form"). Also: how often? At the start of every Refactor session (recommended), weekly, or at every Tau Ceti toolchain tag.
6. **The old harness.** May step 1 remove `glc/project.toml`, `reviews/statement-pin.toml`, `reviews/sorry-budget.toml` and the ReviewKit requirement, with `@[placeholder]` moved to a local attribute?
   - (a) Yes.
   - (b) Keep them, as a check before each commit.
   - (c) Remove ReviewKit, but keep a statement pin in a new form (closure hash with proofs erased, approval only you can write), as `nlalib.md` suggests.

   **Recommended: (a)** (§4.4); the notes disagree on the pin (§3.1).
6b. **Who approves later changes to the main statement.** After step 2's redesign, a bump (a Tau Ceti rename), a refactor or an upstreaming can still change `main`, `Setting` or a definition they reach, and at the end the challenge file is frozen.
   - (a) Agents make the change, a fresh agent reviews it against the papers, and the commit message says so; you are not asked.
   - (b) Work on the statement stops until you approve; everything else goes on.
   - (c) You approve only the freeze of the comparator challenge; before that, (a).

   **Recommended: (c)**: your approval checks the process, not the mathematics (§4.5), so it is worth most at the one point that cannot be undone cheaply.
6c. **Warnings as errors.** May step 1 set `warningAsError` in `lakefile.toml` for a sorry-free library target (as Tau Ceti does), leaving the statement surface with its listed sorries outside it? **Recommended: yes** (§2.1, item 2).
7. **Authority to push and to open Tau Ceti PRs.** May `AGENTS.md` say that sessions push to `main` of `WHY-Op109/GLCinLean` at agreed points, and open Tau Ceti PRs from your fork? And will you add `autoMode` entries naming `TauCetiProject/TauCeti` and your fork to your own settings? Only you can do that. **Recommended: yes to both** (§2.3).
8. **How Tau Ceti work runs.**
   - (a) Tau Ceti's Worker, run outside this repository: `--agent claude`, one pinned roadmap area, and only work on your own PRs (`--only roadmap,fix,fix-ci,rebase`). In sessions you start, on your subscription, at least weekly.
   - (b) A GLCinLean prompt that drives Claude Code under Tau Ceti's rules.
   - (c) A loop that runs all the time on API keys, with a budget.

   **Recommended: (a)**: the Worker is maintained, and it enforces claims and safe pushes.

   Also: may it run outside a sandbox? It then uses your full `gh` credentials. **Recommended: yes**, to start with.
9. **Reviewing other people's Tau Ceti PRs** (as in your `/goal` example). Reviews are posted under your login, and Tau Ceti means them for people it trusts.
   - (a) Not for now.
   - (b) Yes, from the start.

   **Recommended: (a)**; look at it again once your own PRs land reliably.
10. **Final checks and Linux.** Should the proof count as done only when `lake comparator` accepts it against a frozen challenge, with the three standard axioms? And where should those runs happen?
    - (a) In a Linux virtual machine, at milestones, trusting Mathlib's and Tau Ceti's caches. Comparator's newest help text assumes no pre-existing `.lake`, so trusting the caches is an extra assumption you accept; a fully clean run instead takes hours [R/E: lake-comparator §7].
    - (b) In one GitHub Actions job, which brings CI back.
    - (c) Without a sandbox on macOS, which Lean's manual calls "not trustworthy".

    **Recommended: yes, and (a)** (§2.2, step 6).

**C. Tau Ceti, other libraries, announcing**

11. **A roadmap for geometric representation theory.**
    - (a) None for now: write the backbone here, and contribute only to existing roadmaps.
    - (b) Ask a member of Tau Ceti's `humans` team to file a target on the roadmap job board.
    - (c) Write and post a roadmap yourself.

    **Recommended: (a) now, then (b) once a first layer (D-modules on schemes) exists here.** Tau Ceti's roadmap guide warns that "a roadmap whose lowest rung is still far above what has been formalized just makes agents thrash" [R: tauceti-roadmaps].
12. **Open roadmap PRs** (#1828, #999, #1056, #1202).
    - (a) Use them as specifications: write the code here now, in Tau Ceti's conventions and at the paths Tau Ceti would use, and contribute it after they merge.
    - (b) Wait for them.
    - (c) Ignore them.

    **Recommended: (a)**.
13. **Other libraries:** AxiomMath/Stacks, stacks-and-moduli, the Langlands knowledge base, infinity-cosmos.
    - (a) Read-only references, never dependencies. Anything adapted goes into Tau Ceti PRs with a provenance section, and AI-written, unreviewed code is reviewed again first.
    - (b) The current `PLAN.md` route: copy declarations into `GLCinLean/Stacks/`.

    **Recommended: (a)** (§2.1, item 3).
14. **Mathlib.** Should agents ever open PRs to Mathlib directly? **Recommended: no**; go through Tau Ceti (§2.1, item 4).
15. **The ∞-categorical layer.**
    - (a) Keep `DGCat` as a refined placeholder. Build the 1-categorical layer here now (D-modules on schemes, on Mathlib's sheaves of modules), and leave presentable ∞-categories to Tau Ceti's EnhancedDerivedSheaves roadmap.
    - (b) Build the ∞-categorical foundations here now.

    **Recommended: (a)**; Tau Ceti's own foundations for this layer have barely started (tauceti-roadmaps, gaitsgory-rozenblyum).
16. **Announcing.** The first Tau Ceti PR ends "public but unannounced".
    - (a) Accept that, and register GLCinLean at `leanprover-community/project-intentions`, so that others avoid duplicating the work.
    - (b) Accept it, but do not register.

    **Recommended: (a)**.

**D. Review**

17. **Outside review.**
    - (a) Seek it narrowly: a few questions on the meaning of Conj. 1.6.7 early, and a read of the statement surface once the placeholders are real definitions, written and sent by you. Otherwise claim "agent-reviewed".
    - (b) Claim only "agent-reviewed", and ask no one.

    **Recommended: (a)** (§4.5). If (a), you choose the channel (email to the authors, Zulip, a public issue) and what you offer (acknowledgement, co-authorship of a write-up).
18. **Rubrics.**
    - (a) Copy and adapt Tau Ceti Review's rubrics, NumLib-Auto's rubrics and the Lean Quality Indicators prompts into the review-system repository; all are Apache 2.0, so the copies carry notices. GLCinLean's prompts cite them.
    - (b) Write new rubrics.

    **Recommended: (a)**.
19. **What resets a review.**
    - (a) Statement scope: any change to the statement or to anything it reaches, upstream definitions included. Library scope: any change to the declaration's source, including its proof and docstring.
    - (b) Only a change to the declaration's own statement, in both scopes.

    **Recommended: (a)** (§2.1, "Two patterns").
20. **The base of the review system.**
    - (a) Require the tracker as a library, copy ReviewKit's fingerprint code, fork the tracker's graph explorer, link the doc-gen4 docs unchanged, and use one mechanism with two scopes; then archive `WHY-Op109/reviewkit`.
    - (b) Fork the tracker.
    - (c) Start from nothing.

    **Recommended: (a)**; fork only if a Lean bump breaks the tracker and upstream has not fixed it yet.

**E. Housekeeping**

21. **Paper versions.**
    - (a) Drop `manifest.toml`. Keep a committed `docs/references.bib` with the arXiv id, the version and a licence note for every cited paper; drop the hashes.
    - (b) Keep the manifest.

    **Recommended: (a)** (§2.1, item 5).
22. **Copyright and `Authors:` lines in the Lean files.**
    - (a) "The GLCinLean contributors" in the copyright line, your name under `Authors:` (the person to contact), and AI help recorded in the commit trailers.
    - (b) Name the AI models as authors, as some Tau Ceti files do.

    **Recommended: (a)**.
23. **Leftovers.** `THIRD_PARTY_NOTICES.md` is settled: the owner removed it on purpose on 2026-11-08.

**F. The open questions of `workflow.md`**

The recommendations of §4 need your answer too; §4.3 to §4.5 are covered by Q2–Q6b and Q17–Q20 above.

24. **`AGENTS.md`** (§4.1).
    - (a) The eleven items of §4.1, with item 11 ("update the next prompt") also a "done when" line in every recurring prompt; no hooks.
    - (b) The same, plus one deterministic check, for example a `Stop` hook that runs `lake build`.
    - (c) Item 11 in `AGENTS.md` only, added to "done when" only if sessions are seen skipping it (anthropic-guidance's suggestion).

    **Recommended: (a)**.
25. **`PLAN.md`** (§4.2).
    - (a) Move its content as §4.2 says, delete it, and add a short committed `STATUS.md`.
    - (b) Keep a short `PLAN.md` as the one record of decisions, and leave `notes/workflow.md` as history.

    **Recommended: (a)**.
26. **Notes in public** (§4.6). **Decided by the owner on 2026-11-08: (b).** The notes are public after removing the judgements about named people and the owner's private set-up details; judgements of projects and code stay.