# Step 2: plan

**Goal.** Write the blueprint of the GLC statement, and redesign the Lean statement to match it.
The blueprint lists every object that [GLC1] Conj. 1.6.7 uses, down to what Mathlib and Tau Ceti
already have, and says for each where it comes from and what it depends on. The redesign makes
the statement say *which* equivalence it claims, in the form `AGENTS.md` describes.

**Done when**
- `blueprint.md` lists every object the statement uses, each with: the exact locator in the
  papers; its provider (Mathlib, Tau Ceti, a Tau Ceti roadmap item, an open Tau Ceti roadmap pull
  request, or missing), with the Tau Ceti commit checked; what it depends on; library or
  statement; and its Lean name and state (planned, placeholder, defined);
- `blueprint.md` proposes answers, with reasons, to the questions left for after the blueprint:
  how to use the open Tau Ceti roadmap pull requests (#1828, #999, #1056, #1202); how other Lean
  libraries may be used (AxiomMath/Stacks, stacks-and-moduli, the Langlands knowledge base,
  infinity-cosmos); and how to handle the ∞-categorical layer;
- the Lean statement is redesigned as one change: stated through the characterisation of `𝕃_G`,
  with `sorry` only in the main theorem, no re-export layer, Mathlib-style files, and the
  placeholders refined so the statement exposes the objects the blueprint names (for example
  `IndCohNilp` through singular support, `Psi` as a composite, `LCoarse` built from the spectral
  action);
- the done check in `AGENTS.md` passes;
- a fresh agent has reviewed the redesigned statement with `prompts/review.md`;
- `STATUS.md` is updated, the prompt for the next step (`prompts/build.md`) has been checked and
  updated if needed, and the work is committed and pushed.

**Context**
- The papers' TeX is in the git-ignored `references/papers/<id>v<version>/src/`; GLC I is
  `2405.03599v3/src/functor.tex` (the conjecture is labelled `c:GLC dR`). Download any other
  paper you need from arXiv into that folder, and add it to `docs/references.bib`.
- Research of 2026-11-08 in `notes/research/`: `audit-lean.md` (the current Lean files),
  `mathlib-coverage.md`, `tauceti-library.md`, `tauceti-roadmaps.md`, and the notes on the papers
  (`further-glc-series-proof-papers.md`, `further-scholze-…`, `further-arinkin-gaitsgory-…`,
  `further-gaitsgory-indcoh.md`, `further-agkrrv-…`, `further-gaitsgory-rozenblyum-…`) and on other
  libraries (`stacks.md`, `further-stacks-and-moduli-…`, `further-langlands-knowledge-base-…`,
  `further-infinity-cosmos-…`, `further-jo-l-riou-…`). They are dated evidence: re-check Tau Ceti
  live.
- `notes/research/annals-challenge.md`: how the Annals Challenge formalises statements, including
  the "hack answer" test (would a trivial choice for a placeholder make the main theorem easy?).
- GLC III–V argue by induction over Levi subgroups, so `Setting` should allow that.
- Library interfaces keep the ground field and the coefficient field apart, so that other sheaf
  theories can be added later.
