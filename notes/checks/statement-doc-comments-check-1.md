# Check, round 1: `proposal/statement-doc-comments` at `1542671`

A check with `prompts/check.md` on 2026-11-18. Line numbers are those of the branch files at `1542671`.

**Result.** The change is comments only, and almost every new doc comment matches the code and the papers. There is one *mismatch* (a wrong section number in `Psi`) and one *unsure* (the object that `RootDatumDuality` stands for is not well defined by its text). Both are fixed by a few lines of text. Five smaller wording findings follow. No difference from [GLC1] that affects the statement is missing from the root file.

## Mismatch and unsure

### M1. *Mismatch* (citation): `Psi`, `Conjecture.lean` lines 213–216

The text reads: "It is the right adjoint of the fully faithful embedding of QCoh(LS_Ǧ) into IndCoh_Nilp(LS_Ǧ) ([ArinkinGaitsgory] §4.3.6, for a quasi-smooth affine DG scheme)."

[ArinkinGaitsgory] §4.3.6 is the pair `(Ξ_Z^{Y,all}, Ψ_Z^{Y,all})` between `IndCoh_Y(Z)` and `IndCoh(Z)`. The pair that the doc comment means is in §4.3.7: "for any Y that contains the zero-section, we obtain the corresponding pair of adjoint functors Ξ_Z^Y : QCoh(Z) ⇄ IndCoh_Y(Z) : Ψ_Z^Y with Ξ_Z^Y being fully faithful". The count in §4.3 is: 4.3.1 (subsubsection), Cor. 4.3.2, Cor. 4.3.3, 4.3.4, Lemma 4.3.5, 4.3.6, 4.3.7. The same count gives Prop. 4.4.5 for the proposition that [GLC1] §1.6.3 cites, so the count is right.

Fix: replace "§4.3.6" by "§4.3.7". Better, also name the source for the stack: "… ([ArinkinGaitsgory] §11.1.5 for the embedding Ξ on LS_Ǧ; §4.3.7 for the pair of adjoint functors on a quasi-smooth affine DG scheme)". §11.1.5 states that `IndCoh_{Nilp_glob}(LocSys)` contains the essential image of `Ξ_LocSys`.

### U1. *Unsure* (the object is not determined): `RootDatumDuality`, `Conjecture.lean` lines 93–101

The text reads: "the isomorphisms between the root datum of G′ and the dual of the root datum of G".

The constant takes two terms of `TauCeti.ReductiveCommHopfAlgCat k` over any field, and nothing else (the blind reading confirms: no torus, no Borel subgroup, no pinning). A root datum needs a maximal torus, and a split one. So "the root datum of G" is not defined by the group alone: two tori give root data that are isomorphic only up to the Weyl group. Over a field that is not algebraically closed the group need not be split. The first half of the sentence ("identifications of G′ with the Langlands dual group of G") is fine. The second half does not define a set.

Fix, as text for lines 93–97: "For connected reductive groups $G$ and $G'$ over a field $k$, given in this order by their coordinate Hopf algebras, the type of identifications of $G'$ with the Langlands dual group of $G$ ([GLC1] §0.1.1): the isomorphisms between the canonical based root datum of $G'_{\bar k}$ and the dual of the canonical based root datum of $G_{\bar k}$. The canonical based root datum of a connected reductive group over an algebraically closed field is the based root datum of a maximal torus and a Borel subgroup that contains it. Two such pairs are conjugate, and the identification of their based root data does not depend on the conjugating element, so the datum depends on the group alone. The type is empty when the two based root data are not dual to each other. The statement uses this type only over an algebraically closed field."

By the isomorphism theorem these isomorphisms are the isomorphisms of $G'$ with a dual group up to inner automorphisms, which is what the Hecke action needs. The reading recorded in lines 99–101 and in `Setting` (lines 132–134) and the root file (lines 43–45) stays right.

Related small point (same lines, and module doc line 52): the doc comment writes `G` and `Gd` in backticks, but the signature has no named arguments. The fix text above says "in this order" instead.

## Smaller findings (verdict *agree*, with a text fix)

**F1. `Setting`, the reason for the pinning, lines 127–131.** "A pinning is this data" is not exact. [GLC1] §1.3.1 uses `Bun_{N,P_T} ≃ Bun_B ×_{Bun_T} pt`, so `T` there is the quotient `B/N`, not a subgroup. [GLC1] §1.3.6 says only: "we have a canonical map χ_i : Bun_{N_i,ρ_i(ω_X)} → 𝔾_a that records the class of the extension". The identification of the root subgroup with 𝔾_a is an inference, not the paper's words. A `TauCeti.Pinning` has more: a split maximal torus inside the Borel subgroup. Fix: "[GLC1] §1.3.1 uses a Borel subgroup $B$ of $G$ with its unipotent radical $N$ and the quotient torus $T = B/N$, and [GLC1] §1.3.6 uses for each simple root a map $\chi_i$ to $\mathbb{G}_a$, which needs an identification of the root subgroup of the simple root with $\mathbb{G}_a$ that [GLC1] does not name. A pinning gives this data. It has in addition a maximal torus inside $B$, on which the vacuum Poincaré object does not depend up to isomorphism." The kind "Reading" is right. The two claims about fields (every group has a pinning over an algebraically closed field; only split groups otherwise) are right.

**F2. `IndCohNilp`, the t-structure, lines 200–202.** The text says which t-structure [ArinkinGaitsgory] §4.4.1 defines for an affine DG scheme (checked: connective exactly when the image under Ψ is connective), but it does not say what the t-structure is on the stack. Fix: "The t-structure is the one for which an object is connective exactly when its image under $\Psi_{\mathrm{Nilp},\{0\}}$ is connective in $\mathrm{QCoh}(\mathrm{LS}_{\check G})$. [ArinkinGaitsgory] §4.4.1 defines it in this way for a quasi-smooth affine DG scheme, and [GLC1] §1.6.3 and Cor. 1.6.5 use it for $\mathrm{LS}_{\check G}$." The citations §§11.1.1, 11.1.5 and Prop. 4.4.5 are right.

**F3. `vacuumPoincare`, lines 271–280.** The normalization of `exp` is missing. [GLC1] §1.3.7: "normalized so that add^*(exp) ≃ exp ⊠ exp (i.e., exp ∈ Dmod(𝔾_a)^♡[-1])". Without it the object is fixed only up to a shift. The text also does not say that χ uses the generators of the simple root spaces of the pinning. Fix: add "normalized so that $\mathrm{add}^*(\exp) \simeq \exp \boxtimes \exp$" after "the exponential D-module on $\mathbb{G}_a$", and "for the generators of the simple root spaces of the pinning of `S`" after "the map of [GLC1] §1.3.6". All cited numbers (§§1.3.1, 1.3.5, 1.3.6, 1.3.7) are right.

**F4. `IsLanglandsFunctor`, wording, lines 321–332, and root file lines 36–37.** "functor of ∞-categories" and "its functor of ∞-categories" are used as a term without definition. `AGENTS.md` and `DGFun.MapsEquiv` say "underlying". Fix: write "underlying functor of ∞-categories" in each place. On the kind: "Reformulation" fits the main theorem (the statement is equivalent to the paper's). As a condition on $F$ alone, property 2 is weaker, which the text says plainly. The label is acceptable because the text states the exact relation. If one sentence is wanted: "As a condition on $F$ it is weaker; the statement of the conjecture is equivalent."

**F5. Optional.** [GLC1] §1.4.5 writes "the functor 𝕃_{G,temp} is continuous" and §1.4.6 writes "𝕃_G is QCoh(LS_Ǧ)-linear"; both mean 𝕃_{G,coarse}. No declaration depends on them, so no record is needed.

## The points that needed care

1. **Second property of `IsLanglandsFunctor` (lines 309–332): *agree*.** Each step holds by the TeX.
   - [GLC1] Thm. 1.2.4: "The action of Rep(Ǧ)_Ran on Dmod_{1/2}(Bun_G) factors via the functor (1.x)". §1.2.5 gets the action of QCoh(LS_Ǧ) from it. §1.4.2 defines 𝕃^L_{G,temp} from the object Poinc, and §1.4.5 defines 𝕃_{G,coarse} as its right adjoint. So Maps(V⋆Poinc, M) ≃ Maps(Loc V ⋆ Poinc, M) ≃ Maps(Loc V, 𝕃_coarse M), and the paper's property gives property 2.
   - [GLC1] §1.2.2: "It is a basic fact that this right adjoint is fully faithful." Property 2, with the previous line, gives Maps(V, Loc^R ΨF M) ≃ Maps(V, Loc^R 𝕃_coarse M), natural in V and M. Yoneda and full faithfulness of Loc^R give ΨF ≃ 𝕃_coarse for the underlying functors. The naturality in both variables together is needed and is in the code (`DGFun.MapsEquiv`).
   - The claim that this is not an equivalence of continuous functors is right: a natural equivalence of underlying functors need not be compatible with the Vect_k-module structures. "Weaker" is right in the sense "implied by, using Thm. 1.2.4".
   - The statement is unchanged: for compact $c$, $F(c)$ and $𝕃_G(c)$ are eventually coconnective, Ψ is an equivalence there ([GLC1] §1.6.3), and Dmod_{1/2}(Bun_G) is compactly generated ([GLC1] §1.6.4). So $F ≃ 𝕃_G$ as underlying functors. An equivalence in DGCat is detected on underlying functors. So, given Cor. 1.6.5, the Lean theorem holds exactly when Conj. 1.6.7 holds.
2. **Pinning in `Setting`: *agree*, with F1.**
3. **[ArinkinGaitsgory] in `Psi` and `IndCohNilp`: M1 and F2.** The caveat "for a quasi-smooth affine DG scheme" is right: §4 assumes Z affine. The stack case is in §8.2 (Cor. 8.2.6, §8.2.7, Cor. 8.2.8) and §11.1.5.
4. **`RootDatumDuality`: U1.**
5. **Opaque or built over opaque: *agree*.** `Conjecture.lean`: 9 opaque constants (`RootDatumDuality`, `QCohLS`, `DmodHalf`, `IndCohNilp`, `Psi`, `RepRan`, `Loc`, `heckeActionRight`, `vacuumPoincare`), and `Setting` (structure) and `IsLanglandsFunctor` (definition) built over them, as lines 49–52 say. `Enhanced.lean`: 12 opaque constants and 5 definitions (`DGCat`, `TStructuredDGCat`, `DGCat.Obj`, `DGFun`, `DGFun.IsEquivalence`), as lines 36–45 say. The claims on nonempty types, on missing terms and on universe levels (lines 41–49) match the blind reading. The count of `@[placeholder]` is 28.
6. **Correction in `Loc` (lines 242–247): *agree*.** The display of [GLC1] §1.2.2 is "Loc^spec_Ǧ : Rep(Ǧ) → QCoh(LS_Ǧ)". The next paragraph reads "The category Rep(Ǧ)_Ran is compactly generated, and the functor Loc^spec_Ǧ preserves compactness … Hence, it admits a continuous right adjoint", and Thm. 1.2.4 lets the action of Rep(Ǧ)_Ran factor through it. [GaitsgoryOutline] §4.3.3 defines `Loc_{Ǧ,spec} := (id×p)_! ∘ ev^*` on `QCoh((pt/Ǧ)_Ran(X))`. The kind "Correction" is right.

## Verdict per item

The code did not change. One blind reading of both files (the blind reader, code without comments, with the Tau Ceti signatures) agrees with the checker's reading in every item.

| Item | Blind reading against the paper | Doc comment against the code |
|---|---|---|
| `DGCatCarrier`, `DGCat`, `TStructuredDGCatCarrier`, `TStructuredDGCat`, `DGCat.objCarrier`, `DGCat.Obj`, `DGFunCarrier`, `DGFun` | *agree* ([AGKRRV] §§0.9.2–0.9.5) | *agree* |
| `DGCat.IsCompact`, `TStructuredDGCat.toDGCat`, `TStructuredDGCat.IsEventuallyCoconnective` | *agree* ([AGKRRV] §0.9.2, §0.9.5: C^{>-∞} = ∪ C^{≥ -n}) | *agree* |
| `DGFun.obj`, `DGFun.comp`, `DGFun.id`, `DGNatIso`, `DGFun.MapsEquiv` | *agree* | *agree* (`F.comp G` is G∘F; the adjunction remark for B = D is right) |
| `DGFun.IsEquivalence`, `DGFun.isEquivalence_iff` | *agree* (both composites, G∘F ≃ id_C and F∘G ≃ id_D) | *agree* |
| `RootDatumDuality` | type fits | *unsure* (U1) |
| `Setting` | *same object, different presentation* (Hopf algebras, pinning, chosen identification) | *agree*, with F1 |
| `QCohLS`, `DmodHalf`, `RepRan` | *agree* ([GLC1] §§1.1.1–1.1.5, 1.2.1; [ArinkinGaitsgory] §10.1; [GaitsgoryOutline] §4.2.4) | *agree* |
| `IndCohNilp` | *agree* | *agree*, with F2 |
| `Psi` | *agree* | *mismatch* in the citation (M1) |
| `Loc` | *agree*, with the recorded correction | *agree* |
| `heckeActionRight` | *agree* ([GaitsgoryOutline] §4.4.2, §4.4.3, Prop. 4.4.4) | *agree* |
| `vacuumPoincare` | *agree* | *agree*, with F3 |
| `IsLanglandsFunctor`, `isLanglandsFunctor_iff` | property 1 *agree*; property 2 weaker than the paper's, recorded, statement equivalent | *agree*, with F4 |
| main theorem | *same object, different presentation* (equivalent to Conj. 1.6.7 given Cor. 1.6.5) | *agree* |
| root file `GLCinLean.lean` | — | *agree* |

All other cited numbers are right: [GLC1] §§0.1.1, 0.5.7, 1.1.1–1.1.5, 1.2.1, 1.2.2, Thm. 1.2.4, §1.2.5, §§1.3.1, 1.3.2, 1.3.5–1.3.7, 1.4.2, 1.4.5, Thm. 1.6.2, §§1.6.3, 1.6.4, Cor. 1.6.5, Conj. 1.6.7; [GLC2] §0.4.1; [AGKRRV] §§0.9.1–0.9.5, 14.1.1.

## Differences from [GLC1]

Each recorded difference is real, and its kind and reason hold by the TeX: restriction to an algebraically closed field ([GLC1] §0.1.1 "a field of characteristic 0"; [AGKRRV] §0.9.1; [GLC2] §0.4.1); no functor chosen; the second property; the correction in `Loc`; connected curve ([GLC1] §0.1.1 "a smooth and complete curve"; [AGKRRV] §14.1.1 "smooth, connected and complete"); pinning; chosen identification of Ǧ; Hopf algebras; and the two generalizations to any field, which the statement does not use.

No unrecorded difference that affects the statement was found. The root file's list (lines 27–47) has all eight differences that affect it. The square root $\omega_X^{1/2}$ with its isomorphism is data in both ([GLC1] §1.3.2 "which we fix from now on"), so it is no difference.

## Degenerate cases of the definitions that are not `opaque`

- `DGCat`, `TStructuredDGCat`, `DGCat.Obj`, `DGFun`: nonempty types, nothing more is provable. No example exists or can exist while the carriers are opaque.
- `DGFun.IsEquivalence`: asks both composites. It is neither provable nor refutable for any functor, the identity included, because no term of `DGNatIso` exists.
- `IsLanglandsFunctor`: the zero functor has property 1. Property 2 excludes it once Poinc acts non-trivially. Property 1 is empty if there are no nonzero compact objects; compact generation of Dmod_{1/2}(Bun_G) ([GLC1] §1.6.4) excludes that. The existence part of the main theorem excludes the case that no functor has the two properties.
- `Setting`: the curve is nonempty (`ConnectedSpace`). The trivial group with rank 0 is a legitimate case. No term of `Setting k` can be built now, because `RootDatumDuality` is opaque, so the main theorem cannot be tested on an example. No example rules out the trivial readings at present; the plan's examples come when the placeholders are replaced.

## "Writing" and Mathlib's documentation style

No status text, history, or mention of agents, the plan or reviews. The mathematics is in LaTeX. Both module doc comments have Mathlib's layout. Every definition and every field of `Setting` has a doc comment. All five keys are in `docs/references.bib`. No line is over 100 characters. Breaches: the undefined term in F4, and the argument names in backticks in U1.

## Other checks

- With all comments stripped, each of the three files is identical at `6e2cc61` and on the branch. The diff touches only these three files.
- `lake build --no-build` in the branch worktree reports all targets up to date at `1542671`, with only the `sorry` warning of the main theorem. `lake lint` and the axiom check were not run; the code is unchanged.
