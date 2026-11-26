# 固定模数间距下可约二次同余根的近距离配对

**Close pairs of roots of a reducible quadratic congruence at shifted moduli**

Codex · 研究预印本 · 2026 年 11 月 26 日

[中文全文](close-root-pairs-zh.pdf) · [English preprint](close-root-pairs-en.pdf) · [Typst 源码](paper.typ) · [以往七篇研究笔记](https://github.com/SHIN09-git/prime-sign-correlations/tree/41b4fc6b14bbd1160314276bf4e6f5eb13c1522a/supplements/fixed-branch-deficit)

把同余方程 $z(6z-1)\equiv0\pmod q$ 的每个根画在单位圆上，位置为 $z/q$。同时观察模数 $q$ 和 $q+d$，其中 $V<q<q+d\le2V$。当间距 $d$ 固定、区间向右移动时，两边能有多少对根靠得非常近？

**定理 1** 给出一个与 $V$ 无关的答案。设 $a,d$ 为固定正整数，$c>0$ 固定。两个模数均无平方因子。对每个根写 $m=\gcd(z,q)$、$n=q/m$，两端都要求 $\min(m,n)>Y\ge ad$。在整个倍增区间里，满足

$$
\left\|a\left(\frac zq-\frac{z'}{q+d}\right)\right\|\le\frac cV
$$

的有序根对只有 $O_{a,d,c}(1)$ 个。双竖线表示到最近整数的距离。正文还给出 $a,d$ 和半径都可变时的显式上界，并举例说明保留小因子时，极近根对的个数可以随 $V$ 线性增长。

证明把每个根对对应到一个整数 $t$。固定 $t$ 后，两个分母满足二次范数方程 $u^2-6t(2q+d)^2=(a^2-6t)d^2$。正范数单位之间的间隔限制了同一倍增区间内的分母数。给定分母和相位，中国剩余定理再限制根的重数。

**与素数配对的关系。** 在研究 $(p,6p\pm1)$ 的模型中，记 $L=\log Z$、$V\asymp\sqrt Z L^{3/4}$。对半径 $V^{-1/2}L^{-3/10}$ 以内的根对，即使逐项取绝对值，归一化总贡献也至多为 $O\!\left(L^{2/5}(\log L)^{11}\right)=o(\sqrt L)$。在固定中心 $3Z/2$，原研究要估计每个分母短窗口内所有前缀和的最大值，再对其平方取平均。这就是此前工作稿的式（8）。沿目前的证明路线，还需要控制更宽相位范围内的带符号净和。真实素数配对在所有充分大倍增区间上的一致平均上界仍是开放问题。

**English summary.** For squarefree shifted moduli in one dyadic interval, the paper counts close normalized roots of the reducible congruence $z(6z-1)\equiv0\pmod q$. With the multiplier $a$, shift $d$ and $c>0$ fixed, the total number within circular distance $c/V$ after multiplication by $a$ is bounded independently of $V$ when both factors of each root exceed $Y\ge ad$. The proof gives explicit dependence on $a,d$ and the radius. Section 5 treats the extreme near-phase contribution in the prime-pair model. The wider signed range at the fixed centre remains open.

## 复算有限数据

在本目录用 Python 3.12 运行以下命令即可重建正文表格，并与归档指纹比较。只需 Python 标准库。

```sh
python -B check_counts.py
```

程序分别通过因子分解、逐素数合成同余根两条途径遍历同一批 182,000 个候选根对。六组参数在四个半径上的累计计数都一致。在每组最宽的半径 $1/\sqrt V$ 上，还逐条比较分母、两个根、带符号相位和整数 $t$。各组参数、计数和 SHA-256 记录在 [counts.json](counts.json)，实现见 [check_counts.py](check_counts.py)。

另有六组从素数配对研究保留下来的带符号窗口数据。它们枚举了 3,007,962 个近相位根对与筛因子的组合，使用的因子截点有时低于 $ad$。程序对其中七个完整移位独立重算了 204,418 项。这批数据用来研究抵消，正文表格则单独按定理 1 的假设计算。[带符号窗口的定义、数据和复算命令](signed/README.md)

## 重建两份 PDF

两份 PDF 各嵌入同一个 `verification.zip`，含本页、排版源码、构建脚本及两组复算材料。解压后也可直接运行上述命令。发布版本使用 Python 包 typst 0.15.2、PyMuPDF 1.28.2、Libertinus Serif 和宋体（SimSun）。

```sh
python -m pip install typst==0.15.2 PyMuPDF==1.28.2
python build.py
```

使用其他已安装的中文字体时，运行 `python build.py --cjk "Noto Serif CJK SC"`。重建到另一个目录可加 `--out-dir rebuilt`。如需直接从 PDF 取出附件，可运行以下两条命令。

```sh
python -m pymupdf embed-extract close-root-pairs-zh.pdf -name verification.zip -output verification.zip
python -m zipfile -e verification.zip evidence
```

## 相关研究

Dartyge 与 Martin 研究可约多项式的同余根在模数求和下的指数和。Marklof 与 Welsh 研究另一族二次同余的根的细尺度分布与成对关联。本文同时固定两个模数的间距，并要求两端的根均满足因子下界。正文第 6 节列有二次域理想与单位论证的参考资料。[Dartyge–Martin](https://arxiv.org/abs/1802.09090) · [Marklof–Welsh](https://arxiv.org/abs/2105.02854)

本篇由 OpenAI Codex 按原项目的研究方向续作。原七篇研究笔记署名为 GPT-6.2 Astra 与 JIN HANZHE。
