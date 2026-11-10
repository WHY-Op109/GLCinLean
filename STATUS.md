# Status

Updated 2026-11-09.

## Candidate and second-review repairs

The second review, `notes/reviews/2026-11-09-second.md` at `5914e73`, approved the logical
shape of the statement at `f6d537a` and requested changes to the 204-declaration blueprint at
`f1e69ec`. Its Satake and spectral-vanishing gaps were real. The former claim that the whole
construction chain was covered was too strong.

The local repair candidate is `76abe97114b8d757165492cb625fcee945a24dfd`. It tests
G1, G2 and P1–P7. All nine findings are confirmed, with
qualifications and exact references in `notes/blueprint-gap-resolution.md`. The new plans add
Satake geometry, reconstruction, enhancement and normalization; critical localization and
parabolic inputs for spectral vanishing; and the actual compactness/rigidity proof chains.
They extend IndCoh to prestacks, remove the duplicate characterization, and choose an explicit
future duality signature using two pinnings. There are now 443 declarations in 214 module-plan
files (213 contain declarations), including 66 direct upstream suppliers. The fresh independent
review in `notes/reviews/2026-11-09-repair.md` approves all nine repairs at that exact commit,
with no new blocking mismatch. It accepts the blueprint's construction and proof routes;
it does not certify the missing Lean implementations or resolve the statement placeholders.

Three rechecks followed, each by a fresh reviewer:

- `notes/reviews/2026-11-09-repair-recheck.md` (on `76abe97`): request changes (B1, B2, M1–M3).
- `notes/reviews/2026-11-09-repair-recheck-2.md` (on `834cc56`): request changes (R1, F1–F3).
- `notes/reviews/2026-11-09-repair-recheck-3.md` (on `a68cc53`): request changes (one blocker,
  M1–M5, S1–S6).

The latest commit answers the third recheck. It has not been reviewed yet. The plan now has:

- Semisimplicity of the spherical heart (`Satake.sphericalHeart_semisimple`), proved in
  D-modules over k from parity of IC stalks (`Satake.icStalkParity`, even D-module degrees),
  constancy of equivariant restrictions, and even de Rham cohomology of the strata
  (`Hecke.schubertStratum_deRhamCohomology_even`). Parity over k comes from the complex statement
  `Satake.icStalkParity_complex` by comparison through Q̄ and C, using `DModules.analyticDeRham`,
  `DModules.schubertRiemannHilbert`, the constructible nodes and `DModules.regularHolonomic`.
  Reductivity then uses `TauCeti.reductiveCommHopfAlgProperty_iff_linearlyReductive`.
- Complex parity (owner decision Q1, 2026-11-10): reduce to the simply connected group
  (`Hecke.affineGrassmannian_reducedComponents`, `Hecke.iwahoriWeylGroup`,
  `Groups.simplyConnectedCover`), push forward along Bott–Samelson resolutions, which gives parity
  complexes (`Hecke.bottSamelsonPushforward_parity`, [JuteauMautnerWilliamson] §4.1), and apply the
  decomposition theorem. [LusztigQAnalog] §11 is kept only as a cross-check of the statement.
- **Known deep input (not a blocker):** `Constructible.decompositionTheorem` ([BBD]) is the only
  use of a theory of weights. Its proof route (ℓ-adic purity or Hodge theory) is decided when
  work reaches it. The tracker has no "not ready" state: the node will appear in
  `lake exe tracker ready` once its three `Constructible.*` dependencies are proved, so its
  description and `prompts/build.md` are what hold it back. It does not affect the Lean statement.
- A half-twisted factorization spherical category, compared with the untwisted heart only at a
  point.
- One spherical action on Dmod_1/2(Bun_G) (`Hecke.sphericalAction`,
  `Hecke.renormalizedSphericalAction`), the lift of naive Satake along non-ren,
  `Hecke.action_viaRenormalized`, and `SpectralProof.naiveSatakeIsoDerivedSatakeInverse`
  with the Chevalley involution (`Groups.chevalleyInvolution`,
  `Satake.sphericalChevalleyInvolution`).
- [ParabolicEisensteinFH] Appendix A without its semisimple simply connected hypothesis
  (`SemiInfinite.parabolicIC_colimitDescription`). The FH results are re-proved in the
  half-twisted setting of [GLC3] §§1.1 and 1.3.
- The dual identification (owner decision Q2, 2026-11-10): one chosen pinning of the Tannakian
  group (`Satake.tannakaPinning`, made for the Aut(O)-equivariant heart), the pinned isomorphism
  `Satake.dualIdentification` used everywhere, and `Satake.dualIdentificationChangePinningIso`,
  which shows that another choice changes every action only by a monoidal isomorphism.
- The module structure built from the vanishing (`Spectral.actionOfVanishing`), through the
  unital independent category (`Hecke.unitalIndependentRepresentations`,
  `SpectralProof.localUnitalAction`, `Spectral.localization_factorsThroughIndependent`,
  `Hecke.action_factorsThroughIndependent`, `Hecke.unitalIndependentRepresentations_rigid`).
  The rank induction is explicit.

There are now 483 declarations in 225 module-plan files, including 70 direct upstream
suppliers. The owner decided both open questions on 2026-11-10, as recorded above.

The same commit makes the three Lean changes of the second review, so the statement changed:

- L1: the unused placeholder `MonoidalDGCat.toDGCat` is removed; `A.regularModule.toDGCat`
  stands for the category underlying `A`.
- L2: the main theorem is renamed (final name under U1 below) so that its name spells both
  conjuncts.
- L3: the docstring of `MonoidalDGCat.regularModule` cites [AGKRRV] §0.9.4 and [GLC1] §1.4.1.

The statement remains in `GLCinLean/Statement/Conjecture.lean` and
`GLCinLean/Statement/Enhanced.lean`. The fresh review `notes/reviews/2026-11-10.md` (on
`ef1ab1f`) approved L1–L3 and requested plan changes (M1–M3, S1–S11) and a clearer theorem name
(U1). The follow-up commit makes them:

- M1: Bott–Samelson parity is stated for Iwahori orbits; the step to L+G-orbits uses the
  L+G-equivariance of IC_λ.
- M2: the route cites [JuteauMautnerWilliamson] Prop. 4.11 and no longer uses Thm. 4.8.
- M3: `Hecke.action_localUnital` plans the unitality of the Hecke action.
- U1: the main theorem is renamed
  `exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence`, because
  `A_and_B_of_C` would read as "C implies A and B".
- S1–S11: records, sources, one split node (`Satake.isLanglandsFunctor_iff_of_changePinning`),
  Mathlib suppliers for the constructible derived category, and the regularModule citations.

Nothing is pushed until the owner approves.

## What is not implemented

The blueprint is a plan for future proofs, not a completed formalization. All 30 statement
placeholders remain. The first and second reviews found no definite formula mismatch but
recorded 29 unresolved meanings (28 after L1 removed `MonoidalDGCat.toDGCat`) and possible trivial interpretations. In particular, the
opaque duality relation does not establish that Setting is inhabited. Singleton/zero
interpretations of categorical placeholders can trivialize the intended mathematics.

Replacement requires actual constructions, characterizing APIs and nontrivial examples.
The planned tests include a nonempty geometric setting, point categories, a singular derived
affine, zero singular support and torus normalization. None is added as an assumption of the
main theorem. The geometric Satake heart, its factorization enhancement, and the derived
spherical equivalence needed in the spectral proof are distinct constructions.

## Verification

The required caches were fetched with the pinned configuration, including the full Tau Ceti
cache command. The build on 2026-11-10 passes (8173 jobs), with only the main theorem's
`sorry` warning and no Mathlib or Tau Ceti Lean source rebuild. The axiom audit checks all 33
explicit statement declarations: only the main theorem uses `sorryAx`; all others use subsets
of `propext`, `Classical.choice`, `Quot.sound`.

`lake exe tracker lint` exits 0 on the 483-declaration plan, with 144 superseded-metadata
notices and no other warnings or errors. The static audit finds no duplicate IDs, unresolved
dependencies or cycles; every node has a source, provider, checked revision and dependency
list, and every source key is in the bibliography. 464 of the 483 declarations are reachable
from the main theorem through the suggested graph; the other 19 are examples, API results and
the two choice-independence nodes `Satake.dualIdentificationChangePinningIso` and
`Satake.isLanglandsFunctor_iff_of_changePinning`. Superseded provenance notices are expected: the owner
requires source/provider/dependency records even where compiled declarations supersede them.
`prompts/build.md` was checked; it already requires provider inspection, nontrivial examples,
axiom checks and fresh owner-approved statement review, so no further edit is needed.
`prompts/plan.md` now names the actual statement paths.

## Provider snapshot

No dependency pin moved. Mathlib is `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`; Tau Ceti is
`e0610cce4004d628cbd9d2aafdbbb5459fe72938`. The original audit used Tau Ceti main
`7ca783d4c8d324c9c74efaacd641c8a40f69f284` and roadmap main
`f7dd719a392f7b65ad30ef45b26c344d08ba5f91`. Repaired/new nodes use the separately searched
snapshots `1e668f5e55bc20f2eb87f4ba49b48833470290d1` and
`000abc149867f86a79d9708294c89af6b42c37a6`. Unchanged nodes retain their historical checks.
Exact proposal heads and provider limitations are in `docs/blueprint-providers.md`.
PR #1056 was rechecked open at `d4bae7ce50e8fa1e08d9e1b91abacc4beacb721a`; its scope changes since the earlier `ccaed5e` check are recorded in the provider audit.

Existing DG nerves, mapping spaces, K-injective comparisons and Tannakian reconstruction
interfaces must be reused within their actual scope. A reconstruction theorem for a supplied
Hopf algebra is not a construction of the Satake Hopf algebra. Accepted roadmaps #908 and #785
are merged; open proposals are not implementations. No Tau Ceti contribution was opened.

## Proposed answers for the owner

### How should open Tau Ceti roadmap pull requests be used?

Use them as design and coordination evidence, recording the exact head, but keep accepted
roadmap ownership as the implementation authority until a proposal merges or its owner
explicitly resolves the scope. Work on accepted prerequisites through Tau Ceti Worker. Do not
import `Suggested.lean`, treat its admitted statements as implementations, or pin this project
to an unmerged proposal branch. This avoids duplicated foundations and unverifiable dependencies.

The relevant open proposals are [HigherToposTheory #1901](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1901),
which proposes ownership consolidation; the [EnhancedDerivedSheaves amendment #1630](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1630),
which prioritizes DG nerves and excludes prestack QCoh; and [DerivedDeRhamCohomology #868](https://github.com/TauCetiProject/TauCetiRoadmap/pull/868),
a possible supplier of cotangent and derived de Rham models. Recheck each before implementation.
Local ℓ-adic parameter stacks (#1202), p-adic Satake (#1235), and local opers (#1056) do not
supply the global de Rham constructions merely because their titles overlap.

### How may other Lean libraries be used?

Allow read-only discovery and reuse of ideas under compatible licenses. Before adding a
library, require a concrete declaration inventory, compatible Lean/Mathlib versions, a license
check, an axiom audit, and an explicit comparison with the existing objects. Prefer a small
compatible dependency or an upstreamed contribution over a second incompatible category or
scheme API. Roadmap-owned work still goes through Tau Ceti; other GLC constructions stay here.
No additional dependency is needed for this blueprint. This preserves the pinned build and
prevents an apparent shortcut from creating a larger interoperability problem.

### How should the infinity-categorical layer be handled?

Build the enhanced theory on Mathlib quasicategories and Tau Ceti's existing DG nerve and
K-injective models. Follow the accepted EnhancedDerivedSheaves and BordismFormalGroups targets
for presentability, stable k-linearity, coherent tensor/module structures, adjoints and compact
objects. Track #1901 and #1630 for ownership and construction order. Do not initiate a competing
foundation or replace the enhanced theory by ordinary triangulated categories.

Keep explicit statement placeholders until mapping-space universal properties and coherent
comparisons are proved, with examples that distinguish the construction from the zero category.
This retains the meaning needed by Corollary 1.6.5 and Proposition 1.7.2 while reusing existing
work. The three answers above are proposals for the owner, not newly adopted permissions.

## Next

1. The blueprint, the Lean changes L1–L3 and their fresh review are ready for the owner's
   decision. Do not push; the owner decides what to approve.
2. After approval, choose a genuine prerequisite using the plan and provider records. Accepted
   roadmap work goes through Tau Ceti Worker; uncovered GLC constructions stay here.
3. Require examples, build/axiom checks and fresh review at every placeholder replacement.
   The full proof of the main theorem follows the fully defined statement.
