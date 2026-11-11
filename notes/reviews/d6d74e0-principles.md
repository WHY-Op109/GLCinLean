# Review of the plan against the principles

Commit reviewed: `d6d74e0`. Scope: the 239 nodes in the 120 module plans of `plans/` (197 written here, 42 owned by roadmaps). Not in scope: `plans-proof/`, and the meaning checks of `prompts/review.md`.

Question: does anything in the plan go against the current `AGENTS.md`, Mathlib's principles or Tau Ceti's principles? This includes narrow choices (less general than the natural generality), unused or over-strong hypotheses or instances, and abstractions that nothing uses.

**Result.** 24 problems. None changes the meaning of the main theorem. The most serious are structural: the planned files cannot be compiled as laid out (problem 1), and one held node blocks 38 nodes that do not need it (problem 2).

## Documents cited

- `AGENTS.md`, by line number at `d6d74e0`. Line 31: never duplicate Mathlib or Tau Ceti, and factor near-copies. Line 33: natural generality, no unused or over-strong hypotheses, no abstraction that nothing uses. Line 35: canonical home, one concept per file, minimal imports. Line 37: a theorem's name spells its conclusion.
- Tau Ceti Review rubrics (`TauCetiProject/TauCetiReview`, `rubrics/*.md` on `main`, fetched 2026-11-11), by file and line. `generality.md` lines 6–13; `reuse.md` lines 3 and 24–25; `placement.md` lines 9–12; `naming.md` lines 8–13; `documentation.md` lines 6–7; `correctness.md` line 31.
- Tau Ceti's `AGENTS.md` lines 17–21 (modest generalisation of existing code is always in scope).
- Mathlib: naming conventions (`mathlib.org/contribute/naming.html`: "Often the name of theorem simply describes the conclusion", and the capitalisation rules) and the review guide (`mathlib.org/contribute/pr-review.html`, "Is it general enough to support known future needs?").
- `tools/tracker/README.md`: a node id is the Lean name the declaration will have, and a module plan is one Lean module.

## A. The plan cannot be built as laid out

**1. Five groups of module plans import each other in a cycle.** A module plan is one Lean file, and Lean does not allow cyclic imports. The tracker checks cycles only between nodes, so `lake exe tracker lint` does not report these, and no module in a cycle can become `ready`. The groups, found by the script in the appendix:

- `Derived/DeRham` ↔ `Derived/FormalCompletion` (`Derived.deRhamCechNerve_formalCompletion` → `Derived.formalCompletion` → `Derived.deRhamPrestack`).
- `Sheaves/SingularSupport` ↔ `Sheaves/SupportTStructure` (`Sheaves.psi_eventuallyCoconnective_equiv` → `Sheaves.supportTStructure` → `Sheaves.indcohWithSupport`).
- `AffineGrassmannian/Basic` ↔ `Hecke/Correspondence` (`Hecke.affineGrassmannian` → `Hecke.correspondence`; `Hecke.correspondence_pseudoProper` → `Hecke.affineGrassmannian`).
- Nine modules: `DModules/{Coherent, Crystals, DirectImage, Holonomic, Operations, Twisting, Verdier}` and `Sheaves/{FormalCompletion, IndCoh}`. For example `DModules.extraordinaryPullback` (Operations) → `DModules.twistedCrystals` (Twisting) → `DModules.shriekTensor` (Operations), and `DModules.leftToRightCrystals` (Crystals) ↔ `Sheaves.upsilon_isEquivalence_of_smooth` (IndCoh).
- Seven modules: `Hecke/{Action, Satake}`, `Satake/{Cousin, DualGroup, Equivalence, Factorization}` and `Statement/Conjecture`. The statement is in it because `Satake.isLanglandsFunctor_iff_of_changePinning` (`Satake/DualGroup.toml:32`) uses the statement, while `Statement.heckeActionRight` → `Hecke.action` → … → `Satake.dualIdentification` (also `Satake/DualGroup`).

Against: `placement.md` lines 9–12; `AGENTS.md` line 35.

**2. The untwisted `!`-pullback depends on gerbes.** `DModules.extraordinaryPullback` (`DModules/Operations.toml:4`) is defined only in its twisted form, for an étale `μ_n`-gerbe on the target, although `DModules.rightCrystals` (`DModules/Crystals.toml:4`) already says "with !-pullback". So 65 nodes depend on `Stacks.etaleGerbe`, which is held for #853. Only 27 of them use a twist. The other 38 include `DModules.kashiwara`, `DModules.deRhamPushforward`, the whole Satake heart, `Spectral.localization` and `Statement.Loc`. Against: `AGENTS.md` lines 31 and 35; `generality.md` lines 9–10.

## B. Duplication of upstream or of the plan itself

**3. `Hecke.iwahoriWeylGroup` (`AffineGrassmannian/IwahoriWeyl.toml:4`) names no upstream declaration.** Tau Ceti at the pin has `RootPairing.affineWeylGroup` (`TauCeti/LinearAlgebra/RootSystem/Weyl/Affine/Basic.lean`), `RootPairing.extendedAffineWeylGroup`, `extendedAffineWeylGroupQuotientEquiv` (`W_ext / W_aff ≃ P∨ / Q∨`) and `fundamentalAlcoveStabilizer` (`.../Weyl/ExtendedAffine/`). Mathlib has `CoxeterSystem.length` (`Mathlib/GroupTheory/Coxeter/Length.lean`). The node defines the Iwahori–Weyl group, `Ω ≅ π₁(G)`, length and Bruhat order. `docs/blueprint-providers.md` does not list these declarations either. Against: `reuse.md` line 3; `AGENTS.md` lines 11 and 31.

**4. `Hecke.action` and `Hecke.satake` describe the same object.** `Hecke.action` (`Hecke/Action.toml:4`) is the "Action of Rep(H)_Ran on Dmod_1/2(Bun_G) by Hecke correspondences and Satake kernels" and depends only on `Hecke.satake`. `Hecke.satake` (`Hecke/Satake.toml:4`) is "The Hecke functors of Rep(Ǧ)_Ran on Dmod_1/2(Bun_G)", built as naive Satake followed by `Hecke.sphericalAction`. Against: `AGENTS.md` line 31; `reuse.md` lines 24–25.

**5. A root of a line bundle is defined twice.** `Curves.thetaCharacteristic` (`Curves/Theta.toml:4`) is a line bundle `L` with `L⊗L ≅ Ω¹`, on a smooth proper connected curve. The objects of `Stacks.rootGerbe` (`Stacks/Gerbe.toml:11`) are line bundles `M` with `M^{⊗n} ≅ L`. The theta characteristic is the case `n = 2`, `L = Ω¹`. Properness and connectedness are not used by the definition; they are used by `Curves.thetaCharacteristic_exists`. Against: `AGENTS.md` lines 31 and 33; `generality.md` lines 6–10.

**6. `Rep(H)` has two descriptions with no stated link.** `Hecke.representationCategory` (`Hecke/Representations.toml:4`) is the "Enhanced category Rep(H) of algebraic representations". `Hecke.spreadClassifyingStack` (`Hecke/Spread.toml:4`) says "its QCoh category is Rep(H)_Ran", that is, it uses `QCoh(BH)`. No node compares the two. The first also depends on `Groups.langlandsDual`, although `Rep(H)` exists for every affine algebraic group. Against: `AGENTS.md` lines 31 and 33.

**7. The coadjoint Chevalley map repeats a construction for a second representation.** `Groups.chevalleyMap` and `Groups.nilpotentCoadjointCone` (`Group/Nilpotent.toml:4,11`) name `TauCeti.adjointInvariantPolynomials` and `TauCeti.nilpotentConeIdeal` on Tau Ceti `main`, for the adjoint representation. Both cases are the invariant quotient and zero fibre of a representation. `chevalleyMap` also depends on `Derived.affineScheme`, which a classical construction does not need. This rests on the nodes' own text; the two Tau Ceti files on `main` were not read. Against: `AGENTS.md` lines 31 and 33; `generality.md` lines 9–10.

## C. Narrower than the natural generality

Each item is against `AGENTS.md` line 33 and `generality.md` lines 6–8 or 11–13, unless noted.

**8. `LocalSystems.classifyingStack` (`LocalSystems/DeRham.toml:4`) asks for a reductive group.** [ArinkinGaitsgory] §10 (`1201.6343v4/src/singsupp.tex`, line 6996) opens with "In this section G is an arbitrary affine algebraic group"; reductive starts in §11 (line 7850). `LocalSystems.deRham` inherits it. Likewise `Hecke.loopArcGroups` (`LoopGroups/Basic.toml:4`) depends on `Groups.pinnedData`, which loop and arc groups do not need.

**9. `Derived.formalCompletion` (`Derived/FormalCompletion.toml:4`) asks for a closed subprestack.** [DGIndschemes] §6.1 (`1108.1738v8/src/IndSchemestext.tex`, lines 5450–5530) defines `X^∧_Y = X ×_{X_dR} Y_dR` for any map `Y → X`. As a result, `Derived.deRhamCechNerve_formalCompletion` (`Derived/DeRham.toml:18`) carries "closed", "separated" and "finite type"; only its conclusion that the terms are indschemes needs them.

**10. `Sheaves.qcoh_formalCompletion_localization` (`Sheaves/FormalCompletion.toml:4`) asks for a scheme of finite type.** [DGIndschemes] §7.1 takes a DG scheme `X` and a quasi-compact quasi-separated closed subset `Y`, with the finiteness assumption of its §sss:fin codim.

**11. `Groups.pinnings_torsor` (`Group/Pinning.toml:11`) asks for an algebraically closed field.** Only its last clause (every element of `T_ad(k)` lifts to `T(k)`) needs it. The torsor statement holds over any field.

**12. `DModules.holonomicHom_fieldBaseChange` (`DModules/ScalarExtension.toml:4`) asks that both fields be algebraically closed.** Its proof by flat base change of de Rham pushforward needs only an extension of fields of characteristic zero. It also puts six conclusions under one name.

**13. `Stacks.associatedAdjointBundle` (`Stacks/Bundles.toml:11`) is one case of the associated bundle of a representation.** The roadmap node `Stacks.groupTorsor` already lists "associated bundles".

**14. `Hecke.ranSpace` (`Hecke/Ran.toml:4`) defines only the Ran space of `X_dR`.** `Hecke.ranPseudoProper` and `Hecke.correspondence_pseudoProper` also use the colimit of the `X^I`, which is the Ran space of `X`. The general object is the Ran space of any prestack.

**15. The constructible side is stated for one case.** `Constructible.derivedCategory` (`Constructible/Complex.toml:10`) needs only a stratified topological space and a coefficient field, not a ℂ-scheme and ℂ-coefficients. `DModules.perverseHeart` (`DModules/Perverse.toml:4`) is "glued on finite-dimensional Schubert unions". `DModules.schubertRiemannHilbert` (`DModules/RiemannHilbert.toml:4`) is stated only for finite unions of Schubert varieties, and `Constructible.decompositionTheorem` (`Constructible/Decomposition.toml:4`) only for a smooth source. Both are narrower than the theorems they cite. [HottaTakeuchiTanisaki] is not in the repository, so its text was not checked.

**16. `Actions.hyperbolicInterpolation` (`GroupActions/Hyperbolic.toml:4`) covers only locally linear actions.** Its user `DModules.hyperbolicRestriction` (`DModules/Hyperbolic.toml:4`) is stated "for G_m-actions on finite-type algebraic spaces", as in [BradenDG] (`1308.3786v4/src/braden.tex`, lines 628, 760). The user is wider than its input.

**17. Smaller cases.** `DModules.deRhamPushforward` (`DModules/DirectImage.toml:4`) asks for "quasi-compact maps of finite-type schemes"; every such map is quasi-compact. `Derived.artinStack` (`Derived/Stack.toml:4`) "includes almost finite type hypotheses", which is the separate node `Derived.locallyAlmostFiniteType` (also `AGENTS.md` line 34, "Bundle a named concept instead of repeating its assumptions"). `Sheaves.indcohTStructure` (`Sheaves/IndCoh.toml:25`) is for "the schemes and Artin stacks in scope", which is not a mathematical condition.

**18. Roadmap-owned nodes described more narrowly than their targets.** `Infinity.monoidalCategory` (`Roadmap/BordismFormalGroups/Monoidal.toml:4`) says "Coherent symmetric monoidal enhanced categories", but `Satake.factorizationSphericalCategory` is "not a symmetric monoidal DG category" and acts through `Infinity.moduleCategory`, which depends on it. `Infinity.rightAdjoint` (`Roadmap/EnhancedDerivedSheaves/Adjunction.toml:4`) depends on `Infinity.continuousLinearFunctor`, and `Infinity.rightKanExtension` on `Infinity.presentableCategory`, although neither notion needs them. `Groups.pinning_exists` (`Roadmap/ReductiveGroups/PinnedRootData.toml:17`) asks for characteristic zero; Tau Ceti's `reductiveCommHopfAlgProperty` (`TauCeti/Algebra/AlgebraicGroup/Reductive/Basic.lean:71`) has no such restriction.

**19. `Stacks.etaleGerbe` (`Stacks/Gerbe.toml:4`) fixes the band `μ_n`.** No step of the definition uses `μ_n`. [GLys] §1.3 (`1608.00284v7/src/text.tex`, lines 1505–1558) allows any abelian band, in most examples a constant torsion group, and roadmap proposal #853 has abelian bandings. The owner chose `μ_n` on 2026-11-11, and the review of `796c1eb` (point 1) accepted it as within the sources. So this is a judgement call, not a defect.

**20. `Statement.Setting` takes `[CharZero k] [IsAlgClosed k]`, which none of its fields use** (`GLCinLean/Statement/Conjecture.lean:50`). They are the project's scope, and the placeholders that will use them are opaque. Any change needs the owner's approval (`AGENTS.md` line 48).

## D. In `plans/`, but only the proof uses it

Each item is against `AGENTS.md` lines 23 and 33, and `generality.md` lines 11–13.

**21. Three parts have no user in `plans/`.** `Hecke.ranInclusions` (`Ran/Inclusions.toml:4`) serves only the second part of `Hecke.ranPseudoProper`, which `STATUS.md` ("Open items") already lists as used only by `plans-proof/`. `Groups.chevalleyInvolution` (`Group/Pinning.toml:4`, held) serves only one clause of `Satake.dualIdentification` ("It intertwines the Chevalley involutions"); the users of that clause are in `plans-proof/` (`Satake/Renormalized`, `DerivedSatake/Monads`), and 14 nodes of `plans/` depend on the held node. The Levi sentence of `Hecke.sphericalAction` ("For a Levi quotient M …") has no user in `plans/`.

**22. `Sheaves.passable` (`Sheaves/Passable.toml:4`) is used only in one case.** `Spectral.localization` applies `Sheaves.passable_tensorBaseChange` to the product `LS_H × (X^I)_dR`. The node promises that "The spectral-localization hypotheses theorem supplies nontrivial examples"; that theorem is `SpectralProof.localizationPassability`, in `plans-proof/`.

## E. Names, kinds and descriptions

**23. Names and kinds.** A node id is the Lean name the declaration will have.

- Capitalisation: types and propositions are in lowerCamelCase, for example `Derived.prestack`, `Sheaves.qcoh`, `Stacks.qca`, `Derived.quasiSmooth`, `Sheaves.passable`, `Derived.pseudoProper`. Mathlib uses UpperCamelCase for types and `Is…` for propositions, as the statement's own Lean code does (`DGCat`, `IsLanglandsFunctor`).
- Theorem names: some name a person or a topic, not the conclusion: `DModules.kashiwara`, `DModules.schubertRiemannHilbert`, `Constructible.decompositionTheorem`, `Stacks.qcaStratification`, `LocalSystems.quasiSmooth`, `Examples.torusNilpotent_is_zero`.
- Namespaces: general objects are under `Hecke.` (the Ran space, loop and arc groups, the affine Grassmannian). `DModules.leftToRightCrystals` is the functor `Υ : QCoh → IndCoh` on every prestack, not a D-module notion.
- Kinds: some nodes of kind `theorem` produce data that later definitions use: `Satake.criticalTwist_matchesBunDeterminant`, `Sheaves.zeroSupport_equiv_qcoh`, `Stacks.qcaStratification` ("Retain the cover and embedding data"), `Infinity.adjointableDiagram_limitAdjunction` ("construct the adjunction"), `Examples.nonemptySetting` ("Construct actual examples"). A Lean theorem cannot carry data.

Against: Mathlib naming conventions; `naming.md` lines 8–13; `AGENTS.md` lines 28 and 37.

**24. Twenty-two module plans share one of four generic descriptions.** Twenty use "Satake construction prerequisite. The DG enhancement and determinant normalization are separate from the heart equivalence.", "Finiteness prerequisites for the statement construction." or "Nontrivial checks of the indicated constructions, or their input existence theorem.". Two (`DModules/Coherent`, `DModules/Verdier`) say "Coherent D-module prerequisites for the compactness proof.", which is now in `plans-proof/`. The module `desc` becomes the module docstring. Against: `documentation.md` lines 6–7; `AGENTS.md` line 29. Also, `plans/GLCinLean/AlgebraicGeometry/Etale/` is an empty folder.

## Fix plan

Every node outside the statement is still open, so each fix is a text edit of the plan. `lake exe tracker lint` and the cycle script check the result, and `AGENTS.md` line 46 asks for a fresh-agent review of each changed definition.

1. **Separate the twisted pullback (problem 2).** Keep the untwisted `f^!` in `DModules.rightCrystals`, and make `DModules.extraordinaryPullback` the twisted functor only. The 38 untwisted users then depend on `DModules.rightCrystals`. This can be done because the node's own text says the twisted functor agrees with the untwisted one under a trivialization. It also frees `Spectral.localization` and `Statement.Loc` from the held gerbe nodes.
2. **Break the cycles (problem 1).** Move each node to the file its dependencies fit: `Derived.deRhamCechNerve_formalCompletion` to `Derived/FormalCompletion`; `Sheaves.psi_eventuallyCoconnective_equiv` to `Sheaves/SupportTStructure`; `Υ` and its equivalence on smooth schemes to one `Sheaves` file; the Beauville–Laszlo comparison out of `Hecke.affineGrassmannian`, as its own node; the two change-of-pinning nodes to a file after the statement; `Satake/Factorization` split into the category and the chiral Hecke algebra. Done when the script lists no cycle. This only changes where declarations live, which is what `placement.md` asks for.
3. **Reuse and merge (problems 3–7).** Split `Hecke.iwahoriWeylGroup` into a combinatorial part on Tau Ceti's groups and a geometric part here. Keep `Hecke.action` and delete `Hecke.satake`. Define one "n-th root of an invertible sheaf", with the theta characteristic as the case `n = 2` of `Ω¹`; this comes first, because `Curves.Theta` is the first build target. Say that `Rep(H)` is `QCoh(BH)`, or add the comparison. For the nilpotent cone, generalise Tau Ceti's adjoint construction to any representation; Tau Ceti's `AGENTS.md` lines 17–21 allow this without a roadmap entry. The result has one construction per concept, as `AGENTS.md` line 31 and `reuse.md` ask.
4. **Widen to the source's generality (problems 8–14, 17, 18).** Each edit replaces a hypothesis by the one the cited source states. The source's proof already covers the wider case, so no new mathematics is needed, and the result is at the natural level of `generality.md`. For problem 18 only the `desc` and `deps` change; the roadmap keeps ownership.
5. **Move proof-only parts to `plans-proof/` (problem 21).** This takes the held node `Groups.chevalleyInvolution` out of the statement's closure, and leaves in `plans/` only what the statement uses (`AGENTS.md` line 23).
6. **One rename pass and new module descriptions (problems 23, 24).** Do it before the first build session, while a rename is only text. `AGENTS.md` line 38 says what a rename must update.

Steps 1, 2, 5 and 6 need no decision from the owner.

## Decisions for the owner

- **Problems 15 and 16.** `AGENTS.md` line 32 allows a lemma weaker than the paper's when it only serves a proof. The owner's ruling of 2026-11-11 calls a theorem narrower than its source under-generalisation. The two meet at Riemann–Hilbert, the decomposition theorem and the interpolation. Recommendation: state each theorem under the abstract hypotheses its proof uses, with the Schubert case as an instance. The full theorems would be far more work, and a recorded exception would leave the rule unclear.
- **Problem 19.** Recommendation: a band parameter when #853 is resolved, since #853 already has it. `μ_n` stays the only case that the D-module twist uses.
- **Problem 20.** Recommendation: leave `Setting` until its placeholders are replaced, since each real definition will then show which instances it needs.
- **Problem 22.** Recommendation: at least fix the dangling example. Moving `Sheaves.passable` to `plans-proof/` is cleaner, but needs a product-only statement in `plans/`.

## Limits of this review

- `plans-proof/` was not reviewed.
- Paper numbering was re-checked only for the passages cited above.
- Most nodes do not state their base ring or field, so over-strong field hypotheses can only be checked when each is written.

## Appendix: the cycle check

Run from the repository root with `python3 <script> plans`. It reads every module plan, builds the graph of imports between module plans from the `deps` fields, and prints each strongly connected set of more than one module, with the edges inside it. It also prints the nodes with no dependent.

```python
import tomllib, sys, os, collections
root = sys.argv[1]
nodes = {}
for d, _, fs in os.walk(root):
    for f in fs:
        if f.endswith('.toml'):
            p = os.path.join(d, f)
            mod = os.path.relpath(p, root)[:-5].replace('/', '.')
            for n in tomllib.load(open(p, 'rb')).get('node', []):
                nodes[n['id']] = (mod, n.get('deps', []))
mg = collections.defaultdict(set)
for i, (m, deps) in nodes.items():
    for dep in deps:
        if dep in nodes and nodes[dep][0] != m:
            mg[m].add(nodes[dep][0])
idx, low, st, on, sccs, c = {}, {}, [], set(), [], [0]
sys.setrecursionlimit(10000)
def sc(v):
    idx[v] = low[v] = c[0]; c[0] += 1; st.append(v); on.add(v)
    for w in mg.get(v, ()):
        if w not in idx: sc(w); low[v] = min(low[v], low[w])
        elif w in on: low[v] = min(low[v], idx[w])
    if low[v] == idx[v]:
        comp = []
        while True:
            w = st.pop(); on.discard(w); comp.append(w)
            if w == v: break
        if len(comp) > 1: sccs.append(comp)
for m in {m for m, _ in nodes.values()}:
    if m not in idx: sc(m)
for comp in sccs:
    print(sorted(comp))
    for i, (m, deps) in nodes.items():
        for dep in deps:
            if m in comp and dep in nodes and nodes[dep][0] in comp and nodes[dep][0] != m:
                print('   ', i, '->', dep)
used = collections.Counter(d for _, ds in nodes.values() for d in ds)
print('no dependent:', sorted(i for i in nodes if used[i] == 0))
```
