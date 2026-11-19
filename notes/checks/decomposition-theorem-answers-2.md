# Answers to round 2 of the checks of `proposal/decomposition-theorem`

The report is of commit `c9d8a6e`: `notes/checks/decomposition-theorem-codex-2.md`. Codex agrees with the provider and the route, finds its eight objections of round 1 resolved, and has five new objections. Four are fixed as it asks. For objection 3 the part that this change caused is fixed, and the rest is a proposed "Open items" line. Paths are relative to the repository; `plans/Roadmap/EtaleDualityAndPerverseSheaves/` is written `R/`, and `plans/GLCinLean/AlgebraicGeometry/` is written `A/`.

**What is agreed.** The difference of `plans/`, `plans-proof/` and `docs/` between `main` and the branch, and sections 5 "Texts for `STATUS.md`" and 6 "Worker guidance" of `notes/checks/decomposition-theorem-proposal.md`. The other sections of the proposal and the answer files are the working record.

## The five objections

**1. The domain of `j_!*`. Fixed.**

- `R/AnalyticStratified.toml`, items (4) and (5): "(4) For a locally closed union U of strata with inclusion j, let S|U be the stratification of U by the strata of S that lie in U; it is good. Then j^* and j^! carry D^b_S(Y, E) into D^b_{S|U}(U, E), and Rj_* and j_! carry D^b_{S|U}(U, E) into D^b_S(Y, E). (5) The intermediate extension j_!* of Constructible.PerverseSheaves is defined on perverse sheaves only. It carries the heart of D^b_{S|U}(U, E) into the heart of D^b_S(Y, E), by (4), (1) and (3)."
- `R/AnalyticPerverse.toml`: "the intermediate extension j_!* of a perverse sheaf P along a locally closed embedding j, as the image of pH^0(j_!P) → pH^0(Rj_*P) in the heart; it is a functor between the hearts and is not defined on all of D^b_c".
- Checked: `S|U` is good, because `j^* Rj_{T*} L ≅ R(j_T^U)_* L` for a stratum `T` in `U` and a locally closed `j`; `j^!` and `Rj_*` preserve the categories by duality on both sides; the image in (5) is a quotient of `pH^0(j_!P)`, which is in the heart of `D^b_S` by (4) and (1), so it is there by (3).
- Rule 2: the other sentences with `j_!*` are quotations of SpringerResolutionAndCharacteristicCycles §11.3 and "intermediate extensions to intermediate extensions" in `DModules.analyticDeRham_isEquivalence`; none gives `j_!*` a derived domain.

**2. Base change of `Rj_*` in the proof of goodness. Fixed, by a named supplier.**

- `R/AnalyticConstructible.toml`, new identity: "(7) For a smooth map g of relative dimension d, g^! ≅ g^*[2d]; in particular a^!E ≅ E[2d] for the map a to the point from a smooth scheme of dimension d. With (4) and the adjunctions of (1) this gives smooth base change for Rf_*: in the Cartesian square of (4) with g smooth of relative dimension d, g^* Rf_* ≅ Rf′_* g′^*, because the right adjoints of the two sides of f^* Rg_! ≅ Rg′_! f′^* are g^! Rf_* and Rf′_* g′^!." "What uses what" and "Left for this node" name (7).
- `A/AffineGrassmannian/SchubertConstructible.toml`: the proof applies (7) to the action `a` and to the projection `p` of `H × Y`, both smooth, each with a Cartesian square over `j`; this gives `a^* Rj_* E_T ≅ R(1 × j)_* E_{H × T} ≅ p^* Rj_* E_T`; restricted to `H × {y}`, the pullback of a cohomology sheaf along the orbit map is constant; the complex orbit map has holomorphic local sections (roadmap ReductiveGroups, Layer 3A.5f "Complex orbits"). `deps` add `Constructible.ComplexPoints`.
- Why (7) and not a proof by product charts inside the Schubert node. Codex allows both. The identity for smooth maps is generic sheaf theory, and the roadmap nodes use it already without a supplier: the check "L[d] is perverse" of `Constructible.PerverseSheaves` and the formula `𝔻(j_{T!}L) ≃ Rj_{T*}(L^∨)[2 dim T]` of `Constructible.StratifiedDerivedCategory` need `a^!E ≅ E[2d]`, and `AffineGrassmannian.isEven_bottSamelsonPushforward` uses `π^! ≅ π^*[2d]`. A proof by charts would need base change for maps that are not maps of schemes, which no item of the node states.
- Rule 2: `AffineGrassmannian.isEven_bottSamelsonPushforward` names (7); the lists "more than §§5.9–5.10 use" in `docs/blueprint-providers.md` and in doubt 1 of the proposal add "the identity `g^! ≅ g^*[2d]` for smooth maps other than the map to the point".
- A gap that this repair makes visible, proposed as an "Open items" line: no node of `plans/` stands for ReductiveGroups 3A.5f, so the tracker does not wait for the local sections. The sentence of `c9d8a6e`, "An equivariant complex has cohomology sheaves that are locally constant along each orbit", used the same fact without naming it.

**3. The partial flag varieties in the proof of evenness. One part fixed; the rest is a proposed "Open items" line.**

- The part that this change caused. `c9d8a6e` made the node depend on `Constructible.IsStratifiedMap`, whose condition (b) asked for good stratifications, and on a goodness theorem for `LG/I` and `Gr_G` only. After objection 4, (b) has no hypothesis of goodness, so the proof needs no goodness on `LG/P_s` through it.
- The rest is older than this change, and this change does not force it. Evidence: `git diff d73f8b3 HEAD -- plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/BottSamelson.toml` changes in the node only the words "which is good (AffineGrassmannian.isGood_schubertStratification)", the reference to (7) and the `deps`; the route through the projections between partial flag varieties, and `Constructible.DerivedCategory` on schemes of finite type, are on `main`.
- Why it is not repaired here. The missing objects (`LG/P_s`, its I-orbits, the projections `LG/I → LG/P_s`) belong to `AffineGrassmannian.bottSamelsonResolution`, which is under "Held" for the roadmap pull request #1734, and held nodes stay as they are. The node is not about to be written: five held nodes are below it. The repair adds objects to a definition; it is not a wording.
- The line is the fourth entry of "Open items" in section 5 of the proposal, with owner `AffineGrassmannian.isEven_bottSamelsonPushforward`.

**4. `Constructible.IsStratifiedMap`. Fixed.**

- `A/Constructible/StratifiedMaps.toml`: "(a) S_X refines the pullback of S_Y: S_X ≤ S_Y.comap f, for S_X and S_Y as stratifications of the spaces X(C) and Y(C) (`TauCeti.FiniteStratification`) and the continuous map of complex points. By `TauCeti.FiniteStratification.le_def` and `TauCeti.FiniteStratification.mem_comap_parts` this says that f sends each stratum of X into a stratum of Y. No new definition is made for (a)." and "(b) f is stratified, which is the definition of this node: (a) holds, so that the preimage of each stratum of Y is a union of strata of X, and over each stratum T of Y the map is locally trivial for the classical topology by trivializations that carry strata to strata ... Then, for S_X with the frontier condition and f proper, Rf_* carries D^b_{S_X}(X, E) into D^b_{S_Y}(Y, E). Goodness of S_X or S_Y is not a hypothesis."
- Checked at the pin (`TauCeti/Topology/Stratification.lean`): `comap (f : Y → X) (hf : Continuous f) (S : FiniteStratification X)`; `le_def : S ≤ T ↔ ∀ s ∈ S.parts, ∃ t ∈ T.parts, s ⊆ t`; `mem_comap_parts : u ∈ (S.comap f hf).parts ↔ u.Nonempty ∧ ∃ s ∈ S.parts, f ⁻¹' s = u`. A stratum of `X` is nonempty, so `f(s) ⊆ t` makes `f⁻¹(t)` a part of the pullback; empty preimages are no parts.
- Checked for (b): Codex's argument holds. After proper base change to a stratum `T` and restriction to a chart `U` of `T` with `f⁻¹(U) ≅ U × F`, the frontier condition of `S_X` orders the strata so that the unions are closed; on `U × F_i` a locally constant sheaf comes from `F_i`, so its compactly supported direct image to `U` is constant; the triangles give the complex. The frontier condition is needed for this filtration: for a line and a conic that meet in two points, the line without the first point and the conic without the second are two smooth connected strata of their union, and the closure of each meets the other.
- Rule 2: `DModules.analyticDeRham_isEquivalence` ("strata into strata for *-pullback; stratified maps for proper pushforward"), the proposal and `docs/blueprint-providers.md` state the conditions in the same way and need no change.

**5. The cost statement. Fixed.**

- New wording, the same in the summary of the proposal, in the entry "Decisions taken" of section 5 and in `docs/blueprint-providers.md`: "Tau Ceti at the pin has no constructible derived category, étale or analytic, no perverse sheaves and no decomposition theorem". Section 2.4 of the proposal and the record of EtaleDualityAndPerverseSheaves in `docs/blueprint-providers.md` say what was searched and what Tau Ceti has of the suppliers.
- Searched in `TauCeti/` at the pin: no file contains "perverse", "recollement" or "Verdier dual"; "constructible" occurs in 37 files, for constructible subsets and topologies, and once in the module doc comment of `TauCeti.Topology.Stratification`.
- Removed, as wrong or not verifiable: "Tau Ceti has no code for it or for its suppliers at the pin"; "None has code at the pin" (section 3); "None of its targets has code at the pin" (`docs/blueprint-providers.md`); "Tau Ceti has no code for this roadmap at the pin" (the proposed decision); "It has two inputs" (2.4).
- Verified: ComplexComparisonPartII §C6.1 says "extension by zero along an open inclusion is the pinned Tau Ceti exact left adjoint `SheafExtensionByZero`"; EtaleCohomologyFoundations names `TauCeti.Compactification` for §G.1, and `TauCeti/AlgebraicGeometry/Compactification/Basic.lean` has it; the generated `STATUS.md` of EtaleCohomologyFoundations says "Everything from base change and finiteness through adic realization, duality and perverse sheaves has not begun."
- The list of what the target rests on is now the "Dependencies" paragraph of Layer 5 of the roadmap, in section 3 of the proposal and in `docs/blueprint-providers.md`. The lists of `c9d8a6e` were partial.

## What rule 3 changed besides the objections

- **A declaration at the pin that the branch did not name.** `CategoryTheory.Sheaf.IsLocallyConstantIn` (`TauCeti.CategoryTheory.Sites.LocallyConstant`): sheaves on a site that are locally constant with values in a class of objects. It is named in `R/AnalyticStratified.toml`, in the table of upstream declarations of `docs/blueprint-providers.md`, and in item 3 of "Worker guidance".
- **The numbers of [BBD].** The roadmap cites 6.2.4, Théorème 6.2.5 with 6.2.7 (§§5.9–5.10) and Théorème 4.3.1 (§2.10); it does not cite §§2.1.13–2.1.16. The `source` fields of `Constructible.PerverseSheaves`, `Constructible.StratifiedDerivedCategory` and `Satake.icSheaf_restriction_isParity` say so. Doubt 4 of the proposal is rewritten.
- **Counts.** All counts are those of the merged plan (below). `docs/blueprint-providers.md`, candidate 7: 45 nodes, 8 in `AffineGrassmannian/`.
- **Section 8 against the Satake nodes of `main`.** Corrected: [DeligneMilne] is in `references/` (Propositions 2.20(b), 2.21(a) and Corollary 2.22 were read there); the hypotheses of `TauCeti.reductiveCommHopfAlgProperty_iff_linearlyReductive` are characteristic 0, finite type and geometric connectedness; `Satake.tannakaRootDatum_equiv_dual` uses semisimplicity for finite type, connectedness and reductivity, and no longer calls the Deligne–Milne criteria "explicit obligations here" (they are the roadmap nodes `Tannaka.finiteType_iff_exists_tensorGenerator` and `Tannaka.connected_iff_not_tensorClosed_hull`); "about fifteen nodes" is 21 nodes, counted from the dependency closure. Unchanged and confirmed: the two users of `Satake.sphericalHeart_semisimple`; the quotations of `Satake.naiveFactorizationFunctor`, `Satake.dualIdentification`, `Satake.tannakaPinning` and `Satake.tannakaRootDatum_equiv_dual`; `Satake.tannakaGroup` uses no semisimplicity.
- **Checked and left as they are:** the two extension-by-zero declarations, `TauCeti.FiniteStratification` and its `comap`, `CategoryTheory.ObjectProperty.HasInducedTStructure` and `tStructure`, with their modules; the quotations of §§3.5, 5.9 and 5.10, of ComplexComparisonPartII §C−1.1 and §C6.1, of SpringerResolutionAndCharacteristicCycles §11.3 and of GeometricSatakeAndFusion; the target names `complexAnalyticComparison`, `pureSpecializationOfGeometricOrigin`, `decompositionTheorem`, `decompositionTheoremComplex`, `relativeHardLefschetzComplex` and `heartAbelianSubcategory`; the 18 nodes above the theorem and the four in the statement.
- **Rule 6.** No error or gap of a paper was found in this round, so `GLCinLean.lean` has no new entry.

## The merge of `main`

`main` moved twice while this round was written, so the branch has two merge commits: `17bea94`, with `main` at `d29fcb6`, and `6088a44`, with `main` at `54a0e9f` (the change of the provider of the loop groups). In both, one file had conflicts, `docs/blueprint-providers.md`.

The first merge, two places:

- **The snapshot rows.** The rows of `main`. The roadmap snapshot is `fe56342a` for every area, which contains the note of the branch on a second read of five READMEs at `fe56342a`.
- **The table of open roadmap pull requests.** The rows of `main` (new heads of #1734, #1687 and #2450; GeneralizedCohomology G2.11 in the row of #2270). For #2279, whose head is the same on both sides, the row of the branch, which says that the two carrier nodes are roadmap nodes of EtaleDualityAndPerverseSheaves.
- **Without a conflict marker.** The paragraph of `main` on the accepted roadmaps that cover nodes written here said "and no decomposition theorem". The row of the theorem is not in that table on the branch, so the fact is stated once, in the record of EtaleDualityAndPerverseSheaves.
The second merge, four places:

- **The table of upstream declarations.** The six rows of `main` and the five rows of the branch.
- **The table of roadmaps that own plan nodes.** The row of `main` (FormalConnectionsOpers), then the row and the record of the branch (EtaleDualityAndPerverseSheaves).
- **The accepted roadmaps that cover nodes written here.** The text and the rows of `main`, without the row of EtaleDualityAndPerverseSheaves, which this change removes, and without "no decomposition theorem", as in the first merge. The row of SpringerResolutionAndCharacteristicCycles is the branch's, with its §11.3.
- **Candidate 7.** The row of `main`, with one more node in `AffineGrassmannian/`: 45 nodes, 8 + 2 + 2 + 1 + 27 + 5.

`STATUS.md`, `tools/`, `GLCinLean.lean` and every other file are those of `main` at `54a0e9f`.

## Counts and checks, at the head of the branch

- `plans/`: 303 nodes in 189 module plans; 221 under `plans/GLCinLean/` (31 of them the statement) and 82 under `plans/Roadmap/`, in thirteen areas. 220 of the 221 have a roadmap node below them. `main` at `54a0e9f` has 300 in 184, with 222 and 78 in twelve areas. The difference is this change: 7 modules added and 2 removed; 3 nodes moved to the roadmap; 3 new nodes, one in the roadmap and two here.
- `lake exe tracker lint`: 0 errors, 61 warnings (superseded fields of the statement's nodes).
- `python3 tools/check-module-cycles.py`: 189 module plans, 303 nodes, 0 cycles.
- `python3 tools/check-upstream-names.py`: 250 pairs, 0 not confirmed.
- The dependency closure of the suppliers: every `deps` entry is a node; every node that a `desc` of this change names as a supplier is in the dependency closure of that node. The names outside the closure are users, not suppliers: `Constructible.DerivedCategory` names its users in "What uses what", and `DModules.perverseHeart` names `Constructible.StratifiedDerivedCategory` and `DModules.analyticDeRham_isEquivalence` for a comparison that it does not use. One supplier is a roadmap target without a node: ReductiveGroups 3A.5f (the proposed "Open items" line).
- The done check: `lake build` passes with the one warning of the main theorem and builds no module of Mathlib or Tau Ceti; `lake lint` passes; `lake env lean tools/check-statement-axioms.lean` shows `sorryAx` only for the main theorem, with `propext`, `Classical.choice` and `Quot.sound`.
- No Lean file, no file of `GLCinLean/Statement/`, no file of `plans-proof/` and not `STATUS.md` differs from `main` at `54a0e9f`.

## Where I disagree with Codex

- **Objection 3.** I agree that the step is missing. I disagree that this change must supply it: the route is on `main`, the objects that it lacks belong to a held node, and the hypothesis of goodness that this change brought in is removed by objection 4.
- **Objection 2, the form of the repair.** I took the second of the two forms that Codex offers, a named supplier, and not the proof by product charts.
