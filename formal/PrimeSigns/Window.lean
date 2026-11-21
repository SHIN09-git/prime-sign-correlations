import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open Real
namespace PrimeSigns

/-- Autocorrelation of the exponential interval window. -/
noncomputable def window (h t : ℝ) : ℝ :=
  if |t| ≤ h then exp (|t|/2) * (exp (h-|t|)-1) else 0

theorem window_outside {h t : ℝ} (ht : h < |t|) : window h t = 0 := by
  simp [window, not_le.mpr ht]

theorem window_zero {h : ℝ} (hh : 0 ≤ h) : window h 0 = exp h - 1 := by
  simp [window, hh]

theorem window_edge {h t : ℝ} (he : |t| = h) : window h t = 0 := by
  simp [window, he]

theorem window_nonneg (h t : ℝ) : 0 ≤ window h t := by
  unfold window
  split_ifs with ht
  · exact mul_nonneg (exp_pos _).le (sub_nonneg.mpr <| Real.one_le_exp_iff.mpr (sub_nonneg.mpr ht))
  · exact le_rfl

theorem window_overlap {h t : ℝ} (ht : |t| ≤ h) :
    (∫ u in 0..h-|t|, exp (u+|t|/2)) = window h t := by
  simp only [exp_add, intervalIntegral.integral_mul_const, integral_exp, exp_zero, window, if_pos ht]
  ring

/-- At an isolated center the whole finite weighted sum is a single term. -/
theorem isolate_atom {ι : Type*} [DecidableEq ι] (s : Finset ι) (i : ι)
    (hi : i ∈ s) (a w : ι → ℝ) {h : ℝ} (hh : 0 ≤ h)
    (gap : ∀ j ∈ s, j ≠ i → h < |a j-a i|) :
    (∑ j ∈ s, w j * window h (a j-a i)) = w i * (exp h-1) := by
  rw [Finset.sum_eq_single i]
  · simp [window_zero hh]
  · intro j hj hji
    simp [window_outside (gap j hj hji)]
  · exact fun h => (h hi).elim

/-- On a cell where both counts are constant, the two excess conditions cut off
    the cell at the smaller of the two thresholds. -/
theorem two_excess_cell {a b x d q s t : ℝ} (hd : 0 < d) (hq : 0 < q) :
    (a ≤ x ∧ x < b ∧ d*x < s ∧ (q*d)*x < t) ↔
      (a ≤ x ∧ x < min b (min (s/d) (t/(q*d)))) := by
  simp only [lt_min_iff, lt_div_iff₀ hd, lt_div_iff₀ (mul_pos hq hd)]
  rw [mul_comm x d, mul_comm x (q*d)]

end PrimeSigns
