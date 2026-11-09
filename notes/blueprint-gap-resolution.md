# Blueprint gap audit, 2026-11-09

Scope: G1, G2 and P1–P7 of `notes/reviews/2026-11-09-second.md`, committed as
`5914e73`. The baseline is the 204-declaration blueprint at `f1e69ec`. These are repairs to
the blueprint and its records. No Lean declaration, dependency pin or main-theorem formula
changes. The second review's separate Lean suggestions L1–L3 are outside this repair scope.
Nothing in this session is pushed.

## Findings tested

| Finding | Verdict | Evidence and repair |
|---|---|---|
| G1: Satake inputs missing | **Confirmed** | [GaitsgoryOutline] Prop. 4.4.4 explicitly invokes geometric Satake. The old `Hecke/Satake.toml:4–8` had no spherical category or reconstruction. `GeometricLanglands/Satake/` now plans the heart, convolution, fusion, reconstruction, dual identification, factorization enhancement and determinant normalization, with supporting geometry in subject modules. |
| G2: spectral vanishing proof missing | **Confirmed** | [GaitsgoryOutline] Thm. 4.5.2 and Cor. 4.5.5 require the proof in §11.1. The old `Spectral/Action.toml:4–8` had only Hecke action and spectral localization as inputs. The new `Spectral/Critical/`, `Spectral/Parabolic/` and `Spectral/Generation.toml` expose the localization, Eisenstein and rank-induction proof. The detailed proof route below includes its geometric, local-to-global and coefficient-comparison prerequisites; a theorem node alone does not establish closure. |
| P1: assertion-only finiteness sources | **Confirmed** | [GLC1] §1.4.2 asserts the needed compactness; it is not its proof. `Whittaker/Compactness.toml`, `DModules/Safety.toml`, `LocalSystems/CompleteIntersection.toml` and `Sheaves/CompleteIntersectionFiniteness.toml` now supply the respective chains. [DG2] and [DGIndschemes] are in the bibliography. |
| P2: IndCoh domain too narrow | **Confirmed** | [IndCoh] §§10.1.2–10.1.4 define IndCoh on locally almost finite type prestacks; [Crystals] §§2.3.1–2.3.2 use it on the de Rham prestack. `Sheaves/IndCoh.toml` now constructs the affine !-diagram and its right Kan extension. The coarsening Ψ and standard t-structure remain restricted to Artin stacks, with §11.7 sources. |
| P3: duplicate characterization | **Confirmed** | The two baseline descriptions gave the same boundedness and coarsening predicate. Removed `Functor/Characterization.toml`, including its supporting uniqueness node; the sole predicate is `Statement.IsLanglandsFunctor` in `Statement/Conjecture.toml`. No Lean declaration or user was removed. |
| P4: inconsistent scope prose | **Confirmed** | The baseline README implied that auxiliary results used in the existence proof were excluded, although it included them. `plans/README.md` now distinguishes the complete statement-construction dependencies and selected supporting results from a plan of the full main-theorem proof. Automorphic compact generation is also used in the spectral-vanishing generation argument, so it is not exclusively an existence-proof input. |
| P5: wrong roadmap target names | **Confirmed** | ReductiveGroupsPartII README lines 6736 and 6787 name `dual-based-root-datum` and `langlands-dual-group`. The repaired duality/statement plans and provider record use those exact names. The relevant roadmap text is unchanged at the revision snapshot. |
| P6: duality replacement ambiguous | **Confirmed** | Baseline `Groups.rootDatum` needed a specified torus, but `Setting.dualGroup` carried none. The plan chooses a future signature change: both group pinnings become explicit, and `Groups.dualityData` identifies their flipped based root data. Classification and transport under changing pinning are separate prerequisites. The current opaque signature is unchanged. |
| P7: stale coverage and revision records | **Confirmed** | The baseline STATUS overstated coverage; the provider record's 200 count was an intermediate audit count, not the committed 204. STATUS now separates the rejected baseline from the repaired candidate. Provider records distinguish original and revision snapshots, and record current checked proposal heads without falsely re-dating unchanged node audits. |

Plan paths in this table are relative to `plans/GLCinLean/`; file and declaration locators
below disambiguate the subjects. Historical line numbers refer to `f1e69ec`, not the repaired
tree. Paper line numbers refer to the pinned local copies in `docs/references.bib`.

## G1: heart, enhancement and normalization are separate obligations

The need is explicit in [GaitsgoryOutline] Prop. 4.4.4
(`1302.2506v3/src/outline.tex:3035–3043`) and [GLC1] §1.2.1
(`2405.03599v3/src/functor.tex:1432–1435`). The new chain reaches:

- `Hecke.loopArcGroups`, `Hecke.affineGrassmannian` and `Hecke.schubertStratification`
  in the LoopGroups and AffineGrassmannian subject modules: [BDHitchin] Thm. 4.5.1,
  §§4.5.2, 4.5.8–4.5.12; [MV] §2.
- `Satake.sphericalHeart`, weight functors, convolution and fusion: [MV] §§2–6.
  Hyperbolic restriction uses the algebraic D-module proof of [BradenDG] Thm. 3.1.6,
  adjunction Thm. 3.3.4 and §§4–5 (`1308.3786v4/src/braden.tex:2506–3556`).
- `Satake.weightProjectives` and `Satake.tannakaGroup`: [MV] §§9–11
  (`math-0401222v5/src/Satake.tex:2972–3468`). The upstream
  `TauCeti.Tannaka.pointsFunctorIsoTensorAutFunctor` reconstructs a supplied Hopf algebra;
  it does not construct the Hopf algebra from an arbitrary neutral category.
- `Satake.tannakaRootDatum_equiv_dual`, `Satake.dualIdentification_compatible` and the heart
  equivalence: [MV] Thms. 7.3 and 12.1. Compatibility is with the explicit two-pinning
  `Groups.dualityData`, not with an arbitrary opaque identification.
- `Satake.naiveFactorizationFunctor`: [GLys] §9.2.1
  (`1608.00284v7/src/text.tex:6316–6348`) and [RaskinCPSI] §6, especially §6.33.
  The regular-comodule construction, chiral Hecke algebra and collision concentration have
  separate nodes. The concentration proof is [BDChiral] §§3.4.11–3.4.12; the older
  [GaitsgoryDeJong] Appendix B (§7) calls that lemma “2.4.12”.
- `Satake.criticalTwist_matchesBunDeterminant`: [GLys] §6.3 and §§9.5.1–9.5.2;
  [GLC1] Rem. 1.1.6 (`functor.tex:1414–1418`). These data feed `Hecke.satake`.
  The fresh review caught a root/coroot confusion: the fusion/gerbe parity uses the
  positive-root sum **character**, not the Whittaker positive-coroot **cocharacter**.
  `Groups.coweightParity` now uses the existing `TauCeti.twoWeylVector` and its
  even-coroot-pairing theorem, with [GLys] §§5.2.2–5.2.3 as the source. It gives a central
  element of order dividing two, allowing trivial parity for a torus.

[MV] §2 is over C with classical sheaves; §14 gives an étale variant. Neither is silently
treated as a de Rham theorem over every algebraically closed characteristic-zero field.
The plans explicitly require the algebraic D-module constructions over the original field.
[GLys] §9.1.1 and [RaskinCPSI] Rem. 6.30.1 also distinguish the heart equivalence from the
full spherical DG category: the naive functor must not be called an equivalence of DG categories.

## G2: spectral vanishing now has an explicit proof route

The missing step was the assertion that the kernel of spectral localization acts by zero.
Hecke action and the existence of localization alone do not establish it. The repaired
`Spectral/Action.toml` reaches `SpectralProof.localizationKernel_annihilatesAutomorphic`
through critical localization, arbitrary-parabolic Eisenstein comparison and induction on
semisimple rank. Declaration IDs below omit the prefix `GLCinLean.`; paper paths are under
`references/papers/`. These are planned proof obligations, not implemented Lean theorems.

- **The older notes do not close the arbitrary-parabolic step.** [GenVan] §2.6
  (`GenVan-2010-10-18/GenVan.txt:255–259`) says that the cited Eisenstein theory is
  developed for a Borel and expects its extension to general P. [GaitsgoryOutline]
  Prop. 11.1.4 (`1302.2506v3/src/outline.tex:6941`) likewise needs the intermediate
  parabolic functor. The new route uses [GLC3] rather than reporting that expectation
  as a proved supplier.

- **Critical localization and generation are separated.**
  `SpectralProof.globalOperLocalization` uses [GLC2] Thm. 15.1.7
  (`2405.03648v3/src/Loc.tex:16872`), its proof §§15.6–15.10 and Appendix F;
  `SpectralProof.globalOperLocalization_ranLinear` uses Cor. 15.5.9 (`:17542`) for the full Ran
  action. Its approximation, vacuum-insertion, prescribed-pole base-change and
  oper-homology inputs have separate nodes in `Spectral/Critical/HeckeCompatibility.toml`.
  `SpectralProof.kacMoodyLocalizationOnOpen_rightAdjoint_fullyFaithful` uses Thm. **13.4.2**
  (`:15723`), with the second proof §13.6 (`:16037`), Lemma 13.4.7 (`:15788`)
  and `SpectralProof.localizationCDO_is_diagonal`. This gives generation on each quasi-compact
  open, not global generation by KL alone. `SpectralProof.cuspidalSupport_bounded` uses
  [GeometricConstantTerm] Prop. 1.4.6 (`1311.2071v4/src/CT.tex:1341`) and Appendix B
  (`:3739`), retaining an open that is quasi-compact **component by component**.
  `SpectralProof.localizedKL_and_Eisenstein_generate` and `SpectralProof.localizationKernel_annihilatesAutomorphic`
  then implement [GaitsgoryOutline] Thm. 11.1.1 (`outline.tex:6874`): right
  orthogonality implies cuspidality, bounded support permits local KL generation,
  and proper Levi subgroups reduce semisimple rank. Rank zero is included.

- **The arbitrary-P functor is constructed without assuming the G spectral action.**
  `SpectralProof.semiInfiniteSatake_equiv` uses [GLC3] Thm. 2.4.3
  (`2409.07051v1/src/Eis.tex:3636`), with the proof in Appendices A–E and the additional deferred inputs described below.
  `SpectralProof.enhancedEisenstein` uses §§8.2–8.5 (`:10368`, `:10772`); §8.5.5 (`:10830`)
  identifies its free-module restriction with ordinary Eis. The partial enhancement
  uses Prop. 12.7.3 (`:16765–16841`), the Rep(P)-to-semi-infinite functor of
  §12.6.8 (`:16727`), and [GLC2] Rem. **15.6.15**, equation (15.32)
  (`Loc.tex:17848`; GLC3 v1 cites the older number 15.6.16).
  `SpectralProof.twistedUnipotentLocalSystems_functions` requires the twisted calculation of
  [GLC3] §§12.3.2–12.3.5 (`Eis.tex:16195–16305`) over every affine family
  S→LS_M and descent; the trivial local system alone is insufficient.
  `SpectralProof.independentCategory_tensorBaseChange` uses the universal property in
  [GLC2] Lemma H.1.13 (`Loc.tex:37126`), not an assertion that arbitrary tensor
  products commute with limits. These feed `SpectralProof.parabolicPartialEnhancement_independent_equiv`,
  `SpectralProof.partialEnhancement_to_semiInfinite`, `SpectralProof.parabolicGlobalization_comparison` and
  `SpectralProof.localizationKernel_annihilatesEisenstein`. Only the proper Levi's spectral action
  is used as the induction hypothesis; twists and Chevalley normalizations remain explicit.

- **The papers deferred by GLC III are actual proof inputs.** Its §1.3
  (`Eis.tex:1923–2040`) and §B.4 (`:24194–24230`) cannot be treated as a complete
  proof of compact generation, induction and the Omega/Jacquet comparison.
  The previously forthcoming paper is now pinned as [ParabolicEisensteinFH]
  2507.13930v2. `SemiInfinite.parabolicIC`, its Hecke structures and Koszul boundary,
  and `SemiInfinite.whittakerJacquet_matches_unipotentInvariants` expose its
  construction and rigorous first proof of Thm. 6.4.4.1 in §6.4.6
  (`2507.13930v2/src/main.tex:3788–3842`). This uses the finite Zastava IC/shift
  comparison of [GaRanII] Prop. 3.8.3 and [GaSemiInfiniteI] Prop. 3.6.5(a), then
  [RaskinCPSI] Thm. 3.4.1. The pointwise Casselman–Shalika theorem of
  [WhittakerPatternsFGV] is a separate prerequisite of that vanishing; it is not
  deduced circularly from the later full factorization theorem. FGV's introduction
  explicitly includes characteristic-zero D-modules (`math9907133v5/src/FGV.tex:323–325`).
  FH's §2.3.1 assumes simply connected derived group. The generality comparison
  `SpectralProof.parabolicZExtension_descent` uses the corrected quotient-stack
  compactification of [DrinfeldCompactificationSchieder] §§7.2–7.4, especially
  Prop. 7.3.2 (`1212.6814v2/src/Schieder.tex:3144–3194`). It retains stabilizers,
  choices, component maps and the Bun_Z torsor; the kernel/factorization transport is
  an explicit adaptation obligation. The required curve H2 vanishing is [StacksProject]
  Thm. 59.68.5, tag 03RM, assigned to SchemeAndStackFoundations §2.16.

- **Compact generation and induction use the actual invariant-category argument.**
  `SemiInfinite.parabolicStratification`, `parabolicInvariants_monodromic`,
  `parabolicStratumAdjunctions` and `parabolicInvariants_compactlyGenerated` expose
  [ChenNearbyCycles] Lemma 2.3.4(1)–(4)
  (`2008.09349v3/src/main.tex:1845–1870`) and Appendix D (`:5465–5788`).
  Parameterized Braden adjunction, finite-interval excision and adjointable limits
  construct the invariant adjoints; continuous conservative restriction then proves
  compact generation. The general-group step transports the strata and generators
  through the separate z-extension comparison. It does not infer compact generation
  from an arbitrary descent limit. [DhillonLysenkoRan] §§2.3–2.4 and §2.7 supply
  additional parabolic stratum comparisons, not a substitute for Chen's full argument.
  The plan distinguishes these invariant adjoints from ambient partial shriek, as
  [GaRanII] Rem. 1.5.4 requires. `SemiInfinite.parabolicVacuumShriek` constructs the
  ambient shriek image only of the dualizing vacuum, using finite-type holonomic
  charts and [ChenNearbyCycles] §A.4.6. General coefficients enter
  `SemiInfinite.parabolicInduction_factorization` through convolution and the
  invariant adjunction. Spherical rigidity over configurations is relative to
  Dmod(X^I), as [GLC3] §9.6.11 (`Eis.tex:12466`) requires; it is ordinary rigidity
  at geometric points. Neither arbitrary base coefficients' holonomicity nor their
  tensor dualizability is assumed.

- **The spectral semi-infinite operand has its own infinite-type construction.**
  [GLC3] §§2.1–2.2 (`Eis.tex:3126–3199`) says its Ran-family triple fiber product
  is not locally almost finite type and is outside [GLC2] Appendix A.5. The plan
  therefore constructs `LocalSystems.horizontalLoops`, `Sheaves.horizontalLoopIndCoh`
  and `Sheaves.parabolicHorizontalLoopIndCoh_compactDuality` from [GLC3] Appendix A.
  The special finite open cover of the quasi-affine dualG/N_dualP by big-cell charts
  supplies descent, arc-to-loop adjunction and group coinvariants. This is separate
  from the oper construction; no general smooth-quasi-affine horizontal-loop
  factorization theorem is asserted where the source leaves it unknown.

- **Derived Satake retains the group and coefficient comparisons.**
  [FactorizableDerivedSatake] Thm. 6.6.1 (`2310.19734v2/src/satake.tex:2515`),
  proved in §9 (`:3352–3487`), uses [LoopGrassmannianExt] Thm. 7.6.1 and
  Lemma 7.6.3 (`math0304173v3/src/abg.tex:6044`, `:6082`). ABG supplies a graded
  Ext algebra over C, in its semisimple simply-connected-geometric/adjoint-dual
  setting. `SpectralProof.geometricSatakeMonad_cohomology` therefore does not assume
  DG formality. `Satake.regularSheafExt_torusAndProducts` and
  `Satake.regularSheafExt_centralIsogenyComparison` track torus factors, components and
  finite-kernel characters. `DModules.boundedEquivariantExt_baseChange` and
  `Satake.regularSheafExt_complexComparison` specify finite-Schubert and finite-jet
  models, bounded totalizations, the regular ind-object, and multiplicative
  de Rham/constructible comparison before faithfully flat descent. They do not
  assume an embedding of arbitrary k into C. The actual monad map is tested;
  `SpectralProof.invariantQuadratics_detect_equiv` uses linear invariants on the center and a
  nondegenerate invariant quadratic on each simple ideal, correcting the literal
  degree-two-invariants sentence in CR §9.3 (`satake.tex:3446`).

- **The critical-center and oper foundations are explicit.**
  `Spectral/Critical/FieldComparison.toml` separates complex-simple Feigin–Frenkel,
  vacuum reduction, finite-projective Satake sections, the geometric oper map,
  finite-weight scalar extension and reductive comparison. The geometric source is
  [GeometricFeiginFrenkel] Thm. 1.4 (`1106.3112v1/src/ff.tex:523`), with
  Thms. 3.2, 3.5 and 4.1 (`:793`, `:853`, `:875`), Prop. 5.1 and Lemma 5.3
  (`:1191`, `:1259`). It starts over C with semisimple simply connected G;
  `SpectralProof.criticalCenter_fieldBaseChange`, `SpectralProof.criticalGlobalSections_flatBaseChange` and
  `SpectralProof.reductiveCriticalCenter_comparison` are the explicit adaptation obligations.
  The torus critical level is zero. `SpectralProof.localOpers` retains the specified Cartan
  bundle and simple-root coefficients equal to one, as in [GLC2] §§3.1.1–3.1.3;
  central-isogeny comparison does not identify unnormalized raw oper stacks.
  Infinite-type opers use `Sheaves.indcohBang`, `Sheaves.indcohStar`,
  `Sheaves.infiniteTypeUpsilon`, `SpectralProof.opers_indPlacid` and
  `SpectralProof.operIndCoh_ranDescent`: [GLC2] §§A.4–A.6 (`Loc.tex:21781–22220`), §§A.9–A.10
  (`:22609–22955`), §§3.2.2–3.2.6 (`:3509–3568`) and §§B.13.9–B.13.22
  (`:25707–26015`). The plan does not apply the LAFT IndCoh interface directly
  to these spaces or assume the factorization equivalence asked in Question 3.8.9.

- **Spectral localization itself has a separate geometric proof.**
  `SpectralProof.spectralLocalization_counit_isIso` follows [GLC4] Prop. C.1.7,
  Cor. C.1.8 and §C.1.9 (`2409.08670v1/src/ambidex.tex:5843–5874`), with the
  diagonal-kernel proof §C.4 (`:6101–6217`). `Sheaves.passable_tensorBaseChange`
  and `Sheaves.passable_qcohKernelEquivalence` retain the passability hypotheses.
  `SpectralProof.affineDPrestack_factorizationHomology` uses Prop. **B.3.8(a)** (`:5357`),
  Prop. C.4.4 (`:6182`) and Cor. C.4.5 (`:6188`), restricted to the image of
  forgetting unitality and its dualizing-unit case. The BD input is expanded into
  convenient semifree resolutions, finite-arity Com–Lie contraction, free
  commutative homology, and
  `Factorization.centralChiralHomology_equiv_derivedConstantQuotient`:
  [BDChiral] §§4.3.7, 4.6.1–4.6.5 (chapter 4, printed pp319–320, 341–346;
  `BDChiral-2004/cha_ch4.txt:3099`, `:5072–5365`). The aritywise argument
  addresses footnote 70's boundedness issue using [OperadicKoszul] Thms. 4.1.13,
  4.2.5 and Cor. 4.2.7 (`0709.1228v1/src/operad.tex:4090`, `:4312`, `:4339`).
  `Hecke.ranHomology_is_unit` uses the algebraic proof of
  [GaitsgoryContractibility] Thm. 1.6.5 and §6
  (`1108.1741v3/src/Contractibility.tex:1885`, `:6062–6111`);
  `Hecke.ranSupersetPullback_fullyFaithful` uses [GaitsgoryAtiyahBott] Lemma 2.5.7
  and §4.6.3 (`1505.02331v2/src/Tamagawa.tex:2373`, `:3383–3401`).
  GLC2 H.2's independent-vacuum calculation is not substituted for this geometric
  contractibility theorem.

The collision-specific verification is `Hecke.spreadClassifyingStack_collisionDescent` and
`Hecke.spreadClassifyingStack_passable`, with one-affineness, formal-support and localization
pullback prerequisites feeding `SpectralProof.localizationPassability`. The sources are
[RaskinCPSI] Lemma 6.16.2, Thm. 6.17.1, Lemma 6.18.1, Cor. 6.18.2 and Appendices A.2–A.3
(`RaskinCPSI-2018-09-05/cpsi.txt:3269–3396`, `:4712–4758`), with [GLC4] §§C.1.1–C.1.2.
Proposition B.5.1(3) and Remark B.5.2 give compactness after arbitrary coefficient-category
base change. The proof uses the finite collision diagram and localization gluing; it does
not infer passability from separate-point fibers or rigidity of QCoh(LS). The one-affineness
inputs are [OneAffineness] Thms. 2.1.1, 2.5.4(b) and 2.6.3, restricted to schemes and their
de Rham prestacks; the finite-dimensional formal additive group is a separate proof input.
These are explicit future proof obligations. The final independent review and its precise
scope are recorded in `notes/reviews/2026-11-09-repair.md` after the candidate is committed.

## P1: proof chains and hypotheses

For `Whittaker.vacuumPoincare_compact`, the reduction stack is a torsor stack for a twisted
unipotent group on the proper curve. A central/root filtration reduces finite type to vector
bundle cohomology. [GLC2] §12.5.7 (`2405.03648v3/src/Loc.tex:14429`) states the required
quasi-compactness and safety. The curve-cohomology finiteness, degree-at-least-two vanishing and flat-base-change interfaces already exist in Tau Ceti and now occur as direct provider leaves; the Serre trace alone would not supply them. [DG2] Def. 10.2.2, Thm. 10.2.4 and Cor. 10.2.7
(`1108.5351v3/src/Finiteness.tex:8501–8575`) then give compactness of the coherent exponential
pullback on this safe source. Its partial shriek image is compact by its adjunction to the
continuous extraordinary pullback. This uses [GLC1] §§1.3.5, 1.3.7 for twist compatibility and
definedness; it never assumes that shriek pushforward is defined on every D-module.

For `LocalSystems.qcohRigid`, [DG2] Thm. 4.3.1 gives dualizability; Rem. 4.3.2 explicitly
does not supply general QCA compact generation. Instead the plan uses [ArinkinGaitsgory]
Cor. 9.2.7 (`1201.6343v4/src/singsupp.tex:6808–6847`) for global complete intersections,
the LS presentation in §10.6.2 and Prop. 10.6.6 (`7715–7832`), and the zero-support equivalence
Thm. 4.2.6. The smooth ambient stack is a quasi-compact neighborhood of LS, not the whole
regular-singular connection stack. [DG2] Cor. 1.4.3 then identifies compact objects with perfect,
tensor-dualizable objects. Relative Koszul duality and the meromorphic connection construction
are explicit prerequisites, including [DGIndschemes] Props. 8.2.2 and 9.1.4.

## P2–P6: domain and signature repairs

`Sheaves.indcohAffine`, `Sheaves.indcohShriekOnSchemes` and `Sheaves.indcoh` construct the
diagram before extending it, rather than presupposing an Artin atlas for a de Rham prestack.
[IndCoh] §10.1 starts at `1105.4857v7/src/IndCohtext.tex:7560`; [Crystals] §2.3 starts at
`1111.2087v4/src/Crystalstext.tex:1340`. The de Rham prestack's locally almost finite type
condition is its own theorem, using [Crystals] Prop. 1.3.3 and Cor. 1.3.7. Extending IndCoh does
not extend every piece of its scheme API automatically: Ψ uses [IndCoh] §§11.7.1–11.7.2
(`IndCohtext.tex:9153–9197`) and the Artin t-structure uses §11.7.4 (`9235ff`).

`AlgebraicGeometry/Group/Duality.toml` distinguishes the unbased datum extracted from a
specified split torus, the based datum of a pinning, and an equivalence of flipped based data
for two specified pinnings. [ConradRGS] Thms. 6.1.16(2), 6.1.17 and Prop. 7.1.6 provide
existence/classification and transport, including the central torus. The planned replacement
of `Statement.RootDatumDuality` will add a dual pinning and rank to Setting and must come with
nontrivial examples and a new statement review. It is not permission to change that signature
without the owner's approval.

## Evidence revisions and checks

Mathlib and Tau Ceti pins are unchanged. New searches use Tau Ceti main
`1e668f5e55bc20f2eb87f4ba49b48833470290d1` and roadmap main
`000abc149867f86a79d9708294c89af6b42c37a6`; unchanged nodes retain their original checked
commits. The seven relevant accepted roadmap READMEs were compared with the original snapshot
and are byte-identical. PR #1056 was first checked at `ccaed5e19b5e7e0d5e967ce24b2d1f8ca5f20201`; the reviewer later observed it open at `d4bae7ce50e8fa1e08d9e1b91abacc4beacb721a` and read the intervening scope diff on 2026-11-09. See `docs/blueprint-providers.md` for
the other heads and the distinction between a proposal and an implementation.

Build, axiom-audit and tracker results, counts, candidate commit and final fresh-review status
are recorded in `STATUS.md`. The reviewer did not author these repairs. A passing parser or
build does not establish mathematical completeness of a future proof; the source review is a
separate gate.
