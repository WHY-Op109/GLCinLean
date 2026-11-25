# Check of `proposal/riemann-hilbert-provider` (commits `581fbf0`, `cc49450` on `8cde2a3`)

**Result.** The proposal is right in its main lines: the move of the three constructible nodes, the new roadmap node for §1.5, and the narrower scope of the two nodes written here. I found no mismatch of an object with its source. There is one *unsure* clause, one entry that the session must add to `GLCinLean.lean` when it applies the change, and six wording corrections. I changed no file. The branch has no Lean item, so no blind reading was needed.

Paths: the worktree is `/Users/why/Documents/Projects/GLCinLean/.claude/worktrees/agent-a6b9e8df509a9f9bc`. The roadmap text is `/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/a7db057a-3bb8-4d94-9a2c-5ae19d70d1fd/scratchpad/roadmap/TauCetiRoadmap/MixedHodgeModulesAndIrregularHodgeTheory/README.md` (called "the roadmap" below; merged as `82b2362b`, read at `b24abdf7`).

## Findings that need a change

**F1. *Unsure*: the compatibility for three embeddings in `DModules.analyticDeRham`.** File `plans/GLCinLean/AlgebraicGeometry/DModules/AnalyticDeRham.toml`, line 6, part (c): "The node includes that these isomorphisms are compatible for three embeddings, so that DR_Y does not depend on the embedding up to a unique isomorphism."
- The proof of this compatibility goes through `X_1 × X_2 × X_3`. It needs that the isomorphisms `pDR ∘ f_+ ≅ Rf_* ∘ pDR` of clause (3) of `DModules.regularHolonomicDeRham` are compatible with the composition of maps. That roadmap node states natural isomorphisms for each map and no compatibility with composition. The roadmap §1.5 (line 141) says only "compatible with `f_+` and `Rf_*`".
- No user needs it. Statements (1) to (4) of the node, and every compatibility of `DModules.analyticDeRham_isEquivalence`, are statements that an isomorphism exists. They need the isomorphism for two embeddings only.
- "Unique isomorphism" is the wrong word: isomorphisms of functors are not unique. The correct word would be "canonical".
- What to change: delete the sentence, and keep the isomorphism for two embeddings as the theorem that shows independence of the choice. The alternative is to add the compatibility with composition to clause (3) of the roadmap node, marked as a part beyond the target. I recommend the first.

**F2. The session must add an entry to `GLCinLean.lean` when it applies the change.** `GLCinLean.lean` lines 126–128 say: "## Not formalized / No claim of the sources is given up."
- The dropped clause is a claim of the node's own source. The old node said that DR "carries bounded holonomic complexes to D^b_c(Y, C)" and "takes holonomic modules to perverse sheaves". This is Kashiwara's constructibility theorem in [HottaTakeuchiTanisaki] Chapter 4. The book is not in `references/`, so I could not check the theorem number.
- `AGENTS.md`, "Small and big changes", lists "a claim of the source that the plan drops" as a big change, and "Plan" asks for a record under "Not formalized". After the change the sentence in line 128 is false.
- The entry to add, in place of line 128: "[HottaTakeuchiTanisaki] Chapter 4 (the constructibility theorem of Kashiwara): the de Rham complex of a bounded holonomic complex that is not regular is constructible, and that of a holonomic module is perverse. The de Rham functor `DModules.analyticDeRham` is defined on the regular holonomic complexes only; no declaration uses the functor on other complexes." Check the theorem number against the book first.
- The narrower scope needs no entry. [HottaTakeuchiTanisaki] states the correspondence for smooth varieties only (`STATUS.md` line 102 says the same). So the scope "closed in a smooth scheme" is a generalization of the source, and no claim of a source is given up. The doc comment of the future declaration records it, as "Writing" says. Nothing goes under "Differences from the sources" of the root file: the two nodes are used only in proofs (see item 2), so the statement is not affected.

## Verdict for each item

### 1. The roadmap nodes against their passages

I checked every quoted passage of the four nodes mechanically against the READMEs of MixedHodgeModulesAndIrregularHodgeTheory, EtaleDualityAndPerverseSheaves, ComplexComparisonPartII, SpringerResolutionAndCharacteristicCycles and EnhancedDerivedSheaves. Every quote is there word for word. I compared the old and new text of the three moved nodes word by word: clauses (1) to (7) and the checks are unchanged, and (8) is the only new mathematical clause.

- **`Constructible.DerivedCategory`** against §1.2 (roadmap line 86): *agree*. Schemes, space, field, coefficients and the constructibility condition match. Clause (8) is the target's ("the two localization triangles", "functorial in `K`"). The parts beyond the target are all marked as (i) to (iv). I found no unmarked part. Correction: the composition isomorphisms appear only under "The target states more than this node", but `DModules.analyticDeRham` (c) and the part "Maps" of `DModules.analyticDeRham_isEquivalence` use them. Add them to clause (1); the target states them, so there is no risk.
- **`Constructible.PerverseSheaves`** against §1.3 (line 104): *same object, different presentation*. The node defines the t-structure by supports and duality; the target defines it by conditions on strata. The node's argument for the equivalence is correct. The parts beyond the target are marked. One small part is not marked: the node states the two conditions for every stratification with smooth connected strata along which both restrictions are lisse, and the target for Whitney stratifications. The wider statement is true.
- **`Constructible.StratifiedDerivedCategory`**: *agree* that "prerequisite, not a named target" is right, and that the new area is the right place. Tau Ceti's `AGENTS.md` (lines 8–11) allows a declaration that "supplies a prerequisite that a specific target needs". SpringerResolutionAndCharacteristicCycles §11.3 is such a target: it needs the "complexes on F(C) constructible along the Schubert cells", exactness for the perverse t-structure, and `j_!`, `j_*`, `j_!*` along the cells. The node names it. Correction: the sentence "§1.1 gives the algebraic Whitney stratifications and the local triviality along their strata, from which the goodness of Whitney stratifications follows" claims more than §1.1 states. §1.1 (line 75) states that a proper map is locally trivial over the strata of its target. The local triviality of a Whitney stratified space along a stratum is Thom's isotopy lemma with control data, AlgebraicTopologyPartII §§16.1a–16.1e, which §1.1 lists under "Needs". Name that input.
- **`DModules.regularHolonomicDeRham`** against §1.5 (line 141): *agree*. Object, base field ℂ, coefficients ℂ, left modules, covariant direction and `pDR = DR[d]` all match.
  - Reading "pure dimension": right. It is a restriction, supported by the roadmap's "Conventions" (line 60, "smooth of pure dimension `d`") and by Springer §9.1 (its line 850).
  - Reading "no further shift": right. The planner tested a closed immersion. I tested a smooth map: for `p : A¹ → pt`, `p^†ℂ = O[1]`, `pDR(O[1]) = ℂ[2] = p^!ℂ`. Springer §9.1 has `f† = Lf*[dim Y − dim Y′]`, as the node says.
  - Correction: clause (3) asserts that `f_+`, `f_!` and `f^†` preserve regular holonomic cohomology. §1.5 presupposes this and no accepted roadmap states it as a target (roadmap line 1144 is a request to another roadmap). The node says so under "Inputs", but it does not list it as a part beyond the target with the rule that a declined part comes back, as the three other nodes do. Add that sentence.

### 2. The two nodes written here

- **`DModules.analyticDeRham`**: *agree* on the object, the scope and the construction, apart from F1. The source field is right: [Crystals] Proposition 4.2.5 says "The functor `i_{dR,*}` … is t-exact" (`references/papers/1111.2087v4/src/Crystalstext.tex`, line 2391). The checks (a point, `C_Y[d]`, a closed point of a singular scheme) are correct and rule out a trivial reading.
- **`DModules.analyticDeRham_isEquivalence`**: *agree*. The proof outline uses only clauses that the nodes it names state. The degree convention of its user ("D-module degree i corresponds to the constructible degree i − d_μ") agrees with the construction.
- **The reason for the scope**: *agree*. The objects of a triangulated category do not glue along an open cover, and §1.5 gives the functor on triangulated categories only. A general scheme needs the enhanced form of `D^b_c` and of `pDR`, or the reconstruction from the perverse hearts; no accepted target states either. One wrong attribution in the note (section 3.8): the words "on ordinary derived categories" are not in §1.5, which says "the bounded derived category with regular holonomic cohomology".
- **A better scope**: no. The scope is stable under closed and open subschemes, products and graphs, which is what the proof uses. "Quasi-projective" is a stronger hypothesis with no gain. I agree with the planner's choice.
- **The users**: each is served.
  - `Satake.ic_starRestriction_isEven` (`plans/GLCinLean/GeometricLanglands/Satake/Spherical.toml`, line 26) uses closures of Schubert strata, which are projective. It is the only user in `plans/`. Above it are only theorems and then definitions (`Satake.sphericalHeart_semisimple`, then `Satake.geometricSatakeHeartEquivalence`), so the two nodes are lemmas of proofs.
  - `Satake.regularSheafExt_complexComparison` (`plans-proof/GLCinLean/GeometricLanglands/Satake/Comparison.toml`, line 4) does not name its schemes. Its dependency `DModules.boundedEquivariantExt_baseChange` describes the finite stages: "a finite jet group quotient" and "bounded truncations of the simplicial quotient". These are products of a finite Schubert union with powers of a smooth connected affine group. They are quasi-projective, so they are in the scope, and the face maps are maps of such schemes.
  - Correction: the sentence of `DModules.analyticDeRham` "Every use is on a finite union of Schubert varieties, which is projective" is therefore too narrow for the proof plan. Write "on a finite union of Schubert varieties, or on its product with powers of a finite jet quotient of L⁺G; all are quasi-projective".
  - No other node of `plans/` or `plans-proof/` uses the de Rham comparison, also not implicitly (searched), and none uses the functor on a complex that is not regular.
- Small: `GLCinLean.DModules.IsHolonomic` is still in the `deps` of `DModules.analyticDeRham` although the new text does not use it.

### 3. "Small and big changes" and "Plan"

*Agree*, with F2. Both weakenings are big changes and are handled as such. Both are justified.
- The scope: `AGENTS.md`, "Lean code": "A lemma used in a proof may be weaker than the paper's, as long as it still proves what it is used for." The old claim is true but cannot be reached from the accepted targets, so no `wrong` mark is needed.
- The dropped clause: no node uses it, and no accepted target provides it. The planner cites "no abstraction that nothing uses"; the better reasons are the scope of the plan (`plans/README.md`) and the missing provider.

### 4. The decisions of `STATUS.md`

*Agree*: the proposal is consistent with both decisions.
- "D-modules on smooth schemes": the new roadmap node is in the generality of its roadmap, and the crystal versions stay here, as for `DModules.regularHolonomicDModule` and `DModules.IsRegularHolonomic`.
- "The decomposition theorem": it already has the rule that a declined part "comes back through `prompts/change.md`". Each part beyond a target carries that sentence (a general field, `𝔻𝔻 ≅ id`, Hom by global sections, `g^! ≅ g^*[2d]`, the classification of simple perverse sheaves). I note that `g^! ≅ g^*[2d]` is likely a prerequisite of §1.5 itself, for the compatibility with `f^†` along a smooth map.
- Sentences of `STATUS.md` that become false at the apply step, beyond those the note lists: in the decision "The decomposition theorem" (line 145), "`DModules.analyticDeRham` claims an image in the complexes constructible along a stratification…" (the clause is now in `DModules.analyticDeRham_isEquivalence`), "The three are prerequisites and not named targets" and "roadmap nodes of the same area"; in the open item of line 111, "the open TauCetiRoadmap #2279".
- One provider question stays open and is recorded: the stability of regular holonomic complexes is asked for in clause (3) of the roadmap node and is also planned here in `DModules.IsRegularHolonomic`.

### 5. "Writing" and the sources

*Agree*. The node texts and the changed parts of `docs/blueprint-providers.md` state current facts, with no history apart from the dated snapshot rows that the file already has. The counts are right (4 nodes in the new area, 1 in EtaleDualityAndPerverseSheaves, 89 roadmap nodes in 16 areas). No stale mention of the old state remains in `plans/`, `plans-proof/` or `docs/`.
- Dimca and Kashiwara 1984 are named as the roadmap's citations and marked as missing from `docs/references.bib`. The titles and sections match the roadmap's bibliography (lines 1222 and 1224). No entry is needed while no doc comment here cites them.
- The note of [HottaTakeuchiTanisaki] in `docs/references.bib` says "Chapters 2–3, 6–8", and the nodes also cite Chapters 1 and 4. This was so before the change.

### 6. The tools

*Agree*. `lake exe tracker lint`: exit 0, no error, 61 warnings, the same 61 as on `main`. `python3 tools/check-module-cycles.py`: "197 module plans, 310 nodes, 0 cycles". `python3 tools/check-upstream-names.py`: "335 pairs …; 0 not confirmed". No roadmap node depends on a node written here. Nothing in `GLCinLean/`, `GLCinLean.lean`, `STATUS.md`, `AGENTS.md`, `prompts/` or `tools/` changed.

## Claims of the note that I tested

- The pinned Tau Ceti (`553f7926`) has no analytification of a scheme, no perverse sheaf, no D-module de Rham functor and no constructible derived category: confirmed by search. It has constructible étale sheaves of modules as a property (`TauCeti/AlgebraicGeometry/Sites/Etale/Constructible.lean`), which is not the analytic category.
- Every smooth separated scheme of finite type is closed in a smooth one of pure dimension: correct.
- `i^* i_* ≅ id` from base change, and the equivalence onto the objects that vanish on the complement: correct.

## Not checked

- [HottaTakeuchiTanisaki], Dimca and Kashiwara 1984: none is in `references/`. Statements about them rest on the roadmap's citations and on memory.
- The numbers of [BBD] in the `source` fields, which the nodes mark as unchecked.
- The statements of ComplexComparisonPartII §C−1.1 and C5.6 beyond the quoted words.
- `lake build` and the done check: the branch changes no Lean file.
- Whether Tau Ceti's review will accept the parts beyond the targets.
- `DModules.analyticDeRham_isEquivalence` uses C5.6 `deligneRiemannHilbert` directly, and no plan node stands for it. The tracker waits for it only through `DModules.regularHolonomicDeRham`, which lists it under "Needs". I did not check that this is enough.