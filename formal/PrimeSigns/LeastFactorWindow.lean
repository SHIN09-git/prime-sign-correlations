import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Algebra.Field.ZMod
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith

/-! Least-factor decompositions, local sieve densities, and the window averaging argument. -/
namespace PrimeSigns.LeastFactorWindow

def Rough (z n : ℕ) : Prop := ∀ p : ℕ, p.Prime → p ∣ n → z < p

theorem rough_mul_iff (z m n : ℕ) : Rough z (m*n) ↔ Rough z m ∧ Rough z n := by
  constructor
  · intro h
    exact ⟨fun p hp hd => h p hp (dvd_mul_of_dvd_left hd n),
      fun p hp hd => h p hp (dvd_mul_of_dvd_right hd m)⟩
  · rintro ⟨hm, hn⟩ p hp hd
    exact (hp.dvd_mul.mp hd).elim (hm p hp) (hn p hp)

/-- A rough composite has a canonical small prime factor and a rough cofactor. -/
theorem composite_witness {z m : ℕ} (hm : 1 < m) (hc : ¬m.Prime) (hr : Rough z m) :
    ∃ r s : ℕ, r.Prime ∧ z < r ∧ r ≤ s ∧ r^2 ≤ m ∧ r*s = m ∧ Rough z s := by
  let r := m.minFac
  let s := m / r
  have hp : r.Prime := Nat.minFac_prime (by omega)
  have hd : r ∣ m := Nat.minFac_dvd m
  have heq : r*s = m := Nat.mul_div_cancel' hd
  have hmul : Rough z (r*s) := heq.symm ▸ hr
  exact ⟨r, s, hp, hr r hp hd, Nat.minFac_le_div (by omega) hc,
    Nat.minFac_sq_le_self (by omega) hc, heq, ((rough_mul_iff z r s).mp hmul).2⟩

/-- Both signed polynomials reduce over a prime field to two product fibers. -/
theorem polynomial_roots {K : Type*} [Field K] {u v : K} (hu : u ≠ 0) (x y : K) :
    (x*y)*(u*(x*y)+v) = 0 ↔ x*y = 0 ∨ x*y = -v/u := by
  rw [mul_eq_zero, eq_div_iff hu]
  constructor
  · rintro (h|h)
    · exact Or.inl h
    · right
      rw [mul_comm (x*y) u]
      exact eq_neg_of_add_eq_zero_left h
  · rintro (h|h)
    · exact Or.inl h
    · right
      rw [mul_comm u (x*y), h, neg_add_cancel]

theorem bad_fiber_card {K : Type*} [Field K] [Fintype K] [DecidableEq K]
    {c : K} (hc : c ≠ 0) (x : K) :
    (Finset.univ.filter (fun y : K => x*y=0 ∨ x*y=c)).card =
      if x=0 then Fintype.card K else 2 := by
  by_cases hx : x=0
  · simp [hx]
  · rw [if_neg hx]
    have hdiv (y : K) : x*y=c ↔ y=c/x := by rw [eq_div_iff hx, mul_comm x y]
    have eq : Finset.univ.filter (fun y : K => x*y=0 ∨ x*y=c) = {0,c/x} := by
      ext y
      simp [mul_eq_zero, hx, hdiv y]
    rw [eq, Finset.card_pair (Ne.symm (div_ne_zero hc hx))]

theorem bad_residue_count {K : Type*} [Field K] [Fintype K] [DecidableEq K]
    {c : K} (hc : c ≠ 0) :
    (∑ x : K, (Finset.univ.filter (fun y : K => x*y=0 ∨ x*y=c)).card) =
      3 * Fintype.card K - 2 := by
  simp_rw [bad_fiber_card hc]
  rw [← Finset.sum_erase_add _ _ (Finset.mem_univ (0 : K))]
  have hf : (∑ x ∈ Finset.univ.erase (0 : K), if x=0 then Fintype.card K else 2)
      = ∑ _x ∈ Finset.univ.erase (0 : K), (2 : ℕ) := by
    apply Finset.sum_congr rfl
    intro x hx
    exact if_neg (Finset.ne_of_mem_erase hx)
  rw [hf]
  simp only [ite_true, Finset.sum_const, Finset.card_erase_of_mem (Finset.mem_univ _),
    Finset.card_univ, nsmul_eq_mul]
  have hpos : 0 < Fintype.card K := Fintype.card_pos
  change (Fintype.card K - 1) * 2 + Fintype.card K = 3 * Fintype.card K - 2
  omega

/-- Local dimension three for every prime greater than three and either orientation. -/
theorem polynomial_residue_count (q : ℕ) [Fact q.Prime] {u v : ZMod q}
    (hu : u ≠ 0) (hv : v ≠ 0) :
    (∑ x : ZMod q, (Finset.univ.filter
      (fun y : ZMod q => (x*y)*(u*(x*y)+v) = 0)).card) = 3*q-2 := by
  simp_rw [polynomial_roots (K := ZMod q) hu]
  simpa only [ZMod.card] using
    (bad_residue_count (K := ZMod q) (div_ne_zero (neg_ne_zero.mpr hv) hu))

open MeasureTheory Set

/-- Every point contributes an interval of length h to the count in (x, x+h]. -/
theorem window_occupation {ι : Type*} (t : Finset ι) (v : ι → ℝ) {h : ℝ} (hh : 0 ≤ h) :
    (∫ x : ℝ, ∑ i ∈ t, (Ico (v i-h) (v i)).indicator (1 : ℝ → ℝ) x) = (t.card : ℝ)*h := by
  have hf (i : ι) : Integrable ((Ico (v i-h) (v i)).indicator (1 : ℝ → ℝ)) volume := by
    apply (integrable_indicator_iff measurableSet_Ico).2
    exact integrableOn_const measure_Ico_lt_top.ne
  rw [integral_finset_sum t (fun i _ => hf i)]
  simp only [integral_indicator_one measurableSet_Ico, Real.volume_real_Ico, sub_sub_cancel,
    max_eq_left hh, Finset.sum_const, nsmul_eq_mul]

/-- A lower bound for the mean and a pointwise upper bound control the measure of good starts. -/
theorem mean_forces_good_starts {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsFiniteMeasure μ] {f : α → ℝ} (hf : Integrable f μ) {c C : ℝ} (hc : 0 ≤ c)
    (hm : MeasurableSet {x | c ≤ f x}) (hbound : ∀ x, f x ≤ C) :
    (∫ x, f x ∂μ) - c * μ.real univ ≤ C * μ.real {x | c ≤ f x} := by
  let E := {x | c ≤ f x}
  have hi : Integrable (E.indicator (fun _ : α => C)) μ := (integrable_const C).indicator hm
  have hmaj (x : α) : f x ≤ c + E.indicator (fun _ : α => C) x := by
    by_cases hx : x ∈ E
    · rw [Set.indicator_of_mem hx]
      linarith [hbound x]
    · rw [Set.indicator_of_notMem hx]
      have hlt : f x < c := lt_of_not_ge hx
      linarith
  have h := integral_mono hf ((integrable_const c).add hi) hmaj
  change (∫ x, f x ∂μ) ≤ ∫ x, c + E.indicator (fun _ : α => C) x ∂μ at h
  rw [integral_add (integrable_const c) hi, integral_const, integral_indicator_const C hm] at h
  simp only [smul_eq_mul] at h
  change (∫ x, f x ∂μ) - c * μ.real univ ≤ C * μ.real E
  linarith [h]

end PrimeSigns.LeastFactorWindow
