# Sign correlations of primes in short intervals and their first reversal

**GPT-6.2 Astra · JIN HANZHE**  
Research preprint, second edition · 22 November 2026

[English paper](paper-english.pdf) · [中文论文](paper-chinese.pdf) · [Lean proofs](formal/README.md) · [Proof review](evidence/proof-review.md) · [Reproduction evidence](evidence)

Choose a relative width $\delta$ and a base point $x$. Assign a window the value 1 if its von Mangoldt count exceeds its length. Compare two copies of that window, one at $x$ and the other at $qx$. Starting from 3, how far must one observe before the mass of simultaneous excesses at $q=6$ first catches up with the mass at $q=4$?

## First contact

Write $C_q(B)$ for the accumulated joint mass with measure $dx/x$ from 3 to $B$. Let $B_*$ be the first $B\ge4$ with $C_6(B)\ge C_4(B)$, using $+\infty$ for an empty contact set. Put $M=1/(6\delta)$ and $H_M=\sqrt M(\log M)^{3/2}$. Up to $M$ the only aligned contributions at ratio 4 come from powers of 2, and ratio 6 has none. Beyond $M$ the first possible ratio-6 partners of $n$ are $6n-1$ and $6n+1$.

| Result | Arithmetic input | Paper |
| --- | --- | --- |
| The normalized overshoot $(B_*-M)/H_M$ has lower limit at least $1/\sqrt{16S\log 2}\approx0.130664$. | Unconditional upper-bound sieve | §§9–11 |
| Its limit over all real $M$ equals $\sqrt{2/(S\log 2)}\approx0.739149$ if and only if the signed prime pairs have density $S$ on each interval $(M,M+vH_M]$ after normalization. | Equivalence proved in both directions. The local prime-pair law remains open. | §§11–12 |
| The same first-contact equivalence holds in probability over starting heights. At one fixed scaled distance, the mean signed reading has its predicted limit if and only if the global signed prime-pair count has its predicted asymptotic. | Unconditional equivalences for typical starting points and for averages | §12, Theorem 4A |
| A uniform $O(H_M)$ upper bound for the overshoot is equivalent to a local lower bound at the predicted order and forces $\gg X/(\log X)^2$ prime pairs globally. | Unconditional implication | §11 |
| A single shrinking-window schedule recovers the asymptotic for any fixed tuple of nonproportional integer affine forms containing $n$. With the second ratio $2+1/X$ it recovers the Sophie Germain prime asymptotic. | Unconditional equivalence for each proposed limiting constant | §§13–14 |
| A finite-band estimate controls the measured sign in a long observation interval. Under effective linear independence and simple zeros it applies with $h=(\log Y)^{-\beta}$ for each $0<\beta<1$. | Explicit near-relation error in the general inequality | §§15–17 |

Here $S=8C_2$, where $C_2=\prod_{p>2}(1-1/(p-1)^2)$. The equivalences also hold for the infimum of the strictly overtaking heights. The local count adds the two prime-pair signs and counts a prime twice when both partners are prime. In the converse, moving the initial height shows that every possible limiting density has the same convolution with $v\,\mathbf{1}_{[0,b]}(v)$. That kernel has a nowhere-zero Fourier transform, which determines the density uniquely.

![Certified cumulative lead and first passage compared with the short-interval prime-pair prediction](paper/passage.svg)

At $M=2^{36}$ the first contact is between **68,744,114,238.83330279 and 68,744,114,238.83330280**. The 195,443rd overlap erases the lead of ratio 4. All seven large-height observations have normalized overshoot between 0.75037 and 0.75901. Two sieve implementations reproduce the event sequences and rational endpoints. These data measure a finite deviation from the proposed limit.

## The long-time coefficient

The first edition studied the limiting sign density $d_h(a)$ for a fixed logarithmic width $h$ and lag $a$. Under the independence and exceptional-energy condition of §2, each fixed real $q>1$ satisfies

$$
\lim_{h\downarrow0}2\pi\log(1/h)
\left(\tfrac14-d_h(\log q+\tau h)\right)
=\frac{\lambda(q)}{\sqrt q}\max(1-|\tau|,0).
$$

Here $\lambda(p^k)=\log p$ and $\lambda(q)=0$ elsewhere. The exact spectral trace, multiplicity correction, calibration at 2, and uniform recovery of the von Mangoldt function are retained in §§1–7. In the displayed limit the averaging length goes to infinity first. The finite-time bound in §15 supplies a separate simultaneous regime under its stated control of near relations.

**中文摘要**　从 3 开始累加，倍率 4 凭借对齐的 2 的幂先取得领先。倍率 6 最早依靠 $n$ 与 $6n\pm1$ 这样的素数幂配对追赶。本文无条件证明首次追平的延迟下界，并证明其精确常数与相应短区间的素数对渐近律等价。证明逆方向需要从追平位置恢复整段分布。对典型起点同样能做到这一点，在一个固定距离上取平均还能刻画全局素数对律。另取倍率 $2+1/X$，一个联合超额频率就能刻画索菲·热尔曼素数的完整计数渐近式。论文同时给出了密集窗口下的有限时间估计，并说明各结论所需的独立性条件。

## Reproduce the computations

Use Python 3.12 and the pinned Arb binding. The first two commands after installation compare an arithmetic trace with a sum over 22,491 positive zeros below 20,000 and a rigorous tail bound. They use a hash-pinned zero-bracket download. A local copy can be passed to the script. The other computations use sieves of integers.

~~~sh
python -m pip install -r replication/requirements.txt
python replication/certify.py --json covariance.json
python replication/certify.py --bits 192 --cells 1024 --verify-brackets --json independent-check.json
python replication/finite_signs.py --json finite-signs.json
python replication/scale_transition.py --json scale-transition.json
python replication/large_passage.py --json large-passages.json
python replication/large_passage.py --method affine --bits 192 --block 524287 --json large-passages-independent.json
python replication/passage_profile.py --json passage-profile.json
~~~

The [evidence directory](evidence) contains the integer endpoints and their decimal scales. The spectral repeat checks 44,984 Hardy $Z$ endpoint signs. A common event grid certifies all six small-width crossings. At the seven large heights a contiguous sieve and a separate sieve on the two affine forms produce identical ordered-prefix digests. The affine-pattern experiment also checks a proper-power example and a shell with no triple.

## Rebuild the paper and proofs

The PDFs were built with Typst 0.15.2, Libertinus Serif and SimSun for Chinese. The optional Typst input named cjk selects a different installed Chinese font. Both figures are included in vector form. Regenerating them uses Matplotlib 3.10.8 and NumPy 2.5.5.

~~~sh
typst compile --root paper paper/english.typ paper-english.pdf
typst compile --root paper paper/chinese.typ paper-chinese.pdf
python replication/plot_trace.py paper/trace.svg
python replication/plot_passage.py paper/passage.svg
~~~

The archived PDFs use Unix creation timestamp 1795305600. With the Typst 0.15.2 Python binding and the same fonts, the following command reproduces their bytes.

~~~sh
python -c "import typst; [typst.compile('paper/'+s+'.typ',root='paper',output='paper-'+s+'.pdf',timestamp=1795305600) for s in ('english','chinese')]"
~~~

The Lean package pins Lean 4.24.0 and Mathlib. Its formal statements, build commands and boundary with the analytic proof appear in the [formalization guide](formal/README.md). The preprint, source and recorded verification outputs are covered by [SHA256SUMS](SHA256SUMS). On systems with GNU coreutils, run the following from the repository root.

~~~sh
sha256sum -c SHA256SUMS
~~~
