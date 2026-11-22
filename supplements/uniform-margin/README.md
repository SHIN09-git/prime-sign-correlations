# The unresolved margin for affine prime pairs

**GPT-6.2 Astra and JIN HANZHE**

Research supplement to the [third edition](https://github.com/SHIN09-git/prime-sign-correlations/tree/d62b69ce93b4b84372d731a57f56e03177558342), 22 November 2026.

[English PDF](english.pdf) · [中文 PDF](chinese.pdf) · [Divisor and margin proofs](../../formal/PrimeSigns/Margin.lean) · [Factor-count proofs](../../formal/PrimeSigns/FactorProfile.lean)

Let $H=\sqrt X(\log X)^{3/2}$. The all-height first-reversal upper bound would follow from a fixed positive lower bound for the normalized mass of pairs $p,6p\pm1$ with both entries prime in each sufficiently large critical interval. That positive lower bound remains open.

| Part | Result and scope |
| --- | --- |
| §§1–3 | An exact Möbius expansion and Poisson summation isolate a real remainder after removing small divisor products and either small divisor. The main term is $8C_2\int w^2$. The estimates use the ordinary and Dirichlet critical-line theorems. |
| §4 | The Bettin–Chandee bound controls genuine balanced blocks with divisor size $P\ge\sqrt X$ and frequency $T\le P^\gamma$ for $0<\gamma<1/27$. The total in this range is $o(1)$. The natural band $P\asymp\sqrt X$, $T\asymp P^2/H$ extends beyond that estimate. |
| §5 | At every sufficiently large starting point, for each sign there are $\gg H/(\log X\log\log X)$ actual primes $p$ whose partner has no prime factor below $(\log X)^\theta$ for fixed $0<\theta<1/4$. The missing fraction of genuinely prime partners, pooling the signs and using the paper's smooth weights, has threshold order $(\log\log X)/\log X$. |
| §§6–7 | A single deterministic set of marks on true primes erases every prime edge, maintains the stated one-point estimates, and attains exact limiting cancellation on the complementary arcs. Its Euler exponents are modified. This tests the information used by that method. |
| §8 | The two-dimensional weighted sieve gives, for each sign, order $H/(\log X)^2$ squarefree products with at most seven prime factors, all exceeding $X^{1/400}$. The paper checks the translated interval, level, size and large-square errors needed to use the published sieve table. |
| §§9–10 | Six factor counts cover the candidates. Two positive evaluations cancel the three-factor class exactly. Six real evaluations or three real Fourier terms recover the true-pair fraction. A global Liouville estimate is compared with the required local scale. |
| §11 | On all rough pairs, including squareful values and every factor count, write $A_X(u)$ for the weighted two-point correlation of $u^{\Omega}$ with small primes removed. A uniform prime-pair lower bound is equivalent to $\limsup_X A_X(2t)/A_X(t)<8$ for some fixed window weight and $0<t\le1/3$. |
| §12 | For each fixed weight the iterated limit, taking the upper limit in height first and then sending $t$ down to zero, is exactly $2^r$. Here $r$ is the first factor count reached with uniform positive mass. There are six possible limits, from 4 through 128 in powers of two. |

## Verification

The [Lean source](../../formal/PrimeSigns/Margin.lean) uses the genuine Mathlib von Mangoldt and Möbius functions. Run with the parent project's pinned Lean 4.24.0 and Mathlib v4.24.0, from the repository root.

```sh
cd formal
lake exe cache get
lake build PrimeSigns.Margin PrimeSigns.FactorProfile
lake env lean ../supplements/uniform-margin/Audit.lean
```

The [axiom audit](Audit.lean) names 21 public declarations across both modules. The first module checks the finite divisor expansions, compatibility of the two moduli, exclusion on neighboring vertices, the exponent inequalities and the original numerator–denominator comparison. The factor-count module checks the prime-pair characterization using Mathlib's prime-factor count, the finite filters, the error bound for every factor count, multiplicativity on positive integers, and the strict threshold eight in the ratio. There are no placeholders in the module. The axiom report contains only `propext`, `Classical.choice` and `Quot.sound`. Its final two declarations prove the moment inequalities and the quantified upper and lower bounds for the limiting ratio from the stated mass hypotheses. To replay the kernels with a matching [lean4checker](https://github.com/leanprover/lean4checker), run one command per module.

```sh
lake env lean4checker --verbose PrimeSigns.Margin
lake env lean4checker --verbose PrimeSigns.FactorProfile
```

The analytic sieve applications, square-divisor removal, trilinear estimates, concentration and Euler-product arguments are paper proofs. Section 8 uses [Booker and Browning, §3 and Table 1](https://arxiv.org/abs/1511.00601). The analytic mass hypotheses needed to select the value four in §12 remain unproved.

Two independent finite checks can be run from the repository root.

```sh
python supplements/uniform-margin/check_crt.py
python supplements/uniform-margin/check_factor_profile.py
```

The [CRT check](check_crt.py) enumerates the progression and density formulas. The [factor-count check](check_factor_profile.py) compares segmented factorization with a separate interval primality sieve, and evaluates the identities using exact rational arithmetic on both signs. At integer starting points 65,536, 1,048,576 and 16,777,216, over respective lengths 9,400, 52,800 and 278,000, it finds 367, 1,311 and 4,842 true pairs, counting the two signs separately. It checks both the paper's rough cutoff at these heights and the fixed comparison cutoff removing 2, 3, 5 and 7. These samples use interval indicators.

The two papers are compiled from [English](english.typ) and [Chinese](chinese.typ) sources with [shared equations](equations.typ) and the parent paper's layout. With Typst 0.15.2 installed, run from the repository root:

```sh
typst compile --root . supplements/uniform-margin/english.typ
typst compile --root . supplements/uniform-margin/chinese.typ
```

The Chinese PDF uses SimSun. The document source also accepts the parent layout's `cjk` font input.
