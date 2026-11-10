# Independent opinion on the open decisions, 2026-11-10

Author: Codex (GPT-6.1).

This preserves the independent opinion given to the owner in chat. The recommendations are proposals, not owner decisions. Project file links have been made relative.

I would adopt the Hecke reformulation and split Session 4. I would revise several workflow proposals, especially the approval boundary and the replacement of the axiom audit.

I checked the repository at `b63e688`, the relevant paper sources, the tracker implementation, pinned foundations, and current upstream roadmaps. Nothing in the repository changed during the review. **Disagree** below marks a substantive departure from a report’s proposal; **partly disagree** marks a proposal I would amend.

One upstream correction: [roadmap PR #1676](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1676) merged on November 10. The reports’ statement that it remains open is now outdated.

For decisions **1–10 in the goal review**, my choices are:

**1 — Adopt property 2′, in its mapping-space form. Agree with the choice.**

The proposed equivalence is mathematically correct. Here is the argument, including its dependencies.

Write \[ \mathcal R=\operatorname{Rep}(\check G)_{\mathrm{Ran}},\quad Q=\operatorname{QCoh}(\operatorname{LS}_{\check G}),\quad D=\operatorname{Dmod}_{1/2}(\operatorname{Bun}_G). \] Let \(R:\mathcal R\to Q\) be spectral localization, \(P\) the vacuum Poincaré object, \(H(V)=V\star P\), and \(T=\Psi\circ F\). State property 2′ as the existence of an equivalence \[ \operatorname{Map}_D(H(V),M) \simeq \operatorname{Map}_Q(R(V),T(M)) \] **natural jointly in \(V\) and \(M\)**. This must be an equivalence of mapping-space bifunctors, with coherent naturality—not separately chosen equivalences of sets of morphisms.

For comparison with the paper, assume Thm. 1.2.4. The spectral action supplies \(B:Q\to D\), \(B(E)=E\star P\), with \(H\simeq B\circ R\), and \(L_{\mathrm{coarse}}=B^R\). Put \(U=R^R\). Then \[ H^R\simeq U\circ L_{\mathrm{coarse}}. \] Thus property 2′ is equivalent to \[ U\circ T\simeq U\circ L_{\mathrm{coarse}}. \] Since \(U\) is fully faithful, this is equivalent to \(T\simeq L_{\mathrm{coarse}}\), exactly the second property of Cor. 1.6.5. Equivalently, apply \(R\) and use the invertible counit \(RU\simeq\mathrm{Id}_Q\). These are the inputs recorded in [GLC1 §§1.2, 1.4 and 1.6](https://arxiv.org/html/2405.03599v3).

**Defining property 2′ does not require Thm. 1.2.4.** The mapping-space formulation uses \(R,H,P,\Psi\), but neither the spectral action nor \(U\). The construction of \(R\) from evaluation of local systems is given independently in [Gaitsgory’s Outline §4.3](https://arxiv.org/abs/1302.2506v3).

The report nevertheless overstates matters when it says “without any theorem”: constructing these functors and their coherence still requires substantial mathematics, including Satake. What disappears is this particular factorization theorem and the construction of the coarse right adjoint.

I prefer this formulation because it removes a major prerequisite without weakening the intended characterization. Keeping the coarse functor makes its construction part of the statement’s prerequisites. The eventual Lean comparison theorem should remain an explicit proof-phase obligation.

**2 — Use continuous \(k\)-linear enhanced functors without imposing \(Q\)-linearity. Agree.**

“Plain” must mean forgetting the additional `QCoh(LS)`-module structure, not forgetting \(k\)-linearity or enhancement. Keep continuity and the specified t-structure. Prop. 1.7.2 then supplies the additional spectral linearity later.

Retaining the present linear placeholders would force the spectral action back into the statement and undermine decision 1. Monoidal and module constructions still needed inside the library must remain.

**3 — Move the exclusively spectral-action prerequisites outside the active statement plan, after statement approval. Agree.**

I reproduced the current count of 369 reachable library nodes and the 135-node dependency closure of `Hecke.action`. The proposed reduction is substantial.

However, treat 174 as an estimate, not a certified final count: the new natural-equivalence interface and the revised dependencies have not been implemented. Compute the cut from the approved formulation, retaining dependencies of examples and comparison results. Keep deferred work in something such as `plans-proof/`.

Leaving those nodes active would continue offering proof-phase work as statement work; deleting their mathematical specifications entirely would discard useful work.

**4 — Make the upstream foundation work explicit. Agree.**

Name concrete targets and blockers in `STATUS.md`, with a short routing instruction in `build.md`. In particular, the accepted EnhancedDerivedSheaves roadmap delegates several foundational constructions to BordismFormalGroups F6.5; “work on E0–E5” alone is too broad. See the [accepted foundation contracts](https://github.com/TauCetiProject/TauCetiRoadmap/blob/4ec889e8f0480e2cdb21a524eb76e48215c9ad94/TauCetiRoadmap/EnhancedDerivedSheaves/README.md).

The alternative invites repeated local sessions that cannot replace a placeholder. This is a statement about the critical path, not a claim that absolutely no useful local work exists.

**5 — Remove existing upstream declarations from the active plan and centralize provider records. Agree, with preservation of references.**

The tracker’s treatment of unimported upstream declarations explains the misleading readiness results. Remove their plan nodes and update every affected dependency.

Preserve exact declaration names, import modules, accepted roadmap targets, and snapshot information in the provider record or the consuming node’s mathematical brief. Remove repeated snapshots, not useful traceability.

Keeping the current leaves misrepresents completed upstream work as unfinished work. Removing their records altogether would make later integration harder.

**6 — Request placeholder-aware tracker support, without making it a prerequisite. My choice: yes.**

The current workaround loses intended dependencies when the tracker regards a placeholder as proved. Attribute-aware readiness would address a real problem.

I would prefer a distinct placeholder flag or state rather than conflating placeholders with declarations depending on `sorryAx`. Until support exists, retain the explicit placeholder inventory and dependency cautions. A local tracker fork would add maintenance disproportionate to this need.

**7 — Correct the dependencies and providers, but do not yet approve the blanket determinant scope reduction. Partly disagree.**

`QCohLS` should depend on the construction of QCoh on the local-system stack, not on its rigidity theorem. The proposed determinant and Schubert provider corrections are justified.

The determinant argument checks only one consumer. [The determinant on `Bun_G`](../plans/GLCinLean/AlgebraicGeometry/Stacks/Determinant.toml) uses curve cohomology, but [the Satake twist](../plans/GLCinLean/GeometricLanglands/Satake/Twisting.toml) also needs a relative determinant with factorization and sign compatibility.

I would narrow the requested API after checking both consumers: families, descent, quasi-isomorphism invariance, base change, relative determinants, and grading. A suitable two-term construction may suffice. “Amplitude \([0,1]\) at the `Bun_G` consumer” alone does not establish that. Conversely, implementing an unrestricted determinant theory locally would duplicate accepted upstream scope.

**8 — Record #1734, #1687 and #848 as ownership candidates. Agree.**

All three remain open, at the heads recorded in the upstream note. Their proposed scope is relevant, but partial: arbitrary-field Grassmannian geometry does not automatically supply fusion over the chosen curve; the proposed stack sheaf theory needs a comparison with the intended QCoh construction; analytification does not supply every D-module comparison. See [#1734](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1734), [#1687](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1687), and [#848](https://github.com/TauCetiProject/TauCetiRoadmap/pull/848).

Assigning ownership before acceptance would make the plan depend on a proposal. Ignoring them would risk competing work.

**9 — Accept AxiomMath as prior art; make no port now. Agree.**

The repositories have Apache-2.0 licences and remain on older toolchains: Stacks uses Lean 4.35.0 and Weil 4.34.0-rc2, against this project’s 4.36.0-rc2. Their existence does not remove the current enhancement bottleneck. See [Stacks](https://github.com/AxiomMath/Stacks) and [Weil](https://github.com/AxiomMath/Weil).

When a concrete target becomes ready, assess a minimal dependency closure, the actual hypotheses, axioms, attribution, and compatibility. Rejecting all prior art wastes useful mathematics; bulk porting now spends effort away from the critical path.

**10 — Clarify that algebraic closedness is the owner’s chosen scope. Agree.**

The current docstring already cites sources using that scope, but an explicit distinction from GLC1’s standing field hypothesis would be clearer. This is documentation, not a reason to generalize the Lean statement beyond the owner’s goal.

For **W1–W12 in the workflow review**:

**W1 — Let the owner operate the persistent Worker; let local sessions integrate its results. Agree as the default workflow.**

The Worker already manages maintenance, review, target selection, and authoring. Its target guidance applies to roadmap rounds, not every round. A second orchestration loop here adds little. The [current Worker README](https://github.com/TauCetiProject/TauCetiWorker/blob/f65aafb2ed0c93c31f2be3ecdc4fc01ee57c439a/README.md) confirms this.

Record commands, concrete targets, and resulting PRs. Do not make a local build session responsible for producing an upstream merge.

**W2 — Replace `build.md`, but not verbatim with §1.5. Partly disagree.**

The proposed direction is right: allow foundation progress without requiring an immediate placeholder replacement, and permit an honest blocked outcome.

I would amend three things: allow a bounded, useful part of a large module; use the semantic approval boundary described under W4; and obtain Worker briefs from a **specific module or node**. `tracker show Roadmap.<area>` does not recursively print all descendant targets: [the implementation prints that module’s own nodes and its immediate children](../tools/tracker/Tracker/Commands.lean).

The old prompt demands an often-impossible outcome. The proposed replacement still has operational traps if copied unchanged.

**W3 — Use `plans/Roadmap/<area>/` for pending upstream obligations. Agree.**

This makes ownership visible without adding a tracker feature. Preserve node identities and cross-area prerequisites.

Remove a landed obligation only after its actual replacement is available at the project’s selected pin, its interface has been checked, and dependent records have been updated. A merge somewhere upstream is insufficient by itself.

Keeping ownership buried in prose makes task selection unreliable. Permanently retaining completed upstream nodes recreates decision 5’s problem.

**W4 — Review definitions when written, but retain owner approval for semantic changes throughout the statement’s dependency closure. Disagree with approval based only on directory.**

A change to `Sheaves.indcoh`, singular support, or compactness can alter the conjecture without touching `GLCinLean/Statement/`.

My rule would be: new and changed mathematical definitions receive independent review, including relevant unplanned helpers; changes to the statement’s meaning require owner approval wherever they occur; proof-only changes and verified equivalent refactors do not. Use proposal branches for changes awaiting approval.

The present rule is too broad for routine refactoring. The proposed directory boundary is too narrow to protect mathematical meaning.

**W5 — Keep a meaning-review prompt, with a broader semantic scope than “planned definitions only.” Partly disagree.**

I support separating it from standards checking, distinguishing standalone reviews from review subagents, using commit-based report names, and avoiding repetitive tests of unchanged opaque placeholders.

But a plan entry is not a sound review boundary. Include relevant helper definitions, the main theorem’s statement, and characterizations used to justify replacements. Previously reviewed dependencies may be treated through their contracts only at the reviewed revision; inspect their bodies when the contract is inadequate.

The report’s assertion that a wrongly stated lemma is always unprovable or harmless is too strong: a proved weaker lemma can be misrepresented as establishing the intended mathematical contract. Lean checks the proposition written, not that interpretation.

**W6 — Add `lake lint` and keep a separate standards check using `AGENTS.md`. Agree.**

The lint driver is already configured. One concise instruction pointing to the existing standards is enough; another prompt file would mostly duplicate them.

Lint handles mechanical checks. It does not replace mathematical review, reuse searches, or the axiom audit.

**W7 — Add an event-triggered whole-project audit. Agree.**

Module work cannot reliably detect an unnecessarily expensive formulation or a changed upstream owner. Layer completion, significant roadmap changes, and placeholder replacement are useful triggers; a count of substantive build sessions is a reasonable backstop.

Update the provider record in place and keep an identifiable audit report. Clarify that its permitted writes include that record, the report, and `STATUS.md`. Repeating a full audit after every small change would cost too much; abandoning whole-project review would let the plan drift.

**W8 — Accept the worktree exemption and clarify coordinated pin changes; retain searches of upstream `main` before substantial proofs. Partly disagree.**

Read-only reviewers do not need worktrees. A needed Tau Ceti bump can legitimately bring its matching Mathlib pin, with owner approval for a required Lean upgrade and verification of caches and tracker compatibility.

I would not remove `main` from substantial-proof searches. An existing upstream proof may justify the very pin update the rules permit, or reveal that a planned helper would duplicate upstream work. Batch these searches against a recorded snapshot rather than repeating them mechanically.

Searching only the pins makes reuse depend on an outdated view of the library.

**W9 — Consolidate policies and create a Held list. Agree.**

Give each held item a reason and a release condition. Keep rules in `AGENTS.md`, changing state in `STATUS.md`, and mathematical specifications in the plan.

Retain mathematical cautions in briefs where they define the required object—for example, the half-twist or a missing comparison theorem. These are useful task specifications, not redundant policy text. Repeated fixed rules drift; removing all contextual cautions would make briefs less usable.

**W10 — Keep the explicit axiom audit. Disagree with the proposed replacement.**

There are two concrete problems:

- [Tracker state classification](../tools/tracker/Tracker/Types.lean) tests for `sorryAx` first. A declaration using both `sorryAx` and a forbidden axiom is classified as `stated`.
- [The printed state totals](../tools/tracker/Tracker/Commands.lean) count planned declarations, not every declaration.

Consequently, “1 stated, 0 axioms” is not the required audit.

The manual declaration list can eventually be replaced by an automatically enumerated, failing axiom check that examines actual axiom sets and identifies the sole permitted `sorry` declaration. Until then, retain `#print axioms` and use the tracker as a supplementary check.

**W11 — Resolve the three STATUS policies before ordinary implementation sessions. Agree.**

They determine foundation choice, permitted reuse, and how proposals affect ownership. Settling them once avoids inconsistent implementation decisions.

This should not delay read-only investigation, but leaving them indefinitely marked “proposed” would make the build prompt ambiguous.

**W12 — Begin narrow roadmap scoping before reaching derived prestacks. Partly disagree with waiting until then.**

Check existing ownership first, especially #1687. Then prepare only the first clearly uncovered general layer, for the owner to consider proposing.

Acceptance and upstream coordination take time. Waiting until the layer is ready risks creating a new serial blocker. Conversely, proposing the entire general library now would freeze speculative interfaces too early. Early, narrow scoping is the better compromise.

For the **three open decisions in `STATUS.md`**:

**STATUS 1 — Use open roadmap PRs as design evidence, while accepted roadmaps remain authoritative. Agree.**

Record exact heads and recheck status before relying on them. #1901, #1630 and #868 remain open; their proposals do not yet change ownership. Do not import `Suggested.lean` or adopt an unmerged dependency pin.

Ignoring proposals risks incompatible design. Treating them as accepted commits the project to unsettled contracts.

**STATUS 2 — Permit read-only discovery and selective reuse from other libraries; assess new dependencies explicitly. Agree.**

The proposed declaration inventory, version check, licence check, axiom audit, and comparison with existing objects are appropriate. The deciding question should be what concrete missing mathematics a dependency supplies.

An outright ban would waste reusable work. Adding a library because its subject sounds relevant would import compatibility and maintenance costs without demonstrated benefit.

**STATUS 3 — Continue with Mathlib quasicategories and Tau Ceti’s enhanced foundations. Agree.**

The pinned code contains real starting points, including DG nerves and the [K-injective homotopy-category comparison](../.lake/packages/TauCeti/TauCeti/CategoryTheory/DG/CochainComplex/KInjective.lean). The accepted roadmaps identify the further coherent constructions required.

Do not mistake those starting points for a completed enhanced foundation. But a competing foundation would duplicate upstream scope, and ordinary triangulated categories lose the mapping-space information needed for the intended constructions.

**Session 4 — Split it into three sessions. Yes; this changes the current single-session arrangement.**

1. **Workflow and independent plan changes.** Apply approved policies, provider corrections, and other changes valid under either statement. Preserve the current mathematical target.
2. **Statement proposal.** Write the reformulation on a branch, complete its checks and fresh review, and present the exact reviewed revision to the owner.
3. **Plan cut after approval.** Recompute dependencies from the approved statement, preserve required examples, move proof-only obligations, and finish the structural plan cleanup.

The existing order already recognizes the approval dependency. Separate sessions make that boundary clearer and avoid cutting the plan against a formulation that may change during review. If the statement is declined, the workflow improvements remain useful and the spectral-action prerequisites remain active.
