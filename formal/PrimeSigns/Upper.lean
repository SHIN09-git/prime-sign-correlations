import PrimeSigns.Passage
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith

open Real
open scoped BigOperators

namespace PrimeSigns

/-- Lower bound for the log width throughout a closed cell of starting parameters. -/
theorem cell_log_width {M U : ℝ} (hM : 0 < M) (hMU : M ≤ U) :
    1 / (6 * U + 1) ≤ log (1 + 1 / (6 * M)) := by
  have h6 : 0 < 6 * M := by positivity
  have harg : 0 < 1 + 1 / (6 * M) := by positivity
  calc
    1 / (6 * U + 1) ≤ 1 / (6 * M + 1) :=
      one_div_le_one_div_of_le (by positivity) (by linarith)
    _ = 1 - (1 + 1 / (6 * M))⁻¹ := by field_simp; ring
    _ ≤ _ := Real.one_sub_inv_le_log_of_pos harg

/-- Bounds for both logarithmic displacements of the candidate image prime. -/
theorem image_log_shifts {n : ℝ} (hn : 1 < 6 * n) :
    |log (1 + 1 / (6 * n))| ≤ 1 / (6*n-1) ∧
    |log (1 - 1 / (6 * n))| ≤ 1 / (6*n-1) := by
  have h : 0 < 6*n := by linarith
  have hx : 0 < 1 / (6*n) := by positivity
  have hx1 : 1 / (6*n) < 1 := (div_lt_one h).2 hn
  constructor
  · rw [abs_of_nonneg (Real.log_nonneg (by linarith))]
    calc
      log (1 + 1 / (6*n)) ≤ (1 + 1 / (6*n)) - 1 :=
        Real.log_le_sub_one_of_pos (by positivity)
      _ = 1 / (6*n) := by ring
      _ ≤ _ := one_div_le_one_div_of_le (by linarith) (by linarith)
  · rw [abs_of_nonpos (Real.log_nonpos (by linarith) (by linarith)), ← Real.log_inv]
    calc
      log (1 - 1 / (6*n))⁻¹ ≤ (1 - 1 / (6*n))⁻¹ - 1 :=
        Real.log_le_sub_one_of_pos (inv_pos.mpr (by linarith))
      _ = _ := by
        have hn0 : n ≠ 0 := by linarith
        have hz : 6*n-1 ≠ 0 := by linarith
        rw [show 1-1/(6*n) = (6*n-1)/(6*n) by field_simp [hn0], inv_div]
        field_simp [hz]
        ring

/-- A complete overlap supplies at least this rational fraction of the log width. -/
theorem overlap_fraction_lower {U D n h a : ℝ}
    (hU : 0 ≤ U) (hun : U+1 ≤ n) (hnD : n ≤ D)
    (hh : 1/(6*U+1) ≤ h) (ha : a ≤ 1/(6*n-1)) :
    (3*(n-U)-1)/(3*D) ≤ 1-a/h := by
  have hd : 0 < 3*D := by linarith
  have hm : 0 < 6*n-1 := by linarith
  have hu : 0 < 6*U+1 := by linarith
  have hp : 0 < h := lt_of_lt_of_le (one_div_pos.mpr hu) hh
  have hprod : 1 ≤ (6*U+1)*h := by
    have t := (div_le_iff₀ hu).1 hh
    linarith [mul_comm h (6*U+1)]
  have ha' : a/h ≤ (6*U+1)/(6*n-1) := by
    apply (div_le_iff₀ hp).2
    calc
      a ≤ 1/(6*n-1) := ha
      _ ≤ (6*U+1)/(6*n-1)*h := by
        rw [div_mul_eq_mul_div]
        exact (div_le_div_iff_of_pos_right hm).2 hprod
  have hnnum : 0 ≤ 3*(n-U)-1 := by linarith
  calc
    (3*(n-U)-1)/(3*D) ≤ (3*(n-U)-1)/((6*n-1)/2) :=
      div_le_div_of_nonneg_left hnnum (by linarith) (by linarith)
    _ = 1-(6*U+1)/(6*n-1) := by
      rw [div_div_eq_mul_div, eq_sub_iff_add_eq, ← add_div, div_eq_iff hm.ne']
      ring
    _ ≤ _ := by linarith

/-- Weighted prime-pair witnesses force strict overtake for any supplied list of events. -/
theorem integer_weight_overtake {ι : Type*} (s : Finset ι) (n w : ι → ℝ)
    {U D J h C₄ C₆ : ℝ} (hD : 0 < D) (hh : 0 < h)
    (h4 : C₄ / h ≤ J) (h6 : ∑ i ∈ s, w i ≤ C₆ / h)
    (hw : ∀ i ∈ s, (3*(n i-U)-1)/(3*D) ≤ w i)
    (hcert : 3*D*J < ∑ i ∈ s, (3*(n i-U)-1)) : C₄ < C₆ := by
  have hd : 0 < 3*D := by positivity
  have hj : J < (∑ i ∈ s, (3*(n i-U)-1))/(3*D) := by
    apply (lt_div_iff₀ hd).2
    linarith [mul_comm J (3*D)]
  rw [Finset.sum_div] at hj
  have hsum := Finset.sum_le_sum hw
  exact (div_lt_div_iff_of_pos_right hh).1 (h4.trans_lt (hj.trans_le (hsum.trans h6)))

/-- A strict positive margin in the quadratic profile gives an upper location. -/
theorem quadratic_upper_margin {κ d e z : ℝ} (hκ : 0 < κ)
    (hrad : 0 ≤ d^2+2*κ*e) (hz : (d+sqrt (d^2+2*κ*e))/κ < z) :
    e < κ*z^2/2-d*z := by
  have ht := (div_lt_iff₀ hκ).1 hz
  have hq : sqrt (d^2+2*κ*e) < κ*z-d := by linarith [mul_comm z κ]
  have hs := Real.sqrt_nonneg (d^2+2*κ*e)
  have hpos : 0 < (κ*z-d)^2-(sqrt (d^2+2*κ*e))^2 := by
    nlinarith [mul_pos (sub_pos.mpr hq) (show 0 < κ*z-d+sqrt (d^2+2*κ*e) by linarith)]
  have hscaled : 0 < κ*(κ*z^2-2*d*z-2*e) := by
    nlinarith [Real.sq_sqrt hrad]
  have : 0 < κ*z^2-2*d*z-2*e := (mul_pos_iff_of_pos_left hκ).1 hscaled
  linarith

/-- The actual two integer windows at ratio four force exact alignment. -/
theorem four_window_lock {x δ : ℝ} {n m : ℕ}
    (hl : x < (n:ℝ)) (hu : (n:ℝ) ≤ (1+δ)*x)
    (hl' : 4*x < (m:ℝ)) (hu' : (m:ℝ) ≤ (1+δ)*(4*x))
    (hlen : 4*δ*x ≤ 1) : m = 4*n := by
  have a : (m:ℝ) < (4*n+1:ℕ) := by push_cast; nlinarith
  have b : ((4*n:ℕ):ℝ) < (m+1:ℕ) := by push_cast; nlinarith
  have a' : m < 4*n+1 := by exact_mod_cast a
  have b' : 4*n < m+1 := by exact_mod_cast b
  omega

/-- One strict endpoint comparison bounds both conventions for the first contact. -/
theorem contact_le_of_strict_reading (C₄ C₆ : ℝ → ℝ) {b : ℝ}
    (hb : 4 ≤ b) (h : C₄ b < C₆ b) :
    sInf {x : ℝ | 4 ≤ x ∧ C₄ x ≤ C₆ x} ≤ b ∧
      sInf {x : ℝ | 4 ≤ x ∧ C₄ x < C₆ x} ≤ b := by
  exact ⟨csInf_le ⟨4, fun _ hx => hx.1⟩ ⟨hb, h.le⟩,
         csInf_le ⟨4, fun _ hx => hx.1⟩ ⟨hb, h⟩⟩

/-- The two-level bound for the proportion of readings above threshold. -/
theorem fraction_of_capped_mean {c u mu rho : ℝ} (hu : c < u)
    (hm : mu ≤ c*(1-rho)+u*rho) : (mu-c)/(u-c) ≤ rho := by
  apply (div_le_iff₀ (sub_pos.mpr hu)).2
  nlinarith

end PrimeSigns
