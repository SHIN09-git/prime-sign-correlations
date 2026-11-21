# Lean verification

This project uses Lean 4.24.0 and Mathlib revision f897ebcf72cd16f89ab4577d0c826cd14afaafc7. The root module imports all five mathematical modules. Run from this directory with Elan and Git available.

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

The arguments of fixed_lag_inverse give the isolated-trace relation, the negligible smooth term, the limiting variance scale, the vanishing correlation, and the scaled Gaussian comparison. Its conclusion is the coefficient in Theorem 1 at each fixed displacement. The manuscript proves these input statements for the arithmetic process, the uniformity in bounded displacements, and the growing-range estimate. The Lean package treats the analytic inputs as hypotheses of this implication. It does not import an axiom about zeta zeros.

The checked declarations and the output of Lean’s axiom inspection are recorded in [lean-audit.txt](../evidence/lean-audit.txt). A replay of the compiled project modules against their imports is recorded in [lean-replay.txt](../evidence/lean-replay.txt). The replay uses the Lean 4.24-compatible executable from [lean4checker revision da26eb0](https://github.com/leanprover/lean4checker/tree/da26eb05e9959402afcb9bd6dfe5dc4f700f70d6). With its executable on the path, run the following from this directory.

~~~sh
lake env lean4checker --verbose PrimeSigns
~~~
