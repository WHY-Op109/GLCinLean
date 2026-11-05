-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Placeholders (K2): an opaque placeholder without @[placeholder].
import GLCinLean.Foundations
noncomputable section
namespace GLCinLean.Faults.UntaggedPlaceholder
opaque HiddenCategory : GLCinLean.Foundations.DGCat
end GLCinLean.Faults.UntaggedPlaceholder
end
