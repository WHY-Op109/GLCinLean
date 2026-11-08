# Audit: the Lean files and the placeholder design

- **Source:** GLCinLean's own Lean files,
  <https://github.com/WHY-Op109/GLCinLean/tree/0feeb6fa88b31cf418fe1ecc304e358faf7b88f6>.
- **Checked 2026-11-08** (first written and then independently re-checked against the TeX on the
  same day).
- **Audited:** `GLCinLean.lean`, `GLCinLean/Foundations.lean`, `GLCinLean/Abstract.lean` at
  GLCinLean commit `0feeb6f` (pushed to `origin/main`; working tree, these files unmodified),
  with the statement decisions in `PLAN.md`.
- **Compared against:** GLC I, arXiv 2405.03599 **v3**, TeX source `functor.tex` (local copy in
  `references/papers/2405.03599v3/src/`; licence CC BY 4.0 as recorded in the manifest);
  Tau Ceti @ `e0610cce4004d628cbd9d2aafdbbb5459fe72938` (tag `v4.36.0-rc2`, Apache 2.0);
  Mathlib @ `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` (as pinned in `lake-manifest.json`);
  ReviewKit @ `3fd3bfa7`. For the hypotheses also: AGKRRV, arXiv 2010.01906 **v2**, `text.tex`,
  and GLC II, arXiv 2405.03648 **v3**, `Loc.tex`, both fetched from arXiv into
  `references/papers/` on 2026-11-08, with SHA-256 matching `manifest.toml` [R]. AGKRRV is
  under the arXiv non-exclusive licence, so it is only cited and quoted in a few words here.
- **Tags:** [R] read directly, [S] a source's claim about itself,
  [E] estimate, [J] judgement. All tags dated 2026-11-08.

## 1. What it is

The current formal statement of GLC, written as a stub on 2026-11-05 [R file headers].

- `GLCinLean/Foundations.lean` (148 lines): an "adapter layer". Six `abbrev` re-exports of
  Mathlib/Tau Ceti objects (`Scheme`, `SpecField`, `ReductiveGroup`, `Pinning`, `LineBundle`,
  `canonicalSheaf`, plus `LineBundle.tensor`), one real wrapper (`ReductiveGroup.coordinateRing`) and one real instance
  (`ReductiveGroup.smooth_coordinateRing`), then a family of "generic" placeholders for enhanced
  categories: `DGCat`, `DGCat.Obj`, `DGCat.IsCompact`, `DGCat.IsEventuallyCoconnective`,
  `LinFun`, `LinFun.obj/comp/id`, `LinIso`, and a real definition `LinFun.IsEquivalence` over
  them [R].
- `GLCinLean/Abstract.lean` (137 lines): the standing data (`structure Setting`), a placeholder
  `RootDatumDuality`, five placeholders for the `𝕃_G` chain (`DmodHalf`, `QCohLS`,
  `IndCohNilp`, `Psi`, `LCoarse`), the characterisation `IsLanglandsFunctor` (Cor. 1.6.5),
  existence and uniqueness theorems, `LG := Classical.choose …`, and `theorem main :
  (LG S).IsEquivalence` (Conj. 1.6.7). Four `sorry`s: `exists_dualGroup`,
  `exists_isLanglandsFunctor`, `isLanglandsFunctor_unique`, `main` [R].
- `GLCinLean.lean`: the root file, importing both [R].

## 2. What it says that matters (findings)

### 2.1 Does it elaborate, and is it sound?

- Both files elaborate with no errors through the Lean LSP, using the cached oleans (no Mathlib
  or Tau Ceti module was rebuilt) [R, `lean_diagnostic_messages`].
- Warnings: the four `sorry`s, and the Mathlib **header linter** (enabled by
  `weak.linter.mathlibStandardSet = true` in `lakefile.toml`) fires on both files: it reads the
  opening `/- … -/` comment as a malformed copyright header (six warnings in `Abstract.lean`:
  no "Copyright (c) YYYY", no "Released under …", no "Authors: " line), and there is no
  `/-! … -/` module docstring after the imports [R, re-run 2026-11-08].
- `#print axioms` for `main` and `LG`: `propext, Classical.choice, Quot.sound, sorryAx`. No
  project axioms [R, `lean_verify`].
- Trivial-proof probes: `inferInstance`/`aesop`/`simp` cannot produce `Nonempty (LinIso F G)`,
  prove `(LG S).IsEquivalence`, or produce `Nonempty (Setting k)` [R, `lean_run_code`, re-run
  2026-11-08]. Since every placeholder is `opaque`, the kernel
  never unfolds it, so `main` is neither provable nor refutable from the definitions [J]. This
  is what the design intends: the statement has the right *shape* but no content until the
  placeholders are replaced.
- `LG` is built by `Classical.choose` from a `sorry`'d theorem. A proof of `main` would still
  carry `sorryAx` through `LG`'s definition [R, `#print axioms LG`], so an axiom check catches a
  "proof" that skips existence [J]. Good.

### 2.2 Faithfulness to GLC I, hypothesis by hypothesis

The paper's set-up (Intro §0.1.1, `functor.tex` l.717–719) [R]:
"Let $k$ be a field of characteristic $0$. Let $X$ be a smooth and complete curve and $G$ a
connected reductive group over $k$. Let $\cG$ be the Langlands dual of $G$, viewed also as a
reductive group over $k$." Conventions "largely follow those adopted in [AGKRRV]" (l.1268) [R].

| Lean | Paper | Verdict |
|---|---|---|
| `[Field k] [CharZero k]` | char 0 field (l.717) [R] | faithful [J] |
| `[IsAlgClosed k]` | not in GLC I's sentence (l.717). GLC I says its conventions "largely follow" AGKRRV (l.1268); AGKRRV fixes a ground field "assumed algebraically closed" (`text.tex` l.2066–2067) and, for D-modules, takes `k` of characteristic zero (l.2087–2088); GLC II works "over a fixed algebraically closed field $k$ of characteristic $0$" (`Loc.tex` l.1497) [R] | faithful to the series' conventions; the Abstract's citations of these lines are correct [R]. Weaker than GLC I's sentence read literally [J]. It also matters for the pinning: over a non-closed field a reductive group need not be split, so requiring a `Pinning` would silently restrict `G` to split groups [J] |
| `X : Scheme.{u}`, `X.Over (Spec k)`, `SmoothOfRelativeDimension 1`, `IsProper`, `ConnectedSpace X` | "smooth and complete curve" [R] | faithful; "complete" = proper; "connected" is in AGKRRV's "smooth, connected and complete curve" (`text.tex` l.15123) and GLC II needs it for contractibility of Ran (`Loc.tex` l.37293–37294; GLC II's own sentence says "smooth projective curve", l.1502) [R]. Tau Ceti already has `Scheme.IsCurveOver k` (integral, proper, dimension 1; `Curves/Basic.lean:37`) [R], which the hand-rolled block duplicates in part [J] |
| `G : ReductiveGroup k` (Tau Ceti `ReductiveAffineGroupSchemeCat`) | "connected reductive" | faithful: Tau Ceti's predicate is "smooth and geometrically connected and … no nontrivial connected normal smooth unipotent closed subgroup" (`Reductive/Basic.lean` docstring) [R] |
| `rank : ℕ`, `pinning : Pinning G rank` | the word "pinning" does not occur in `functor.tex` (grep: 0 hits; also none for "Borel", "maximal torus") [R]. §1.3 uses $T$, $B$, $N$ without naming them (l.1501–1502), Dynkin vertices, `ρ(ω_X)` and maps `χ_i` that "record the class of the extension" (l.1629), which presuppose such choices; the footnote says the sign choice "does not matter because the situation is equivariant with respect to the action of $T$" (l.1667–1668) [R] | acceptable as a universally quantified choice, giving a statement at least as strong [J]. `rank` is redundant: Tau Ceti's torus is a `SplitMaximalTorus`, so the rank is fixed by `G` [R def; J consequence]. The docstring "(GLC I §1.3)" overstates what the paper says [J] |
| `sqrtOmega`, `sqrtOmegaIso : (L ⊗ L).obj ≅ Ω_{X/k}` | "The Langlands functor depends on the choice of the square root $\omega_X^{1/2}$ … which we fix" (l.1511) [R] | faithful; quantifying over all choices is right [J] |
| `dualGroup`, `dualIdentification : RootDatumDuality G dualGroup` + `exists_dualGroup` | "Let $\cG$ be the Langlands dual of $G$" (l.719) [R] | faithful in shape [J]. The docstring cites "GLC I §1.3", but the dual group is introduced in the Introduction (l.719); §1.3 is the vacuum Poincaré sheaf [R] |

The objects of the chain:

- `DmodHalf S`, docstring "twist by `ω_X^{1/2}`". The paper defines $\Dmod_{1/2}(\Bun_G)$ by the
  $\mu_2$-gerbe of square roots of $\det_{\Bun_G}$ (l.1391–1394) [R]; that does **not** depend on
  $\omega_X^{1/2}$. The square root only gives the identification
  $\Dmod_{1/2}(\Bun_G)\simeq\Dmod(\Bun_G)$ (eq. `e:untwist`, l.1405) and enters the Poincaré sheaf [R]. The
  docstring is wrong in detail [J]. Signature: every chain object takes all of `S`; the real ones
  depend on less (`DmodHalf` on `X, G`; `QCohLS`, `IndCohNilp` on `X, Ǧ`) [J].
- `QCohLS` "(GLC I §1.4)": $\QCoh(\LS_\cG)$ first acts in §1.2 (spectral action, l.1420ff.)
  [R]; `LS_Ǧ` itself is not defined in GLC I (it refers to AGKRRV/[AG]) [J: no definition
  found by reading §1; not a full-text proof of absence].
- `IndCohNilp` "(§1.6)": correct; the paper takes it from [AG, Sect. 11.1.5] (l.1820) [R].
  `Psi` "(§1.6)": correct, eq. `e:coarsening` (l.1821), "t-exact and induces an equivalence" on
  eventually coconnective parts [R]. `LCoarse` "(§1.6)": it is *defined* in §1.4 (l.1723–1724), as
  the right adjoint of $\BL^L_{G,\mathrm{temp}}$, "automatically $\QCoh(\LS_\cG)$-linear" by
  rigidity (l.1729; the TeX there says $\BL_{G,\on{temp}}$, an evident typo for the coarse
  functor [J]); §1.6 only uses it [R].
- `DGCat.IsEventuallyCoconnective` is an opaque predicate on objects of *every* `DGCat`, "for the
  category's standard t-structure". A general DG category has no standard t-structure; the paper
  uses the t-structure of $\IndCoh_\Nilp(\LS_\cG)$ specifically (l.1821–1825) [R]. The real
  interface will need the t-structure as data of that category [J].

The characterisation and the conjecture:

- Cor. 1.6.5 is `c:main dr` (l.1833) and Conj. 1.6.7 is `c:GLC dR` (l.1861) [R labels]. The
  numbers are counted from the TeX, not read from the compiled PDF: every theorem-like
  environment shares the `subsubsection` counter (`\newtheorem{cor}[subsubsection]…`,
  l.22–35), and §1.6 (`\ssec` at l.1799, the sixth of §1) contains in order `\sssec` (l.1804),
  thm (1808), `\sssec` (1818), `\sssec` (1828), cor (1833), `\sssec` (1852), conj (1861); so
  1.6.5 and 1.6.7. Likewise Prop. 1.7.2 at l.1939 [R count; numbering not seen compiled].
- **The paper's Cor. 1.6.5 is about plain colimit-preserving functors**: "There exists a
  (colimit-preserving) functor $\BL_G$ … uniquely characterized by" sending compacts to
  $\IndCoh_\Nilp(\LS_\cG)^{>-\infty}$ and $\Psi\circ\BL_G\simeq\BL_{G,\mathrm{coarse}}$
  (l.1833–1849) [R]. The $\QCoh(\LS_\cG)$-linear structure comes later, in **Prop. 1.7.2**
  (`p:L and Hecke`, l.1939): "The functor $\BL_G$ carries a uniquely defined
  $\QCoh(\LS_\cG)$-linear structure" [R].
- The Lean `IsLanglandsFunctor` instead ranges over `LinFun (QCohLS S) …` (linear functors) and
  asks for a *linear* isomorphism. So the Lean existence theorem is Cor. 1.6.5 + Prop. 1.7.2, and
  the Lean uniqueness theorem is a linear-uniqueness statement the paper proves only implicitly.
  The `LinFun` docstring's "GLC I Cor. 1.6.5: continuous `QCoh(LS)`-linear functors" is
  therefore a wrong citation, and `PLAN.md`'s decision "The properties are about continuous
  `QCoh(LS)`-linear functors" (l.47–48) records the reformulation as if it were the paper's
  [R].
  For the conclusion this is equivalent: a linear functor is a linear equivalence iff its
  underlying functor is an equivalence [J, standard for module categories]. But it is a
  reformulation, not a transcription, and the docstrings cite only Cor. 1.6.5 [J].
- A literal transcription would need only plain continuous functors and isomorphisms on the
  statement surface; linearity is needed only *inside* the definition of `LCoarse` (via the
  spectral action). That would remove `A` from `LinFun` and simplify the interface [J].
- `LinFun.IsEquivalence` (two-sided inverse up to isomorphism) matches "equivalence in DGCat"
  [J]. Nothing yet says it is invariant under `LinIso`, which `main` implicitly relies on
  (uniqueness only up to iso); that lemma would come with the real theory [J].

### 2.3 Vacuity risks

- `Setting k` needs a term of the opaque `RootDatumDuality G Gd`, so `Setting k` might be empty
  for all the kernel knows, and `main` (`∀ S`) would then be vacuous. The design answers this with
  `exists_dualGroup` as an explicit obligation [R]. It is unprovable while the placeholder is
  opaque, which is honest [J].
- The same risk exists for `Pinning G rank` and for square roots of `ω_X`: if Tau Ceti's
  `Pinning` (or the line-bundle/tensor API) were accidentally uninhabited, `main` would be
  vacuous, and there is no `exists_pinning` / `exists_sqrtOmega` obligation [J]. A single
  obligation "for every `X` and `G` as above there is a `Setting` over them" would cover all
  three [J].
- `Pinning` needs `[ConnectedSpace (PrimeSpectrum R)]` (Tau Ceti `Pinning/Basic.lean:90`) [R];
  it elaborates for a field, so an instance is found [R].

### 2.4 Does the invented interface fit what the providers will give?

- Mathlib has quasicategories (`AlgebraicTopology/Quasicategory/`) and 1-categorical
  presentability (`CategoryTheory/Presentable/`), but no stable or presentable ∞-categories and no
  DG categories [R grep; consistent with `mathlib-coverage.md`].
- Tau Ceti has **strict DG categories**: `TauCeti.DGCategory R C` is an `abbrev` for enrichment
  over `CochainComplex (ModuleCat R) ℤ` (`CategoryTheory/DG/Basic.lean:78`), with `DGFunctor`,
  `DGNatTrans`, `IsQuasiEquivalence`, a DG-to-simplicial construction [R]. The roadmap
  EnhancedDerivedSheaves plans presentable/dualizable categories on a dg-nerve/quasicategory
  model, still early (see `tauceti-roadmaps.md`) [S].
- Mathlib does have the 1-categorical vocabulary such an interface would mirror: actions of a
  monoidal category (`CategoryTheory/Monoidal/Action/Basic.lean`), functors linear for an action
  as typeclasses on `F : D ⥤ D'` (`F.LeftLinear C`, `Monoidal/Action/LinearFunctor.lean`), and
  t-structures on triangulated categories (`CategoryTheory/Triangulated/TStructure/`) [R]. These
  are 1-categorical (or triangulated) and cannot carry GLC's statement faithfully on their own,
  since uniqueness up to isomorphism in a homotopy category is weaker than in the enhanced
  sense [J]; but they fix the shape and names the enhanced versions are likely to copy [J].
- Root data: Mathlib has `RootPairing` and `RootDatum` with `RootPairing.flip`
  (`LinearAlgebra/RootSystem/Defs.lean` l.81, l.111, l.129) [R]. Tau Ceti uses them for the
  coordinate root datum of a split torus and for `GL_n` (`SplitTorus/RootDatum/`,
  `GeneralLinear/Root/Datum.lean`), but a grep finds no root datum attached to a general pinned
  reductive group [R grep]. So `RootDatumDuality` has a clear target: an isomorphism between the
  root datum of `Gd` and the `flip` of that of `G` [J].
- So the eventual objects will look like `(C : Type*) [Category C] [DGCategory k C] …` or a
  bundled category of presentable stable `k`-linear ∞-categories in a higher universe, with
  module structures over a monoidal category as data, and isomorphisms as `≅` in a functor
  category [J]. The current interface differs on every count:
  - `DGCat : Type` has **no `k` parameter** (not `k`-linear) [R];
  - it lives in `Type 0` whatever `u` is [R `#check DGCat : Type`], while presentable categories
    over `k : Type u` are large (objects in `Type (u+1)` or more) [J];
  - `LinFun A C D` mentions `A` but no monoidal structure and no actions (the docstring admits
    this) [R];
  - the names `DGCat`, `LinFun`, `LinIso`, `LinFun.IsEquivalence` will not match Mathlib's
    vocabulary (`Functor.IsEquivalence`, `≅`, `⋙`) [J].
- Verdict: the interface will be thrown away, not adapted [J]. It is small (about 50 lines), so
  the cost is low, but the Abstract's signatures (and the pinned statement) will change with it
  [J].

### 2.5 Universe levels

- `k : Type u`, `X : Scheme.{u}`, `ReductiveGroup k`, `Pinning … : Type u` are consistent with
  Mathlib's convention that a scheme over `Spec k` has rings in the same universe [R/J].
  `Setting k : Type (u+1)` [R `#check`].
- `RootDatumDuality … : Type u` is reasonable [J]. Everything on the categorical side is in
  `Type 0`, which is a placeholder artefact and will become universe-polymorphic and larger [J].

### 2.6 The re-export layer and "the abstract imports only Foundations"

- `abbrev Scheme := AlgebraicGeometry.Scheme.{u}` gives a second name to a Mathlib object and
  forces `open AlgebraicGeometry hiding Scheme` in the Abstract [R]. Mathlib does not rename
  objects through aliases (aliases are for deprecations) [J; see `mathlib-style-guide.md`].
- The layer's purpose was ReviewKit's closure walk and import rule (`review imports`) [R
  Abstract header; `glc/project.toml` l.37–38 allows the Abstract only `Init`, `Mathlib`,
  `TauCeti`, `GLCinLean.Foundations`, and l.52 unfolds Foundations' abbrevs in the closure].
  Without ReviewKit, the purpose goes [J].
- In a library, the statement file would import the subject files that define D-modules,
  `IndCoh`, `LS`, etc. A single adapter file through which "every substantial object" passes does
  not scale to a library with many files and is a second index next to the blueprint [J].
- `ReductiveGroup.coordinateRing` and `smooth_coordinateRing` are real API that Tau Ceti lacks in
  this form [R: needed because `Pinning` is stated on the Hopf-algebra side]; they belong in a
  library file or a Tau Ceti PR, not an adapter [J].
- `@[placeholder]` is a plain `TagAttribute` from `ReviewKit/Attr.lean` [R]; Foundations imports
  ReviewKit only for it [R]. Replacing it is a few lines in GLCinLean, or a docstring convention
  [J].

### 2.7 Mathlib style

- Header: neither file has the copyright header or a `/-!` module docstring (linter warnings
  above) [R].
- Docstrings carry project bookkeeping ("Budgeted sorry", `reviews/statement-pin.toml`,
  "STUB written … by Claude Opus 5.5", `[J: …]` tags) [R]. Mathlib docstrings describe the
  mathematics; status belongs in the blueprint or tracker [J].
- Names: `main`, `LG`, `Psi`, `LCoarse` are not Mathlib-style descriptive names (for example
  `langlandsFunctor`, `isEquivalence_langlandsFunctor`) [J]. `exists_dualGroup`,
  `isLanglandsFunctor_unique`, `smooth_coordinateRing` are fine [J].
- No line over 100 characters [R awk]. `LinFun.comp F G = G ∘ F` follows Mathlib's
  `Functor.comp` order [R/J].
- Citations that are wrong or imprecise, see 2.2 [R]: dual group "§1.3" (in `RootDatumDuality`
  and `exists_dualGroup`; it is Intro l.719); `QCohLS` "§1.4" (first acts in §1.2); `LCoarse`
  "§1.6" (defined in §1.4); `LinFun` "Cor. 1.6.5: … linear" (linearity is Prop. 1.7.2);
  `DmodHalf` "twist by `ω_X^{1/2}`" (the twist is by the gerbe of square roots of
  `det_{Bun_G}`); "Standing hypotheses (GLC I §1 …)" (the hypotheses are in the Introduction,
  l.717–719). Overstated rather than wrong: pinning "§1.3" [J].

## 3. What it means for GLCinLean

- **Step 2 (Plan)** decides whether `Abstract.lean`, `Foundations.lean` and their placeholders
  stay. This audit says: keep the *statement design* (standing data as a structure, `𝕃_G` chosen
  by its characterisation, isomorphisms never equalities, opaque placeholders without
  `Nonempty` on isomorphisms), drop the adapter layer, and expect the categorical interface to be
  replaced [J].
- **ideas.md, "Defer to human-curated libraries" / "Avoid duplication"**: the `abbrev`
  re-exports duplicate names; use Mathlib/Tau Ceti names directly, and Tau Ceti's `IsCurveOver`
  where it fits [J].
- **ideas.md, "fully in Mathlib's documentation style" / "Set standards, and meet them"**: the
  files fail the header linter and mix status text into docstrings; fix when the file is next
  touched, not "later" [J].
- **ideas.md, "Link to the existing literature"**: citations should be exact (label + line or
  section), and the reformulation of Cor. 1.6.5 should cite Prop. 1.7.2 [J].
- **ideas.md, "a library for geometric representation theory"**: PLAN.md's rule that
  `Abstract.lean` "holds … every GLC-specific definition it needs" puts library definitions
  (D-modules, `IndCoh`) into the statement file; they belong in subject folders, with the
  statement file importing them [J].
- **workflow.md step 1** (what happens to each file) and **the review system**: dropping
  ReviewKit means replacing `@[placeholder]`; the tracker-based system would need some marker for
  placeholders [J; tracker not checked here].
- **Owner's files**: renaming `main`/`Setting` or changing signatures changes
  `reviews/statement-pin.toml` (pins `GLCinLean.Abstract.main` and `GLCinLean.Abstract.Setting`)
  [R], which the owner must approve.

## 4. Conflicts

- **PLAN.md vs ideas.md**: "Foundations re-exports provider objects (one name each)" and
  "Abstract imports only Mathlib, Tau Ceti and Foundations" conflict with "Avoid duplication",
  Mathlib style, and a library structure [J].
- **Abstract vs GLC I**: `IsAlgClosed k` and `ConnectedSpace X` are not in GLC I's own sentence
  (l.717–718) [R]. They are the conventions of the series: AGKRRV `text.tex` l.2066–2067 and
  l.15123, GLC II `Loc.tex` l.1497 [R, read 2026-11-08]. A conflict with GLC I's sentence read
  literally, not with the series [J].
- **Abstract vs GLC I**: Cor. 1.6.5 is stated in Lean over linear functors with linear
  isomorphisms; the paper states it over plain functors and adds linearity in Prop. 1.7.2 [R].
  Equivalent for the conjecture [J], but not a transcription.
- **Docstrings vs GLC I**: `DmodHalf` "twist by `ω_X^{1/2}`" (paper: gerbe of square roots of
  `det_{Bun_G}`, l.1394), the `LinFun` citation of Cor. 1.6.5 for linearity, and four section
  numbers (2.2, 2.7) [R].
- **PLAN.md vs GLC I**: the decision "The properties are about continuous `QCoh(LS)`-linear
  functors" presents the reformulation as the paper's Cor. 1.6.5 [R].
- **Foundations vs Tau Ceti**: Tau Ceti already has `TauCeti.DGCategory` (strict DG, `k`-linear);
  the Foundations comment calls DG categories "provider-less". True for the enhanced ∞-sense the
  paper needs, but the name `DGCat` collides conceptually with Tau Ceti's `DGCategory` [J].
- **`mathlib-coverage.md`** (another note) suggests exposing a `TStructure` so that
  `IsEventuallyCoconnective` gets a Mathlib model. Compatible with this audit, but it would add
  interface that this audit expects to be replaced [J].

## 5. Input for the open questions (workflow.md)

- **Are `Abstract.lean`, `Foundations.lean` and the placeholder design reasonable?**
  The soundness design is reasonable and checked: no axioms, no free isomorphisms, choice-based
  `𝕃_G` that still shows `sorryAx` [R tools]. The adapter layer and the categorical interface
  should change (2.4, 2.6) [J]. Suggest: one statement file in Mathlib style that imports library
  modules directly; placeholders kept as `opaque` next to where the real definition will live;
  add existence obligations for pinnings and square roots (or one for `Setting`) [J].
- **What happens to each file: the ReviewKit requirement and `@[placeholder]`.** The Lean files
  use ReviewKit only for the attribute [R]; if ReviewKit goes, define the tag locally or use a
  docstring convention [J].
- **Who reviews the mathematics, and to what standard.** This audit found six wrong or imprecise
  citations, one overstated one and one unflagged reformulation (Cor. 1.6.5 + Prop. 1.7.2) in
  about 290 lines, all of them marked "Unreviewed" stubs [R/J]. The second pass also corrected
  this note itself (an [S] claim about AGKRRV turned out checkable, and was right) [R].
  That suggests fresh-agent reviews against the TeX (label + line) catch real problems and are
  worth running per change, while the reformulation question (2.2) needs a human expert [J].
- **Whether `PLAN.md` is needed.** Its "statement decisions" are the only written record of why
  the hypotheses are what they are (AGKRRV conventions, quantification over choices) [R]; that
  content must survive somewhere, for example in the statement file's module docstring or the
  blueprint [J].

## 6. Questions for the owner

1. **Literal or reformulated Cor. 1.6.5?** State `𝕃_G`'s characterisation over plain continuous
   functors, as the paper does (simpler interface; linearity as a separate theorem, Prop. 1.7.2),
   or keep the current linear version? Suggestion: literal [J].
2. **Hypotheses beyond GLC I's sentence.** Keep "algebraically closed" and "connected", as the
   series' conventions say (AGKRRV l.2066, l.15123; GLC II l.1497, read 2026-11-08), or state for
   any char-0 field as l.717 reads? The latter would also need a non-split version of the
   pinning and of the dual group. Suggestion: keep the series' conventions, and say so in the
   module docstring [J]. An expert should still confirm.
3. **Existence obligations.** Add `sorry`'d existence theorems for pinnings and square roots of
   `ω_X` (or one for `Setting`), so a wrong definition cannot make `main` vacuous? This adds
   entries to `reviews/sorry-budget.toml` (owner's file).
4. **Drop the adapter layer?** Remove the `abbrev` re-exports and the rule "the abstract imports
   only Foundations", using provider names directly. This changes the pinned statement text in
   `reviews/statement-pin.toml` (owner's file).
5. **Renames.** Rename `main`, `LG`, `Psi`, `LCoarse` to Mathlib-style names now (one pin
   re-approval) or when the real definitions arrive (another re-approval then anyway)?

## 7. Verdict per part (keep / change / drop)

All [J], 2026-11-08, from the findings above.

| Part | Verdict | Why |
|---|---|---|
| Statement design (structure of standing data, `𝕃_G` by `Classical.choose` with existence and uniqueness, `main`) | **keep** | sound: no axioms, `sorryAx` still shows through `LG`, isomorphisms never equalities (2.1) |
| `Setting` | **change** | use Tau Ceti's `IsCurveOver` where it fits, drop the redundant `rank`, cite AGKRRV/GLC II in the docstring; add an existence obligation for the whole `Setting` (2.3) |
| `exists_dualGroup` | **keep** (or fold into one `Setting` existence theorem) | guards against vacuity (2.3) |
| `RootDatumDuality` | **change** | towards Mathlib's `RootDatum` and `RootPairing.flip` (2.4) |
| Chain objects `DmodHalf`, `QCohLS`, `IndCohNilp`, `Psi`, `LCoarse` | **change** | narrower signatures (depend on `X, G` or `X, Ǧ`, not all of `S`), corrected docstrings and citations (2.2) |
| `IsLanglandsFunctor`, `exists_…`, `…_unique` | **change** | either state Cor. 1.6.5 literally over plain functors (Prop. 1.7.2 separately) or cite both; owner question 1 |
| Interface `DGCat`, `DGCat.Obj`, `IsCompact`, `IsEventuallyCoconnective`, `LinFun`, `LinIso`, `LinFun.IsEquivalence` | **drop** when providers arrive; until then **change** minimally | no `k`, `Type 0`, no actions or t-structure as data; will not be adapted (2.4) |
| `abbrev` re-exports (`Scheme`, `SpecField`, `ReductiveGroup`, `Pinning`, `LineBundle`, `canonicalSheaf`) | **drop** | second names for provider objects (2.6) |
| `ReductiveGroup.coordinateRing`, `smooth_coordinateRing` | **keep**, moved | real API; belongs in a library file or a Tau Ceti PR (2.6) |
| Rule "the abstract imports only Foundations" | **drop** | fits ReviewKit, not a library (2.6) |
| `@[placeholder]` from ReviewKit | **change** | define locally or replace by a docstring convention (2.6) |
| File headers and docstrings | **change** | Mathlib header and `/-!` docstring; status text out of docstrings (2.7) |
| Names `main`, `LG`, `Psi`, `LCoarse` | **change** | Mathlib-style names; timing is owner question 5 |
| `GLCinLean.lean` root file | **keep** | standard |
