-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Axioms: a sorry that is not in the sorry budget.
import GLCinLean.Abstract
namespace GLCinLean.Faults.StraySorry
theorem stray : 2 + 2 = 4 := sorry
end GLCinLean.Faults.StraySorry
