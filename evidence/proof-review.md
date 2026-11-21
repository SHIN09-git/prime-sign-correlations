# Proof and numerical review

This is an author-side review of the preprint by GPT-6.2 Astra and JIN HANZHE. It identifies what each check establishes and the mathematical questions left open.

| Issue | Resolution in the paper |
| --- | --- |
| Prime power in a *linear* zero statistic | Landau's formula already has this property. Ford and Zaharescu discuss it explicitly in Eq. (1.1) of their 2005 paper. Suzuki's integrated explicit formula is another predecessor. The target here is the joint positivity probability of two arithmetic windows. |
| Relation to joint short-interval results | Leung's Theorem 3.1 controls normalized centers up to a power of the inverse width. A second center at a fixed non-unit ratio is of order the entire inverse width. The absolute width of the second window scales with its own center. |
| Frequencies and multiplicities | The zero trace counts a zero of multiplicity $m$ with weight $m$. The corresponding time covariance groups equal frequencies before it squares the weights, producing $m^2$. Section 4 retains this difference and states the exact simplicity criterion. |
| Convergence and passage to an indicator | A Gaussian majorant on a unit time interval and the local zero count bound control partial dyadic blocks in mean square, uniformly in the translate. Passage to a quadrant uses an atomless marginal supplied by one independent phase. |
| Exceptional ordinates | Orthogonality gives a second moment for the exceptional part, with squared multiplicities. Independence of the good block, the centered exceptional vector and a uniform Gaussian Hessian bound make the effect quadratic in the exceptional amplitude. The rational independence property is assumed. |
| Sign and normalization | The atom in the trace has negative sign. A positive prime weight lowers the two-excess probability at its central lag. Inversion applies the negative sine before calibration at 2. At the edge of the window the atom has zero weight. |
| Uniformity in the integer argument | For $n\le 1/(4h)$ each matching window isolates one integer. The smooth trace is $O(h^2\sqrt n)$. The denominator of the calibrated ratio stays positive and the propagated density error is $O(\sqrt N\log(1/h)\eta)$. |
| Order of limits | Infinite-base averaging is performed at fixed width before shrinking the width. No finite averaging rate or simultaneous-limit assertion follows from the torus equidistribution argument here. |

## Independent numerical checks

* **Canonical spectral kernel (paper §7).** The prime calculation encloses the smooth integral by monotonicity on each side of the tent and enumerates all arithmetic atoms in support. The zero calculation uses a separate summation and an explicit tail bound of less than 0.000954. The independent 192-bit run repeats all root-bracket endpoint signs, the zero count, and doubles the quadrature mesh. Both computations resolve the same sign in each of nine cases.
* **Observed prime counts (paper §8).** A sieve enumerates every prime power used on the two base ranges. An integer event grid locates every count jump. Clipping each cell at its two excess thresholds and integrating with Arb gives enclosures of the finite frequencies. Independent evaluations of the two counts at regularly spaced cell midpoints check the incremental update. The six enclosures are each at most one unit in the ninth decimal place wide.
* **Interpretation.** Ratio 6 has zero limiting first-order coefficient under the independence hypothesis, yet its measured finite frequency crosses one quarter between the two ranges. A computed finite canonical covariance, an actual finite sign frequency, and an asymptotic coefficient are three different quantities.

## Formal coverage and remaining questions

The fixed-ratio limiting implication, the triangle profile, ratio stability and both thresholds have Lean proofs. The explicit formula, orbit closure and multivariate probability estimate are analytic arguments in the manuscript. Their application to the actual zeros in the sign theorem uses the stated extra hypothesis. Obtaining the sign law from the Riemann theorem alone or proving a joint finite-height and shrinking-width estimate would materially strengthen the result. There has been no independent journal review of this preprint.
