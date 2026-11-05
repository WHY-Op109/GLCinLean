-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Staging route (D43/F01, control): the abstract reaches the Staging object through Foundations.
import GLCinLean.Faults.Staging.Foundations
namespace GLCinLean.Faults.StagingAbstract
def UsesLocal : Type := GLCinLean.Faults.StagingFoundations.LocalObject
end GLCinLean.Faults.StagingAbstract
