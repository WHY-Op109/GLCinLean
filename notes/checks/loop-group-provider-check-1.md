# Check of `proposal/loop-group-provider` (`e952ddb` on `d73f8b3`)

**Result.** The change of provider is right: the split into four nodes follows the roadmap text, the papers and `AGENTS.md`. One clause of `LoopGroups.RanLoopGroup` is false as stated (*mismatch*, small fix). One interface with `Derived.IsIndscheme` is open (*unsure*, small fix). Everything else is *agree*. No file was changed. `lake exe tracker lint` has 0 errors, and `python3 tools/check-module-cycles.py` reports 169 module plans, 285 nodes, 0 cycles.

Worktree: `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7`. No Lean file changed, so there is no blind reading and no degenerate-case check of a Lean definition.

## Mismatch and unsure

**M1. *Mismatch*: `LoopGroups.RanLoopGroup`, clause (3), is false for an arbitrary classical prestack Z.**
- Node (`plans/GLCinLean/AlgebraicGeometry/LoopGroups/Ran.toml`): "(2) Definition. For a classical prestack Z, 𝔏⁺(Z) and 𝔏(Z) are the classical prestacks over Ran(X) whose S-points over I are the maps D_I → Z and D°_I → Z", then "(3) Factorization. Over the locus of Ran(X)^J where the J points are pairwise disjoint, the pullback of 𝔏(Z) along the union map (Ran.union) is the product of the pullbacks of 𝔏(Z) from the J factors, by (1); the same holds for 𝔏⁺(Z)".
- Source, [GLys] §7.1.3: "Let $Z$ be a prestack. … The isomorphisms \eqref{e:disc factor} imply that $\fL^+(Z)$ and $\fL(Z)$ are naturally factorization prestacks over $\Ran$."
- The node copies the paper, and the paper has a gap. D_I and D°_I are affine schemes, and a disjoint union of two affine schemes is one affine scheme. So (3) needs Z(S₁ ⊔ S₂) = Z(S₁) × Z(S₂). An arbitrary functor on affine schemes does not have this property.
- Counterexample: Z the constant functor with value a set of two elements. Then 𝔏(Z) has two points over every (S, I). Over a disjoint pair the product of the two pullbacks has four points.
- Fix (small): state (3) for a Z that sends finite disjoint unions of affine schemes to products (every Zariski sheaf, every scheme, so H). Record the restriction as a correction of [GLys] §7.1.3 for the root file's "Differences from the sources". Clause (2), "𝔏⁺ and 𝔏 are functors of Z that commute with finite products", is true for every Z and stays.

**U1. *Unsure*: "classical ind-scheme" is used by two nodes, and no node states it.**
- `LoopGroups.LoopGroup` (3): "LH is a classical ind-scheme ([DGIndschemes] §1.1, the case n = 0 of the definition that Derived.IsIndscheme uses for every n)". `LoopGroups.RanLoopGroup` (4): "S ×_{Ran(X)} 𝔏(H) is an ind-scheme over S".
- Dependency, `Derived.IsIndscheme`: "Convergent derived prestack whose restrictions to n-coconnective test affines are filtered unions of quasi-compact quasi-separated n-coconnective schemes along closed embeddings."
- This predicate is about a derived prestack and asks every n. LH has no values on affine schemes that are not classical, so the predicate cannot be stated of LH. [DGIndschemes] §1.1 does define the notion that is needed: "We shall refer to objects of $^{\leq 0}\!\dgindSch$ as \emph{classical indschemes}". The citation is right; the plan node lacks the stage.
- Fix (small, on this branch, since `AGENTS.md` says to correct the nodes that the new nodes use): `Derived.IsIndscheme` names the n-coconnective stage with the classical case n = 0 as part of its API. This is doubt 5 of the proposal; it should be settled before the nodes are written, not after.
- A consequence for later, not for this change: the held `GLCinLean.AffineGrassmannian` and `DModules.EquivariantIndscheme` depend on `Derived.IsIndscheme`. When they are written they must say whether they take the classical stage or a derived prestack. No node has a passage from a classical prestack to a derived one (left Kan extension, [DGIndschemes] §9.1).

## Verdict for each item

| Item | Verdict |
|---|---|
| `LoopGroups.FormalLoopGroup` (new, roadmap) | *agree* with FormalConnectionsOpers §§3.1–3.2; two wording points below |
| `LoopGroups.coordinateChange` (new, roadmap) | *agree* with §1.2, §5.1, §6.3 and with Tau Ceti at the pin |
| `LoopGroups.LoopGroup` (new text) | *same object, different presentation* against the old node; U1 open |
| `LoopGroups.RanLoopGroup` (new) | *agree* with [GLys] §§7.1.1–7.1.4, 7.2.2 in (1), (2), (4), (5); *mismatch* M1 in (3); one check of (6) is loose |
| `Satake.criticalDeterminantGerbe`, `Satake.factorizationSphericalCategory` | *agree*: only the dependency and the name of the family over Ran changed |
| `docs/blueprint-providers.md` | *agree*: every name and module is at the pin |

## The seven points of the task

**1. Quotations, and the action on loops.** Every quotation of §§1.2, 3.1, 3.2, 5.1 and 6.3 in the two roadmap nodes is exact. The saved `fco-README.md` and `fco-Suggested.lean` have the same git blob hashes as the roadmap at `fe56342a` (`41bb59b1`, `5d15fe5d`). They are also unchanged on the roadmap's current main `68a511ab`. The area has no generated `STATUS.md`.

The action of `Aut(O)` on loops is a genuine prerequisite, and more than the proposal says. §6.3 orders it as a construction: "Convert §1.2's right substitution to a left action `ρ_φ = σ_(φ⁻¹)` on coefficients and Hopf-valued loops. Use the semidirect product `(g, φ)(h, ψ) = (g ρ_φ(h), φ∘ψ)`". The roadmap's "Scope and ownership" says it owns "the relative formal calculus over arbitrary coefficient algebras (Layer 1)" and "formal and polynomial loop groups". Its supplier note says "Layer 1 extends L1–L3 to arbitrary coefficient algebras `R` by construction", so substitution on `R((t))` for every `R` is this roadmap's, and FormalLaurentPuiseux has only the field case. The node's sentence that §5.1 "uses the action on the gauge group LG(R)" is an inference: §5.1 does not state it. It is a fair one, because the action on opers must be compatible with the gauge action of loops in N and B. The stated way back, if review declines it, is correct.

**2. The mathematics of `LoopGroups.FormalLoopGroup`.** All checked by hand.
- "Formally smooth" is the right hypothesis: lift step by step along the square-zero maps `R[t]/t^{M+1} → R[t]/t^M` and pass to the limit. Injectivity holds by the definition of K_N. The roadmap's bullet `L⁺G/K_N ≃ G(R[t]/t^N)` has no hypothesis; the node's version is the correct one over a ring.
- The counterexample holds: in `𝔽_p[t]/t^N` with N ≥ 2, `(1 + t^{N−1})^p = 1`, and `μ_p(𝔽_p[[t]]) = {1}` because `𝔽_p[[t]]` is a domain.
- The pieces `LG_{≤N}` with both bounds are representable; the next piece is cut out by the vanishing of one more coefficient of each `g(x_i)` and `g⁻¹(x_i)`, so the inclusions are closed immersions; the union is all of LG; two presentations are cofinal.
- The fpqc sheaf property is true for every H: `R((t)) → S((t)) ⇉ (S ⊗_R S)((t))` is an equalizer coefficient by coefficient, and `Hom(H, −)` keeps equalizers.
- The checks for 𝔾_m and 𝔾_a are right, including "t^M lies in LG_{≤N} exactly when |M| ≤ N".
- The generality (a commutative Hopf algebra over a commutative ring) agrees with `Suggested.lean`, whose `positiveLoopToFormal` has `[CommRing k]`, with `TauCeti.HopfAlgebra.congruenceSubgroup` and `TauCeti.FormalCoordinate` at the pin, and with "Lean code" (natural generality).
- Two wording points. "Its pieces are not of finite type." is false for the trivial group and for finite groups; `LoopGroups.LoopGroup` says it correctly ("when H has positive dimension"). "its checks are those of (5)" is loose: (5) also has 𝔾_a, and the trivial group is a check of §3.1.

**3. Side and order in `LoopGroups.coordinateChange`.** All correct. `σ_φ(σ_ψ f) = f∘ψ∘φ = σ_{ψ∘φ} f`. `ρ_φ ρ_ψ = σ_{φ⁻¹} σ_{ψ⁻¹} = σ_{(φ∘ψ)⁻¹} = ρ_{φ∘ψ}`, a left action. `ρ_{a·t}(t^n) = (a⁻¹t)^n = a^{−n}t^n`. The two-term check (`2t + 4t²` against `2t + 2t²`) is right. The semidirect law is the standard one for a left action. Tau Ceti at the pin has the same convention: the product of `FormalCoordinate` is `φ(ψ)`, and `(φ * ψ).substAlgEquiv = ψ.substAlgEquiv * φ.substAlgEquiv`.

**4. `LoopGroups.RanLoopGroup` and the two claims of representability.** The section numbers are right (checked with `tools/tex-locator.awk`), and (1), (2), (5) match the paper.
- First claim (the arc group is a limit of smooth affine group schemes over S): true. The multiples nD of the divisor of the graphs are finite locally free over S and cofinal; `nD ⊂ (n+1)D` is a square-zero thickening, so the transition maps are smooth and surjective for a smooth H. [GLys] §7.1.4 states it.
- Second claim (the loop group is an ind-scheme over S for every affine H of finite type, by the bound on the poles): **true as stated**. Locally on S the ideal of the divisor in the ring A of D_I is generated by a nonzerodivisor f. `f^{−N}A` is represented by an affine space over S, because each `A/f^n` is finite locally free over S. The equations of H are closed conditions, the inclusions are closed embeddings, and every element of `A[1/f]` lies in some `f^{−N}A`.
- The proposal's doubt 4 understates the source. The group of [GLys] is "a fixed connected algebraic group $G$ over $k$; our main interest is the case when $G$ is reductive" (the paragraph "Groups" of the conventions), and Theorem A.3.7 is for "an algebraic group". So §7.2.2 covers G, B, N and T, which are all the groups the plan uses. Only a disconnected H has no source.
- Is it needed? Not by the two users in `plans/`: `Satake.criticalDeterminantGerbe` needs gerbes on a group prestack, and `Satake.factorizationSphericalCategory` needs only the arc group (the first claim). It is API that the paper states. The proof by poles is still the right route, because the paper's route goes through the Grassmannian, which is held.
- One note for the text: the relative proof cannot reuse the roadmap's `LG_{≤N}`, which is tied to `R((t))`; where points collide there is no coordinate, only the local equation f. The node should say this as the reason that a parallel construction is written here ("Lean code", no duplicates).
- Check (6), last sentence: "over a point (x, x) of the diagonal it is the fibre at x, which for a nontrivial H is not such a product". As a statement about isomorphism classes this is false for 𝔾_a (`L𝔾_a ≅ L𝔾_a × L𝔾_a` by even and odd coefficients). State it for the arc group, where there is a natural map 𝔏⁺(H) → pr₁*𝔏⁺(H) × pr₂*𝔏⁺(H) over X × X: it is an isomorphism off the diagonal and the diagonal map on the diagonal, which is not an isomorphism for a nontrivial H.

**5. The reading "classical prestack", the users, and lost clauses.** The reading is right by [GLys] §1.2.1 ("the category of \emph{classical} affine schemes"; the loop group is "0-truncated"), and the plan already uses it in `Derived.PseudoProper` and `Actions.hyperbolicInterpolation`. The citations of [DGIndschemes] §1.1, §9.2.1, Proposition 9.2.4 and Theorem 9.3.5 are exact.
- The seven users in `plans/` each get what their text needs: the fpqc quotient (`GLCinLean.AffineGrassmannian`); functoriality for an isogeny and a torus and `L𝔾_m` (`…simplyConnectedCover`); evaluation at t = 0 (`iwahoriStratification`); the jet quotients and the pro-unipotent K_1 (`deRhamCohomology_schubertStratum_eq_zero_of_odd`); LN for a unipotent group (`Satake.semiInfiniteOrbits`); the family over Ran (the two Satake nodes).
- One small addition helps `…simplyConnectedCover`: say that L and L⁺ commute with kernels (fibre products of groups), not only with finite products; the central extension argument of [PappasRapoport] §6.1.1 uses it.
- No clause of the old node is lost: functors, the two presentations, coordinate changes, the families over Ran, "no reductivity or pinning", and the three sources are all in the four nodes.
- The three users in `plans-proof/`: `torusDerivedSatake_equiv` and `sphericalKL` use D-modules and the arc group, so the classical objects are enough, but both use factorization and will need `LoopGroups.RanLoopGroup`. `opers_indPlacid` needs more than "ind-scheme" (ind-placid), and any use of local systems on the punctured disc as a derived quotient would need the values on derived rings or [DGIndschemes] Theorem 9.3.5. The proposal leaves this to the plan of the proof; that is acceptable, because the tracker does not read `plans-proof/`.
- `LoopGroups.LoopGroup` (2) calls each J_N H smooth. This is available at the pin without a Hopf structure on the Weil restriction: `TauCeti.Algebra.WeilRestriction.instSmooth` (`TauCeti.RingTheory.WeilRestriction.Smooth`). The node should name it under "Upstream declarations used".

**6. Upstream names at the pin `b2350004`.** All exist, in the modules named: `TauCeti.HopfAlgebra.points`, `pointsFunctor`; `AlgHom.mapValue`; `TauCeti.HopfAlgebra.congruenceSubgroup` (with `congruenceSubgroup_normal`, `_mono`, `_iInf`, `_bot`); `congruenceQuotientEquiv` (for `I² ≤ J ≤ I`, with a lifting hypothesis) and `congruenceCotangentHom_surjective_of_formallySmooth`; `TauCeti.Algebra.WeilRestriction`, `.tensorHomEquiv`, `instFiniteType`, `instFinitePresentation`; `TauCeti.smoothCommHopfAlgProperty_of_charZero`; `TauCeti.FormalCoordinate`, `.substAlgEquiv`, `.substAlgEquivHom` (to the opposite group), `.map`, `.Jet`, `.jetLimitEquiv`; `TauCeti.LaurentSeries.substAlgEquiv` and `substAlgEquiv_mul` (over a field only); `TauCeti.finiteTypeCommHopfAlgCatOpEquivFiniteTypeAffineGroupSchemeCat`. The remark in `docs/blueprint-providers.md` that the trivial-intersection lemma is for a noetherian local ring only is right (`iInf_congruenceSubgroup_pow_eq_bot`).

**7. The options not chosen, and #1734.** The rejections of (b), (c), (d) and (e) follow "Sources of code". (a2) is better than (a1): five users do not need `Ran.FormalDisc`. #1734 is open at head `e16543f1`. Its §3.0 quotation is exact, it is for "a split connected reductive group over F", and its own ownership sentence lists "the loop Grassmannian, affine flag, convolution, Beilinson–Drinfeld and semi-infinite geometry", not loop groups; it names FormalConnectionsOpers only for §3A.5 over ℂ. So no outcome of #1734 changes the owner of the loop group. Not verified by me: the statements of proposal §2.2 on EndoscopicTransferAndUnitaryTraceComparison, AffineLieAlgebras and "the 23 areas added"; KacMoody was spot-checked and agrees.

## Breaches of `AGENTS.md`

- **"Lean code", adversarial reading of degenerate cases:** M1.
- **"Small and big changes", correct the nodes that the new nodes use:** U1.
- **"Writing", one term for each concept (minor):** "closed immersion" in `LoopGroups.FormalLoopGroup` and "closed embedding" in the two nodes written here, for the same notion.
- **"Writing", no text on what changed (minor):** `docs/blueprint-providers.md`, "The loop groups of FormalConnectionsOpers … have moved and are in the table"; say only where they are.
- **Design note, not a breach:** `LoopGroups.LoopGroup` is a bridge from functors on commutative algebras to the plan's prestacks. It is not a copy of the roadmap target, and the node says so. Its checks (5) repeat the checks of `LoopGroups.FormalLoopGroup` (5) nearly word for word; keep only what is new in terms of prestacks.
- **To apply together:** `STATUS.md` on the branch still lists `LoopGroups.LoopGroup` under "Held". The texts of proposal §7 must go to `main` in the same commit as the plan.

## Files

- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/plans/GLCinLean/AlgebraicGeometry/LoopGroups/Ran.toml` (M1, check (6))
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/plans/GLCinLean/AlgebraicGeometry/LoopGroups/Basic.toml` (U1)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/plans/GLCinLean/AlgebraicGeometry/Derived/Indscheme.toml` (the fix of U1)
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/plans/Roadmap/FormalConnectionsOpers/FormalLoopGroups.toml` and `CoordinateAutomorphisms.toml`
- `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a9f7725a45e8585d7/notes/checks/loop-group-provider-proposal.md` (doubt 4 understates [GLys])
- Sources: `/Users/why/Documents/Projects/GLCinLean/references/papers/1608.00284v7/src/text.tex`, `/Users/why/Documents/Projects/GLCinLean/references/papers/1108.1738v8/src/IndSchemestext.tex`, `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/roadmap/fco-README.md`
