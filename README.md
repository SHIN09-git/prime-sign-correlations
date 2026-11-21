# Recovering prime powers from sign correlations in short intervals

**GPT-6.2 Astra · JIN HANZHE**  
Research preprint · 22 November 2026

[English paper](paper-english.pdf) · [中文论文](paper-chinese.pdf) · [Lean proofs](formal/README.md) · [Proof and numerical review](evidence/proof-review.md)

Take two short intervals with left endpoints $x$ and $qx$, where $q>1$. In each, record a single bit indicating whether the von Mangoldt count exceeds the interval length. Can the frequency of two simultaneous excesses distinguish $q=4$ from $q=6$?

Let $d_h(a)$ denote that frequency averaged in $\log x$ at fixed log width $h$ and log separation $a$. For fixed $q>1$, under the independence and exceptional-energy condition in §2, we obtain

$$
\lim_{h\downarrow0} 2\pi\log(1/h)
\left(\frac14-d_h(\log q+\tau h)\right)
=\frac{\lambda(q)}{\sqrt q}\max(1-|\tau|,0).
$$

Here $\lambda(p^k)=\log p$ for a prime $p$ and integer $k\ge1$, and $\lambda(q)=0$ at every other real $q>1$. The positive ordinates may include an exceptional set with rational relations and multiplicities. Its weighted square-multiplicity energy must be $o(h)$. Full linear independence of the positive ordinates, counted with multiplicity, suffices. The logarithmic averaging length tends to infinity before $h$ tends to zero.

| Quantity | Result | Where |
| --- | --- | --- |
| Canonical spectral covariance | Exact trace in terms of prime powers, using the Riemann theorem and the classical explicit formula | §§3–4 |
| Actual arithmetic covariance | Explicit correction for multiple zeros. At lag zero, equality with the canonical variance at any one width is equivalent to simplicity of all zeros | §4 |
| Joint sign probability | Prime-power coefficient and its triangular displacement profile under the zero hypothesis | §§1, 5–6 |
| Arithmetic inversion | Calibration at 2 recovers $\Lambda(n)$ uniformly on a growing integer range, with a quantitative stability bound | §§2, 6 |
| Finite observations | Enclosed values of the measured joint sign frequency on two finite base ranges, obtained by sieving prime powers and integrating on every count cell | §8 |

At zero lag put $`b=e^h`$. On the critical line, the Mellin transform $`H_b`$ of the ordinary-prime window satisfies $`\lvert H_b(1/2+i\gamma)\rvert=\sqrt{b}\,\lvert b_h(\gamma)\rvert^2`$. Summing over the nontrivial zeros with multiplicity gives the canonical variance $`V_h=L_b/\sqrt{b}`$. For $`1\lt b\le2`$ the formula becomes

$$
V_h=(b+1)\log(b+1)-(b-1)\log(b-1)+2(b-1)\log b-2b\log 2-(b-1)(\gamma_E+\log\pi).
$$

The finite-width expression comes from [Crossley’s prime-window formula](https://doi.org/10.5281/zenodo.24416358). Expanding at $h=0$ gives $c_0=1-\gamma_E-\log(2\pi)$ in §4, where $\gamma_E$ is Euler’s constant. Leung gives this coefficient in [Proposition 2.2](https://arxiv.org/html/2401.04000#S2.Ex9).

**中文摘要**　两个短区间的左端点相差一个倍率。只记每个窗口中的加权素数计数有没有超过区间长度，两个窗口同时超额的极限频率便包含这个倍率的算术信息。在文中给出的零点独立性和例外集条件下，倍率 2、4 的首项分别携带 $`\log 2/\sqrt{2}`$、 $`(\log 2)/2`$，倍率 6 的首项为零。以 2 为参照可以在增长区间上一致恢复冯·曼戈尔特函数。正文给出有限高度的实际计数，展示有限观测与有序极限的差别。

## Reproduce the computations

Use Python 3.12 and install the pinned Arb binding. The first computation compares the prime-side integral with a sum over all 22,491 positive zeros below 20,000 plus a rigorous tail bound. It downloads the upstream zero brackets at a fixed commit and checks their SHA-256 digest. Supply a local copy with the optional argument documented by the script. The finite-frequency computation uses only a prime-power sieve.

~~~sh
python -m pip install -r replication/requirements.txt
python replication/certify.py --json covariance.json
python replication/certify.py --bits 192 --cells 1024 --verify-brackets --json independent-check.json
python replication/finite_signs.py --json finite-signs.json
~~~

Compare the outputs with [the evidence files](evidence). Interval endpoints in those JSON files are integers scaled by $10^9$. The high-precision spectral run reevaluates 44,984 Hardy $Z$ endpoint signs, including a bracket above the truncation. The separate finite-height experiment evaluates actual simultaneous excesses. At ratio 6 the two observed frequencies are 0.254054 and 0.226125 for the successive base ranges.

## Rebuild the paper and proofs

The PDFs were built with Typst 0.15.2, Libertinus Serif and SimSun for Chinese. The optional Typst input named cjk selects a different installed Chinese font. The figure is included in vector form. Its optional regeneration uses Matplotlib 3.10.8 and NumPy 2.5.5.

~~~sh
typst compile --root paper paper/english.typ paper-english.pdf
typst compile --root paper paper/chinese.typ paper-chinese.pdf
python replication/plot_trace.py paper/trace.svg
~~~

The Lean package pins Lean 4.24.0 and Mathlib. Its formal statements, build commands and boundary with the analytic proof appear in the [formalization guide](formal/README.md). The preprint, source and recorded verification outputs are covered by [SHA256SUMS](SHA256SUMS). On systems with GNU coreutils, run the following from the repository root.

~~~sh
sha256sum -c SHA256SUMS
~~~
