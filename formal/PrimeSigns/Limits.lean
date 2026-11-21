import PrimeSigns.Window
import PrimeSigns.Calibration
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Sinc
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Slope

open Filter Real
open scoped Topology
namespace PrimeSigns

/-- Rescaling the exact window by its width produces the triangular line profile. -/
theorem window_profile (τ : ℝ) :
    Tendsto (fun h : ℝ => window h (τ*h)/h) (𝓝[>] 0) (𝓝 (max (1-|τ|) 0)) := by
  have hid : Tendsto (fun h : ℝ => h) (𝓝[>] 0) (𝓝 0) := nhdsWithin_le_nhds
  by_cases ht : |τ| ≤ 1
  · rw [max_eq_left (sub_nonneg.mpr ht)]
    have hd : HasDerivAt (fun x : ℝ => exp ((1-|τ|)*x)) (1-|τ|) 0 := by
      simpa using (((hasDerivAt_id (0 : ℝ)).const_mul (1-|τ|)).exp)
    have hs : Tendsto (fun h : ℝ => (exp ((1-|τ|)*h)-1)/h)
        (𝓝[>] 0) (𝓝 (1-|τ|)) := by
      simpa [smul_eq_mul, div_eq_inv_mul] using hd.tendsto_slope_zero_right
    have hc : Tendsto (fun h : ℝ => exp (|τ| *h/2)) (𝓝[>] 0) (𝓝 1) := by
      have scaled : Tendsto (fun h : ℝ => |τ| * h / 2) (𝓝[>] 0) (𝓝 0) := by
        simpa using ((hid.const_mul |τ|).div_const 2)
      simpa using scaled.rexp
    have prod := hc.mul hs
    rw [one_mul] at prod
    apply prod.congr'
    filter_upwards [self_mem_nhdsWithin] with h hh
    have hp : 0 < h := hh
    have hab : |τ*h| = |τ| *h := by rw [abs_mul, abs_of_pos hp]
    have inside : |τ*h| ≤ h := by
      rw [hab]; simpa using mul_le_mul_of_nonneg_right ht hp.le
    unfold window
    rw [if_pos inside, hab]
    rw [sub_mul, one_mul]
    ring
  · rw [max_eq_right (sub_nonpos.mpr (le_of_not_ge ht))]
    apply tendsto_const_nhds.congr'
    filter_upwards [self_mem_nhdsWithin] with h hh
    have hp : 0 < h := hh
    have outside : h < |τ*h| := by
      rw [abs_mul, abs_of_pos hp]
      simpa using mul_lt_mul_of_pos_right (lt_of_not_ge ht) hp
    simp [window_outside outside]

/-- Transfer a calibrated sine signal to the leading deviation of the quadrant density. -/
theorem sign_first_order {ι : Type*} {f : Filter ι} {p L : ι → ℝ} {m : ℝ}
    (hp : Tendsto p f (𝓝 (1/4 : ℝ)))
    (hs : Tendsto (fun j => L j * signal (p j)) f (𝓝 m)) :
    Tendsto (fun j => 2*π*L j*(1/4-p j)) f (𝓝 m) := by
  let u : ι → ℝ := fun j => 2*π*(p j-1/4)
  have hu : Tendsto u f (𝓝 0) := by
    simpa [u] using (hp.sub_const (1/4 : ℝ)).const_mul (2*π)
  have hq : Tendsto (fun j => sinc (u j)) f (𝓝 1) := by
    simpa [Function.comp_def] using (continuous_sinc.tendsto (0 : ℝ)).comp hu
  have hn : (1 : ℝ) ≠ 0 := one_ne_zero
  have hdiv := hs.div hq hn
  rw [div_one] at hdiv
  apply hdiv.congr'
  filter_upwards [hq.eventually_ne hn] with j hj
  change L j * signal (p j) / sinc (u j) = _
  apply (div_eq_iff hj).2
  have trig : sinc (u j) * u j = sin (u j) := by
    by_cases z : u j = 0
    · simp [z]
    · rw [sinc_of_ne_zero z, div_mul_cancel₀ _ z]
  change L j * -sin (u j) = _
  rw [← trig]
  dsimp [u]
  ring

end PrimeSigns
