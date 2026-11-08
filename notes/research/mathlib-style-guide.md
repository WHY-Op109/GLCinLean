# Mathlib style guide, naming conventions and pull request review guide

- **Sources:**
  - "Library Style Guidelines", <https://leanprover-community.github.io/contribute/style.html>
    (the URL in `notes/ideas.md`) and <https://mathlib.org/contribute/style.html> (the newer copy).
  - "Mathlib naming conventions", <https://leanprover-community.github.io/contribute/naming.html>
    and <https://mathlib.org/contribute/naming.html>.
  - "Pull Request Review Guide": the old URL
    <https://leanprover-community.github.io/contribute/pr-review.html> is only a "Page Moved"
    stub that redirects to <https://mathlib.org/contribute/pr-review.html>.
- **Pinned source files:**
  - newer copies: `community/templates/contribute/{style,naming,pr-review,commit}.md` in
    [leanprover-community/mathlib-landing @ 9f98903c](https://github.com/leanprover-community/mathlib-landing/tree/9f98903cbf25898c12243193d6195223f76cd70f/community/templates/contribute)
    (head commit, 2026-11-06);
  - older copies: `templates/contribute/{style,naming}.md` in
    [leanprover-community/leanprover-community.github.io @ 3ad7ec4f](https://github.com/leanprover-community/leanprover-community.github.io/tree/3ad7ec4f73140982e24afff754e6c7656521f867/templates/contribute)
    (head commit, 2026-11-06).
  - Both repositories are MIT-licensed.
- **Linter code read:** Mathlib @ `1b1ccf4b` (2026-11-02, the commit this project builds against
  through Tau Ceti): `Mathlib/Init.lean`, `Mathlib/Tactic/Linter/{Style,Header,DocString,EmptyLine,
  Whitespace,FlexibleLinter,Multigoal,DeprecatedSyntaxLinter,UnusedInstancesInType,Lint,TextBased}.lean`.
  Batteries @ `6d971e7e`: `Batteries/Tactic/Lint/*.lean` and `scripts/runLinter.lean`. Tau Ceti @
  `e0610cce`: `lakefile.toml`, `scripts/HeaderStyle.lean`, `.github/workflows/pr-build.yml`.
- **Independent re-check, 2026-11-08:** the page diffs, the live pages, the header and docBlame
  linter code, the Lean diagnostics of both files and a `warningAsError` test were redone, and the
  corrections are folded into the text below.
- **Checked 2026-11-08.** Both clones are in `.lake/research/` (Git ignores it).

Tags: [R] read directly, [S] a source's claim about itself, [E] estimate, [J] judgement. All
dated 2026-11-08.

## 1. What it is

- Three pages from the Lean community that set Mathlib's code standard:
  - the **style guide** covers layout, headers, proofs, API design and deprecation;
  - the **naming conventions** say how declarations and files are named;
  - the **pull request review guide** says what a human reviewer looks for. [R]
- The style guide calls itself "guidelines rather than rigid rules" (style.md l.6–7). [S]
- **There are two copies, and they differ.** The site's sources moved to `mathlib-landing`
  (mathlib.org). The old site still serves its own copies of `style.html` and `naming.html`
  (HTTP 200, no redirect), but they are older. [R]
  - The new style guide adds the sentence "All files should be `module`s", rules for `meta`
    imports and `import all`, and exact blank-line rules around the module docstring. The old copy
    already has the `module` keyword right after the header and the `public import` / `import`
    blocks, so the difference is the requirement, not the layout. [R, both copies diffed and the
    live pages fetched 2026-11-08]
  - The new naming guide adds a section on naming tactics, attributes and commands; the rest of
    the naming page is identical. [R]
  - `pr-review.html` and `doc.html` at the old address are only redirect stubs.
  - So the URL in `ideas.md` points at the older copy. [R]

## 2. What it says that matters for GLCinLean

### 2.1 Style rules (style.md)

**File layout**
- Every file starts with a copyright header of three lines:
  `Copyright (c) YYYY …. All rights reserved.`, then
  `Released under Apache 2.0 license as described in the file LICENSE.`, then `Authors: …`
  (commas between names, no "and", no final period). [R]
- **Both copies:** the `module` keyword comes on its own line right after the header; then
  `public import`s, a blank line, then `import`s, alphabetical within each block. [R]
- **New copy only:**
  - "All files should be `module`s";
  - `meta` imports go at the top of each group, and any `import all`s form a third block. [R]
- The `Authors:` line lists "the ones we would reach out to if we had questions about the design
  or development of the Lean code"; there are no strict rules on who qualifies. [R]
- After the imports comes exactly one blank line (new copy; the old one only says "after"), then
  a `/-! … -/` module docstring with:
  - a title;
  - a summary of the main definitions and results;
  - notation;
  - references (new entries go in `docs/references.bib`). [R]

**Lines and declarations**
- Lines are at most 100 characters. [R]
- Declarations and commands are flush-left; opening a `namespace` or `section` does not indent
  its contents. [R]
- A statement that continues onto more lines is indented 4 spaces; the proof is indented 2 spaces.
  `:= by` goes at the end of the line, never on a line of its own. Use one tactic per line, and
  `·` for subgoals. [R]
- Give the types of all arguments and the return types of definitions. [R]
- Every field of a structure or class has a docstring. [R]
- No empty lines inside declarations; use comments instead. [R]

**Syntax**
- Write `fun x ↦`, never `λ`; write `<|`, never `$`. [R]
- Prefer hypotheses to the left of the colon. [R]
- Hypotheses and conclusions should not be conjunctions or disjunctions; split them into separate
  lemmas instead. [R]

**Proofs and performance**
- Terminal `simp` calls should not be squeezed into `simp only`. [R]
- Use `@[to_additive]` / `@[to_dual]` rather than writing the second statement by hand. [R]
- Use **normal forms**, for example `s.Nonempty`; `≠ ⊥` in assumptions and `⊥ <` in conclusions. [R]
- **Transparency:** definitions are `semireducible` by default. Any other choice must be justified
  in the PR description. A sealed API is written as a `structure` wrapper, not as `irreducible`.
  `irreducible_def` is used "only when there is a documented necessity from profiling". [R]
- An `erw`, or an extra `rfl` after `simp`/`rw`, "is an indication that there is missing API". [R]
- Contributors are responsible for performance: changes to classes, instances, `simp` lemmas or
  imports should be benchmarked (`!bench` in Mathlib). [R]

**Deprecation**
- A removed or renamed public declaration keeps a
  `@[deprecated (since := "YYYY-MM-DD")] alias old := new`.
- Deprecated declarations can be deleted after 6 months. [R]

### 2.2 Naming rules (naming.md)

**Case**
- Proofs and theorem names use `snake_case`.
- `Prop`s and `Type`s (structures, classes, inductives) use `UpperCamelCase`.
- Functions are named like their return value.
- Other terms of types use `lowerCamelCase`.
- An `UpperCamelCase` name inside a `snake_case` name becomes `lowerCamelCase`. [R]
- Files use `UpperCamelCase`. Declaration names use **American spelling** (`Localization`,
  `FiberBundle`); documentation may use other spellings. [R]

**Theorem names**
- A theorem name describes its conclusion; hypotheses are added with `_of_`, in the order they
  appear (`C_of_A_of_B`). [R]
- There is a dictionary of symbols (`mem`, `notMem`, `iUnion`, `smul`, `le`/`ge`, …). [R]
- Structural lemmas follow fixed patterns:
  - `.ext` / `.ext_iff`;
  - `f_injective` / `f_inj`;
  - `induction_on` / `recOn`;
  - predicates go first as prefixes (`isClosed_Icc`), with exceptions such as `_injective` and
    `_monotone`;
  - `fun_mul` for the expanded form of an operation on functions;
  - `_apply` and `map_` for function application;
  - a `₀` suffix for versions about groups with zero. [R]

**Classes and syntax**
- A `Prop`-valued class named by a noun starts with `Is` (`IsTopologicalRing`). An adjective
  needs no `Is` (`Normal`). `Has` is used for data other than the argument (`HasLimit`). [R]
- New copy only: tactics, attributes and commands use `lower_snake_case`. A `#` command is for
  temporary or test use only. [R]
  - This bears on any project attribute, for example `@[placeholder]`. [J]

### 2.3 What a reviewer looks for (pr-review.md)

- Five areas, "approximately from easiest to hardest": style, documentation, location,
  improvements, library integration. "New reviewers are certainly capable of commenting on the
  first two or three issues", whereas library integration "generally requires several months of
  developing familiarity with mathlib". [R]
- **Documentation:**
  - Docstrings exist, are accurate and give cross-references. Long proofs carry a sketch in
    comments. Important theorems have docstrings.
  - Warnings for declarations meant only for internal use.
  - A citation in `references.bib` when the result comes from the literature. [R]
- **Location:**
  - Is the declaration in the right file? Use `#find_home`.
  - Does the result already exist, perhaps more generally? Try `exact?` / `apply?`.
  - Do the imports pull in too much?
  - Should the file be split? The rule of thumb is more than 1000 lines. [R]
- **Improvements:**
  - Split long proofs into lemmas; use better tactics (`gcongr`, `positivity`).
  - Ask whether the definitions are the best way to formalise the concept ("very difficult!").
    Rule of thumb: "the more definitions avoid dependent types, the better". [R]
- **Library integration:**
  - A sensible API: attributes `@[simp]`, `@[ext]`, `@[gcongr]`; rewrite lemmas so that proofs
    need not unfold definitions.
  - Generality for known future needs.
  - Bundled morphisms with `FunLike`, bundled subobjects with `SetLike`.
  - "Follow the advice of any existing library note."
  - `Type*` rather than `Type _`; no instance diamonds. [R]
- **PR titles** (commit.md): `<type>(<scope>): <subject>`, where the type is one of `feat`, `fix`,
  `doc`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`. Discussion goes below `---` in the
  description. [R]

### 2.4 Which rules a machine checks, and which need a reviewer

**Turned on by `weak.linter.mathlibStandardSet = true`** (in this project's `lakefile.toml`):
these are the syntax linters registered in `Mathlib/Init.lean` l.87–115. [R]

| Linter | What it flags |
|---|---|
| `style.header` | missing module docstring (any file); malformed copyright header and duplicate imports (only files the library root imports; `GLCinLean.lean` imports both files, so both are checked); import-block formatting and broad-import checks only for `Mathlib.*` modules |
| `style.longLine` | lines over 100 characters (URLs are exempt) |
| `style.longFile` | long files; the limit is 0 (off) downstream unless set — Tau Ceti sets 1500 |
| `style.docString` | docstrings that do not start and end with a single space or newline, or that end with a comma |
| `style.emptyLine` | empty lines inside a declaration |
| `style.whitespace` | spacing in the binder part of a declaration; commands not at the start of a line |
| `style.cdot` | `.` instead of `·`, or a `·` alone on a line |
| `style.dollarSyntax` | `$` |
| `style.lambdaSyntax` | `λ` |
| `style.setOption` | `set_option` for `pp`, `profiler` or `trace`; unscoped `maxHeartbeats` |
| `style.maxHeartbeats` | `maxHeartbeats` settings (part of the deprecated-syntax linters) |
| `style.missingEnd` | an unclosed `section` or `namespace` |
| `style.openClassical` | `open Classical` that is not scoped |
| `style.show` | `show` that changes the goal |
| `style.extendedBinder` | `∀ᵉ` / `∃ᵉ` |
| `style.multiGoal` | tactics that act on several goals |
| `style.cases`, `style.induction`, `style.refine` | deprecated syntax: `cases'`, `induction'`, `refine'` |
| `style.native` | `native_decide` and similar |
| `flexible` | a rigid tactic such as `rw` acting on the output of `simp` |
| `hashCommand` | `#` commands left in the file |
| `oldObtain` | old `obtain` syntax |
| `auxLemma` | auxiliary lemmas |
| `privateModule` | modules whose declarations are all private |
| `unusedDecidableInType`, `unusedFintypeInType` | unused instances in a statement |

**Checked only by `lake lint`** (Batteries' `runLinter`, the project's `lintDriver`): the
environment linters. [R]
- Batteries: `docBlame` (missing docstrings on definitions), `simpNF`, `simpComm`,
  `unusedArguments`, `checkType`, `synTaut`, `unusedHavesSuffices`, `impossibleInstance`,
  `nonClassInstance`.
- Mathlib: `defsWithUnderscore` (a definition whose name contains `_`), `structureInType`,
  `deprecatedNoSince`, `subsetDotNotationLinter`, `tacticDocs`, `tacticAlt`.
- `runLinter` imports the module plus `Batteries.Tactic.Lint` and runs every enabled
  `@[env_linter]` in that environment (`getChecks`), so Mathlib's linters are included because
  GLCinLean imports Mathlib [R, code read]. I did not run `lake lint`. [E]
- `docBlame` skips instances and `Prop`-valued structure projections (`Misc.lean` l.88–103), so
  it cannot catch a missing docstring on an instance-implicit structure field. [R, code read]

**Also on in every build, outside the standard set:**
- `style.nameCheck` (double underscores in declaration names) has `defValue := true`, so it runs
  wherever Mathlib's linters are imported. [R, code read]

**Not run here at all:**
- Mathlib's text-based linters (`lake exe lint-style`): the Unicode allow-list, Windows line
  endings, a space before `;`, adaptation notes. [R]

**Left to a reviewer** [J], from the pages above:
- all naming conventions except underscores in definition names and double underscores;
- normal forms and conjunctions in hypotheses;
- argument types written explicitly;
- the transparency choice, and missing API (`erw`);
- unsqueezed `simp`;
- deprecations;
- whether docstrings are accurate (`docBlame` only checks that they exist), and docstrings on
  instance-implicit or `Prop`-valued structure fields, which `docBlame` skips;
- location, duplication, generality, imports;
- the whole "library integration" area.

**Comparison with Tau Ceti** (Tau Ceti `lakefile.toml` l.37) [R]:
- Tau Ceti sets `mathlibStandardSet`, `style.header = true`, `longFile = 1500` and
  **`warningAsError = true`**, so in Tau Ceti every lint is a build failure.
- `warningAsError` also turns `declaration uses 'sorry'` into an error (tested 2026-11-08 with
  `set_option warningAsError true` on a `sorry` theorem). Tau Ceti's `TauCeti/` tree has no
  `sorry` at all (grep, 0 hits). [R]
- Its own comment says `style.header` "is inert during ordinary builds" there, because the
  linter skips modules the library root does not import and `TauCeti.lean` is empty. It checks
  headers with a script (`scripts/HeaderStyle.lean`) instead [S]. That script checks only the
  copyright block and `Authors:` line, "not the … module-doc checks" (its docstring) [R]. So
  Tau Ceti does not enforce the `/-!` module docstring mechanically; GLCinLean's build does,
  because `GLCinLean.lean` imports both files. [R, code read; J for the comparison]
- File length: `longFile = 1500` for existing files, and a CI "New-file length guard" holds
  *new* files to 1000 lines (`lakefile.toml` comment; the step is at `.github/workflows/pr-build.yml`
  l.450). [R]
- `Authors:` lines in Tau Ceti: 21488 of 23391 files say `The Tau Ceti contributors`,
  1032 `Codex`, 205 `Claude`, the rest named people. [R, counted at `e0610cce`]

### 2.5 How the current Lean files fare (brief; the audit notes cover the files)

Seen through the Lean language server, 2026-11-08 [R]:
- `Foundations.lean` gives 9 `style.header` warnings, and `Abstract.lean` gives 8 plus 4 `sorry`
  warnings. Each file opens with a plain `/- … -/` description instead of the copyright header,
  and has no `/-! … -/` module docstring after the imports.
- Neither file is a `module` (no `module` keyword, no `public import`), although Tau Ceti's files
  are (for example `TauCeti/Algebra/AlgebraicGroup/Pinning/Basic.lean`).
- No lines over 100 characters (checked with `awk`). [R]
- Under `warningAsError` the 4 budgeted `sorry`s in `Abstract.lean` would be build errors. [R,
  from the test in 2.4]

Points a reviewer would likely raise [J]:
- The term-valued placeholders `Psi`, `LCoarse`, `LG` are `UpperCamelCase`, but naming rules 3
  and 4 (a function is named like its return value; terms of a type are `lowerCamelCase`) suggest
  `lowerCamelCase`, since they return terms of `LinFun …` (`DmodHalf : … → DGCat` is arguable,
  like Mathlib's `Spec`).
- The theorem name `main` does not describe its conclusion.
- The instance-implicit fields of `Setting` (`over`, `smooth`, `proper`, `connected`) have no
  docstrings, against "each field should have a docstring". `docBlame` would not flag them: it
  skips instances (they are made instances by `attribute [instance]`) and `Prop` projections
  [R for the code; E that it applies, not run]. Only a reviewer catches this.
- `@[placeholder] def DGCat` etc. take the `def` default transparency, which is consistent with
  the style rule.

## 3. What it means for GLCinLean

- **"Fully in Mathlib's documentation style" (ideas.md, What I want) means more than docstrings.**
  Everything in 2.1–2.3 applies. About half of it can be enforced by linters; the rest needs a
  reviewer. [J]
  - Step 1 (rebuild) should state the standard by pointing to these pages at mathlib.org, not
    copy them into `AGENTS.md`.
  - Step 4 (review) should use the pr-review areas as its checklist for human-level points.
- **"Set standards, and meet them" (ideas.md §1, Xena).** Today the linters are "warnings in the
  build log, never a gate" (`lakefile.toml` comment), and both Lean files already fail
  `style.header`.
  - Tau Ceti fails the build on every warning.
  - Code written to be contributed to Tau Ceti (workflow step 3, "fully automated, following Tau
    Ceti's own requirements") has to pass `warningAsError` (so no `sorry`), be a `module`, carry
    the copyright header, and stay within 1000 lines for a new file (1500 for an existing one).
    [R for Tau Ceti's settings, 2.4]
  - Holding this whole repository to the same settings is not a one-line change: `warningAsError`
    would turn the budgeted `sorry`s of `Abstract.lean` (and every future unproved step) into build
    errors, which conflicts with the sorry-budget design. Options: apply Tau Ceti's settings only
    to code headed for Tau Ceti (for example a separate `lean_lib` with its own `leanOptions`), or
    use `warningAsError` plus explicit per-file exceptions. I have not tested either. [J]
- **Library, not a one-off (ideas.md §1).**
  - The naming conventions and the "library integration" questions matter most for the
    geometric-representation-theory backbone (D-modules, perverse sheaves): sensible API,
    `@[simp]`/`@[ext]`, bundled morphisms, normal forms, generality.
  - The statement surface (`Abstract.lean`) matters less here. [J]
- **"Stay up to date" (ideas.md §1; workflow decision: keeping up is fully automated).**
  - The deprecation rule (aliases with `since`, deleted after 6 months) is the mechanism that keeps
    downstream code compiling across Mathlib bumps.
  - An automated bump (step 5) should treat deprecation warnings as work to do at once, not as
    noise. [J]
  - If GLCinLean's own API is used by others, the project should deprecate in the same way. [J]
- **Linter coverage (workflow step 4).** Running `lake lint` (environment linters such as
  `docBlame` and `defsWithUnderscore`) as part of the routine check would catch missing docstrings
  and some naming errors mechanically. Today it runs only by hand. [J]
- **Placeholders (workflow step 2).**
  - A "missing API" warning applies to placeholders in spirit: an `opaque` with no lemmas is the
    extreme case.
  - The transparency section supports the current choice of `opaque`/`def` over `irreducible_def`.
  - The new naming rule for attributes (`lower_snake_case`) is satisfied by `@[placeholder]`. [J]
- **Spelling.**
  - The project's prose is British ("formalisation"), which is allowed in docstrings.
  - Declaration names must be American (`formalization`, `localization`, `fiber`). [R for the rule]
  - Agents should be told this, because British prose tends to leak into names. [J]

## 4. Conflicts

- **With ideas.md (references):** the style guide URL in `ideas.md` serves the older copy. It
  lacks the sentence "All files should be `module`s" and the `meta`/`import all` rules, and the
  matching naming page lacks the section on tactics and attributes. The canonical copy is
  mathlib.org. [R]
  - `ideas.md`'s other link, `mathlib.org/contribute/doc.html`, is already the new site.
- **With the current `lakefile.toml`:** "warnings in the build log, never a gate", against
  Tau Ceti's `warningAsError = true` and the Xena principle "Set standards, and meet them" that
  `ideas.md` quotes. [R for both texts, J for the tension]
  - `lakefile.toml` is an owner's file.
- **Tau Ceti's `warningAsError` against this repository's sorry budget:** Tau Ceti allows no
  `sorry`; GLCinLean's statement-first plan keeps budgeted `sorry`s in the default target. A
  "warnings are errors" gate cannot be copied unchanged. [R for both facts, J for the conflict]
- **With the current Lean files:**
  - no copyright header, no module docstring after the imports, not `module`s (2.5);
  - the descriptive header block (status, sorry budget, statement pin) has no place in Mathlib's
    layout. It would belong in the `/-!` module docstring, or, for the status text, outside the
    code. [J]
- **Within the sources:**
  - The style guide calls itself "guidelines rather than rigid rules", but the linters and Tau
    Ceti's `warningAsError` turn part of it into hard rules. [R]
  - The pr-review guide gives a rule of thumb of 1000 lines for splitting a file; `longFile` is
    1500 in Mathlib (its lakefile) and Tau Ceti, and 0 (off) downstream unless set. Tau Ceti uses
    both numbers: 1000 for new files in CI, 1500 for existing ones. [R]
- **Licence line:** `style.header` requires the Apache 2.0 sentence by default (configurable via
  `linter.style.header.license`). GLCinLean's `LICENSE` is Apache 2.0, so there is no conflict. [R]

## 5. Input for the open questions

- **What goes into `AGENTS.md`:**
  - one line saying that code follows Mathlib's style, naming and documentation pages at
    mathlib.org (linked, not copied);
  - that the linters must be clean;
  - that declaration names use American spelling;
  - that PR titles follow `<type>(<scope>): <subject>`.
  - Reasons: the pages are long (900, 620 and 720 lines), change often (the two copies already
    differ), and the linters enforce the mechanical part. [J]
- **Who reviews the mathematics, and to what standard:**
  - The pr-review guide says new reviewers can comment on "the first two or three issues"
    (style, documentation, perhaps location), while library integration "generally requires
    several months" of Mathlib experience. [R] Treating a fresh agent like a new reviewer is my
    analogy. [J]
  - This suggests fresh agents for the first two areas plus `exact?`/`#find_home` checks for
    duplication. The library-integration verdict should come from Tau Ceti's review (for Tau Ceti
    PRs) or be flagged for a human. [J]
  - Mathematical correctness against the papers is outside these pages.
- **What happens to each existing file (the `lakefile.toml` lint settings):**
  - The findings suggest proposing to the owner Tau Ceti's settings: `style.header = true`,
    `longFile = 1500`, `warningAsError = true`, but `warningAsError` only where no `sorry` is
    allowed (see 3 and 4), since it makes `sorry` a build error.
  - `style.header = true` adds nothing here: the standard set already turns it on, and it is
    already active because `GLCinLean.lean` imports both files. [R]
  - They also suggest converting the files to `module`s with headers and `/-!` docstrings.
  - `lake lint` should run as a routine check. [J]
- **Whether `Abstract.lean`, `Foundations.lean` and their placeholder design are reasonable:**
  - On style grounds alone, the design is compatible: opaque or default-transparency
    placeholders, an attribute in `lower_snake_case`.
  - What needs to change is mechanical (header, module docstring, `module`) and naming (`Psi`,
    `LCoarse`, `LG`, `main`). [J]

## 6. Questions for the owner

1. Should linter warnings fail the build in this repository, as they do in Tau Ceti
   (`warningAsError = true`, plus `longFile = 1500`)? `warningAsError` also makes every `sorry` a
   build error, so it fits only code with no budgeted `sorry`: the whole repository once the
   statement is proved, or now only a part (for example code headed for Tau Ceti). Which? This
   changes `lakefile.toml`, which is your file.
2. Should all GLCinLean files become Lean `module`s with Mathlib's copyright header now, to match
   Mathlib's newer rule and Tau Ceti? If so, what goes on the `Authors:` line for agent-written
   code? Most Tau Ceti files say `Authors: The Tau Ceti contributors` (some `Codex` or `Claude`),
   and Mathlib says it lists the people "we would reach out to".
3. Should `lake lint` (the environment linters, including `docBlame`) be part of every session's
   checks, rather than run by hand?
4. Should `ideas.md` link the mathlib.org copy of the style guide, now that the old address serves
   an older version?
