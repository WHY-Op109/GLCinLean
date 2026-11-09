# Setup on a new computer

**Goal.** Set up GLCinLean on this computer, ready for the other prompts.

**Done when**
- the tools below are present, or each missing one is reported with how to install it;
- the tracker submodule is checked out at the commit the repository records;
- the caches are fetched and `lake build` passes without compiling any Mathlib or Tau Ceti module, as `AGENTS.md` describes; `lake exe tracker status` runs;
- every paper in `docs/references.bib` has its TeX in `references/papers/<id>v<version>/src/`, with its original file names;
- if anything in the repository had to change to get here, it is committed and pushed.

**Context**
- Tools: `git`, `curl`, `tar`, `gunzip`, `file`; `elan`; `gh`, logged in as `WHY-Op109` with push rights on `WHY-Op109/GLCinLean` (`gh api repos/WHY-Op109/GLCinLean --jq .permissions.push`). For Tau Ceti contributions: `uv` and Tau Ceti's Worker (https://github.com/TauCetiProject/TauCetiWorker).
- A paper's TeX is at `https://arxiv.org/e-print/<id>v<version>` (the `eprint` field of `docs/references.bib`). In its `src/` folder:

      curl -L -o source.gz https://arxiv.org/e-print/<id>v<version>
      gunzip -N source.gz
      if file source | grep -q tar; then tar -xf source && rm source; fi

  Fetch one paper at a time, with a pause between requests.
