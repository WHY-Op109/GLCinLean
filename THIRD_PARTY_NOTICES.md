# Third-party notices

GLCinLean is licensed under Apache-2.0 (`LICENSE`, D22). It uses or adapts the following
third-party material. Licences checked on 2026-11-05 [R] unless stated otherwise. This file
replaces the permission record of README line 37 (plan §1, C1).

## In this repository

| Material | Where | Source, pinned | Licence | Use |
|---|---|---|---|---|
| bridgekat/tracker | `tools/tracker/` (git submodule) | `https://github.com/bridgekat/tracker` @ `c223b672b26179322ca61f321bcfa8aabedaba79` | Apache-2.0, Copyright (c) 2026 Great Bay University | progress tracker, built and run unmodified (D12) |
| Tau Ceti cache service entry | `.lake-config/lake-config.toml` | TauCetiProject/TauCetiTools @ `b49bb4f`, `scripts/lake-cache-get.sh` | Apache-2.0 | four lines of configuration, adapted |

The review kit (`reviewkit/`) is our own code. Its closure walk follows the idea of
`edemaine/lean-canny` `scripts/CheckAbstract.lean` @ `af8d9dc` (Apache-2.0); no code was copied
(D39: ideas adopted, not code). Its SHA-256 follows FIPS 180-4.

## Lake dependencies (fetched, not redistributed here)

| Dependency | Pin | Licence |
|---|---|---|
| Tau Ceti | tag `v4.36.0-rc2` = `e0610cce4004d628cbd9d2aafdbbb5459fe72938` | Apache-2.0 |
| Mathlib and its dependencies (Batteries, Aesop, Qq, ProofWidgets, Plausible, ImportGraph, LeanSearchClient, Cli) | Mathlib `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`, through Tau Ceti | Apache-2.0 |
| Lean 4 toolchain | `leanprover/lean4:v4.36.0-rc2` | Apache-2.0 |

## Planned (added in later stages; notices to be completed then)

- `bridgekat/tracker-graph-explorer` @ `bbd8cc6` (MIT); its built page bundles elkjs (EPL-2.0 OR GPL-3.0-or-later), which needs a notice and a source link (A3, K11).
- doc-gen4 fork `kim-em/doc-gen4@d25c2842` (Apache-2.0), if approved (Q9).
- numlib-auto prompts @ `ac8840c0` (Apache-2.0), adapted with attribution (K10).
- AxiomMath/Stacks @ `012108f6` (Apache-2.0): only if B1b sends a node to Stacks (D41, D42); copied files carry provenance headers.

## Not redistributed

The GLC I–V papers and AGKRRV (`references/papers/manifest.toml`) are fetched locally by
`scripts/fetch-papers.py` and never committed (D6). The Stacks Project LaTeX (GFDL 1.2) will be
fetched the same way from A3 (D42).
