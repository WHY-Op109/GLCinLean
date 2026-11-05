-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Fingerprint (D43/F03): two statements that differ only by one opaque object swapped for
-- another of the same type (IndCohNilp and DmodHalf are both opaque Setting k → DGCat). The
-- prototype's name-free hash gave them the same fingerprint (Astra's probe A).
import GLCinLean.Abstract
namespace GLCinLean.Faults.SwappedObject
open GLCinLean.Abstract GLCinLean.Foundations
universe u
variable {k : Type u} [Field k] [CharZero k] [IsAlgClosed k]
theorem mainA (S : Setting k) : (LinFun.id (QCohLS S) (IndCohNilp S)).IsEquivalence := sorry
theorem mainB (S : Setting k) : (LinFun.id (QCohLS S) (DmodHalf S)).IsEquivalence := sorry
theorem mainCopy (S : Setting k) : (LinFun.id (QCohLS S) (IndCohNilp S)).IsEquivalence := sorry
end GLCinLean.Faults.SwappedObject
