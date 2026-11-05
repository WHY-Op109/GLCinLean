-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Imports (Q14, warning only): an abstract that names Mathlib's schemes directly instead of
-- the Foundations name.
import GLCinLean.Foundations
namespace GLCinLean.Faults.FoundationsName
def Curves : Type 1 := AlgebraicGeometry.Scheme.{0}
end GLCinLean.Faults.FoundationsName
