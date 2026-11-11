# Blueprint of the de Rham statement

This plan follows [GLC1] Corollary 1.6.5, Conjecture 1.6.7 and Proposition 1.7.2. The target is any algebraically closed field of characteristic zero, a smooth proper connected curve, a pinned reductive group, and a chosen theta characteristic. It includes the constructions that identify the categories, actions, coarsening and coarse functor, including the proofs needed to construct their actions and adjoints. Thus geometric Satake and spectral decomposition are inside the statement blueprint, even when their proofs use localization, vanishing or Eisenstein series. The plan also records selected supporting results, such as automorphic compact generation and normalization examples. It does not plan the full proof of the main theorem (including its existence conjunct), nor the Betti variants. Those supporting results are not a claim to cover all of Corollary 1.6.5's proof.

## Reading the plan

Every TOML file is a tracker module plan. Every node records a paper locator (`source`), what the object is and who provides it (`desc`), and its immediate prerequisites (`deps`).

- `plans/GLCinLean/` holds the nodes written here, in subject folders as in Mathlib; the statement has its own `Statement` folder. Their `desc` says "Provider: here", and names the roadmap targets that the construction uses.
- `plans/Roadmap/<area>/` holds the nodes that a Tau Ceti roadmap owns, with their ids unchanged. `<area>` is the roadmap's folder, which is also the Worker's `--roadmap-only` value. Their `desc` says "Provider: roadmap ⟨area⟩, ⟨target⟩", where the target is a section title or a Lean name of the roadmap. A node here may depend on a roadmap node, never the other way round.
- An existing Mathlib or Tau Ceti declaration is not a node. The node that uses one names it and its import module in its `desc`, under "Upstream declarations used".

When a roadmap node lands upstream, it is deleted only when its declaration is at this project's pin, its interface is checked, and a fresh agent has reviewed its meaning with `prompts/review.md`. The nodes that use it are updated in the same commit.

On declarations that already exist (the statement's placeholders), `desc` and `deps` are kept although `lake exe tracker lint` reports them as superseded; `kind` is not kept, because Lean gives it. The reason: a placeholder has no real dependencies in Lean, so its suggested `deps` are the only link from the statement to the rest of the plan, and its `desc` records how it is to be replaced. Lean and its docstrings remain authoritative for the compiled object.

The one upstream snapshot is in `docs/blueprint-providers.md`. `STATUS.md` holds the current state, the decisions and the nodes that are held back.

## Construction chain

1. Existing fields, schemes, reductive Hopf algebras, pinnings, invertible sheaves and differentials supply the geometric input. Root-datum extraction/classification and dual group existence belong to the accepted reductive-group roadmaps.
2. Existing quasicategories, mapping spaces, strict DG categories and DG nerves are starting points. Presentability, stable k-linearity, coherent tensor/module structures, adjunctions, compactness, Ind-completion and t-structures are separate enhanced obligations.
3. Derived affine schemes and prestacks supply de Rham prestacks, derived mapping stacks, QCoh, IndCoh and singular support. LS is Maps(X_dR, B dualG), retaining its derived structure.
4. The spectral support is the closed cone of horizontal nilpotent **coadjoint** sections in Sing(LS), containing zero. It is not the automorphic nilpotent cone in T*Bun.
5. The automorphic category is Dmod(Bun_G) twisted by the square-root gerbe of the normalized determinant line. The theta characteristic trivializes that gerbe and fixes the Whittaker normalization. The integral cocharacter 2ρ is applied to its frame torsor.
6. The spherical perverse category, convolution, fusion and Tannakian reconstruction supply the geometric Satake heart equivalence. Its de Rham factorization extension, compatible with the chosen duality and half-twist, supplies the Hecke functor. Spectral decomposition additionally requires its vanishing and localization proof inputs; it is not a formal consequence of the spectral localization being a localization. The vacuum Poincaré object is p_! χ^*(exp), with definedness and compactness proved.
7. Acting on that object defines the left functor. Its right adjoint is the coarse functor; continuity and linearity are theorems, not assumptions. Coarsening is Ψ_Nilp,{0}.
8. The main theorem asserts existence of a continuous functor with the two properties, and equivalence of every such functor. Its second property does not use the coarse functor of step 7: it is one equivalence `Maps(V ⋆ Poinc, M) ≃ Maps(Loc V, Ψ (F M))` of mapping spaces, natural in `V` in `Rep(Ǧ)_Ran` and `M` together, with the Hecke action of step 6. By [GLC1] Thm. 1.2.4 this is the same as `Ψ ∘ F ≃ 𝕃_{G,coarse}`; the comparison is the planned theorem `Langlands.isLanglandsFunctor_iff_comp_psi_iso_coarse`. A separately chosen functor depending on an admitted existence theorem is not part of the statement.
