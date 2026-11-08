# Joël Riou, "Formalization of derived categories in Lean/Mathlib"

- **Source:** Annals of Formalized Mathematics, Volume 1 (2025), pp. 1–42,
  DOI [10.46298/afm.13609](https://doi.org/10.46298/afm.13609), published 2025-07-15 (received
  2024-05-17, final form 2025-01-20). Journal page <https://afm.episciences.org/15978>, PDF
  <https://afm.episciences.org/15978/pdf>; preprint HAL `hal-04546712v5`.
- **Companion code:** [joelriou/lean-derived-categories @ `c1d75ec`](https://github.com/joelriou/lean-derived-categories/tree/c1d75ecdb3bbb9d85b161bade0aadfa1c2b7f6e4)
  (2025-06-25; Lean `v4.21.0-rc3`; requires Riou's Mathlib fork at `d886e33`). One file,
  `LeanDerivedCategories.lean` (766 lines), with `#check`s following the paper's sections.
- **Compared against:** the Mathlib this project actually builds with, `.lake/packages/mathlib`
  at `1b1ccf4b` (2026-11-02, through Tau Ceti `v4.36.0-rc2`), and Tau Ceti at `e0610cc`.
- **Checked 2026-11-08.** Licence: the paper is CC BY 4.0 [R, PDF p. 1]; the companion
  repository has no licence file (GitHub API reports none) [R].
- **How read:** whole PDF, through `pdftotext` (diagrams partly garbled) [R]; the companion file,
  sections 5.2–5.4 in full, the rest by its outline [R]. The fetch tool refused the journal host
  (it resolves to a private address here), so the page and PDF were taken with `curl` into
  `.lake/research/riou-derived/` (not committed).
- **Second check, 2026-11-08:** an independent pass re-read the paper text (§§1.9, 1.11, 3.7.5–3.7.7,
  4–5.2), the journal page, the companion repository, the pinned Mathlib and Tau Ceti files and
  the PR states on GitHub. Corrections and additions from that pass are marked "(second check)".

## 1. What it is

A 42-page paper by the author of Mathlib's homological algebra, describing how Mathlib defines
the derived category `D(C)` of an arbitrary abelian category `C`: as the **localization of
unbounded cochain complexes `CochainComplex C ℤ` at quasi-isomorphisms**, given a triangulated
structure through the Verdier quotient of the homotopy category `K(C)` by acyclic complexes
[R, abstract and §4]. Section 5 ("Ongoing works") covers Ext groups, t-structures, derived
functors and spectral sequences: "Very significant parts of these are already formalized, but it
may take a certain time before they enter mathlib" [S, p. 30]. The work was done on the Mathlib
branch `jriou_localization` [S, §1.9, p. 4] (second check: the branch is named in §1.9, not on
p. 30).

It is entirely **1-categorical**: triangulated categories with shift functors and distinguished
triangles, no ∞-categories or DG enhancements anywhere in the paper [R].

## 2. What it says that matters for GLCinLean

### Design decisions in Mathlib's derived category

- **Localization by a predicate, not a construction.** `L.IsLocalization W` says a functor `L`
  is "a" localization; most of the API works for any such `L`, so a category equivalent to the
  constructed one can be used [R, §3.3]. Stability under `op`, products and composition are
  instances [R, §3.4].
- **The universe problem.** Morphisms of the constructed localized category live in
  `Type (max u v)`, not `Type v` [R, §3.7.3]. Mathlib therefore asks for a chosen localization:
  `abbrev HasDerivedCategory := MorphismProperty.HasLocalization.{w} (quasiIso C (up ℤ))`, and a
  proof that does not mention `D(C)` in its statement opens with
  `have := HasDerivedCategory.standard C` [R, §3.7.6–3.7.7; same text in
  `Mathlib/Algebra/Homology/DerivedCategory/Basic.lean`]. Getting `w = v` for a Grothendieck
  abelian category needs a v-smallness theorem resting on Hovey's model structure [R, §3.7.5],
  expected "after a few years" [S, p. 19]; on the pinned
  Mathlib Hovey appears only in that docstring and no `HasDerivedCategory.{v}` instance exists
  [R, grep 2026-11-08].
- **Shifts** are a monoidal functor `Discrete A ⥤ (C ⥤ C)`; `shiftFunctorAdd'` takes a proof
  `h : i + j = k` instead of rewriting indices, and `Functor.CommShift` packages compatibility
  with shifts [R, §4.2]. Cochain compositions likewise take `h : a + b = c` [R, §4.3.3].
  This "explicit index equation" style recurs across Mathlib's homological algebra.
- **Diagram chasing "up to refinements"** (`epi_iff_surjective_up_to_refinements`,
  `ShortComplex.exact_iff_exact_up_to_refinements`) replaces pseudo-elements in general abelian
  categories [R, §2.2].
- **Sources and conventions:** Verdier's definition of distinguished triangles, Conrad's sign
  conventions (for the connecting maps of Ext, [Con00, §1.3]), and BBD §1.3 (cited as
  [Bei+18], the 2018 edition of *Faisceaux pervers*) for t-structures: "it was easy to translate
  the written arguments into formal proofs in Lean/mathlib" [R, pp. 25, 31]. That remark is about
  t-structures in general, not about perverse sheaves (second check).

### What the pinned Mathlib has (checked against the paper's claims)

| Item | Paper | Pinned Mathlib `1b1ccf4b` |
|---|---|---|
| `DerivedCategory C`, triangulated, `Q`, `Qh` | merged June 2024, PR #11806 [S, p. 30] | present, `Algebra/Homology/DerivedCategory/Basic.lean` [R] |
| `R`-linear structure on `D(C)` | not in paper | present, `DerivedCategory/Linear.lean` [R] |
| Ext groups as `Hom(X, Y[n])`, long exact sequences | §5.1, PRs #14515, #15092 [S] | present, `DerivedCategory/Ext/` [R] |
| Canonical t-structure `DerivedCategory.TStructure.t` | §5.2.1 | present, `DerivedCategory/TStructure.lean` [R], defined by strictly ≤ n / ≥ n representatives, with `isGE_iff`/`isLE_iff` lemmas [R]; PR #27395 merged by Bors 2025-09-01, #27536 ("complementary embeddings") merged by Bors 2025-08-11 [R, GitHub API: closed with "[Merged by Bors]" titles; GitHub's own `merged_at` is null, as usual for Bors] |
| `TStructure`, truncations, `plus`/`minus`/`bounded`, t-exact functors, the spectral object of truncations | §5.2.3–5.2.4 | present, `CategoryTheory/Triangulated/TStructure/` (`TruncLEGT`, `TruncLTGE`, `TExact`, `SpectralObject`; `plus := ∃ n, t.IsGE X n` at `Basic.lean:259`) [R] |
| **The heart is abelian** | "I have formalized" [S, §5.2.2]; companion uses `[t.HasHeart]` and `Abelian t.Heart`, and `(t : TStructure (DerivedCategory C)).Heart = C` by `rfl` [R, companion l. 572–581] | **not yet**: the general BBD 1.2 criterion `Triangulated.AbelianSubcategory.abelian` (needs `[IsTriangulated C]`) exists, but `Heart.lean` and `Basic.lean` keep the TODO "show that the heart is an abelian category" [R]. Mathlib uses a different interface from the companion: `t.heart : ObjectProperty C` and a class `t.Heart H` saying an additive category `H` identifies with it; `HasHeart` does not exist, and no `Heart` instance for the canonical t-structure (heart ≅ `C`) was found [R, grep] (second check). These pieces landed in Feb–Mar 2026 (#35392 "the heart of a t-structure", #35387 "abelian subcategories", #35381, #35370 "the spectral object") [R, GitHub search]; no open Riou PR titled with "heart" besides #25848 [R, search 2026-11-08] |
| `rightDerivedFunctorPlus : D⁺(C) ⥤ D⁺(D)`, derivability structures (Kahn–Maltsiniotis), K-injective / K-projective | §5.3 | present [R, file names and grep] |
| Spectral sequences: `SpectralSequence`, `E₂CohomologicalSpectralSequenceNat`, spectral objects | §5.4.1, 5.4.4 | present, `Algebra/Homology/SpectralSequence/Basic.lean`, `SpectralObject/` [R] |
| Convergence (`StronglyConvergesTo`, `HasPageInfinityAt`), five-term sequence, Grothendieck spectral sequence | §5.4.2–5.4.5 | **not found** [R, grep] |
| Sheaf cohomology as Ext | predicted, §1.8 | present, `CategoryTheory/Sites/SheafCohomology/Basic.lean` [R] |

The umbrella PR #25848 ("redefinition of homology + derived categories", about 150 extracted PRs
[S, p. 4]) is still **open** on 2026-11-08 [R, GitHub API], so the API is still moving. Docstrings
lag the code too: `TStructure/Basic.lean` still says the canonical t-structure on the derived
category is "(TODO)", although `DerivedCategory/TStructure.lean` defines it [R] (second check).

Tau Ceti already builds on it: `TauCeti/CategoryTheory/Sites/SheafCohomology/*`,
`TauCeti/Topology/Sheaves/Cohomology/*`, `TauCeti/CategoryTheory/DG/CochainComplex/KInjective.lean`
and others import `DerivedCategory` or `TStructure` [R, grep of Tau Ceti `e0610cc`].

**Tau Ceti already has a first enhancement of `D(C)`** (second check; the first pass listed
`KInjective.lean` only as an importer) [R, Tau Ceti `e0610cc`, file headers and statements]:

- `TauCeti/CategoryTheory/DG/` defines DG categories (`TauCeti.DGCategory`, enriched in cochain
  complexes), their homotopy category `DGHomotopyCategory` (H⁰) and quasi-equivalences.
- `TauCeti/CategoryTheory/DG/CochainComplex/KInjective.lean:180`:
  `dgNerveHomotopyCategoryEquiv [HasKInjectiveResolutions C] :
  (dgNerve R (KInjectiveDGCategory C)).HomotopyCategory ≌ DerivedCategory C`, i.e. the DG nerve
  of K-injective complexes (a quasicategory in Mathlib's `SSet.Quasicategory` sense) has Mathlib's
  `DerivedCategory C` as homotopy category. An instance `HasKInjectiveResolutions (ModuleCat R)`
  exists (`TauCeti/Algebra/Homology/ModuleCat/KInjective.lean:180`).
- This is exactly the kind of "∞-category → Mathlib triangulated category" map that §3.2 below
  asks for, for derived categories of abelian categories. It is not yet presentable stable
  `k`-linear ∞-categories in general: the Tau Ceti roadmap EnhancedDerivedSheaves plans stability,
  presentability, compact generation and Ind comparisons [R, its README, roadmap repo `7bf4638`],
  and `tauceti-roadmaps.md` reports these "still absent" [S of that note].

### What it does not provide (relevant to GLC)

- Only the derived category **of an abelian category**. Nothing about compact objects,
  coproducts or compactly generated triangulated categories. On the pinned Mathlib, `Triangulated/`
  has no compact objects either [R, grep 2026-11-08], but it does have classical and strong
  triangulated generators (thick closures, `Triangulated/Generators.lean`, 2026) and Verdier
  localizing subcategories (`LocalizingSubcategory.lean`) [R, file headers] (second check: the
  first pass said "nothing" here). Compact generation in GLC's sense (via arbitrary coproducts)
  is still absent [R].
- No enhancement (DG or ∞), so no functorial cones, no well-behaved limits of categories, no
  categories of functors that are again triangulated [J, standard; the paper does not discuss it].

## 3. What it means for GLCinLean

1. **The GLC statement itself cannot be stated faithfully in this 1-categorical world** [J].
   GLC I states the conjecture for presentable stable `k`-linear ∞-categories: GLC I says only
   "Notations and conventions in this paper largely follow those adopted in [AGKRRV]"
   (`functor.tex` l. 1268 [R]), and AGKRRV defines `DGCat` as "the ∞-category of presentable
   stable ∞-categories, equipped with a module structure over `Vect_e`" (arXiv 2010.01906v2,
   `text.tex` l. 2141–2145 [R]) (second check: the first pass attributed the ∞-categorical wording
   to GLC I itself, which does not contain it). `𝕃_G` is "uniquely characterized" by its values on compact
   objects and `Ψ ∘ 𝕃_G ≃ 𝕃_{G,coarse}` (Cor. 1.6.5, `functor.tex` l. 1830–1850 [R]). That
   uniqueness, the ind-extension from compacts, `D-mod(Bun_G)` as a limit over quasi-compact
   opens, and `QCoh(LS_Ǧ)`-linearity of the spectral action all need an enhancement [J]. And
   `QCoh(LS_Ǧ)` (a derived stack) and `IndCoh_Nilp` are not derived categories of their hearts in
   general, so `DerivedCategory C` is the wrong carrier for them [J, not checked against a source].
   This supports the existing design note in `GLCinLean/Foundations.lean` (l. 80–90): `DGCat` is a
   placeholder for the enhanced theory, not for `DerivedCategory`.
2. **But the shadow is useful for *meaning*** (ideas.md: "Link to the existing literature ... a
   mathematician should be able to trust ... the expected meaning") [J]. For an exact functor of
   stable ∞-categories, being an equivalence is detected on homotopy categories [J, standard fact,
   source not checked here], and "eventually coconnective" is exactly Mathlib's
   `TStructure.plus` on the homotopy category. So a later `DGCat` could carry a map to Mathlib's
   pretriangulated categories with a `TStructure`, and `DGCat.IsEventuallyCoconnective` could
   become a real definition instead of a bare `opaque` [J]. Step 2 of `notes/workflow.md` (decide
   whether `Abstract.lean`, `Foundations.lean` and their placeholders stay) should weigh this.
   Two refinements (second check):
   - the map need not be invented here: Tau Ceti's `dgNerveHomotopyCategoryEquiv` (§2) is the
     existing pattern, and EnhancedDerivedSheaves plans the general one [R, §2 above]; using
     theirs follows ideas.md §3 (order of sources) and "Avoid duplication" [J];
   - EnhancedDerivedSheaves fixes a convention that limits this idea: "Every comparison with an
     ordinary category is a theorem about mapping spaces, never a definition by passage to the
     homotopy category", and "An equivalence of quasicategories is a categorical equivalence ...,
     never just an equivalence of homotopy categories" [R, README]. So `LinFun.IsEquivalence`
     should stay an ∞-categorical notion, with "detected on homotopy categories" as a theorem
     [J]. A t-structure, by contrast, is normally *defined* on the homotopy category of a stable
     ∞-category (Lurie, HA Def. 1.2.1.4, per `mathlib-coverage.md` [S of that note; HA not read
     here]), so `IsEventuallyCoconnective` via `TStructure.plus` would not break the convention [J].
3. **The library goal can start now on this base** (ideas.md §1, "a library for geometric
   representation theory (D-modules, perverse sheaves, etc.)") [J]. Perverse sheaves are the heart
   of a t-structure on a triangulated category in BBD itself [J, standard], and BBD §1.3 (the
   t-structure chapter) is the part Riou found easy to formalize [R, p. 31]; he says nothing about
   the perverse part of BBD. The missing general piece is "the heart is abelian" (criterion present,
   instance missing) [R]. The perverse t-structure itself also needs the six operations on
   constructible derived categories, which neither this paper nor the pinned Mathlib provides [J]. Bounded derived categories of D-modules on smooth varieties are derived
   categories of abelian categories [J]. Under ideas.md §3 ("first Mathlib"), these parts should
   use `DerivedCategory`, `TStructure`, `ShortComplex` and `rightDerivedFunctorPlus`, not new
   definitions.
4. **Duplication risk** (ideas.md: "Avoid duplication"; "continuously refactor to adopt their
   decisions"). The heart-is-abelian theorem, convergence of spectral sequences and the
   Grothendieck spectral sequence already exist on Riou's branch [S, paper; the companion file
   `#check`s them against Riou's fork `d886e33`, e.g. `grothendieckSpectralSequence`,
   `StronglyConvergesTo`, l. 32, 677–747, R; that it compiles is S] and are not yet merged [R].
   The heart pieces are arriving in small PRs (§2 table), so the wait is real but active [J]. Writing them in GLCinLean or Tau Ceti would duplicate work that is
   expected to arrive upstream [J].
5. **Keeping up with Mathlib** (workflow decision "Keeping up with Mathlib and Tau Ceti is fully
   automated"; step 5 Refactor). PR #25848 is still open and the TODOs above are live, so code on
   top of `TStructure` and `DerivedCategory` will see upstream changes [J]. The refactor prompt
   should look for these specifically.
6. **Conventions for code and review** (ideas.md §2, Mathlib style). Concrete conventions to
   follow and to check in review [R, §3.7, 4.2, 4.3.3]: carry `[HasDerivedCategory.{w} C]` as a
   variable in definitions; use `HasDerivedCategory.standard` only inside proofs; state index
   arithmetic with explicit equations (`shiftFunctorAdd'` style); use `IsLocalization` rather
   than the constructed localization.

## 4. Conflicts

- **With the computed task text.** It said PRs #27395 and #27536 were "for the canonical
  t-structure", merge status unchecked. Both are merged [R, GitHub API 2026-11-08]; #27536 is
  titled "complementary embeddings", a prerequisite rather than the t-structure itself [R, title
  only].
- **Within the paper versus Mathlib.** The paper says the heart was formalized as abelian
  [S, §5.2.2]; on the pinned Mathlib it is still a TODO [R]. Not a contradiction (§5 is
  "ongoing works"), but any note or prompt that says "Mathlib has abelian hearts" is wrong today.
  `mathlib-coverage.md` §2.8 states this correctly.
- **With `notes/ideas.md`.** None directly. One tension [J]: ideas.md §3 orders sources as
  Mathlib → Tau Ceti → Stacks, and §4 sends roadmap-covered work to Tau Ceti and everything else
  to the owner's repository first; the natural home for "the heart is abelian" or "compact objects
  in triangulated categories" is Mathlib itself (where the derived-category work is done), which ideas.md does not mention as a
  destination (second check: reworded; the first pass said §4 sends work "only to Tau Ceti").
- **With `notes/workflow.md` decisions.** None.
- **With `GLCinLean/Foundations.lean` (l. 80–84).** Its note "No provider has this enhanced theory
  yet" is still true for presentable stable `k`-linear ∞-categories, but no longer for
  enhancements as such: Tau Ceti has DG categories and a DG-nerve enhancement of `D(C)` (§2)
  [R]. Worth rewording in step 2 [J] (second check).
- **With other sources.** Tau Ceti's EnhancedDerivedSheaves convention (no definitions by passage
  to the homotopy category) cuts against the broadest form of §3.2; see the refinement there
  (second check). Otherwise none found: `tauceti-library.md` (Mathlib `DerivedCategory`,
  `Pretriangulated` [R]) and `mathlib-coverage.md` §2.8 agree with what is above.

## 5. Input for the open questions (`notes/workflow.md`)

- **Whether `Abstract.lean`, `Foundations.lean` and their placeholder design are reasonable.**
  The suggestion is to keep `DGCat`, `DGCat.Obj` and `LinFun` as placeholders, because Mathlib's
  derived categories are 1-categorical and only cover abelian categories (§3.1) [J]. Consider
  grounding the *predicates* (`IsEventuallyCoconnective`, later `IsCompact` and equivalence) in
  Mathlib's `TStructure` and triangulated API through a homotopy-category map, so that fewer
  bare `opaque` declarations carry meaning that a reader has to trust (§3.2) [J]. This adds a
  design commitment before the ∞-theory exists, which is the owner's call. If done, it should go
  through Tau Ceti's enhancement-to-`DerivedCategory` comparisons rather than a new map, and keep
  equivalence ∞-categorical, in line with EnhancedDerivedSheaves' convention (§3.2) [J].
- **What goes into `AGENTS.md`.** At most one line of working advice [J]: "Derived and
  triangulated categories: use Mathlib's `DerivedCategory` and `TStructure`; carry
  `[HasDerivedCategory.{w} C]`; the GLC categories are ∞-categorical and are not
  `DerivedCategory`." Anything longer belongs in the plan, not the shared context.
- **Who reviews the mathematics, and to what standard.** A weak data point: the merged code went
  through Mathlib review (Commelin reviewed "massively" [S, p. 5]) in about 150 small PRs [S].
  Code built on it inherits that standard for the foundations [J]; it says nothing about who
  checks the GLC-specific surface.

## 6. Questions for the owner

1. **Statement design.** Should the GLC statement stay fully on ∞-categorical placeholders until
   Tau Ceti's EnhancedDerivedSheaves exists, or should some predicates (eventually coconnective,
   perhaps compact) be tied now to Mathlib's triangulated categories and t-structures through a
   homotopy-category map, following Tau Ceti's `dgNerveHomotopyCategoryEquiv` pattern? (Tying
   *equivalence* this way would go against EnhancedDerivedSheaves' stated convention, §3.2.)
2. **Library base.** May the geometric-representation-theory library (perverse sheaves, bounded
   derived categories of D-modules) be built now on Mathlib's 1-categorical `DerivedCategory` and
   `TStructure`, knowing that a bridge to the later ∞-categorical versions will be needed?
3. **Upstream destination.** For missing 1-categorical pieces that belong in Mathlib (the abelian
   heart instance, compact objects in triangulated categories), should GLCinLean wait for Riou's
   branch, contribute to Mathlib directly, or go through Tau Ceti? ideas.md names only Tau Ceti
   as a destination.
