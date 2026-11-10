# The papers

ArXiv TeX sources in `docs/references.bib` are in the git-ignored
`references/papers/<id>v<version>/src/`; a missing one is fetched from
`https://arxiv.org/e-print/<id>v<version>` and unpacked there. PDF-only author notes use the explicit paths below; their download hashes are in the bibliography.
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
| [ConradRGS] | `ConradRGS/luminysga3.pdf` | 390 pages | pinned reductive groups, root data and classification (Theorems 6.1.16–6.1.17) |
| [MV] | `math-0401222v5/src/Satake.tex` | TeX | spherical perverse category, convolution, fusion, weight functors and Tannakian Satake; topology over C is not itself a de Rham DG enhancement |
| [GLys] | `1608.00284v7/src/text.tex` | TeX | gerbe normalization and metaplectic duality; de Rham factorization Satake in §§8–9 |
| [RaskinCPSI] | `RaskinCPSI-2018-09-05/cpsi.pdf` | PDF | coherent factorization enhancement of geometric Satake, §6, especially §6.33 |
| [DGIndschemes] | `1108.1738v8/src/IndSchemestext.tex` | TeX | formal smoothness and classical comparison for DG indschemes, used by meromorphic-connection geometry |
| [BradenDG] | `1308.3786v4/src/braden.tex` | TeX | algebraic D-module hyperbolic localization and interpolation geometry |
| [GaitsgoryDeJong] | `math-0402184v4/src/dejong.tex` | TeX | Appendix B (§7): regular Hecke object, chiral Cousin complex and factorization |
| [BDChiral] | `BDChiral-2004/cha_ch2.pdf`, `BDChiral-2004/cha_ch3.pdf`, `BDChiral-2004/cha_ch4.pdf` | PDF chapters | commutative D_X-algebras; chiral Cousin complex (§§3.4.11–3.4.12); commutative chiral homology and coefficients (§4.6) |
| [BDHitchin] | `BDHitchin/QuantizationHitchin.pdf` | 386 pages | §4.5: affine Grassmannian geometry and Schubert calculations |
| [GenVan] | `GenVan-2010-10-18/GenVan.pdf` | PDF notes | spectral vanishing strategy; §2.6 leaves the arbitrary-parabolic extension as an expectation |
| [GeometricConstantTerm] | `1311.2071v4/src/CT.tex` | TeX | Eisenstein adjunction, constant terms and the bounded-support theorem for cuspidal objects |
| [FactorizableDerivedSatake] | `2310.19734v2/src/satake.tex` | TeX | derived spherical Satake, factorization and monadic proof; needed by the parabolic spectral-action proof |
| [LoopGrassmannianExt] | `math0304173v3/src/abg.tex` | TeX | equivariant Ext calculation used by the derived spherical Satake monad |
| [StacksProject] | `https://stacks.math.columbia.edu/` | stable tags | tags 02O6, 02UZ and 02KH: coherent cohomology finiteness, dimension vanishing and flat base change; the corresponding Tau Ceti interfaces are already available |
| [GRQCoh] | `GRQCoh-2016-01-08/QCohBook.pdf` | 23 pages | passable prestacks, tensor base change and QCoh kernel formalism, Chapter I.3 §§3.1–3.5 |
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

- Search one file with `grep -n`: by label (`\label{c:GLC dR}`), by the name of a theorem, or by a
  symbol's TeX macro (`\BL_G`, `\LS`). Labels are named `s:`, `ss:`, `sss:` (sections),
  `t:`, `p:`, `c:`, `l:` (results). Cross-references read `\thmref{t:...}`, `\propref{p:...}`.
- The TeX does not contain the numbers of the compiled paper. To cite a line as AGENTS.md asks,
  for example [GLC1] Conj. 1.6.7, get its number with

      awk -v line=1861 -f tools/tex-locator.awk references/papers/2405.03599v3/src/functor.tex

  which prints `1.6.7`. Cite numbers, never TeX file names or line numbers.
