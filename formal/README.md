# Lean verification

This project uses Lean 4.24.0 and Mathlib revision f897ebcf72cd16f89ab4577d0c826cd14afaafc7. The root module imports all seven mathematical modules. Run from this directory with Elan and Git available.

~~~sh
lake exe cache get
lake build
lake env lean Audit.lean
~~~

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

The arguments of fixed_lag_inverse give the isolated-trace relation, the negligible smooth term, the limiting variance scale, the vanishing correlation, and the scaled Gaussian comparison. Its conclusion is the coefficient in Theorem 1 at each fixed displacement. The manuscript proves these input statements for the arithmetic process, the uniformity in bounded displacements, and the growing-range estimate. The Lean package treats the analytic inputs as hypotheses of this implication.

The first-passage module proves the two geometric opening conditions and the order-limit transfer from bounds on both sides of a proposed root. The ramp module evaluates the complex Fourier integral of the actual one-sided kernel, including its value at zero, proves a quantitative modulus bound and deduces that the integral vanishes at no real frequency. The Selberg sieve, the passage to measures, uniqueness of convolution, and the finite-time probability estimates are written proofs in the paper. The audit covers 35 named theorems. The observed axioms are the standard propext, Classical.choice and Quot.sound.

The checked declarations and the output of Lean’s axiom inspection are recorded in [lean-audit.txt](../evidence/lean-audit.txt). A replay of the compiled project modules against their imports is recorded in [lean-replay.txt](../evidence/lean-replay.txt). The replay uses the Lean 4.24-compatible executable from [lean4checker revision da26eb0](https://github.com/leanprover/lean4checker/tree/da26eb05e9959402afcb9bd6dfe5dc4f700f70d6). With its executable on the path, run the following from this directory.

~~~sh
lake env lean4checker --verbose PrimeSigns
~~~
