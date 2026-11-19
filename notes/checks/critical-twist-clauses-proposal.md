# Proposal: the two compatibility clauses of `Satake.criticalTwistBunDeterminantEquiv` (audit finding B8)

## Summary

The finding holds on `main` at `0c1bcf5`. The chosen option is (a), with one addition. The node `Satake.criticalTwistBunDeterminantEquiv` of `plans/` keeps the equivalence of gerbes, now fixed by its construction and with a test on the unit section. Its compatibility with the composition of modifications and with factorization moves to one new node of `plans-proof/`, `Satake.criticalTwistBunDeterminantEquiv_comp`.

The reason: the statement uses only the functor `V ↦ V ⋆ M`, and the two clauses are part of the action structure, which is already in `plans-proof/`. The clauses cannot be stated from the nodes of `plans/` at all, because no node of `plans/` has the composition map of the Ran Hecke stack. The statement is not weakened: the equivalence is the same object, and the Hecke functor built from it is the same functor.

## 1. The problem

The node `Satake.criticalTwistBunDeterminantEquiv` (module plan `plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml`) asks for an equivalence of gerbes on the Ran Hecke stack "compatibly with factorization and composition of modifications". The audits of 2026-11-18 (B8) and 2026-11-19 (F4) found that these two clauses have one user, `Hecke.sphericalAction_associativity`, which is in `plans-proof/`. The question is whether the two clauses belong to the statement's plan. Moving them drops a claim from `plans/`, so it is a big change.

## 2. Evidence

**The node.** `lake exe tracker show GLCinLean.Satake.criticalTwistBunDeterminantEquiv` at `0c1bcf5`: kind definition, state open, needed by `Hecke.sphericalAction` only. Its `deps` are `Satake.criticalDeterminantGerbe`, `Stacks.determinantBundle`, `DModules.TwistedCrystals`, `Hecke.Correspondence`, `Hecke.loopGroupAction` and `Stacks.rootGerbe`.

**The users in `plans/`.**
- `Hecke.sphericalAction` builds the functor `(S, M) ↦ S ⋆ M` by pull-push along the Ran Hecke stack. It uses the equivalence to see the pulled-back kernel as twisted by `h_out^*𝒢 ⊗ (h_in^*𝒢)^{-1}`. Its text says that the statement uses only this functor, and that the action structure is `Hecke.sphericalAction_associativity` in the plan of the proof.
- `Hecke.action` is the only user of `Hecke.sphericalAction`. Its users are `Statement.heckeActionRight`, `Satake.dualIdentificationChangePinningIso` (natural isomorphisms of functors; its monoidal form is in `plans-proof/`) and `Examples.trivialGroup_isLanglandsFunctor_id` (the trivial group, where the gerbe is trivial). None of them uses the two clauses.

**The users in `plans-proof/`.** `Hecke.sphericalAction_associativity` names the node in its `deps` and says that it uses the compatibility with the composition of modifications. No other node of `plans-proof/` names the node. No file of `docs/`, `prompts/` or `GLCinLean/` names it.

**The composition map.** A search of `plans/` for the composition of modifications, of Hecke correspondences or of isomorphisms finds only the clause itself. `Hecke.Correspondence` has the Ran Hecke stack with its two projections and the factorization of the Grassmannians, and no composition map. So the clause on composition has no object in `plans/` over which it can be stated. The clause on factorization is the same compatibility over the disjoint locus: there the Ran Hecke stack at `x ⊔ y` is the fibre product over `Bun_G` of the Hecke stacks at `x` and at `y`, through the composition map.

**The placeholder.** `Statement.heckeActionRight` (`GLCinLean/Statement/Conjecture.lean`) is, for an object `M`, one continuous functor `RepRan S → DmodHalf S`. Its doc comment records the reformulation: the monoidal structure of `Rep(Ǧ)_Ran`, the functoriality in `M` and the associativity of the action are not part of the constant, because `IsLanglandsFunctor` uses only the functor `V ↦ V ⋆ M` for the vacuum Poincaré object. So a faithful definition of the placeholder needs the functor, and the functor needs the equivalence of gerbes over the whole Ran Hecke stack. It needs neither clause. The Hecke action is an action of a monoidal category only with the compatibility with composition, but that action structure is not part of the placeholder.

**The papers.**
- [GLC1] §1.2.1: the naive geometric Satake functor and the Hecke action define an action of `Rep(Ǧ)_Ran` on `Dmod_½(Bun_G)`. The paper's object is an action; the statement uses its functor.
- [GLys] §9.5.1: "the Hecke action defines a monoidal action of `Sph(Ran)` on" the twisted sheaves on `Bun_G`, where the gerbes on `Bun_G` are those of §2.3.5. No compatibility of the gerbes with composition is stated or proved there.
- [GLys] §2.3.5: a gerbe on `Gr_G` descends uniquely to `Bun_G`. So in [GLys] the gerbe on `Bun_G` comes from the gerbe on `Gr_G`; the plan defines `det^{1/2}_{Bun_G}` from `det_{Bun_G}` ([GLC1] §§1.1.1, 1.1.4), and the node is the comparison of the two.
- [GLys] §7.3.1: composition of isomorphisms makes the local Hecke stack a groupoid, compatibly with factorization, and a gerbe on it can have a multiplicative structure for the groupoid operation. This local structure is in `Satake.criticalDeterminantGerbe`.
- [GLC2] §10.1.2: the global Hecke groupoid over Ran maps to the local Hecke groupoid by restriction to the disc. §10.1.3: the pullback of a line bundle that is multiplicative on the local groupoid is multiplicative for the global groupoid structure. So multiplicativity is a structure relative to the groupoid structure of the global Hecke stack.
- [GLC2] §1.5.1: `Sph^non-ren_G` is a factorization monoidal category. [GLC2] Remark H.6.9: the binary operation of an integrated action is defined from less structure than its lax structures need.

## 3. The options

- **(a) Move the two clauses to a node of `plans-proof/`.** For: `plans-proof/` holds what only the proof needs, and the single user of the clauses is there. The same split is already made for `Satake.factorizationConvolution`, `Hecke.sphericalAction_associativity`, `Hecke.action_associativity` and `Satake.naiveFactorizationFunctor_monoidal`. The clauses need the composition map of the Ran Hecke stack, which is not in `plans/`. Against: the node of `plans/` loses the only property that tests the equivalence, and "the canonical equivalence" alone does not say which equivalence is meant.
- **(b) Leave the node.** For: the compatibilities are natural API of the equivalence ("Lean code": each definition gets the API that lets other files use it). Against: no file of the statement's plan uses this API, and "Lean code" also asks for no abstraction that nothing uses. To state the clauses, `plans/` would need the composition map of the Ran Hecke stack and the comparison of the local structures over the union map. That is work of the action structure, before the first goal, for no placeholder.
- **(c) Keep a part in `plans/`.** The part that `plans/` can state and use is the unit case: on the identity modification the equivalence is the evident one. The trivial-group example uses exactly this case.

## 4. The chosen option and what the branch changes

Option (a), with the unit case of (c) as a test of the node in `plans/`.

- `plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml`, node `Satake.criticalTwistBunDeterminantEquiv`:
  - the clause "compatibly with factorization and composition of modifications" is removed;
  - the equivalence is fixed by its construction: the isomorphism of line bundles between `det RΓ(X, ad(P′)) ⊗ (det RΓ(X, ad(P)))^{-1}` and the relative determinant of the two lattices on the disc, from the additivity of the determinant through a common subbundle `ad(P)(−nD)`, and then the functor of square roots of `Stacks.rootGerbe`. The node says why an equivalence that is only known to exist does not serve: two equivalences differ by a `μ_2`-torsor, which changes the Hecke functors;
  - a test is part of the node: on the unit section the isomorphism of line bundles is the contraction `det ⊗ det^{-1} ≅ 𝒪`;
  - the node names `Satake.criticalTwistBunDeterminantEquiv_comp` as the home of the two compatibilities;
  - `deps` gains `Sheaves.determinant` and `LoopGroups.RanLoopGroup`, which the text now names (both were already below the node); `source` gains [GLys] §§2.3.5, 5.2.1, 7.3.1 and [GLC2] §10.1.2.
- `plans-proof/GLCinLean/GeometricLanglands/Satake/Twisting.toml` (new module plan), node `Satake.criticalTwistBunDeterminantEquiv_comp`: the composition map of the Ran Hecke stack over the union map; the theorem that the isomorphism of line bundles at a composite is the tensor product of its values at the two factors; its agreement over the diagonal with the multiplicative structure and over the disjoint locus with the factorization of `Satake.criticalDeterminantGerbe`; and the resulting isomorphism of equivalences of gerbes with its cocycle condition. Both clauses of the old text are in this one node, because over the union map they are one statement.
- `plans-proof/GLCinLean/GeometricLanglands/Hecke/SphericalAction.toml`, node `Hecke.sphericalAction_associativity`: the text names the new node, and `deps` gains it.
- `plans-proof/README.md`, "Contents": the list of the monoidal structures on the Hecke side names the new node.

No Lean file, no file of `docs/` and no text of `GLCinLean.lean` changes: no declaration exists yet, and no difference from the papers is added. The meaning of the statement does not change, because `Statement.heckeActionRight` already excludes the action structure.

Checks on the branch: `lake build` passes; `lake exe tracker lint` has no errors; `python3 tools/check-module-cycles.py` reports 198 module plans, 312 nodes, 0 cycles; `python3 tools/check-upstream-names.py` confirms all 267 pairs; every `deps` entry of `plans-proof/` resolves, and no node of `plans/` depends on a node of `plans-proof/`.

## 5. Texts for `STATUS.md`

**Counts.** `plans/` is unchanged: 312 planned declarations in 198 module plans, 222 under `plans/GLCinLean/`, 90 roadmap nodes in fifteen areas. The entry on the plan of the proof changes: `plans-proof/` has 196 nodes in 75 module plans, 187 to be written here and 9 owned by six roadmaps.

**Decisions taken** (new entry):

- **The gerbe comparison on the Ran Hecke stack** (2026-11-19, audit finding B8). `Satake.criticalTwistBunDeterminantEquiv` in `plans/` is the equivalence of gerbes alone. It is defined by its construction: the isomorphism of line bundles between `h_out^* det ⊗ (h_in^* det)^{-1}` and the pullback of `det_{Gr_G}`, from the additivity of the determinant, in graded lines with the Koszul sign rule, and its image under the functor of square roots. Its test is the unit section, where the isomorphism sends the identity to the identity; the trivial-group example uses this case. Its compatibility with the composition of modifications and with factorization is `Satake.criticalTwistBunDeterminantEquiv_comp` in `plans-proof/`, together with the composition map of the Ran Hecke stack. The reasons: `Statement.heckeActionRight` is the functor `V ↦ V ⋆ M` without the action structure; the only user of the compatibility is `Hecke.sphericalAction_associativity`, in `plans-proof/`; and no node of `plans/` has the composition map over which the compatibility is stated.

**Open items.**

- The note for the writers on `Satake.criticalTwistBunDeterminantEquiv` is settled and is removed. In its place: the writer of `Satake.criticalTwistBunDeterminantEquiv` defines the isomorphism of line bundles by the construction of the node, uses graded lines, and proves the test on the unit section; the writer does not state the compatibility with composition or with factorization. The writer of `Satake.criticalDeterminantGerbe` forms the relative determinant with the refinement identifications of `Satake.criticalTwistBunDeterminantEquiv`.
- The item on the scope of `Sheaves.determinant` is replaced by: "**Scope of `Sheaves.determinant`.** It plans the determinant of every perfect complex. It has three users in the statement's plan: `Stacks.determinantBundle`, `Satake.criticalDeterminantGerbe` and `Satake.criticalTwistBunDeterminantEquiv`. The second and the third use the additivity of the determinant on exact triangles, with values in ℤ-graded lines and the Koszul sign rule; the text of `Sheaves.determinant` names neither. The second also needs a relative determinant with factorization. Its scope is narrowed only after the three users are checked."

**Audit.** Finding B8 is closed.

## 6. Worker guidance

None. No roadmap node changes, and no target of a Tau Ceti worker changes.

## 7. Open doubts

1. **The construction is not quoted from a paper.** No cited passage gives the isomorphism of line bundles in the form of the node. [GLys] §2.3.5 gets the gerbe on `Bun_G` by descent from `Gr_G`, and [GLC2] §9.3.1 uses a comparison of this kind along the map from the `ρ(ω_X)`-twisted Grassmannian to `Bun_G` without constructing it. The node gives the standard construction through a common subbundle. A checker should read it against [GLys] §5.2.1 (the relative determinant) and [GLC1] §1.1.1 (the normalized determinant).
2. **Signs.** The lines `det RΓ(X, ad(P))` have degree `dim G · (1 − g)`, which can be odd, while the relative determinant has degree zero. The theorem of the new node must fix the order of the tensor factors in its contraction, with the sign rule of `Sheaves.determinant`. A constant sign changes the equivalence of gerbes by the torsor of square roots of `−1`, which is trivial over an algebraically closed field but has no chosen trivialization.
3. **The composition map has no node of its own.** It is defined with `Satake.criticalTwistBunDeterminantEquiv_comp`, in the Satake folder. Its canonical home is the module of `Hecke.Correspondence`. When the proof starts, it may become a node of `plans-proof/` there.
4. **The kind of the new node.** It is a definition, because at the level of gerbes the compatibility is an isomorphism between equivalences. At the level of line bundles it is a theorem. The name ends in `_comp` as a lemma about composition would.
5. **The orientation.** The node now says that `P` is the image under `h_in` and `P′` the image under `h_out`. This agrees with its formula `h_out^* det ⊗ (h_in^* det)^{-1}` and with `Satake.criticalDeterminantGerbe` (the modified lattice against the trivial one). The open note on the orientation of the kernel of `Hecke.sphericalAction` is not touched.
6. **The unit test is a new obligation in `plans/`.** It is small, and it needs that the descended line bundle is trivial on the unit section of the local Hecke stack, which follows from the trivialization on the arc group in `Satake.criticalDeterminantGerbe`.
