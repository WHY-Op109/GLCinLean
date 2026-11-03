# Re-check of sources and revisions to the recommendations

*Claude Code, 2 November 2026. Re-checks everything relied on in the reports of 28–29 October. Tags: [R] inspected directly; [S] a document's claim about itself; [J] judgement. Earlier reports are not edited; this file supersedes them where they conflict.*

## 0. Verdict

**The strategy stands. Three operational parts need revising, because Tau Ceti's code moved much faster than its own status files show.**

1. **The ∞-categorical layer has crossed a milestone.** The dg nerve, its quasicategory property and the enhancement of derived categories merged between 29 and 31 October, sorry-free. So "pilot on the dg nerve" is obsolete, and the Phase C trigger for the enhanced layer is partly met.
2. **Tau Ceti's STATUS files are stale.** None of the GLC-path STATUS files has been regenerated since 23–26 October, although the relevant code changed daily. Plan from the commit log and the code, not from STATUS.
3. **The D-module entry point has shifted again.** The FormalConnectionsOpers roadmap was rewritten, and the basic differential-operator API now sits in a second open roadmap. Separately, `itpplasma/algebraic-analysis` published a full Weyl algebra library today. Your Mathlib Weyl-algebra contribution should be repositioned around these facts.

Nothing else changed: there is still no GLC roadmap, no GLC statement in any proof assistant, and no new outside effort.

## 1. What changed since 29 October

### 1.1 Tau Ceti code [R]

Clone of `TauCetiProject/TauCeti`, `main` at `36bbd863` (2 Nov 2026). There were 3,193 commits from 29 Oct to 2 Nov, about 800 a day with a peak of 1,107 on 31 Oct, against ≈ 316 a day the week before. GLC-path merges:

| Layer | Merged | What it actually states |
|---|---|---|
| Enhanced derived categories | #19054 dg nerve (29 Oct); #23073 "the differential graded nerve is a quasicategory" (30 Oct); #23138 its homotopy category (30 Oct); #24273 and `TauCeti/CategoryTheory/DG/CochainComplex/KInjective.lean` (31 Oct) | `instance dgNerve.quasicategory` for any `R`-linear DG category; `dgNerve.homotopyCategoryEquiv` (homotopy category of the dg nerve ≃ $H^0$); `KInjectiveDGCategory.dgNerveHomotopyCategoryEquiv`: for an `R`-linear abelian category with K-injective resolutions, the dg nerve of K-injective complexes is a quasicategory with homotopy category `DerivedCategory C`. **0 `sorry`** in these files. The K-injective-resolution hypothesis is a typeclass; unbounded module replacements were constructed separately (#22881, 30 Oct). |
| | Also: DG bimodules as a linear monoidal category (2 Nov); pretriangulated envelope (1 Nov) | |
| Stacks | #22558 (30 Oct): `SchPseudofunctor`, the carrier for prestacks and stacks on schemes (a type abbreviation only); the pseudofunctor of quasi-coherent modules on schemes; #25487 (2 Nov): `RepresentableDiagonal`, `EtaleAtlas` for presheaves on schemes (0 `sorry`) | First rung of SchemeAndStackFoundations Layer 1. No algebraic stacks, torsors or quotient stacks yet. |
| Reductive groups | Coweight lattice of a root datum (31 Oct); conjugacy of maximal tori in unitary groups (30 Oct); pseudo-reductive quotient (29 Oct) | The root datum of a general reductive group is still missing. |
| Curves/Jacobian | Base change of relative and rigidified Picard functors (31 Oct) | |
| AffineLieAlgebras (proof stage) | Completed enveloping algebra and its ring structure (31 Oct); smooth modules as modules over the completion (31 Oct); centre of the completed enveloping algebra and its action on smooth modules (1 Nov); finitely generated smooth modules by congruence quotients (1 Nov); vacuum module of the residue extension (2 Nov) | A3–A6 have started; the STATUS file of 26 Oct still says they are "untouched". |

**STATUS staleness** [R]. Last STATUS.md commits: EnhancedDerivedSheaves 23 Oct, SchemeAndStackFoundations 25 Oct, ReductiveGroups 26 Oct, GeometricRepresentationCategories 26 Oct, AffineLieAlgebras 26 Oct, JacobianChallenge 26 Oct, AlgebraicCurves 23 Oct.

### 1.2 Tau Ceti roadmaps [R]

- **No new roadmap or target** mentions geometric Langlands, D-modules, IndCoh, Bun_G of a curve or LocSys. 50 roadmap PRs were opened 29 Oct–2 Nov; the GRT-adjacent ones are p-curvature (#1747, mycaule) and a Scholze-functor roadmap (#1757, CBirkbeck).
- **The insiders' Langlands-adjacent PRs remain open and unreviewed**, with updates on 1–2 Nov: #1202, #1230, #1235, #1241, #1252, #1490 (all REVIEW_REQUIRED), and the EnhancedDerivedSheaves amendment #1630.
- **FormalConnectionsOpers #1056 was rewritten** on 31 Oct (1,094 → 2,515 lines) and is still CHANGES_REQUESTED. The new version moves the characteristic-free order predicate on differential operators, principal parts and the universal jet to **ComplexComparisonPartII C5.1**, which is open roadmap PR #848 (`awaiting-review`, `awaiting-dependencies`). FCO Layer 2 keeps symbols, $\mathrm{gr}\,D_X \cong \mathrm{Sym}\,T_X$, the Atiyah sequence and the Lie–Rinehart enveloping algebra, and still says "These are targets here, not dependencies on an unnamed D-module roadmap." The refreshed copy is in `references/tau-ceti/FormalConnectionsOpers-PR1056/README.md`.
- **Unchanged:** GRC and AffineLieAlgebras READMEs (last change 19 Oct); roadmap README/CONTRIBUTING rules (only automated list syncs); TauCeti README and AGENTS.md (no commits since 29 Oct); target filing still restricted to the `humans` team plus roed-math; latest tag still `v4.36.0-rc1`.

### 1.3 Outside Tau Ceti [R]

| Source | Change |
|---|---|
| `itpplasma/algebraic-analysis` | **2 Nov 2026, PR #15: "Add the Weyl algebra: presentation, Bernstein symbol, Noetherian, Kdim ≤ ω, simplicity"**, about 5,000 lines in `AlgebraicAnalysis/Weyl/` (presentation, PBW, Bernstein filtration and associated graded, simplicity, Ore tower), extracted from their `stafford38-formal` repository, Apache-2.0. Affine/polynomial level only. |
| Mathlib | Still no Weyl algebra or D-module PR. Presentability work continues (#45538, #45545, #45562, #30847, #43938); nothing on stable ∞-categories, quasicategory limits or stacks. |
| openai/math | Update of 29–30 Oct: revisions to other families, 6 new formalisations; families 014 and 069 unchanged; still no Langlands entry in `formalization.yaml`. |
| przchojecki/langlands; Langlandsproject; frenzymath; stacks-and-moduli; infinity-cosmos | No commits since 9 Feb, 19 Aug, 3 Sep, 23 Sep and 30 Sep respectively. |
| formal-conjectures | No GLC file or PR; arithmetic PRs #5368 (merged) and #5629 (open) only. |
| project-intentions | No Langlands, D-module, stack or derived entry. |
| GitHub repositories | No new repository on geometric Langlands. |

Not re-checked: the live Lean Zulip (needs the browser session), the arXiv sources of GLC I–V (versions unchanged on 29 Oct), and Scholze/Ben-Zvi/Raskin.

## 2. Re-evaluation of each recommendation

| Recommendation (28–29 Oct) | Still right? | Revision |
|---|---|---|
| Hybrid: agents on Tau Ceti code now; GLCinLean downstream for the spec and theorem; foundational GRT roadmaps with an expert later; proof as separate decision | **Yes.** The pace of Tau Ceti's fleet on exactly the GLC-path layers strengthens it. | None. |
| Target: GLC I Conj. 1.6.7 over an algebraically closed field of characteristic 0, Gaitsgory–Rozenblyum conventions | Yes | None. |
| Pilot targets: dg nerve; algebraic spaces/torsors/stacks; root datum of a reductive group; Jacobian | **Partly obsolete.** The dg nerve and its enhancement are done; algebraic spaces have started. | Choose from the commit log and claims repository on the day. Open GLC-path rungs as of 2 Nov: **stability and presentability** of the dg-nerve enhancement; enhancement of $D(\mathcal O_X)$ / $D_{qc}$ on schemes (EnhancedDerivedSheaves E1); **fppf torsors, algebraic stacks and quotient stacks** (SchemeAndStackFoundations Layer 1); root datum of a reductive group; Jacobian representability. At ≈ 800 merges a day, check claims immediately before starting, or your agents will collide with the operators' fleet. |
| Phase C trigger (i): "dg nerve → $D_\infty(\mathcal O)$ enhancement and presentability merged in code" | **Partly met** (dg nerve, quasicategory, enhancement of $D(C)$) | Split it: (i-a) stable and presentable structure on the enhanced category; (i-b) enhancement of quasi-coherent derived categories of schemes. Both still open. |
| Phase C trigger (ii): algebraic stacks and torsors merged | Not met; first rung landed 2 Nov | Unchanged. |
| Use STATUS files to read progress | **No longer reliable** | Use `git log` on TauCeti `main` filtered by roadmap area, plus the code. Add this to `AGENTS.md` and to the watchlist. |
| D-modules: "consume FCO F2, start from D-module categories" | Direction right, owners changed | Coordinate with **two** open roadmaps: ComplexComparisonPartII C5.1 (#848; order predicate, principal parts) and FCO Layer 2 (#1056; symbols, $\mathrm{gr}\,D_X$, Lie–Rinehart). Both are unmerged, so their scope can still move. A D-module *category* roadmap (left/right modules, functoriality, de Rham, holonomic, twisted, on stacks) remains unowned. |
| Finish the Weyl-algebra Mathlib contribution | **Revise** | Mathlib still has no Weyl algebra, so a Mathlib PR remains the one place you get human review. But a full Apache-2.0 Lean development appeared today. Before continuing: compare your construction with `AlgebraicAnalysis/Weyl/Presentation.lean` and `PBW.lean`; say in the Zulip thread that it exists; decide whether to upstream a minimal definition, citing theirs, rather than a parallel one. Its GLC value is modest: GLC needs sheaves of D-modules on schemes and stacks, not the affine Weyl algebra. |
| Do not pilot in itpplasma or frenzymath | Yes | itpplasma is an active, well-made library but still a two-person project with no contribution process. Cite it. |
| Chojecki atlas: link, do not copy | Yes | Unchanged; repo dormant. |
| formal-conjectures optional end state | Yes | Unchanged. |

### 2.1 Changes to the structure proposal

The proposal of 29 October holds. Three additions:

1. **`atlas/watchlist.yaml` should track code, not STATUS.** For each Tau Ceti layer, record the source directories (for example `TauCeti/AlgebraicTopology/DGNerve`, `TauCeti/CategoryTheory/DG`, `TauCeti/AlgebraicGeometry/AlgebraicSpace`, `TauCeti/AlgebraicGeometry/Stack`, `TauCeti/Algebra/Lie/Current`) and the last commit checked. A short script can run `git log --since` over those paths.
2. **`atlas/objects.yaml` needs a `hypotheses` field.** The new enhancement theorem holds under `[HasKInjectiveResolutions C]`. Results that hold under a typeclass hypothesis should record it, so a `constructed` status is not read as unconditional.
3. **`AGENTS.md` rule:** "Never cite a Tau Ceti STATUS file as current; confirm against the code at a recorded commit."

## 3. What would change the judgement now

The table in the 29 October review still applies, with two additions:

- **If the operators' fleet completes the stack layer (torsors, algebraic and quotient stacks) within weeks**, the stack-level D-module and Bun_G roadmaps become writable much sooner than expected, and recruiting an expert becomes the critical path.
- **If FCO #1056 or ComplexComparisonPartII #848 is merged with a D-module scope, or closed**, re-plan the D-module entry point accordingly.

## 4. Sources

TauCeti `main` at `36bbd8632db6b5adc339cbf1beafa59a02336daa` (2 Nov 2026), files `TauCeti/AlgebraicTopology/DGNerve/{Basic,HornFilling,HomotopyCategory,Nerve,Quasicategory}.lean`, `TauCeti/CategoryTheory/DG/CochainComplex/KInjective.lean`, `TauCeti/AlgebraicGeometry/AlgebraicSpace/Basic.lean`, `TauCeti/AlgebraicGeometry/Stack/Basic.lean`; TauCetiRoadmap `main` at `fa41b374` (30 Oct 2026) and PR heads #1056 (`1aab7da1`), #848, #1202, #1230, #1235, #1241, #1252, #1490, #1630; TauCetiRoadmapJobs `tauceti-roadmap.toml`; `itpplasma/algebraic-analysis` commit `5443734b` (2 Nov); `openai/math` `4eaee875` (30 Oct); Mathlib open PR searches; GitHub repository searches; formal-conjectures; project-intentions. Searches are index-limited; private work and the live Zulip were not checked in this pass.
