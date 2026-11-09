# Status

Updated 2026-11-09.

## Candidate awaiting owner approval

The paper-led blueprint is in `plans/`, with 204 declarations. It covers the statement and its construction chain:
input geometry and duality, enhanced categories, derived stacks and local systems, QCoh and
IndCoh with singular support, half-twisted D-modules, Ran/Hecke/Satake, the spectral action,
Whittaker/Poincaré normalization, coarsening and the coarse functor. Existing upstream APIs
are named directly at the dependency boundaries. Each declaration records its paper locator,
provider, checked Tau Ceti revision and prerequisites. See `plans/README.md` for tracker caveats.

The statement candidate is locally committed as `f6d537a`. It has not been pushed. The current
files are `GLCinLean/Statement/Conjecture.lean` and `GLCinLean/Statement/Enhanced.lean`; the former
`Abstract.lean` and `Foundations.lean` were removed and every import was updated. Changes:

- State existence of a characterized functor and equivalence of every characterized functor.
  Remove the three other admitted theorems and the functor chosen from an admitted existence
  theorem; no definition now depends on `sorryAx`.
- Use provider declarations directly, including reductive groups in their coordinate Hopf
  algebra presentation; remove the thin adapter aliases.
- Keep the coefficient field, universe sizes, monoidal category, module actions and specified
  t-structure explicit in the enhanced placeholders.
- Correct the half-twist to the square-root gerbe of the normalized determinant on Bun_G;
  the theta characteristic trivializes it. Cite Proposition 1.7.2 for compatible linearity.
- Mark the opaque carriers and definitions built over them as placeholders. Add the two
  predicate characterization lemmas. Add the public entry point's missing documentation.

The fresh review is `notes/reviews/2026-11-09.md`, including a separate blind reading of stripped
Lean text. It found no definite mismatch in the implemented formulas, lists 29 unresolved
meanings, and tests all 31 placeholders for trivial interpretations. The owner must approve the statement changes with that report before any candidate
commit is pushed. The goal remains active until that approval and the push.

## What is not implemented

This is a blueprint and a corrected statement skeleton, not a completed formalization of GLC.
Enhanced operations, the derived geometric categories and functors, and general root-datum
duality still have placeholders. In particular the opaque duality relation does not yet prove
that Setting has an inhabitant, and singleton/zero interpretations of opaque categorical data
can trivialize the intended content. These facts are not hidden by the successful build or by
the tracker's `proved` count. Replacement requires actual constructions and nontrivial examples.

The plan includes dual-group existence, theta-characteristic existence and a concrete geometric
setting, plus point, singular-derived-affine, zero-support and torus checks. None is made an
extra assumption or an opaque proof of the desired conclusion.

## Verification

- Both required caches were fetched with the pinned configuration, including the full Tau Ceti
  cache command. No Mathlib or Tau Ceti Lean module was rebuilt.
- `lake build` passes; the sole Lean warning is the main theorem's admitted proof.
- `lake exe tracker lint` exits 0. Its remaining notices are superseded provenance fields kept
  because this blueprint explicitly requires `desc` and `deps` even for existing declarations.
- `#print axioms` was run for all 34 explicit statement declarations. Every definition and both
  predicate lemmas use only `propext`, `Classical.choice` and `Quot.sound` (or a subset).
  Only `exists_isLanglandsFunctor_and_isEquivalence` also uses `sorryAx`.
- The repeatable audit is `lake env lean tools/check-statement-axioms.lean`.
- Plan checks verify that IDs are unique, dependencies resolve, sources use bibliography keys,
  and every declaration records the checked Tau Ceti main revision.
- `prompts/build.md` was checked and updated for provider ownership, placeholder readiness,
  actual upstream availability, example obligations and the axiom audit.

## Provider snapshot

No dependency pin moved. Mathlib is `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`; Tau Ceti is
`e0610cce4004d628cbd9d2aafdbbb5459fe72938`. Tau Ceti main was searched at
`7ca783d4c8d324c9c74efaacd641c8a40f69f284`, and TauCetiRoadmap main at
`f7dd719a392f7b65ad30ef45b26c344d08ba5f91`. Exact providers and proposal heads are recorded in
`docs/blueprint-providers.md`. The source inventory is `notes/blueprint-paper-evidence.md`.

Existing DG nerves, right mapping spaces and K-injective comparisons must be reused. The
accepted EnhancedDerivedSheaves roadmap and ReductiveGroupsPartII roadmap are already merged
(#908 and #785 respectively); they are not open proposals. No Tau Ceti implementation pull
request was opened in this session.

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

1. Obtain owner approval of the reviewed statement candidate, then push the local commits to
   `WHY-Op109/GLCinLean` main.
2. Select a genuine open prerequisite using both tracker suggestions and the provider record.
   Route accepted roadmap work through Tau Ceti Worker; implement uncovered GLC mathematics here.
3. Repeat build, example checks and fresh review at each placeholder replacement. Only after
   the statement is fully defined should work proceed to the proof of equivalence.
