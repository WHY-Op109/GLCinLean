-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Helper: project code outside every closure class (not Foundations, Staging or Stacks).
import GLCinLean.Foundations
namespace GLCinLean.Faults.Impl
def helperBound : Nat := 42
theorem helper_pos : 0 < helperBound := by decide
end GLCinLean.Faults.Impl
