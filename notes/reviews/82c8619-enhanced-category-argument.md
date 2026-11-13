# Review of the enhanced-category rule in `prompts/build.md`

Date: 2026-11-13. Reviewer: GPT-6 (Codex).

Reviewed revision: `82c8619`, together with the working-tree version of
`AGENTS.md` supplied for this review. In particular, its line 31 no longer gives
an ordinary category versus an enhanced category as the example of an unusable
upstream object. That pre-existing edit is not part of this report's changes.

Scope: the argument for `prompts/build.md`, line 19, rather than a new review of
every definition in the statement or plan. No Lean definition, plan node, or
policy is changed by this report. The replacement below is a proposal.

## Findings for the owner

The rule is sound as a prohibition on replacing the statement's enhanced
categories by their ordinary homotopy categories. It is too compressed to make
its scope clear. The supplied argument overstates what homotopy categories
forget and what cannot be checked in them. Its other three safeguards are
justified, with the qualifications below.

| Part | Verdict | Reason |
| --- | --- | --- |
| 1. Enhanced categories | **Disagree with the argument as written; agree with the rule in its intended scope.** | Coherent categorical constructions and the specified mapping-space equivalence require enhancements. But homotopy categories retain shifts, triangles, shifted Hom groups, t-structures, and some limits and colimits. The conclusion is not the only information that can be checked there. |
| 2. Ground field | **Agree**, for the uniform statement over the original field. | The de Rham DG categories and functors are `k`-linear. An embedding of arbitrary `k` into ℂ cannot be assumed. Comparisons over ℂ and through a common smaller field are allowed. |
| 3. Universes | **Agree**, as a requirement on mathematical size conventions. | The universe defining small diagrams matters. The particular offset `u + 2` and fully explicit syntax at every use are not mathematical necessities. |
| 4. t-structures | **Agree**, for the specified geometric t-structure. | The boundedness condition must use the standard t-structure in the paper. An arbitrary existential choice can erase that condition. “No canonical t-structure” needs qualification: particular geometric categories have natural ones, and every stable category has degenerate ones. |

There is no unresolved *unsure* verdict in this scope. Agreement here concerns
the intended mathematical interfaces. The Lean primitives are still
placeholders: their types and docstrings do not prove the categorical laws,
linearity, or boundedness properties discussed below.

## 1. What requires enhancement, and what survives in the homotopy category

### Sources and the current statement

[AGKRRV] §§0.9.2–0.9.4 uses mapping spaces and defines DG categories as
presentable stable ∞-categories with a module structure over complexes of
coefficients, using the Lurie tensor product. Morphisms preserve colimits.
This is the intended meaning of [Enhanced.lean](../../GLCinLean/Statement/Enhanced.lean),
lines 30–34 and 71–77. Its `DGFun.MapsEquiv`, lines 95–101, specifies a natural
equivalence of two space-valued functors on a product of categories. It is not
a family of unrelated bijections of Hom sets.

The need is concrete in the sources:

- [GaitsgoryOutline] §2.7.1 defines `QCoh` on a prestack by a limit over derived
  affines. [IndCoh] §§10.1.2–10.1.4 defines `IndCoh` by right Kan extension and
  gives its limit formula, on **locally almost finite type** prestacks with the
  specified affine tests. These are not unrestricted assertions about every
  conceivable prestack and every sheaf theory.
- [CompactGeneration] §1.6 explains the use of DG categories specifically by
  the need for limits with coherent transition data. Its §§2.1.1–2.1.2 gives
  D-modules on prestacks and the smooth-chart description for Artin stacks.
  This supplies the framework for `Bun_G`.
- [IndCoh] Definition 1.1.3 uses enhanced Ind-completion;
  [CompactGeneration] §1.3.1 states its universal property in categories of
  enhanced functors.
- [GaitsgoryOutline] §4.1.2 presents Ran as a colimit **of prestacks**;
  §§4.2–4.3 constructs the representation category, its monoidal structure and
  spectral localization. One should not conflate that prestack colimit with a
  categorical colimit. Pullback sheaf theories give limits; descriptions using
  colimits along adjoints need their own justification.
- [GLC1] §§1.2.1–1.2.5 supplies the Hecke action, localization and factorization
  of the action. Corollary 1.6.5 characterizes the Langlands functor, and
  Conjecture 1.6.7 asserts its equivalence.

[Conjecture.lean](../../GLCinLean/Statement/Conjecture.lean), lines 111–136, uses
the natural equivalence of mapping spaces in both variables. The explanation
in lines 119–130 correctly distinguishes this from an enriched equivalence:
mapping spaces alone do not record `k`-linearity. The equivalence with the
paper's characterization is for underlying ∞-functors; the functors themselves
are intended to be continuous and `k`-linear. This is also the distinction in
`STATUS.md`, the 2026-11-11 decisions U2 and “Obligations of the proof”.
Those comparison theorems remain proof obligations, not results established by
the present opaque `MapsEquiv` declaration. Nor does this argument justify
adding `QCoh(LS_Ǧ)`-module linearity as a new hypothesis on `F`.

### Corrections to the argument

“A homotopy category keeps none of these” is false. For a stable ∞-category
`C`, its triangulated homotopy category retains the groups

\[
\pi_n\operatorname{Map}_C(X,Y)
  \cong \operatorname{Hom}_{hC}(X[n],Y),\qquad n\geq 0,
\]

based at zero. Thus a single Hom group is π₀, but **all shifted Hom groups**
contain more information. They still do not supply the coherent composition,
diagrams, or the specified natural equivalence of space-valued bifunctors.
Existing enhanced monoidal structures descend to monoidal structures on
homotopy categories; arbitrary triangulated monoidal data is not thereby
proved to lift back.

Homotopy categories also retain coproducts that exist in the enhancement, and
t-structures are already data on the triangulated homotopy category
([LurieHA] Definition 1.2.1.4). In the presentable stable setting, compactness
can be tested by the usual triangulated condition that Hom out commutes with
small coproducts ([LurieHA] Proposition 1.4.4.1(3)). Consequently the first
characterization property can be read on the homotopy categories with the
specified t-structure and size convention. It is too strong to say that **only** the conclusion can be read
there and **none** of the hypotheses can.

The qualification about equivalence is correct. For an **already given exact
∞-functor** `F : C → D`, full faithfulness of `hF`, applied to all shifts,
implies that the induced maps of mapping spaces are equivalences.
Essential surjectivity of `hF` supplies the other condition. Hence `F` is an
equivalence exactly when `hF` is. This does not construct an enhanced functor
from an arbitrary triangulated equivalence. Likewise, checking an already
constructed comparison on shifted Hom groups is different from constructing
its coherent lift.

[GaitsgoryOutline] §0.5.1 makes essentially this distinction: the conjectural
equivalence can be perceived at the triangulated level, while its categorical
constructions require ∞-categories. The claim that homotopy categories do not
commute with limits should say **not in general**; products, for example, do
commute with passage to homotopy categories.

### Concrete failure prevented

Here is a failure inside stable `k`-linear categories, not just an analogy
with spaces. Let `C = D(k)` be the enhanced category of complexes, and let
`Bℤ` be the one-object groupoid with automorphism group ℤ. The limit of the
constant diagram with value `C` indexed by `Bℤ` is
`Fun(Bℤ, C)`, the category of coherent ℤ-actions. It identifies with
`D(k[t,t⁻¹])`. Give `k` and `k[1]` trivial actions. Then

\[
\operatorname{Hom}_{h\operatorname{Fun}(B\mathbb Z,C)}(k,k[1])
 =\operatorname{Ext}^1_{k[t,t^{-1}]}(k,k)=k.
\]

The last equality follows from the free resolution with differential `t − 1`;
after applying `Hom(−,k)` that differential is zero. In contrast, in
`Fun(Bℤ, hC)` a natural transformation between these two diagrams has a
component in `Hom_{D(k)}(k,k[1]) = 0`. Thus the natural comparison from the
homotopy category of the enhanced limit is not faithful, even if the ordinary
replacement uses the **2-limit**, which remembers actions and isomorphisms.
The ordinary strict limit does not repair this failure.

An even smaller test for replacing a mapping space by a Hom set is
`Map_{D(k)}(k,k[1]) ≃ K(k,1)`. It and `Map(k,0)` have the same singleton π₀,
but their π₁ groups differ. This tests the loss from using just one Hom set;
it does not contradict recovery of homotopy groups from all shifts.

These are mathematical counterexamples to the proposed replacements, not
claims that the current placeholders have already excluded them in Lean.

## 2. The field and linearity

**Agree with preserving arbitrary `k`; interpret the prohibition as “do not
assume an embedding of the original arbitrary field”.** A blanket ban on
every comparison involving ℂ would be unjustified.

[GLC1] §0.1.1 starts with a field of characteristic zero. Its §0.5.7 says that
conventions largely follow [AGKRRV]. [AGKRRV] §0.9.1 distinguishes the geometric
field from the coefficient field and identifies them in the D-module case.
[GLC2] §0.4.1 expressly fixes an algebraically closed field of characteristic
zero. This supports the project's scope; it would be inaccurate to attribute
the algebraic-closedness hypothesis directly to [GLC1] §0.1.1.

`Enhanced.lean`, lines 28–77, retains `k` and requires only `[Field k]` for the
generic categorical placeholders. `Conjecture.lean`, lines 46–74 and 153–157,
has the geometric setting and theorem over arbitrary `k` with `[CharZero k]`
and `[IsAlgClosed k]`. These typeclass hypotheses are parameters, not a
specialization to ℂ. “Everything is `k`-linear” should refer to the de Rham DG
categories and functors: the mapping-space comparison is not itself specified
as enriched, and the auxiliary constructible theory has a separately named
coefficient field `E`.

The 2026-11-13 decisions do not force all field hypotheses onto all
definitions. Decision 5 and the corresponding open item expressly defer
removing the currently unused `[CharZero k]` and `[IsAlgClosed k]` from
`Setting`; they will belong on constructions and the theorem that need them.
This agrees with the natural-generality rule in `AGENTS.md`.

The permitted comparison is visible in
[Satake/Spherical.toml](../../plans/GLCinLean/GeometricLanglands/Satake/Spherical.toml),
the node `Satake.ic_starRestriction_isEven`: use split Schubert models over
`Q̄`, compare their base changes to `k` and ℂ, and transfer the calculation
using scalar extension and base change of Hom. No arrow `k → ℂ` is needed.
The 2026-11-13 decisions retain scalar extension along arbitrary extensions
of characteristic-zero fields. Its compatibility and Hom theorems remain
explicit adaptation obligations; this review does not certify their proofs.
This is consistent with [JuteauMautnerWilliamson] §2.1 and [MV] §1, where the
geometry is over ℂ and the coefficient ring is a separate matter.

**Concrete excluded field.** Take an index set `I` with cardinality greater
than `|ℂ|` and let

\[
k=\overline{\mathbb Q(t_i\mid i\in I)}.
\]

This is an algebraically closed characteristic-zero field. An embedding into
ℂ would inject its algebraically independent generators into ℂ, impossible
even by cardinality. A theorem with an additional `k → ℂ` embedding hypothesis
would therefore omit legitimate instances of the project's statement. This
is not a counterexample to GLC. It is a counterexample to that proposed
reduction. The common-field comparison through `Q̄` is still available.

## 3. Universe bounds and smallness

**Agree with retaining size conventions.** `DGCat k : Type (u + 2)` is the
actual signature in `Enhanced.lean`, line 34; objects are in `Type (u + 1)`
(lines 53–56), functors in `Type (u + 2)` (lines 72–77), and natural
equivalences and `MapsEquiv` in `Type (u + 1)` (lines 93–101).

Those signatures allocate carriers. They do **not** yet specify the universe
of test diagrams or establish accessibility or presentability. A replacement
must give compatible bounds for objects, morphisms or mapping spaces, indexing
diagrams and the categories of categories. Merely retaining the text
`u + 2` does not discharge that obligation. Conversely, the papers do not
mandate that particular Lean universe offset; an adequate future construction
may organize the levels differently.

[CompactGeneration] §1.3.1 assumes an essentially small input to Ind-completion;
its §1.1.1 explicitly sets aside set-theoretic details while referring to
accessibility. For the foundations it cites, [LurieHTT] §1.2.15 fixes the meaning
of smallness relative to a universe; §5.3.5 constructs Ind-objects; and
Corollary 5.5.2.9 characterizes right adjoints by preservation of small colimits
between presentable categories. Thus these qualifications belong to the
theorems being used, even when a geometric paper suppresses their notation.

**Concrete size failure.** Fix universes `U ⊂ V`, with `U = V_κ` for a strongly
inaccessible cardinal κ, and a field `k ∈ U`. The category `Vect_U(k)` has all
`U`-small coproducts. Choose a `V`-small set `I` of cardinality κ. It cannot
have an `I`-indexed coproduct of copies of `k` inside `Vect_U(k)`: if `P` were
one, its universal property would give

\[
\operatorname{Hom}_k(P,k)\cong k^I.
\]

The left side is `U`-small and has cardinality below κ; the right side has
cardinality at least `2^κ`. The same obstruction applies to the enhanced
derived category `D_U(k)` and the degree-zero mapping groups. Calling this
category cocomplete for `V`-small diagrams is false. Assuming such
cocompleteness as a hypothesis makes an implication about this example
vacuous. Similarly, enlarging the universe used in Ind-completion permits
larger filtered diagrams and produces genuinely larger objects.

This is a semantic warning, not a prohibition on Lean's universe inference.
Implicit universe parameters have definite elaborated meanings, and Lean does
not prove a false mathematical statement merely because parameters are
implicit. The danger is proving a different size-restricted statement than
intended. Uniform conventions and explicit relations in the interfaces suffice;
writing every universe argument at every call is unnecessary. Nothing in W11.3
or the 2026-11-13 decisions changes this requirement or fixes a new size policy.

## 4. The specified t-structure

**Agree with the requirement; qualify the explanation.** A bare DG category
does not specify the geometric t-structure relevant to a boundedness claim.
However, particular constructions do supply natural t-structures:
[IndCoh] §1.2.1 constructs one on `IndCoh`, and [ArinkinGaitsgory] §4.4.1
specifies the supported version. Proposition 4.4.5 compares the nonnegative
parts via coarsening. [GLC1] §1.6.3 uses these t-structures, and Corollary
1.6.5 uses eventual coconnectivity for that choice.

This is precisely the intended distinction between `DGCat` and
`TStructuredDGCat` in `Enhanced.lean`, lines 38–45 and 63–69.
`IndCohNilp` in `Conjecture.lean`, lines 85–87, specifies the **standard**
t-structure. Lines 133–134 ask, for each compact `c`, that `F(c)` be bounded
below for this structure. The bound depends on `c`; there is no single uniform
bound and no arbitrary t-structure chosen to suit `F`.

This safeguard is independent of enhancement. A t-structure can be specified
on a triangulated homotopy category ([LurieHA] Definition 1.2.1.4). The planned
ordinary constructible category appropriately uses Mathlib's triangulated
t-structure API. A fixed finite shift of a t-structure also leaves its
eventually coconnective subcategory unchanged: the union ranges over all
integer bounds. Such a shift is **not** a counterexample to this particular
boundedness condition.

**Concrete degenerate choice.** Use the papers' cohomological indexing. On any
stable category `C`, the pair

\[
C^{\leq 0}=0,\qquad C^{\geq 0}=C
\]

is a degenerate t-structure: orthogonality is immediate and the truncation
triangle is `0 → X → X`. Its eventually coconnective part is all of `C`.
Consequently “there exists a t-structure for which images of compact objects
are eventually coconnective” imposes no restriction on a functor unless further
conditions exclude this choice. This also explains why the literal claim
“no canonical t-structure” is too strong: degenerate choices are available
universally, but are not the geometric structure intended here.

For a nonzero test functor, let `E = ⨁_{n≥0} k[n]` in `D(k)` and
`F(M) = M ⊗_k E`. This functor is continuous and `k`-linear, and `k` is
compact. In the standard cohomological t-structure, `F(k) = E` has nonzero
cohomology in arbitrarily negative degrees, so it fails the boundedness
condition. In the displayed degenerate structure, it passes automatically.
This trivializes **the first property only**; it does not prove the second
property or make the whole Langlands conjecture true for this example.

Excluding degenerate t-structures would remove this particular example, but
would still not identify an unspecified t-structure with the standard one in
the source. Conversely, one must not add completeness or nondegeneracy
hypotheses without checking them: [IndCoh] §1.3 studies the left completion,
and IndCoh is not generally left complete in its standard t-structure.

## Agreement with the decisions and the current `AGENTS.md`

**W11.3:** yes. `STATUS.md`, the 2026-11-10 decision 3 (line 104 at the reviewed
revision), requires the enhanced theory to use Mathlib quasicategories and
Tau Ceti's DG nerve and K-injective models under the accepted roadmaps. The
need for enhancement is not permission to start a competing foundation.

**2026-11-13, decision 3:** yes, on the intended reading. It chooses an ordinary
triangulated `Constructible.DerivedCategory` built from Mathlib, with no
enhanced dependencies. That category is an auxiliary tool in the parity
calculation, not a replacement for `DmodHalf`, `QCohLS`, `IndCohNilp` or
`RepRan`. [JuteauMautnerWilliamson] §2.1 explicitly works in a triangulated
constructible derived category with graded Hom groups; its parity methods
therefore support this decision. Decision 1 retains natural generality of the
constructible definitions and makes finite Schubert unions the instance used.
The construction need not be artificially limited to one parity calculation.

The current [Constructible/Complex.toml](../../plans/GLCinLean/AlgebraicGeometry/Constructible/Complex.toml)
says this explicitly. It still requires appropriate ordinary functoriality,
base change, duality and the chosen perverse t-structure; “ordinary” does not
remove those requirements. The statement plan uses it for parity. The wider
proof plan also names `Satake.regularSheafExt_complexComparison` as a use of
Riemann–Hilbert, so “only for parity computations” should not be read as a
permanent ban on other justified computations of ordinary derived Hom.

**Current `AGENTS.md`, line 31:** yes. Removing the example leaves the substantive
test intact: an upstream object may be replaced only if it cannot serve the
goal even in principle. An ordinary derived category can serve the planned
constructible parity goal, so it must be reused there. It cannot by itself
serve as the required enhanced categorical interface. Yet upstream complexes,
localizations and ordinary categorical APIs may be ingredients in constructing
that enhancement. Their reuse is not ruled out. The exception requires a
specific explanation of missing structure; the adjective “ordinary” alone is
not a license to duplicate them. These conclusions also respect line 32's
prohibition on weakening the statement and line 33's natural-generality rule.

The existing build line is thus compatible with both decisions when read as
“do not substitute an ordinary category for a required enhancement”. It would
conflict with the 2026-11-13 decision if read as a blanket ban on ordinary
derived categories anywhere in the dependency chain. Its wording should make
that distinction explicit.

## Exact proposed replacement

Replace `prompts/build.md`, line 19, with this single bullet:

> - Keep the enhancements needed for the statement's DG categories, coherent categorical constructions and mapping-space comparisons. Ordinary triangulated categories may be used for the planned constructible parity computations and other claims whose required structure they retain. Keep the ground field and linearity, the universe bounds defining smallness, and the specified t-structures in the mathematical interfaces. The statement remains over every algebraically closed field of characteristic zero, without assuming an embedding of that field into ℂ.

Here “in the mathematical interfaces” permits ordinary Lean inference while
requiring that the resulting signatures and meanings keep the relevant data.
It also permits proved comparisons over ℂ through a common field, without
silently restricting the theorem's quantification over `k`.

## Source locations

The local paper versions are the ones named by [docs/papers.md](../../docs/papers.md)
and [docs/references.bib](../../docs/references.bib). Section and result numbers
above are the papers' numbering; the checked local sources are:

| Key | Local source | Principal passages checked |
| --- | --- | --- |
| [GLC1] | `references/papers/2405.03599v3/src/functor.tex` | §§0.1.1, 0.5.7, 1.2.1–1.2.5, 1.4.1–1.4.5, 1.6.3; Cor. 1.6.5; Conj. 1.6.7 |
| [GLC2] | `references/papers/2405.03648v3/src/Loc.tex` | §0.4.1 |
| [AGKRRV] | `references/papers/2010.01906v2/src/text.tex` | §§0.9.1–0.9.5 |
| [CompactGeneration] | `references/papers/1112.2402v8/src/DBunG.tex` | §§1.1, 1.3.1, 1.6, 2.1.1–2.1.2 |
| [GaitsgoryOutline] | `references/papers/1302.2506v3/src/outline.tex` | §§0.5.1–0.5.2, 2.7.1, 4.1.2, 4.2–4.3 |
| [IndCoh] | `references/papers/1105.4857v7/src/IndCohtext.tex` | §§0.6.4–0.6.7; Def. 1.1.3; §§1.2.1, 1.3, 10.1.2–10.1.4 |
| [ArinkinGaitsgory] | `references/papers/1201.6343v4/src/singsupp.tex` | §4.4.1; Prop. 4.4.5 |
| [JuteauMautnerWilliamson] | `references/papers/0906.2994v3/src/paritysheaves_a.tex` | §2.1 |
| [MV] | `references/papers/math-0401222v5/src/Satake.tex` | §1, geometry over ℂ versus coefficients |

Two foundational references were checked in the author's online copies,
accessed 2026-11-13; no dependency pin or bibliography entry was changed:

- [LurieHA], [Higher Algebra](https://www.math.ias.edu/~lurie/papers/HA.pdf),
  September 18, 2017, §1.1.4, Definition 1.2.1.4 and Proposition
  1.4.4.1. It supplies the stable-category framework, exactness and the
  homotopy-category definition of t-structures. The equivalence criterion and the explicit examples above are
  explained directly rather than attributed to an unchecked theorem number.
- [LurieHTT], [Higher Topos Theory](https://www.math.ias.edu/~lurie/papers/HTT.pdf),
  §1.2.15, §5.3.5 and Corollary 5.5.2.9. This is a local citation label for this
  report, not a newly added bibliography key.

## Validation

After fetching the Mathlib and Tau Ceti caches with the configured Lake cache
settings, `lake build` passed with only the main theorem's existing `sorry`
warning, and `lake lint` passed. `lake env lean tools/check-statement-axioms.lean`
reported `sorryAx` only for the main theorem, whose axioms were exactly
`propext`, `Classical.choice`, `Quot.sound` and `sorryAx`. Local links and the
listed paper paths were checked. These checks validate the unchanged Lean
build; they do not turn the mathematical examples in this report into Lean
proofs.
