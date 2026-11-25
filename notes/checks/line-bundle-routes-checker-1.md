# Check of `proposal/line-bundle-routes` (`bbbb797` = B2, `ffd8332` = B3)

Result in short. B2 is right in every item. B3 has the right objects, the right split and the right `deps`, but three of its texts must change before it is applied: one claim about the pin is false, one clause of the construction has a gap, and two sentences are out of date against `main`. No file of the repository was changed.

Worktree: `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-af74e0aca0fc92ecf`. Tau Ceti at the pin: `/Users/why/Documents/Projects/GLCinLean/.lake/packages/TauCeti` (HEAD `553f7926`).

## Mismatch and unsure (all in B3)

### M1. *Mismatch*: "a braided monoidal pullback is not at the pin" is false as stated

At the pin Tau Ceti has the braided monoidal pullback of quasi-coherent sheaves, with its two coherence isomorphisms:

- `TauCeti.AlgebraicGeometry.QuasicoherentSheaf.pullbackBraided : (QuasicoherentSheaf.pullback f).Braided`, in `TauCeti/AlgebraicGeometry/Modules/Pullback/Monoidal/Basic.lean`, line 169 ("strong symmetric monoidal for every scheme morphism").
- `QuasicoherentSheaf.isMonoidal_pullbackId_hom`, in `.../Pullback/Monoidal/Identity.lean`, line 78.
- `QuasicoherentSheaf.isMonoidal_pullbackComp_hom`, in `.../Pullback/Monoidal/Composition.lean`, line 184.
- For duals: `FiniteLocallyFreeSheaf.pullbackDualIso` with `pullbackDualIso_hom_id` and `pullbackDualIso_hom_comp`, in `TauCeti/AlgebraicGeometry/VectorBundle/Dual/Pullback.lean`, line 46; and `Scheme.Hom.pullback_map_evaluation_comp_pullbackObjUnitIso_hom`, in `.../Pullback/InternalHom/Coherence.lean`, line 233.

I confirmed the three instances with Lean (`inferInstance` succeeds). What is true: `InvertibleSheaf.pullback` itself has no monoidal instance at the pin (`inferInstance` for `(InvertibleSheaf.pullback f).Monoidal` fails). The open pull request #45392 is about all module sheaves and is still open; this part of the note is right.

Effect on the decision: none. The structure on `InvertibleSheaf.pullback` is still new code that belongs to Tau Ceti (roadmap §3.4), so the new node rightly depends on `LineBundle.picardGroupoid`. Effect on the texts: the remaining upstream work is a transport along the inclusion of invertible sheaves into quasi-coherent sheaves, not a new proof of coherence. The roadmap node is the brief of the author worker, so it must say this ("Sources of code").

What to change:
- `plans/Roadmap/SchemeAndStackFoundations/PicardGroupoid.toml`, line 6: add the three declarations and their modules to the list "In Tau Ceti". Change "Still to do … the symmetric monoidal pullback" and "this node adds its compatibility with the associativity, unit and symmetry isomorphisms" to: the braided monoidal structure on `InvertibleSheaf.pullback` is carried over from `QuasicoherentSheaf.pullbackBraided`, and the monoidal `pullbackId` and `pullbackComp` from the two instances above.
- `docs/blueprint-providers.md`: the new row of `InvertibleSheaf.dual` says "Not there: an isomorphism `f^*(L^{-1}) ≅ (f^*L)^{-1}`". Name `FiniteLocallyFreeSheaf.pullbackDualIso` there (it exists for finite locally free sheaves). The row of `Roadmap.SchemeAndStackFoundations.PicardGroupoid` and the row of `TauCeti.tensorPow` need the same three names.
- `notes/checks/root-tensor-route.md`, section 1, item 5 ("A monoidal pullback is not at the pin").
- `plans/GLCinLean/AlgebraicGeometry/LineBundle/RootTensorProductPullback.toml`, line 6: for `f^*(M^{-1}) ≅ (f^*M)^{-1}`, say whether it is `pullbackDualIso` or the isomorphism from `mapTensorIsoUnit` (see U1 for why this needs care).

### U1. *Unsure*: the dual of a root, in `LineBundle.Root.tensorProduct`

File `plans/GLCinLean/AlgebraicGeometry/LineBundle/RootTensorProduct.toml`, line 6. The object is right: the dual root exists, and the claim "the tensor product of a root and its dual is isomorphic to the trivial root of 𝒪, over L ⊗ L^{-1} ≅ 𝒪" is true for invertible sheaves. The construction in the node does not prove it, for two reasons.

1. `tensorPowInverseIso e n f` needs `f : N ⊗ X^{⊗n} ≅ 𝟙`, a left inverse isomorphism. Tau Ceti specifies only the right one, `tensorDualIso : L ⊗ L^{-1} ≅ 𝒪`. The node does not say where `f` comes from. The note's test point 6 takes `f` from the braiding.
2. With `f` from the braiding, the evaluation `M ⊗ M^{-1} ≅ 𝟙` is an arrow of roots only up to the self-braiding of `M^{⊗n}`. In a general symmetric monoidal category this is a sign. Example: for the odd line in super vector spaces and `n = 1`, `isoOfTensorIsoUnit` gives −1, and the claim fails. So the sentence "the operations on roots are the operations that a braided monoidal functor gives on its fibres" is not true for the dual with this formula. For invertible sheaves the self-braiding is the identity, but this fact is not at the pin (no declaration found), and the node does not name it. The compatibility of `dualCongr` with `tensorDualIso` is also not at the pin (`TauCeti/AlgebraicGeometry/LineBundle/Dual.lean` has no such lemma).

What to change (a small change of wording): define the isomorphism `ψ : (M^{-1})^{⊗n} ≅ L^{-1}` of the dual root by its property: `(φ ⊗ ψ)` followed by `L ⊗ L^{-1} ≅ 𝒪` equals `tensorPowTensorIsoUnit` of `M ⊗ M^{-1} ≅ 𝒪`. It exists and is unique because `L ⊗ −` is fully faithful, in every monoidal category, with no sign. Then the evaluation is an arrow of roots by construction. Or keep the formula and add to the node the two lemmas it needs: the self-braiding of an invertible sheaf is the identity, and `dualCongr` commutes with `tensorDualIso`. The same care applies to `f^*(M^{-1}) ≅ (f^*M)^{-1}` in the new node.

### S1. Out of date against `main` (B3; "Writing": current facts)

`main` has `tensorPowFunctor_ε`, `tensorPowFunctor_η`, `tensorPowFunctor_μ` and `tensorPowFunctor_δ` in `/Users/why/Documents/Projects/GLCinLean/GLCinLean/CategoryTheory/Monoidal/TensorPow.lean` (lines 345 to 413). When the branch is applied:
- `RootTensorProduct.toml`, line 6: "the lemma belongs to the module of CategoryTheory.tensorPowFunctor and is written there first" becomes a reference to `tensorPowFunctor_η`. Add that the isomorphism `(M ⊗ M′)^{⊗n} ≅ M^{⊗n} ⊗ M′^{⊗n}` is `TauCeti.tensorPowTensorIso` by `tensorPowFunctor_δ`, and add `TauCeti.tensorPowTensorIso` (`TauCeti.CategoryTheory.Monoidal.Braided.TensorPow`) to the upstream declarations. This also closes the planner's fourth unsure point.
- `docs/blueprint-providers.md`, line 103: "its comparison with `tensorPowUnitIso` and `tensorPowTensorIso` is not stated yet" and the new sentence after it.
- Note: `main` is two commits ahead of the base (`5b0bc7f`, `de24230`), not three. Neither touches `plans/` or `docs/`.

## Verdicts, B2 (`bbbb797`)

1. **Nodes against sources and users: *agree*.** [GLC1] §1.3.2 (`references/papers/2405.03599v3/src/functor.tex`, line 1511) fixes a square root as data and says nothing on ℙ¹; the node is an example of the plan. `Curves.thetaCharacteristicProjectiveLine` (`plans/GLCinLean/AlgebraicGeometry/Curves/ProjectiveLine.toml`, line 6) is the same object (𝒪(−1), φ), now with a formula. Its user `Examples.exists_setting_rank_pos` needs `(M.tensorProduct M).obj ≅ X.relativeDifferentials k` (`GLCinLean/Statement/Conjecture.lean`, line 219); the planner's `settingIso` has this type and elaborates.
2. **Upstream declarations: *agree*.** All named declarations are at the pin with only `[CommRing R]`: `projectiveLine` (line 149), `coord` (158), `coord_mem` (162), `iSup_basicOpen_coord_eq_top` (515), `affineCoordinate` (698), `smoothOfRelativeDimension` (853) in `ProjectiveSpectrum/ProjectiveLine.lean`; `tensorProductIso` (199), `tensorObjIso` (262), `tensorObjIso_hom_app_tmulRight` (281) in `TwistingSheaf/TensorProduct.lean`; `relativeDifferentialsIsoTwistingSheaf` (332) and `_inv_chartGenerator` (339) in `Modules/Differentials/ProjectiveLine.lean`; `chartGenerator`, `mul_chartGenerator`, `TauCeti.SymmetricAlgebra.isInvertible_twistingSheaf` in `TwistingSheaf/LocalTriviality.lean`; `InvertibleSheaf.relativeDifferentials` (`Rank.lean`, line 173). The covering family of degree one holds over every commutative ring. `(-1 : ℤ) + -1 = -2` holds by `rfl`. The planner's test elaborates, with axioms `propext`, `Classical.choice`, `Quot.sound` only. The signs are right: `hom(dt) = X₀^{−2}`, `hom(ds) = −X₁^{−2}`, so test lemma (a) gives `dt` and `−ds`. `Proj.tensorPowTwistingSheafIso` covers only 𝒪(1)^{⊗n} for `n : ℕ`, so nothing is written twice.
3. **Generality and the text of `Curves.ThetaCharacteristic`: *agree*.** Every commutative ring is the natural generality: no step uses a field, and `Scheme.relativeDifferentials` exists only over `Spec R` at the pin. The conversion text (`plans/GLCinLean/AlgebraicGeometry/Curves/Theta.toml`, line 6) is right: I wrote both directions for every `M` and `L` with `tensorProductIsoTensor` and the whiskered right unit isomorphism, and both elaborate. "A bijection for a fixed M" is true because `InvertibleSheaf X` is a full subcategory. The definition is unchanged, so the four other users are not affected.
4. **Rules: *agree*, one minor remark.** `GLCinLean/Statement/` is untouched (the diff of `GLCinLean/` is empty). Minor, "Writing": "The construction uses no classification of line bundles by their degree and no field" describes what the node replaces.
5. **Degenerate cases: *agree*.** Over the zero ring ℙ¹ is empty and every instance still holds (I instantiated `R = PUnit`). This case cannot reach the statement: `Statement.Setting` asks for a field and a connected curve. Test lemma (a) rules out a trivial reading over a field.

Test lemma (b) is true by the two definitions (`tensorProductObjIso`, `TensorProduct.lean` line 84; `tensorObjIso`, line 262): the composite cancels to `tensorProductIso`. I also did not close it in Lean in two attempts; the obstacle is the one the planner names (two names for the same category of module sheaves).

## Verdicts, B3 (`ffd8332`)

1. **Nodes against sources and users.** [GLys] §1.4.2 (`references/papers/1608.00284v7/src/text.tex`, lines 1610 to 1627) gives the pairs `(ℒ′, ℒ′^{⊗n} ≃ ℒ|_S)`; §1.4.4 uses tensor products of the gerbes; the paper gives no construction, so the route is a choice of the plan. Tensor product, functoriality, associativity, commutativity, unit, twist: *agree*. The dual: *unsure* (U1). The new node `LineBundle.Root.pullbackTensorProductIso`: *agree* on the object and its clauses.
2. **Upstream claims.**
   - `tensorPowFunctor (InvertibleSheaf X) n` gives `TauCeti.tensorPow`: *agree*. `obj` is `rfl`, `map` is `tensorPowMap` by `rfl`, so the arrows of the fibre are the arrows of `LineBundle.Root` (`φ = φ′ ∘ ρ^{⊗n}`). The `Braided` instance is found.
   - The unit: *agree*. `tensorPowTrivialIso_def` (`LineBundle/Power.lean`, line 72) with `tensorPowFunctor_η` identifies the unit root with the trivial root.
   - `InvertibleSheaf.dual` with `tensorDualIso` gives the dual of a root: *unsure* (U1). The declarations are at the pin (`Dual.lean`, lines 56, 95, 157) and test points 4 to 6 elaborate.
   - "The pullback part needs a braided monoidal pullback that is not at the pin": *mismatch* (M1).
   - Test points 7 and 8 (the passage through the core): *agree*, they elaborate.
3. **The split, the `deps`, `Stacks.rootGerbe`: *agree*.** `Root.tensorProduct` needs only `LineBundle.Root` and `CategoryTheory.tensorPowFunctor`. The new node has `Root`, `Root.tensorProduct`, `picardGroupoid`, `tensorPowFunctor`. `Stacks.rootGerbe` (`plans/GLCinLean/AlgebraicGeometry/Stacks/Gerbe.toml`, line 13) depends on both nodes and loses no clause. `picardGroupoid` keeps one user.
4. **Rules.** "Sources of code": M1. "Writing": S1; minor, "it does not pass to the Picard groupoid …, which it does not use" describes what the node replaces. "Found at the pin on 2026-11-20" in `docs/blueprint-providers.md` is older text, not from this change. "The statement": untouched.
5. **Degenerate cases: *agree*.** `n = 0`: `tensorPow M 0 = 𝟙` by `rfl`, the functor is constant and still braided monoidal, and a root is `𝟙 ≅ L`. The empty scheme: no instance has a hypothesis on `X`.

## Tools (both changes): *agree*

In the worktree: `lake exe tracker lint` exits 0 with no error (61 warnings, all on `GLCinLean.Statement.*` nodes, none on a changed node); `python3 tools/check-module-cycles.py`: 197 module plans, 310 nodes, 0 cycles; `python3 tools/check-upstream-names.py`: 348 pairs, 0 not confirmed.

## Blind reading

The change has no Lean item: only plan nodes, `docs/blueprint-providers.md` and two notes. So no blind reader was started. The Lean test texts of the notes were elaborated instead.

## Not checked

- Tau Ceti `main` after the pin, and the roadmap text of §3.4 and §4.3 (I took the planner's quotations).
- The statement of `LineBundle.Root` in Tau Ceti, which does not exist yet.
- A Lean proof of test lemmas (a) and (b) of B2, of the sign in U1 (shown by hand with the odd line), and of the first step of the new node (`f^*(L^{⊗n}) ≅ (f^*L)^{⊗n}` equals `tensorPowFunctorCompIso`).
- Whether the inclusion of invertible sheaves into quasi-coherent sheaves is a braided monoidal functor at the pin (only `toFiniteLocallyFree` was seen).
- The file `notes/checks/line-bundle-routes-codex-1.md`, which appeared untracked in the worktree during the check; I did not read it.

## What I ran

Test files are in `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/` (`B2.lean`, `B2b.lean`, `B3.lean`). One `lake build` unpacked three cached Tau Ceti modules (`Modules.Pullback.Monoidal.Basic`, `.Composition`, `.Identity`) into the build folder of the main checkout; no source file changed. I only read Tau Ceti; the one call to GitHub read the state of pull request #45392.