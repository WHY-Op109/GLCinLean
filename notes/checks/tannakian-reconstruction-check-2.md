# Check 2 of `proposal/tannakian-reconstruction` (head `2b1e184`, first version `8d37e68`)

**Result.** No *mismatch* and no *unsure* remains. All nine nodes and the removal of `Satake.weightProjectives` are right as they now stand. My findings B1, B2, B3, the point of my section 6 and all nine improvements are resolved. One finding is blocking, and it is small: one proposed text for `STATUS.md` no longer fits `STATUS.md` after the merge of `main` (finding N1, with the exact wording). Six improvements can wait. I changed no file.

Worktree: `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a4d3b1753e8bf1a3d`. [DeligneMilne] was read in `/Users/why/Documents/Projects/GLCinLean/references/papers/DeligneMilne-2022-02-11/tc2022.txt` (line numbers below are of that file); [MV] in `references/papers/math-0401222v5/src/Satake.tex`; the roadmap in `MotivesAndAlgebraicCycles/README.md` at `fe56342a`.

## Blocking finding

**N1. The proposed “Audit” text does not fit `STATUS.md` at `550f64e`.** `notes/checks/tannakian-reconstruction-proposal.md`, section 5, says B6 “leaves the list of findings that are not applied” and quotes the sentence “B4 and B7 are changes of provider to accepted roadmaps (…)”. `STATUS.md` line 13 has no such sentence. It says: “The big findings B3 to B9 … still hold and are not applied. … B6 (Tannakian reconstruction) and B7 (compact generation of QCoh of a scheme) are with `prompts/change.md` on the local branches `proposal/tannakian-reconstruction` and `proposal/qcoh-compact-generation`. B4 is a change of provider …”. Applied as written, the text would record the state of B7 wrongly. Wording that resolves it:

> **“Audit”.** Replace “The big findings B3 to B9 of the audit of 2026-11-18 still hold and are not applied.” by “Of the big findings B3 to B9 of the audit of 2026-11-18, B6 (Tannakian reconstruction) is applied ("Decisions taken"); the others still hold and are not applied.” Replace “B6 (Tannakian reconstruction) and B7 (compact generation of QCoh of a scheme) are with `prompts/change.md` on the local branches `proposal/tannakian-reconstruction` and `proposal/qcoh-compact-generation`.” by “B7 (compact generation of QCoh of a scheme) is with `prompts/change.md` on the local branch `proposal/qcoh-compact-generation`.”

## 1. The findings of check 1

| Finding | State |
|---|---|
| B1, gap of [MV] §11 in the root file | resolved (item 4 below) |
| B2, `TauCeti.Coalgebra.isLinearlyReductive_iff_forall_nonempty_splitting` | resolved in `DualGroup.toml:6` and in the provider row; no other new name lacks a namespace (item 5) |
| B3, description of [DeligneMilne] | resolved; pages and hash verified (item 2) |
| Section 6, the sentence on what the projectives serve | resolved: `Equivalence.toml:6` now gives the plan's own reason, and section 7 of the proposal and the “Decisions taken” text name [MV] Remark 7.2 |
| Improvements 1, 2, 4, 5, 7, 8, 9 (biduality; the direction of the connectedness criterion; `μ_2` over any field; the universe of `R`; the name clash; the coefficient rings of [MV]; open doubt 1) | resolved |
| Improvement 3, “braided” follows | resolved for `U`; the equivalence of clauses (2) and (5) keeps it, which matches the roadmap's signature (`E.functor.Braided`) and is harmless |
| Improvement 6, coherence identities | resolved as far as this change should: `Satake.tannakaGroup` lists them and a proposed “Open items” entry names the two nodes whose writers state them |

## 2. The nodes as they now stand

**`Tannaka.neutralReconstruction`: *agree*.**
- Hypotheses and universes match `neutralTannakian_recognition` of `Suggested.lean` one by one (`Category.{u}`, `EssentiallySmall.{u}`, `H : Type u`, `FGComoduleCat.{u, u, u}`).
- Clause (3) is now the signature's own comparison: `E.functor ⋙ forget₂ _ (SemimoduleCat K) ≅ (ω ⋙ forget₂ _ (ModuleCat K)) ⋙ ModuleCat.equivalenceSemimoduleCat.functor`, monoidal. The pin supplies every functor in it as a braided functor: `FGComoduleCat.instForgetBraided` (`Finite/Symmetric.lean:90`) and Mathlib's `equivalenceSemimoduleCat.functor.Braided` (`ModuleCat/Monoidal/Symmetric.lean:120`).
- Clause (4): `pointsFunctorIsoTensorAutFunctor` has `k H : Type u`, value algebras in `CommAlgCat.{u} k`, and `GrpCat.uliftFunctor.{u + 1, u}`; the node says exactly this.
- Clause (5): the Yoneda argument is valid with test algebras in the universe of `K`, because `H` and `B` are in it.
- [DeligneMilne]: Definition 2.19 (line 1318), Theorem 2.11 (1101), Lemma 2.13 (1193), Proposition 2.14 (1217), Proposition 2.16 with footnote 12 (1254), Remark 2.17 (1300).
- Roadmap: §6.1 and §6.2 as quoted; `coalgebra_reconstruction` is named in §5.2 and its comparison is in `ModuleCat K`; §6.2 and §6.4 build the bialgebra before the antipode; the three dependency quotes exist (README lines 553, 1112, 1288).
- Trivial group: `C = FGModuleCat K`, `ω = id`, `B = K`. `FGModuleCat K` meets the hypotheses at the pin (symmetric monoidal in Mathlib, rigid in `TauCeti/Algebra/Category/FGModuleCat/Rigid.lean:57`).

**`Tannaka.finiteType_iff_exists_tensorGenerator`: *agree*.** “Which may differ from one summand to the next” is footnote 13 of Proposition 2.20 (line 1329): a subquotient of `P(X, X^∨)`, `P ∈ ℕ[t, s]`. The description of the faithfulness theorem matches its declaration (`Faithful/Basic.lean:232–324`: `CommRing k`, `CommRing H`, `HopfAlgebra k H`, `b : Basis (Fin d) k V`).

**`Tannaka.connected_iff_not_tensorClosed_hull`: *agree*.** Corollary 2.22 (line 1381). The new sentences are right: a group scheme that is not connected has a nontrivial finite étale quotient over any field, and the hull of its regular representation is the representations of that quotient (Propositions 2.20(a), 2.21(a)), closed under the tensor product. `Representation/LieStable.lean` is what the node says (connected, finite type, algebraically closed, characteristic 0).

**`Tannaka.reconstructionMap`: *agree*.** Proposition 2.21(b) (line 1348), Corollary 2.9 (1083).
- Directions. `U : D → C`, `V : E → D`. `g_U : Spec B_C → Spec B_D`, `g_V : Spec B_D → Spec B_E`, so `g_{U∘V} = g_V ∘ g_U : Spec B_C → Spec B_E`. `b_U : B_D → B_C`, `b_V : B_E → B_D`, so `b_{U∘V} = b_U ∘ b_V : B_E → B_C`. Both laws in the node are right.
- Trivial group: `C = FGModuleCat K`, `U = ω_D`, `b_U` is the counit `B_D → K`, `g_U` is the inclusion of the trivial subgroup, and the criterion holds.
- “Strong monoidal, hence braided” is right. `TauCeti.VecTwisted` matches its declaration (`k G : Type u`, `Monoid G`, a `TwistingCocycle` normalized in the middle variable, a `MonoidalCategory` instance, no braiding).

**`Satake.tannakaGroup`: *same object, different presentation*.** [MV] line 2642 for the source; lines 1084–1085 for “commutative Noetherian rings of finite global dimension, [MV] §2”. The PGL_2 check is right (degrees −1 and 1).

**`Satake.sphericalHeartDual`: *agree*.**
- Pairings against Mathlib (`Monoidal/Rigid/Basic.lean:77–85`): `ExactPairing X Y` has `coevaluation' : 𝟙 ⟶ X ⊗ Y` and `evaluation' : Y ⊗ X ⟶ 𝟙`. The node's `IC_0 → A ⋆ A^∨` and `A^∨ ⋆ A → IC_0` are `ExactPairing A A^∨`, which is `HasRightDual A` (line 236). `ExactPairing A^∨ A` is `HasLeftDual A` (line 242). Both are as the node says.
- Adjunction. Mathlib's `tensorRightAdjunction Y Y' : tensorRight Y ⊣ tensorRight Y'` for `ExactPairing Y Y'` (line 464) is the node's `− ⋆ B ⊣ − ⋆ B^∨`. Unit at `IC_0`: `IC_0 → (IC_0 ⋆ B) ⋆ B^∨ ≅ B ⋆ B^∨`. Counit at `IC_0`: `(IC_0 ⋆ B^∨) ⋆ B ≅ B^∨ ⋆ B → IC_0`. Both agree with the node.
- At the unit object: `IC_0^∨ = IC_0`, and the pairing is the unit constraint and its inverse. Trivial group: `V^∨ = V^*`, `k → V ⊗ V^*`, `V^* ⊗ V → k`, the orientation of Mathlib's `FGModuleCatCoevaluation` and `FGModuleCatEvaluation`.
- The second pairing through `(A^∨)^∨ ≅ A` is valid.
- [MV] lines 3435–3458; [DeligneMilne] Definition 1.7 (472), Proposition 1.20 with footnote 5 (774), Remark 2.18 (1303). GeometricSatakeAndFusion §2.10 has the quoted words.
- New `deps` `DModules.EquivariantIndscheme` and `DModules.holonomicShriek` exist.

**`Satake.cohomologyFiberFunctor`: *same object, different presentation*.** Codomains: `F` to `FGModuleCat k` (Mathlib); `F_gr` to `FGComoduleCat k` of `MonoidAlgebra k (Multiplicative X_*(T))` (Tau Ceti; `DirectSum.IsInternal.monoidAlgebraComodule` takes `MonoidAlgebra R G` for a type `G` with `DecidableEq`). Neither needs a plan node. The comparison in `SemimoduleCat k` uses only functors that are braided at the pin, so “F_gr is braided” follows as the node says. At `IC_0`: `F(IC_0) ≅ k` and `F_gr(IC_0)` is `k` in weight 0, the unit comodule. Trivial group: `F = id`.

**`Satake.tannakaRootDatum_equiv_dual`: *agree*, same strength as on `main`.** The step for the torus now names every functor: `D` the heart, `C` the comodules of `k[X_*(T)]`, `U = F_gr`, `ω_C` the forgetful functor of the prerequisite, and `ω_C ∘ U ≅ ω_D`. The map is `B_D → B_C = k[X_*(T)]`, that is the dual torus to the Tannakian group. Trivial group: `k → k`. The connectedness step cites the direction that holds over every field.

**`Satake.geometricSatakeHeartEquivalence`: *agree*.**

**Removal of `Satake.weightProjectives`: *agree*.** Nothing in `plans/` or `plans-proof/` names or needs it.

## 3. The rename

No file uses `Satake.convolutionDual` except the notes of earlier rounds (`…-check-1.md`, `…-answers-1.md`) and one sentence of the proposal that records the rename. `plans/`, `plans-proof/`, `docs/`, `STATUS.md`, `prompts/`, `tools/` and the Lean sources have none. `Satake.sphericalHeartDual` spells the concept (the dual of an object of the spherical heart), is not named after a source, and fits the other plan names (`Satake.sphericalHeart_semisimple`, `Satake.tannakaGroup`). *Agree*.

## 4. The entry in `GLCinLean.lean`

- Accurate against [MV] 3435–3458: the anti-involution is defined on `P^{k-proj}`; the sentence on `Rep^{k-proj}` “on finitely generated projective k-modules” is quoted in substance; no map and no identity is given. [MV] §7 (lines 2636–2643) does use Proposition 1.20.
- Heading: “Errors and gaps found in the sources”. Right.
- Form: key and number, what is missing, no status text and no history. It names no declaration, which the rule allows until one exists.
- `git diff 550f64e 2b1e184 -- GLCinLean.lean GLCinLean/` shows these nine comment lines and nothing else. No declaration changed. `lake build` passes in the worktree (8,307 jobs; the only warning is the `sorry` of the main theorem). I did not run `lake lint` or the axioms check.

## 5. Descriptions of pinned declarations

I opened each declaration. All match, with one inexact description (improvement I2). Names were compared with the namespaces open at each declaration.
- `ModuleCat.equivalenceSemimoduleCat` (`Mathlib/Algebra/Category/ModuleCat/Basic.lean:204`): `ModuleCat.{v} R ≌ SemimoduleCat.{v} R`. Right.
- `FGModuleCat`: `[Ring R]`; monoidal for `[CommRing R]` as a full subcategory (`isFG R).IsMonoidal`), symmetric by `fullSymmetricSubcategory`. Right.
- `TauCeti.Comodule.convolutionActionEquiv`: `[Module.Projective R C] [Module.Finite R C] [Coalgebra R C]`, `Comodule R C M ≃ (WithConv (Module.Dual R C) →ₐ[R] Module.End R M)`: right coactions against left actions of the dual algebra, any module `M`. Right.
- `TauCeti.FGComoduleCat.corestrict (f : C →ₗc[R] D) : FGComoduleCat R C ⥤ FGComoduleCat R D`. Right.
- `DirectSum.IsInternal.monoidAlgebraComodule`: root namespace, `G` a type. Right.
- `TauCeti.geometricallyConnectedCommHopfAlgProperty`: extensions `K : Type u` in the universe of `k`. Right.
- `TauCeti.VecTwisted`, `TauCeti.Tannaka.pointsFunctorIsoTensorAutFunctor`, `TauCeti.Tannaka.fgPointTensorIsoEquiv`, `TauCeti.reductiveCommHopfAlgProperty_iff_linearlyReductive`, `TauCeti.Coalgebra.isLinearlyReductive_iff_forall_nonempty_splitting`, the `Functor.Braided` row (characteristic 2 remark), the `Representation/Tannaka` count (14 files and `SchemePoints.lean`): right.
- `python3 tools/check-upstream-names.py`: 199 pairs, 0 not confirmed.

## 6. `plans-proof/`

*Agree.* The new sentences of `SpectralProof.geometricCenter_operMap` and of the README state what is open, and they are true: [DeligneMilne] Theorem 3.2(a) (line 1642) is the torsor `Hom^⊗(ω, η)` for a fibre functor `η` with values in finite projective modules over `R`; the roadmap's §6.8, second paragraph, states it (“Construct `Isom^⊗(ω_R,η)` as an affine faithfully flat right `G_ω,R`-torsor”); the Satake nodes are stated over an algebraically closed field. No node is added, so this is the smallest fix. The statement's plan is unaffected: the tracker does not read `plans-proof/`, no node of `plans/` depends on it, and `lake exe tracker lint` has 0 errors (171 module plans, 287 nodes, 0 cycles).

## 7. The proposed texts

- **Counts: right.** 287 nodes in 171 module plans; 216 under `plans/GLCinLean/`, 31 of them the statement; 71 in ten folders of `plans/Roadmap/`; 215 of the 216 have a roadmap node below them (I computed it; the other is `CategoryTheory.tensorPowFunctor`).
- **“Decisions taken”: states what the branch does.** `⟨n⟩` is still to be filled.
- **“Open items”: each is true**, except that the last one can now be a fact (I1).
- **“Audit”: N1 above.**
- **Worker entry.** The Worker has a limit. `tauceti_worker/config.py:102` sets `EXTRA_ROADMAP_PROMPT_MAX_CHARS = 4096`; `validate_extra_roadmap_prompt` strips the text and counts characters; `worker_manager.py:231–240` applies it to the `extra_roadmap_prompt` field of `workers.toml`, so `tauceti workers apply --check` rejects a longer text. The guidance has 3,901 characters, so it passes with 195 to spare. I read the installed source only; I did not find `docs/workers.md` on this machine.

## Improvements that can wait

- **I1.** Replace the open item “Shorten it if the Worker has a limit” and the same remark in section 6 by the fact: “The Worker's limit is 4,096 characters (`EXTRA_ROADMAP_PROMPT_MAX_CHARS`); the guidance has 3,901.” A later addition of more than 195 characters fails the check.
- **I2.** The row of `TauCeti.ConvolutionDual` and the same words in `NeutralReconstruction.toml:6` call it “the dual of a finite projective algebra, as a coalgebra”. The declaration is the linear dual `WithConv (Module.Dual k H)` of any module, with convolution multiplication when `H` is a coalgebra. The coalgebra structure for a finite projective algebra is the instance `TauCeti.ConvolutionDual.instCoalgebra` (`FiniteDual/Basic.lean:284`, with `Δ(φ)(x ⊗ y) = φ(xy)`). Suggested wording: “The linear dual with the convolution product; for a finite projective algebra, `ConvolutionDual.instCoalgebra` makes it a coalgebra.”
- **I3.** `GLCinLean.lean` line 90 breaks after “It gives no”. Reflow the paragraph to the 100-character width.
- **I4.** If the worker is started, the sentence of `STATUS.md` “Each `extra_roadmap_prompt` names only targets of the plan” needs an exception: this guidance also names one prerequisite (step 1) and `coalgebra_reconstruction` of §5.2 (step 3).
- **I5.** The row of `TauCeti.Coalgebra.isLinearlyReductive_iff_forall_nonempty_splitting` could add “for comodules with carriers in the universe of the field” (`IsLinearlyReductive.{u, v, u}`, `FGComoduleCat.{u, v, u}`).
- **I6.** `SpectralProof.geometricCenter_operMap` keeps `Satake.tannakaGroup` in its `deps`, but its objects `F_V` come from `Satake.geometricSatakeHeartEquivalence`, and its torsor is for the specified dual group. This is older than the branch and belongs to the start of the proof.
