-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Axioms (D27 test 1): a property axiom asserting the conjecture, and a theorem using it.
import GLCinLean.Abstract
namespace GLCinLean.Faults.ProjectAxiom
open GLCinLean.Abstract
axiom glc_holds : ∀ {k : Type} [Field k] [CharZero k] [IsAlgClosed k] (S : Setting k), (LG S).IsEquivalence
theorem main' {k : Type} [Field k] [CharZero k] [IsAlgClosed k] (S : Setting k) :
    (LG S).IsEquivalence := glc_holds S
end GLCinLean.Faults.ProjectAxiom
