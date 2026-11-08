# Goal: the proof

**Goal.** A proof of GLC I Conj. 1.6.7 as stated in `GLCinLean/Abstract.lean`: a theorem
outside the abstract (for example in `GLCinLean/Proof/`) with exactly the abstract's statement,
whose axioms are only `propext`, `Classical.choice` and `Quot.sound`, and a sorry budget that is
empty.

**Read first:** `PLAN.md`, `AGENTS.md`, the blueprint, and GLC I–V (`references/papers/`).

**Steps.** Extend the blueprint with the proof's structure (one node per numbered result used),
then prove nodes whose dependencies are proved, one per commit, building each
time. Copied Stacks theorems get their proofs ported here too.

**Notes.** Changing the abstract's statements or definitions to make a proof easier is a
statement change, so the owner would want to hear about it. An `axiom` would leave the proof
incomplete. `reviews/` is the owner's: a budget entry whose theorem is proved can be listed for
them to remove.

**Done when** the final theorem exists, `#print axioms` on it shows only the three standard
axioms, the budget is empty, and the build passes.
