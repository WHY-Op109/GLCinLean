-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Staging route (control): the abstract reaches the Staging object through Foundations.
import GLCinLean.Faults.Staging.Foundations
namespace GLCinLean.Faults.StagingAbstract
def UsesLocal : Type := GLCinLean.Faults.StagingFoundations.LocalObject
end GLCinLean.Faults.StagingAbstract
