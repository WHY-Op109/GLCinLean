# Blueprint of the de Rham statement

This plan follows [GLC1] Corollary 1.6.5, Conjecture 1.6.7 and Proposition 1.7.2. The target is any algebraically closed field of characteristic zero, a smooth proper connected curve, a pinned reductive group, and a chosen theta characteristic. It includes the constructions that identify the categories, actions, coarsening and coarse functor, including the proofs needed to construct their actions and adjoints. Thus geometric Satake and spectral decomposition are inside the statement blueprint, even when their proofs use localization, vanishing or Eisenstein series. The plan also records selected supporting results, such as automorphic compact generation and normalization examples. It does not plan the full proof of the main theorem (including its existence conjunct), nor the Betti variants. Those supporting results are not a claim to cover all of Corollary 1.6.5's proof.

## Reading the plan

Every TOML file is a tracker module plan. Every node records a paper locator (`source`), a provider and the checked Tau Ceti main commit (`desc`), and immediate prerequisites (`deps`). Library modules use subject folders under `GLCinLean`; the statement has its own `Statement` folder. No planned library definition may be implemented as a placeholder.

`plans/Mathlib` and `plans/TauCeti` name existing declarations in their actual defining modules. These are dependency boundaries. An empty `deps` means the upstream interface is already provided, not that its implementation has no dependencies; some suppliers explicitly list other supplier interfaces needed by their consumers. Do not create local wrappers for these names. Some leaves are not imported by the current small statement and therefore appear as `open` in the tracker despite existing at the checked pin. The provider description, exact module and revision record that distinction.

A future declaration assigned to a Tau Ceti roadmap is temporarily located by subject in this blueprint. Its implementation goes through Tau Ceti Worker under the upstream rules, not here. Once its upstream name is established, move its plan to the upstream module, rename every reference in the same commit, and remove the tentative local name. Do not implement both APIs.

On declarations that already exist (the statement's placeholders and the upstream leaves), `desc` and `deps` are kept although `lake exe tracker lint` reports them as superseded; `kind` is not kept, because Lean gives it. The reason: a placeholder has no real dependencies in Lean, so its suggested `deps` are the only link from the statement to the rest of the plan, and its `desc` records its provider and how it is to be replaced. The `desc` of an upstream leaf says where it falls short of the paper (for example, ordinary sheaves, not the enhanced category). Lean and its docstrings remain authoritative for the compiled object.

## Construction chain

1. Existing fields, schemes, reductive Hopf algebras, pinnings, invertible sheaves and differentials supply the geometric input. Root-datum extraction/classification and dual group existence belong to the accepted reductive-group roadmaps.
2. Existing quasicategories, mapping spaces, strict DG categories and DG nerves are starting points. Presentability, stable k-linearity, coherent tensor/module structures, adjunctions, compactness, Ind-completion and t-structures are separate enhanced obligations.
3. Derived affine schemes and prestacks supply de Rham prestacks, derived mapping stacks, QCoh, IndCoh and singular support. LS is Maps(X_dR, B dualG), retaining its derived structure.
4. The spectral support is the closed cone of horizontal nilpotent **coadjoint** sections in Sing(LS), containing zero. It is not the automorphic nilpotent cone in T*Bun.
5. The automorphic category is Dmod(Bun_G) twisted by the square-root gerbe of the normalized determinant line. The theta characteristic trivializes that gerbe and fixes the Whittaker normalization. The integral cocharacter 2ρ is applied to its frame torsor.
6. The spherical perverse category, convolution, fusion and Tannakian reconstruction supply the geometric Satake heart equivalence. Its de Rham factorization extension, compatible with the chosen duality and half-twist, supplies the Hecke functor. Spectral decomposition additionally requires its vanishing and localization proof inputs; it is not a formal consequence of the spectral localization being a localization. The vacuum Poincaré object is p_! χ^*(exp), with definedness and compactness proved.
7. Acting on that object defines the left functor. Its right adjoint is the coarse functor; continuity and linearity are theorems, not assumptions. Coarsening is Ψ_Nilp,{0}.
8. The main theorem asserts existence of a continuous linear lift with the two properties, and equivalence of every such lift. A separately chosen functor depending on an admitted existence theorem is not part of the statement.

## Readiness and examples

Run `lake exe tracker ready`, but inspect each node's provider and suggested dependencies first. A placeholder counts as proved in the tracker, so readiness is not evidence of a completed mathematical definition. Enumerate the statement placeholders with `rg -n '@\[placeholder\]' GLCinLean` as well.

Before replacing placeholders, prove characterizing APIs and examples: derived vector spaces at a point; a genuinely singular derived affine for IndCoh; the zero-support QCoh comparison; a nontrivial split torus or GL₂ on P¹ with actual duality and theta data; and torus Fourier–Mukai normalization. In particular, never prove a vacuous statement by putting the needed existence or equivalence in Setting, nor choose a zero category to stand for a geometric category.

The provider snapshots and open roadmap pull requests are in `docs/blueprint-providers.md`. `STATUS.md` records the current state and the open decisions.