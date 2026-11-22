import Mathlib.Data.Finset.Card
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Linarith
import Mathlib.Data.Real.Basic

namespace PrimeSigns

/-- The two forbidden residues of a nondegenerate affine prime-pair pattern. -/
theorem affine_forbidden_classes {K : Type*} [Field K] [Fintype K] [DecidableEq K]
    (a σ : K) (ha : a ≠ 0) (hs : σ ≠ 0) :
    ((Finset.univ : Finset K).filter (fun r => r = 0 ∨ a*r+σ = 0)).card = 2 := by
  classical
  have hroot (r : K) : a*r+σ = 0 ↔ r = -σ/a := by
    rw [eq_div_iff ha]
    constructor <;> intro h <;> linear_combination h
  have sets : ((Finset.univ : Finset K).filter (fun r => r = 0 ∨ a*r+σ = 0)) =
      {0, -σ/a} := by
    ext r
    simp [hroot]
  have hne : (0 : K) ≠ -σ/a := (div_ne_zero (neg_ne_zero.mpr hs) ha).symm
  rw [sets, Finset.card_pair hne]

/-- When the coefficient vanishes in the residue field only the base zero is excluded. -/
theorem degenerate_forbidden_class {K : Type*} [Field K] [Fintype K] [DecidableEq K]
    (σ : K) (hs : σ ≠ 0) :
    ((Finset.univ : Finset K).filter (fun r => r = 0 ∨ (0 : K)*r+σ = 0)).card = 1 := by
  have sets : ((Finset.univ : Finset K).filter (fun r => r = 0 ∨ (0 : K)*r+σ = 0)) = {0} := by
    ext r
    simp [hs]
  rw [sets, Finset.card_singleton]

/-- The large-prime local factor in the two-branch Ramanujan calculation. -/
theorem prime_pair_local_factor {p : ℝ} (hp : 1 < p) :
    (1-2/p)/(1-1/p)^2 = 1-1/(p-1)^2 := by
  have hp0 : p ≠ 0 := by linarith
  have hp1 : p-1 ≠ 0 := by linarith
  rw [show 1-1/p = (p-1)/p by field_simp, show 1-2/p = (p-2)/p by field_simp]
  field_simp
  ring

end PrimeSigns
