# Review of the goal and the plan, 2026-11-10

Commit reviewed: `19cf33f`. This report changes nothing in the statement or the plan. Each
finding waits for the owner's decision.

## Key points

1. **The statement is faithful** to [GLC1] Cor. 1.6.5, Prop. 1.7.2 and Conj. 1.6.7. No hypothesis
   is missing, and no conclusion was moved into a hypothesis.
2. **The current form of the statement cannot be fully defined cheaply.** Its second property
   uses the coarse functor, which uses the action of `QCoh(LS_Ǧ)` on the automorphic category.
   This action exists only by a deep theorem ([GLC1] Thm. 1.2.4). So about half of the plan is
   the proof of that theorem: 125 of the 157 planned theorems that the statement reaches.
3. **An equivalent form avoids that theorem.** It states the second property with the Hecke
   action of `Rep(Ǧ)_Ran`, which needs no theorem to exist. The plan then needs about 174 library
   nodes in place of 369. This is a change to the statement, so the owner must decide it.
4. **The first work is not in this repository.** Everything depends on about 27 ∞-category nodes
   that Tau Ceti roadmaps own. `lake exe tracker ready` does not show this.
5. **The tracker is the right tool.** Three uses of it in this plan work against it and should
   change.
6. **Upstream.** Apply suggestion 1 of the upstream note. Suggestions 2 and 3 need no change to
   the plan now. Code from AxiomMath is acceptable as prior art, but no port is worth doing now.

## How the review was done

- The statement was read line by line against the TeX of [GLC1] §§1.1–1.7 and Introduction §0.1.1.
- The plan was read through its dependency graph (`lake exe tracker graph`): 483 planned
  declarations, of which 33 are in the statement, 70 name Mathlib or Tau Ceti declarations, and
  380 are library nodes. The numbers below come from reachability in that graph, with suggested
  and real dependencies together.
- The descriptions and sources were read in full for the nodes on the direct path of the
  statement, and for all 72 `SpectralProof.*` nodes by source only.
- **Limit.** The 380 library nodes were not each checked against their papers. The answer to
  "is any part wrong" is therefore structural, not node by node.
- The open roadmap pull requests #1734, #1687, #848, #1676, #1332, #1225, #1901 and #1630 were
  checked again on 2026-11-10. All are still open, with the head commits that
  `notes/upstream-2026-11-10.md` records.

## Findings, ranked by effect on the goal

### Finding 1. The second property can be stated without the spectral action (high)

**What the code does.** `IsLanglandsFunctor` (`GLCinLean/Statement/Conjecture.lean:97`) asks for
a linear isomorphism `F.comp (Psi S) ≅ LCoarse S` (line 101). `LCoarse` (line 91) is the right
adjoint of the functor `E ↦ E ⋆ Poinc` from `QCoh(LS_Ǧ)` ([GLC1] §§1.4.2, 1.4.5). This functor
needs the action of `QCoh(LS_Ǧ)` on `Dmod_½(Bun_G)`, which is `DmodHalf` (line 77).

**Why this is costly.** The action exists by [GLC1] Thm. 1.2.4: the Hecke action of `Rep(Ǧ)_Ran`
factors through the localization `Loc : Rep(Ǧ)_Ran → QCoh(LS_Ǧ)`. [GLC1] cites it from
[GaitsgoryOutline] Cor. 4.5.5 and does not prove it. The plan must prove it, because every object
of the statement must be fully defined. The proof is the node `Spectral.action` and what only it
needs (`plans/GLCinLean/GeometricLanglands/Spectral/Action.toml`):

- all 72 `SpectralProof.*` nodes: critical-level localization, opers and the Feigin–Frenkel
  centre, derived Satake, Eisenstein series and constant terms;
- 13 `SemiInfinite.*`, 5 `Factorization.*`, 2 `Etale.*` and 2 `Homology.*` nodes, and parts of
  `DModules`, `Sheaves`, `Hecke` and `Whittaker`.

The written sources of this proof are also incomplete. The plan's own sources name
"[GenVan] Conjecture 1.6" for `SpectralProof.localizationKernel_annihilatesAutomorphic`, and
`docs/papers.md` says that [GenVan] §2.6 leaves the case of an arbitrary parabolic as an
expectation. Several nodes are marked "explicit obligation". So the statement would wait for a
proof that is harder than most of what comes after it.

**The other form.** Write `D` for `Dmod_½(Bun_G)`, `Q` for `QCoh(LS_Ǧ)` and `P` for the vacuum
Poincaré object. The Hecke action `V ⋆ M` of `Rep(Ǧ)_Ran` on `D` ([GLC1] §1.2.1) needs no
theorem. Replace property 2 by:

> **Property 2′.** The functor `Loc^R ∘ Ψ ∘ F` is right adjoint to `V ↦ V ⋆ P`, as functors
> between `Rep(Ǧ)_Ran` and `D`. In other words there is an equivalence
> `Maps_D(V ⋆ P, M) ≃ Maps_Q(Loc V, Ψ (F M))`, natural in `V` and `M`.

**Why it is equivalent.** Assume [GLC1] Thm. 1.2.4. By the definition of the spectral action
([GLC1] §1.2.5), `(E ↦ E ⋆ P) ∘ Loc ≃ (V ↦ V ⋆ P)`. Passing to right adjoints gives
`Loc^R ∘ L_coarse ≃ (V ↦ V ⋆ P)^R`. So property 2 gives property 2′. In the other direction,
apply `Loc` and use `Loc ∘ Loc^R ≃ Id`, which holds because `Loc^R` is fully faithful
([GLC1] §1.2.2). So the two forms agree whenever the paper's form is defined, and property 2′ is
defined without any theorem.

**What it saves.** Library nodes that the main theorem reaches:

| Form | Nodes | Definitions | Theorems |
|---|---|---|---|
| Current | 369 | 212 | 157 |
| Property 2 as an adjunction only, spectral action kept | 363 | — | — |
| Property 2′, rigidity of `QCoh(LS_Ǧ)` kept | 189 | 146 | 43 |
| Property 2′, rigidity not needed | 174 | 142 | 32 |

The middle row shows that the saving comes from the spectral action, not from the constructed
right adjoint. With property 2′ the statement no longer needs: Thm. 1.2.4, compactness of the
Poincaré object, compact generation and rigidity of `QCoh(LS_Ǧ)`, and linearity of the right
adjoint. These stay true and are needed for the proof of the conjecture, which comes later.

**What it does not save.** The Hecke action itself reaches 135 library nodes, including
geometric Satake over the Ran space. No form of the statement avoids these.

**The cost.** Property 2′ is not the paper's wording. Its agreement with the paper rests on
Thm. 1.2.4, which would not be in Lean until the proof phase. Then a library theorem can state
the agreement. `AGENTS.md` asks that the statement go "through the characterisation of `𝕃_G`";
property 2′ keeps that shape but changes how the second property is written. The detailed design
needs care in one place: `Loc^R` is continuous only by a theorem, so the adjunction should be
stated with mapping spaces, as above, or among all exact functors.

**Proposed decision.** Adopt property 2′. Move the 180 to 195 nodes that only the spectral
action needs out of the statement's plan and into the plan of the proof.

### Finding 2. The plan starts in Tau Ceti, and the tracker does not show it (high)

Of the 369 library nodes, 60 are owned by a Tau Ceti roadmap, and 309 say "implement here". But
almost all of the 309 depend on the 27 `Infinity.*` nodes (presentable stable `k`-linear
∞-categories, modules, Ind-completion, t-structures), and 24 of these belong to the roadmaps
EnhancedDerivedSheaves and BordismFormalGroups. `AGENTS.md` sends such work to Tau Ceti through
Worker. So no library code can be written here until that layer exists upstream.

`lake exe tracker ready` lists as ready the Mathlib and Tau Ceti leaves that already exist (for
example `CochainComplex`), and a few nodes such as `Curves.thetaCharacteristic`. It gives no
sign that the real first step is Worker rounds on EnhancedDerivedSheaves E0–E5.

**Proposed change.** `prompts/build.md` should say this in one line, and `STATUS.md` should name
the roadmap targets that block the plan. This layer is also the largest risk to the goal: neither
Mathlib, Tau Ceti nor AxiomMath has it, and no simpler foundation serves, because the categories
of the statement are limits of ∞-categories. The review found no better route than the one in
`STATUS.md`, open decision 3.

### Finding 3. The statement is faithful (confirmation, with small points)

Checked against the TeX of [GLC1]:

- **Hypotheses.** `Setting` (`Conjecture.lean:44–63`) has a smooth, proper, connected curve over
  `k`, a connected reductive group, a pinning, a theta characteristic and a dual group with its
  identification. Tau Ceti's `reductiveCommHopfAlgProperty` includes smoothness and geometric
  connectedness (`TauCeti/Algebra/AlgebraicGroup/Reductive/Basic.lean:71–83`), as the paper's
  "connected reductive group" needs ([GLC1] §0.1.1). The theta characteristic is the choice of
  [GLC1] §1.3.2. The pinning is not in the paper's text, where it is implicit in the character
  `χ`; the plan has a theorem that the statement does not depend on it
  (`Satake.isLanglandsFunctor_iff_of_changePinning`).
- **The two properties.** Property 1 (line 99) is the first item of Cor. 1.6.5: the bound may
  depend on the object. Property 2 (line 101) is the second item, in the linear form of
  Prop. 1.7.2.
- **The conclusion.** The theorem (line 115) says that such a functor exists and that each one is
  an equivalence. The second half is equivalent to Conj. 1.6.7, by the uniqueness in Cor. 1.6.5
  and by Prop. 1.7.2. The first half is a theorem of the paper (it follows from Thm. 1.6.2). So
  the Lean theorem is "Thm. 1.6.2's consequence and Conj. 1.6.7". This is stronger than the
  conjecture alone, on purpose, and it prevents an empty statement.
- **Linear in place of plain functors.** Cor. 1.6.5 and Conj. 1.6.7 speak of plain continuous
  functors. The code uses `QCoh(LS_Ǧ)`-linear functors and linear equivalence. This is the same
  statement, because a linear functor is a linear equivalence exactly when its underlying functor
  is an equivalence. It is not needed, see Finding 4.
- **Field.** [GLC1] §0.1.1 says "a field of characteristic 0". The code adds `IsAlgClosed`, as
  the owner's goal and [GLC2] §0.4.1 do. The module docstring should say that this is the
  owner's scope, not a hypothesis of [GLC1].
- **Known caution, still open.** All 30 placeholders are `opaque`, so the theorem says nothing
  yet. `STATUS.md` already records this.

### Finding 4. The linear layer of `Enhanced.lean` can go (medium, with Finding 1)

`GLCinLean/Statement/Enhanced.lean` has 22 placeholders. Nine exist only to speak of linear
functors: `MonoidalDGCat` and its carrier, `DGModule` and its carrier, `DGModule.toDGCat`,
`regularModule`, and `TStructuredDGModule` with its carrier and `toModule`. `LinFun` and `LinIso`
also lose their linear reading. With property 2′ every functor in the statement is a
plain continuous functor. The statement then needs only: DG categories, objects, compactness,
continuous functors with composition and identity, natural equivalence, adjunction, a
t-structure, and equivalence. That is Cor. 1.6.5 and Conj. 1.6.7 word for word, and Prop. 1.7.2
becomes a later theorem. If the owner keeps the current property 2, this finding does not
apply, because `LCoarse` is then compared as a linear functor.

### Finding 5. Three uses of the tracker work against it (medium)

See question 4 below.

### Finding 6. Smaller points on the plan (low)

- **`QCohLS` depends on a theorem, not on its definition.** In
  `plans/GLCinLean/Statement/Conjecture.toml` the only library dependency of `QCohLS` is
  `LocalSystems.qcohRigid`. The object is `Sheaves.qcoh` on `LocalSystems.deRham` with its
  monoidal structure; rigidity is a property. With property 2′ rigidity leaves the statement.
- **`Sheaves.determinant` plans more than the statement needs.** It plans the determinant of
  every perfect complex. `det_{Bun_G}` ([GLC1] §1.1.1) needs only the cohomology of a vector
  bundle on a curve, which has amplitude `[0, 1]`. The two-term determinant is enough.
- **The complex-analytic part is small but deep.** `Satake.icStalkParity` is the only user of 8
  nodes, among them `Constructible.decompositionTheorem`. `STATUS.md` already defers this
  decision. Property 2′ does not remove it, because geometric Satake stays.
- **Locators to roadmap layers are fragile.** Many descriptions cite a layer number and a commit
  of Tau Ceti main. Three different commits appear in 452 descriptions. See question 4.

## Answers to the five questions

### 1. Is the statement faithful to [GLC1] Conj. 1.6.7?

Yes. Finding 3 gives the checks. The hypotheses are those of [GLC1] §0.1.1 with the owner's
choice of an algebraically closed field. The characterisation is that of Cor. 1.6.5, in the
linear form of Prop. 1.7.2. The existence half makes the statement stronger than the conjecture,
not weaker.

### 2. Does the plan reach a fully defined statement?

- **Reach.** Yes in structure: each of the 30 placeholders has suggested dependencies that lead
  to library nodes, and these lead to existing Mathlib and Tau Ceti declarations. 465 of the 483
  nodes are reachable from the main theorem. The 18 others are the 6 examples, 2 `Iff.rfl`
  lemmas, 5 results that are wanted but not used (for example
  `Langlands.coarse_globalSections_iso_coefficient`, [GLC1] §1.4.6), and 5 leaves. None is waste:
  the examples are required by `AGENTS.md`.
- **Missing.** Nothing was found missing on the direct path. The one wrong link is the
  dependency of `QCohLS` (Finding 6).
- **Wrong.** No wrong node was found, within the limit stated above.
- **More than the statement needs.** With the current form, nothing: the proof of Thm. 1.2.4 is
  needed. With property 2′, 180 to 195 nodes are more than the statement needs (Finding 1).
  `Sheaves.determinant` is more general than needed (Finding 6).

### 3. Is there a simpler or more direct faithful formulation or route?

Yes: property 2′ of Finding 1, with the plain functors of Finding 4. It saves about half of the
library nodes and four fifths of the theorems, and it removes the part of the plan whose written
proofs have gaps. It is equivalent to the paper's form by a theorem that the paper cites. Stating
property 2 as an adjunction but keeping the spectral action saves only 6 nodes, so it is not
worth doing alone. No simpler route was found for the ∞-category layer or for geometric Satake.

### 4. Is the tracker the right way to hold the plan?

Yes. It is one small tool, it checks the plan against the compiled code, it gives each subagent
its brief (`show`), and its graph feeds the page of session 5. Other tools would cost more: a
LaTeX blueprint is a second system, and stubs with `sorry` break the rule of one `sorry`. Its
value grows once library code exists. Three uses in this plan should change:

1. **Upstream leaves as plan nodes.** `plans/Mathlib` and `plans/TauCeti` hold 70 nodes for
   declarations that exist. The tracker treats what is outside the project as a boundary
   (`tools/tracker/README.md`, "Dependencies"), so the leaves that are not imported show as
   `open` and fill `tracker ready`. Proposal: delete the two folders and name the upstream
   declaration in the `desc` of the node that uses it. The count of open nodes is then honest.
2. **Placeholders count as proved.** 30 of the 55 "proved" nodes are placeholders, and their
   kept `desc` and `deps` cause the 88 lint warnings. `plans/README.md` and `prompts/build.md`
   each carry a caution for this. Proposal: ask the tracker's author for one option that reads an
   attribute and reports a tagged declaration as `stated`. Until then the present way is the best
   available, and the cautions stay.
3. **Provider, owner and snapshot in free text.** The tracker allows no extra key, so each `desc`
   repeats the provider and a commit of Tau Ceti main. The commits are already old (Tau Ceti main
   gains about 1,000 commits a day) and nothing checks them. Proposal: keep in `desc` only
   "Provider: here" or "Provider: roadmap ⟨name⟩ ⟨target⟩", without layer numbers and commits.
   Keep the one snapshot in `docs/blueprint-providers.md`.

One more point for the workflow review: the plan has 427 open nodes in full detail before any
library code exists. The detail of the far layers will change when the near layers are written.

### 5. Which suggestions of §7 of `notes/upstream-2026-11-10.md` should change the plan?

- **Suggestion 1 (two provider texts): apply.** `Sheaves.determinant` gets the providers
  PadicMeasuresIwasawaAlgebras §5.1 and AlgebraicVectorBundles L0C, and its scope becomes the
  two-term case (Finding 6). `Hecke.schubertStratum_deRhamCohomology_even` gets SchubertGeometry
  and FlagVarieties for the cells.
- **Suggestion 2 (watch #1734, #1687, #848): no change to the plan.** All three are open, not
  approved, and wait for dependencies. None of the nodes they touch can start now, because each
  depends on `Derived.prestack` and so on the ∞-category layer. `prompts/build.md` already says
  to check upstream before implementation. Record the three as owner candidates in
  `docs/blueprint-providers.md`, with these limits: #1734 builds the Grassmannians over `𝔸^J`,
  not over powers of the curve; #1687 defines sheaves on stacks in another way than the plan's
  right Kan extension; #848 serves only the complex-analytic part.
- **Suggestion 3 (#1676 locators): no change now.** #1676 is still open. If the layer numbers
  leave the descriptions (question 4, point 3), this kind of update is not needed again.
- **Suggestion 4 (AxiomMath as prior art): acceptable, but nothing to port now.** The licence
  (Apache 2.0) and Tau Ceti's practice allow a port with attribution, through Worker, against an
  accepted roadmap target. No candidate is on the critical path, which is the ∞-category layer;
  AxiomMath has none of it. Case by case:
  - Cotangent complex (core closure 9,600 lines, Mathlib only): the best candidate, for
    DerivedModuleAlgebra §0.4, when work reaches `Derived.affineCotangentComplex`.
  - Complex points (40 lines): only if the owner keeps the complex-analytic route to parity.
  - Two-term determinant (18,200 lines): it covers what `det_{Bun_G}` needs; offer it when work
    reaches `Stacks.determinantBundle`.
  - Stacks 03RM (closure 1.2 million lines): no port. Its two plan nodes (`Etale.*`) leave the
    statement's plan under property 2′.
  - StacksFrontier is not reviewed, and some of its theorems take unproved inputs as hypotheses.
    Each ported theorem needs a check of its hypotheses.

## Decisions for the owner

| # | Decision | Proposal |
|---|---|---|
| 1 | Restate the second property with the Hecke action (property 2′) | yes; it is a change to the statement, so it needs `prompts/review.md` and approval |
| 2 | Use plain continuous functors and drop the linear placeholders | yes, if decision 1 is yes |
| 3 | Move the nodes that only the spectral action needs to a plan of the proof | yes, if decision 1 is yes |
| 4 | Say in `prompts/build.md` and `STATUS.md` that the first work is Worker rounds on the ∞-category roadmaps | yes |
| 5 | Delete `plans/Mathlib` and `plans/TauCeti`; shorten the provider text | yes |
| 6 | Ask the tracker's author for a placeholder option | optional |
| 7 | Correct `QCohLS`'s dependency and the scope and providers of `Sheaves.determinant`; correct the providers of `Hecke.schubertStratum_deRhamCohomology_even` | yes |
| 8 | Record #1734, #1687 and #848 as owner candidates in `docs/blueprint-providers.md` | yes |
| 9 | Accept AxiomMath code as prior art for Worker ports, case by case, none now | yes |
| 10 | Say in the module docstring that `IsAlgClosed` is the owner's scope | yes |
