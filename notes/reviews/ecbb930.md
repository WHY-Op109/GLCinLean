# Review of `ecbb930`: `Setting` takes only `[Field k]`

Commit reviewed: `ecbb930` on branch `proposal/setting-instances` ("Statement: Setting takes only [Field k]; the placeholders keep their instances"). It changes one file, `GLCinLean/Statement/Conjecture.lean`, and is compared with the version on `main` (`2b12ebc`, where the file is the same as before the commit). Scope, as the calling session named it: (1) `Setting`; (2) the eight placeholders `QCohLS`, `DmodHalf`, `IndCohNilp`, `Psi`, `RepRan`, `Loc`, `heckeActionRight`, `vacuumPoincare`; (3) `IsLanglandsFunctor`, `isLanglandsFunctor_iff` and the main theorem `exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence`; (4) anything that the change makes weaker, vacuous or easier. Line numbers are those of the file on the branch. TeX line numbers refer to `references/papers/2405.03599v3/src/functor.tex` ([GLC1]).

## Points for the owner

**Mismatch: 0. Unsure: 0.** The counts are: *agree* 11, *same object, different presentation* 0, *mismatch* 0, *unsure* 0.

The change does what it says. The elaborated main theorem is the same as on `main`: it quantifies over `{k : Type u} [Field k] [CharZero k] [IsAlgClosed k] (S : Setting k)`, in this order, and has the same conclusion. Each of the eight placeholders has the same binders as before. `Setting` now needs only `[Field k]`, and none of its fields uses characteristic zero or algebraic closedness. No new degenerate case appears. Nothing needs a decision. Two small gaps are listed below, and neither changes a verdict.

## How the verdicts were reached

**Blind reading.** A fresh subagent got the Lean text of the items in scope without docstrings. It also got the signatures and docstrings of what they use (the placeholders of `Enhanced.lean`, `RootDatumDuality`, and the Tau Ceti types `ReductiveCommHopfAlgCat`, `Pinning`, `InvertibleSheaf`, `tensorProduct`, and `Scheme.relativeDifferentials`). It opened no file. It read the items as follows. `Setting k` needs only a field. It holds a scheme `X` over `Spec k` that is smooth of relative dimension 1, proper and connected; a reductive Hopf algebra `G` with a pinning of some rank; a line bundle `L` with `L ⊗ L ≅ Ω_{X/k}`; a second reductive Hopf algebra and an element of the opaque `RootDatumDuality G Gd`. The eight opaque constants each take `[Field k] [CharZero k] [IsAlgClosed k] (S : Setting k)`. The main theorem says: for every algebraically closed field `k` of characteristic 0 and every `S`, some continuous `F : DmodHalf S → IndCohNilp S` sends compact objects to eventually coconnective objects, and has natural equivalences `Maps(heckeActionRight S Poinc b, c) ≃ Maps(Loc b, Psi (F c))`; and every such `F` is an equivalence. This agrees with the docstrings and with [GLC1] Cor. 1.6.5 and Conj. 1.6.7 (below).

**Elaboration check.** I wrote a scratch file, outside the repository, with two copies of the declarations, from `Setting` to the main theorem. One copy is the text on `main` and the other is the text on the branch, and each is in its own namespace. Both copies import the built `GLCinLean.Statement.Conjecture` only for `RootDatumDuality` and the enhanced-category placeholders. I ran it with `lake env lean` and printed each declaration with `#check @…` and `#print`. The results were as follows:

- **`Setting`:** `(k : Type u) → [Field k] → [CharZero k] → [IsAlgClosed k] → Type (u + 1)` on `main`, and `(k : Type u) → [Field k] → Type (u + 1)` on the branch. The constructor `Setting.mk` has the same fields in the same order on both, after the binders for `k`.
- **The eight placeholders:** each has `{k : Type u} → [Field k] → [CharZero k] → [IsAlgClosed k] → (S : Setting k) → …` on both sides, with the same result type. Only the binder names of the anonymous instances differ.
- **`IsLanglandsFunctor`:** the type and the body printed by `#print` are the same on both sides, term for term.
- **The main theorem:** both sides print `∀ {k : Type u} [Field k] [CharZero k] [IsAlgClosed k] (S : Setting k), (∃ F, IsLanglandsFunctor S F) ∧ ∀ F, IsLanglandsFunctor S F → F.IsEquivalence`.

`CharZero` and `IsAlgClosed` are `Prop`-valued classes, so splitting their binders off from `Setting` cannot cause an instance mismatch: any two instances are equal by proof irrelevance. I did not rerun `lake build`, `lake lint` or the axiom check; the calling session reports that they pass on the branch. Lines 101 and 111 have exactly 100 characters, which is within Mathlib's limit.

**Hack-answer test.** `Setting` is the only item in scope that is not an `opaque` or a definition over the opaque mathematical objects. It is tested in point (4) below.

## Verdicts

| Item | Lean lines (branch) | Verdict | Paper lines behind the verdict |
|---|---|---|---|
| `Setting` | 47–72 | *agree* | [GLC1] §0.1.1, `functor.tex` 717–719; theta characteristic §1.3.2, 1509–1510; square root of `det_{Bun_G}` §1.1.2, 1334 |
| `QCohLS` | 76–78 | *agree* (binders unchanged) | §0.1.1, 731–734 |
| `DmodHalf` | 80–83 | *agree* (binders unchanged) | §0.1.1, 721–725 |
| `IndCohNilp` | 85–88 | *agree* (binders unchanged) | §0.1.1, 731–734; Cor. 1.6.5, 1833–1843 |
| `Psi` | 90–93 | *agree* (binders unchanged) | 1825–1826 |
| `RepRan` | 95–97 | *agree* (binders unchanged) | unchanged; see `main`'s earlier reviews |
| `Loc` | 99–101 | *agree* (binders unchanged) | unchanged |
| `heckeActionRight` | 103–107 | *agree* (binders unchanged) | unchanged |
| `vacuumPoincare` | 109–111 | *agree* (binders unchanged) | unchanged |
| `IsLanglandsFunctor`, `isLanglandsFunctor_iff` | 113–150 | *agree* (elaborated statement unchanged) | Cor. 1.6.5, 1833–1849 |
| Main theorem | 152–161 | *agree* (elaborated statement unchanged) | Cor. 1.6.5, 1833–1849; Conj. 1.6.7, 1861–1863 |

### (1) `Setting`

*Agree.* [GLC1] §0.1.1 (717–719) says: "Let k be a field of characteristic 0. Let X be a smooth and complete curve and G a connected reductive group over k. Let Ǧ be the Langlands dual of G, viewed also as a reductive group over k." The fields of `Setting` record exactly these data. The curve is smooth of relative dimension 1, proper and connected (lines 52–56). The group is a reductive Hopf algebra with a pinning (58–62). The dual group comes with its root-datum identification (68–70). The theta characteristic is the line bundle `ω_X^{1/2}` of §1.3.2 (1509–1510; it gives the square root of `det_{Bun_G}`, §1.1.2, 1334), with its squaring isomorphism (64–66). The pinning and the theta characteristic are chosen data, as the module docstring says (lines 30–31). Connectedness follows [AGKRRV] §14.1.1, as the module docstring also says (line 29); this is unchanged.

Dropping the two instances is correct. No field uses them: the blind reading found this, and the elaborated `Setting.mk` shows it. Their types need only the following:
- `ReductiveCommHopfAlgCat k` and `RootDatumDuality` need only `[Field k]`.
- `Pinning` needs a commutative ring with a connected spectrum, which a field gives.
- `Scheme.relativeDifferentials` and `InvertibleSheaf.tensorProduct` need no hypothesis on `k`.

`[Field k]` is the natural generality. Both `ReductiveCommHopfAlgCat` and `RootDatumDuality` require a field, so `Setting` cannot be stated over a weaker base without changing those two types. The change moves no conclusion into a field and adds no field. The data over the fields that the main theorem allows are the same as before.

### (2) The eight placeholders

*Agree* for each. As the elaboration check shows, each placeholder has the same binders, in the same order, and the same result type as on `main`. The binders are `{k} [Field k] [CharZero k] [IsAlgClosed k] (S : Setting k)`, and `heckeActionRight` also takes its argument `M`. The docstrings are unchanged. As `notes/reviews/small-confirmations-codex.md` part 2 also says, this keeps the earlier hypotheses of each placeholder. It does not claim that both instances are the weakest hypotheses for each of the eight objects; that check comes when each placeholder is replaced.

### (3) `IsLanglandsFunctor` and the main theorem

*Agree.* The elaborated type and body of `IsLanglandsFunctor` and the elaborated main theorem are the same as on `main` (see "Elaboration check"). The theorem quantifies over every field `k` with both instances, then over every `S : Setting k`. The conclusion is: a functor with the two properties exists, and every functor with them is an equivalence. The instances reach the theorem through `variable [CharZero k] [IsAlgClosed k]` (line 113). Every placeholder in the statement requires them, so they are not unused section variables, and no warning appears. The two properties are those of Cor. 1.6.5 (1833–1849): (i) compact objects go to `IndCoh_Nilp(LS_Ǧ)^{>-∞}`. (ii) is `Ψ_{Nilp,{0}} ∘ 𝕃_G ≃ 𝕃_{G,coarse}`, in the Hecke-action form that the docstring (lines 123–134) justifies by [GLC1] Thm. 1.2.4. Conj. 1.6.7 (1861–1863) gives the equivalence. The commit leaves this faithfulness argument as it was, and this review did not check it again.

### (4) Is anything weaker, vacuous or easier?

No. The theorem's hypotheses on `k` are unchanged, so it does not become a statement about fields of positive characteristic or fields that are not algebraically closed. `Setting k` now exists for such fields as well, but no declaration of the statement uses it there. Every placeholder and the main theorem still require both instances.

The hack-answer test for `Setting` finds no new degenerate case. `ConnectedSpace X` includes `Nonempty X`, so the empty curve is ruled out. The case of the trivial group with rank 0 is a genuine case of the conjecture; the plan's example `Examples/Point` uses it to test the placeholders' replacements, and it is not a defect.

One degenerate case existed before this commit and is not changed by it. If the opaque `RootDatumDuality G Gd` were empty for every pair, `Setting k` would be empty, and the theorem would hold vacuously. This is a matter for when `RootDatumDuality` is replaced: the replacement needs an example that gives a non-empty `Setting`, such as the plan's `Examples/Point` with `Groups.dualityData`. It is not a finding against `ecbb930`.

## Definite gaps

Neither gap changes a verdict, and neither needs a decision.

1. **Use of `Setting` over a field that is not algebraically closed.** Over a field that is not algebraically closed, `ConnectedSpace X` is weaker than geometric connectedness, and the pinning makes `G` a split group. So `Setting k` for such a field is not "the data of [GLC1] §0.1.1 over `k`" in every sense. Nothing uses `Setting` there now. If later library code uses `Setting` over such fields, its docstring should say that `X` is only connected. This follows Codex's note (part 2, "Where the assumptions belong"), which puts the passage from connectedness to geometric connectedness on the arguments that need it. No change is needed now.
2. **`STATUS.md` on `main` still describes the old plan.** The "Open items" entry (`STATUS.md` line 90 on `main`) and decision 5 of 2026-11-13 (line 126) say that `Setting` keeps its instances until its placeholders are replaced. After the merge, they should say that the record refactor is done and that the check of each placeholder's hypotheses comes when it is replaced. This is step 5 of Codex's note, part 2. The branch changes no other file, so it merges into `main` without a conflict: `main`'s newer commit `2b12ebc` touches only `STATUS.md`.
