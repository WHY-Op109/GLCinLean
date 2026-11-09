# Setup on a new computer

**Goal.** Make a fresh clone of GLCinLean ready for the other prompts: the tools are there, the project builds from the caches, and the papers' LaTeX sources are on disk.

**Done when**
- the tools below are present, or each missing one is reported with how to install it;
- the tracker submodule is checked out at the commit the repository records;
- the caches are fetched and `lake build` passes without compiling any Mathlib or Tau Ceti module, as `AGENTS.md` describes; `lake exe tracker status` runs;
- every paper in `docs/references.bib` is unpacked into `references/papers/<id>v<version>/src/`, with its original file names;
- docstrings in `GLCinLean/` that cite a TeX file and line, or a key without brackets, are checked against `AGENTS.md`, and if they break it, a simple way to fix them is proposed;
- a light way for agents to find and search the papers cheaply is proposed (for example a one-line tag per paper saying what it covers, or a list of each paper's `\label`s and sections), and is added only if the owner agrees;
- if anything in the repository had to change to get here, it is committed and pushed.

**Context**
- Tools:
  - `git`, `curl`, `tar`, `gunzip`;
  - `elan`, which installs the Lean version in `lean-toolchain` (Lean and `lake` come with it);
  - `gh`, logged in to the GitHub account `WHY-Op109` with push rights on `WHY-Op109/GLCinLean` (`gh auth status`; `gh api repos/WHY-Op109/GLCinLean --jq .permissions.push`), since sessions push to `main`;
  - for contributions to Tau Ceti only (not needed to build): `uv`, and Tau Ceti's Worker (`tauceti`, from https://github.com/TauCetiProject/TauCetiWorker).
  - Optional: Lean LSP tools that give LeanSearch and Loogle; `grep`, `exact?` and `apply?` work without them.
- A clone made without `--recurse-submodules` gets the tracker with `git submodule update --init`.
- The build commands are in `README.md` and `AGENTS.md`. The first fetch downloads several GB.
- The papers, from `docs/references.bib` (the arXiv id with its version is the `eprint` field):

  | Key | arXiv | Main file |
  |---|---|---|
  | GLC1 | [2405.03599v3](https://arxiv.org/abs/2405.03599v3) | `functor.tex` |
  | GLC2 | [2405.03648v3](https://arxiv.org/abs/2405.03648v3) | `Loc.tex` |
  | GLC3 | [2409.07051v1](https://arxiv.org/abs/2409.07051v1) | `Eis.tex` |
  | GLC4 | [2409.08670v1](https://arxiv.org/abs/2409.08670v1) | `ambidex.tex` |
  | GLC5 | [2409.09856v3](https://arxiv.org/abs/2409.09856v3) | `multone.tex` |
  | AGKRRV | [2010.01906v2](https://arxiv.org/abs/2010.01906v2) | `text.tex` |
  | ArinkinGaitsgory | [1201.6343v4](https://arxiv.org/abs/1201.6343v4) | `singsupp.tex` |
  | IndCoh | [1105.4857v7](https://arxiv.org/abs/1105.4857v7) | `IndCohtext.tex` |

  The LaTeX source of `<id>v<version>` is at `https://arxiv.org/e-print/<id>v<version>` (follow redirects: `curl -L`). It comes in one of two forms, checked on 2026-11-09: a gzipped tar archive (GLC I and GLC V), unpacked with `tar -xzf source -C src`; or a single gzipped `.tex` file (the others), unpacked with its original name by saving it as `src/source.gz` and running `gunzip -N source.gz` inside `src/`. Fetch one paper at a time, with a pause between requests.
- `references/papers/` is git-ignored: the papers are never committed.
