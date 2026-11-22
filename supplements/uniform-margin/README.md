# The unresolved margin for affine prime pairs

**GPT-6.2 Astra and JIN HANZHE**

Research supplement to the [third edition](https://github.com/SHIN09-git/prime-sign-correlations/tree/d62b69ce93b4b84372d731a57f56e03177558342), 22 November 2026.

[English PDF](english.pdf) · [中文 PDF](chinese.pdf) · [Lean module](../../formal/PrimeSigns/Margin.lean)

Let $H=\sqrt X(\log X)^{3/2}$. The all-height first-reversal upper bound would follow from a fixed positive lower bound for the normalized mass of pairs $p,6p\pm1$ with both entries prime in each sufficiently large critical interval. That positive lower bound remains open.

| Part | Result and scope |
| --- | --- |
| §§1–3 | An exact Möbius expansion and Poisson summation isolate a real remainder after removing small divisor products and either small divisor. The main term is $8C_2\int w^2$. The estimates use the ordinary and Dirichlet critical-line theorems. |
| §4 | The Bettin–Chandee bound controls genuine balanced blocks with divisor size $P\ge\sqrt X$ and frequency $T\le P^\gamma$ for $0<\gamma<1/27$. The total in this range is $o(1)$. The natural band $P\asymp\sqrt X$, $T\asymp P^2/H$ extends beyond that estimate. |
| §5 | At every sufficiently large starting point, for each sign there are $\gg H/(\log X\log\log X)$ actual primes $p$ whose partner has no prime factor below $(\log X)^\theta$ for fixed $0<\theta<1/4$. The missing fraction of genuinely prime partners, pooling the signs and using the paper's smooth weights, has threshold order $(\log\log X)/\log X$. |
| §§6–7 | A single deterministic set of marks on true primes erases every prime edge, maintains the stated one-point estimates, and attains exact limiting cancellation on the complementary arcs. Its Euler exponents are modified. This tests the information used by that method. |

## Verification

The [Lean source](../../formal/PrimeSigns/Margin.lean) uses the genuine Mathlib von Mangoldt and Möbius functions. Run with the parent project's pinned Lean 4.24.0 and Mathlib v4.24.0, from the repository root.

```sh
cd formal
lake exe cache get
lake build PrimeSigns.Margin
lake env lean ../supplements/uniform-margin/Audit.lean
```

The [axiom audit](Audit.lean) names ten declarations. They prove the finite divisor identities for one and two weights, the coprimality in the two signed branches, exclusion and zero weight on neighboring retained vertices, the two exponent ranges of §4, and the comparison of a uniform numerator bound with a lower bound on its fraction of candidates in §5. The build and a kernel replay of this module passed. The audit uses only `propext`, `Classical.choice` and `Quot.sound`. With the matching [lean4checker](https://github.com/leanprover/lean4checker) installed, run `lake env lean4checker --verbose PrimeSigns.Margin` to replay the module.

The analytic estimates, linear sieve, concentration and Euler-product arguments are paper proofs. To check signs, including modulus one, the [finite independent check](check_crt.py) enumerates integer residue classes and the two prime-pattern densities on five primorials. From the repository root run `python supplements/uniform-margin/check_crt.py`. These finite checks do not certify a lower bound as $X\to\infty$.

The two papers are compiled from [English](english.typ) and [Chinese](chinese.typ) sources with [shared equations](equations.typ) and the parent paper's layout. With Typst 0.15.2 installed, run from the repository root:

```sh
typst compile --root . supplements/uniform-margin/english.typ
typst compile --root . supplements/uniform-margin/chinese.typ
```

The Chinese PDF uses SimSun. The document source also accepts the parent layout's `cjk` font input.
