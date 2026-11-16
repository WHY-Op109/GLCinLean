# Citation keys of the sources

One work has many keys: each paper in `references/papers/` cites it under its own key. This table gives one canonical key per work, and the key that each source uses for it. It covers 37 sources: the 34 arXiv TeX sources, and the three files converted from PDF ([RaskinCPSI], [GenVan], [GRQCoh]; named `raskin`, `genvan`, `grqcoh` below). The arXiv sources are never edited, so they keep their own keys; the converted files use the canonical keys. `docs/references.bib` gives the fixed keys of the project. The full data, with every single-source work, is in the git-ignored `references/papers/reference-keys.json`. Made on 2026-11-16.

## Counts

- Sources: 37.
- Bibliography entries: 1193 (1117 printed entries, and 76 entries that are only in a `.bib` file and are not cited).
- Works: 605 identified works, of which 167 are cited by two or more sources and 7 are in `docs/references.bib` only. 12 more entries are under "Unsure".
- Canonical keys: 47 from `docs/references.bib` (all 47 keys of that file); 418 are a key that a source already uses; 140 are new descriptive keys.
- Check, run when the table was made: a script finds every `\bibitem` and every `.bib` entry again with its own search and compares them with the JSON. It also checks that no canonical key is used for two works and that each key of `docs/references.bib` is the canonical key of its work. The result is OK.

## How the canonical key was chosen

1. A work in `docs/references.bib` gets that key (`key_source: references.bib`).
2. Otherwise the key that the most sources use for this work, if no other work uses that key in any source (`present`). If that key is not free, an existing descriptive key of the work (UpperCamelCase, as in the converted files) is taken when it is free.
3. Otherwise a new key: surnames of the authors and the first words of the title (`new`), or a key chosen by hand (`chosen`).

Keys with spaces or TeX in them are never canonical. Canonical keys are unique without regard to upper and lower case, because BibTeX does not distinguish case. Each work that is not in `docs/references.bib` also has a field `descriptive_alternative` in the JSON. Use it if a descriptive key is preferred to a short key such as `BG1` or `Ra4`.

## Works cited by two or more sources

| Canonical key | Work | Present keys (source: key) |
|---|---|---|
| `LurieHTT` | Lurie, *Higher topos theory* | 1105.4857v7: `Lu0`; 1106.3112v1: `htt`; 1108.1738v8: `Lu0`; 1108.1741v3: `Lu0`; 1108.5351v3: `Lu1`; 1111.2087v4: `Lu0`; 1112.2402v8: `Lu1`; 1201.6343v4: `Lu0`; 1302.2506v3: `Lu`; 1306.4304v4: `Lu1`; 1308.3786v4: `Lur`; 1311.2071v4: `Lur`; 1505.02331v2: `Lu1`; 1608.00284v7: `Lu1`; 1703.04199v6: `Lu`; 1708.07205v5: `Lu1`; 2008.09349v3: `HTT`; 2010.01906v2: `Lu1`; 2310.19734v2: `htt`; 2405.03648v3: `Lu1`; 2507.13930v2: `lurie2009higher`; 2508.01527v2: `HTT`; raskin: `LurieHTT` |
| `BDHitchin` (references.bib) | Beilinson, Drinfeld, *Quantization of Hitchin's integrable system and Hecke eigensheaves* | 1106.3112v1: `bd`; 1108.1738v8: `BD`; 1108.1741v3: `BD2`; 1302.2506v3: `BD2`; 1306.4304v4: `BD`; 1608.00284v7: `BD2`; 2010.01906v2: `BD2`; 2405.03599v3: `BD`; 2405.03648v3: `BD1`; 2409.07051v1: `BD1`; 2409.08670v1: `BD1`; 2409.09856v3: `BD`; 2507.13930v2: `beilinson1991quantization`; genvan: `BDHitchin`; math-0401222v5: `BD`; math-0607130v2: `B-D`; math0304173v3: `BeDr` |
| `LurieHA` (references.bib) | Lurie, *Higher Algebra* | 1106.3112v1: `higheralgebra`; 1108.1741v3: `Lu1`; 1108.5351v3: `Lu2`; 1111.2087v4: `Lu2`; 1112.2402v8: `Lu2`; 1201.6343v4: `Lu1`; 1306.4304v4: `Lu2`; 1505.02331v2: `Lu2`; 1608.00284v7: `Lu2`; 1708.07205v5: `Lu2`; 2008.09349v3: `HA`; 2010.01906v2: `Lu2`; 2310.19734v2: `higheralgebra`; 2405.03648v3: `Lu2`; 2507.13930v2: `lurie2017higher`; 2508.01527v2: `HA`; raskin: `LurieHA` |
| `CompactGeneration` (references.bib) | Drinfeld, Gaitsgory, *Compact generation of the category of D-modules on the stack of G-bundles on a curve* | 1105.4857v7: `DrGa2`; 1108.1741v3: `DrGa1`; 1112.2402v8: `old_version`; 1201.6343v4: `DrGa1`; 1212.6814v2: `CompactGenerationBunG`; 1302.2506v3: `DrGa2`; 1308.3786v4: `DrGa2`; 1311.2071v4: `DrGa2`; 1505.02331v2: `DrGa`; 2008.09349v3: `drinfeld2015compact`; 2010.01906v2: `DrGa2`; 2405.03599v3: `DG1`; 2405.03648v3: `DrGa2`; 2409.07051v1: `DG2`; 2409.08670v1: `DG`; 2409.09856v3: `DG` |
| `DG2` (references.bib) | Drinfeld, Gaitsgory, *On some finiteness questions for algebraic stacks* | 1105.4857v7: `DrGa1`; 1108.1741v3: `DrGa0`; 1112.2402v8: `finiteness`; 1201.6343v4: `DrGa0`; 1302.2506v3: `DrGa1`; 1306.4304v4: `DrGa`; 1308.3786v4: `DrGa1`; 1311.2071v4: `DrGa1`; 1608.00284v7: `DrGa`; 2008.09349v3: `drinfeld2013some`; 2010.01906v2: `DrGa1`; 2405.03599v3: `DG2`; 2405.03648v3: `DrGa1`; 2409.07051v1: `DG1`; 2507.13930v2: `drinfeld2013some` |
| `ArinkinGaitsgory` (references.bib) | Arinkin, Gaitsgory, *Singular support of coherent sheaves, and the geometric Langlands conjecture* | 1105.4857v7: `AG`; 1108.5351v3: `AG`; 1302.2506v3: `AG`; 1306.4304v4: `AG`; 1311.2071v4: `AG`; 1608.00284v7: `AG`; 2008.09349v3: `arinkin2015singular`; 2010.01906v2: `AG`; 2310.19734v2: `arinkin-gaitsgory`; 2405.03599v3: `AG`; 2405.03648v3: `AG`; 2409.07051v1: `AG`; 2409.09856v3: `AG`; 2507.13930v2: `arinkin2015singular` |
| `BDChiral` (references.bib) | Beilinson, Drinfeld, *Chiral Algebras* | 1106.3112v1: `chiral`; 1108.1741v3: `BD1`; 1302.2506v3: `BD1`; 1505.02331v2: `BD`; 1608.00284v7: `BD1`; 2010.01906v2: `BD1`; 2405.03648v3: `BD2`; 2409.07051v1: `BD2`; 2409.08670v1: `BD2`; 2508.01527v2: `BD_chiral`; math-0402184v4: `CHA`; raskin: `BDChiral` |
| `Crystals` (references.bib) | Gaitsgory, Rozenblyum, *Crystals and D-modules* | 1105.4857v7: `GR2`; 1108.1741v3: `Crystals`; 1108.5351v3: `GR1`; 1112.2402v8: `Crys`; 1201.6343v4: `Crys`; 1302.2506v3: `GR`; 1306.4304v4: `Crys`; 1608.00284v7: `GR1`; 2405.03599v3: `GaRo2`; 2405.03648v3: `GaRo2`; 2409.08670v1: `GaRo1`; 2507.13930v2: `gaitsgory2011crystals` |
| `IndCoh` (references.bib) | Gaitsgory, *Ind-coherent sheaves* | 1108.1738v8: `IndCoh`; 1108.1741v3: `IndCoh`; 1108.5351v3: `IndCoh`; 1111.2087v4: `IndCoh`; 1112.2402v8: `IndCoh`; 1201.6343v4: `IndCoh`; 1302.2506v3: `Ga3`; 1306.4304v4: `IndCoh`; 2010.01906v2: `Ga4`; 2310.19734v2: `indcoh`; 2405.03648v3: `Ga7`; 2507.13930v2: `gaitsgory2011ind` |
| `BG1` | Braverman, Gaitsgory, *Geometric Eisenstein series* | 1112.2402v8: `BG`; 1212.6814v2: `GeometricEisenstein`; 1311.2071v4: `BG`; 1708.07205v5: `BG1`; 2008.09349v3: `braverman2002geometric`; 2409.07051v1: `BG1`; 2507.13930v2: `braverman1999geometric`; 2508.01527v2: `BG`; genvan: `BG1`; math9907133v5: `BG1`; raskin: `BG1` |
| `GaitsgoryGeneralitiesDG` | Gaitsgory, *Generalities on DG categories (Notes on Geometric Langlands)* | 1105.4857v7: `DG`; 1108.1738v8: `DG`; 1108.1741v3: `DG`; 1108.5351v3: `DG`; 1111.2087v4: `DG`; 1112.2402v8: `DG`; 1201.6343v4: `DG`; 1302.2506v3: `DG`; 1306.4304v4: `DGCat`; 1505.02331v2: `GL:DG`; raskin: `GaitsgoryGeneralitiesDG` |
| `BG2` | Braverman, Gaitsgory, *Deformations of Local Systems and Eisenstein Series* | 1302.2506v3: `BG`; 1703.04199v6: `BG`; 1708.07205v5: `BG2`; 2008.09349v3: `braverman2006deformations`; 2310.19734v2: `bg-deformations`; 2409.07051v1: `BG2`; 2409.08670v1: `BG`; 2507.13930v2: `braverman2006deformations`; genvan: `BG2`; raskin: `BG2` |
| `DGIndschemes` (references.bib) | Gaitsgory, Rozenblyum, *DG indschemes* | 1105.4857v7: `GR1`; 1108.1741v3: `IndSch`; 1111.2087v4: `IndSch`; 1201.6343v4: `IndSch`; 1306.4304v4: `IndSch`; 1311.2071v4: `GR`; 2008.09349v3: `gaitsgory2014dg`; 2010.01906v2: `GR3`; 2405.03599v3: `GaRo1`; 2405.03648v3: `GaRo1` |
| `GaitsgoryOutline` (references.bib) | Gaitsgory, *Outline of the proof of the geometric Langlands conjecture for GL(2)* | 1608.00284v7: `Ga5`; 1708.07205v5: `Ga3`; 2008.09349v3: `gaitsgory2015outline`; 2010.01906v2: `Ga5`, `Ga7`; 2310.19734v2: `dennis-laumonconf`; 2405.03599v3: `Ga2`; 2405.03648v3: `Ga1`; 2409.07051v1: `Ga1`; 2409.09856v3: `Ga4`; 2507.13930v2: `gaitsgory2013outline` |
| `MV` (references.bib) | Mirkovic, Vilonen, *Geometric Langlands duality and representations of algebraic groups over commutative rings* | 0906.2994v3: `MV`; 1106.3112v1: `mirkovic-vilonen`; 1108.1741v3: `MV`; 1201.6343v4: `MV`; 1302.2506v3: `MV`; 1308.3786v4: `MV`; 2507.13930v2: `mirkovic2007geometric`; 2508.01527v2: `MV`; math-0402184v4: `MV`; raskin: `MV` |
| `OneAffineness` (references.bib) | Gaitsgory, *Sheaves of categories and the notion of 1-affineness* | 1201.6343v4: `GA`; 1608.00284v7: `Ga1`; 2008.09349v3: `gaitsgory2015sheaves`; 2010.01906v2: `Ga2`; 2310.19734v2: `G3`; 2405.03648v3: `Ga5`; 2409.08670v1: `Ga3`; 2409.09856v3: `Ga3`; 2508.01527v2: `Ga1`; raskin: `OneAffineness` |
| `FrancisGaitsgoryChiralKoszul` | Francis, Gaitsgory, *Chiral Koszul duality* | 1105.4857v7: `FG`; 1108.1741v3: `FrGa`; 1108.5351v3: `FG`; 1201.6343v4: `FG`; 1505.02331v2: `FG`; 2310.19734v2: `FG`; 2405.03648v3: `FraG`; 2508.01527v2: `FG`; raskin: `FrancisGaitsgoryChiralKoszul` |
| `GaRo3` | Gaitsgory, Rozenblyum, *A study in derived algebraic geometry, Volume I: Correspondences and duality* | 1608.00284v7: `GR2`; 1708.07205v5: `GR`; 2008.09349v3: `GR-DAG1`; 2010.01906v2: `GR1`; 2310.19734v2: `gr-i`; 2405.03648v3: `GaRo3`; 2409.07051v1: `GaRo3`; 2409.08670v1: `GaRo2`; 2507.13930v2: `gaitsgory2019study` |
| `Stacks` | Gaitsgory, *Stacks (Notes on Geometric Langlands)* | 1105.4857v7: `Stacks`; 1108.1738v8: `Stacks`; 1108.1741v3: `Stacks`; 1108.5351v3: `Stacks`; 1111.2087v4: `Stacks`; 1112.2402v8: `Stacks`; 1201.6343v4: `Stacks`; 1302.2506v3: `Stacks`; 1306.4304v4: `Stacks` |
| `BFGM` | Braverman, Finkelberg, Gaitsgory, Mirkovic, *Intersection cohomology of Drinfeld's compactifications* | 1212.6814v2: `ICofDrinfeldCompactifications`; 1703.04199v6: `BFGM`; 1708.07205v5: `BFGM`; 2008.09349v3: `braverman2002intersection`; 2409.07051v1: `BFGM`; 2507.13930v2: `braverman2002intersection`; 2508.01527v2: `BFGM`; raskin: `BFGM` |
| `GaitsgoryRozenblyumDAG` | Gaitsgory, Rozenblyum, *A study in derived algebraic geometry (whole book, including the preliminary versions)* | 1105.4857v7: `GR3`; 1108.1738v8: `GR`; 1108.5351v3: `GR2`; 1111.2087v4: `Funct`; 1201.6343v4: `Algebroids`; 1703.04199v6: `GR`; 2508.01527v2: `G`; raskin: `GaitsgoryRozenblyum` |
| `GaitsgoryStrangeFunctionalEquation` | Gaitsgory, *A “strange” functional equation for eisenstein series and miraculous duality on the moduli stack of bundles* | 1112.2402v8: `self-duality`; 1311.2071v4: `Ga`; 2008.09349v3: `gaitsgory2017strange`; 2405.03599v3: `Ga1`; 2405.03648v3: `Ga3`; 2409.07051v1: `Ga3`; 2409.08670v1: `Ga1`; 2409.09856v3: `Ga1` |
| `QCoh` | Gaitsgory, *Quasi-coherent sheaves on stacks (Notes on Geometric Langlands)* | 1105.4857v7: `QCoh`; 1108.1738v8: `QCoh`; 1108.1741v3: `QCoh`; 1108.5351v3: `QCoh`; 1111.2087v4: `QCoh`; 1201.6343v4: `QCoh`; 1302.2506v3: `QCoh`; 1306.4304v4: `QCoh` |
| `Ra4` | Raskin, *Chiral principal series categories II: the factorizable Whittaker category* | 1703.04199v6: `Ras`; 2008.09349v3: `raskin2016chiral`; 2310.19734v2: `R3`; 2405.03648v3: `Ra4`; 2409.07051v1: `Ra4`; 2507.13930v2: `raskin2018chiralII`; 2508.01527v2: `Ras2`; raskin: `RaskinCPSII` |
| `AGKRRV` (references.bib) | Arinkin et al., *The stack of local systems with restricted variation and geometric Langlands theory with nilpotent singular support* | 2405.03599v3: `AGKRRV`; 2405.03648v3: `AGKRRV`; 2409.07051v1: `AGKRRV`; 2409.08670v1: `AGKRRV1`; 2409.09856v3: `AGKRRV`; 2507.13930v2: `arinkin2020stack`; 2508.01527v2: `AGKRRV` |
| `FR` | Faergeman, Raskin, *Non-vanishing of geometric Whittaker coefficients for reductive groups* | 2310.19734v2: `coeffs`; 2405.03599v3: `FR`; 2405.03648v3: `FR`; 2409.07051v1: `FR`; 2409.08670v1: `FR`; 2409.09856v3: `FR`; 2507.13930v2: `faergeman2022non` |
| `GaitsgoryAtiyahBott` (references.bib) | Gaitsgory, *The Atiyah-Bott formula for the cohomology of the moduli space of bundles on a curve* | 1608.00284v7: `Ga2`, `Ga7`; 1708.07205v5: `Ga2`; 2310.19734v2: `atiyah-bott`; 2405.03648v3: `Ga4`; 2409.08670v1: `Ga4`; 2409.09856v3: `Ga2`; 2508.01527v2: `G3` |
| `raskin2015chiral` | Raskin, *Chiral categories* | 1608.00284v7: `Ras1`; 2008.09349v3: `raskin2015chiral`; 2310.19734v2: `R1`; 2405.03648v3: `Ra6`; 2507.13930v2: `raskin2015chiral`; 2508.01527v2: `R`; raskin: `RaskinChiralCategories` |
| `ArkhipovBezrukavnikovPerverseSheaves` | Arkhipov, Bezrukavnikov, *Perverse sheaves on affine flags and Langlands dual group* | 2008.09349v3: `arkhipov2009perverse`; 2310.19734v2: `AB`; 2409.07051v1: `AB`; 2507.13930v2: `arkhipov2009perverse`; math0304173v3: `AB`; raskin: `AB` |
| `BBD` (references.bib) | Beilinson, Bernstein, Deligne, *Faisceaux pervers* | 0906.2994v3: `BBD`; 2508.01527v2: `Asterisque100`; math-0401222v5: `BBD`; math-0402184v4: `BBD`; math0304173v3: `BBD`; raskin: `BBD` |
| `BeraldoGeometricRamanujan` | Beraldo, *On the geometric Ramanujan conjecture* | 2310.19734v2: `dario-ramanujan`; 2405.03599v3: `Be1`; 2405.03648v3: `Be2`; 2409.08670v1: `Be2`; 2409.09856v3: `Be2`; 2507.13930v2: `beraldo2021geometric` |
| `BFN` | BenZvi, Francis, Nadler, *Integral transforms and Drinfeld centers in derived algebraic geometry* | 1105.4857v7: `BFN`; 1108.5351v3: `BFN`; 1112.2402v8: `BFN`; 1201.6343v4: `BFN`; 1306.4304v4: `BFN`; 2310.19734v2: `bzfn` |
| `BradenDG` (references.bib) | Drinfeld, Gaitsgory, *On a theorem of Braden* | 1311.2071v4: `DrGa3`; 1708.07205v5: `DrGa`; 2008.09349v3: `drinfeld2014theorem`; 2010.01906v2: `DrGa3`; 2508.01527v2: `DG1`; raskin: `BradenDG` |
| `BradenHyperbolicLocalization` | Braden, *Hyperbolic localization of intersection cohomology* | 1112.2402v8: `Br`; 1308.3786v4: `Br`; 1311.2071v4: `Br`; 1703.04199v6: `Bra`; 2008.09349v3: `braden2003hyperbolic`; math-0401222v5: `Br` |
| `ChenNearbyCycles` (references.bib) | Chen, *Nearby cycles on Drinfeld-Gaitsgory-Vinberg Interpolation Grassmannian and long intertwining functor* | 2008.09349v3: `nearby-unit`; 2310.19734v2: `lin-nearby`; 2405.03648v3: `Ch1`; 2409.07051v1: `Ch1`; 2507.13930v2: `chen2023nearby`; 2508.01527v2: `Chen` |
| `DS` | Drinfeld, Simpson, *b -structures on g -bundles and local triviality* | 1108.1741v3: `DS`; 1608.00284v7: `DrSi`; 1708.07205v5: `DS`; 2008.09349v3: `drinfeld1995b`; 2010.01906v2: `DS`; 2508.01527v2: `DS` |
| `FrenkelGaitsgoryAffineFlag` | Frenkel, Gaitsgory, *D-modules on the affine flag variety and representations of affine Kac-Moody algebras* | 1105.4857v7: `FrenGa`; 1302.2506v3: `FG2`; 2405.03648v3: `FG6`; 2409.07051v1: `FG2`; 2507.13930v2: `frenkel2009d`; raskin: `FrenkelGaitsgoryAffineFlag` |
| `GaitsgoryLocalGlobalWhittaker` | Gaitsgory, *The local and global versions of the whittaker category* | 1708.07205v5: `Ga5`; 2008.09349v3: `gaitsgory2018local`; 2010.01906v2: `Ga6`; 2405.03648v3: `Ga6`; 2409.07051v1: `Ga6`; 2508.01527v2: `GaLocWhit` |
| `GaRanII` (references.bib) | Gaitsgory, *The semi-infinite intersection cohomology sheaf-II: the Ran space version* | 1703.04199v6: `Ga1`; 2008.09349v3: `gaitsgory2017semi`; 2310.19734v2: `G2`; 2409.07051v1: `Ga5`; 2507.13930v2: `gaitsgory2021semi`; 2508.01527v2: `Gai19Ran` |
| `GaRo4` | Gaitsgory, Rozenblyum, *A study in derived algebraic geometry, Volume II: Deformations, Lie theory and formal geometry* | 2008.09349v3: `GR-DAG2`; 2010.01906v2: `GR2`; 2310.19734v2: `gr-ii`; 2405.03648v3: `GaRo4`; 2409.07051v1: `GaRo4`; 2507.13930v2: `gaitsgory2017study` |
| `GaSemiInfiniteI` (references.bib) | Gaitsgory, *The semi-infinite intersection cohomology sheaf* | 1708.07205v5: `Ga1`; 2008.09349v3: `gaitsgory2018semi`; 2310.19734v2: `G1`; 2409.07051v1: `Ga4`; 2507.13930v2: `gaitsgory2018semi`; 2508.01527v2: `Gai19SI` |
| `GeometricConstantTerm` (references.bib) | Drinfeld, Gaitsgory, *Geometric constant term functor(s)* | 1112.2402v8: `CT`; 1201.6343v4: `DrGa2`; 1302.2506v3: `DrGa3`; 1308.3786v4: `DrGa3`; 2008.09349v3: `drinfeld2016geometric`; 2409.07051v1: `DG3` |
| `RaskinCPSI` (references.bib) | Raskin, *Chiral principal series categories I: finite dimensional calculations* | 1608.00284v7: `Ras2`; 2310.19734v2: `R2`; 2405.03648v3: `Ra3`; 2409.07051v1: `Ra3`; 2409.09856v3: `Ras`; 2507.13930v2: `raskin2021chiral` |
| `WhittakerPatternsFGV` (references.bib) | Frenkel, Gaitsgory, Vilonen, *Whittaker patterns in the geometry of moduli spaces of bundles on curves* | 1302.2506v3: `FGV1`; 1708.07205v5: `FGV`; 2310.19734v2: `fgv`; 2405.03648v3: `FGV`; 2507.13930v2: `frenkel2001whittaker`; raskin: `WhittakerPatternsFGV` |
| `Bar` | Barlev, *D-modules on spaces of rational maps* | 1302.2506v3: `Bar`; 1708.07205v5: `Bar`; 2008.09349v3: `barlev2014d`; 2409.07051v1: `Bar`; 2507.13930v2: `barlev2012d` |
| `DrinfeldTwoDimensional` | Drinfeld, *Two-dimensional l-adic representations of the fundamental group of a curve over a finite field and automorphic forms on GL(2)* | 1302.2506v3: `Dr`; 2010.01906v2: `Dri`; 2405.03648v3: `Dr`; 2409.07051v1: `Dr`; math9907133v5: `Dr` |
| `FrenkelGaitsgoryLocalLanglands` | Frenkel, Gaitsgory, *Local geometric Langlands correspondence and affine Kac-Moody algebras* | 1106.3112v1: `fg2`; 1302.2506v3: `FG3`; 2405.03648v3: `FG4`; 2507.13930v2: `frenkel2006local`; raskin: `FrenkelGaitsgoryLocalLanglands` |
| `gaitsgory1999construction` | Gaitsgory, *Construction of central elements in the affine Hecke algebra via nearby cycles* | 2008.09349v3: `gaitsgory2001construction`; 2507.13930v2: `gaitsgory1999construction`; math-0402184v4: `Ga1`; math-0607130v2: `G`; math0304173v3: `Ga` |
| `GaitsgoryContractibility` (references.bib) | Gaitsgory, *Contractibility of the space of rational maps* | 1302.2506v3: `Ga2`; 1608.00284v7: `Ga3`; 1708.07205v5: `Ga4`; 2409.09856v3: `Ga5`; 2507.13930v2: `gaitsgory2011contractibility` |
| `GaitsgoryVanishingConjecture` | Gaitsgory, *On a vanishing conjecture appearing in the geometric Langlands correspondence* | 1302.2506v3: `Ga1`; 2010.01906v2: `Ga1`; 2409.08670v1: `Ga2`; genvan: `GaitsgoryVanishingConjecture`; math-0402184v4: `Ga` |
| `GLys` (references.bib) | Gaitsgory, Lysenko, *Parameters and duality for the metaplectic geometric Langlands theory* | 2405.03599v3: `GLys`; 2405.03648v3: `GLys`; 2409.07051v1: `GLys`; 2409.09856v3: `GLys`; 2508.01527v2: `GLys` |
| `KashiwaraSchapiraSheavesManifolds` | Kashiwara, Schapira, *Sheaves on manifolds* | 0709.1228v1: `KS`; 0906.2994v3: `KS1`; 2010.01906v2: `KS`; 2405.03599v3: `KS`; math-0401222v5: `KS` |
| `La1` | Laumon, *Correspondance de Langlands géométrique pour les corps de fonctions* | 1302.2506v3: `Lau1`; 2010.01906v2: `laumon`; 2405.03599v3: `L`; 2409.07051v1: `Laum`; math9907133v5: `La1` |
| `Lin` | Lin, *Poincaré series and miraculous duality* | 2405.03599v3: `Lin`; 2405.03648v3: `Lin`; 2409.07051v1: `Lin`; 2409.08670v1: `Lin`; 2507.13930v2: `lin2023poincare` |
| `ABBGM` | Arkhipov et al., *Modules over the small quantum group and semi-infinite flag manifold* | 1703.04199v6: `ABBGM`; 2507.13930v2: `arkhipov2005modules`; 2508.01527v2: `ABBGM`; raskin: `ABBGM` |
| `B-L` | Beauville, Laszlo, *Conformal blocks and generalized theta functions* | 0906.2994v3: `BL`; 2507.13930v2: `beauville1994conformal`; math-0401222v5: `BL1`; math-0607130v2: `B-L` |
| `beilinson1987glue` | Beilinson, *How to glue perverse sheaves* | 1112.2402v8: `Be`; 2008.09349v3: `beilinson1987glue`; 2507.13930v2: `beilinson2006glue`; raskin: `Bei` |
| `beraldo2017loop` | Beraldo, *Loop group actions on categories and Whittaker invariants* | 2008.09349v3: `beraldo2017loop`; 2310.19734v2: `B`; 2507.13930v2: `beraldo2017loop`; raskin: `Ber` |
| `BZN` | BenZvi, Nadler, *Betti geometric Langlands* | 2010.01906v2: `BN`; 2405.03599v3: `BZN`; 2409.09856v3: `BZN`; 2507.13930v2: `ben2018betti` |
| `CF` | Chen, Fu, *An extension of the Kazhdan-Lusztig equivalence* | 2310.19734v2: `chen-fu`, `charles-lin`; 2405.03648v3: `CF`; 2409.07051v1: `CF`; 2507.13930v2: `chen2021extension` |
| `FFKM` | Feigin, Finkelberg, Kuznetsov, Mirkovic, *Semiinfinite Flags. II. Local and Global Intersection Cohomology of Quasimaps Spaces* | 1703.04199v6: `FFKM`; 2507.13930v2: `feigin1997semiinfinite`; math9907133v5: `FM2`; raskin: `FFKM` |
| `FrenkelGaitsgoryFusion` | Frenkel, Gaitsgory, *Fusion and convolution: applications to affine Kac-Moody algebras at the critical level* | 1106.3112v1: `fusion`; 2405.03648v3: `FG5`; 2507.13930v2: `frenkel2005fusion`; genvan: `FrenkelGaitsgoryFusion` |
| `FrenkelGaitsgorySpherical` | Frenkel, Gaitsgory, *Local geometric Langlands correspondence: the spherical case* | 1302.2506v3: `FG1`; 2405.03648v3: `FG2`; 2507.13930v2: `frenkel2009local`; genvan: `FrenkelGaitsgorySpherical` |
| `FrenkelGaitsgoryVilonenGeometricLanglands` | Frenkel, Gaitsgory, Vilonen, *On the geometric Langlands conjecture* | 1302.2506v3: `FGV2`; 2409.07051v1: `FGV`; 2409.08670v1: `FGV`; math-0402184v4: `FGV` |
| `GaLu` | Gaitsgory, Lurie, *Weil's conjecture for function fields (Volume I)* | 1505.02331v2: `Main Text`; 1608.00284v7: `GL1`, `GL2`; 2010.01906v2: `GaLu`; 2405.03648v3: `GaLu` |
| `GLC1` (references.bib) | Gaitsgory, Raskin, *Proof of the geometric Langlands conjecture I: construction of the functor* | 2405.03648v3: `GLC1`; 2409.07051v1: `GLC1`; 2409.08670v1: `GLC1`; 2409.09856v3: `GLC1` |
| `GLC2` (references.bib) | Arinkin et al., *Proof of the geometric Langlands conjecture II: Kac-Moody localization and the FLE* | 2409.07051v1: `GLC2`; 2409.08670v1: `GLC2`; 2409.09856v3: `GLC2`; 2507.13930v2: `arinkin2024proof` |
| `GLC3` (references.bib) | Campbell et al., *Proof of the geometric Langlands conjecture III: compatibility with parabolic induction* | 2310.19734v2: `eis`; 2409.08670v1: `GLC3`; 2409.09856v3: `GLC3`; 2507.13930v2: `campbell2024proof` |
| `LM` | Laumon, MoretBailly, *Champs algébriques* | 1108.5351v3: `LM`; 1308.3786v4: `LM`; 1311.2071v4: `LM`; math9907133v5: `La:s` |
| `LoopGrassmannianExt` (references.bib) | Arkhipov, Bezrukavnikov, Ginzburg, *Quantum groups, the loop Grassmannian, and the Springer resolution* | 1703.04199v6: `ABG`; 2310.19734v2: `ABG`; 2409.07051v1: `ABG`; raskin: `LoopGrassmannianExt` |
| `LusztigQAnalog` (references.bib) | Lusztig, *Singularities, character formulas, and a q-analog of weight multiplicities* | math-0401222v5: `Lu`; math0304173v3: `L1`; math9907133v5: `Lu2`; raskin: `LusztigQAnalog` |
| `ParabolicEisensteinFH` (references.bib) | Faergeman, Hayash, *Parabolic geometric Eisenstein series and constant term functors* | 2310.19734v2: `FH`; 2409.07051v1: `FH`; 2409.09856v3: `FH`; 2508.01527v2: `FH` |
| `Ra2` | Raskin, *W-algebras and Whittaker categories* | 2310.19734v2: `whit`; 2405.03648v3: `Ra2`; 2409.07051v1: `Ra2`; 2507.13930v2: `raskin2021w` |
| `RozenblyumConnectionsModuli` | Rozenblyum, *Connections on moduli spaces and infinitesimal Hecke modifications* | 2405.03648v3: `Ro2`; 2409.07051v1: `Ro`; 2409.08670v1: `Ro`; 2409.09856v3: `Ro` |
| `affinegrassmannian` | Frenkel, Gaitsgory, *D-modules on the affine Grassmannian and representations of affine Kac-Moody algebras* | 1106.3112v1: `affinegrassmannian`; 2405.03648v3: `FG1`; math0304173v3: `FG` |
| `Ari` | Arinkin, *Irreducible connections admit generic oper structures* | 2409.08670v1: `Ari`; 2409.09856v3: `Ari`; 2507.13930v2: `arinkin2016irreducible` |
| `beilinson1993proof` | Beilinson, Bernstein, *A proof of Jantzen conjectures* | 1111.2087v4: `BB`; 2008.09349v3: `beilinson1993proof`; 2507.13930v2: `beilinson1993proof` |
| `BeraldoExtendedWhittaker` | Beraldo, *On the extended Whittaker category* | 2405.03648v3: `Be1`; 2409.08670v1: `Be1`; 2409.09856v3: `Be1` |
| `BernsteinLuntsEquivariantSheaves` | Bernstein, Lunts, *Equivariant sheaves and functors* | 0906.2994v3: `BLu`; math-0401222v5: `BL`; math0304173v3: `BL` |
| `BeV` | Beilinson, Vologodsky, *A DG guide to Voevodksy's motives* | 1108.5351v3: `BeV`; 1112.2402v8: `BeV`; 1201.6343v4: `BeVo` |
| `Bez` | Bezrukavnikov, *On two geometric realizations of an affine Hecke algebra* | 1302.2506v3: `Bez`; 2507.13930v2: `bezrukavnikov2016two`; raskin: `Bez` |
| `BF` | Bezrukavnikov, Finkelberg, *Equivariant Satake category and Kostant-Whittaker reduction* | 1201.6343v4: `BF`; 1302.2506v3: `BF`; 2310.19734v2: `bezrukavnikov-finkelberg` |
| `BKS` | Beraldo, Kazhdan, Schlank, *Contractibility of the Space of Opers for Classical groups* | 2409.08670v1: `BKS`; 2409.09856v3: `BKS`; 2507.13930v2: `kazhdan2018contractibility` |
| `DeligneWeilII` | Deligne, *La conjecture de Weil-II* | 1505.02331v2: `Del`; 2010.01906v2: `De`; math0304173v3: `De` |
| `DrinfeldAlgebraicSpaces` | Drinfeld, *On algebraic spaces with an action of G_m* | 1308.3786v4: `Dr`; 1311.2071v4: `Dr`; 2008.09349v3: `drinfeld2013algebraic` |
| `DrinfeldCompactificationSchieder` (references.bib) | Schieder, *The Harder-Narasimhan stratification of the moduli stack of G-bundles via Drinfeld's compactifications* | 1112.2402v8: `Sch`; 2507.13930v2: `schieder2015harder`; raskin: `DrinfeldCompactificationSchieder` |
| `FactorizableDerivedSatake` (references.bib) | Campbell, Raskin, *Langlands duality on the Beilinson-Drinfeld Grassmannian* | 2405.03648v3: `CR`; 2409.07051v1: `CR`; 2507.13930v2: `campbell2023langlands` |
| `FinkelbergMirkovicSemiinfiniteFlags` | Finkelberg, Mirkovic, *Semiinfinite Flags. I. Case of global curve P^1* | 2507.13930v2: `finkelberg1997semiinfinite`; math9907133v5: `FM`; raskin: `FM` |
| `GaitsgoryDeJong` (references.bib) | Gaitsgory, *On de Jong's conjecture* | 2507.13930v2: `gaitsgory2007jong`; math-0401222v5: `G`; raskin: `GaitsgoryDeJong` |
| `GinzburgPerverseSheaves` | Ginzburg, *Perverse sheaves on a loop group and Langlands duality* | math-0401222v5: `Gi`; math0304173v3: `G2`; math9907133v5: `Gi` |
| `GLC4` (references.bib) | Arinkin et al., *Proof of the geometric Langlands conjecture IV: ambidexterity* | 2405.03648v3: `GLC4`; 2409.07051v1: `GLC4`; 2409.09856v3: `GLC4` |
| `GLys2` | Gaitsgory, Lysenko, *Metaplectic Whittaker category and quantum groups: the" small" FLE* | 2310.19734v2: `gl-small`; 2507.13930v2: `gaitsgory2019smallfle`; 2508.01527v2: `GLys2` |
| `Ker` | Gaitsgory, *Functors given by kernels, adjunctions and duality* | 1112.2402v8: `Ker`; 2008.09349v3: `gaitsgory2016functors`; 2010.01906v2: `Ga3` |
| `La2` | Laumon, *Faisceaux automorphes pour GL_n: la première construction de Drinfeld* | 1302.2506v3: `Lau2`; math-0402184v4: `La`; math9907133v5: `La2` |
| `LS` | Laszlo, Sorger, *The line bundles on the moduli of parabolic G-bundles over curves and their sections* | math-0401222v5: `LS`; math-0607130v2: `LS`; math9907133v5: `LS` |
| `LurieSpectralAlgebraic` | Lurie, *Spectral algebraic geometry* | 2010.01906v2: `Lu3`; 2405.03648v3: `Lu3`; 2507.13930v2: `Lurie` |
| `MirkovicVilonenPerverseSheaves` | Mirkovic, Vilonen, *Perverse Sheaves on Loop Grassmannians and Langlands Duality* | math-0401222v5: `MiV2`; math0304173v3: `MV`; math9907133v5: `MV` |
| `Ne` | Neeman, *The Grothendieck duality theorem via Bousfield's techniques and Brown representability* | 1105.4857v7: `Ne`; 1201.6343v4: `NTr`; 1302.2506v3: `Ne` |
| `PS` | Pressley, Segal, *Loop Groups* | math-0401222v5: `PS`; math-0607130v2: `P-S`; math0304173v3: `PS` |
| `R5` | Raskin, *Homological methods in semi-infinite contexts* | 2310.19734v2: `R5`; 2405.03648v3: `Ra5`; 2507.13930v2: `raskin2020homological` |
| `RaskinDmodInfinite` | Raskin, *D-modules on infinite dimensional varieties* | 2008.09349v3: `raskin2015d`; 2310.19734v2: `infdim`; raskin: `RaskinDmodInfinite` |
| `RY` | Yang, Raskin, *Affine Beilinson-Bernstein localization at the critical level* | 2310.19734v2: `RY`; 2409.07051v1: `RY`; 2507.13930v2: `yang2022affine` |
| `TT` | Thomason, Trobaugh, *Higher algebraic K -theory of schemes and of derived categories* | 1105.4857v7: `TT`; 1108.5351v3: `TT`; 1201.6343v4: `TT` |
| `AM` | Achar, Mautner, *Sheaves on nilpotent cones, Fourier transform, and a geometric Ringel duality* | 0906.2994v3: `AM`; 1308.3786v4: `AM` |
| `Beh` | Behrend, *Semi-stability of reductive group schemes over curves* | 1112.2402v8: `Beh`; 1212.6814v2: `Behrend semistability` |
| `Beh1` | Behrend, *The Lefschetz trace formula for the moduli stack of principal bundles* | 1112.2402v8: `Beh1`; 1212.6814v2: `Behrend thesis` |
| `BFS` | Bezrukavnikov, Finkelberg, Schechtman, *Factorizable sheaves and quantum groups* | math0304173v3: `BFS`; raskin: `BFS` |
| `BGG` | Bernstein, Gelfand, Gelfand, *Algebraic vector bundles on P^n and problems of linear algebra* | 0709.1228v1: `BGG`; math0304173v3: `BGG` |
| `BGSh` | Beilinson, Ginzburg, Schechtman, *Koszul duality* | 0709.1228v1: `BGS`; math0304173v3: `BGSh` |
| `BGSo` | Beilinson, Ginzburg, Soergel, *Koszul duality patterns in Representation Theory* | 0709.1228v1: `BGSo`; math0304173v3: `BGS` |
| `BL2` | Beauville, Laszlo, *Un lemme de descent* | math-0401222v5: `BL2`; math9907133v5: `BL` |
| `BM` | Borho, MacPherson, *Partial resolutions of nilpotent varieties* | 0906.2994v3: `BM2`; math-0402184v4: `BM` |
| `campbell2018nearby` | Campbell, *Nearby cycles of Whittaker sheaves on Drinfeld’s compactification* | 2008.09349v3: `campbell2018nearby`; 2507.13930v2: `campbell2018nearby` |
| `CFGY` | Chen, Fu, Gaitsgory, Yang, *Loop group actions via factorization* | 2405.03648v3: `CFGY`; 2409.07051v1: `CFGY` |
| `CG` | Chriss, Ginzburg, *Representation Theory and Complex Geometry* | 0906.2994v3: `CG`; math0304173v3: `CG` |
| `Ch2` | Chen, *Nearby cycles and dualities in geometric Langlands program* | 2405.03648v3: `Ch2`; 2409.07051v1: `Ch2` |
| `D-G` | Demazure, Gabriel, *Groupes algbriques* | math-0401222v5: `DG`; math-0607130v2: `D-G` |
| `deligne1982duality` | Deligne, Lusztig, *Duality for representations of a reductive group over a finite field* | 0709.1228v1: `DL 2`; 2008.09349v3: `deligne1982duality` |
| `DeligneMilne` (references.bib) | Deligne, Milne, *Tannakian categories* | math-0401222v5: `DM`; math0304173v3: `DM` |
| `dhillon2025semiinfiniteic` | Dhillon, Lysenko, *Semi-infinite parabolic IC sheaf* | 2507.13930v2: `dhillon2025semiinfiniteic`; 2508.01527v2: `DL` |
| `EF` | Eisenbud, Frenkel, *Jet schemes of locally complete intersection canonical singularities* | 1106.3112v1: `ef`; 1108.1738v8: `EF` |
| `faergeman2021arinkin` | Faergeman, Raskin, *The Arinkin-Gaitsgory temperedness conjecture* | 2310.19734v2: `independence`; 2507.13930v2: `faergeman2021arinkin` |
| `feigin-frenkel` | Feigin, Frenkel, *Affine Kac-Moody algebras at the critical level and Gelʹfand-Dikii algebras* | 1106.3112v1: `feigin-frenkel`; 2405.03648v3: `FF` |
| `FGKV` | Frenkel, Gaitsgory, Kazhdan, Vilonen, *Geometric realization of Whittaker functions and the Langlands conjecture* | 1302.2506v3: `FGKV`; math9907133v5: `previous` |
| `frenkel` | Frenkel, *Lectures on Wakimoto modules, opers and the center at the critical level* | 1106.3112v1: `frenkel`; 2409.07051v1: `Fr` |
| `frenkel2010weyl` | Frenkel, Gaitsgory, *Weyl modules and opers without monodromy* | 2405.03648v3: `FG3`; 2507.13930v2: `frenkel2010weyl` |
| `FrenkelGaitsgoryLocalizationModules` | Frenkel, Gaitsgory, *Localization of D-modules on the affine Grassmannian* | 1703.04199v6: `FG`; 2409.07051v1: `FG3` |
| `gaitsgory2011acts` | Gaitsgory, *What acts on geometric Eisenstein series* | 2008.09349v3: `gaitsgory2011acts`; 2310.19734v2: `whatacts` |
| `GaitsgoryConjecturalExtension` | Gaitsgory, *A conjectural extension of the Kazhdan-Lusztig equivalence* | 2405.03648v3: `Ga2`; 2409.07051v1: `Ga2` |
| `GenVan` (references.bib) | Gaitsgory, *A generalized vanishing conjecture* | 1302.2506v3: `GenVan`; 2507.13930v2: `gaitsgory2010generalized` |
| `GeometricFeiginFrenkel` (references.bib) | Raskin, *A geometric proof of the Feigin-Frenkel theorem* | 2405.03648v3: `Ra1`; 2409.07051v1: `Ra1` |
| `GinzburgGlobalNilpotent` | Ginzburg, *The global nilpotent variety is Lagrangian* | 1201.6343v4: `Gi`; 2010.01906v2: `Gi` |
| `GKM` | Goresky, Kottwitz, MacPherson, *Equivariant cohomology, Koszul duality, and the localization theorem* | 0906.2994v3: `GKM`; math0304173v3: `GKM` |
| `GM-SMT` | Goreski, MacPherson, *Stratified Morse theory* | 0709.1228v1: `GM`; 0906.2994v3: `GM-SMT` |
| `Ha` | Hayash, *Semi-infinite flags and Zastava spaces* | 2507.13930v2: `hayash2025zastava`; 2508.01527v2: `Ha` |
| `HarderNarasimhan` | Harder, Narasimhan, *On the cohomology groups of moduli spaces of vector bundles on curves* | 1112.2402v8: `HN`; 1212.6814v2: `HarderNarasimhan` |
| `He` | Heinloth, *Bounds for Behrend's conjecture on the canonical reduction* | 1112.2402v8: `He`; 1212.6814v2: `Heinloth Behrend's conjecture` |
| `HR` | Raskin, Hilburn, *Tate's thesis in the de Rham setting* | 2310.19734v2: `HR`; 2405.03648v3: `HR` |
| `Ja` | Jantzen, *Representations of algebraic groups* | 1212.6814v2: `Jantzen representations of reductive groups`; math0304173v3: `Ja` |
| `KKMS` | Kempf, Knudsen, Mumford, SaintDonat, *Toroidal embeddings. I* | 1308.3786v4: `KKMS`; 1311.2071v4: `KKMS` |
| `KL1` | Kazhdan, Lusztig, *Schubert varieties and Poincaré duality* | 0906.2994v3: `KL2`; math0304173v3: `KL1` |
| `KnutsonAlgebraicSpaces` | Knutson, *Algebraic spaces* | 1308.3786v4: `Kn`; 1311.2071v4: `Kn` |
| `KrS` | Krause, *The stable derived category of a Noetherian scheme* | 1105.4857v7: `Kr`; 1201.6343v4: `KrS` |
| `Kumar` (references.bib) | Kumar, *Kac-Moody Groups, their Flag Varieties and Representation Theory* | 0906.2994v3: `Ku`; math-0607130v2: `Ku2` |
| `LanglandsProblemsTheory` | Langlands, *Problems in the Theory of Automorphic Forms* | math-0401222v5: `L2`; math9907133v5: `La` |
| `Lo` | Loday, *Cyclic homology* | 0709.1228v1: `Lo`; math0304173v3: `Lo` |
| `LurieDAGVIII` | Lurie, *DAG-VIII* | 1108.1738v8: `Lu1`; 1111.2087v4: `Lu1` |
| `LusztigIntroductionQuantum` | Lusztig, *Introduction to quantum groups* | 1608.00284v7: `Lus`; math0304173v3: `L2` |
| `N` | Neeman, *The connection between the K-theory localization theorem of Thomason, Trobaugh and Yao and the smashing subcategories of Bousfield and Ravenel* | 1108.5351v3: `N`; 1112.2402v8: `N` |
| `Na` | Nadler, *Perverse Sheaves on Real Loop Grassmannians* | 0906.2994v3: `Na`; math-0401222v5: `Na` |
| `nick-thesis` | Rozenblyum, *Connections on conformal blocks* | 1302.2506v3: `Ro`; 2310.19734v2: `nick-thesis` |
| `NY` | Nadler, Yun, *Spectral action in Betti geometric Langlands, Israel Journal of Mathematics* | 2010.01906v2: `NY1`; 2405.03599v3: `NY` |
| `Ol` | Olsson, *On proper coverings of Artin stacks* | 1108.5351v3: `Ol`; 2010.01906v2: `Ols` |
| `R4` | Raskin, *On the notion of spectral decomposition in local geometric Langlands* | 2310.19734v2: `R4`; 2507.13930v2: `raskin2015notion` |
| `RamananRamanathan` | Ramanan, Ramanathan, *Some remarks on the instability flag* | 1112.2402v8: `RR`; 1212.6814v2: `RamananRamanathan` |
| `Ramanathan1` | Ramanathan, *Moduli for principal bundles over algebraic curves. I* | 1112.2402v8: `R2`; 1212.6814v2: `Ramanathan1` |
| `Ramanathan2` | Ramanathan, *Moduli for principal bundles over algebraic curves. II* | 1112.2402v8: `R3`; 1212.6814v2: `Ramanathan2` |
| `Ramanathan3` | Ramanathan, *Stable principal bundles on a compact Riemann surface* | 1212.6814v2: `Ramanathan3`; 2409.09856v3: `Ra` |
| `Ran` | Gaitsgory, *Categories over the Ran space* | 1108.1741v3: `Ran`; 2507.13930v2: `gaitsgory2010notes` |
| `Reich` | Reich, *Twisted geometric Satake equivalence via gerbes on the factorizable Grassmannian* | 1608.00284v7: `Re`; raskin: `Reich` |
| `RozenblyumChiralModules` | Rozenblyum, *Modules over a chiral algebra* | 2405.03648v3: `Ro1`; raskin: `RozenblyumChiralModules` |
| `Sat` | Satake, *Theory of spherical functions on reductive algebraic groups over p-adic fields* | math-0401222v5: `Sat`; math9907133v5: `Sa` |
| `SGA` | Demazure, A. Grothendieck (eds.), *Schémas en groupes (SGA 3)* | math-0401222v5: `SGA`; raskin: `SGA3` |
| `Sh2` | Shatz, *The decomposition and specialization of algebraic families of vector bundles* | 1112.2402v8: `Sh2`; 1212.6814v2: `Shatz` |
| `top-algs` | Beilinson, *Remarks on topological algebras* | 1106.3112v1: `top-algs`; 2405.03648v3: `Bei` |
| `wakimoto` | Frenkel, Gaitsgory, *Geometric realizations of Wakimoto modules at the critical level* | 1106.3112v1: `wakimoto`; 2409.07051v1: `FG1` |
| `YaR` | Yang, *Twisted Whittaker category on affine flags and category of representations of mixed quantum group* | 2310.19734v2: `ruotao-flags`; 2409.07051v1: `YaR` |

## Sources whose keys differ from the canonical ones

| Source | Entries | Keys that change | Keys that stay |
|---|---|---|---|
| 0709.1228v1 | 62 | 40 | 22 |
| 0906.2994v3 | 60 | 8 | 52 |
| 1105.4857v7 | 17 | 11 | 6 |
| 1106.3112v1 | 20 | 8 | 12 |
| 1108.1738v8 | 11 | 6 | 5 |
| 1108.1741v3 | 18 | 9 | 9 |
| 1108.5351v3 | 21 | 10 | 11 |
| 1111.2087v4 | 12 | 7 | 5 |
| 1112.2402v8 | 40 | 21 | 19 |
| 1201.6343v4 | 39 | 23 | 16 |
| 1212.6814v2 | 17 | 10 | 7 |
| 1302.2506v3 | 36 | 24 | 12 |
| 1306.4304v4 | 13 | 9 | 4 |
| 1308.3786v4 | 26 | 9 | 17 |
| 1311.2071v4 | 29 | 15 | 14 |
| 1505.02331v2 | 9 | 9 | 0 |
| 1608.00284v7 | 32 | 24 | 8 |
| 1703.04199v6 | 15 | 11 | 4 |
| 1708.07205v5 | 15 | 10 | 5 |
| 2008.09349v3 | 55 | 29 | 26 |
| 2010.01906v2 | 52 | 29 | 23 |
| 2310.19734v2 | 48 | 35 | 13 |
| 2405.03599v3 | 21 | 12 | 9 |
| 2405.03648v3 | 60 | 38 | 22 |
| 2409.07051v1 | 49 | 27 | 22 |
| 2409.08670v1 | 23 | 15 | 8 |
| 2409.09856v3 | 34 | 17 | 17 |
| 2507.13930v2 | 101 | 55 | 46 |
| 2508.01527v2 | 36 | 19 | 17 |
| genvan | 7 | 0 | 7 |
| grqcoh | 7 | 0 | 7 |
| math-0401222v5 | 30 | 19 | 11 |
| math-0402184v4 | 11 | 6 | 5 |
| math-0607130v2 | 49 | 12 | 37 |
| math0304173v3 | 54 | 24 | 30 |
| math9907133v5 | 24 | 16 | 8 |
| raskin | 40 | 9 | 31 |

Total: 626 of 1193 keys change. `genvan` and `grqcoh` keep all their keys. In `0709.1228v1` the entries have no keys (plain TeX `\item{[label]}`); the printed label is given as the present key, and labels with a space (`Ar 1`) always change.

## Unsure

These entries are not in `works`. Each one keeps its present key, except where that key is the canonical key of a different work.

| Source | Present key | Proposed key | Best guess | Reason |
|---|---|---|---|---|
| grqcoh | `BFN` | `BFN` | `BFN`: Integral transforms and Drinfeld centers in derived algebraic geometry | GRQCoh chapter prints no bibliography; label BFN matches Ben-Zvi--Francis--Nadler, "Integral transforms and Drinfeld centers", cited as [BFN] in the Gaitsgory papers of the same period |
| grqcoh | `TT` | `TT` | `TT`: Higher algebraic K -theory of schemes and of derived categories | GRQCoh chapter prints no bibliography; label TT matches Thomason--Trobaugh, "Higher algebraic K-theory of schemes and of derived categories" |
| grqcoh | `Ne` | `Ne` | `Ne`: The Grothendieck duality theorem via Bousfield's techniques and Brown representability | GRQCoh chapter prints no bibliography; label Ne matches Neeman, "The Grothendieck duality theorem via Bousfield's techniques and Brown representability" ([Ne] in IndCoh and GaitsgoryOutline) |
| grqcoh | `LM` | `LM` | `LM`: Champs algébriques | GRQCoh chapter prints no bibliography; label LM matches Laumon--Moret-Bailly, "Champs algebriques" |
| grqcoh | `Lu1` | `Lu1` | `LurieHTT`: Higher topos theory | GRQCoh chapter prints no bibliography; [Lu1] is "Higher Topos Theory" in most Gaitsgory papers that also have [Lu2] |
| grqcoh | `Lu2` | `Lu2` | `LurieHA`: Higher Algebra | GRQCoh chapter prints no bibliography; [Lu2] is cited for Sect. 1.3.2, 1.3.3, Prop. 1.2.1.16 and Cor. 2.4.3.10, which fit "Higher Algebra" (derived categories, t-structures) |
| grqcoh | `DrGa1` | `DrGa1` | `DG2`: On some finiteness questions for algebraic stacks | GRQCoh chapter prints no bibliography; [DrGa1] is cited for Definition 1.1.8 and Corollary 1.4.5, which fit Drinfeld--Gaitsgory, "On some finiteness questions for algebraic stacks" (QCA stacks) |
| 1108.1741v3 | `GaLu` | `GaLu` | `GaLu`: Weil's conjecture for function fields (Volume I) | "On the Tamagawa number formula", forthcoming (2011): probably the work that appeared as Gaitsgory--Lurie, "Weil's conjecture for function fields"; the title differs and no identifier is given |
| 1108.1741v3 | `Ba` | `Ba` | `Bar`: D-modules on spaces of rational maps | "Moduli spaces of generic data over a curve", forthcoming (2011): probably Barlev, "D-modules on spaces of rational maps and on other generic data" (arXiv:1204.3469); the title differs and no identifier is given |
| 1703.04199v6 | `GLys` | `GaitsgoryLysenkoTwistedWhittakerCategory` | `GLys2`: Metaplectic Whittaker category and quantum groups: the" small" FLE | "Twisted Whittaker category and quantum groups", in preparation (2017): probably Gaitsgory--Lysenko, "Metaplectic Whittaker category and quantum groups: the small FLE" (arXiv:1903.02279); the title differs |
| 2405.03648v3 | `Bogd` | `Bogd` | `Satakefunctor`: A factorizable geometric Satake functor with tame ramification | Entry has no title ("E. Bogdanova, in preparation"); possibly Bogdanova--Faergeman, "A factorizable geometric Satake functor with tame ramification", but there is no evidence in the entry |
| 2507.13930v2 | `Cstterm` | `Cstterm` | `GLC3`: Proof of the geometric Langlands conjecture III: compatibility with parabolic induction | Uncited .bib entry "The Langlands functor and constant terms" (Chen, Gaitsgory, Raskin, 2023), no identifier: possibly a working title of GLC III, whose first author list was Campbell, Chen, Gaitsgory, Raskin |

## Judgement calls (entries put in one work although the text differs)

- A thesis and the arXiv paper with the same title are one work: Barlev, "D-modules on spaces of rational maps and on other generic data" (`Bar`; thesis entry `barlev2012d` in 2507.13930v2; also the entry of 1708.07205v5 with the title "Moduli spaces of generic data", which gives the same arXiv number 1204.3469), and Lin, "Poincaré series and miraculous duality" (`Lin`; thesis entry `lin2023poincare`).
- Preprint and published version with a changed title are one work: Gaitsgory, "A strange functional equation ... Verdier duality / miraculous duality" (arXiv:1404.6780); Frenkel, "Lectures on Wakimoto modules, opers and the center at the critical level" (arXiv:math/0210029, Adv. Math. 195); Gaitsgory–Lurie, "Weil's conjecture for function fields" (preprint, "-I", "Volume 1"); Schieder, "On the Harder–Narasimhan stratification of Bun_G ..." (arXiv:1212.6814); Frenkel–Gaitsgory, "Localization of g-modules / D-modules on the affine Grassmannian" (Ann. of Math. 170).
- Two editions are one work: Jantzen, "Representations of algebraic groups" (1987 and 2003); SGA 3 (IHES 1966 and Lecture Notes 151–153).
- Wrong or shortened titles, identified by authors, volume and pages: `BM` in math-0402184v4 prints "Small resolutions of nilpotent varieties" for Borho–MacPherson, "Partial resolutions of nilpotent varieties" (Astérisque 101–102, 23–74); the three Astérisque entries of Lusztig with different titles are `LusztigQAnalog` (pages 208–229); the GenVan entries "Eisenstein Series and deformations" (`BG2`), "Fusion and Convolution", "The spherical case", "On a vanishing conjecture arising in ..." and "Quantization of Hitchin's Hamiltonians ..." (`BDHitchin`) are the works with the full titles.
- `kazhdan2018contractibility` in 2507.13930v2 gives arXiv:1801.00655; the other sources give arXiv:1808.05801 for the same authors and title (`BKS`). It is taken as the same work.
- "DG categories" in 1302.2506v3 (`DG`, Notes on Geometric Langlands) is taken as "Generalities on DG categories" (`GaitsgoryGeneralitiesDG`).
- The Gaitsgory–Rozenblyum book is three works: the whole book including the preliminary versions and "Studies in derived algebraic geometry" (`GaitsgoryRozenblyumDAG`), Volume I (`GaRo3`) and Volume II (`GaRo4`). The chapter `GRQCoh` of `docs/references.bib` is a fourth work, which no source cites.
- Different works that look alike are kept apart: Mirković–Vilonen, Annals 2007 (`MV`) and Math. Res. Lett. 2000 (`MirkovicVilonenPerverseSheaves`); "Semi-infinite flags" I and II; Ramanathan, "Moduli for principal bundles" (1979) and parts I, II (1996); Deligne–Lusztig duality I and II; Bruhat–Tits I and II; Pappas–Rapoport local models I, II, III; Putcha and Renner, both "Linear algebraic monoids"; Dhillon–Lysenko part I (`dhillon2025semiinfiniteic`) and part II (`DhillonLysenkoRan`); Bezrukavnikov–Losev 2018 and 2023; Casselman I and Casselman–Shalika II; single talks of the 2014 workshop and the whole set of notes (`jerusalem2014`); Gaitsgory's single notes (`Stacks`, `QCoh`, `GaitsgoryGeneralitiesDG`) and the whole collection (`DG:GL` in 1212.6814v2).
- The same label for different works: Raskin's [FG1] is `FrancisGaitsgoryChiralKoszul`, GenVan's [FG1] is `FrenkelGaitsgoryFusion`; [BD], [BD1], [BD2] are `BDChiral` or `BDHitchin` depending on the source; [DG1], [DG2], [DrGa1], [DrGa2] are `DG2`, `CompactGeneration`, `GeometricConstantTerm` or `BradenDG` depending on the source. In 1703.04199v6 the key `GLys` is not the work `GLys` of `docs/references.bib` (see "Unsure").

## Odd things

- One source has two entries for one work, so its bibliography needs one entry removed after the change: 2010.01906v2: `Ga5`, `Ga7` are both `GaitsgoryOutline`; 1608.00284v7: `Ga2`, `Ga7` are both `GaitsgoryAtiyahBott`; 2310.19734v2: `chen-fu`, `charles-lin` are both `CF`; 1608.00284v7: `GL1`, `GL2` are both `GaLu`.
- `.bib` files with entries that are not cited: `2507.13930v2/src/Bip.bib` has 101 entries, 36 are in `main.bbl`, 65 are not cited; `2008.09349v3/src/mybiblio.bib` has 55 entries, 44 are in `main.bbl`, 11 are not cited. The uncited entries are in the JSON with `"cited": false` and the `.bib` file as `file`; the cited ones have the `.bbl` as `file` and the `.bib` as `also_in`.
- `2310.19734v2`: `satake.tex` calls `\bibliography{bibtex.bib}`, but the `.bib` file is not in the source; the entries are taken from `satake.bbl`. The `thebibliography` in `satake.tex` is commented out. `1201.6343v4/src/singsupp.tex` has a `thebibliography` and also a `\bibliography{singsupp}` line without a `.bib` file.
- `grqcoh` prints no bibliography; its 7 entries are labels only (all under "Unsure"). The PDF-only items `BDChiral-2004`, `BDHitchin` and `ConradRGS` have no converted source and are not covered.
- `0709.1228v1` (plain TeX) has no cite keys. `1212.6814v2` and `1505.02331v2` have keys with spaces (`Behrend thesis`, `Main Text`), `math0304173v3` has the key `APW${}_{2}$`, `0709.1228v1` has the label `L\"o`.
- Commented-out `\bibitem` lines are not counted (for example 30 in `2405.03599v3/src/functor.tex`).
- Printed identifiers with errors: `2508.01527v2` [DL] gives arXiv:2310.0638 (one digit is missing; the work is arXiv:2310.06386); Braden's paper is printed as arXiv:math/020225 in three sources; `1105.4857v7` [DrGa2] prints "arXiv:0805:1112.2402".
- These keys of `docs/references.bib` are cited by no source: `ConradRGS`, `DhillonLysenkoRan`, `GRQCoh`, `HottaTakeuchiTanisaki`, `JuteauMautnerWilliamson`, `OperadicKoszul`, `PappasRapoport`.
- Rule 2 keeps 76 short or BibTeX-style keys for works cited by two or more sources, for example `BG1`, `BG2`, `Ra4`, `raskin2015chiral`, `beilinson1987glue`. They replace descriptive keys of the converted Raskin file in 9 places (`RaskinCPSII` to `Ra4`, `RaskinChiralCategories` to `raskin2015chiral`, `Bei`, `Ber`, `AB`, `FM`, `FF`, `SGA3`, `GaitsgoryRozenblyum`). If descriptive keys are preferred, take `descriptive_alternative` from the JSON.

