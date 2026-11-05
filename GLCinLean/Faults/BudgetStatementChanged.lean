-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Axioms (Q13): the budgeted Cor. 1.6.5 existence theorem with its statement changed to False.
-- The budget entry is bound to the statement fingerprint, so it must fail.
import GLCinLean.Abstract
namespace GLCinLean.Faults.BudgetStatementChanged
open GLCinLean.Abstract
theorem exists_isLanglandsFunctor {k : Type} [Field k] [CharZero k] [IsAlgClosed k]
    (_S : Setting k) : False := sorry
end GLCinLean.Faults.BudgetStatementChanged
