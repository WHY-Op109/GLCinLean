# Answers to round 4 of the checks of `proposal/decomposition-theorem`

The report is of commit `b47fdb0`: `notes/checks/decomposition-theorem-codex-4.md`. Codex agrees with the provider and the route, finds the five corrections of round 3 resolved, and has seven objections to the applied text, each with a replacement. All seven replacements are applied with Codex's wording. The deviations are listed at the end. Paths are relative to the repository; `plans/Roadmap/EtaleDualityAndPerverseSheaves/` is written `R/`, and `plans/GLCinLean/AlgebraicGeometry/` is written `A/`.

## The seven objections

**1. The star-pullback in the claim of `DModules.analyticDeRham`. Applied.**

- `A/DModules/AnalyticDeRham.toml`: "Let M be a bounded regular holonomic complex (DModules.IsRegularHolonomic). If for every stratum inclusion i_T of a stratification S the D-module star-pullback i_T^*M (DModules.starPullback) has lisse cohomology, then DR(M) belongs to D^b_S(Y, C) of Constructible.StratifiedDerivedCategory."
- Verified. `DModules.starPullback` is the left adjoint of de Rham pushforward, and on holonomic objects it is `D f^! D`; this is the pullback that corresponds to the restriction of sheaves. The umbrella example of `Constructible.StratifiedDerivedCategory` gives the counterexample for the other pullback: for the inclusion `j` of the complement of the axis, the !-restriction of `Rj_*` of the constant sheaf to the axis is zero, and its degree-zero cohomology sheaf has stalk rank 2 and 1 along the axis.
- Step 3. `DModules.starPullback` is in the `deps` of `DModules.IsRegularHolonomic`, which is in the `deps` of `DModules.analyticDeRham`. So it is below the node; no `deps` entry is added, and the cycle check finds no cycle.
- Step 4. The entry "Decisions taken" of section 5 of the proposal has the same claim; it now reads "only for regular holonomic complexes whose D-module star-pullbacks to the strata have lisse cohomology". `DModules.analyticDeRham_isEquivalence` states its restriction for a good `S` and is not changed.

**2. The last pushforward to the affine Grassmannian. Applied.**

- Section 5 of the proposal, the proposed "Open items" line on the partial affine flag varieties: "For the map to `LG/I`, proper base change expresses the pushforward using pullback and pushforward along `LG/I → LG/P_s` for the letters of the word, where `P_s` is the minimal parahoric subgroup of a simple reflection. For the map to `Gr_G`, apply in addition `Rq_*` for `q : LG/I → LG/L⁺G = Gr_G`. This projection also preserves evenness by the proper-even argument of Propositions 4.10 and 2.36." Its last sentence: "it then specifies the finite supports for the intermediate projections and for `q`, and checks smoothness on the spaces that the pullbacks use."
- Verified. `AffineGrassmannian.bottSamelsonResolution` says "compose with the projection to Gr_G". [JuteauMautnerWilliamson] Proposition 4.10 is for a projection to `G/P_K` with `K` of finite type, and its proof takes the pushforward through Proposition 2.36.
- Step 4. The node `AffineGrassmannian.isEven_bottSamelsonPushforward` says "the projections between partial flag varieties", which contains `q`; it is not changed.

**3. The pinned inputs of the orbit theorem, and the domain of 3A.5f. Applied.**

- `A/Constructible/OrbitStratification.toml`, after the statement: "Take each stratum with its orbit scheme and locally closed immersion, `TauCeti.SchemeAction.orbitScheme` and `TauCeti.SchemeAction.orbitι` (`TauCeti.AlgebraicGeometry.GroupAction.Orbit.Scheme`). The smoothness instance for `orbitToBase` is in `TauCeti.AlgebraicGeometry.GroupAction.Orbit.Smooth`. Each orbit is connected as the image of the connected group. The frontier condition follows from `TauCeti.SchemeAction.orbitClosure_subset_orbitClosure_iff` (`TauCeti.AlgebraicGeometry.GroupAction.ClosedOrbit`)." The list "Upstream declarations used" of the node has the three named declarations.
- Verified by opening the files at the pin. `Orbit/Scheme.lean`, namespace `TauCeti.SchemeAction`: `abbrev orbitScheme` (the locally closed image of the orbit map), `def orbitι : orbitScheme G x ⟶ X.left`, `instance : IsImmersion (orbitι G x)`, `def orbitToBase`. `Orbit/Smooth.lean`, same namespace: an instance without a name, `Smooth (orbitToBase G x)`, for a reduced group; the group of the node is smooth by Cartier's theorem, hence reduced. `ClosedOrbit.lean`, same namespace: `theorem orbitClosure_subset_orbitClosure_iff`, `orbitClosure G y ⊆ orbitClosure G x ↔ y.left a ∈ orbitClosure G x`. The hypotheses of these files are an algebraically closed field and finite type for the group and the scheme.
- `docs/blueprint-providers.md`, the row of ReductiveGroups Layer 3A.5f: "for an affine group scheme `H` of finite type over ℂ acting on a finite-type ℂ-scheme `Y`, and `y ∈ Y(ℂ)`, the map `H(ℂ) → O_y(ℂ)` is a holomorphic submersion with holomorphic local sections". Verified: Layer 3A takes "a group scheme `G` locally of finite type over `k` with quasi-compact underlying space, and a scheme `X` with the same finiteness"; 3A.5f takes "an affine group scheme `G` of finite type over ℂ" that acts "as in 3A.1", and `x ∈ X(ℂ)`.
- Step 4. The proposed "Open items" line on the local sections states the same fact; it has the same wording now. The sentence of the node on the complex orbit map is inside this domain and is not changed.

**4. Whitney stratifications. Applied.** `R/AnalyticStratified.toml`: "Whitney stratifications with connected strata are good by stratified local triviality. The orbit cases used in this plan follow from Constructible.isGood_orbitStratification." Step 4: a search of `plans/`, `plans-proof/` and `docs/` for "all orbit stratifications" and for "Thom isotopy" finds no other place.

**5. The projection formula in "What uses what". Applied.**

- `R/AnalyticConstructible.toml`: "The exchange in (3) for a map f uses (5) for that map. The local comparison, stratified-map, orbit-goodness and Bott–Samelson nodes (DModules.analyticDeRham_isEquivalence, Constructible.IsStratifiedMap, Constructible.isGood_orbitStratification, AffineGrassmannian.isEven_bottSamelsonPushforward) use further instances of base change and smooth purity, derived global Hom, external products or general coefficient fields. The complex-analytic geometric-origin and decomposition statements of §§5.9–5.10 require only part of this interface."
- Verified against item (3) of the node: "𝔻 f^* ≅ f^! 𝔻 and 𝔻 Rf_! ≅ Rf_* 𝔻; this follows from (1), (2) and (5)", for every map `f`.
- `docs/blueprint-providers.md`, record of EtaleDualityAndPerverseSheaves: "general base change and duality exchange for arbitrary maps, with the projection formula used to prove that exchange".
- Step 4. Doubt 1 of the proposal has the same list, with the same wording now.

**6. Both conditions of [JuteauMautnerWilliamson] §2.4. Applied.** `A/Constructible/StratifiedMaps.toml`: "The definition in [JuteauMautnerWilliamson] §2.4 requires (a) and requires each induced map of strata to be a submersion with smooth fibre. Here (b) requires local product charts preserving the strata." Verified in the pinned TeX, lines 1470 to 1483: (1) "the inverse image `π^{-1}(Y_μ)` is a union of strata"; (2) "the induced morphism `π_{λ,μ} : X_λ → Y_μ` is a submersion with smooth fibre". Step 4: a search for "asks only" finds no other place.

**7. The sentence on the search of the pinned library. Applied.** `docs/blueprint-providers.md`, record of EtaleDualityAndPerverseSheaves: "The pinned library has constructible subsets, constructible topologies and finite stratifications. The module comment of `TauCeti.Topology.Stratification` mentions constructible étale sheaves as an application. The search found no implementation of the constructible derived category or its perverse t-structure." Verified at the pin: `Topology.IsConstructible` and `TauCeti.IsProConstructible`, `constructibleTopology`, `TauCeti.FiniteStratification`, and line 16 of `TauCeti/Topology/Stratification.lean`. Step 4: section 2.4 of the proposal has the replaced sentence; it is outside sections 5 and 6 and is not changed.

## Deviations from Codex's wording

- **1:** the sentence keeps the two node names of the replaced sentence, `DModules.IsRegularHolonomic` and `Constructible.StratifiedDerivedCategory`, and says "of a stratification S", because the node introduces `S` there.
- **2:** the clause "where `P_s` is the minimal parahoric subgroup of a simple reflection" is added, because the line then says that the plan has no node for `LG/P_s`.
- **3:** the three declarations are also in the list "Upstream declarations used" of the node.
- **4:** the node name is written without backticks, as node names are in `plans/`.
- **5:** the four node names of the replaced sentence are kept in parentheses.
- **One improvement, one line:** the proposed "Open items" line on the local sections says that the two inputs of the Schubert node are missing plan dependencies and not missing sources, with [MV] §2 and [JuteauMautnerWilliamson] Proposition 4.3. Verified: [MV] §2 has "The group `G(O)` acts on the `Gr_n` via a finite dimensional quotient" and "the orbits `Gr^λ` are simply connected"; Proposition 4.3 ends "any local system ... is constant".
- **One number of the working record:** section 8 of the proposal says 22 nodes, not 21; the node of round 3 is one of them.

## The merge of `main`

`git merge main`, one merge commit `e9b1fab`, with `main` at `08061de`. No conflict. `main` changed no file of `plans/`, `plans-proof/`, `docs/` or Lean since `54a0e9f`. The files of this change under `notes/checks/` stay; `STATUS.md` and `tools/` are those of `main`.

## Counts and checks, at the head of the branch

- `plans/`: 304 nodes in 190 module plans; 222 under `plans/GLCinLean/` (31 of them the statement) and 82 under `plans/Roadmap/`, in thirteen areas. 221 of the 222 have a roadmap node below them. `main` has 300 in 184, with 222 and 78 in twelve areas. The counts of section 5 of the proposal are these.
- The held nodes below the six nodes of the paragraph "Held" of section 5 are as the paragraph says, against the rows of "Held" on `main` at `08061de`.
- `lake exe tracker lint`: 0 errors, 61 warnings (superseded fields of the statement's nodes).
- `python3 tools/check-module-cycles.py`: 190 module plans, 304 nodes, 0 cycles.
- `python3 tools/check-upstream-names.py`: 255 pairs, 0 not confirmed. The three pairs that this round adds were compared by hand with their declarations and namespace (objection 3).
- The dependency closure of the suppliers, for the eight nodes written here that the change adds, moves or rewrites: every node that a `desc` names is in the dependency closure of that node, except the names of users: `DModules.analyticDeRham` names `DModules.analyticDeRham_isEquivalence`, and `DModules.perverseHeart` names `Constructible.StratifiedDerivedCategory` and `DModules.analyticDeRham_isEquivalence` for a comparison that it does not use. The roadmap node `Constructible.StratifiedDerivedCategory` names its user `Constructible.isGood_orbitStratification`; no roadmap node has a node written here in its `deps`. One supplier is a roadmap target without a node: ReductiveGroups 3A.5f.
- No Lean file changed in this round or in the merge. No Lean file, no file of `GLCinLean/Statement/`, no file of `plans-proof/` and not `STATUS.md` differs from `main`.
