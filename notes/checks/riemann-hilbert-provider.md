# The provider of the regular Riemann–Hilbert correspondence and of the constructible categories

Branch `proposal/riemann-hilbert-provider`, on `main` at `8cde2a3`. Steps 1 and 2 of `prompts/change.md` for finding B1 of the audit of 2026-11-25. Sections 1 to 3 state the problem and its evidence. Section 4 states the options. Sections 5 to 7 state the choice, the change on the branch and the points of doubt. The reports of round 1 are `riemann-hilbert-provider-checker-1.md` and `riemann-hilbert-provider-codex-1.md`, and `riemann-hilbert-provider-answers-1.md` answers them. The report of round 2 is `riemann-hilbert-provider-codex-2.md`, and `riemann-hilbert-provider-answers-2.md` answers it; the report of round 3 is `riemann-hilbert-provider-codex-3.md`, and `riemann-hilbert-provider-answers-3.md` answers it; the report of round 4 is `riemann-hilbert-provider-codex-4.md`, and `riemann-hilbert-provider-answers-4.md` answers it. Sections 6 and 7 describe the branch with these answers applied.

## 1. The problem

The roadmap MixedHodgeModulesAndIrregularHodgeTheory merged into TauCetiRoadmap on 2026-11-21 (#2279). Its Layer 1 states three objects of the plan as targets, over ℂ: the constructible derived category with the six operations (§1.2), the perverse sheaves (§1.3) and the regular Riemann–Hilbert correspondence on smooth varieties (§1.5).

`AGENTS.md`, "Sources of code", says: "Parts covered by a Tau Ceti roadmap go to Tau Ceti … The roadmap owns these parts, so a second copy here would compete with it. Everything else is written here."

Before this change the plan had these providers:

| Node | Folder | Provider text of the node |
|---|---|---|
| `Constructible.DerivedCategory` | `plans/Roadmap/EtaleDualityAndPerverseSheaves/` | "as a prerequisite of two targets and not a named target" (§3.5 and §5.9 of that roadmap) |
| `Constructible.PerverseSheaves` | the same | "as a prerequisite of two targets and not a named target" |
| `Constructible.StratifiedDerivedCategory` | the same | "as a prerequisite and not a named target"; SpringerResolutionAndCharacteristicCycles §11.3 needs it |
| `DModules.analyticDeRham` | `plans/GLCinLean/AlgebraicGeometry/DModules/` | "Provider: here" |
| `DModules.analyticDeRham_isEquivalence` | the same | "Provider: here" |

So two questions are open. Does the smooth case of the two D-module nodes go to Tau Ceti, and what stays here? Do the constructible nodes belong to the area that states them as targets?

## 2. The sources

- TauCetiRoadmap at `b24abdf7`: `TauCetiRoadmap/MixedHodgeModulesAndIrregularHodgeTheory/README.md` (Summary, "Conventions", Layer 1, the list "It leaves to named owners", and the sections "From TauCetiRoadmap.…"); `EtaleDualityAndPerverseSheaves/README.md` §§3.5, 5.9, 5.10; `SpringerResolutionAndCharacteristicCycles/README.md` §§9.1, 9.7, 11.3 and its section on scope; `ComplexComparisonPartII/README.md` §C−1.1 and C5.6; `EnhancedDerivedSheaves/README.md` §0.1.
- The plan at `8cde2a3`: the five nodes above; their users `Satake.icSheaf_restriction_isParity`, `Satake.ic_starRestriction_isEven`, `AffineGrassmannian.isEven_bottSamelsonPushforward`, `Constructible.IsStratifiedMap`, `Constructible.isGood_orbitStratification`, `Constructible.exists_iso_directSum_ic_properPushforward`, and in `plans-proof/` `Satake.regularSheafExt_complexComparison`; the D-module nodes `DModules.rightCrystals_equiv_dModules`, `DModules.IsRegularHolonomic`, `DModules.deRhamPushforward`, `DModules.verdierDuality`, `DModules.starPullback`, `DModules.transferModule`, `DModules.regularHolonomicDModule`.
- `STATUS.md` at `8cde2a3`: "Open items" ("The de Rham comparison on singular schemes", "The de Rham functor of SpringerResolutionAndCharacteristicCycles §11.3", "The operations of `Constructible.DerivedCategory` as operations on sheaves", "Findings of the audit of 2026-11-25 that are not applied"); "Decisions taken" ("The decomposition theorem", "D-modules on smooth schemes: Tau Ceti provides the classical theory").
- `docs/blueprint-providers.md`; the report of the audit, `git show f5bfe9a:notes/audit-2026-11-25.md` (finding B1, question 3).
- The pinned Tau Ceti source (`553f7926`), searched for "analytification", `ComplexAnalyticSpace`, "perverse", "Riemann–Hilbert", "regular singular", "holonomic". It has no analytification of a scheme, no constructible derived category, no perverse sheaf and no de Rham functor of D-modules.
- The book [HottaTakeuchiTanisaki] is the `source` of the nodes and is not in `references/`. Its English edition was read for the numbers that `docs/papers.md` lists (Theorems 4.6.3, 4.6.6, 4.7.7, 6.1.5, 7.1.1, 7.2.2 and 7.2.5, Corollary 4.6.5, Proposition 4.7.8, Remark 7.2.3). The roadmap cites Dimca, *Sheaves in Topology*, and Kashiwara, *The Riemann–Hilbert problem for holonomic systems*; neither is in `docs/references.bib`, and neither was read.

## 3. The evidence: the passages of the roadmap, clause by clause

### 3.1 The conventions of the roadmap

"**Varieties.** Varieties are separated schemes of finite type over `ℂ`; maps are algebraic. … Analytification `X ↦ X^an` is ComplexComparisonPartII's `complexSchemeAnalytification`."

"**Degrees.** For `X` smooth of pure dimension `d`, the unshifted de Rham complex `DR(M)` of a left `D_X`-module has terms in degrees `0, …, d`, and `pDR(M) = DR(M)[d]`."

Layer 1: "On analytifications of complex algebraic varieties, this layer constructs bounded algebraically constructible complexes with rational and complex coefficients, the six operations, the middle perverse `t`-structure, nearby and vanishing cycles, and the regular Riemann–Hilbert correspondence normalized by `pDR(M) = DR(M)[dim X]`."

### 3.2 §1.2 and `Constructible.DerivedCategory`

The target: "For a separated complex variety `X` and `Λ ∈ {ℚ, ℂ}`, let `D^b_c(X, Λ)` be the full subcategory of the derived category of sheaves of `Λ`-modules on `X^an` (EnhancedDerivedSheaves §0.1) of complexes with bounded cohomology whose cohomology sheaves have finite-dimensional stalks and are locally constant on the strata of some finite algebraic stratification. Construct, for algebraic maps, `f^*`, `Rf_*`, `Rf_!`, `f^!`, derived tensor product, internal Hom, external product and Verdier duality `D_X = RHom(−, f^! Λ)` for `f : X → pt`, with the adjunctions, composition, proper base change, the projection formula and the two localization triangles of an open–closed decomposition."

Its route: "the operations come from EnhancedDerivedSheaves §§0.1–0.4 and §E1.4 on the topological carriers of ComplexComparisonPartII §C-1.1; `Rf_!` uses the compact-support theory of ComplexComparisonPartII §C6.1 after factoring `f` as an open immersion followed by a proper map (a dense compactification, EtaleCohomologyFoundations §§G.1–G.2), and `f^!` is its right adjoint; constructibility of `Rf_*` and `Rf_!` follows from 1.1 by stratified local triviality".

| Clause of the node | The target | Result |
|---|---|---|
| A separated scheme `Y` of finite type over ℂ | "separated complex variety", which the conventions define as a separated scheme of finite type over ℂ | the same |
| The space `Y(ℂ)` of `Constructible.ComplexPoints` | `X^an`, the analytification of ComplexComparisonPartII; its §C−1.1 says "The underlying space of `X^an` is the set of complex points of `X`" | the same space |
| A coefficient field `E` | `Λ ∈ {ℚ, ℂ}` | the node asks for more |
| Bounded complexes, cohomology sheaves constructible for an algebraic stratification, stalks of finite rank | "bounded cohomology", "finite-dimensional stalks", "locally constant on the strata of some finite algebraic stratification" | the same |
| An ordinary triangulated category | a full subcategory of "the derived category of sheaves of `Λ`-modules on `X^an` (EnhancedDerivedSheaves §0.1)"; §0.1 provides the enhanced category "with its homotopy category identified with Mathlib's `DerivedCategory`" | the same, on the homotopy category |
| (1) `f^*`, `Rf_*`, `Rf_!`, `f^!`, the adjunctions, `Rf_! ≅ Rf_*` for a proper `f` | the four functors "with the adjunctions"; `Rf_!` is defined through an open immersion and a proper map | the same |
| (2) tensor product and internal Hom | "derived tensor product, internal Hom" | the same |
| (3) `𝔻 = RHom(−, a^!E)`, the external product | "Verdier duality `D_X = RHom(−, f^! Λ)` for `f : X → pt`", "external product" | the same |
| (3) `𝔻𝔻 ≅ id`, and `𝔻` exchanges `f^*` with `f^!` and `Rf_*` with `Rf_!` | not a clause. The route cites Dimca for Verdier duality; §1.3 uses "self-duality under `D_X`" | the node asks for more |
| (4) base change for `Rf_!` along every map | "proper base change"; interface: "For `f` proper and any algebraic base change `g`, the base-change map `g^* Rf_* → Rf′_* g′^*` is an isomorphism" | the same, through the factorization of `f` |
| (5) the projection formula | "the projection formula" | the same |
| (6) Hom by derived global sections of `RHom` | not a clause | the node asks for more |
| (7) `g^! ≅ g^*[2d]` for a smooth map of relative dimension `d`; smooth base change for `Rf_*` | only the check "For `X` smooth of dimension `d`, `D_X(ℚ_X[d]) = ℚ_X[d]`", the case of the map to the point | the node asks for more |
| The triangles of a closed subscheme and its open complement (not a numbered clause before this change; the nodes of the plan use them) | "the two localization triangles of an open–closed decomposition", functorial in `K` | the target states it |
| That the operations are the operations on sheaves (`STATUS.md`, open item "The operations of `Constructible.DerivedCategory` as operations on sheaves") | the route quoted above | the target states it |

### 3.3 §1.3 and `Constructible.PerverseSheaves`

The target: "For an algebraic Whitney stratification with strata `S` of complex dimension `s`, the middle perverse `t`-structure on `D^b_c(X, Λ)` has `pD^{≤0}` given by `H^j(i_S^* K) = 0` for `j > −s` and `pD^{≥0}` by `H^j(i_S^! K) = 0` for `j < −s`. Prove independence of the adapted stratification, boundedness, nondegeneracy and self-duality under `D_X`; the heart `Perv(X, Λ)` is abelian of finite length. Construct perverse cohomology `pH^j` and intermediate extension `j_!* L = im(pH⁰ j_! L → pH⁰ Rj_* L)` for a locally closed immersion `j`. For a local system `L` on a smooth `d`-fold, `L[d]` is perverse". Interface: "`j_!* L` is the unique extension of `L` with no nonzero subobject or quotient supported on the boundary."

| Clause of the node | The target | Result |
|---|---|---|
| The part `≤ 0` by the dimension of the supports, the part `≥ 0` by duality; then the two conditions on strata | the two conditions on the strata of an adapted Whitney stratification; independence of the stratification | one t-structure, two definitions. On a smooth stratum of dimension `s`, duality carries cohomology in degree `j` to the dual of the cohomology in degree `−j − 2s`, so the condition on `i^!K` is the condition on `i^*` of the dual |
| Finite length of the heart, `pH^i`, `j_!*` as the image of `pH⁰(j_!P) → pH⁰(Rj_*P)` | the same words | the same |
| `IC(Z, L) = j_!*(L[dim U])` | not named | a name for an object of the target |
| The simple perverse sheaves are the `IC(Z, L)` with `L` irreducible | not a clause | the node asks for more |
| Checks on a point and for `L[d]` | "`Perv(pt, ℚ)` is the category of finite-dimensional `ℚ`-vector spaces in degree `0`"; "`L[d]` is perverse" | the same |
| A coefficient field `E` | `Λ ∈ {ℚ, ℂ}` | the node asks for more |

### 3.4 The roadmap on the owner of the two categories

The list "It leaves to named owners" of the new roadmap says: "EtaleDualityAndPerverseSheaves §3.5 (`complexAnalyticComparison`) compares étale complexes with finite and `ℓ`-adic coefficients with algebraically constructible complexes on `X^an`, and its §5.9 works in `D^b_c(X(ℂ), ℂ)` with its operations and perverse heart; it constructs neither the rational nor the complex category. Layer 1 constructs both, for `Λ ∈ {ℚ, ℂ}`, in the derived category of `Λ`-module sheaves on `T_X` (EnhancedDerivedSheaves §0.1) with the same stalk and costalk conditions on strata, so that the complex category and heart of that §5.9 are those of 1.2 and 1.3."

The text of EtaleDualityAndPerverseSheaves does not name the new roadmap (`grep MixedHodge` finds nothing in its README). Its §5.10 states the decomposition theorem for `K ∈ D^b_c(X(ℂ), ℂ)`, and its §3.5 says "Realize `D^b_c` in the unbounded coefficient category appropriate to its regime and the analytic `D^b_c` in the native derived category of analytic module sheaves". No section of it is a target for the construction of the category with coefficients ℂ, of its six operations or of its perverse t-structure.

### 3.5 `Constructible.StratifiedDerivedCategory`

No accepted roadmap names the category `D^b_S` of a fixed stratification, goodness of a stratification, or the induced t-structure. Three passages are near it. §1.3 of the new roadmap defines the perverse t-structure by conditions on the strata of "an algebraic Whitney stratification" and names the route "glue the support and cosupport truncations over strata by recollement (1.2)". Its §1.1 states Whitney stratifications of an algebraic map with local triviality over the strata. SpringerResolutionAndCharacteristicCycles §11.3 has a functor to the "complexes on F(C) constructible along the Schubert cells". EtaleDualityAndPerverseSheaves §5.9 defines restricted categories `D^b_{T,L}` for étale ℓ-adic coefficients with a condition on constituents.

### 3.6 §1.5 and the two D-module nodes

The target: "**Theorem.** For `X` a smooth complex variety of dimension `d`, analytification followed by `pDR(M) = DR(M)[d]` is an equivalence from algebraic regular holonomic left `D_X`-modules to `Perv(X, ℂ)`, and from the bounded derived category with regular holonomic cohomology to `D^b_c(X, ℂ)`. It is exact, fully faithful, and compatible with `f_+` and `Rf_*`, `f_!` and `Rf_!`, `f^†` and `f^!` up to the normalizing shifts, holonomic duality and Verdier duality, and external product. Regularity includes regularity at the boundary of an algebraic compactification. The inverse is the regular holonomic realization; it is not the space of analytic solutions of an irregular connection". Its needs: "1.2, 1.3; SpringerResolutionAndCharacteristicCycles §§9.1, 9.2, 9.4, 9.7 and gap:regular-holonomic-stability; ResolutionOfSingularitiesCharacteristicZero §§5.1, 5.2; ComplexComparisonPartII §C5.6 (`deligneRiemannHilbert`, `CanonicalLogExtension`)." Its checks: "`pDR(O_X) = ℂ_X[d]`"; "For `δ_0 = D/Dx` on `A¹`, `pDR(δ_0)` is the skyscraper `ℂ` at the origin in degree `0`".

The nodes before this change. `DModules.analyticDeRham`: "For a separated scheme Y of finite type over C, analytification of algebraic D-modules on Y to analytic D-modules on Y(C), and the normalized analytic de Rham functor DR. It carries bounded holonomic complexes to D^b_c(Y, C) …, commutes with holonomic duality … and Verdier duality, and takes holonomic modules to perverse sheaves …", with a clause on the complexes that are lisse along a stratification. `DModules.analyticDeRham_isEquivalence`: "Over k = C, for a separated scheme Y of finite type: the de Rham functor … is an equivalence from the bounded regular holonomic complexes on Y to D^b_c(Y, C) …, which commutes with proper pushforward, with *- and !-pullback along all maps, with external products and with Verdier duality …", with the restriction to a good stratification.

| Point | The nodes | The target | Result |
|---|---|---|---|
| Base field | ℂ | ℂ | the same |
| Schemes | every separated scheme of finite type, singular ones too | smooth varieties "of dimension `d`"; the D-modules of its supplier are on smooth schemes of pure dimension | the target is the smooth case |
| D-modules | right crystals, with `DModules.rightCrystals_equiv_dModules` to right `D_X`-modules on a smooth `X` | left `D_X`-modules with quasi-coherent underlying module (SpringerResolutionAndCharacteristicCycles §8.1) | they differ by the equivalence with crystals and the side change, which are written here |
| Direction of the functor | covariant de Rham functor | covariant `pDR`; "it is not the space of analytic solutions" | the same |
| Normalisation | "normalized", holonomic modules go to perverse sheaves | `pDR(M) = DR(M)[d]`, t-exact to `Perv` | the same |
| Which complexes the functor takes into `D^b_c` | all bounded holonomic complexes (`analyticDeRham`); the equivalence for regular ones | the regular holonomic complexes only | the node asks for more: the constructibility of the de Rham complex of a holonomic module that is not regular |
| Categories | ordinary triangulated categories | "the bounded derived category with regular holonomic cohomology", `D^b_c(X, ℂ)` | the same |
| Compatibilities | proper pushforward, `*`- and `!`-pullback along all maps, external products, duality | `f_+` and `Rf_*`, `f_!` and `Rf_!`, `f^†` and `f^!`, the dualities, the external product, for maps of smooth varieties | the target has them for smooth schemes; it has `Rf_*` for every map, not only proper ones |
| A fixed stratification, goodness, t-exactness on `D^b_S`, intermediate extensions | stated | not stated; SpringerResolutionAndCharacteristicCycles §11.3 has the case of strongly `B`-equivariant modules on a finite flag variety | stays outside the target |
| Analytification | "analytification of algebraic D-modules on Y to analytic D-modules on Y(C)", written here | "analytification followed by `pDR`", inside the target, on `complexSchemeAnalytification` | the target covers it |

Two readings of the target are needed. "of dimension `d`" is read as pure dimension `d`: the convention says "smooth of pure dimension `d`", and the D-modules of SpringerResolutionAndCharacteristicCycles §§8–9 are on schemes of pure dimension. "up to the normalizing shifts" is read with `f^† = Lf^*[dim X − dim X′]` (§9.1; `DModules.transferModule` (2)) and the shift of `pDR`: then `pDR ∘ f^† ≅ f^! ∘ pDR` has no further shift. Test for the inclusion `i` of the origin in the affine line: `i^†δ_0` is `ℂ` in degree 0 (the check of `DModules.transferModule`), `pDR(δ_0)` is the skyscraper sheaf in degree 0 (the check of the target), and `i^!` of the skyscraper sheaf is `ℂ` in degree 0.

The stability of regular holonomic complexes under `f_+`, `f_!` and a general `f^†`, which the compatibilities presuppose, is not a target of any roadmap. The new roadmap requests it: "What SpringerResolutionAndCharacteristicCycles must provide (gap:regular-holonomic-stability): stability of the bounded derived category with regular holonomic cohomology under `f_+`, `f_!`, arbitrary `f^†`, external product and restriction to the diagonal, for algebraic maps of smooth complex varieties." The text of SpringerResolutionAndCharacteristicCycles does not state it and says: "the general regular holonomic Riemann–Hilbert correspondence on arbitrary smooth varieties is not part of this roadmap".

### 3.7 What the plan uses

- `Satake.ic_starRestriction_isEven` (the statement's plan) is over every algebraically closed field `k` of characteristic zero. It uses `DModules.analyticDeRham_isEquivalence` over ℂ only: "G and its Schubert geometry are base changes of their split models over Q̄, restriction to strata commutes with scalar extension (DModules.scalarExtension …), and over C DModules.analyticDeRham_isEquivalence carries *-restriction to strata to the constructible one. Only Q̄ ⊂ k and Q̄ ⊂ C are used." So a target over ℂ serves the statement over `k`; the passage between the fields is written here.
- Its schemes are the closures of the strata `Gr^λ`, which are singular and projective (`AffineGrassmannian.schubertStratification`: "finite-dimensional projective closures"). `DModules.analyticDeRham_isEquivalence` says: "The finite unions of Schubert varieties in Gr_G with their Schubert stratification are the instance used."
- `Satake.regularSheafExt_complexComparison` (`plans-proof/`) applies the theorem "on each finite stage".
- No node uses `DModules.analyticDeRham` except `DModules.analyticDeRham_isEquivalence`. No node uses the de Rham functor on a holonomic complex that is not regular.
- The coefficient field: the decomposition theorem, the de Rham comparison and `Satake.icSheaf_restriction_isParity` use ℂ. `Constructible.IsStratifiedMap`, `Constructible.isGood_orbitStratification` and `AffineGrassmannian.isGood_schubertStratification` are stated "for every coefficient field E".
- `STATUS.md`, open item "The de Rham comparison on singular schemes": the two nodes "do not yet say how the singular case is reached: closed embeddings into smooth varieties, Kashiwara's equivalence, gluing, and independence of the embedding … The planner settles the singular case of the two nodes with this D-module side, when the line of work reaches them."

### 3.8 A fact about the singular case

`D^b_c(Y, ℂ)` is used in the plan "as an ordinary triangulated category and never as an enhanced one" (`Constructible.DerivedCategory`), and §1.5 states its equivalence for "the bounded derived category with regular holonomic cohomology" and `D^b_c(X, ℂ)`, which are triangulated categories. The objects of a triangulated category of sheaves do not glue along an open cover: an object given on the opens of a cover with isomorphisms on the overlaps does not determine an object on the union. The crystals glue (`DModules.rightCrystals_hDescent`), because they form an enhanced category. So a de Rham functor that is built on affine charts through closed embeddings gives, on a scheme with no global embedding, a family of functors on the charts and no functor on the scheme. A scheme with a closed embedding `i : Y → X` into a smooth scheme needs no gluing: the functor is `ι^* ∘ DR_X ∘ i_*`, for the map `ι` of complex points. Every quasi-projective scheme has such an embedding (a closed subscheme of an open subscheme of a projective space), and so has every smooth separated scheme of finite type (embed each component `Y_a` in `Y_a × 𝔸^m` to reach one dimension).

## 4. The options

**For the two D-module nodes.**

- **D1. Move both nodes to the new area in full.** The two ids go to `plans/Roadmap/MixedHodgeModulesAndIrregularHodgeTheory/` with their present text. Against the rows of 3.6: the target has no singular scheme, no crystal and no fixed stratification, so the node would ask Tau Ceti for objects outside the target. It would also depend on `DModules.rightCrystals_equiv_dModules` and `DModules.IsRegularHolonomic`, which are written here, and `plans/README.md` says: "A node here may depend on a roadmap node, never the other way round."
- **D2. Move what the target states, keep the rest here.** One roadmap node for §1.5 as it is stated (left modules, smooth schemes). The two nodes stay here for the crystals on schemes that need not be smooth and for the restriction to a stratification, and they take the smooth case from the roadmap node. This is the form of the decision "D-modules on smooth schemes: Tau Ceti provides the classical theory" of 2026-11-19, where `DModules.regularHolonomicDModule` is the roadmap node and `DModules.IsRegularHolonomic` the node written here.
- **D3. Keep the provider here and record why the target does not serve.** The reason would be the rows "Schemes" and "D-modules" of 3.6. Against it: the smooth case with its analytification would be written here although an accepted target states it, and the nodes written here reduce to the smooth case in any proof.

Under D2 the nodes written here must say how the singular case is reached (3.7, last item). Three sub-options:

- **D2a.** The scope is the schemes with a closed embedding into a smooth scheme (3.8). It covers every use.
- **D2b.** The scope stays "every separated scheme of finite type", with gluing. By 3.8 this needs the enhanced form of `D^b_c` and of the functor, or the reconstruction of `D^b_c` from the perverse hearts; no accepted target states either, and no node uses the wider scope.
- **D2c.** The scope is the quasi-projective schemes. It covers every use too; it is a stronger hypothesis than D2a, and the construction uses only the embedding.

And for the functor on holonomic complexes that are not regular (row 6 of 3.6): keep the clause as a theorem written here, or drop it. No node uses it, and no accepted target states it.

**For the constructible nodes.**

- **C1. Leave the three under EtaleDualityAndPerverseSheaves**, as prerequisites of its §§3.5, 5.9 and 5.10. Against it: 3.2 to 3.4. The construction is a named target of another accepted roadmap, which says that the étale roadmap does not construct the category.
- **C2. Move `Constructible.DerivedCategory` and `Constructible.PerverseSheaves`** to the new area as named targets (§1.2, §1.3), and leave `Constructible.StratifiedDerivedCategory` under EtaleDualityAndPerverseSheaves.
- **C3. Move all three.** `Constructible.StratifiedDerivedCategory` stays a prerequisite and not a named target (3.5), in the area that constructs the category of which it is a full subcategory and the t-structure that it restricts.

In C2 and C3 the nodes ask for more than the targets (the rows "the node asks for more" of 3.2 and 3.3). Two ways: cut the nodes to the targets (coefficients ℚ and ℂ only, no (6), (7) only for the map to the point), or keep the parts with the rule of the decision "The decomposition theorem": "if Tau Ceti's review declines one …, it comes back through `prompts/change.md`".

The decomposition theorem (`Constructible.exists_iso_directSum_ic_properPushforward`) is not part of the question: its target is EtaleDualityAndPerverseSheaves §5.10, and the new roadmap does not state it (its §§4.4–4.5 are Saito's direct image theorem for Hodge modules).

## 5. The choice

**D2 with D2a, and C3.** The parts of the nodes beyond the targets are kept, with the rule that a declined part comes back.

Reasons for D2. The target covers exactly the smooth case of left modules, with the analytification; "Sources of code" sends that part to Tau Ceti. The rest (crystals, schemes that are not smooth, a fixed stratification) is in no target and depends on nodes written here, so it stays here. The split follows the decision of 2026-11-19 on D-modules and needs no new kind of node.

Reasons for D2a. The two nodes are lemmas of the proof of `Satake.ic_starRestriction_isEven`; the statement does not name them. `AGENTS.md`, "Lean code": "A lemma used in a proof may be weaker than the paper's, as long as it still proves what it is used for." The scope of D2a contains every use (projective schemes). The scope of D2b cannot be built from the accepted targets (3.8). D2a is the weakest hypothesis that the construction uses, so it is preferred to D2c.

Reason for dropping the clause on holonomic complexes that are not regular. It is a theorem with no user, and after D2 the functor of the roadmap node is specified on the regular holonomic complexes only. `AGENTS.md`: "no abstraction that nothing uses".

Reasons for C3. For the first two nodes: a named target passes Tau Ceti's review as a target, and a prerequisite can be declined (the decision "The decomposition theorem" records this risk); the new roadmap says that it constructs the category which the étale roadmap uses. For the third node: it is a full subcategory of the category of §1.2 with the t-structure of §1.3 restricted to it, and §1.3 builds its t-structure stratum by stratum on a Whitney stratification, so the area that writes §§1.1–1.3 has every input of the node. With C2 the node would sit in an area whose text constructs neither the category nor the t-structure.

Reasons for keeping the parts beyond the targets. Nodes of the plan use them: (7) in `Constructible.isGood_orbitStratification` and `AffineGrassmannian.isEven_bottSamelsonPushforward`, the classification of the simple objects in `Constructible.StratifiedDerivedCategory` and in the decomposition theorem. A general coefficient field is the natural generality (`AGENTS.md`, "Lean code"), and nothing in the construction uses the field. The rule for a declined part is already in force for these nodes.

## 6. The change on the branch

Plan nodes moved (ids unchanged, folder and provider changed), from `plans/Roadmap/EtaleDualityAndPerverseSheaves/` to `plans/Roadmap/MixedHodgeModulesAndIrregularHodgeTheory/`:

- `GLCinLean.Constructible.DerivedCategory` (`AnalyticConstructible.toml`). Provider: §1.2, a named target. The node quotes the target and compares it clause by clause; it lists (i) to (iv), the parts beyond the target. One clause is new, (8): the two triangles of a closed subscheme and its open complement, which the target states and the nodes of the plan use; with it, `i_*` is an equivalence onto the objects that vanish on the complement. Clause (1) now names the isomorphisms for composable maps, which the target states ("composition"). The sentence on the carrier quotes §1.2 and EnhancedDerivedSheaves §0.1, and the node depends on `Infinity.enhancedDerivedCategory` and `Infinity.derivedBimoduleTransfer`, from which the route of the target takes the carrier and the direct image. The other mathematical clauses and the checks are unchanged.
- `GLCinLean.Constructible.PerverseSheaves` (`AnalyticPerverse.toml`). Provider: §1.3, a named target, with the comparison of 3.3. The mathematical text is unchanged.
- `GLCinLean.Constructible.StratifiedDerivedCategory` (`AnalyticStratified.toml`). Provider: the new area, as a prerequisite and not a named target, with the passages of 3.5. The mathematical text is unchanged.

Plan node added:

- `GLCinLean.DModules.regularHolonomicDeRham` (`plans/Roadmap/MixedHodgeModulesAndIrregularHodgeTheory/RegularHolonomicDeRham.toml`), a roadmap node for §1.5: the functor `pDR` on the bounded complexes of left `D_X`-modules with regular holonomic cohomology, on a smooth separated scheme of finite type over ℂ of pure dimension, and its theorem (1) to (6). Clause (5) defines the external product of left D-modules. Clause (6) is beyond the target: on a vector bundle with a regular integrable connection `pDR` is the local system of horizontal sections, shifted, and every local system of finite rank arises so. It records the readings of the target, its limits and its inputs. It asks for one isomorphism for each map and for no compatibility with composition. It marks the stability of regular holonomic complexes as a part that the target presupposes and no roadmap states (`gap:regular-holonomic-stability`), with the rule that a declined part comes back, and with a condition on the order of work: the node is not taken up, and the stability theorem of `DModules.IsRegularHolonomic` is not written, before the provider of the stability for left modules on smooth complex schemes is decided.

Plan nodes changed, written here:

- `GLCinLean.DModules.analyticDeRham`. Scope: a separated scheme of finite type over ℂ with a closed embedding into a smooth separated scheme of finite type of pure dimension. The functor is on the bounded regular holonomic complexes of right crystals. The closed embedding is part of the data of the functor. The node gives the construction (the roadmap node on the smooth scheme, then the closed embedding) and five statements: the functors of two embeddings are isomorphic, by a named isomorphism; agreement on smooth schemes; t-exactness; compatibility with closed embeddings and open restrictions; compatibility with duality. It states no compatibility for three embeddings. Dropped: the values on holonomic complexes that are not regular. Moved to the next node: the clause on the complexes that are lisse along a stratification, because its proof uses the compatibility with `*`-pullback, which that node states.
- `GLCinLean.DModules.analyticDeRham_isEquivalence`. The same scope. The equivalence and its list of compatibilities are unchanged in content; the node now says how each follows from the roadmap node, and names the adjunction and the base change that give the !-pullback. The restriction to a stratification is unchanged, with the clause moved from the first node, and the converse on a stratum is clause (6) of the roadmap node. The comparison of the external product of right crystals with that of left D-modules is a proof obligation of the node.
- `GLCinLean.DModules.perverseHeart`: the words "when Y is separated and defined over C" are "when Y is defined over C and is in the scope of DModules.analyticDeRham". Nothing else.
- Wording only, for the new facts: the module `desc` of `plans/GLCinLean/AlgebraicGeometry/Constructible/StratifiedMaps.toml`; `GLCinLean.Constructible.exists_iso_directSum_ic_properPushforward` (one sentence: the categories of §§5.9–5.10 are the targets §§1.2–1.3 of the new roadmap); `GLCinLean.DModules.regularHolonomicDModule` (the roadmap #2279 is accepted, and its §1.5 is the node `DModules.regularHolonomicDeRham`); `GLCinLean.DModules.IsRegularHolonomic` (its stability theorem and the stability that the roadmap node presupposes are one theorem for left modules on smooth complex schemes; the theorem is not written before the provider of that case is decided).

`docs/blueprint-providers.md`: a row and a paragraph of notes for the new area under "Roadmaps that own plan nodes"; the row of EtaleDualityAndPerverseSheaves owns one node; under "Accepted roadmaps that cover nodes written here", the row of the new roadmap keeps only §2.1, the row of ComplexComparisonPartII on the analytification is removed (the analytification is inside the roadmap node, and no node written here constructs an analytification), and the row of SpringerResolutionAndCharacteristicCycles §11.3 names the clause that it covers; one item under "Limits of existing providers"; the candidate 1 of "Roadmap candidates". `docs/papers.md` and `docs/references.bib` list the numbers of [HottaTakeuchiTanisaki] that were compared with the book.

Nothing in `GLCinLean/` is changed. The module doc comment of `GLCinLean.lean` has one new entry under "Not formalized", for the statements on holonomic modules that are not regular. `STATUS.md` is not changed on the branch. When the change is applied, these parts of `STATUS.md` need the new facts: the open items "The de Rham comparison on singular schemes" (settled for the schemes that are closed in a smooth scheme), "The de Rham functor of SpringerResolutionAndCharacteristicCycles §11.3", "The operations of `Constructible.DerivedCategory` as operations on sheaves" (its first half is settled by the route of §1.2; identity (7) for a smooth map stays open) and finding B1; the decision "The decomposition theorem" (the area of the three nodes); the counts (310 nodes in 197 module plans, 89 of them owned by sixteen roadmap areas); and the workers (the new area has no author worker).

Checks on the branch: `lake exe tracker lint` has no errors; `python3 tools/check-module-cycles.py` reports 197 module plans, 310 nodes, 0 cycles; `python3 tools/check-upstream-names.py` confirms all 335 pairs.

## 7. Points of doubt

1. **The scope of the two nodes written here (D2a).** The nodes were stated for every separated scheme of finite type, and are now stated for the schemes that are closed in a smooth scheme. This weakens two planned statements. The reasons are 3.8 and the uses. A checker may prefer D2b with a recorded open item, or D2c.
2. **The dropped clause** on holonomic complexes that are not regular. It was a claim of `DModules.analyticDeRham` with source [HottaTakeuchiTanisaki] Chapter 4. `GLCinLean.lean` records it under "Not formalized". The scope of point 1 has no entry there: [HottaTakeuchiTanisaki] treats smooth algebraic varieties and complex manifolds only, so the narrower scope gives up no claim of a source.
3. **`Constructible.StratifiedDerivedCategory` in the new area (C3 against C2).** It is a prerequisite in either area.
4. **The parts of the constructible nodes beyond the targets** are kept: a general coefficient field, `𝔻𝔻 ≅ id` with the exchange, (6), (7) for smooth maps, the classification of simple perverse sheaves. The decision of 2026-11-19 on D-modules says that each object is provided "in the generality of its roadmap"; the decision on the decomposition theorem keeps such parts with the rule that a declined part comes back. The branch follows the second.
5. **The two readings of §1.5** (pure dimension; no shift in `pDR ∘ f^† ≅ f^! ∘ pDR`). The second is tested on a closed immersion and on a smooth map, and [HottaTakeuchiTanisaki] Theorem 7.1.1 states it with the same conventions.
6. **`gap:regular-holonomic-stability`.** The roadmap node states that `f_+`, `f_!` and `f^†` preserve regular holonomic cohomology, which §1.5 presupposes through this request; no roadmap states it as a target. `DModules.IsRegularHolonomic` plans the same stability here, for crystals over every field of characteristic zero. Both nodes now say that the case of left modules on smooth complex schemes is one theorem and is not proved twice. The branch does not decide its provider: that is a change of provider for a theorem that the decision of 2026-11-19 assigns to this project, and it belongs to the open item "Theorems on holonomic and regular holonomic complexes that no accepted roadmap states" of `STATUS.md`.
7. **`Satake.regularSheafExt_complexComparison`** in `plans-proof/` applies the theorem "on each finite stage" of an equivariant Ext comparison. The stages are the schemes `H^n × Z` for a finite Schubert union `Z` and a finite jet quotient `H` of `L⁺G` (`DModules.boundedEquivariantExt_baseChange`); they are quasi-projective, so they are in the scope. The node needs more than the scope: an equivariant Ext group is the cohomology of a totalization over these stages, and its comparison needs comparison maps of complexes that are compatible with the face maps, which a triangulated equivalence on each stage does not give. This gap is in the node at `8cde2a3` and is not part of this change; `riemann-hilbert-provider-answers-1.md` states it as an open item.
8. **The sources.** The nodes keep [HottaTakeuchiTanisaki] as `source`, by chapter, and name the texts that the roadmap cites (Dimca; Kashiwara 1984) without an entry in `docs/references.bib`. [HottaTakeuchiTanisaki] was compared for the numbers that `docs/papers.md` lists; the other two were not read.
9. **The independence of the embedding** in `DModules.analyticDeRham` is an isomorphism between the functors of two embeddings. No compatibility for three embeddings is stated. A use that needs coherent comparison maps, such as an equivariant comparison on a simplicial scheme, needs an enhanced form of the functor and is not served by these nodes.
