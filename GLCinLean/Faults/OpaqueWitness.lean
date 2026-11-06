-- Passing control for OpaqueSorry, built only by the fault job; see glc/faults.toml.
-- The same shape with an honest witness: no sorry source, no axiom diagnostic.
import GLCinLean.Abstract
noncomputable section
namespace GLCinLean.Faults.OpaqueWitness
@[placeholder] opaque taggedData : Nat
theorem usesTaggedData : taggedData = taggedData := rfl
end GLCinLean.Faults.OpaqueWitness
end
