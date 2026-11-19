# Answers of the planner, round 1

Branch `proposal/theta-characteristic-existence`. The reports are of `9cc2b70`: `theta-characteristic-existence-codex-1.md` (Codex) and `theta-characteristic-existence-check-1.md` (the checker). Both agree with dropping the three nodes from both plans. Every point below is accepted. "The proposal" is `notes/checks/theta-characteristic-existence-proposal.md`.

## The points

**Codex 1 and checker M1 (the agreement with [GLC1] and the necessity of the Jacobian): accepted, with Codex's wording.** Verified: `GLCinLean.lean`, "Differences of the statement from [GLC1]", records a restriction of the ground field and three readings of `Setting` (the connected curve, the pinning, the duality datum), so "the same objects as the paper" was too wide. The proposal shows which proof was planned, not that every proof needs the Jacobian.

- Proposal, section 5, "Decisions taken": the sentence that began with "Why" is now "[GLC1] §1.3.2 and [GLC2] §1.1.1 fix a square root of the canonical line bundle. `Statement.Setting` records this choice as an invertible sheaf and a squaring isomorphism. Every construction and example in the two plans can be stated with this choice or supplies its own. The proof considered for the general existence theorem uses the Jacobian and surjectivity of multiplication by 2 on its points over an algebraically closed field."
- `plans/README.md`, first paragraph, last sentence: "One proof uses the Jacobian of the curve and surjectivity of multiplication by 2 on its points over the algebraically closed field (JacobianChallenge, Layers D and E)."

**Codex 2 (degree additivity still has a user): accepted, with Codex's wording.** Verified: `Stacks.schemeRootGerbe` says that the root gerbe of `𝒪(1)` on ℙ¹ has no object over ℙ¹ "because n · deg M = 1 has no solution", and names `projectiveLine.eulerDegree_twistingSheaf`. `Curves.thetaCharacteristicProjectiveLine` uses the degree of `𝒪(−1)^{⊗2}`. Both use the degree theory of ℙ¹, so the removed row of `LineBundleClass.eulerDegreeHom` stays removed.

- Proposal, section 5, "Open items", first item: "Remove the open item on offering a smooth-curve corollary of `deg Ω = 2g − 2` to Tau Ceti. Its only remaining planned application is to ℙ¹ in `Curves.thetaCharacteristicProjectiveLine`. The projective-line examples still use the degrees of tensor powers. No remaining node calls for the degree-one formula for the divisor of a section on a general smooth proper connected curve."

**Codex 3 (the plan also uses results of Layer A): accepted, with Codex's wording.** Verified: JacobianChallenge §A.3 "Degree" at `1b7b481a` covers the degree of a line bundle and its additivity under tensor product (`LineBundleClass.eulerDegree_mul`, `LineBundleClass.eulerDegree_mul_of_smooth`).

- `docs/blueprint-providers.md`, "Other facts about these areas", the bold opening of the item on JacobianChallenge: "**JacobianChallenge has one remaining plan node, in Layer B.**" The rest of the item is unchanged.

**Checker M2 (D.8 has no named target for the `k`-points): accepted, with the checker's wording; the construction is completed as Codex's first improvement says.** Verified: the removed node `Curves.picardZero_isAbelianVariety` (at `0c1bcf5`) says "The clause on k-points has no named target: it follows from the exact sequence of D.1 for a curve with a section and `rigidifiedPicardDegreeZeroFunctorIso`".

- Proposal, section 5, "Open items", second item: "Once Tau Ceti has the Jacobian (JacobianChallenge D.8), the identification of its `k`-points with the line bundle classes of degree zero (no named target; it follows from D.1 and `rigidifiedPicardDegreeZeroFunctorIso`) and `multiplication_isogeny` (E.7), it is a short corollary of Tau Ceti's degree theory: choose a point `x₀ ∈ X(k)`, put `M = 𝒪((g − 1)x₀)`, and take a line bundle `N` of degree zero with `N^{⊗2} ≅ Ω ⊗ M^{−2}`; then `M ⊗ N` is a square root of `Ω`."

**Checker U1 (the branch reverses a decision of the owner): accepted.** Verified: `git show 6183267:STATUS.md`, decision 5 of the audit of 2026-11-13: "`Curves.nonempty_thetaCharacteristic` stays in the plan as the check that no curve is left out."

- Proposal, section 5, "Decisions taken", last sentence of the entry: "This replaces the owner's decision of 2026-11-13, which kept the theorem in the plan as the check that no curve is left out." The line after the entry says that the entry is for the case that the owner agrees.
- Proposal, section 5, new paragraph "The question for the owner": the entry for "Waiting for the owner", in six lines: what, why, the option "drop", the option "keep", each with what it costs and gives, and the positions of the planner, the checker and Codex.

**Codex's second improvement (the count "16 / 11" of roadmap candidate 6): the table is unchanged.** Proposal, section 5, "Open items", new last item: "New item for the next audit: the count "16 / 11" of roadmap candidate 6 in `docs/blueprint-providers.md` cannot be derived from its four folders, which hold 21 nodes in `plans/GLCinLean/` and 11 in `plans-proof/GLCinLean/`; the audit counts it again and names the modules it includes."

**The checker's note on the rule of `AGENTS.md`, "Plan"** (a roadmap node "is deleted only when its declaration is at the pin"): no change on the branch. The wording of that rule is the owner's.

## Other sentences with the same claims

Searched: `plans/`, `plans-proof/`, `docs/`, and sections 5 and 6 of the proposal.

- Corrected: proposal, section 4, the line that describes the item on JacobianChallenge in `docs/blueprint-providers.md`. It quoted the old opening ("the plan uses Layer B only") and now says "the area has one remaining plan node, in Layer B". This line is outside sections 5 and 6; it is changed because the replacement made it false.
- Examined and left, because they claim less:
  - `plans/GLCinLean/AlgebraicGeometry/Curves/Theta.toml`, `Curves.ThetaCharacteristic`: "[GLC1] §1.3.2 fixes a square root, Statement.Setting takes one as data, and no node uses the existence". It speaks of the theta characteristic only.
  - `plans/GLCinLean/GeometricLanglands/Examples/Setting.toml`: "Statement.Setting takes one as data, as [GLC1] §1.3.2 does". The same.
  - `docs/blueprint-providers.md`, the item on JacobianChallenge: "through the 2-divisibility of the `k`-points of `Pic⁰` (D.8 `JacobianVariety`, E.7 `multiplication_isogeny`)". It names the variety and the isogeny, and does not say that D.8 identifies the `k`-points with line bundle classes.
  - Proposal, section 5, "Workers": "The plan has no node on the Jacobian".
- `plans-proof/` has no sentence on these claims.
- Not changed: the Summary and sections 1 to 4 and 7 of the proposal, apart from the one line above. Three of their sentences still carry the wider claims of Codex 1: "The theorem costs the Jacobian of a curve" (Summary), "the Lean statement and [GLC1] Conj. 1.6.7 quantify over the same objects" (section 3, option (a)) and "the proof of it needs the Jacobian" (section 4). These sections are not applied to `main`.

## The merge

`main` at `9f37ba9` is merged into the branch as one merge commit, without conflict. The commit of `main` changes one sentence of `STATUS.md` and no fact of section 5.

## Counts and checks, on the merged branch

- `plans/`: 309 planned declarations in 196 module plans; 221 under `plans/GLCinLean/`, 31 of them the statement; 88 under `plans/Roadmap/`, in fifteen areas; JacobianChallenge has 1. 220 of the 221 have a roadmap node below them; the other is `GLCinLean.CategoryTheory.tensorPowFunctor`.
- `plans-proof/`: 195 nodes in 74 module plans. Placeholders: 28. `lake exe tracker ready`: 16 modules, with `Roadmap.JacobianChallenge.SerreDuality`.
- These are the counts of section 5; none changed.
- `lake build`: passes. `lake exe tracker lint`: status 0, no error, 61 "superseded" warnings. `python3 tools/check-module-cycles.py`: "196 module plans, 309 nodes, 0 cycles". `python3 tools/check-upstream-names.py`: "251 pairs of a declaration and its module; 0 not confirmed". No `deps` list names an unknown node, and no roadmap node of `plans/` is without a user.
