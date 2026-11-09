# Paper blueprint evidence for GLC1 Conjecture 1.6.7

Read against locally stored pinned TeX on 2026-11-09. This is a dependency specification, not a claim that the declarations exist. Provider matching is recorded in docs/blueprint-providers.md and in each plan. Suggested IDs below are mathematical labels for a planner, not instructions to duplicate provider declarations. Reuse actual provider IDs at the leaves.

## Exact scope and critical corrections

1. The source of truth is [GLC1] Corollary 1.6.5 and Conjecture 1.6.7. Corollary 1.6.5 says that a **colimit-preserving** functor from half-twisted D-modules to nilpotent IndCoh exists, sends compact objects to eventually coconnective objects, and its composite with coarsening is isomorphic to the coarse functor. The unique compatible QCoh-linear enhancement is **[GLC1] Proposition 1.7.2**, not in the literal statement of Corollary 1.6.5. Include this locator if the final surface quantifies over linear functors.
2. The half twist is the **μ₂-gerbe of square roots of the normalized determinant line on Bun_G**, [GLC1] §1.1.4. It is not the line ω_X^(1/2) on X. The latter is a chosen theta characteristic that supplies a trivialization of that gerbe ([GLC1] §1.1.2) and normalizes the Whittaker construction (§1.3.2). Existing DmodHalf's docstring confuses these.
3. [GLC1] §1.2.2 displays the domain of spectral localization as Rep(dual G), but surrounding text and [GaitsgoryOutline] §4.3 show that the domain is **Rep(dual G)_Ran**. Do not reproduce this typographical omission.
4. The nilpotent cone on the spectral side lies in Sing(LS_dualG) and consists of **horizontal coadjoint sections** that are pointwise nilpotent; it is not the automorphic nilpotent cone in T*Bun_G. [ArinkinGaitsgory] §§10.4.6–10.4.7, 11.1.1–11.1.5 give the distinction.
5. LS must be the **derived mapping stack** Map(X_dR, B dualG), not the ordinary moduli stack or a set of flat bundles. Derived structure is precisely why IndCoh differs from QCoh. See [ArinkinGaitsgory] §10.1.1.
6. DGCat must depend on k and appropriate universes. The current global universe-zero carrier erases both. Its intended content is a presentable stable infinity-category with a Vect_k module structure; continuity is preservation of all colimits. [AGKRRV] §§0.9.3–0.9.4. A bare category/functor API or a triangulated category is not an adequate replacement.
7. A t-structure is **additional data on a DG category**, not an automatic property of every DG category. Eventual coconnectivity means existence of an integer lower cohomological bound relative to a specified t-structure, [AGKRRV] §0.9.5. Compactness is preservation of filtered colimits by the **mapping-space** functor, §0.9.2. Separate these concepts in the plan.
8. Linear functors require actual monoidal and module-action data. The current LinFun's first argument is merely a DGCat and carries none. At the placeholder stage its docstring can honestly say that it stands for all this data; the library blueprint must plan monoidal category, module action, linear functor, linear natural equivalence and their coherence.
9. Do not use the Killing form alone as a nondegenerate invariant form on an arbitrary reductive Lie algebra; it degenerates on the center. The coadjoint nilpotent cone in [ArinkinGaitsgory] §11.1.1 is independent of a chosen invariant identification g ≅ g*. The Killing form in [GLC1] Proposition 1.3.3 pairs the opposite **nilpotent radicals**, where the restriction works.
10. Existing extra sorries for dual existence, Corollary existence/uniqueness and the chosen LG violate the one-sorry policy. The approved form can put existence and universal equivalence together in the main theorem and avoid selecting LG from an unproved theorem. Do not insert any of these desired conclusions as fields of Setting. Any future standalone theorem asserting dual existence must actually be proved.
11. Every opaque carrier and every definition transitively built over placeholder data needs truthful treatment as a placeholder, including the current Pt carriers and LinFun.IsEquivalence. The primary target is still a statement blueprint with honest placeholders, not a completed mathematical library.
12. Root-datum duality as an uninhabited opaque relation could make every Setting empty; the plan needs dual-group existence, construction and small nontrivial examples to rule out this eventual vacuity. Likewise include theta-characteristic existence over the stated fields as a library task, without turning it into an extra unproved theorem used by the statement.

## Dependency inventory

Each row is an intended declaration, its paper locator, and its immediate mathematical dependencies. Module boundaries here are suggestions; split one concept per file. The endpoint is provider-owned primitives, not an arbitrary stopping point at opaque names.

### CategoryTheory / enhanced foundation

| Declaration/concept | Source | Dependencies / specification |
|---|---|---|
| InfinityCategory | [AGKRRV] §0.9.2 | simplicial/higher-category foundation, universes; must have mapping spaces |
| MappingSpace | [AGKRRV] §0.9.2 | InfinityCategory, spaces/infinity-groupoids |
| InfinityFunctor | [AGKRRV] §0.9.2 | InfinityCategory, coherent composition |
| NaturalEquivalence | [GLC1] Cor. 1.6.5; [AGKRRV] §0.9.2 | infinity functor category and its equivalences |
| InfinityEquivalence | [GLC1] Conj. 1.6.7 | functor, inverse, unit/counit equivalences; no propositional equality of functors |
| InfinityLimits / InfinityColimits | [CompactGeneration] §§1.6–1.8 | functors, mapping spaces, universal property |
| FilteredColimit | [AGKRRV] §0.9.2 | filtered diagrams, infinity colimits |
| PresentableCategory | [AGKRRV] §0.9.4 | accessibility and small colimits |
| StableCategory | [AGKRRV] §§0.9.3–0.9.4 | pointed infinity-category, finite limits/colimits, suspension equivalence |
| DerivedVect k | [AGKRRV] §0.9.3; [IndCoh] §0.6.4 | chain complexes of k-modules, quasi-isomorphisms, enhanced localization |
| LurieTensorProduct | [AGKRRV] §0.9.4 | presentable stable categories, colimit-preserving functors, tensor universal property |
| DGCategory k | [AGKRRV] §0.9.4 | presentable stable category, DerivedVect k, Lurie tensor, module structure |
| ContinuousFunctor | [AGKRRV] §0.9.4 | DGCategory, infinity functor, preservation of colimits and k-linearity |
| DGInternalHom | [AGKRRV] §0.9.4 | DGCategory, DerivedVect action, tensor-Hom adjunction |
| CompactObject | [AGKRRV] §0.9.2; [CompactGeneration] §1.2.1 | mapping spaces, filtered-colimit preservation |
| CompactlyGenerated | [CompactGeneration] §1.2.2 | compact objects, generation by colimits |
| IndCompletion | [CompactGeneration] §1.3 | small enhanced category, filtered-colimit completion, universal property |
| MonoidalDGCategory | [AGKRRV] §0.9.4 | associative algebra object in DGCat with coherent unit |
| SymmetricMonoidalDGCategory | [AGKRRV] §0.9.4 | commutative algebra object in DGCat |
| DGModuleCategory | [ArinkinGaitsgory] §1.5.2(viii); [GLC1] §1.7.1 | monoidal DG category, coherent action |
| LinearFunctor | [GLC1] Prop. 1.7.2 | module categories, continuous functor, coherent intertwining |
| LinearNaturalEquivalence | [GLC1] Prop. 1.7.2 | linear functors, equivalence in their functor infinity-category |
| LinearFunctor.id / comp / obj / IsEquivalence | [GLC1] Cor. 1.6.5 and Prop. 1.7.2 | enriched/linear functor theory; plan the actual introduction/elimination and coherence APIs |
| TStructure | [AGKRRV] §0.9.5; [IndCoh] §0.6.5 | stable enhanced category, orthogonality, truncation triangles |
| EventuallyCoconnective | [AGKRRV] §0.9.5 | chosen t-structure, integer shifts, ∃ n, C^{≥ n} |
| PerfectObject / DualizableObject | [GLC1] §§1.2.2, 1.4.2 | symmetric monoidal enhanced category, evaluation/coevaluation |
| RigidDGCategory | [GLC1] §§1.2.2, 1.4.2 | dualizable compact objects, compact generation |
| ContinuousRightAdjoint | [GLC1] §1.4.5; [CompactGeneration] §1.2 | enhanced adjunction, compact preservation, compact generation |
| LinearRightAdjoint | [GLC1] §1.4.5 | linear adjunction, rigidity; proves coarse functor's linearity |

The ordinary Mathlib category, functor, natural isomorphism, adjunction, monoidal category, filtered-colimit and triangulated t-structure APIs are useful leaves or model ingredients, not substitutes for this layer. No new duplicate wrappers should be declared just to give them local IDs.

### Algebra / groups and curve input

| Declaration/concept | Source | Dependencies / specification |
|---|---|---|
| ground field k | [GLC1] §0.1.1; [AGKRRV] §0.9.1 | Field, CharZero, IsAlgClosed; same k for geometry and D-module coefficients |
| SmoothProperConnectedCurve | [ArinkinGaitsgory] §10.4; [AGKRRV] §14.1.1 | scheme over Spec k, smooth relative dimension one, proper, connected; nonempty follows connectedness convention |
| ReductiveGroup | [GLC1] §0.1.1 | affine algebraic group, finite type, smooth, geometrically connected reductivity |
| MaximalTorus / Borel / UnipotentRadical | [GLC1] §§1.3.1, 1.3.6 | reductive group, subgroup schemes; B contains T and N=rad_u(B) |
| RootDatum / BasedRootDatum | [GLC1] §0.1.1, §1.3.6 | characters, cocharacters, perfect pairing, roots, coroots, simple roots |
| Pinning | [GLC1] §1.3.6; [GLC2] §0.4 | split maximal torus, Borel, simple-root trivializations |
| DualRootDatum / LanglandsDualGroup | [GLC1] §0.1.1 | exchange characters/cocharacters and roots/coroots; existence and uniqueness up to appropriate isomorphism |
| GroupLieAlgebra / AdjointRepresentation / CoadjointRepresentation | [GLC1] §1.1.1; [ArinkinGaitsgory] §10.4 | tangent at identity, differentiation, dual representation |
| nilpotentCoadjointCone | [ArinkinGaitsgory] §§11.1.1–11.1.2 | invariant polynomial algebra, Chevalley map and zero fiber; invariant-form independence |
| twiceRhoCoweight | [GLC1] §§1.3.4–1.3.6 | positive coroots, their sum; integral 2ρ, do not assume ρ integral for arbitrary G |
| CanonicalLineBundle | [GLC1] §1.3.2 | relative Kähler differentials, curve smooth of dimension one, proof of invertibility |
| ThetaCharacteristic | [GLC1] §1.3.2 | line bundle L, chosen isomorphism L⊗L ≅ ω_X; no equality of bundles |
| rhoOmegaTBundle | [GLC1] §§1.3.4–1.3.6 | ThetaCharacteristic, integral 2ρ cocharacter, extension of structure group |

### AlgebraicGeometry / derived geometry

| Declaration/concept | Source | Dependencies / specification |
|---|---|---|
| ConnectiveCommutativeDerivedAlgebra k | [AGKRRV] §0.9.6 | DerivedVect k, symmetric monoidal structure, commutative algebra objects, t-structure |
| DerivedAffineScheme | [AGKRRV] §0.9.6 | opposite of connective commutative derived k-algebras |
| DerivedPrestack | [AGKRRV] §0.9.6 | accessible functors from derived affine schemes opposite to spaces |
| ClassicalTruncation / Reduction | [Crystals] §1.1.1; [IndCoh] §0.6.6 | H⁰ of connective algebra, reduction by nilradical, classical-to-derived embedding |
| DerivedFiberProduct / MappingPrestack | [ArinkinGaitsgory] Appendix B.1 | prestack limits, functor categories, mapping-space universal property |
| DerivedStack / DerivedArtinStack | [IndCoh] §11.1; [ArinkinGaitsgory] §1.5.3 | etale/smooth topology, infinity descent, representable diagonals, smooth atlases |
| LocallyAlmostFiniteType / QCA | [IndCoh] §0.6.9; [ArinkinGaitsgory] §10.4.3 | classical finite type, finite-generation of negative cohomology, quasi-compactness and affine stabilizers |
| ClassifyingStack G | [ArinkinGaitsgory] §10.1.1; [Crystals] §6.1.1 | G-torsors, descent; quotient pt/G |
| BundleStack X G | [ArinkinGaitsgory] §10.1.1 | Map(X, BG), classical embedding; test-scheme interpretation |
| bundleStack_smooth | [ArinkinGaitsgory] Lemma 10.4.2 | curve, algebraic group, mapping deformation theory |
| DeRhamPrestack | [Crystals] §1.1.1 | Y_dR(S)=Y((S_cl)_red); canonical X→X_dR and functoriality |
| LocalSystemStack X G | [ArinkinGaitsgory] §10.1.1 | Map(X_dR, BG), derived mapping prestack |
| ForgetConnection | [ArinkinGaitsgory] §10.1.1 | X→X_dR, restriction of mapping stacks |
| localSystemStack_QCA | [ArinkinGaitsgory] §10.4.3 | mapping-stack representability, affine diagonal, boundedness for bundles admitting connections |
| CotangentComplex | [ArinkinGaitsgory] §2.1, Appendix B.2 | derived algebraic geometry, square-zero extensions, derivation universal property |
| PerfectComplex / TorAmplitude | [ArinkinGaitsgory] §2.1.3 | QCoh, duality, derived tensor, t-structure |
| QuasiSmoothScheme / QuasiSmoothStack | [ArinkinGaitsgory] §2.1.3 and §8.1.1 | cotangent perfect of amplitude [-1,0] for schemes, [-1,n] for n-Artin stacks; do not impose scheme amplitude on stacks |
| localSystemStack_quasiSmooth | [ArinkinGaitsgory] Prop. 10.4.5 | de Rham cohomology, associated adjoint bundle, curve duality |
| SingScheme / SingStack | [ArinkinGaitsgory] §2.3.3 and §8.1.4 | classical relative Spec Sym(T[1]); smooth descent |
| localSystemSing_equiv_horizontalCoadjoint | [ArinkinGaitsgory] Cor. 10.4.7 | cotangent description, duality, SingStack |
| SpectralNilpotentCone | [ArinkinGaitsgory] §§11.1.1–11.1.2 | Sing(LocalSystemStack), horizontal coadjoint sections, nilpotent coadjoint cone |
| spectralNilpotentCone_conical_closed | [ArinkinGaitsgory] §11.1.1 and Lemma 11.1.4 | Chevalley zero fiber, horizontal-section evaluation |
| zeroSection_mem_spectralNilpotentCone | [ArinkinGaitsgory] §§11.1.1, 11.1.5 | nilpotence of zero; required for coarsening and t-structure |

### AlgebraicGeometry / enhanced sheaves and singular support

| Declaration/concept | Source | Dependencies / specification |
|---|---|---|
| DerivedModuleCategory A | [AGKRRV] §§0.9.3, 0.9.6 | derived algebra, enhanced module category |
| QCoh | [IndCoh] §0.6.7 | affine derived modules, right Kan extension to prestacks |
| QCoh.pullback / tensor / unit / globalSections | [IndCoh] §0.6.7 and §1.4; [GLC1] §1.4.6 | enhanced sheaf descent, derived tensor, structure sheaf; Γ valued in Vect_k |
| QCoh.standardTStructure | [IndCoh] §1.1.1 | affine standard t-structures and descent |
| CoherentComplex | [IndCoh] Def. 1.1.2 | QCoh, bounded cohomological amplitude and coherent cohomology |
| IndCohScheme | [IndCoh] Def. 1.1.3 | IndCompletion of CoherentComplex on Noetherian derived scheme |
| IndCohPrestack / IndCohStack | [IndCoh] §§10.1, 11.2 | ! pullbacks and enhanced right Kan extension; smooth descent |
| IndCoh.psi | [IndCoh] §1.1.5, §10.3 | extension of Coh→QCoh; compatible descent |
| IndCoh.qcohAction | [IndCoh] §1.4 | derived tensor action, coherences |
| IndCoh.psi_linear | [IndCoh] Lemma 1.4.2 | action compatibility of psi |
| IndCoh.tStructure | [IndCoh] §1.2 | Ind-extension of Coh t-structure |
| E2Algebra / HochschildCochains | [ArinkinGaitsgory] Appendices E.1–E.3, F.1 | enhanced algebra objects and endomorphisms of identity |
| HochschildEvenCentralAction | [ArinkinGaitsgory] §§4.1.1–4.1.2 | Hochschild cochains, graded center, canonical Sym(H¹T)→HH^even |
| GradedSupport | [ArinkinGaitsgory] §3.3 and §3.5 | homogeneous localization of graded central action; support in Spec graded ring |
| SingularSupport | [ArinkinGaitsgory] Def. 4.1.4 | Hochschild central action and GradedSupport |
| IndCohWithSupport | [ArinkinGaitsgory] Def. 4.1.5 | conical closed subset of Sing, full enhanced subcategory with support containment |
| IndCohWithSupportOnStack | [ArinkinGaitsgory] §8.2.3 | smooth descent of IndCohWithSupport |
| IndCohWithSupport.qcohAction | [ArinkinGaitsgory] Lemma 4.2.2, Cor. 8.2.4 | singular support stable under QCoh action |
| zeroSupport_equiv_qcoh | [ArinkinGaitsgory] Thm. 4.2.6; §8.2 | zero support, QCoh embedding Xi |
| coarseningWithSupport | [ArinkinGaitsgory] §§4.2, 8.2; [GLC1] §1.6.3 | IndCohWithSupport inclusion, psi, QCoh-linearity; equivalently Ψ_{Y,{0}} |
| supportTStructure | [ArinkinGaitsgory] §4.4.1 | support containing zero, coarsening, QCoh t-structure; connective part detected by psi |
| coarsening_tExact | [ArinkinGaitsgory] Cor. 4.4.3 | support t-structure, adjunction |
| coarsening_eventuallyCoconnective_equivalence | [ArinkinGaitsgory] Prop. 4.4.5; [GLC1] §1.6.3 | coarsening t-exact, bounded-below equivalence |
| QCohLS | [GLC1] §1.2 | QCoh(LocalSystemStack X dualG), with tensor and regular module action |
| IndCohNilp | [ArinkinGaitsgory] §11.1.5; [GLC1] §1.6.3 | LocalSystemStack, SpectralNilpotentCone, support IndCoh; induced action and t-structure |
| Psi | [GLC1] §1.6.3, §1.7.1 | coarseningWithSupport at SpectralNilpotentCone |

### AlgebraicGeometry / twisted D-modules and automorphic normalization

| Declaration/concept | Source | Dependencies / specification |
|---|---|---|
| DMod / RightCrystal | [Crystals] §2.3.2 and §5.5 | IndCoh(Y_dR), de Rham functor, enhanced sheaf theory; comparison with differential operators |
| DMod.extraordinaryPullback | [Crystals] §2.3; [CompactGeneration] §2.1 | ! pullback of IndCoh on de Rham prestacks |
| DMod.holonomic / partialShriekPushforward | [GLC1] §1.3.7; [CompactGeneration] §3.3 | holonomicity, Verdier duality, partial left adjoint of ! pullback |
| Gerbe / RootGerbe | [Crystals] §§6.1–6.3; [GLC1] §1.1.3 | etale descent, μ_n group, line bundles, nth-power map |
| TwistedDMod | [Crystals] §7.2; [GLC1] §1.1.3 | right crystals with prescribed gerbe character; weight condition essential |
| DeterminantOfCohomology | [GLC1] §1.1.1 | perfect derived global sections, determinant of perfect complexes |
| AssociatedAdjointBundle | [GLC1] §1.1.1 | principal G-bundle, adjoint representation, descent |
| NormalizedDeterminantBundleOnBun | [GLC1] §1.1.1 | det RΓ(X,g_P) ⊗ det RΓ(X,g_trivial)^(-1), variation in families |
| HalfCanonicalGerbeOnBun | [GLC1] §1.1.4 | square-root gerbe of NormalizedDeterminantBundleOnBun |
| DmodHalf | [GLC1] §1.1.4 | TwistedDMod(BundleStack X G, HalfCanonicalGerbeOnBun) |
| thetaCharacteristic_trivializes_halfGerbe | [GLC1] §1.1.2 | theta characteristic, Pfaffian/determinant square root construction; deeper original source is Beilinson–Drinfeld §4 |
| dmodHalf_compactlyGenerated | [CompactGeneration] Thm. 0.1.2; [GLC1] §§1.1.5, 1.6.4 | ordinary Dmod(Bun_G) compact generation and untwisting equivalence |
| TwistedUnipotentBundleStack | [GLC1] §1.3.1 | Bun_B ×_{Bun_T} {P_T}; choose P_T=rhoOmegaTBundle |
| forgetUnipotentReduction | [GLC1] §1.3.1 | extension B→G of structure group |
| determinantPullbackConstantLine | [GLC1] §1.3.1 | determinant on Bun_G, TwistedUnipotentBundleStack |
| determinantPullbackSquareRoot | [GLC1] Prop. 1.3.3, Cor. 1.3.4 | theta characteristic, Serre duality, Weil pairing/determinant formula, opposite nilpotent radicals |
| twistedUnipotentPullback | [GLC1] §1.3.5 | preceding trivialization, DMod.extraordinaryPullback |
| WhittakerCharacter | [GLC1] §1.3.6 | simple-root quotients, extension classes, trace H¹(X,ω_X)→k, pinning, addition on Ga |
| ExponentialDModule | [GLC1] §1.3.7 | Ga, D-module (connection d−dx), additive character property; normalization exp∈heart[-1] |
| WhittakerExponential | [GLC1] §1.3.7 | * pullback of exp along WhittakerCharacter, holonomicity |
| VacuumPoincare | [GLC1] §1.3.7 | partially defined p_! applied to WhittakerExponential; prove definedness on this object |
| vacuumPoincare_compact | [GLC1] §1.4.2 | compactness criterion and the particular Whittaker construction |
| VacuumWhittakerCoefficient | [GLC1] §1.3.8 | enhanced Hom from VacuumPoincare to object, value in DerivedVect k |

Correction after the second review: constructing the spectral action includes proving its factorization theorem. Its proof reaches Kac–Moody localization and parabolic Eisenstein compatibility, independently of a separate proof of Corollary 1.6.5. The original inventory omitted that proof chain and the geometric Satake inputs; see the findings-resolution report for the repaired nodes and remaining source limits.

### AlgebraicGeometry / Ran, Hecke and spectral action

| Declaration/concept | Source | Dependencies / specification |
|---|---|---|
| DeRhamRanSpace | [GaitsgoryOutline] §4.1.1 | finite nonempty subsets of maps S_red→X, or colimit over finite nonempty sets and surjections |
| RanUnion | [GaitsgoryOutline] §4.1.4 | union of finite subsets; commutative semigroup structure |
| FormalDiscAtRanPoint | [GaitsgoryOutline] §4.1.3 | formal completion along union of graphs in S×X |
| SpreadPrestackOverRan | [GaitsgoryOutline] §4.2.1 | maps from formal-disc de Rham prestack, relative fiber product over S_dR |
| RepRan | [GaitsgoryOutline] §4.2.4 | QCoh of spread B dualG, not a product of ordinary representation categories |
| RepRan.convolution | [GaitsgoryOutline] §4.2.3 | restriction to discs, Ran union, pull-push; natural non-unital symmetric monoidal structure |
| SpectralEvaluation | [GaitsgoryOutline] §4.3.1 | restriction LocalSystemStack×Ran→spread B dualG |
| SpectralLocalization | [GaitsgoryOutline] §§4.3.1–4.3.3; [GLC1] §1.2.2 | (id×p)_! ev*, monoidal structure; required adjoints |
| spectralLocalization_rightAdjoint_fullyFaithful | [GaitsgoryOutline] Prop. 4.3.4; [GLC4] Prop. C.1.7, Cor. C.1.8 and proof §C.4 | passability, QCoh kernel/base-change calculus, relative affine factorization homology on unital-image objects, Ran homology |
| HeckeStackRan | [GaitsgoryOutline] §4.4.1 | two G-bundles with isomorphism away from a finite set, left/right maps to Bun |
| HeckeConvolution / HeckeAction | [GaitsgoryOutline] §4.4.2 | DMod pull-push on correspondence, composition of modifications |
| NaiveSatakeRan | [GaitsgoryOutline] Prop. 4.4.4; [GLC1] §1.2.1 | geometric Satake, RepRan, HeckeStackRan; half-twisted version must respect determinant gerbe |
| repRanAction_factors_through_spectralLocalization | [GaitsgoryOutline] Thm. 4.5.2, Cor. 4.5.5; [GLC1] Thm. 1.2.4 | Satake-Hecke action, kernel vanishing, spectral localization |
| SpectralAction | [GLC1] §1.2.5 | action descending through spectral localization; actual QCohLS-module structure on DmodHalf |

### Statement / characterization

| Declaration/concept | Source | Dependencies / specification |
|---|---|---|
| TemperedLeftFunctor | [GLC1] §§1.4.1–1.4.2 | SpectralAction evaluated on VacuumPoincare |
| temperedLeft_preserves_compact | [GLC1] §1.4.2 | vacuum compactness, QCohLS rigidity and compact generation |
| LCoarse | [GLC1] §1.4.5 | enhanced right adjoint of TemperedLeftFunctor, continuity, QCoh-linearity |
| globalSections_comp_lCoarse_iso_coefficient | [GLC1] §1.4.6 | adjunction and evaluation at unit of QCohLS |
| IsLanglandsFunctor | [GLC1] Cor. 1.6.5; Prop. 1.7.2 for linear form | compact→eventually-coconnective, specified linear natural equivalence Psi∘F ≃ LCoarse |
| Main existence-and-universal-equivalence assertion | [GLC1] Cor. 1.6.5 and Conj. 1.6.7 | ∃ F, characterization F, and ∀ F, characterization F → equivalence F; only admitted theorem |

If the owner requests a separately proved Corollary 1.6.5 before the main theorem, its proof additionally requires [GLC1] Theorem 1.6.2 (coarse functor sends compacts to bounded-below objects), the compact-generation theorem, and the bounded-below coarsening equivalence. That reaches [GLC1] §2 and its localization estimates. The requested conjunction form deliberately avoids needing a separately admitted construction of LG; it must not claim to have proved those auxiliary results.

## Boundary cases / examples required before placeholder replacement

- G=1: Bun and LS identify with the point, automorphic and spectral categories with DerivedVect k, nilpotent cone is zero, normalized determinant gerbe trivial, and functor identity. This tests field parameter, universe, nonvacuity and shifts.
- G a torus: nilpotent cone is zero and IndCoh_Nilp ≃ QCoh ([GLC1] §1.5.4). Do not assert QCoh equals all IndCoh, since LS can still be derived singular. [ArinkinGaitsgory] §11.2 gives examples.
- Smooth affine scheme: IndCoh→QCoh equivalence ([IndCoh] Lemma 1.1.6); compare crystals with classical D-modules on smooth affine space ([Crystals] §5.5).
- Singular derived affine scheme: nonzero singular support example distinguishes IndCoh from QCoh; [ArinkinGaitsgory] §5.1 (derived self-intersection of zero in a vector space) provides an explicit Koszul model.
- Nilpotent zero section included; arbitrary conical support lacking zero is not eligible for the same coarsening t-structure.
- Rho itself need not be integral; use integral 2ρ with chosen theta characteristic.
- Every A-linear natural equivalence belongs to the actual functor category; no automatic Nonempty instance for arbitrary pairs. Nonempty continuous-functor type may be justified by the zero functor only after stable module categories and linearity are constructed.

## Source additions made

Added [Crystals] 1111.2087v4, [GaitsgoryOutline] 1302.2506v3, [CompactGeneration] 1112.2402v8 to docs/references.bib and docs/papers.md, downloaded pinned TeX to references/papers/<version>/src. These were verified against arXiv metadata and source. Source links: https://arxiv.org/abs/1111.2087v4, https://arxiv.org/abs/1302.2506v3, https://arxiv.org/abs/1112.2402v8. This inventory informed the library plans and the revised statement.

The repair expands this original inventory with fetched primary proof sources, all pinned in `docs/references.bib` and cataloged in `docs/papers.md`. It includes MV/GLys and de Rham Satake enhancement; DG2 and DGIndschemes for finiteness; GLC2/GLC3 and derived Satake/critical-center inputs for spectral vanishing; and GLC4 Appendix C, GRQCoh, BDChiral chapter 4, Ran contractibility and OneAffineness for spectral localization. `notes/blueprint-gap-resolution.md` records the exact proof chains and their scope. This inventory is a navigation aid; the module plans contain the current declaration dependencies. In particular, a theorem citation alone is no longer treated as evidence that its proof inputs have been covered.
