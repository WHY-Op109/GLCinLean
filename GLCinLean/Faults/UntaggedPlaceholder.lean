-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Placeholders: an opaque placeholder without @[placeholder].
import GLCinLean.Foundations
noncomputable section
namespace GLCinLean.Faults.UntaggedPlaceholder
opaque HiddenCategory : GLCinLean.Foundations.DGCat
end GLCinLean.Faults.UntaggedPlaceholder
end
