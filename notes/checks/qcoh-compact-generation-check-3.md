# Third check of `proposal/qcoh-compact-generation` (head `af3ac44`)

**Result in short.** No *mismatch* and no *unsure* verdict remains. Every node agrees with its source. B1 to B5 of my second report are resolved. Two small findings still block, each one sentence in a node written here, with the exact wording below (R1, R2). The rest are improvements that can wait. Sections 5 and 6 of the proposal are accurate.

I changed no file. `lake exe tracker lint`: 0 errors. `tools/check-module-cycles.py`: 176 module plans, 292 nodes, 0 cycles. `tools/check-upstream-names.py`: 198 pairs, 0 not confirmed. By my own script: 220 nodes here (31 the statement, 219 with a roadmap node below), 72 roadmap nodes in ten areas, no edge from a roadmap node to a node written here, no unknown dependency. I did not run `lake build`; the only Lean change is a module doc comment, and its lines are within 100 characters.

Sources read in this round: Higher Algebra 1.4.4.1 to 1.4.4.3 in `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/ha/HA.pdf`; [GRQCoh] Theorem 1.3.4, Corollaries 1.3.5 to 1.3.11 and Proposition 1.4.4; [RaskinCPSI] §§6.15 to 6.17; [CompactGeneration] §§1.1.7 and 1.2.2; SchemeKTheoryOperations README lines 205 to 217 and `Suggested.lean` lines 50 to 84; EnhancedDerivedSheaves README lines 425 to 496, 1155 to 1177 and 2010 to 2020; the Worker's `workers.toml` for the count.

## Blocking findings, with the wording that resolves each

**R1. `Infinity.isPresentable_of_compactGenerators` names a supplier that does not apply to one step.** `plans/GLCinLean/CategoryTheory/PresentableOfCompactGenerators.toml`: "the functor from its κ-Ind-completion (Infinity.indCompletion) to C is fully faithful and preserves small colimits, so it has a right adjoint (Infinity.rightAdjoint)".
- `Infinity.rightAdjoint` is the adjoint functor theorem "between presentable categories" (its node, and README line 1167: "Let `F : C → D` be a functor between presentable quasicategories"). Here the target C is the category that the theorem proves presentable, so that theorem cannot be used.
- Higher Algebra uses another statement at this step: "F admits a right adjoint G (Remark HTT.5.5.2.10)", the form with a locally small target.
- Replace the clause by: "so it has a right adjoint. C is not yet known to be presentable, so this is not `adjointFunctorTheorem`; it is the form with a locally small target (Higher Topos Theory, Remark 5.5.2.10): for each object y of C the functor Map(F(−), y) on the Ind-completion preserves small limits and has small values, so it is representable (`representable_iff_preservesLimits`, of the same section E3.2 as Infinity.rightAdjoint), and the representing objects give the right adjoint".
- The dependency `Infinity.rightAdjoint` stays; only the text changes. I gave this dependency in B5 without the distinction.

**R2. The sentence on the t-structure in `Sheaves.qcqsScheme_passable` is partly wrong and puts a general object in the wrong module.** `PassableScheme.toml`: "No node gives this t-structure; it is written with this lemma."
- The connective part of the modules is in the roadmap item behind `Derived.affineModules`: EnhancedDerivedSheaves E5:animation.4 `animatedModules`, README line 2010, "The connective part of `Mod_B` is the animation of the functor sending a pair (P, F) … to F". A t-structure written "with this lemma" would be a second definition of that part, and its home is not the module of a theorem on schemes ("Lean code": canonical home; never duplicate).
- What no node states is narrower: that this connective part is the connective half of a t-structure in the sense of `Infinity.tStructure`, and that localization at an element is t-exact.
- Replace the sentence by: "The connective part of these modules is that of `animatedModules` (E5:animation.4, the provider of Derived.affineModules). No node states that it is the connective half of a t-structure, nor that localization at an element is t-exact. This is an input of the lemma without a node; its home is beside Derived.affineModules, and it is not written in this module."
- Change the open item of section 6 in the same way: "has no node" stays; "and writes it with the lemma" becomes "and names it as an input without a node".

## 1. The findings of the second check

| Finding | State |
|---|---|
| B1 (perfect objects) | Resolved, with two nodes in a tenth area. |
| B2 (universe sentence) | Resolved in the node and in step (e) of the guidance. |
| B3 (small Hom sets) | Resolved; one account (item 3). |
| B4 (helper lemma) | Resolved in substance; R2 is what remains. |
| B5 (presentability) | Resolved by a node of its own; R1 is what remains. |
| Precision 1 (Lemma 36.13.8, tag 08EI) | Resolved in the node, its `source`, the providers document, the guidance and the decision. |
| Precision 2 (Lemma 36.15.2; the supported generator) | Resolved. |
| The statement nodes | Resolved: the open item names the six nodes; I confirmed each by the closure. |
| I7 | Resolved. |
| I6, I8, the `desc` of `Sheaves.properPerfectPushforward` | Listed as open items; acceptable. |

**The two departures.**
- `Sheaves.IsPerfectComplex` without `deps`: right. The predicate of `Suggested.lean` line 63 is on `CochainComplex X.Modules ℤ` and uses only Mathlib; my proposed dependency on `Sheaves.derivedQCoh` was not needed.
- The further inputs of the compactness deduction are not named: acceptable. The node's sentence is true as it stands. The inputs I named follow from the text of §2.18 (README lines 5049 to 5053), so naming them remains a possible improvement, not a correction.

## 2. The three new nodes

- **`Sheaves.IsPerfectComplex`: *agree*.** It is the predicate of `Suggested.lean` (a quasi-isomorphism from a strictly perfect complex to the restriction, near every point), for every scheme. README line 207 says that the local criterion is valid on arbitrary schemes and that the perfect objects of the derived category are induced by it. The quotation is exact. It is a named object of §1.3. The checks are right.
- **`Sheaves.perfectDerived_iff_isPerfectComplex`: *agree*.** It is the third item of the interface of §1.3 (line 215), quoted exactly; the scope "qcqs" is the roadmap's. Its `deps` are roadmap nodes.
- **`Infinity.isPresentable_of_compactGenerators`: *agree* with Corollary 1.4.4.2, with R1.**
  - Hypotheses: small coproducts, small Hom sets of the homotopy category, and a generator. They are HA's (1), (2), (3) for X the coproduct of all shifts of all members of S. HA's generator is tested without shifts (`π₀ Map(X, Y) ≃ ∗` implies Y zero), so X is the right object.
  - The regular cardinal is right: `Map(X, −)` is a κ-small product of functors that preserve filtered colimits.
  - Local smallness is derived as in HA's proof.
  - The empty set gives the zero category, which is presentable.
  - The `deps` reach every input once the step of R1 names the right statement.
  - Improvement: say that C lives in the universe `w + 1`, as E0.8 fixes for `IsPresentable`.

## 3. The compactness test and the small mapping spaces

- **`Infinity.compactObject_iff_homotopyCategory`: *agree*.** Proposition 1.4.4.1(3) has no hypothesis of local smallness (its mapping spaces are in the spaces "not necessarily small"), so the general statement is right. Compactness in the sense of E0.8 is named only under local smallness, which is right. The new dependency supplies the addition on the Hom sets.
- **One consistent account.** `Sheaves.schemeQCoh` supplies small mapping spaces, as a full subcategory of `D∞(O_X)` (E1.3). `Sheaves.schemeQCoh_compactGeneration` uses this once, before the test, and again as the hypothesis of the presentability theorem. `Sheaves.derivedQCoh` states the smallness of its Hom sets as a fact that is not an item of §2.18, and `Sheaves.derivedQCoh_perfectGenerator` uses it only for the remark on equivalence. Each step is supplied, and every supplier is in `deps`.

## 4. The helper lemma of `Sheaves.qcqsScheme_passable`

*Agree*; I checked every step again.
- The limit is over the non-empty subsets I of the finite index set, with the restriction maps for I ⊆ J. This is a finite limit, and it computes the same as the Čech limit of the cover of Z by the `Z_i`. In connective commutative algebras it is the connective cover of the ring of global functions of Z, so `Z′ = Spec B` is the right affine scheme.
- Localization at `g_i` is exact on modules and commutes with connective covers, so it commutes with this limit. The limit of the rings of the `Z_{I ∪ {i}}` is the ring of `Z_i`, because I ↦ I ∪ {i} is left adjoint to the inclusion of the sets that contain i, and these have the least element {i}. The node does not state this last step. Improvement: add "and the limit of the rings of the Z_{I ∪ {i}} is the ring of Z_i, because the sets that contain i have the least element {i}".
- `deps`: right. `Sheaves.properPerfectPushforward` is no longer reached.
- The input without a node: R2.

## 5. `Sheaves.qcoh_compactGeneration_of_qcqsScheme`

*Agree*. Theorem 1.3.4 is flat, hence Zariski, descent for QCoh on affine derived schemes. Its consequence for prestacks is Corollary 1.3.11 (for a surjection of prestacks, QCoh is the totalization over the Čech nerve). Proposition 1.4.4 is the limit over the affine opens of a scheme of the source. The route (a basis of affine opens, refined intersections, affine equivalences natural for restriction) is sound for a non-separated scheme.
- Improvement: cite "Theorem 1.3.4 and Corollary 1.3.11".
- The claim that the schemes of [GRQCoh] are separated rests on Chapter I.2 of the book, which is not in `references/`; it agrees with my memory of that chapter.

## 6. The other nodes

- **`Sheaves.schemeQCoh`: *agree*;** the same object as at `ebbb29c`. Without clause (3) it holds only items of EnhancedDerivedSheaves.
- **`Sheaves.derivedQCoh_perfectGenerator`: *agree*.** The universe sentence is right. Lemma 36.13.8 (tag 08EI) with 36.13.6 and 36.13.7, Lemma 36.15.2, and the two targets of §3.2 that need the generator (lines 878 and 882) are stated correctly.
- **`DModules.IsULAModuleCategory`: *agree*.** The collision example now has the hypotheses of [RaskinCPSI] §6.15 and Theorem 6.17.1 and of `Ran.collisionCategory_isULAModuleCategory`.
- **`Sheaves.passable` and `Infinity.compactGeneration`:** unchanged since `5f98800`; the same objects as at `ebbb29c`.

## 7. `GLCinLean.lean`

*Agree*. The entry is accurate against the paper: §1.1.7 defines `Hom` as the degree 0 cohomology, and §1.2.2 states the condition without shifts and calls it equivalent to the absence of a proper cocomplete subcategory. It is under "Errors and gaps found in the sources", in the form of its neighbours, with no status text. `git diff 550f64e af3ac44 -- GLCinLean.lean GLCinLean/` shows five added lines of doc comment and no change of a declaration.

## 8. Sections 5 and 6 of the proposal

- **Length.** I counted from `workers.toml`: the present guidance of `author-stacks` has 2,413 characters; with target (7) inserted before "Work only on the targets named here" and one space, the full text has 4,066. The limit is 4,096.
- **Steps.** Each step matches §2.18 and the nodes. No wait is circular: the targets of SchemeKTheoryOperations on Lemmas 36.13.6, 36.13.8 (line 870) and 36.13.7 (line 874) need steps (a) and (b), not the generator. No step asks for a target of another roadmap.
- **Improvement to step (b).** It no longer names the lemmas that (d) and (e) use (membership in `DQCoh`, the adjunction of pullback and direct image), and the guidance ends with "Work only on the targets named here". Also, the pin already has K-flat resolutions of complexes of module sheaves (`TauCeti.Algebra.Category.ModuleCat.Sheaf.TensorProduct.KFlat`: `CochainComplex.exists_quasiIso_isKFlat_sheafOfModules`), on which the derived tensor should be built. A wording that fits the limit (full text 4,075 characters, counted):
  - (b): "(b) derivedTensor, derivedHom, derivedPullback, totalDirectImage, with the lemmas of 2.18 that (d) and (e) use (adjunctions, membership in DQCoh, totalDirectImage_coproduct), on the K-flat resolutions of module sheaves on main; each in its own pull requests."
  - in (e), in place of the sentence "On DerivedCategory X.Modules … the same as for Type u.": "With HasDerivedCategory.standard it also tests families indexed by Type (u+1); such a family with a coproduct has only a u-small set of non-zero members, so the statement is the same."
- **Counts and facts: right.** 292, 176, 220, 31, 219, 72, ten areas; EnhancedDerivedSheaves 24, SchemeAndStackFoundations 8, SchemeKTheoryOperations 2.
- **"Waits for" and "does not wait for": all true by the closure.**
  - `Sheaves.passable`, `Sheaves.passable_tensorBaseChange` and `Sheaves.QCoh` reach `Sheaves.derivedQCoh` and reach neither the generator nor the two nodes of SchemeKTheoryOperations.
  - `Infinity.dualizableCategory` reaches neither the test nor `Infinity.homotopyCategoryPretriangulated`.
  - 38 nodes are above the generator. Six are statement nodes, all above `Stacks.determinantBundle`; four of them are also above `DModules.IsULA` and `Sheaves.qcSeparatedScheme_oneAffine`.
- **One fact to add (improvement).** `lake exe tracker ready` now lists `Roadmap.SchemeKTheoryOperations.IsPerfectComplex` as a ready module, in an area with no worker.
- **The decision entry and the open items** state what the branch does. Only the open item on the t-structure changes, with R2.

## 9. `docs/blueprint-providers.md`

*Agree*. The three new upstream rows exist at the pin under the names and modules given; I read the declarations of `isQuasicoherent_kernel`, and the script confirms the pairs. The rows for SchemeKTheoryOperations, for the two ready modules and for #43025 match the nodes and the pull request (head `fc58c1d6`).

## Other improvements that can wait

- `Sheaves.IsPerfectComplex` (roadmap predicate on complexes of module sheaves) and `Sheaves.PerfectComplex` (perfect objects of QCoh of a prestack, written here) have near-identical ids. One clause in each, naming the other, prevents confusion.
- `Sheaves.derivedQCoh_perfectGenerator` still repeats the definition of a perfect complex that `Sheaves.IsPerfectComplex` now holds; it can refer to that node.

## Files

- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/plans/GLCinLean/CategoryTheory/PresentableOfCompactGenerators.toml` (R1)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/plans/GLCinLean/AlgebraicGeometry/Sheaves/PassableScheme.toml` (R2, and the clause of item 4)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/plans/GLCinLean/AlgebraicGeometry/Sheaves/QCohOfScheme.toml` (item 5)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/notes/checks/qcoh-compact-generation-proposal.md` (sections 5 and 6)
- `/Users/why/Library/Application Support/tauceti/workers.toml` (read only, for the count)
