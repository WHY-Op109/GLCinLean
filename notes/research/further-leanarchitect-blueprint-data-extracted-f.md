# LeanArchitect (blueprint data extracted from Lean source)

- Source: https://github.com/hanwenzhu/LeanArchitect/tree/c948bae1767330bb4cf09071f47752a10311d7d2
  (`main` = tag `v4.36.0-rc2`, commit 2026-10-28).
- Checked 2026-11-08.
- Licence: Apache-2.0 [R]. A fork or a reuse of its code is allowed with attribution.
- Found by the open search, not listed in `notes/ideas.md`.
- What was read [R 2026-11-08]: `README.md`, `lakefile.lean`, `Main.lean`, all of `Architect/`
  (`Basic`, `Attribute`, `CollectUsed`, `Output`, `Content`, `Tactic`, `Command`, `Load`;
  1,058 lines, plus 93 in `Architect.lean` and `Main.lean`), `ArchitectTest/MyNat.lean`, both
  CI workflows, `git log`, and the GitHub issues and pull requests #1–#14. Also read for
  context: LeanMarathon's `agents/Worker/docs/contracts/blueprint-format.md` and README (one
  user, commit `e2febe2`), the README of `leanprover/verso-blueprint` at `4943d33` (an
  alternative), and Tau Ceti's `formalization.yaml` at GLCinLean's pin. Cloned to
  `.lake/research/LeanArchitect/`.
- Re-checked 2026-11-08 by a second reader against the same commit: the code paths for
  dependencies, readiness, `\mathlibok` and JSON, issue #7, pull requests #8 and #11, and the
  LeanMarathon rules. Corrections are listed at the end of this note.
- Not done: LeanArchitect was not built or run. Everything below about its behaviour comes
  from reading the code, not from running it. No claim here is about mathematics.

## 1. What it is

- A Lean 4 package (author Thomas Zhu, `hanwenzhu`) that produces the data of a
  [leanblueprint](https://github.com/PatrickMassot/leanblueprint) blueprint from Lean
  source, instead of a hand-written LaTeX file. Its own words: "a tool for generating the
  blueprint data of a Lean project directly from Lean." [S]
- You tag declarations with `@[blueprint]`. `lake build :blueprint` writes LaTeX for
  leanblueprint to turn into a PDF, a web page and a dependency graph. `lake build :blueprintJson`
  writes JSON. [R]
- Upstream state [R 2026-11-08, GitHub API]: 94 stars, 11 forks, 108 commits, 6 open issues or
  pull requests. It has a tag for each Lean release (`v4.35.0-rc2` … `v4.36.0-rc2`), created by
  `leanprover-community/lean-release-tag` whenever `lean-toolchain` changes. Since 2026-09-25
  the toolchain bumps have been committed as "Claude".
- Users [R, GitHub code search 2026-11-08, which is capped and incomplete]: about 30
  repositories name it in a `lakefile` or `lake-manifest.json`, among them
  PrimeNumberTheoremAnd, `emilyriehl/infinity-cosmos` (∞-category theory, the closest to
  GLCinLean's subject) and `openai/math`. LeanMarathon does not require it itself: it is a
  harness whose generated target repositories use LeanArchitect's format (its README lists
  `.scripts/verify_blueprint.py`, a "verifier for LeanArchitect blueprint files") [R].
  Neither Mathlib nor Tau Ceti uses it: no `LeanArchitect` and no `@[blueprint]` in either, at
  the pins in GLCinLean's `.lake/packages/` [R].
- Tau Ceti's own stand-in for a blueprint is different. Its `formalization.yaml` says the
  human-authored roadmaps in `TauCetiProject/TauCetiRoadmap` "play the role of blueprints",
  each stating "its goals as sorry-allowed signatures in its Suggested.lean" [R].

## 2. What it says that matters for GLCinLean

### The attribute [R]

```lean
@[blueprint "thm:label"
  (statement := /-- LaTeX statement -/)
  (proof := /-- LaTeX proof -/)          -- default: the doc comments inside the tactic proof
  (uses := [a, "label-b", -c])           -- extra or removed statement dependencies
  (proofUses := [a, "label-b", -c])      -- extra or removed proof dependencies
  (title := /-- Title -/) (notReady := true) (discussion := 123) (latexEnv := "lemma")
  (hasProof := true)]                    -- default: true for theorems or when `proof` is given
theorem foo : ... := by
  /-- A proof step in LaTeX. -/
  tac
```

- Each file that uses it needs `import Architect`. The doc comment inside a tactic proof is a
  new tactic from `Architect/Tactic.lean`; so are `blueprint_using [a, b]` and
  `sorry_using [a, b]` (a `sorry` that records dependencies).
- **The statement text is not the docstring.** It defaults to `""` (`text :=
  cfg.statement.getD ""` in `Attribute.lean`). A Mathlib-style docstring is not read. Pull
  request #11, which would add `set_option blueprint.all true` to tag every declaration that has
  a docstring and use that docstring, has been open and unmerged since 2026-04-03.
- Only theorems have a proof part by default (`hasProof`). For a `def`, the type and the body
  together count as its "statement".
- Several declarations may share one label and become one node; `to_additive` pairs are merged.

### How it infers dependencies and readiness [R, `CollectUsed.lean`, `Output.lean`]

- It walks the constants used by the declaration's **type** (statement) and its **value**
  (proof), much like Lean's `collectAxioms`. It passes through untagged constants and stops at
  other `@[blueprint]` nodes. Passing through means reading the type *and* the value of every
  untagged `def`, `theorem` and `opaque` it meets, so an untagged helper's body counts as part
  of whatever statement mentions it.
- Statement uses and proof uses are kept apart: the proof's set is "value minus type". That is
  the statement/proof split that a check for "has the statement of a reviewed declaration
  changed?" would need.
- A part is ready (`\leanok`) when `sorryAx` is not among the constants it uses. Nothing else is
  checked. An `axiom` does not stop `\leanok`, unlike tracker's `axioms` state.
- `\mathlibok` is set when every declaration of the node is in a module under `Init`, `Lean`,
  `Std`, `Batteries` or `Mathlib`. This is read off the environment, so it stays correct after
  every bump. **`TauCeti` is not in that list.**

### The JSON output is thinner than the LaTeX [R, `Output.lean` `NodeWithPos.toJson`]

- Per node the JSON has: `name`, `latexLabel`, `statement` and `proof` (the text, plus only the
  `uses`/`excludes` written by hand), `notReady`, `discussion`, `title`, `hasLean`, `file`, and
  `location` (module, start and end line and column).
- **It does not have the inferred dependencies, nor `leanok`, nor `mathlibok`.** Those are
  computed only when the LaTeX is written. The open search said "infers `uses` and `proofUses`
  … `lake build :blueprintJson` exports the nodes as JSON". Each half is true, but the graph
  is not in the JSON.
- There is no hash, fingerprint or commit of a statement or a proof anywhere in the data.

### Tagging declarations you cannot edit [R]

- README, "Declarations upstreamed to Mathlib": `attribute [blueprint "thm:x" (statement := …)]
  Mathlib.foo` from your own project. "Put this just before the first local node that depends
  on it, or in the root module if nothing local does."
- Issue #7 (open, by the author, 2026-02-02): this breaks across files. Each module's blueprint
  is extracted by importing only that module (`runEnvOfImports #[module]` in `Load.lean`). If
  `attribute [blueprint] a` sits in a file that the dependent's file does not import, the edge
  is lost. The author's example: `a` in Mathlib, used by `b` and `c` in two files that do not
  import each other, leaves "no current good place" for the command. The author's fix (load all
  modules at once) "might break the incremental build logic" and may need "a large refactor".
- So a root module that imports everything is the *wrong* place for such tags: the
  dependents' modules do not import it, and their edges are lost. The tag has to sit in a
  module that every dependent imports [R for the mechanism, from `Load.lean` and the issue].

### Using it from outside, and the move to Verso [R]

- Pull request #8 (Kim Morrison, 2026-03-14) added an `--all` flag "to use LeanArchitect as a
  purely external tool: the target project needs no `require LeanArchitect`, no
  `import Architect`, and no `@[blueprint]` attributes". The reason given was that annotations
  "add noise that confuses the automated agents". It ran against compiled `.olean` files and
  took docstrings as statement text. The author (`hanwenzhu`) replied that the promised Lake
  facets were not implemented. It was closed unmerged on 2026-04-21 with Kim Morrison's comment
  "I am just migrating to Verso blueprint and won't need/use LeanArchitect." Kim Morrison is not
  among LeanArchitect's contributors (the code is almost all by `hanwenzhu`, 94 of 106
  contributions).
- `leanprover/verso-blueprint` (created 2026-02-22, 48 stars, last push 2026-11-05; no licence
  shown by the GitHub API) does the same job in Verso. Its README (at `4943d33`) says it links
  to Lean in three ways: inline code blocks, `@[blueprint]` on compiled code, and "existing
  declarations referenced with `(lean := "Nat.add_assoc")`" from the blueprint document. The
  third way needs no tag in the Lean code. Dependency inference is opt-in (`set_option
  verso.blueprint.autoDeps true`), and the README warns: "An empty inferred dependency list
  does not establish mathematical independence." It tracks `sorry`, draws dependency graphs,
  and is queried through `lake exe vbp query …`. Only its README was read, not its code.

### LeanMarathon's usage (one heavy user) [R]

- LeanMarathon ("a graph-engineering agent harness for long-horizon, research-level
  autoformalization" [S]) makes the `@[blueprint]` file its contract between agents. Its hard
  rules forbid `axiom`, `example` and **`opaque`**, forbid `namespace` and `mutual` blocks, and
  require `statement`, `title` and (for theorems) `proof` on every node.

## 3. What it means for GLCinLean

- **Review system: the closest input format, but not the review data** (ideas.md, "The review
  system"). Each node gives the label, the statement/proof split, the source range and an issue
  number (`discussion`), and the LaTeX side gives `uses` and `leanok`. That is most of the
  "dependency graph" half. The "review tags" half is missing: there is nothing to record "reviewed
  at commit X". The `location` range is enough to cut out the source at a commit and hash it, or
  the review tool could hash the elaborated type and value itself [J]. For the graph the tool
  must either parse the LaTeX, or compute the dependencies itself (tracker already does this from
  `.olean` files: `notes/research/tracker.md` §2), or patch LeanArchitect to put them in the JSON
  [J].
- **It does not take "a Lean project documented in Mathlib's style" as it is** (ideas.md: "Input:
  a Lean project documented in Mathlib's style"). It needs `import Architect`, an attribute on
  every node, and LaTeX statement text written separately from the docstring [R]. Tracker reads
  plain `.olean` files and a plan [R, tracker note], which fits the stated input better [J].
- **Order of sources and contributing to Tau Ceti** (ideas.md points 3–4; workflow decision
  "Tau Ceti contributions are fully automated"). Code meant for Tau Ceti or Mathlib cannot carry
  `@[blueprint]` or `import Architect`, since neither uses LeanArchitect [R]. So tags for such
  code would have to live in GLCinLean, through `attribute [blueprint]`. Because of issue #7
  they would have to go in a low module that every GLCinLean file using them imports (one
  "tags" file near the bottom of the import graph), not in a root module that imports
  everything [J, from the mechanism above]. Tau Ceti declarations would never get
  `\mathlibok` unless `TauCeti` is added to the list in `isMathlibOk` [R for the list; J for
  the consequence]. Verso Blueprint's `(lean := "…")` references avoid the tension, since the
  link lives in the blueprint document and not in the code [R README only; J that it fits].
- **Placeholders** (workflow question on `Abstract.lean`/`Foundations.lean`). An `opaque` such as
  `DGCat.IsCompact` (`GLCinLean/Foundations.lean`, `@[placeholder] opaque … : C.Obj → Prop`) has
  a value with no `sorry`, so LeanArchitect would count anything built only on placeholders as
  ready [J, from the code]. A graph made from it would show a placeholder-based statement as
  "done" unless each placeholder node gets `notReady := true` or the review tool reads ReviewKit's
  `@[placeholder]` tag itself [J]. This matches the AGENTS.md warning that a trivial witness
  "would make the statement say less than it appears to". LeanMarathon solves it by banning
  `opaque` altogether [R].
- **Statement readiness passes through definitions.** In `GLCinLean/Abstract.lean`, `LG S` is a
  def whose body uses the sorry'd `exists_isLanglandsFunctor`. Walking `main`'s type goes through
  `LG`'s body to that `sorry`, so `main`'s statement would not be `\leanok` unless
  `exists_isLanglandsFunctor` is itself a node [J, from the code]. For a review tool this means
  "the statement changed" must cover the bodies of the definitions it unfolds through, not only
  the type text [J].
- **"Stay up to date"** (Xena principle; workflow decision "Keeping up with Mathlib and Tau Ceti is
  fully automated"). There is a tag per Lean release, and the current tag `v4.36.0-rc2` matches
  GLCinLean's Tau Ceti pin `v4.36.0-rc2` [R]. As a dependency it would be one more pin to move in
  the automated bump. Its `batteries` pin (`d4c39b2`, tag `v4.36.0-rc2`) differs from the one in
  GLCinLean's manifest (`6d971e7`, from Mathlib's `main`). Lake would keep one of them; that is
  probably harmless but untested [E].
- **Link to the existing literature** (Xena principle). A LaTeX statement next to the Lean
  declaration, in one place, is a concrete way for a reviewer to compare the informal and the
  formal statement [J]. Mathlib-style docstrings with citations do the same job without a new
  dependency [J].

## 4. Conflicts

- **With the open search's own summary.** "`lake build :blueprintJson` exports the nodes" is
  true, but the JSON lacks the inferred `uses`/`proofUses` and the ready flag (§2) [R].
- **With ideas.md "Input: a Lean project documented in Mathlib's style"**: LeanArchitect needs
  annotations and LaTeX text in the source, and ignores docstrings [R].
- **With ideas.md point 4 / the Tau Ceti decision**: annotations cannot go into code contributed
  upstream, and the attribute route for such code is fragile across files (issue #7) [R].
- **With Tau Ceti's own planning format**: Tau Ceti plans through `Suggested.lean` signatures
  in `TauCetiRoadmap`, not through blueprint attributes [R, `formalization.yaml`]. A GLCinLean
  plan meant to feed Tau Ceti roadmaps would more naturally take that shape [J].
- **With the current placeholder design**: `opaque` placeholders look "ready" to LeanArchitect
  [J], and LeanMarathon forbids `opaque` outright [R]. This is not a reason to drop the design,
  but whichever tool draws the graph must know about `@[placeholder]` [J].
- **With tracker** (`notes/research/tracker.md`): two models of readiness. Tracker has `open`,
  `stated`, `proved` and `axioms`, and keeps the plan in TOML files. LeanArchitect has
  `leanok`/`notReady`/`mathlibok` and keeps the plan in Lean attributes [R]. Using both would mean
  two plans [J].
- **With Kim Morrison's direction**: the author of the proposed (unmerged) external-use mode
  dropped LeanArchitect for Verso Blueprint [R]. LeanArchitect itself is still maintained (a tag
  per Lean release, last push 2026-10-28) [R]. Verso Blueprint, under `leanprover`, may be the
  better long-term base, but only its README was read [J].

## 5. Input for the open questions

- **What happens to `blueprint/`.** Today it holds tracker plans (`blueprint/plans/`). A
  LeanArchitect blueprint would put LaTeX in `blueprint/src/` for leanblueprint, a third format.
  Suggests: do not add LeanArchitect to this repository now. If the review system wants
  LeanArchitect-style data, it can compute it from `.olean` files the way tracker does [J].
- **What happens to the ReviewKit requirement and `@[placeholder]`.** LeanArchitect does not
  replace the placeholder tag; it has no notion of a placeholder [R]. If placeholders stay, the
  tag, or something that does its job, must stay too, and the review tool must read it [J].
- **Whether `Abstract.lean`/`Foundations.lean` and the placeholders are reasonable.** Under any
  sorry-based readiness check, `opaque` placeholders show as done (§3). Suggests: whatever
  replaces them, the review site should show "placeholder" as its own state, distinct from
  "proved" [J].
- **Whether `PLAN.md` is needed.** LeanArchitect shows a plan that lives in the Lean files (with
  `--convert_informal`, unformalised nodes become `sorry`-typed declarations [R]). That is a third
  place a plan could live, besides `PLAN.md` and tracker TOML. Suggests: choose one [J].
- **Who reviews the mathematics, and to what standard.** The `statement`/`proof` LaTeX fields
  and `discussion := <issue>` give a reviewer the informal text and a thread per node [R]. This
  is useful for an outside expert who reads LaTeX rather than Lean [J].
- **The review system's "two patterns" question** (ideas.md). LeanArchitect serves the "single
  statement with a long verification" pattern (a blueprint towards one theorem) better than the
  "library" pattern, where code is spread over Mathlib, Tau Ceti and here and cannot be tagged
  [J]. This argues that the library pattern needs an annotation-free source of the graph, such
  as `.olean` files (tracker) or Verso Blueprint's references by name [J].

## 6. Questions for the owner

1. Should the review system read **annotation-free** Lean (like tracker, `.olean` plus a separate
   list of declarations to review), or accept **in-source annotations** in the LeanArchitect
   style? Annotations cannot go into code you contribute to Tau Ceti.
2. Should the review system's graph format be **compatible with LeanArchitect or Verso
   Blueprint**, so that other projects can use it, or be its own format based on tracker?
3. Should the review site show **"placeholder" as its own state**, so that a statement built on
   `@[placeholder]` objects is never shown as finished?

## Corrections on re-check (2026-11-08)

- Issue #7: the first version said cross-file tags "belong in one root module that imports
  everything". That loses the edges; they must sit in a module the dependents import (§2, §3).
- Kim Morrison was called "the main contributor of an external-use mode". She wrote one
  unmerged pull request (#8) and is not among the contributors (§2, §4).
- Users: "about 35 repositories require it, among them … LeanMarathon" became about 30 by code
  search, and LeanMarathon is a harness for target repositories that use the format, not a
  package that requires it (§1).
- Line count of `Architect/` corrected from 1,141 to 1,058 (header).
- Added: Tau Ceti's `Suggested.lean` roadmaps as its own blueprint format (§1, §4); Verso
  Blueprint's `(lean := "…")` references, which need no tag in the code (§2, §3); the
  `hasProof` option; that dependency walks read untagged helpers' bodies (§2).
