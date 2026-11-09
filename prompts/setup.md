# Setup on a new computer

**Goal.** Make a fresh clone of GLCinLean ready for the other prompts: the tools are there, the project builds from the caches, and the papers' LaTeX sources are on disk.

**Done when**
- the tools below are present, or each missing one is reported with how to install it;
- the tracker submodule is checked out at the commit the repository records;
- the caches are fetched and `lake build` passes without compiling any Mathlib or Tau Ceti module, as `AGENTS.md` describes; `lake exe tracker status` runs;
- every paper in `docs/references.bib` has its TeX in `references/papers/<id>v<version>/src/`, with its original file names;
- docstrings in `GLCinLean/` that cite a TeX file and line, or a key without brackets, are checked against `AGENTS.md`, and if they break it, a simple way to fix them is proposed;
- a light way for agents to find and search the papers cheaply is proposed (for example a one-line tag per paper saying what it covers), and is added only if the owner agrees;
- if anything in the repository had to change to get here, it is committed and pushed.

**Context**
- Tools: `git`, `curl`, `tar`, `gunzip`, `file`; `elan`, which installs the Lean in `lean-toolchain`; `gh`, logged in as `WHY-Op109` with push rights on `WHY-Op109/GLCinLean` (`gh api repos/WHY-Op109/GLCinLean --jq .permissions.push`). Only for contributions to Tau Ceti: `uv` and Tau Ceti's Worker (https://github.com/TauCetiProject/TauCetiWorker).
- The tracker comes with `git submodule update --init`. The build commands are in `README.md`; the first fetch downloads several GB.
- A paper's TeX is at `https://arxiv.org/e-print/<id>v<version>` (the `eprint` field of `docs/references.bib`). In its `src/` folder:

      curl -L -o source.gz https://arxiv.org/e-print/<id>v<version>
      gunzip -N source.gz
      if file source | grep -q tar; then tar -xf source && rm source; fi

  (a single `.tex` file gets its original name back; a tar archive comes out as `source` and is unpacked). Fetch one paper at a time, with a pause between requests.
- `references/papers/` is git-ignored: the papers are never committed.
