# Third-party notices

GLCinLean is licensed under Apache-2.0 (`LICENSE`). Licences checked on 2026-11-05.

## In this repository

| Material | Where | Source, pinned | Licence | Use |
|---|---|---|---|---|
| bridgekat/tracker | `tools/tracker/` (git submodule) | `https://github.com/bridgekat/tracker` @ `c223b672b26179322ca61f321bcfa8aabedaba79` | Apache-2.0, Copyright (c) 2026 Great Bay University | progress tracker, built and run unmodified |
| Tau Ceti cache service entry | `.lake-config/lake-config.toml` | TauCetiProject/TauCetiTools @ `b49bb4f`, `scripts/lake-cache-get.sh` | Apache-2.0 | four lines of configuration, adapted |

## Lake dependencies (fetched, not redistributed here)

| Dependency | Pin | Licence |
|---|---|---|
| ReviewKit (our own review checks) | `https://github.com/WHY-Op109/reviewkit`, pinned in `lake-manifest.json` | Apache-2.0 |
| Tau Ceti | tag `v4.36.0-rc2` = `e0610cce4004d628cbd9d2aafdbbb5459fe72938` | Apache-2.0 |
| Mathlib and its dependencies (Batteries, Aesop, Qq, ProofWidgets, Plausible, ImportGraph, LeanSearchClient, Cli) | Mathlib `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`, through Tau Ceti | Apache-2.0 |
| Lean 4 toolchain | `leanprover/lean4:v4.36.0-rc2` | Apache-2.0 |

ReviewKit's closure walk follows the idea of `edemaine/lean-canny` `scripts/CheckAbstract.lean`
@ `af8d9dc` (Apache-2.0); no code was copied.

## Not redistributed

The GLC I–V papers and AGKRRV (`references/papers/manifest.toml`) are fetched locally by
`scripts/fetch-papers.py` and never committed.
