import PrimeSigns.Detection
import Mathlib.Analysis.Normed.Group.Basic
import Mathlib.Data.Real.Sqrt
import Mathlib.Topology.Order.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

open Filter Real
open scoped Topology

namespace PrimeSigns

/-- The two integer candidates of the affine construction must coincide. -/
theorem affine_integer_lock {m n : ℤ} {u : ℝ}
    (ha : |(m:ℝ)-u| < 1/2) (hb : |u-(n:ℝ)| < 1/2) : m = n := by
  have h1 := abs_lt.mp ha
  have h2 := abs_lt.mp hb
  have l : (m:ℝ) < (n:ℝ)+1 := by linarith
  have r : (n:ℝ) < (m:ℝ)+1 := by linarith
  have l' : m < n+1 := by exact_mod_cast l
  have r' : n < m+1 := by exact_mod_cast r
  omega

/-- At an exactly aligned integer dilation both members have the same prime base. -/
theorem prime_power_alignment {q n : ℕ} (hq : 2 ≤ q) (hn : 2 ≤ n) :
    IsPrimePow (q*n) ↔ ∃ p j k : ℕ, p.Prime ∧ 0 < j ∧ 0 < k ∧ q=p^j ∧ n=p^k := by
  constructor
  · intro h
    obtain ⟨p,l,hp,_,he⟩ := (isPrimePow_nat_iff _).1 h
    have hq' : q ∣ p^l := by rw [he]; exact dvd_mul_right _ _
    have hn' : n ∣ p^l := by rw [he]; exact dvd_mul_left _ _
    obtain ⟨j,_,hj⟩ := (Nat.dvd_prime_pow hp).1 hq'
    obtain ⟨k,_,hk⟩ := (Nat.dvd_prime_pow hp).1 hn'
    have hj' : j ≠ 0 := by rintro rfl; simp at hj; omega
    have hk' : k ≠ 0 := by rintro rfl; simp at hk; omega
    exact ⟨p,j,k,hp,by omega,by omega,hj,hk⟩
  · rintro ⟨p,j,k,hp,hj,_,rfl,rfl⟩
    exact (isPrimePow_nat_iff _).2 ⟨p,j+k,hp,by omega,pow_add _ _ _⟩

theorem six_never_aligns (n : ℕ) : ¬ IsPrimePow (6*n) := by
  intro h
  obtain ⟨p,_,unique⟩ := isPrimePow_iff_unique_prime_dvd.mp h
  have dd : 6 ∣ 6*n := dvd_mul_right _ _
  have a := unique 2 ⟨Nat.prime_two, dvd_trans (by decide : 2 ∣ 6) dd⟩
  have b := unique 3 ⟨Nat.prime_three, dvd_trans (by decide : 3 ∣ 6) dd⟩
  omega

theorem overlap_length (h v : ℝ) :
    min 0 v - max (-h) (v-h) = h-|v| := by
  by_cases hv : 0 ≤ v
  · rw [min_eq_left hv, max_eq_right (by linarith), abs_of_nonneg hv]
    ring
  · have h' := le_of_not_ge hv
    rw [min_eq_right h', max_eq_left (by linarith), abs_of_nonpos h']
    ring

theorem upper_neighbour_opens {M n : ℝ} (hM : 0<M) (hn : 0<n) :
    1+1/(6*n) < 1+1/(6*M) ↔ M<n := by
  rw [add_lt_add_iff_left, div_lt_div_iff₀ (by linarith) (by linarith)]
  constructor <;> intro h <;> linarith

theorem lower_neighbour_opens {M n : ℝ} (hM : 0<M) (hn : 1 < 6*n) :
    1/(1-1/(6*n)) < 1+1/(6*M) ↔ M+1/6<n := by
  have h6n : 0 < 6*n := by linarith
  have h6m : 0 < 6*M := by linarith
  have hn' : n ≠ 0 := by linarith
  have hM' := ne_of_gt hM
  have nonzero : 6*n-1 ≠ 0 := by linarith
  have lhs : 1/(1-1/(6*n)) = (6*n)/(6*n-1) := by
    field_simp
  have rhs : 1+1/(6*M) = (6*M+1)/(6*M) := by
    field_simp
  rw [lhs,rhs,div_lt_div_iff₀ (by linarith) h6m]
  constructor <;> intro h <;> nlinarith

/-- Stability of inversion for a contraction, used for the weighted counting operator. -/
theorem contraction_error {E : Type*} [SeminormedAddCommGroup E] {T : E → E}
    {rho : ℝ} (hr : rho<1) (bound : ∀ v, ‖T v‖ ≤ rho*‖v‖) (v : E) :
    ‖v‖ ≤ ‖v-T v‖/(1-rho) := by
  apply (le_div_iff₀ (sub_pos.mpr hr)).2
  have ht : ‖v‖ ≤ ‖v-T v‖+‖T v‖ := by
    simpa using norm_add_le (v-T v) (T v)
  nlinarith [bound v]

theorem profile_positive_iff {S d z : ℝ} (hS : 0<S) (hz : 0≤z) :
    0 < d-S*z^2/2 ↔ z < sqrt (2*d/S) := by
  rw [Real.lt_sqrt hz, lt_div_iff₀ hS]
  constructor <;> intro h <;> nlinarith

/-- Transfer strict signs on both sides of the limiting zero to the first-passage location. -/
theorem first_passage_limit {ι : Type*} {f : Filter ι} (M H B : ι → ℝ) {r : ℝ}
    (hr : 0<r) (hH : ∀ᶠ i in f, 0<H i)
    (left : ∀ z, 0<z → z<r → ∀ᶠ i in f, M i+z*H i ≤ B i)
    (right : ∀ z, r<z → ∀ᶠ i in f, B i ≤ M i+z*H i) :
    Tendsto (fun i => (B i-M i)/H i) f (𝓝 r) := by
  apply tendsto_order.2
  constructor
  · intro u hu
    obtain ⟨v,hv,hv'⟩ := exists_between (max_lt hu hr)
    filter_upwards [left v ((le_max_right u 0).trans_lt hv) hv', hH] with i h hi
    apply (lt_div_iff₀ hi).2
    have := mul_lt_mul_of_pos_right ((le_max_left u 0).trans_lt hv) hi
    linarith
  · intro u hu
    obtain ⟨v,hv,hv'⟩ := exists_between hu
    filter_upwards [right v hv, hH] with i h hi
    apply (div_lt_iff₀ hi).2
    have := mul_lt_mul_of_pos_right hv' hi
    linarith

end PrimeSigns
