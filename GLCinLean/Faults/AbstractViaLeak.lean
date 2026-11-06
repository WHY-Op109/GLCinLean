-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Closure: the abstract uses only the leaky structure; caught because constructors are walked.
import GLCinLean.Faults.FoundationsLeak
namespace GLCinLean.Faults.AbstractViaLeak
def UsesWrapper : Prop := ∀ w : GLCinLean.Faults.FoundationsLeak.Wrapper, 0 < w.val
end GLCinLean.Faults.AbstractViaLeak
