# Answers to round 3: `proposal/tannakian-reconstruction`

Step 4 of `prompts/change.md`. The reports are `notes/checks/tannakian-reconstruction-codex-3.md` (Codex on `2b1e184`: five blocking objections, three improvements) and `notes/checks/tannakian-reconstruction-check-2.md` (the checker on `2b1e184`: one blocking finding N1, six improvements I1 to I6).

All findings are right. Each correction below uses the wording of the report, after a comparison with the source that the report cites. No node, construction or claim changed. In the list, “proposal” is `notes/checks/tannakian-reconstruction-proposal.md`.

## Codex

**1. `Tannaka.reconstructionMap` does not take comodules only.** Source: `plans/Roadmap/MotivesAndAlgebraicCycles/FiberFunctoriality.toml`; the node takes two categories with fibre functors that satisfy the hypotheses of `Tannaka.neutralReconstruction`, and one of its checks has `C = FGModuleCat K`.
- `plans/GLCinLean/GeometricLanglands/Satake/FiberFunctor.toml`: “the values of F_gr are comodules, the form that Tannaka.reconstructionMap takes.” is now “the values of F_gr are comodules. For the torus application take C = FGComoduleCat k k[X_*(T)] and U = F_gr. Clause (5) of Tannaka.neutralReconstruction identifies B_C with k[X_*(T)].”
- Proposal, section 2.3 (“Gradings and tori”): “is stated with values in comodules, the form that `Tannaka.reconstructionMap` takes.” is now “is stated with values in comodules.”, followed by the same two sentences.
- Proposal, doubt 8: “and `Tannaka.reconstructionMap` takes comodules.” is removed, and the same two sentences follow.
- No other sentence of `plans/`, `plans-proof/`, `docs/` or the root file has this claim.

**2. [MV] Proposition 9.1 and the limit.** Source: [MV], TeX lines 2972–2976 (“a closed subset which is a finite union of `G_O`-orbits”) and line 3356 (`B(k) = \varinjlim B_Z(k)`).
- Proposal, section 2.4: “on a finite union of orbits” is now “on a closed finite union `Z` of orbits”; “builds the coalgebra `B(k) = lim B_Z(k)` from them” is now “builds from them the coalgebra as the filtered colimit `B(k) = colim_Z B_Z(k)`”.
- No other sentence has this claim.

**3. The signature of `tensorAutFunctor`.** `notes/checks/tannakian-reconstruction-answers-2.md` is a record and is not edited. Its table row that groups `pointsFunctorIsoTensorAutFunctor`, `fgPointTensorIsoEquiv`, `tensorAutFunctor` and `reconstructedPoint` under one signature is wrong for `tensorAutFunctor`. The correct statement, from `TauCeti/Algebra/AlgebraicGroup/Representation/Tannaka/GroupFunctor.lean`, lines 57–63: `TauCeti.Tannaka.tensorAutFunctor` takes `(R : Type u) [CommRing R] (H : Type v) [Semiring H] [Bialgebra R H]` and has the type `CommAlgCat.{u} R ⥤ GrpCat.{max (u + 1) v}`. The field, the commutative Hopf algebra in the universe of the field and the lift of the points functor are hypotheses of the comparison `TauCeti.Tannaka.pointsFunctorIsoTensorAutFunctor`.
- No sentence of a node, of `docs/` or of the proposal has this error: none assigns the field, the commutative Hopf algebra or the one universe to `tensorAutFunctor`.

**4. Two steps assigned to the wrong place.** Source: `plans/GLCinLean/GeometricLanglands/Satake/DualGroup.toml`, node `Satake.dualIdentification` (“by the isomorphism theorem”); `lake exe tracker ready` lists `Roadmap.MotivesAndAlgebraicCycles.NeutralReconstruction`.
- Proposal, section 2.8: “Three steps inside `Satake.tannakaRootDatum_equiv_dual` are general … and the isomorphism theorem (`Groups.splitReductiveGroup`, roadmap ReductiveGroups).” is now “Two steps inside `Satake.tannakaRootDatum_equiv_dual` are general …” with the first two steps, followed by “The isomorphism theorem (`Groups.splitReductiveGroup`, roadmap ReductiveGroups) is used in `Satake.dualIdentification`, to lift the identification of the based root data to an isomorphism of pinned groups.”
- Proposal, section 3, option (a): “every dependency of `Satake.tannakaGroup` is behind D-modules, loop groups and the ∞-categorical layer.” is now “the geometric inputs to `Satake.tannakaGroup` wait for D-modules and loop groups. The abstract reconstruction module is ready independently.”
- No other sentence has these claims.

**5. What the search excluded.** Source: `TauCeti/CategoryTheory/Grothendieck/Pushforward.lean` (“Pushing sections forward along fiber functors”) and `TauCeti/Algebra/Coalgebra/Comodule/PointSeparation.lean` (“the scalar-extension fibre functor”).
- Proposal, section 2.3: “The files that match “fiber functor” are about Galois categories and covering spaces.” is now “The search also finds other uses of “fiber functor”, including Galois categories and covering spaces, indexed categories, and the scalar-extension functor of a given coalgebra. None of these supplies neutral reconstruction from an arbitrary marked category.”
- Proposal, doubt 9: “by seven phrases” is now “by the phrases listed in §2.3”.
- No other sentence has these claims.

**Improvements.** The first is a new line of the proposed “Open items” (essential smallness and `CategoryTheory.locallySmall_of_faithful`). The second: see N1; and in the proposal, doubt 7, “lacks five things for this (section 2.3)” is now “lacks the prerequisites listed in §2.3 for this”. The third names work that waits for its modules; nothing changes.

## The checker

**N1. The proposed text for “Audit”.** Proposal, section 5: the section no longer quotes a sentence of `STATUS.md`. Its first paragraph says that the session writes `STATUS.md` when the change is applied, from the state of `STATUS.md` at that time. The parts “Plan”, “Library” and “Audit” are replaced by two facts: “Audit finding B6 (Tannakian reconstruction) is applied by this change”, and the counts, unchanged (287 planned declarations in 171 module plans, one proved; 216 written here, 31 of them the statement; 71 in ten roadmap areas; 215 of the 216 with a roadmap node below them). The texts of the “Decisions taken” entry and of the “Open items” entries are kept.

**I1. The limit of the Worker.** Source: `tauceti_worker/config.py`, line 102, `EXTRA_ROADMAP_PROMPT_MAX_CHARS = 4096`. Proposal, section 5 (“Open items”) and section 6: the remark “the longest existing one has about 3,000” with “Shorten it if the Worker has a limit” is now “The Worker's limit is 4,096 characters (`EXTRA_ROADMAP_PROMPT_MAX_CHARS`)”, with the length of the guidance. That length is now 3,991 characters, not 3,901: the correction I2 below changed one phrase of the guidance.

**I2. `TauCeti.ConvolutionDual`.** Source: `TauCeti/Algebra/HopfAlgebra/FiniteDual/Basic.lean`, lines 56 and 284; the instance is `TauCeti.ConvolutionDual.instCoalgebra`.
- `docs/blueprint-providers.md`, the row of `TauCeti.ConvolutionDual`: “The dual of a finite projective algebra, as a coalgebra.” is now “The linear dual with the convolution product; for a finite projective algebra, `TauCeti.ConvolutionDual.instCoalgebra` makes it a coalgebra.”
- The same words, “the dual coalgebra of a finite projective algebra (`TauCeti.ConvolutionDual`)”, in `plans/Roadmap/MotivesAndAlgebraicCycles/NeutralReconstruction.toml`, in the row of the ready module in `docs/blueprint-providers.md`, in the proposal (section 2.3) and in the worker's guidance (section 6): each is now “the linear dual with the convolution product (`TauCeti.ConvolutionDual`), which `TauCeti.ConvolutionDual.instCoalgebra` makes a coalgebra for a finite projective algebra”, or the checker's sentence.

**I3. The entry in `GLCinLean.lean`.** The paragraph is reflowed to the width of 100 characters. Its words did not change.

**I4. A fact for `STATUS.md`.** Proposal, section 5 (“Workers”), a new sentence: “This guidance names, besides targets of the plan, one prerequisite (step 1) and `coalgebra_reconstruction` of §5.2 (step 3).”

**I5. The universe of the comodules.** Source: `IsLinearlyReductive.{u, v, u}` and `FGComoduleCat.{u, v, u}` in `TauCeti/Algebra/Coalgebra/Comodule/Finite/LinearlyReductive.lean`, line 134. The words “for comodules with carriers in the universe of the field” are added in three places with this claim: the row of `TauCeti.Coalgebra.isLinearlyReductive_iff_forall_nonempty_splitting` in `docs/blueprint-providers.md`; `Satake.tannakaRootDatum_equiv_dual` in `plans/GLCinLean/GeometricLanglands/Satake/DualGroup.toml`; the proposal, section 2.3.

**I6. The `deps` of `SpectralProof.geometricCenter_operMap`.** A new line of the proposed “Open items”, with the checker's words. The node is not changed.

## Checks before the commit

`lake build` passes with only the `sorry` warning of the main theorem; `lake lint` passes; `lake env lean tools/check-statement-axioms.lean` shows `sorryAx` for the main theorem only. `lake exe tracker lint` has no errors (171 module plans, 287 nodes). `python3 tools/check-module-cycles.py` finds no cycle. `python3 tools/check-upstream-names.py` confirms all 199 pairs. `main` is at `550f64e`, which the branch already contains.
