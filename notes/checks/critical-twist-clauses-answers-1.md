# Answers to round 1 on `proposal/critical-twist-clauses`

Codex and the checker read `1efd60a`. Every point of both reports is accepted. Each replacement was read against its source before it was applied. "The plan node" is `Satake.criticalTwistBunDeterminantEquiv` in `plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml`. "The proof node" is `Satake.criticalTwistBunDeterminantEquiv_comp` in `plans-proof/GLCinLean/GeometricLanglands/Satake/Twisting.toml`.

## Sources read

- [GLC2] Proposition 10.1.11 and its proof. Equation (10.5) is the relative determinant of the first lattice against the second, "for some/any lattice 𝐋 contained in both"; the critical line is its inverse. Equation (10.6) is `det Γ(X, 𝔤_{P²}) ⊗ det Γ(X, 𝔤_{P¹})^{-1}`, the fibre of `h_r^* det ⊗ (h_l^* det)^{-1}`. So the plan node takes the outgoing lattice against the incoming lattice, as the paper does. The two equation numbers were counted in the TeX (equations are numbered within the section).
- [GLC2] §10.1.2: the global Hecke groupoid acts on `Bun_G × Ran` and has a unit section `Bun_G × Ran → Hecke`. So units exist for one point of the Ran space.
- [GLys] §5.2.1, footnote: the relative determinant is a priori ℤ-graded, and its grading is trivial because `G` is unimodular.
- [GLys] §9.5.1: the monoidal structure over Ran is non-unital.
- [GaitsgoryOutline] §4.4.2 is in `references/`. Its first diagram has the fibre product over `(h_r, Bun_G, h_l)`, the map to `Hecke ×_{Ran} (Ran × Ran)`, and then the map `id × ∪` to `Hecke`; it calls the monoidal structure non-unital.
- [GLC2] Remark 1.1.4, footnote: the square root from `ω^{1/2}` is a ℤ/2-graded factorization line bundle with grading `⟨λ, 2ρ̌⟩ mod 2` on the component of `λ`.

## Points

**1. Codex 1, checker M2 and M3: units and the disjoint locus (the proof node, `desc`).** Codex's replacement is the text. From the checker's M2 one clause is added, the reason why there is no unit. New wording: "Write H for the Ran Hecke stack. Composition defines an associative map c from H ×_{Bun_G} H to H over Ran.union, using h_out on the first factor and h_in on the second ([GaitsgoryOutline] §4.4.2). On the diagonal x = y this is composition in the Hecke groupoid over Bun_G × Ran, with the identity modifications as units ([GLC2] §10.1.2). Composition over varying supports is non-unital: composing with the identity modification at y moves a modification at x to the point x ∪ y of the Ran space. Let U ⊂ Ran × Ran be the locus of ordered pairs of disjoint supports. The map remembering (x, y) and the composite is an equivalence from (H ×_{Bun_G} H)|_U to U ×_{Ran} H, where U → Ran is union. Its inverse recovers the intermediate bundle by gluing P off Γ_x to P″ off Γ_y using the given isomorphism on their common open." The checker's M3 wording ("the pullback of Hecke along Ran.union over that locus") is the same fact as Codex's `U ×_{Ran} H` and is not repeated.

Deviations from Codex's wording: the two citations in brackets are added; the clause after "non-unital" is the checker's; the sentence before the passage now starts "Composition sends" and the sentence after it says "the map c", so that `c` is introduced once.

**2. Codex 2, checker M1: graded lines (the plan node, `desc`).** Codex's replacement is the text, for the passage from "For the divisor D" to "under the functor of square roots of Stacks.rootGerbe". Added from the checker's replacement, where Codex's text lacks it:
- in the sentence on the graded determinant: "with values in ℤ-graded lines, graded by the rank, with the Koszul sign rule for the symmetry of the tensor product ([GLys] §5.2.1, footnote)";
- "of Stacks.determinantBundle" after the common normalization;
- the sentence on the sign, see the correction below;
- ", that is, the pullback of det_{Gr_G} ([GLC2] Proposition 10.1.11 and its proof)", and the words "the lattice of P′" and "the lattice of P" beside "outgoing" and "incoming".

The checker's other sentences state facts that Codex's text already has (the two triangles, the cancellation of the constant line, degree zero, independence of `n` and of the lifts, naturality in `S`), so they are not repeated.

Correction of one detail of the checker's sentence. The checker wrote that each contraction is determined by the coherence of the Picard groupoid and that "without the grading it is not determined". In graded lines a line of degree `d` has two contractions with its inverse, the evaluation after the symmetry and the inverse of the coevaluation, and they differ by `(−1)^d`. Codex's Hom form uses no symmetry and so fixes the cancellation. The sentence in the node is therefore: "Written as a contraction of A with its inverse, this cancellation has two forms, which differ by the sign (−1)^d for the degree d of A; only the form above is independent of n, because d, the rank of Rπ_*N, is dim G · (1 − g − n · deg D), and its parity changes with n when dim G · deg D is odd." The rank formula is the checker's and was checked: `ad(P)` has rank `dim G` and degree zero.

**3. Checker only.**
- The plan node, `source`: `'[GLys] §§2.3.5, 5.2.1, 6.3, 7.3.1, 9.5.1–9.5.3; [GLC1] §§1.1.1, 1.1.4–1.1.6 and Remark 1.1.6; [GLC2] §§1.1, 10.1.2, Proposition 10.1.11 and its proof, equations (10.5) and (10.6)'`. This is the checker's text with Codex's equation numbers.
- The proof node, theorem (1): "in the graded lines of Satake.criticalTwistBunDeterminantEquiv" is added.
- The proof node, `deps`: `GLCinLean.LoopGroups.RanLoopGroup` and `GLCinLean.Stacks.determinantBundle` are added. Both exist in `plans/`. No cycle can arise: the proof node depends only on nodes of `plans/`, and no node of `plans/` depends on `plans-proof/`.
- The proof node, `source`: `'[GLys] §§7.3.1, 9.5.1; [GLC2] §§10.1.2–10.1.3 and Proposition 10.1.11; [GaitsgoryOutline] §4.4.2; explicit obligation'`. One sentence of `desc` says why the node stays an explicit obligation: the proof of [GLC2] Proposition 10.1.11 asks for an identification of multiplicative line bundles on the completed Hecke groupoid and gives the identification of the lines only. This sentence is an addition that neither report worded.
- Section 5 of the proposal: the decision has ", in graded lines with the Koszul sign rule"; the note for the writers has "uses graded lines"; the open item on `Sheaves.determinant` is the checker's replacement text (three users); the count of `plans-proof/` is named as the change of the entry on the plan of the proof.

**4. Codex's improvements that can wait.**
- The three source additions are in the two `source` fields above.
- The plan node, last sentence: "it is compatible when the component parity of the theta-induced square root, the grading ⟨λ, 2ρ̌⟩ mod 2 of Satake.criticalDeterminantGerbe, is zero on every component, as for the trivial group".
- The home of the composition map with `Hecke.Correspondence` stays for the start of the proof (doubt 3 of the proposal).

**5. The agreement sentence.** Section 5 no longer says that Codex agreed, and the remark on that sentence is removed.

## Other places with the same claims (step 4)

- The plan node, the test: the isomorphism on the unit section was "the contraction det ⊗ det^{-1} ≅ 𝒪". It is now "both lines are lines of endomorphisms Hom(L, L), and the isomorphism of line bundles sends the identity to the identity", the Hom form of point 2.
- The proof node, part (1): the isomorphism of the relative determinants is "in the Hom form of Satake.criticalTwistBunDeterminantEquiv … the composition of maps, for a subbundle contained in the three adjoint bundles"; theorem (1) uses "the composition Hom(det(P′), det(P″)) ⊗ Hom(det(P), det(P′)) → Hom(det(P), det(P″)) of the ratio lines" in place of the contraction of four lines.
- The proof node, parts (1) and (2): "over the disjoint locus" is "over U", twice.
- `Hecke.sphericalAction_associativity` (`plans-proof/GLCinLean/GeometricLanglands/Hecke/SphericalAction.toml`): "over the disjoint locus" is "over the locus of ordered pairs of disjoint supports".
- Section 5 of the proposal, the decision: "where the isomorphism is the contraction" is "where the isomorphism sends the identity to the identity".
- `docs/` and section 6 have no such sentence. `Satake.criticalDeterminantGerbe` and `Ran.union` speak of the disjoint locus and of the grading in their own sense and are not changed.

Sections 4 and 7 of the proposal describe `1efd60a` and are not changed. Doubt 1 of section 7 is answered by [GLC2] Proposition 10.1.11, and doubt 2 by point 2 above.

## Merge, counts and checks

`main` at `9f37ba9` is merged into the branch as one merge commit (`STATUS.md` only, no conflict).

Counts, counted on the merged branch: `plans/` has 312 planned declarations in 198 module plans, 222 under `plans/GLCinLean/` and 90 roadmap nodes in fifteen areas. `plans-proof/` has 196 nodes in 75 module plans, 187 to be written here and 9 owned by six roadmaps.

Checks on the merged branch:
- `lake exe tracker lint`: exit 0, 0 errors, 61 warnings, all of superseded fields.
- `python3 tools/check-module-cycles.py`: 198 module plans, 312 nodes, 0 cycles.
- `python3 tools/check-upstream-names.py`: 267 pairs, 0 not confirmed.
- Every `deps` entry of `plans-proof/` resolves, and no node of `plans/` depends on a node of `plans-proof/`.
