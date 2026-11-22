import PrimeSigns.Passage
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.Calculus.ContDiff.Operations
import Mathlib.Topology.Algebra.Support

namespace PrimeSigns

/-- A unit complex phase cannot annihilate the ramp multiplier at nonzero frequency. -/
theorem ramp_reverse_triangle (u : ℝ) (s : ℂ) (hs : ‖s‖ = 1) :
    Real.sqrt (1+u^2)-1 ≤ ‖s*(1-Complex.I*(u:ℂ))-1‖ := by
  have hn : ‖(1-Complex.I*(u:ℂ))‖ = Real.sqrt (1+u^2) := by
    rw [Complex.norm_def, Complex.normSq_apply]
    congr 1
    simp
    ring
  have h := norm_sub_norm_le (s*(1-Complex.I*(u:ℂ))) (1 : ℂ)
  simpa [norm_mul, hs, hn] using h

/-- Explicit lower bound for the modulus of the first-moment Fourier multiplier. -/
theorem ramp_multiplier_lower {b ξ : ℝ} (hξ : ξ ≠ 0) (s : ℂ) (hs : ‖s‖=1) :
    b^2/(1+Real.sqrt (1+(b*ξ)^2)) ≤ ‖s*(1-Complex.I*((b*ξ:ℝ):ℂ))-1‖ / ξ^2 := by
  have hr := Real.sqrt_nonneg (1+(b*ξ)^2)
  have hrs := Real.sq_sqrt (show 0 ≤ 1+(b*ξ)^2 by positivity)
  have den : 0 < 1+Real.sqrt (1+(b*ξ)^2) := by linarith
  have h0 := ramp_reverse_triangle (b*ξ) s hs
  apply (div_le_div_iff₀ den (sq_pos_of_ne_zero hξ)).2
  calc
    b^2 * ξ^2 = (Real.sqrt (1+(b*ξ)^2)-1)*(1+Real.sqrt (1+(b*ξ)^2)) := by nlinarith
    _ ≤ _ := mul_le_mul_of_nonneg_right h0 den.le

/-- The first moment of a complex exponential, integrated in a real variable. -/
theorem ramp_exp_integral (b : ℝ) {c : ℂ} (hc : c ≠ 0) :
    (∫ x in (0:ℝ)..b, (x:ℂ)*Complex.exp (c*x)) =
      (Complex.exp (c*b)*(c*b-1)+1)/c^2 := by
  have hd (x : ℂ) :
      HasDerivAt (fun w : ℂ => Complex.exp (c*w)*(c*w-1)/c^2)
        (x*Complex.exp (c*x)) x := by
    have hw := (hasDerivAt_id' x).const_mul c
    convert (hw.cexp.mul (hw.sub_const 1)).div_const (c^2) using 1
    dsimp
    field_simp
    ring
  calc
    _ = Complex.exp (c*b)*(c*b-1)/c^2 -
          Complex.exp (c*(0:ℂ))*(c*(0:ℂ)-1)/c^2 := by
      apply intervalIntegral.integral_eq_sub_of_hasDerivAt
        (f := fun x : ℝ => Complex.exp (c*x)*(c*x-1)/c^2)
      · exact fun x _ => (hd (x:ℂ)).comp_ofReal
      · apply Continuous.intervalIntegrable
        fun_prop
    _ = _ := by simp; ring

/-- Closed form of the one-sided ramp Fourier integral at nonzero frequency. -/
theorem ramp_fourier (b : ℝ) {ξ : ℝ} (hξ : ξ ≠ 0) :
    (∫ x in (0:ℝ)..b, (x:ℂ)*Complex.exp (Complex.I*(ξ:ℂ)*x)) =
      (Complex.exp (Complex.I*(ξ:ℂ)*b)*(1-Complex.I*((b*ξ:ℝ):ℂ))-1)/(ξ:ℂ)^2 := by
  have hc : (ξ:ℂ) ≠ 0 := by exact_mod_cast hξ
  rw [ramp_exp_integral b (mul_ne_zero Complex.I_ne_zero hc), mul_pow, Complex.I_sq]
  push_cast
  ring

/-- The actual integral has a one-derivative lower bound away from the origin. -/
theorem ramp_fourier_bound (b : ℝ) {ξ : ℝ} (hξ : ξ ≠ 0) :
    b^2/(1+Real.sqrt (1+(b*ξ)^2)) ≤
      ‖∫ x in (0:ℝ)..b, (x:ℂ)*Complex.exp (Complex.I*(ξ:ℂ)*x)‖ := by
  rw [ramp_fourier b hξ, norm_div, norm_pow, Complex.norm_real, Real.norm_eq_abs, sq_abs]
  apply ramp_multiplier_lower hξ
  rw [show Complex.I*(ξ:ℂ)*(b:ℂ)=((b*ξ:ℝ):ℂ)*Complex.I by push_cast; ring]
  exact Complex.norm_exp_ofReal_mul_I _

/-- The zero-frequency value is the area of the ramp. -/
theorem ramp_fourier_zero (b : ℝ) :
    (∫ x in (0:ℝ)..b, (x:ℂ)*Complex.exp (Complex.I*(0:ℂ)*x)) = ((b^2/2:ℝ):ℂ) := by
  simp only [mul_zero, zero_mul, Complex.exp_zero, mul_one]
  rw [intervalIntegral.integral_ofReal (f := fun x : ℝ => x), integral_id]
  norm_num

/-- No real frequency annihilates a ramp of positive length. -/
theorem ramp_fourier_ne_zero {b : ℝ} (hb : 0 < b) (ξ : ℝ) :
    (∫ x in (0:ℝ)..b, (x:ℂ)*Complex.exp (Complex.I*(ξ:ℂ)*x)) ≠ 0 := by
  by_cases hξ : ξ = 0
  · subst ξ
    rw [Complex.ofReal_zero, ramp_fourier_zero]
    exact_mod_cast (by positivity : (b^2/2:ℝ) ≠ 0)
  · apply norm_pos_iff.mp
    exact lt_of_lt_of_le (by positivity) (ramp_fourier_bound b hξ)

/-- Division by a smooth nonvanishing multiplier preserves compactly supported tests. -/
theorem smooth_test_division {m g : ℝ → ℂ} (hm : ContDiff ℝ ⊤ m)
    (hne : ∀ x, m x ≠ 0) (hg : ContDiff ℝ ⊤ g) (hs : HasCompactSupport g) :
    ∃ φ : ℝ → ℂ, ContDiff ℝ ⊤ φ ∧ HasCompactSupport φ ∧ (fun x => m x * φ x) = g := by
  refine ⟨g * (fun x => (m x)⁻¹), hg.mul (hm.inv hne), hs.mul_right, ?_⟩
  funext x
  change m x * (g x * (m x)⁻¹) = g x
  calc
    m x * (g x * (m x)⁻¹) = g x * (m x * (m x)⁻¹) := by ring
    _ = g x := by simp [hne x]

/-- A frequency functional annihilating the multiplied tests vanishes on every test. -/
theorem multiplier_test_uniqueness {m : ℝ → ℂ} (hm : ContDiff ℝ ⊤ m)
    (hne : ∀ x, m x ≠ 0) (F : (ℝ → ℂ) → ℂ)
    (ann : ∀ φ, ContDiff ℝ ⊤ φ → HasCompactSupport φ → F (fun x => m x * φ x) = 0)
    {g : ℝ → ℂ} (hg : ContDiff ℝ ⊤ g) (hs : HasCompactSupport g) : F g = 0 := by
  obtain ⟨φ, hφ, hcompact, rfl⟩ := smooth_test_division hm hne hg hs
  exact ann φ hφ hcompact

end PrimeSigns
