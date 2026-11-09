/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, Claude Opus 5.5
-/
import Lean

/-!
# The `@[placeholder]` attribute

`@[placeholder]` marks a declaration that stands for an object of the GLC statement that is not
defined yet: an `opaque` constant, or a definition built over one. Placeholders appear only in
the statement surface, never in the library, so that a statement resting on them is never
mistaken for a finished one.
-/

open Lean

/-- `@[placeholder]` marks a declaration that stands for a not-yet-defined object of the GLC
statement. -/
initialize placeholderAttr : TagAttribute ←
  registerTagAttribute `placeholder "marks a not-yet-defined object of the GLC statement"
