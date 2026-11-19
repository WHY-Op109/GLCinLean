# Check of `proposal/theta-characteristic-existence` at `9cc2b70` against `main` at `0c1bcf5`

## Result

The removal is right by the papers and by the plan: I found no mathematical mismatch, the object of each edited node is unchanged, and every count of section 5 is correct. There is one *unsure* that the session must settle before it applies the change: the branch reverses an explicit decision of the owner (2026-11-13: "`Curves.nonempty_thetaCharacteristic` stays in the plan as the check that no curve is left out"), and the proposal does not say so. There are two small wording mismatches, each with a replacement below. An example in positive genus is not needed for a faithful statement. The branch changes no Lean file, so there is no Lean item and no blind reading was needed. I changed no file.

Worktree: `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a57ea827054e569f5`.

## Unsure and mismatch

**U1. The change reverses a decision of the owner, and the proposal is silent on it. Verdict: *unsure* (authority, not mathematics).**
- Evidence: `git show 6183267:STATUS.md`, line 159, decision 5 of the audit of 2026-11-13: "`Examples.exists_setting_rank_pos` uses the theta characteristic 𝒪(−1) of ℙ¹ … `Curves.nonempty_thetaCharacteristic` stays in the plan as the check that no curve is left out." Line 134, the owner's decision "Theta (A)" of 2026-11-11, gave the theorem its own module plan and its JacobianChallenge inputs. The commits are `f79facd` and `b8587fb`. Commit `3cb5781` (2026-11-18) removed both entries from `STATUS.md` when it made the file shorter ("The full text of the earlier decisions and the history stay in git"). The sentence that the branch deletes from `plans/GLCinLean/GeometricLanglands/Examples/Setting.toml` line 6 is the text of that decision.
- The proposal (`notes/checks/theta-characteristic-existence-proposal.md`, sections 2 and 5) names neither decision. `AGENTS.md` does not say whether an agreement of the planner and Codex may replace a decision of the owner.
- Recommended action: the session puts the question under "Waiting for the owner" before it applies the branch, or at least states the reversal in its reply. In either case the "Decisions taken" entry (proposal line 102) gets this sentence: "This replaces the owner's decision 5 of 2026-11-13, which kept the theorem in the plan as the check that no curve is left out (`git show 6183267:STATUS.md`)."
- Note for the owner's choice: the general theorem is the only node that gives the check "no curve is left out". An example in genus one does not give it. Keeping the theorem does not block the first goal, because no placeholder is above it; its only cost is one ready roadmap module without a worker.

**M1. `plans/README.md` line 3, last sentence: "Its proof needs the Jacobian of the curve (roadmap JacobianChallenge, Layers D and E)." Verdict: *mismatch* (wording only).** The sentence claims necessity. The proposal's own evidence (section 3, option (c)) is that no route without the Jacobian was found. Replacement: "The known proof uses the Jacobian of the curve: the 2-divisibility of the `k`-points of `Pic⁰` (roadmap JacobianChallenge, Layers D and E)." The same clause in the "Decisions taken" text (proposal line 102), "its proof needs the Jacobian, which Tau Ceti does not have", becomes "the known proof uses the Jacobian, which Tau Ceti does not have".

**M2. Proposal line 109, new open item: "Once Tau Ceti has the Jacobian with its `k`-points (JacobianChallenge D.8) and `multiplication_isogeny` (E.7), it is a short corollary". Verdict: *mismatch* (small).** D.8 has no named target for the `k`-points. The removed node recorded this (`plans/Roadmap/JacobianChallenge/Jacobian.toml` at `0c1bcf5`, line 6: "The clause on k-points has no named target"). Replacement: "Once Tau Ceti has the Jacobian (JacobianChallenge D.8), the identification of its `k`-points with the line bundle classes of degree zero (no named target; it follows from D.1 and `rigidifiedPicardDegreeZeroFunctorIso`) and `multiplication_isogeny` (E.7), it is a short corollary". The mathematics of the rest of the item is correct: `Ω ⊗ 𝒪(−(2g − 2)x₀) ≅ N²` gives the square root `N ⊗ 𝒪((g − 1)x₀)`.

## 1. Is the removal right? Verdict: *match*

- [GLC1] §1.3.2: "The Langlands functor depends on the choice of the square root `ω_X^{1/2}` of the canonical line bundle on `X`, which we fix from now on." [GLC1] §1.1.2 and [GLC2] §1.1.1 ("We choose once and for all a square root") agree. I located the numbers with `tools/tex-locator.awk`. A search of [GLC1] to [GLC5], [AGKRRV] and [ArinkinGaitsgory] finds no sentence that states the existence.
- `GLCinLean/Statement/Conjecture.lean` lines 215 and 219: `Setting` has the fields `sqrtOmega : InvertibleSheaf X` and `sqrtOmegaIso : (sqrtOmega.tensorProduct sqrtOmega).obj ≅ X.relativeDifferentials k`. They are data, as in the paper.
- Users: on `main`, `lake exe tracker show` gives no "needed by" for `Curves.nonempty_thetaCharacteristic`, and gives only that theorem for the two roadmap nodes. My own script over every `deps` list of `plans/` and `plans-proof/` agrees. A search by name on the branch finds the three names only in `STATUS.md` and `notes/`. No file under `GLCinLean/`, `docs/`, `prompts/` or `tools/` names them. No node text relies on the existence, on `Pic⁰` or on the Jacobian.
- No roadmap states the existence: the README of JacobianChallenge has no "theta characteristic", and a code search of TauCetiRoadmap finds only QSeriesPartitionsAndMockModularForms §6.1.
- `GLCinLean.lean` rightly does not change: the existence is no claim of a source, so "Not formalized" does not apply.
- Rule text: `AGENTS.md`, "Plan", says that a roadmap node "is deleted only when its declaration is at the pin". The proposal reads this rule as the rule for nodes that an upstream declaration replaces, and removes the two nodes as part of "dropping … a theorem … that the plan asks for". I agree with this reading by purpose, but the literal text does not allow it. Verdict: *match*, with the note that the wording of the rule is the owner's to change.

## 2. Examples for `Setting` and its theta fields. Verdict: *match*; no example in positive genus is needed

- The trivial reading of `Setting` is the empty type. `Examples.exists_setting_rank_pos` rules it out over every algebraically closed field of characteristic zero. The trivial readings of the theta fields are a wrong sheaf of differentials or a wrong tensor square. `Curves.thetaCharacteristicProjectiveLine` rules them out: `Ω ≅ 𝒪(n)^{⊗2}` holds only for `n = −1`, because `deg Ω = −2`. Both nodes stay, with unchanged `deps`.
- A positive-genus example would test no definition of this project. The two fields consist only of Tau Ceti declarations, and the composition of these declarations is the same in every genus. That a square root exists in positive genus is a classical theorem about Tau Ceti's objects. The Lean statement and [GLC1] Conj. 1.6.7 quantify over the same data with or without it.
- If the owner still wants one: it is a new definition node beside `Curves.thetaCharacteristicProjectiveLine` in `plans/GLCinLean/AlgebraicGeometry/Curves/` (the structure sheaf on a curve with `Ω ≅ 𝒪`). `Examples.exists_setting_rank_pos` should not state it, because its claim is non-emptiness and is complete with ℙ¹. This node needs a curve of genus one in Lean, and it does not restore the check "no curve is left out" (see U1).
- Degenerate cases: `Setting` (structure, placeholder) and `Curves.ThetaCharacteristic` (data) are unchanged; the examples above are the ones that rule out the degenerate cases.

## 3. Edited sentences

- `plans/GLCinLean/AlgebraicGeometry/Curves/Theta.toml` line 1 (module `desc`): *match*.
- Same file, line 6 (`Curves.ThetaCharacteristic`): *match*. The first sentence, `kind`, `deps` and `source` are unchanged, so the object is unchanged. "No properness, no connectedness and no condition on the base" agrees with "over a base scheme S". Each of the three reasons is true.
- `plans/GLCinLean/GeometricLanglands/Examples/Setting.toml` line 6: *match*. The claim, `deps` and `source` are unchanged.
- `plans/README.md` line 3: the sentence "The existence … is not planned either: …" is *match*; the last sentence is M1.
- `docs/blueprint-providers.md` line 106 (one remaining user of `eulerDegree_relativeDifferentials`), line 173 (JacobianChallenge owns 1 node, Layer B, B.2), line 214 ("the plan uses Layer B only"): *match*. `deg Ω = 2g − 2` is B.3 of the roadmap, D.8 and E.7 are named correctly, and the column of line 173's table sums to 88.

## 4. Counts and removed rows. Verdict: *match*

- Counted on the branch: 309 nodes in 196 module plans; 221 under `plans/GLCinLean/`, 31 of them the statement; 88 under `plans/Roadmap/` in fifteen areas; JacobianChallenge 1. 220 of the 221 have a roadmap node below them, and the other is `GLCinLean.CategoryTheory.tensorPowFunctor`. `plans-proof/`: 195 nodes in 74 module plans. Placeholders: 28. `lake exe tracker ready`: 16 modules on the branch and 17 on `main`; `Roadmap.JacobianChallenge.SerreDuality` is listed.
- Checks on the branch: `lake exe tracker lint` ends with status 0 and 61 warnings; `python3 tools/check-module-cycles.py` prints "196 module plans, 309 nodes, 0 cycles"; `python3 tools/check-upstream-names.py` prints "251 pairs … 0 not confirmed". No `deps` list names an unknown node, and no roadmap node is without a user.
- Removed rows: `LineBundleClass.eulerDegreeHom` (with `picZero`), `eulerDegree_toLineBundleClass_ofPoint_of_section`, the ready module `Roadmap.JacobianChallenge.Jacobian`, and the pull requests #43607 and #42808. No file of `plans/`, `plans-proof/`, `docs/`, `prompts/` or `GLCinLean/` names any of them after the change.
- `Curves.serreTrace` is rightly kept: `Whittaker.character` uses it in `plans/`, and `DModules.maximalConstantQuotient`, `Factorization.centralChiralHomology_equiv_derivedConstantQuotient` and `LocalSystems.regularSingular_smoothNearLS` use it in `plans-proof/`.
- The count "16 / 11" of roadmap candidate 6 (`docs/blueprint-providers.md` line 350): *unsure*, not caused by this change. The four folders hold 21 node ids in `plans/` on the branch, so the figure cannot be derived before or after. The next audit should count it again.

## 5. Texts of section 5 for `STATUS.md`

- Counts: *match* (item 4). They agree with `STATUS.md` on `main`, which has 312, 198, 222 and 90.
- "Decisions taken": every fact is true, except the clause of M1 and the missing sentence of U1.
- Open items: the item on `deg Ω = 2g − 2` is *match* (one user is left; the smooth forms of `deg 𝒪(x₀) = 1` and of additivity have no user in the plan). The new item is M2. "Tau Ceti accepts only work toward a roadmap target" agrees with `docs/blueprint-providers.md` line 17.
- Workers: *match*. Tau Ceti #41795 is open with the label ready to merge.
- Watched pull requests: *match*. #43607 is open, labelled ready to merge, and is among the monitor's arguments in `STATUS.md`; #42808 is not named in `STATUS.md`.
- Audit: B9 is closed by the change, once U1 is settled.

## Breaches of `AGENTS.md`

None in "Sources of code" or "Lean code". In "Writing": the edited texts state current facts and reasons; none beside M1.
