# Answers to round 4 on `proposal/loop-group-provider`

The reports are `loop-group-provider-codex-4.md` (one blocking objection, one improvement) and `loop-group-provider-check-2.md` (no *mismatch*, no *unsure*, three follow-ups), both on commit `e8b53f9`. All five points are applied. `main` at `6712788` is merged into the branch.

## Codex

**The parabolic IC node asserted that no equivalence exists.** Fixed. Checked against [GLC3] §1.1: §1.1.2 gives the square root of `det_{Gr_{G,M}}` as a ℤ-graded, hence super, factorization line bundle with grading `⟨λ, 2ρ̌_P⟩`; §1.1.4 says that, because it factorizes only as a super line bundle, the identification of the gerbes that it gives is incompatible with factorization; §1.1.5 corrects the Jacquet functor by the shift `[⟨λ, 2ρ̌_P⟩]`, which is compatible with factorization. So the source supports only that the identification without the shift need not preserve factorization.
- `plans-proof/GLCinLean/GeometricLanglands/SemiInfinite/ParabolicIC.toml`, `SemiInfinite.parabolicIC`: the sentence now says this, names the shift of §1.1.5, and says that the node does not transport the results of [ParabolicEisensteinFH] from the untwisted setting but proves them directly in the half-twisted setting. It no longer says that no factorization equivalence relates the two settings.
- The search of `plans/`, `plans-proof/`, `docs/blueprint-providers.md`, the proposal and the root file for another sentence that asserts that such an equivalence does not exist found none. `plans/GLCinLean/GeometricLanglands/Automorphic/Category.toml` says that the Hecke action "is not transported along this equivalence", which is a choice of construction and not a claim of non-existence. The answers of round 3 quote the earlier wording; they are not edited, and this file is the correction.

**Improvement, `Satake.criticalTwistBunDeterminantEquiv`.** Applied. `plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml`: the sentence begins "The construction retains the half twist for every G".

## Checker

**A. The Beauville–Laszlo comparison was asked twice.** Fixed.
- `plans/GLCinLean/GeometricLanglands/Hecke/Correspondence.toml`, `Hecke.Correspondence`: the sentence "Prove the Beauville–Laszlo comparison: after a choice of coordinate at a point x of X, …" is removed. Nothing else of the node changes; its dependencies and its source are as before.
- `plans/GLCinLean/GeometricLanglands/Hecke/LoopGroupAction.toml`, `Hecke.loopGroupAction` (4): the comparison at a point with a coordinate is stated there as a consequence of (1), (3) and the comparison (5) of `LoopGroups.RanLoopGroup`, with the action and the orbit map; the same for an S-point with a coordinate along it.
- The users of `Hecke.Correspondence`, each checked for the removed fact:
  - `Satake.fusion` uses the fibres of the Beilinson–Drinfeld Grassmannian at the points and on the diagonals. It now depends on `Hecke.loopGroupAction` (`plans/GLCinLean/GeometricLanglands/Satake/Fusion.toml`).
  - `Satake.factorizationSphericalCategory` and `Satake.criticalTwistBunDeterminantEquiv` depend on `Hecke.loopGroupAction` since rounds 1 and 2.
  - `Hecke.sphericalAction` reaches it through both of them.
  - `Hecke.correspondence_pseudoProper` is not changed. Its text uses that the Beilinson–Drinfeld Grassmannian is ind-proper over `S × X^I`, and not the comparison at a point. It is in the module of `Hecke.Correspondence`, so a dependency on `Hecke.loopGroupAction` is a cycle of modules; `tools/check-module-cycles.py` reported it when I tried.
  - No node of `plans-proof/` depends on `Hecke.Correspondence` directly.

**B. Two sentences of the decision, and an open item.** Applied in `notes/checks/loop-group-provider-proposal.md` §7: the proposed "Decisions taken" entry says that the held `GLCinLean.AffineGrassmannian` now reads as a classical ind-scheme with the induced action of `Aut(O)` and stays held, and that `Hecke.loopGroupAction` takes its Beauville–Laszlo input from roadmap AInfCohomology §AI.2.1, which has no code and no author worker of ours. A proposed entry of "Open items" on this input follows the entry of the decision.

**C. The checks for 𝔾_a and the piece of level 0.** Applied in the worker guidance of the proposal, §8, step (5): "LG_(<=0) is L+G", and the two checks for G_a (the pieces for the generator `x`, and the piece of level 1 for the generators `x` and `x^2`, which is not reduced).

## The merge of `main`

`git merge main`, one merge commit, no rebase. `STATUS.md` is the file of `main`, unchanged. The one conflict was in `docs/blueprint-providers.md`, in seven places; every fact of both sides is kept:
1. Snapshot: the two rows of `main` (Tau Ceti at the pin, TauCetiRoadmap at `fe56342a`), then the row of this branch on FormalConnectionsOpers and ReductiveGroupsPartII RG2.0a.
2. The paragraph "Checked on …" under "Roadmaps that own plan nodes": the paragraph of `main`. Its first sentence (checked on 2026-11-19 against `fe56342a`) contains the clause that this branch had added for the row of FormalConnectionsOpers.
3. The ready modules: the four rows of `main` (among them `Roadmap.GeneralizedCohomology.Mapping`), and the row `Roadmap.FormalConnectionsOpers.FormalLoopGroups` of this branch in its alphabetical place.
4. The paragraph of "Accepted roadmaps that cover nodes written here": the text of `main` with its second check of 2026-11-19, and the three insertions of this branch ("of this table", where the loop groups are, the two rows on the loop Grassmannian). I compared the READMEs of FormalConnectionsOpers and EndoscopicTransferAndUnitaryTraceComparison at the two snapshots; they are the same files, so the sentence of `main` that none of these READMEs changed also holds for the two added rows.
5. The sentence after "Roadmaps that nodes here use as inputs": the two sections on Beauville–Laszlo of this branch, and "exist at `fe56342a`, where none of their READMEs changed since `87035f35`" of `main`.
6. Open roadmap pull requests: the row of #1734 of this branch, which has the facts of `main`'s row (the head `e16543f1`, the same §3.0 as at `83dc9e6f`); the rows of #1687 and #2450 of `main`, with their new heads.
7. Roadmap candidates: the rows of `main`; in row 7 the counts and the owner of this branch, with the date of the state of `main`.

## After the merge

- **Counts.** 287 planned declarations in 171 module plans: 218 under `plans/GLCinLean/` and 69 under `plans/Roadmap/`, in ten roadmap areas. Of the 218 nodes written here, 217 have a roadmap node below them; the other is `CategoryTheory.tensorPowFunctor` (computed from the dependencies). Proposal §§6 and 7 have these numbers.
- **`lake exe tracker lint`:** no errors; 61 warnings on the superseded fields of the 31 existing declarations of the statement.
- **`python3 tools/check-module-cycles.py`:** 171 module plans, 287 nodes, 0 cycles.
- **`python3 tools/check-upstream-names.py`:** 213 pairs of a declaration and its module; 0 not confirmed; exit status 0.
- **The done check of "Builds":** `lake build` succeeds with one warning, the `sorry` of the main theorem; `lake lint` passes; `lake env lean tools/check-statement-axioms.lean` lists 31 declarations and shows `sorryAx` only for the main theorem, with `propext`, `Classical.choice` and `Quot.sound`.
