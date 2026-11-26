# Two node splits below `RootDatumDuality`

Branch `proposal/root-datum-node-splits`, on `main` at `df74883`. This note is steps 1 and 2 of `prompts/change.md`. Round 1 of the checks changed the points that `root-datum-node-splits-answers-1.md` lists, and this note states them as corrected. Section 1 is the problem, section 2 the sources, section 3 the users of each clause, sections 4 and 5 the options and the choice for each of the two nodes, section 6 the change on the branch, section 7 the count of results, section 8 the checks, and section 9 the points that stay open.

## 1. The problem

A placeholder is replaced only when every node below it is proved (`AGENTS.md`, "The statement"). Nine nodes are below `GLCinLean.Statement.RootDatumDuality` (the deps of its plan node, followed to the end): `Groups.dualityData`, `Groups.langlandsDual`, `Groups.dualityData_changePinning`, `Groups.basedRootDatum`, `Groups.rootDatum`, `Groups.pinning_exists`, `Groups.pinnings_torsor`, `Groups.pinnedData` and `Groups.splitReductiveGroup`. Two of them state several results in one node:

1. `Groups.splitReductiveGroup` (`plans/Roadmap/ReductiveGroups/Classification.toml`) states the existence theorem, the isomorphism theorem and the isogeny theorem of split reductive groups.
2. `Groups.pinnedData` (`plans/Roadmap/ReductiveGroups/PinnedRootData.toml`) states the torus, the Borel subgroup, the simple roots and the root vectors of a pinning, and also the unipotent radical N of the Borel subgroup and the normalized simple root characters N → 𝔾ₐ.

The question for each node: does the replacement of `RootDatumDuality`, or a node below it, use every clause? If not, the rule makes the replacement wait for results that it does not use. Tau Ceti has neither the isogeny theorem nor the simple root characters, and the characters wait for the open pull request #41782 of another contributor.

## 2. Sources

- The plan at `df74883`: `plans/` and `plans-proof/`, read with `lake exe tracker show <id>` and by a walk over the `deps` of every node.
- The statement: `GLCinLean/Statement/Conjecture.lean`, lines 104–145 (`RootDatumDuality`) and 147–224 (`Setting`).
- [GLC1], `references/papers/2405.03599v3/src/functor.tex`: §0.1.1, lines 716–719 (the Langlands dual group); §1.3.1, lines 1499–1508 (`Bun_{N,P_T} ≃ Bun_B ×_{Bun_T} pt`); §1.3.6, lines 1616–1636 (the map χ as the sum of the χ_i over the simple roots).
- [ConradRGS], `references/papers/ConradRGS/src/luminysga3-excerpt.tex`: Definition 6.1.8 (line 36), Example 6.1.9 (line 47), Theorem 6.1.16 (lines 148–153), the sentence before Theorem 6.1.17 and the theorem (lines 156–166), the remarks on the proofs (lines 169–173), Exercise 6.5.2 (lines 214–215).
- The roadmaps at TauCetiRoadmap `b24abdf7eb3b7465f1e3a17c4eaa3aca26b655d3`, the commit of `docs/blueprint-providers.md`. `TauCetiRoadmap/ReductiveGroups/README.md` (lines below as "RG"): Layer 5, the item "Solvable groups" (RG 2393–2413); Layer 7C (RG 3133–3137); 8.2 "Pinnings" (RG 3819–3855); §9B (RG 4510–4540), §9B.2 "Central quotients and realizations" (RG 4669–4680) and §9B.3 "Pinned comparison" (RG 4733–4741); Layer 9D, first item (RG 5397–5419). `TauCetiRoadmap/ReductiveGroupsPartII/README.md` (lines below as "RG2"): RG2.5.1, *langlands-dual-group* (RG2 6476–6500) and *pinned-automorphisms* (RG2 6542–6561). Read with `gh api -H "Accept: application/vnd.github.raw" "repos/TauCetiProject/TauCetiRoadmap/contents/TauCetiRoadmap/<area>/README.md?ref=b24abdf7"`.
- Tau Ceti at the pin `ea7f36aa9d31d22b2b362a282632d3956a8d22de`, in `.lake/packages/TauCeti`: `TauCeti/Algebra/AlgebraicGroup/Pinning/Basic.lean` (lines 57–127), `TauCeti/Algebra/AlgebraicGroup/Isogeny/Basic.lean` (lines 77–84), `TauCeti/LinearAlgebra/RootSystem/Isogeny/Basic.lean` (lines 104–131).
- The search of the pin that counted the missing results (its list of 20 results is quoted in section 7).

## 3. Who uses each clause

### `Groups.splitReductiveGroup`

| User | What it uses | Evidence |
|---|---|---|
| `Groups.langlandsDual` (below `RootDatumDuality`) | existence | its text: "the existence theorem of Groups.splitReductiveGroup for the flipped based root datum"; RG2 6479–6480: "Theorem 6.1.16(2), p. 196, for existence and Theorem 6.1.17, p. 197, for uniqueness of the pinned group"; its "Needs" names §§9B, 9B.1 and 9B.3, and not §9B.2 |
| `Groups.dualityData_changePinning` (below `RootDatumDuality`) | isomorphism | its text: "the torsor of pinnings (Groups.pinnings_torsor) with the isomorphism theorem"; source [ConradRGS] Theorem 6.1.17 and Proposition 7.1.6 |
| `Satake.dualIdentification` | isomorphism | "the unique isomorphism of pinned groups lifting the based-root-datum identification Groups.dualityData, by the isomorphism theorem" |
| `Groups.chevalleyInvolution` (`plans-proof/`) | isomorphism | "obtained from the isomorphism theorem applied to the automorphism −w0 of the based root datum" |
| `Groups.SimplyConnectedCover` | existence, isogeny (central isogenies), isomorphism for uniqueness | "the existence and isogeny theorems … give G_sc and the central isogeny G_sc → G_der"; source Theorem 6.1.16 and Example 6.1.9, and Theorem 6.1.17 for uniqueness |

No other node of `plans/` or `plans-proof/` names an isogeny of reductive groups as an input from this node (`grep -rni isogen plans plans-proof`). `Groups.SimplyConnectedCover` has one more user in `plans-proof/`, `Groups.zExtension_exists`, whose text builds a z-extension "from the simply connected derived cover"; its `deps` did not name the cover, and now do. `Groups.SimplyConnectedCover` is not below `RootDatumDuality`: its one user is `AffineGrassmannian.reducedNeutralComponent_iso_simplyConnectedCover`, which is below `Statement.heckeActionRight`.

The replacement of `RootDatumDuality` itself (the replacement contract of its plan node, and the description in its doc comment) is an isomorphism of based root data. Its example is the self-duality of the based root datum of `GL₂` (`Examples.exists_setting_rank_pos`). Neither uses an isogeny.

### `Groups.pinnedData`

| Clause | Users |
|---|---|
| (a) The torus T, the Borel subgroup B ⊃ T, the positive and simple roots, the root vectors | `Groups.basedRootDatum`, `Groups.splitReductiveGroup`, `Groups.pinnings_torsor` (all three below `RootDatumDuality`), `Groups.twoRho`, `Groups.torusToAdjointTorus_surjective`, `AffineGrassmannian.schubertStratification`, `AffineGrassmannian.iwahoriStratification`, `AffineGrassmannian.deRhamCohomology_schubertStratum_eq_zero_of_odd`, `Groups.chevalleyInvolution` |
| (b) The unipotent radical N of B, with B = N ⋊ T | `Whittaker.ReductionStack` (`Bun_B ×_{Bun_T} {ρ(ω_X)}` needs the map B → T; [GLC1] §1.3.1), `Satake.semiInfiniteOrbits` (the orbits of LN), `Stacks.unipotentTorsorFiltration` (`plans-proof/`) |
| (c) The normalized simple root characters N → 𝔾ₐ | `Whittaker.character` ([GLC1] §1.3.6); in `plans-proof/`, the four nodes that use the Whittaker character of the loop group of N: `Whittaker.finiteZastava`, `Whittaker.pointwiseCasselmanShalika`, `SpectralProof.sphericalWhittaker_equiv_representations` and `SemiInfinite.whittakerJacquet`. On `main` none of the four named `Groups.pinnedData`; the characters were below them through other nodes |

No node below `RootDatumDuality` uses (b) or (c). [GLC1] §0.1.1 names no Borel subgroup. The based root datum of a pinning is the root datum of T with the base of the simple roots of B; its statement names no N.

Clause (a) is at the pin in full: `TauCeti.Pinning` has the fields `torus`, `borel`, `isBorel`, `borel_le_torus` and `rootSpaceEquiv`, with `Pinning.rootVector`, and `SplitMaximalTorus.IsPositiveRoot` and `IsSimpleRoot` are defined from T and B. `Statement.Setting` already uses `TauCeti.Pinning`.

## 4. Question 1: `Groups.splitReductiveGroup`

Options.

1. No change.
2. Split off the isogeny theorem: the node keeps existence and isomorphism, and the isogeny theorem is a node with `Groups.SimplyConnectedCover` as its user.
3. Three nodes: existence, isomorphism, isogeny.
4. Option 2, and also restrict the isogeny theorem to central isogenies over a field of characteristic zero, the one case that a node uses.

Choice: option 2.

- The sources state two theorems. [ConradRGS] Theorem 6.1.17 says that the functor from pinned split reductive groups to based root data, with isomorphisms as morphisms, is an equivalence. Existence is its essential surjectivity, and the isomorphism theorem is its full faithfulness. So existence and isomorphism together are one statement, and option 3 would cut one statement in two for no user: every node below `RootDatumDuality` that uses one of them has the other below it too. The isogeny theorem, Theorem 6.1.16(1), is about maps that are not isomorphisms.
- The roadmap states them apart. §9B is the construction of the group over ℤ. §9B.3 is the pinned comparison, with Theorem 6.1.17. §9B.2 has the central isogenies, with Theorem 6.1.16(1). The first item of Layer 9D names "The **isomorphism** and **existence theorems**" and then, as a further clause, "central isogenies and the isogeny theorem" (RG 5397–5402).
- The split is sound for the proofs. In [ConradRGS] the isomorphism theorem is "an immediate consequence of Theorem 6.1.16" (line 156), so in that route its proof uses the isogeny theorem, but only for the morphisms of root data that are isomorphisms; that case is the full faithfulness that the kept node states. The classical route proves the three theorems apart (line 169 cites three results of Springer's book). In the other direction, over a field of characteristic zero every isogeny that is compatible with the splittings is central (Example 6.1.9, with p = 1), and a central isogeny of root data comes from the quotient of the source group by a finite central subgroup of its torus and the isomorphism theorem. The new node has `Groups.splitReductiveGroup` under its `deps` for this route, and no node below `RootDatumDuality` depends on the new node.
- "The statement": nothing is weakened. The text of the isogeny clause moves unchanged. The kept node says in addition what its users need and [ConradRGS] Theorem 6.1.17 states: the isomorphism theorem is for any two pinned split groups over one base, and not only for base changes of the groups over ℤ. `Groups.dualityData_changePinning` applies it to two pinnings of an arbitrary group, and `Satake.dualIdentification` to the Tannakian group. The old words "between two such groups" could be read either way.
- Option 4 is not chosen. It weakens a theorem that the plan asks for, which is a big change of its own, and the node is not needed for the current work: it is below `Statement.heckeActionRight` and not below `RootDatumDuality`. Section 9 records it.

The name `Groups.exists_isogeny_of_rootPairingIsogeny` spells the conclusion with the structure at the pin, `TauCeti.RootPairingIsogeny`: an isogeny of root pairings with an exponent at each root, which is the p(S)-morphism of [ConradRGS] Definition 6.1.8 without the condition that the exponents are powers of one prime.

## 5. Question 2: `Groups.pinnedData`

Options.

1. No change.
2. Two nodes: (a) and (b) stay, (c) becomes a node.
3. Two nodes: (a) stays, (b) and (c) become one node.
4. Three nodes: (a) stays, (b) is a node, (c) is a node.

Choice: option 4.

- One concept for each node. The three clauses are three definitions with three sets of users (section 3) and three sets of prerequisites: (a) is at the pin; (b) is the item `pinning-borel-unipotent-radical`, which needs only `solvable-group-maximal-torus-decomposition` and does not wait for #41782; (c) is the item `pinning-simple-root-characters`, which needs (b) and the root subgroups of `root-subgroup-coroot`, and waits for #41782. The target list already has one item for each.
- Option 2 leaves N below `RootDatumDuality`, which no node there uses, and keeps `Groups.pinnedData` open until N is at the pin. Option 3 makes `Whittaker.ReductionStack`, `Satake.semiInfiniteOrbits` and `Stacks.unipotentTorsorFiltration` wait for the characters and for #41782, which they do not use: it repeats, for these nodes, the defect that this change removes for the duality.
- With option 4, `Groups.pinnedData` is at the pin in full. It can then be deleted as "Plan" in `AGENTS.md` says. The checker of round 1 read `TauCeti.Pinning`, `SplitMaximalTorus.IsPositiveRoot`, `IsSimpleRoot` and `Pinning.rootVector` clause by clause, with a blind reader, and agrees that they are all of the node. This change does not delete it: the session does, after this change is applied, and the deletion rewrites the text of fifteen users.
- The roadmap: (a) is 8.2 "Pinnings". (b) is the item "Solvable groups" of Layer 5 (`G = G_u ⋊ T`, RG 2406) for the Borel subgroup of a pinning, and Layer 7C keeps "B+=T⋉U+" (RG 3135). (c) is the "normalized simple-root parameterizations" of 8.2 (RG 3832) with the root subgroups and the positive-height filtration of Layer 7C; the roadmap names no target for the characters, as the item of the target list already says. The provider of each clause is the same as before the split.
- "The statement": nothing is weakened. Each clause of the old node is in one of the three nodes, and each user depends on the node of the clause that it uses. Two sentences are more exact than before: N and the characters are stated for a group over a field, where `TauCeti.FiniteTypeCommHopfAlgCat.unipotentRadical` is defined, and the sentence that N modulo its derived subgroup is the product of the simple root subgroups is stated in characteristic zero, where it holds.

## 6. The change on the branch

Plan nodes.

- `plans/Roadmap/ReductiveGroups/Classification.toml`: `Groups.splitReductiveGroup` keeps existence and isomorphism (source: [ConradRGS] §6.3 and Theorems 6.1.16(2), 6.1.17). New node `Groups.exists_isogeny_of_rootPairingIsogeny` (theorem; deps `Groups.rootDatum`, `Groups.splitReductiveGroup`; source: Definition 6.1.8, Example 6.1.9 and Theorem 6.1.16(1)). `Groups.SimplyConnectedCover` gets the new node under its deps and names it in its text. The kept node also says what a pinned split group and an isomorphism of such groups over a base are (the roadmap's 8.1 and 8.2: a fixed splitting of the torus, constant roots and coroots, one constant positive system), that the base is nonempty, and that the root-free data and the data of rank zero are included.
- `plans/Roadmap/ReductiveGroups/PinnedRootData.toml`: `Groups.pinnedData` keeps clause (a) (source: [GLC1] §§1.3.1 and 1.3.6). New nodes `Groups.borelUnipotentRadical` (definition; deps `Groups.pinnedData`; source [GLC1] §1.3.1) and `Groups.simpleRootCharacter` (definition; deps `Groups.borelUnipotentRadical`, `Groups.pinnedData`, `Groups.rootDatum`; source [GLC1] §1.3.6). The module `desc` names them.
- Users: `Whittaker.ReductionStack` and `Satake.semiInfiniteOrbits` get `Groups.borelUnipotentRadical`; `Whittaker.character` gets `Groups.simpleRootCharacter`; `Stacks.unipotentTorsorFiltration` (`plans-proof/`) gets `Groups.borelUnipotentRadical`; `Groups.zExtension_exists` (`plans-proof/`) gets `Groups.SimplyConnectedCover`. Each names the node in its text. The four nodes of `plans-proof/` that use the Whittaker character of the loop group of N get `Groups.simpleRootCharacter` under their deps. The other users keep their deps.

Target list (`docs/worker-targets/targets.md`).

- `split-reductive-existence-isomorphism-isogeny` becomes four items, each one statement: `split-reductive-root-datum-comparison` (the existence theorem over a field: the based root datum of the base change of the group over ℤ is the input datum), `pinned-isomorphism-unique` and `pinned-isomorphism-exists` (the two halves of the isomorphism theorem for any two pinned groups over an algebraically closed field of characteristic zero), and `split-reductive-isogeny` (serves the new node; needs `pinned-isomorphism-exists`). The first three serve `Groups.splitReductiveGroup`. No pull request names the old slug: the item is under "Notes (not targets)" and was not started.
- The group over ℤ of a root datum with its central torus, the first part of the existence theorem, is the end point of the roadmap's §§9A–9B. It is more than one pull request, and the list has no item for it: a remark before `split-reductive-root-datum-comparison` says so, says what Tau Ceti main has, and says what to do before that item leaves the notes. The item names it under `waits for:`.
- `langlands-dual-group` needs `split-reductive-root-datum-comparison` and no part of the isomorphism theorem. `duality-data-change-pinning` needs `pinned-isomorphism-exists` and no part of the existence theorem. `simply-connected-cover` needs the comparison, `pinned-isomorphism-exists` and `split-reductive-isogeny`.
- `serves:` follows the node ids: `pinning-borel-unipotent-radical` and `solvable-group-maximal-torus-decomposition` serve `Groups.borelUnipotentRadical`, `pinning-simple-root-characters` serves `Groups.simpleRootCharacter`, and `pinning-based-root-datum` no longer serves `Groups.pinnedData`.
- `pinning-based-root-datum` no longer needs `pinning-borel-unipotent-radical`: its statement (the root datum of the torus with the base of `borel-positive-system`, the comparison of the index sets, the transport along `Pinning.comapOfIso`) names no N.
- No other `needs:` changes. The final clause of each new or changed item has no brackets.

Other files: `docs/blueprint-providers.md` (the row of ReductiveGroups, now 11 nodes, and the row of `Roadmap.ReductiveGroups.PinnedRootData`); `STATUS.md` (the counts under "Nearest placeholders" and "Plan", the slug under "The way to the root datum", and an entry under "Decisions taken"). No Lean file changes.

## 7. The count of results

The search of the pin listed 20 results between the plan and the replacement of `RootDatumDuality`: (1) `central-vector-subgroup-unipotent-radical`, (2) `solvable-group-maximal-torus-decomposition`, (3) `maximal-tori-conjugate-affine-group`, (4) `pinning-borel-unipotent-radical`, (5) `borel-subgroups-containing-torus`, (6) `semisimple-rank-one`, (7) `root-subgroup-coroot`, (8) `root-datum-of-split-maximal-torus`, (9) `borel-positive-system`, (10) `pinning-based-root-datum`, (11) the duality data, (12) the simple root characters, (13) `pinning-exists`, (14) the base change of a pinning, (15) the existence theorem, (16) the isomorphism theorem, (17) the isogeny theorem, (18) the torsor of pinnings, (19) the Langlands dual group, (20) the change of pinning.

- Before: 20. Results 12 and 17 were needed only because their clauses were in nodes below the placeholder. Result 4 was needed only because the item `pinning-based-root-datum` named it under `needs:`, when that item also served the N of `Groups.pinnedData`.
- After: 17, the results 1 to 3, 5 to 11, 13 to 16 and 18 to 20. Results 12 and 17 are in nodes that are not below `RootDatumDuality`, and result 4 is N, which no node below the placeholder and no item toward it uses.
- In the target list the 17 results are 18 open items and one part without an item. Result 15, the existence theorem, is the group over ℤ of the roadmap's §§9A–9B (no item; more than one pull request) and the item `split-reductive-root-datum-comparison`. Result 16, the isomorphism theorem, is the items `pinned-isomorphism-unique` and `pinned-isomorphism-exists`. The other 15 results are one item each.
- The type of duality data alone (`Groups.dualityData`) needs 10 results: 1 to 3 and 5 to 11.
- In the plan, the deletion of `Groups.pinnedData` (section 5) is also needed before the replacement. It needs no result of Tau Ceti.

## 8. Checks

Run in the worktree, with the dependencies of the main checkout.

- `lake exe tracker lint`: no errors (61 warnings, all "superseded by its doc comment" or "by the real dependencies", on nodes of `plans/GLCinLean/Statement/`, as at `df74883`).
- `python3 tools/check-module-cycles.py`: 202 module plans, 314 nodes, 0 cycles. The graph of `plans/` and `plans-proof/` together has no cycle and no dependency without a node (a local script).
- `python3 tools/check-upstream-names.py`: 517 pairs, 0 not confirmed (513 at `df74883`; the four new pairs are `IsIsogeny`, `IsCentralIsogeny`, `RootPairingIsogeny` and `adjointWeightSpaceEquivOfEtaleKernel`, each with its module).
- The target list, by a local script (`tools/deploy-worker-targets.py --check` needs the workers' host and was not run): each of the eleven items that this change adds or edits parses, its `needs:` names items of the list, its `serves:` names nodes of the plan, and its final clause has no brackets; the list has no cycle, and every `serves:` of the list names a node of the plan.

## 9. Points that stay open

1. **Only the central case of the isogeny theorem has a user.** `Groups.SimplyConnectedCover` uses central isogenies over a field of characteristic zero. The node states the theorem over a nonempty base with the powers of the characteristic exponent. A restriction is a big change of its own, for the time when the work reaches `Statement.heckeActionRight`. The item `split-reductive-isogeny` tells the worker to say in the pull request when only the case of characteristic zero is proved.
2. **`Satake.semiInfiniteOrbits` names an opposite unipotent radical N⁻.** No node defines it, before or after this change: the old `Groups.pinnedData` had N only. The node now names `Groups.borelUnipotentRadical` for N and leaves N⁻ as it was. A node for the opposite Borel subgroup is needed when the work reaches it.
3. **The roadmap names no target for the simple root characters.** This is as before. If Tau Ceti declines them, `Groups.simpleRootCharacter` comes back through `prompts/change.md`; as a node of its own it can then be written here on Tau Ceti's N.
4. **The doc comment of `RootDatumDuality` and its plan node describe two forms of the replacement.** The doc comment says that the constant takes "the field and the two groups and nothing else: no torus, Borel subgroup or pinning enters", with the based root datum of [ConradRGS] Rem. 7.1.2. The plan node's replacement contract says "change its signature to take the input and dual pinnings". The tracker treats the doc comment as the description in force. Neither form uses the isogeny theorem, N or the characters, so the two splits do not depend on this point. It is a change to `GLCinLean/Statement/` and is not part of this branch.
5. **The group over ℤ of a root datum has no item.** It is the end point of the roadmap's §§9A–9B and more than one pull request. Its items need a comparison of the targets of §§9A–9B (about 1,000 lines of the roadmap) with Tau Ceti main and with four open pull requests of other contributors, which this change did not make. It blocks no work now: every item after it waits for #41782 and for the root datum.
6. **No node states the root-height filtration of N.** `Stacks.unipotentTorsorFiltration` uses it with additive quotients, and `Groups.simpleRootCharacter` rests on it (the root subgroups of height at least 2 are a normal subgroup). This is as on `main`.
7. **Findings of the local script in lines of the target list that this change does not touch**, as on `main`. Five items under "Notes (not targets)" have no `needs:` field: `diag-representable-iff`, `is-algebraic-stack`, `perfect-dual`, `perfect-generator` and `differential-operators-affine-comparison`. The final clause of `bounded-lattices-stable-submodules` contains the square brackets of `R[[t]]`; its `needs:` is `none`.
