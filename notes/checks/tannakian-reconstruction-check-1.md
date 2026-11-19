# Check of `proposal/tannakian-reconstruction` (commit `8d37e68` on `ebbb29c`)

**Result.** I found no *mismatch* and no *unsure* in the mathematics of the nine new or changed plan nodes. The removal of `Satake.weightProjectives` is supported by the evidence. Three small findings are blocking under the task's definition (one rule breach, two wrong records); each has a one-line fix. The rest are improvements that can wait. No Lean file changed, so there is no blind reading. I changed no file.

Worktree: `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a4d3b1753e8bf1a3d`. Each node `desc` is one line of its file, so I cite `file:line` and quote the words.

## 1. Mismatch and unsure

None.

One source note. [DeligneMilne] is not in `references/`. I did not rely on memory: I downloaded the authors' corrected version of 2022 from jmilne.org to `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/dm-check/tc2022.pdf`. Its preface says "The numbering is unchanged from the original". Definition 1.7, Proposition 1.20, Corollary 2.9, Theorem 2.11, Lemma 2.13, Propositions 2.14 and 2.16, Definition 2.19, Propositions 2.20, 2.21, 2.23 and Corollary 2.22 all say what the nodes say. I did not see the 1982 print.

## 2. Blocking findings (each a small fix)

**B1. Breach of `AGENTS.md`, "Plan": a gap in a paper is not recorded in the root file.** `plans/GLCinLean/GeometricLanglands/Satake/Duals.toml:6` says "[MV] states the duality and gives no proof, so this proof is an explicit obligation". The source is `references/papers/math-0401222v5/src/Satake.tex` lines 3449–3459: "This involution makes Rep^{k-proj} … a rigid tensor category", with no argument. The rule says such a gap is recorded in the module doc comment of `GLCinLean.lean`. Its section "Errors and gaps found in the sources" (lines 68–84) has five items of exactly this kind ("is stated without proof") and no item for [MV] §11. Fix: add one item when the change is applied. Caveat: other "explicit obligation" nodes on `main` are also not all listed there, so the practice is uneven.

**B2. A wrong record: one upstream name lacks its namespace.** `plans/GLCinLean/GeometricLanglands/Satake/DualGroup.toml:6` (twice) and the new row of `docs/blueprint-providers.md` write `Coalgebra.isLinearlyReductive_iff_forall_nonempty_splitting`. In `TauCeti/Algebra/Coalgebra/Comodule/Finite/LinearlyReductive.lean` the declaration is inside `namespace TauCeti` (line 34) and `namespace Coalgebra` (line 127), at line 134. Its name is `TauCeti.Coalgebra.isLinearlyReductive_iff_forall_nonempty_splitting`. `tools/check-upstream-names.py` passes because it accepts a name that lacks leading namespaces. The other new names are exact, including `DirectSum.IsInternal.monoidAlgebraComodule`, which is in the root namespace.

**B3. A wrong record after this change: the description of [DeligneMilne].** `docs/papers.md:61` and the `note` of `docs/references.bib:410` say the paper is cited "through [MV] §7" for Propositions 2.20, 2.23 and Corollary 2.22. On the branch, four roadmap nodes have [DeligneMilne] as their only `source`, and `Satake.tannakaGroup` and `Satake.convolutionDual` cite Definitions 1.7 and 2.19, Proposition 1.20, Corollary 2.9, Theorem 2.11, Lemma 2.13 and Propositions 2.14, 2.16, 2.21. Fix: update both lines. Better: pin the 2022 corrected version in `references/`, since the plan now rests on it. That version also records two errors of the 1982 original: Proposition 1.20 was false as first stated (footnote 5: the object `U` must be an identity object), and the proof of Proposition 2.16 made an incorrect claim (footnote 12).

## 3. Verdict for each node

| Node | Verdict |
|---|---|
| `Tannaka.neutralReconstruction` (`plans/Roadmap/MotivesAndAlgebraicCycles/NeutralReconstruction.toml:6`) | *agree* with the roadmap §§6.1–6.2 and [DeligneMilne] Theorem 2.11 |
| `Tannaka.finiteType_iff_exists_tensorGenerator` (`TensorGeneration.toml:6`) | *agree* with §6.3 and Proposition 2.20(b) |
| `Tannaka.connected_iff_not_tensorClosed_hull` (`TensorGeneration.toml:13`) | *agree* with §6.3 and Corollary 2.22 |
| `Tannaka.reconstructionMap` (`FiberFunctoriality.toml:6`) | *agree* with §6.3 and Proposition 2.21(b), Corollary 2.9 |
| `Satake.tannakaGroup` (`Satake/Reconstruction.toml:6`) | *same object, different presentation*: the same Hopf algebra, equivalence and points as on `main`, by a different route |
| `Satake.convolutionDual` (`Satake/Duals.toml:6`) | *agree* with [MV] §11 lines 3437–3459, restricted to a field |
| `Satake.cohomologyFiberFunctor` (`Satake/FiberFunctor.toml:6`) | *same object, different presentation* |
| `Satake.tannakaRootDatum_equiv_dual` (`Satake/DualGroup.toml:6`) | *agree*; the same theorem at the same strength |
| `Satake.geometricSatakeHeartEquivalence` (`Satake/Equivalence.toml:6`) | *agree*; text only, `deps` unchanged |
| removal of `Satake.weightProjectives` | *agree* |

Degenerate cases. The zero category fails `End(𝟙) = K`. The trivial group gives `B = K`, the heart `FGModuleCat k`, no object in the connectedness criterion, and `r = 0` with the zero object as tensor generator; the nodes agree with each other on these conventions. Nothing under `GLCinLean/Statement/` changed, so no degenerate case touches the main theorem.

## 4. The eight items

**1. Removal of `Satake.weightProjectives`: agree, the evidence is enough.**
- Uses. `git grep weightProjectives ebbb29c` finds its own node, the `deps` of `Satake.tannakaGroup`, and one row of `docs/blueprint-providers.md`. On the branch only `notes/` mentions it.
- Search by content. I searched `plans/` and `plans-proof/` for projective objects, generators, covers and resolutions, for "Proposition 9.1", "Corollary 9.2", "Proposition 10.1", and for standard and costandard sheaves. No node needs them. The hits for "projective" in `plans-proof/` are projective modules and projective supports, not objects of the heart. `SpectralProof.geometricCenter_operMap` uses only the group and the tensor functor.
- [MV]. Line 2327: "the results of this present section are used in section 7 only in the case when k is a field". Line 2361 gives the Künneth step directly "when k is field"; lines 2383–2401 use Corollary 9.2 and Proposition 10.1 only for "the general case". Lines 2608–2612 and 2636–2643: §7 verifies Proposition 1.20 and Theorem 2.11 of [DM] and uses no projective. Lines 3300–3303: §11 works "over an arbitrary commutative ring", "made possible by the fact that F(P_Z(k)) is free". The only other use of the projectives is line 3523 (§12, over ℤ). So both claims of the planner are right.
- One caveat, see section 6: [MV] Remark 7.2 (lines 2629–2633).

**2. `Satake.convolutionDual`: agree.**
- A separate node is the right reading. On `main` the words were "prove the required tensor and rigidity constraints" inside the fibre-functor node. Rigidity is a property of the category that Theorem 2.11 needs; it does not use the fibre functor.
- The claim is true as stated. The pairing in the node (`A^∨ ⋆ A → IC_0`, `IC_0 → A ⋆ A^∨`) is Mathlib's `ExactPairing A A^∨`. The checks are right: `IC_λ^∨ = IC_{−w_0λ}`, the torus case, and the trivial group, where the heart is `FGModuleCat k` because `Satake.sphericalHeart` takes holonomic objects with finite Schubert support.
- The route is sound. The adjunction `Hom(A ⋆ B, C) ≅ Hom(A, C ⋆ B^∨)` holds in the derived category by the properness of the convolution map and Verdier duality, and passes to the heart because convolution is exact. The words "compatible with convolution on the left" are exactly what makes the unit and counit at `IC_0` satisfy the triangle identities.
- The planner's claims on the sources are right. [MV] §11 gives no proof. [BDHitchin] 5.3.22 (text extraction lines 7878–7880) only cites [MV]. [DeligneMilne] Remark 2.18 proves Proposition 1.20 through "the affine monoid scheme representing End^⊗(ω)". GeometricSatakeAndFusion §2.10 (README line 1567) uses the same shape of proof for its own category.

**3. `Satake.cohomologyFiberFunctor`, clause (e): the same object, no added claim.** [MV] Proposition 6.4 (lines 2433–2441): "The functor F: P → Mod_k(X_*(T)) is a tensor functor". The node fixes the plain symmetry (no sign) on the comodules of `k[X_*(T)]`; Tau Ceti's braiding on `FGComoduleCat` is the swap of the underlying modules (`Finite/Symmetric.lean`, `tensorBraiding`, `instForgetBraided`). This is the braiding under which `F` is a tensor functor to vector spaces with the usual symmetry: [MV] Lemma 6.1 (lines 2337–2340) gives the super sign for the constraint of §5, and Proposition 6.3 (lines 2411–2431) gives the usual symmetry for the corrected constraint; [BDHitchin] 5.3.21 says the same ("plain (not super) commutativity constraint"). Clause (d) and the PGL_2 check are right: the IC object of the odd component has cohomology in degrees ±1. The braiding of `F_gr` adds nothing: it follows from (d), because the forgetful functor is faithful and braided.

**4. `Tannaka.neutralReconstruction`: agree.**
- Hypotheses. Each matches `neutralTannakian_recognition` in `Suggested.lean`: `Category.{u}`, `EssentiallySmall.{u}`, `Abelian`, `Linear K`, `MonoidalPreadditive`, `MonoidalLinear K`, `SymmetricCategory`, `RigidCategory`, bijectivity of `c ↦ c • 𝟙`, and `ω : C ⥤ FGModuleCat K` braided, additive, linear, faithful, preserving finite limits and colimits. The README §6.1 (line 1118) gives the same definition and says "It contains no group or Hopf algebra".
- Conclusion. The headline is existential; the node asks for data, the points and uniqueness. The README supports clauses (1) to (4): §6.2 "The resulting affine group scheme G_ω=Spec B represents Aut^⊗(ω)", and "Downstream consumers" (line 1715) "This identifies their tensor-automorphism functors on every coefficient algebra". Clause (5) follows from (4) by Yoneda, and [DeligneMilne] Remark 2.17 is the check `B ≅ H`. The quoted check of §RD.2.52 exists (PadicDifferentialEquationsAndRigidCohomology README line 5649).
- The three criteria are named targets by the text of §6.3 (lines 1149–1153: "Prove that …", "construct G_C→G_D. Prove it … a closed immersion exactly when …"). They have no signature. The header of `Suggested.lean` says the README is the definitive document.
- The examples are right: super vector spaces (no braided functor exists at all, since the odd line has self-symmetry −1), ℕ-graded spaces (comodules of `K[t]`, not rigid), `K[ℚ]`.

**5. Quantifiers of the two criteria: agree.**
- Finite type. Proposition 2.20(b) with its footnote 13 is the node's definition, the dual included. `𝔾_m`, `K[ℚ]` and the trivial group (zero object, exponent 0) are right. `μ_2`, `α_p` and finite constant groups are of finite type and have a generator, in every characteristic.
- Connectedness. Corollary 2.22 quantifies over every `X` with nontrivial action; the node does the same and excludes exactly the sums of copies of `𝟙`, the zero object among them. `μ_2`: the sign character alone has a hull that is not closed, and `𝟙 ⊕ sign` has a closed hull, so the quantifier over all objects is needed. A nontrivial finite constant group: the regular representation. `α_p`: connected, finite, hull of the regular representation is everything, so the criterion fails in characteristic `p`. Characteristic 0 is needed only for "connected ⟹ criterion" (finite quotients are étale).
- "Connected implies geometrically connected, because of the rational point" is right, and `TauCeti.geometricallyConnectedCommHopfAlgProperty` is what the node says (`Connected/CommHopfAlgCat.lean:63`).

**6. `Satake.tannakaRootDatum_equiv_dual`: agree, same strength as `main`.** The first sentence is unchanged in content.
- Tensor generator: valid. The monoid of dominant coweights is finitely generated; `IC_λ` occurs in the ordered convolution, which is a summand of `X^{⊗Σk_i}`; semisimplicity gives the rest. No dual is needed.
- Hull: valid. A summand `IC_λ`, `λ ≠ 0`, would put the pairwise different `IC_{nλ}` in a hull with finitely many simple objects.
- Characters: valid. `ν = λ − μ`, `F_λ(IC_λ)` has dimension 1 ([MV] Theorem 3.2), and a monoidal functor preserves duals, so `F_gr(IC_λ ⋆ IC_μ^∨)` contains `ν`. The direction of `Tannaka.reconstructionMap` is right: `D` the heart, `C` the comodules of `k[X_*(T)]`, `U = F_gr`.
- Trivial group: `r = 0`, no object in the hull criterion, the character 0 in `F_gr(IC_0)`.
- The hypotheses of `TauCeti.reductiveCommHopfAlgProperty_iff_linearlyReductive` are as stated (`CharZero`, `FiniteTypeCommHopfAlgCat`, geometric connectedness; `Reductive/CompleteReducibility.lean:91–121`).

**7. Claims on Tau Ceti at the pin `b2350004`: confirmed, apart from B2.**
- `Representation/Tannaka` has 15 files and 3,334 lines. Every file takes a bialgebra or Hopf algebra `H` as a variable; `SchemePoints.lean` takes an affine group scheme.
- `FGComoduleCat`: no `Linear`, `MonoidalPreadditive` or `MonoidalLinear` instance (the only such instances in `TauCeti/Algebra` are for `HopfModuleCat` and `FiniteHopfModuleCat`, which are modules, not comodules); no `EssentiallySmall`; no statement on `End(𝟙)`; no functor to `FGModuleCat`. The exact forgetful functor goes to `ModuleCat` (`Finite/Abelian.lean:94–103`), the braided one to `SemimoduleCat` (`Finite/Symmetric.lean:90`). `Suggested.lean` itself bridges the two with `ModuleCat.equivalenceSemimoduleCat`.
- `python3 tools/check-upstream-names.py`: 197 pairs, 0 not confirmed. I also read the cited statements themselves.
- No structure for a fibre functor or a Tannakian category outside Galois categories and covering spaces.

**8. Options not chosen: agree.** (b) and (c) copy a roadmap target. (e): GeometricSatakeAndFusion takes §§6.1–6.4 because its coefficients are not fields. GeometricSatakeAndFusion is not a provider: its "Conventions" (README lines 72–82) fix a nonarchimedean local field and `Perf_k` with `k` the closure of `𝔽_q`; it has no D-module category. It divides the work as the branch does (line 1866 and §4.6, line 1943). It is the only roadmap whose subject is geometric Satake; I judged this from the count of mentions in all READMEs, not by reading each.

## 5. Checks run

`lake exe tracker lint`: 0 errors (171 module plans, 287 nodes). `python3 tools/check-module-cycles.py`: 0 cycles. `lake exe tracker ready` lists `Roadmap.MotivesAndAlgebraicCycles.NeutralReconstruction`. Counts: 71 nodes in ten folders of `plans/Roadmap/`, 216 under `plans/GLCinLean/`, as the proposed `STATUS.md` text says. I did not verify "215 of the 216 have a roadmap node below them".

## 6. Semisimplicity (not in scope)

No node decides the question by accident. The four `Tannaka` nodes, `Satake.convolutionDual`, `Satake.cohomologyFiberFunctor` and `Satake.tannakaGroup` do not use it. `Satake.tannakaRootDatum_equiv_dual` uses it in three named steps, and `main` already depended on it.

One point touches the question. [MV] Remark 7.2 (lines 2629–2633) says the route that avoids Lemma 7.1 goes through "the rest of the paper" and §12, which is the part that uses the projectives. So the sentence "they serve coefficient rings that are not fields of characteristic 0" (`Satake/Equivalence.toml:6`) is true of the main line of [MV] and not of that remark. The removal does not decide the question, but a later choice of that route must bring the node back through `prompts/change.md`. A safer wording gives the plan's reason: "are not used: over a field the group comes from `Tannaka.neutralReconstruction`".

## 7. Improvements that can wait

- `Satake.convolutionDual`: "a left dual and a right dual, both `A^∨`" needs `(A^∨)^∨ ≅ A` (biduality and `inv² = id`) or the mirror adjunction, since no commutativity is used. Say which.
- `Tannaka.connected_iff_not_tensorClosed_hull`: the direction "criterion ⟹ connected" holds in every characteristic, and it is the only direction the plan uses. The worker could state it without characteristic 0.
- `Tannaka.reconstructionMap` and clause (5): "braided" for `U` and for the equivalence follows from "monoidal over faithful braided fibre functors". It is harmless.
- `Tannaka.reconstructionMap`: the check for `𝔾_m → μ_2` does not need "characteristic different from 2".
- Clause (4): Tau Ceti's theorem takes `R` in the universe of `K`; the node says "every commutative K-algebra".
- `Satake.tannakaGroup` assigns `SymmetricCategory` to `Satake.fusion` and the monoidal structure to `Satake.convolution_preserves_perversity`. Those unchanged nodes do not yet name the hexagon identities, `c² = 1` or the pentagon.
- `Satake.convolutionDual` and `TauCeti.ConvolutionDual` are different concepts with nearly the same name, and the plan cites both.
- `Satake/Reconstruction.toml:6` says "every commutative ring of coefficients"; [MV] assumes Noetherian of finite global dimension (line 1085).
- Open doubt 1 of `notes/checks/tannakian-reconstruction-proposal.md` proposes "a small amount of general code here, to be offered upstream". That is the option (c) which the same note rejects under "Sources of code". If it happens, it needs its own `prompts/change.md`.
