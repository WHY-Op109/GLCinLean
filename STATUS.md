# Status

Updated 2026-11-11, after the decision on the statement.

## Current state

- **Statement.** `GLCinLean/Statement/Conjecture.lean` and `GLCinLean/Statement/Enhanced.lean`. The main theorem is `GLCinLean.Statement.exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence`: a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and every such functor is an equivalence. Its proof is the only `sorry`.
- **Placeholders.** 30 declarations are `@[placeholder]` (`grep -rn '@\[placeholder\]' GLCinLean`). None is replaced yet. All are `opaque`, so the main theorem says nothing yet: with one-point categories and always-true predicates it would be trivially true.
- **Plan.** 413 planned declarations in 172 module plans. 364 are under `plans/GLCinLean/` and are written here; 33 of them are the statement. 49 are under `plans/Roadmap/<area>/` and belong to seven Tau Ceti roadmaps. Existing Mathlib and Tau Ceti declarations are no longer nodes; the nodes that use them name them in their `desc`, and `docs/blueprint-providers.md` lists them.
- **Ready.** `lake exe tracker ready` lists six roadmap modules (`Roadmap.BordismFormalGroups.Mapping`, `Roadmap.SchemeAndStackFoundations.AlgebraicStacks`, `Roadmap.SchemeAndStackFoundations.Torsors`, `Roadmap.ReductiveGroups.PinnedRootData`, `Roadmap.JacobianChallenge.SerreDuality`, `Roadmap.AffineLieAlgebras.Levels`) and one module here, `GLCinLean.AlgebraicGeometry.Curves.Theta`. It also lists `GLCinLean.Statement.Conjecture`, because the main theorem is stated with `sorry`; that is not work for a build session.
- **Reviews.** The last reviewed commit on `main` is `b64c7fc`; the statement on `main` has not changed since. The proposed statement on the branch `proposal/hecke-form` is reviewed at `a09a016` (see "Waiting for the owner"). An independent assessment of the proposal at `b4740c9`, including U1 and U2, is in [notes/reviews/b4740c9.md](notes/reviews/b4740c9.md); it recommends approval. The decision is under "Decisions taken". The three reports `notes/review-goal.md`, `notes/review-workflow.md` and `notes/review-independent-2026-11-10.md` stay until Session 4c closes them.
- **Checks.** `lake build` passes with only the main theorem's `sorry` warning. `lake lint` passes. `lake env lean tools/check-statement-axioms.lean` shows `sorryAx` only for the main theorem. `lake exe tracker lint` has no errors; its warnings are the superseded `desc` and `deps` of the statement's placeholders, which `plans/README.md` explains.
- **Pins.** Mathlib `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`, Tau Ceti `e0610cce4004d628cbd9d2aafdbbb5459fe72938`.
- **Tau Ceti pull requests.** None opened.

## Upstream targets that block the plan

Of the 364 nodes written here, 361 have a roadmap node below them. So the first work is Worker rounds in Tau Ceti. The targets, with the number of nodes here that depend on them:

1. **BordismFormalGroups F6.5**, to which EnhancedDerivedSheaves delegates its generic quasicategory constructions:
   - "Categorical model and functor spaces": `Infinity.mappingSpaces` (354 nodes; ready now);
   - "Coherent model diagrams and stable enhancements": `Infinity.limits` (354), `Infinity.stableCategory` (349), `Infinity.tStructure` (250);
   - the monoidal and fibration sub-lane: `Infinity.monoidalCategory` (350), `Infinity.moduleCategory` (340), `Infinity.continuousLinearFunctor` (254), `Infinity.linearEquivalence`;
   - "Marked fibrations and Kan extensions": `Infinity.rightKanExtension` (231);
   - the quotient and Ind sub-lane: `Infinity.compactObject`.
2. **EnhancedDerivedSheaves**: E0.8 and E5:presentability.1–.4 (`Infinity.presentableCategory` 350, `Infinity.indCompletion` 246, compact generation, dualizable and rigid categories); E1.3–E1.4 (`Infinity.derivedVect` 342); E5:abstract.2 (`Infinity.linearCategory` 340); E3.1–E3.4 (`Infinity.rightAdjoint` 246, adjointable diagrams); E5:abstract.5 (monadicity); E5:animation.1 and .4 (`Derived.commutativeAlgebra` and `Derived.affineScheme` 322, `Derived.affineModules` 270); E1.8 (`Sheaves.schemeQCoh` 257); E5:cotangent-export (`Derived.affineCotangentComplex`).
3. **SchemeAndStackFoundations**: §§1.18–1.20 (`Stacks.algebraicStack` 279; ready now), §§1.15–1.16 (`Stacks.groupTorsor` 199; ready now), §§2.11, 2.15–2.16 (`Etale.*`).
4. **ReductiveGroups**: 8.2 and 9D, with Layers 5 and 7 (`Groups.pinnedData` 185, pinnings, root data, 2ρ; ready now), 7b (`SpectralProof.parabolicLevi`). **ReductiveGroupsPartII**: RG2.5.1 (`Groups.langlandsDual`, `Groups.dualityData`, `Groups.coweightParity`), RG2.1.5 (`Groups.zExtension`).
5. **JacobianChallenge** Layers B–C (`Curves.serreTrace`; ready now), and Layers B, D, E as inputs of `Curves.thetaCharacteristic_exists`. **AffineLieAlgebras** A2.2 (`SpectralProof.criticalLevel`; ready now).

The three nodes here with no roadmap node below them are `Curves.thetaCharacteristic`, `Curves.thetaCharacteristic_exists` (which still needs JacobianChallenge inputs by its `desc`) and `Constructible.complexPoints` (held).

## Worker command lines

The owner runs the Tau Ceti Worker in a terminal; a session here does not start it, and only folds in its results. Read the Worker's README first (https://github.com/TauCetiProject/TauCetiWorker); it is the authority on the flags. Tau Ceti asks that an intention is registered on its intentions board before substantial roadmap work. The brief for a target is `lake exe tracker show Roadmap.<area>.<Module>` or `lake exe tracker show <node id>`.

```
tauceti work --agent claude --roadmap-only BordismFormalGroups --extra-roadmap-prompt "F6.5, Categorical model and functor spaces: mapping spaces and homotopy-coherent functors between quasicategories, with composition and equivalences, built on SSet.rightMappingSpace and SSet.QCat."
tauceti work --agent claude --roadmap-only SchemeAndStackFoundations --extra-roadmap-prompt "§§1.18–1.20: stacks in groupoids, stackification, algebraic stacks and their presentations. §§1.15–1.16: torsors under group schemes in the fppf topology, contracted products and twisting."
tauceti work --agent claude --roadmap-only ReductiveGroups --extra-roadmap-prompt "Pinned data of a split connected reductive group (8.2), existence of pinnings (9D), its root datum and based root datum, and the cocharacter 2ρ as the sum of the positive coroots."
tauceti work --agent claude --roadmap-only JacobianChallenge --extra-roadmap-prompt "Layers B–C: the Serre duality trace H¹(X, ω_X) → k of a smooth proper connected curve, normalized, with base change."
tauceti work --agent claude --roadmap-only AffineLieAlgebras --extra-roadmap-prompt "A2.2: the critical level −½ Killing form for a reductive Lie algebra over a field of characteristic zero, without assuming nondegeneracy on the centre."
```

## Held

A node on this list is not started, here or through the Worker.

| Nodes | Reason | Released when |
|---|---|---|
| `Constructible.decompositionTheorem`, and the nodes whose only open input it is | the only use of a theory of weights; its proof route (ℓ-adic purity or Hodge theory) is the owner's choice | the owner chooses the route |
| `Hecke.loopArcGroups`, `Hecke.affineGrassmannian`, `Hecke.affineGrassmannian_reducedComponents`, `Hecke.schubertStratification`, `Hecke.iwahoriWeylGroup`, `Hecke.bottSamelsonResolution`, `Satake.semiInfiniteOrbits`, `Satake.semiInfiniteIntersection_dimension`, `Satake.convolution` | open roadmap PR #1734 would own them (`docs/blueprint-providers.md`, "Owner candidates") | #1734 merges (the nodes move to `plans/Roadmap/SheafTheoreticSmithTheory/`, within its limits) or closes without this scope |
| `Sheaves.qcoh`, `Sheaves.qcohGlobalSections` | open roadmap PR #1687 would own them | #1687 merges and its stacks are checked against the plan's QCoh, or it closes without this scope |
| `Constructible.complexPoints` | open roadmap PR #848 would own it | #848 merges or closes without this scope |
| `Groups.pinnings_torsor`, `Groups.simplyConnectedCover`, `Groups.chevalleyInvolution` | ReductiveGroupsPartII may own them | a check of ReductiveGroupsPartII shows whether it owns them (then they move to `plans/Roadmap/`) or not (then they are written here) |
| `Infinity.moduleOverMonoidalLocalization` | EnhancedDerivedSheaves (E5:abstract.2, E5:presentability.4) may own it | a check of EnhancedDerivedSheaves, as for the row above |

## Waiting for the owner

- **The tracker request (decision 6).** The draft is below; the owner sends it.

## Draft: request to the tracker's author

> **A separate state for placeholder declarations.** In GLCinLean the statement uses `opaque` declarations, marked with an attribute `@[placeholder]`, for objects that are not defined yet. The tracker counts them as `proved`, because they have no `sorry`. Two effects follow: `ready` treats a module above a placeholder as unblocked, and `lint` calls a placeholder's suggested `deps` superseded, although these are the only link from the statement to the rest of the plan. Could the tracker read an attribute named by an option (for example `--placeholder-attr placeholder`) and give such declarations their own state `placeholder`? It would count as not proved, keep the suggested dependencies in force as for an `open` declaration, and be counted on its own line in `status`. This would be a state of its own, not the `stated` state, because a placeholder does not use `sorryAx`. It is not urgent for us: until then we list placeholders with `grep` and keep their `desc` and `deps` by hand.

## Open items

- **Scope of `Sheaves.determinant`.** It plans the determinant of every perfect complex. It has two users, `Stacks.determinantBundle` and `Satake.criticalDeterminantGerbe`; the second also needs a relative determinant with factorization and sign compatibility. Its scope is narrowed only after both users are checked (decision 7).
- **Later task: an automatic axiom check (W10).** Replace the hand-kept list in `tools/check-statement-axioms.lean` by a script that lists every declaration of `GLCinLean` itself, prints the axioms of each, and fails unless `sorryAx` appears only in the main theorem and all other axioms are `propext`, `Classical.choice` and `Quot.sound`. Until then the file and `#print axioms` stay the check. The tracker is only a second check: it calls a declaration `stated` even when it also uses a forbidden axiom, and its totals count planned declarations only.
- **Later task: narrow roadmap scoping (W12).** A session of its own, not part of Session 4: check #1687 first, then scope the first general layer of the plan that no roadmap covers (for example derived prestacks), for the owner to propose as a roadmap.

## Decisions taken

- 2026-11-10, the owner's decisions on `notes/review-goal.md` (1 to 10), `notes/review-workflow.md` (W1 to W12) and the independent opinion. The text is in `prompts/next-steps.md`, "The owner's decisions". Session 4a applied these:
  - 4: this file names the upstream targets that block the plan.
  - 5: `plans/Mathlib` and `plans/TauCeti` are deleted; a node names the upstream declarations it uses and their modules; a `desc` says only "Provider: here" or "Provider: roadmap ⟨area⟩, ⟨target⟩"; the one snapshot is `docs/blueprint-providers.md`. This settles the ReductiveGroups locators that #1676 changed.
  - 6: the tracker request is drafted above.
  - 7: `QCohLS` depends on `Sheaves.qcoh` and `LocalSystems.deRham`; the providers of `Sheaves.determinant` and `Hecke.schubertStratum_deRhamCohomology_even` are corrected.
  - 8: #1734, #1687 and #848 are owner candidates in `docs/blueprint-providers.md`; their nodes are held.
  - 9: AxiomMath Stacks and Weil are prior art for Worker ports, case by case; no port now.
  - W1: the owner runs the Worker; the command lines are above.
  - W2, W6: `prompts/build.md` is replaced; a standards check comes before the meaning review; `lake lint` is in the done check. It keeps "module actions" until Session 4c.
  - W3: roadmap-owned nodes are under `plans/Roadmap/<area>/`.
  - W4: the review and approval rule in `AGENTS.md`, "The statement".
  - W5: `prompts/review.md` checks meaning only.
  - W7: `prompts/audit.md`.
  - W8: `AGENTS.md` on subagents' worktrees and on the pins.
  - W9: each caution has one home; the "Held" list is above.
  - W10: the axiom check stays; its automation is a later task.
  - W11: the three decisions below.
- 2026-11-10, from the plan session, accepted by the owner (W11):
  1. **Open Tau Ceti roadmap pull requests.** Use them as design evidence, with their exact head recorded. The accepted roadmap stays the authority until a proposal merges. Never import a proposal's `Suggested.lean` or pin this project to an unmerged branch.
  2. **Other Lean libraries.** Read-only discovery and reuse of ideas under compatible licences. Adding a dependency first needs a list of the declarations used, compatible Lean and Mathlib versions, a licence check, an axiom audit and a comparison with the existing objects.
  3. **The ∞-categorical layer.** Build the enhanced theory on Mathlib quasicategories and Tau Ceti's DG nerve and K-injective models, following the accepted EnhancedDerivedSheaves and BordismFormalGroups targets. Do not start a competing foundation, and do not replace enhanced categories by triangulated ones.
- 2026-11-10, Q1: parity of IC stalks over C goes through the simply connected group, Bott–Samelson pushforwards and the decomposition theorem ([JuteauMautnerWilliamson] §4).
- 2026-11-10, Q2: one chosen pinning of the Tannakian group, with `Satake.dualIdentificationChangePinningIso` showing that another choice changes nothing essential.
- 2026-11-11, the statement (decisions 1, 2 and 10), decided at the owner's request from the review `notes/reviews/a09a016.md` (on the branch) and the independent assessment `notes/reviews/b4740c9.md`:
  - **Approve** the branch `proposal/hecke-form` at `b4740c9`. The second property of `IsLanglandsFunctor` is the equivalence `Maps(V ⋆ Poinc, M) ≃ Maps(Loc V, Ψ (F M))`, natural in `V` and `M` together; functors are continuous `k`-linear functors; the statement has 28 placeholders. Both reviews find no *mismatch*.
  - **U1, the ground field.** Keep the wording of the branch: [GLC1] §0.1.1 asks only for characteristic zero, its conventions follow [AGKRRV], and algebraic closedness is the project's scope. One change: write "largely follow", as [GLC1] §0.5.7 says, because the paper does not import every convention of [AGKRRV].
  - **U2, mapping spaces.** Keep mapping spaces, as decision 1 says. The Lean property gives back `Ψ ∘ F ≃ 𝕃_{G,coarse}` as an equivalence of the underlying functors of ∞-categories; whether that equivalence can be chosen `k`-linear is not proved, which is not the same as false. The main theorem is not affected: on compact objects `F` and `𝕃_G` land in the bounded-below part, where `Ψ` is an equivalence, so compact generation makes `F` and `𝕃_G` equivalent as functors of ∞-categories, and a `k`-linear functor whose underlying functor is an equivalence is an equivalence of DG categories. One change: replace "equal form" by "an equivalent form for the underlying functors of ∞-categories", in the same words in every place.
  - **Obligations of the proof.** Two planned theorems, both outside the statement's plan: the comparison `Langlands.isLanglandsFunctor_iff_comp_psi_iso_coarse` of the second property with the paper's, and a theorem for the whole statement: any two functors with the two properties are equivalent as functors of ∞-categories, so one is an equivalence exactly when the other is (by full faithfulness of the right adjoint of `Loc`, compact generation, and detection of equivalences in `DGCat`). With the comparison theorem, `𝕃_G` of [GLC1] Cor. 1.6.5 is one such functor; the plan needs no node for `𝕃_G` itself, whose existence rests on [GLC1] Thm. 1.6.2 and is part of the proof of the main theorem.

## Next

Session 4c of `prompts/next-steps.md`: the two docstring changes on the branch, a new review, the merge, and the plan cut. The owner's answer is filled in under its "Context".
