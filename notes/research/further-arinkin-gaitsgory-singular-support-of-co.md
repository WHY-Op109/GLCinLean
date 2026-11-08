# Arinkin–Gaitsgory, *Singular support of coherent sheaves, and the geometric Langlands conjecture*

- **Source:** D. Arinkin and D. Gaitsgory, arXiv 1201.6343 **v4** (v1 30 Jan 2012; v4 3 Nov 2014),
  <https://arxiv.org/abs/1201.6343v4>. Published as Selecta Math. (N.S.) 21 (2015) 1–199,
  DOI 10.1007/s00029-014-0167-5 [R, arXiv API and Crossref, 2026-11-08; GLC I's bibliography
  gives the same volume and pages, `functor.tex` l.4426].
- **Read from:** the v4 TeX source (`https://arxiv.org/e-print/1201.6343v4`, one file
  `singsupp.tex`, 11,773 lines), unpacked into
  `references/papers/1201.6343v4/src/` (Git-ignored). SHA-256 of the downloaded e-print:
  `f10cac88ddc99cd48ecbec728efc94a1eac304d37368f1a80b69ba1c8d2a96f5`.
- **Read:** abstract; all of §1 (introduction, conventions); §4.1–4.2 (the definition), §4.4
  (t-structure); §3.3 (definition of support); §8.1–8.2 (stacks);
  §10.1, §10.4, §10.6 (`LocSys`); all of §11 (the conjecture); §12.8 (tempered part); §13.3
  (the generation theorem); the statement of Prop. 6.2.2; the opening of Appendix H; the
  bibliography. **Not read:** proofs in §§2–9, §§12.1–12.7, §13.1–13.2, Appendices A–G.
- **Section numbers** below are those of v4, computed from the TeX source by a small counting
  script (the paper numbers theorems inside the subsubsection counter) and checked against the
  content at each cited place [R, 2026-11-08]. A second, independent count by the checker agreed
  at every place cited here [R, 2026-11-08]. The checker also counted the v1, v2 and v3 sources
  (fetched only to a temporary directory, not kept): v2 and v3 agree with v4 at every place GLC I
  cites, **v1 does not** (v1 has 14 numbered sections; its §11.1.5 is unrelated, and its 13.3.6 is
  a Satake corollary) [R by script, 2026-11-08]. The Selecta version appeared 11 days after v4;
  that its numbering matches v4 is an estimate, not checked [E].
- **Licence:** arXiv non-exclusive distribution licence 1.0 [R, arXiv abstract page,
  2026-11-08]: link, do not copy; quotes here are short.
- **Checked 2026-11-08.** All tags below were checked on that date.

## 1. What it is

- The paper that **defines the spectral side** of the geometric Langlands conjecture as stated
  in GLC I: the category `IndCoh_Nilp(LocSys_Ǧ)` of ind-coherent sheaves with nilpotent
  singular support [R].
- GLC I does not define this category itself. It says: "Let `IndCoh_Nilp(LS_Ǧ)` be the category
  of \cite[Sect. 11.1.5]{AG}" (`functor.tex` l.1820; also l.731) [R].
- Three parts [R, §1.4]:
  - **Part I** (§§2–3): quasi-smooth DG schemes and the scheme of singularities `Sing(Z)`;
    support in triangulated categories acted on by a graded algebra (after Benson–Iyengar–Krause).
  - **Part II** (§§4–9): singular support of ind-coherent sheaves on quasi-smooth DG schemes,
    then on quasi-smooth Artin stacks; functoriality; compact generation.
  - **Part III** (§§10–13): the stack `LocSys_G`, the global nilpotent cone, the conjecture,
    and two consistency checks (geometric Satake, Eisenstein series).
  - Appendices A–H: group actions on categories, mapping spaces, Thomason–Trobaugh with
    supports, finite generation of Exts, `E_2`-algebras, Hochschild cochains, Lie algebras,
    other approaches to singular support.

## 2. What it says that matters for GLCinLean

### 2.1 Conventions [R, §1.5]

- `k` algebraically closed of characteristic 0; `X` a smooth, connected, complete curve; `G`
  connected reductive (§1.1.1, §1.5.1, §11 opening).
- The ∞-categorical conventions "follow completely" Drinfeld–Gaitsgory [DrGa1], §1 (§1.5.2).
- "category" means `(∞,1)`-category; DG categories are pretriangulated and **cocomplete**;
  functors are exact and **continuous**; subcategories are closed under direct sums (§1.5.2(iii)).
- Schemes and stacks are **derived by default** and locally almost of finite type; conventions
  for stacks, `QCoh`, `IndCoh` and `Dmod` are delegated to Gaitsgory's "Notes on Geometric
  Langlands: Stacks / QCoh" (unpublished web notes), [IndCoh] (Moscow Math. J. 13, 2013) and
  [Crys] (arXiv 1111.2087) (§§1.5.3–1.5.4, bibliography).

### 2.2 The definition chain of `IndCoh_Nilp(LocSys_Ǧ)` [R]

1. **Quasi-smooth DG scheme** (§2.1.3): the cotangent complex is perfect of Tor-amplitude
   `[-1, 0]`; equivalently (Cor. 2.1.6), Zariski-locally a derived fibre product
   `pt ×_{𝔸^m} 𝔸^n`. Rem. 2.1.4: the underlying classical scheme need not be l.c.i.
2. **`Sing(Z)`** (§2; introduced in §1.1.4): the classical scheme whose points are pairs `(z, ξ)`,
   `ξ ∈ H^{-1}(T*_z Z)`; affine over `Z`, with a `G_m`-action by dilations. Its functions are
   `Γ(Z, Sym(H^1(T(Z))))`.
3. **Support** (§3.3, Defs 3.3.3–3.3.4): for a triangulated category `T` acted on by an
   even-graded commutative algebra `A`, and a conical Zariski-closed `Y ⊂ Spec A`, a
   subcategory `T_Y` (§3.3.1: the intersection of the `T_{Y_a}` over homogeneous `a` vanishing
   on `Y`); `supp_A(t)` is the minimal such `Y` with `t ∈ T_Y`. AG's support is the
   **Zariski closure** of the Benson–Iyengar–Krause support (Rem. 3.3.5).
4. **The action** (§4.1.1–4.1.2): Hochschild cochains `HC(Z)` (an `E_2`-algebra) act on
   `IndCoh(Z)`; for quasi-smooth `Z` there is a graded map
   `Γ(Sing Z, O) → HH^even(Z)`, with `H^1(T(Z))` in degree 2.
5. **Definition** (Defs 4.1.4 and 4.1.5): `SingSupp(F) := supp_{Γ(Sing Z, O)}(F)`; for a
   conical Zariski-closed `Y ⊂ Sing(Z)`, `IndCoh_Y(Z)` is the full subcategory of objects with
   singular support in `Y`. (Z affine first; Zariski-local, §4.1 and §1.3.6(b).)
6. **Stacks** (§8.1–8.2): `𝒵` quasi-smooth if every smooth affine chart is; `Sing(𝒵)` by
   descent (equivalently `cl Spec_𝒵 Sym(T(𝒵)[1])`); and
   `IndCoh_Y(𝒵) := lim_{Z → 𝒵 smooth} IndCoh_{Y ×_𝒵 Z}(Z)`
   (§8.2.3).
7. **`LocSys_G`** (§10.1): `Maps(S, LocSys_G(X)) := Maps(S × X_dR, pt/G)`, with `X_dR` the de Rham
   prestack. It is QCA (§10.4.3), quasi-smooth (Prop. 10.4.5), and
   `Sing(LocSys_G) ≅ Arth_G`, the classical stack of triples `(P, ∇, A)` with `A` a horizontal
   section of `g*_P` (Cor. 10.4.7).
8. **`Nilp_glob`** (§11.1.1): the triples with `A` nilpotent, where `Nilp(ǧ*)` is the image of
   `Nilp(ǧ)` under "some (or any)" invariant identification `ǧ ≅ ǧ*`.
   §11.1.2 gives an equivalent form that needs **no** identification: with the Chevalley map
   `ϖ : ǧ* → 𝔠(ǧ) := Spec(Sym(ǧ)^Ǧ)`, `A` is nilpotent iff `ϖ(A)` factors through `{0} ⊂ 𝔠(ǧ)`.
   Lemma 11.1.4: nilpotent
   iff `A(x)` nilpotent at one (then every) point `x` — the proof uses that `X` is connected.
9. **The spectral side** (§11.1.5): "Our main object of study is the category
   `IndCoh_{Nilp_glob}(LocSys_Ǧ)`" — a full subcategory of `IndCoh(LocSys_Ǧ)` containing the
   image of `Ξ : QCoh(LocSys_Ǧ) → IndCoh(LocSys_Ǧ)`.

So the definition needs, in order: derived schemes and stacks, the cotangent complex,
`IndCoh` (with `!`-pullbacks and smooth descent), Hochschild cochains as an `E_2`-algebra
acting on `IndCoh`, BIK-style support, the de Rham prestack and mapping stacks, and the
nilpotent cone [J, from the chain above].

### 2.3 Properties that pin the definition down [R]

- **Zero section = QCoh** (Thm 4.2.6; stacks: Cor. 8.2.8): `IndCoh_{0}(Z)` is exactly the
  essential image of the fully faithful `Ξ_Z : QCoh(Z) → IndCoh(Z)`.
- **The adjoint pairs.** For an affine `Z`, AG define `Ξ^Y_Z : QCoh(Z) ⇄ IndCoh_Y(Z) : Ψ^Y_Z`
  with `Ξ^Y_Z` fully faithful (§4.3, l.3098). For a **stack** they state only
  `Ξ^{Y,all}_𝒵 : IndCoh_Y(𝒵) ⇄ IndCoh(𝒵) : Ψ^{Y,all}_𝒵`, the inclusion and its right adjoint
  (Cor. 8.2.6; the TeX has the typo `IndCoh(Z)` for `IndCoh(𝒵)`). GLC I's
  `Ψ_{Nilp,{0}} : IndCoh_Nilp(LS) → QCoh(LS)` (`functor.tex` l.1820–1826) is then
  `Ψ_{LS} ∘ Ξ^{Nilp,all}`, the stack analogue of the affine identity
  `Ψ^Y_Z ≃ Ψ_Z ∘ Ξ^{Y,all}_Z` (proof of Lemma 4.4.2) [R for the pieces; J that this is the
  intended composite — AG do not write it down for stacks].
- **t-structure** (§4.4.1, affine `Z`, and only for `Y` containing the zero section): defined by
  `F ∈ IndCoh_Y(Z)^{≤0} ⇔ Ψ^Y_Z(F) ∈ QCoh(Z)^{≤0}`;
  `Ψ^Y` is t-exact (Cor. 4.4.3) and induces `IndCoh(Z)^{≥0} ≃ IndCoh_Y(Z)^{≥0} ≃ QCoh(Z)^{≥0}`
  (Prop. 4.4.5). §1.3.9(d) summarises: "the difference between `IndCoh_Y(Z)` and `QCoh(Z)` is
  'at −∞'".
- **No t-structure for stacks in AG.** In §§8–11 the word "t-structure" occurs only once, for
  `QCoh` (l.7100); AG v4 never defines a t-structure on `IndCoh_Y(𝒵)` for a stack `𝒵`, so none
  on `IndCoh_Nilp(LocSys_Ǧ)` [R by search of the v4 TeX, 2026-11-08]. GLC I nevertheless uses one
  (`IndCoh_Nilp(LS_Ǧ)^{>-∞}`, l.1825, l.1842) and cites only the affine Prop. 4.4.5 for it. The
  stack version presumably follows by smooth descent with the same `Ψ`-characterisation [J], but
  it is a step the formalisation must supply itself.
- **Compact generation** (§11.1.6): `IndCoh_Nilp(LocSys_Ǧ)` is compactly generated, via
  `LocSys_Ǧ` being a global complete intersection (Prop. 10.6.6, Cor. 9.2.7). For a general
  QCA stack AG prove only dualizability (Cor. 8.2.12) and say they do not know compact
  generation, "not even for `Y = {0}`".
- **A second formula, depending on a point `x ∈ X`** (§11.1.6):
  `IndCoh_Nilp(LocSys_Ǧ) ≃ IndCoh(LocSys_Ǧ) ⊗_{QCoh(ǧ*/(Ǧ×G_m))} QCoh(Nilp(ǧ*)/(Ǧ×G_m))`.
  AG stress that the monoidal action used "depends on the choice of a point `x ∈ X`".
- **Torus case** (§11.2.6): for `G = T`, `Nilp_glob` is the zero section, so
  `IndCoh_Nilp = QCoh`, and the conjecture is Laumon–Rothstein Fourier–Mukai.
- **Other characterisations:** Koszul duality on a global complete intersection (§5, §1.3.6);
  point-wise via `i_z^!` and `Sym(H^1(T_z Z))` (Prop. 6.2.2); Drinfeld's criterion for
  coherent sheaves: `(z, ξ) ∉ SingSupp(F)` iff `i_*F` is perfect near `z` on a hypersurface
  (Thm 1.3.8 / Cor. 7.3.6); relation to Orlov's singularity category and others (App. H).
  [R statements only; proofs not read.]

### 2.4 The conjecture as AG state it [R, Conj. 11.2.2]

> "There exists an equivalence of DG categories `Dmod(Bun_G) ≃ IndCoh_{Nilp_glob}(LocSys_Ǧ)`."

- No functor is specified and the automorphic side is **untwisted** `Dmod(Bun_G)`. AG say
  "one needs to specify a lot more data to fix the equivalence ... uniquely. This will be done
  over the course of several papers following this one" (§11.2.5).
- AG's main theorem (Thm 13.3.6) is that the part of `IndCoh_Nilp` supported on reducible local
  systems is generated by spectral Eisenstein series from proper parabolics; with Prop. 13.3.3
  (on irreducibles, `IndCoh_Nilp = QCoh`), this is the minimality of `Nilp` (§1.2.5). The
  combined statement — `QCoh(LocSys_Ǧ)` and the images of `Eis^P_spec` for proper `P` generate
  `IndCoh_Nilp` — is Cor. 13.3.8; the minimality argument (§13.3.11) assumes the Eisenstein
  compatibility conjecture.

### 2.5 How GLC I cites AG [R, `functor.tex` v3; AG numbering by script]

| GLC I line | Cites | What is at that place in AG v4 | Match |
| --- | --- | --- | --- |
| l.731, l.1820 | Sect. 11.1.5 | the spectral side `IndCoh_{Nilp_glob}(LocSys_Ǧ)` | yes |
| l.1826 | Prop. 4.4.5 | `≥0` parts equivalent, **for an affine quasi-smooth scheme** | no: AG define no t-structure on `IndCoh_Y` of a stack (§2.3) [R by search]; the `>−∞` form follows from `≥0` by shifting [J] |
| l.3553 | Sect. 11.1.6 | compact generation of `IndCoh_Nilp(LocSys_Ǧ)` | GLC I uses it for `LS^restr`, an AGKRRV object [J] |
| l.3768 | Thm 13.3.6 | the Eisenstein generation theorem | yes in substance; the closest statement is Cor. 13.3.8 (13.3.6 with 13.3.3), which says "generate", while GLC I says "compactly generated by" the compact objects [J] |
| l.3944 | Prop. 13.3.3 | `IndCoh_Nilp = QCoh` on irreducibles | yes |
| l.3823 | Sect. 12.8.4 | tempered D-modules (`e:temp as tensor`) | GLC I says "as in", for the Betti analogue |
| l.3374 | Sect. 17.8.4 | **does not exist** in any arXiv version of AG (v1: 14 sections; v2–v4: 13, then Appendices A–H); nor in AGKRRV v2 (its §17 has subsections 17.1–17.5 only, and AGKRRV never uses the word "tempered") | no [R by script, 2026-11-08; J that it is a slip, perhaps for 12.8.4] |

GLC I l.3368 has one more, commented-out, `\cite[]{AG}` [R]. Note that AG's tempered subcategory
(§12.8.4) is defined using a point `x ∈ X`; its independence of `x` is Conj. 12.8.5 [R].

## 3. What it means for GLCinLean

- **The `IndCohNilp` and `Psi` placeholders point at this paper.** `GLCinLean/Abstract.lean`
  documents `IndCohNilp` as "`IndCoh_Nilp(LS_Ǧ)` (GLC I §1.6)" and `Psi` as a forgetful
  functor (GLC I §1.6). GLC I itself defers to AG §11.1.5 and AG Prop. 4.4.5. Under
  ideas.md ("The formalisation", item 1: "Link to the existing literature"), the docstrings should cite AG (v4 / Selecta,
  §11.1.5, §4.4, Cor. 8.2.x) as the defining source [J].
- **This is deep backbone, all of it missing.** Every step of §2.2 is absent from Mathlib and
  Tau Ceti on 2026-11-08 (see `tauceti-library.md`, `tauceti-roadmaps.md`: no derived stacks,
  IndCoh, de Rham prestack, singular support or `LocSys`; NilpotentOrbits has "no nilpotent cone
  as a scheme") [S, those notes]. For step 2 (plan) the map is roughly [J]:
  - DG categories, Ind, compact objects, presentability → Tau Ceti EnhancedDerivedSheaves;
  - cotangent complex → DerivedModuleAlgebra;
  - Hochschild cochains → DGAInfinity (as dg algebra; the `E_2` structure is not mentioned);
  - Artin stacks, smooth descent → SchemeAndStackFoundations (classical only);
  - nilpotent cone of `ǧ` → NilpotentOrbits;
  - derived schemes/stacks, `IndCoh`, `Sing(Z)`, BIK support, singular support, `X_dR`,
    `LocSys_G`, `Nilp_glob` → no roadmap for the de Rham setting: this repository first
    (ideas.md, item 4).
  - **One exception to "no roadmap".** The open (unmerged) Tau Ceti roadmap PR #1202,
    LanglandsParameterStacks, plans a derived stack of *local* L-parameters with cotangent
    complex, singularity stack and nilpotent singular support of coherent complexes
    (Fargues–Scholze VIII.2, citing AG) [S, `tauceti-roadmaps.md` §2.3]. That is the same
    mechanism (AG §§2–8) for a different stack. Building singular support twice would go against
    "Avoid duplication. Generalize theorems for maximal reuse" (ideas.md, item 1); whether an
    open roadmap PR counts as "covered" (ideas.md, item 4) is already an open point in
    `tauceti-roadmaps.md` [J].
- **A good library candidate.** Singular support of coherent sheaves on quasi-smooth stacks is
  general (any quasi-smooth stack, any conical `Y`), not GLC-specific; ideas.md, item 1 ("a library,
  not a one-off"; "generalize for maximal reuse") argues for formalising §§2–8 in that
  generality and only then specialising to `LocSys_Ǧ` [J].
- **The placeholder can be made more transparent.** AG show `IndCoh_Nilp(LocSys_Ǧ)` is a full
  subcategory of `IndCoh(LocSys_Ǧ)` cut out by a support condition, containing `QCoh` via `Ξ`,
  with `Ψ` the composite `Ψ_{LocSys} ∘ (inclusion)` (§2.3). One opaque `IndCohNilp : DGCat` plus an opaque `Psi`
  hides all of this. Splitting it (placeholders for `IndCoh(LS)`, `Sing(LS)`, `Nilp_glob`,
  `SingSupp`, and the full subcategory as a definition) would let a reviewer see more of the
  statement's meaning before the backbone exists — relevant to the workflow question on
  `Abstract.lean` and its placeholders [J].
- **`IsEventuallyCoconnective` is not generic.** `GLCinLean/Foundations.lean` has one opaque
  `DGCat.IsEventuallyCoconnective` for "the category's standard t-structure". AG define the
  t-structure on `IndCoh_Y` specifically, through `Ψ` (§4.4.1). It cannot simply be replaced by
  "`Ψ(F)` is eventually coconnective": an `F ≠ 0` with `Ψ(F) = 0` lies in every `≤ −n`, so it is
  not eventually coconnective although `Ψ(F)` is [J, from the definition in §4.4.1]. Such `F`
  exist whenever `Y ≠ {0}`, since then `IndCoh_Y ≠ Ξ(QCoh)` [J]. The t-structure should be data
  of the category in the eventual design [J]. Moreover AG define it only for affine schemes
  (§2.3, "No t-structure for stacks in AG"), so the t-structure on `IndCoh_Nilp(LS_Ǧ)` that the
  statement's first condition (`Abstract.lean` l.109) refers to has **no written definition in
  the cited source**; the plan must define it (by smooth descent) and cite it as the project's own
  step, not as AG's [R for the gap; J for the remedy].
- **Hypotheses.** AG's conventions (algebraically closed, characteristic 0, connected curve,
  connected reductive `G`) agree with the labels already in `Abstract.lean`'s hypothesis block,
  sourced there from AGKRRV and GLC II; AG is a third source for them [R AG; J agreement].
- **Point-independence.** The intrinsic definition (§8 via §11.1.5) needs no point of `X`; the
  global-complete-intersection presentation and the tensor-product formula need one. A Lean
  definition should follow the intrinsic one and prove the `x`-dependent formula as a theorem,
  or the statement would carry a hidden choice [J].
- **`ǧ` versus `ǧ*`.** AG put the nilpotent cone in `ǧ*`, via an invariant identification
  `ǧ ≅ ǧ*` (characteristic 0); Tau Ceti's NilpotentOrbits is about `ǧ`.
  Either the identification is a lemma the plan has to contain, or `Nilp(ǧ*)` is defined as
  the zero fibre of the Chevalley map `ǧ* → 𝔠(ǧ)` (AG §11.1.2), which needs no identification but
  then has to be compared with NilpotentOrbits' cone in `ǧ` [J].
- **Sanity theorems for review.** Thm 4.2.6 (zero section = `QCoh`), the torus case, Prop. 13.3.3
  (irreducibles) and Drinfeld's criterion are consequences that are cheap to *state* (their
  proofs, notably Thm 4.2.6 and Drinfeld's criterion, are not cheap). Stated (with
  budgeted `sorry`s) next to the definition, they act as tests that the definition means what
  AG mean — the test-based design described in the Formal Conjectures notes [J].
- **The paper matters for the proof too (step 6).** GLC I uses AG Thm 13.3.6 and Prop. 13.3.3 in
  its proof (`functor.tex` l.3768, l.3944) [R].
- **Papers.** `references/papers/manifest.toml` lists AGKRRV but not AG, although AG defines the
  spectral side. Whatever replaces the manifest (ideas.md, item 5: TeX files, untracked) needs to
  record AG's version, because GLC I cites section numbers and v1's numbering differs from
  v2–v4's at those places (header) [R manifest and numbering; J].

## 4. Conflicts

- **AG's conjecture vs GLC I Conj. 1.6.7** — not a contradiction, a refinement. AG: *an*
  equivalence `Dmod(Bun_G) ≃ IndCoh_Nilp`; GLC I: *the* functor `𝕃_G` on half-twisted
  `Dmod_{1/2}(Bun_G)` is an equivalence. `Abstract.lean` follows GLC I, which is the stronger
  statement. Any reformulation that drifts to AG's existence form would say less [R both; J].
- **GLC I's citations of AG are partly loose:** "Sect. 17.8.4" does not exist in AG v4; 11.1.6 is
  cited for `LS^restr`, which AG do not treat; Prop. 4.4.5 is cited for a stack, `>−∞` version
  it does not state as such (§2.5 table). Not a mathematical conflict, but any docstring that
  copies GLC I's pointers inherits them [R; J].
- **`Abstract.lean` docstrings** say "(GLC I §1.6)" for `IndCohNilp`, while GLC I points to AG
  §11.1.5 [R].
- **`Foundations.lean`**: the generic `DGCat.IsEventuallyCoconnective` versus AG's specific
  t-structure (§3 above) [J].
- **GLC I relies on a t-structure AG do not define.** GLC I (l.1820–1826, l.1842) uses a
  t-structure on `IndCoh_Nilp(LS_Ǧ)` and cites AG Prop. 4.4.5, which is for affine schemes; AG v4
  defines no t-structure on `IndCoh_Y` of a stack [R, both TeX sources]. Probably a routine
  extension [J], but `Abstract.lean`'s first condition depends on it.
- **"No roadmap" versus Tau Ceti #1202.** Singular support has no roadmap in the de Rham setting,
  but the open roadmap PR LanglandsParameterStacks (#1202) plans nilpotent singular support for
  local parameter stacks [S, `tauceti-roadmaps.md`]. ideas.md item 4 sends roadmap-covered parts
  to Tau Ceti and the rest to this repository; for singular support the line is unclear [J].
- **Notation:** AG write `LocSys_Ǧ`, GLC I `LS_Ǧ`; AG §12.8.4 writes `Ψ_{LocSys}` for the
  functor `QCoh → IndCoh` that is called `Ξ` everywhere else in AG (an apparent typo) [R; J].
- **Foundational references of AG are informal.** AG delegate stacks and `QCoh` conventions to
  unpublished web notes ("Notes on Geometric Langlands"); the later book by Gaitsgory–Rozenblyum
  (*A Study in Derived Algebraic Geometry*) is their published form [R bibliography; E book].
  This is in tension with ideas.md §1 "a mathematician should be able to trust and verify":
  the backbone should cite the book, not the notes [J].
- **With ideas.md "thoroughness and breadth before depth":** no conflict, but the depth of
  §2.2 means the spectral side will be a placeholder for a long time unless derived algebraic
  geometry is built broadly first [J].

## 5. Input for the open questions (notes/workflow.md)

- **Whether `Abstract.lean`, `Foundations.lean` and their placeholders are reasonable.** The
  object `IndCohNilp` is well defined and certainly exists, so the `@[placeholder] opaque`
  pattern is honest for it. AG suggest refining it: express it as a full subcategory of
  placeholder `IndCoh(LS)` by a placeholder singular-support condition, make `Psi` the
  composite of `Ψ_{LS}` with the inclusion, and make the t-structure data rather than a generic
  predicate. This exposes more meaning to review now at little cost [J]. The t-structure
  placeholder's docstring should say that AG define it only for affine schemes and that the
  stack version is an extension (§2.3) [R gap; J].
- **What happens to `references/papers/manifest.toml`.** If it stays, AG v4 needs an entry
  (arXiv licence 1.0: link only). If it goes, the version still has to be recorded where the
  citation is (docstring "AG, arXiv 1201.6343v4 / Selecta 21 (2015), §11.1.5"), since section
  numbers are what GLC I cites; "v4" (or v2–v4) matters, because v1 is numbered differently
  [R numbering; J].
- **Who reviews the mathematics, and to what standard.** The definition of `IndCoh_Nilp`
  (Hochschild `E_2` action, BIK support, smooth descent) is where a misformalisation would be
  hardest for a fresh agent or the owner to see. It suggests (a) sanity theorems from §2.3 as
  required tests, and (b) an outside expert for this definition specifically [J].
- **What goes into `AGENTS.md`.** Nothing AG-specific; at most the general rule "cite the defining
  source with version and section, not the paper that cites it" [J].

## 6. Questions for the owner

1. Should `IndCoh_Nilp(LS_Ǧ)` be defined AG's intrinsic way (Hochschild cochains acting on
   `IndCoh`, then descent to stacks) — faithful to the cited source but needing the most
   backbone — or by an equivalent, more concrete characterisation (point-wise, or the
   point-dependent tensor-product formula), with the equivalence to AG's definition left as a
   theorem to prove later? Either way the docstring would say which one is used.
2. Should singular support be built in the generality of AG §§2–8 (any quasi-smooth stack, as a
   library), or only as much as `LS_Ǧ` needs? Related: should it be coordinated with Tau Ceti's
   open roadmap PR LanglandsParameterStacks (#1202), which plans the same mechanism for local
   parameter stacks, so that it is built once?
3. Should AG be recorded as a tracked reference (in the manifest or whatever replaces it), given
   that GLC I defines its spectral side by citing it?
4. Would you seek an outside expert for the spectral-side definition, where the risk of a subtly
   wrong formalisation is highest?
