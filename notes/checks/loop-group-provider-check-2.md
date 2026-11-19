# Second check of `proposal/loop-group-provider` (head `e8b53f9`, base `d73f8b3`)

**Result.** No *mismatch* and no *unsure* remains. Nothing in the content blocks the application to `main`. One step of the application needs care: `main` has moved to `6712788` since `d73f8b3`, the merge has one conflict (`docs/blueprint-providers.md`), and the counts in proposal §7 are right for the branch but wrong after the merge (details under item 8). Three small follow-ups are listed at the end; none of them blocks.

Checks I ran in the worktree `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7`, changing no tracked file: `lake exe tracker lint` has 0 errors; `python3 tools/check-module-cycles.py` gives 170 module plans, 286 nodes, 0 cycles; `lake build GLCinLean` succeeds with only the `sorry` warning of the main theorem. I did not rerun `lake lint` or the axioms check.

## 1. My findings of the first check

| Finding | State |
|---|---|
| M1: `LoopGroups.RanLoopGroup` (3) false for an arbitrary prestack Z | **Resolved.** (3) now asks for "a classical prestack Z that sends the disjoint union of two affine schemes to the product of the values: a disjoint-union-local prestack ([GLC2] §B.3.2)", and records the difference from [GLys] §7.1.3 as a correction, with the counterexample. [GLC2] §§B.3.2 and B.4.1 do state this condition. |
| U1: "classical ind-scheme" used but stated by no node | **Resolved.** `Derived.IsIndscheme` names the stage at each n and the extension (item 2). |
| "Its pieces are not of finite type" | Resolved: "need not be of finite type and need not be reduced", with three examples. |
| "its checks are those of (5)" | Resolved: the roadmap's checks "are among those of (5); the checks for 𝔾_a are added by this node". |
| Collision check of `RanLoopGroup` (6) | Resolved: stated for the arc group with the restriction map; the μ_3 remark is correct (`μ_3(ℚ[[t]])` is trivial, and the diagonal fails exactly over test rings with a cube root of unity other than 1). |
| Reason for the parallel pole-bounded pieces over S | Resolved, in (4). |
| L and L⁺ commute with kernels | Resolved, in `LoopGroups.LoopGroup` (1). |
| `TauCeti.Algebra.WeilRestriction.instSmooth` named | Resolved. The Weil restriction also has a Hopf structure at the pin (`instHopfAlgebra`, `pointsMulEquiv`, `mapBialgHom` in `TauCeti.Algebra.HopfAlgebra.WeilRestriction`); the nodes and the document now say so. |
| "closed immersion" and "closed embedding" | Resolved: "closed embedding" everywhere. |
| "have moved" in `docs/blueprint-providers.md` | Resolved. |
| Repeated checks in `LoopGroups.LoopGroup` (5) | Resolved: one check in terms of prestacks (ℤ × L⁺𝔾_m has the points of L𝔾_m over reduced R only), which is correct. |
| [GLys] covers connected groups | Resolved, in `RanLoopGroup` (4). |
| `STATUS.md` applied with the plan | Stated in §7. |

## 2. `Derived.IsIndscheme`: *same object, different presentation* against `d73f8b3`; *agree* with [DGIndschemes]

- The old first sentence said "filtered unions … along closed embeddings" at every n. The new one says "filtered colimits", with "a map of n-coconnective schemes is a closed embedding when the map of the classical truncations is one, and for n = 0 such a colimit is a filtered union". This is the definition of [DGIndschemes] §1.1: "a colimit of a functor … where the category $A$ is filtered", with closed embeddings defined on classical truncations. At a positive n a closed embedding is not a monomorphism of spaces, so "union" was a loose word for the same definition. The `source` field did not change. No Lean declaration exists yet. So the predicate is the same, and I find the meaning unchanged: this is not a big change of its own.
- The general predicate ("convergent, and each restriction is an n-coconnective ind-scheme") is the definition in §1.4.1, exactly.
- The stage n = 0 is "classical indschemes" of §1.1, exactly.
- The extension is right: Lemma 1.4.7 (the convergent completion of such a colimit is a DG ind-scheme) and §1.4.8 ("$\CX:={}^{\on{conv},L}\!\on{LKE}(\CX_n)$ … the convergent completion of the same colimit taken in PreStk", fully faithful, with the unit an isomorphism). The remark that the left Kan extension alone is not used is correct.
- Users in `plans/`: `Derived.deRhamCechNerve_formalCompletion`, `Sheaves.qcoh_formalCompletion_localization`, `Sheaves.indcoh_formalCompletion_localization`, `DModules.indscheme_compactlyGenerated` and `DModules.EquivariantIndscheme` use the full derived predicate, which is unchanged. `LoopGroups.LoopGroup`, `LoopGroups.RanLoopGroup` and `GLCinLean.AffineGrassmannian` use the stage n = 0. For the Grassmannian and the loop group the extension gives the derived object of the paper, because [DGIndschemes] Theorems 9.3.4 and 9.3.5 say that these are 0-coconnective.

## 3. `Hecke.loopGroupAction`: *agree* with [GLys] §§7.2.1–7.2.2 and [GLC2] §§B.1.8, B.4.10, 1.1.2

- **Claim.** `Gr_{G,Ran}` as G-bundles on S × X with a trivialization off the graphs is [GLC2] §B.1.8. The comparison with bundles on `D_x` trivialized on `D°_x`, and the equivalence of bundles on `D_x` and on the formal disc, are [GLys] §7.2.1 and [GLC2] §B.4.10. That the pairs have no automorphisms is true (the complement of the divisor is schematically dense, G is affine).
- **Sides.** Correct and consistent: loops act on the left by changing the trivialization; the orbit map of the unit section is left equivariant and invariant under right multiplication by arcs; the Grassmannian is the étale quotient by the right arc action; the left arc action remains. This matches [GLys] §7.3.1, `Hecke^loc ≃ 𝔏⁺(G)\Gr_G ≃ 𝔏⁺(G)\𝔏(G)/𝔏⁺(G)`.
- **Inputs.** The map of pairs from `D_x` and `D°_x` to S × X and the complement is in `RanLoopGroup` (1), from [GLC2] §§B.3.4 and B.3.7. I read both roadmap sections at `fe56342a`: AInfCohomology §AI.2.1 has "**Linear module patching across a principal divisor**. For any commutative ring `R` and non-zero-divisor `f` … A module is finite projective exactly when both members of its triple are finite projective", and RelativeFarguesFontaine §6.5 names `AInf.linear_module_patching` as its supplier. Neither Mathlib nor Tau Ceti has the theorem at the pin. Naming a roadmap input in the `desc` without a node follows `plans/README.md` ("names the roadmap targets that the construction uses") and the table "Roadmaps that nodes here use as inputs".
- **Dependencies.** `Hecke.Correspondence`, `LoopGroups.RanLoopGroup`, `Stacks.groupTorsor`, `GLCinLean.AffineGrassmannian`: right, and no cycle. The held Grassmannian is needed only for (4), and `Hecke.Correspondence` depends on it already.
- **One concept, canonical home.** Yes: the action and the quotient presentation of `Gr_{G,Ran}`, next to `Hecke.Correspondence`, which defines that Grassmannian.
- **Copy of another node?** Not of a held node: (3) is the family form, without a coordinate, of the quotient statement of `GLCinLean.AffineGrassmannian`, and (4) ties the two. There is one overlap with `Hecke.Correspondence`, which is follow-up A below.
- The checks (5) are correct (the k-points of the Grassmannian of 𝔾_m over one point are ℤ).

## 4. `LoopGroups.RanLoopGroup`: *agree* with [GLC2] §§B.1.1, B.3–B.5 and [GLys] §§7.1.1–7.1.4, 7.2.2

- **Base.** [GLC2] §B.1.1: "the set of finite-non-empty subsets of $\Hom(S_{\on{red}},X)$", and "the map $\Ran\to \Ran_{\dr}$ is an isomorphism". This is `Ran(X_dR)` of `GLCinLean.Ran`, the Ran space of the statement.
- **Discs.** Every section number is right (B.3.1, B.3.4 with Remarks B.3.5 and B.3.6, B.3.7, Example B.5.6). The lifts exist for every affine S, the multiples of D are cofinal because D is locally principal, and the divisor is Cartier in `D_x`, so `D°_x` is affine.
- **Pullbacks.** The families over `Ran(X)` and `X^I` as pullbacks are right: the discs of a point of `Ran(X)` depend only on its image in `Ran(X_dR)`. So the object over `Ran(X)` is that of [GLys] §7.1.3.
- **Formal coproduct.** [GLC2] §B.3.3 says "where ⊔ is the coproduct taken in $\on{PreStk}_{\on{disj-loc}}$"; the node says the same and gives the reason.
- **Representability (4).** Stated for each test scheme, as [GLC2] §B.1.9 defines local properties; Lemma B.4.8 (a) to (c) is quoted correctly.
- **Comparison (5).** I checked `i_{t′} = ρ_φ ∘ i_t` by hand: the two identifications differ by `σ_{φ⁻¹}`, and the test `ρ_{a·t}(t) = a⁻¹·t` agrees.
- **Generality.** The node states the constant target only, where [GLC2] §B.5.5 has an affine scheme over X. It records this with the reason, and no node of `plans/` needs more. Acceptable.

## 5. The entry in `GLCinLean.lean`: *agree*

It is accurate ([GLys] §7.1.3 says "Let $Z$ be a prestack" and claims factorization). It is under "Differences from the sources", "Errors and gaps found in the sources", in the form of its neighbours: key, number, what is missing, the counterexample, no history. `git diff d73f8b3 e8b53f9 -- GLCinLean.lean GLCinLean/` is six added lines inside the module doc comment; no declaration changed, no line is over 100 characters, and the file builds.

## 6. Edited nodes: each is a correction of wording or dependency, object unchanged

| Node | Verdict |
|---|---|
| `GLCinLean.AffineGrassmannian` (held) | *same object, different presentation*. The two sentences fix the reading "classical ind-scheme, with the extension for a derived prestack" and add the induced `Aut(O)` action ([MV] §2: "extend to an action of the semidirect product"). By [DGIndschemes] Theorem 9.3.4 the extension is the derived Grassmannian of the paper. |
| `Satake.criticalDeterminantGerbe` | *agree*. The gerbe on 𝔏(G) as the pullback along the orbit map is [GLys] §§7.2.4–7.2.6 and [GLC2] §1.1.14. The sentence on [GLC2] Remark 1.1.4 now matches the remark and its footnote; "in general" is the right quantifier. |
| `Satake.criticalTwistBunDeterminantEquiv` | *agree*. The added text says how the pullback is formed, through the local Hecke stack of [GLys] §7.3.1. New dependency only. |
| `Satake.factorizationSphericalCategory` | *agree*. Names the left arc action; "in general" added; dependencies changed. |
| `Satake.halfTwistedHeart_equiv_untwistedHeart` | *agree*: two words ("in general"). |
| `SemiInfinite.parabolicIC` (`plans-proof/`) | *agree*: "in general", twice. |
| `SpectralProof.sphericalKL` (`plans-proof/`) | *agree*: one more dependency. |
| `SpectralProof.opers_indPlacid` (`plans-proof/`) | *agree*: it now says that it builds the loops into `𝔞(ǧ)_{ω_X}`; [GLC2] §§3.1.7 and 3.2.4 are the right places. |

## 7. The two roadmap nodes: *agree*

- **`LoopGroups.FormalLoopGroup`.** The new claims are right: `LG_{≤0}` is `L⁺G`; the pieces depend on the presentation; for 𝔾_a with generators x and x², the first piece is `Spec k[a_{−1}, a_0, …]/(a_{−1}²)`, so not reduced; the checks carry their quantifiers ("over a nonzero ring", "a k-algebra F that is a field"). All new upstream names exist at the pin: `congruenceSubgroup_iInf`, `Algebra.FormallySmooth.exists_mkₐ_comp_eq_of_isAdicComplete`, the `IsAdicComplete` instance of `PowerSeries`, `WeilRestriction.instHopfAlgebra`, `pointsMulEquiv`, `instSmooth`, `LaurentSeries.of_powerSeries_localization`.
- **`LoopGroups.coordinateChange`.** `TauCeti.LaurentSeries.rescale : Rˣ →* (R⸨X⸩ ≃ₐ[R] R⸨X⸩)` exists over a commutative semiring, and `rescale_single` shows that it is `σ_{a·t}`. The checks "over ℚ" and "over 𝔽_2 the series 2t is zero" are right, and so is "moves the point t^n exactly when a^n ≠ 1".
- **Jets of `Aut(O)`** (in `LoopGroups.LoopGroup` (4)). `Jet R N` at the pin is "formal coordinates modulo `X ^ (N + 1)`", so level 0 is trivial and level N ≥ 1 is `𝔾_m × 𝔸^{N−1}`. `strictCoeffsEquiv` and `homothety` exist.
- **Generality.** The nodes now say that the plan needs the roadmap's own case and that the commutative ring is asked "where Tau Ceti's review accepts it". This is accurate and removes the risk I named in the first check.

## 8. The texts of proposal §§7 and 8

- **"Held" row.** States what the branch does. #1734 is still open at head `e16543f1` (read now). Nine nodes remain in the row.
- **"Decisions taken".** States the provider decision, the three nodes written here and `Derived.IsIndscheme`. It leaves out two things that the branch does and that a later reader needs: the held `GLCinLean.AffineGrassmannian` now reads as a classical ind-scheme with the induced `Aut(O)` action; and `Hecke.loopGroupAction` waits for a roadmap input (AInfCohomology §AI.2.1) that has no code and no worker of ours. One sentence each is enough; the second also belongs under the open items.
- **Counts.** Correct on the branch: 286 nodes in 170 module plans, 218 + 68, nine areas (I counted). After the merge with `main` they are wrong: `main` gained one roadmap area and one roadmap node, so the plan will have 287 nodes, 218 + 69, in ten areas, and the number of module plans must be counted again. I did not verify "217 have a roadmap node below them".
- **Worker entry (§8).** Agrees with the two roadmap nodes in steps, order, conventions and names (`mapBialgHom` exists). One difference: `LoopGroups.FormalLoopGroup` (5) lists the 𝔾_a checks and (4) lists "`LG_{≤0}` is `L⁺G`" as asked, and the worker prompt asks for neither. Either add them to the prompt or say in the node that they are checks of the plan. I did not validate the entry with `tauceti workers apply --check`.

## For the application to `main`

- `main` is at `6712788`. `git merge-tree main e8b53f9` reports one conflict, in `docs/blueprint-providers.md`; the other files merge. Recount for `STATUS.md` after the merge, and run the lint and the done check there.

## Follow-ups, none blocking

- **A. The Beauville–Laszlo comparison is now asked twice** ("Lean code": the general result first). `Hecke.Correspondence` says "Prove the Beauville–Laszlo comparison: after a choice of coordinate at a point x of X, the fibre over x … is the affine Grassmannian". `Hecke.loopGroupAction` (1) asks for the comparison for every S and x. The first is the case of the second for a constant point with a coordinate (with (3) and `RanLoopGroup` (5)), but the dependency runs from the new node to `Hecke.Correspondence`, so the special case cannot come from the general one. `Hecke.Correspondence` also names no roadmap input for it. Small change: move that sentence into `Hecke.loopGroupAction` (4), where it follows. Proposal §9, doubt 6, names the situation and leaves it.
- **B.** The two sentences for "Decisions taken" and the open item (item 8).
- **C.** The 𝔾_a checks in the worker prompt or in the node (item 8).

## Files

- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/plans/GLCinLean/AlgebraicGeometry/Derived/Indscheme.toml`
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/plans/GLCinLean/GeometricLanglands/Hecke/LoopGroupAction.toml` and `Correspondence.toml` (follow-up A)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/plans/GLCinLean/AlgebraicGeometry/LoopGroups/Ran.toml` and `Basic.toml`
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/plans/Roadmap/FormalConnectionsOpers/FormalLoopGroups.toml` and `CoordinateAutomorphisms.toml`
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/GLCinLean.lean`
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/notes/checks/loop-group-provider-proposal.md` (§§7 and 8)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/docs/blueprint-providers.md` (the merge conflict)
- Sources read: `/Users/why/Documents/Projects/GLCinLean/references/papers/2405.03648v3/src/Loc.tex` (Appendix B, §§1.1, 3.1–3.2), `/Users/why/Documents/Projects/GLCinLean/references/papers/1108.1738v8/src/IndSchemestext.tex` (§§1.1–1.4, 9.2–9.3), `/Users/why/Documents/Projects/GLCinLean/references/papers/1608.00284v7/src/text.tex` (§§7.1–7.3), and the two roadmap texts saved in `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/roadmap2/` (`AInfCohomology.md`, `RelativeFarguesFontaine.md`)
