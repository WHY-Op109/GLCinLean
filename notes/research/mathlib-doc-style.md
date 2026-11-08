# Mathlib documentation style

- **Source:** "Documentation style", <https://mathlib.org/contribute/doc.html>.
- **Pinned source file:** `community/templates/contribute/doc.md` in
  [leanprover-community/mathlib-landing @ 9f98903c](https://github.com/leanprover-community/mathlib-landing/blob/9f98903cbf25898c12243193d6195223f76cd70f/community/templates/contribute/doc.md)
  (last change to that file: 2425b961, 2026-10-12). Licence of that repository: MIT.
- **Checked 2026-11-08.** The live page and the pinned Markdown agree on every rule quoted below
  (phrase spot-check of the downloaded page) [R 2026-11-08].
- **Supporting code read:** Mathlib `Mathlib/Tactic/CrossRefAttribute.lean` and `Mathlib/Init.lean`
  @ 6ea21925 (master on 2026-11-08); the Mathlib that GLCinLean builds against (1b1ccf4b, via
  Tau Ceti, in `.lake/packages/mathlib`): `Mathlib/Init.lean`, `Mathlib/Tactic/Linter/Header.lean`,
  `Mathlib/Util/VersoRoles.lean`; doc-gen4 `lakefile.lean` and `Main.lean` @ 0e9ef140; Tau Ceti
  `docbuild/` and `docbuild/docs/references.bib` @ d2083f0f; GLCinLean's build traces
  `.lake/build/lib/lean/GLCinLean/{Abstract,Foundations}.trace` (2026-11-06).
- **Re-checked 2026-11-08** by an independent pass against the pinned Markdown, the live page and
  the code above; corrections are marked "(corrected)", new points "(added)".

Tags: [R] read directly, [S] a source's claim about itself, [E] estimate, [J] judgement. All
dated 2026-11-08 unless noted.

## 1. What it is

- Mathlib's rules for documentation inside Lean files: the file header, the module docstring,
  declaration docstrings, sectioning comments, LaTeX and Markdown, citations, cross-references to
  external databases, and language. It opens with "All pull requests must meet the following
  documentation standards" [R].
- **It moved.** Until 2026-11-06 the page lived on `leanprover-community.github.io`; that
  repository's commit 3ad7ec4f ("redirect nine moved pages to mathlib.org", #940) replaced it with a
  redirect stub naming `mathlib-landing/community/templates/contribute/doc.md` as the source [R].
  The URL in `notes/ideas.md` is the current canonical one. The *style guide*
  (`contribute/style.html`) was **not** among the nine moved pages: the old site still serves
  its own copy [R, file list of commit 3ad7ec4f].
- (corrected) **But mathlib.org serves a second, newer copy of the style guide.** `mathlib-landing`
  started as a byte-for-byte copy of the old site ("both copies are live for now, and material
  moves or is dropped page by page", commit 932c2616) [S], and its
  `community/templates/contribute/style.md` has since changed (7cf8a58f "write down import style
  guidelines" and later commits on 2026-10-12, a681ed60 "more conventions for newlines and module
  doc-string", 2026-10-19) [R]. The two copies now differ: mathlib.org's has the sections
  `#copyright-header`, `#imports` and `#module-docstrings`, says "All files should be `module`s",
  orders `meta` and `import all` imports, and fixes blank lines around the module docstring; the
  old site's has one section `#header-and-imports` instead and no `#imports` or
  `#copyright-header` anchor [R, both pages fetched 2026-11-08].
- The documentation page links to the style guide for the copyright header, the import order and
  module docstrings (`style.html#copyright-header`, `#imports`, `#module-docstrings`) rather than
  repeating them [R]. These links are relative, so they land on **mathlib.org's** copy, the only
  one with those anchors [R]. Those rules belong to the `mathlib-style-guide` note.

## 2. What it says that matters for GLCinLean

### File header, in this order [R]

1. a copyright comment (rules in the style guide);
2. the `module` token;
3. the imports, grouped and sorted (`public import ...` in the example);
4. a **module docstring** `/-! ... -/`, with `/-!` and `-/` on their own lines.

### Module docstring contents [R]

- A first-level header `# Title`, which is "mandatory", then a summary of the file.
- Then second-level sections, in this order:
  - *Main definitions* (optional, can be covered in the summary);
  - *Main statements* (optional, can be covered in the summary);
  - *Notation* ("omitted only if no notation is introduced in this file");
  - *Implementation notes* ("description of important design decisions or interface features,
    including use of type classes and `simp` canonical form for new definitions");
  - *References* ("references to textbooks or papers, or Wikipedia pages");
  - *Tags* (keywords for text search).
- Headers are atx style (`#`), not underlined.
- The page names three files as models: `Mathlib.NumberTheory.Padics.PadicNorm`,
  `Mathlib.Topology.Basic`, `Mathlib.Analysis.Calculus.ContDiff.Basic` [R].

### Declaration docstrings [R]

- "Every definition and major theorem is required to have a doc string." Docstrings on lemmas
  are "encouraged, particularly if the lemma has any mathematical content or might be useful in
  another file."
- `/--` ... `-/`; continuation lines not indented; a complete sentence ends with a period; named
  theorems in bold (`**mean value theorem**`).
- "Doc strings should convey the mathematical meaning of the definition. They are allowed to lie
  slightly about the actual implementation." (Example: `padicValRat` described by its meaning,
  with the junk value at `q = 0` mentioned.)
- Tactics follow the Lean core tactic-docstring guide (full sentence with the tactic as subject,
  all forms in a bulleted list).

### Linters [R]

- `docBlame` lists definitions without docstrings; `docBlameThm` (opt-in) lists theorems and
  lemmas without them; `tacticDocs` lists undocumented tactics. Run with `#lint only docBlame`,
  `#lint only docBlame docBlameThm`, `#lint`, `#lint docBlameThm`.
- So the "major theorem" rule is not checked by the default linter set; only definitions are
  [R for what the linters list; J that this leaves major theorems to review].
- (added) Not on the page, but in Mathlib's code: the linter set `linter.mathlibStandardSet`
  (which downstream projects switch on with `weak.linter.mathlibStandardSet`, as GLCinLean does)
  includes `linter.style.header` and `linter.style.docString` (formatting of docstrings), both at
  Mathlib 1b1ccf4b and at 6ea21925 [R, `Mathlib/Init.lean`]. The header linter checks the
  copyright block, the authors line, the `module` token, import grouping and that a `/-!` module
  docstring follows the imports; its required licence line defaults to "Released under Apache
  2.0 license as described in the file LICENSE." and can be changed with
  `linter.style.header.license` [R, `Mathlib/Tactic/Linter/Header.lean` @ 1b1ccf4b].

### Sectioning comments [R]

- `/-! ### ... -/` (third-level headers) describe groups of declarations and appear in the
  generated docs. They need not match `section`/`namespace`. They have "no semantic meaning".

### LaTeX and Markdown [R]

- Lean names in backticks; a fully qualified name becomes a link in the online docs.
- Raw URLs in angle brackets `<...>`.
- Maths as `$...$`, `$$...$$`, or `\begin{*}...\end{*}` (MathJax).
- (The page's example of a qualified name, `finset.card_pos`, is still in Lean 3 spelling [R];
  harmless, but prompts should not copy it.)

### Citing the literature [R]

- References "should refer to bibtex entries in the mathlib citations file"
  (`docs/references.bib`), normalised with the given `bibtool` command.
- Two citation forms, both turned into links to the generated References page:
  - `[Boole1854]` (the key; rendered as an alpha-style label such as `[Boo54]`);
  - `[custom text][hilbert1999]`.
- The link text may not contain `]`: `[Euclid's *Elements* [Prop. 1]][heath1956a]` does **not**
  work. So `[GLC I, Conjecture 1.6.7][key]` works, but `[GLC I [Conj. 1.6.7]][key]` does not.

### (added) Verso docstrings: a second citation form the page does not mention

- Mathlib is moving files to Verso docstrings: at 1b1ccf4b, 1355 of 8696 files in `Mathlib/` set
  `set_option doc.verso true` [R, count by grep]. The page describes only the Markdown form.
- In a Verso docstring a citation is written `{cite "key"}[text]`, e.g.
  `{cite "Adamek_Rosicky_1994"}[Adámek–Rosický]`, and "A warning is emitted when the key is not
  found in `docs/references.bib`" [R, `Mathlib/Util/VersoRoles.lean` @ 1b1ccf4b]. The file is
  looked up at the relative path `docs/references.bib`, so it is the bibliography of the project
  being built [R for the code; E that this means the directory `lake build` runs in].
- Tau Ceti uses no Verso docstrings (no `doc.verso` under `TauCeti/` @ d2083f0f) [R].
- Consequence: Markdown `[text][key]` is checked only when doc-gen4 renders the docs; Verso's
  `{cite}` is checked at build time [J from the two mechanisms].

### Cross-references to external databases [R]

- Attributes such as `@[stacks 0123]` or `@[wikidata Q12345]` add a link to the declaration's
  generated doc entry; an optional comment is allowed: `@[stacks 0123 "only the first part is
  formalized"]`.
- The databases supported in Mathlib @ 6ea21925 are Stacks, Kerodon, Wikidata, LMFDB, π-Base,
  DLMF and OEIS (`Mathlib/Tactic/CrossRefAttribute.lean`, its module docstring and its
  `Database` type) [R]. **arXiv and the nLab are not among them**, so GLC papers can only be
  cited through BibTeX keys.

### Language [R]

- English; any common spelling is fine for documentation (British is allowed). Declaration
  *names* use American spelling (rule on the naming page).

### How the bibliography reaches the generated docs (doc-gen4, not the page itself) [R]

- doc-gen4's `bibPrepass` reads `docs/references.json` or else `docs/references.bib` from the
  **root package** only (`(← getRootPackage).srcDir / "docs" / "references.bib"`, doc-gen4
  `lakefile.lean` @ 0e9ef140) [R]. A downstream project therefore does not inherit Mathlib's
  bibliography: it needs its own file.
- Tau Ceti does exactly this: a nested `docbuild/` project with `docbuild/docs/references.bib`
  (26 entries [R]). Its header says ten keys are shared with Mathlib's and that key names follow
  Mathlib [S]; (corrected) comparing the two files gives eleven shared keys (`cohen1993` is also
  in both) [R]. The header also says: "A key with no entry here renders as a bare bracketed word,
  so every key used under `TauCeti/` needs one" [S].
- Mathlib's own `docs/references.bib` @ 6ea21925 has 521 entries, including `bbd-1982`
  (Faisceaux pervers), `Kashiwara2006` (Kashiwara–Schapira), `LurieHTT`, `LurieSAG` [R].
  (corrected) 33 entries have an `eprint` field (48 lines mention "eprint", counting
  `eprinttype`); arXiv is marked by `archiveprefix = {arXiv}` in 23 entries and by
  `eprinttype = {arXiv}` in 3 [R, grep]. No GLC paper is in it (grep for Gaitsgory and Raskin:
  none) [R].

## 3. What it means for GLCinLean

- **"Fully in Mathlib's documentation style"** (ideas.md, "What I want"): this page is the
  checkable definition of that phrase. Every new Lean file needs the four-part header, a `/-!`
  module docstring with `# Title`, summary and the ordered sections, and a docstring on every
  definition and major theorem [J].
- **"Link to the existing literature"** (ideas.md, Xena principles): the Mathlib mechanism is a
  project `docs/references.bib` plus `[text][key]` citations in docstrings and a `## References`
  section, and `@[stacks ...]` / `@[kerodon ...]` on declarations that match a Stacks or Kerodon
  tag [J]. For geometric representation theory, Kerodon (∞-categories) and Stacks (schemes,
  sheaves) are the relevant databases [J]. Existing Mathlib keys (`bbd-1982`, `Kashiwara2006`,
  `LurieHTT`) should be reused rather than re-keyed, as Tau Ceti does [J].
- **"A mathematician should be able to trust and verify"**: the citation should carry a precise
  locator (section, theorem or equation number in the published or arXiv version) inside the link
  text, e.g. `[GLC I, Conj. 1.6.7][gaitsgory2024glc1]` (Markdown) or
  `{cite "gaitsgory2024glc1"}[GLC I, Conj. 1.6.7]` (Verso); the BibTeX entry carries the arXiv id
  and version (`eprint = {2405.03599v3}`) [J].
- **Papers** (ideas.md item 5, "I don't see the point of `references/papers/manifest.toml`"): a
  `docs/references.bib` already records each paper's arXiv id and version in the form Mathlib and
  doc-gen4 use. It could replace the manifest's identifying role; the manifest's SHA-256 sums and
  licence notes have no place in BibTeX and would be dropped or moved [J].
- **Review system input** (ideas.md: "a Lean project documented in Mathlib's style"): the module
  docstring, `/-! ### -/` sections, docstrings and `references.bib` are exactly what doc-gen4
  renders. A review web page built from the same project can reuse them, and the review system can
  rely on `docBlame` (and `docBlameThm`) as a mechanical first check [J].
- **Tau Ceti contributions** (workflow decision "fully automated, following Tau Ceti's own
  requirements"): Tau Ceti files already follow the header layout (copyright, `module`, `public
  import`, `/-!` docstring with `## References`) and enable `linter.style.header` with
  `warningAsError` in `lakefile.toml` [R]. Writing GLCinLean files the same way from the start
  means code can move into Tau Ceti without rewriting its documentation [J].
- **Docs build** (step 3, "Publish freely ... explorable"): if GLCinLean publishes API docs, the
  Tau Ceti `docbuild/` layout (nested project requiring doc-gen4 and the main library, sharing
  `.lake/packages`) is a ready model [R for the layout; J for the fit].

### Audit against the current files [R for what the files contain; J for the verdicts]

`GLCinLean/Abstract.lean` and `GLCinLean/Foundations.lean` (stubs of 2026-11-05):

- They open with a plain `/- ... -/` comment, not a copyright block, and have no `module` token
  and no `/-!` module docstring. doc-gen4 shows nothing for a plain comment, so neither file has
  module documentation in the Mathlib sense.
- (corrected) The header linter is **already on** in GLCinLean (through
  `weak.linter.mathlibStandardSet`) and **already flags both files**: the build traces of
  2026-11-06 hold eight `linter.style.header` warnings for each, e.g. "Copyright line should start
  with 'Copyright (c) YYYY'", "Second copyright line should be "Released under Apache 2.0 license
  …"", "The authors line should begin with 'Authors: '", and "Please, add a module doc-string
  (`/-! ... -/`) before `noncomputable section`" [R, `.lake/build/lib/lean/GLCinLean/*.trace`].
  They are warnings only, because GLCinLean does not set `warningAsError` (Tau Ceti does) [R].
  The previous version of this note said they "would be flagged" if the linter were switched on.
- The opening comments carry process status ("Status: STUB written 2026-11-05 by Claude Opus
  5.5", sorry-budget and pin files) instead of the summary and the *Main definitions*,
  *Implementation notes*, *References* sections.
- Docstrings begin with "PLACEHOLDER (provisional)" and refer to repository files
  (`reviews/statement-pin.toml`). Mathlib has no placeholder convention; its rule is that a
  docstring conveys the mathematical meaning.
- Citations are written as "GLC I §1.3", "`text.tex` l.2066", "`functor.tex` l.717". No
  `references.bib` exists in the repository (`find . -name '*.bib'`: none outside `.lake/`).
  TeX line numbers refer to a local, untracked download and cannot be followed by a reader of the
  docs.
- `lakefile.toml` sets `weak.linter.mathlibStandardSet = true` and uses
  `batteries/runLinter` as `lintDriver`, so `lake lint` would run `docBlame` [R for the setting;
  E for the effect].

## 4. Conflicts

- **Current files vs ideas.md** ("fully in Mathlib's documentation style"): the headers,
  missing `module` token, missing module docstrings and TeX-line citations above do not follow
  this page [J].
- **Placeholders vs "convey the mathematical meaning"**: an `opaque` placeholder has no content,
  so a docstring that describes the intended object "lies" by more than the "slightly" this page
  allows. Saying plainly that the declaration is a placeholder for the named object, and citing
  where the object is defined, keeps both the Mathlib rule and the owner's "trust and verify"
  [J]. This bears on the AGENTS.md placeholder note as well.
- **Review provenance vs Mathlib citations**: precise TeX line numbers help a reviewer (and
  `prompts/review.md` compares declarations with the papers "at the versions in `manifest.toml`"),
  but Mathlib-style docstrings cite section and theorem numbers through BibTeX. The two serve
  different readers; line numbers belong in review records, not docstrings [J].
- **Tau Ceti practice vs this page**: Tau Ceti's
  `TauCeti/Algebra/AlgebraicGroup/Pinning/Basic.lean` lists references as plain text ("B. Conrad,
  *Reductive Group Schemes* (2014), §5.1.") rather than `[text][key]` links, although its own
  `references.bib` header asks for keys [R]. (added) This is the norm, not an exception: at
  d2083f0f, 19050 of 27553 files under `TauCeti/` have a `## References` heading, but at most
  1429 contain a `][key]` reference link (an upper bound: the pattern also matches notation such as
  `[X][Y]`) [R, grep]. The page says references "should" use BibTeX entries, so this is a softer
  rule in practice than it reads [J]. (The same file's imports are not alphabetical either, though
  the page asks for "grouped and sorted" imports [R].)
- (added) **Style-guide URL in `notes/ideas.md` vs the documentation page**: ideas.md links the
  style guide on `leanprover-community.github.io`, while this page's links go to the newer,
  diverged copy on mathlib.org (section 1) [R]. Prompts that link both pages should link the
  mathlib.org copy, which is the one Mathlib's maintainers are editing [J].
- (added) **Markdown vs Verso citation syntax**: the page gives only `[text][key]`; Mathlib's
  Verso files use `{cite "key"}[text]` (section 2) [R]. A prompt that copies the page's syntax
  would be wrong for Verso docstrings [J].
- **No arXiv cross-reference attribute**: the owner's sources are arXiv papers; Mathlib offers no
  `@[arxiv ...]` attribute, so declaration-level links to GLC papers can only be in docstring text
  [R for the list; J for the consequence].

## 5. Input for the open questions (workflow.md, "Questions for after the research")

- **What goes into `AGENTS.md`.** Suggests one line requiring Mathlib's documentation style with
  a link to <https://mathlib.org/contribute/doc.html>, plus the project-specific facts that page
  cannot supply: the location of the project's `docs/references.bib`, the key convention (reuse
  Mathlib's keys, Mathlib's `authorYEAR` style for new ones), and how placeholders are documented.
  Reason: the page is maintained upstream and changes (it moved two days ago); a copy would drift
  [J].
- **Whether `Abstract.lean`, `Foundations.lean` and their placeholder design are reasonable.**
  Whatever stays needs a Mathlib header and module docstring, process status moved out of the
  docstrings, and citations by BibTeX key [J].
- **What happens to each existing file.** `references/papers/manifest.toml`: suggests a
  `docs/references.bib` take over the identification of papers (arXiv id plus version), which
  answers the owner's doubt about the manifest; whether the hashes are kept is the owner's call
  [J]. `blueprint/` and `PLAN.md`: the "theories documentation" mentioned on the page (overviews
  spanning several files) is Mathlib's place for cross-file mathematical explanation; a
  blueprint fills the same role for a project [J].
- **Who reviews the mathematics, and to what standard.** The documentation part of the standard
  can be this page, checked mechanically by `docBlame`/`docBlameThm` and the header linter
  (already on, as warnings), and by review for the rest (meaning of docstrings, precise
  citations) [J]. Making the header linter a gate needs `warningAsError`, as Tau Ceti has, which
  would also turn every other warning into an error [R for Tau Ceti's setting; J].
- **Where research notes and session summaries live.** Not addressed by this source.

### Rules prompts should link to rather than copy [J]

Link (upstream, maintained, may change):

- the header order and the module-docstring section list (`doc.html#header-comment`);
- docstring rules (`doc.html#doc-strings`) and LaTeX/Markdown (`doc.html#latex-and-markdown`);
- citation syntax (`doc.html#citing-other-works`) and cross-reference attributes
  (`doc.html#cross-references-to-external-mathematical-databases`, and the attribute list in
  `Mathlib.Tactic.CrossRefAttribute`);
- the copyright and import rules on the style guide, on **mathlib.org**
  (`https://mathlib.org/contribute/style.html#copyright-header`, `#imports`,
  `#module-docstrings`); these anchors do not exist on the old site's copy [R];
- the Verso `{cite}` role (`Mathlib/Util/VersoRoles.lean`), if Verso docstrings are used.

The header linter already enforces the mechanical part of the header rules, so a prompt can
say "fix all `linter.style.header` warnings" instead of restating them [J].

State in the project's own text (not on the page, or specific to GLCinLean):

- that the project bibliography is `docs/references.bib` (or a `docbuild/docs/` copy) and every
  cited key needs an entry there, because doc-gen4 reads only the root package's file;
- the citation form for GLC papers, with a locator in the link text and no `]` inside it;
- how a placeholder's docstring is written;
- that process metadata (status, dates, model names) stays out of docstrings.

## 6. Questions for the owner

1. **Copyright and authors line.** Mathlib's header needs `Copyright (c) YEAR NAME` and
   `Authors:`. Tau Ceti writes "Copyright (c) 2026 The Tau Ceti contributors"; its `Authors:`
   lines are mostly "The Tau Ceti contributors" (25536 files), then "Codex" (1093), "Claude" (210)
   and named people [R, grep @ d2083f0f]. Who is named in GLCinLean files: you, the AI model, or
   both? (The licence line is not a question: GLCinLean's `LICENSE` is Apache 2.0, which matches
   the header linter's default [R].)
2. **Bibliography home.** Accept a `docs/references.bib` (BibTeX, arXiv id and version per paper)
   as the project's record of papers, replacing `references/papers/manifest.toml`? If yes, are the
   SHA-256 sums and licence notes kept anywhere?
3. **Published API docs.** Should GLCinLean build and publish doc-gen4 pages (Tau Ceti's
   `docbuild/` layout), or is the review system's web page the only published view?
4. **Placeholder docstrings.** Is it acceptable that a placeholder's docstring says it is a
   placeholder for the named, cited object (rather than describing the object as if defined)?
5. **`docBlameThm`.** Mathlib requires docstrings on "major theorems" but lints only definitions
   by default. Should GLCinLean turn on `docBlameThm` (docstrings on every theorem), which is
   stricter than Mathlib?
6. (added) **Markdown or Verso docstrings.** Tau Ceti uses Markdown docstrings only; Mathlib is
   converting files to Verso, whose `{cite}` role checks bibliography keys at build time. Write
   GLCinLean in Tau Ceti's form (easier to contribute there) or in Verso (checked citations,
   Mathlib's direction)?
7. (added) **Warnings as errors.** The header and docstring linters already run and already warn
   on both Lean files. Should GLCinLean set `warningAsError`, as Tau Ceti does, so that these rules
   are gates and not just log lines? (This touches `lakefile.toml`, an owner's file.)
