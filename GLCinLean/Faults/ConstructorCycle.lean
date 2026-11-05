-- Fault-injection fixture (D27 test 1), built only by the fault job; expected diagnostic in glc/faults.toml.
-- Axioms (D43/F21): a sorry inside a constructor type. The inductive and its constructor refer
-- to each other; the per-declaration traces must contain sorryAx in every root order.
import GLCinLean.Foundations
namespace GLCinLean.Faults.ConstructorCycle
inductive T where
  | mk (n : Nat) (h : n = (sorry : Nat)) : T
def aUsesMk : Nat → Prop := fun n => ∃ h, T.mk n h = T.mk n h
def useT : T → Nat := fun _ => 0
end GLCinLean.Faults.ConstructorCycle
