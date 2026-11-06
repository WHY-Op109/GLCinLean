# Goal: the proof

Paste into a Claude Code session in goal mode, only after the statement goal is done.

**Goal.** A proof of GLC I Conj. 1.6.7 as stated in `GLCinLean/Abstract.lean`: a theorem
outside the abstract (for example in `GLCinLean/Proof/`) with exactly the abstract's statement,
whose axioms are only `propext`, `Classical.choice` and `Quot.sound`, and a sorry budget that is
empty.

**Read first:** `PLAN.md`, `AGENTS.md`, the blueprint, and GLC I–V (`scripts/fetch-papers.py`).

**Steps.** Extend the blueprint with the proof's structure (one node per numbered result used),
then prove nodes whose dependencies are proved, one per commit, running `scripts/check.sh` each
time. Copied Stacks theorems get their proofs ported here too.

**Do not:** change the abstract's statements or definitions to make a proof easier (that is a
statement change: ask the owner); add an `axiom`; edit `reviews/` (removing a budget entry once
its theorem is proved is the owner's step: list it for them).

**Done when** the final theorem exists, `#print axioms` on it shows only the three standard
axioms, the budget is empty, and `scripts/check.sh` passes.
