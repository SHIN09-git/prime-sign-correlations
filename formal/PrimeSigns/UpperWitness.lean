import PrimeSigns.Upper
import Mathlib.Data.Nat.Prime.Basic

namespace PrimeSigns

/-- The image coordinates distinguish both signs of the pair, including a double hit. -/
def upperWitnessImages : List ℕ := [
  476381, 476467, 476599, 476887, 477221, 477293, 477677, 477727, 477797, 477941,
  478157, 478879, 478901, 478937, 479081, 479201, 479239, 479419, 479441, 479839,
  480427, 480461, 480463, 480881, 480919, 481001, 481003, 481147, 481387, 481433,
  481577, 481639, 481673, 481721, 482179, 482213, 482323, 482441, 482683, 482827,
  482837, 482947, 483163, 483221, 483619, 483727, 483761, 483773, 483907, 484027,
  484061, 484123, 484207, 484493, 484733, 484853, 484987, 484999, 485383, 485717,
  485777, 486103, 486139, 486247, 486281, 486293, 486583, 486713, 486943, 486977,
  487183, 487219, 487397, 487757, 487793, 487843, 488057, 488119, 488153, 488227,
  488239, 488407, 488633, 488743, 488779, 489053, 489101, 489161, 489197, 489283,
  489823, 490001, 490003, 490207, 490241, 490421, 490493, 491081, 491083, 491213,
  491297, 491299, 491719, 491837, 492017, 492053, 492077, 492403, 492979, 493027,
  493133, 493159, 493243, 493301, 493313, 493447, 493567, 493807, 494093, 494107,
  494167, 494237, 494359, 494743, 494899, 494959, 495041, 495043, 495401, 495679,
  495713, 495797, 495799, 496193, 496339, 496579, 496687, 496877, 497297, 497417,
  497479, 497633, 498053, 498461, 498557, 499063, 499327, 499361, 499363, 499397,
  499459, 499601, 499637, 500299, 500333, 500393, 500443, 500501, 500587, 500693,
  500861, 501223, 501341, 501343, 501367, 501701, 501703, 502133, 502301, 502421,
  503213, 503599, 504103, 504353, 504403, 504727, 504787, 504821, 504857, 505073,
  505327, 505339, 505481, 505877, 506083, 506263, 506333, 506347, 506743, 506887,
  506993, 507137, 507139, 507197, 507917, 507919, 507953, 508037, 508567, 508867,
  508961, 509227, 509477, 509513, 509681, 509767, 509801, 509863, 509947, 510127,
  510617, 510619, 511193, 511279, 511337, 511457, 511997, 512167, 512287, 512467,
  512573, 512683, 512717, 512921, 513101, 513103, 513137, 513427, 513641, 513727,
  513761, 514001, 514013, 514147, 514219, 514399, 514757, 514903, 515587, 515597,
  515993, 516161, 516163, 516499, 516679, 516701, 516821, 517073, 517183, 517207,
  517457, 517459, 517577, 517613, 517721, 517747, 518047, 518717, 518767, 518801,
  518803, 518863, 519521, 519523, 520063, 520313, 520699, 521021, 521023, 521107,
  521167, 521537, 521539, 521707, 521753, 521813, 521887, 522079, 522497, 523519,
  523541, 523543, 523759, 523793, 523877, 523903, 523937, 524599, 524947, 525101,
  525137, 525247, 525353, 525533, 525677, 525739, 525773, 525893, 526027, 526073,
  526459, 526601, 526759, 526781, 526997, 527753, 528041, 528043, 528223, 528413,
  528559, 529421, 529423, 529807, 529927, 529961, 530021, 530539, 531079, 531281,
  531547, 531857, 531977, 532001]

def upperWitnessEvent (m : ℕ) : Prop :=
  let n := (m+3)/6
  79360 < n ∧ n ≤ 88704 ∧ Nat.Prime n ∧ Nat.Prime m ∧ (m+1 = 6*n ∨ m = 6*n+1)

private def noSmallDivisor (n : ℕ) : Bool :=
  (List.range 729).all fun j => n % (j+2) != 0

private theorem prime_of_trial {n : ℕ} (hn : 2 ≤ n) (hu : n < 731*731)
    (htrial : noSmallDivisor n = true) : Nat.Prime n := by
  refine Nat.prime_def_le_sqrt.2 ⟨hn, ?_⟩
  intro d hd hs hdiv
  have hlt : n.sqrt < 731 := Nat.sqrt_lt.2 hu
  have hmem : d-2 ∈ List.range 729 := List.mem_range.2 (by omega)
  have hrem := (List.all_eq_true.1 htrial) (d-2) hmem
  have heq : d-2+2 = d := by omega
  simp [heq, Nat.mod_eq_zero_of_dvd hdiv] at hrem

private def checkImage (m : ℕ) : Bool :=
  let n := (m+3)/6
  decide (79360 < n ∧ n ≤ 88704 ∧ 2 ≤ m ∧ m < 731*731 ∧ (m+1 = 6*n ∨ m = 6*n+1))
    && noSmallDivisor n && noSmallDivisor m

private theorem event_of_check {m : ℕ} (h : checkImage m = true) : upperWitnessEvent m := by
  simp only [checkImage, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨⟨hc, hd, hlo, hhi, himage⟩, h1⟩, h2⟩ := h
  exact ⟨hc, hd, prime_of_trial (by omega) (by omega) h1,
    prime_of_trial hlo hhi h2, himage⟩

set_option maxRecDepth 30000 in
set_option maxHeartbeats 10000000 in
/-- A concrete 324-event cell checked by integer trial division in the kernel. -/
theorem concrete_upper_prime_witnesses :
    upperWitnessImages.length = 324 ∧ upperWitnessImages.Pairwise (· < ·) ∧
      ∀ m ∈ upperWitnessImages, upperWitnessEvent m := by
  have facts : upperWitnessImages.length = 324 ∧ upperWitnessImages.Pairwise (· < ·) ∧
      upperWitnessImages.all checkImage = true := by decide
  exact ⟨facts.1, facts.2.1, fun m hm => event_of_check (List.all_eq_true.1 facts.2.2 m hm)⟩

set_option maxRecDepth 30000 in
/-- The weighted witnesses strictly exceed the ratio-4 threshold for the entire cell. -/
theorem concrete_upper_weight :
    (upperWitnessImages.map (fun m => 3*((m+3)/6-79360)-1)).sum = 4272462 ∧
      3*93760*15 < (upperWitnessImages.map (fun m => 3*((m+3)/6-79360)-1)).sum := by
  decide

end PrimeSigns
