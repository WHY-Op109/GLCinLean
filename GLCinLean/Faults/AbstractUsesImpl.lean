-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Closure: an abstract definition depends on implementation code.
import GLCinLean.Faults.Impl
namespace GLCinLean.Faults.AbstractUsesImpl
theorem okProof : ∃ n : Nat, 0 < n := ⟨_, GLCinLean.Faults.Impl.helper_pos⟩
def Bad : Prop := GLCinLean.Faults.Impl.helperBound = 42
end GLCinLean.Faults.AbstractUsesImpl
