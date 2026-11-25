# Answers to round 1 of the checks of `proposal/line-bundle-routes`

The two reports are `notes/checks/line-bundle-routes-checker-1.md` (the checker) and `notes/checks/line-bundle-routes-codex-1.md` (Codex). They check `bbbb797` (B2, the theta characteristic of the projective line) and `ffd8332` (B3, the tensor product of roots). Each finding below was checked against the files and against Tau Ceti at the pin `553f7926`. The branch was first merged with `main` at `de24230` (`ab10a93`). The fixes are `48b50de` (B2) and `a93ec5a` (B3).

In short: every finding is right, and each is fixed, with one limit. Objection 1 of Codex to B2 concerns a gap of `Curves.ThetaCharacteristic` that is older than this change; the new text no longer depends on it, and the gap itself stays open.

After the fixes `lake exe tracker lint` has no errors, `python3 tools/check-module-cycles.py` finds no cycle (197 module plans, 310 nodes), and `python3 tools/check-upstream-names.py` confirms all 359 pairs.

## B2: the theta characteristic of the projective line

### Codex, objection 1: `Curves.ThetaCharacteristic` over an arbitrary base has no input for `Ω¹_{X/S}`

**Fixed for the text that this change adds (`48b50de`); the gap of the node itself is not changed.**

The objection is right. `Scheme.relativeDifferentials` takes a commutative ring `R` and `[X.Over (Spec (.of R))]` (`TauCeti/AlgebraicGeometry/Modules/Differentials/Basic.lean`, line 67), and `InvertibleSheaf.relativeDifferentials` asks also for `SmoothOfRelativeDimension 1` over `Spec R` (`…/Differentials/Rank.lean`, line 173). No node and no upstream declaration gives `Ω¹_{X/S}` for a base that is not affine.

What changed: the conversion between a theta characteristic and the form of `Statement.Setting`, which `bbbb797` added to `plans/GLCinLean/AlgebraicGeometry/Curves/Theta.toml`, is now stated for an affine base `Spec R`, with `Ω¹` the invertible sheaf `InvertibleSheaf.relativeDifferentials`. This is the base of `Statement.Setting` (a field) and of the example (a commutative ring), so every use of the conversion is covered.

What remains open: the first sentence of the node still plans the definition "over a base scheme S". `STATUS.md` ("Notes for the writers") records this: the writer states the definition over `Spec R` or hands the question to the planner. This change does not settle it, because it is a question on the generality of a definition that the statement will use, and it is not part of finding B2.

### Codex, objection 2: test lemma (b) reverses the last arrow

**Fixed (`48b50de`).** The objection is right. In `plans/GLCinLean/AlgebraicGeometry/Curves/ProjectiveLine.toml`, step (3) is already the inverse of `relativeDifferentialsIsoTwistingSheaf`, that is `𝒪(−2) ≅ Ω¹`. Test lemma (b) said "followed by the inverse of (3)", which is the wrong direction. It now says "followed by the isomorphism (3)". The Lean test of the note had the right direction, and `notes/checks/theta-projective-line.md` names the upstream isomorphism and its inverse, so its text was right.

### The checker, verdict 4, minor remark: a sentence describes what the node replaces

**Fixed (`48b50de`).** The sentence "The construction uses no classification of line bundles by their degree and no field" is removed from the node.

### The checker and Codex: test lemma (b) in Lean

**Not changed.** The checker did not close the equation in two attempts, for the reason that the proposal names; Codex reports that it checked it. The mathematics is not in doubt: both reports confirm it from the two definitions. The note now records both results. The writer of the node proves the lemma.

## B3: the tensor product of roots

### The checker, M1, and Codex, objection 1: a braided monoidal pullback is at the pin

**Fixed (`a93ec5a`).** The finding is right, and the proposal was wrong to say that a monoidal pullback is not at the pin. At the pin:

- `TauCeti.AlgebraicGeometry.QuasicoherentSheaf.pullbackBraided : (pullback f).Braided` (`TauCeti/AlgebraicGeometry/Modules/Pullback/Monoidal/Basic.lean`, line 169), with the equations `pullback_δ_hom` (line 252) and `pullback_η_hom` (line 270): on underlying module sheaves the inverse tensor comparison is `δ` of the pullback of module sheaves, and the inverse unit comparison is `Scheme.Modules.pullbackObjUnitIso`.
- `QuasicoherentSheaf.isMonoidal_pullbackId_hom` (`…/Monoidal/Identity.lean`, line 78) and `QuasicoherentSheaf.isMonoidal_pullbackComp_hom` (`…/Monoidal/Composition.lean`, line 184).
- `FiniteLocallyFreeSheaf.pullbackDualIso` (`TauCeti/AlgebraicGeometry/VectorBundle/Dual/Pullback.lean`, line 46), with `pullbackDualIso_hom_id` and `pullbackDualIso_hom_comp`.

The three instances are found by `inferInstance` (test point 4 of `notes/checks/root-tensor-route.md`). `InvertibleSheaf.pullback` has no monoidal instance, as the checker says.

What changed:

- `plans/Roadmap/SchemeAndStackFoundations/PicardGroupoid.toml`: the list "In Tau Ceti" names the three declarations with their modules, and `InvertibleSheaf.isQuasicoherent_obj`. "Still to do" has two parts. Part (1) is the braided monoidal instance on `InvertibleSheaf.pullback`, carried over from `QuasicoherentSheaf.pullbackBraided` ("a transport and no new proof of coherence"), with the equations of its two comparisons on underlying module sheaves and the monoidal `pullbackId` and `pullbackComp`. Part (2) is the class `PicardGroupoid` with its instance and the functor on the cores. The node says that this plan uses part (1) only, and which four things its one user takes. This answers Codex's sentence "The present rationale makes the whole Picard deliverable appear necessary".
- `docs/blueprint-providers.md`: a new row for `QuasicoherentSheaf.pullbackBraided`; the rows of `TauCeti.tensorPow`, `isMonoidal_isInvertible` and `Roadmap.SchemeAndStackFoundations.PicardGroupoid` refer to it; the row of `InvertibleSheaf.dual` names `FiniteLocallyFreeSheaf.pullbackDualIso`.
- `notes/checks/root-tensor-route.md`, section 1, item 5, is rewritten.
- `plans/GLCinLean/AlgebraicGeometry/LineBundle/RootTensorProductPullback.toml`: the isomorphism `f^*(M^{-1}) ≅ (f^*M)^{-1}` is `FiniteLocallyFreeSheaf.pullbackDualIso`, read for invertible sheaves through `InvertibleSheaf.toFiniteLocallyFree`, and not the isomorphism from `mapTensorIsoUnit` and the braiding. The node proves that it carries the pullback of `M ⊗ M^{-1} ≅ 𝟙` to the evaluation of `f^*M`, from `whiskerLeft_pullbackIhomComparison_app_comp_ev` (`TauCeti/AlgebraicGeometry/Modules/Pullback/InternalHom/Basic.lean`, line 59). By the uniqueness of U1 it is then an arrow of roots.

The decision is not changed, as the checker says: the instance on `InvertibleSheaf.pullback` is new code that belongs to Tau Ceti, so the new node depends on `LineBundle.picardGroupoid`.

One item that the checker did not check: whether the inclusion of invertible sheaves into quasi-coherent sheaves is a braided monoidal functor at the pin. There is no such functor at the pin; only the instance `InvertibleSheaf.isQuasicoherent_obj` (`TauCeti/AlgebraicGeometry/LineBundle/Basic.lean`, line 179) and the inclusion `InvertibleSheaf.toFiniteLocallyFree`. So the node says "carried over" and does not prescribe the functor through which Tau Ceti carries the instance.

### Codex, objection 2: the comparison with the pullback of roots, with the unit, is underspecified

**Fixed (`a93ec5a`).** The objection is right in both parts.

- The passage through the core is removed from `LineBundle.Root.pullbackTensorProductIso`. It took an arbitrary braided functor between cores, which nothing identified with the pullback of roots. The node now uses one structure: the instance on the functor `InvertibleSheaf.pullback` itself, which is what part (1) of `LineBundle.picardGroupoid` gives. With `QuasicoherentSheaf.pullbackBraided` at the pin, a structure on the cores only is no longer a case to plan for.
- The node states the recursion of `tensorPowFunctorCompIso` (`GLCinLean/CategoryTheory/Monoidal/TensorPow.lean`, `tensorPowFunctorCompIso_hom_app_zero` and `tensorPowFunctorCompIso_hom_app_succ`): for `n = 0` it is the inverse unit comparison alone, and for `n + 1` it is the inverse tensor comparison followed by the isomorphism for `n`. It says that the case `n = 0` must be checked on its own.
- The two comparisons of the pullback are fixed where they are made: `LineBundle.picardGroupoid` asks for the equations of `δ` and `η` on underlying module sheaves (`δ` is the tensor comparison of the pullback of module sheaves, so it is `pullbackTensorProductIso` carried by `tensorProductIsoTensor`; `η` is `Scheme.Modules.pullbackObjUnitIso`), and for the monoidal `pullbackId` and `pullbackComp`.
- The other side is fixed too: `plans/Roadmap/AlgebraicModuliForArithmeticGeometry/LineBundleRoot.toml` now says that the isomorphism `f^*(L^{⊗n}) ≅ (f^*L)^{⊗n}` is defined by the same recursion, with `Scheme.Modules.pullbackObjUnitIso` for `n = 0`. Before, the node named the ingredients and not the recursion.
- The compatibility with the identity map and with a composite needs two lemmas on `tensorPowFunctorCompIso` that the module does not have: its value on a composite of monoidal functors, and its naturality for a monoidal natural transformation. The node names them as lemmas that it adds to the module.

Not tested: the equality of the two recursions, because neither the isomorphism of `LineBundle.Root` nor the instance on `InvertibleSheaf.pullback` exists in Tau Ceti yet.

### The checker, U1: the dual of a root

**Fixed (`a93ec5a`), by the first of the two ways that the checker offers, with one lemma of the second.**

The finding is right. `tensorPowInverseIso e n f` needs a left inverse isomorphism `f`, Tau Ceti specifies only `tensorDualIso : L ⊗ L^{-1} ≅ 𝒪`, and with `f` taken from the braiding the evaluation is an arrow of roots only up to the symmetry of `M^{⊗n} ⊗ M^{⊗n}`. No declaration at the pin says that this symmetry is the identity for an invertible sheaf, and none says that `dualCongr` respects `tensorDualIso` (`TauCeti/AlgebraicGeometry/LineBundle/Dual.lean`).

The choice: the isomorphism `ψ : (M^{-1})^{⊗n} ≅ L^{-1}` of the dual root is defined by its property. `ψ` is the unique isomorphism such that `φ ⊗ ψ` followed by `L ⊗ L^{-1} ≅ 𝟙` is `tensorPowTensorIsoUnit` of `M ⊗ M^{-1} ≅ 𝟙`.

The reasons:

- The property is the clause that the node must prove ("the tensor product of a root and its dual is isomorphic to the trivial root"), and it is what `Stacks.rootGerbe` uses for `R_n(L)^{-1} ≃ R_n(L^{-1})`. Defined so, the clause holds with no proof, and the first sentence of the node now fixes the isomorphism instead of asking only for its existence.
- It is true in every braided monoidal category, with no sign. So the sentence "the operations on roots are the operations that a braided monoidal functor gives on its fibres" stays true for the dual. With the formula it is false, by the checker's example of the odd line.
- It needs less that is missing. The formula needs the fact that the symmetry of `L ⊗ L` is the identity for an invertible sheaf, which is new mathematics on sheaves (a local computation) with no other use in the plan. The property needs only that tensoring with `L` is fully faithful, and Tau Ceti has it: `CategoryTheory.MonoidalCategory.tensorRightEquivalenceOfIso` (`TauCeti/CategoryTheory/Monoidal/InvertibleObject.lean`, line 59), which asks for the two isomorphisms `L ⊗ M ≅ 𝟙` and `M ⊗ L ≅ 𝟙` and for no compatibility between them. The second isomorphism comes from the braiding, and it does not enter the equation that defines `ψ`.
- It is tested: test points 6 and 8 of `notes/checks/root-tensor-route.md` prove, at the pin, that left tensoring with an object with a tensor inverse is fully faithful in every braided monoidal category, and that the property of `ψ` has exactly one solution for invertible sheaves.

What the second way still gives: the dual must act on arrows of roots, and the node uses `InvertibleSheaf.dualCongr` for that, so that no second action of the dual is written. That `dualCongr ρ` is an arrow of the dual roots follows from the uniqueness of `ψ` and from one lemma: `dualCongr` respects `tensorDualIso`. Tau Ceti does not have it; the node names it and proves it. The lemma on the symmetry is not needed.

The same care in the new node: `f^*(M^{-1}) ≅ (f^*M)^{-1}` is `FiniteLocallyFreeSheaf.pullbackDualIso` with a stated property, and no formula through the braiding (M1 above).

A consequence outside the plan: `tensorPowInverseIso` and `MonoidalCategory.isoOfTensorIsoUnit` of `GLCinLean/CategoryTheory/Monoidal/TensorPow.lean` were written for the formula. With this choice no node uses them. `Functor.Monoidal.mapTensorIsoUnit` and `tensorPowTensorIsoUnit` stay in use. The branch changes no Lean file; the two declarations are a question for the session.

### The checker, S1: sentences out of date against `main`

**Fixed (`ab10a93`, `a93ec5a`).** The branch is merged with `main`, which has `tensorPowFunctor_ε`, `tensorPowFunctor_η`, `tensorPowFunctor_μ` and `tensorPowFunctor_δ`.

- `RootTensorProduct.toml`: the identification of the unit root with the trivial root is `tensorPowFunctor_η` with `tensorPowTrivialIso_def`. The isomorphism `(M ⊗ M′)^{⊗n} ≅ M^{⊗n} ⊗ M′^{⊗n}` is `TauCeti.tensorPowTensorIso`, by `tensorPowFunctor_δ`, because `InvertibleSheaf X` is symmetric. `TauCeti.tensorPowTensorIso` (`TauCeti.CategoryTheory.Monoidal.Braided.TensorPow`) is among the upstream declarations.
- `docs/blueprint-providers.md`, the row of `TauCeti.tensorPow`: the sentence "is not stated yet" is replaced by the four lemmas, with the limit to symmetric categories for the tensor comparison.
- This closes the fourth unsure point of the proposal (the two braidings), as the checker says.

Codex's remark on the same point (the tracker counts the module of the power functor as proved, so its output cannot show that a lemma is there) holds also for the two lemmas on `tensorPowFunctorCompIso` that the new node needs. They are named in the node, and the node's writer adds them with the node.

### The checker, verdict 4, minor remarks

- "it does not pass to the Picard groupoid …, which it does not use" describes what the node replaces. **Fixed (`a93ec5a`)**: the sentence now says what the node uses ("It uses no groupoid of invertible sheaves: the arrows of roots are isomorphisms of `InvertibleSheaf X`").
- "Found at the pin on 2026-11-20" in `docs/blueprint-providers.md`. **Not changed**: it is older text of a row, as the checker says, and not of this change.

## What stays open after round 1

- `Curves.ThetaCharacteristic` over a base that is not affine (Codex, B2, objection 1): an open item of `STATUS.md`, not of this change.
- The scope of the node `LineBundle.picardGroupoid`. This plan uses its part (1) only. The node keeps its name and its part (2). To narrow the node to part (1) and to rename it would change the workers' table of `STATUS.md`, so it is left to the session.
- Two things that could not be elaborated, because one side is not in Tau Ceti yet: the equality of the isomorphism of `LineBundle.Root` with `tensorPowFunctorCompIso` of the pullback; and that `FiniteLocallyFreeSheaf.pullbackDualIso`, read through `InvertibleSheaf.toFiniteLocallyFree`, is an isomorphism between `InvertibleSheaf.pullback` of `InvertibleSheaf.dual` and `InvertibleSheaf.dual` of `InvertibleSheaf.pullback` (both duals are the internal Hom into the unit; read from the definitions).
- The order of the upstream work. The isomorphism `f^*(L^{⊗n}) ≅ (f^*L)^{⊗n}` of `LineBundle.Root` is simplest once part (1) of `LineBundle.picardGroupoid` is there, because it is then the comparison of a monoidal functor with tensor powers. Tau Ceti has no such general comparison; this repository has one (`tensorPowFunctorCompIso`). If an author worker writes the general comparison in Tau Ceti, `tensorPowFunctorCompIso` here becomes a copy and must give way to it.
- `tensorPowInverseIso` and `isoOfTensorIsoUnit` have no user in the plan (U1 above).
