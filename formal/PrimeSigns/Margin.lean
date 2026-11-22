import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace PrimeSigns.Margin

open ArithmeticFunction

/-- The signed logarithmic coefficient in the exact divisor expansion of Λ. -/
noncomputable def coeff (d : ℕ) : ℝ := -((moebius d : ℝ) * ArithmeticFunction.log d)

theorem sum_coeff (n : ℕ) :
    ∑ d ∈ n.divisors, coeff d = vonMangoldt n := by
  simp only [coeff, Finset.sum_neg_distrib, sum_moebius_mul_log_eq, neg_neg]

theorem pair_expansion (n m : ℕ) :
    vonMangoldt n * vonMangoldt m =
      ∑ d ∈ n.divisors, ∑ v ∈ m.divisors, coeff d * coeff v := by
  simp only [← Finset.mul_sum, ← Finset.sum_mul, sum_coeff]

theorem two_signs_expansion (n : ℕ) :
    vonMangoldt n * (vonMangoldt (6*n-1) + vonMangoldt (6*n+1)) =
      (∑ d ∈ n.divisors, ∑ v ∈ (6*n-1).divisors, coeff d * coeff v) +
      (∑ d ∈ n.divisors, ∑ v ∈ (6*n+1).divisors, coeff d * coeff v) := by
  rw [mul_add, pair_expansion n (6*n-1), pair_expansion n (6*n+1)]

theorem compatible_plus {d v n : ℕ} (hd : d ∣ n) (hv : v ∣ 6*n+1) :
    v.Coprime (6*d) := by
  apply Nat.Coprime.of_dvd hv (Nat.mul_dvd_mul_left 6 hd)
  exact Nat.coprime_self_add_left.mpr (Nat.coprime_one_left _)

theorem compatible_minus {d v n : ℕ} (hn : 0 < n) (hd : d ∣ n) (hv : v ∣ 6*n-1) :
    v.Coprime (6*d) := by
  apply Nat.Coprime.of_dvd hv (Nat.mul_dvd_mul_left 6 hd)
  exact (Nat.coprime_self_sub_left (by omega : 1 ≤ 6*n)).mpr (Nat.coprime_one_left _)

/-- A vertex is retained when its label is strictly below each neighbor's. -/
def retained {V : Type*} (adj : V → V → Prop) (label : V → ℝ) (v : V) : Prop :=
  ∀ u, adj v u → label v < label u

theorem label_exclusion {V : Type*} {adj : V → V → Prop} (hs : Symmetric adj)
    {label : V → ℝ} {u v : V} (huv : adj u v) :
    ¬ (retained adj label u ∧ retained adj label v) := by
  rintro ⟨hu, hv⟩
  exact (lt_asymm (hu v huv)) (hv u (hs huv))

theorem marked_edge_zero {V : Type*} {adj : V → V → Prop} (hs : Symmetric adj)
    (label mass : V → ℝ) {u v : V} (huv : adj u v)
    [DecidablePred (retained adj label)] :
    (if retained adj label u then mass u else 0) *
      (if retained adj label v then mass v else 0) = 0 := by
  by_cases h : retained adj label u
  · have h' : ¬ retained adj label v := fun hv => label_exclusion hs huv ⟨h, hv⟩
    simp [h']
  · simp [h]

/-- Positive power savings after the square root of the perturbation factor. -/
theorem savings_perturbed {γ : ℝ} (h : γ < 1/27) :
    0 < 1/20 - 27*γ/20 ∧ 0 < 1/8 - 3*γ/2 := by
  constructor <;> linarith

theorem savings_bounded_phase {γ : ℝ} (h : γ < 1/17) :
    0 < 1/20 - 17*γ/20 ∧ 0 < 1/8 - γ := by
  constructor <;> linarith

open Filter

/-- When the rough-candidate mass is comparable to A, the required lower bound
for a prime-pair numerator is equivalent to a lower bound for its share of the
candidates. An arbitrary filter allows exceptional bounded starting heights. -/
theorem uniform_fraction_criterion {ι : Type*} (F : Filter ι)
    (A D N r : ι → ℝ) {lo hi : ℝ} (hlo : 0 < lo) (hhi : 0 < hi)
    (hden : ∀ᶠ x in F, 0 < A x ∧ 0 ≤ r x ∧ lo * A x ≤ D x ∧ D x ≤ hi * A x) :
    (∃ c : ℝ, 0 < c ∧ ∀ᶠ x in F, c * (r x * A x) ≤ N x) ↔
    (∃ c : ℝ, 0 < c ∧ ∀ᶠ x in F, c * r x ≤ N x / D x) := by
  constructor
  · rintro ⟨c, hc, hN⟩
    refine ⟨c / hi, div_pos hc hhi, ?_⟩
    filter_upwards [hden, hN] with x hx hpair
    obtain ⟨hA, hr, hleft, hright⟩ := hx
    apply (le_div_iff₀ ((mul_pos hlo hA).trans_le hleft)).2
    calc
      (c / hi * r x) * D x ≤ (c / hi * r x) * (hi * A x) :=
        mul_le_mul_of_nonneg_left hright (mul_nonneg (div_pos hc hhi).le hr)
      _ = c * (r x * A x) := by field_simp
      _ ≤ N x := hpair
  · rintro ⟨c, hc, hN⟩
    refine ⟨c * lo, mul_pos hc hlo, ?_⟩
    filter_upwards [hden, hN] with x hx hfrac
    obtain ⟨hA, hr, hleft, _⟩ := hx
    calc
      c * lo * (r x * A x) = (c * r x) * (lo * A x) := by ring
      _ ≤ (c * r x) * D x := mul_le_mul_of_nonneg_left hleft (mul_nonneg hc.le hr)
      _ ≤ N x := (le_div_iff₀ ((mul_pos hlo hA).trans_le hleft)).1 hfrac

end PrimeSigns.Margin
