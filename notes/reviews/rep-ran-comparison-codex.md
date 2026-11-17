**Independent assessment of the two presentations of Rep(Ǧ)_Ran**

2026-11-17. Repository state: `91b6cb0`. This assesses part B, “Points for the owner”,
point 1 of `notes/reviews/b8587fb.md` against the current plan. It proposes changes;
it does not apply them.

**Recommendation: (a), with the comparison and its prerequisites factored into a
general API.** Keep `Ran.Representations` canonically defined as QCoh of the spread
classifying stack. Move the existing comparison and its dependency closure into
`plans/`. State the comparison with its de Rham descent data, so that its D-module
and affine-parameter forms are consequences of one construction. Extract the
general collision-category results currently hidden inside
`Ran.Representations.linearFunctorEquivComodule`. Do not maintain two independent
comparisons, or two representation categories with parallel APIs.

The reason is mathematical, not just the dependency rule. Raskin's chosen proof
already uses much of the supposedly proof-only infrastructure for its D-module
conclusion. The affine-parameter form also has an actual consumer:
`Hecke.spreadClassifyingStack_passable`. These are useful general results, rather
than generality invented for a possible future application. There is no short,
complete proof of (b) or (c) supplied by the cited passages. This is a statement
about the available proof routes, not a claim that a shorter proof is impossible.

I read the specified plan files and both plan READMEs, [GLC1] §1.2.1,
[GaitsgoryOutline] §4.2 (and the adjoining definitions in §4.1), and
[RaskinCPSI] §§6.8–6.32 and Appendix A in the TeX listed in `docs/papers.md`.
For Raskin I also read §§6.5–6.7, the conversion findings, and checked the important
formulas and diagrams against PDF pages 40, 44–46, 50 and 66. The converted TeX
contains damaged indices and diagram images; the assertions below use the printed
formulas. I computed the current transitive dependency closure rather than taking
the review's count on trust.

**What must be compared.** Work over the algebraically closed characteristic-zero
field of the project, with X a smooth separated curve of finite type; properness
is not needed for this comparison. Write B_I = (X^I)_dR and let Z_I be the pullback of
(BH)_Ran to B_I. The plan's category is QCoh(Z_I), linear over
QCoh(B_I) ≃ Dmod(X^I). Here H is an affine algebraic group, not necessarily the
particular pinned dual group. [GaitsgoryOutline] §4.2.1 defines the spread using
maps from

`(D_x)_dR ×_{S_dR} S`

to BH. The final factor S matters: this is relative de Rham geometry, retaining
the parameter's infinitesimal structure. Section 4.2.2 computes the fibre over a
configuration of distinct k-points; §4.2.4 defines Rep(H)_Ran as QCoh of that
prestack. [GLC1] §1.2.1 refers to this definition and uses its Satake action. It
does not supply the comparison with Raskin's construction.

Raskin first constructs, for a presentable symmetric monoidal DG category C whose
tensor product preserves colimits separately, the category

`C_{X^I} = lim_{(I ↠p J ↠q K) ∈ S_I} (Dmod(U(p)) ⊗ C^{⊗ K}).`

The open U(p) requires points in different p-blocks to be distinct; points in
the same block need not coincide. The arrows combine open restriction with
multiplication in C. The general construction precedes the compact-generation
and rigidity assumptions of §6.15. Only in §6.19 does Raskin specialize to
C = Rep(H). This is the natural order for the library too.

There are two different changes of presentation to keep separate. Lemma 6.16.2
identifies extension of scalars of this categorical limit from Dmod(X^I) to
QCoh(X^I) with the limit having QCoh(U(p)) as coefficients. The geometric
comparison must identify that construction, with its descent data, with QCoh of
the actual spread stack. The first identification does not prove the second.
An equivalence after forgetting to X^I, without compatibility with descent along
X^I → B_I, is not enough to recover the required Dmod(X^I)-linear equivalence.

The comparison should preserve the forgetful functor and the regular object,
including the coalgebra used in the comodule description, as well as diagonal
pullback and disjoint factorization. An abstract equivalence of the underlying
categories would not identify the particular Hecke functor. The regular object
inside the representation category and its underlying coalgebra in Dmod(X^I)
must also be distinguished when typing `F ↦ F(O_{H,X^I})`.

**Why the general prerequisites belong to the statement's plan.** The published
route to Lemma 6.32.1 has the following substantive steps:

1. Lemma 6.16.2 uses one-affineness of X^I and B_I to pass from the D-module
   collision diagram to its QCoh version. Lemma 6.17.2 supplies the formal-support
   localization used in proving ULA generation in Theorem 6.17.1.
2. Appendix A.3 again uses one-affineness of X^I and B_I. It proves Lemma 6.18.1
   by induction on |I|. Away from the full diagonal, cover by U(p) with more than
   one block, apply factorization and induction, and use descent for sheaves of
   categories. Across the full diagonal use the pullback criterion of Lemma
   A.2.1. The continuous right adjoints and the fully faithful right adjoint to
   one arrow are essential hypotheses of that criterion.
3. Corollary 6.18.2 supplies self-duality. Proposition 6.22.1 constructs the
   continuous linear right adjoint of the forgetful functor and identifies its
   value on the unit with the regular object. Its proof uses the ULA results and
   Proposition B.7.1, not just the existence of an abstract right adjoint.
4. Lemma 6.23.2 applies Lemma 6.18.1 with an arbitrary Dmod(X^I)-module D, then
   checks comonadicity term by term. It expressly invokes one-affineness of
   finite-type group classifying stacks through [OneAffineness] Theorem 2.2.2
   and Lemma 5.5.4. Self-duality and this comonadicity give Lemma 6.32.1.

Thus “whose long proof is an obligation here” in `RegularComodule.toml` already
commits the statement to general gluing and one-affineness results. Moving only
Barr–Beck–Lurie does not expose that dependency. The thirteen nodes are the
closure of the *current planned proofs* of those foundations; they are not a
proof that all thirteen are logically indispensable under every possible proof.

This organization meets the project's rule to prove the general result before
its special case. The generic collision construction has the concrete user
C = Rep(H); the generic tensor-limit theorem has the concrete user
`linearFunctorEquivComodule`. Conversely, there is no need here to assert a
comparison for every prestack Y merely because the spread prestack can be
defined for every Y. Use the hypotheses that establish the QCoh comparison.
The categorical construction needs no reductivity; the rigidity results need
rigidity. For the representation specialization, prove the needed rigidity of
Rep(H) for the asserted class of H. The current group node explicitly supplies
it for reductive H in characteristic zero, which covers Ǧ. Do not silently use
a theorem for all H with only this special-case provider.

Mathlib's published standards emphasize generality, integration and
maintainability. Its style guide also favors a standard form and an API that
avoids clients relying on unfolding. Here the explicit requirement of one
canonical definition and the prohibition on unused abstractions come from
this project's AGENTS.md and the owner's instructions; they should not be
presented as a Mathlib ban on useful equivalent presentations.
See [Mathlib's contribution principles](https://leanprover-community.github.io/contribute/index.html)
and [its style guide](https://mathlib.org/contribute/style.html).

**Assessment of (b) and (c).** A narrow D-module comparison is a legitimate
theorem. Having it as a corollary alongside a general comparison is not
duplication. What I would avoid is an independent proof and API in `plans/`
while retaining essentially the same geometric construction in `plans-proof/`.
Dropping the words “every affine S → X^I” does not remove the one-affineness
steps above, and it does not by itself prove a comparison over B_I.

There is a short *final deduction* for (b) once the general comparison is in
place: identify the geometric and collision sheaves of categories over B_I,
take sections using one-affineness, identify QCoh(B_I) with Dmod(X^I), and
transport the regular object, forgetful functor and their compatibilities.
The affine-parameter version is then obtained from the same comparison by
localization and scalar extension, with tensor-limit interchange justified
by the proved categorical results. This is not a short independent proof that
would justify leaving those results in `plans-proof/`.

For (c), the plausible direct route would construct the forgetful functor on
QCoh(Z_I) from the trivial torsor, prove a continuous B_I-linear right adjoint
and identify its comonad with the regular coalgebra, prove comonadicity after
tensoring with every D, and prove the appropriate self-duality of QCoh(Z_I).
The last two steps are precisely substantial assertions supplied by Raskin's
collision method. Neither [GaitsgoryOutline] §4.2 nor [GLC1] §1.2.1 proves them
directly for Z_I. Its k-point fibres do not establish them. I therefore cannot
recommend (c) as a shorter source-backed route.

Raskin does point out a genuine saving in Remark 6.18.3: tensoring with the
particular spherical category is easier because that coefficient category is
dualizable. Footnote 32 also says self-duality alone is weaker and more direct
than the full tensor-limit theorem. These observations concern the categorical
part; neither identifies QCoh(Z_I). They could support a different, specialized
Satake implementation after its dualizability has been proved. They do not
prove the current node, which quantifies over every D, and are not a reason to
replace a useful general theorem with a special case in this assessment.

**What (a) still has to prove.** Moving nodes is not a proof of the comparison.
The existing description's “formal Taylor descent” names work to be done;
the cited Raskin passages do not discharge it. A reasonable construction to
investigate is to compare horizontal H-torsors and their representations on
the relative formal discs with the compatible collision data, then identify
the QCoh categories by descent. It must establish the gluing across collisions
and the de Rham descent datum, not merely the descriptions on individual
strata. Appendix A controls tensoring the resulting categorical limit; it does
not provide this geometric descent theorem. This remains a distinct proof
obligation requiring review. I recommend retaining it visibly in the statement's
plan, rather than treating the references as an already complete proof.

The first useful verification is the two-point case. With U = X² minus the
diagonal, Raskin's category is the pullback

`(Dmod(X²) ⊗ Rep(H)) ×_{Dmod(U) ⊗ Rep(H)} (Dmod(U) ⊗ Rep(H)^{⊗2}).`

The two maps are open restriction and restriction of representations along
H → H × H, respectively ([RaskinCPSI] Examples 6.6.2–6.6.3). Establish this
description for the geometric Z_2, including its parameter dependence. It tests
the information along the diagonal that the distinct-point calculation misses.
Also check one point, H the trivial group, and the fibre at distinct points.
Use nonempty finite I for the Ran statement; if the general categorical API
includes I empty, give its value Vect separately rather than silently adding an
empty configuration to the paper's Ran space. These are examples required when
replacing placeholders, not hypotheses to put into a new “comparison data”
structure.

**Concrete changes I recommend to the plan.** Move the following existing nodes
from `plans-proof/` to `plans/`, keeping their current providers. Prefix every
id in this table with `GLCinLean.`; paths are relative to the respective plan
root. The count is fourteen including the comparison, as the review says.

| Module path | Nodes to move |
| --- | --- |
| `GLCinLean/AlgebraicGeometry/Ran/RepresentationDescent.toml` | `Hecke.spreadClassifyingStack_collisionDescent` |
| `GLCinLean/AlgebraicGeometry/Sheaves/Categories.toml` | `Sheaves.sheafOfCategories`, `Sheaves.isOneAffine` |
| `GLCinLean/AlgebraicGeometry/Sheaves/OneAffineness.toml` | `Sheaves.qcSeparatedScheme_oneAffine`, `Sheaves.finiteTypeGroupClassifying_oneAffine`, `Sheaves.formalVector_qcohIndcohComparison`, `Sheaves.formalVectorClassifying_oneAffine`, `Sheaves.finiteTypeScheme_deRham_oneAffine`, `Sheaves.oneAffine_baseChangeAndCompletion` |
| `GLCinLean/AlgebraicGeometry/Sheaves/FormalCompletion.toml` | `Sheaves.formalCompletion_moduleSupport` |
| `GLCinLean/AlgebraicGeometry/Sheaves/Passable.toml` | `Sheaves.passable`, `Sheaves.passable_tensorBaseChange` |
| `Roadmap/EnhancedDerivedSheaves/Gluing.toml` | `Infinity.localizationPullback_dualizable` |
| `Roadmap/EnhancedDerivedSheaves/Monadicity.toml` | `Infinity.finiteMultiplicityProduct_isMonadic` |

`Infinity.barrBeckLurie` is already in `plans/` at the inspected commit.
Do not move `Hecke.spreadClassifyingStack_passable`, the QCoh kernel theorem,
Ran convolution, the lax-monoidal algebra variant, or the spectral action merely
because they use these foundations. Their current users can remain in
`plans-proof/`. Moving the general predicate `Sheaves.passable` does require a
proved example available in `plans/`, such as an affine scheme; its current
description points only to a proof-plan example.

Add explicit nodes for the following obligations, rather than burying them in
one large functor-equivalence definition. These are suggested ids and scopes,
not new Lean declarations or approved plan entries:

| Suggested id after `GLCinLean.` | Scope and source |
| --- | --- |
| `Ran.CollisionCategory` | The general diagram, its limit universal property and functoriality; diagonal and disjoint-factorization API. [RaskinCPSI] §§6.5–6.11. No rigidity assumption for the definition. |
| `Ran.collisionCategory_tensorEquivLimit` | Tensor-limit interchange for compactly generated rigid symmetric monoidal C and arbitrary D. Lemma 6.18.1 and Appendix A; use the general localization-pullback theorem. |
| `Ran.collisionCategory_selfDual` | Self-duality with its evaluation and coevaluation, under the applicable rigidity hypotheses. Corollary 6.18.2. |
| `Ran.collisionCategory_ula` | ULA generators and ULA generation for rigid C, with the needed ULA/continuous-adjoint API provided generally. Proposition 6.16.1, Lemma 6.16.2, Theorem 6.17.1 and Proposition B.7.1. |
| `Ran.Representations.regularObject` | The actual regular object and underlying coalgebra, forgetful functor and continuous linear right adjoint, with diagonal and factorization compatibilities. §§6.13–6.14, 6.21–6.22. |
| `Ran.Representations.forgetfulTensor_comonadic` | Universal comonadicity, including identification of the comonad. Lemma 6.23.2. |

The abstract ULA and adjoint infrastructure must be checked against the
EnhancedDerivedSheaves roadmap and existing upstream declarations before adding
local nodes; it should not be reimplemented inside the Ran files. The general
gluing and monadicity nodes already have that roadmap as provider. The table
specifies the mathematical obligations to expose, not a claim that six new local
implementations are all necessary. Routine one-point, trivial-group and
two-point examples can accompany these nodes and the comparison.

Keep `Ran.Representations` as the QCoh definition with its restriction API.
Make the moved comparison identify that object with the application of the
general collision construction, naturally over the de Rham base and after
affine scalar extension. Its geometric comparison and the categorical
tensor-limit theorem should have separate proofs. Give the comparison a
canonical home under `Ran` rather than `Hecke` when it is implemented; any
rename must update all uses as AGENTS.md requires.

Update `Ran.Representations.linearFunctorEquivComodule` to depend explicitly on
the comparison, self-duality, the regular-object API and universal comonadicity.
Its source list should include Proposition 6.22.1. Keep its arbitrary D
generality. `Satake.naiveFactorizationFunctor` then uses this single transported
API, while `Spectral.localization` continues to use the canonical geometric
definition. Only the intrinsic tensor structures needed for these arguments
belong here; this does not move the Ran convolution or the lax-monoidal
strengthening back into the statement's plan.

**Corrections and qualifications to the review.** Its central diagnosis is
right, and its fourteen-node count is right for the current dependency graph.
I find the following parts misleading or incomplete:

- The suggestion that the long proof of Lemma 6.18.1 could already cover the
  comparison conflates two obligations. Appendix A starts with the categorical
  collision construction; it never identifies it with the spread classifying
  stack. These are not the same theorem just because their proofs share tools.
- Treating the thirteen prerequisites chiefly as the extra price of the
  arbitrary-affine comparison obscures their role in the existing D-module
  proof. Appendix A.3, Lemma 6.16.2 and Lemma 6.23.2 show that role explicitly.
  This is why I do not share the preference for (b) based only on a hoped-for
  short comparison. One must compare the complete proof dependencies.
- “The D-module form” and “the QCoh form” need their bases specified. QCoh(Z_I)
  is already a Dmod(X^I)-module. The QCoh diagram over X^I is a scalar-extension
  presentation, and descent back to B_I is additional compatibility. Simply
  removing the affine-parameter clause from the current comparison does not
  state that compatibility.
- Merely adding the moved comparison to `RegularComodule.toml` would leave
  the regular-object/right-adjoint construction and the ULA steps implicit.
  The plan should expose these source obligations too.

I do not regard the review's *unsure* verdict as evidence that the mathematical
definitions disagree. It correctly identifies missing justification in the
plan. The recommendation is to make that justification a shared, fully proved
part of the statement's library, with the remaining geometric descent step
stated honestly as work still to do.
