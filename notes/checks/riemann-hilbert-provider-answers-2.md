# Answers to round 2 on `proposal/riemann-hilbert-provider`

The report of round 2 is `riemann-hilbert-provider-codex-2.md` (Codex). It judges the commits `cc49450..39d54ca` and has four open objections. This file has one entry for each. "Fixed" names the commit: `63164a2` for the plan and `docs/`, `9f0ca8f` for `GLCinLean.lean`, and the commit that adds this file for the note `riemann-hilbert-provider.md`.

After the fixes: `lake exe tracker lint` has no errors (the same 61 warnings as on `main`), `python3 tools/check-module-cycles.py` reports 197 module plans, 310 nodes and 0 cycles, `python3 tools/check-upstream-names.py` confirms all 335 pairs, and `lake build` and `lake lint` pass with the one `sorry` of the main theorem.

The numbers of [HottaTakeuchiTanisaki] that this file names were compared with the English edition: §1.5 (the external tensor product), Theorem 4.2.4, §4.7 (the definition of `DR_X` for an algebraic module), Theorem 5.3.8, Corollary 5.3.10, Remark 6.1.3 and Theorem 6.1.5.

## 1. The stability of regular holonomic complexes needs one provider, or a condition on the order of work

**Fixed in `63164a2` by a condition on the order of work in both nodes. The single provider is not chosen on this branch, because that choice is a change of provider of its own.**

What the branch has now:

- `DModules.regularHolonomicDeRham` says which clauses presuppose the stability: (3) for `f_+`, `f_!` and `f^†`, (5) for the external product, and (1) through the route of the target ("proper direct image and induction on the support"). It carries the condition: "this node is not taken up, and the stability theorem of DModules.IsRegularHolonomic is not written, before the provider of the stability for the left modules on smooth complex schemes is decided with prompts/change.md."
- `DModules.IsRegularHolonomic` carries the same condition for its stability theorem, and says that its definition does not wait. Its sentence on the request now names the external product and the restriction to the diagonal, which the request `gap:regular-holonomic-stability` has and which correspond to the !-tensor product of the node.
- Both nodes name the form to decide on: a roadmap node of its own for the request, in the area SpringerResolutionAndCharacteristicCycles, as a prerequisite of both nodes; the theorem of `DModules.IsRegularHolonomic` then reduces a field of characteristic 0 to the complex numbers.
- The external product in clause (5): neither roadmap defines the external product of D-modules (the README of SpringerResolutionAndCharacteristicCycles at `b24abdf7` has no external product of D-modules; MixedHodgeModulesAndIrregularHodgeTheory uses `⊠` and requests its stability). Clause (5) now states the definition, with [HottaTakeuchiTanisaki] §1.5, and the node lists it with the stability as a part beyond the target.

Why the shared upstream node is not added on this branch:

- It is the right form. Tau Ceti cannot import this project, so the correspondence of §1.5 can only use a stability that is in Tau Ceti; the request names its supplier; and `Infinity.derivedBimoduleTransfer` is the precedent of a roadmap node for a request (`gap:derived-bimodule-sheaves`). SpringerResolutionAndCharacteristicCycles §9.7 has the same shape for the stabilities that it does state: "First establish the stated complex-field theorem, then prove compatibility under algebraically closed characteristic-zero extensions".
- It is a change of provider. The decision "D-modules on smooth schemes: Tau Ceti provides the classical theory" of 2026-11-19 lists, under "Also written here, because no accepted roadmap states them", "the stability of regular holonomic complexes under the six operations with the curve criterion (`DModules.IsRegularHolonomic`)". The shared node moves the case of left modules on smooth complex schemes to Tau Ceti. `AGENTS.md`, "Small and big changes", lists "a change of provider: work moved between this project and Tau Ceti" as a big change.
- It changes the route of a node that the statement's plan uses. With the shared node, the theorem of `DModules.IsRegularHolonomic` must pass from a field of characteristic 0 to ℂ: descent of a holonomic complex to a finitely generated subfield, an embedding of that field into ℂ, the invariance (4) of `DModules.regularHolonomicDModule`, and the compatibility of the six operations with the extension of the field. The last is in `DModules.scalarExtension`, which depends on `DModules.IsRegularHolonomic`; so the stability theorem must leave that node, or the two modules form a cycle. These are choices for nodes of the Satake category, and they need their own comparison of options.

What holds until that change is decided: the condition in the two node texts. `lake exe tracker show` gives the node text to the writer and to the worker, so the text reaches both. The tracker does not enforce it: both nodes are far from ready (their dependencies are open roadmap nodes), and the list "Held" of `STATUS.md` is the tool that stops a worker. For the apply step: put `DModules.regularHolonomicDeRham` under "Held", released when the provider of the stability is decided, and record under "Open items" that the request `gap:regular-holonomic-stability` is in an accepted roadmap. The branch does not edit `STATUS.md`.

## 2. Step (f) needs the comparison of the two external products

**Fixed in `63164a2`: recorded as a proof obligation of `DModules.analyticDeRham_isEquivalence`.**

No node states the comparison: `DModules.shriekTensor` gives the external product of right crystals from IndCoh, and `DModules.rightCrystals_equiv_dModules` states the comparison of the pullbacks only. Step (f) now says: for smooth separated schemes `X` and `X′` of finite type of pure dimensions, the equivalences of `DModules.rightCrystals_equiv_dModules` for `X`, `X′` and `X × X′` and the side changes carry the functor that the external product of right crystals induces on the homotopy categories, on the complexes with bounded cohomology, to the external product of left D-modules of clause (5) of the roadmap node. It names three inputs, as Codex suggests: the equivalence is built through left crystals, whose external product is that of the underlying quasi-coherent sheaves; the sheaf of differential operators of `X × X′` is the external product of those of the factors; and `ω` of `X × X′` is the external product of the `ω` of the factors, for the side change and for the passage between left and right crystals. The node depends on `DModules.leftCrystalsEquivRightCrystals` for the last.

The obligation is with the theorem that uses it and not with `DModules.shriekTensor`: the classical external product is defined in the roadmap node of the correspondence, and `DModules.shriekTensor` is a node below IndCoh that must not depend on it.

## 3. The stratified converse uses C5.6 directly, and the tracker does not check it

**Fixed in `63164a2`: the converse is a clause of the roadmap node, and the node written here uses no statement of ComplexComparisonPartII directly.**

- `DModules.regularHolonomicDeRham` has a new clause (6): for a vector bundle `E` with an integrable connection that is regular in the sense of (a) of `DModules.regularHolonomicDModule`, `pDR(E) ≅ L[d]` for the local system `L` of the horizontal sections of `E^an`; every local system of finite rank on `X(ℂ)` arises so; hence, with (1), a regular holonomic module whose image is a shifted local system is a vector bundle with an integrable connection. In the book: Theorem 4.2.4, Theorem 5.3.8 with Corollary 5.3.10, and Remark 6.1.3.
- The node marks (6) as a part beyond the target, with the rule for a declined part. The target does not state it; its route names it as the base case ("on the smooth locus the base case is `deligneRiemannHilbert`").
- The node names the inputs of (6): the Poincaré lemma for a holomorphic connection, C5.6 `deligneRiemannHilbert`, and the regularity comparison that Codex asks for: C5.6 tests regularity on all maps from smooth curves and SpringerResolutionAndCharacteristicCycles §9.7 on the smooth locally closed curves, and "the proof of (6) includes that the two tests agree for a vector bundle with an integrable connection". The comparison of two notions of Tau Ceti is thus an obligation on the side of Tau Ceti, in the node whose source category is defined by the test of §9.7.
- `DModules.analyticDeRham_isEquivalence` cites (6) for both directions on a stratum and says that it uses no statement of ComplexComparisonPartII directly. Its dependency on `DModules.regularHolonomicDeRham` is in the graph, so the tracker checks the prerequisite of the local proof.
- The provider row is corrected: the row for C5.6 under "Roadmaps that nodes here use as inputs", with its claim that the tracker waits for C5.6, is removed. The notes on the area say that C5.6 is an input of clause (6), that no node written here uses it directly, and that the tracker does not check C5.6 itself.

## 4. Two source descriptions need a narrower formulation

**Fixed in `63164a2` (the formula) and `9f0ca8f` (the root entry).**

- The formula. For an algebraic complex the book defines `DR_X(M) := DR_{X^an}(M^an) = Ω_{X^an} ⊗ᴸ_{D_{X^an}} M^an` (§4.7). Reading (ii) of `DModules.regularHolonomicDeRham` and the row of `docs/papers.md` now say that the functor is the de Rham complex of the analytification, over the holomorphic differential operators. `riemann-hilbert-provider-answers-1.md` keeps the formula `Ω_X ⊗ᴸ_{D_X} M` where it quotes Theorem 4.6.3, which is about a complex manifold.
- The root entry. Its last sentences now read: the de Rham complex of an algebraic complex is that of the analytification; the statements belong to the analytic comparison, between D-modules and the constructible complexes on a complex manifold or on the complex points of a variety; "They are not formalized for the holonomic modules that are not regular, nor for the bounded complexes with holonomic cohomology that is not regular: nothing here uses the de Rham complex of such a module or complex." `lake build` and `lake lint` pass.

## The note

`riemann-hilbert-provider.md`, section 6, describes the branch with these answers applied (clauses (5) and (6) of the roadmap node, the condition on the order of work, the proof obligation of step (f)); fixed in the commit that adds this file.
