# What Mathlib already has for GLC

- **Source:** Mathlib (leanprover-community/mathlib4), the copy pinned in `lake-manifest.json`:
  rev `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` (committed 2026-11-02), read locally in
  `.lake/packages/mathlib`. Compared against master at `6ea219250edddc6df74165eb514e71cd6efe0db4`
  (2026-11-08T17:56Z) and a search of open Mathlib PRs via `gh`.
- **Checked 2026-11-08.**
- **Licence:** Apache 2.0 (`.lake/packages/mathlib/LICENSE`) [R 2026-11-08].
- **Method.** Directory listings, module docstrings and `grep` for declaration heads in the pinned
  copy. "Missing" means a targeted grep over the whole `Mathlib/` tree found nothing; that is
  strong but not complete evidence (a concept under an unexpected name could be missed). No Lean
  code was elaborated. Tau Ceti is mentioned only where Foundations already relies on it, or
  where it decides a Mathlib-based proposal (root data, §2.3); the Tau Ceti notes cover it
  properly. Tau Ceti spot checks use the pinned copy in `.lake/packages/TauCeti` (rev
  `e0610cce`, 2026-11-02).
- **Independent re-check 2026-11-08.** The declaration names, files and line numbers below were
  re-read in the pinned copy, the master comparison and the PR states were re-queried with `gh`.
  Corrections from that pass: Weil divisors exist (§2.1); the affine Kac–Moody central extension
  can already be assembled (§2.4); the heart of a t-structure is not yet proved abelian (§2.8);
  1-categorical `IsFinitelyPresentable` is not the right model for compactness (§3.4);
  `RootDatumDuality` lives in `Abstract.lean`, not `Foundations.lean` (§4).

## 1. What it is

Mathlib is the human-curated library that the owner's rule "Mathlib first" (ideas.md, point 3)
puts at the top of the source order. This note maps the objects GLC I uses onto the pinned
Mathlib: what exists (declaration names and files), what is partial, what is missing.

**Pinned vs. master** [R 2026-11-08]: master is 150 commits ahead of the pin. Those commits
touch many `AlgebraicGeometry/` files but add only two new Lean files
(`Algebra/Homology/ShortComplex/HomologyCofork.lean`, `AlgebraicGeometry/OrderOfVanishing/DVR.lean`).
None of the gaps below is closed on master.

## 2. What it says that matters for GLCinLean

All paths are relative to `Mathlib/`. The tag applies to the existence and name of the
declaration; "suits GLC" remarks are [J].

### 2.1 Schemes, morphisms, curves — **largely present**

- Schemes `AlgebraicGeometry.Scheme`, `Spec`, `X.Over S` and `X ↘ S` (`Over.lean`) [R].
- `class Smooth`, `class SmoothOfRelativeDimension` (`AlgebraicGeometry/Morphisms/Smooth.lean`) [R].
- `class IsProper` = separated + universally closed + locally of finite type
  (`Morphisms/Proper.lean:41`) [R].
- Also étale, flat, finite, finite type/presentation, separated, quasi-compact, immersions, flat
  descent (`Morphisms/`) [R]; `GeometricallyConnected` (`Geometrically/Connected.lean:40`), plus
  geometrically integral/irreducible/reduced [R].
- **Curves:** no "curve" definition. A curve has to be written as
  `SmoothOfRelativeDimension 1 (X ↘ Spec k)` + `IsProper` + `ConnectedSpace X`, which is exactly
  what `Abstract.lean`'s `Setting` does [R Abstract.lean]. The only curve-specific theory is
  elliptic curves (Weierstrass models, `EllipticCurve/`), function fields
  (`FunctionField.lean`), order of vanishing and algebraic cycles [R].
- **Divisors (corrected):** Weil divisors exist in general, as algebraic cycles supported in
  codimension one: `AlgebraicCycle.IsWeilDivisor` (`AlgebraicGeometry/AlgebraicCycle/Basic.lean:143`)
  [R 2026-11-08]. Principal divisors, linear equivalence, genus, Riemann–Roch and Serre duality:
  missing [R grep 2026-11-08].
- `Setting` asks for `ConnectedSpace X`. Over an algebraically closed `k` this is the same as
  geometric connectedness, but Mathlib's `GeometricallyConnected` would keep the hypothesis
  correct if `IsAlgClosed k` were ever dropped [J 2026-11-08].

### 2.2 Group schemes and reductive groups — **partial (group objects only)**

- Group schemes as group objects `GrpObj` / `Grp (Over (Spec R))` in the cartesian monoidal
  category of schemes over `Spec R` [R `AlgebraicGeometry/Group/Affine.lean`].
- `hopfSpec : (CommHopfAlgCat R)ᵒᵖ ⥤ Grp (Over (Spec R))`, fully faithful
  (`hopfSpec.fullyFaithful`), essential image = affine group schemes (`essImage_hopfSpec`)
  (`Group/Affine.lean:177,187,480`) [R].
- `smooth_of_grpObj`: a geometrically reduced, locally finite-type group scheme over a field is
  smooth (`Group/Smooth.lean`) [R]. `isCommMonObj_of_isProper_of_geometricallyIntegral`
  (`Group/Abelian.lean`) [R].
- **Missing** [R grep for `Reductive`, `Borel`, `maximal torus`, `Torsor` in AG]: tori, Borel
  subgroups, reductive/semisimple groups, the root datum of a group, pinnings, `GL_n` as a group
  scheme, representations of group schemes (no `Comodule`), `G`-torsors / principal bundles.
  Foundations already takes `ReductiveGroup` and `Pinning` from Tau Ceti
  (`TauCeti.ReductiveAffineGroupSchemeCat`, `TauCeti.Pinning`) [R Foundations.lean].

### 2.3 Root data and Langlands duals — **present at the combinatorial level**

- `structure RootPairing`, `abbrev RootDatum := RootPairing ι ℤ X₁ X₂`, `class IsRootSystem`
  (`LinearAlgebra/RootSystem/Defs.lean:81,111,120`) [R].
- **The dual root datum exists:** `RootPairing.flip` and `flipEquiv`, with `flip_flip`
  (`Defs.lean:129–146`) [R].
- Morphisms and isomorphisms: `RootPairing.Hom`, `protected structure RootPairing.Equiv`
  (`RootSystem/Hom.lean:63,271`) [R]. Also bases, Cartan matrices, Weyl group, irreducible and
  reduced systems, `RootPairingCat` [R file list].
- Docstring caveat [R]: "Formally `RootDatum` does not demand the finite generation hypotheses"
  (`Defs.lean:104`). The same docstring gives the remedy: "one must supply the two assumptions
  `[Module.Finite ℤ X₁] [Module.Finite ℤ X₂]`", freeness then being automatic [R 2026-11-08].
  So this is two instance arguments, not a wrapper.
- `RootPairing.Hom` carries an explicit bijection of root index sets (`indexEquiv`) besides the
  weight and coweight maps, and `RootPairing.Equiv` adds bijectivity of both maps
  (`Hom.lean:63–74,271`) [R]. `RootPairingCat R` bundles the index type, weight and coweight
  lattices and the pairing in one structure (`RootPairingCat.lean`; SGA III Exp. 21 §6) [R]. A
  function "root datum of `G`" can therefore take values in `RootPairingCat ℤ` [J].
- **Missing:** the root datum *of a reductive group* (needs tori and characters). Tau Ceti builds
  its root data on Mathlib's `RootDatum`: the coordinate root datum of a split torus
  (`SplitTorus/RootDatum/Basic.lean`), `GL_n` and `Sp` diagonal-torus data, and simply connected
  root data for each Dynkin type (`LinearAlgebra/RootSystem/SimplyConnectedRootDatum/`) [R
  2026-11-08]. A grep of pinned Tau Ceti found no root datum attached to a general
  `ReductiveAffineGroupSchemeCat` [R grep 2026-11-08]. So the gap is in both providers.

### 2.4 Lie algebras and Kac–Moody — **rich finite-dimensional theory; Kac–Moody only begun**

- Large `Algebra/Lie/` tree: solvable, nilpotent, semisimple, Killing form, Cartan subalgebras,
  weights, `UniversalEnvelopingAlgebra` [R].
- `LieAlgebra.IsKilling.rootSystem`: the root system of a Killing Lie algebra
  (`Algebra/Lie/Weights/RootSystem.lean:411`) [R].
- `Matrix.ToLieAlgebra`: the Serre construction from a Cartan matrix, including `e₆ … g₂`
  (`Algebra/Lie/SerreConstruction.lean`) [R]. The remark that it "also allows construction of
  Kac-Moody Lie algebras" is in `LinearAlgebra/RootSystem/GeckConstruction/Basic.lean:38–40`,
  which adds "as of May 2025, almost nothing has been proved about it in Mathlib" [R 2026-11-08].
- `LieAlgebra.loopAlgebra R A L := AddMonoidAlgebra R A ⊗[R] L` (polynomial loops; the classical
  case is `A = ℤ`, i.e. `L[t, t⁻¹]`) and `loopAlgebra.twoCocycleOfBilinear` for a symmetric
  invariant form (`Algebra/Lie/Loop.lean:65,183`) [R]. Its TODO lists "Construction of central
  extensions from invariant forms" [R].
- **Correction:** the extension itself already exists in general: `LieAlgebra.Extension.ofTwoCocycle`
  builds the Lie algebra extension of `L` by `M` from any 2-cocycle (`Algebra/Lie/Extension.lean:243`)
  [R 2026-11-08]. Applying it to `twoCocycleOfBilinear` should give the central extension of
  `g[t, t⁻¹]` at a level, without a name or API [J, not elaborated]. What is really missing is the
  Laurent-*series* version `g((t))` that GLC uses, a named `ĝ_κ`, and its representations.
- Open PR #45801 "symmetrizable matrices" (updated 2026-11-08) [R title only].
- **Missing:** the Lie algebra of a group scheme, Kac–Moody representation theory, the critical
  level, vertex-algebra-side objects relevant to GLC [R grep].

### 2.5 Line bundles and the canonical sheaf — **ring level only**

- `Module.Invertible`, `CommRing.Pic` (`RingTheory/PicardGroup.lean:77,429`) [R].
- `KaehlerDifferential` / `Ω[S⁄R]` for rings (`RingTheory/Kaehler/Basic.lean:148`) [R].
- Presheaf of relative differentials, identity-functor case only:
  `relativeDifferentials'` (`Algebra/Category/ModuleCat/Differentials/Presheaf.lean:188`); its
  docstring: "the general case (TODO)" [R]. Open PR #41228 (joelriou, 2026-10-03) does the
  general case [R title].
- `SheafOfModules.IsLocallyFree` (`Algebra/Category/ModuleCat/Sheaf/LocallyFree.lean:61`) [R].
- **Missing:** invertible sheaves on schemes, `Pic X`, `Ω_{X/k}` as a sheaf on a scheme, the
  canonical bundle, square roots of `ω_X`. Draft PR #44200 "feat(AlgebraicGeometry): Picard
  Group" (Brian-Nugent, 2026-10-29) and drafts #40831, #40194 on locally free sheaves [R titles].
  Foundations takes `LineBundle`, `LineBundle.tensor` and `canonicalSheaf` from Tau Ceti [R].

### 2.6 Sheaves of modules and quasi-coherent sheaves — **1-categorical, partial**

- `SheafOfModules R` for any `R : Sheaf J RingCat` (noncommutative rings allowed)
  (`Algebra/Category/ModuleCat/Sheaf.lean:31`) [R].
- `X.Modules := SheafOfModules X.ringCatSheaf`, with `Abelian`, `HasLimits`, `HasColimits`,
  `IsGrothendieckAbelian`, and `pullback ⊣ pushforward` (`AlgebraicGeometry/Modules/Sheaf.lean`) [R].
- `class SheafOfModules.IsQuasicoherent` (`ModuleCat/Sheaf/Quasicoherent.lean:247`, Stacks 01BD)
  [R]; `tilde` with `tilde.adjunction` (`AlgebraicGeometry/Modules/Tilde.lean`) [R].
- Monoidal structures: on presheaves of modules (`ModuleCat/Presheaf/Monoidal.lean`) and on
  `Sheaf J A` for closed braided `A` (`CategoryTheory/Sites/Monoidal.lean`) [R]; no tensor
  product of `X.Modules` found [R grep].
- **Missing:** a bundled `QCoh(X)` category, coherent sheaves, and anything derived (`D(QCoh)`,
  `IndCoh`). Open PR #39989 (pullback of quasi-coherent is quasi-coherent) [R title].

### 2.7 Sites, stacks, fibered categories — **foundations present, algebraic stacks missing**

- Grothendieck topologies, sheafification, coverages, hypercovers, points
  (`CategoryTheory/Sites/`) [R].
- Sites on schemes: big Zariski, étale, fpqc, pro-étale, `ellAdicSheaf`
  (`AlgebraicGeometry/Sites/`); representability is Zariski-local
  (`Sites/Representability.lean`) [R].
- `Functor.IsPreFibered`, `Functor.IsFibered` (`CategoryTheory/FiberedCategory/Fibered.lean:55,65`)
  [R]. No class for categories *fibred in groupoids* [R grep 2026-11-08].
- Descent data and stacks: `Pseudofunctor.IsPrestack`, `IsStack` for
  `F : LocallyDiscrete Cᵒᵖ ⥤ᵖ Cat` (`Sites/Descent/IsStack.lean:49`). Its docstring says the
  fibre categories need not be groupoids [R].
- Sheaf cohomology as `Ext` (`Sites/SheafCohomology/`) and `H¹` cochains
  (`Sites/NonabelianCohomology/H1.lean`) [R].
- **Missing:** algebraic stacks/spaces, quotient stacks, `Bun_G`, `LS_Ǧ`, mapping stacks [R grep].

### 2.8 Derived and triangulated categories, t-structures — **good 1-categorical base**

- Pretriangulated and triangulated categories, triangulated functors, subcategories, Verdier
  localizing subcategories, generators (`CategoryTheory/Triangulated/`) [R].
- `DerivedCategory C` for abelian `C` as a localisation of `CochainComplex C ℤ`, triangulated
  (`Algebra/Homology/DerivedCategory/Basic.lean:87`); `HasDerivedCategory.standard`; `Ext`;
  K-injective/projective resolutions; derived functors (`CategoryTheory/Functor/Derived/`) [R].
- `structure TStructure` with `IsLE`, `IsGE`, `minus`, `plus`, `bounded`
  (`Triangulated/TStructure/Basic.lean:54,159,164,256–262`), `heart` (`Heart.lean:44`),
  truncations, t-exact functors [R].
- **The heart is not yet proved abelian.** `TStructure/Basic.lean` keeps the TODO "show that the
  heart of `t` is an abelian category", and no declaration in `Triangulated/` or
  `Algebra/Homology/` gives that instance [R grep 2026-11-08]. The criterion it would use is
  there: `TStructure/AbelianSubcategory.lean` (BBD 1.2) [R].
- The canonical t-structure: `DerivedCategory.TStructure.t`, with `DerivedCategory.Plus`/`Minus`
  (`DerivedCategory/TStructure.lean:33,198,201`) [R]. (The TODO in `TStructure/Basic.lean`
  saying this is still to do is out of date [R both files].)
- `TStructure.plus X := ∃ n, t.IsGE X n` is, in the cohomological convention, "eventually
  coconnective" [R definition; J that it matches GLC I's `(-)^{>-∞}`].
- Monoidal localisation (`CategoryTheory/Localization/Monoidal/`) [R file list].
- **Missing:** compact objects in triangulated categories, compactly generated triangulated
  categories, Brown representability, ind-completion of triangulated categories [R grep]. No
  file in `Triangulated/` mentions coproducts (`HasCoproducts`), and there is no bundled type of
  (pre)triangulated categories [R grep 2026-11-08].

### 2.9 ∞-categories — **foundations only**

- `class SSet.Quasicategory` (`AlgebraicTopology/Quasicategory/Basic.lean:41`), with a TODO
  "Generalize the definition to higher universes" [R]; inner fibrations, nerve of a category is
  a quasicategory, the strict bicategory `QCat.strictBicategory` (Riehl–Verity) [R].
- `KanComplex` (`SimplicialSet/KanComplex.lean:40`), homotopy category `SSet.hoFunctor` with the
  nerve adjunction, model categories (`AlgebraicTopology/ModelCategory/`) [R].
- `SimplicialNerve` of a simplicial category, whose listed "Projects" include proving it is a
  quasicategory and defining "the quasicategory of anima" [R].
- Open PR #44257 (characterising quasicategories by internal homs) [R title].
- **Missing:** ∞-functor categories, ∞-limits/colimits, stable ∞-categories, spectra,
  presentable ∞-categories, `DGCat`, Lurie tensor product [R grep for `Stable`, `Spectra`].
  Also no DG categories in Mathlib [R grep for `DGCategory`, `DG categor`].
- The nearest DG structure is concrete: `CochainComplex.HomComplex F G`, the cochain complex of
  maps between two cochain complexes, used for the homotopy category and mapping cones
  (`Algebra/Homology/HomotopyCategory/HomComplex.lean`), and general enriched categories
  (`CategoryTheory/Enriched/`) [R 2026-11-08]. Neither is a theory of DG categories [J].

### 2.10 Presentable categories, Ind, monoidal actions (1-categorical) — **present**

- `IsCardinalLocallyPresentable`, `IsLocallyPresentable`, `IsAccessibleCategory`
  (`CategoryTheory/Presentable/LocallyPresentable.lean:41,80,87`) [R].
- `IsFinitelyPresentable X` (= ℵ₀-presentable, the 1-categorical "compact")
  (`Presentable/Finite.lean:49`) [R]. It is about filtered colimits in a 1-category; it is not
  the compactness of an object of a stable ∞-category (§3.4) [J].
- `Ind C`, `IsIndObject` (`CategoryTheory/Limits/Indization/`) [R].
- Monoidal actions and linear functors: `Functor.LaxLeftLinear`, `OplaxLeftLinear`,
  `LeftLinear` with the iso `μₗIso` (`CategoryTheory/Monoidal/Action/LinearFunctor.lean:48,101,156,178`)
  [R]. This is the 1-categorical analogue of Foundations' `LinFun` [J].
- `Linear` categories and functors (`CategoryTheory/Linear/`), Day convolution [R].

### 2.11 D-modules, local systems, perverse sheaves — **missing**

- D-modules / differential operators / Weyl algebra: no file mentions them [R grep].
- Local systems: no `LocalSystem`, no algebraic flat connections, no de Rham local systems
  [R grep]. Mathlib's manifold connections are differential-geometric and unrelated [J].
- Perverse sheaves and constructible sheaves: missing; `Topology/Constructible.lean` is about
  constructible *sets* [R].
- Also missing [R grep]: affine Grassmannian, loop groups, jet/arc spaces, formal schemes,
  ind-schemes, Hecke/Satake/Whittaker in the geometric sense. `RingTheory/Grassmannian.lean`
  gives `Module.Grassmannian` and its functor of points only.

### 2.12 Summary table

| GLC object | Mathlib (pinned) | Status |
|---|---|---|
| schemes, smooth, proper, connected | `Scheme`, `Smooth`, `SmoothOfRelativeDimension`, `IsProper` | present |
| smooth proper curve | written as hypotheses; `IsWeilDivisor` | partial (no genus, Riemann–Roch, Serre duality) |
| group schemes | `GrpObj` in `Over (Spec R)`, `hopfSpec` | partial |
| reductive group, pinning | — | missing (Tau Ceti) |
| root datum, its dual | `RootDatum`, `RootPairing.flip`, `RootPairing.Equiv` | present |
| root datum of `G` | — | missing (also in Tau Ceti, except specific groups) |
| Lie algebras | large theory, Serre construction | present |
| affine Kac–Moody `ĝ_κ` | polynomial loop algebra, 2-cocycle, `Extension.ofTwoCocycle` | partial (no `g((t))`, no named `ĝ_κ`) |
| line bundles, `ω_X` | ring-level `Module.Invertible`, `Ω[S⁄R]`, presheaf `relativeDifferentials'` | missing on schemes (Tau Ceti; Mathlib PRs open) |
| sheaves on sites, sheaves of modules | `Sheaf`, `SheafOfModules`, `X.Modules` | present |
| quasi-coherent | `IsQuasicoherent`, `tilde` | partial |
| stacks, fibrations | `IsFibered`, `Pseudofunctor.IsStack` | 2-categorical base only; algebraic stacks missing |
| derived / triangulated / t-structures | `DerivedCategory`, `TStructure`, `heart`, `plus` | present (1-categorical; heart not yet proved abelian; no triangulated compactness) |
| ∞-categories | `Quasicategory`, `KanComplex`, `QCat.strictBicategory` | foundations only |
| stable / presentable / DG ∞-categories | 1-categorical `IsLocallyPresentable` only | missing |
| `QCoh` / `IndCoh` (∞-sense) | — | missing |
| D-modules, local systems, perverse sheaves | — | missing |

## 3. What it means for GLCinLean

1. **Mathlib first, but the GLC categories are not there** (ideas.md point 3). Every category in
   the conjecture (`Dmod_{1/2}(Bun_G)`, `QCoh(LS_Ǧ)`, `IndCoh_Nilp(LS_Ǧ)`) needs presentable
   stable ∞-categories and algebraic stacks. Mathlib has neither [R §2.7, §2.9], and on master
   they are not close [J from the open-PR search]. So the `DGCat` placeholder family in
   `Foundations.lean` stands for a real gap, not a failure to look [J].
2. **The standing data is almost all Mathlib or Tau Ceti.** The `Setting` structure uses Mathlib
   for the curve and Tau Ceti for `G`, the pinning, `ω_X` and its square root [R
   Abstract/Foundations]. That fits the source order. Step 3 (build) and step 5 (refactor) should
   watch #44200 (Picard group), #41228 (differentials), #40831/#40194 (locally free) and #39989:
   if they land, "avoid duplication" and "continuously refactor to adopt their decisions" (Xena
   principles in ideas.md) mean moving `LineBundle` and `canonicalSheaf` to Mathlib's versions,
   or making sure Tau Ceti does [J].
3. **`RootDatumDuality` can say more than an opaque type** (workflow.md step 2, "decide whether
   … placeholders stay or change"). Mathlib has `RootDatum`, `RootPairing.flip` and
   `RootPairing.Equiv` [R]. Only "the root datum of a reductive group with a pinning" is missing.
   Making that the single placeholder (a function to a `RootDatum`) and *defining* the duality as
   a `RootPairing.Equiv` between `Ǧ`'s root datum and the `flip` of `G`'s would shrink the
   trusted surface and tie the statement to Mathlib's definitions [J]. Caveats:
   - Mathlib's `RootDatum` does not require finite generation; its docstring says to add
     `[Module.Finite ℤ X₁] [Module.Finite ℤ X₂]` [R docstring]. For the root datum of a
     reductive group these would be facts to prove about the placeholder's value, so they should
     come with it (for example as fields of the bundled value) [J].
   - The root datum depends on a split maximal torus; it is canonical only up to isomorphism.
     `Setting` has a torus for `G` (through the pinning) but none for `Ǧ`. So the placeholder
     should either take a torus or be stated so that only its isomorphism class matters, which
     an existence statement `Nonempty (RootPairing.Equiv …)` does [J].
   - A bundled value would live in `RootPairingCat ℤ` [R structure; J choice]. The gap is in
     Tau Ceti too (§2.3), so the placeholder would stay in `Foundations.lean` until a provider
     defines it.
4. **`DGCat.IsEventuallyCoconnective` has a 1-categorical Mathlib model; `DGCat.IsCompact` only
   half of one (corrected).** For a stable ∞-category, a t-structure *is* a t-structure on its
   triangulated homotopy category (Lurie, *Higher Algebra*, Def. 1.2.1.4), and an object of a
   stable ∞-category with small coproducts is compact exactly when it is compact in the
   triangulated sense: `Hom(X, -)` on the homotopy category commutes with arbitrary coproducts
   (Higher Algebra, Prop. 1.4.4.1) [J recalled, not checked in the source today]. So:
   - eventual coconnectivity could be *defined* as `TStructure.plus` on the homotopy category
     [R `plus`; J that it matches GLC I's `(-)^{>-∞}` in the cohomological convention];
   - compactness could not be defined with Mathlib's `IsFinitelyPresentable`: the homotopy
     category of a presentable stable ∞-category has coproducts but in general not filtered
     colimits, and finite presentability there is not the right notion [J]. The triangulated
     notion is missing from Mathlib (§2.8) and would be a short new definition (here or in Tau
     Ceti) [J].
   The interface would be a placeholder map `DGCat →` (pretriangulated category with
   coproducts) plus a placeholder `TStructure` per category, since a DG category has no
   canonical t-structure [J]. Mathlib has no bundled type of pretriangulated categories (§2.8),
   so that bundle would itself be new. Whether the formal statement should take this route is a
   step 2 design decision.
5. **`LinFun` has a 1-categorical template.** `Functor.LeftLinear C` with `μₗIso`
   (`Monoidal/Action/LinearFunctor.lean`) is Mathlib's notion of a functor compatible with a
   monoidal action [R]. When the enhanced theory is built, its API names should follow these
   (Mathlib's naming conventions, ideas.md point 2) [J].
6. **The "library for geometric representation theory" (ideas.md point 1) is greenfield in
   Mathlib.** D-modules, differential operators, local systems and perverse sheaves are all
   missing [R]. The base exists: `SheafOfModules` allows a sheaf of *noncommutative* rings
   [R definition], so an abelian category of `D_X`-modules can be built once `D_X` is defined [J].
   The general notions of t-structure and heart exist, so a perverse t-structure could be stated
   [R], but the heart is not yet proved abelian (§2.8) and constructible sheaves do not exist [R].
   These are natural first library targets, in this repository or in a Tau Ceti roadmap
   (ideas.md point 4) [J].
7. **The pin is current.** The pin is 6 days and 150 commits behind master, and no relevant new
   file has appeared since [R]. The decision "keeping up with Mathlib … is fully automated" has
   nothing urgent to absorb here [J].

## 4. Conflicts

- **`TStructure/Basic.lean` vs. `DerivedCategory/TStructure.lean`.** The first says the
  canonical t-structure on `D(C)` is TODO; the second defines it [R both]. This is Mathlib-internal
  and harmless, but agents should trust the declaration, not the TODO [J].
- **Foundations/Abstract comments vs. Mathlib.** `Foundations.lean` calls `DGCat`, `IsCompact` and
  `IsEventuallyCoconnective` "provider-less". That is true for the ∞-categorical objects [R].
  But eventual coconnectivity has a Mathlib 1-categorical counterpart and compactness half of one
  (§3.4). The `RootDatumDuality` placeholder is in `Abstract.lean` (l.37–42), not in
  `Foundations.lean`, which contradicts the Foundations header's rule that every substantial
  object reaches the abstract through Foundations [R both files; J reading]. Its docstring ("No
  library defines the root datum of a general reductive group yet") is accurate for Mathlib and
  for pinned Tau Ceti [R grep], but the placeholder does not use Mathlib's existing
  `flip`/`Equiv` (§3.3) [J]. Not a contradiction of the owner's ideas, but the placeholders are
  coarser than Mathlib allows.
- **Possible future duplication.** Foundations re-exports Tau Ceti's `InvertibleSheaf` and
  `relativeDifferentials`, while Mathlib PRs #44200 and #41228 build the same notions [R titles].
  If both land, the "avoid duplication" principle (ideas.md) will need a choice [J].
- No conflict found with the decisions in `workflow.md`.

## 5. Input for the open questions

- **"Whether `Abstract.lean`, `Foundations.lean` and their placeholder design are reasonable,
  or need to change."** This source suggests the design is reasonable in outline [J]. The
  ∞-categorical objects (`DGCat`, `DGCat.Obj`, `LinFun`, `LinIso`, the five `𝕃_G`-chain objects)
  have no Mathlib provider [R §2.9, §2.11], and the opaque/`NonemptyType` split matches AGENTS.md.
  Three refinements are suggested, each moving content from opaque constants to Mathlib
  definitions:
  1. `RootDatumDuality` → a placeholder "root datum of `G`" in `RootDatum`, plus the duality
     *defined* with `RootPairing.flip` and `RootPairing.Equiv` (§3.3).
  2. `IsEventuallyCoconnective` → defined through an opaque homotopy-category map into
     Mathlib's pretriangulated categories with a `TStructure` (§3.4). `IsCompact` could follow
     only after a triangulated compactness predicate is written, since Mathlib has none (§3.4).
  3. Keep `LinFun` names aligned with `Functor.LeftLinear` (§3.5).
  The cost: each refinement adds interface that may need to change once the enhanced theory
  exists [J].
- **"What happens to each existing file."** Nothing here bears on ReviewKit, `glc/project.toml`,
  `reviews/` or the manifest. It does bear on `Foundations.lean`: its Tau Ceti re-exports
  (`LineBundle`, `canonicalSheaf`) should be revisited when the Mathlib PRs above land [J].
- **"Who reviews the mathematics."** Several placeholder judgements here rest on standard but
  unchecked facts, for example that compactness and t-structures of a stable ∞-category are
  detected on the homotopy category. These are [J], and an expert or a sourced citation should
  confirm them before the statement relies on them [J].

## 6. Questions for the owner

1. Should the formal statement keep the ∞-categorical placeholders fully opaque, or expose a map
   to Mathlib's triangulated categories so that eventual coconnectivity (and, after a new
   triangulated compactness definition, compactness) become definitions (§3.4)? More Mathlib,
   but a larger provisional interface, and the mathematical identifications behind it are [J]
   until an expert or a checked citation confirms them.
2. Should `RootDatumDuality` be replaced by a placeholder root datum plus a duality defined with
   Mathlib's `RootPairing.flip` and `RootPairing.Equiv` (§3.3)? And should that placeholder
   move from `Abstract.lean` to `Foundations.lean`, as the Foundations header asks for every
   substantial object (§4)?
3. Mathlib PRs #44200 (Picard group) and #41228 (differentials) would duplicate what Foundations
   takes from Tau Ceti. When they land, switch to Mathlib's versions, or leave that to Tau Ceti's
   own refactoring?
4. Mathlib has nothing on D-modules, local systems or perverse sheaves. Should the
   geometric-representation-theory library start with the 1-categorical abelian layer, which
   Mathlib's `SheafOfModules` and `TStructure` support now, or wait for an ∞-categorical base?
