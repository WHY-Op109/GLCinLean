/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5, GPT-6
-/
module

public import GLCinLean.Placeholder
public import GLCinLean.Statement.Enhanced
public import GLCinLean.Statement.Conjecture

/-!
# The geometric Langlands statement

Public entry point for the characterized-functor form of [GLC1] Conj. 1.6.7, including
its explicitly marked statement placeholders.

## Differences from the sources

Errors and gaps found in the sources.

* [RaskinCPSI] §6.10: the proof that the factorization functors of the category `C_{X^I}` are
  equivalences over the disjoint locus is one sentence ("a cofinality argument"). It interchanges a
  tensor product of categories with two limits. This interchange holds for a compactly generated
  rigid category `C` (Lemma 6.18.1); for another category the source has no proof.
* [RaskinCPSI] Corollary 6.18.2: the self-duality of `C_{X^I}` as a module category over the
  D-modules on `X^I` is stated without proof. Dualizability follows from Lemma 6.18.1; the pairing
  and its perfectness do not.
* [RaskinCPSII] Lemma 9.8.1 and Appendix A.5: the reduction from a general curve to the affine line
  is left to the reader.
* [IndCoh] Theorem 5.6.3, on which the symmetric monoidal structure of the `!`-tensor product
  rests, is stated without proof.
* [OneAffineness] Theorem 2.6.3: the gluing step over a finite affine open cover is left to the
  reader.

## Not formalized

No claim of the sources is given up.
-/
