# Assessment of the three owner decisions

Repository state reviewed: `aab0d35`. Date: 2026-11-11. Reviewer: GPT-6 Astra. These are recommendations, not approved changes to the plan.

My decisions are: **add a direct trivial-group example without requiring Ran contractibility; narrow the crystals equivalence but explicitly plan its substantial proof inputs; revise and send the tracker request.**

I checked `aab0d35`, the cited plans and papers, and the tracker's `ready`, `show`, `status` and `lint` output. I used the existing binary with `--no-check` to avoid writes; its cached project fingerprints match the compiled files, and every current planned identifier is present. No files changed during the assessment. This report was saved afterward at the owner's request.

## 1. Add a direct trivial-group example

**Add a trivial-group example that proves the two characterizing properties directly.**

Its contract should identify the *actual constructed objects*:

\[
\operatorname{Bun}_1=\operatorname{LS}_1=\mathrm{pt},\qquad
\operatorname{Rep}(1)_{\mathrm{Ran}}\simeq\operatorname{Dmod}(\mathrm{Ran}),
\]
\[
\operatorname{Loc}(V)\simeq p_!V,\qquad
V\star M\simeq p_!V\otimes M,\qquad
\operatorname{Poinc}\simeq k.
\]

Then prove `IsLanglandsFunctor` for the identity of `Vect`: compact complexes are bounded below, and the mapping-space equivalence follows naturally in **both** `V` and `M`. Include a coefficient supported at a chosen point, whose pushforward is `k`, to exclude a jointly zero localization and action.

This tests the normalization of the exponential at zero, the trivial twist, Poincaré, and the relationship between the two independently constructed functors. It must not define the action from `Loc` just to make the comparison automatic. The formulas follow by specializing [GaitsgoryOutline] §§4.2–4.4 and [GLC1] §§1.2–1.3.

**Why not omit it?** The remaining examples do not test the four objects of the second property, contrary to the replacement criterion in [prompts/build.md](../../prompts/build.md).

**Why not restore all five nodes now?** Ran contractibility proves the additional normalization `p_!ω_Ran ≃ k`; it is not needed for the displayed comparison for arbitrary `V`. I verified that the stronger example's dependency closure would indeed restore exactly the five nodes listed in `STATUS.md`. That is a legitimate later test, but unnecessary work for this first example.

**Why not restore the coarse-functor example?** It brings the proof machinery back into the statement's construction plan. The direct example tests the approved formulation itself. Factor out and reuse the Ran pushforward already **planned** inside `Spectral.localization`; it has not yet been implemented.

## 2. Narrow the crystals equivalence and expose its proof inputs

**Narrow the equivalence to smooth finite-type schemes, with naturality for arbitrary morphisms between them. Add explicit nodes for its proof.**

This covers `X^I`, projections and diagonals. Restricting naturality to *smooth morphisms* would fail: the diagonals needed by `Loc` are closed embeddings.

The narrowing saves the reduction from arbitrary prestacks to affine schemes and the embedding of a possibly singular affine scheme into a smooth one. It does **not** eliminate the main formal-completion argument. `Υ_X` being an equivalence does not by itself prove the required assertion about `Υ_{X_dR}`. The current `STATUS.md` correctly fixes the earlier review's claim on this point. See [Crystals, proof of Proposition 2.4.4](https://people.mpim-bonn.mpg.de/gaitsgde/GL/Crystalstext.pdf).

The plan should expose these proof obligations as nodes, rather than leave them implicit inside a definition:

| Proof input | Required content |
|---|---|
| Smooth-scheme comparison | `Ψ_S` and `Υ_S` are equivalences for smooth `S`, with the specified dualizing-object formula; [IndCoh] Lemma 1.1.6 and Proposition 9.3.3. |
| Descent of left and right crystals | The two totalization equivalences for the Čech nerve of `X → X_dR`; [Crystals] Lemmas 2.1.7 and 2.3.11, at least in the smooth case used here. |
| Formal-diagonal geometry | Identify the Čech terms with formal completions of powers of `X` along the diagonal, and establish the hypotheses needed to apply IndCoh. The existing `formalCompletion` node supplies the construction, not all these results. |
| QCoh formal-completion localization | The comparison with supported QCoh; [IndSch] Proposition 7.1.3. |
| IndCoh localization and compatibility | The corresponding IndCoh comparison, compatible with `Υ`; [IndSch] Proposition 7.4.5 and diagram (7.16). This compatibility makes the equivalences on the smooth ambient scheme and its open complement imply the equivalence on the completion. |

The final equivalence must retain coherent pullback compatibility, so the construction survives totalization and the Ran diagram.

**Why not keep the general theorem?** Its only explicit consumer needs smooth schemes. The saving from narrowing is modest, but it removes obligations with no current consumer and follows the repository's scope rule. Keep the general *construction* of `Υ` where the existing prestack API supplies it; prove equivalence at the scope required.

**Why not narrow and add no inputs?** That would conceal essentially the same gap. Nor is [Crystals] §5.5 a shortcut: its D-module comparison itself invokes Proposition 2.4.4.

## 3. Revise and send the tracker request

**Revise the tracker request and send it.**

The observed output supplies a concrete reproducer: `Enhanced` is “done,” `Conjecture` is “ready,” and `show Statement.Loc` lists `Spectral.localization` as “suggested but not used.” `lint` passes while recommending removal of the replacement dependencies and descriptions.

I would ask exactly:

> Please support an optional configurable tag attribute, such as `--placeholder-attr placeholder`. Tagged declarations should be reported separately from implemented declarations, retain the union of real and suggested dependencies, remain eligible for replacement work when their prerequisites are complete, and block dependent work from being reported ready or complete.
>
> Preserve axiom and `sorryAx` diagnostics independently. Report real dependency on placeholders, including through unplanned helpers, so an untagged wrapper cannot hide unfinished implementation.
>
> For placeholders, retain and display the planned replacement description alongside the authoritative compiled docstring, without a superseded-field warning. Include placeholder information in `status`, `show` and graph output, and invalidate the cache when the attribute configuration changes.
>
> Our reproducer is a tagged `Loc` declaration whose suggested dependency is the still-open `Spectral.localization`; today the tracker calls `Loc` proved and ignores that dependency.

**Why not send unchanged?** “As for an open declaration” would retain suggestions alone, although these placeholders have genuine type dependencies. The draft also leaves replacement descriptions and indirect dependence unspecified.

**Why not drop it?** This affects the build prompt's work selection and completion checks. `grep` counts tags but cannot repair those decisions. Nevertheless, it should remain an upstream feature request rather than become a prerequisite for mathematical work.

## Other findings for the owner

- **Theta's readiness is overstated.** `thetaCharacteristic_exists` names canonical degree, Picard varieties and multiplication by two in its description, but depends only on `thetaCharacteristic`. The tracker therefore reports the whole module ready. Add the missing roadmap inputs or explicitly restrict the next build to the definition and a concrete example. This is separate from the placeholder problem.
- **Split the right-crystals construction from its D-module comparison.** The current `rightCrystals` node bundles both, while `leftCrystalsEquivRightCrystals` depends on it. Following the cited §5.5 proof makes the comparison depend back on the equivalence. Separate nodes expose the correct order and avoid a concealed circular dependency.
- **Check the domain of the Hecke pushforward.** `Hecke.action` concerns arbitrary objects, but its named shriek input guarantees existence on holonomic objects and the particular Poincaré extension. The plan should explicitly supply the proper-support/colimit extension or another argument covering arbitrary coefficients. This is a proof obligation to resolve, not evidence that the action is mathematically wrong.
- **Resolve the monoidal wording before implementation.** `ranRepresentations` still promises “its monoidal structure,” while the convolution construction lives in `plans-proof/`. [GaitsgoryOutline] §4.2 uses the non-unital convolution product. Specify exactly which structure each construction needs; an unspecified monoidal structure is not a reliable build brief.
