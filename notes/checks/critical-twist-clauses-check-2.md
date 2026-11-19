# Second check of `proposal/critical-twist-clauses` at `7cf5422` (diff `1efd60a..7cf5422`)

## Result

M1, M2 and M3 are resolved. The planner's correction of my M1 wording is right, and my sentence was wrong. The node now determines the isomorphism of lines for each choice of the subbundle. One clause is missing for the claim of independence of `n` to be true as stated: the node does not say how the target lines for two subbundles are identified. One sentence of the node on the two contractions is loose. Both have exact replacement wording below. The unit test and theorem (1) are true as stated and are real tests. Section 5 is correct. I changed no file.

Files: `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a87d533c7732b9a79/plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml` ("the plan node file", node `desc` on line 16), `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a87d533c7732b9a79/plans-proof/GLCinLean/GeometricLanglands/Satake/Twisting.toml` ("the proof node file", node `desc` on line 6), `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a87d533c7732b9a79/notes/checks/critical-twist-clauses-proposal.md` ("the proposal").

## Mismatch

**N1. The refinement identification of the target is not named.** The plan node file, line 16, sentence "Prove that these identifications agree under common refinement, hence are independent of n and of the lifts defining D, and commute with pullback in S." Verdict: *mismatch* (wording, one clause).

- For subbundles `N₂ ⊂ N₁` the targets `Hom(det Q₂, det Q₂′)` and `Hom(det Q₁, det Q₁′)` are different lines. "Agree under refinement" needs an identification of them.
- With the identification in the same Hom form (cancel `det π_*(N₁/N₂)` on the left) the claim is true: additivity is associative for `N₂ ⊂ N₁ ⊂ E`, so `id_{A₂} ⊗ g₂ = id_{A₂} ⊗ id_K ⊗ g₁`.
- With the other contraction for the refinement, the claim fails by `(−1)^{rank(N₁/N₂)}`. That other choice is also consistent in itself, and `Satake.criticalDeterminantGerbe`, which owns the relative determinant, names neither. So a writer of that node can choose it without any error showing there.

Replacement for the sentence:

> For subbundles N₂ ⊂ N₁ of this kind, det Q₂ ≅ det π_*(N₁/N₂) ⊗ det Q₁ and likewise for Q₂′, and the lines Hom(det Q₂, det Q₂′) and Hom(det Q₁, det Q₁′) are identified by cancelling tensor product on the left by det π_*(N₁/N₂); the relative determinant of Satake.criticalDeterminantGerbe is formed with these identifications. Prove that the identifications above agree under common refinement, hence are independent of n and of the lifts defining D, and commute with pullback in S.

## Findings

**1. M1, M2, M3.**
- M1 (the plan node file, line 16): *resolved*, apart from N1. Graded lines with the Koszul rule are named with [GLys] §5.2.1; the two cofiber sequences and their order are stated; the normalization is cancelled; degree zero and the lifts are stated. The `source` (line 18) cites [GLC2] Proposition 10.1.11 with equations (10.5) and (10.6). I counted the equations in the TeX (`\numberwithin{equation}{section}`; `e:det loc` and `e:det glob` are the fifth and sixth of §10): *agree*.
- M2 (the proof node file, line 6): *resolved*. Units are stated for `x = y` with [GLC2] §10.1.2, and the composition over varying supports is stated as non-unital, with the reason.
- M3 (the proof node file, line 6): *resolved*. `U ⊂ Ran × Ran`, the equivalence onto `U ×_{Ran} H`, and the gluing of `P` off `Γ_x` to `P″` off `Γ_y` are correct. [GaitsgoryOutline] §4.4.2 has the fibre product over `(h_r, Bun_G, h_l)` and the map `id × ∪` (TeX lines 3001–3022): *agree*.
- The added `deps` of the proof node exist; `python3 tools/check-module-cycles.py` gives 198 module plans, 312 nodes, 0 cycles; every `deps` entry of `plans-proof/` resolves.

**2. The planner's correction and the node text.**
- The mathematics: *agree* with the planner. A graded line `A` of degree `d` has two contractions with its inverse: the evaluation after the symmetry, and the inverse of the coevaluation. Their ratio is the trace of the identity of `A`, which is `(−1)^d`. My sentence "the coherence of the Picard groupoid determines each contraction" was wrong: coherence fixes only maps built from one duality datum and the symmetry, and the inverse of the coevaluation is not of that kind. The contraction I named in round 1 (evaluation after the symmetry) is the one that is `(−1)^d` times the Hom form.
- Determination: *agree*. For a fixed `N` the Hom form is one map: `φ ↦ g` with `u′ ∘ φ ∘ u⁻¹ = id_A ⊗ g`. It uses no dual and no symmetry. It is the same whether additivity is written `A ⊗ det Q` or `det Q ⊗ A`, as long as both sequences use one order. The cancellation of the normalization (`f ↦ f ⊗ id`) and the identification of `L′ ⊗ L⁻¹` with `Hom(L, L′)` for lines of degree zero are also determined.
- Independence of `n` and of the lifts: true with the clause of N1. For two lifts, `E(−nD₁ − mD₂)` is a common refinement.
- The sentence "Written as a contraction of A with its inverse, this cancellation has two forms, which differ by the sign (−1)^d … only the form above is independent of n": *agree* in substance, loose in wording. The cancellation is one map; there are two contractions, and it is one of them. When `dim G` is even, `d` is even and the two contractions are equal, so "only" holds exactly when `dim G · deg D` is odd, as the "because" clause says. Exact wording, if wanted:

> As a contraction of A with its inverse, this cancellation is the inverse of the coevaluation 𝒪 → A ⊗ A⁻¹. The other contraction, the evaluation after the symmetry, is (−1)^d times it, for the degree d of A, and is not used: d, the rank of Rπ_*N, is dim G · (1 − g − n · deg D), so when dim G · deg D is odd the other contraction changes sign with n.

**3. The unit test and theorem (1).**
- Unit test (the plan node file, line 16): *agree*, true as stated. With `P′ = P` and `α = id`, `u′ = u`, so `id ↦ g` with `id_A ⊗ g = id`, hence `g = id`, for every `n`. It is a real test: the other contraction sends the identity to `(−1)^d` times the identity, and any constant sign error fails. It does not see a twist that is trivial on the unit section; only the construction fixes that.
- Theorem (1) (the proof node file, line 6): *agree*, true as stated. For one `N` inside the three adjoint bundles, `u″ψφu⁻¹ = (u″ψu′⁻¹)(u′φu⁻¹) = id_A ⊗ (h ∘ g)`. The two ratio lines have degree zero, so the order of the two tensor factors carries no sign. It is a real test: the other contraction fails it by `(−1)^d`. Its proof compares `N` with the subbundles `E(−nD_x)` and `E′(−mD_y)` of the two factors, which the refinement statement of N1 covers.

**4. Section 5 of the proposal** (lines 59–72 of the revised file).
- Counts: *agree*. `plans/`: 312 nodes, 198 module plans, 222 and 90. `plans-proof/`: 196 nodes, 75 module plans, 187 and 9, recounted at `7cf5422`.
- Decision text: *agree*. After "in graded lines with the Koszul sign rule" the words "and in the Hom form of the node" would name what fixes the sign; optional.
- Open item on `Sheaves.determinant`: *agree*; three users in `plans/`, and neither additivity nor graded lines is in its text.
- Note for the writers: *agree*. If N1 is applied, add to it: "the writer of `Satake.criticalDeterminantGerbe` forms the relative determinant with the refinement identifications of `Satake.criticalTwistBunDeterminantEquiv`".
