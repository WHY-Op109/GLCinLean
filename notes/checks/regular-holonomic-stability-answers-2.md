# Answers to round 2 on `proposal/regular-holonomic-stability`

The report of round 2 is `regular-holonomic-stability-codex-2.md` (Codex). It judges the branch at `1ea40be`, accepts the four answers of round 1, and has two new objections and two remarks. All four are right. The fixes are in commit `fbeedf4`.

The two objections concern one roadmap node, `DModules.regularHolonomicDModule_directImage_inverseImage_complex` in `plans/Roadmap/SpringerResolutionAndCharacteristicCycles/RegularHolonomicStability.toml`; this document calls it the complex node. It states, for left D-modules on smooth separated schemes of finite type of pure dimension over ℂ, that the direct image, the inverse image and the external product preserve the complexes with regular holonomic cohomology. Its passage "Readiness" lists what a proof needs beyond the node's `deps`.

I checked each point in the English edition of [HottaTakeuchiTanisaki], in the public copy that Codex links; the book is not in `references/`.

## 1. The book is for quasi-projective varieties

**Fixed.**

Evidence. Assumption 1.4.19 of the book reads: "Hereafter, all algebraic varieties are assumed to be quasi-projective." Theorems 3.2.3, 6.1.5 and 6.1.6, and the route to the external product that round 1 recorded, come after it. The complex node is for smooth separated schemes of finite type, which is the scope of the request: MixedHodgeModulesAndIrregularHodgeTheory defines a variety as a separated scheme of finite type over ℂ (its "Conventions"). So a proof that follows the book leaves a passage from quasi-projective varieties to these schemes.

The complex node now records this passage as obligation (i) under "Readiness", with the route that Codex names:

- Regularity of a holonomic module is local for the Zariski topology. The restriction to an open subscheme preserves it, by (3) of `DModules.regularHolonomicDModule`. The converse, for a finite open cover, is proved from the definition and without the stability.
- Direct image: `f_+` commutes with the restriction to an affine open of the target, by open base change. For a finite affine open cover of the source, the finite intersections are affine because the source is separated; the triangles of Mayer–Vietoris and the composition of direct images ((6) of `DModules.transferModule`) reduce to morphisms of smooth affine schemes.
- Inverse image and external product: the restriction to affine opens.

The node says that step (a2) of `DModules.IsRegularHolonomic` cannot supply the locality, because that step uses the theorem of this node. The `source` of the node says that the cited theorems and the route to clause (3) are for quasi-projective varieties. The node over every field, `DModules.regularHolonomicDModule_directImage_inverseImage`, says under "Readiness" that it waits for this obligation through its dependency.

Step (a2) itself is not changed. It is a step of the passage to crystals, which is below both roadmap nodes and may use them.

## 2. The book's regular modules and those of the roadmap

**Fixed.**

Evidence, from the book and the roadmap:

- Definition 5.3.2: an integrable connection is regular if its pullback along every morphism from a smooth curve is regular. SpringerResolutionAndCharacteristicCycles §9.7, and clause (a) of `DModules.regularHolonomicDModule`, test "every restriction to a smooth locally closed curve".
- Definition 6.1.1: a holonomic module is regular if every composition factor is a minimal extension `L(Y, N)` of a regular integrable connection on a locally closed smooth subvariety `Y` "such that the inclusion Y → X is affine"; Theorem 3.4.2 classifies the simple modules by such pairs. §9.7, and clause (b) of the plan node, take `j_!*` along every locally closed immersion of a smooth `W`.

The proof applies the theorems of the book to the category of the roadmap, so the two categories must be shown equal. The complex node now records this as obligation (ii) under "Readiness", with the two steps that Codex names:

- Curves. The pullback along a constant morphism is a trivial connection. A morphism that is not constant restricts, over a dense open of its source, to a dominant morphism onto a smooth open subset of its image, which is a smooth locally closed curve. Regularity passes along a dominant morphism of curves (Lemma 5.1.23 (i): `M` is regular exactly when `f^†M` is) and from a dense open of a curve to the curve (Definition 5.1.21). This is the argument of Step 1 of §6.2 of the book.
- Affine inclusions. A dense affine open `W°` of `W` has an affine inclusion, because the ambient scheme is separated. For a simple `E`, `j_!*E` is the intermediate extension of `E|W°`: it is simple by (3) of `DModules.holonomicIntermediateExtension`, so it has no proper submodule or quotient at all, and (2) of that node gives the uniqueness.

Both steps can be proved before the stability, as Codex says. The node also notes that ComplexComparisonPartII C5.6 tests on all maps from smooth curves, as the book does, and that clause (6) of `DModules.regularHolonomicDeRham` needs the first comparison too; that node already said so for its own clause.

`docs/blueprint-providers.md` names both obligations in the sentence on the readiness of the two nodes. `docs/papers.md` records the numbers compared for this round: Assumption 1.4.19, Definition 5.3.2, Lemma 5.1.23 and Theorem 3.4.2.

## 3. Remark: coherence first in the lemma of `DModules.verdierDuality`

**Fixed.** The lemma says that the duality commutes with the direct image along a closed embedding `i : Y → Z`. The duality `𝔻_Z` is defined on `DModules.Coherent` only, so `i_*M` must be coherent before the isomorphism is stated. The lemma now proves the coherence first, by Codex's argument: for an affine open `V` of `Z` with a closed embedding into an affine space, the preimage of `V` in `Y` is affine and closed in `V`, its composite into the affine space is a closed embedding, and the criterion of `DModules.Coherent` through charts applies.

## 4. Remark: which node proceeds over ℂ

**Fixed.** `docs/blueprint-providers.md`, "The Riemann–Hilbert correspondence", said that "the correspondence over the complex numbers does not wait for the other fields". That was true only of the roadmap node. The text now says: the correspondence for left modules on smooth complex schemes, `DModules.regularHolonomicDeRham`, does not wait for the other fields; the two de Rham nodes written here, `DModules.analyticDeRham` and `DModules.analyticDeRham_isEquivalence`, depend on `DModules.IsRegularHolonomic` and through it on the node over every field.

This is a real cost of the design and not only a wording point: the two nodes written here are over ℂ, and they wait for a theorem over every field because `DModules.IsRegularHolonomic` is one node for all fields. I did not split that node. A split by field would be a change of a definition that the statement will use, and no work is blocked by it today. The session may add it to the entry under "Decisions taken".

## 5. Text for `STATUS.md`

One addition to the line "Before the Worker takes the complex node" of `regular-holonomic-stability-answers-1.md`, section 9: the inputs under "Readiness" now include the passage from quasi-projective varieties to smooth separated schemes of finite type and the comparison of the two notions of regularity. The other texts of that section stand.

## 6. Checks

After `fbeedf4`: `lake exe tracker lint` has no errors; `python3 tools/check-module-cycles.py` reports 200 module plans, 314 nodes, 0 cycles; `python3 tools/check-upstream-names.py` confirms all 359 pairs. No Lean file changed.

Not checked: that the lattice condition of §5.1.3 of the book is the logarithmic lattice of §9.7 word for word; the comparison of obligation (ii) assumes it, and it is part of that obligation.
