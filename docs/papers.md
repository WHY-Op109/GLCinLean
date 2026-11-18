# The papers

The paper sources:

- **Find the source.** ArXiv TeX sources in `docs/references.bib` are in the git-ignored `references/papers/<id>v<version>/src/`; fetch a missing one from `https://arxiv.org/e-print/<id>v<version>` and unpack it there. Sources that exist only as PDFs use the paths in the table below; their download hashes are in the bibliography. Work from TeX, never from a plain PDF or a text extraction of it.
- **Convert a PDF.** If a source has only a PDF, convert it first with the skill `converting-math-documents` into a TeX file with a closing `thebibliography`, in `<folder>/src/`, as the sources below are. For a long source, convert only the pages that are needed, with the skill's `--page-range` option, into a file named `<pdf name>-excerpt.tex` whose first lines say which pages it holds.
- **What a converted file holds.** The unedited Mathpix output, with these additions only:
  - a line `% PDF PAGE n` at the start of each physical page of the original PDF;
  - the bibliography as a closing `thebibliography` with `\bibitem[printed label]{key}` entries, and `\cite` with the key of `docs/references.bib` for a work that is there, and a descriptive key for any other work;
  - each printed equation number `N` as `\tag{N}\label{eq:N}` on its display, with `\eqref{eq:N}` where the text refers to it (the skill's `latex-structure.py` restores the numbers from Mathpix's own line data).
- **Check against the PDF.** The Mathpix text is not corrected, so the PDF stays the authority. The `conversion-findings-*.md` files beside each TeX file record a page-by-page reading against the PDF: the places where the reader saw a difference (often accents, sub- and superscripts, script letters, arrows and garbled displays) and the errors of the PDF itself. Before quoting a formula, read the findings for that page and check the PDF. For an equation number reported as missing, check the current TeX and the PDF before you correct anything.
- **What a checker may correct.** Only the bibliography, the citations and the equation numbers and references. It reports any other difference as a finding and leaves the text as it is.
- **Text extractions.** [ConradRGS], [BDHitchin], [BDChiral] and [RaskinCPSII] are converted only in the pages named in the table. For the rest, each has a sibling `.txt` text extraction with a page marker line (`PDF PAGE n`, `PAGE n` or `=== PAGE n ===`) before each physical page. It is not checked against the PDF and is good only for finding a place.

One line per paper, to choose which one to search:

| Key | Main file | Lines | What it covers |
|---|---|---|---|
| [GLC1] | `2405.03599v3/src/functor.tex` | 4.6k | construction of `𝕃_G` (de Rham and Betti); the conjecture (Conj. 1.6.7, label `c:GLC dR`); equivalent forms of it |
| [GLC2] | `2405.03648v3/src/Loc.tex` | 39.7k | Kac–Moody localization, the FLE; the conventions for `k`, `X`, `G` (§0.4) |
| [GLC3] | `2409.07051v1/src/Eis.tex` | 27.7k | compatibility of `𝕃_G` with Eisenstein series and constant terms |
| [GLC4] | `2409.08670v1/src/ambidex.tex` | 6.4k | GLC for `GL_n`; ambidexterity of `𝕃_G` on the cuspidal part |
| [GLC5] | `2409.09856v3/src/multone.tex` | 6.8k | the multiplicity one theorem, ending the proof |
| [AGKRRV] | `2010.01906v2/src/text.tex` | 31.5k | local systems with restricted variation; nilpotent singular support; conventions GLC I cites (§0.9) |
| [ArinkinGaitsgory] | `1201.6343v4/src/singsupp.tex` | 11.8k | singular support of coherent sheaves; `IndCoh_Nilp`; the original statement of GLC |
| [IndCoh] | `1105.4857v7/src/IndCohtext.tex` | 9.4k | ind-coherent sheaves on schemes and stacks; the functor `Ψ` |
| [Crystals] | `1111.2087v4/src/Crystalstext.tex` | 4.9k | de Rham prestacks (§1), crystals (§2), D-modules (§5), gerbes and twisted crystals (§§6–7) |
| [GaitsgoryOutline] | `1302.2506v3/src/outline.tex` | 7.6k | Ran space, factorization representations, spectral localization, Satake and Hecke action (§4) |
| [CompactGeneration] | `1112.2402v8/src/DBunG.tex` | 7.3k | enhanced categories and compact generation (§1); D-modules on stacks (§2); compact generation of `Dmod(Bun_G)` (Thm. 0.1.2) |
| [DG2] | `1108.5351v3/src/Finiteness.tex` | 9.6k | QCA finiteness, compact/coherent D-modules and safety; QCA alone does not imply QCoh compact generation |
| [ConradRGS] | `ConradRGS/luminysga3.pdf`; excerpt `ConradRGS/src/luminysga3-excerpt.tex` (PDF pages 191–198, 235–236, 238–249: Def. 6.1.8 to Thm. 6.1.17, Exercise 6.5.2, §7.1) | 390 pages | pinned reductive groups, root data and classification (Theorems 6.1.16–6.1.17) |
| [MV] | `math-0401222v5/src/Satake.tex` | TeX | spherical perverse category, convolution, fusion, weight functors and Tannakian Satake; topology over C is not itself a de Rham DG enhancement |
| [GLys] | `1608.00284v7/src/text.tex` | TeX | gerbe normalization and metaplectic duality; de Rham factorization Satake in §§8–9 |
| [RaskinCPSI] | `RaskinCPSI-2018-09-05/src/cpsi.tex` (converted from `cpsi.pdf`, 73 pages) | 3.5k | coherent factorization enhancement of geometric Satake, §6, especially §6.33 |
| [RaskinCPSII] | `RaskinCPSII-2018-09-05/cpsii.pdf`; excerpt `RaskinCPSII-2018-09-05/src/cpsii-excerpt.tex` (PDF pages 68–72 and 93–99: §§9.1–9.12, Appendix A, references) | 99 pages | QCoh of the factorizable regular local systems `LocSys_Γ(𝒟)_{X^I_dR}` (the spread classifying stack) is `Rep(Γ)_{X^I_dR}` (Lemma 9.8.1, proof in Appendix A.2–A.5); passability (Cor. A.8.1) and 1-affineness (Lemma 9.9.2) |
| [DGIndschemes] | `1108.1738v8/src/IndSchemestext.tex` | TeX | formal smoothness and classical comparison for DG indschemes, used by meromorphic-connection geometry |
| [BradenDG] | `1308.3786v4/src/braden.tex` | TeX | algebraic D-module hyperbolic localization and interpolation geometry |
| [GaitsgoryDeJong] | `math-0402184v4/src/dejong.tex` | TeX | Appendix B (§7): regular Hecke object, chiral Cousin complex and factorization |
| [BDChiral] | `BDChiral-2004/cha_ch2.pdf`, `BDChiral-2004/cha_ch3.pdf`, `BDChiral-2004/cha_ch4.pdf`; excerpts in `BDChiral-2004/src/`: `cha_ch2-excerpt.tex` (pages 1–15 of the chapter file: §2.1), `cha_ch3-excerpt.tex` (pages 26–28: §§3.4.11–3.4.12), `cha_ch4-excerpt.tex` (pages 67–74: §4.6) | PDF chapters | commutative D_X-algebras; chiral Cousin complex (§§3.4.11–3.4.12); commutative chiral homology and coefficients (§4.6) |
| [BDHitchin] | `BDHitchin/QuantizationHitchin.pdf`; excerpt `BDHitchin/src/QuantizationHitchin-excerpt.tex` (PDF pages 172–183: §4.5) | 386 pages | §4.5: affine Grassmannian geometry and Schubert calculations |
| [GenVan] | `GenVan-2010-10-18/src/GenVan.tex` (converted from `GenVan.pdf`, 7 pages) | 0.4k | spectral vanishing strategy; §2.6 leaves the arbitrary-parabolic extension as an expectation |
| [GeometricConstantTerm] | `1311.2071v4/src/CT.tex` | TeX | Eisenstein adjunction, constant terms and the bounded-support theorem for cuspidal objects |
| [FactorizableDerivedSatake] | `2310.19734v2/src/satake.tex` | TeX | derived spherical Satake, factorization and monadic proof; needed by the parabolic spectral-action proof |
| [LoopGrassmannianExt] | `math0304173v3/src/abg.tex` | TeX | equivariant Ext calculation used by the derived spherical Satake monad |
| [StacksProject] | `https://stacks.math.columbia.edu/` | stable tags | tags 02O6, 02UZ and 02KH: coherent cohomology finiteness, dimension vanishing and flat base change; the corresponding Tau Ceti interfaces are already available |
| [GRQCoh] | `GRQCoh-2016-01-08/src/QCohBook.tex` (converted from `QCohBook.pdf`, 23 pages) | 1.4k | passable prestacks, tensor base change and QCoh kernel formalism, Chapter I.3 §§3.1–3.5 |
| [GeometricFeiginFrenkel] | `1106.3112v1/src/ff.tex` | TeX | geometric center/oper construction and compatibility with Satake, Theorem 1.4 |
| [OneAffineness] | `1306.4304v4/src/oneaffine.tex` | 7.3k | sheaves of categories, 1-affineness and localization for quasi-coherent module categories |
| [GaitsgoryContractibility] | `1108.1741v3/src/Contractibility.tex` | 6.2k | D-module homology on pseudo-indschemes; algebraic Ran contractibility (Theorem 1.6.5 and §6) |
| [GaitsgoryAtiyahBott] | `1505.02331v2/src/Tamagawa.tex` | 10.2k | pseudo-proper direct images, universal homological contractibility and unital Ran cofinality (§§1.5, 2.5, 4.6) |
| [OperadicKoszul] | `0709.1228v1/src/operad.tex` | 4.9k | Com–Lie operadic Koszul duality and the free-algebra contraction used by BD §4.6.2 |
| [ParabolicEisensteinFH] | `2507.13930v2/src/main.tex` | TeX | parabolic Hecke structures and Jacquet/Casselman–Shalika compatibility; supplies proofs deferred by GLC III, with a simply connected derived-group hypothesis; its Appendix A (§A.1.3) assumes G semisimple and simply connected, replaced in `SemiInfinite.parabolicIC_colimitDescription` |
| [DrinfeldCompactificationSchieder] | `1212.6814v2/src/Schieder.tex` | TeX | corrected compactifications for arbitrary reductive groups, z-extensions and torsor descent (§7) |
| [WhittakerPatternsFGV] | `math9907133v5/src/FGV.tex` | TeX | pointwise geometric Casselman–Shalika and Whittaker cleanness; introduction explicitly includes characteristic-zero D-modules |
| [GaSemiInfiniteI] | `1703.04199v6/src/Semiinf.tex` | TeX | finite Zastava/global IC comparison with its dimension shift, Proposition 3.6.5(a) |
| [ChenNearbyCycles] | `2008.09349v3/src/main.tex` | 6.1k | full parabolic stratification and compact generation of LU-invariant D-modules over finite configurations (Lemma 2.3.4, Appendices C.3 and D); source assumes simply connected derived group |
| [DhillonLysenkoRan] | `2508.01527v2/src/SI_IC_parab_Ran_v4.tex` | 6.8k | arbitrary-parabolic stratum adjunctions with diagonal base change, §§2.4 and 2.7; printed numbering differs from stale TeX labels; simply connected derived group from §2.3 |
| [GaRanII] | `1708.07205v5/src/semiinfinite.tex` | 5.9k | Borel semi-infinite Ran category, invariant-stratum adjunctions (§1.5), local–global IC comparison and finite Zastava restriction (Theorem 3.3.3, Proposition 3.8.3) |
| [HottaTakeuchiTanisaki] | not pinned | book | regular holonomic D-modules and the Riemann–Hilbert correspondence (Chapters 2–3, 6–8); used only for the comparison over C |
| [LusztigQAnalog] | not pinned | paper | parity vanishing of IC stalks on the affine Grassmannian (§11), cited through [MV] Lemma 7.1 |
| [DeligneMilne] | not pinned | paper | Tannakian criteria for finite type, connectedness and reductivity (Props. 2.20 and 2.23, Cor. 2.22), cited through [MV] §7 |
| [LurieHA] | not pinned | book | idempotent algebras and their modules (§4.8.2) |
| [JuteauMautnerWilliamson] | `0906.2994v3/src/paritysheaves_a.tex` | 4.1k | parity sheaves; even maps (Prop. 2.36); Kac–Moody flag varieties, Bott–Samelson varieties and convolution (§4.1, Thms. 4.6, 4.8); characteristic-0 parity sheaves are IC sheaves (Rem. 2.17). Numbered per section |
| [PappasRapoport] | `math-0607130v2/src/TwistedLoops08fi.tex` | 4.5k | connected components of affine flag varieties (Thm. 5.1); the simply connected cover and the neutral component (§6.1.1, stated in characteristic p); Iwahori–Weyl group (§8) |
| [BBD] | not pinned | book | the decomposition theorem (Thm. 6.2.5) |
| [Kumar] | not pinned | book | Kac–Moody flag varieties and Bott–Samelson varieties (§7.1) |

## Searching

- Search one file with `grep -n`: by label (`\label{c:GLC dR}`), by the name of a theorem, or by a symbol's TeX macro (`\BL_G`, `\LS`). Labels are named `s:`, `ss:`, `sss:` (sections), `t:`, `p:`, `c:`, `l:` (results). Cross-references read `\thmref{t:...}`, `\propref{p:...}`.
- The TeX does not contain the numbers of the compiled paper. To cite a line as AGENTS.md asks, for example [GLC1] Conj. 1.6.7, get its number with

      awk -v line=1861 -f tools/tex-locator.awk references/papers/2405.03599v3/src/functor.tex

  which prints `1.6.7`. Cite numbers, never TeX file names or line numbers.
- A file converted from a PDF has its section and theorem numbers as literal text: find a result with `grep -n 'Lemma 6.18.1'`, and an equation with `grep -n 'tag{3.2}'`. Do not use `tools/tex-locator.awk` on it.

## Errors and gaps in the sources

One line for each error or gap found in a source, and for each claim that is given up as too hard ("Plan" in `AGENTS.md`). The node says how the plan handles it.

| Source | What is wrong or missing | Node |
|---|---|---|
| [RaskinCPSI] §6.10 | The proof that the factorization functors are equivalences over the disjoint locus is one sentence ("a cofinality argument"). It interchanges a tensor product of categories with two limits, which holds for a compactly generated rigid category (Lemma 6.18.1); for another category the source has no proof. | `Ran.CollisionCategory`, `Ran.collisionCategory_tensorLimitComparison_isEquivalence` |
| [RaskinCPSI] Corollary 6.18.2 | The self-duality of the collision category is stated without proof. Dualizability follows from Lemma 6.18.1; the pairing and its perfectness do not. | `Ran.collisionCategory_tensorLimitComparison_isEquivalence` |
| [RaskinCPSII] Lemma 9.8.1, Appendix A.5 | The reduction from a general curve to the affine line is left to the reader. | `Ran.Representations.equivCollisionLimit` |
| [IndCoh] Theorem 5.6.3 | The theorem, on which the symmetric monoidal structure of the !-tensor product rests, is stated without proof. | `DModules.shriekTensor` |
| [OneAffineness] Theorem 2.6.3 | The gluing step over a finite affine open cover is left to the reader. | `Sheaves.finiteTypeScheme_deRham_oneAffine` |
