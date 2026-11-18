A check with `prompts/check.md` on 2026-11-18, round 2, of the plan and the provider record at `f7f1a90`. The report follows unchanged.

# Second check of `proposal/gerbes-provider` (plan and docs at `f7f1a90`)

**Result: agree. No mismatch.** Every finding of my first report is resolved. Two small points are *unsure*, and five wording notes remain; none changes a provider or the meaning of a node, so the planner can fix them as small changes. I changed no file.

The worktree head is `8e0e7f7`, one commit after `f7f1a90`; it adds only `notes/checks/gerbes-provider-codex-4.md`, so `plans/` and `docs/` are those of `f7f1a90`. I did not use Codex's reports (I saw the first lines of round 4 while listing files).

**A correction of my first report.** In M2 I wrote that Tau Ceti at the pin has no sheaf `𝔾_m` and no `μ_n`. That was wrong. `TauCeti/AlgebraicGeometry/Sites/Big/StructureSheaf.lean` has `Scheme.Gm S` (line 143) and `Scheme.mu S n` (line 219) as `Sheaf (fpqcTopology.over S) AddCommGrpCat`, `powHom` (165) and `isLimitMuKernelFork` (247); `TauCeti/AlgebraicGeometry/FiniteEtale/Kummer.lean` line 113 has `kummerCover`. Mathlib has `etaleTopology_le_proetaleTopology` and `proetaleTopology_le_fpqcTopology` (`Mathlib/AlgebraicGeometry/Sites/Proetale.lean` lines 75, 78), so both are étale sheaves. The roadmap says the same (SchemeAndStackFoundations README lines 4602–4607). Only the epimorphism claim is missing, as the planner says.

Roadmap lines are those of the two READMEs at `87035f35` (`/private/tmp/claude-501/-Users-why-Documents-Projects-GLCinLean/52d621d8-2c82-404f-9076-82338dfa7bdd/scratchpad/roadmap-dl/README.md` for AlgebraicModuliForArithmeticGeometry, and `ssf/README.md` in the same folder).

## Unsure

**U-a (unsure, small). `Stacks.stackification` does not state the universe levels that the plan needs.**
- Roadmap, SchemeAndStackFoundations line 3549: "for any small site `(C, J)` (a category `C : Type u` with `Category.{u} C` …) and any category-valued pseudofunctor `F : LocallyDiscrete Cᵒᵖ ⥤ᵖ Cat.{u, u}`".
- The plan's site is `Over S` for `S : Scheme.{u}`: objects in `Type (u+1)`. Tau Ceti's `SchPseudofunctor` has values in `Cat.{u, u + 1}` (`TauCeti/AlgebraicGeometry/Stack/Basic.lean` line 37). The roadmap applies the target to `Scheme.{u}` with the fppf topology in the same paragraph, so its stated signature and its own use differ.
- The node says only: "The roadmap states the stackification for a small site and names the fppf site of schemes as a case of it". `Stacks.gerbeChangeOfBand`, `Stacks.quotientStack`, `Stacks.classifyingAbelianGerbe`, `Stacks.relativeGerbe` and `Stacks.schemeRootGerbe` need the form for `Over S`. A worker that builds only the small-site form leaves them blocked.
- Fix: the node states the levels (site with objects in `Type (u+1)` and arrows in `Type u`; fibres as in `SchPseudofunctor`) and that the small-site form alone does not serve. This is not a consequence of choosing the big site: Mathlib's small étale site `X.Etale` has the same sizes.

**U-b (unsure, small). `LineBundle.Root.tensorProduct`: one comparison has no named owner, and a general statement sits in a line-bundle module.**
- The node says its tensor comparison is "matched with `InvertibleSheaf.tensorPow`". Roots use `InvertibleSheaf.tensorPow` (`L^{⊗(n+1)} = L^{⊗n} ⊗ L`), the monoidal functor uses `TauCeti.tensorPow` (`X ⊗ tensorPow X n`, `TensorPow/Basic.lean` line 63). The isomorphism between the two is named in no node. It can only be stated after `LineBundle.picardGroupoid`, so its place is this node. Fix: name it under "New in this node".
- "(1) for a symmetric monoidal category, the symmetric monoidal structure of the functor X ↦ `TauCeti.tensorPow X n`, stated in that generality" is planned in the module `GLCinLean.AlgebraicGeometry.LineBundle.RootTensorProduct`. "Lean code" asks for the canonical home and one concept per file. Fix (a split, small): a helper node in a module of its own under category theory; this node depends on it.
- The placement here is right by the rules: no roadmap at `87035f35` asks for a monoidal structure on a tensor power functor (searched all READMEs), and `TensorPow/Basic.lean` has none.

## 1. The findings of the first report

- **M1 (pullback on one site): resolved.** `Stacks.gerbeSliceRestriction` is a roadmap node, the prerequisite of `changeBand.slice` (line 7152), `liftingGerbe.slice` (7154) and "`RootGerbe_n(L)×X T≃RootGerbe_n(L|T)`, respecting its band" (2253). On the big étale site the pullback along S′ → S is this restriction, so the plan needs neither `relativePullback` nor `classSitePullback`; the node and the provider record say so. I confirmed that no target defines the restriction: the only mention is "the intrinsic band of the restricted gerbe" (line 1991). `Stacks.EtaleGerbe` clause (1) keeps only the compatibility with composition, the limit and maps of prestacks.
- **M2 (Kummer): resolved.** `Etale.kummer_shortExact` is in `plans/Roadmap/SchemeAndStackFoundations/KummerSequence.toml`, and `Stacks.schemeRootGerbe` depends on it. See my correction above.
- **U1 (the site): resolved.** `Stacks.EtaleGerbe`, `Stacks.schemeRootGerbe` and `Stacks.rootGerbe` name one site, "the schemes over [S] with the étale topology", with `Scheme.etaleTopology` and `GrothendieckTopology.over` (both exist). The band clause now holds for every abelian sheaf A. The difference from [GLys] §1.3.2 (affine schemes) is recorded.
- **U2 (contracted sum): resolved.** `Stacks.gerbeContractedSum` quotes line 7156 exactly and takes the product, the contracted sum and the inverse on one site. `Stacks.EtaleGerbe` keeps the associativity, commutativity, unit and inverse equivalences. The contrary sentences are gone.
- **U3 (roots): resolved.** `LineBundle.pullbackTensorIso` is the one owner of `f^*(M ⊗ N) ≅ f^*M ⊗ f^*N`; `LineBundle.Root` lists `𝒪^{⊗n} ≅ 𝒪` and the trivial root, with the roadmap's check quoted (line 2261).
- **Item 1 note (`abelianBandedGerbe` and §1.18): resolved.** The theorems moved to `Stacks.bandPreserving_isEquivalence`, which depends on `Stacks.relativeGerbe` and `Stacks.stackification`. I confirmed the chain: `band_morphism_full_faithful` needs `BandedMorphism.faithful` and `BandedMorphism.locallyIsomEquiv` (line 2045), which list `relativeGerbe` (lines 4974, 5062). The needs of `isomTorsor` (lines 2031, 4898, 4912) stay inside Layer 4.
- **Item 3 note ([GLys] §1.3.1): resolved.** "the band is a group-like E_n-object of the prestacks over Y, with values in spaces".
- **Item 6 (blocking): resolved.** `Stacks.stackification` and `Stacks.quotientStack` are split off; `Stacks.algebraicStack` depends on the first. No gerbe node depends on `Stacks.groupTorsor`.
- **Item 8 (provider record): resolved.** "Among its targets"; the providers of the pullback and the contracted sum; the Kummer supplier. Counts are right: 11 nodes in AlgebraicModuliForArithmeticGeometry, 6 in SchemeAndStackFoundations. The ready table has the ten roadmap modules that `lake exe tracker ready` lists. Tau Ceti #40965 is open and is the Kummer map of Galois cohomology.
- **Item 9 (terms): resolved**, with one slip (section 5).

## 2. The nodes new since `32874ad`

All quoted names and section titles exist; all named upstream declarations exist at the pin.

- `Stacks.gerbeSliceRestriction`: *agree*. Content and `deps` right; needs only Mathlib (`GrothendieckTopology.over`, `Over.iteratedSliceEquiv`).
- `Stacks.gerbeContractedSum`: *agree*. It is a prerequisite of one clause of a prose paragraph, not of a named target; the node says so.
- `Stacks.relativeGerbe`: *agree*. Matches line 1894; `deps` follow line 1904.
- `Stacks.bandPreserving_isEquivalence`: *agree*. Note 2 below.
- `Stacks.classifyingAbelianGerbe` and `Stacks.neutralGerbeEquiv`: *agree*. The contracted product of two torsors is rightly a prerequisite here: the pin has only `Sheaf.Torsor.map` (`Map.lean` line 150), and `contractedProduct` of SchemeAndStackFoundations §1.16 is `(P × X)/G` for a group space, a different object.
- `LineBundle.pullbackTensorIso`: *agree*. `pullbackToModulesMonoidal` (line 93), `isQuasicoherent_obj` (`Basic.lean` line 139) and the proof of `LineBundleClass.pullback_mul` (`Functoriality.lean` line 176) are as described.
- `Stacks.stackification`: *agree* on content; U-a.
- `Stacks.quotientStack`: *agree*. Note 4.
- `Etale.kummer_shortExact`: *agree*. The claims on the pin are right. Note 1.
- `LineBundle.picardGroupoid`: *agree*. Matches lines 6025–6031; `Scheme.Modules.instSymmetricCategory` exists.
- **Orientation of the band in `Stacks.schemeRootGerbe`: *agree*.** I checked the computation. With the action `g · ψ = ψ ∘ g` on `Isom(𝒪, M)`, the map `ψ ↦ φ ∘ ψ^{⊗n}` is equivariant along the n-th power, and `ζ · id_M` acts as the translation by `ζ`, the "positive translation by A" of line 7154. With the action `g·φ := φ ∘ (g⁻¹)` of `picEquiv` (SchemeAndStackFoundations lines 3319–3320) it is the translation by `ζ^{-1}`. The cube-root check separates the two; `μ_2` does not. `deps` are complete: `liftingGerbe` needs line 2161 are all covered.

Notes (wording only):
1. `Etale.kummer_shortExact` presents its big-site statement as the clause of `fppf_kummer_sequence`. That clause says "the étale site", cites Stacks Lemma 59.28.1 (the small étale site) and is exported with `muEtale`. The node's statement is stronger and implies it by restriction. Say so, so that a reviewer does not read the pull request as off target.
2. `Stacks.bandPreserving_isEquivalence` says "None of the four can be written at the pin". For `IsGerbe.equivalence_iff` the provider record says that #43615 already proves its gerbe conditions. Write "the roadmap lists §1.18 under its needs".
3. `Stacks.schemeRootGerbe` asks for a frame torsor with the action opposite to the one of `picEquiv` for the same sheaf. The node states the relation, so the meaning is fixed; say that Tau Ceti should have one frame torsor, and the other action through the inversion.
4. `Stacks.quotientStack` says "This part rests on §1.18 only". The Needs line of §1.21 (§1.13, §1.14, §1.15, §1.19, §1.20) does not separate the site-level part; the claim is a reading of the construction. Say so.
5. The provider record names four nodes that are prerequisites and not named targets. Add what happens if Tau Ceti refuses one for roadmap fit: the node comes back through `prompts/change.md` (the record says this for ReductiveGroups item (2)).

## 3. The nodes written here

- `Stacks.EtaleGerbe`: *same object, different presentation* against [GLys] §1.3.6, as before. `Stacks.rootGerbe` and `LineBundle.Root.tensorProduct`: *agree*.
- Every user still gets what it needs: pullback along maps of prestacks (`DModules.twistedExtraordinaryPullback`, `Whittaker.twistTrivialization`), tensor product and inverse (`Hecke.sphericalAction`, `Satake.criticalTwistBunDeterminantEquiv`), étale-local triviality and the torsor between two trivializations (`DModules.TwistedCrystals`), the root gerbe on a prestack with `R_n(f^*L)`, `R_n(L ⊗ M)`, `R_n(L^{-1})` (`Satake.criticalDeterminantGerbe`, `Automorphic.HalfTwistedDModules`). `Curves.ThetaCharacteristic` and `Curves.thetaCharacteristicProjectiveLine` depend only on `LineBundle.Root`, which waits for the ready module `LineBundlePullbackTensor`.
- In both: nothing found. In neither: only the comparison of the two tensor powers (U-b).

## 4. Plan checks

`lake exe tracker lint` exits 0 with no error (61 warnings, all the known ones on superseded fields). `python3 tools/check-module-cycles.py`: "165 module plans, 282 nodes, 0 cycles". Every `deps` entry names an existing node; no node of `plans/` depends on `plans-proof/`.

## 5. "Writing"

- `Stacks.EtaleGerbe` clause (2): "on one site and on Y, the equivalences … of the tensor product". On a site the term is "contracted sum".
- No history or status text in the new node texts. The sentence of the provider record on `7342e8fd` is the text of `1f973bd`, so this branch does not add it.

## Degenerate cases

Unchanged from the first report: the zero band, `μ_1` and n = 0 are not used by the statement, and the examples on ℙ¹ and on `𝔾_m` are kept.

## Limits

I checked the needs chains at the lines cited, not every auxiliary target of §§4.9–4.21. `STATUS.md` still has the "Held" row; the session updates it when it applies the change.
