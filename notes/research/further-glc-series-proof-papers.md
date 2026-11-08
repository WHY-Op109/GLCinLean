# The GLC series I–V: what the proof papers prove, what they need, and the manifest check

- **Sources** (all five checked 2026-11-08; arXiv abstract pages give CC BY 4.0 for each [R]):
  - GLC I, Gaitsgory–Raskin, "construction of the functor", <https://arxiv.org/abs/2405.03599v3>
  - GLC II, Arinkin–Beraldo–Campbell–Chen–Færgeman–Gaitsgory–Lin–Raskin–Rozenblyum, "Kac-Moody
    localization and the FLE", <https://arxiv.org/abs/2405.03648v3>
  - GLC III, Campbell–Chen–Færgeman–Gaitsgory–Lin–Raskin–Rozenblyum, "compatibility with
    parabolic induction", <https://arxiv.org/abs/2409.07051v1>
  - GLC IV, Arinkin–Beraldo–Chen–Færgeman–Gaitsgory–Lin–Raskin–Rozenblyum, "ambidexterity",
    <https://arxiv.org/abs/2409.08670v1>
  - GLC V, Gaitsgory–Raskin, "the multiplicity one theorem", <https://arxiv.org/abs/2409.09856v3>
- **Local copies** (Git-ignored, not committed):
  - `references/papers/2405.03599v3/src/functor.tex` and `references/papers/2405.03648v3/src/Loc.tex`
    (already present);
  - new on 2026-11-08: `references/papers/2409.07051v1/src/Eis.tex`,
    `references/papers/2409.08670v1/src/ambidex.tex`, `references/papers/2409.09856v3/src/multone.tex`.
    Each folder also holds the raw e-print (`source.download`, plus `source.tar` for V), the
    arXiv PDF (`paper.pdf`) and the HTTP headers;
  - PDFs of I and II, and `pdftotext` extractions of all five (used for the printed theorem
    numbers): `.lake/research/glc-pdfs/`.
- **Checked 2026-11-08.** "Read" here means: the full introduction of each paper, the summary
  sections of IV (§1) and V (§1), the statements of the theorems listed below, the passages quoted,
  and each bibliography. The 900-odd pages of proofs were **not** read. Every [R] below refers to
  one of these passages, with its TeX line.
- **Tags:** [R] read directly, [S] a source's claim about itself, [E] estimate, [J] judgement.
  All dated 2026-11-08. Line numbers are lines of the TeX files above. Printed numbers (Thm 6.1.4
  and so on) were matched against the PDF text; where only the TeX label was checked, only the
  label is given.

## 1. What it is

- Five papers that together claim the unramified, global, de Rham geometric Langlands conjecture
  in characteristic 0. GLC I l.699: "This paper is the first in a series of five, in which the
  geometric Langlands conjecture will be proved" [S].
- The conjecture proved is GLC I Conj. 1.6.7 (`c:GLC dR`, functor.tex l.1861): "The functor 𝕃_G
  is an equivalence." III, IV and V each restate it with this reference [R Eis.tex l.740, ambidex.tex
  l.719, multone.tex l.746].
- Size [R `pdfinfo`]: I 43 pp., II 448 pp., III 330 pp., IV 64 pp., V 62 pp. (947 pp. in all).
  TeX: 4 604 / 39 677 / 27 677 / 6 415 / 6 810 lines.
- Dates (arXiv API) [R]: I v1 2024-05-06, v3 2025-09-30; II v1 2024-05-06, v3 2024-09-11;
  III v1 2024-09-11; IV v1 2024-09-13; V v1 2024-09-15, v3 2026-01-16.
- Gaitsgory's page <https://people.mpim-bonn.mpg.de/gaitsgde/GLC/> also hosts all five as PDFs.
  `Last-Modified` dates are 11–16 Sep 2024 [R headers, 2026-11-08], so it is older than I v3 and
  V v3 on arXiv. Its `ambidex.pdf` has the same numbering as arXiv IV v1 [R], but a different
  SHA-256 (`585ecd25…`).

## 2. What it says that matters for GLCinLean

### 2.1 The manifest's records hold

`references/papers/manifest.toml` was checked against fresh downloads and the arXiv API on
2026-11-08 [R]:

| Paper | Pinned | Latest on arXiv | Title | Licence | SHA-256 source | SHA-256 PDF |
|---|---|---|---|---|---|---|
| I 2405.03599 | v3 | v3 | matches | CC BY 4.0 | matches | matches |
| II 2405.03648 | v3 | v3 | matches | CC BY 4.0 | matches | matches |
| III 2409.07051 | v1 | v1 | matches | CC BY 4.0 | matches | matches |
| IV 2409.08670 | v1 | v1 | matches | CC BY 4.0 | matches | matches |
| V 2409.09856 | v3 | v3 | matches | CC BY 4.0 | matches | matches |

- The e-print of III is one gzipped file `Eis.tex` and that of IV one gzipped `ambidex.tex`. That
  of V is a tar of `multone.tex` and `00README.json` (TeX Live 2025, pdflatex) [R `file`, `tar -t`].
- The manifest has no entry for the external papers the series rests on (§2.3). The records it
  does have are right.

### 2.2 Paper by paper: main results, inputs, new objects

**GLC I (functor.tex).** It constructs 𝕃_G and states GLC.

- Main results [R]:
  - Thm 1.2.4 (`t:spectral decomp`, l.1459): the Hecke action of Rep(Ǧ)_Ran factors through
    QCoh(LS_Ǧ). It is *quoted* from [Ga2, Cor. 4.5.5] (Gaitsgory, "Outline of the proof of the
    GLC for GL(2)", Astérisque 370, arXiv 1302.2506), not proved here.
  - Thm 1.6.2 (`t:compact to bdd below dr`, l.1808): 𝕃_{G,coarse} sends compacts to eventually
    coconnective objects.
  - Cor 1.6.5 (`c:main dr`, l.1833): 𝕃_G exists and is unique.
  - Conj 1.6.7 (l.1861).
  - Thm 2.1.2 (`t:L coarse left exact`, l.2020) and Thm 2.3.8 (`t:L coarse left exact Nilp`,
    l.2331). Thm 2.3.8 is imported from [FR], Færgeman–Raskin, arXiv 2207.02955 (GLC I calls it "the left
    t-exactness half" of a result of [FR], l.2329).
  - Betti and restricted versions, out of scope for de Rham: Thm 3.5.2 (`t:dR => Betti`, l.2857),
    Thm 3.5.6 (l.2909).
  - Thm 6.1.3 (`t:eigensheaves`, l.3983).
- Inputs:
  - from the intro (l.842–847): Thm 1.6.2 "uses non-trivial input: ultimately we deduce it from
    Thm 2.3.8, proved in [FR] using methods developed in [AGKRRV] and [Lin]" [R];
  - from the text: [AG] for IndCoh_Nilp and for Ψ being an equivalence on eventually coconnective
    parts (AG Prop. 4.4.5, l.1826); [DG1] for compact generation of Dmod_{1/2}(Bun_G) (Thm 0.1.2,
    l.1831) [R];
  - by citation count [R], the most-cited works are [FR] (11) and [AGKRRV] (about 25 across its
    sections). No other GLC paper is cited.
- New objects: coeff^{Vac,glob}, Poinc^{Vac,glob}_{G,!}, 𝕃_{G,coarse}, 𝕃_G, the tempered
  quotient Dmod_{1/2}(Bun_G)_temp, and the restricted and Betti variants [R intro l.697–1095].

**GLC II (Loc.tex).** The local theory (FLE) and its link to the global functor.

- Main results [R]:
  - Thm 0.1.2 (`t:main intro`, l.730) = Thm 18.5.2 (`t:Langlands critical compat`, l.20886).
    𝕃_G ∘ (Loc_{G,crit} ⊗ line) ≅ Poinc^spec_{Ǧ,*} ∘ FLE_{G,crit}, as functors out of
    KL(G)_{crit,Ran}.
  - Thm 6.1.4 (`t:critical FLE`, l.7087): FLE_{G,crit} : KL(G)_crit → IndCoh^*(Op^mf_Ǧ) "is an
    equivalence of factorization categories".
  - Thm 6.2.2 (`t:critical FLE pointwise`, l.7153): the pointwise version, first proved in [FG2]
    (Frenkel–Gaitsgory) and reproved here.
  - Thm 18.3.2 (l.20665): GLC I Cor. 1.6.5, quoted.
  - §§15–16 (l.16739ff): the Hecke eigen-property of critical localisation (Thm 15.2.8 is proved
    in §16).
- Inputs [R intro l.1100–1630 and bibliography]:
  - GLC I;
  - Beilinson–Drinfeld [BD1, BD2] (13 and 10 citations);
  - Frenkel–Gaitsgory [FG2], Raskin [Ra2] ("W-algebras and Whittaker categories") and Campbell–
    Raskin [CR] (arXiv 2310.19734) for derived geometric Satake and Casselman–Shalika ("largely
    taken from [CR]", l.1293);
  - the Feigin–Frenkel isomorphism [FF], Chen–Fu [CF], Rozenblyum [Ro2], Gaitsgory–Rozenblyum
    [GaRo3–4], Lurie [Lu1–3];
  - two unpublished items: [CFGY] (Chen–Fu–Gaitsgory–Yang, "Loop group actions via
    factorization", "preprint"), cited for a construction that "we sketch … a more detailed
    exposition will be given in [CFGY]" (l.6116); and Raskin's website notes [Ra4], [Ra6].
    An arXiv title search found no CFGY [R API search; a different title cannot be ruled out];
  - one forward reference: GLC IV, App. C (l.15744, l.20323).
- New objects [R]:
  - KL(G)_{crit,Ran};
  - the Ran-space space of monodromy-free opers Op^mf_Ǧ;
  - IndCoh^! and IndCoh^* in infinite type, placidity, QCoh_co (Appendix);
  - factorization spaces, categories and algebras, the unital Ran space and unital structures
    (Appendices);
  - local-to-global functors and their unitalisation (§11);
  - Loc_{G,κ}, Poinc^spec_{Ǧ,*}, FLE_{G,crit}.
  - The paper says it had to "refine many foundational parts of the original work of
    Beilinson-Drinfeld. This ultimately accounts for the length" (l.858–861), much of it because
    "we (have to) work with ∞-categories" (l.864) [S].

**GLC III (Eis.tex).** Eisenstein series and the Eisenstein part.

- Main results [R]:
  - Main Thm 17.1.2 (`t:main`, l.21749): "Let us assume that GLC is valid for Levi subgroups of
    all proper parabolics of G. Then the adjoint functors [𝕃_G : Dmod_{1/2}(Bun_G)_Eis ⇄
    IndCoh_Nilp(LS_Ǧ)_red : 𝕃_G^L] are mutually inverse equivalences."
  - Thm 14.2.2 (`t:L and Eis`, l.19026): 𝕃_G commutes with Eisenstein series, up to shift.
  - Thm 15.1.13 (`t:CT compat`, l.19725), assuming GLC for M: commutation with constant terms.
  - Thm 15.1.2 (`t:L and CT`, l.19500): proved only after Main Thm 17.1.2 (l.895).
  - Thm 16.1.2 (`t:left adjoint`, l.21049): 𝕃_G has a left adjoint.
  - Thm 16.2.3 (`t:left adjoint as dual`, l.21161).
  - Thm 16.4.2 (`t:AG`, l.21454): 𝕃_G ∘ 𝕃_G^L is tensoring with an algebra A_G ∈ QCoh(LS_Ǧ).
  - Local: Thm 5.2.3 (`t:local Jacquet`, l.8054), FLE compatible with Jacquet functors; Thms 2.4.3
    and 2.7.6 (`t:semiinf geom Satake` l.3636, `t:semiinf CS` l.4071).
- Inputs [R intro l.735–1660 and bibliography]:
  - GLC II Thm 18.5.2 ("constructed in [GLC2, Theorem 18.5.2]", l.922) and the critical FLE;
  - GLC I;
  - [FR], in a footnote on equivalent forms;
  - [CR] (10 citations); Raskin–Yang [RY] (Annals 2024); Arkhipov–Bezrukavnikov(–Ginzburg)
    [AB, ABG]; Frenkel–Gaitsgory [FG1, FG3]; Gaitsgory's semi-infinite IC sheaf [Ga4, Ga5];
    Braverman–Gaitsgory [BG1, BG2]; Drinfeld–Gaitsgory [DG1–3]; R. Yang [YaR] for the pointwise
    semi-infinite Casselman–Shalika (l.23789);
  - [FH], Færgeman–Hayash, "forthcoming" in III v1 (l.27540). III defers to it the
    general-parabolic case of several inputs: compact generation (l.1931), the left adjoint
    (l.1994), IC^{−,∞/2} (l.2159), and "A detailed proof of Theorem `t:ident Omega bis` will
    appear in [FH]" (l.24216), a theorem used for semi-infinite geometric Satake (l.24190). FH is
    now arXiv 2507.13930 v2 (arXiv API) [R];
  - [Ra4] (Raskin, "Chiral principal series categories II", website only; not found on arXiv by
    title [R API search]).
- New objects [R]:
  - local semi-infinite categories I(G,P⁻)^loc and I(Ǧ,P̌⁻)^{spec,loc};
  - Jacquet and Wakimoto functors; parabolic Miura opers;
  - enhanced and "compactified" Eis/CT (Eis_{!*}, CT_{!*}), and spectral Eis/CT;
  - Dmod_{1/2}(Bun_G)_Eis, IndCoh_Nilp(LS_Ǧ)_red;
  - 𝕃_G^L, Φ_G (dual of 𝕃_G with miraculous duality and the Chevalley involution), A_G.

**GLC IV (ambidex.tex).** Ambidexterity on the cuspidal part.

- It assumes GLC for proper Levis throughout ("For the duration of this paper, we will assume the
  validity of GLC for proper Levi subgroups of G", l.1170) [R].
- Main results [R]:
  - Main Thm 3.1.4 (`t:ambidex`, l.2267): the left and right adjoints of 𝕃_{G,cusp} are isomorphic.
  - Main Thm 3.1.8 (`t:A G irred`, l.2292): A_{G,irred} is a classical vector bundle with a flat
    connection.
  - Main Thm 4.5.11 (`t:GLC for class`, l.3222): GLC for classical groups, through [BKS].
  - Reductions: Cor `c:reduce to cusp` (l.1464), GLC ⇔ 𝕃_{G,cusp} is an equivalence;
    Thm 1.4.6 (`t:cusp is irred`, l.1593).
  - Imported: Thm 1.5.2 (`t:cusp cons`, l.1659), "𝕃_{G,cusp} is conservative", from "[FR,
    Theorem A] (which is a combination of [FR, Theorem B] and [Be2, Theorem A])" (l.1656).
  - Thm 1.5.5 (l.1672): 𝕃_G is conservative.
  - Conj 4.5.7 (`c:oper contr`, l.3195): GLC ⇔ the space of generic opers on each irreducible
    local system is homologically contractible.
  - §1.7: GLC for GL_n, via [Be1] or [Ga2] (Gaitsgory, vanishing conjecture, Annals 2004) and [FGV].
- Inputs [R]:
  - GLC I–III, in particular II's "Fundamental Commutative Diagram" (II Diagram (18.14)) and
    III Thms 14.2.2, 15.1.2, 16.1.2 and 17.1.2 (ambidex.tex §1);
  - [FR], Beraldo [Be1, Be2], [FGV], [BD1], Arinkin [Ari] (arXiv 1602.08989);
    Braverman–Gaitsgory [BG] "only treats the case of P=B. The general case will be treated in a
    forthcoming paper of J. Færgeman and A. Hayash" (l.1631);
  - [BKS], Beraldo–Kazhdan–Schlank.
- New objects [R]:
  - Dmod_{1/2}(Bun_G)_cusp, LS^irred_Ǧ, 𝕃_{G,cusp}, A_{G,irred};
  - B^Op_{G,irred} from generic opers Op^gen;
  - spaces of rational maps, with Ran-space embedding results (§§5–8).

**GLC V (multone.tex).** Multiplicity one and the end of the proof.

- GLC is proved in §5.5 ("Proof of GLC", l.3149, ending `\qed[GLC]`). The paper restates GLC as
  Conj 1.1.3 (l.1517) and has no "Main Theorem" environment [R].
- The argument [R intro l.865–1010, outline l.907–925]:
  - reduce to G almost simple and simply connected (§2, Cor `c:sc` l.2143);
  - g = 0: LS^irred is empty;
  - g = 1: SL_n by [BKS] and [Ga5] (contractibility of rational maps); other types by
    "Appealing to Riemann-Hilbert" (l.2534) and compact forms [BFM, KS], which give LS^irred = ∅;
  - g ≥ 2, excluding g = 2 with A_1 factors: Thm 4.3.2 (`t:pi 1 LS`, l.2774), LS^irred is
    simply connected modulo the centre; Thm 5.3.2 (`t:LS CM`, l.3089), quoted from [BD, Prop.
    2.11.2], LS_Ǧ is lci, hence Cohen–Macaulay; Prop `p:compl 2`, the complement of LS^irred has
    codimension ≥ 2; Thm 5.2.3 (`t:end Poinc vac a`, l.3045), k ≅ H⁰ End(Poinc^Vac_{G,!,α});
  - the centre: Thms 5.1.5 and 5.1.7 (`t:Hecke Z 0/1`, l.3000, l.3011), proved through a
    "2-categorical Fourier-Mukai transform" on sheaves of categories over gerbes (§8, l.4151).
  - The paper notes that this route "does not adapt to either Betti or étale settings" (l.988)
    [S].
- Inputs [R §1 l.1491–1663 and bibliography]:
  - GLC I (Sect. 1.2, 1.4, 1.7, Cor 1.6.5);
  - GLC III (Thms 16.1.2, 16.4.2, 17.1.2; Lemma 17.3.7);
  - GLC IV (Main Thm 3.1.8, Cor 4.2.5, Prop 4.2.8, Conj 4.5.7, Cor 4.5.5, Thm 4.5.11);
  - external: [AG], [BD], [BKS], [Ari], [FR], [DG], [Ga3] (1-affineness), [Ga4] = Gaitsgory 2015
    (§11.1, the spectral decomposition), [FH] (arXiv 2507.13930), and classical results on
    G-bundles: Narasimhan–Ramanan, Ramanathan, Biswas et al. [NR, Ra, AB, BMP].
- New objects [R]:
  - the action of Bun_{Z_G} and the decomposition by (Z_G)^∨;
  - gerbes Ge_{Z_G}(X) and Ge_{π₁(Ǧ)}(X), sheaves of categories on non-1-affine prestacks, and
    the 2-categorical Fourier–Mukai transform;
  - τ_{≤1} étale homotopy types of LS^irred and Bun_Ǧ;
  - GLC for non-pure inner forms, as a twisted version (Cors `c:twisted GLC 1/2`).

### 2.3 What the *statement* already needs from the series

- The spectral action is used in the very definition of 𝕃_{G,coarse} (GLC I intro l.746–790, l.1459).
  It has this chain of dependencies [R]:
  - GLC I quotes it from [Ga2, Cor. 4.5.5] (Gaitsgory 2015, arXiv 1302.2506).
  - GLC II §15 (l.16749): "here we fill the gap in the literature: we supply a proof of [Ga1,
    Theorem 10.3.4], which is used in [Ga1, Corollary 4.5.5], while the latter is essential for
    the GLC series." It also says §§15–16 "are not logically necessary either for this paper, nor
    for the other papers in the GLC series".
  - GLC V footnote (l.5456–5460): the proof of the spectral decomposition in [Ga4, §11.1] "relies
    on two ingredients that were not written down at the time": [Ga4, Thm 10.3.4], proved in
    [GLC2, Sects. 15–16], and [Ga4, Prop. 11.1.3], proved in [FH], "in fact, as was observed by
    J. Faergeman, this second ingredient is not even necessary".
  - The same paper is keyed [Ga2] in GLC I, [Ga1] in GLC II and [Ga4] in GLC V (same title in each
    bibliography).
- The bound from compact to eventually coconnective (GLC I Thm 1.6.2), which is needed to *define*
  𝕃_G, rests on [FR] through Thm 2.3.8, with [AGKRRV] and [Lin] behind it [R l.842–847, l.2329].
- So, for the statement as GLC I gives it, the definitions rest on:
  - critical-level Kac–Moody localisation and its Hecke eigen-property (GLC II §§15–16, with
    II's local theory behind it);
  - Gaitsgory 2015;
  - Færgeman–Raskin;
  - AGKRRV's restricted variation [J].

### 2.4 Loose ends found in the texts

Each of these was checked on 2026-11-08 [R]:

1. **A wrong arXiv id for [BKS].** IV (ambidex.tex l.6254) and V (multone.tex l.6620) both give
   "arXiv:1808.05801". The arXiv API returns "On Bias and Rank" (Kazhdan–Schlank) for that id.
   "Contractibility of the space of generic opers for classical groups" (Beraldo–Kazhdan–Schlank)
   is arXiv **1801.00655** (v2).
2. **V v3 cites IV numbers that IV v1 does not have.**
   - V gives [GLC4, Thm 1.6.2] for "𝕃_G is conservative" (l.802, l.1509); in IV v1 that is
     Thm 1.5.5, and 1.6.2 is a paragraph about Nilp|LS^irred.
   - V gives [GLC4, Thm 1.8.2] for multiplicity one in type A (l.1018); IV v1 has no §1.8, and
     its GL_n proof is §1.7.
   - V gives [GLC4, Thm 3.1.5] for "the fiber of A_G at σ is the homology of generic opers"
     (l.3394); in IV v1, 3.1.5 is a corollary about self-adjointness, and the fibre statement is
     in §4.2.
   - Other V citations of IV do match v1: Main Thm 3.1.8, Cor 4.2.5, Prop 4.2.8, Conj 4.5.7,
     Cor 4.5.5, Thm 4.5.11. Gaitsgory's site has the same numbering as v1.
   - So V v3 (Jan 2026) seems to refer to a revision of IV that is public in neither place [J].
3. **Unpublished or late inputs.**
   - [FH] was "forthcoming" for III v1 and IV v1, and is now arXiv 2507.13930.
   - [CFGY] is cited by II as a "preprint" for the details of a construction.
   - Raskin's [Ra4] and [Ra6] are website PDFs.
   - [Bogd] is "in preparation" (II).
4. **Typos.** III l.855 cites "[Conjecture 1.6.7]{GLC2}" for GLC; it is GLC1. The bibliographies
   of IV and V list GLC III with four authors (Campbell, Chen, Gaitsgory, Raskin); arXiv lists
   seven.

### 2.5 The order of the proof, compared with Scholze's outline

The papers give this order [R, from the passages above]:

```
GLC I  (𝕃_G; uses Gaitsgory 2015 for the spectral action, FR for the bound)
  └─ GLC II  (FLE, Loc, Thm 18.5.2; §§15–16 also complete Gaitsgory 2015's spectral action)
       └─ GLC III  (Eis/CT compatibility, 𝕃^L, A_G; Main Thm 17.1.2 *assuming GLC for proper Levis*)
            └─ GLC IV  (cusp reduction, FR conservativity, ambidexterity, A_irred a local system;
                 │       GL_n and classical groups)
                 └─ GLC V  (reduction to almost simple simply connected; low genus; π₁, CM,
                            End(Poinc) = k ⇒ A_irred = O; centre via 2-categorical FM)
Induction on the semisimple rank: III + IV + V together form one induction step.
```

Scholze's outline as the Scholze note records it (`further-scholze-geometric-langlands-after-gaitsg.md`
§2.5, labels (a)–(f)) [R that note]. Where the papers differ [J unless marked]:

- **(d) before (e) is not the logical order.** Scholze lists the Eisenstein part (d) before
  Kac–Moody/FLE (e). In the papers, III's constant-term compatibility (Thm 15.1.13) uses II Thm
  18.5.2 and III's local FLE/Jacquet theorem 5.2.3 [R III l.922, intro §"The local FLE/Jacquet compatibility" l.1280ff]. So (e) comes before
  (d). Scholze does say that the CT compatibility "uses Kac–Moody Localization", so this is an
  order of presentation, not a contradiction.
- **The induction covers more than (d).** Scholze places "induction on rank" in (d). In the
  papers, IV and V also assume GLC for proper Levis, and V's §2 reduction changes the group too
  (almost isogenies, ambidex.tex l.1170 and multone.tex §2) [R]. So the whole of (d) to (f) is one
  inductive step.
- **FR enters twice.** Scholze names Færgeman–Raskin only in (f), as "the most central input".
  The papers also use FR in (c): GLC I's bound, Thm 2.3.8, is FR's result [R GLC I l.2329].
  So FR is a statement-level input too.
- **The spectral action (b) has a third ingredient.** Scholze's (b) cites Gaitsgory 2015 and GLC
  II. V adds [FH] for [Ga4, Prop. 11.1.3], while saying that it is "not even necessary" [R V
  l.5459].
- **GLC V is the multiplicity-one step.** Scholze's §12 does not name the paper. The papers
  confirm it, with the same three inputs: π₁(LS^irred), Cohen–Macaulay with codimension ≥ 2, and
  End(Poinc) = k [R V l.907–925].
- **Several steps are not in Scholze's outline as the note records it:**
  - V's reduction to almost simple simply-connected groups (§2);
  - the centre (2-categorical Fourier–Mukai, §8; V thanks Scholze for "the idea to use the
    translation functors by points of Bun_{Z_G}", l.1463);
  - the separate low-genus cases (§3), where g = 1 uses Riemann–Hilbert and compact Lie groups.
  Scholze's "other cases can easily be treated by hand" (as the note quotes it) matches V's §3 in
  substance.
- **Agreement:**
  - classical groups through BKS (IV Main Thm 4.5.11);
  - ambidexterity in IV;
  - the Eisenstein part in III;
  - Scholze's Thm 9.3 matches GLC I Cor 1.6.5, as the Scholze note already says.

## 3. What it means for GLCinLean

1. **Step 6 (proof) has a ready-made top level.** It has five nodes, one per paper, and the
   graph of §2.5. The induction on rank must be designed into the Lean statement of the proof
   from the start: III–V are proved for G *assuming* `main` for every proper Levi of G, over the
   same curve and Θ. (ideas.md: "first the statement, then the whole proof".) So `Setting` must
   allow Levis of G over the same X, and V's §2 needs `main` to pass along almost isogenies of
   the group [J].
2. **Step 2 (plan): the statement's backbone already reaches deep into the proof.** §2.3 shows
   that the spectral action and the bound to eventually coconnective objects are theorems from
   II, Gaitsgory 2015 and FR. They are not definitions.
   - If the statement keeps them as budgeted sorries, as `exists_isLanglandsFunctor` already does
     for the bound, the statement's backbone needs:
     - ∞-categorical DG categories with t-structures, compact generation and Barr–Beck;
     - derived stacks, QCoh and IndCoh with singular support, lci;
     - (twisted) D-modules on stacks; Bun_G and LS_Ǧ;
     - the Ran space and Rep(Ǧ)_Ran;
     - the Hecke action, hence the affine Grassmannian and geometric Satake;
     - Bun_N, the exponential D-module, Poinc and coeff.
   - Stating only *that* the action factors (GLC I Thm 1.2.4) already needs Rep(Ǧ)_Ran → QCoh(LS)
     and the Hecke action [R GLC I l.1459; J].
3. **The proof shares much of its backbone with the statement.**
   - Shared with the statement: DG categories, derived stacks, IndCoh_Nilp, D-modules on Bun_G,
     the Ran space and factorization, Satake, Whittaker and Casselman–Shalika, and Poinc. II, III,
     IV and V all reuse these [R per-paper inputs; J].
   - Proof-only: IndCoh in infinite type and placidity, unital factorization categories and
     local-to-global functors, critical Kac–Moody and W-algebras, Feigin–Frenkel, opers and
     monodromy-free, Miura and generic opers, semi-infinite categories and Drinfeld
     compactifications, Wakimoto modules, rational maps, gerbes and sheaves of categories, the
     2-categorical Fourier–Mukai transform, stability of G-bundles, and étale homotopy types.
   - Proving the statement-level spectral action (rather than leaving it a sorry) needs GLC II's
     Kac–Moody and opers machinery, so that part of the proof's backbone becomes statement
     backbone [J].
   - For workflow step 2's "backbone versus surface", this suggests [J]:
     - the shared layer is backbone from the start;
     - the proof-only layer is backbone that step 6 plans;
     - each paper's main theorems are the proof's surface.
4. **Library value (ideas.md §1, "a library for geometric representation theory").**
   - The proof-only layer *is* that library: D-modules, factorization, Kac–Moody at critical
     level, opers, Satake, Whittaker, Eisenstein series.
   - It is large. II alone is 448 pp. and says it had to "refine many foundational parts" of
     Beilinson–Drinfeld, largely because it works with ∞-categories (l.858–864) [S]. The full proof plausibly needs several times the 947 pp. of
     the series once the external inputs are counted (FR, AGKRRV, AG, CR, Ra2, RY, BD1–2, FG1–3,
     Gaitsgory 2015, DG1–3, Ga4–5, Be1–2, BKS, FH) [E].
5. **Scope stays de Rham.** I's Betti/restricted sections (§§3–4) are not on the de Rham proof
   path; V says the method does not adapt to Betti or étale settings [R V l.988; J]. But V's g = 1
   case uses Riemann–Hilbert and compact real forms, which is analytic input. A de Rham-only Lean
   proof needs either a Riemann–Hilbert/Lefschetz layer or an algebraic substitute for that one
   step [J].
6. **Review (step 4).** §2.4 shows what a reviewer must check: the cross-paper citations. V v3
   cites IV numbers that IV v1 lacks, and the BKS id is wrong. A blueprint node for each imported
   result should therefore name the *version* and the *content*, not just a theorem number [J].

## 4. Conflicts

- **With `notes/ideas.md` item 5** ("I don't see the point of `references/papers/manifest.toml`"):
  §2.4 is an argument for keeping *some* version record. V v3 cites IV by numbers that match no
  public IV, and one cited arXiv id points to an unrelated paper. Without pinned versions a
  reviewer cannot say which theorem is meant. The hashes, by contrast, added nothing beyond the
  version numbers this time: every hash matched [R; J].
- **With "first the statement, then the whole proof"** (ideas.md; workflow steps 2 and 6): this is
  not a clean split (§2.3, §3.2). The Scholze note reached the same conclusion from the exposé;
  the papers confirm it with line references [R; J].
- **With the Scholze note's outline:** the order and missing steps listed in §2.5. These are
  differences of presentation and detail, not of substance [J].
- **Inside the series:** the misnumbered GLC IV citations, the wrong BKS id and the GLC III
  author lists (§2.4) [R].
- **With the decisions in `notes/workflow.md`:** none. The papers do not bear on prompts, pushing
  or automation.

## 5. Input for the open questions (`notes/workflow.md`, "Questions for after the research")

- **Whether `Abstract.lean`, `Foundations.lean` and their placeholder design are reasonable**:
  - The placeholders correspond to real objects the later papers rely on. For example V's §5.5
    uses Poinc^{Vac,glob}_{G,!}, A_G and the spectral action, and III and IV use 𝕃_G^L and Ψ. So
    the abstract's list of objects is the right one [R; J].
  - Two additions would let the proof attach to the statement later [J]:
    - a `Setting` that can be restricted to Levi subgroups, for the induction;
    - an explicit placeholder for the spectral action, kept separate from `LCoarse`.
      I quotes it, II §§15–16 and V's footnote finish its proof, and IV and V use it directly.
- **What happens to `references/papers/manifest.toml`**:
  - Keep a version record, in whatever form (§4). Its five GLC entries are correct as of
    2026-11-08 [R].
  - If it stays, worth adding: the external inputs with pinned versions (FR 2207.02955 v1,
    Gaitsgory 2015 = 1302.2506 v3, FH 2507.13930 v2, BKS 1801.00655 v2, Arinkin 1602.08989 v1,
    CR 2310.19734 v2, Lin 2211.05282 v1, Be2 2103.17211 v2, CF 2111.14606 v1, DG 2016 =
    1311.2071 v4) [R arXiv API, 2026-11-08].
  - Also worth adding a note that V v3's citations of IV do not match IV v1 [J].
- **Who reviews the mathematics, and to what standard**:
  - Fresh agents can check cross-paper citations mechanically (theorem number, version, content),
    as was done here. That catches the class of error in §2.4 [J].
  - Whether the 947 pages are *correct* is beyond such a check. An outside expert is most useful
    on the few places where the papers defer to other work: CFGY, FH, Ra4, Gaitsgory 2015 §11.1,
    and the IV revision V cites [J].
- **Where research notes live:** no bearing.
- **`AGENTS.md`, `PLAN.md`:** no direct bearing, beyond the point that the proof's top level (§2.5)
  belongs in the blueprint, not in a separate plan [J].

## 6. Questions for the owner

1. **Induction in the statement.** Should the Lean statement already be set up so that `main` can
   be assumed for proper Levi subgroups over the same curve (III–V need this)? Suggested: yes,
   decide it in step 2, since changing `Setting` later touches the pinned statement
   (`reviews/statement-pin.toml`, an owner's file).
2. **Statement-level theorems.** The spectral action (Gaitsgory 2015 + GLC II §§15–16 + possibly
   FH) and the bound to eventually coconnective objects (FR) sit inside the statement. Should they
   be listed as named, budgeted sorries of the statement phase, with these sources? Suggested:
   yes. This agrees with the Scholze note's question 3, now with exact sources.
3. **Which GLC IV.** GLC V v3 cites theorem numbers of a GLC IV revision that is on neither arXiv
   nor Gaitsgory's page. Should the project pin IV v1 and record the mismatch, or ask the authors
   for the revision? Suggested: pin v1, record the mismatch in the blueprint, and recheck arXiv
   when step 6 starts.
4. **Version record.** Given §2.4, do you still want to drop the manifest, or keep a minimal list
   of arXiv id + version for every paper cited by a blueprint node? Suggested: keep the minimal
   list; hashes are optional.
5. **Analytic input in the proof.** V's g = 1 case uses Riemann–Hilbert and compact real forms.
   Is an analytic layer acceptable in the proof (Mathlib has complex analysis), or should step 6
   look for an algebraic replacement? Suggested: decide when step 6 reaches V §3; it is one small
   case.
