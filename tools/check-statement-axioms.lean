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
#print axioms GLCinLean.Statement.DGCat.objCarrier
#print axioms GLCinLean.Statement.DGCat.Obj
#print axioms GLCinLean.Statement.DGCat.IsCompact
#print axioms GLCinLean.Statement.MonoidalDGCatCarrier
#print axioms GLCinLean.Statement.MonoidalDGCat
#print axioms GLCinLean.Statement.DGModuleCarrier
#print axioms GLCinLean.Statement.DGModule
#print axioms GLCinLean.Statement.DGModule.toDGCat
#print axioms GLCinLean.Statement.MonoidalDGCat.regularModule
#print axioms GLCinLean.Statement.TStructuredDGModuleCarrier
#print axioms GLCinLean.Statement.TStructuredDGModule
#print axioms GLCinLean.Statement.TStructuredDGModule.toModule
#print axioms GLCinLean.Statement.TStructuredDGModule.IsEventuallyCoconnective
#print axioms GLCinLean.Statement.LinFunCarrier
#print axioms GLCinLean.Statement.LinFun
#print axioms GLCinLean.Statement.LinFun.obj
#print axioms GLCinLean.Statement.LinFun.comp
#print axioms GLCinLean.Statement.LinFun.id
#print axioms GLCinLean.Statement.LinIso
#print axioms GLCinLean.Statement.LinFun.IsEquivalence
#print axioms GLCinLean.Statement.LinFun.isEquivalence_iff
#print axioms GLCinLean.Statement.RootDatumDuality
#print axioms GLCinLean.Statement.Setting
#print axioms GLCinLean.Statement.QCohLS
#print axioms GLCinLean.Statement.DmodHalf
#print axioms GLCinLean.Statement.IndCohNilp
#print axioms GLCinLean.Statement.Psi
#print axioms GLCinLean.Statement.LCoarse
#print axioms GLCinLean.Statement.IsLanglandsFunctor
#print axioms GLCinLean.Statement.isLanglandsFunctor_iff
#print axioms GLCinLean.Statement.exists_isLanglandsFunctor_and_forall_isLanglandsFunctor_imp_isEquivalence
