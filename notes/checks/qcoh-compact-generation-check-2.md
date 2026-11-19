# Second check of `proposal/qcoh-compact-generation` (head `5f98800`)

**Result in short.** No *unsure* verdict remains. No node states a wrong object: every definition and theorem agrees with its source. Five findings still block, all about structure, suppliers or one wrong sentence, and each has an exact change below (B1 to B5). The rest are improvements. The provider decision (Tau Ceti for §2.18 and the generic test, the corollaries here) is right, and I agree with it.

I changed no file. `lake exe tracker lint`: 0 errors. `tools/check-module-cycles.py`: 173 module plans, 289 nodes, 0 cycles. `tools/check-upstream-names.py`: 195 pairs, 0 not confirmed. By my own script on the dependency closure: 219 nodes here, 218 with a roadmap node below, 70 roadmap nodes in nine areas, no edge from a roadmap node to a node written here.

Sources read in this round: Stacks tags 06YZ, 08DT, 06Z0, 08CM, 07LS, 08EG, 08EH, 08EI, 08EJ, 08EK, 09IM, 08DG, 09IQ, 09IR, 09IS, 09M1, 02JR (title, statement and proof, on the site today); Higher Algebra, Proposition 1.4.4.1, Corollary 1.4.4.2 and Remark 1.4.4.3, in the PDF at `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/ha/HA.pdf` (printed pages 154 to 156; nothing from memory this time); the roadmaps at `fe56342a`; [GRQCoh] Propositions 1.4.4 and 2.2.2 and §3.3.1; [RaskinCPSI] B.6.1 and B.6.2.

## Blocking findings, with the change that resolves each

**B1. A clause of `Sheaves.schemeQCoh` belongs to another roadmap, and no dependency reaches its input.** `plans/Roadmap/EnhancedDerivedSheaves/SchemeQCoh.toml`, clause (3): "the perfect subcategories correspond in both directions … the comparison of this membership with `IsPerfectComplex` is the target of roadmap SchemeKTheoryOperations §1.3".
- The node is in the folder of EnhancedDerivedSheaves and says itself that the clause is a target of SchemeKTheoryOperations (`plans/README.md`: a roadmap node is in the folder of its owner).
- `IsPerfectComplex` has no node, so the `deps` of `Sheaves.schemeQCoh` and of `Sheaves.derivedQCoh_perfectGenerator` do not reach it.
- `Sheaves.schemeQCoh` is a definition below the statement (`Sheaves.QCoh` depends on it). With the clause inside, the node cannot be deleted before SchemeKTheoryOperations §1.3 lands. The proposed `STATUS.md` sentence "of §2.18 they reach only `Sheaves.derivedQCoh`" then hides a wait of `Sheaves.passable` and `Sheaves.QCoh` for §1.3.
- Change: take clause (3) out of `Sheaves.schemeQCoh` (keep (1) and (2); "uses the comparison with (1) and (2)"). Add two roadmap nodes under `plans/Roadmap/SchemeKTheoryOperations/`, in two files. `Sheaves.IsPerfectComplex` (definition; "Provider: roadmap SchemeKTheoryOperations §1.3, `IsPerfectComplex` of its `Suggested.lean`: local quasi-isomorphism from the strictly perfect models of §1.1"; `deps`: `Sheaves.derivedQCoh`). `Sheaves.perfectDerived_iff_isPerfectComplex` (theorem; "for a quasi-compact quasi-separated X, an object of `QuasicoherentDerived X` is in `PerfectDerived X` if and only if its image in `DQCoh X` is represented by a complex with `IsPerfectComplex`"; provider §1.3, with the quotation that the node has now; `deps`: `Sheaves.IsPerfectComplex`, `Sheaves.schemeQCoh`). Then `Sheaves.derivedQCoh_perfectGenerator` depends on the first, and `Sheaves.schemeQCoh_compactGeneration` on the second. The smallest acceptable form is the second node alone, holding the predicate.
- Effect on the proposed texts: ten roadmap areas, and the counts change (see B5).

**B2. One sentence of `Sheaves.derivedQCoh_perfectGenerator` is false, and the guidance repeats it.** Input (b): "For `DerivedCategory X.Modules` with `HasDerivedCategory.standard` that universe is u+1, and this is not statement (1)."
- On the standard model `IsCompactForCoproducts K` implies statement (1): a type of `Type u` is small for `Type (u+1)`, and #43034 has the lemma (`IsCompactForCoproducts.preservesColimitsOfShape {G} (hG) (J : Type w) [Small.{v} J]`, `Compact.lean` line 83 at head `3d99a097`).
- It is also equivalent to (1). If a family indexed by J has a coproduct E, let J′ be the set of indices with a non-zero member. The power set of J′ embeds in `Hom(E, E) = ∏_j Hom(E_j, E)` (choose 0 or the inclusion for each j). The Hom sets are u-small, so J′ is u-small, and E is the coproduct over J′.
- As written, the sentence makes the interface check reject a sufficient upstream theorem, and step (e) of the guidance steers the worker away from the predicate that step (d) tells it to wait for.
- Change in the node: replace "and this is not statement (1). Statement (1) is about … indexed by `Type u`." by: "On that model `IsCompactForCoproducts K` implies statement (1), because a type of `Type u` is small for `Type (u+1)`, and it is equivalent to statement (1), because the Hom sets are u-small: a family with a coproduct has only a u-small set of non-zero members. On a model with morphisms in `Type u` it is statement (1). Either form passes the interface check."
- Change in the guidance, step (e): replace the two sentences from "Compact means" to "say in the pull request which" by: "Compact means TauCeti.IsCompactForCoproducts; define no other predicate. On a derived category with morphisms in Type u it says that Hom(K, -) preserves the coproducts indexed by a type in Type u. On DerivedCategory X.Modules with HasDerivedCategory.standard it also quantifies over families indexed by Type (u+1); such a family with a coproduct has only a u-small set of non-zero members, because the Hom sets are u-small, so the statement is the same. Say in the pull request which model is used."

**B3. The supplier of "small Hom sets" is wrong.** `Sheaves.schemeQCoh_compactGeneration`: "its homotopy category has small Hom sets … with the small Hom sets of Sheaves.derivedQCoh". `Sheaves.derivedQCoh` states "Hom sets of the derived category are u-small" under "Universes", but its provider list (the items of §2.18) does not contain it, and neither Mathlib nor Tau Ceti at the pin states local smallness of this derived category.
- Change in `Sheaves.schemeQCoh_compactGeneration`: "the Hom sets of its homotopy category are small, because C is a full subcategory of `D∞(O_X)`, whose mapping spaces are small (E1.3: `enhancedDerived.mappingSpaces`, `enhancedDerived_isPresentable`); Sheaves.schemeQCoh supplies this".
- Change in `Sheaves.derivedQCoh`: after "Hom sets of the derived category are u-small" add "(by K-injective resolutions in a Grothendieck abelian category; this is not an item of §2.18)".

**B4. The helper lemma of `Sheaves.qcqsScheme_passable` has a step without a supplier.** "Let B be the connective cover of the commutative algebra of global sections of j_* f_* O_Z". `Derived.commutativeAlgebra` gives connective commutative algebras only, and the closure of the node's `deps` does not contain `Infinity.tStructure` (checked by script). So neither the non-connective algebra nor its connective cover has a supplier. The mathematics of the lemma is right; I checked it step by step.
- Change, which also removes the need for direct images: "Let Z_I = Z ×_T D(∏_{i∈I} g_i) for each non-empty set I of indices; each is affine. Let B be the limit of the rings of the Z_I in the connective commutative algebras over the ring of T (Derived.commutativeAlgebra), and Z′ = Spec B. For each i the map from the localization of B at g_i to the ring of Z_i is an equivalence, because localization at an element preserves finite limits of connective commutative algebras: it is exact on modules and commutes with connective covers (the standard t-structure on Derived.affineModules, Infinity.tStructure). So Z is the open subscheme Z′ ×_T U′ of the affine scheme Z′."
- `deps`: add `GLCinLean.Infinity.tStructure` and `GLCinLean.Derived.affineModules`. With this wording `GLCinLean.Sheaves.properPerfectPushforward` can leave the `deps` and [GRQCoh] Proposition 2.2.2 the `source`. If the present wording is kept, add `Infinity.tStructure` and name the node that gives non-connective commutative algebras.
- If no node gives the standard t-structure on modules over a connective commutative algebra, name it as a third input without a node.

**B5. The presentability lemma is a general theorem inside a node of algebraic geometry, and its inputs are not reached.** `Sheaves.schemeQCoh_compactGeneration`: "For (1), a lemma proved here in its general form: a stable category with small coproducts … is presentable ([LurieHA] Corollary 1.4.4.2 …)".
- The statement and its use are right (read in the PDF: the generator of Corollary 1.4.4.2 is tested without shifts, so the coproduct of all shifts of all members of S is the right object, and it is κ-compact for a regular κ above the cardinality of S × ℤ). No accepted roadmap cites this corollary, so "here" is right.
- It is a theorem on stable quasicategories. Its home is `plans/GLCinLean/CategoryTheory/`, not the module `GLCinLean.AlgebraicGeometry.Sheaves.SchemeQCohCompactGeneration` ("Lean code": canonical home, one concept per file).
- Its proof uses the adjoint functor theorem (HA: "F admits a right adjoint G"), which is `Infinity.rightAdjoint`. That node is not in the closure of `Sheaves.schemeQCoh_compactGeneration` (checked by script).
- Change: a node of its own, for example `GLCinLean.Infinity.isPresentable_of_compactGenerators` in `plans/GLCinLean/CategoryTheory/PresentableOfCompactGenerators.toml`, with the present text of the lemma, `source = '[LurieHA] Corollary 1.4.4.2'`, and `deps`: `Infinity.stableCategory`, `Infinity.presentableCategory`, `Infinity.compactObject`, `Infinity.indCompletion`, `Infinity.rightAdjoint`, `Infinity.mappingSpaces`. `Sheaves.schemeQCoh_compactGeneration` then says "(1) is Infinity.isPresentable_of_compactGenerators with S = {P}" and depends on it.
- Counts after B1 (two nodes) and B5: 292 planned declarations in 176 module plans; 220 written here, 219 with a roadmap node below; 72 roadmap nodes in ten areas.

## 1. The findings of the first check

| Finding | State |
|---|---|
| M1 (tag of the compact object) | Resolved: tag 07LS. |
| M2 (perfect complexes attributed to #43025 and §2.18) | Resolved in the node, the providers document and the guidance. B1 is what remains of it: the object has no node. |
| M3 (source of form (a)) | Resolved: the node states the reading of [CompactGeneration] §1.2.2 with §1.1.7 and the counterexample. |
| U1 (SchemeKTheoryOperations §2.6) | Resolved: the corollary is written here, and the node gives the right reason. |
| U2 (reading of "compactly generated by perfect complexes") | Resolved as far as the plan can: the node names the reading, the interface check and the deduction (item 5). |
| G1 | Resolved. |
| G2 | Resolved, with two precisions (item 4). |
| G3 | Not resolved: the new sentence is wrong (B2). |
| G4 | Resolved. |
| [GRQCoh] §3.3.1; "affine derived scheme" | Resolved. |
| A non-example in the node of `Sheaves.passable` | Resolved. The coproduct in prestacks fails (1) as well as (2), as the node says; my first report was wrong on (1). |
| The test in a node of its own | Resolved. |
| A source for the derived helper lemma | Resolved in substance; B4 remains. |
| The prestack of a classical scheme, and the equivalence | Resolved: named in the node and as an open item. |
| One transported lemma for the two users | Resolved: `Sheaves.qcoh_compactGeneration_of_qcqsScheme`. |
| The longer wait of the statement | Partly: see item 7. |
| `TauCeti.DerivedDeRham.IsPerfect`; `IsFinitelyPresentable` | Resolved. |
| `docs/papers.md`, `docs/references.bib` | Resolved, except the tags of round 2 (improvement I6). |

## 2. The three definitions

- **`Sheaves.passable`: *agree*; the same object as at `ebbb29c`.** The three conditions are [OneAffineness] Definition 5.1.2 and [GRQCoh] §§3.3.1 and 3.5.1.
- **`Infinity.compactGeneration`: *same object, different presentation*.** Form (a) is the roadmap's `IsCompactlyGenerated`; (a), (b), (c) are equivalent, also for the empty set; (c) now takes a small model. Without the test, the node needs neither the triangulated structure nor `Infinity.derivedVect`. Each user gets what it needs: the 15 direct users need the definition only, except `Sheaves.schemeQCoh_compactGeneration`, which now depends on the test node. `Infinity.dualizableCategory` reaches neither the test nor `Infinity.homotopyCategoryPretriangulated`.
- **`Sheaves.schemeQCoh`: *agree* on the object; B1 on clause (3).**

## 3. The new and moved nodes

- **`Sheaves.derivedQCoh`: *agree*.** The category, (1) to (4), the universes and the checks match README lines 5041 to 5048, `Suggested.lean` lines 559 to 565 and tags 06YZ, 08DT, 06Z0. `X.Modules` is `IsGrothendieckAbelian.{u}` at the pin. One clause to add (B3).
- **`Sheaves.derivedQCoh_perfectGenerator`: *agree*, with B2.** Statement, hypotheses, checks and tags 08CM, 07LS, 09IS, 09M1 are right. The remark on strictly perfect complexes is right. `deps` do not reach `IsPerfectComplex` (B1).
- **`Infinity.compactObject_iff_homotopyCategory`: *agree*.** (i) is Proposition 1.4.4.1(1); (ii) is 1.4.4.1(3), whose proof shows that the node's bijective form is the same condition. HA has no hypothesis of local smallness there, so dropping it is right. The evidence that it is a prerequisite holds (EnhancedDerivedSheaves lines 1217 and 2289).
- **`Sheaves.schemeQCoh_compactGeneration`: *agree* on the statement and on the provider; B3 and B5 on two proof steps.** The other steps have their suppliers in `deps`.
- **`Sheaves.qcoh_compactGeneration_of_qcqsScheme`: *agree*.** The transport needs only an equivalence of categories that matches the unit and the perfect objects. Dualizability as a plain `k`-linear category follows from compact generation, a property of the underlying category. The two inputs without a node are stated; recording them in the node and as an open item is enough while `Sheaves.QCoh` is held. [GRQCoh] Proposition 1.4.4 is quoted correctly.
- **`Sheaves.qcqsScheme_passable`: *agree*; B4 on the helper lemma.** The classical step, the derived step, the non-example and the checks are right; over the two charts of the plane with a doubled origin the diagonal is the punctured plane.
- No roadmap node depends on a node written here.

## 4. The route for the worker

- **True.** Stacks proves Lemma 36.15.1 as "Special case of Lemma 36.13.11". For that case (no map to E, no support) the proof of Lemma 36.13.11 is an induction on the number of affine opens with Lemma 36.13.10 and Lemma 20.45.1 (tag 08DG, first half). Lemma 36.13.7 serves only the map to E.
- **Precision 1 (improvement).** The statement that the node quotes for "Lemma 36.13.10 without its support condition" is word for word **Lemma 36.13.8 (tag 08EI)**. Stacks proves it from Lemmas 36.13.6 and 36.13.7 only; Lemma 36.13.9 serves only the supports of 36.13.10. Write "Lemma 36.13.8 (tag 08EI), with Lemmas 36.13.6 and 36.13.7" in the node, its `source`, the providers document, the guidance and the decision.
- **Precision 2 (improvement).** Theorem 36.15.3 also uses Lemma 36.15.2 (tag 09IR: the Koszul complex on an affine scheme, with Stacks Lemma 36.9.6). §2.18 cites it, so it is part of the target, and the guidance does not name it. In SchemeKTheoryOperations §3.2 two targets list the generator under their needs: line 878 (Lemma 36.13.11) and line 882 (the supported generator, which cites Lemmas 36.15.4 and 36.15.2). The node and the proposal do not say "only", so nothing there is false; `answers-2` says "only". Add to step (e): "Lemma 36.15.2 is also part of this target. Do not wait for the target of SchemeKTheoryOperations, Section 3.2, on the supported generator."
- **No circular wait.** The targets on Lemmas 36.13.6, 36.13.8, 36.13.10 (line 870: §§1.4 and 3.1) and on 36.13.7, 36.13.9 (line 874: §1.4 and the derived operations of §2.18) do not need the generator. Neither do the sections they name (§1.4, lines 256 and 260; §3.1, line 812).
- **Inputs of other roadmaps.** The guidance names all three. The conflict between steps (d) and (e) on compactness is B2.

## 5. The weaker interface

The deduction is right; it is the first half of the proof of Proposition 36.17.1 (tag 09M1). Its inputs are named targets of §2.18. The node names two of them. It also uses `derivedTensor_derivedHom_adj` (global Hom as global sections of the internal Hom; tensor commutes with coproducts), the clause of `derivedHom_mem_DQCoh` for a perfect object, `derivedTensor_mem_DQCoh` and `DQCoh.affineEquiv`. Improvement: name these, and say that the deduction is written upstream, as the reading that SchemeKTheoryOperations takes from its suppliers (line 758 cites tag 09M1; line 794).

## 6. The users

- **`DModules.IsULA`: *agree*.** The example needs that `O_S` is compact in QCoh of the prestack of S; part (1) of the lemma gives it.
- **`DModules.IsULAModuleCategory`: *agree*** with [RaskinCPSI] Definition B.6.1 and Example B.6.2: the objects `P ⊗ Oblv(ω_S) = P` are compact and generate, by parts (1) and (2).
- **`Sheaves.qcSeparatedScheme_oneAffine`: *agree*.**
- **`Sheaves.properPerfectPushforward`: *agree*.** The new dependency gives dualizability of QCoh of the curve. Improvement: the `desc` has no word on why the dependency is there; add "its hypothesis, that QCoh(X) is dualizable, is Sheaves.qcoh_compactGeneration_of_qcqsScheme (3)".
- **`Sheaves.passable_tensorBaseChange`: *agree*;** it does not reach the generator theorem.

## 7. The proposed texts

- **Counts: right for the branch as it is.** They change with B1 and B5.
- **"Waits for" and "does not wait for": true by the closure** for every sentence of the decision and of the open items.
- **One omission that matters (improvement; add it in this revision).** 38 nodes are above `Sheaves.derivedQCoh_perfectGenerator`. Among them are `Statement.DmodHalf`, `Statement.heckeActionRight`, `Statement.vacuumPoincare`, `Statement.IsLanglandsFunctor` and the main theorem, through `Stacks.determinantBundle` and through `DModules.IsULA`. So the first goal waits for `perfect_generator` and for SchemeKTheoryOperations §§1.3 and 3.2 and StableHomotopyKTheory §5.17, where no worker of ours runs. The open item names four nodes and not the statement. Two ways shorten the wait, both for the session to decide: the open item on E1.9 (it may remove the dependency of `Sheaves.properPerfectPushforward` on dualizability), and an author worker on SchemeKTheoryOperations once B1 gives that area nodes.
- **The decision entry** states what the branch does. Correct it for B1 (ten areas; the correspondence of perfect objects is a node of SchemeKTheoryOperations) and for precision 1.
- **The guidance**: B2 in step (e); precisions 1 and 2. Step (c) asks for "the clause of derivedHom_mem_DQCoh for a pseudo-coherent complex", which needs `PseudoCoherence.IsPseudoCoherentComplex` of the first paragraph of §2.18; the guidance does not list it. The plan does not need this clause: drop it or add the definition.

## Other improvements that can wait

- **I6.** `docs/papers.md` and `docs/references.bib` do not list tags 08EK and 08DG, new in round 2 (and 08EI after precision 1).
- **I7.** `Sheaves.qcoh_compactGeneration_of_qcqsScheme` does not say that its provider is decided again when a roadmap with this statement is accepted; the decision entry and the providers document say it for both nodes.
- **I8.** The affine example of `Sheaves.passable` uses that A is a compact generator of its module category. That is a check of E5:presentability.1 (README line 1606); no node names it.

## Files

- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/plans/Roadmap/EnhancedDerivedSheaves/SchemeQCoh.toml` (B1)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/plans/Roadmap/SchemeAndStackFoundations/PerfectGenerator.toml` (B1, B2, precisions 1 and 2) and `DerivedQCoh.toml` beside it (B3)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/plans/GLCinLean/AlgebraicGeometry/Sheaves/SchemeQCohCompactGeneration.toml` (B3, B5)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/plans/GLCinLean/AlgebraicGeometry/Sheaves/PassableScheme.toml` (B4)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/notes/checks/qcoh-compact-generation-proposal.md` (sections 5 and 6)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa278fa99db4f6b76/docs/blueprint-providers.md` (the row of the ready module and the count of areas)
