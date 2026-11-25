# Answers to round 1 on `proposal/unused-nodes`

The reports are `unused-nodes-checker-1.md` and `unused-nodes-codex-1.md` in this folder. The note of the branch is `unused-nodes.md`; its sections are cited below. Each answer names the finding, the decision, and the commit.

## Codex, change 1: the deletion of `LineBundle.picardGroupoid` is against "Plan" in `AGENTS.md`

**Accepted. The change is withdrawn.** "Plan" says: "A node of `plans/Roadmap/` is deleted only when its declaration is at the pin, its interface is checked, and a checker has checked its meaning." The class `PicardGroupoid` and its instance for `Core (InvertibleSheaf X)` are not at the pin. "Small and big changes" names the removal of a planned definition as a big change and gives no exception to this rule.

- The commit `4ec13f9` reverts `6506d9a`. `plans/Roadmap/SchemeAndStackFoundations/PicardGroupoid.toml`, `LineBundle.pullbackBraided`, `LineBundle.Root.pullbackTensorProductIso` and the rows of `docs/blueprint-providers.md` that changed with the node are as on `536cce3`. `git diff 536cce3 -- plans` shows only the node of change 3. The row of SchemeAndStackFoundations says 9 nodes in `plans/`, and the folder has 9.
- The fact stays in the plan: the `desc` of the node says "No node of `plans/` or of `plans-proof/` depends on this node."
- Both reports agree that no node needs the node. Whether a roadmap node without a user may leave `plans/Roadmap/` before its declaration is at the pin is a question of the rule, for the owner. Section 1 of the note states it.

## Codex, change 2: `Groups.chevalleyMap` asks for a generality that the upstream quotient does not cover

**Accepted. The node is stated for `k` and `H` in one universe.** The first sentence of its `desc` now has this condition, and says that these are the hypotheses of `Groups.nilpotentCoadjointCone` with the condition added.

- The reason for one universe, and not for "the universe of `k` is at most that of `H`": the node also asks for the image of the origin, a map of schemes `Spec k → 𝔥*//H`. The quotient is in the universe `max u v` of `Sym(𝔥)`, so this map exists only when `k` is in that universe. With `u ≤ v` this is `u = v`. Section 4.2 of the note shows both failures in Lean.
- Every user is in this scope. The three nodes that depend on `Groups.chevalleyMap` are for the reductive groups of the statement, and `TauCeti.ReductiveCommHopfAlgCat k` is the full subcategory of an object property of `FiniteTypeCommHopfAlgCat.{u, u} k`.
- No transport is planned for the other cases. It would need a copy of `k` or of `H` in the universe `max u v` (`ULift`) with the transport of the Hopf algebra and of the comodule, and no node needs it. The `desc` says so.
- `Groups.nilpotentCoadjointCone` (`plans/`) is unchanged: it is an ideal of `Sym(𝔥)` and uses no scheme, so its universes are free.
- The row of `TauCeti.ComoduleAlgebra.AffineQuotient.projection` in `docs/blueprint-providers.md` states the condition for `A = Sym(𝔥)`.

## Checker, unsure point 1: the upstream declarations were not elaborated

**Done.** The upstream modules are built in the worktree (Lake unpacked them from the cache). Section 4 of the note has the three test files and their full output.

- Section 4.1: `#check` and `#print axioms` for `AffineQuotient.quotient`, `projection`, `act_projection`, `desc` and `existsUnique_desc`: the signatures are those of section 2, and each depends only on `propext`, `Classical.choice` and `Quot.sound`. The examples at `A = Sym(𝔥)`, with `Derivation.adjointComodule` and `ComoduleAlgebra.symmetricAlgebra` as local instances, elaborate: the quotient, the map, the invariance and the universal property, for `k : Type u` with `H : Type (max u v)` and for `k H : Type u`; and the type of the image of the origin for `k H : Type u`. Exit status 0.
- Section 4.2: outside the scope, two examples fail as expected, with the errors quoted there.
- Section 4.3: `#check` and `#print axioms` for `equivalenceOfIsEquivalence` (the same three axioms), `#check` for its lemmas, the two triangle identities, the converse and `BandPreserving` with `id` and `comp`, and one example on `LocallyDiscrete Cᵒᵖ`. Exit status 0.
- The checker's drafts `Check1.lean` and `Check3.lean` were the starting point. The example of `Check1.lean` lacked the hypotheses `Module.Finite` and `Module.Projective` on the cotangent space, which `Derivation.adjointComodule` needs.

## Checker, unsure point 2: `Stacks.stackification` in the `deps` of `Stacks.bandPreserving_isEquivalence`

**Left as it is.** The entry stays, with the reason that the `desc` gives (the roadmap's "Needs" lines). Section 3 of the note records the checker's reading that the mathematics does not need it and that the entry is redundant through `Stacks.relativeGerbe`.

## Checker, unsure point 3: the ℤ-graded lines of the determinant have no node

**Not changed on this branch; an open item for the session.** `Satake.criticalTwistBunDeterminantEquiv` (`plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml`) uses the determinant of `Sheaves.determinant` with values in ℤ-graded lines with the Koszul sign rule, and `Sheaves.determinant` (`plans/GLCinLean/AlgebraicGeometry/Sheaves/Determinant.toml`) states neither these values nor their provider. The candidate on a scheme is the roadmap target `gradedPicardGroupoid` (SchemeAndStackFoundations §3.4), which `LineBundle.picardGroupoid` lists under "Not used by this plan". By "Small and big changes", the node is corrected when the work reaches it.

## Checker, minor: the row "TauCetiRoadmap main" of `docs/blueprint-providers.md`

**Done.** The row no longer names ArithmeticGaloisRepresentations as an area of `plans-proof/Roadmap/`. It says that the README of AffineLieAlgebras of `plans-proof/Roadmap/` changed, and that of ArithmeticGaloisRepresentations, "which owns no plan node and whose §1.11 the row of `TauCeti.ComoduleAlgebra.AffineQuotient.projection` quotes". The count of seventeen READMEs is unchanged: it is the count of the READMEs that were compared.

## Checker, minor: "The rule" in section 1 of the note

**Done.** Section 1 of the note quotes the sentence of `plans/README.md` and marks "a roadmap target that no node needs is not a node of the plan" as the planner's inference. It also quotes the rule of "Plan" that decides the question.

## Codex, change 3

No open objection. Nothing changed.
