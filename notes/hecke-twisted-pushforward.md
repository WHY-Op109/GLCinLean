# Twisted pushforward in the Hecke action

Assessment dated 2026-11-11, concerning `main` at `d843a5ff03c2c72fbc47b1fdb2a0bffe8a231fb6`.
This is advice on the choice under “Waiting for the owner” in [STATUS.md](../STATUS.md), raised in [the review of f79facd](reviews/f79facd.md). It does not implement a plan or code change.

**I recommend (b), restricted to pseudo-proper maps with a pulled-back étale \(\mu_2\)-gerbe.** Keep (a) as the comparison formula when a trivialization is available.

There is one qualification to STATUS.md: **(a) can give the paper’s action.** Using the theta characteristic to compute the final pushforward does not require untwisting the spherical factorization category. The conflict with `criticalTwist_matchesBunDeterminant` is therefore with its present wording, not an unavoidable mathematical contradiction.

The distinction that decides this question is the following. Write

\[
B=\operatorname{Bun}_G,\qquad \mathcal G=\det_B^{1/2},
\]

and let \(h_{\mathrm{in}},h_{\mathrm{out}}:H\to B\) be the Hecke projections. With the kernel oriented accordingly, the determinant comparison identifies its twist with

\[
h_{\mathrm{out}}^*\mathcal G\otimes
(h_{\mathrm{in}}^*\mathcal G)^{-1}.
\]

Consequently, the product of the kernel with \(h_{\mathrm{in}}^!M\) is **\(h_{\mathrm{out}}^*\mathcal G\)-twisted**. What is missing is precisely

\[
(h_{\mathrm{out}})_{!,\mathcal G}:
D_{h_{\mathrm{out}}^*\mathcal G}(H)\longrightarrow D_{\mathcal G}(B).
\]

The gerbe comparison identifies the total twist; it does not itself trivialize it.

This retains the pull-push construction of [GaitsgoryOutline, §§4.2–4.4](https://arxiv.org/abs/1302.2506v3), with the half-twisted normalization required by [GLC1, §§1.1–1.2](https://arxiv.org/html/2405.03599v3). The global twisted action is also described directly in [GLys, §§9.5.1–9.5.2](https://arxiv.org/abs/1608.00284v7).

| Criterion | (a) Theta transport | (b) Twisted pushforward |
|---|---|---|
| Gives the paper’s action | Yes, if transport is applied to the **total pulled-back target twist**, retaining the original kernels and their coherences | Yes, by constructing the required twisted left adjoint directly |
| Consistent with `criticalTwist_matchesBunDeterminant` | Mathematically yes; its blanket prohibition on theta untwisting needs clarification | Yes, including its present prohibition |
| Pinning independence | Preserved, holding the theta characteristic fixed | Preserved; the pushforward introduces no pinning choice |
| Added plan work | Smaller: transport of adjunctions, compatibility and independence proofs | Larger: twisted descent and coherent gluing, followed by the pushforward API |

For **(a)**, let \(U_t:D_{\mathcal G}(B)\simeq D(B)\) be untwisting by the theta-induced trivialization. The correct formula is

\[
f_{!,\mathcal G}^{\,t}
=
U_t^{-1}\circ f_!\circ U_{f^*t}.
\]

One must first prove that these equivalences intertwine twisted and ordinary \(f^!\). The displayed functor is then left adjoint to the intrinsic twisted \(f^!\), which characterizes it up to equivalence compatible with the adjunction.

Changing \(t\) changes untwisting by tensoring with a rank-one local system \(L\) on the target, and changes source untwisting by \(f^*L\). The projection formula cancels these changes. This supplies a concrete independence proof; uniqueness of adjoints supplies the corresponding coherent comparison.

That is a valid construction, and its strongest advantage is its smaller scope. The repository already plans the theta-induced equivalence and untwisted pushforward.

The reason **against choosing (a) as the main interface** is that its short description hides these transport obligations and makes a canonical operation appear dependent on automorphic choices. Merely adding `Automorphic.halfTwisted_equiv_untwisted` to `deps` would not settle them.

A different reading of (a)—replace the half-twisted spherical category over Ran by the ordinary untwisted one and use its usual factorization structure—does fail. The theta trivialization is incompatible with that factorization structure; pointwise equivalence does not repair the missing signs. This is the warning in [GLC2, Remarks 1.1.4, 1.1.7 and 1.1.12](https://arxiv.org/html/2405.03648v3). To adopt the valid reading of (a), the plan should explicitly prohibit **untwisting the spherical factorization structure**, while permitting transport of the final pushforward.

For **(b)**, the construction should be:

1. For each test scheme \(S\to Y\), choose an étale cover trivializing \(\mathcal G|_S\).
2. Over that cover, use the existing untwisted pseudo-proper pushforward.
3. On overlaps, use the projection formula to intertwine the transition local systems.
4. Descend the functors **with their units, counits and comparison maps**, then assemble over test schemes using base change.

This is a mathematical extension to prove, not something already supplied by the terse `twistedCrystals` node. [Crystals, §7.2 and Remark 7.3.1](https://arxiv.org/abs/1111.2087v4) support the twisted formalism and the locally trivial case; [GaitsgoryAtiyahBott, Proposition 1.5.2 and Corollary 1.5.4](https://arxiv.org/abs/1505.02331v2) supply the untwisted pseudo-proper construction and base change. Their combination gives the proposed proof route.

The reason **against (b)** is this additional descent work. It should not expand into arbitrary de Rham twistings or unrestricted twisted \(f_!\): neither is needed here.

For either option, checking individual Hecke functors is insufficient. Composition, diagonal compatibility and disjoint factorization must survive. [GLC2, §1.5](https://arxiv.org/html/2405.03648v3) uses the half-twisted spherical category; §H.6.8 and Remark H.6.9 distinguish the integrated binary operation from the additional structure making it an action. The determinant comparison’s composition and factorization compatibility must be combined with coherent base change and projection formulas.

**The pinning-independence node survives both choices.** Its comparison starts with the tensor natural isomorphism between conjugation pullback and the identity on \(\operatorname{Rep}(\check G)_{\mathrm{Ran}}\). Applying Satake, kernel pullback, tensor product and either correctly constructed pushforward carries this to an isomorphism of Hecke actions. For (a), the same \(U_t\) is used for both pinnings. Theta-independence is a separate assertion; pinning-independence neither requires nor proves it.

For `plans/`, I would make the following bounded change under (b):

- Extend [DModules/Twisting.toml](../plans/GLCinLean/AlgebraicGeometry/DModules/Twisting.toml) to state étale descent, transition under changing trivializations, and compatibility with pullback. Make `extraordinaryPullback` explicitly accept a target gerbe and its pullback without requiring a trivialization.
- Add `DModules.twistedPseudoProperShriek` beside [the untwisted node](../plans/GLCinLean/AlgebraicGeometry/Prestacks/PseudoProper.toml). Reuse that node locally. Require adjunction, continuity, presentation and cover independence, composition, base change and projection formula. The already planned `Infinity.adjointableDiagram_limitAdjunction` supplies the categorical gluing mechanism.
- Add a comparison theorem expressing the displayed untwist–push–retwist formula for any specified trivialization. Its trivial-gerbe specialization recovers the existing operation.
- Make [Hecke.sphericalAction](../plans/GLCinLean/GeometricLanglands/Hecke/Action.toml) depend on this operation and explicitly identify the total twist before pushing forward. Keep the determinant comparison and pinning-independence statements.

This costs more than (a), but gives the Hecke construction the precise operation it needs, preserves its normalization directly, and leaves theta transport as a proved way to compute that operation.
