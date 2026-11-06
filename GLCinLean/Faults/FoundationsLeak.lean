-- Fault-injection fixture, built only by the fault job; expected diagnostic in glc/faults.toml.
-- Closure: a Foundations-class structure whose field type leaks implementation code.
import GLCinLean.Faults.Impl
namespace GLCinLean.Faults.FoundationsLeak
structure Wrapper where
  val : Nat
  pos : 0 < val ∧ val ≤ GLCinLean.Faults.Impl.helperBound
end GLCinLean.Faults.FoundationsLeak
