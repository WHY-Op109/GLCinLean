# Audit of 2026-11-19 after the change of the roadmap ReductiveGroups

The audit is of `main` at `d2bf2df`. It is due because a Tau Ceti roadmap that owns plan nodes changed: TauCetiRoadmap #2530 added §§9B.5–9B.8 to ReductiveGroups. It covers the changes since the audit of `b2a2045` (`notes/audit-2026-11-19.md` (deleted with this audit's merge; git history keeps it at `0ce26cf`)): TauCetiRoadmap from `fe56342a` to `1b7b481a` (3 commits; `1b7b481a` is its main), Tau Ceti from `b2350004` to the pin `d91980bd` (1 commit; the pin is its main), the open roadmap pull requests and the watched Tau Ceti pull requests at their heads, the pull requests opened on 2026-11-19, and the guidance of the worker `author-groups`. `docs/blueprint-providers.md` holds the result in place. The results of the two older audits are not derived again. The five big changes of the plan that were applied since `b2a2045` were each checked with `prompts/change.md` and are not checked again. The nodes of the findings B8 and B9, which are in progress on their branches, are left alone.

The date of this report is that of `date +%F`, 2026-11-19. The report of the audit of `b2a2045` has the name `notes/audit-2026-11-19.md`, so this report has a longer name.

## Main result

Nothing in the plan must change. The new text of ReductiveGroups only adds: four sections on the split classical groups and the general spin groups, with their conventions, supplier contracts, consumers and references. Every layer, number and title of ReductiveGroups that a node or the provider record cites is in the new README with the same text. No node written here states one of the new targets, and no node gets a new provider. The targets of the worker `author-groups` are still targets of the roadmap.

No new big change was found. Four small findings concern the next work: a series of open roadmap pull requests that rewrite READMEs and can change the labels that the nodes cite (F1), two Tau Ceti pull requests opened on 2026-11-19 that supply an input of a node (F2, F3), and the states of the recorded pull requests (F5).

## Findings, ranked by their effect on the goal

Small changes are applied in the audit's commit, or are for the session where the text says so. No finding is a big change.

### F1. Open “Template update” pull requests rewrite roadmap READMEs (small; for the session)

- **Evidence.** Of the 20 roadmap pull requests opened on 2026-11-19 after #2537 (#2538 to #2557), fifteen have the title “Template update: <area>”. #2544 (ChevalleyGroups, two files, head `d7d40406`) says: “The README now has the current roadmap shape. … The old milestones C0 to C7 become Layers 0 to 7, with numbered sections, *Needs:* lines, Examples and Dependencies”, and “a table after the conventions maps each former milestone to its layer, so those citations still resolve”. The fifteen areas are AmenableGroups, CFSGBasicProperties, ChevalleyGroups, CircleMethodThreePrimes, CombinatorialHeegaardFloer, CompactOperators, CompletedCohomologyPartII, ComplexCurveModuli, ComplexManifolds, ComplexTori, ComputabilityTheory, CountableModelCounting, EllipticIntegrals, FinancialMathematics and ReflectionInvariantTheory. None is one of the fifteen areas of `plans/Roadmap/` or the six of `plans-proof/Roadmap/`.
- **Effect.** A template update of an area of the plan can change every layer label, section number and title that its nodes and the guidance of its worker cite. 90 nodes of `plans/` and 9 nodes of `plans-proof/` cite such labels. The merge of one makes an audit due (`AGENTS.md`, “Workflow”).
- **For the session.** The monitor watches pull requests and not the roadmaps on main (`tools/monitor.sh` has no check of TauCetiRoadmap). At each cycle, list the open roadmap pull requests whose title names an area of `plans/Roadmap/` or `plans-proof/Roadmap/` (`gh pr list --repo TauCetiProject/TauCetiRoadmap --search "<area> in:title"`), and compare TauCetiRoadmap main with `1b7b481a` for the folders of these areas (`gh api repos/TauCetiProject/TauCetiRoadmap/compare/1b7b481a...main`, the file list). A check of this kind in `tools/monitor.sh` would replace the manual step; the audit of `b2a2045` asked for it too.

### F2. Tau Ceti #44072 gives the isomorphism that `Curves.thetaCharacteristicProjectiveLine` now chooses (small; due when #44072 is at the pin)

- **Evidence.** Tau Ceti #44072 (opened on 2026-11-19, head `6fb33ea4`, waits for its author, label `roadmap/JacobianChallenge`): “Construct the signed isomorphism `Ω¹_{ℙ¹_R/R} ≅ 𝒪(-2)` over every commutative ring: `dt` maps to the first standard twisting generator and `ds` to the negative of the second. The induced `R`-linear equivalence `H¹(ℙ¹_R, Ω¹) ≃ R` sends the Mayer–Vietoris class of `dt/t` to `1`.”
- **The node.** `Curves.thetaCharacteristicProjectiveLine` (`plans/GLCinLean/AlgebraicGeometry/Curves/ProjectiveLine.toml`) says: “Tau Ceti gives only the existence of this isomorphism, so one is chosen; it is unique up to a scalar in k^×, and no user may depend on which one it is.” This is true at the pin. Its user is `Examples.exists_setting_rank_pos`.
- **What to do.** Nothing now. When #44072 is at the pin, the node names its isomorphism in place of the chosen one; the degree argument (`eulerDegree_relativeDifferentials`, `nonempty_iso_twistingSheaf_iff`) is then not needed for this step, and the comparison of `𝒪(−2)` with `𝒪(−1)^{⊗2}` is then taken from the specified `AlgebraicGeometry.Proj.twistingSheaf.tensorProductIso` and not from the equality of classes. The object, its generality, its hypotheses and its provider do not change; the construction of the isomorphism does. When #44072 is at the pin, a checker checks the changed node with `prompts/check.md` and says whether its meaning is unchanged; the session then applies it as small, or runs `prompts/change.md` (`AGENTS.md`, "Small and big changes": "a different construction or source for an object"). The provider record has a row for #44072. The session adds #44072 to the watched pull requests.

### F3. Chow's lemma, an input of the proper maps on complex points, is in the open Tau Ceti #44039 (small; the node text is applied, the guidance is for the session)

- **Evidence.** ReductiveGroups 3A.5c, under its needs (the same text at `fe56342a` and `1b7b481a`): “A route for the proper comparison uses Chow's lemma and projective-space compactness; its algebraic inputs are SchemeAndStackFoundations §4.12's Chow lemma, applied over affine finite-type complex opens of the base, and §0.3's projective geometry.” Tau Ceti #44039 (opened on 2026-11-19, head `541f074c`, waits for its author, label `roadmap/SchemeAndStackFoundations`) proves Chow's lemma over an affine base: “A separated scheme of finite type over an affine base, with finitely many irreducible components, now admits a surjective projective modification with quasi-projective source.”
- **Effect.** The proper maps are one of the three parts of `Constructible.ComplexPoints` that are still to do, and the last target in the guidance of `author-groups`. The node and the guidance did not name this input.
- **Applied.** The node `Constructible.ComplexPoints` names the route and its inputs. The provider record names #44039 in the row of `Roadmap.ReductiveGroups.ComplexPoints` and in the table of Tau Ceti pull requests.
- **For the session.** One sentence in the guidance of `author-groups` keeps the worker from a second proof of Chow's lemma (“For `STATUS.md`” below). It is a recommendation: the guidance is correct without it.

### F4. The README of ReductiveGroups at `1b7b481a` leaves the plan unchanged (small; the provider record is updated)

- **The change.** TauCetiRoadmap `1b7b481a` (#2530, “feat: add split classical groups and general spin groups to ReductiveGroups”, merged on 2026-11-19), +471 −7 in `TauCetiRoadmap/ReductiveGroups/README.md`. The diff has fifteen hunks. Twelve only add lines:
  - in the overview, one paragraph on what Layer 9B now owns and which roadmaps consume it;
  - in the supplier contracts: Mathlib's quadratic forms and Clifford algebras; Tau Ceti's “Classical and Clifford groups”; one sentence on SchemeAndStackFoundations §2.11; and three new sections “From TauCetiRoadmap.LefschetzPencilsAndVanishingCycles”, “From TauCetiRoadmap.DeformationAndDerivedPatchingAlgebra” and “From Completed/OrthogonalSpinGroups”;
  - in Layer 9, after §9B.4: “Conventions for §§9B.5–9B.8”, “9B.5 The symplectic and symplectic-similitude groups”, “9B.6 Orthogonal groups of a quadratic module and the Dickson invariant”, “9B.7 Clifford groups, general spin groups and spin groups” and “9B.8 Low-rank identifications and duality of classical root data”;
  - one paragraph under “Downstream consumers”, and five references.
- **The seven older lines that changed.** Two lines of “Dependencies” of Layer 9 (the needs of §§9B.5–9B.8 are added). Four lines in the passage of Layer 9D on groups of multiplicative type (“its `VanishingCycles.lisseMonodromyEquiv`” became “the equivalence that roadmap proposes as *VanishingCycles.lisseMonodromyEquiv*”). One line of the reference to Conrad's *Reductive Group Schemes* (citations of its Appendix C are added). No node cites these lines.
- **The headings.** The 120 headings of the README of `fe56342a` are all in the README of `1b7b481a`, in the same order and with the same text; eight headings are new (the three supplier sections and the five of Layer 9B above).
- **The cited labels.** Each is in the new README with the text of `fe56342a`:

  | Label and title | Cited by |
  |---|---|
  | 3A.5 “Properness and the complex comparison”; 3A.5b; 3A.5c “Classical complex points” | `Constructible.ComplexPoints`; the guidance of `author-groups`; the provider record |
  | 3A.5f “Complex orbits” | `Constructible.isGood_orbitStratification`; `STATUS.md`, “Open items” |
  | “Layer 5: solvable and unipotent groups; the unipotent radical” | `Groups.pinnedData`; the guidance |
  | “Layer 7: structure theory”, the item “Root datum” | `Groups.rootDatum`, `Groups.basedRootDatum`, `Groups.twoRho`, `Groups.pinnedData`; the guidance |
  | 7C.3, with `2ρ∨ = ∑_{β>0} β∨` | `Groups.twoRho`; the guidance |
  | “Layer 7b: algebraic parabolics and Levi intersections” | `SpectralProof.parabolicLevi` (`plans-proof/`) |
  | “Layer 8: split groups and pinnings”; 8.2 “Pinnings”, with “Existence and classification are Layer 9D's targets” | `Groups.pinnedData`, `Groups.rootDatum`, `Groups.basedRootDatum`, `Groups.pinning_exists`; the guidance |
  | 9A and 9B (the Chevalley–Demazure groups) | `Groups.splitReductiveGroup` |
  | “Layer 9D: classification, relative groups and forms”, with “Construct central isogenies and the simply-connected and adjoint semisimple forms” | `Groups.pinning_exists`, `Groups.splitReductiveGroup`, `Groups.SimplyConnectedCover`; the guidance |
  | §11C | the provider record (the needs of LanglandsParameterStacks §1.12) |

  Five more nodes name the roadmap without a label (`Sheaves.finiteTypeGroupClassifying_oneAffine`, and in `plans-proof/` `Sheaves.parabolicHorizontalLoopIndCoh_compactDuality`, `Stacks.unipotentTorsorFiltration`, `Satake.regularSheafExt_centralIsogenyComparison` and `SpectralProof.reductiveCriticalCenter_comparison`); the subjects that they take from it (faithful representations and complete reducibility, the big cell, the root-height filtration, central isogenies) are in unchanged text.
- **No duplicate and no new provider.** `plans/` and `plans-proof/` have no symplectic, orthogonal, Clifford or spin group; a search for these words finds only the tests `SL₂`, `PGL₂` and `GL₂` of other nodes.
- **Two owners confirmed.** The new overview says: “Dual and L-groups are ReductiveGroupsPartII RG2.5's; §9B.8 proves only the isomorphisms of based root data that RG2.5 turns into dual groups.” `Groups.langlandsDual`, `Groups.dualityData`, `Groups.dualityData_changePinning` and `Groups.coweightParity` are nodes of ReductiveGroupsPartII. The new conventions say that “the pinned model of a based root datum `Ψ`” is §9B's Chevalley–Demazure group over `ℤ`, which is `Groups.splitReductiveGroup`.
- **One check is near a node written here.** §9B.8, “Dual based root data”, states isomorphisms of based root data for `Sp₂ₙ`, `SO(q_{2n+1})`, `SO(q_{2n})`, `GSpin_{2n+1}`, `GSp₂ₙ`, `GSpin_{2n}` and `GSO(q_{2n})`. Its check reads: “At `n = 1` the duality reads: the dual of the `GSpin₃ = GL₂` datum is the `GL₂ = GSp₂` datum”. This is the self-duality of the based root datum of `GL₂`, which `Examples.exists_setting_rank_pos` constructs on `TauCeti.GeneralLinear.standardPinning` with `Groups.dualityData`. The roadmap states it for the carriers `GSpin₃` and `GSp₂`, each with a pinned isomorphism to `GL₂` (§9B.8 “Low rank”, §9B.5 “Checks”), and it has no target on the dual datum of `GL_n`. So the example is not a copy of a target, and it stays written here, on the root datum of `GL₂` that Tau Ceti has.
- **Applied.** The provider record: the snapshot, the row of ReductiveGroups, and a new item “ReductiveGroups §§9B.5–9B.8” under “Other facts about these areas”.

### F5. States of the recorded pull requests (small, applied to the provider record)

- Tau Ceti #28845 (coCartesian edges and fibrations) was closed without merge on 2026-11-19. No open pull request covers coCartesian edges now. The guidance of `author-infinity` does not name it.
- Tau Ceti #40905 (cotangent map and base change of `relativeDifferentials`, head `b49b5300`) and #40762 (the algebraic de Rham complex, head `7a97c263`) are labelled ready to merge; the record said that they waited for CI.
- Tau Ceti #44042 (opened on 2026-11-19, head `819b02e4`, waits for its author) defines the constructible stratifications of an open subset of a scheme. It is near `Constructible.StratifiedDerivedCategory`, which uses `TauCeti.FiniteStratification` on the space of complex points; it supplies no node.
- No recorded head moved. The record now has the head of #43231 (`8c566546`).

### F6. The big findings B8 and B9 are in progress; no other older finding is open

“The findings of the two older reports” below has the list.

## The comparison

### TauCetiRoadmap, `fe56342a` to `1b7b481a`

Three commits: `68a511ab` (#2534, RepresentationTheory/ModularCharactersAndBlocks), `19ee6221` (#2537, the pin of TauCetiProgress in two workflow files) and `1b7b481a` (#2530, ReductiveGroups). Five files changed: `.github/workflows/progress-announce.yml`, `.github/workflows/progress-merge-report.yml`, `TauCetiRoadmap/ReductiveGroups/README.md` (+471 −7), and the `README.md` (+558 −346) and `Suggested.lean` (+112 −29) of RepresentationTheory/ModularCharactersAndBlocks. That area owns no node of `plans/` or `plans-proof/`; the audit of `b2a2045` searched it for the plan's subjects. For the other fourteen areas of `plans/Roadmap/` and the two further areas of `plans-proof/Roadmap/` (ArithmeticGaloisRepresentations, AffineLieAlgebras), every file is that of `fe56342a`. No generated `STATUS.md` changed. F4 has the comparison of ReductiveGroups.

### Tau Ceti, `b2350004` to the pin

- Tau Ceti main is the pin `d91980bd` (read on 2026-11-19), so no commit is past the pin. It has no tag `v4.36.0`; its newest tags of Lean 4.36 are `v4.36.0-rc1` and `v4.36.0-rc2`. The open #44135 (head `3e3abf3e`) moves it to Mathlib `35f49460`.
- The one commit, `d91980bd` (#43422, the move to Mathlib `fc4f59e5` and Lean `v4.36.0`), changes 180 Lean files (+982 −922 with the manifest and the toolchain file), adds and renames none, and removes one: `TauCeti/Algebra/Module/Projective/Trans.lean`. No node names that file; Mathlib has its lemma `Module.Projective.trans`.
- No module that `plans/`, `plans-proof/`, the provider record or a Lean file of this project names is among the 180. `python3 tools/check-upstream-names.py` confirms all 267 pairs at the pin.
- Of the 607 Tau Ceti modules that this project imports, directly or through other modules, the commit changes one: `TauCeti.Algebra.Category.ModuleCat.RestrictScalars`, in one import and one proof. No line that starts a definition, structure, class, abbreviation or instance changed in it. In the other 179 files, 76 such lines changed: they follow Mathlib's renaming of `Submodule.IsLattice` to `Submodule.IsFullLattice`, or add one of eight instances of `Module.Free` and `Module.Finite`, or give one abbreviation its type.
- Mathlib moved from `048fffa1` to `fc4f59e5` (65 commits, 299 files). None of these files changed: `Mathlib/Algebra/Field/Defs.lean`, `Mathlib/Algebra/CharZero/Defs.lean`, `Mathlib/FieldTheory/IsAlgClosed/Basic.lean`, `Mathlib/AlgebraicGeometry/Scheme.lean`, `Mathlib/AlgebraicGeometry/Morphisms/Smooth.lean`, `Mathlib/AlgebraicGeometry/Morphisms/Proper.lean`, `Mathlib/Topology/Connected/Basic.lean`, and `Defs.lean`, `Base.lean` and `Hom.lean` of `Mathlib/LinearAlgebra/RootSystem/`.

### Pull requests opened on 2026-11-19

- **TauCetiRoadmap.** 29 were opened on that day, #2529 to #2557; all were read by title. Of #2529 to #2537, three concern areas of the plan and are in the provider record: #2530 (merged), #2531 and #2535. Of #2538 to #2557, fifteen are template updates (F1) and five are on special functions (#2538, #2540, #2551, #2552, #2553); none amends an area of the plan.
- **Tau Ceti.** 137 were opened on that day; all were read by title. Three concern the plan: #44072 (F2), #44039 (F3) and #44042 (F5). Three carry the label of ReductiveGroups or ReductiveGroupsPartII and touch no target of the plan: #44033 (the polynomial presentation of the coordinate algebra of `SL_n`, §9B.4), #44028 (split extensions of affine groups are semidirect products) and #43996 (point spaces of standard smooth presentations). No pull request of ours is open in Tau Ceti.

### Open roadmap pull requests

| Pull request | Head on 2026-11-19 | Changed since the audit of `b2a2045` |
|---|---|---|
| #1734 SheafTheoreticSmithTheory | `e16543f1` | no |
| #1687 AnalyticStacks | `d99fdc2b` | no |
| #2450 QuasicoherentSheavesOnPrestacks | `26c8a4ff` | no |
| #2270 InfinityCategoryTheory | `a6d79287` | no |
| #2279 MixedHodgeModulesAndIrregularHodgeTheory | `b7a20a85` | no |
| #1630 EnhancedDerivedSheaves amendment | `21e71828` | no |
| #1330, #2447, #2489, #2531, #2535 | `856fe7ab`, `d5f6490a`, `5680cc46`, `2fdb6a3f`, `8d8d4110` | no |

All are open; #1734, #1687 and #2450 have no review. #2530 is merged. No row of “Held” in `STATUS.md` is released.

### Watched Tau Ceti pull requests

All eleven are open with the recorded heads: #41911 (`354fb987`), #43615 (`430de8cf`), #43631 (`92dfb753`), #41795 (`b0fc5546`), #43607 (`d8a1fe30`), #41535 (`79b1ff5e`) and #41497 (`673d5cb9`) are labelled ready to merge; #41289 (`32fc2646`), #43025 (`fc58c1d6`), #43034 (`3d99a097`) and #43231 (`8c566546`) wait for their authors. The four of TauCetiRoadmap are in the table above.

### The guidance of `author-groups`

The guidance was read in the session's copy of the workers' configuration (`~/Library/Application Support/tauceti/workers.toml`; 1,445 characters). Its targets are, in order: Layer 7, the item “Root datum”; the based root datum of a pinning (§8.2 “Pinnings” and Layer 5); §7C.3; Layer 9D, the existence of pinnings; then Layer 3A.5c. Each label is in the README of `1b7b481a` with the same text (F4). Its sentence on what Tau Ceti main has (“root data only for GL_n, SL_n, Sp_2n and split tori”) agrees with the new supplier contract, which lists `TauCeti.Symplectic.diagonalRootDatum` and no root datum of an orthogonal or spin group. The new sections §§9B.5–9B.8 are targets of the roadmap and not of the plan; the last sentence of the guidance (“do not choose another target of the roadmap”) keeps the worker from them. No change is needed. F3 recommends one sentence.

## The five questions

1. **Is the statement still faithful to the paper?** Yes, as far as the last check found. No placeholder is replaced: 28 declarations are `@[placeholder]`. The code of `GLCinLean/Statement/` is unchanged since the checked commit `bf3b2fd`. Since `b2a2045` the only change of a Lean file is in the module doc comment of `GLCinLean.lean` (28 lines, the entries on errors and gaps of the sources), checked with its changes. The pins moved in `064f476`: the three Tau Ceti modules that the statement imports did not change, the one changed module in the import closure changed in a proof, and the Mathlib files of the declarations that the statement uses did not change (“Tau Ceti, `b2350004` to the pin” above). The done check passed at the pins on 2026-11-19 (`STATUS.md`, “Build checks”), and `lake build` passes in the audit's worktree with only the `sorry` of the main theorem.
2. **Does the plan still reach a fully defined statement?** Yes. The plan has 312 nodes in 198 module plans; 90 are roadmap nodes in fifteen areas, and 222 are written here. `lake exe tracker lint` has no errors, and `python3 tools/check-module-cycles.py` finds no cycle. Wrong: none; no node is marked `wrong`, and this comparison found no false node. Missing: nothing new; the missing items of `STATUS.md`, “Open items”, stand (among them the node for ReductiveGroups 3A.5f). Held: the two rows of `STATUS.md`; #1734, #1687 and #2450 are open with the recorded heads, so no row is released. More than the statement needs: B8 and B9, in progress. The plan changed since `b2a2045` by the five big changes of 2026-11-19 (Tannakian reconstruction, compact generation of QCoh, the loop group, the decomposition theorem, D-modules on smooth schemes), each checked with `prompts/change.md`; this audit did not check them again.
3. **Is there a simpler faithful formulation or route?** No new one. F2 removes one choice from an example when Tau Ceti #44072 is at the pin.
4. **Which rule, prompt or tool got in the way?**
   - The date in the name of the report: two audits on one day give the same name `notes/audit-<date>.md`. `prompts/audit.md` can ask for the audited commit in the name.
   - The worktree of the planner refuses compound shell commands that it cannot check, also when they run no git. Scripts in the scratch folder, run as one plain command, work.
   - The monitor does not watch the roadmaps on main (F1).
   - Still open from the audit of `b2a2045`, question 4, and not applied: `prompts/audit.md` can name the comparison by file list (the GitHub compare API gives it without a clone); “Builds” in `AGENTS.md` can ask for `python3 tools/check-upstream-names.py` at each pin move (the session ran it at the pin move of `064f476`); a rule that the provider text of a node of `plans/Roadmap/` quotes the target name or the words of the roadmap that state the object.
   - Files and parts of `STATUS.md` that are no longer needed: the open item “ReductiveGroups README at `1b7b481a`”, which this audit settles; `notes/audit-2026-11-19.md` (below).
5. **Roadmap candidates.** Nothing changed since the audit of `b2a2045`: no candidate has all four triggers, and none is put to the owner. No module written here is ready (`lake exe tracker ready` lists roadmap modules only), so trigger 3 fails for all. The column “State” of the provider record stands.

## The findings of the two older reports

- **`notes/audit-2026-11-18.md`** (deleted when B8 and B9 were applied; git history keeps it)**.** B1 to B7 are applied (`STATUS.md`, “Decisions taken”). Of B4 one step is left, the provider of the analytification that `DModules.analyticDeRham` uses; it is an open item of `STATUS.md`. B8 (`Satake.criticalTwistBunDeterminantEquiv`) and B9 (the existence of theta characteristics) are in progress with `prompts/change.md`, on the branches `proposal/critical-twist-clauses` and `proposal/theta-characteristic-existence`. Its small changes S1 to S8 are applied. Open in this report: only the evidence of B8 and B9. It can be deleted when both are applied or closed. The provider record names it once, under “Accepted roadmaps that cover nodes written here” (“`notes/audit-2026-11-18.md` has the evidence for each row”); that sentence is removed with the report.
- **`notes/audit-2026-11-19.md`** (the audit of `b2a2045`). F1, F2, F5 and F6 are applied, and the session applied the two changes of guidance of F1 and F7 (the configuration has both texts). F3 (the route of G2.11) and the open point of F1 (the folder of three nodes) are open items of `STATUS.md`. F4 is the list B3 to B9, of which B8 and B9 are in progress. Its three suggestions of question 4 that are not applied are in question 4 above. Nothing else in it is open. It can be deleted when this report is on `main` and `STATUS.md`, “Audit”, names this report.

## Not compared

- The five big changes of the plan of 2026-11-19 and the two proposal branches were not read.
- The Tau Ceti pull requests opened before 2026-11-19 were not searched again; only the recorded ones were read for their state.
- The fifteen template updates were read by title, and #2544 by its description.
- The 179 changed Tau Ceti files outside the import closure of this project were compared only in the lines that start a definition.
- The generated status files of the roadmaps were not read again; none changed.

## For `STATUS.md`

**Audit.** The last audit is of `d2bf2df` (2026-11-19); its report is `notes/audit-2026-11-19-roadmap-1b7b481a.md`. It compared the plan with TauCetiRoadmap main `1b7b481a` and with Tau Ceti main `d91980bd`, which is the pin (`docs/blueprint-providers.md`, “Snapshot”), from the revisions of the audit of `b2a2045`. Its result: the change of ReductiveGroups (#2530) adds §§9B.5–9B.8, the split classical groups and the general spin groups. It changes no layer, number, title or text that the plan or a guidance cites, adds no target that a node written here states, and gives no node a new provider. The audit found no big change. Its small changes are applied: the provider record, and one sentence of `Constructible.ComplexPoints`. B8 and B9 are in progress as before. The sentences of the present entry on the READMEs at `1b7b481a` (“TauCetiRoadmap main is `1b7b481a`: … is not compared with the plan”) are no longer needed.

**Workers.** No guidance must change. The targets of `author-groups` are targets of ReductiveGroups at `1b7b481a`. Recommended, one added sentence in its guidance (F3); the full text is then (1,781 characters):

```
Work on the root datum of a reductive group. Tau Ceti main has TauCeti.Pinning with its torus, Borel subgroup and root vectors, TauCeti.SplitMaximalTorus, the unipotent radical, TauCeti.twoWeylVector, and root data only for GL_n, SL_n, Sp_2n and split tori. Choose a target among the missing parts, in this order: (1) Layer 7, the item "Root datum": the integral root datum of a reductive group with a specified split maximal torus, with roots and coroots from the adjoint action of the torus, as a Mathlib RootDatum on the character and cocharacter lattices; (2) the based root datum of a pinning, with its base of simple roots (Section 8.2 "Pinnings" and Layer 5); (3) Section 7C.3: the sum of the positive coroots as a cocharacter of the torus, from TauCeti.twoWeylVector; (4) Layer 9D: every split connected reductive group over a field has a pinning. When these are blocked, work on Layer 3A.5c: proper maps of separated schemes locally of finite type over the complex numbers give proper maps on complex points, and the complex points as a functor; the carrier, its topology, open and closed immersions, Hausdorff, locally compact and fibre products are already in TauCeti.Topology.Algebra.PointTopology.Scheme. A route of Layer 3A.5c for proper maps uses Chow's lemma (SchemeAndStackFoundations, Section 4.12) over affine opens of finite type of the base; this case, Chow's lemma over an affine base, is in the open pull request #44039: do not prove it again; build on it once it is merged, and until then work on the complex points as a functor. Work only on the targets named here. If none of them is available (blocked, claimed by another contributor, or covered by an open pull request), end the round without a pull request; do not choose another target of the roadmap.
```

The watched pull requests: all eleven of Tau Ceti and all four of TauCetiRoadmap are open with the recorded heads. Add Tau Ceti #44072 (F2) and #44039 (F3) to them. No Tau Ceti pull request of ours is open.

**Held.** No change. #1734 (head `e16543f1`), #1687 (head `d99fdc2b`) and #2450 (head `26c8a4ff`) are open with the same heads, without review.

**Open items.**
- “ReductiveGroups README at `1b7b481a`” is settled and can be removed. Result: the README only adds §§9B.5–9B.8 and their supplier contracts; every label that the plan cites is unchanged; no node duplicates a new target or gets a new provider; the provider record has the comparison under “Other facts about these areas”.
- New: **`Curves.thetaCharacteristicProjectiveLine` and Tau Ceti #44072.** The open #44072 constructs a specified isomorphism `Ω¹_{ℙ¹_R/R} ≅ 𝒪(−2)` over every commutative ring. The node now chooses an isomorphism, because Tau Ceti at the pin gives only its existence. When #44072 is at the pin, the node names that isomorphism in place of the chosen one.
- New: **Template updates of roadmap READMEs.** Fifteen open roadmap pull requests with the title “Template update: <area>” (#2539, #2541 to #2550, #2554 to #2557) rewrite the README of their area in the current layout and can renumber its sections. None is for an area of the plan. When one is opened for such an area, compare the labels that the nodes and the guidance cite with its README; when one merges, an audit is due.
- The item “The local sections of orbit maps” stands: 3A.5f “Complex orbits” has the same text at `1b7b481a`.
- “Pins”: still true. Tau Ceti main is the pin and has no tag `v4.36.0`. The open Tau Ceti #44135 moves Tau Ceti to Mathlib `35f49460`; when it merges, Tau Ceti main is past the pin.

**Counts.** Unchanged: 28 placeholders; 312 planned declarations in 198 module plans, 222 written here (31 of the statement) and 90 in fifteen roadmap areas; 195 nodes in 74 module plans in `plans-proof/`, 9 of them in six roadmap areas; 267 pairs of an upstream declaration and its module, all confirmed at the pin.
