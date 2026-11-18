# Change

**Goal.** Make one big change of the plan, agreed between the planner and Codex. "Small and big changes" in `AGENTS.md` says which changes are big.

**Agreement.** Both judge the change by the papers, by Mathlib's principles and by the rules of `AGENTS.md`: "Sources of code", "Lean code" (the natural generality among them) and "The statement". They agree when Codex's last report has no open objection.

**Done when**
- with agreement: the change is on `main`, the done check passes, and "Decisions taken" in `STATUS.md` records what changed, why, and that both agreed;
- without agreement after three rounds: the change and its reports are on the branch `proposal/<topic>`, and the question is under "Waiting for the owner" in `STATUS.md`, in at most ten lines: what and why, the options, both positions, and the branch.

**Steps**
1. The planner writes down the problem with its evidence: the Lean error or the lines of the paper, and the nodes it touches (`lake exe tracker show`).
2. The planner works out the options, chooses one, and writes it on the branch: the plan nodes and any code. A checker checks the branch with `prompts/check.md`.
3. Codex checks the branch independently: `codex exec`, read-only, with its most capable model at high reasoning effort, and a short prompt that names the branch, the problem, the sources and the criteria of "Agreement", and leaves out the planner's conclusion. Its full output is saved as `notes/checks/<topic>-codex-<round>.md` on the branch.
4. The planner checks each finding of Codex against the files and the papers, fixes what is right, and answers the rest with evidence.
5. Steps 3 and 4 repeat with the revised branch and the answers, until Codex has no open objection.
6. The session applies the change or writes the question, and returns to the other work.
