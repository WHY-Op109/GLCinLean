# Proposal: the existence of theta characteristics leaves the plan

Branch `proposal/theta-characteristic-existence`, made from `main` at `0c1bcf5`. Audit finding B9.

## Summary

The plan asks for a proof that every smooth proper connected curve over an algebraically closed field has a theta characteristic. No construction, example or placeholder uses this theorem, and neither does the proof of the main theorem. [GLC1] does not state it: the paper fixes a square root of the canonical bundle, and `Statement.Setting` takes one as data in the same way. The theorem costs the Jacobian of a curve, which Tau Ceti does not have.

The chosen option is (a), in its form "drop". The branch removes the theorem `Curves.nonempty_thetaCharacteristic` and the two roadmap nodes that only it uses, `Curves.picardZero_isAbelianVariety` and `Curves.abelianVariety_multiplication_surjective`. They do not go to `plans-proof/`, because the proof does not use them. `Curves.serreTrace` stays: it is the one node of the roadmap JacobianChallenge that still has a user. The definition `Curves.ThetaCharacteristic`, its example on the projective line and the example `Examples.exists_setting_rank_pos` stay unchanged in meaning.

## 1. The problem

`plans/README.md` says what the statement's plan holds: every construction that the statement uses, the examples that rule out a trivial reading of its placeholders, and the comparison results for its definitions. The existence of theta characteristics on every curve is in the plan, but it is none of these three. It keeps a ready roadmap module in `lake exe tracker ready` (`Roadmap.JacobianChallenge.Jacobian`) whose targets are Layers D and E of JacobianChallenge: the Picard scheme, its representability and properness, the Jacobian, and multiplication by `n` on an abelian variety. The generated status of that roadmap says that nothing is representable and that the milestones on abelian varieties have not begun.

The question: is this theorem needed for a faithful statement, so that it must stay; or is it more than the statement needs, so that it leaves the plan?

## 2. Evidence

**The nodes** (`lake exe tracker show`, on `main` at `0c1bcf5`).

- `GLCinLean.Curves.nonempty_thetaCharacteristic` (theorem, open, module `GLCinLean.AlgebraicGeometry.Curves.ThetaExistence`, source [GLC1] §1.3.2): "Existence of theta characteristics on a smooth proper connected curve X over an algebraically closed field k". Its proof text: `ω_X ⊗ M^{-2}` has degree zero for `M = 𝒪((g − 1)x₀)`, it is a `k`-point of `Pic⁰`, and "Multiplication by 2 on the abelian variety Pic⁰ is a surjective isogeny". Its `deps`: `Curves.ThetaCharacteristic`, `Curves.picardZero_isAbelianVariety`, `Curves.abelianVariety_multiplication_surjective`.
- `GLCinLean.Curves.picardZero_isAbelianVariety` (theorem, roadmap JacobianChallenge, Layer D: D.2, D.5, D.7, D.8, and Layer E: E.2): `Pic⁰_{X/k}` exists and is an abelian variety of dimension `g`, with its `k`-points.
- `GLCinLean.Curves.abelianVariety_multiplication_surjective` (theorem, roadmap JacobianChallenge, Layer E: E.7 `multiplication_isogeny`): multiplication by `n ≠ 0` on an abelian variety is finite locally free and surjective.

**The users.** A script over every `deps` list of `plans/` and `plans-proof/` gives:

- `Curves.nonempty_thetaCharacteristic`: no user in `plans/`, no user in `plans-proof/`. Two nodes name it in their `desc` only: `Curves.ThetaCharacteristic` ("Properness, connectedness and the base field enter only the existence theorem") and `Examples.exists_setting_rank_pos` ("stays in the plan as the check that no curve is left out").
- `Curves.picardZero_isAbelianVariety` and `Curves.abelianVariety_multiplication_surjective`: one user each, `Curves.nonempty_thetaCharacteristic`. No user in `plans-proof/`.
- `Curves.serreTrace`, the third node of `plans/Roadmap/JacobianChallenge/`: used by `Whittaker.character` in `plans/`, and by `LocalSystems.regularSingular_smoothNearLS`, `Factorization.centralChiralHomology_equiv_derivedConstantQuotient` and `DModules.maximalConstantQuotient` in `plans-proof/`.
- `Curves.ThetaCharacteristic` has six other users (`Statement.Setting`, `Stacks.determinantSquareRoot`, `Whittaker.rhoTorsor`, `Whittaker.character`, `Satake.halfTwistedHeart_equiv_untwistedHeart`, `Curves.thetaCharacteristicProjectiveLine`). Each takes a theta characteristic as given.

**The statement.** `Statement.Setting` (`GLCinLean/Statement/Conjecture.lean`) has the fields `sqrtOmega : InvertibleSheaf X` and `sqrtOmegaIso : (sqrtOmega.tensorProduct sqrtOmega).obj ≅ X.relativeDifferentials k`. Both are built from declarations of Tau Ceti; `Setting` is a placeholder only because of `RootDatumDuality`. The main theorem is quantified over all settings. The examples of the plan: `Examples.exists_setting_rank_pos` builds a setting on the projective line with the theta characteristic `𝒪(−1)`; `Examples.trivialGroup_isLanglandsFunctor_id` is stated "for the trivial group … and any curve and theta characteristic", so it takes the theta characteristic as a hypothesis. No example needs the existence on a curve of positive genus.

**The papers.**

- [GLC1] §1.3.2: "The Langlands functor depends on the choice of the square root `ω_X^{1/2}` of the canonical line bundle on `X`, which we fix from now on."
- [GLC1] §1.1.2: "According to [BD, Sect. 4], the choice of `ω_X^{⊗1/2}` gives rise to a square root of `det_{Bun_G}`."
- [GLC2] §1.1.1: "We choose once and for all a square root `ω_X^{⊗1/2}` of the canonical line bundle `ω_X` on `X`."
- A search of the TeX of [GLC1] to [GLC5], [AGKRRV] and [ArinkinGaitsgory] for "square root" with "canonical" or `ω`, and for "theta characteristic", finds no sentence that states or proves the existence. The papers use the square root only as fixed data.

**Tau Ceti and its roadmaps** (read on 2026-11-19; TauCetiRoadmap main `1b7b481a`).

- No roadmap states the existence of theta characteristics. The READMEs of JacobianChallenge, JacobianChallengePartII and RelativeJacobiansAndIntegralCurveModels use "theta" only for the theta divisor and the theta polarization. A code search of TauCetiRoadmap for "theta characteristic" finds only QSeriesPartitionsAndMockModularForms §6.1, which is about theta series.
- JacobianChallenge, generated status (up to Tau Ceti `aa6e43e`): "Nothing is representable, so there is no Picard scheme, Jacobian or Abel–Jacobi morphism, and the abelian-variety milestones have not begun"; Layer E "lacks every milestone: cube, projectivity, dual, polarizations, autoduality, and `[n]` for `n ≠ 0`".
- Tau Ceti #43607 (the Picard scheme as a representing object) is open and labelled ready to merge, head `d8a1fe30`. #42808 (Abel maps surjective on field points) is open and waits for its author. #41795 (the residue trace) is open and labelled ready to merge, head `b0fc5546`.

So the facts of the finding hold on `main`.

## 3. The options

**(a) Remove the three nodes from `plans/`.** For: the theorem is no construction of the statement, no example for a placeholder and no comparison with the paper, so it is outside the scope that `plans/README.md` gives the plan. `AGENTS.md`, "Lean code", asks for "no abstraction that nothing uses"; a theorem without a user at the cost of the Jacobian is the same kind of excess. The paper fixes the square root as data, and `Setting` does the same, so the Lean statement and [GLC1] Conj. 1.6.7 quantify over the same objects with or without the theorem. The rule on `Prop`-valued definitions does not apply: `Curves.ThetaCharacteristic` is data, and it has its example on the projective line, which is a real test: the isomorphism `Ω ≅ 𝒪(−1)^{⊗2}` exists only because `deg Ω = −2`, so a wrong sheaf of differentials or a wrong sign of the twist would fail. Inside (a), "drop" is right and "move to `plans-proof/`" is wrong: `plans-proof/` holds what only the proof of the main theorem needs, and that proof works with one fixed setting.

**(b) Leave the nodes in `plans/`.** For: without the theorem, the Lean files do not show that a setting exists on a curve of positive genus, so the main theorem could in principle say nothing there. Against: this is not a trivial reading of a placeholder. The two fields are real mathematics of Tau Ceti, and Tau Ceti tests them itself (`eulerDegree_relativeDifferentials`: `deg Ω = 2g − 2`). That a square root exists is a classical theorem about these objects, not a property of a definition of this project. The plan also has no theorem that would use it: no node states "every curve and every group extend to a setting". And the cost is out of proportion: Layers D and E of JacobianChallenge, with no worker and no representability result.

**(c) Keep a weaker node.** The candidates: a theta characteristic on a curve of genus one (`Ω ≅ 𝒪`, from degree zero and `h⁰(Ω) = 1`); one curve of each genus (hyperelliptic curves, or plane curves of odd degree with the adjunction formula); a conditional theorem "if the group of line bundle classes of degree zero is 2-divisible, a theta characteristic exists". Against: none of them shows that no curve is left out, which is the only thing (b) would add. Each is new work that no node uses. The conditional theorem has a hypothesis that nothing here can prove, so it is an abstraction without a user. A route to 2-divisibility of `Pic⁰(k)` without the Jacobian was not found: the Kummer sequence gives it only with `H²(X, μ₂)`, whose computation uses the same fact.

## 4. The chosen option and what the branch changes

Option (a), drop. The reason in short: [GLC1] fixes a square root and never claims that one exists; the statement takes it as data; nothing in `plans/` or `plans-proof/` uses the existence; the proof of it needs the Jacobian.

The two roadmap nodes are not at the pin, so the rule of `AGENTS.md`, "Plan", for a roadmap node that landed upstream does not cover their removal. They leave as part of this big change ("Small and big changes": dropping a theorem that the plan asks for), because a roadmap node without a user is no part of the plan.

`GLCinLean.lean` does not change. Its section "Not formalized" records claims of the sources that are given up, and the existence of theta characteristics is no claim of a source. No Lean file changes.

The branch changes:

- `plans/GLCinLean/AlgebraicGeometry/Curves/ThetaExistence.toml`: deleted (the node `Curves.nonempty_thetaCharacteristic`).
- `plans/Roadmap/JacobianChallenge/Jacobian.toml`: deleted (the nodes `Curves.picardZero_isAbelianVariety` and `Curves.abelianVariety_multiplication_surjective`). They have no user after the change, in `plans/` or in `plans-proof/`.
- `plans/Roadmap/JacobianChallenge/SerreDuality.toml`: unchanged. `Curves.serreTrace` keeps its four users.
- `plans/GLCinLean/AlgebraicGeometry/Curves/Theta.toml`: the module `desc` and the `desc` of `Curves.ThetaCharacteristic` no longer name the existence theorem. The node now says that the definition asks for no properness, connectedness or condition on the base, names its example, and says that the existence on every curve is not planned, with the reason. The object, its `deps` and its `source` are unchanged.
- `plans/GLCinLean/GeometricLanglands/Examples/Setting.toml`: the sentence of `Examples.exists_setting_rank_pos` on the general existence now says that the plan has no such theorem. The claim, the `deps` and the `source` are unchanged.
- `plans/README.md`: one sentence in the first paragraph says that the existence of a theta characteristic on every curve is not planned, and why.
- `docs/blueprint-providers.md`:
  - "Upstream declarations the plan uses": the rows of `LineBundleClass.eulerDegreeHom` and `eulerDegree_toLineBundleClass_ofPoint_of_section` are removed (their only user was the removed theorem); the row of `eulerDegree_relativeDifferentials` names its one remaining user.
  - "Roadmaps that own plan nodes": JacobianChallenge owns 1 node in `plans/`, Layer B (B.2).
  - The table of ready roadmap modules: the row `Roadmap.JacobianChallenge.Jacobian` is removed.
  - "Other facts about these areas": the item on JacobianChallenge says that the area has one remaining plan node, in Layer B, and that Layers D and E would serve only the existence of theta characteristics, which is not planned.
  - "Tau Ceti pull requests toward plan nodes": the row of #43607 and #42808 is removed.

Each roadmap node of JacobianChallenge after the change:

| Node | User after the change | Result |
|---|---|---|
| `Curves.serreTrace` | `Whittaker.character` in `plans/`; three nodes in `plans-proof/` | stays in `plans/` |
| `Curves.picardZero_isAbelianVariety` | none | removed |
| `Curves.abelianVariety_multiplication_surjective` | none | removed |

Checks on the branch: `lake exe tracker lint` ends with status 0 and has no error (its 61 warnings are the "superseded" warnings of the statement's nodes, which `plans/README.md` explains); `python3 tools/check-module-cycles.py` prints "196 module plans, 309 nodes, 0 cycles"; `python3 tools/check-upstream-names.py` prints "251 pairs of a declaration and its module; 0 not confirmed". No `deps` list of `plans/` or `plans-proof/` names an unknown node, and no roadmap node of `plans/` is without a user.

## 5. Texts for `STATUS.md`

**Counts** (counted on the branch).

- `plans/`: 309 planned declarations in 196 module plans. 221 are under `plans/GLCinLean/`; 31 of them are the statement. 88 are under `plans/Roadmap/<area>/`, in fifteen roadmap areas; JacobianChallenge has 1.
- Of the 221 nodes written here, 220 have a roadmap node below them; the other is `GLCinLean.CategoryTheory.tensorPowFunctor`.
- `plans-proof/`: 195 nodes in 74 module plans, unchanged.
- Placeholders: 28, unchanged.
- `lake exe tracker ready` lists 16 modules, one fewer: `Roadmap.JacobianChallenge.Jacobian` is gone. `Roadmap.JacobianChallenge.SerreDuality` is still listed.

**Decisions taken** (new entry).

> **The existence of theta characteristics is not in the plan (audit finding B9).** The theorem `Curves.nonempty_thetaCharacteristic` (every smooth proper connected curve over an algebraically closed field has a theta characteristic) and the two roadmap nodes that only it used, `Curves.picardZero_isAbelianVariety` and `Curves.abelianVariety_multiplication_surjective` (JacobianChallenge Layers D and E), are removed from `plans/`. They are not in `plans-proof/`: the proof of the main theorem does not use them. [GLC1] §1.3.2 and [GLC2] §1.1.1 fix a square root of the canonical line bundle. `Statement.Setting` records this choice as an invertible sheaf and a squaring isomorphism. Every construction and example in the two plans can be stated with this choice or supplies its own. The proof considered for the general existence theorem uses the Jacobian and surjectivity of multiplication by 2 on its points over an algebraically closed field. `Curves.ThetaCharacteristic` keeps its example `Curves.thetaCharacteristicProjectiveLine`, and `Examples.exists_setting_rank_pos` is the example that a setting exists. The two weaker forms were rejected: an example in genus one or in each genus, and a theorem conditional on the 2-divisibility of the line bundle classes of degree zero; neither shows that no curve is left out, and no node would use them. Of JacobianChallenge the plan keeps `Curves.serreTrace` (Layer B, B.2). This replaces the owner's decision of 2026-11-13, which kept the theorem in the plan as the check that no curve is left out.

This entry is for the case that the owner agrees. The session adds to it the sentences on the owner's answer and on the agreement of the planner and Codex, once they hold.

**The question for the owner** (the entry under "Waiting for the owner").

> **Does the existence of theta characteristics stay in the plan?** Branch `proposal/theta-characteristic-existence`.
> - What: the theorem `Curves.nonempty_thetaCharacteristic` (every smooth proper connected curve over an algebraically closed field has a theta characteristic) and its two inputs from JacobianChallenge Layers D and E, `Curves.picardZero_isAbelianVariety` and `Curves.abelianVariety_multiplication_surjective`.
> - Why: the owner's decision of 2026-11-13 kept the theorem in the plan as the check that no curve is left out. Audit finding B9: no node of `plans/` or `plans-proof/` uses it. The branch reverses the decision, so it is not applied without the owner's answer.
> - Option "drop" (the branch): the three nodes leave `plans/` and are not in `plans-proof/`. The plan loses the check that no curve is left out, three nodes and one roadmap module. The statement and its examples are unchanged: [GLC1] §1.3.2 fixes a square root, `Statement.Setting` takes one as data, and `Examples.exists_setting_rank_pos` constructs a setting on ℙ¹.
> - Option "keep" (`main` as it is): the general theorem is the only node that gives the check that no curve is left out; an example in genus one does not give it. It blocks no placeholder. Its cost is the Jacobian of JacobianChallenge Layers D and E in Tau Ceti, and one ready roadmap module without a worker.
> - Positions: the planner proposes "drop". The checker finds the removal right by the papers and by the plan, and names the reversal of the owner's decision as the one point to settle. Codex agrees with "drop": its second report has no open objection, after three wording objections in its first.

**Open items.**

- Remove the open item on offering a smooth-curve corollary of `deg Ω = 2g − 2` to Tau Ceti. Its only remaining planned application is to ℙ¹ in `Curves.thetaCharacteristicProjectiveLine`. The projective-line examples still use the degrees of tensor powers. No remaining node calls for the degree-one formula for the divisor of a section on a general smooth proper connected curve.
- New item, if the session wants the route kept: the existence of a theta characteristic on every smooth proper connected curve over an algebraically closed field is outside the plan. Once Tau Ceti has the Jacobian (JacobianChallenge D.8), the identification of its `k`-points with the line bundle classes of degree zero (no named target; it follows from D.1 and `rigidifiedPicardDegreeZeroFunctorIso`) and `multiplication_isogeny` (E.7), it is a short corollary of Tau Ceti's degree theory: choose a point `x₀ ∈ X(k)`, put `M = 𝒪((g − 1)x₀)`, and take a line bundle `N` of degree zero with `N^{⊗2} ≅ Ω ⊗ M^{−2}`; then `M ⊗ N` is a square root of `Ω`. No roadmap states it. Adding it then is a new node, and its home is a question for that time (Tau Ceti accepts only work toward a roadmap target).
- The item on the base change of `Curves.serreTrace` is unchanged.
- New item for the next audit: the count "16 / 11" of roadmap candidate 6 in `docs/blueprint-providers.md` cannot be derived from its four folders, which hold 21 nodes in `plans/GLCinLean/` and 11 in `plans-proof/GLCinLean/`; the audit counts it again and names the modules it includes.

**Workers.** Facts for the sentence on JacobianChallenge: the area has one node in the plan, `Curves.serreTrace` (module `Roadmap.JacobianChallenge.SerreDuality`, Layer B, B.2). It has no author worker, because the open Tau Ceti #41795 of another contributor constructs the residue trace and is labelled ready to merge. The plan has no node on the Jacobian.

**Watched pull requests.** Tau Ceti #43607 (the Picard scheme) is no longer needed by any node: the session drops it from the arguments of the monitor. Tau Ceti #41795 stays. Tau Ceti #42808 was named only in `docs/blueprint-providers.md` and is no longer named there.

**Audit.** Finding B9 is closed by this change.

## 6. Worker guidance

None. No worker is pinned to JacobianChallenge, and no worker's targets change. No author worker is started for Layers D and E of JacobianChallenge on behalf of this plan.

## 7. Open doubts

- **Positive genus has no example.** After the change the only setting that the plan constructs is on the projective line. A reader who wants one curve of positive genus in the examples would ask for genus one, which is the cheapest (`Ω ≅ 𝒪`). The proposal does not add it: no node would use it, and it does not show that every curve has a setting.
- **A count in `docs/blueprint-providers.md` is left as it is.** The table of candidate roadmaps gives "16 / 11" nodes for candidate 6, from `Stacks/`, `LocalSystems/`, `Automorphic/` and `Curves/`. The four folders hold 21 nodes in `plans/GLCinLean/` after the change (22 before), and the table shares `Stacks/` with candidate 2 in a way it does not state. So it cannot be said whether the removed theorem was among the 16.
- **The route text of the removed theorem is only in the git history.** It names ten Tau Ceti declarations that give the hypotheses of the degree theorems for a smooth curve. The open item above keeps the idea of the proof, not this list.
