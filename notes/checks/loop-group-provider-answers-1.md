# Answers to round 1 on `proposal/loop-group-provider`

The reports are `loop-group-provider-codex-1.md` (11 objections) and `loop-group-provider-check-1.md` (M1, U1 and 15 smaller points), both on commit `e952ddb`. Each finding was checked against the files, the roadmap at `fe56342a`, Tau Ceti and Mathlib at the pins, and the papers. 26 findings are fixed and 2 are not changed; no finding is rejected. Both reports agree with option (a2) and with the release of the loop group from "Held", and this is unchanged.

The file names below are relative to the repository. "FLG" is `plans/Roadmap/FormalConnectionsOpers/FormalLoopGroups.toml`, "CA" is `plans/Roadmap/FormalConnectionsOpers/CoordinateAutomorphisms.toml`, "LG" is `plans/GLCinLean/AlgebraicGeometry/LoopGroups/Basic.toml`, "RAN" is `plans/GLCinLean/AlgebraicGeometry/LoopGroups/Ran.toml`, "HLA" is the new `plans/GLCinLean/GeometricLanglands/Hecke/LoopGroupAction.toml`, "PROV" is `docs/blueprint-providers.md`, and "PROP" is `notes/checks/loop-group-provider-proposal.md`.

## Where the two reports differ, and the decision

**The quotient and the actions over the Ran space (Codex 3; checker, point 4 and the table of verdicts).** The checker finds that the two Satake users need only the changed dependency. Codex finds that the action of `𝔏(G)` on the Grassmannian over Ran, the stabilizer and the étale quotient have no node, and that `Satake.criticalDeterminantGerbe` does not reach the Grassmannian over Ran. The sources decide for Codex. [GLC2] §1.1.14 takes the gerbe on `𝔏(G)` as given with its trivialization on `𝔏⁺(G)`, [GLys] §7.2 says that it is the pullback under the projection `𝔏(G) → Gr_G`, and [GLC2] §1.5.1 writes the spherical category on `𝔏⁺(G)\𝔏(G)/𝔏⁺(G)`. The projection, the action and the quotient are [GLys] §§7.2.1–7.2.2 and [GLC2] §B.4.10. On `main` no node stated them either, and `Satake.criticalDeterminantGerbe` had no path to `Hecke.Correspondence`. The answer is a new node, `Hecke.loopGroupAction`, and not a wider loop group node: the construction needs the Grassmannian of `Hecke.Correspondence` and torsors, which are not part of the concept "loop group".

**The interface with `Derived.IsIndscheme` (Codex 4, first part; checker U1).** The checker asks for the stage n = 0 in `Derived.IsIndscheme` now and leaves the passage to a derived prestack for later. Codex asks for the extension from classical ind-schemes, or a theorem with classical input, in the plan, and for each consumer to say which it uses. [DGIndschemes] has both in the sections that `Derived.IsIndscheme` already cites: §1.1 defines the n-coconnective ind-schemes and calls the case n = 0 classical; Lemma 1.4.7 and §1.4.8 give the fully faithful extension by the convergent completion of the left Kan extension. Both are now in the node, and the three consumers with classical input say that they state the stage n = 0. This is no new line of work: the predicate is unchanged, and the added API is in its own sources.

**The two Ran spaces (Codex 4, second part).** Codex asks for a pullback or de Rham comparison that transports the action groupoid and the gerbe from the Ran space of [GLys] (finite subsets of `X(S)`) to the one of [GLC2] (finite subsets of `X(S_red)`). The finding is right that the first version of RAN used the base of [GLys] while the statement uses the other. The answer differs from the one Codex proposes: no comparison is needed. The discs of [GLC2] §§B.3.1, B.3.4 and B.3.7 depend only on the closed subset of the graphs, so [GLC2] §§B.5.4–B.5.5 define the arcs and loops over the Ran space of §B.1.1, which is `Ran(X_dR)` of `GLCinLean.Ran`. RAN now has this base, and the families over `Ran(X)` and `X^I` are pullbacks. The groupoids and gerbes over the base of the statement are then the primary objects.

## Codex

**1. The pin has the Hopf algebra of the Weil restriction.** Fixed. Verified at the pin: `TauCeti.Algebra.WeilRestriction.instHopfAlgebra`, `pointsMulEquiv`, `pointsMulEquiv_naturality` and `mapBialgHom` are in `TauCeti.Algebra.HopfAlgebra.WeilRestriction`, and `instSmooth` is in `TauCeti.RingTheory.WeilRestriction.Smooth`. My first search for the Hopf structure used the names of the roadmap text (`instHopfAlgebraRes`) and so missed it. Places: FLG (3), its "In Tau Ceti and Mathlib" passage, "Still to do" and "Upstream declarations used"; PROV, the row of `TauCeti.Algebra.WeilRestriction` and the ready module; PROP §§2.2, 2.3, 3; the worker guidance, step (2). The work that remains for the jets is the tower, its transition maps and its limit.

**2. Factorization is false for an arbitrary classical prestack.** Fixed (the same as checker M1). RAN (3) is stated for a disjoint-union-local prestack, with [GLC2] §B.3.2 as the source of the condition and §§B.4.2, B.4.6 as the source of the factorization. RAN records the difference from [GLys] §7.1.3 with its kind (a correction) and the counterexample. The mapping construction of (2) stays for every `Z`. PROP §7 has the item for the root file, to be added when the declaration is written.

**3. The quotient and the actions over Ran; the action of `Aut(O)` on the local Grassmannian.** Fixed, by one new node and one sentence in a held node. HLA, `Hecke.loopGroupAction`: (1) the Beauville–Laszlo comparison for every `S → Ran(X_dR)` in terms of the discs, (2) the left action of `𝔏(G)` and the stabilizer of the unit section, (3) the Grassmannian as the étale quotient by the right action of the arc group, with the residual left action of `𝔏⁺(G)` and the pullback of a gerbe along the orbit map, (4) the compatibilities with factorization, with the pullbacks and with the local quotient. Its dependencies are `Hecke.Correspondence`, `LoopGroups.RanLoopGroup`, `Stacks.groupTorsor` and `GLCinLean.AffineGrassmannian`. `Satake.criticalDeterminantGerbe` and `Satake.factorizationSphericalCategory` depend on it and name it, so both reach the Grassmannian over Ran. `Hecke.Correspondence` is not changed: its comparison for one fibre with a coordinate stays, and the comparison over Ran is in the new node because it uses the discs of RAN. The induced action of `Aut(O)` on the local Grassmannian is assigned to the local quotient node, `GLCinLean.AffineGrassmannian`, by one sentence; LG (4) points to it. That node is held and stays held.

**4. Two comparisons.** Fixed; see "Where the two reports differ". `plans/GLCinLean/AlgebraicGeometry/Derived/Indscheme.toml` has the stages and the extension; LG (3), RAN (4) and `GLCinLean.AffineGrassmannian` say that they state the stage n = 0. LG now says that [DGIndschemes] Proposition 9.2.4 is for an affine target almost of finite type, which `H` is. RAN has the base `Ran(X_dR)`.

**5. A source for the ind-affine loop group over Ran.** Fixed. Verified: [GLC2] Lemma B.4.8 (arcs affine, loops ind-affine, the inclusion a closed embedding into a piece), §B.5.5 (loops into an affine scheme over `X` are the maps from the punctured disc) and Example B.5.6 (the pieces by the multiples of the divisor of lifted graphs). RAN (4) cites them and uses the divisor `D` of lifted graphs of (1), whose multiples are cofinal also where the points collide. Doubt 4 of the first version is removed from PROP §9. The checker's point that [GLys] works with a connected algebraic group, so that its §7.2.2 covers `G`, `B`, `N` and `T`, is also right (the paragraph of conventions of [GLys]) and is in PROP §2.5 and RAN (4).

**6. Two users in `plans-proof/` lost the family.** Fixed. `SpectralProof.sphericalKL` and `SpectralProof.opers_indPlacid` now also depend on `LoopGroups.RanLoopGroup`. `SpectralProof.torusDerivedSatake_equiv` is not changed; I confirmed the path that Codex names: `SpectralProof.derivedSatakeTransform` → `Satake.renormalizedSphericalCategory` → `Satake.factorizationSphericalCategory` → `LoopGroups.RanLoopGroup`. PROP §4.

**7. Checks under their quantifiers.** Fixed, each one.
- "need not be of finite type", with the trivial group and 𝔾_a as the two cases: FLG (3) and (4).
- The formula for `L𝔾_a` names the generator `x`; the presentation with `x` and `x²` is added as a check that the pieces depend on the presentation: FLG (5).
- A nonzero coefficient ring in the tests with `|M|`, with the affine space of infinite dimension and with `x ↦ t^{−N}`: FLG (3), (4), (5).
- "`K_{N+1}` is contained in `K_N`, and the two can be equal": FLG (2).
- The test with `2t` and `t + t²` is over a ring in which 2 is a unit, and `2t` over `𝔽_2` is named as a non-example: CA (3).
- `t²` is not a coordinate over a nonzero ring: CA (3).
- `ρ_{a·t}` moves `t^n` exactly when `a^n ≠ 1`: CA (3).
- The preservation of a piece is quantified over the finite presentation: CA (2), and the worker guidance, step (5).

**8. The collision test and the change of coordinate.** Fixed. RAN (6) states the collision test for the arc group, where restriction along `D_{x_j} → D_x` is a natural map for every pair of points: it is the isomorphism of factorization for disjoint points and the diagonal `g ↦ (g, g)` for equal points, and `(0, 1)` for 𝔾_a is not in its image. For the loop group there is no such map for a general pair, because the punctured disc of `x_1` does not map to the punctured disc of the union. RAN (5) defines a coordinate along an `S`-point (a lift with graph `D` and an isomorphism of the ring of the disc with `R[[t]]` that carries the ideal of `D` to `(t)`), gives the constant point and the étale coordinate on an open of the curve as examples, states the compatibility with base change, and has the formula `i_{t′} = ρ_φ ∘ i_t` with the check that the loop `t` is `a⁻¹·t′` for `t′ = a·t`. I recomputed the formula: the coordinate `t′ = φ(t)` sends `t` to `φ⁻¹(t′)`, so the identification for `t′` is `σ_{φ⁻¹}` after the one for `t`.

**9. The inventory understates the substitution and lifting APIs.** Fixed. Verified at the pins: `TauCeti.LaurentSeries.rescale` over a commutative semiring (`TauCeti.RingTheory.LaurentSeries.Rescale`); Mathlib's `LaurentSeries.of_powerSeries_localization`; `Algebra.FormallySmooth.exists_mkₐ_comp_eq_of_isAdicComplete` (`Mathlib.RingTheory.Smooth.AdicCompletion`), which is what `congruenceCotangentHom_surjective_of_formallySmooth` passes on; `congruenceSubgroup_iInf`; and the instance of completeness of `PowerSeries R` for the ideal `(X)` (`Mathlib.RingTheory.AdicCompletion.Completeness`). FLG no longer names `congruenceCotangentHom_surjective_of_formallySmooth` as the lifting of points; it names the Mathlib lemma. Places: FLG and CA, "In Tau Ceti and Mathlib" and "Upstream declarations used"; PROV, the rows of the congruence subgroups and of the formal coordinates; PROP §2.3; the worker guidance.

**10. The worker guidance made a generalization a condition.** Fixed. FLG and CA each have a paragraph "Generality": the plan needs a field of characteristic zero, a group of finite type and every test algebra, the nonreduced ones included; this is the roadmap's stated case and is sufficient; a commutative ring is asked where Tau Ceti's review accepts it and is not a condition of the plan. The worker guidance says the same. The claim "no curve" is corrected in PROP §2.1 and RAN ("Provider"): §5.1 glues the action on opers over the torsor of formal coordinates on a smooth curve; what the roadmap lacks is a loop group at several points or over the Ran space.

**11. Two smaller claims.** Fixed. (a) `Satake.criticalDeterminantGerbe`: the sentence now follows [GLC2] Remarks 1.1.4 and 1.1.7: the square root of the determinant line bundle exists as a line bundle on the Grassmannian over Ran and trivializes the gerbe; it is compatible with factorization only as a ℤ/2-graded factorization line bundle; so the trivialization is not compatible with factorization. This sentence is older than the proposal; it is corrected here because the node is edited by the proposal, as a small change of wording. (b) PROP §6: the 61 lint warnings are on the 31 existing declarations of the statement, the placeholders, `isLanglandsFunctor_iff` and the main theorem among them.

## Checker

**M1. Clause (3) of `LoopGroups.RanLoopGroup` is false for an arbitrary `Z`.** Fixed; see Codex 2.

**U1. "Classical ind-scheme" has no node.** Fixed; see "Where the two reports differ". The stage is named in `Derived.IsIndscheme`, and the extension is added now, because Codex 4 asks for the passage and it is in the same sources.

**Point 1, the sentence on §5.1.** Fixed. CA and PROP §2.1 say that §5.1 does not name the action on loops and that its need is an inference from the gauge action. CA also quotes "the relative formal calculus over arbitrary coefficient algebras (Layer 1)" for part (1).

**Point 2, "Its pieces are not of finite type."** Fixed; see Codex 7.

**Point 2, "its checks are those of (5)".** Fixed. FLG: the checks of §§3.1 and 3.2 for `𝔾_m` and for the trivial group are among those of (5), and the checks for 𝔾_a are added by the node.

**Point 4, doubt 4 understates [GLys].** Fixed; see Codex 5.

**Point 4, the relative pieces cannot reuse the roadmap's `LG_{≤N}`.** Fixed. RAN (4) says why the pieces over `S` are constructed here (no coordinate where points collide, only the divisor), and (5) compares them with the roadmap's pieces for a coordinate.

**Point 4, the last sentence of check (6).** Fixed; see Codex 8.

**Point 5, kernels.** Fixed. LG (1): `L` and `L⁺` commute with finite limits of affine group schemes, so with fibre products and kernels, and the node names the user.

**Point 5, the three users in `plans-proof/`.** Fixed for two of them; see Codex 6. The checker accepts leaving them; Codex asks for the change, and the texts of the two nodes name factorization and the charts of Ran, so the dependency is right now.

**Point 5, `instSmooth`.** Fixed. LG (2) and its "Upstream declarations used".

**U1, the consequence for the held nodes.** Fixed as far as this change reaches. `GLCinLean.AffineGrassmannian` says that its quotient is formed in classical prestacks and that it is a classical ind-scheme, and that a node which needs a derived prestack applies the extension. `DModules.EquivariantIndscheme` is not changed: it takes an ind-scheme in the sense of `Derived.IsIndscheme`, which the extension supplies.

**Breach, "closed immersion" and "closed embedding".** Fixed. The four loop group nodes, HLA and PROP use "closed embedding", the term of `Derived.IsIndscheme`.

**Breach, "have moved".** Fixed. PROV says only where the loop groups of FormalConnectionsOpers are.

**Design note, the repeated checks.** Fixed. LG (5) keeps the checks in terms of prestacks (the point, and that `L𝔾_m` is not reduced as a prestack) and refers to FLG for the checks on points.

**"To apply together": `STATUS.md`.** Not changed on the branch: the planner does not edit `STATUS.md`. PROP §7 now says that its texts go to `main` in the same commit as the plan.

**Point 7, statements that the checker did not verify.** Not changed. The evidence: EndoscopicTransferAndUnitaryTraceComparison §3.2 and its "Conventions" ("For the equal-characteristic geometry, `k` is finite") and the supplier lines of AffineLieAlgebras, KacMoody and GeometricRepresentationCategories were read in the copy of TauCetiRoadmap of 2026-11-18; the 23 new areas are the difference of the two directory listings, and Codex confirms the two roadmap facts that it checked.

## Changes outside the four loop group nodes

- `plans/GLCinLean/AlgebraicGeometry/Derived/Indscheme.toml`: the stages and the extension (U1, Codex 4).
- `plans/GLCinLean/AlgebraicGeometry/AffineGrassmannian/Basic.toml`: two sentences (Codex 3, Codex 4, U1). The node stays held.
- `plans/GLCinLean/GeometricLanglands/Hecke/LoopGroupAction.toml`: new (Codex 3).
- `plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml` and `Factorization.toml`: the dependency on `Hecke.loopGroupAction`, and the sentence on [GLC2] Remarks 1.1.4 and 1.1.7 (Codex 3, Codex 11).
- `plans-proof/GLCinLean/GeometricLanglands/Spectral/Critical/Factorization.toml` and `IndCoh.toml`: one dependency each (Codex 6).

The plan has 286 nodes in 170 module plans. `lake exe tracker lint` has no errors and `python3 tools/check-module-cycles.py` finds no cycle.
