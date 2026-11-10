# Status

Updated 2026-11-10.

## Current state

- **Statement.** `GLCinLean/Statement/Conjecture.lean` and `GLCinLean/Statement/Enhanced.lean`. The main theorem is `GLCinLean.Statement.exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence`: a functor with the two properties of [GLC1] Cor. 1.6.5 exists, and every such functor is an equivalence. Its proof is the only `sorry`.
- **Placeholders.** 30 declarations are `@[placeholder]` (`grep -rn '@\[placeholder\]' GLCinLean`). None is replaced yet.
- **Plan.** `plans/` has 483 planned declarations in 225 module-plan files, including 70 that name existing Mathlib or Tau Ceti declarations. `prompts/build.md` works through it.
- **Reviews.** The last reviewed commit is `b64c7fc`: the review of 2026-11-10 approved the statement and the plan there, and its small findings were answered in `d63877d`. The earlier reports are in git history, under `notes/reviews/`.
- **Checks.** `lake build` passes with only the main theorem's `sorry` warning. `lake env lean tools/check-statement-axioms.lean` shows `sorryAx` only for the main theorem. `lake exe tracker lint` has no errors.
- **Pins.** Mathlib `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`, Tau Ceti `e0610cce4004d628cbd9d2aafdbbb5459fe72938`. The upstream snapshots that the plan was checked against are in `docs/blueprint-providers.md`.
- **Tau Ceti pull requests.** None opened.

## Cautions that stay open

- **Trivial placeholders.** A placeholder can be read as a trivial object, and then the main theorem is empty or easy. If `RootDatumDuality` is empty, no `Setting` exists and the theorem says nothing. If the categories are one-point types, the predicates always true and `LinIso` always inhabited, the theorem is trivially true. So each replacement comes with examples that rule this out (`prompts/build.md`, `plans/README.md`).
- **Deferred deep input.** `Constructible.decompositionTheorem` ([BBD]) is the only use of a theory of weights. The owner chooses its proof route (ℓ-adic purity or Hodge theory) when work reaches it. The tracker has no "not ready" state, so `prompts/build.md` holds it back.

## Decisions taken

- 2026-11-10, Q1: parity of IC stalks over C goes through the simply connected group, Bott–Samelson pushforwards and the decomposition theorem ([JuteauMautnerWilliamson] §4).
- 2026-11-10, Q2: one chosen pinning of the Tannakian group, with `Satake.dualIdentificationChangePinningIso` showing that another choice changes nothing essential.

## Open decisions for the owner

These three answers were proposed by the plan session. They are proposals until the owner decides.

1. **Open Tau Ceti roadmap pull requests.** Use them as design evidence, with their exact head recorded. The accepted roadmap stays the authority until a proposal merges. Never import a proposal's `Suggested.lean` or pin this project to an unmerged branch. Relevant now: TauCetiRoadmap #1901 (HigherToposTheory), #1630 (EnhancedDerivedSheaves amendment), #868 (DerivedDeRhamCohomology).
2. **Other Lean libraries.** Read-only discovery and reuse of ideas under compatible licences. Adding a dependency first needs a list of the declarations used, compatible Lean and Mathlib versions, a licence check, an axiom audit and a comparison with the existing objects.
3. **The ∞-categorical layer.** Build the enhanced theory on Mathlib quasicategories and Tau Ceti's DG nerve and K-injective models, following the accepted EnhancedDerivedSheaves and BordismFormalGroups targets. Do not start a competing foundation, and do not replace enhanced categories by triangulated ones.

## Next

The next sessions are in `prompts/next-steps.md`.
