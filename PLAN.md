# GLCinLean plan

Written 2026-11-06. Replaces the earlier planning documents, which are kept in the private
repository `GLCinLean-archive`; nothing there is in force.

## Goal

1. **The statement goal:** a faithful Lean statement of GLC I (arXiv 2405.03599 v3)
   Conjecture 1.6.7, with every definition it uses real (no placeholders).
2. **The proof goal:** a proof of it, following GLC I–V.

The owner cannot check the mathematics, so the fidelity review (`prompts/review.md`) is the
evidence for faithfulness, and no claim of faithfulness is made without an outside expert.

## What exists (2026-11-06)

- `GLCinLean/Abstract.lean`: the hypotheses and the conjecture, over placeholders.
- `GLCinLean/Foundations.lean`: re-exports of Mathlib and Tau Ceti objects, plus placeholders.
- `blueprint/plans/`: a stub tracker plan of those declarations.
- `reviews/`: the sorry budget and the statement pin (owner-approved records; not yet approved).
- `glc/project.toml`: the review configuration.
- CI (`.github/workflows/ci.yml`): build from caches and every check, on each push to `main`.
- The review checks come from `github.com/WHY-Op109/reviewkit`, pinned in `lake-manifest.json`.

## How work runs

One Claude Code session at a time, started by the owner in goal mode with one of the prompts:

| Prompt | Purpose |
|---|---|
| `prompts/statement.md` | the statement goal: replace placeholders by real definitions |
| `prompts/proof.md` | the proof goal (only after the statement goal) |
| `prompts/review.md` | the fidelity review of changed key definitions; run now and then |

Sessions commit locally; the owner reads and pushes. `scripts/check.sh` (and CI) must pass.

## Decisions in force

**The statement**
- Hypotheses: `k` algebraically closed of characteristic 0; `X` a smooth, proper, connected
  curve over `k`; `G` a reductive group (Tau Ceti's). "Algebraically closed" and "connected"
  come from the conventions GLC I cites (AGKRRV) and from GLC II, not from GLC I's first sentence.
- The statement holds for every square root of `ω_X`, taken as data (a line bundle with an
  isomorphism from its square to `ω_X`), and for every pinning.
- The dual group `Ǧ` is an input with an identification of its root datum with the dual of
  `G`'s, plus a sorry'd theorem that such a `Ǧ` exists (so a wrong identification shows up as a
  false claim, not a vacuous statement).
- `𝕃_G` is *the* functor with Cor. 1.6.5's two properties, chosen from Cor. 1.6.5's existence
  statement; uniqueness is stated too. The properties are about continuous `QCoh(LS)`-linear
  functors in the enhanced sense; "isomorphic" is always an isomorphism, never an equality.
- The conjecture: `𝕃_G` is an equivalence.

**The code**
- `GLCinLean/Abstract.lean` holds the statement and every GLC-specific definition it needs, and
  imports only Mathlib, Tau Ceti and `GLCinLean.Foundations`.
- `Foundations` re-exports provider objects (one name each) and holds provider-less
  placeholders. Placeholders are data only: `@[placeholder]` on an `opaque`, never an `axiom` or
  a definition with a trivial witness.
- Missing foundations, per object: use Mathlib, else Tau Ceti, else copy the needed declarations
  from `AxiomMath/Stacks` (statements first, into `GLCinLean/Stacks/`, with provenance; its
  closure class and import rule are added to `glc/project.toml` with the first copy), else
  build locally in `GLCinLean/Staging/` (subject folders as in Mathlib; names
  `GLCinLean.<Subject>.…`). Foundations re-exports whatever is chosen.
- Tau Ceti is pinned to a tag (`v4.36.0-rc2`); Mathlib comes through it; builds use the caches
  and never compile Mathlib or Tau Ceti.

**The checks** (`lake exe review --config glc/project.toml all`)
- No axioms beyond `propext`, `Classical.choice`, `Quot.sound`; every `sorry` must be in the sorry
  budget, bound to its statement's fingerprint.
- The main theorem's and the hypothesis block's statements are pinned; a change fails CI until
  the owner re-approves.
- The closure from the abstract (walking into Tau Ceti) lists the key definitions; the
  fidelity review takes its scope from that list.
- The checker's own fault-injection tests live in ReviewKit (`test/faults.toml`), not here.
  The GLCinLean fixtures, evidence records and extras file were moved to `GLCinLean-archive`
  (`glcinlean-2026-11-06-slimming/`) on 2026-11-06.

**The project**
- Public but unannounced; nothing is sent to other projects unless the owner chooses.
- The GLC papers are fetched locally (`scripts/fetch-papers.py`) and never committed.
- Subscriptions only; no API billing.

## Open questions

- Which formalism the geometric objects use (Tau Ceti's stacks, Stacks' stacks, or functors of
  points), decided when the blueprint is written.
- For each missing foundation: wait for Tau Ceti, copy from Stacks, or build locally.
- Who the outside expert is, and when to end the quiet phase.

## Next step

Run `prompts/statement.md`. Its first task is the blueprint: every definition the statement
needs, with its source in the papers and its provider.
