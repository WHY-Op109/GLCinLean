-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Axioms: an admission hidden in an opaque body. `#print axioms`
-- reports `sorryAx` for both declarations; the trace and the direct-sorry scan must see it too.
import GLCinLean.Abstract
noncomputable section
namespace GLCinLean.Faults.OpaqueSorry
@[placeholder] opaque taggedDataWithSorry : Nat := sorry
theorem usesTaggedData : taggedDataWithSorry = taggedDataWithSorry := rfl
end GLCinLean.Faults.OpaqueSorry
end
