-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Staging route (control): Foundations re-exports the Staging object.
import GLCinLean.Faults.Staging.Object
namespace GLCinLean.Faults.StagingFoundations
abbrev LocalObject := GLCinLean.Faults.Staging.LocalObject
end GLCinLean.Faults.StagingFoundations
