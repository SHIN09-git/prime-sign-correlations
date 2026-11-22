# Lean verification

This project uses Lean 4.24.0 and Mathlib revision f897ebcf72cd16f89ab4577d0c826cd14afaafc7. On this research branch the root module imports the ten main-paper modules and both uniform-margin supplement modules. Run from this directory with Elan and Git available.

~~~sh
lake exe cache get
lake build
lake env lean Audit.lean
lake env lean ../supplements/uniform-margin/Audit.lean
~~~

The [uniform-margin supplement](../supplements/uniform-margin/README.md) documents its weighted sieve proof and 21 audited declarations. The factor-count module includes the quantified doubling-ratio theorem.

| Paper step | Checked declarations in namespace PrimeSigns |
| --- | --- |
| Autocorrelation of the exponential interval window, support and center value | window_overlap, window_nonneg, window_outside, window_zero, window_edge |
| An isolated atom in a finite trace and the rescaled triangular profile | isolate_atom, window_profile |
| A finite cell with two excesses | two_excess_cell |
| Gaussian inversion and its leading term | exact_sign_inversion, sign_first_order, gaussian_quadrant_limit |
| Fixed-lag theorem from the analytic inputs | fixed_lag_inverse |
| Stability under errors in the two readings | calibration_error |
| Recovery of an actual arithmetic predicate, with Mathlib’s von Mangoldt function | prime_power_gap, detect_prime_power, nonprime_weight_le_half, detect_prime |
| Affine integer locking, prime-power alignment and the excluded multiplier 6 | affine_integer_lock, prime_power_alignment, six_never_aligns |
| Overlap geometry and the two opening thresholds | overlap_length, upper_neighbour_opens, lower_neighbour_opens |
| Stability of contraction inversion and location from two-sided profile bounds | contraction_error, profile_positive_iff, first_passage_limit |
| Noncancellation and quantitative lower bound for the algebraic ramp multiplier | ramp_reverse_triangle, ramp_multiplier_lower |
| Division of smooth compactly supported frequency tests and the resulting uniqueness implication | smooth_test_division, multiplier_test_uniqueness |
| Fourier transform of the ramp as an actual interval integral, including zero frequency and the global nonvanishing theorem | ramp_exp_integral, ramp_fourier, ramp_fourier_bound, ramp_fourier_zero, ramp_fourier_ne_zero |
| Log-width and both image-shift bounds, rational overlap contribution, integer overtake criterion and the quadratic margin | cell_log_width, image_log_shifts, overlap_fraction_lower, integer_weight_overtake, quadratic_upper_margin |
| Alignment of actual integer windows at ratio four, contact from a strict endpoint, and the mean/proportion inequality | four_window_lock, contact_le_of_strict_reading, fraction_of_capped_mean |
| Distinctness, primality and integer weight of 324 explicit pairs in the cell with endpoints 79,296 and 79,360 | concrete_upper_prime_witnesses, concrete_upper_weight |
| Allowed-residue calculation in a finite field and the resulting large-prime local factor | affine_forbidden_classes, degenerate_forbidden_class, prime_pair_local_factor |

The arguments of fixed_lag_inverse give the isolated-trace relation, the negligible smooth term, the limiting variance scale, the vanishing correlation, and the scaled Gaussian comparison. Its conclusion is the coefficient in Theorem 1 at each fixed displacement. The manuscript proves these input statements for the arithmetic process, the uniformity in bounded displacements, and the growing-range estimate. The Lean package treats the analytic inputs as hypotheses of this implication.

The first-passage module proves the two geometric opening conditions and the order-limit transfer from bounds on both sides of a proposed root. The ramp module evaluates the complex Fourier integral of the actual one-sided kernel, including its value at zero, proves a quantitative modulus bound and deduces that the integral vanishes at no real frequency. The Selberg sieve, the passage to measures, uniqueness of convolution, and the finite-time probability estimates are written proofs in the paper. For Theorem 4B, Lean checks inequalities transferring witness weights to strict overtake, together with the actual 324-event list for the worst cell above $2^{16}$. Its primality test proves the standard Mathlib prime predicate by trial division through the square root, using kernel reduction. Integration over disjoint log windows, all 12,581,376 cells and the infinite-height analytic arguments are verified in the paper or by the published integer sieves. The two forbidden residues for a nonzero coefficient, the single forbidden residue for a zero coefficient, and the large-prime Euler factor of Theorem 4D are also checked. The audit covers 48 named theorems. The observed axioms are the standard propext, Classical.choice and Quot.sound.

The checked declarations and the output of Lean’s axiom inspection are recorded in [lean-audit.txt](../evidence/lean-audit.txt). A replay of the compiled project modules against their imports is recorded in [lean-replay.txt](../evidence/lean-replay.txt). The replay uses the Lean 4.24-compatible executable from [lean4checker revision da26eb0](https://github.com/leanprover/lean4checker/tree/da26eb05e9959402afcb9bd6dfe5dc4f700f70d6). With its executable on the path, run the following from this directory.

~~~sh
lake env lean4checker --verbose PrimeSigns
~~~
