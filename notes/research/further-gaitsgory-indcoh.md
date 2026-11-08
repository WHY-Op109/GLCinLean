# Gaitsgory, *Ind-coherent sheaves*

- **Source:** D. Gaitsgory, *Ind-coherent sheaves*, arXiv 1105.4857 **v7** (latest; v1 24 May 2011,
  v2 9 Aug 2011, v3 15 Aug 2011, v4 28 Dec 2011, v5 30 Jan 2012, v6 5 Feb 2012, v7 22 Sep 2012),
  <https://arxiv.org/abs/1105.4857v7> [R, arXiv API and abstract page, 2026-11-08]. Published as
  Moscow Math. J. 13 (2013) 399–528 [R: AG v4 bibliography, `singsupp.tex` l.11622–11625; the
  journal itself not opened]. Cited below as **[IndCoh]**.
- **Read from:** the v7 TeX source (`https://arxiv.org/e-print/1105.4857v7`, one gzipped file
  `IndCohtext.tex`, 9,360 lines), unpacked into `references/papers/1105.4857v7/src/` (Git-ignored).
  - SHA-256 of the downloaded e-print (`references/papers/1105.4857v7/source.gz`):
    `05b7b250597563c853f4d51ca6053d792437d1cf5543f89991dcd9afae2e2844`
  - SHA-256 of `src/IndCohtext.tex`:
    `d07221051377e0ed336ec980329e43d8e376d00db33933f387b7231040587d83`
- **Read:** the introduction's overview of §§10–11 (l.659–750) and the conventions (l.751–800);
  §1.1–1.2 (definition, t-structure on schemes, up to the start of the proof of Prop. 1.2.4); §10.1
  (definition on prestacks, opening); all of §11.1–11.3; the statements of §11.4–11.6 and where
  their proofs are called sketches; all of §11.7 (Ψ, Ξ, t-structure, with its proof); the
  bibliography. **Not read:** §§2–9 (except statements located by number), the proofs in
  §§11.4–11.6.
- **Also read, to settle where the t-structure on `IndCoh_Nilp(LS_Ǧ)` is defined:** AG v4
  (`references/papers/1201.6343v4/src/singsupp.tex`) §4.4, §8.2, §10.4.3; GLC I v3
  (`functor.tex`) l.1812–1850 and l.1955–1972; text searches of AGKRRV v2 (`text.tex`), GLC II v3
  (`Loc.tex`), the Gaitsgory–Rozenblyum book (`.lake/research/gr-book/Vol1.txt`, with Vol I Ch. 3
  §1.5.1 read), and Gaitsgory's *Outline of the proof of GLC for GL(2)* (arXiv 1302.2506 v3,
  fetched to `.lake/research/gl2-outline-1302.2506/` only for this search; e-print SHA-256
  `d4602eb2a92d538f0f34da37e86a7b983505537e7c5ad28deddddd0fcc61c6b5`).
- **Section numbers** are those of v7, computed from the TeX by a counting script (all
  theorem-like environments share the `subsubsection` counter, `IndCohtext.tex` l.16–29; the
  Introduction is an unnumbered `\section*`) and checked against the content at each cited place
  [R, 2026-11-08]. AG v4 cites the *published* version; every one of AG's numbered citations of
  [IndCoh] that was checked (28 places, among them Prop. 1.2.4, Cor. 4.4.5, Def. 3.5.2,
  Prop. 7.3.8, Sect. 10.6, Sect. 11.2, Sect. 11.7.3) lands on an item of the cited kind and
  topic in v7 [R by script, 2026-11-08]. So v7 and the published numbering agree at least there
  [J].
- **Licence:** arXiv non-exclusive distribution licence 1.0 [R, abstract page, 2026-11-08]: link,
  do not copy; quotes here are short.
- **Checked 2026-11-08.** All tags below were checked on that date.

## 1. What it is

- The paper that sets up **ind-coherent sheaves** `IndCoh` on DG schemes, prestacks and Artin
  stacks: definition, t-structure, the functor `Ψ : IndCoh → QCoh`, `*`- and `!`-functorialities,
  descent, Serre duality [R, table of contents and §§1, 10, 11].
- Abstract: "We develop the theory of ind-coherent sheaves on schemes and stacks. ... the
  difference becomes crucial for the formulation of the categorical Geometric Langlands
  Correspondence" [R, arXiv API].
- It is the source AG cite for `IndCoh` of a stack (AG §8.2.1: "Recall ([IndCoh, Sect. 11.2]) that
  we have a well-defined category IndCoh(𝒵)", `singsupp.tex` l.6023) [R]. It knows nothing about
  singular support: it cites AG only in passing (l.313, l.5480) [R by search].
- It is one step below AG and two below GLC I. Much of its higher-categorical foundation was later
  redone in the Gaitsgory–Rozenblyum book (see `further-gaitsgory-rozenblyum-a-study-in-derived-.md`)
  [J].

## 2. What it says that matters for GLCinLean

### 2.1 Conventions [R, l.751–770]

- Ground field `k` of characteristic 0.
- "∞-category" means `(∞,1)`-category; statements are model-independent, "although the model
  that we have in mind is that of quasi-categories" (l.540–543).
- Set theory is ignored; footnote: "The act of ignoring can be replaced by assuming that the
  ∞-categories and functors involved are κ-accessible for some cardinal κ" (l.762–764).

### 2.2 `IndCoh` and its t-structure on a scheme (§1.1–1.2) [R]

- Def. 1.1.2–1.1.3: `Coh(S) ⊂ QCoh(S)` (bounded, coherent cohomology; `S` Noetherian);
  `IndCoh(S) := Ind(Coh(S))`.
- §1.1.5: `Ψ_S : IndCoh(S) → QCoh(S)`, the ind-extension of `Coh(S) ↪ QCoh(S)`. Lemma 1.1.6: for
  a regular classical scheme, `Ψ_S` is an equivalence.
- §1.2.1: the t-structure on `IndCoh(S)` is the one compatible with filtered colimits for which
  `Coh(S) → IndCoh(S)` is t-exact. Lemma 1.2.2: `Ψ_S` is t-exact.
- **Prop. 1.2.4** (l.1089): for every `n`, `Ψ_S : IndCoh(S)^{≥n} → QCoh(S)^{≥n}` is an
  equivalence. "The next proposition, although simple, is crucial for the rest of the paper."

### 2.3 `IndCoh` on prestacks and on Artin stacks (§10.1, §11.1–11.5) [R]

- **Definition (§10.1.2, l.7580).** `IndCoh^!_{PreStk_laft}` is the right Kan extension of
  `IndCoh^!` from eventually coconnective affine DG schemes almost of finite type along the Yoneda
  embedding; `IndCoh(𝒴)` is its value (§10.1.4). So `IndCoh(𝒴)` is a limit over all affines
  mapping to `𝒴`, with `!`-pullbacks.
- **Artin stacks (§11.1).** `k`-Artin stacks after [GL:Stacks] (Gaitsgory's unpublished web notes);
  `Stk_{laft,Artin} := PreStk_laft ∩ Stk_Artin` (§11.1.3); every such stack has a smooth surjection
  from a DG scheme locally almost of finite type (Cor. 11.1.6); `IndCoh^!` is restricted to them
  (§11.1.7).
- **Recovery from smooth charts (§11.2)** — the place AG cite. Prop. 11.2.10 (l.8514): for
  `𝒴 ∈ Stk_{laft,Artin}` and `𝔠 ∈ {smooth, flat, ev-coconn, all}`, `IndCoh(𝒴)` is the limit of
  `IndCoh(S)` over affine (or all) DG schemes `S` almost of finite type with a map to `𝒴` in `𝔠`;
  Prop. 11.2.11 lets the transition maps be restricted to `𝔠'` too. The general engine is
  Prop. 11.2.2 / Cor. 11.2.3: any presheaf on Artin stacks with smooth descent is the right Kan
  extension of its restriction to affines.
- **The `*`-version (§11.3).** `IndCoh^*` on Artin stacks with eventually coconnective maps:
  the right Kan extension from affines with `(IndCoh,*)`-pullbacks (§11.3.1–11.3.2); smooth
  descent (Lemma 11.3.4); recovery from smooth or flat charts (Cor. 11.3.5).
- **Comparison `IndCoh^! ≃ IndCoh^*`.**
  - For an **algebraic stack** (1-Artin, diagonal schematic, quasi-separated and quasi-compact,
    §11.4.1): Prop. 11.4.3, followed by "The rest of this subsection is devoted to the proof of
    this proposition" (l.8660) [R statement; proof not read].
  - For a **general Artin stack**: Prop. 11.5.2, followed by "a sketch of the proof ... details
    will be supplied elsewhere" (l.8854–8855).

### 2.4 `Ψ`, `Ξ` and the t-structure on an Artin stack (§11.7) [R]

- **§11.7.1–11.7.2 (`Ψ`).** For `𝒴 ∈ Stk_{laft,Artin}` there is a canonical
  `Ψ_𝒴 : IndCoh(𝒴) → QCoh(𝒴)`, obtained as the right Kan extension of `Ψ` on affines (for the
  `*`-version), commuting with smooth pullbacks.
- **§11.7.3 (`Ξ`).** If `𝒴` is eventually coconnective, `Ψ_𝒴` has a fully faithful left adjoint
  `Ξ_𝒴`, compatible with eventually coconnective pullbacks; so `Ψ_𝒴` "realizes `QCoh(𝒴)` as a
  co-localization of `IndCoh(𝒴)`". (AG §8.2.7 cites exactly "[IndCoh, Sect. 11.7.3]" for this.)
- **§11.7.4, Prop. 11.7.5 (l.9239) — the t-structure.** Quoted, since the wording matters:
  > "Let 𝒴 be an object of `Stk_{laft,Artin}`. Then the category `IndCoh(𝒴)` admits a unique
  > t-structure, characterized by the property that for `S ∈ DGSch_aft` with a flat map
  > `f : S → 𝒴`, the functor `f^{IndCoh,*} : IndCoh(𝒴) → IndCoh(S)` is t-exact. Moreover:
  > (a) The above t-structure is compatible with filtered colimits.
  > (b) The functor `Ψ_𝒴` is t-exact, induces an equivalence `IndCoh(𝒴)^+ → QCoh(𝒴)^+`, and
  > identifies `QCoh(𝒴)` with the left completion of `IndCoh(𝒴)` in its t-structure."
- The proof is half a page: Cor. 11.2.3 plus Prop. 1.2.4 and a general observation — a limit of
  DG categories with t-structures and t-exact transition functors has a unique t-structure for
  which the evaluation functors are t-exact; compatibility with filtered colimits passes to the
  limit (l.9262–9286).
- The introduction says the same: smooth recovery "allows us to introduce a t-structure on
  `IndCoh(𝒴)`" (l.744–748).

### 2.5 What the paper proves only in sketch [R]

- Thm. 6.1.10 (the framework behind the `!`-pullback for all morphisms almost of finite type,
  Thm. 5.2.2): "we will indicate the proof ... modulo homotopy-theoretic issues (i.e., a proof that
  works when `C` is an ordinary category). The full proof will appear in [GR3]" (l.4701–4704).
  [GR3] is the Gaitsgory–Rozenblyum book "in preparation" (bibliography).
- Prop. 11.5.2 (`IndCoh^! ≃ IndCoh^*` for general Artin stacks): sketch (l.8854).
- The proposition of §11.6 (`*`-pullback along eventually representable maps): sketch (l.9063).
- None of these is needed for **algebraic** stacks with smooth charts and `(IndCoh,*)`-pullbacks:
  §11.2–11.4 and §11.7 are stated with proofs there [R for which proofs are labelled sketches; J
  that the remaining ones are complete, as they were not all read].

### 2.6 Where the t-structure on `IndCoh_Nilp(LS_Ǧ)` is (and is not) defined

The question from `further-arinkin-gaitsgory-singular-support-of-co.md` §4 and
`further-gaitsgory-rozenblyum-a-study-in-derived-.md` §2.1, answered source by source:

| Object | Where defined | Tag |
| --- | --- | --- |
| `IndCoh(𝒴)`, `𝒴` a laft Artin stack | [IndCoh] §10.1.2 (definition, l.7580) and §11.1.7; smooth-chart formula Prop. 11.2.10 (l.8514) | R |
| t-structure on `IndCoh(𝒴)`; `Ψ_𝒴` t-exact, `IndCoh(𝒴)^+ ≃ QCoh(𝒴)^+` | [IndCoh] Prop. 11.7.5 (l.9239) | R |
| `Ψ_𝒴`, and `Ξ_𝒴` for `𝒴` eventually coconnective | [IndCoh] §11.7.1, §11.7.3 | R |
| t-structure on `QCoh(𝒴)` for any prestack | GR Vol I Ch. 3 §1.5.1 (`Vol1.txt` l.9075–9093); AGKRRV footnote, `text.tex` l.13619–13620 | R |
| `IndCoh_Y(𝒵)`, `𝒵` a quasi-smooth stack | AG §8.2.3 (`singsupp.tex` l.6046) | R |
| `IndCoh_Nilp(LocSys_Ǧ)` | AG §11.1.5 | R |
| t-structure on `IndCoh_Y(Z)`, `Z` an **affine** quasi-smooth DG scheme, `Y ⊇ {0}` | AG §4.4.1 (l.3117): `F ∈ IndCoh_Y(Z)^{≤0} ⇔ Ψ^Y_Z(F) ∈ QCoh(Z)^{≤0}`; Lemma 4.4.2, Cor. 4.4.3, Prop. 4.4.5 (l.3158), Prop. 4.4.7 | R |
| t-structure on `IndCoh_Y(𝒵)` for a **stack**, so on `IndCoh_Nilp(LS_Ǧ)` | **nowhere in these sources** | R by search (below) |

Searches for the last row, all 2026-11-08:

- **AG v4:** in §§8–11 the word "t-structure" occurs once, for `QCoh` (l.7100) [R by search; agrees
  with the AG note].
- **[IndCoh] v7:** every occurrence of "t-structure" after l.7500 is in §11.7.4–11.7.5, about
  `IndCoh(𝒴)` itself; singular support does not occur [R by search].
- **GR book Vol I:** a t-structure on `IndCoh` only for schemes (Ch. 4 §1.2, Prop. 1.2.2,
  `Vol1.txt` l.10446–10501); Ch. 5–6 (l.11969–16079) never use the word "t-structure"; Ψ on stacks
  is mentioned only in Ch. 5 Rem. 0.2.4 ("a feature of schemes (or, more generally, Artin
  stacks)") [R by search]. This confirms the GR note §2.1.
- **AGKRRV v2:** t-structure conventions (§ "t-structures", l.2170–2183; footnote l.2696: "we
  require that t-structures be compatible with filtered colimits"), the `QCoh` t-structure
  (l.13620), none on `IndCoh_Nilp(LocSys_Ǧ)` [R by search].
- **GLC I v3:** uses `IndCoh_Nilp(LS_Ǧ)^{>-∞}` (l.1825, l.1842, l.1965, l.1968) and cites only
  [AG, Prop. 4.4.5] (l.1826); the string "t-structure" does not occur in `functor.tex` [R by search].
- **GLC II v3:** a t-structure on `IndCoh^*` of eventually coconnective affine schemes and
  ind-schemes (§ "The t-structure on IndCoh*", `Loc.tex` l.22411ff.), for its own local setting,
  not `LS_Ǧ` [R].
- **GL(2) outline (1302.2506 v3):** no t-structure on `IndCoh_Nilp` [R by search].

**How the missing step goes** [J, my argument from the cited statements; not in any source]:

1. `LS_Ǧ` is an algebraic stack with affine diagonal, quasi-compact (AG §10.4.3, l.7399–7415 [R]),
   and quasi-smooth (AG Prop. 10.4.5, l.7429 [R]). AG state that "a quasi-smooth Artin stack is
   locally eventually coconnective" (l.5979–5980) [R]; being quasi-compact, `LS_Ǧ` is then
   eventually coconnective, as [IndCoh] §11.7.3 requires [J]. So [IndCoh] §11.4 (the fully proved
   comparison) and §11.7.3 (`Ξ`) apply.
2. Put `Ψ^{Nilp}_{LS} := Ψ_{LS} ∘ Ξ^{Nilp,all}_{LS} : IndCoh_Nilp(LS) → QCoh(LS)` (AG Cor. 8.2.6 for
   the inclusion `Ξ^{Nilp,all}`; [IndCoh] §11.7.1 for `Ψ_{LS}`). This is GLC I's `Ψ_{Nilp,{0}}`
   (`functor.tex` l.1822). Its left adjoint is `Ξ_{LS}`, which lands in
   `IndCoh_{0}(LS) ⊂ IndCoh_Nilp(LS)` (AG Cor. 8.2.8), and `Ψ^{Nilp} ∘ Ξ ≅ id`.
3. **Define** the t-structure exactly as AG §4.4.1 does for affines:
   `F ∈ IndCoh_Nilp(LS)^{≤0} ⇔ Ψ^{Nilp}_{LS}(F) ∈ QCoh(LS)^{≤0}`, with `≥` by right
   orthogonality. It exists because this class is closed under colimits and extensions in a
   presentable category — the same adjoint-functor argument GR use for `QCoh` (Vol I Ch. 3
   §1.5.1, citing [Lu2, Prop. 1.2.1.16]); AG skip this point even for affines.
4. Then AG's affine proofs of Lemma 4.4.2, Cor. 4.4.3 and Prop. 4.4.5 go through word for word,
   with [IndCoh] Prop. 11.7.5(b) in place of [IndCoh] Prop. 1.2.4 (the `+` equivalence restricts
   to each `≥n`, since `Ψ_{LS}` is t-exact). This gives GLC I's claims: `Ψ_{Nilp,{0}}` is t-exact
   and `IndCoh_Nilp(LS)^{≥n} ≃ QCoh(LS)^{≥n}` for all `n`, hence on `>-∞`.
5. Equivalently, the t-structure is the limit over smooth affine charts of AG's affine
   t-structures, glued with `(IndCoh,*)`-pullbacks (the general observation in the proof of
   [IndCoh] Prop. 11.7.5): smooth `(IndCoh,*)`-pullbacks commute with `Ψ^Y`, and flat `*`-pullback
   on `QCoh` is t-exact; and the `QCoh` t-structure on an Artin stack is detected on smooth charts.

**Verdict on the gap** [J]: routine. Every ingredient is a cited result, the argument is AG's
affine one with stack inputs, and no outside source is needed. It still has to be written down
in the formalisation as the project's own step, with these citations, not attributed to AG
Prop. 4.4.5. An expert's one-line confirmation would be cheap and worth having (§6).

**A pitfall: two readings of "eventually coconnective" differ** [J, my argument]. Inside
`IndCoh(LS)` one could also call `F ∈ IndCoh_Nilp(LS)` eventually coconnective when its image
`Ξ^{Nilp,all}(F)` is, for [IndCoh] Prop. 11.7.5's t-structure. That is **not** the AG/GLC I
notion:
- If `Ξ^{Nilp,all}(F) ∈ IndCoh(LS)^{≥-n}` then `F ∈ IndCoh_Nilp(LS)^{≥-n}` (`Ξ^{Nilp,all}` is right
  t-exact by AG Lemma 4.4.2, so `Hom(G, F) = Hom(ΞG, ΞF) = 0` for `G` in `≤ -n-1`).
- The converse fails already in AG's affine setting: take `Z = pt ×_{𝔸¹} pt`, `Y = {0}`, and
  `F = Ξ_Z(k)`. `F` is coconnective in AG's t-structure (`IndCoh_{0}(Z) ≃ QCoh(Z)` through `Ψ`),
  but if `Ξ_Z(k)` were in `IndCoh(Z)^{≥-m}`, Prop. 1.2.4 would force `Ξ_Z(k) ≅ k` in `IndCoh(Z)`,
  so `k` would have singular support `{0}`, i.e. be perfect, which it is not.
- So AG's t-structure on `IndCoh_Y` is not the restriction of the one on `IndCoh` (AG's own
  Prop. 4.4.5 proof goes through `τ^{≥0} ∘ Ξ`, not `Ξ`) [J]. The first condition of Cor. 1.6.5 must
  use AG's (the `Ψ`-defined) t-structure; the "underlying object in `IndCoh(LS)`" reading is
  stricter and would make the existence statement harder or false [J].

### 2.7 An alternative foundation it offers [R for the statements; J for the use]

- For an Artin stack, `IndCoh(𝒴)` can be taken as `IndCoh^*(𝒴)`: a limit over smooth affine charts
  with `(IndCoh,*)`-pullbacks (§11.3, Cor. 11.3.5). `Ψ_𝒴` is constructed on this version directly
  (§11.7.1), and Prop. 11.7.5 is phrased with `f^{IndCoh,*}`.
- `(IndCoh,*)`-pullback along eventually coconnective maps needs no correspondences (§3.5,
  Cor. 3.5.6; GR Vol I Ch. 4 §3.1 per the GR note [S]). AG §8.2.1 allow either pullback
  ("the two differ by the twist by a cohomologically shifted line bundle").
- So `IndCoh(LS_Ǧ)`, `Ψ`, `Ξ`, `IndCoh_Nilp(LS_Ǧ)` and its t-structure can be defined without the
  `(∞,2)`-categorical correspondence machinery, which [IndCoh] itself proves only "modulo
  homotopy-theoretic issues" (§2.5) [J].

## 3. What it means for GLCinLean

- **`Abstract.lean`, first condition of `IsLanglandsFunctor` (l.109).**
  `DGCat.IsEventuallyCoconnective (F.obj c)` must mean: `F.obj c ∈ IndCoh_Nilp(LS_Ǧ)^{>-∞}` for the
  t-structure whose connective part is `Ψ_{Nilp,{0}}^{-1}(QCoh(LS_Ǧ)^{≤0})` (§2.6, step 3) [J].
  - The object is well defined and certainly exists, so an opaque placeholder stays honest
    (AGENTS.md, "Placeholders") [J].
  - The docstring should name the definition and its sources: AG §4.4.1 (affine), AG §8.2.3 and
    §11.1.5 (the category), [IndCoh] Prop. 11.7.5 and §11.7.1 (the stack inputs), and say that the
    stack version is this project's step (ideas.md, item 1, "Link to the existing literature")
    [J].
  - The current docstring in `Foundations.lean` (l.111–112: "for the category's standard
    t-structure (GLC I §1: objects in `IndCoh_Nilp(LS)^{>-∞}`)") cites GLC I for something GLC I
    does not define [R; J].
- **`audit-lean.md`'s verdict "the t-structure must be data of the category" — refine it.**
  - Right that it is specific to `IndCoh_Nilp(LS_Ǧ)`, not a generic predicate on every `DGCat`
    [J, agrees with audit-lean §2 and the AG note].
  - But it need not be **independent** data. It is determined by `Psi` and the canonical
    t-structure on `QCoh(LS_Ǧ)` (which exists for every prestack, GR Vol I Ch. 3 §1.5.1): `≤0` is the
    preimage under `Psi`, `>-∞` is "right-orthogonal to `Psi^{-1}(QCoh^{≤-n-1})` for some `n`"
    [J, from AG §4.4.1].
  - So a cleaner surface: a t-structure on `QCohLS` (canonical, from `QCoh` of a prestack), and
    `IsEventuallyCoconnective` on `IndCohNilp` as a **definition** from `Psi`. This removes one
    opaque, places the remaining trust in `Psi` and `QCoh`'s t-structure, and makes the first
    condition's meaning reviewable now. It needs morphisms (or a Mathlib `TStructure` on a
    homotopy category) in the `DGCat` interface, which `Foundations.lean` lacks today
    (audit-lean §2: "no actions or t-structure as data") [S audit-lean; J].
  - Caution: defining it from the *opaque* `Psi` is faithful only if `Psi` is, in the end, AG's
    `Ψ_{Nilp,{0}}`; a reviewer should check that docstring (§2.6, step 2) [J].
- **Backbone order (workflow step 2).** For `IndCoh` on `LS_Ǧ` the minimal chain is: `IndCoh` and
  `Ψ` on affine DG schemes of finite type ([IndCoh] §1); `(IndCoh,*)`-pullback along eventually
  coconnective maps (§3.5); smooth descent and the smooth-chart limit (§11.2–11.3); `Ψ`, `Ξ`, the
  t-structure (§11.7); then AG §§4, 8. The `!`-pullback for all maps and the correspondence machinery
  are not needed for the statement's spectral side [J, §2.7]. This is "thoroughness and breadth"
  (ideas.md, item 1) in the right order: general Artin stacks, specialised to `LS_Ǧ` only at the end.
- **`LS_Ǧ` is algebraic**, so the only general-Artin result that is merely sketched in [IndCoh]
  (Prop. 11.5.2) is avoidable; the fully proved Prop. 11.4.3 suffices [J, from AG §10.4.3].
- **Citations in docstrings.** [IndCoh] numbering matches between v7 and the published version at
  every place AG cite (header). Docstrings can cite "Gaitsgory, *Ind-coherent sheaves*, Moscow Math.
  J. 13 (2013), arXiv 1105.4857v7, Prop. 11.7.5" [J].

## 4. Conflicts

- **Settled: the AG note's contradiction.** AG v4 defines no t-structure on `IndCoh` of a stack
  with supports [R, confirmed]; [IndCoh] Prop. 11.7.5 **does** define the t-structure on
  `IndCoh(𝒴)` for every laft Artin stack [R]. GLC I's cited source (AG Prop. 4.4.5, affine) plus
  [IndCoh] Prop. 11.7.5 give the stack version by a routine argument (§2.6) [J]. The AG note's
  remark "the plan must define it (by smooth descent)" stands; the step is short.
- **Settled: the GR note's "no smooth-chart treatment".** True of the GR book [R by search]; the
  smooth-chart treatment is in [IndCoh] §11 [R]. Note that [IndCoh] *defines* `IndCoh(𝒴)` by right Kan
  extension over all affines (§10.1.2) and *proves* the smooth-chart formula (Prop. 11.2.10); AG
  §8.2.1 quotes it in that sense [R]. Consistent with the GR note's last sentence.
- **GLC I l.1820–1826 vs its citation.** GLC I says `Ψ_{Nilp,{0}}` "is t-exact and induces an
  equivalence ... see [AG, Proposition 4.4.5]". AG Prop. 4.4.5 is affine and has `≥0`; the stack
  `>-∞` form is the step of §2.6 [R; J]. A docstring copying GLC I's pointer would be inexact.
- **`Foundations.lean` vs the sources.** `DGCat.IsEventuallyCoconnective` is said to use "the
  category's standard t-structure". `IndCoh_Nilp(LS_Ǧ)` has no t-structure in any source; the
  intended one is determined by `Ψ` (§3), and the "standard" one inherited from `IndCoh(LS)` would
  be a different, stricter notion (§2.6, pitfall) [J].
- **ideas.md item 1, "Link to the existing literature".** The literature has a hole here: one
  definition GLC I relies on is not written down. Linking cannot be complete; the docstring has to
  say so [J].
- **AGKRRV's convention** that t-structures be compatible with filtered colimits (footnote
  l.2696) [R]: the `Ψ`-defined t-structure on `IndCoh_Nilp(LS)` should satisfy it (it is generated
  by a colimit-closed class, and AG Prop. 4.4.7 proves compact generation for affines), but no
  source proves this for the stack [J]. Not needed for the statement.
- **[IndCoh]'s own foundations are partly informal:** stacks after unpublished notes [GL:Stacks];
  the `!`-functoriality only "modulo homotopy-theoretic issues", full proof deferred to the book
  (§2.5) [R]. Same tension with ideas.md item 1 ("trust and verify") as in the AG note; the
  `(IndCoh,*)` route avoids the weakest part [J].

## 5. Input for the open questions (notes/workflow.md)

- **Whether `Abstract.lean`, `Foundations.lean` and their placeholders are reasonable, or need to
  change.** The `IndCohNilp` and `Psi` placeholders are honest (the objects exist). The generic
  `DGCat.IsEventuallyCoconnective` should change: either (a) keep an opaque predicate, but only on
  `IndCohNilp` and with a docstring giving the `Ψ`-definition and its sources; or (b) make it a
  definition from `Psi` and a t-structure on `QCohLS` (§3). (b) exposes more meaning to review now;
  (a) needs less interface. This note suggests (b) once the interface has morphisms, (a) until then
  [J].
- **What happens to `references/papers/manifest.toml`.** If any record of paper versions is kept,
  [IndCoh] needs one (v7; arXiv licence 1.0, link only; e-print SHA-256 above), since the
  t-structure GLC I needs rests on its Prop. 11.7.5 [J]. If the manifest goes (ideas.md, item 5),
  the version belongs in the docstring citation instead.
- **Who reviews the mathematics, and to what standard.** The step of §2.6 is the project's own
  mathematics, not a transcription. It is short and routine [J], but no source checks it. It is a
  natural first item for an outside expert, or at least for a fresh-agent review that re-derives it
  from AG §4.4 and [IndCoh] §11.7 [J]. The pitfall in §2.6 is a concrete test: a correct
  formalisation must not make `Ξ_Z(k)` on `pt ×_{𝔸¹} pt` fail to be eventually coconnective in
  `IndCoh_{0}` [J].
- **What goes into `AGENTS.md`.** At most the general rule the AG note already suggests: cite the
  defining source with version and section, and mark a step the sources do not contain as the
  project's own [J].

## 6. Questions for the owner

1. The t-structure on `IndCoh_Nilp(LS_Ǧ)` that GLC I's first condition uses is not written down in
   any source checked; the argument above fills it from AG §4.4 and [IndCoh] Prop. 11.7.5. Do you
   accept it as a project step marked [J] in the docstring, or do you want an outside expert to
   confirm it before the statement is called faithful?
2. Should `IsEventuallyCoconnective` become a definition from `Psi` and a t-structure on
   `QCoh(LS_Ǧ)` (more reviewable, needs morphisms in the interface), or stay an opaque predicate,
   restricted to `IndCohNilp` and documented?
3. For the backbone: should `IndCoh` on Artin stacks be built through the `(IndCoh,*)`-pullback
   route ([IndCoh] §11.3, no correspondences, enough for `LS_Ǧ`), postponing the general
   `!`-functoriality of the GR book until something needs it?
