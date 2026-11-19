# Answers to round 3 on `proposal/loop-group-provider`

The report is `loop-group-provider-codex-3.md`, on commit `088e339`. It has four blocking objections and two improvements. All six are applied. For each of the four objections the whole branch was searched (`plans/`, `plans-proof/`, `docs/blueprint-providers.md`, the proposal and the entry of the root file) for other sentences that state the same claim, and each was corrected in the same way. No construction and no node is added.

## Objections

**1. The parity qualification in the users.** Fixed in four places. The claim is "the trivialization by the theta characteristic is not compatible with factorization", or its consequence that the untwisted and the twisted settings differ; by [GLC2] Remark 1.1.4 with its footnote it holds in general and fails when the grading is zero on every component, as for the trivial group.
- `plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml`, `Satake.criticalTwistBunDeterminantEquiv`, last sentence: the spherical category is not untwisted for any G; "in general that trivialization is not compatible with factorization", and it is compatible when the grading of `Satake.criticalDeterminantGerbe` is zero on every component.
- `plans/GLCinLean/GeometricLanglands/Satake/Factorization.toml`, `Satake.factorizationSphericalCategory`, last sentence: "The twist is kept for every G"; the ε-twisted source "in general is not Rep(Ǧ)_Ran", and the two agree when the sign ε is trivial, as for the trivial group. By [GLys] §9.2.2 the ε-twist changes only the braiding by ε, so a trivial ε gives the same category.
- `plans/GLCinLean/GeometricLanglands/Satake/HalfTwistedHeart.toml`, `Satake.halfTwistedHeart_equiv_untwistedHeart`, last sentence: the identification over Ran is "in general incompatible with factorization". Found by the search.
- `plans-proof/GLCinLean/GeometricLanglands/SemiInfinite/ParabolicIC.toml`, `SemiInfinite.parabolicIC`: "In general no factorization equivalence relates the two settings", and the square root is "in general only a super line bundle". Found by the search.
- Checked and left as they are: `Satake.criticalDeterminantGerbe` (qualified in round 2); `Satake.chiralHeckeAlgebra`, which says that commutativity "would fail by signs on odd components" and so is already conditional; `plans/README.md` and `Statement.DmodHalf`, which speak of the trivialization of the gerbe on `Bun_G` and make no claim on factorization; `Examples.trivialGroup_isLanglandsFunctor_id`, which says that the gerbe of the trivial group is trivial; the proposal §6, qualified in round 2. The root file does not state the claim.

**2. The triples of Beauville–Laszlo.** Fixed in three places. Verified in AInfCohomology §AI.2.1 at `fe56342a`: the equivalence is from the `f`-torsion-free modules to the triples whose module over the completion is `f`-torsion-free, and "a module is finite projective exactly when both members of its triple are finite projective". The inventory now states only the part that is used.
- `docs/blueprint-providers.md`, the row of AInfCohomology in "Roadmaps that nodes here use as inputs": the finite projective modules over `R` are the triples of a finite projective module over the completion, a finite projective module over `R[1/f]` and an isomorphism.
- `plans/GLCinLean/GeometricLanglands/Hecke/LoopGroupAction.toml`, part (1): the same sentence now says "finite projective" for each of the three modules. Codex reads the earlier sentence as correct; it is made explicit so that it cannot be read as the wider claim.
- `notes/checks/loop-group-provider-proposal.md` §2.2: "the Beauville–Laszlo comparison for finite projective modules".

**3. The jet groups of `Aut(O)`.** Fixed in one place; the search found no other statement of the formula. Verified at the pin, `TauCeti/RingTheory/PowerSeries/Coordinate/Jet.lean`: `Jet R N` is the group of formal coordinates modulo `X^(N+1)`, and `jet_eq_jet_iff_coeff` compares the coefficients through degree `N`, so `Jet R 0` is trivial.
- `plans/GLCinLean/AlgebraicGeometry/LoopGroups/Basic.toml`, `LoopGroups.LoopGroup`, part (4): the N-th jet group is trivial for N = 0 and is represented by `𝔾_m × 𝔸^{N−1}` for N ≥ 1, with the group law of truncated composition.

**4. The coefficient bundle of the oper node.** Fixed in three places.
- `plans-proof/GLCinLean/GeometricLanglands/Spectral/Critical/IndCoh.toml`, `SpectralProof.opers_indPlacid`: the bundle "can be non-constant along X, and in general it has no specified trivialization; on an elliptic curve an invariant differential trivializes it".
- `notes/checks/loop-group-provider-proposal.md` §4, the row of the two users in `plans-proof/`, and §9, doubt 4: the same wording ("can be non-constant", "need not be constant").
- Checked and left: `LoopGroups.RanLoopGroup` (2) says that loops into "a target that is not constant along X" are not part of the node; this describes a class of targets and makes no claim on the bundle of the oper node.

## Improvements

**The end of the collision example.** Applied. `plans/GLCinLean/AlgebraicGeometry/LoopGroups/Ran.toml`, part (6), now ends: "So for 𝔾_a this restriction map is not an isomorphism on the diagonal."

**The inputs for the representability of the jets of `Aut(O)`.** Applied. `LoopGroups.LoopGroup` (4) names `TauCeti.FormalCoordinate.strictCoeffsEquiv` and `TauCeti.FormalCoordinate.homothety`, and its "Upstream declarations used" lists them with `TauCeti.FormalCoordinate.Jet`; all are in the pinned source.

## Not changed

The answers of rounds 1 and 2 are not edited; where they repeat a claim that this round corrects (the oper bundle "that is not constant" in `loop-group-provider-answers-2.md`), this file is the correction.

## Checks

`lake exe tracker lint` has no errors (61 warnings on the superseded fields of the statement). `python3 tools/check-module-cycles.py`: 170 module plans, 286 nodes, 0 cycles. `tools/check-upstream-names.py` of `main`, run from the scratch space: 204 pairs, and every pair that this branch names is confirmed; the two unconfirmed pairs are the older ones that `main` has corrected. No Lean file changed in this round.
