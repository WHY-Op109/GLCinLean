# Check of `proposal/dmodules-smooth-schemes` (`e46d54e`, `4aa51ad`, base `3eeb496`)

**Result.** No node is a *mismatch* with the roadmaps or the papers. Three findings are blocking, and each has a one-sentence fix below. Four items are *unsure* only because [HottaTakeuchiTanisaki] is not in `references/`. I changed no file. I did not run `lake build` or `lake lint`: the only Lean change is six comment lines, and I checked their length (at most 97 characters).

## Blocking findings

**B1. One of the four "preservation" theorems is in no node, but the STATUS texts say it is.** The "Decisions taken" entry says that "direct and inverse image along a general map preserve holonomic and regular holonomic complexes" is written here. The second "Open items" line says "It is a theorem of `DModules.holonomicShriek` and `DModules.IsRegularHolonomic`".
- Stated: de Rham pushforward of holonomic complexes (`DModules.holonomicShriek`), and the six operations on regular holonomic complexes (`DModules.IsRegularHolonomic`).
- Not stated in any node: !-pullback along a general map preserves complexes with holonomic cohomology. `DModules.IsHolonomic` only has "stability of the particular exponential pullback under the operations used for the vacuum object".
- A user needs it: `DModules.starPullback` says "On holonomic objects it is D f^! D (DModules.verdierDuality), with holonomic values".
- Fix, in `plans/GLCinLean/AlgebraicGeometry/DModules/Holonomic.toml`: after "and for the stability statements." add "Theorem of this node: !-pullback (DModules.extraordinaryPullback) along every map of schemes of finite type preserves the complexes with holonomic cohomology. No accepted roadmap states this theorem: SpringerResolutionAndCharacteristicCycles §9.1 defines f^† and states no preservation of holonomic modules by it." Add `'GLCinLean.DModules.extraordinaryPullback'` to `deps` (it is already in the closure).
- Fix, in the open item: "It is a theorem of `DModules.holonomicShriek` (pushforward, holonomic), `DModules.IsHolonomic` (!-pullback, holonomic) and `DModules.IsRegularHolonomic` (regular)".

**B2. The pullback comparison compares functors with different domains.** `DModules.rightCrystals_equiv_dModules` says the equivalences "carry the functor that f^! (DModules.extraordinaryPullback) induces on homotopy categories to f^† of DModules.transferModule (2)". The crystal functor is on unbounded complexes. The roadmap states its functors on bounded derived categories, and `DModules.transferModule` (2) gives no domain. The parallel clause of `DModules.deRhamPushforward` does say "on bounded complexes".
- Fix, in `plans/GLCinLean/AlgebraicGeometry/DModules/DifferentialOperators.toml`: "carry the restriction to the bounded complexes of the functor that f^! (DModules.extraordinaryPullback) induces on homotopy categories to f^† of DModules.transferModule (2)".
- Fix, in `plans/Roadmap/SpringerResolutionAndCharacteristicCycles/TransferModules.toml`, clause (2): after "f^†N = Lf^*N[n − n′]" add ", functors from Dᵇ of the left D_Y′-modules to Dᵇ of the left D_Y-modules (O_Y has finite Tor dimension over f⁻¹O_Y′, because Y′ is smooth)".

**B3. The counts of section 5 are right for the branch but stale for `main`.** `main` is now `54a0e9f`, three commits after `3eeb496`, with the new area FormalConnectionsOpers.
- On the branch I confirm: 304 nodes in 188 module plans, 220 written here (31 in the statement), 84 roadmap nodes in 13 areas (EnhancedDerivedSheaves 26, Springer 5, ComplexComparisonPartII 1), 15 ready roadmap modules, 219 of 220 with a roadmap node below, 28 placeholders.
- `main` has 222 nodes here and 78 roadmap nodes in 12 areas, in 184 module plans. After the merge the arithmetic gives 308 nodes in 192 module plans, 222 here, 86 roadmap nodes in 14 areas. The ready count and "219 of the 220" must be recounted.
- `git merge-tree main proposal/dmodules-smooth-schemes` reports a conflict in `docs/blueprint-providers.md`. `GLCinLean.lean` merges automatically.
- Fix: rebase, resolve the conflict, and recount every figure of section 5 before it goes into `STATUS.md`.

## Unsure (rest on memory; none blocks)

- **The two forms of "regular holonomic" give the same modules.** From memory, the new form (simple subquotients are intermediate extensions of regular connections) is the definition of [HottaTakeuchiTanisaki] §6.1, and the old curve condition is the definition of Bernstein and Borel. Their equivalence is a classical theorem; I cannot confirm where the book states it. No user relies on the curve form: no other file of `plans/`, `plans-proof/` or `GLCinLean/` mentions it. `DModules.perverseHeart` uses only regular connections, which clause (2) of `DModules.regularHolonomicDModule` covers.
- **Every chapter number of [HottaTakeuchiTanisaki]** in the `source` fields (Chapters 1, 1–2, 2–3, 3, 6). They match my memory of the book. The nodes already say "not pinned, the numbering is not checked".
- **`DModules.holonomicDModule` (6)** reads "stability of holonomicity under the operations used in intermediate extension" as: all cohomology modules of j_+E and j_!E are holonomic. §9.6 uses only H⁰. The node marks this as a reading, and `DModules.holonomicShriek` proves the general case here, so nothing depends on the stronger reading.
- **`Infinity.derivedBimoduleTransfer`** reads the contract `gap:derived-bimodule-sheaves` as a functor of stable quasicategories. The contract says only "compatible with additive K-injective models".

## Verdicts

| Item | Verdict |
|---|---|
| `DModules.rightCrystals_equiv_dModules` | *same object, different presentation*; fix B2. The sheaf form with quasi-coherent cohomology and the characteristic 0 hypothesis are correct. |
| `DModules.Coherent`, `DModules.IsHolonomic`, `DModules.intermediateExtension`, `DModules.verdierDuality`, `DModules.holonomicShriek`, `DModules.deRhamPushforward` | *agree*: the old sentences are kept word for word, and the additions are consistent. `DModules.IsHolonomic` needs fix B1. |
| `DModules.IsRegularHolonomic` | *same object, different presentation*; the equivalence is *unsure* (memory). |
| `DModules.differentialOperators` | *agree*. The definition by commutators is that of EGA IV 16.8.8. The target is named by the phrase "localization/sheafification on schemes", and Springer §8.1 takes "the order-filtered sheaf D_Y" from C5.1. |
| `DModules.coherentDModule`, `DModules.transferModule`, `DModules.holonomicIntermediateExtension`, `DModules.regularHolonomicDModule` | *agree*; named targets (§§8.1–8.2, 9.1–9.2, 9.6, 9.7). `DModules.transferModule` needs fix B2. |
| `DModules.holonomicDModule` | *agree* for (1)–(5); (6) is a marked reading. Placing (5) and (6) here is right: §9.3 needs §9.1 and §9.2, so the other order is a cycle. |
| `Infinity.enhancedDerivedCategory` | *agree*; named target E1.3 with the t-structure of §0.1. It is not a duplicate id. It overlaps `Infinity.derivedVect` (same target, for vector spaces) and `Sheaves.schemeQCoh` (which already uses `D∞(O_X)` with no node for it). The proposed open item covers this. |
| `Infinity.derivedBimoduleTransfer` | *agree* as a reading; not a named target. The folder is right, because Springer line 142 names EnhancedDerivedSheaves as the provider. `grep -c -i bimodule` on its README gives 0. |
| `GLCinLean.lean` entry | *agree*. |
| Worker `author-dmodules` | *agree*: 2,387 characters, same fields as the eight existing entries, one named target, no circular wait. |

## What I confirmed, by item of the brief

2. Every quoted line of section 2.2 is at the stated line of the READMEs of `fe56342a`: Springer 7, 14, 16, 19, 29, 140–142, 834, 857, 871, 909, 966, 968, 988, 992, 1005, 1018, 1040, 1053, 1077, 1079, 1549; ComplexComparisonPartII 152 and 3094–3119; FormalConnectionsOpers 731–743; EnhancedDerivedSheaves 431, 553, 555, 582. The generality is as the nodes say: left modules, smooth separated finite type of pure dimension, a field of characteristic 0, bounded ordinary derived categories.
4. The conventions hold. By [Crystals] Proposition `p:left to right t-struct`, the left and right t-structures differ by the shift n. So f^! of the right module Ω^{n′} ⊗ L is the side change of Lf^*L[n − n′] = f^†L.
   - Pullback cases: a point (f^!k = ω_X corresponds to O[n]); the identity; an open immersion; a closed point in the line (both give k in degree 0 from δ_0).
   - Pushforward: no shift. Γ_dR(Ω^n) is de Rham cohomology shifted by n on both sides, and i_*k = D/xD.
   - Duality: [DG2] §5.3.1 gives k_Z ≃ 𝔻(ω_Z). With ω ↔ O[n] and k_X ↔ O[−n] this is 𝔻O = O, as the roadmap's check on A¹ says.
5. At the pin `b2350004`, `TauCeti.differentialOperators R A M N m` is defined by recursion on commutators with the sign D∘(a·) − (a·)∘D. This is the roadmap's `IsDifferentialOperator`. The four named declarations and `Derivation.extendOfIsLocalization` exist with the stated content. #43231 is open at head `8c566546`, and its body has the quoted sentence and the move to `…DifferentialOperator.Basic`. Tau Ceti main is the pin, and TauCetiRoadmap main is `1b7b481a`, three commits and five files after `fe56342a`, as stated.
6. No accepted roadmap states the preservation theorems. Only the Springer README treats algebraic holonomic modules, and it has none of them. #2279 is open and has the quoted gap at its line 1144. "No node" is acceptable for now, because each user has the stating node in its closure, once B1 is fixed.
7. The numbers are right, counted from the TeX with the shared counter: [DG2] §5.1.9 Kashiwara, §5.1.17 coherence, §5.2.1 "the classical theory of D-modules constructs a continuous functor", §5.2.3 "there currently is no reference in the literature", §5.3.1 Verdier; [Crystals] §0.3, §5.4, Remark 5.5.1, §5.5.3, Remark 5.5.6. No PDF is in `references/`, so only the TeX is checked. The entry is under "Errors and gaps found in the sources", in the form of its neighbours. `e46d54e` changes only these six comment lines.
8. `lake exe tracker lint` has 0 errors; no cycle; 219 upstream pairs confirmed; no roadmap node depends on a node written here. Six statement nodes are above `DModules.differentialOperators`, and four are above the intermediate extension and the regular modules, as stated.
9. `DModules.perverseHeart`, `DModules.analyticDeRham`, `DModules.analyticDeRham_isEquivalence`, every `Constructible.*` node and every held node are unchanged. In `Perverse.toml` only the two lines of `DModules.intermediateExtension` differ.

## Improvements that can wait

- **The enhanced nodes state less than their users need.** `DModules.deRhamPushforward` needs a continuous k-linear functor. `DModules.rightCrystals_equiv_dModules` needs the forgetful functor to `D∞(O_X)` and the restriction functors to opens for Zariski descent. `Infinity.enhancedDerivedCategory` gives only the category and its homotopy category, and `Infinity.derivedBimoduleTransfer` gives an exact functor with no linear structure. EnhancedDerivedSheaves §0.4 (`ClassicalDerived.functorCoherence`) is a named target for part of this. Add it to the open item on "Older gaps".
- **`Infinity.derivedBimoduleTransfer` bundles two functors.** The contract lists the tensor product and the pushforward separately, and §0.4 may already cover the pushforward. Two clauses would be more reusable.
- **The tracker will show Springer modules as ready too early.** `DModules.coherentDModule` depends only on `DModules.differentialOperators` in the plan, but in Tau Ceti it also waits for FormalConnectionsOpers F2.2, AlgebraicVectorBundles and SchemeAndStackFoundations §0.2, which are not plan nodes. Add an open item, so that the session checks these inputs before it starts a worker.
- **"a smooth affine scheme"** in `DModules.Coherent`, `DModules.IsHolonomic` and `DModules.IsRegularHolonomic` should be "an affine space" or "a smooth affine scheme of pure dimension". The classical input is stated only for pure dimension.
- **`docs/papers.md`.** The row of [HottaTakeuchiTanisaki] says "(Chapters 2–3, 6–8); used only for the comparison over C"; the new nodes cite Chapter 1 and use the book for the classical theory. The row of [LurieHA] lacks §1.3.5.
- **`GLCinLean.lean` entry.** "which constructs it on triangulated categories" is not a statement of [DG2]; the paper says the formulation for ∞-categories "is not straightforward". The paper's schemes are DG schemes. Optional rewording.
- **Writing.** "Written here, as before" in the "Decisions taken" entry refers to an earlier version; drop "as before".

Files: `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a78f16a71d48bad2e/notes/checks/dmodules-smooth-schemes-proposal.md` (the proposal); the roadmap READMEs under `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/rmrepo/TauCetiProject-TauCetiRoadmap-fe56342/TauCetiRoadmap/`; `/Users/why/Documents/Projects/GLCinLean/references/papers/1108.5351v3/src/Finiteness.tex`; `/Users/why/Documents/Projects/GLCinLean/references/papers/1111.2087v4/src/Crystalstext.tex`.

