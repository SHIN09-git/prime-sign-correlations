import PrimeSigns.Limits

open Filter Real
open scoped Topology
namespace PrimeSigns

/-- The Gaussian quadrant comparison transfers a scaled covariance to the sign density. -/
theorem gaussian_quadrant_limit {ι : Type*} {f : Filter ι} {L ρ p : ι → ℝ} {m : ℝ}
    (hr : Tendsto ρ f (𝓝 0))
    (hs : Tendsto (fun j => L j * ρ j) f (𝓝 (-m)))
    (he : Tendsto (fun j => L j * (p j - (1/4 + arcsin (ρ j)/(2*π)))) f (𝓝 0)) :
    Tendsto (fun j => 2*π*L j*(1/4-p j)) f (𝓝 m) := by
  have hu : Tendsto (fun j => arcsin (ρ j)) f (𝓝 0) := by
    simpa [Function.comp_def] using (continuous_arcsin.tendsto (0 : ℝ)).comp hr
  have hq : Tendsto (fun j => sinc (arcsin (ρ j))) f (𝓝 1) := by
    simpa [Function.comp_def] using (continuous_sinc.tendsto (0 : ℝ)).comp hu
  have hn : (1 : ℝ) ≠ 0 := one_ne_zero
  have hd := hs.div hq hn
  rw [div_one] at hd
  have ha : Tendsto (fun j => L j * arcsin (ρ j)) f (𝓝 (-m)) := by
    apply hd.congr'
    have low := hr.eventually_const_lt (show (-1 : ℝ) < 0 by norm_num)
    have high := hr.eventually_lt_const (show (0 : ℝ) < 1 by norm_num)
    filter_upwards [hq.eventually_ne hn, low, high] with j hj hlo hhi
    apply (div_eq_iff hj).2
    have id : sinc (arcsin (ρ j)) * arcsin (ρ j) = ρ j := by
      calc
        sinc (arcsin (ρ j)) * arcsin (ρ j) = sin (arcsin (ρ j)) := by
          by_cases z : arcsin (ρ j) = 0
          · simp [z]
          · rw [sinc_of_ne_zero z, div_mul_cancel₀ _ z]
        _ = ρ j := sin_arcsin hlo.le hhi.le
    calc
      L j * ρ j = L j * (sinc (arcsin (ρ j)) * arcsin (ρ j)) := congrArg (L j * ·) id.symm
      _ = _ := by ring
  have hout := (he.const_mul (-(2*π))).sub ha
  rw [mul_zero, zero_sub, neg_neg] at hout
  apply hout.congr'
  apply Eventually.of_forall
  intro j
  change -(2*π) * (L j * (p j - (1/4 + arcsin (ρ j)/(2*π)))) -
    L j * arcsin (ρ j) = _
  field_simp [Real.pi_ne_zero]
  ring

/-- Assemble the fixed-ratio sign asymptotic from the isolated trace, the variance
    scale and the quantitative Gaussian comparison proved in the paper. -/
theorem fixed_lag_inverse (q τ weight : ℝ) (K V B d : ℝ → ℝ)
    (trace : ∀ᶠ h in 𝓝[>] 0, K h = B h - weight/sqrt q * window h (τ*h))
    (smooth : Tendsto (fun h => B h/h) (𝓝[>] 0) (𝓝 0))
    (variance : Tendsto (fun h => h * log (1/h) / V h) (𝓝[>] 0) (𝓝 1))
    (small : Tendsto (fun h => K h/V h) (𝓝[>] 0) (𝓝 0))
    (comparison : Tendsto
      (fun h => log (1/h) * (d h - (1/4 + arcsin (K h/V h)/(2*π)))) (𝓝[>] 0) (𝓝 0)) :
    Tendsto (fun h => 2*π*log (1/h)*(1/4-d h)) (𝓝[>] 0)
      (𝓝 (weight/sqrt q * max (1-|τ|) 0)) := by
  apply gaussian_quadrant_limit small _ comparison
  have profile := (window_profile τ).const_mul (weight/sqrt q)
  have scaled := variance.mul (smooth.sub profile)
  rw [one_mul, zero_sub] at scaled
  apply scaled.congr'
  filter_upwards [trace, self_mem_nhdsWithin] with h hh hp
  have hpos : 0 < h := hp
  change h * log (1/h) / V h * (B h/h - weight/sqrt q * (window h (τ*h)/h)) =
    log (1/h) * (K h/V h)
  rw [hh]
  by_cases hv : V h = 0
  · simp [hv]
  · field_simp [hpos.ne', hv]

end PrimeSigns
