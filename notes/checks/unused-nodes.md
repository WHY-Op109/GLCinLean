# Changes of the plan: a node without a user, and two nodes that the pin supplies

Branch `proposal/unused-nodes`, on `536cce3`. Tau Ceti is read at the pin `553f7926`, in `.lake/packages/TauCeti`; the paths below that start with `TauCeti/` are relative to that folder. Each section gives the evidence first and then the change. At the head of the branch, `lake exe tracker lint` has no errors, `python3 tools/check-module-cycles.py` finds no cycle, and `python3 tools/check-upstream-names.py` confirms every pair. The reports of the checkers and the answers to them are `unused-nodes-checker-<round>.md`, `unused-nodes-codex-<round>.md` and `unused-nodes-answers-<round>.md` in this folder.

## 1. The roadmap node `LineBundle.picardGroupoid` has no user and stays in the plan (no change on the branch)

### Evidence

- **No `deps` names the node.** `grep -rn "^deps.*picardGroupoid" plans plans-proof` finds nothing. `lake exe tracker show GLCinLean.LineBundle.picardGroupoid` prints one dependency (`GLCinLean.LineBundle.pullbackBraided`) and no line "needed by".
- **Every text that names it.** `grep -rli picard . --exclude-dir=.lake --exclude-dir=.git`, without `tools/tracker`, finds five files: `STATUS.md`, `docs/blueprint-providers.md`, and three files of `plans/`. No file of `plans-proof/`, `GLCinLean/`, `GLCinLean.lean` or `prompts/` contains the word. The three files of `plans/` are:
  - `plans/Roadmap/SchemeAndStackFoundations/PicardGroupoid.toml`: the node. Its `desc` says "No node of `plans/` or of `plans-proof/` depends on this node."
  - `plans/Roadmap/SchemeAndStackFoundations/LineBundlePullbackBraided.toml` (`LineBundle.pullbackBraided`): it names the roadmap target `picardGroupoid.pullback` as the target of which the node is a prerequisite, and it lists `LineBundle.picardGroupoid` as a user of its instance. This is a use by the node, not a use of it.
  - `plans/GLCinLean/AlgebraicGeometry/LineBundle/RootTensorProductPullback.toml` (`LineBundle.Root.pullbackTensorProductIso`): "The node uses no Picard groupoid (LineBundle.picardGroupoid): not its class, not the core, and not the existence of tensor inverses."
- **A use that the `deps` do not show.** Three texts were read for a use of the object without its name.
  - `Stacks.rootGerbe` (`plans/GLCinLean/AlgebraicGeometry/Stacks/Gerbe.toml`) says that "R_n is a symmetric monoidal functor from the groupoid of line bundles on Y to the μ_n-gerbes on Y, natural in Y". This is the nearest text to a use. It is not a use of the node, for three reasons. (a) Y is a prestack, and the node is the groupoid `Core (InvertibleSheaf X)` of a scheme X. (b) The node spells the functor out as band-preserving equivalences (`R_n(f^*L) ≃ f^*R_n(L)`, `R_n(L) ⊗ R_n(M) ≃ R_n(L ⊗ M)`, `R_n(L)^{-1} ≃ R_n(L^{-1})`, with their coherence), and takes them over each test scheme from `LineBundle.Root.tensorProduct` and `LineBundle.Root.pullbackTensorProductIso`, which are in its `deps`. The inverse uses the specified dual `InvertibleSheaf.dual`, not the existence of tensor inverses, which is the content of the class `PicardGroupoid`. (c) What the node still has to add for the pullback is at the pin as instances: `TauCeti/CategoryTheory/Monoidal/Core.lean` has the monoidal functor on the cores of a monoidal functor (`Functor.instMonoidalCore`, line 162), the braided one (`Functor.instBraidedCore`, line 202), the monoidal comparisons for the identity and for a composite (lines 190 and 195), and the monoidal isomorphism on the cores of a monoidal natural isomorphism (`Iso.instIsMonoidalCoreHom`, line 208). So a node that needs the pullback on the cores has it from `LineBundle.pullbackBraided` with these instances, and needs no declaration of this node.
  - `LineBundle.Root.tensorProduct` (`plans/GLCinLean/AlgebraicGeometry/LineBundle/RootTensorProduct.toml`) says "It uses no groupoid of invertible sheaves: the arrows of roots are isomorphisms of `InvertibleSheaf X`."
  - `Satake.criticalTwistBunDeterminantEquiv` (`plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml`) uses the determinant of `Sheaves.determinant` "with values in ℤ-graded lines". The roadmap target for graded lines is `gradedPicardGroupoid` of the same §3.4. The node excludes it ("Not used by this plan from §3.4: … `gradedPicardGroupoid`"), so the determinant is no user of the node. The graded variant is a different object: pairs of a line bundle and a locally constant degree, with the Koszul sign in the symmetry.
- **The rules.** `plans/README.md` says: "The plan holds every construction that the statement uses, the examples that rule out a trivial reading of its placeholders, and the comparison results for its definitions". From this the planner infers that a roadmap target that no node needs is not a node of the plan; `plans/README.md` does not state this sentence. `AGENTS.md`, "Plan", says: "A node of `plans/Roadmap/` is deleted only when its declaration is at the pin, its interface is checked, and a checker has checked its meaning." The class `PicardGroupoid` and its instance for `Core (InvertibleSheaf X)` are not at the pin, so this rule does not allow the deletion. "Small and big changes" lists "the removal of a planned definition" among the big changes and states no exception to the rule of "Plan" for a roadmap node without a user.

### Result

- The branch does not change the node or any text that names it: `plans/Roadmap/SchemeAndStackFoundations/PicardGroupoid.toml`, `LineBundle.pullbackBraided`, `LineBundle.Root.pullbackTensorProductIso` and the rows of `docs/blueprint-providers.md` are as on `536cce3`. The commit `6506d9a` removed the node, and a later commit of the branch reverts it.
- The fact is in the plan already: the `desc` of the node says "No node of `plans/` or of `plans-proof/` depends on this node", and `docs/blueprint-providers.md` says in the row of SchemeAndStackFoundations that no node of the plan uses it.
- Open question for the owner, through the session: whether a roadmap node that no node of the plan needs may leave `plans/Roadmap/` before its declaration is at the pin. The two checkers of round 1 found no node that needs `LineBundle.picardGroupoid`.

### Unsure

- Whether `Sheaves.determinant` should name the roadmap target `gradedPicardGroupoid` (SchemeAndStackFoundations §3.4) as the provider of its ℤ-graded lines. The node names two other roadmaps and no graded lines. This is outside the three changes.

## 2. `Groups.affineQuotientProjection` of `plans-proof/` is removed: Tau Ceti has it at the pin (small, with a check of meaning)

### Evidence

- **The node** (`plans-proof/Roadmap/ArithmeticGaloisRepresentations/AffineQuotient.toml`, removed): for a commutative bialgebra H over a commutative ring k and a commutative comodule algebra A over H, the projection Spec A → Spec A^H that the inclusion A^H → A induces; its invariance; and its universal property, that every invariant map from Spec A to an affine scheme factors through the projection in exactly one way. "No hypothesis on the group or on A is used."
- **The upstream declarations**, all in `TauCeti/AlgebraicGeometry/Quotient/ComoduleAlgebra.lean` (module `TauCeti.AlgebraicGeometry.Quotient.ComoduleAlgebra`), namespace `TauCeti.ComoduleAlgebra.AffineQuotient`:
  - lines 72–73, the variables: `(R : Type*) (H A : Type u) [CommRing R] [CommRing H] [Bialgebra R H] [CommRing A] [Algebra R A] [ComoduleAlgebra R H A]`;
  - line 77, `quotient : Scheme.{u} := Spec (CommRingCat.of (coinvariants R H A))`;
  - line 81, `projection : Spec (CommRingCat.of A) ⟶ quotient R H A := Spec.algebraMap (coinvariants R H A) A`;
  - line 91, `act_projection`: `Spec.map (coactAlgHom R H A) ≫ projection = Spec.map includeLeft ≫ projection`, an equation of maps from `Spec (A ⊗[R] H)`;
  - line 122, `desc`: for `{Y : Scheme.{u}} [IsAffine Y]`, a map `f : Spec A ⟶ Y` and the equation `Spec.map (coactAlgHom R H A) ≫ f = Spec.map includeLeft ≫ f`, a map `quotient R H A ⟶ Y`; with `projection_desc` (line 133) and `hom_ext` (line 152);
  - line 161, `existsUnique_desc`: under the same hypotheses, `∃! g : quotient R H A ⟶ Y, projection R H A ≫ g = f`.
  - The coinvariants are `TauCeti.ComoduleAlgebra.coinvariants` (`TauCeti/Algebra/Bialgebra/ComoduleAlgebra.lean`, line 145), the equalizer of the coaction and `a ↦ a ⊗ 1`; this is the algebra that `Groups.nilpotentCoadjointCone` and `Groups.chevalleyMap` name. `ComoduleAlgebra` (line 104 of that file) is a right comodule algebra.
- **The comparison.**

  | | The node | Tau Ceti at the pin | Verdict |
  |---|---|---|---|
  | The object | Spec A^H, with A^H the coinvariants | `quotient`: `Spec` of `coinvariants R H A` | the same |
  | The projection | induced by the inclusion A^H → A | `projection`: `Spec.algebraMap (coinvariants R H A) A` | the same |
  | The generality | a commutative bialgebra over a commutative ring, a commutative comodule algebra | `CommRing R`, `CommRing H`, `Bialgebra R H`, `CommRing A`, `Algebra R A`, `ComoduleAlgebra R H A` | the same |
  | Other hypotheses | none | none (the hypotheses `HopfAlgebra`, `Module.Finite` and `Module.Projective` of lines 179–181 are for the later results on finite locally free groups only) | the same |
  | The invariance | "the action map and the projection from Spec A × Spec H to Spec A have the same composite with it" | `act_projection`, with the two maps from `Spec (A ⊗[R] H)` | the same statement in another form: `Spec (A ⊗[R] H)` is the fibre product of Spec A and Spec H over Spec R; the upstream statement does not name the fibre product |
  | The universal property | every invariant map from Spec A to an affine scheme factors through the projection in exactly one way | `existsUnique_desc`, with the factorization `desc` | the same |
  | Among which schemes | affine schemes | every `Y : Scheme.{u}` with `IsAffine Y`; Y need not be `Spec` of a ring, and need not be a scheme over `Spec R` | the same, or more general when the node is read over the base |
  | Universes | not stated | `H` and `A` in one universe `u`, `R` in any universe, `Y` in `Scheme.{u}` | a restriction of the form, see below |

- **The universes.** An equation of maps of schemes from `Spec (A ⊗[R] H)` to `Spec A` needs both in `Scheme.{u}`, so the upstream declarations take `H` and `A` in one universe. `Derivation.adjointComodule` (`TauCeti/Algebra/AlgebraicGroup/Tangent/Representation.lean`, line 296) is a comodule structure on `Module.Dual R (Bialgebra.CotangentSpace R H)`, for `R : Type u` and `H : Type v` (line 56). So `Sym(𝔥)` is in universe `max u v`, and the five declarations apply to it exactly when `u ≤ v`. The node `Groups.chevalleyMap` also asks for the image of the origin, a map of schemes `Spec k → 𝔥*//H`; it exists only when `k` is in the universe `max u v` of the quotient. Both conditions together are `u = v`. So the node is stated for `k` and `H` in one universe, which is `Groups.nilpotentCoadjointCone`'s generality with this one condition added. Every user is in this scope: the statement takes `k : Type u` and its groups in `TauCeti.ReductiveCommHopfAlgCat k`, the full subcategory of an object property of `FiniteTypeCommHopfAlgCat.{u, u} k` (`TauCeti/Algebra/AlgebraicGroup/Reductive/Basic.lean`, lines 72–73 and 168). A transport for the other cases (a copy of `k` or of `H` in the universe `max u v`, by `ULift`, with its structures) is not planned: no node needs it. Section 4 has the test.
- **The users.** `grep -rn affineQuotientProjection plans plans-proof` at `536cce3`: the only node with it in `deps` is `Groups.chevalleyMap` (`plans-proof/Roadmap/LanglandsParameterStacks/CoadjointQuotient.toml`); no node of `plans/` names it. `Groups.chevalleyMap` needs, at A = Sym(𝔥) with the comodule algebra `TauCeti.ComoduleAlgebra.symmetricAlgebra` of `Derivation.adjointComodule`: the quotient scheme, the map χ, its invariance, and its universal property among affine schemes. Each is one of the declarations above. It needs more than the removed node gave in two points, which stay "Still to do" of `Groups.chevalleyMap`: the image of the origin as a section, and the fibre of χ over it. `TauCeti.ComoduleAlgebra.symmetricAlgebra` is a definition and not a global instance (`TauCeti/Algebra/Bialgebra/ComoduleAlgebra/SymmetricAlgebra.lean`, line 66), so the user supplies it as the instance. The three nodes that use `Groups.chevalleyMap` (`SpectralProof.equivariantRegularSheaf_cohomology`, `SpectralProof.geometricSatakeMonad_cohomology`, `SpectralProof.invariantQuadratics_detect_equiv`) state no need for the projection of a general comodule algebra and none for a universal property among schemes that are not affine.
- **Verdict.** The upstream declarations serve: they are the object of the node in its generality, with its invariance and its universal property. Lean confirms the interface and the case `A = Sym(𝔥)` (section 4).

### Change

- `plans-proof/Roadmap/ArithmeticGaloisRepresentations/AffineQuotient.toml` is deleted; the folder had no other file.
- `Groups.chevalleyMap`: `deps` no longer names the node. Its `desc` names `TauCeti.ComoduleAlgebra.AffineQuotient.quotient`, `projection`, `act_projection`, `desc` and `existsUnique_desc` with their module, says what each states, states the universes, and lists the five under "Upstream declarations used". "Still to do" is now the image of the origin and the fibre of χ over it. The text on who writes the node no longer names a worker for the projection. The node is stated for `k` and `H` in one universe; its `desc` gives the reason and says that the statement and the nodes that use it are in this scope.
- `plans-proof/README.md`, "Contents": the coadjoint quotient map is a case of the upstream projection, named with its module.
- `docs/blueprint-providers.md`: a new row for `TauCeti.ComoduleAlgebra.AffineQuotient.projection` in "Upstream declarations the plan uses"; the row of `coinvariants` points to it; the row of LanglandsParameterStacks names the upstream projection; the row of ArithmeticGaloisRepresentations is removed from "Roadmaps that own plan nodes", because the area owns no node now; and the entry of #43631 in the list of merged pull requests. The row of TauCetiRoadmap main in "Snapshot" names ArithmeticGaloisRepresentations as a roadmap that owns no plan node and whose §1.11 the new row quotes.

### Not changed, for the session

- `STATUS.md`: "Open items" (finding S3 of the audit of 2026-11-25) and the decision "The coadjoint nilpotent cone and its quotient map" name the node. The counts of the plan of the proof fall by one: 195 nodes, 8 owned by five roadmaps, 74 module plans.

### Unsure

- The node's words "among affine schemes" do not say whether the schemes are over Spec k. The upstream property is for all affine schemes of the universe. For a map f over Spec R, the factorization is over Spec R too, by `hom_ext` with `Y = Spec R`; no upstream declaration states this, and no node needs it now.
- The roadmap text of ArithmeticGaloisRepresentations §1.11 was not read again in this run; the comparison is with the node and with its user.

## 3. `Stacks.bandPreserving_isEquivalence` names the equivalence that the pin has (small)

### Evidence

- **The declaration.** `CategoryTheory.Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence` is at the pin, in `TauCeti/CategoryTheory/Bicategory/NaturalTransformation/Cat.lean` (module `TauCeti.CategoryTheory.Bicategory.NaturalTransformation.Cat`), line 222. `grep -rn equivalenceOfIsEquivalence .lake/packages/mathlib/Mathlib` finds nothing: it is not in Mathlib.
- **Its statement** (lines 215–232): for a bicategory `B`, pseudofunctors `F G : B ⥤ᵖ Cat.{v, w}`, and `η : F ⟶ G` with `[∀ a, (η.app a).toFunctor.IsEquivalence]`, it is a `Bicategory.Equivalence F G`, in the bicategory of pseudofunctors, strong transformations and modifications. It is `η.equivalenceMk` (`TauCeti/CategoryTheory/Bicategory/NaturalTransformation/Equivalence.lean`, line 156) at the quasi-inverses `(η.app a).toFunctor.inv`, the units and the counits of `(η.app a).toFunctor.asEquivalence`. The lemmas of lines 236–265 state its parts: its `hom` is `η`, the components of its `inv` are the quasi-inverses, and the components of its unit and counit are the componentwise ones.
- **The triangle identities.** `CategoryTheory.Bicategory.Equivalence` (`Mathlib/CategoryTheory/Bicategory/Adjunction/Basic.lean`, line 242) has the fields `hom`, `inv`, `unit : 𝟙 a ≅ hom ≫ inv`, `counit : inv ≫ hom ≅ 𝟙 b` and `left_triangle`. The right triangle identity is the theorem `Equivalence.right_triangle` of the same file (line 267).
- **The part of the node that it supplies.** The node asks, for a band-preserving morphism η of A-banded gerbes: (i) every component is fully faithful, through the isomorphisms of the sheaves Isom; (ii) every component is essentially surjective; (iii) η "has an inverse strong transformation that preserves the band, with unit and counit modifications that satisfy the triangle identities"; (iv) for an equivalence over the site, F is a gerbe if and only if G is. The declaration gives (iii) from (i) and (ii), without the words "that preserves the band". It is stated for every bicategory `B`, so it applies to `LocallyDiscrete Cᵒᵖ`, on which `IsGerbe`, `AbelianBanding` and `BandPreserving` are stated.
- **What is missing.** (i) and (ii): `grep -rln "band_morphism\|BandPreserving" TauCeti` finds `BandPreserving` only in `TauCeti/CategoryTheory/Sites/Descent/Banding.lean`, and no `band_morphism_*`. The band of the inverse: `BandPreserving` (line 141 of that file) has `BandPreserving.id` (line 167) and `BandPreserving.comp` (line 175), and no statement for the inverse of an equivalence. (iv) is in the node already, with its missing hypothesis.
- **The converse**, in the same module: `Bicategory.Equivalence.appEquivalence` (line 304), `isEquivalence_hom_app` (line 311) and `isEquivalence_inv_app` (line 317): the components of an equivalence of pseudofunctors into `Cat` are equivalences of categories.

### Change

- `Stacks.bandPreserving_isEquivalence` (`plans/Roadmap/AlgebraicModuliForArithmeticGeometry/BandPreservingEquivalence.toml`): the sentence "The other three targets are not in Tau Ceti." is replaced. The `desc` now says what the pin has of `band_morphism_equivalence` (the declaration, with its generality and its parts), what is still to do for it (the components are equivalences; the inverse preserves the band), and that `band_morphism_full_faithful` and `band_morphism_essential_surjective` are not in Tau Ceti. "Upstream declarations used" gains `equivalenceOfIsEquivalence` and `BandPreserving` with their modules. `deps` and `source` are unchanged.
- `docs/blueprint-providers.md`: a new row for the pair in "Upstream declarations the plan uses", after the row of `CategoryTheory.Pseudofunctor.StrongTrans`.

### Unsure

- The node keeps `Stacks.stackification` in its `deps`. The `desc` gives the reason: the roadmap lists SchemeAndStackFoundations §1.18 under the needs of `band_morphism_equivalence` and of `IsGerbe.equivalence_iff`. With the inverse at the pin, the construction of the inverse needs no stackification. The checker of round 1 reads the mathematics of the node as not needing it, and notes that the entry is redundant, because `Stacks.relativeGerbe` is in the same `deps` and depends on `Stacks.stackification`. The roadmap carriers of §§4.9–4.21 were not read, so the entry stays.

## 4. The interface, elaborated

The upstream modules were built in the worktree with `lake build TauCeti.AlgebraicGeometry.Quotient.ComoduleAlgebra TauCeti.CategoryTheory.Bicategory.NaturalTransformation.Cat TauCeti.Algebra.Bialgebra.ComoduleAlgebra.SymmetricAlgebra TauCeti.Algebra.AlgebraicGroup.Tangent.Representation TauCeti.CategoryTheory.Sites.Descent.Banding`; Lake unpacked them from the cache and compiled nothing. Each test below is a file outside the repository, run with `lake env lean <file>` in the worktree. No Lean file of the repository changed.

### 4.1 The affine quotient and its case `A = Sym(𝔥)` (section 2)

Result: exit status 0, no error and no warning. The five declarations have the signatures of section 2, and each depends only on `propext`, `Classical.choice` and `Quot.sound`. With `Derivation.adjointComodule` and `ComoduleAlgebra.symmetricAlgebra` as local instances, the quotient, the map, its invariance and its universal property elaborate at `A = Sym(𝔥)`, for `k : Type u` with `H : Type (max u v)` and for `k H : Type u`. For `k H : Type u`, the type of the image of the origin, `Spec k ⟶ 𝔥*//H`, is well formed.

```lean
import TauCeti.AlgebraicGeometry.Quotient.ComoduleAlgebra
import TauCeti.Algebra.Bialgebra.ComoduleAlgebra.SymmetricAlgebra
import TauCeti.Algebra.AlgebraicGroup.Tangent.Representation

/-! The interface of the affine quotient of a comodule algebra, and its case `A = Sym(𝔥)`. -/

open TauCeti TauCeti.ComoduleAlgebra AlgebraicGeometry CategoryTheory
open scoped TensorProduct

#check @AffineQuotient.quotient
#check @AffineQuotient.projection
#check @AffineQuotient.act_projection
#check @AffineQuotient.desc
#check @AffineQuotient.existsUnique_desc

#print axioms AffineQuotient.quotient
#print axioms AffineQuotient.projection
#print axioms AffineQuotient.act_projection
#print axioms AffineQuotient.desc
#print axioms AffineQuotient.existsUnique_desc

#check @Derivation.adjointComodule
#check @ComoduleAlgebra.symmetricAlgebra

universe u v

/-! The universe of `k` is at most the universe of `H`: `k : Type u` and `H : Type (max u v)`. -/
section

variable (k : Type u) (H : Type (max u v)) [CommRing k] [CommRing H] [HopfAlgebra k H]
  [Module.Finite k (Bialgebra.CotangentSpace k H)]
  [Module.Projective k (Bialgebra.CotangentSpace k H)]

local notation "𝔥" => Module.Dual k (Bialgebra.CotangentSpace k H)

attribute [local instance] Derivation.adjointComodule ComoduleAlgebra.symmetricAlgebra

/-- The coadjoint quotient `𝔥*//H = Spec Sym(𝔥)^H`. -/
noncomputable example : Scheme.{max u v} :=
  AffineQuotient.quotient k H (SymmetricAlgebra k 𝔥)

/-- The coadjoint quotient map `χ : 𝔥* → 𝔥*//H`. -/
noncomputable example :
    Spec (CommRingCat.of (SymmetricAlgebra k 𝔥)) ⟶
      AffineQuotient.quotient k H (SymmetricAlgebra k 𝔥) :=
  AffineQuotient.projection k H (SymmetricAlgebra k 𝔥)

/-- The invariance of `χ`. -/
example :
    Spec.map (CommRingCat.ofHom (coactAlgHom k H (SymmetricAlgebra k 𝔥)).toRingHom) ≫
        AffineQuotient.projection k H (SymmetricAlgebra k 𝔥) =
      Spec.map (CommRingCat.ofHom
        (Algebra.TensorProduct.includeLeftRingHom :
          SymmetricAlgebra k 𝔥 →+* SymmetricAlgebra k 𝔥 ⊗[k] H)) ≫
        AffineQuotient.projection k H (SymmetricAlgebra k 𝔥) :=
  AffineQuotient.act_projection k H (SymmetricAlgebra k 𝔥)

/-- The universal property of `χ` among affine schemes. -/
example {Y : Scheme.{max u v}} [IsAffine Y] (f : Spec (CommRingCat.of (SymmetricAlgebra k 𝔥)) ⟶ Y)
    (hf : Spec.map (CommRingCat.ofHom (coactAlgHom k H (SymmetricAlgebra k 𝔥)).toRingHom) ≫ f =
      Spec.map (CommRingCat.ofHom
        (Algebra.TensorProduct.includeLeftRingHom :
          SymmetricAlgebra k 𝔥 →+* SymmetricAlgebra k 𝔥 ⊗[k] H)) ≫ f) :
    ∃! g : AffineQuotient.quotient k H (SymmetricAlgebra k 𝔥) ⟶ Y,
      AffineQuotient.projection k H (SymmetricAlgebra k 𝔥) ≫ g = f :=
  AffineQuotient.existsUnique_desc f hf

end

/-! Equal universes, the case of the statement: `k H : Type u`. -/
section

variable (k H : Type u) [CommRing k] [CommRing H] [HopfAlgebra k H]
  [Module.Finite k (Bialgebra.CotangentSpace k H)]
  [Module.Projective k (Bialgebra.CotangentSpace k H)]

local notation "𝔥" => Module.Dual k (Bialgebra.CotangentSpace k H)

attribute [local instance] Derivation.adjointComodule ComoduleAlgebra.symmetricAlgebra

noncomputable example :
    Spec (CommRingCat.of (SymmetricAlgebra k 𝔥)) ⟶
      AffineQuotient.quotient k H (SymmetricAlgebra k 𝔥) :=
  AffineQuotient.projection k H (SymmetricAlgebra k 𝔥)

example {Y : Scheme.{u}} [IsAffine Y] (f : Spec (CommRingCat.of (SymmetricAlgebra k 𝔥)) ⟶ Y)
    (hf : Spec.map (CommRingCat.ofHom (coactAlgHom k H (SymmetricAlgebra k 𝔥)).toRingHom) ≫ f =
      Spec.map (CommRingCat.ofHom
        (Algebra.TensorProduct.includeLeftRingHom :
          SymmetricAlgebra k 𝔥 →+* SymmetricAlgebra k 𝔥 ⊗[k] H)) ≫ f) :
    ∃! g : AffineQuotient.quotient k H (SymmetricAlgebra k 𝔥) ⟶ Y,
      AffineQuotient.projection k H (SymmetricAlgebra k 𝔥) ≫ g = f :=
  AffineQuotient.existsUnique_desc f hf

/-- The type of the image of the origin, a section `Spec k → 𝔥*//H`, is well formed. -/
example : Type u :=
  Spec (CommRingCat.of k) ⟶ AffineQuotient.quotient k H (SymmetricAlgebra k 𝔥)

end
```

Output:

```text
AffineQuotient.quotient : (R : Type u_2) →
  (H A : Type u_1) →
    [inst : CommRing R] →
      [inst_1 : CommRing H] →
        [inst_2 : Bialgebra R H] → [inst_3 : CommRing A] → [inst_4 : Algebra R A] → [ComoduleAlgebra R H A] → Scheme
AffineQuotient.projection : (R : Type u_2) →
  (H A : Type u_1) →
    [inst : CommRing R] →
      [inst_1 : CommRing H] →
        [inst_2 : Bialgebra R H] →
          [inst_3 : CommRing A] →
            [inst_4 : Algebra R A] → [inst_5 : ComoduleAlgebra R H A] → Spec ↧A ⟶ AffineQuotient.quotient R H A
AffineQuotient.act_projection : ∀ (R : Type u_2) (H A : Type u_1) [inst : CommRing R] [inst_1 : CommRing H]
  [inst_2 : Bialgebra R H] [inst_3 : CommRing A] [inst_4 : Algebra R A] [inst_5 : ComoduleAlgebra R H A],
  Spec.map (CommRingCat.ofHom (coactAlgHom R H A).toRingHom) ≫ AffineQuotient.projection R H A =
    Spec.map (CommRingCat.ofHom Algebra.TensorProduct.includeLeftRingHom) ≫ AffineQuotient.projection R H A
@AffineQuotient.desc : {R : Type u_2} →
  {H A : Type u_1} →
    [inst : CommRing R] →
      [inst_1 : CommRing H] →
        [inst_2 : Bialgebra R H] →
          [inst_3 : CommRing A] →
            [inst_4 : Algebra R A] →
              [inst_5 : ComoduleAlgebra R H A] →
                {Y : Scheme} →
                  [IsAffine Y] →
                    (f : Spec ↧A ⟶ Y) →
                      Spec.map (CommRingCat.ofHom (coactAlgHom R H A).toRingHom) ≫ f =
                          Spec.map (CommRingCat.ofHom Algebra.TensorProduct.includeLeftRingHom) ≫ f →
                        (AffineQuotient.quotient R H A ⟶ Y)
@AffineQuotient.existsUnique_desc : ∀ {R : Type u_2} {H A : Type u_1} [inst : CommRing R] [inst_1 : CommRing H]
  [inst_2 : Bialgebra R H] [inst_3 : CommRing A] [inst_4 : Algebra R A] [inst_5 : ComoduleAlgebra R H A] {Y : Scheme}
  [IsAffine Y] (f : Spec ↧A ⟶ Y),
  Spec.map (CommRingCat.ofHom (coactAlgHom R H A).toRingHom) ≫ f =
      Spec.map (CommRingCat.ofHom Algebra.TensorProduct.includeLeftRingHom) ≫ f →
    ∃! g, AffineQuotient.projection R H A ≫ g = f
'TauCeti.ComoduleAlgebra.AffineQuotient.quotient' depends on axioms: [propext, Classical.choice, Quot.sound]
'TauCeti.ComoduleAlgebra.AffineQuotient.projection' depends on axioms: [propext, Classical.choice, Quot.sound]
'TauCeti.ComoduleAlgebra.AffineQuotient.act_projection' depends on axioms: [propext, Classical.choice, Quot.sound]
'TauCeti.ComoduleAlgebra.AffineQuotient.desc' depends on axioms: [propext, Classical.choice, Quot.sound]
'TauCeti.ComoduleAlgebra.AffineQuotient.existsUnique_desc' depends on axioms: [propext, Classical.choice, Quot.sound]
@Derivation.adjointComodule : {R : Type u_1} →
  {H : Type u_2} →
    [inst : CommRing R] →
      [inst_1 : CommRing H] →
        [inst_2 : HopfAlgebra R H] →
          [Module.Finite R (Bialgebra.CotangentSpace R H)] →
            [Module.Projective R (Bialgebra.CotangentSpace R H)] →
              Comodule R H (Module.Dual R (Bialgebra.CotangentSpace R H))
symmetricAlgebra : (R : Type u_1) →
  (H : Type u_2) →
    (M : Type u_3) →
      [inst : CommSemiring R] →
        [inst_1 : CommSemiring H] →
          [inst_2 : Bialgebra R H] →
            [inst_3 : AddCommMonoid M] →
              [inst_4 : Module R M] → [Comodule R H M] → ComoduleAlgebra R H (SymmetricAlgebra R M)
```

### 4.2 Outside the universe scope (section 2)

Result: exit status 1, as expected. The first example fails because `Sym(𝔥)` is in `Type (max u v)` and `H` is in `Type v`. The second fails because `Spec k` is in `Scheme.{u}` and the quotient in `Scheme.{max u v}`: Lean cannot solve `u =?= max u v`.

```lean
import TauCeti.AlgebraicGeometry.Quotient.ComoduleAlgebra
import TauCeti.Algebra.Bialgebra.ComoduleAlgebra.SymmetricAlgebra
import TauCeti.Algebra.AlgebraicGroup.Tangent.Representation

/-! Outside the universe scope of the node. Both examples are expected to fail. -/

open TauCeti TauCeti.ComoduleAlgebra AlgebraicGeometry CategoryTheory

universe u v

attribute [local instance] Derivation.adjointComodule ComoduleAlgebra.symmetricAlgebra

/-- `k : Type u` and `H : Type v` with no relation between `u` and `v`: no quotient. -/
noncomputable example (k : Type u) (H : Type v) [CommRing k] [CommRing H] [HopfAlgebra k H]
    [Module.Finite k (Bialgebra.CotangentSpace k H)]
    [Module.Projective k (Bialgebra.CotangentSpace k H)] : Scheme.{max u v} :=
  AffineQuotient.quotient k H
    (SymmetricAlgebra k (Module.Dual k (Bialgebra.CotangentSpace k H)))

/-- `k : Type u` and `H : Type (max u v)`: the quotient exists, and the image of the origin is
not a map of schemes, because `Spec k` and the quotient are in different universes. -/
example (k : Type u) (H : Type (max u v)) [CommRing k] [CommRing H] [HopfAlgebra k H]
    [Module.Finite k (Bialgebra.CotangentSpace k H)]
    [Module.Projective k (Bialgebra.CotangentSpace k H)] : Type (max u v) :=
  Spec (CommRingCat.of k) ⟶ AffineQuotient.quotient k H
    (SymmetricAlgebra k (Module.Dual k (Bialgebra.CotangentSpace k H)))
```

Output:

```text
Interface2Fail.lean:17:28: error: Application type mismatch: The argument
  H
has type
  Type v
of sort `Type (v + 1)` but is expected to have type
  Type (max u v)
of sort `Type ((max u v) + 1)` in the application
  AffineQuotient.quotient k H
Interface2Fail.lean:25:54: error: Application type mismatch: The argument
  H
has type
  Type (max u v)
of sort `Type ((max u v) + 1)` but is expected to have type
  Type u
of sort `Type (u + 1)` in the application
  AffineQuotient.quotient k H
Interface2Fail.lean:26:5: error: failed to solve universe constraint
  u =?= max u v
while trying to unify
  Type u : Type (u + 1)
with
  Type (max u v) : Type ((max u v) + 1)
Interface2Fail.lean:25:2: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Quiver Scheme

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
```

### 4.3 The equivalence of a strong transformation (section 3)

Result: exit status 0, no error and no warning. `equivalenceOfIsEquivalence` has the signature of section 3 and depends only on `propext`, `Classical.choice` and `Quot.sound`. The example applies it on `LocallyDiscrete Cᵒᵖ`, the source of the pseudofunctors on which `IsGerbe`, `AbelianBanding` and `BandPreserving` are stated.

```lean
import TauCeti.CategoryTheory.Bicategory.NaturalTransformation.Cat
import TauCeti.CategoryTheory.Sites.Descent.Banding

/-! The interface of the equivalence of a strong transformation with equivalence components. -/

open CategoryTheory Opposite
open scoped Pseudofunctor.StrongTrans

#check @Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence
#print axioms Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence
#check @Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence_hom
#check @Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence_inv_app
#check @Bicategory.Equivalence.left_triangle
#check @Bicategory.Equivalence.right_triangle
#check @Bicategory.Equivalence.isEquivalence_hom_app
#check @Pseudofunctor.BandPreserving
#check @Pseudofunctor.BandPreserving.id
#check @Pseudofunctor.BandPreserving.comp

universe w v u v' u'

/-- On a site, as the node uses it: a strong transformation of `Cat`-valued pseudofunctors on
`LocallyDiscrete Cᵒᵖ` whose components are equivalences is an equivalence of pseudofunctors,
with the given transformation as its forward map. -/
noncomputable example {C : Type u} [Category.{v} C]
    {F G : Pseudofunctor (LocallyDiscrete Cᵒᵖ) Cat.{v', u'}} (η : F ⟶ G)
    [∀ a, (η.app a).toFunctor.IsEquivalence] :
    { e : Bicategory.Equivalence F G // e.hom = η } :=
  ⟨η.equivalenceOfIsEquivalence, η.equivalenceOfIsEquivalence_hom⟩
```

Output:

```text
@Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence : {B : Type u_5} →
  [inst : Bicategory B] →
    {F G : Pseudofunctor B Cat} →
      (η : F ⟶ G) → [∀ (a : B), (η.app a).toFunctor.IsEquivalence] → Bicategory.Equivalence F G
'CategoryTheory.Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
@Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence_hom : ∀ {B : Type u_5} [inst : Bicategory B]
  {F G : Pseudofunctor B Cat} (η : F ⟶ G) [inst_1 : ∀ (a : B), (η.app a).toFunctor.IsEquivalence],
  (Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence η).hom = η
@Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence_inv_app : ∀ {B : Type u_5} [inst : Bicategory B]
  {F G : Pseudofunctor B Cat} (η : F ⟶ G) [inst_1 : ∀ (a : B), (η.app a).toFunctor.IsEquivalence] (a : B),
  (Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence η).inv.app a = (η.app a).toFunctor.inv.toCatHom
@Bicategory.Equivalence.left_triangle : ∀ {B : Type u_3} [inst : Bicategory B] {a b : B}
  (self : Bicategory.Equivalence a b),
  Bicategory.leftZigzagIso self.unit self.counit =
    Bicategory.leftUnitor self.hom ≪≫ (Bicategory.rightUnitor self.hom).symm
@Bicategory.Equivalence.right_triangle : ∀ {B : Type u_3} [inst : Bicategory B] {a b : B}
  (e : Bicategory.Equivalence a b),
  Bicategory.rightZigzagIso e.unit e.counit = Bicategory.rightUnitor e.inv ≪≫ (Bicategory.leftUnitor e.inv).symm
@Bicategory.Equivalence.isEquivalence_hom_app : ∀ {B : Type u_5} [inst : Bicategory B] {F G : Pseudofunctor B Cat}
  (e : Bicategory.Equivalence F G) (a : B), (e.hom.app a).toFunctor.IsEquivalence
@Pseudofunctor.BandPreserving : {C : Type u_3} →
  [inst : Category.{u_2, u_3} C] →
    {F G : Pseudofunctor (LocallyDiscrete Cᵒᵖ) Cat} →
      {J : GrothendieckTopology C} →
        {A : Sheaf J AddCommGrpCat} → F.AbelianBanding J A → G.AbelianBanding J A → F.StrongTrans G → Prop
@Pseudofunctor.BandPreserving.id : ∀ {C : Type u_3} [inst : Category.{u_2, u_3} C]
  {F : Pseudofunctor (LocallyDiscrete Cᵒᵖ) Cat} {J : GrothendieckTopology C} {A : Sheaf J AddCommGrpCat}
  (bF : F.AbelianBanding J A), Pseudofunctor.BandPreserving bF bF (Pseudofunctor.StrongTrans.id F)
@Pseudofunctor.BandPreserving.comp : ∀ {C : Type u_3} [inst : Category.{u_2, u_3} C]
  {F G H : Pseudofunctor (LocallyDiscrete Cᵒᵖ) Cat} {J : GrothendieckTopology C} {A : Sheaf J AddCommGrpCat}
  {bF : F.AbelianBanding J A} (bG : G.AbelianBanding J A) {bH : H.AbelianBanding J A} (η : F ⟶ G) (θ : G ⟶ H)
  [Pseudofunctor.BandPreserving bF bG η] [Pseudofunctor.BandPreserving bG bH θ],
  Pseudofunctor.BandPreserving bF bH (η ≫ θ)
```
