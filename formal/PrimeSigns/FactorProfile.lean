import Mathlib.Data.Real.Basic
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-! Finite factor-count reductions for the two affine prime-pair windows. -/
namespace PrimeSigns.FactorProfile
open ArithmeticFunction

theorem two_factors_iff {m n : ℕ} (hm : 1 < m) (hn : 1 < n) :
    cardFactors (m * n) = 2 ↔ m.Prime ∧ n.Prime := by
  have h₁ := cardFactors_pos_iff_one_lt.mpr hm
  have h₂ := cardFactors_pos_iff_one_lt.mpr hn
  rw [cardFactors_mul (by omega : m ≠ 0) (by omega : n ≠ 0),
    ← cardFactors_eq_one_iff_prime, ← cardFactors_eq_one_iff_prime]
  omega

theorem excess_mod_six {m n : ℕ} (hm : 1 < m) (hn : 1 < n)
    (h : cardFactors (m * n) ≤ 7) :
    (cardFactors (m * n) - 2) % 6 = 0 ↔ m.Prime ∧ n.Prime := by
  rw [← two_factors_iff hm hn]
  have h₁ := cardFactors_pos_iff_one_lt.mpr hm
  have h₂ := cardFactors_pos_iff_one_lt.mpr hn
  have hmul := cardFactors_mul (by omega : m ≠ 0) (by omega : n ≠ 0)
  omega

/-- The masses in the six classes of excess prime factors, from zero to five. -/
noncomputable def profile (a : Fin 6 → ℝ) (t : ℝ) : ℝ :=
  a 0 + a 1 * t + a 2 * t ^ 2 + a 3 * t ^ 3 + a 4 * t ^ 4 + a 5 * t ^ 5

theorem recover_six_values (a : Fin 6 → ℝ) :
    a 0 = 6 * profile a (1/6) - 15 * profile a (1/3) + 20 * profile a (1/2)
      - 15 * profile a (2/3) + 6 * profile a (5/6) - profile a 1 := by
  unfold profile
  ring


theorem tail_bound_all (t : ℝ) (h₀ : 0 ≤ t) (h₁ : t ≤ 1/3)
    (j : ℕ) (hj : 2 ≤ j) :
    0 ≤ (2 ^ j - 2 : ℝ) * t ^ j ∧ (2 ^ j - 2 : ℝ) * t ^ j ≤ 2 * t ^ 2 := by
  induction j, hj using Nat.le_induction with
  | base => norm_num; positivity
  | succ j hj ih =>
    have four : (4 : ℝ) ≤ 2 ^ j := by
      calc
        (4 : ℝ) = 2 ^ (2 : ℕ) := by norm_num
        _ ≤ 2 ^ j := pow_le_pow_right₀ (by norm_num) hj
    have pos : 0 ≤ (2 : ℝ) ^ (j+1) - 2 := by rw [pow_succ]; linarith
    have step : ((2 : ℝ)^(j+1)-2)*t ≤ 2^j-2 := by
      calc
        _ ≤ ((2 : ℝ)^(j+1)-2)*(1/3) := mul_le_mul_of_nonneg_left h₁ pos
        _ ≤ 2^j-2 := by rw [pow_succ]; linarith
    constructor
    · exact mul_nonneg pos (pow_nonneg h₀ _)
    · calc
        _ = (((2 : ℝ)^(j+1)-2)*t)*t^j := by rw [pow_succ t]; ring
        _ ≤ ((2 : ℝ)^j-2)*t^j := mul_le_mul_of_nonneg_right step (pow_nonneg h₀ _)
        _ ≤ _ := ih.2

/-- All excess counts are allowed. A three-factor pair has excess one. -/
theorem monomial_error (t : ℝ) (h₀ : 0 ≤ t) (h₁ : t ≤ 1/3) (k : ℕ) :
    0 ≤ (if k = 0 then 1 else 0 : ℝ) - (2*t^k - (2*t)^k) ∧
    (if k = 0 then 1 else 0 : ℝ) - (2*t^k - (2*t)^k) ≤ 2*t^2 := by
  cases k with
  | zero => norm_num; nlinarith [sq_nonneg t]
  | succ k =>
    cases k with
    | zero => norm_num; nlinarith [sq_nonneg t]
    | succ k =>
      simp only [Nat.succ_ne_zero, if_false, mul_pow]
      have ident : (0:ℝ) - (2*t^(k+2) - 2^(k+2)*t^(k+2)) =
        ((2:ℝ)^(k+2)-2)*t^(k+2) := by ring
      rw [ident]
      exact tail_bound_all t h₀ h₁ (k+2) (by omega)

noncomputable def siftWeight (q n : ℕ) (u : ℝ) : ℝ :=
  if n.Coprime q then u ^ cardFactors n else 0

theorem siftWeight_mul (q m n : ℕ) (hm : m ≠ 0) (hn : n ≠ 0) (u : ℝ) :
    siftWeight q (m*n) u = siftWeight q m u * siftWeight q n u := by
  by_cases h : (m*n).Coprime q
  · obtain ⟨h₁, h₂⟩ := Nat.coprime_mul_iff_left.mp h
    simp only [siftWeight, if_pos h, if_pos h₁, if_pos h₂, cardFactors_mul hm hn, pow_add]
  · by_cases h₁ : m.Coprime q
    · have h₂ : ¬ n.Coprime q := fun hnq => h (Nat.coprime_mul_iff_left.mpr ⟨h₁, hnq⟩)
      simp only [siftWeight, if_neg h, if_neg h₂, mul_zero]
    · simp only [siftWeight, if_neg h, if_neg h₁, zero_mul]

theorem ratio_below_eight (a b t : ℝ) (ha : 0 < a) (ht : 0 < t) :
    0 < (2*a - b/4)/t^2 ↔ b/a < 8 := by
  rw [lt_div_iff₀ (sq_pos_of_pos ht), div_lt_iff₀ ha]
  constructor <;> intro h <;> linarith

theorem two_values_error (a : Fin 6 → ℝ) (ha : ∀ i, 0 ≤ a i)
    (t : ℝ) (h₀ : 0 ≤ t) (h₁ : t ≤ 1/3) :
    0 ≤ a 0 - (2 * profile a t - profile a (2*t)) ∧
    a 0 - (2 * profile a t - profile a (2*t)) ≤
      2*t^2 * (profile a 1 - a 0) := by
  have b (j : Fin 6) (hj : 2 ≤ j.val) :
      0 ≤ a j * ((2^j.val - 2 : ℝ) * t^j.val) ∧
      a j * ((2^j.val - 2 : ℝ) * t^j.val) ≤ a j * (2*t^2) := by
    obtain ⟨hpos, hle⟩ := tail_bound_all t h₀ h₁ j.val hj
    exact ⟨mul_nonneg (ha j) hpos, mul_le_mul_of_nonneg_left hle (ha j)⟩
  obtain ⟨p₂, q₂⟩ := b 2 (by decide)
  obtain ⟨p₃, q₃⟩ := b 3 (by decide)
  obtain ⟨p₄, q₄⟩ := b 4 (by decide)
  obtain ⟨p₅, q₅⟩ := b 5 (by decide)
  have p₁ : 0 ≤ a 1 * (2*t^2) := mul_nonneg (ha 1) (by positivity)
  norm_num at p₂ q₂ p₃ q₃ p₄ q₄ p₅ q₅
  unfold profile
  constructor <;> linarith only [p₁, p₂, q₂, p₃, q₃, p₄, q₄, p₅, q₅]

/-- The three real nonconstant Fourier terms of the sixth-roots filter. -/
theorem three_mode_filter (a : Fin 6 → ℝ) :
    6 * a 0 = profile a 1
      + (2*a 0 + a 1 - a 2 - 2*a 3 - a 4 + a 5)
      + (2*a 0 - a 1 - a 2 + 2*a 3 - a 4 - a 5)
      + (a 0 - a 1 + a 2 - a 3 + a 4 - a 5) := by
  unfold profile
  ring


/-- A moment of a finite factor-count distribution, before normalization. -/
noncomputable def moment (s : Finset ℕ) (w : ℕ → ℝ) (t : ℝ) : ℝ := ∑ k ∈ s, w k * t^k

noncomputable def massBelow (s : Finset ℕ) (w : ℕ → ℝ) (r : ℕ) : ℝ :=
  ∑ k ∈ s, if k < r then w k else 0

/-- The three finite-sum inequalities behind the limiting doubling ratio. -/
theorem moment_bounds (s : Finset ℕ) (w : ℕ → ℝ) (hw : ∀ k, 0 ≤ w k)
    (r : ℕ) (t : ℝ) (ht : 0 ≤ t) (hu : 2*t ≤ 1) :
    t^r * massBelow s w (r+1) ≤ moment s w t ∧
    moment s w (2*t) ≤ 2^r * moment s w t + (2*t)^(r+1) * ∑ k ∈ s, w k ∧
    (2:ℝ)^r * (moment s w t - massBelow s w r) ≤ moment s w (2*t) := by
  have ht1 : t ≤ 1 := by linarith
  have ht2 : 0 ≤ 2*t := by positivity
  constructor
  · unfold massBelow moment
    rw [Finset.mul_sum]
    apply Finset.sum_le_sum
    intro k _
    by_cases hk : k < r+1
    · rw [if_pos hk, mul_comm]
      exact mul_le_mul_of_nonneg_left (pow_le_pow_of_le_one ht ht1 (by omega)) (hw k)
    · rw [if_neg hk, mul_zero]
      exact mul_nonneg (hw k) (pow_nonneg ht k)
  constructor
  · unfold moment
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
    apply Finset.sum_le_sum
    intro k _
    by_cases hk : k ≤ r
    · have hpow : (2:ℝ)^k ≤ 2^r := pow_le_pow_right₀ (by norm_num) hk
      rw [mul_pow]
      have h := mul_le_mul_of_nonneg_right hpow (mul_nonneg (hw k) (pow_nonneg ht k))
      have hpos := mul_nonneg (pow_nonneg ht2 (r+1)) (hw k)
      linarith only [h, hpos]
    · have hpow := pow_le_pow_of_le_one ht2 hu (show r+1 ≤ k by omega)
      have h := mul_le_mul_of_nonneg_left hpow (hw k)
      have hpos := mul_nonneg (show (0:ℝ) ≤ 2^r by positivity)
        (mul_nonneg (hw k) (pow_nonneg ht k))
      linarith only [h, hpos]
  · unfold moment massBelow
    rw [← Finset.sum_sub_distrib, Finset.mul_sum]
    apply Finset.sum_le_sum
    intro k _
    by_cases hk : k < r
    · rw [if_pos hk]
      have hpow : t^k ≤ 1 := pow_le_one₀ ht ht1
      have hlow : w k * t^k ≤ w k := by simpa using mul_le_mul_of_nonneg_left hpow (hw k)
      exact (mul_nonpos_of_nonneg_of_nonpos (by positivity) (sub_nonpos.mpr hlow)).trans
        (mul_nonneg (hw k) (pow_nonneg ht2 k))
    · rw [if_neg hk, sub_zero, mul_pow]
      have hpow : (2:ℝ)^r ≤ 2^k := pow_le_pow_right₀ (by norm_num) (by omega)
      have h := mul_le_mul_of_nonneg_right hpow (mul_nonneg (hw k) (pow_nonneg ht k))
      linarith only [h]

/-- Quantified upper and lower envelopes for the limsup in the starting height.
The two mass hypotheses are the eventual lower bound at the first ubiquitous
factor count and arbitrarily small mass below it at arbitrarily large heights. -/
theorem threshold_envelope (s : Finset ℕ) (w : ℝ → ℕ → ℝ) (r : ℕ) (c x₀ : ℝ)
    (hc : 0 < c) (hw : ∀ x k, 0 ≤ w x k) (hunit : ∀ x, ∑ k ∈ s, w x k = 1)
    (hlarge : ∀ x ≥ x₀, c ≤ massBelow s (w x) (r+1))
    (hsmall : ∀ R η : ℝ, 0 < η → ∃ x ≥ R, massBelow s (w x) r < η)
    (t : ℝ) (ht : 0 < t) (hu : 2*t ≤ 1) :
    (∀ x ≥ x₀, moment s (w x) (2*t) / moment s (w x) t ≤
      (2:ℝ)^r + 2^(r+1)*t/c) ∧
    (∀ R ε : ℝ, 0 < ε → ∃ x ≥ R, (2:ℝ)^r - ε ≤
      moment s (w x) (2*t) / moment s (w x) t) := by
  have low (x : ℝ) (hx : x₀ ≤ x) : c*t^r ≤ moment s (w x) t := by
    calc
      c*t^r ≤ massBelow s (w x) (r+1)*t^r :=
        mul_le_mul_of_nonneg_right (hlarge x hx) (pow_nonneg ht.le _)
      _ = _ := mul_comm _ _
      _ ≤ _ := (moment_bounds s (w x) (hw x) r t ht.le hu).1
  have dc : 0 < c*t^r := mul_pos hc (pow_pos ht _)
  constructor
  · intro x hx
    have h := (moment_bounds s (w x) (hw x) r t ht.le hu).2.1
    rw [hunit, mul_one] at h
    apply (div_le_iff₀ (dc.trans_le (low x hx))).mpr
    have scale := mul_le_mul_of_nonneg_left (low x hx)
      (show 0 ≤ (2:ℝ)^(r+1)*t/c by positivity)
    have ident : ((2:ℝ)^(r+1)*t/c)*(c*t^r) = (2*t)^(r+1) := by
      rw [mul_pow, pow_succ t]; field_simp
    rw [ident] at scale
    linarith only [h, scale]
  · intro R ε hε
    have htwo : (0:ℝ) < 2^r := by positivity
    obtain ⟨x, hx, hmass⟩ := hsmall (max R x₀) (ε*(c*t^r)/2^r) (by positivity)
    have hx₀ : x₀ ≤ x := (le_max_right _ _).trans hx
    refine ⟨x, (le_max_left _ _).trans hx, (le_div_iff₀ (dc.trans_le (low x hx₀))).mpr ?_⟩
    have herr := (lt_div_iff₀ htwo).mp hmass
    have herr' := mul_le_mul_of_nonneg_left (low x hx₀) hε.le
    have h := (moment_bounds s (w x) (hw x) r t ht.le hu).2.2
    linarith only [herr, herr', h]

end PrimeSigns.FactorProfile
