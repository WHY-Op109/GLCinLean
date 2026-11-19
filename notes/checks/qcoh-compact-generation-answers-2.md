# Answers to round 2 on `proposal/qcoh-compact-generation`

The report is `qcoh-compact-generation-codex-2.md` (Codex, on commit `8fa034a`). All six objections are right and are corrected. Line numbers of roadmaps are of the READMEs at TauCetiRoadmap `fe56342a`.

## The six objections

**1. The left Kan extension claim. Right; the claim is removed.** [DG2] `Finiteness.tex` lines 1088–1091 say that the left Kan extension of a classical affine scheme is the same affine scheme as a derived prestack, so the claim was false for `X = Spec A`. No user needs a statement about what the prestack of `X` is not. The node keeps its two named inputs, the route by affine opens and the definition of the prestack of `X` as `X` as a derived scheme. The sentence that #2450 §5.3 "does not give" the comparison is also removed; the node now says only what §5.3 states.

Places: `plans/GLCinLean/AlgebraicGeometry/Sheaves/QCohOfScheme.toml` (two sentences); `docs/blueprint-providers.md`, the row of #2450; the proposal, section 2.6 and the first proposed open item ("only" removed). `qcoh-compact-generation-answers-1.md` repeats the claim under "Codex 4"; it is the record of round 1 and is not changed.

**2. The circle. Right; an acyclic route is stated.** I chose the route and not "blocked pending a supplier decision", for this reason: a blocked line needs a decision in the roadmaps, which no agent of this project may ask for, while the route is read off the Stacks proofs and needs three claims, each checked:
- §2.18 cites Lemma 36.15.1 for `perfect_generator` (README lines 5060–5061), so it is part of that target.
- Stacks proves Lemma 36.13.11 (tag 09IM) by induction on the number of affine opens with Lemma 36.13.10, Lemma 36.13.7 and Lemma 20.45.1 (tag 08DG, gluing on two opens). Lemma 36.13.7 serves only the map to `E`; Lemma 36.15.1 is the case with no map and no support.
- In SchemeKTheoryOperations §3.2, the target on Lemmas 36.13.6, 36.13.8, 36.13.10 has "*Needs:* §§1.4 and 3.1" (line 870) and the target on Lemmas 36.13.7, 36.13.9 has "§1.4 … §2.18, quasicoherent derived operations" (line 874). Only the target on Lemma 36.13.11 lists "§2.18, perfect generators" (line 878).

So `perfect_generator` waits for Lemma 36.13.10 and not for the target on Lemma 36.13.11. `perfect_dual` and the clause of `derivedHom_mem_DQCoh` for a perfect object are released as soon as `IsPerfectComplex` is on main.

Places: `PerfectGenerator.toml` (input (c), `source`); `docs/blueprint-providers.md`, the row of the ready module; the proposal, sections 2.1, 5 (steps (c), (d), (e) of the guidance and the paragraph after it) and 6 (the decision).

**3. The weaker interface. Right; fixed.** The node no longer says that the weaker reading serves the users. It says that the users need (1) for every perfect object, that the interface check asks for it, and that under the weaker statement (1) is deduced from `perfect_dual` and `totalDirectImage_coproduct` before the node is deleted. Checked against Stacks tag 09M1, first direction.

Places: `PerfectGenerator.toml` (two sentences); the proposal, sections 2.1, 6 (the decision), 7 (doubt 1) and the guidance, step (e) ("State compactness for every perfect object").

**4. The supplier evidence for the generic test. Right; fixed with the fewest claims.** E3.3 (line 1217) and E2.5 (line 2289) cite only Proposition 1.4.4.1(3). I found no accepted target that needs Corollary 1.4.4.2 in this generality. So the roadmap node keeps parts (i) and (ii) only, and the presentability deduction is a lemma of its one user, `Sheaves.schemeQCoh_compactGeneration`, written here in its general form. The other form, to keep (iii) upstream, would need a claim about a target that I cannot make. The hypothesis on small Hom sets left the roadmap node and is with the presentability lemma. The node has a new name, because its conclusion changed: `Infinity.compactObject_iff_homotopyCategory`, in `CompactObjectHomotopyCategory.toml`. It lost the dependencies `Infinity.presentableCategory` and `Infinity.homotopyCategoryPretriangulated`, the sentence on Remark 1.4.4.3 and the sentence on mapping spectra.

Places: the node; `CompactGeneration.toml` (two references to the name); `SchemeQCohCompactGeneration.toml` (the proof, `deps`, `source`); `docs/blueprint-providers.md` (the row of EnhancedDerivedSheaves, the row of #43034); the proposal, the summary and sections 2.4, 4, 5, 6 and 8.

**5. Two proof steps without a supplier. Right; fixed.**
- `DModules.IsULA` now depends on `Sheaves.qcoh_compactGeneration_of_qcqsScheme` and says that `O_S` is compact by its part (1). `DModules.IsULAModuleCategory` states the example as [RaskinCPSI] Example B.6.2 does: `ω_S` is ULA with `Oblv(ω_S) = O_S`, and the objects `P ⊗ Oblv(ω_S) = P`, for `P` perfect, are compact and generate.
- The helper lemma of `Sheaves.qcqsScheme_passable` names its input: the direct images of the first clause of `Sheaves.properPerfectPushforward`, with base change, which gives `j^* j_* ≃ id` ([GRQCoh] Proposition 2.2.2 and the proof of Proposition 3.3.3, `QCohBook.tex` lines 646–649 and 1050–1053). The node depends on `Sheaves.properPerfectPushforward`; this makes no cycle, because that node depends on the lemma and not on passability. My own reading found one more step without a supplier: the first version used a t-structure on QCoh of an open subscheme, which no node gives. The proof now works on the principal opens of the affine scheme, where it needs only that localization at an element commutes with connective covers; the node says that this fact is proved with the lemma.

Places: `ULA.toml` (both nodes); `PassableScheme.toml` (the helper lemma, `deps`, `source`); `QCohOfScheme.toml` (the list of users); the proposal, section 4.

**6. Two facts in the proposed text. Right; fixed.** Checked with a script on the dependency closure: `Sheaves.passable` and `Sheaves.passable_tensorBaseChange` reach `Sheaves.derivedQCoh` and do not reach `Sheaves.derivedQCoh_perfectGenerator`. The decision now says that they do not wait for the generator theorem. "All of §2.18" is replaced by "`perfect_generator` of §2.18" in three sentences. The cost is six new nodes and seven revised nodes, counted by a script against `ebbb29c`; the seventh is `DModules.IsULA`, revised in this round.

Places: the proposal, sections 3 (cost; option (d)), 4 ("What waits longer now") and 6 (the decision; the open item on the nodes that wait).

## The improvements

- **The exact name and import of the pseudo-coherent sheaves in the guidance. Applied**, with the imports of the two other declarations that the guidance names.
- **The infinite disjoint union. Applied**, one sentence each: `PerfectGenerator.toml` says "in this example (2) holds with P = O" and no longer "not for (2)"; `SchemeQCohCompactGeneration.toml` no longer speaks of the enhanced category of a scheme that is not quasi-compact, for which E1.8 defines none.
- **Staging the enhanced carrier and the strict-model theorem. Not applied**: it is advice for scheduling and is no sentence of a node.

## Step 4: what was checked, and what changed

**(a) Declarations at the pin, opened and compared.**
- `AlgebraicGeometry.Scheme.Modules.IsPseudoCoherent`, `isPseudoCoherent_iff_forall_affineOpens`, `TauCeti.DerivedDeRham.IsPerfect`, `SSet.fullEnhancedSubcategory`, `AlgebraicGeometry.QuasiSeparated`, `AlgebraicGeometry.QuasiCompact`, `Scheme.IsQuasiAffine.of_isImmersion`, `Scheme.IsQuasiAffine.of_isAffineHom`, `HasDerivedCategory.standard`, `DerivedCategory`, `Scheme.Modules` with its `Hom : Type u` and its instance `IsGrothendieckAbelian.{u}`, `CategoryTheory.IsFinitelyPresentable`, the two triangulated generators of Mathlib: as described.
- `CategoryTheory.ObjectProperty.localizingClosure`: its row in `docs/blueprint-providers.md` left out "isomorphism-closed" and the universe of the coproducts (`∀ J : Type v`, the universe of the morphisms). **Changed.**
- `TauCeti.IsCompactForCoproducts` at the head `3d99a097` of #43034 and `isStrictlyPerfect` in the description of #43025: as described.

**(b) Non-existence, "waits for" and "does not wait for".**
- The pin has no `DQCoh`, `IsPerfectComplex`, `isStrictlyPerfect`, `perfect_generator`, and no definition of a compact object in `CategoryTheory` or `Algebra/Homology` of Mathlib or Tau Ceti (search by name and by `def`, `class`, `abbrev`, `structure` with "compact"). As stated.
- By the dependency closure of `plans/`: the claims on `Sheaves.passable`, `Sheaves.passable_tensorBaseChange`, `Sheaves.schemeQCoh`, `Infinity.dualizableCategory` (it reaches neither the test nor `Infinity.homotopyCategoryPretriangulated`), `Sheaves.properPerfectPushforward`, `Stacks.determinantBundle`, `DModules.IsULA`, `DModules.IsULAModuleCategory`, `Sheaves.qcSeparatedScheme_oneAffine` hold after the corrections of objection 6. No roadmap node depends on a node written here. The ready module of the area is `Roadmap.SchemeAndStackFoundations.DerivedQCoh` (`lake exe tracker ready`).
- The proposal said that the test node is not ready until `Infinity.homotopyCategoryPretriangulated` is at the pin; the node no longer depends on it. **Changed** to its four dependencies.
- The proposal said that the corollary "depends on three roadmap nodes"; it depends on eight, all roadmap nodes. **Changed** to "only on roadmap nodes"; the node said "three" too. **Changed.**

**(c) Attributions to roadmaps, Stacks tags and papers, read again.**
- Roadmap lines: SchemeAndStackFoundations 5041–5061; EnhancedDerivedSheaves 553, 842, 852, 1205, 1217, 1599, 2289; SchemeKTheoryOperations 13, 93, 207, 758, 760, 870, 874, 878, 1702 and `Suggested.lean` line 63; StableHomotopyKTheory 2189; #2450 at `26c8a4ff`, §§2.5, 5.3, 8.1. As quoted.
- Stacks tags by title and statement: 06YZ, 08DT, 06Z0, 08CM, 07LS, 09IQ, 09IR, 09IS, 08EK, 09IM, 08DG, 09M1, 02JR. As cited. Tags 08EK and 08DG are new in this round.
- Papers: [CompactGeneration] §§1.1.7, 1.2.1, 1.2.2; [GRQCoh] Propositions 1.4.4 and 2.2.2, §§3.3.1, 3.5.1, 3.7.1–3.7.4; [OneAffineness] Definition 5.1.2 and §5.3.1; [RaskinCPSI] Definition B.6.1 and Example B.6.2; Higher Algebra, Proposition 1.4.4.1 and Corollary 1.4.4.2. As cited.
- `PerfectGenerator.toml` said that the plan does not use "the gluing theorems" of §2.18. The route for Lemma 36.15.1 uses a gluing lemma of Stacks, and I did not compare it with the two gluing theorems of §2.18. **Changed**: the three words are removed.
- `SchemeQCohCompactGeneration.toml` cited Remark 1.4.4.3 in `source`; its text no longer uses it. **Changed.**

**(d) Proof steps and their suppliers.**
- `Sheaves.schemeQCoh_compactGeneration`: stability, coproducts, the triangulated comparison and the perfect objects from `Sheaves.schemeQCoh`; the small Hom sets from `Sheaves.derivedQCoh` (**changed**: the node attributed them to `Sheaves.schemeQCoh`); (2) from parts (i) and (ii) of the test (**changed**: it named (ii) only); (1) from the lemma proved here. All are in `deps`.
- `Sheaves.qcoh_compactGeneration_of_qcqsScheme`: `Sheaves.schemeQCoh_compactGeneration`, `Sheaves.PerfectComplex`, `Infinity.dualizableCategory`, and the two inputs without a node, behind the held `Sheaves.QCoh`. In `deps`.
- `Sheaves.qcqsScheme_passable`: the classical step from Mathlib; the derived step from `Derived.IsArtinStack`, `Sheaves.properPerfectPushforward` and, through `Derived.Prestack` and `Sheaves.QCoh`, `Derived.commutativeAlgebra` and `Derived.affineModules`; (2) and (3) from the lemma. In `deps` or reached by them.
- `DModules.IsULA` and `DModules.IsULAModuleCategory`: the lemma, in `deps` of both.

**(e) Counts.** By `lake exe tracker lint`, `tools/check-module-cycles.py` and a script on the plan files: 289 planned declarations, 173 module plans, 219 written here (31 the statement, 218 with a roadmap node below), 70 roadmap nodes (24 in EnhancedDerivedSheaves, 8 in SchemeAndStackFoundations), nine areas; against `ebbb29c`, 6 new and 7 revised nodes and none removed; nine upstream declarations added to the table of `docs/blueprint-providers.md`. The proposal agrees after the correction of objection 6.

## What this round did not change

No held node, no file of `GLCinLean/Statement/`, no `STATUS.md`, no worker. No new node. This round adds no upstream name to a node or to the provider record; the guidance names three import modules, each compared with its file at the pin.
