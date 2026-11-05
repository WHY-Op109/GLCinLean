-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Staging route (D43/F01, control): Foundations re-exports the Staging object.
import GLCinLean.Faults.Staging.Object
namespace GLCinLean.Faults.StagingFoundations
abbrev LocalObject := GLCinLean.Faults.Staging.LocalObject
end GLCinLean.Faults.StagingFoundations
