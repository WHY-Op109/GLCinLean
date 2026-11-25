# The route for the tensor product of roots of invertible sheaves

A proposal by `prompts/change.md` for finding B3 of the audit of 2026-11-25, in its state after round 2 of the checks (`line-bundle-routes-checker-1.md`, `line-bundle-routes-codex-1.md`, `line-bundle-routes-answers-1.md`, `line-bundle-routes-codex-2.md`, `line-bundle-routes-answers-2.md`). It is a change of route for `LineBundle.Root.tensorProduct`: the objects stay the same, and the source of their coherence changes. The branch is `proposal/line-bundle-routes`.

## 1. The problem

**The node.** `GLCinLean.LineBundle.Root.tensorProduct` (`plans/GLCinLean/AlgebraicGeometry/LineBundle/RootTensorProduct.toml`, source [GLys] §§1.4.2 and 1.4.4) holds the tensor product, the dual and the twist of n-th roots of invertible sheaves on a scheme, with their coherence and their compatibility with the pullback of roots. On `main` its construction is: "the n-th tensor power is a symmetric monoidal functor from the Picard groupoid of X to itself (LineBundle.picardGroupoid), and the groupoid of roots of L is its fibre over L". Its `deps` are `LineBundle.Root`, `LineBundle.picardGroupoid` and `CategoryTheory.tensorPowFunctor`. So every part of the node waits for the roadmap node `LineBundle.picardGroupoid`, of which it is the only user.

**The papers.** [GLys] §1.4.2 (`references/papers/1608.00284v7/src/text.tex`, lines 1610–1627) defines the gerbe `ℒ^{1/n}` on a prestack by its values on affine test schemes `S`: "the groupoid of pairs `(ℒ′, (ℒ′)^{⊗n} ≃ ℒ|_S)`". §1.4.4 (lines 1636–1646) uses tensor products of such gerbes. The paper gives no construction of the tensor product of roots and names no Picard groupoid for it, so the route is a choice of the plan and no claim of the paper is touched.

**The evidence at the pin** (Tau Ceti `553f7926`, in `.lake/packages/TauCeti`; this repository at `de24230`).

1. `InvertibleSheaf X` is a symmetric monoidal category: the instance `TauCeti.AlgebraicGeometry.SheafOfModules.isMonoidal_isInvertible` (`TauCeti/AlgebraicGeometry/LineBundle/Monoidal.lean`, line 70) with Mathlib's structure on a full subcategory. Powers of an invertible sheaf are `TauCeti.tensorPow` in this category (`TauCeti/AlgebraicGeometry/LineBundle/Power.lean`), and the node `LineBundle.Root` states its roots with them.
2. `GLCinLean/CategoryTheory/Monoidal/TensorPow.lean` gives, for every monoidal category `C`: the functor `tensorPowFunctor C n`, monoidal for a braided `C` and braided for a symmetric `C`; the lemmas `tensorPowFunctor_η` (its inverse unit comparison is `TauCeti.tensorPowUnitIso`) and `tensorPowFunctor_δ` (for a symmetric `C`, its inverse tensor comparison is `TauCeti.tensorPowTensorIso`); `tensorPowFunctorCompIso G n`, the isomorphism `G(X^{⊗n}) ≅ G(X)^{⊗n}` for a monoidal functor `G`, which is a monoidal natural isomorphism for a braided `G`; and `tensorPowTensorIsoUnit`, which carries an isomorphism `X ⊗ M ≅ 𝟙` through the functor. None of these needs a groupoid.
3. The roadmap SchemeAndStackFoundations §3.4 (TauCetiRoadmap `b24abdf7`, `README.md`, lines 6025–6031) defines the Picard groupoid as `picardGroupoid X := Core (InvertibleSheaf X)`, and `PicardGroupoid C` as: "every morphism is an isomorphism and every object has a tensor inverse up to isomorphism". Two consequences. First, a tensor power in the core is an object of the core, and it is equal to the tensor power in `InvertibleSheaf X` only by an induction on n; so the route on `main` must compare the two tensor powers through the inclusion of the core, although the node says that it "compares no two definitions of the tensor power". Second, the class gives the existence of an inverse, not an inverse; the dual of a root is data, so it needs a specified inverse in any case.
4. The specified inverse is at the pin: `InvertibleSheaf.dual` (`TauCeti/AlgebraicGeometry/LineBundle/Dual.lean`, line 56), `InvertibleSheaf.tensorDualIso : tensorProduct L (dual L) ≅ trivial X` (line 157) and `InvertibleSheaf.dualCongr` (line 95), with `tensorProductIsoTensor` and `trivialIsoTensorUnit` (`…/LineBundle/Monoidal.lean`, lines 113 and 131) to carry them to the monoidal category. Tensoring with an object that has a tensor inverse is an equivalence: `CategoryTheory.MonoidalCategory.tensorRightEquivalenceOfIso` (`TauCeti/CategoryTheory/Monoidal/InvertibleObject.lean`, line 59). Not at the pin: that `dualCongr` respects `tensorDualIso`, and that the symmetry of `L ⊗ L` is the identity for an invertible sheaf.
5. The pullback. At the pin the pullback of quasi-coherent sheaves is braided monoidal for every map of schemes: `QuasicoherentSheaf.pullbackBraided` (`TauCeti/AlgebraicGeometry/Modules/Pullback/Monoidal/Basic.lean`, line 169), with the equations of its comparisons on underlying module sheaves (`pullback_δ_hom`, line 252; `pullback_η_hom`, line 270) and with monoidal isomorphisms for the identity map and for a composite (`isMonoidal_pullbackId_hom`, `…/Monoidal/Identity.lean`, line 78; `isMonoidal_pullbackComp_hom`, `…/Monoidal/Composition.lean`, line 184). Every invertible sheaf is quasi-coherent (`InvertibleSheaf.isQuasicoherent_obj`). The functor `InvertibleSheaf.pullback` (`…/LineBundle/Pullback.lean`, line 182) is a lift of the same pullback of module sheaves, and it has no monoidal instance: instance search for `(InvertibleSheaf.pullback f).Monoidal` fails. `InvertibleSheaf.pullbackTensorProductIso` (`…/LineBundle/Functoriality.lean`, line 151) is one isomorphism for `InvertibleSheaf.tensorProduct`, natural for isomorphisms. For duals, `FiniteLocallyFreeSheaf.pullbackDualIso` (`TauCeti/AlgebraicGeometry/VectorBundle/Dual/Pullback.lean`, line 46) is `f^*(E^∨) ≅ (f^*E)^∨`, with `whiskerLeft_pullbackIhomComparison_app_comp_ev` (`…/Modules/Pullback/InternalHom/Basic.lean`, line 59) for its evaluation. The roadmap states `picardGroupoid.pullback` as "a functor of Picard groupoids". The open Tau Ceti pull request #45392 of another contributor makes the pullback of all module sheaves strong symmetric monoidal.

**The nodes that the change touches, and every user of each** (`lake exe tracker show`, on `main`).

| Node | Its users | Touched how |
|---|---|---|
| `LineBundle.Root.tensorProduct` | `Stacks.rootGerbe` | `desc` and `deps`; the compatibility with pullback leaves the node |
| `LineBundle.Root.pullbackTensorProductIso` (new) | `Stacks.rootGerbe` | the compatibility with pullback |
| `LineBundle.pullbackBraided` (new; roadmap SchemeAndStackFoundations) | `LineBundle.Root.pullbackTensorProductIso`, `LineBundle.picardGroupoid` | the braided monoidal structure on `InvertibleSheaf.pullback`, a prerequisite of the target `picardGroupoid.pullback` of §3.4 |
| `LineBundle.picardGroupoid` (roadmap SchemeAndStackFoundations) | `LineBundle.Root.tensorProduct` only | its `desc` and its `deps`: it keeps the class and the functor on the cores, and depends on `LineBundle.pullbackBraided`; no node depends on it any more |
| `LineBundle.Root` (roadmap AlgebraicModuliForArithmeticGeometry) | five nodes | one sentence of its `desc`: the recursion that defines `f^*(L^{⊗n}) ≅ (f^*L)^{⊗n}` |
| `Stacks.rootGerbe` | `Satake.criticalDeterminantGerbe`, `Whittaker.twistTrivialization`, `Satake.criticalTwistBunDeterminantEquiv`, `Automorphic.HalfTwistedDModules` | one dependency and one clause of its `desc` |
| `CategoryTheory.tensorPowFunctor` (proved) | `LineBundle.Root.tensorProduct` only | not touched; the new node uses it too |

## 2. The checks

**What each part of the node needs.**

| Part | Needs | From a roadmap node on the pullback? |
|---|---|---|
| The root `M ⊗ M′` of `L ⊗ L′` | the tensor comparison of the tensor power functor of `InvertibleSheaf X` | no |
| Functoriality in the two roots | the naturality of that comparison | no; the arrows of roots are isomorphisms in `InvertibleSheaf X` already |
| Associativity, unit, commutativity | the three axioms of a braided monoidal functor; `tensorPowFunctor_η` for the trivial root | no |
| The dual of a root, and a root tensor its dual | `InvertibleSheaf.dual`, `tensorDualIso`, `tensorPowTensorIsoUnit`, the equivalence `tensorRightEquivalenceOfIso`; one new lemma on `dualCongr` | no; the class would give existence only |
| The twist, and two roots of one `L` | the parts above | no |
| The compatibility with the pullback of roots | a braided monoidal instance on `InvertibleSheaf.pullback` with the equations of its comparisons, and `tensorPowFunctorCompIso` | yes: `LineBundle.pullbackBraided`, a transport of the instance for quasi-coherent sheaves; not the Picard groupoid |

**The dual of a root.** The isomorphism `ψ : (M^{-1})^{⊗n} ≅ L^{-1}` of the dual root is defined by a property: `φ ⊗ ψ` followed by `L ⊗ L^{-1} ≅ 𝟙` is `tensorPowTensorIsoUnit` of `M ⊗ M^{-1} ≅ 𝟙`. The property is the statement that `M ⊗ M^{-1} ≅ 𝟙` is an arrow of roots from the tensor product of the root and its dual to the trivial root. A unique `ψ` has it, because tensoring on the left with `L` is fully faithful (test point 6). A formula for `ψ` through the braiding and `tensorPowInverseIso` (round 0 of this note) has the property only up to the symmetry of `M^{⊗n} ⊗ M^{⊗n}`: in super vector spaces, for the odd line and `n = 1`, the formula gives the sign `−1`. For invertible sheaves this symmetry is the identity, but no declaration at the pin says so. The definition by the property needs neither that fact nor a sign, in every braided monoidal category.

**The unit.** The trivial root of `LineBundle.Root` has the isomorphism `InvertibleSheaf.tensorPowTrivialIso`, which is `TauCeti.tensorPowUnitIso` carried along `trivialIsoTensorUnit` (`tensorPowTrivialIso_def`, `…/LineBundle/Power.lean`, line 72). The unit of the tensor product of roots is `(𝟙, η_n)`, with `η_n` the inverse unit comparison of `tensorPowFunctor`. The two agree by `tensorPowFunctor_η`.

**The pullback, and the case `n = 0`.** `tensorPowFunctorCompIso G n` is defined by recursion: for `n = 0` it is the inverse unit comparison `η` of `G` (`tensorPowFunctorCompIso_hom_app_zero`), and for `n + 1` it is the inverse tensor comparison `δ` of `G` at `(X, X^{⊗n})` followed by `G(X) ◁` the isomorphism for `n` (`tensorPowFunctorCompIso_hom_app_succ`). So the new node must know both comparisons of the pullback, and the unit comparison alone decides the case `n = 0`. The node `LineBundle.pullbackBraided` therefore asks for the instance on `InvertibleSheaf.pullback` together with the equations of `δ` and `η` on underlying module sheaves (`δ` is the tensor comparison of the pullback of module sheaves; `η` is `Scheme.Modules.pullbackObjUnitIso`), as Tau Ceti states them for quasi-coherent sheaves. The node `LineBundle.Root` defines its isomorphism `f^*(L^{⊗n}) ≅ (f^*L)^{⊗n}` by the same recursion from the same two comparisons. The new node proves that the two are equal, and takes the compatibility with the identity map and with a composite from the monoidal `pullbackId` and `pullbackComp`.

**A test in Lean.** The file below elaborates at the pin with no error (`lake env lean`, after `lake build +TauCeti.AlgebraicGeometry.LineBundle.Power +TauCeti.AlgebraicGeometry.LineBundle.Dual +TauCeti.AlgebraicGeometry.Modules.Pullback.Monoidal.Composition +TauCeti.AlgebraicGeometry.Modules.Pullback.Monoidal.Identity +TauCeti.CategoryTheory.Monoidal.InvertibleObject`; the cache supplies these modules).

```lean
import GLCinLean.CategoryTheory.Monoidal.TensorPow
import TauCeti.AlgebraicGeometry.LineBundle.Power
import TauCeti.AlgebraicGeometry.LineBundle.Dual
import TauCeti.AlgebraicGeometry.Modules.Pullback.Monoidal.Composition
import TauCeti.AlgebraicGeometry.Modules.Pullback.Monoidal.Identity
import TauCeti.CategoryTheory.Monoidal.InvertibleObject

open CategoryTheory MonoidalCategory AlgebraicGeometry TauCeti.AlgebraicGeometry
open GLCinLean.CategoryTheory

universe u

noncomputable section

-- 1. The n-th tensor power functor of `InvertibleSheaf X` is braided monoidal at the pin.
example (X : Scheme.{u}) (n : ℕ) : (tensorPowFunctor (InvertibleSheaf X) n).Braided :=
  inferInstance

-- 2. Its objects are the tensor powers that roots use.
example (X : Scheme.{u}) (n : ℕ) (M : InvertibleSheaf X) :
    (tensorPowFunctor (InvertibleSheaf X) n).obj M = TauCeti.tensorPow M n := rfl

-- 3. The isomorphism of the tensor product of two roots.
example (X : Scheme.{u}) (n : ℕ) {L L' M M' : InvertibleSheaf X}
    (φ : TauCeti.tensorPow M n ≅ L) (φ' : TauCeti.tensorPow M' n ≅ L') :
    TauCeti.tensorPow (M ⊗ M') n ≅ L ⊗ L' :=
  (Functor.Monoidal.μIso (tensorPowFunctor (InvertibleSheaf X) n) M M').symm ≪≫ (φ ⊗ᵢ φ')

-- 4. The braided monoidal pullback of quasi-coherent sheaves is at the pin, with its monoidal
-- isomorphisms for the identity and for a composite.
example {X Y : Scheme.{u}} (f : X ⟶ Y) : (QuasicoherentSheaf.pullback f).Braided := inferInstance

example (X : Scheme.{u}) : NatTrans.IsMonoidal (QuasicoherentSheaf.pullbackId X).hom :=
  inferInstance

example {X Y Z : Scheme.{u}} (f : X ⟶ Y) (g : Y ⟶ Z) :
    NatTrans.IsMonoidal (QuasicoherentSheaf.pullbackComp f g).hom :=
  inferInstance

-- 5. With a braided monoidal structure on the pullback of invertible sheaves, the comparison
-- `f^*(M^{⊗n}) ≅ (f^*M)^{⊗n}` is a monoidal natural isomorphism.
example {X Y : Scheme.{u}} (n : ℕ) (f : X ⟶ Y) [(InvertibleSheaf.pullback f).Braided] :
    NatTrans.IsMonoidal (tensorPowFunctorCompIso (InvertibleSheaf.pullback f) n).hom :=
  inferInstance

-- 6. Tensoring on the left with an object that has a tensor inverse is fully faithful, in every
-- braided monoidal category. No compatibility of the two isomorphisms is used.
theorem existsUnique_whiskerLeft_eq {C : Type*} [Category C] [MonoidalCategory C]
    [BraidedCategory C] {X X' A B : C} (e : X ⊗ X' ≅ 𝟙_ C) (g : X ⊗ A ⟶ X ⊗ B) :
    ∃! ψ : A ⟶ B, X ◁ ψ = g := by
  let E := tensorRightEquivalenceOfIso e (β_ X' X ≪≫ e)
  let hff := E.fullyFaithfulFunctor
  have hw (ψ : A ⟶ B) : ψ ▷ X = (β_ X A).inv ≫ X ◁ ψ ≫ (β_ X B).hom := by
    rw [BraidedCategory.braiding_naturality_right, Iso.inv_hom_id_assoc]
  have key (ψ : A ⟶ B) : X ◁ ψ = g ↔ ψ ▷ X = (β_ X A).inv ≫ g ≫ (β_ X B).hom := by
    rw [hw]
    constructor
    · rintro rfl; rfl
    · intro h; exact (cancel_mono (β_ X B).hom).1 ((cancel_epi (β_ X A).inv).1 h)
  refine ⟨hff.preimage ((β_ X A).inv ≫ g ≫ (β_ X B).hom), (key _).2 (hff.map_preimage _), ?_⟩
  intro ψ hψ
  exact hff.map_injective (((key ψ).1 hψ).trans (hff.map_preimage _).symm)

variable (X : Scheme.{u}) (n : ℕ)

-- 7. A specified tensor inverse of an invertible sheaf, from the declarations at the pin.
def tensorDual (M : InvertibleSheaf X) : M ⊗ M.dual ≅ 𝟙_ (InvertibleSheaf X) :=
  (InvertibleSheaf.tensorProductIsoTensor M M.dual).symm ≪≫ InvertibleSheaf.tensorDualIso M ≪≫
    InvertibleSheaf.trivialIsoTensorUnit X

-- 8. The property that defines the isomorphism of the dual root has a unique solution.
example {L M : InvertibleSheaf X} (φ : TauCeti.tensorPow M n ≅ L) :
    ∃! ψ : TauCeti.tensorPow M.dual n ⟶ L.dual,
      (φ.hom ⊗ₘ ψ) ≫ (tensorDual X L).hom = (tensorPowTensorIsoUnit (tensorDual X M) n).hom := by
  have h := existsUnique_whiskerLeft_eq (tensorDual X L)
    (φ.inv ▷ _ ≫ (tensorPowTensorIsoUnit (tensorDual X M) n).hom ≫ (tensorDual X L).inv)
  obtain ⟨ψ, hψ, huniq⟩ := h
  refine ⟨ψ, ?_, fun ψ' hψ' ↦ huniq ψ' ?_⟩
  · change (φ.hom ⊗ₘ ψ) ≫ _ = _
    rw [tensorHom_def, Category.assoc, hψ]
    simp only [Category.assoc, Iso.inv_hom_id, Category.comp_id, hom_inv_whiskerRight_assoc]
  · change (φ.hom ⊗ₘ ψ') ≫ _ = _ at hψ'
    change L ◁ ψ' = _
    rw [← hψ', tensorHom_def]
    simp only [Category.assoc, Iso.hom_inv_id, Category.comp_id, inv_hom_whiskerRight_assoc]

end
```

Test point 8 gives `ψ` as a morphism. It is an isomorphism because `L ◁ ψ` is one and a fully faithful functor reflects isomorphisms.

## 3. The options

- **A. Keep the route through the Picard groupoid.** Everything waits for `LineBundle.picardGroupoid`. The node must compare the tensor powers of the core with those of `InvertibleSheaf X`, and it still needs `InvertibleSheaf.dual` for the dual of a root.
- **B. Apply `tensorPowFunctor` to `InvertibleSheaf X`, in one node.** The text of the node changes and its `deps` do not, because the compatibility with pullback still needs the monoidal pullback, which is a roadmap node. The whole node still waits for that roadmap node.
- **C. Apply `tensorPowFunctor` to `InvertibleSheaf X`, and split the node.** `LineBundle.Root.tensorProduct` keeps the operations on one scheme and depends on `LineBundle.Root` and `CategoryTheory.tensorPowFunctor`. A new node `LineBundle.Root.pullbackTensorProductIso` holds the compatibility with pullback and depends also on the braided monoidal structure of `InvertibleSheaf.pullback`, which is a roadmap node of its own, `LineBundle.pullbackBraided`.
- **D. Use no roadmap node for the pullback: write the braided monoidal instance on `InvertibleSheaf.pullback` here.** It is a transport of an instance of Tau Ceti to a functor of Tau Ceti, and SchemeAndStackFoundations §3.4 states the pullback of Picard groupoids as a target. A copy here would compete with Tau Ceti (`AGENTS.md`, "Sources of code").
- **E. Write, for every braided monoidal functor of symmetric monoidal categories, the category of its fibres with its tensor product, and get roots as a case.** `LineBundle.Root` is a roadmap node and is written in Tau Ceti for invertible sheaves; a general category of fibres here would be a second groupoid of roots beside it, or an abstraction with one use (`AGENTS.md`, "Lean code"). The node keeps the mathematics of E as its construction: the writer states the lemmas for a braided monoidal functor where that is shorter.

## 4. The choice: C

**Reasons.**

- The route is shorter and uses what exists. The tensor structure comes from an instance at the pin and from a module that is written and checked; test points 1 to 3 and 6 to 8 show that the one-scheme part elaborates today, once `LineBundle.Root` supplies the groupoid.
- It removes a comparison instead of adding one: roots and the tensor power functor use the same `TauCeti.tensorPow` in the same category (test point 2 is a `rfl`).
- Inverses come from the declarations that specify them. The class `PicardGroupoid` could not give the dual of a root as data.
- The split states the dependencies as they are (`AGENTS.md`, "Small and big changes": a split of a module and a new node are small changes). `lake exe tracker ready` will list the module of `LineBundle.Root.tensorProduct` when `LineBundle.Root` is at the pin, without a wait for the monoidal pullback. Option B would describe the same mathematics and keep the wait.
- The monoidal pullback is a roadmap node of its own, `LineBundle.pullbackBraided`: the braided monoidal instance on `InvertibleSheaf.pullback`, a transport of what Tau Ceti has for quasi-coherent sheaves. A roadmap node leaves the plan only when its whole declaration is at the pin (`AGENTS.md`, "Plan"), and a node is ready when every dependency is proved (`tools/tracker/README.md`, "States"). So one node for the instance and for the Picard groupoid would make the new node wait for the class `PicardGroupoid`, which it does not use. This is finding B3 as the audit states it, with two corrections: the operations on roots need the monoidal pullback only, not inverses; and they need it on `InvertibleSheaf.pullback`, not on the Picard groupoid.

**The users, checked.**

- `Stacks.rootGerbe` uses, on one site, the tensor product and the dual of roots for `R_n(L) ⊗ R_n(M) ≃ R_n(L ⊗ M)` and `R_n(L)^{-1} ≃ R_n(L^{-1})`, with their coherence, and it needs these to be maps of gerbes on the big étale site, that is, compatible with the pullback of roots. The first is `LineBundle.Root.tensorProduct` as before. The second is now `LineBundle.Root.pullbackTensorProductIso`, which is a new dependency of `Stacks.rootGerbe`. Nothing that the node used is dropped: the two nodes together state every clause of the old `desc`, and the new node spells out what the old words "compatible with pullback of roots" must mean for a map of gerbes: the clauses on the trivial root, the identity map and a composite.
- `LineBundle.pullbackBraided` has two users: `LineBundle.Root.pullbackTensorProductIso` and `LineBundle.picardGroupoid`.
- `LineBundle.picardGroupoid` has no user in `plans/` or `plans-proof/` any more. It is left in the plan: to remove a planned definition is a decision of its own.
- `CategoryTheory.tensorPowFunctor` is used as it is, with `tensorPowFunctor_η` and `tensorPowFunctor_δ`. The new node adds two lemmas to its module: `tensorPowFunctorCompIso` of a composite of monoidal functors, and its naturality for a monoidal natural transformation.

**The hypotheses in the generality of the node.** The node has no hypothesis on `n` or on `X`. `tensorPowFunctor C n` is braided monoidal for every `n : ℕ`, also `n = 0`, where it is the constant functor at the unit; a root of `L` for `n = 0` is then an invertible sheaf with an isomorphism `𝟙 ≅ L`, and the tensor product is defined by the same formulas. `InvertibleSheaf X` is symmetric monoidal for every scheme `X`, also the empty one. `InvertibleSheaf.dual` and `tensorDualIso` have no hypothesis on `X`.

**What the branch changes.**

- `plans/GLCinLean/AlgebraicGeometry/LineBundle/RootTensorProduct.toml`: the `desc` and the `deps` of `LineBundle.Root.tensorProduct` (no dependency on `LineBundle.picardGroupoid`).
- `plans/GLCinLean/AlgebraicGeometry/LineBundle/RootTensorProductPullback.toml`: the new node `LineBundle.Root.pullbackTensorProductIso`, with the source of the old node.
- `plans/GLCinLean/AlgebraicGeometry/Stacks/Gerbe.toml`: `Stacks.rootGerbe` depends on the new node and names it.
- `plans/Roadmap/SchemeAndStackFoundations/LineBundlePullbackBraided.toml`: the new roadmap node `LineBundle.pullbackBraided`.
- `plans/Roadmap/SchemeAndStackFoundations/PicardGroupoid.toml`: the node keeps the class and the functor on the cores, and depends on `LineBundle.pullbackBraided`.
- `plans/Roadmap/AlgebraicModuliForArithmeticGeometry/LineBundleRoot.toml`: the recursion that defines `f^*(L^{⊗n}) ≅ (f^*L)^{⊗n}`.
- `docs/blueprint-providers.md`: the rows of `TauCeti.tensorPow`, `isMonoidal_isInvertible` (it also said that the monoidal structure on the core is not in Tau Ceti; it is, in `TauCeti.CategoryTheory.Monoidal.Core`) and `pullbackTensorProductIso`; new rows for `InvertibleSheaf.dual` and `QuasicoherentSheaf.pullbackBraided`; in the table of the ready roadmap modules, the row of `Roadmap.SchemeAndStackFoundations.LineBundlePullbackBraided` in place of the row of `Roadmap.SchemeAndStackFoundations.PicardGroupoid`, which is no longer ready; the count of SchemeAndStackFoundations (9 nodes).

**`STATUS.md` when the change is applied.** The plan has 311 nodes in 198 module plans: 222 written here and 89 owned by roadmap areas. "Notes for the writers": `LineBundle.Root.tensorProduct` is written once `LineBundle.Root` is at the pin; `LineBundle.Root.pullbackTensorProductIso` once `LineBundle.pullbackBraided` is at the pin too. The row of `author-stacks`: `LineBundle.pullbackBraided` first, as a transport of `QuasicoherentSheaf.pullbackBraided`; `LineBundle.picardGroupoid` after it has no user in the plan. The row of `author-moduli`: the recursion of `f^*(L^n) ≅ (f^*L)^n`. "Findings of the audit of 2026-11-25 that are not applied" loses B3, and "Decisions taken" gains the change.

## 5. Where the planner is unsure

- **B or C.** The split is the planner's reading of "use `LineBundle.picardGroupoid` only for the monoidal pullback". A checker who wants one node can merge the two texts; the route is the same.
- **The statement of `LineBundle.Root` in Tau Ceti.** It is not at the pin. The node assumes what the roadmap node says: `M^{⊗n}` is `TauCeti.tensorPow M n` in `InvertibleSheaf X`, and `f^*(L^{⊗n}) ≅ (f^*L)^{⊗n}` is the recursion from the unit and the tensor comparison of the pullback. If the code there differs, the first step of the new node is checked again.
- **Which tensor product the root `M ⊗ M′` is a root of.** The node takes `L ⊗ L′` in the monoidal category `InvertibleSheaf X`, because the functor is monoidal for it. `InvertibleSheaf.tensorProduct L L′` is isomorphic to it by `tensorProductIsoTensor`. `Stacks.rootGerbe` can use either; the writer of that node chooses.
- **The node `LineBundle.picardGroupoid` has no user.** After the split no node of `plans/` or `plans-proof/` depends on it. It is the target of the roadmap, and the plan does not need it for the statement. Whether it leaves the plan is a decision of its own.
- **Whether Tau Ceti takes `LineBundle.pullbackBraided` as a prerequisite.** It is not a named target of §3.4. If Tau Ceti's review refuses it as outside the roadmap, the node comes back through `prompts/change.md`.
- **`FiniteLocallyFreeSheaf.pullbackDualIso` for invertible sheaves.** The new node reads it through `InvertibleSheaf.toFiniteLocallyFree`. Codex reports in round 2 that it checked in Lean that this inclusion identifies both the dual and the pullback objects; the planner read it from the definitions only.
- **`tensorPowInverseIso` and `isoOfTensorIsoUnit`.** With the dual of a root defined by its property, no node of the plan uses these two declarations of `GLCinLean/CategoryTheory/Monoidal/TensorPow.lean`.
- **The cost of the first step of the new node.** It must prove that the isomorphism `f^*(L^{⊗n}) ≅ (f^*L)^{⊗n}` of `LineBundle.Root` is `tensorPowFunctorCompIso` of the pullback. Both are the same recursion, but neither side exists in Tau Ceti yet, so the proof is not tested.
