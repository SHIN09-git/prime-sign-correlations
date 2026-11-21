import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

open ArithmeticFunction
namespace PrimeSigns

theorem prime_power_gap {n : ℕ} (hn : 2 ≤ n) (hpp : IsPrimePow n) :
    Real.log 2 ≤ vonMangoldt n := by
  rw [vonMangoldt_apply, if_pos hpp]
  apply Real.log_le_log (by norm_num)
  exact_mod_cast (Nat.minFac_prime (by omega : n ≠ 1)).two_le

theorem detect_prime_power {n : ℕ} (hn : 2 ≤ n) {estimate : ℝ}
    (err : |estimate-vonMangoldt n| < Real.log 2/2) :
    Real.log 2/2 < estimate ↔ IsPrimePow n := by
  have he := abs_lt.mp err
  constructor
  · intro h
    by_contra no
    rw [vonMangoldt_eq_zero_iff.mpr no] at he
    linarith
  · intro h
    linarith [prime_power_gap hn h]

/-- A nonprime integer has at most half its logarithm as its prime weight. -/
theorem nonprime_weight_le_half {n : ℕ} (hn : 2 ≤ n) (hp : ¬ n.Prime) :
    vonMangoldt n ≤ Real.log (n : ℝ)/2 := by
  by_cases pp : IsPrimePow n
  · obtain ⟨p, k, hprime, hk, rfl⟩ := (isPrimePow_nat_iff n).mp pp
    have hk2 : 2 ≤ k := by
      by_contra small
      have hone : k = 1 := by omega
      subst k
      exact hp (by simpa using hprime)
    rw [vonMangoldt_apply_pow (by omega : k ≠ 0), vonMangoldt_apply_prime hprime,
      Nat.cast_pow, Real.log_pow]
    have hlog : 0 ≤ Real.log (p : ℝ) := Real.log_nonneg (by exact_mod_cast hprime.one_le)
    have hkR : (2 : ℝ) ≤ k := by exact_mod_cast hk2
    nlinarith [mul_nonneg (sub_nonneg.mpr hkR) hlog]
  · rw [vonMangoldt_eq_zero_iff.mpr pp]
    have one : 1 ≤ (n : ℝ) := by exact_mod_cast (by omega : 1 ≤ n)
    linarith [Real.log_nonneg one]

theorem detect_prime {n : ℕ} (hn : 2 ≤ n) {estimate : ℝ}
    (err : |estimate-vonMangoldt n| < Real.log 2/4) :
    3*Real.log (n : ℝ)/4 < estimate ↔ n.Prime := by
  have he := abs_lt.mp err
  have hlog : Real.log 2 ≤ Real.log (n : ℝ) :=
    Real.log_le_log (by norm_num) (by exact_mod_cast hn)
  constructor
  · intro h
    by_contra no
    linarith [nonprime_weight_le_half hn no]
  · intro h
    rw [vonMangoldt_apply_prime h] at he
    linarith

end PrimeSigns
