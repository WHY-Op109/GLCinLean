# Answers to round 2 of the checks on `proposal/dmodules-smooth-schemes`

The reports are `dmodules-smooth-schemes-codex-2.md` and `dmodules-smooth-schemes-check-2.md`, both on `299a2d0`. "D/" is `plans/GLCinLean/AlgebraicGeometry/DModules/`. All five findings are fixed with the given wording; the deviations are named under each. The three improvements of Codex are applied.

## The five findings

**Codex 1. `DModules.indHolonomicShriek`, `plans-proof/GLCinLean/AlgebraicGeometry/DModules/IndHolonomic.toml`. Fixed.** The counterexample is right: for `g` from a countable disjoint union of points to a point, de Rham pushforward is the direct sum, which does not preserve products, so `g^*k` does not exist. Checked at [ChenNearbyCycles] Appendix A (`references/papers/2008.09349v3/src/main.tex`, lines 3527–3534 and 3609–3613): `Dmod` of an indscheme of ind-finite type is the left Kan extension along pushforwards, and `Dmod_hol(Y) ≃ colim` over *-pushforwards of the `Dmod_hol(Y_α)`. The sentence that began "Verify independence" is now Codex's text, in plain characters: "Prove independence of finite-stage factorizations and coherent composition. For a Cartesian square with change of base g : Z′ → Z representable by schemes of finite type, construct g^* on ind-holonomic inputs by its ambient partial adjunction, using finite-type base change on the finite-support generators. Prove g^* f_! ≃ f′_! g′^* on these generators and extend by colimits. For such a smooth g, deduce the formula with extraordinary pullbacks by the relative-dimension shift. For the diagonal squares used by the semi-infinite kernels, prove the extraordinary-pullback comparison in the corresponding kernel theorem." No deviation. No dependency changes: `DModules.holonomicShriek`, which is in its `deps`, has `DModules.starPullback` and `DModules.deRhamPushforward` below it.

**Codex 2 and checker M2. The `Vect_k`-linear structure. Fixed.**
- D/`DifferentialOperators.toml`, `DModules.rightCrystals_equiv_dModules`. The structure is stated once, here. Codex's sentence replaces the old one: "The node is a Vect_k-linear equivalence from the right crystals on X (DModules.RightCrystals) to Dmod^r_qc(X), where the action on the latter tensors complexes over k using the central action of k on D_X, t-exact for the right t-structure …". Before it stands the checker's sentence on why the action exists: "Complexes of k-vector spaces act on the complexes of sheaves of right D_X-modules by the tensor product over k, which preserves quasi-isomorphisms in each variable and so passes to the localization (Infinity.linearCategory)." Deviation: the checker's sentences "Dmod^r_qc(X) is k-linear", "The equivalence of this node is k-linear" and "This structure and this statement are part of the node" are not added, because Codex's sentence states them. No new dependency: `Infinity.linearCategory` is below the node.
- D/`DirectImage.toml`, `DModules.deRhamPushforward`. After the sentence on the bounded direct images, Codex's three sentences: "The comparison with the restricted transfer is an equivalence of continuous Vect_k-linear functors, using the equal left and right actions of k on D_{X→Y}. On finite-type schemes, construct the comparisons for changes of smooth ambient embedding and for restrictions to chart overlaps. Prove their coherence under refinement and composition so that the chart functors descend to the stated direct image." And the checker's reference: "and is k-linear" is now "and is k-linear for the structure of DModules.rightCrystals_equiv_dModules". No deviation.

**Codex 3. `DModules.IsRegularHolonomic`, D/`RegularHolonomic.toml`. Fixed.** Checked at the Springer README: §9.8 (line 1101) defines a strongly `H`-equivariant module by "a D_(H×Y)-linear isomorphism a^*M≅p^*M on H×Y satisfying the identity and cocycle compatibilities", with `a^*` and `p^*` the abelian smooth pullbacks, and asks for "compatibility with arbitrary characteristic-zero field extension and faithful descent"; §9.9 (lines 1125–1129) asks for "equivariant smooth descent" and "the component-group classification of strongly equivariant connections on an orbit", and states the classification "over an algebraically closed field with geometrically connected stabilizers". The clause "equivariant holonomic modules on a homogeneous space with connected stabilizers are regular" is replaced by Codex's text. Two deviations, both additions: the text is introduced by "Theorem of this node on equivariant modules:", and "(DModules.EquivariantIndscheme)" follows "crystal descent data for the action groupoid", so that the supplier is named; "Springer §9.8" is written "SpringerResolutionAndCharacteristicCycles §9.8". `deps` gains `GLCinLean.DModules.EquivariantIndscheme`.
- Section 5, entry "Strong equivariance": the last sentence is Codex's two sentences.

**Checker M1. `DModules.IsHolonomic`, D/`Holonomic.toml`. Fixed**, with the checker's sentence after "preserves the holonomic complexes." in (d): "For a closed immersion i with open complement j, the proof uses the triangle i_* i^! M → M → j_* j^! M and that j_* sends a holonomic complex to a holonomic complex; on smooth separated schemes of pure dimension this is DModules.holonomicDModule (6), through the comparison of DModules.deRhamPushforward." `deps` gains `GLCinLean.DModules.deRhamPushforward`. No deviation.

## The new dependencies

| Node | New dependency | Exists | Cycle | What it puts below the node |
|---|---|---|---|---|
| `DModules.IsHolonomic` | `DModules.deRhamPushforward` | yes | none: `DModules.IsHolonomic` is not below `DModules.deRhamPushforward` | only `DModules.deRhamPushforward`; its own dependencies were below already |
| `DModules.IsRegularHolonomic` | `DModules.EquivariantIndscheme` | yes | none: its `deps` are `DModules.RightCrystals`, `Derived.Prestack`, `Infinity.limits`, `Derived.IsIndscheme`, so it is not above `DModules.IsRegularHolonomic` | only `DModules.EquivariantIndscheme`; its own dependencies were below already |

`python3 tools/check-module-cycles.py` finds no cycle of module plans.

## The three improvements

- **The verification notes on [HottaTakeuchiTanisaki].** `docs/papers.md`, the row of the book: Chapter 4 is added (three nodes cite it), Chapters 7 and 8 are separated, and the last sentence is the checker's: "Definition 6.1.1, Theorem 6.1.6 and the chapter contents were compared with the English edition on 2026-11-19; the book is not in `references/`". D/`RegularHolonomic.toml`, `source`: "the book is not in references/, and the two numbers agree with its English edition".
- **Section 5, the decision:** "the base change of the !-pushforward is against *-pullback, and the node also gives base change against !-pullback along a smooth map".
- **Section 5, the worker guidance:** the open item now says "The entry of the worker `author-dmodules` is in the workers' configuration with `enabled = false`"; section 6 holds the entry itself.

## Other sentences with a corrected claim (step 4)

- "not pinned, the numbering is not checked" in the `source` of six roadmap nodes (`DModules.coherentDModule`, `DModules.transferModule`, `DModules.holonomicDModule`, `DModules.holonomicIntermediateExtension`, `DModules.regularHolonomicDModule`, `Infinity.derivedBimoduleTransfer`) is now "the book is not in references/; the chapter contents agree with its English edition", because the checker compared the chapters.
- "the sentence on equivariant modules" is "the theorem on equivariant modules" in D/`RegularHolonomic.toml` and in the Springer row of `docs/blueprint-providers.md`. In the entry "Strong equivariance" of section 5, the half sentence that the sections "are not compared with the plan's equivariant D-modules" is removed, because the comparison is now a clause of the node.
- Section 5, the entries "The interface of the two enhanced roadmap nodes" and "Older gaps of `DModules.deRhamPushforward`" now say what the two nodes state after Codex 2 (the linear structure, the comparison of linear functors, the comparisons of the chart functors as obligations).
- Section 5, the decision: the sentence "The proposal is `notes/checks/dmodules-smooth-schemes-proposal.md`" is removed, for the same reason as the worker reference.
- Section 4 of the proposal follows the new node texts.
- Searched and found no other place: "!-base change" (only the two nodes of `plans-proof/` with their open item), "k-linear", "homogeneous space", "numbers are not checked".

## The merge

`git merge main` at `1987892`, one merge commit (`0a10739`). One file conflicted, `docs/blueprint-providers.md`, in two places:
- the rows of upstream declarations: the five rows of `main` and the three of the branch are kept;
- "Accepted roadmaps that cover nodes written here": the first paragraph keeps the change of `main` (it no longer names the decomposition theorem) and the sentences of the branch on differential operators at the pin; the row of EtaleDualityAndPerverseSheaves is removed, as on `main`; the row of ComplexComparisonPartII keeps the sentence of `main` on its §§C6.0–C6.1 and the corrected sentence of the branch on C5.1; the row of SpringerResolutionAndCharacteristicCycles, which the branch had removed and `main` had extended, is kept for §11.3 only, with the two sentences of `main` on §11.3, and it points to "Roadmaps that own plan nodes" for Layers 8–9. The limits of Layers 8–9 that `main` had in that row are in "Limits of existing providers".

`DModules.analyticDeRham` has the text of `main`; no correction of this branch concerns it. `STATUS.md`, `AGENTS.md`, `prompts/` and `tools/` are those of `main`. `GLCinLean.lean` did not conflict; it differs from `main` by the entry on [DG2] only. The files `notes/checks/dmodules-smooth-schemes-*` stay; the files that `main` deleted are deleted.

Section 5 after the merge: the counts are corrected; the entry on the branch of the decomposition theorem is replaced by an entry on the analytification step, which that change did not decide; and a paragraph says what this change does to the three open items of `STATUS.md` (the de Rham comparison on singular schemes: text changes; the inputs of the Schubert example: left; the de Rham functor of §11.3: text changes).

## Counts and checks

- 312 nodes in 198 module plans; 222 written here (31 of the statement); 90 roadmap nodes in 15 areas (EnhancedDerivedSheaves 26, SpringerResolutionAndCharacteristicCycles 5, ComplexComparisonPartII 1, EtaleDualityAndPerverseSheaves 4); 221 of 222 with a roadmap node below; `plans-proof/` 195 nodes in 74 module plans; 28 placeholders; 16 ready roadmap modules.
- `lake exe tracker lint`: no errors. `python3 tools/check-module-cycles.py`: no cycle. `python3 tools/check-upstream-names.py`: 267 pairs, none unconfirmed; this round adds no upstream name. No roadmap node depends on a node written here. Suppliers: for the four nodes of `plans/` edited in this round, every node named as a supplier is among the `deps` or below them.
- No Lean file changed in this round, and `GLCinLean.lean` did not conflict, so the done check was not run again.
- An accident, repaired: a helper script of round 1 ran again by mistake and reverted two sentences in D/`DifferentialOperators.toml` and D/`RegularHolonomic.toml`; both files were restored to the committed text before the edits of this round.
