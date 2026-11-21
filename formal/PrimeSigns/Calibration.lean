import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

namespace PrimeSigns

/-- The real statistic after Gaussian quadrant inversion. -/
noncomputable def signal (p : ℝ) : ℝ := -Real.sin (2 * Real.pi * (p-1/4))

theorem exact_sign_inversion {ρ : ℝ} (lo : -1 ≤ ρ) (hi : ρ ≤ 1) :
    signal (1/4 + Real.arcsin ρ/(2*Real.pi)) = -ρ := by
  unfold signal
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  rw [show 2*Real.pi*(1/4+Real.arcsin ρ/(2*Real.pi)-1/4) = Real.arcsin ρ by field_simp; ring]
  rw [Real.sin_arcsin lo hi]

/-- Deterministic inversion with errors in the reference reading and the target reading. -/
theorem calibration_error {c b t a z ea ez : ℝ} (hc : 0 < c) (hb : 0 < b)
    (safety : ea ≤ c*b/2) (anchor : |a-c*b| ≤ ea) (sample : |z-c*t| ≤ ez) :
    |b*z/a-t| ≤ 2*(b*ez+|t| * ea)/(c*b) := by
  have hcb := mul_pos hc hb
  have hlow := (abs_le.mp anchor).1
  have ha : 0 < a := by linarith
  have key : |b*z-t*a| ≤ b*ez+|t| * ea := calc
    |b*z-t*a| = |b*(z-c*t)-t*(a-c*b)| := by congr 1; ring
    _ ≤ |b*(z-c*t)| + |t*(a-c*b)| := abs_sub _ _
    _ ≤ b*ez+|t| * ea := by
      rw [abs_mul, abs_mul, abs_of_pos hb]
      exact add_le_add (mul_le_mul_of_nonneg_left sample hb.le)
        (mul_le_mul_of_nonneg_left anchor (abs_nonneg _))
  have hn : 0 ≤ b*ez+|t| * ea := (abs_nonneg _).trans key
  rw [show b*z/a-t=(b*z-t*a)/a by field_simp, abs_div, abs_of_pos ha]
  apply (div_le_div_iff₀ ha hcb).2
  calc
    |b*z-t*a| * (c*b) ≤ (b*ez+|t| * ea)*(c*b) := mul_le_mul_of_nonneg_right key hcb.le
    _ ≤ 2*(b*ez+|t| * ea)*a := by nlinarith [mul_nonneg hn (show 0 ≤ 2*a-c*b by linarith)]

end PrimeSigns
