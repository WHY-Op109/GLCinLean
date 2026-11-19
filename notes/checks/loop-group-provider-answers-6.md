# The merge of `main` into `proposal/loop-group-provider`

`main` at `d29fcb6` is merged into the branch, as one merge commit and without a rebase. `main` was at `3eeb496` when the merge was asked for and gained one commit meanwhile, which changes only `STATUS.md`; the merge takes it. `STATUS.md` and `tools/` are those of `main`.

## Conflicts and their resolution

Two files had conflicts. Every fact of both sides is kept, each once.

**`GLCinLean.lean`, "Errors and gaps found in the sources".** Both sides added entries at the end of the list. The list now ends with the two entries of `main`, on [CompactGeneration] §§1.1.7 and 1.2.2 and on [MV] §11, and then the entry of this branch on [GLys] §7.1.3. No entry is changed and no line is over 100 characters.

**`docs/blueprint-providers.md`, "Accepted roadmaps that cover nodes written here".** Two places.
1. The paragraph above the table. The text of `main` is kept: its new wording on when a node moves, the sentence that SchemeAndStackFoundations §2.18 is not a row, and the list of what the pinned source lacks, without `neutralTannakian_recognition`. Two facts of this branch are added to it: the loop groups of FormalConnectionsOpers are in the table "Roadmaps that own plan nodes", and the two rows on the loop Grassmannian were read on 2026-11-19.
2. The table. `main` removed the rows of MotivesAndAlgebraicCycles and of SchemeAndStackFoundations §2.18, whose nodes are now roadmap nodes, and left the row of FormalConnectionsOpers as it was. This branch had replaced that row by the row on §3A.5 and added the row of EndoscopicTransferAndUnitaryTraceComparison §3.2. The result has the two rows of this branch and not the two rows that `main` removed.

## What the merge made wrong

Nothing. Each of the sixteen nodes that this branch adds or changes was checked: every node that its text or its dependencies name exists after the merge, and none of them names `Satake.weightProjectives` or another node that `main` removed. No node that `main` added or changed names a loop group node, and none places the Beauville–Laszlo comparison in `Hecke.Correspondence`. The counts of `docs/blueprint-providers.md` agree with the merged plan: the table "Roadmaps that own plan nodes" sums to 78, and candidate 7 has 7 + 2 + 2 + 1 + 27 + 5 nodes.

## The counts

- 300 planned declarations in 184 module plans.
- 222 under `plans/GLCinLean/`. Of them, 221 have a roadmap node below them; the other is `CategoryTheory.tensorPowFunctor`.
- 78 under `plans/Roadmap/`, in twelve roadmap areas.

These are the counts of `main` (296, 180, 220 and 219, 76, eleven) with the four nodes, the four module plans and the one area of this branch. Proposal §§6 and 7 have them.

## The worker guidance of proposal §8

It had 5,223 characters. The Worker's limit is 4,096 (`EXTRA_ROADMAP_PROMPT_MAX_CHARS`; `validate_extra_roadmap_prompt` counts the characters after removing the surrounding white space). So it was over and is shortened to 4,058 characters; the Worker's own function accepts it. The five steps, their order, the case to cover, the rule on hypotheses, every reusable declaration, the checks that the plan adds (the two for `𝔾_a`, and that the piece of level 0 is the arc group) and the closing instruction are kept. Removed: words, the second mention of names, the text of the checks of §3.1 for `𝔾_m`, which the roadmap states and the guidance now names as "the checks of Section 3.1", and the descriptions in the list of what is not a target.

## The checks, on the merged tree

- `lake exe tracker lint`: no errors; 61 warnings on the superseded fields of the 31 existing declarations of the statement.
- `python3 tools/check-module-cycles.py`: 184 module plans, 300 nodes, 0 cycles.
- `python3 tools/check-upstream-names.py`: 240 pairs of a declaration and its module; 0 not confirmed.
- The done check of "Builds": `lake build` succeeds with one warning, the `sorry` of the main theorem; `lake lint` passes; `lake env lean tools/check-statement-axioms.lean` lists 31 declarations and shows `sorryAx` only for the main theorem.
- `lake exe tracker ready` lists `Roadmap.FormalConnectionsOpers.FormalLoopGroups`.
