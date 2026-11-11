# Étale gerbes and the scope of twisted D-modules

Assessment of the open choice in `STATUS.md` at `efad065f65218f75e5b7b5b8eceb33f5304ddb42`, following [the review of b274dc8](reviews/b274dc8.md). Author: Codex. Date: 2026-11-11. This records advice, not an owner decision or a change to the plan.

**Choose (a): retain general étale μₙ-gerbes, with root gerbes as examples, and split implementation by upstream ownership.** Option (b) can support the present statement, but imposes a hypothesis that the descent construction does not use.

## The generality rule

The construction needs an étale-locally trivial, μₙ-banded gerbe, its trivializations, and the torsors relating those trivializations. It does not use a line bundle presenting the gerbe. This is the construction in [GLys] §§1.3, 1.7.2–1.7.4; [GLC1] §1.1.3 likewise introduces twisted D-modules for a general étale μₙ-gerbe before specializing to the determinant. Restricting to root gerbes adds an unnecessary assumption to `DModules.twistedCrystals`, `DModules.extraordinaryPullback`, and `DModules.twistedPseudoProperShriek`. The general abstraction already has concrete users, so it does not violate “no abstraction that nothing uses.”

Keep the scope bounded: positive `n`, invertible on the base; band-preserving equivalences and their coherence; pullback, tensor product, inverse, trivializations and their difference torsors. There is no need to make a full classification by H², arbitrary bands, or the whole metaplectic theory prerequisites.

## What the statement and Hecke action require

The review is right that root gerbes suffice for the specified twists. Writing `R_n(L)` for the root gerbe, there are coherent equivalences

```text
f* R_n(L)          ≃ R_n(f* L)
R_n(L) ⊗ R_n(M)    ≃ R_n(L ⊗ M)
R_n(L)⁻¹          ≃ R_n(L⁻¹).
```

Thus tensor products and inverses do not, by themselves, force general gerbes.

In particular, `Satake.criticalDeterminantGerbe` is the square-root gerbe of the relative determinant factorization line bundle ([GLys] §5.2; [GLC2] §1.1). `Satake.criticalTwist_matchesBunDeterminant` must supply the oriented comparison

```text
h_out* 𝒢 ⊗ (h_in* 𝒢)⁻¹ ≃ 𝒢_Gr restricted to the Hecke correspondence,
```

where `𝒢 = R_2(det_Bun_G)`, compatibly with composition and factorization. Tensoring a spherical kernel with `h_in^! M` then gives the target twist needed by the twisted pushforward. Both options can express this, provided they retain those coherent comparisons. See the [Satake twisting nodes](../plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml) and [Hecke action node](../plans/GLCinLean/GeometricLanglands/Hecke/Action.toml).

The essential distinction is root gerbe versus chosen root. The theta characteristic trivializes the underlying Grassmannian gerbe, but not compatibly with factorization. Neither option permits replacing the factorization spherical category by its untwisted version. This is explicit in [GLC2] Remarks 1.1.4, 1.1.7 and 1.1.12. The comparison with de Rham twistings in §1.1.9 is useful for root gerbes, but does not replace the general étale construction; Remark 1.1.13 explains the distinction.

## Reasons against the alternatives

Option (b)'s strongest argument is sufficient scope for the present statement. It is mathematically viable, not a weakening of that statement if implemented faithfully. Nevertheless:

- It restricts three reusable constructions without simplifying their descent argument.
- It still needs torsors between trivializations, equivalences of twists, and tensor/inverse coherence.
- Indexing everything only by line bundles and their isomorphisms risks omitting gerbe equivalences needed for untwisting and transport.

The alternative “choose the theta characteristic and untwist everything” fails because it loses the required factorization compatibility.

Option (a) also needs a scope and provider qualification: a full general theory of gerbes written independently in GLCinLean would go beyond the immediate need and compete with roadmap-owned foundations. Add the required interface and examples while reusing their upstream providers.

## Upstream search

The searches covered Lean sources at the two pins and a snapshot of Tau Ceti `main`, including gerbe, root-stack and banding terminology, together with the nearby stack, line-bundle and torsor foundations.

| Library | Revision | Finding |
|---|---|---|
| Mathlib pin | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` | Stack/descent and étale-site foundations; no gerbe implementation found. |
| Tau Ceti pin | `e0610cce4004d628cbd9d2aafdbbb5459fe72938` | Stack carriers, invertible sheaves and torsor foundations; no gerbe implementation found. |
| Tau Ceti `main` | `7550358f47732d3a41117cdb6dc90d7aae03dcad` | No étale-gerbe or root-gerbe implementation found. |

Reusable declarations include Mathlib's `CategoryTheory.Pseudofunctor.IsStack` and Tau Ceti's `TauCeti.AlgebraicGeometry.SchPseudofunctor` and `TauCeti.AlgebraicGeometry.InvertibleSheaf`. These are foundations, not an existing implementation of the proposed gerbe interface.

## Roadmap ownership

The current-roadmap search used TauCetiRoadmap at `cde8588f391d716f874fa155ef661e0a3d6ac5a7` and covered its Markdown and Lean files. It exposes an additional correction to the existing provider description.

[SchemeAndStackFoundations §§1.18, 1.21](https://github.com/TauCetiProject/TauCetiRoadmap/blob/cde8588f391d716f874fa155ef661e0a3d6ac5a7/TauCetiRoadmap/SchemeAndStackFoundations/README.md) owns generic stackification and quotient stacks. Its root-stack target concerns a line bundle with a section, not the root gerbe of a line bundle. The current `DModules.rootGerbe` node's provider description conflates these constructions.

The same roadmap's Layer 1 conventions explicitly assign banded gerbes and their H² classification to AlgebraicModuliForArithmeticGeometry. That directory is absent from this current roadmap snapshot: the ownership reference is stale. The [historical AlgebraicModuliForArithmeticGeometry Layer 4](https://github.com/TauCetiProject/TauCetiRoadmap/blob/ceba5c798ace9c7aaa13b4f1732828187c904ce5/TauCetiRoadmap/AlgebraicModuliForArithmeticGeometry/README.md#layer-4-gerbes-bands-and-profinite-stages), reached through a pinned link in the current SchubertGeometry roadmap, includes general site-level gerbes, neutralizations, torsors, and the actual root-gerbe construction. In particular, §4.3 specifies roots of a line bundle with no section as part of the data. This is evidence of the intended ownership, not confirmation that the historical target is currently active.

Accordingly, add the missing dependency conceptually, but do not assign all its mathematics to GLCinLean. Route roadmap-owned foundations through Tau Ceti's Worker from `WHY-Op109/TauCeti`, under Tau Ceti's `AGENTS.md` and `COORDINATION.md`; resolve the stale gerbe-target reference before implementation. Keep any uncovered prestack extension and the D-module/Satake constructions here, reusing upstream carriers. The ownership uncertainty does not change the mathematical choice.

## Sources

Paper keys and local source paths are recorded in [docs/papers.md](../docs/papers.md) and [docs/references.bib](../docs/references.bib). The assessment used the local TeX sources for:

- [GLC1](https://arxiv.org/abs/2405.03599v3), §1.1, especially §1.1.3 and Remark 1.1.6.
- [GLys](https://arxiv.org/abs/1608.00284v7), §§1.3, 1.4, 1.7, 5.2 and 9.5.
- [GLC2](https://arxiv.org/abs/2405.03648v3), §1.1, especially Remarks 1.1.4, 1.1.7, 1.1.12 and 1.1.13, and §1.1.9.
