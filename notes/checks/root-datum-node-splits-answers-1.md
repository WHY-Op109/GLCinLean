# Answers to round 1 of the checks of `proposal/root-datum-node-splits`

Round 1 checked the commit `bf674d6`. Codex's report is `root-datum-node-splits-codex-1.md` (two objections, four remarks). The checker's report has ten findings and the verdict *match* for both splits; it is not a file of the branch, so each of its findings is quoted here in one sentence. Every fix below is in the commit that adds this file, and `root-datum-node-splits-proposal.md` states the corrected plan.

## Codex

1. **Objection: `Groups.zExtension_exists` uses the simply connected cover and does not depend on it.** Right, and fixed. The node's text builds the z-extension "from the simply connected derived cover and a torus embedding of its finite central kernel", and the roadmap's proof "divides `G̃_sc × S` by a scheme-theoretic finite central subgroup" (ReductiveGroupsPartII, *z-extension-existence*, RG2 lines 2294–2302 at `b24abdf7`). `plans-proof/Roadmap/ReductiveGroupsPartII/ZExtension.toml`: the node names `Groups.SimplyConnectedCover` in its text and has it under `deps`; the isogeny theorem is then below it. The gap was on `main` too.

2. **Objection: the item `split-reductive-existence-isomorphism` is more than one pull request.** Right, and fixed for every part that can be stated as one item now; one part has no item, and the list says so.
   - The item is replaced by three items, each one statement: `split-reductive-root-datum-comparison` (the existence theorem over a field: the based root datum of the base change of the group over ℤ is the input datum), `pinned-isomorphism-unique` and `pinned-isomorphism-exists` (the two halves of the isomorphism theorem, for any two pinned groups over an algebraically closed field of characteristic zero). The sentence "Several pull requests: cut it when the root datum is on main" is gone.
   - The `needs:` are now exact. `langlands-dual-group` needs the comparison and no part of the isomorphism theorem. `duality-data-change-pinning` needs `pinned-isomorphism-exists` and no part of the existence theorem. `split-reductive-isogeny` needs `pinned-isomorphism-exists`. `simply-connected-cover` needs all three.
   - The part without an item is the group over ℤ of a root datum with its central torus and its pinning ("integral existence" in Codex's words). It is the end point of the roadmap's §§9A–9B, and it is more than one pull request: at the pin the Chevalley group schemes are semisimple (`TauCeti/Algebra/AlgebraicGroup/Chevalley/Datum.lean`, module doc comment), their torus is a morphism of schemes and no `TauCeti.SplitMaximalTorus`, they have no pinning, and `Chevalley/GenericFiber.lean` says that it "asserts neither smoothness nor point generation". To cut it into items needs a comparison of the targets of §§9A–9B (RG lines 3885–4861, about 1,000 lines) with Tau Ceti main and with the open #42030, #42969, #42734 and #43076 of other contributors. This change did not make that comparison: its scope is two nodes and their users, and an item written without it would be a guess. So the list does not present this part as an item. A remark line before `split-reductive-root-datum-comparison` states the fact and the action (compare, then write one item for each missing step, before that item leaves the notes), the item names the part under `waits for:`, and `STATUS.md` records it under "Nearest placeholders" and "Decisions taken". No worker can take an item that needs it: all of them are under "Notes (not targets)" and wait for #41782.
   - The sizes of the three new items are not measured. Each is one statement with its checks. `pinned-isomorphism-exists` is the largest; if it does not fit one pull request, the Worker ends the round and says why (the rule in the head of the list), and the session cuts it.

3. **Remark: `pinning-based-root-datum` still needs `pinning-borel-unipotent-radical`.** Right, and fixed: the need is removed. The item's statement is the root datum of the torus with the base that `borel-positive-system` gives, the comparison of the index set of `Pinning.rootSpaceEquiv` with that base, and the transport along `Pinning.comapOfIso`. No step names N. `borel-positive-system` does not need the item either; the decomposition of a solvable group that its proof may use is `solvable-group-maximal-torus-decomposition`, which is above it in the chain. So N is out of the workers' prerequisites of the duality as well as out of the plan nodes below the placeholder, and the count is 17.

4. **Remark: keep the splitting convention; the base is nonempty; §9B.3 alone does not give the classification of arbitrary groups.** Right, and written into the node and the items.
   - `Groups.splitReductiveGroup` now says what a pinned split group over a base is, with the roadmap's 8.1 and 8.2 (RG lines 3789–3832): the identification T ≃ D_S(M), roots and coroots that are constant sections, root spaces free of rank one, a pinning with one constant positive system; an isomorphism of pinned split groups is compatible with these identifications, so an isomorphism that changes the datum between components of a disconnected base is excluded. The base is nonempty ("over the empty base the group is empty and the root datum cannot be recovered from its fibres", RG 3805–3806). The root-free data and the data of rank zero are included (Layer 9D, RG 5403–5405, with Milne Theorem 23.55). Over a nonempty connected affine base the pinning is a `TauCeti.Pinning`.
   - The provider sentence says that §9B.3 compares the groups over ℤ only and that the isomorphism theorem for arbitrary pinned split groups is Layer 9D's. The item `pinned-isomorphism-exists` says the same and says what it proves: the bijection for any two pinned groups over the field.

5. **Remark: the other clauses and users are preserved.** No action.

6. **Remark: the mechanical checks pass.** No action. They pass again on the new commit (below).

## The checker

1. **`Satake.semiInfiniteOrbits`, last sentence, still names `Groups.pinnedData` for the unipotent radical.** Right, and fixed: it names `Groups.borelUnipotentRadical`.

2. **Four nodes of `plans-proof/` use the Whittaker character of the loop group of N and are not in the table of users; `Groups.zExtension_exists` lacks a dep.** Right. I added the dependency instead of only recording it, because the split caused the loss: on `main` the characters were below the four nodes through `Groups.pinnedData`, and on `bf674d6` they were below none. `Whittaker.finiteZastava`, `Whittaker.pointwiseCasselmanShalika`, `SpectralProof.sphericalWhittaker_equiv_representations` and `SemiInfinite.whittakerJacquet` now have `Groups.simpleRootCharacter` under `deps`. The table in section 3 of the note names them. `Groups.zExtension_exists` is Codex's finding 1.

3. **Nothing below `RootDatumDuality` uses the three parts.** No action.

4. **The rewording of the isomorphism theorem is a strengthening against the literal old text, and the right one.** No action. The note already names it as a change of wording in the direction of the source.

5. **The isomorphism node need not depend on the isogeny node; optional: say in the item that the isomorphism theorem is proved without the general isogeny theorem.** Done: `pinned-isomorphism-exists` says "prove it without the isogeny theorem for maps of root data that are not isomorphisms, which is the later item `split-reductive-isogeny`".

6. **`Groups.pinnedData` is at the pin in full.** Recorded. The node's text, the note (section 5) and the entry under "Decisions taken" say that the check of this change agrees and that the session deletes the node as "Plan" in `AGENTS.md` says. The node is not deleted on this branch.

7. **"18 results" is a count of entries and a lower bound; `STATUS.md` should say what it counts.** Right, and fixed. The count is now 17 results (Codex's finding 3 removed N). `STATUS.md`, "Nearest placeholders", says that the 17 are a lower bound for the number of pull requests, that the group over ℤ is more than one pull request and has no item, that the isomorphism theorem is two items, and that the list has 18 open items toward the replacement. Section 7 of the note has the same account.

8. **Optional: say which generality the plan needs.** Done: `Groups.borelUnipotentRadical` and `Groups.simpleRootCharacter` say "The plan needs the case of an algebraically closed field of characteristic zero", and `Groups.splitReductiveGroup` says that over a nonempty connected affine base the pinning is a `TauCeti.Pinning` and that the plan uses the theorem over the field k.

9. **The item `split-reductive-existence-isomorphism` is not one pull request.** Fixed with Codex's finding 2.

10. **Small points.**
    - The root-height filtration of N has no node: recorded as an open point in the note (section 9) and in the entry under "Decisions taken". It is as on `main`.
    - The entry under "Decisions taken" had text about what changed ("replace one item", "in place of 20"): removed. The entry states the nodes, the items and the count as they are.
    - The direction of `TauCeti.RootPairingIsogeny`: the node `Groups.exists_isogeny_of_rootPairingIsogeny` and the item `split-reductive-isogeny` now say that an isogeny G′ → G induces an isogeny from the root pairing of G to that of G′, because the weight map of `RootPairingIsogeny P Q` goes from the weight lattice of P to that of Q (`TauCeti/LinearAlgebra/RootSystem/Isogeny/Basic.lean`, lines 104–131; [ConradRGS] Definition 6.1.8 has `h : X → X′` for `R′ → R`).

## Checks on the new commit

- `lake exe tracker lint`: no errors (61 warnings, as before).
- `python3 tools/check-module-cycles.py`: 202 module plans, 314 nodes, 0 cycles. The graph of `plans/` and `plans-proof/` together: 509 nodes, no cycle, no dependency without a node, and no node of `plans/` that depends on a node of `plans-proof/`.
- `python3 tools/check-upstream-names.py`: 517 pairs, 0 not confirmed.
- The target list (a local script): the eleven items that this change adds or edits parse, their `needs:` name items, their `serves:` name nodes, and no final clause has brackets; the list has no cycle.

## The count

17 results of Tau Ceti stand between the plan and the replacement of `RootDatumDuality` (20 on `main`): the results 1 to 3, 5 to 11, 13 to 16 and 18 to 20 of the list in section 7 of the note. In the target list they are 18 open items and the group over ℤ, which has no item and is more than one pull request. `Groups.dualityData` alone needs 10.
