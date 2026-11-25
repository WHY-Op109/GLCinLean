# Answers to round 2 of the checks of `proposal/line-bundle-routes`

The report is `notes/checks/line-bundle-routes-codex-2.md` (Codex), on the branch at `fc66a4f`. It has no open objection to change 1 (the theta characteristic of the projective line) and one open objection to change 2 (the tensor product of roots). The fix is `d2cde84`.

After the fix `lake exe tracker lint` has no errors, `python3 tools/check-module-cycles.py` finds no cycle (198 module plans, 311 nodes), and `python3 tools/check-upstream-names.py` confirms all 359 pairs.

## Change 2, objection 1: the dependency still includes the full Picard groupoid

**Fixed (`d2cde84`).** The objection is right.

**The evidence.**

- The tracker (`tools/tracker/README.md`, "States"): a planned declaration "is *ready* when it is open or stated and every dependency in force is proved", and for an open node the dependencies in force are the suggested ones, that is, its `deps`.
- `AGENTS.md`, "Plan": "A node of `plans/Roadmap/` is deleted only when its declaration is at the pin, its interface is checked, and a checker has checked its meaning." So a roadmap node is discharged as a whole.
- At `fc66a4f` the node `LineBundle.picardGroupoid` held two parts: (1) the braided monoidal instance on `InvertibleSheaf.pullback` with its equations and the monoidal `pullbackId` and `pullbackComp`; (2) the class `PicardGroupoid` with its instance and the functor on the cores. `LineBundle.Root.pullbackTensorProductIso` used part (1) only and had the whole node in its `deps`. So it would have waited for part (2), which it does not use.

**The roadmap.** SchemeAndStackFoundations §3.4 "Picard groups: divisor classes, excision, Picard groupoids" (TauCetiRoadmap `b24abdf7`, `TauCetiRoadmap/SchemeAndStackFoundations/README.md`, lines 6025–6031) states as targets `PicardGroupoid C`, `picardGroupoid X := Core (InvertibleSheaf X)` "with its symmetric monoidal structure and `PicardGroupoid` instance", and "`pullback` (a functor of Picard groupoids)". It does not name a monoidal structure on the functor `InvertibleSheaf.pullback`. Part (1) is the prerequisite of the target `picardGroupoid.pullback`: a functor of Picard groupoids is a symmetric monoidal functor between the cores, and `TauCeti.CategoryTheory.Monoidal.Core` gives that from a braided monoidal functor between the categories `InvertibleSheaf`. The roadmap AlgebraicVectorBundles §1.2 "Strong monoidal pullback" (same commit, lines 189–212) states the same structure for all module sheaves ("make pullback strong symmetric monoidal on module sheaves, extending Tau Ceti's `QuasicoherentSheaf.pullbackBraided`") and does not name invertible sheaves either. So part (1) is a prerequisite and not a named target, in the same way as `LineBundle.Root` is the prerequisite of `rootGerbe`.

**What changed.**

- A new roadmap node, `GLCinLean.LineBundle.pullbackBraided`, in `plans/Roadmap/SchemeAndStackFoundations/LineBundlePullbackBraided.toml`. It holds part (1): the braided monoidal structure on `InvertibleSheaf.pullback`; the two equations on underlying module sheaves (the inverse tensor comparison is the tensor comparison of the pullback of module sheaves; the inverse unit comparison is `Scheme.Modules.pullbackObjUnitIso`); and the monoidal `InvertibleSheaf.pullbackId` and `InvertibleSheaf.pullbackComp`. Its `desc` names the provider as above, what Tau Ceti has (`QuasicoherentSheaf.pullbackBraided`, `isMonoidal_pullbackId_hom`, `isMonoidal_pullbackComp_hom`), what remains (a transport), and its two users. It has no `deps`, so its module is ready: `lake exe tracker ready` lists `Roadmap.SchemeAndStackFoundations.LineBundlePullbackBraided`.
- `LineBundle.Root.pullbackTensorProductIso`: its `deps` name `LineBundle.pullbackBraided` in place of `LineBundle.picardGroupoid`, and its `desc` names the new node.
- `LineBundle.picardGroupoid`: it keeps part (2), the class with its instance and the pullback of Picard groupoids as the functor on the cores, and it has `deps = ['GLCinLean.LineBundle.pullbackBraided']`. The facts on the pullback moved to the new node.
- `LineBundle.Root` (roadmap node): the sentence on the recursion names `LineBundle.pullbackBraided`.
- `docs/blueprint-providers.md`: SchemeAndStackFoundations owns 9 nodes, and its row names both nodes of §3.4; in the table of the ready roadmap modules, the row of the new module replaces the row of `Roadmap.SchemeAndStackFoundations.PicardGroupoid`, which is no longer ready because it depends on an open node; the rows of `TauCeti.tensorPow`, `isMonoidal_isInvertible`, `pullbackTensorProductIso`, `QuasicoherentSheaf.pullbackBraided` and of pull request #45392 name the new node. One older sentence said that the tensor product of roots is "built on the Picard groupoid of SchemeAndStackFoundations §3.4"; it now says what the branch does.
- `notes/checks/root-tensor-route.md` states the proposal after this fix.

**The other users, checked.** Before the split, `LineBundle.picardGroupoid` had one user, `LineBundle.Root.pullbackTensorProductIso` (`lake exe tracker show`). A search of `plans/` and `plans-proof/` for the name finds no other node that depends on it. `LineBundle.Root.tensorProduct` and `Stacks.rootGerbe` do not depend on it. So only one `deps` list needed the correction.

## A consequence that is not decided here

After the split, no node of `plans/` or of `plans-proof/` depends on `LineBundle.picardGroupoid`: `lake exe tracker show GLCinLean.LineBundle.picardGroupoid` has no line "needed by". The node is left in the plan, and its `desc` says that no node depends on it. To remove a planned definition is a big change of its own (`AGENTS.md`, "Small and big changes"). The facts for that decision: the node is a target of the roadmap §3.4 and stays one whether or not the plan lists it; the statement needs no declaration of it; and the worker `author-stacks` has it as a target in `STATUS.md`.

## The remarks of the report

- The dual of a root: the report confirms that the equation determines a unique isomorphism, also for n = 0, with no self-braiding identity. It adds that the lemma on `dualCongr` follows from `MonoidalClosed.id_tensor_pre_app_comp_ev`, because `dualCongr` precomposes by the inverse isomorphism. Not changed: the node names the lemma and leaves its proof to the writer.
- `FiniteLocallyFreeSheaf.pullbackDualIso`: the report says that it checked in Lean that the inclusion into finite locally free sheaves identifies both the dual and the pullback objects. This was an open point of the answers to round 1; the note records it.
- The report lists what it did not check: a second run of the proof of test lemma (b) of change 1, the chart formula of test lemma (a), the full evaluation square of the dual, and the comparison with the root interface of Tau Ceti, which does not exist yet. These stay with the writers of the nodes; none is an objection.
