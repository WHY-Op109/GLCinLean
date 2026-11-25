# Check of the branch `proposal/unused-nodes` (commits `6506d9a`, `fda9a7d`, `069f9bb` on `536cce3`)

**Result.** I found no *mismatch*. All three changes say what the pin, the plan and the papers say. There are three *unsure* points; none of them is an error of the branch. I changed no file.

Paths: the worktree is `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-aa13f465b503f3b40`. Tau Ceti at the pin `553f7926` is `/Users/why/Documents/Projects/GLCinLean/.lake/packages/TauCeti`; the upstream paths below are relative to it. Plan paths are relative to the worktree.

## Unsure points (top)

1. **The upstream declarations of changes 2 and 3 were read in the source text, not elaborated.** The object files of `TauCeti.AlgebraicGeometry.Quotient.ComoduleAlgebra` and `TauCeti.CategoryTheory.Bicategory.NaturalTransformation.Cat` do not exist in the main checkout, so `lake env lean` stops at the import. `AGENTS.md`, "Plan", asks that the interface is checked before a roadmap node is deleted. The signatures are certain from the source at the pin. Not confirmed by Lean: that the declarations apply to `A = Sym(𝔥)` when `k` and `H` are in one universe (the new text of `Groups.chevalleyMap`). To do: build the two modules and run the two test files `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/Check1.lean` and `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/Check3.lean` (`#check`, `#print axioms`, and one `example` for `Sym(𝔥)`; the `example` is a draft that never ran).
2. **`Stacks.stackification` in the `deps` of `Stacks.bandPreserving_isEquivalence`** (`plans/Roadmap/AlgebraicModuliForArithmeticGeometry/BandPreservingEquivalence.toml:7`). My reading: the mathematics of the node does not need it. Details are under change 3. It is unsure because I did not read the roadmap's carriers of §§4.9–4.21.
3. **The ℤ-graded lines of the determinant have no node** (outside the three changes). `Satake.criticalTwistBunDeterminantEquiv` (`plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml:16`) uses "the determinant of Sheaves.determinant with values in ℤ-graded lines … with the Koszul sign rule". `Sheaves.determinant` (`plans/GLCinLean/AlgebraicGeometry/Sheaves/Determinant.toml:13–14`) names no graded lines and depends only on `Sheaves.PerfectComplex`. The removal does not cause this and does not make it worse. Details are under change 1.

## Change 1 (`6506d9a`): removal of `LineBundle.picardGroupoid`. Verdict: *agree*

- **No `deps` names the node.** At `536cce3`, `git grep -i picardGroupoid` over `plans`, `plans-proof`, `GLCinLean`, `GLCinLean.lean`, `docs`, `prompts` and `tools` finds the node's own file, two other plan files and four lines of `docs/blueprint-providers.md`. No `deps` line is among them. At the branch tip, a script over both plan folders finds no `deps` entry that names an unknown node.
- **No text uses the object without its name.** I searched `plans`, `plans-proof`, `GLCinLean` and `GLCinLean.lean` for "groupoid of line bundles", "groupoid of invertible", "monoidal groupoid", "tensor inverse", "Core (", "Pic", "graded line", "invertible objects", "symmetric monoidal functor from", "Picard" and "2-group". The only text near a use is `Stacks.rootGerbe`.
- **The reading of `Stacks.rootGerbe` is confirmed** (`plans/GLCinLean/AlgebraicGeometry/Stacks/Gerbe.toml:13`). "R_n is a symmetric monoidal functor from the groupoid of line bundles on Y" is not a use of the removed node. Reasons:
  - Y is a prestack, and the removed node was `Core (InvertibleSheaf X)` of a scheme X.
  - The node spells the functor out as band-preserving equivalences and takes them from `LineBundle.Root.tensorProduct` and `LineBundle.Root.pullbackTensorProductIso`, which are in its `deps` (line 14).
  - What the removed node still had to write was the class `PicardGroupoid` (existence of tensor inverses) with its instance, and the pullback on the cores. A symmetric monoidal functor needs no such class, and the inverse clause uses the specified dual.
  - The pullback on the cores is at the pin as instances. I confirmed in `TauCeti/CategoryTheory/Monoidal/Core.lean`: `instSymmetricCategory` (line 151), `instMonoidalCore` (162), the instances for the identity and a composite (190, 195), `Functor.instBraidedCore` (202) and `Iso.instIsMonoidalCoreHom` (208).
  - The paper agrees: [GLys] §1.4.2 (`references/papers/1608.00284v7/src/text.tex`, lines 1611–1628) defines `L^{1/n}` on an affine test scheme as the groupoid of pairs `(L′, L′^{⊗n} ≃ L|_S)` and names no Picard groupoid.
- **`Sheaves.determinant` and `Satake.criticalTwistBunDeterminantEquiv` do not need the removed node.** They need the graded variant, which is a different object: the same objects in degree 0, but pairs (line bundle, locally constant degree) with the Koszul sign in the symmetry. I read the roadmap text at `b24abdf7` (SchemeAndStackFoundations §3.4). It defines `gradedPicardGroupoid X` directly from `InvertibleSheaf` and `LocallyConstant X ℤ`, not from `picardGroupoid X`. The construction in `Twisting.toml:16` uses specified inverses (`Hom(L, L′)`, the coevaluation), not the class. Its last step applies `Stacks.rootGerbe` to "the resulting isomorphism of ordinary lines", which is an isomorphism of invertible sheaves.
- **Open item for the session (unsure point 3).** The removed node said "Not used by this plan from §3.4: … `gradedPicardGroupoid`". That sentence did not fit `Twisting.toml:16` before the change, and it is gone now. When the work reaches `Sheaves.determinant`, its `desc` should state its values (ℤ-graded lines with the Koszul sign) and their provider. The roadmap target `gradedPicardGroupoid` is the candidate on a scheme, and it uses the class `PicardGroupoid` for its `π_0` and `π_1`. I did not read roadmap PadicMeasuresIwasawaAlgebras (`detLine`).
- **The changed texts are right.** `LineBundle.pullbackBraided` and `LineBundle.Root.pullbackTensorProductIso` no longer name the node id. The four places of `docs/blueprint-providers.md` agree with the plan: SchemeAndStackFoundations has 8 nodes in `plans/` (counted). The plan has 311 nodes in 198 module plans.
- **Procedure.** The declaration is not at the pin, so this is the removal of a planned definition, a big change. It reverses one sentence of a decision in force (`STATUS.md:148`, "`LineBundle.picardGroupoid` stays a roadmap node"). `STATUS.md:105` already names it as a big change of its own. The branch leaves `STATUS.md` to the session.

## Change 2 (`fda9a7d`): removal of `Groups.affineQuotientProjection`. Verdict: *agree*; the invariance is *same object, different presentation*

The verdict rests on a blind reading of the Lean text without doc comments, compared with the removed node (`git show 536cce3:plans-proof/Roadmap/ArithmeticGaloisRepresentations/AffineQuotient.toml`), with `Groups.chevalleyMap`, and with the paper.

| Point | Removed node | Upstream, `TauCeti/AlgebraicGeometry/Quotient/ComoduleAlgebra.lean` | Verdict |
|---|---|---|---|
| Object | Spec A^H | `quotient` (line 77): `Spec` of `coinvariants R H A` | agree |
| Projection | induced by A^H → A | `projection` (line 81): `Spec.algebraMap (coinvariants R H A) A` | agree |
| Generality | commutative bialgebra over a commutative ring, commutative comodule algebra | line 72: `CommRing R`, `CommRing H`, `Bialgebra R H`, `CommRing A`, `Algebra R A`, `ComoduleAlgebra R H A` | agree |
| Other hypotheses | none | none; `HopfAlgebra`, `Module.Finite`, `Module.Projective` (lines 179–181) are for later results only | agree |
| Invariance | action and projection from Spec A × Spec H have the same composite | `act_projection` (line 91): the two maps from `Spec (A ⊗[R] H)`; no fibre product is named | same object, different presentation |
| Universal property | every invariant map to an affine scheme factors in exactly one way | `desc` (122), `projection_desc` (133), `hom_ext` (152), `existsUnique_desc` (161) | agree |
| Which schemes | affine schemes | every `Y : Scheme.{u}` with `IsAffine Y`; Y need not be `Spec` of a ring, has no map to `Spec R`, and `f` is any morphism of schemes | agree (the absolute form) |
| Universes | not stated | `H`, `A` in one universe `u`; `R` in any universe; `Y` in `Scheme.{u}` | a restriction of the form; the new text states it |

- **Over the base or not.** The upstream property is absolute. It implies the property over `Spec R` when `R` is in the universe `u`: for a map over `Spec R`, the factorization is over `Spec R` by `hom_ext` with `Y = Spec R`. No upstream declaration states this, and no node asks for it.
- **The universes.** `Derivation.adjointComodule` (`TauCeti/Algebra/AlgebraicGroup/Tangent/Representation.lean:296`, with `R : Type u`, `H : Type v` at line 56) is a comodule on `Module.Dual R (Bialgebra.CotangentSpace R H)`, a type in universe `max u v`. So `Sym(𝔥)` is in `max u v`, and the declarations apply exactly when `u ≤ v`. The statement has `u = v`: `reductiveCommHopfAlgProperty` is a property of `FiniteTypeCommHopfAlgCat.{u, u} k` (`TauCeti/Algebra/AlgebraicGroup/Reductive/Basic.lean:72–73`). The new text of `Groups.chevalleyMap` (`plans-proof/Roadmap/LanglandsParameterStacks/CoadjointQuotient.toml:6`) says this correctly. See unsure point 1 for the elaboration.
- **The other facts of the new text hold.** `ComoduleAlgebra` is a right comodule algebra (`TauCeti/Algebra/Bialgebra/ComoduleAlgebra.lean:104`), which fits "Spec A × Spec H". `coinvariants` is the equalizer of the coaction and `a ↦ a ⊗ 1` (line 145). `ComoduleAlgebra.symmetricAlgebra` is a definition and not a global instance (`TauCeti/Algebra/Bialgebra/ComoduleAlgebra/SymmetricAlgebra.lean:66`).
- **The paper.** [ArinkinGaitsgory] §11.1.2 (`references/papers/1201.6343v4/src/singsupp.tex`, lines 7883–7886): `𝔠(ǧ) := Spec(Sym(ǧ)^Ǧ)` and `ϖ : ǧ* = Spec(Sym(ǧ)) → 𝔠(ǧ)`. These are `quotient` and `projection` at `A = Sym(𝔥)`.
- **The one user.** `Groups.chevalleyMap` needs the quotient, the map, its invariance and the universal property among affine schemes; each is one upstream declaration. Its "Still to do" (the image of the origin and the fibre over it) is more than the removed node gave, so nothing is lost. Its `deps` is now `['GLCinLean.Groups.nilpotentCoadjointCone']`, a known node. In the three nodes that depend on it (`plans-proof/GLCinLean/GeometricLanglands/Spectral/DerivedSatake/Monads.toml`), a search finds no request for a universal property or for a quotient among schemes that are not affine.
- **Doc comments upstream match the code.** `existsUnique_desc` says "categorical quotient in affine schemes", and the code has `[IsAffine Y]`. The module doc says the property for targets that are not affine is not proved.
- **Degenerate cases** (from the blind reading): for a trivial coaction the coinvariants are all of A and the projection is an isomorphism; for `A = 0` both schemes are empty. Both are correct mathematics. The statement of the main theorem does not reach these declarations.
- **The blind reader's remark.** The declarations use `H` only through the ring `A ⊗[R] H` and two ring maps; they prove nothing geometric (orbits, surjectivity, base change). The node did not ask for more.

## Change 3 (`069f9bb`): `Stacks.bandPreserving_isEquivalence`. Verdict: *agree*

- **The declaration matches the new text.** `CategoryTheory.Pseudofunctor.StrongTrans.equivalenceOfIsEquivalence` (`TauCeti/CategoryTheory/Bicategory/NaturalTransformation/Cat.lean:222`, variables at line 215). For any bicategory `B`, pseudofunctors `F G : B ⥤ᵖ Cat.{v, w}` and a strong transformation `η : F ⟶ G` whose components are all equivalences of categories (an instance hypothesis), it is a `Bicategory.Equivalence F G` in the bicategory of pseudofunctors, strong transformations and modifications. The blind reading says the same: no site, stack, gerbe or band appears, and the declaration assumes that the components are equivalences.
- **Its parts match.** Lemmas at lines 236–262: the forward map is `η`; the components of the inverse are the chosen quasi-inverses; the components of the unit and the counit are those of the components. The structure `Bicategory.Equivalence` has the left triangle identity as a field (`Mathlib/CategoryTheory/Bicategory/Adjunction/Basic.lean:242–252`), and `Equivalence.right_triangle` is a theorem of the same file (line 267). The converse is `Bicategory.Equivalence.isEquivalence_hom_app` (line 311).
- **What is missing is stated correctly.** `BandPreserving` (`TauCeti/CategoryTheory/Sites/Descent/Banding.lean:141`) has `id` (167) and `comp` (175) and no statement for an inverse. No `band_morphism_*` exists at the pin. On Tau Ceti `main` (`58174b5f`, 2026-11-25) `Banding.lean` has the same declarations, and a code search finds `BandPreserving` in that file only.
- **`Stacks.stackification` in `deps`: not needed by the mathematics, as I read it (unsure point 2).**
  - Full faithfulness and essential surjectivity use the Isom sheaves, torsors and effective descent. The stack property is a field of the gerbe: `class IsGerbe … extends F.IsStack J` (`TauCeti/CategoryTheory/Sites/Descent/IsGerbe.lean:50–51`).
  - The inverse is at the pin, and its band is a pointwise computation.
  - "F is a gerbe iff G is" needs the stack property carried along a pointwise equivalence. The roadmap proves it by "transport `Pseudofunctor.IsStack` along the equivalence". §1.18 of SchemeAndStackFoundations has no such target; its targets are stacks in groupoids, the stackification and 2-fibre products. I found no such lemma at the pin.
  - The entry records only the roadmap's "Needs" lines, as the `desc` says. It is also redundant: `Stacks.relativeGerbe` is in the same `deps` and itself depends on `Stacks.stackification`.
  - Keeping it is not an error. Dropping it is a small change. Then two texts change in the same commit: "(Stacks.stackification)" in the `desc` of this node, and "Stacks.bandPreserving_isEquivalence … use it" in the `desc` of `Stacks.stackification` (`plans/Roadmap/SchemeAndStackFoundations/Stackification.toml:6`).

## `AGENTS.md`: "Writing", "Sources of code", "Lean code"

- **No breach in the changed plan nodes.** They state current facts and name each upstream declaration with its module. No Lean file changed.
- **Minor, `docs/blueprint-providers.md:12`** (row "TauCetiRoadmap main"): it still names "AffineLieAlgebras and ArithmeticGaloisRepresentations of `plans-proof/Roadmap/`". After change 2, `plans-proof/Roadmap/` has five areas and none has that name. The planner left the row on purpose as a dated record. To make it a current fact: name ArithmeticGaloisRepresentations there as the roadmap whose §1.11 the row of `TauCeti.ComoduleAlgebra.AffineQuotient.projection` quotes.
- **Minor, the planner's note** (`notes/checks/unused-nodes.md`, section 1, "The rule"): the sentence "A roadmap target that no node needs is not a node of the plan" is not in `plans/README.md`; only the first sentence is (line 3). It is the planner's inference and should be marked so.
- **Commit messages** name each small change.

## `docs/blueprint-providers.md` and the tools

- The table "Roadmaps that own plan nodes" agrees with the node counts of every area in both folders: 89 roadmap nodes in `plans/`; 8 in `plans-proof/`, in five areas. The new rows for `AffineQuotient.projection` and `equivalenceOfIsEquivalence` say what the declarations state.
- At the branch tip, in the worktree: `lake exe tracker lint` exits 0 with no errors (61 warnings, all "superseded by its doc comment" or "superseded by the real dependencies"). `python3 tools/check-module-cycles.py`: 198 module plans, 311 nodes, 0 cycles. `python3 tools/check-upstream-names.py`: 363 pairs, 0 not confirmed. `plans-proof/` has 195 nodes, and no `deps` names an unknown node.
- For the session, `STATUS.md` is unchanged on the branch and names the removed nodes at lines 105, 134, 148 and 154, and in the row of `author-stacks`. Its counts at lines 10–11 become 311 declarations in 198 module plans, and 195 proof nodes (8 owned by five roadmaps) in 74 module plans.

## Not checked

- Elaboration of the upstream declarations (unsure point 1).
- The roadmap carriers of AlgebraicModuliForArithmeticGeometry §§4.9–4.21, and whether they use §1.18.
- Roadmap PadicMeasuresIwasawaAlgebras (`detLine`) and AlgebraicVectorBundles, for the determinant.
- Roadmap ArithmeticGaloisRepresentations §1.11 and LanglandsParameterStacks §1.12: I fetched the first and did not compare its text with the node.
- The tools after each single commit: I ran them at the branch tip only.
- The unchanged claims of `Stacks.bandPreserving_isEquivalence` against [GLys] §1.3.6, and the `isGerbe_*_of_isEquivalence` lemmas beyond their signatures.
- Tau Ceti `main` beyond `Banding.lean` and one code search; the search for `equivalenceOfIsEquivalence` on `main` failed with a network error.

## One more fact

During my check, an untracked file appeared in the worktree: `notes/checks/unused-nodes-codex-1.md`. I did not create it and did not read it, so this report is independent of it.