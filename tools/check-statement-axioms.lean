/-
Copyright (c) 2026 The GLCinLean contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: The GLCinLean contributors, GPT-6
-/
import GLCinLean

/-!
# Axiom audit of the statement

Run with `lake env lean tools/check-statement-axioms.lean` after building. Every explicit
statement declaration is listed; update the list when the statement changes. Only the main
theorem may report `sorryAx`; all closures must stay within the axioms in `AGENTS.md`.
-/

#print axioms GLCinLean.Statement.DGCatCarrier
#print axioms GLCinLean.Statement.DGCat
#print axioms GLCinLean.Statement.TStructuredDGCatCarrier
#print axioms GLCinLean.Statement.TStructuredDGCat
#print axioms GLCinLean.Statement.DGCat.objCarrier
#print axioms GLCinLean.Statement.DGCat.Obj
#print axioms GLCinLean.Statement.DGCat.IsCompact
#print axioms GLCinLean.Statement.TStructuredDGCat.toDGCat
#print axioms GLCinLean.Statement.TStructuredDGCat.IsEventuallyCoconnective
#print axioms GLCinLean.Statement.DGFunCarrier
#print axioms GLCinLean.Statement.DGFun
#print axioms GLCinLean.Statement.DGFun.obj
#print axioms GLCinLean.Statement.DGFun.comp
#print axioms GLCinLean.Statement.DGFun.id
#print axioms GLCinLean.Statement.DGNatIso
#print axioms GLCinLean.Statement.DGFun.MapsEquiv
#print axioms GLCinLean.Statement.DGFun.IsEquivalence
#print axioms GLCinLean.Statement.DGFun.isEquivalence_iff
#print axioms GLCinLean.Statement.RootDatumDuality
#print axioms GLCinLean.Statement.Setting
#print axioms GLCinLean.Statement.QCohLS
#print axioms GLCinLean.Statement.DmodHalf
#print axioms GLCinLean.Statement.IndCohNilp
#print axioms GLCinLean.Statement.Psi
#print axioms GLCinLean.Statement.RepRan
#print axioms GLCinLean.Statement.Loc
#print axioms GLCinLean.Statement.heckeActionRight
#print axioms GLCinLean.Statement.vacuumPoincare
#print axioms GLCinLean.Statement.IsLanglandsFunctor
#print axioms GLCinLean.Statement.isLanglandsFunctor_iff
#print axioms GLCinLean.Statement.exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence
