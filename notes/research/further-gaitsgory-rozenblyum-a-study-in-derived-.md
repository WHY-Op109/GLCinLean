# Gaitsgory–Rozenblyum, *A Study in Derived Algebraic Geometry*, Vols I–II

- Source: <https://people.mpim-bonn.mpg.de/gaitsgde/Book/> (the authors' book page; the server
  reports `Last-Modified: Tue, 03 Oct 2023`, ETag `e1c-606c6572d3c61`). There is no Git
  history or version tag, so the files are pinned by SHA-256 instead:
  - `Vol1.pdf`, 568 pages, PDF created 2021-12-09:
    `add4c68bdd8245b5b8adafbe4bd1cb8ff027e1ce289ac2f227d82eb25459cf1b`
  - `Vol2.pdf`, 467 pages, PDF created 2021-12-09:
    `d292a16424793cbf6c6183d4b4f697d74016a289a493aaf283cc126a84facb5d`
- Downloaded to `.lake/research/gr-book/` (ignored by Git), with 18 of the 33
  chapter-by-chapter PDFs (20 PDFs in all with the two volumes). Text was extracted with
  `pdftotext`. Hashes, page counts and PDF dates re-checked 2026-11-08 [R: shasum, pdfinfo].
- Also read: the introduction (§1) of Loubaton–Ruit, arXiv 2507.07807 v2 (2025-07-25), on the
  status of the book's (∞,2)-categorical conjectures, and the GLC I, GLC II, AGKRRV and AG TeX
  sources in `references/papers/`, to see how they cite the book.
- Checked 2026-11-08.
- Licence: the book page states none, and the PDFs carry no copyright or imprint page [R].
  The book was published by the AMS in 2017 as *Mathematical Surveys and Monographs* 221 [R:
  the bibliographies of AGKRRV, GLC II and Loubaton–Ruit say so]. The DOIs
  10.1090/surv/221.1 and 10.1090/surv/221.2 come from web search results, not opened here [S].
  So the PDFs are free to read but not openly licensed [J]. They should not be committed or
  copied into the repository. Short quotations in docstrings, with a citation, are fine [J].

Tags: [R] read directly in the PDFs or TeX; [S] a source's claim about itself or about other
work; [E] estimate; [J] judgement. All checked 2026-11-08.

## 1. What it is

- A two-volume monograph, about 1,035 pages [R: pdfinfo]: Vol I *Correspondences and duality*,
  Vol II *Deformations, Lie theory and formal geometry* [R: title pages]. Its purpose is "to
  set up the machinery of ind-coherent sheaves on (derived) schemes, in order to apply it in Volume II and
  describe algebro-geometrically categories and functors that naturally arise in representation
  theory" [R: Vol I, Introduction]. In the authors' words, "this book is not really about
  algebraic geometry ... this book is written with a view toward applications to representation
  theory" [R: Preface §1.1].
- The published structure differs from the chapter-by-chapter files on the same page [R]:

  | Published (cite this) | Chapter-by-chapter file on the page | Content |
  |---|---|---|
  | Vol I, Part I, Ch. 1–3 | I.1–I.3 (`HA`, `BasicsDAG`, `QCoh`) | higher algebra and DG categories; prestacks, derived schemes, Artin stacks; QCoh on prestacks |
  | Vol I, Part II, Ch. 4–6 | II.1–II.3 | IndCoh on schemes; IndCoh as a functor out of correspondences; QCoh vs IndCoh (the functors Ψ and Υ) |
  | Vol I, Part III, Ch. 7–9 | V.1–V.3 | the (∞,2)-category of correspondences, extension theorems, monoidal structure |
  | Vol I, Appendix, Ch. 10–12 | A.1–A.3 | (∞,2)-categories, straightening and Yoneda, adjunctions |
  | Vol II, Part I, Ch. 1–4 | III.1–III.4 | deformation theory; ind-schemes and inf-schemes; IndCoh on ind-inf-schemes; crystals (D-modules) |
  | Vol II, Part II, Ch. 5–9 | IV.1–IV.5 | formal moduli; Lie algebras and Koszul duality; formal groups; Lie algebroids; infinitesimal differential geometry |

- Two chapter-by-chapter links are broken: `InfCohoninf.pdf` (III.3) and `crysttext.pdf` (III.4)
  return HTTP 404 [R]. Their content is in `Vol2.pdf` (Ch. 3 and 4) [R]. The chapter files
  carry different PDF dates (2015–2016 for some, 2021 for others) [R: pdfinfo]. So the
  "chapter-by-chapter original version" and the "published version" may not agree line by
  line [J].
- No TeX source is offered, only PDFs [R: every link on the page is a `.pdf`].

## 2. What it says that matters for GLCinLean

### 2.1 The objects GLC's statement rests on, and where the book defines them

- **DG categories.** "Throughout this book we will be working over a ground field k of
  characteristic 0" [R: Vol I Ch. 1 §10.1.1]. `DGCat_cont` is `Vect-mod(1-Cat^{St,cocmpl}_cont)`:
  modules over `Vect` in cocomplete stable ∞-categories with continuous functors. "The
  (∞,1)-category DGCat_cont will be the principal actor in this book" [R: Ch. 1 §10.3.3]. The
  approach goes through Lurie's stable ∞-categories, not through Drinfeld's DG quotients: "we
  decided to abandon this approach, and access DG categories via a more robust
  (=automatic, tautological) approach" [R: Ch. 1 §0.6.1].
  Presentability is assumed silently: "When talking about cocomplete categories we will always
  assume that they are presentable", and "we will omit the adjective 'presentable' even when it
  should properly be there" [R: Ch. 1 §5.1 footnote 8, §2.5 footnote 3]. So the placeholder
  docstring's "presentable" is right, but the book never writes the condition out; a Lean
  definition must [J].
- **QCoh on prestacks** (Vol I Ch. 3) is a limit over affine schemes mapping to the prestack.
  It needs ∞-categorical limits of DG categories, but not correspondences [R: Preface §2,
  Ch. 1 §0.1.2].
- **IndCoh on a scheme** is `Ind(Coh(Z))`. There is a t-exact functor
  `Ψ_Z : IndCoh(Z) → QCoh(Z)` that is an equivalence on `IndCoh(Z)^{≥−n}` for every n, and an
  equivalence everywhere "if and only if Z is smooth" [R: Preface §2.3–2.4 and footnote 8].
  The book constructs Ψ for schemes only. For prestacks it says "only the functor Υ_X makes
  sense; the functor Ψ_X is a feature of schemes (or, more generally, Artin stacks)" [R: Vol I
  Ch. 5, Remark 0.2.4]. The Ψ of GLC I, on the stack `LS_Ǧ`, therefore comes from AG and
  Gaitsgory's *IndCoh* paper, not from this book [J].
- **The (IndCoh,*)-pullback** along eventually coconnective maps (flat and smooth maps among
  them) is a functor of ∞-categories `((Sch_aft)_{event-coconn})^op → DGCat_cont`, built in
  Vol I Ch. 4 from the *-pushforward by adjunction, with no correspondences [R: Vol I Ch. 4
  §3.1.5, Prop. 3.1.6, Cor. 3.1.10].
- **The !-pullback for arbitrary maps**, as a functor of ∞-categories
  `IndCoh^!_Sch : (Sch)^op → DGCat`, needs the correspondence machinery: "even if one is only
  interested in the functor (0.4), one has to employ the machinery of (∞, 2)-categories of
  correspondences in order to construct it" [R: Vol I Ch. 5, Remark 0.2.1]. Ch. 5 "delegates"
  the hard work to Ch. 7, and Ch. 7 relies on the (∞,2)-appendix [R: Preface §3.2, §3.4.2,
  §3.4.4]. IndCoh on a laft prestack is then the right Kan extension of `IndCoh^!` [R: Vol I
  Ch. 5 §0.2.2]. "Roughly a third of the work in this book goes into the construction of the
  functor (2.3)" [R: Preface §2.3].
- **A shortcut** [R: Preface §3.4.7]. In the context of Vol II Ch. 7–9 ("differential
  calculus"), and if one is content with inf-schemes, "we can bypass the entire discussion of
  correspondences, and only use the material from Volume I, Chapter 4, i.e., IndCoh on schemes
  and !-pullbacks for proper (in fact, finite) morphisms". This covers `X_dR` for a scheme X.
  It does not cover `Bun_G` or `(Bun_G)_dR`, which are not inf-schemes, since their reduced
  parts are stacks, not schemes [J: from the book's definition of inf-schemes, not re-read
  here].
- **Crystals (D-modules).** `Crys(Z) := IndCoh(Z_dR)` (right crystals), and
  `Crys^l(X) := QCoh(X_dR)` (left crystals) [R: Vol II Ch. 4 §0.2.1, §0.3.5]. For any scheme
  almost of finite type, `Υ_{X_dR} : Crys^l(X) → Crys^r(X)` is an equivalence, citing
  [GaRo2, Prop. 2.2.4] [R: Vol II Ch. 4 §4.3.1]. For smooth X, crystals agree with classical
  D-modules [R: Vol II Ch. 4 §0.2, §4]. The authors' verdict on this chapter: "Nothing in this
  Chapter is very exciting" [R: Preface §3.2].
- **Not in the book.** `Bun_G`, `LS_Ǧ` (beyond the rank-one `LocSys` example in the Preface),
  twisted D-modules (so the half twist of `D-mod_{1/2}`) and singular support do not appear
  [R: text search of both volumes for these terms; a search, not a full reading].
- **IndCoh on Artin stacks.** The book defines k-Artin stacks (Vol I Ch. 2 §4) and recovers
  QCoh and its t-structure on them from smooth atlases (Vol I Ch. 3 §1.4–1.5) [R]. It has no
  separate smooth-chart treatment of IndCoh on Artin stacks [R: text search]. AG (1201.6343,
  which GLC I uses for `IndCoh_Nilp`) writes: "Recall ([IndCoh, Sect. 11.2]) that we have a
  well-defined category IndCoh(𝒵), and that it can be recovered as
  `lim_{Z ∈ affdgSch_{/𝒵,smooth}} IndCoh(Z)`". It adds that either !-pullbacks or
  (IndCoh,*)-pullbacks can be used, "as the two differ by the twist by a cohomologically
  shifted line bundle" [R: singsupp.tex, the subsection "Definition of the category with
  supports for stacks"]. So in AG the smooth-chart formula is a result about an
  already-defined category, quoted from Gaitsgory's *IndCoh* paper, not a definition [R].
- **Why derived.** LocSys has to be read as a derived stack for the Fourier–Mukai–Laumon
  equivalence `Dmod(Pic(X)) ≃ QCoh(LocSys(X))` to hold [R: Preface §2.6(II)].

### 2.2 How carefully the foundations are set up

- **∞-categories are used model-independently.** "What Lurie's book provides is a syntax of
  allowed words and sentences", and the authors' grammar "is incomplete and suffers from
  circularity (e.g., we appeal to fiber products before introducing limits)" [R: Vol I Ch. 1
  §0.4.1–0.4.2]. The book still names the model behind the syntax: Lurie's theory "is based on
  the model of ∞-categories as quasi-categories", and his book "ensures that this syntax can
  be realized in the model of quasi-categories" [R: Ch. 1 §0.4, §0.4.1]. For (∞,2)-categories it
  works "by imitating the complete Segal space approach" [R: Vol I Introduction §3.1]. Vol I Ch. 1 has "no original mathematics" except §9 (rigid monoidal
  categories); it summarises Lurie's HTT and HA [R: Ch. 1 §0.3].
- **Set theory is ignored on purpose.** "Our policy is option (3) from loc.cit., i.e., we just
  ignore these issues" (large and small categories) [R: Ch. 1 §0.4.5].
- **Some proofs are left out.** The Appendix lays out the theory of (∞,2)-categories
  "albeit, omitting some proofs" [R: Vol I Introduction §3]. The Preface is blunter: Ch. 10 "is
  not very technical (mainly because it omits most proofs)" [R: Preface §3.2]. "We made the
  decision to leave
  some statements in Chapter 10 without proof ... The most important of them is the theorem
  that says that the functor (2.1) is fully faithful. The missing proofs will be supplied
  elsewhere" [R: Appendix Introduction §2.7]. Footnotes in the appendix read "We do not prove
  it, and we were not able to find a reference" (8 occurrences, footnotes 2–9 of Ch. 10) [R].
  They sit on Prop. 3.2.6, Prop. 3.2.9, Prop. 3.3.5, Thm. 4.1.3, Thm. 4.3.5, Prop. 4.5.4,
  Thm. 4.6.3 and Thm. 5.2.3 of Ch. 10 [R: the statement just before each footnote]. These are
  exactly the eight statements in Loubaton–Ruit's tables [R].
- **Status of those gaps (2025).** Loubaton–Ruit list eight statements from Ch. 10 that the book
  conjectures (associativity of the Gray tensor product, Prop. 10.3.2.9; Sq fully faithful,
  Thm. 10.4.1.3; and others). They attribute proofs to Verity, Ozornova–Rovelli–Verity, Maehara,
  Abellán and Loubaton, and prove the last one (Prop. 10.4.5.4) themselves. They say "we may
  conclude that all conjectures are now resolved" [S: arXiv 2507.07807 v2 §1]. The proofs use
  several different models of (∞,2)-categories, compared through a chain of published
  identifications [R: their §1.2 diagram]. Their account covers these eight flagged
  statements. It does not cover proofs that Ch. 10 omits without flagging them, if the
  Preface's "omits most proofs" means more than the eight [J].
- **What the authors call routine or technical** [R: Preface §3.2]. Ch. 6 "is routine. The
  only really useful thing from it is the functor Υ_Z". Ch. 8 is "a rather technical
  extension theorem ... we do not believe that the reader will gain much by studying its
  proof". Vol II Ch. 2 is "quite technical. So, the practically minded reader should just
  understand the definition (Sect. 3.1) and move on".
- **The authors' own dependency graph** is in Preface §3.4 [R]. Vol I Part I comes first. Ch. 4
  needs Part I. Ch. 5 needs Ch. 4 and Ch. 7. Ch. 7–9 need the Appendix. Vol II Ch. 1 needs only
  Vol I Ch. 2–3 ("(almost) independent of the material from Volume I, Part II"). Vol II Ch. 3
  needs Vol I Ch. 5 and 8 and Vol II Ch. 2. Vol II Ch. 6 needs only Vol I Ch. 1. From Vol II
  Ch. 4 (crystals), later chapters use only "the extremely useful notion of the de Rham
  prestack construction X ↝ X_dR" [R: Preface §3.4.5]. The graph has a slip: §3.4.3 says
  "Volume I, Part II develops the theory of categories of correspondences. It plays a service
  role for Volume I, Chapter 6 and Volume II, Chapter 3". §3.1 and the table of contents put
  correspondences in Part III, and §3.4.2 makes Ch. 5 (not only Ch. 6) depend on it [R]. An
  agent that builds a dependency order from §3.4 should use §3.1 and §3.4.2 here [J].

### 2.3 How the GLC papers use the book

- GLC I does not cite the book. Its bibliography has only GaRo1 (*DG ind-schemes*, cited once)
  and GaRo2 (*Crystals and D-modules*, listed but not cited). GLC I says "Notations and
  conventions in this paper largely follow those adopted in [AGKRRV]", and cites AGKRRV 52
  times [R: `references/papers/2405.03599v3/src/functor.tex`].
- AGKRRV (2010.01906) cites the book 64 times (GR1: 34, GR2: 30), counting citation keys
  outside the bibliography [R: count re-done 2026-11-08; an earlier count of 66 included the
  bibliography entries]. For example, "locally of finite type (see [GR1, Chapter 2, Sect.
  1.6.1])". AGKRRV says that the algebro-geometric objects over the ground field k (X, `Bun_G`)
  "will be classical, i.e., non-derived; this is because we will study sheaf theories on them
  that are insensitive to the derived structure (such as ℓ-adic sheaves, or D-modules)".
  Derived objects live over the coefficient field e [R].
- GLC II cites the published book 15 times (GaRo3: 12, GaRo4: 3), counted the same way [R].
  Among them are Vol I Ch. 7 and Ch. 11 (Thm. 1.1.8) [R]. AG (1201.6343) cites Gaitsgory's
  *Ind-coherent sheaves* (Moscow Math. J. 2013), *Crystals and D-modules* (arXiv:1111.2087),
  and "Notes on Geometric Langlands: Studies in derived algebraic geometry. Book in
  preparation" [R: AG bibliography].
- So the book sits about two citation steps below the GLC statement. GLC I relies on AGKRRV and
  AG, and they rely on the book [J].

## 3. What it means for GLCinLean

1. **It is the natural map of the geometric-representation-theory foundations** (ideas.md §1,
   "a library ... for geometric representation theory (D-modules, perverse sheaves, etc.)")
   [J]. The authors' dependency graph (§2.2 above) is a ready-made dependency order for the
   backbone. Step 2 of workflow.md ("each object of the GLC statement mapped to Mathlib, Tau
   Ceti, a Tau Ceti roadmap item, or missing; backbone versus surface") could use it to order
   the backbone [J].
2. **The statement does not need the whole book** [J, based on §2.1]. A minimal path to
   *define* (not prove anything about) the objects of Conj. 1.6.7:
   - `DGCat` and continuous `A`-linear functors: Vol I Ch. 1 §§1–8, 10. This rests on stable,
     presentable ∞-categories and the Lurie tensor product, none of which is in Mathlib or Tau
     Ceti (see `tauceti-library.md`, `tauceti-roadmaps.md` on EnhancedDerivedSheaves).
   - `QCoh(LS_Ǧ)`: derived affine schemes and prestacks (Vol I Ch. 2 §1, §3.1) and QCoh as a
     limit (Ch. 3 §1).
   - `D-mod_{1/2}(Bun_G)`: either left crystals `QCoh((Bun_G)_dR)`, which needs only QCoh on
     prestacks and the de Rham prestack, or right crystals `IndCoh((Bun_G)_dR)`, which needs
     IndCoh on prestacks and therefore the correspondence machinery. The book proves the two
     agree for schemes almost of finite type (§2.1), not for stacks. Taking left crystals on
     `Bun_G` is therefore a choice, and matching it with the D-modules GLC I uses is a further
     obligation [J]. The half twist is not in this book [R: text search]; GaRo2 is said to treat
     twistings [J: not checked here].
   - `IndCoh_Nilp(LS_Ǧ)` and `Ψ`: IndCoh on affine derived schemes with (IndCoh,*)-pullback
     along smooth maps (Vol I Ch. 4 §§1–3; Cor. 3.1.10 gives this pullback as a functor of
     ∞-categories without correspondences [R]), a limit over smooth charts as in AG, and
     singular support from AG (not from this book).
   - Not needed for the statement: Vol I Part III (correspondences), the Appendix, Vol I Ch. 8,
     inf-schemes beyond `X_dR`, and the whole of Vol II Part II [J].
3. **This choice changes how much the placeholders hide** [J]. The smooth-chart limit needs a
   smooth atlas, so it describes the right category only when `LS_Ǧ` is an Artin stack. Singular
   support (AG) also needs `LS_Ǧ` to be quasi-smooth. Both would then be separate proof
   obligations, or budgeted `sorry`s in `reviews/sorry-budget.toml`. In AG the smooth-chart
   formula is a theorem about the general definition (§2.1). Taking it as the definition moves
   that theorem out of reach until the general theory exists. The general definition (IndCoh on
   any laft prestack) avoids all this, at the cost of Vol I Ch. 5 and 7 and the Appendix.
4. **The existing placeholders fit the book, with two gaps** [R: `GLCinLean/Foundations.lean`,
   `GLCinLean/Abstract.lean`; J: assessment]:
   - `DGCat`'s docstring ("Cocomplete presentable stable `k`-linear ∞-categories") and
     `LinFun` (continuous `A`-linear functors) match `DGCat_cont` and module categories in
     Ch. 1 §§8, 10. `Psi` corresponds to Ψ, restricted to `IndCoh_Nilp` and taken on a stack.
     That version is AG's, not the book's (§2.1).
   - Gap 1: `DGCat : Type` (from `NonemptyType.{0}`) has **no `k` parameter**, but the book's
     DG categories are `Vect_k`-modules. Adding `k` later changes the statement's signature [J].
   - Gap 2: `DGCat` lives in `Type 0`. The real object is a large category of large categories,
     and the book "ignore[s]" size. A Lean definition must fix universes, so the placeholder's
     universe will probably change when it is replaced [J].
   - `DmodHalf`, `QCohLS` and `IndCohNilp` are opaque per `Setting`. The book suggests a finer
     design: general constructions (QCoh of a prestack, `(-)_dR`, IndCoh of an Artin stack)
     applied to placeholder geometric objects (`LS_Ǧ`, `Bun_G`). That design would make the
     statement say more and fits the library goal [J].
5. **Mathlib style, "Link to the existing literature"** (ideas.md §1). Docstrings should cite the
   published numbering, e.g. "[GR, Vol. I, Ch. 4, §2.1]". The page's chapter-by-chapter
   numbering (II.1, V.1, ...) differs and would confuse readers [J]. Papers built on the book
   (GLC II, AGKRRV, Loubaton–Ruit) cite the published numbering [R].
6. **Papers as TeX** (ideas.md §5). This source has no TeX, only PDFs, and they are not openly
   licensed [R]. `pdftotext` drops many symbols and all diagrams [R: e.g. the Cyrillic epigraph
   and commutative squares come out garbled]. Agents that review against this book need the
   PDF, read as images, or a human [J].
7. **Breadth before depth** (ideas.md §1, Xena list). The book is itself an example of
   "breadth first": three quarters of it is general machinery built before any application
   [J]. A faithful library on its model is a very large, multi-year effort. It sits on Lurie's
   HTT and HA (thousands of pages; [E]), which Mathlib and Tau Ceti have barely begun [S:
   `tauceti-roadmaps.md`].
8. **Proof stage** (workflow.md step 6). The proof (GLC I–V) uses much more of the book: Ch. 5's
   functoriality, Verdier/Serre duality via correspondences (Ch. 9 §§2.2–2.3), and Vol II Ch. 3.
   So the (∞,2)-layer that the statement can skip becomes unavoidable for the proof [J, from
   the GLC II citations to Ch. 7 and 11].

## 4. Conflicts

- **With the task's caveat** ("its (∞,2)-categorical claims were stated without proof").
  Accurate for the book [R], but by Loubaton–Ruit's account all eight flagged statements had
  been proved in the literature by July 2025 [S]. Seven proofs are attributed to other papers,
  which were not read here; the eighth is their own Theorem B, which was not checked here
  either [R: their tables 1.2.1, 1.3.1, 1.5.1]. The closing proofs use several models (Verity's complicial
  sets, Maehara's Θ₂-presheaves, Gagna–Harpaz–Lanari's scaled simplicial sets), compared by a
  chain of identifications [R]. Formalising them means formalising those comparisons too [J].
- **With the source order in ideas.md §3** (Mathlib, then Tau Ceti, then Stacks). None of the
  three has stable or presentable ∞-categories, derived schemes, IndCoh or crystals [S:
  `mathlib-coverage.md`, `tauceti-library.md`, `stacks.md`]. Mathlib's quasicategories
  (`SSet.Quasicategory`) are the model Lean already has. The book writes model-independently,
  but it names quasi-categories as the model that realises its (∞,1) syntax, and complete Segal
  spaces as the pattern for its (∞,2)-categories [R: §2.2 above]. So it points to two different
  models for the two layers, and one of them (quasi-categories) matches Mathlib [J]. It does not
  say how to choose for a formalisation [J]. So the order of sources does
  not settle where this layer comes from. That is the owner's choice between "write it here"
  and "contribute to Tau Ceti EnhancedDerivedSheaves" (ideas.md §4).
- **With ideas.md §5** (TeX files). There is no TeX for this source (above).
- **Within the source itself.** Published numbering and chapter-file numbering differ. The
  "published version" PDFs on the page are dated 2021-12-09, four years after the 2017 AMS
  edition [R: pdfinfo; the 2017 date from the AGKRRV, GLC II and Loubaton–Ruit
  bibliographies]. They may include later corrections, so the page's PDF and the AMS print
  edition may differ [J]. The numbering Loubaton–Ruit cite from the AMS edition (e.g. Prop.
  10.3.2.9, Thm. 10.4.1.3) matches the 2021 `Vol1.pdf` [R]. The book page has no errata list [R].
  A web search found none [S: search results only]. The Preface's own dependency graph
  has a slip (§3.4.3 says "Part II" for the correspondences; see §2.2) [R].
- **With GLC I's own conventions.** GLC I points to AGKRRV, which works over a coefficient
  field `e` that is algebraically closed of characteristic 0. The book fixes a ground field `k`
  of characteristic 0 [R]. For D-modules, `k = e` [R: AGKRRV conventions]. That agrees with
  `Setting`'s `[CharZero k] [IsAlgClosed k]` [R], so this is no conflict, only something to keep
  aligned [J].
- No conflict found with the decisions in workflow.md.

## 5. Input for the open questions (workflow.md, "Questions for after the research")

- **Is `Abstract.lean` / `Foundations.lean` / the placeholder design reasonable?** Broadly yes:
  the objects match the book's definitions, and Ψ matches AG's version on stacks [J]. Before the statement is pinned again,
  consider (a) adding `k` and universe parameters to `DGCat`/`LinFun`, and (b) splitting the
  per-`Setting` opaques into general constructions applied to placeholder geometric objects
  (§3.4). Reason: both change the statement's shape. Making the change while everything is a
  placeholder is cheap; making it after review means re-pinning [J].
- **Is `PLAN.md` needed?** The book supplies a stable dependency order (Preface §3.4) that
  outlasts any one session's prompt [J]. That order fits in the blueprint (step 2) better than
  in a free-text plan [J]. This source does not by itself settle whether `PLAN.md` stays.
- **What goes into `AGENTS.md`?** Two short rules suggested by this source [J]: cite the book by
  published volume, chapter and section; and note that the PDF is not openly licensed and is
  not committed, with the SHA-256 recorded wherever the project lists its sources.
- **What happens to `references/papers/manifest.toml`?** This source is not on arXiv, so a
  "TeX only, fetched from arXiv" rule does not cover it. If the manifest goes (ideas.md §5),
  something still has to record the URL and hash of non-arXiv sources like this one [J].
- **Who reviews the mathematics, and to what standard?** The foundations layer is where a fresh
  agent is weakest. The text is a PDF whose extraction loses diagrams. The book itself
  delegates syntax to Lurie and skips size issues. Several of its proofs live in other papers
  [R/J]. This suggests an outside expert for definitions taken from the book (DGCat, QCoh and
  IndCoh on stacks, crystals), with agent review checking against cited sections [J].
- **Where research notes live.** Not affected by this source.

## 6. Questions for the owner

1. **Which path for the statement's foundations?** (a) The minimal path: QCoh on prestacks,
   D-modules as left crystals, IndCoh on `LS_Ǧ` through smooth charts, and algebraicity and
   quasi-smoothness of `LS_Ǧ`, and the match with GLC I's D-modules, as separate obligations. (b) The book's full route: IndCoh on all laft prestacks via
   correspondences and (∞,2)-categories. (a) reaches a real statement much sooner. (b) is what
   the proof eventually needs [J].
2. **Who builds the ∞-categorical layer?** The candidates are stable and presentable
   ∞-categories, `DGCat_cont` and the Lurie tensor product (Vol I Ch. 1). Should GLCinLean build
   it here, contribute it to Tau Ceti's EnhancedDerivedSheaves roadmap, or wait for it?
3. **Change the `DGCat` placeholder's signature now?** The options are to add `k` and universe
   parameters and to replace per-`Setting` opaques by general constructions. Either changes the
   pinned statement (`reviews/statement-pin.toml`, an owner's file).
4. **Which edition to cite?** The AMS 2017 print or the authors' 2021 PDFs (pinned by
   SHA-256)? And how should a PDF-only, not openly licensed source be recorded, given the
   preference for untracked TeX?
