# Scholze, "Geometric Langlands [after Gaitsgory, Raskin, ...]", Séminaire Bourbaki exposé 1252

- Source: <https://www.bourbaki.fr/TEXTES/Exp1252-Scholze.pdf>. Séminaire Bourbaki, 78e année,
  2025–2026, n° 1252, dated "Mars 2026". This is the only version: there is no commit or arXiv
  version to pin, so the file is identified by its server metadata and hash: `Last-Modified: Sun, 29 Mar
  2026 13:35:17 GMT`, ETag `69c92a95-99c75`, 629 877 bytes, SHA-256
  `005682ba272266dba653fb24ec69eaf393c27ef3b8e3d93ca5c890fefb29db8f`. Its PDF metadata gives a
  creation date of 2026-03-29.
- Read in full on 2026-11-08: all 56 PDF pages (pp. 1252-01 to 1252-56, references included),
  extracted with `pdftotext`. A local copy is in `.lake/research/scholze-bourbaki/` (ignored by Git).
- Cross-checked against GLC I's TeX source (`references/papers/2405.03599v3/src/functor.tex`)
  and against `GLCinLean/Abstract.lean` and `GLCinLean/Foundations.lean`, as the repository has them
  on 2026-11-08.
- Checked 2026-11-08. Independently re-checked the same day: the PDF was downloaded again, its
  SHA-256, size, ETag and Last-Modified match the values above, and every page reference below
  was checked against a per-page `pdftotext` extraction (PDF page n carries label 1252-n). [R]
- Licence: the PDF states none [R, grep for "licen", "copyright" and "©"]. Treat it as all rights
  reserved: link to it and cite it, but copy nothing into the repository.

Page references below use the exposé's own page labels (1252-NN).

## 1. What it is

- A Séminaire Bourbaki survey by Peter Scholze of the proof of the (characteristic 0, unramified,
  global) geometric Langlands conjecture by Gaitsgory, Raskin and coauthors, and of its use over
  function fields. [R p.1–2]
- Written by someone outside the group that wrote the proof, after Gaitsgory and Raskin
  answered "many of my questions in preparing this report". [R p.11]
- Scholze calls it a survey, not a proof: "This report is barely scratching the surface, and I
  apologize for the many omissions, imprecisions, and loose ends." [R p.11] On Kac–Moody
  localisation he says he is "even more impressionistic here than in the rest of this survey".
  [R p.49]
- Contents [R p.1]: 1 Introduction (the arithmetic motivation, function fields, Thm 1.7);
  2 The equivalence; 3 Sheaves on Bun_G; 4 The stack of local systems; 5 Spectral action;
  6 The case G = G_m; 7 Beilinson's spectral projector; 8 Trace of Frobenius; 9 Whittaker
  coefficients; 10 Eisenstein series; 11 Kac–Moody localisation; 12 Cusp forms; References.
  (The computed task's list of sections leaves out §8, Trace of Frobenius.)
- Scholze recommends Ben-Zvi (2026) as a "much more vivid" survey of the proof. [R p.11]

## 2. What it says that matters for GLCinLean

### 2.1 The statement (Conjecture 2.10, p.17)

> "Conjecture 2.10 (Geometric Langlands Conjecture). — There is an equivalence of
> Dqc(LocSys_Ǧ)-linear (∞,1)-categories D(Bun_G) ≅ IndCoh_Nilp(LocSys_Ǧ)." [R p.17]

- Normalisation, stated after the conjecture: the equivalence "should send the structure sheaf
  on the right-hand side to the Whittaker sheaf on the left-hand side". [R p.17] Scholze then
  says: "if an equivalence of the desired form exists, it is uniquely determined by this
  requirement, cf. Remark 9.4 below". [R p.18] Remark 9.4 itself argues only that the lift
  𝕃_G of 𝕃^coarse_G is unique; the step from "a normalised Dqc-linear equivalence" to "it is
  𝕃_G" (its inverse composed with Ψ is the right adjoint of A ↦ A ⋆ W, and an equivalence sends
  compact objects to bounded ones) is left to the reader. [S for the uniqueness claim; J that
  this is the intended argument]
- The Whittaker sheaf is W = p_! ψ^* exp ∈ D(Bun_G). It is built from the correspondence
  Bun_G ← Bun_U^Θ → A¹ and the exponential D-module on A¹. Scholze adds that it is "also known as
  the Poincaré object". [R p.40–41] GLC I calls the same role "the vacuum Poincaré sheaf"
  `Poinc^{Vac,glob}_{G,!}`, "the image of O_{LS_Ǧ} under the would-be left adjoint 𝕃_G^L"
  (`functor.tex` l.1489–1496), and defines it as `p_! ∘ χ^*(exp)` for p : Bun_{N,ρ(ω_X)} →
  Bun_G and χ : Bun_{N,ρ(ω_X)} → 𝔾_a, with exp normalised to lie in Dmod(𝔾_a)^♥[−1]
  (`functor.tex` l.1636–1650). [R] This is the same recipe as Scholze's W (Bun_U^Θ is the
  stack of U^Θ-bundles, U^Θ twisted by 2ρ(Θ) = ρ(Ω¹_X)); Scholze fixes no shift for exp and
  works untwisted, so the two agree up to these conventions, which this note did not compare.
  [J]
- Scholze also gives a purely automorphic description: Poinc_! : Whit(G) → D(Bun_G), built by
  pull-push from the local Whittaker category, is identified (through the geometric
  Casselman–Shalika formula, Cor. 9.7) with A ↦ A ⋆ W on Dqc(*/Ǧ)_Ran. [R p.45]
- Standing setup (§2, p.11) [R]:
  - X is "a smooth projective connected curve over an algebraically closed field k";
  - a Theta characteristic Θ is fixed (Θ^{⊗2} = Ω¹_X), "needed to normalize" the equivalence;
  - G is reductive over k, with a pinning and T ⊂ B ⊂ G;
  - in the de Rham setting, k has characteristic 0 and the coefficients are e = k (p.23).
- Genus is not a hypothesis of the theorem. §4 and §6 assume g ≥ 1 only "for simplicity".
  [R p.23, p.33] (The p.23 assumption is made in the Betti discussion of §4: "For simplicity, we
  exclude the case of P1".) Footnote 19 adds that for X = P¹ "a slight modification is
  necessary" in the étale definition of LocSys. [R p.25] The final step of §12 is written "at
  least if g ≥ 2 and excluding the case g = 2 and G of type A1", and footnote 34 says "the
  cuspidal part of the other cases can easily be treated by hand". [R p.53; S that the other
  cases are easy]
- The de Rham automorphic category is the full one: "one takes the full derived category of
  D-modules D(Bun_G) on Bun_G. Notably, one does not pass to some subcategory of (ind-)holonomic
  D-modules." [R p.23] In the de Rham case the Beilinson projector is left out and "the full
  D(Bun_G)" is used (p.42). Nilpotence appears only on the spectral side (IndCoh_Nilp).
- The half twist: Scholze writes D(Bun_G) rather than GLC I's Dmod_{1/2}(Bun_G). In §11 he notes
  that the critical twist (the subscript in D(Bun_G)_crit) "actually does not change the
  category by our choice of Θ". [R p.51] GLC I says the same in its own terms: "the choice of
  ω_X^{1/2} gives rise to a square root of det_{Bun_G}" (citing Beilinson–Drinfeld), and
  det_{Bun_G} is, up to a constant line, the canonical bundle of Bun_G (`functor.tex`
  l.1320–1333). [R] That Scholze's critical twist is GLC I's half twist is [J].
- Sheaf formalism: Scholze works in the (−^*, −_!) formalism, whereas AGKRRV, and hence GLC I, use
  (−^!, −_*). He says that "as far as the geometric Langlands equivalence is concerned, the choice
  turns out not to matter", and that on Bun_G (a smooth Artin stack) the category does not depend
  on the choice. [R p.20] His aside (Remark 3.1): "I must admit that I find the
  (−^!, −_*)-formalism confusing, to the point that I cannot read the series of papers [AGKRRV
  2020a, 2020b, 2021] beyond a superficial level." [R p.20] (The formalism he finds confusing is
  AGKRRV's (−^!, −_*), not his own (−^*, −_!); an earlier version of this note had the indices the
  wrong way round.) Remark 3.3 adds that the two formalisms "mostly agree at the level of
  (∞, 1)-categories" but give "very different (∞, 2)-categories of kernels". [R p.21]
- No formulation for a general sheaf theory: "Currently, it is not known how to formulate a
  geometric Langlands equivalence for an arbitrary (reasonable) choice of cohomology theory";
  the de Rham, Betti and étale formulations "each use some special features of the given
  situation". [R p.12]
- Module structures are data: in Lurie's foundations the associativity and commutativity
  diagrams of an algebra or module "are not conditions, but extra data, that are subject to
  higher coherences" (footnote 11). [R p.13]

### 2.2 The Langlands functor (Definition 9.2, Theorem 9.3, p.42)

- The coarse Langlands functor 𝕃^coarse_G is the right adjoint of A ↦ A ⋆ P(W), where P is the
  Beilinson projector, which is omitted in the de Rham case. [R p.42] This matches GLC I, which
  defines 𝕃_{G,coarse} as the right adjoint of 𝕃^L_{G,temp}, the QCoh-linear functor determined by
  `Poinc^{Vac,glob}_{G,!}` (`functor.tex` l.1683–1722). [R]
- "Theorem 9.3 (Gaitsgory and Raskin, 2025b). — There is a unique colimit-preserving functor
  L_G : D_Nilp(Bun_G) → IndCoh_Nilp(LocSys_Ǧ) such that L^coarse_G = Ψ ∘ L_G, and such that it
  sends compact objects to objects that are eventually coconnective." [R p.42] In the de Rham
  case D_Nilp(Bun_G) here means the full D(Bun_G) (p.42: "uses the full D(Bun_G)"). This is
  GLC I Cor. 1.6.5 (`functor.tex` l.1833), which has the same two properties and the same
  uniqueness clause. [R both] Scholze's bibliography identifies "Gaitsgory and Raskin (2025b)"
  as GLC I, arXiv 2405.03599v3. [R p.55]
- Remark 9.4 explains why the functor is unique. All the functors preserve colimits. GLC I shows
  that compact objects go to eventually coconnective objects, and Ψ is an equivalence on
  eventually coconnective objects. [R p.42]
- Ψ : IndCoh_Nilp → Dqc is t-exact, and "the difference between IndCoh_Nilp and Dqc is
  ∞-connective". [R p.42] Eisenstein series are "ultimately the reason" Dqc must be replaced by
  IndCoh_Nilp: proper pushforward keeps coherent complexes but not perfect ones. [R p.48–49]

### 2.3 The spectral action is a deep theorem, not a construction (Thm 2.7, Thm 5.9)

- "In the D-module setting, the existence of the spectral action requires heavy nonformal input
  and is due to Gaitsgory (2015), relying on results on Kac–Moody localization that have only
  recently been written in [GLC II]." [R p.17]
- Theorem 5.9 (Gaitsgory 2015; Gaitsgory–Raskin 2025b) says that the action of Dqc(*/Ǧ)_Ran on
  D(Bun_G) factors over the Verdier quotient to Dqc(LocSys^dR_Ǧ). "This theorem is highly
  nontrivial." [R p.32–33] GLC I states the same thing as `t:spectral decomp`, citing
  [Ga2, Cor. 4.5.5] (`functor.tex` l.1457–1466). [R] GLC I's bibliography entry [Ga2] is
  Gaitsgory, "Outline of the proof of the Geometric Langlands Conjecture for GL(2)", Astérisque
  370 (2015) (`functor.tex` l.4514), the same paper as Scholze's "Gaitsgory (2015)" (p.55);
  arXiv 1302.2506 has that title (arXiv API, 2026-11-08). [R]
- How it is proved, in one sentence: "one shows that these two sources [Eisenstein series and
  Kac–Moody localisation] generate all of D(Bun_G), and that both sources are supported on"
  LocSys^dR. [R p.33, in the text after Remark 5.10]
- Remark 2.8: compatibility with the Hecke action "would in fact determine the spectral action
  uniquely". [R p.16]

### 2.4 Scope (Theorems 2.11, 2.12, p.18)

- Thm 2.11: in characteristic 0, GLC holds "in any of the de Rham, Betti, and étale settings".
  It is proved by the series GLC I–V (Scholze cites GLC I as 2405.03599v3 and GLC V as
  2409.09856v3, the versions in `references/papers/manifest.toml`; GLC II–IV without versions).
  [R p.17–18, p.53–55]
- Thm 2.12 (char p, from arXiv 2508.02237) gives the equivalence only for an open and closed
  substack LocSys′_Ǧ ⊂ LocSys_Ǧ, and only for p large relative to G. LocSys′ = LocSys is expected,
  and "known for G = SL_n". [R p.18]

### 2.5 Proof outline (pp.18–19, §§9–12): a ready-made top-level dependency list

The outline [R], with the papers it names. The labels (a)–(f) are added here.

- (a) **Comparing sheaf theories.** De Rham, Betti and étale are equivalent in char 0 through
  Riemann–Hilbert (GR 2025b = GLC I). Char p is handled by deformation (GR 2025a). [R p.18,
  p.55; GLC I's own Betti section compares the restricted variants "via Riemann-Hilbert",
  `functor.tex` l.2847, R] *Neither is needed for a de Rham-only formalisation.* [J]
- (b) **Spectral action** in the de Rham setting (Gaitsgory 2015 = GLC I's [Ga2]; GLC II). It
  rests on the fact that Eisenstein series and Kac–Moody localisation together generate D(Bun_G)
  (stated in the text after Rem. 5.10, not in the remark itself). [R p.32–33]
- (c) **Construction of 𝕃_G**: the Whittaker/Poincaré sheaf, the coarse functor, and the bound
  from compact to bounded below (GLC I). [R p.40–42]
- (d) **Eisenstein part**, by induction on the rank of G through proper Levi subgroups (p.18).
  It uses the second adjunction (Drinfeld–Gaitsgory 2016, Thm 10.1), the geometric
  Casselman–Shalika formula (Thm 9.6, Cor. 9.7), and the compatibility of 𝕃 with Eis and CT
  (GLC III). The Eis compatibility holds "up to twist"; the CT compatibility "uses Kac–Moody
  Localization". [R p.44–49] Scholze credits GLC II and GLC III together with the Eisenstein
  part: after them "the geometric Langlands equivalence is known on the Eisenstein part". [R
  p.52]
- (e) **Kac–Moody localisation and the fundamental local equivalence at critical level**
  (GLC II, Thm 11.4). This is the source of the Galois-to-automorphic direction and exists only
  for D-modules. [R p.18–19, p.49–51]
- (f) **Cuspidal part** [R p.52–53]:
  - left and right adjoints of 𝕃^cusp agree (ambidexterity, GLC IV);
  - conservativity of Whittaker coefficients (Færgeman–Raskin, JAMS 2025), "the most central
    input";
  - 𝕃^cusp ∘ (𝕃^cusp)^R is tensoring with a local system A_Ǧ on LocSys^irred;
  - multiplicity one: the fundamental group of LocSys^irred, a complement of codimension ≥ 2,
    local complete intersection and depth arguments, and End(Whittaker) being 1-dimensional.
    §12 does not name the paper for this step; that it is GLC V ("the multiplicity one
    theorem", p.55) is [J] from the title;
  - for classical groups, alternatively the contractibility of generic opers (Beraldo–Kazhdan–
    Schlank).
- Rem. 12.1: the argument depends on LocSys^dR having "very few global sections". [R p.53]

### 2.6 The objects the statement needs, as Scholze presents them

- Bun_G as a smooth Artin stack. [R p.12]
- D-modules on X as QCoh of Simpson's de Rham stack X_dR = X/(X ⊂ X×X)^∧. [R p.24]
- LocSys^dR_Ǧ as a derived algebraic stack over Bun_Ǧ, a local complete intersection; "everything
  has to be interpreted in the world of derived algebraic geometry". [R p.24]
- Dqc, IndCoh_Nilp (Arinkin–Gaitsgory 2015), Ψ, t-structures and eventual coconnectivity.
  [R p.17, p.42]
- Hecke stacks and the affine Grassmannian; geometric Satake (Mirković–Vilonen,
  Perv(Hck^loc_G) ≅ Rep(Ǧ)). [R p.14–15]
- The twisted Bun_U^Θ, ψ : Bun_U^Θ → A¹, and the exponential D-module. [R p.40–41]
- Foundations: "requires one to work (∞,1)-categorically throughout", resting on Lurie's
  *Higher Algebra*. [R p.13] Six-functor formalisms are cited from Heyer–Mann (2024). [R p.11]
- Dual group: Scholze argues that "arguably … the correct definition of the Langlands dual group"
  is "the Tannakian group that arises in the geometric Satake equivalence". [R p.15]

### 2.7 A fully worked case: G = G_m (§6, pp.33–35)

- Betti: D_Nilp(Pic) ≅ Dqc(LocSys^Betti_{G_m}), as a product of three explicit equivalences.
  The factor Spec(e[ε]) needs derived algebraic geometry. [R p.34]
- de Rham: LocSys^dR_{G_m} = EJ × */G_m × Spec(k[ε]), with EJ the universal vector extension of
  the Jacobian. D_qc(J_dR) ≅ D_qc(EJ) is Laumon's Cartier duality (1996). [R p.35] GLC I has the
  same case as §1.5 "The case G=T", through the enhanced Fourier–Mukai transform (`functor.tex`
  l.1746ff). [R]
- Scholze says the Betti identification is reached "at the level of pattern matching", and that
  "working a bit more carefully" the spectral action makes D_Nilp(Pic) free of rank 1. [R p.34]
  So even this case is sketched, not proved, in the exposé. [J]

## 3. What it means for GLCinLean

1. **A second, independent statement agrees with the one the abstract pins** (ideas.md
   "Link to the existing literature"; workflow step 2) [J]:
   - The objects and conditions in `Abstract.lean` match Scholze's Def. 9.2, Thm 9.3 and Conj.
     2.10: the three categories, Ψ, compact → eventually coconnective, Ψ ∘ 𝕃 ≅ 𝕃_coarse, and
     QCoh-linearity.
   - So does the hypothesis block: algebraically closed, connected, a square root of ω_X as data,
     a pinning. The `Setting` doc-string sources "algebraically closed" and "connected" from
     AGKRRV and GLC II; Scholze's §2 states both directly (p.11), which gives a second,
     plainer source for the label.
   - Scholze says "smooth projective", `Setting` says smooth and proper (`IsProper`). For a
     smooth curve over a field the two agree, but a doc-string saying so would save a reviewer
     the check. [R p.11, Abstract.lean; J]
2. **A gap: the normalisation is not in the abstract.** In `Abstract.lean`, `LCoarse` is an
   opaque placeholder. Nothing ties it to the Poincaré/Whittaker sheaf or to the spectral action.
   - Scholze (Conj. 2.10, Rem. 9.4) and GLC I (l.1489–1496, l.1720) both say that this
     normalisation is what pins the equivalence down.
   - As written, `main` says: "the unique lift of *some unspecified* QCoh-linear functor is an
     equivalence". [R Abstract.lean; J on the consequence]
   - For step 2, this suggests defining `LCoarse` as the right adjoint of A ↦ A ⋆ Poinc. The open
     placeholders would then be the spectral action (to be characterised by Hecke compatibility,
     Rem. 2.8) and `Poinc` (to be defined as p_! ψ^* exp). Neither should be opaque *functors* with
     no meaning. [J]
3. **The QCoh(LS)-module structure is missing too.** `LinFun (QCohLS S) …` says "the provisional
   interface: the monoidal structure of `A` and its actions are not yet data" [R Foundations.lean].
   Scholze stresses that in the de Rham setting this action is a theorem with "heavy nonformal
   input" (§2.3 above). He also stresses that a module structure in this setting is "not
   conditions, but extra data, that are subject to higher coherences" (p.13, footnote 11), so
   making the action real data in `LinFun` is a substantial piece of ∞-categorical algebra, not
   a small addition. [R p.13; J]
   - So the statement's own definitions rest on deep theorems: the spectral action (Gaitsgory
     2015, GLC II) and the bound from compact to bounded below (GLC I).
   - "First the statement, then the proof" (ideas.md; workflow steps 3 and 6) cannot be a clean
     split. These theorems must be budgeted sorries or inputs at the level of the statement, as
     `exists_isLanglandsFunctor` already is for GLC I's bound. [J]
4. **The doc-strings for `DmodHalf` should say "full category"**: the full DG category of
   half-twisted D-modules, with no holonomic or nilpotent restriction (p.23, p.42). Readers who
   know the étale or Betti versions might otherwise expect D_Nilp. [J]
5. **The proof plan's top layer** (workflow step 6) can follow §2.5 (a)–(f): spectral action,
   functor, Eisenstein part by induction on rank, Kac–Moody/FLE, then the cuspidal part
   (ambidexterity, Whittaker conservativity, multiplicity one). The de Rham-only scope removes (a).
   [J]
6. **Library targets** (ideas.md §"The formalisation" 1: "a library for geometric representation
   theory"). §§2–5 and 9–11 list the reusable layers, roughly in dependency order: six-functor
   formalisms, D-modules through the de Rham stack, Bun_G and Hecke stacks, the affine
   Grassmannian, geometric Satake, singular support and the nilpotent cone, derived LocSys,
   IndCoh with singular support, Whittaker categories, Eisenstein and CT functors, opers.
   - Geometric Satake (Mirković–Vilonen) and the G_m case (Laumon's Fourier–Mukai for J_dR) are
     self-contained, classical, library-sized milestones.
   - The Tau Ceti roadmap note (`notes/research/tauceti-roadmaps.md`) found these only in open
     roadmap pull requests, not on `main`: geometric Satake only ℓ-adic over finite fields
     (#1490) or over the Fargues–Fontaine curve (#1235), the loop Grassmannian over ℂ (#1056),
     and nothing on Laumon's Fourier–Mukai for J_dR. [R that note; J]
   - A de Rham-specific library is unavoidable: Scholze says no formulation of GLC is known for a
     general sheaf theory, and each formulation uses "special features" of its setting (p.12).
     A generic six-functor layer can be shared, but the statement's objects (D-modules on stacks,
     LocSys^dR, the spectral action) cannot be obtained from it alone. [R p.12; J]
7. **The G = G_m case is a natural first test** (workflow step 4, review). For a torus, the
   placeholders should specialise to Fourier–Mukai. A future check could state that 𝕃_T agrees
   with GLC I §1.5's FM^enh. That would test whether the placeholders mean what they claim. [J]
8. **The review standard** (workflow, "Who reviews the mathematics"). The exposé's author, from
   outside the group that wrote the proof, says that he could not read AGKRRV "beyond a superficial level" and is "impressionistic"
   on Kac–Moody localisation (p.20, p.49). Any outside expert check of the statement is therefore
   best aimed narrowly at the statement-level definitions: Dmod_{1/2}, LS_Ǧ, IndCoh_Nilp, Ψ,
   Poinc, the spectral action. Asking an expert to vouch for the whole proof is unrealistic. [J]

## 4. Conflicts

- **With GLC I Conj. 1.6.7: different logical form.** [R both; J on the reconciliation]
  - Scholze's Conj. 2.10 is existential: "there is an equivalence". GLC I's conjecture is about
    one named functor: "𝕃_G is an equivalence".
  - Unnormalised, Scholze's form is strictly weaker as a formal statement: another equivalence
    could witness it.
  - With his normalisation (O ↦ Whittaker) and his uniqueness claim (p.18, pointing to Rem. 9.4;
    see §2.1 for what Rem. 9.4 does and does not argue), the two say the same thing in
    substance. [S; J]
  - The abstract follows GLC I, which is the right choice for a pinned statement. Scholze's form
    could be added later as a stated corollary, not as the main statement.
- **With GLC I on the automorphic category: notational, not real.** [R p.51; J]
  - Scholze writes D(Bun_G); GLC I writes Dmod_{1/2}(Bun_G).
  - Scholze says the twist does not change the category, given Θ. The identification depends on
    Θ, and GLC I keeps the twist explicit.
  - The Lean statement should keep GLC I's twisted form; a doc-string can note the
    identification.
- **Sheaf-theoretic conventions: no effect on the statement.** Scholze uses (−^*, −_!); GLC I and
  AGKRRV use (−^!, −_*). Scholze says the difference does not matter for the equivalence (p.20).
  [R] His caveat (Remark 3.3, p.21) is that the two give different (∞, 2)-categories of kernels,
  so notions of adjointness at that level differ. [R] The statement lives at the (∞, 1) level,
  so this matters only for proof steps phrased with kernels (for example the second adjunction,
  which Scholze states "at the level of the (∞, 2)-category of kernels", p.47). [J]
- **Uniqueness in Thm 9.3 versus the abstract's uniqueness theorem.** [R; J]
  - Scholze states uniqueness among colimit-preserving functors, with no linearity.
  - `isLanglandsFunctor_unique` states it among QCoh-linear functors, up to QCoh-linear
    isomorphism. That combines GLC I Cor. 1.6.5 with the proposition `p:L and Hecke`
    (`functor.tex` l.1939), which gives a unique linear structure.
  - These are consistent, but not the same theorem. A reviewer should know that the Lean version
    is GLC I's enhanced reading.
- **With the dual-group placeholder: a design alternative, not a contradiction.** [R; J]
  - Scholze calls the Tannakian group from geometric Satake "arguably … the correct definition"
    (p.15).
  - `RootDatumDuality` follows GLC I §1.3's root-datum definition. That is right for the pinned
    statement; the Tannakian definition would make the statement depend on geometric Satake.
- **With ideas.md, "first the statement, then the whole proof".** In tension, as §3 point 3
  explains: the definitions needed to state GLC already depend on deep theorems, the spectral
  action above all. [J]
- **With the computed task's description of this source:** [R]
  - The PDF has 56 pages, not 54.
  - The normalisation O ↦ Whittaker is given in the text after Conj. 2.10, not inside it.
  - Thm 2.12 holds only on LocSys′, not on all of LocSys.
  - These are minor; nothing else conflicts.
- **No conflict found with the decisions in notes/workflow.md.** This source does not bear on
  prompts, pushing or automation.

## 5. Input for the open questions (notes/workflow.md, "Questions for after the research")

- **What goes into `AGENTS.md`.**
  - At most one line of mathematical orientation: the statement is GLC I Conj. 1.6.7 in the de
    Rham setting.
  - Scholze's exposé §§2, 9 is the plain-language companion for reading it, and GLC I's TeX is
    the authority.
  - Nothing more: AGENTS.md should stay short (workflow "Decisions"). [J]
- **Whether `PLAN.md` is needed.** The outline in §2.5 belongs in the blueprint (step 2/6), not in
  a separate plan. This source gives no reason to keep `PLAN.md`. [J]
- **Whether `Abstract.lean`, `Foundations.lean` and the placeholder design are reasonable.**
  - The shape is right: Scholze's account matches every object and condition the abstract uses
    [R/J].
  - Two changes are suggested for step 2 [J]:
    - make `LCoarse` a *definition* (the right adjoint of A ↦ A ⋆ Poinc) over placeholders for
      the spectral action and the Poincaré sheaf, so that the normalisation enters the pinned
      statement;
    - make the QCoh(LS)-action on each category real data in `LinFun`, not an unstated
      assumption.
  - Without these, the main theorem's meaning depends on an opaque functor that a reviewer cannot
    check against either source.
  - The hypotheses (algebraically closed, connected, no genus condition) are confirmed by a
    second source. [R p.11, p.18, p.53]
- **What happens to `references/papers/manifest.toml`.**
  - Scholze cites GLC I v3 and GLC V v3, the versions the manifest pins; he cites GLC II–IV
    without a version (the manifest pins II v3, III v1, IV v1). [R p.53–55, manifest.toml]
  - He also names statement-level dependencies that the manifest does not list (it lists
    GLC I–V and AGKRRV 2010.01906 only) [R manifest.toml, 2026-11-08]:
    - Arinkin–Gaitsgory 2015 (arXiv 1201.6343), which defines IndCoh_Nilp. A local copy
      `references/papers/1201.6343v4/` exists (fetched 2026-11-08 during this research step),
      but it has no manifest entry; an earlier version of this note said the folder lacked it;
    - Gaitsgory 2015 (arXiv 1302.2506, GLC I's [Ga2]), the spectral action; not local;
    - Færgeman–Raskin 2025 (arXiv 2207.02955); not local;
    - Drinfeld–Gaitsgory 2016 (arXiv 1311.2071); not local.
    (arXiv ids and titles checked against the arXiv API on 2026-11-08. [R])
  - Whatever replaces the manifest (ideas.md item 5 prefers plain local TeX files), the first two
    are needed for step 2. [J]
- **Who reviews the mathematics, and to what standard.**
  - See §3 point 8. Fresh agents can check each definition against GLC I's TeX, with Scholze's
    exposé as a second reading.
  - An outside expert, if one is found, is best asked about the narrow list of statement-level
    objects.
  - The G = G_m case gives a cheap test of meaning that does not need an expert. [J]
- **Where research notes live.** No bearing.

## 6. Questions for the owner

1. **Normalisation in the pinned statement.** Should step 2 make `LCoarse` a definition, built
   from a spectral-action placeholder and a Poincaré-sheaf placeholder, instead of an opaque
   functor? (Suggested: yes. Otherwise the pinned theorem does not say *which* equivalence, which
   is the point both GLC I and Scholze stress.) Changing the main statement touches
   `reviews/statement-pin.toml`, which is the owner's file.
2. **Scope.** Do you confirm de Rham, characteristic 0 only? Then Betti, étale (Thm 2.11) and
   char p (Thm 2.12) are out of scope, and so is proof step (a), the comparison of sheaf theories.
   (Suggested: yes.)
3. **Deep theorems inside the statement.** The spectral action and GLC I's bound from compact to
   bounded below are needed just to *define* 𝕃_G. Should they count as budgeted sorries of the
   statement phase (as `exists_isLanglandsFunctor` already does), or should the statement wait
   until they are proved? (Suggested: budgeted sorries, listed explicitly, so that "statement
   done" has a clear meaning.)
4. **A plain-language reference.** Should Scholze's exposé be the cited plain-language reference
   in the abstract's module doc-string and in the blueprint, next to GLC I? The PDF states no
   licence, so it is best treated as all rights reserved: link it, don't copy it. (Suggested:
   yes, cite and link it.) Scholze himself recommends a second, "much more vivid" survey,
   Ben-Zvi, "What is the geometric Langlands correspondence about?", AMS Current Events
   Bulletin (2026), pp. 4–36 (p.11, p.54); it was not read for this note and has no research
   note of its own. [R for the citation only]
