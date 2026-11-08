# AGKRRV, *The stack of local systems with restricted variation and geometric Langlands theory with nilpotent singular support*

- **Source:** D. Arinkin, D. Gaitsgory, D. Kazhdan, S. Raskin, N. Rozenblyum, Y. Varshavsky,
  arXiv 2010.01906 **v2** (v1 5 Oct 2020; v2 6 Apr 2022, the latest version),
  <https://arxiv.org/abs/2010.01906v2>. The arXiv record carries no journal reference
  [R, arXiv API and abstract page, 2026-11-08]; publication status not checked further.
- **Read from:** the v2 TeX source (one file `text.tex`, 31,501 lines) in
  `references/papers/2010.01906v2/src/` (Git-ignored). SHA-256 of `source.tar.gz`:
  `f20e49df5d0087e49f3c510bb91d5ce742f4cbc3864cce8a874c09ca77146775`, equal to
  `references/papers/manifest.toml` [R, `shasum`, 2026-11-08]. The PDF was not fetched, so the
  manifest's PDF hash is not re-checked.
- **Which version GLC I means.** GLC I's bibliography gives "arXiv:2010.01906" without a version
  (`functor.tex` l.4429–4431). v2 predates GLC I v1 (May 2024), so v2 is the only candidate
  [R dates; J]. All 46 located citations of AGKRRV in GLC I resolve at v2 (§2.5) [R by script].
- **Read:** the Introduction's "Contents", the overview of `LocSys^restr`, the overview of
  Langlands theory (in part) and all of "Notations and conventions" (l.999–1240, l.1729–1770,
  l.2056–2225); §1.1 and §1.4 (l.2318–2420, l.2689–2770); §4.1 up to Cor. 4.1.11
  (l.5215–5525); §14.1.1–14.1.3, §14.2.1 and §14.5 (l.15115–15190, l.15268–15300,
  l.15679–15740); all of §21.1–21.3 (l.20656–21160). Spot-checked the passages GLC I cites
  in §18.2–18.3 and Appendix E.5. **Not read:** the proofs, Parts II and III in general, §§22–25,
  Appendices A–D and F–H beyond their headings.
- **Section numbers** are those of v2, computed from the TeX by a counting script (theorem-like
  environments share the subsubsection counter, `text.tex` l.22–49; appendices start at l.24426)
  and checked against the content at each cited place. They were not seen in a compiled PDF
  [R by script, 2026-11-08].
- **Licence:** arXiv non-exclusive distribution licence 1.0 [R, abstract page, 2026-11-08]: cite
  and link only, never copy. The quotes below are a few words each.
- **Checked 2026-11-08.** Tags: [R] read directly, [S] a source's claim about itself, [E]
  estimate, [J] judgement. All tags dated 2026-11-08.

## 1. What it is

- A long research paper in four parts [R, "Contents", l.999–1024]:
  - **Part I** defines the prestack `LocSys^restr_Ǧ(X)` of local systems "with restricted
    variation" and studies its geometry (§§1–7).
  - **Part II** proves a spectral decomposition theorem: a "lisse" Hecke action on a category
    gives an action of `QCoh(LocSys^restr)` (§§8–13).
  - **Part III** studies `Shv_Nilp(Bun_G)`, sheaves on `Bun_G` with nilpotent singular support,
    and proves that Hecke eigensheaves have nilpotent singular support and that (for D-modules)
    sheaves with nilpotent singular support have regular singularities (§§14–20).
  - **Part IV** states a "restricted" geometric Langlands conjecture that makes sense for any
    sheaf theory, including ℓ-adic sheaves, and a trace conjecture (§§21–25).
- It works in three sheaf theories at once: Betti, de Rham (holonomic D-modules) and étale
  (`§1.1.1`, l.2342–2367) [R].
- Its "Notations and conventions" (l.2056–2225) are what GLC I adopts: "Notations and
  conventions in this paper largely follow those adopted in [AGKRRV]" (`functor.tex` l.1268)
  [R]. AGKRRV in turn says its notations "largely follow" GKRV (arXiv 1908.05420; l.2058) [R].

## 2. What it says that matters for GLCinLean

### 2.1 Conventions GLC I imports (task a)

From the Introduction's "Notations and conventions" [R, lines as given]:

- **Two fields.** A *ground field* `k`, "assumed algebraically closed, but of arbitrary
  characteristic" (l.2066), for the automorphic side; a *field of coefficients* `e`, algebraically
  closed and of characteristic zero (l.2087–2088), for the spectral side. They "do not generally
  mix unless we work with D-modules, in which case" `k = e` is of characteristic zero
  (l.2092–2093).
- **Geometry over `k` is classical.** `X`, `G`, `Bun_G` are classical (non-derived) and locally of
  finite type (l.2072–2083, citing GR1 Ch. 2 §1.6.1).
- **Geometry over `e` is derived.** Derived affine schemes are connective commutative algebras in
  `Vect_e`; every other object is a prestack, an accessible functor to spaces (l.2197–2215);
  `QCoh` of a prestack is taken from GR1 Ch. 3 (l.2219–2222).
- **Curve.** "In Parts III and IV ... `X` will be a complete curve" (l.2072). §14.1.1 (Part III)
  sharpens this to a "smooth, connected and complete curve" (l.15123). §1 already assumes `X`
  connected, because `LocSys^restr` uses a base point (l.2320).
- **Group.** "`G` will be a reductive group over `k`" (l.2072–2073); §14.1.1 again says only
  "reductive" (l.15123). The word "connected" is not attached to `G`. In Part I the spectral group
  is "a connected algebraic group" (l.2691). The Langlands dual is introduced in one sentence,
  "Let Ǧ denote the Langlands dual group of G" (l.15276), with no construction, as a group over `e`.
- **∞-categories.** Lurie's language; "categories" means ∞-categories (l.2097–2100). An object is
  compact if its Yoneda functor preserves filtered colimits (l.2111–2112).
- **`DGCat`.** "the ∞-category of presentable stable ∞-categories", with a module structure over
  `Vect_e` for the Lurie tensor product, citing Lurie HA §4.8.1 (l.2143–2145). "1-morphisms in
  DGCat are in particular colimit-preserving" (l.2146). `DGCat` is symmetric monoidal; monoidal DG
  categories are algebras in it, assumed unital (l.2156–2168).
- **t-structures.** Cohomological indexing; notation `C^{<∞}` and `C^{>-∞}` (the union of the
  `C^{≥-n}`) (l.2172–2180). By convention, t-structures are compatible with filtered colimits
  (footnote, l.2696–2697).

So **`DGCat` is fixed there as a convention (a pointer to Lurie), not constructed** [R]. The claim
in `further-jo-l-riou-...md` §3 that AGKRRV "defines `DGCat`" with that wording is correct [R],
and so is the "(AGKRRV conventions)" label in `GLCinLean/Foundations.lean` l.80–81 [R].

### 2.2 Where the objects are defined (task b)

| Object | Where | What it is |
|---|---|---|
| `LocSys^restr_Ǧ(X)` | **§1.4.2** (l.2707–2714), in §1.4 "Definition of `LocSys^restr` as a functor" (l.2689) | prestack over `e`: `S ↦` right t-exact symmetric monoidal functors `Rep(Ǧ) → QCoh(S) ⊗ QLisse(X)` [R]. `QLisse` is defined in §1.2–1.3 (l.2441–2688) [R]. Structure theorem: Main Thm 1.4.5 (l.2727) [R] |
| the map `LocSys^restr → LocSys^dR` | §4.1, eq. (4.2) (l.5262); monomorphism (lemma after it), formal isomorphism (Prop. 4.1.8, l.5390); closed embedding at the reduced level per component (Thm 4.1.10, l.5486) | [R] |
| **`LocSys^dR_Ǧ(X)`** (GLC I's `LS_Ǧ`) | **not defined in AGKRRV**. §4.1.1 (l.5236–5242) *recalls* it from "[AG, Sects. 10.1-2]": `S ↦` right t-exact symmetric monoidal functors `Rep(Ǧ) → QCoh(S) ⊗ Dmod(X)`. laft and deformation theory from AG; algebraic stack for proper `X` from "[AG, Sects. 10.3.8 and 10.4.3]" (l.5478–5480) | [R]. In AG v4, §10.1 is "Definition of `LocSys_G`" and §10.2 "A Tannakian description" (`singsupp.tex` l.7008, l.7078); 10.3.8 is the schematicity proposition and 10.4 "The case of curves" [R by script]. AGKRRV's "[AG, Proposition 10.3]" (l.5245) names a subsection, not a proposition (AG §10.3 "Basic properties") [R; J that it is a loose pointer] |
| `Nilp ⊂ T*(Bun_G)` (automorphic) | §14.1.2 (l.15133–15156) | pairs `(P_G, A)` with `A` nilpotent; half-dimensional in char 0, or for a "very good" prime (proof in App. D) [R] |
| `Shv_Nilp(Bun_G)` | §14.1.3 (l.15158) | full subcategory of `Shv(Bun_G)` (ind-holonomic in the de Rham case) [R] |
| `Sing`, `IndCoh_N` for quasi-smooth formal affine schemes | §21.1 (l.20673–20895) | adapts AG's singular support to formal schemes; compact generation (§21.1.7, l.20846–20862); `IndCoh_{0} ≃ QCoh` (§21.1.9) [R] |
| `Sing(LocSys^restr)`, `IndCoh_N(LocSys^restr)` | §21.2.3 (l.20936–20964) | via the rigidified version and the quotient by `Ǧ` [R] |
| `Arth_Ǧ(X)` and spectral `Nilp` | §21.2.4–21.2.5 (l.20966–20990) | `Nilp`: pairs `(σ, A)` with `A ∈ H^0(X, ǧ_σ)` nilpotent [R] |
| `IndCoh_Nilp(LocSys^restr)` | §21.2.5 (l.20988–20990) | full subcategory of `IndCoh(LocSys^restr)` [R] |
| restricted GLC | Main Conj. 21.2.7 (l.20996) | `Shv_Nilp(Bun_G) ≃ IndCoh_Nilp(LocSys^restr)`, compatible with the `QCoh(LocSys^restr)` actions [R] |
| `IndCoh_Nilp(LocSys^dR)` and the de Rham GLC | **not defined in AGKRRV**: §21.3.1 (l.21077–21084) recalls the conjecture from "[AG, Conjecture 11.2.2]", untwisted `Dmod(Bun_G)` | [R] |
| restricted ⇒ full | §21.4 (l.21162), under Hypothesis 21.4.2 (l.21172) | [R statement only] |

- AGKRRV itself warns that `Nilp` has two meanings on the two sides of the duality (footnote,
  l.1750) [R].
- `ω_X` also has two meanings: the dualizing sheaf of a sheaf theory, the unit for `⊗^!`
  (l.2380–2382), and the canonical line bundle (l.15136) [R].

### 2.3 The Lean chain, object by object (task c)

Defining source of each object in `GLCinLean/Abstract.lean` and `Foundations.lean`:

| Lean | Defining source | AGKRRV's role |
|---|---|---|
| `[IsAlgClosed k]` | AGKRRV l.2066; GLC II `Loc.tex` l.1497 [R] | **source** of the label |
| `[CharZero k]` | GLC I l.717; AGKRRV l.2092–2093 (D-modules: `k = e`, char 0) [R] | second source |
| `ConnectedSpace X` | AGKRRV l.15123 (and l.2320) [R] | **source** of the label |
| smooth, proper curve | GLC I l.718 [R] | agrees (l.15123) |
| `G` connected reductive | GLC I l.718 ("connected reductive") [R] | AGKRRV says only "reductive" (l.2072, l.15123) [R] |
| `pinning` | neither paper [R grep] | none |
| `sqrtOmega`, `sqrtOmegaIso` | GLC I l.1334 (citing [BD, Sect. 4]) and l.1510–1511 [R] | **none** (2.4) |
| `dualGroup`, `RootDatumDuality` | GLC I l.719 [R] | one sentence, no construction (l.15276) |
| `DGCat`, `DGCat.Obj` | AGKRRV l.2143–2146 (pointing to Lurie HA §4.8.1) [R] | **source** |
| `DGCat.IsCompact` | AGKRRV l.2111–2112 [R] | **source** |
| `DGCat.IsEventuallyCoconnective` | notation `C^{>-∞}`: AGKRRV l.2180; the t-structure on `IndCoh_Nilp`: AG §4.4 (see `further-arinkin-gaitsgory-...md`) [R] | notation only |
| `LinFun` ("continuous") | 1-morphisms colimit-preserving: AGKRRV l.2146 [R] | **source** of "continuous" |
| `LinFun.IsEquivalence` ("equivalence in DGCat") | AGKRRV conventions [R] | **source** |
| `DmodHalf` | GLC I §1.1 (l.1386–1394; gerbe of square roots of `det_{Bun_G}`) [R] | none: AGKRRV works with untwisted `Shv(Bun_G)`, `Dmod(Bun_G)` [R] |
| `QCohLS` | `LS_Ǧ`: AG §10.1–10.2, recalled in AGKRRV §4.1.1; `QCoh` of a prestack: GR1 Ch. 3 (AGKRRV l.2219–2222); spectral action: Gaitsgory, *Outline of the proof of GLC for GL(2)*, Cor. 4.5.5 (GLC I key `Ga2`, l.1458; AGKRRV key `Ga5`, l.15692) [R] | a one-line Tannakian definition of `LocSys^dR` (l.5238–5240), useful for a docstring |
| `IndCohNilp` | AG §11.1.5 (GLC I l.731, l.1820) [R] | none for `LS_Ǧ`; AGKRRV defines only the restricted version (§21.2.5) |
| `Psi` | AG Prop. 4.4.5 (GLC I l.1826) [R] | none |
| `LCoarse` | GLC I §1.4 (l.1723–1729) [R] | none |

So **none of the five chain placeholders traces to AGKRRV**. AGKRRV is the source of the
hypothesis labels "algebraically closed" and "connected" and of the categorical conventions behind
the `Foundations` layer (`DGCat`, compactness, continuity, `>-∞`, equivalence) [R table; J
summary]. The citations in `audit-lean.md` §2.2 and in the AG note §2.5 agree with this, with the
small corrections listed in §4.

### 2.4 The half twist and the square root of `ω_X` (task d)

- AGKRRV has no square root of `ω_X`, no `det_{Bun_G}`, no `μ_2`-gerbe and no half-twisted
  category [R, grep of `text.tex` for "square root", `\frac{1}{2}` (one hit, `q^{1/2}` at
  l.24043, about Frobenius weights), "gerbe", `det`, "twist"]. Its automorphic categories are
  untwisted throughout: the Hecke action of `Rep(Ǧ)` on `Shv(Bun_G)` (Thm 14.2.2, citing GKRV
  Prop. B.2.3; l.15276–15286) and the de Rham conjecture `Dmod(Bun_G) ≃ IndCoh_Nilp(LocSys^dR)`
  (l.21081–21084) [R].
- GLC I sets the twist up itself (l.1321–1405), citing [BD, Sect. 4] for the square root of
  `det_{Bun_G}` that `ω_X^{1/2}` induces (l.1334). It uses AGKRRV only through the untwisting
  `Dmod_{1/2}(Bun_G) ≃ Dmod(Bun_G)` (eq. `e:untwist`, l.1405): "the results from [AGKRRV]
  pertaining to `Dmod_Nilp(Bun_G)` apply" to the half-twisted version (l.1410–1412) [R].
- GLC I adds that the twisted version is "crucial" for the Hecke functors; otherwise `Rep(Ǧ)` has
  to be twisted by a canonical `Z_Ǧ`-gerbe ([GLys, Sect. 6.3], l.1414–1417) [R]. AGKRRV's
  untwisted `Rep(Ǧ)` action does not mention this [R]. Whether this is a difference of
  normalisation (absorbed by GKRV's set-up) or something more is not settled here [J; needs an
  expert].
- Consequence for the vacuity risk (`audit-lean.md` §2.3, `tauceti-library.md`: no square root
  of `ω_X` in Tau Ceti): this source does not help. The existence of a square root has to be
  argued from the curve itself (degree `2g−2` is even and, over an algebraically closed field, the
  Picard group of degree 0 is divisible) [J, standard, not checked against a source]. So
  `[IsAlgClosed k]` also makes the `sqrtOmega` field of `Setting` inhabitable, which a
  non-closed field might not [J].

### 2.5 How GLC I cites AGKRRV

- GLC I mentions AGKRRV 52 times before its bibliography, one of them in a comment (l.3436): 46
  citations with a location, plus l.846, l.1268, l.1410, l.3906, l.4044 without one [R count].
  Same number as in the GR note §2.3 [R].
- **Where:** 11 located citations in the Introduction (l.763–1252); **none in §1** (l.1304–2000,
  the statement), which mentions AGKRRV only at l.1410; the other 35 in the proofs: §2
  (de Rham estimates), §3 (Betti), §4 (restricted vs full) and §5 (eigensheaves) [R].
- **All 46 resolve at v2** to a unit of the stated kind with matching content, checked by script
  (e.g. Sect. 1.4 → definition of `LocSys^restr`; Eq. (4.2) → `LocSys^restr → LocSys^dR`;
  Prop. 14.5.3 → `Shv_Nilp` as a tensor product; Conj. 21.2.7 → restricted GLC; Sect. 21.4 →
  "A converse implication"; App. E.5, F.6, G → singular support and Betti sheaves) [R by script;
  content spot-checked for about 15 of them].
- One slip on GLC I's side: l.2312–2316 writes the tensor product over `QCoh(LS^restr_Ǧ)`, while
  AGKRRV Prop. 14.5.3 (l.15706–15718) and GLC I's own Introduction (l.986–987) have it over
  `QCoh(LS_Ǧ)` [R both; J that l.2312 is a typo].
- GLC I's l.3553 cites AG §11.1.6 for the compact generation of `IndCoh_Nilp(LS^restr_Ǧ)`. The
  closest statement for formal schemes is AGKRRV §21.1.7 (l.20860–20862), for quasi-smooth formal
  affine schemes, which `LocSys^restr` is not exactly (it is a quotient of a union of them by `Ǧ`)
  [R; J].
- Bibliography keys differ between papers for the same work: GLC I's `Ga2` is AGKRRV's `Ga5`
  (*Outline of the proof of GLC for GL(2)*, Astérisque 370) [R, `functor.tex` l.4514; `text.tex`
  l.31339].

## 3. What it means for GLCinLean

- **The statement surface needs AGKRRV only for conventions** [J, from 2.3]. For workflow.md
  step 2 (the blueprint), `LocSys^restr`, `QLisse`, `Shv_Nilp(Bun_G)`, the Beilinson projector
  and the restricted conjecture are **proof-only** (step 6) objects: GLC I uses them in §§2–5,
  never in §1 [R 2.5; J].
- **"Link to the existing literature"** (ideas.md, "The formalisation", item 1). Each docstring
  should cite the defining source of 2.3, not a nearby one: AGKRRV (l.2143–2146, l.2111–2112,
  l.2180) for `DGCat`, compactness and `>-∞`; AG for `LS_Ǧ` (§10.1–10.2), `IndCoh_Nilp` and `Ψ`;
  GLC I for `DmodHalf` and `𝕃_{G,coarse}`; GLC I with [BD, §4] for `ω_X^{1/2}` [J]. AGKRRV's
  Tannakian formula for `LocSys^dR` (l.5238–5240) is a good one-line gloss for `QCohLS`'s
  docstring, cited, not copied [J].
- **The Foundations layer should be `e`-linear.** AGKRRV's `DGCat` is linear over `Vect_e`, and in
  the de Rham case `e = k`. That supports `audit-lean.md` §2.4's finding that the `DGCat`
  placeholder lacks a `k` parameter [R AGKRRV; J].
- **`IsEventuallyCoconnective` and t-structures.** AGKRRV fixes only the notation and the
  convention that t-structures are compatible with filtered colimits; the t-structure itself is
  per category. This agrees with the AG note's point that the t-structure must be data of the
  category [J].
- **A library, not a one-off** (ideas.md item 1, "D-modules, perverse sheaves, etc.";
  "Generalize theorems for maximal reuse"). AGKRRV works with one abstract constructible sheaf
  theory and three instances (Betti, de Rham, étale; §1.1.1), with constructible sheaves on
  schemes and stacks and their singular support in Appendices E–G. That is a ready design template
  for a geometric-representation-theory library: one interface, several instances [J]. It also
  carries the ground field / coefficient field split (`k` vs `e`), which a library will need even
  though the de Rham statement identifies them [J].
- **Names in Mathlib style.** Two meanings of `Nilp` (l.1750) and two of `ω_X` (l.2382 vs
  l.15136) mean Lean names must say which: for example a global nilpotent cone in `T*Bun_G` vs a
  nilpotent locus in `Sing(LocSys)`, and `canonicalSheaf` (line bundle) vs a dualizing object [J].
- **Order of sources** (ideas.md item 3) and **Tau Ceti** (item 4). Nothing in this paper is in
  Mathlib or Tau Ceti on 2026-11-08 as far as the other notes report (`tauceti-library.md`,
  `tauceti-roadmaps.md`: no derived stacks, IndCoh, `LocSys`) [S, those notes]. Prestacks over a
  derived base (l.2205–2215) and formal affine schemes (Remark 1.4.7, App. A) would be
  backbone in this repository first [J].
- **Papers as TeX** (ideas.md item 5). The counting script worked on the TeX directly and agreed
  with every citation GLC I makes; this is a cheap, repeatable check that a review agent can run
  [R; J]. The licence (arXiv non-exclusive, not CC BY like GLC I–V) means quotes stay short in
  notes, docstrings and the blueprint [R manifest; J].

## 4. Conflicts

With other notes (none changes a conclusion):

- **`audit-lean.md` §2.2 (table row `[IsAlgClosed k]`) and `GLCinLean/Abstract.lean` l.33** cite
  AGKRRV l.2087(–2088) for "for D-modules, `k` of characteristic zero". l.2087–2088 is about the
  coefficient field `e`; the D-module sentence (`k = e`, characteristic zero) is l.2092–2093 [R].
- **`further-arinkin-gaitsgory-...md` §2.5** says AGKRRV v2's §17 "has subsections 17.1–17.5
  only". By the TeX, §17 has three subsections, 17.1–17.3 (l.17277, l.17329, l.17424), none
  commented out [R by script]. The conclusion that no "Sect. 17.8.4" exists in AGKRRV stands, and
  AGKRRV never uses the word "tempered" [R grep: 0 hits].
- **`audit-lean.md` §2.2** says `LS_Ǧ` "is not defined in GLC I (it refers to AGKRRV/[AG])".
  More precisely, GLC I gives no reference where it introduces `LS_Ǧ` (l.730–732); its one
  pointer is to AGKRRV §4.1 (l.2281) for `LS^restr ⊂ LS`, and AGKRRV §4.1.1 recalls `LocSys^dR`
  from AG §§10.1–2. The defining source is AG §10.1 [R].
- **AG note §2.5, row l.3553**: agrees that GLC I applies AG §11.1.6 to an AGKRRV object; the
  closer source is AGKRRV §21.1.7 (2.5 above) [J].
- **`further-jo-l-riou-...md` §3 and `Foundations.lean`**: agree (2.1). Small addition: the
  wording sits at l.2143–2146 (l.2141 is the heading), and AGKRRV states it as a convention
  pointing to Lurie, not a construction [R].

With GLC I (not contradictions, but mismatches a transcription has to handle):

- GLC I: "a field of characteristic 0" (l.717); AGKRRV: ground field algebraically closed
  (l.2066). Known; `audit-lean.md` owner question 2 [R].
- GLC I: "connected reductive" (l.718); AGKRRV: "reductive" (l.2072, l.15123). No effect on the
  Lean statement, since Tau Ceti's reductive groups are connected (`audit-lean.md` §2.2) [S that
  note; J].
- GLC I: half-twisted `Dmod_{1/2}(Bun_G)`, twist "crucial" for Hecke functors (l.1414–1417);
  AGKRRV: untwisted throughout, plain `Rep(Ǧ)` action (l.15276–15286). An expert should say
  whether the two set-ups agree after `e:untwist` [J].
- GLC I l.2312 tensors over `QCoh(LS^restr)`, AGKRRV Prop. 14.5.3 over `QCoh(LocSys^dR)` (2.5)
  [R; J typo].

With notes/ideas.md and notes/workflow.md:

- **ideas.md item 5** ("I don't see the point of `references/papers/manifest.toml`"). This paper is
  the one whose licence differs from GLC I–V, and the one GLC I cites without a version. If the
  manifest goes, the version (v2) and the licence rule have to be recorded somewhere else [J].
- No conflict with the decisions in workflow.md found [J].

## 5. Input for the open questions (notes/workflow.md)

- **What goes into `AGENTS.md`.** Suggest three short facts, because agents will meet them
  every session [J]:
  - the papers' licences differ: GLC I–V are CC BY 4.0; AGKRRV and AG are arXiv non-exclusive,
    so cite and link only;
  - in these papers theorem numbers share the subsubsection counter, so numbers can be computed
    from the TeX (and should be, rather than guessed);
  - bibliography keys differ between papers (`Ga2` in GLC I is `Ga5` in AGKRRV).
- **Whether `PLAN.md` is needed.** `PLAN.md` l.40 is where the hypotheses' provenance (AGKRRV,
  GLC II) is written down. That record should move into the statement file's module docstring,
  with the corrected line numbers of §4 [J].
- **`Abstract.lean`, `Foundations.lean` and the placeholders.** AGKRRV backs the `Foundations`
  layer's meaning (`DGCat` as `Vect_e`-linear presentable stable categories, continuous
  1-morphisms, compactness) but says the linearity is over the coefficient field. That is one more
  reason for a `k` parameter on `DGCat`, and for the t-structure to be data. None of the five chain
  placeholders is AGKRRV's, so their docstrings should not cite it [J].
- **What happens to each file: `references/papers/manifest.toml`.** The manifest's AGKRRV entry is
  right: role, version, licence and source hash all check out [R]. Its role text "the source of
  the hypotheses' labels" is accurate for "algebraically closed" and "connected" [R 2.3].
  Whatever replaces it should keep the version and the licence line [J].
- **Who reviews the mathematics, and to what standard.** A script-based check of citations
  against the TeX caught one real slip in a source (GLC I l.2312) and two small slips in our own
  notes (§4). Fresh agents can do this check. The twist question (2.4) and restricted ⇔ full
  (§21.4) need a human expert [J].

## 6. Questions for the owner

1. **One field or two?** The GLC statement uses a single `k` (de Rham: `k = e`). Should library
   definitions taken from AGKRRV (sheaf theories, `LocSys^restr`, `DGCat`) separate the ground
   field from the coefficient field, so that Betti and ℓ-adic versions can be added later?
   Suggestion: one `k` in the statement, two fields in the library interfaces [J].
2. **Scope of the library.** Follow AGKRRV's sheaf-theory-agnostic design (one interface, three
   instances), or build only D-modules for now? It affects step 2's blueprint. Suggestion: an
   interface with the de Rham instance first [J].
3. **Where do paper versions and licences live** once the manifest is gone (ideas.md item 5)? AGKRRV
   is the case that makes it matter. Suggestion: one short table in `AGENTS.md` or in a tracked
   `references/README.md` [J].
4. **Expert check of the twist.** The untwisted (AGKRRV) and half-twisted (GLC I) Hecke set-ups
   should be compared by someone who can judge it before `DmodHalf` gets a real definition. Is
   there an expert to ask, or should this wait for the review system?
