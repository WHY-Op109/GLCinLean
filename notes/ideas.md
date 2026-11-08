# Rebuilding GLCinLean: ideas and context

These are my ideas and the context they need. They could be split into several prompts or become a workflow.

## What I want

- Reconstruct the whole project: redraft the whole plan and all the prompts.
- Work in a very simple way, at least in this repository: do the whole formalisation with
  prompts alone, without any complex system or harness.
- The goal is still the same: first the statement, then the whole proof, fully in Mathlib's documentation style.

## The formalisation

1. **A library, not a one-off.** The formalisation should not be something done once and never used again. It should also be a library for geometric representation theory (D-modules, perverse sheaves, etc.). It should follow [How to formalize all of mathematics](https://xenaproject.wordpress.com/2026/10/16/how-to-formalize-all-of-mathematics/) (Xena Project blog), especially this part:

   ```
   Defer to human-curated libraries, particularly Mathlib; follow their design principles and code rules, and continuously refactor to adopt their decisions.
   Prefer thoroughness and breadth. These must come before depth, but ultimately enable it.
   Avoid duplication. Generalize theorems for maximal reuse.
   Review additions publicly, according to agreed standards.
   Publish freely. Libraries should be open source, interoperable, and explorable.
   Stay up to date. Ensure continuous compatibility with every release of Lean and Mathlib.
   Stay open-minded about changes. If a better approach is discovered, it’s never too late.
   Document and organize. Files should be coherent, systematically organized, and their contents must be documented.
   Link to the existing literature. A mathematician should be able to trust and verify that the concepts described in the library have the expected meaning.
   Set standards, and meet them. Producing low-quality or unaudited code and claiming or hoping to “clean it up later” is counterproductive.
   ```

2. **Code quality as high as possible.** Use Mathlib's style, and use Mathlib's code first, which meets that quality.

3. **Order of sources.** The project uses code from [Tau Ceti](https://github.com/TauCetiProject/TauCeti) and [Stacks](https://github.com/AxiomMath/Stacks). First use Mathlib's code; if it does not exist, Tau Ceti's; if that does not exist either, Stacks's. (Stacks's code may never be needed, as Tau Ceti has enough.)

4. **This repository and Tau Ceti: both.** The project is a single repository of my own, and also a part of Tau Ceti:
   - parts that a Tau Ceti roadmap covers: write the Tau Ceti version and contribute it directly to Tau Ceti;
   - parts that neither Mathlib nor Tau Ceti has: write them in my repository first. Then perhaps
    write a roadmap for geometric representation theory (one may already exist), or perhaps not; it depends on how hard it is to contribute to Tau Ceti's roadmap. I might not be able to review a roadmap fully.

5. **Papers.** I prefer to use the TeX files directly, untracked by Git. I don't see the point of `references/papers/manifest.toml`.

## The review system (its own repository)

- A single repository of its own, separate from this one.
- Based on [tracker](https://github.com/bridgekat/tracker/tree/c223b672b26179322ca61f321bcfa8aabedaba79).
  It can be a rewrite of [reviewkit](https://github.com/WHY-Op109/reviewkit), or reviewkit can simply be deleted and a completely new one made.
- **Input:** a Lean project documented in Mathlib's style. **Output:** a web page generated directly from it, with the dependency graph and review tags.
- **Review status.** Each Lean declaration that needs a review is pinned and tagged, and tracked by the Git commit hash at which it was reviewed. After each refactor (for example one made after review suggestions) we can then tell whether the declaration has changed:
  - reviewed and checked OK, unchanged since: **reviewed**;
  - changed during a refactor after its review: **unreviewed** again, but showing that it was
    reviewed before and needs to be reviewed again.
- **Open question: two patterns, or is one enough?** I am not sure yet. One pattern is for building a library; the other is for a single statement whose verification involves very long Lean code.

## References

Useful, but not the only ones; searching for more may help.

- [Mathlib documentation style](https://mathlib.org/contribute/doc.html)
- [Mathlib style guide](https://leanprover-community.github.io/contribute/style.html)
- [Tau Ceti Review](https://github.com/TauCetiProject/TauCetiReview): Tau Ceti's review focuses on reusing Mathlib's code, not repeating what Mathlib already has, etc.
- [Lean Quality Indicators](https://github.com/RemyDegenne/lean-quality-indicators): Kim Morrison uses this metric; quite like Tau Ceti Review.
- [Lean Metrics](https://github.com/bridgekat/metrics/tree/55248898784e6bca981fcf96faea8657cad62c75): the metrics come from Tau Ceti Review but are more general, usable for any Lean project, not only Tau Ceti.
- [NumLib-Auto](https://github.com/bridgekat/numlib-auto/tree/main): a Lean project that formalises numerical analysis, with a review system and a dependency graph. It is a good example of how to do the review system. The prompts for the formalisation are in `prompts/` might be useful for GLCinLean.
- [NLAlib](https://github.com/tchen-research/NLAlib): has review guidance, with a lot on Mathlib's conventions; its system design may also help with the review system I want to make.
- [Annals Challenge](https://github.com/ImperialCollegeLondon/AnnalsChallenge): they formalise statements. Search online for how they do it and what their metric for a statement is; it may help with how we formalise the statement.
- [GLCinLean-archive](https://github.com/WHY-Op109/GLCinLean-archive): my previous ideas and a lot of design. Too complicated, I think, but it still contains my ideas and the points I want.

## Example prompts

These may also be useful.

```
/goal I'd like to formalize the proof of XXX. Let's get all the preliminaries written as high quality library code in the Tau Ceti repository. Think through everything we need to get done to formalize XXX, carefully looking to see what has already been done in Mathlib and Tau Ceti. Then read the relevant Tau Ceti roadmaps to find what is already planned for Tau Ceti. Start writing PRs (you may use subagents!), and then fix any CI problems and fix anything the reviewers complain about. (You may like to use the TauCetiReview machinery to run commensurately many reviews on other people's PRs, to be a good citizen!) As your PRs get merged, move on to the subsequent ones (but don't open stacked PRs). Please keep a file STATUS up to date, with a concise record of the PRs you've opened, and landed, and your central estimate for when you'll be done. If you finish everything needed for XXX that is covered by existing Tau Ceti roadmaps, come back to me and give me a tutorial on contributing new roadmaps!
```

```
You are the orchestrator for our lean formalization project – the goal is to formalize the Caffarelli-Kohn-Nirenberg theorem on the partial regularity of suitable weak solutions of 3d Navier-Stokes. We have placed several papers in the /sources subfolder, these have different proofs of the theorem. We need to find the best proof which is most convenient for formalization. This will be your first task. Please launch a codex agent in yolo mode (in a tmux shell) set to GPT 6 Astra (high effort) to do the research on the best proof, and audit its findings with an Opus (high) subagent. Then have a Sonnet subagent write a detailed MD file (“blueprint.md”) with the proof outline. Let me know if you have questions before you begin. 
```

```
You are the orchestrator for our lean formalization project – the goal is to formalize the Caffarelli-Kohn-Nirenberg theorem on the partial regularity of suitable weak solutions of 3d Navier-Stokes (based on blueprint.md). You will use up to four Sonnet subagents at a time, and can use up to eight GPT 6 Luna (xhigh effort) subagents in a tmux shell. Audits should be done by Sonnet, and if there is a particularly difficult part of the code to write you can upgrade up to 2 of the Lunas at any time to GPT 6.1 Sol (medium). Please read the lean orchestration skill files and the dependency graph skill files and make a detailed plan to launch the project. Let me know if you have any questions before you begin. 
```
