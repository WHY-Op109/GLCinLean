-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Imports (warning only): an abstract that names Mathlib's schemes directly instead of
-- the Foundations name.
import GLCinLean.Foundations
namespace GLCinLean.Faults.FoundationsName
def Curves : Type 1 := AlgebraicGeometry.Scheme.{0}
end GLCinLean.Faults.FoundationsName
