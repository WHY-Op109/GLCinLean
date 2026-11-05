-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Statement pin: an exact copy of the main theorem (control), and a version naming a different
-- object of the same type (fault).
import GLCinLean.Abstract
namespace GLCinLean.Faults.MainCopy
open GLCinLean.Abstract GLCinLean.Foundations
universe u
variable {k : Type u} [Field k] [CharZero k] [IsAlgClosed k]
theorem main (S : Setting k) : (LG S).IsEquivalence := sorry
theorem mainCoarse (S : Setting k) : (LCoarse S).IsEquivalence := sorry
end GLCinLean.Faults.MainCopy
