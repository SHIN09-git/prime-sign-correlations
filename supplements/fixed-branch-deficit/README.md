# Fixed-branch prime pairs in short intervals

**GPT-6.2 Astra · JIN HANZHE**  
七篇中文研究笔记，2026 年 11 月 22–23 日

对每个素数 $p$，分别检查 $6p-1$ 和 $6p+1$ 是否为素数。两个搭档都是素数时，底数 $p$ 计两次。这七篇笔记从倍率 6 首次追平倍率 4 的位置出发，研究长度为 $H=\sqrt X(\log X)^{3/2}$ 的窗口里，两支素数对合计会短缺多少。记 $L=\log X$、$\mu=H/L^2$。

## 从哪里读起

想看末次失守的具体窗口，可先读第 4 篇。想看无穷范围还差哪一步，可直接读第 7 篇。表中顺序按各篇之间的推导关系排列。

| 研究笔记 | 主要内容 |
| --- | --- |
| [1 · 固定偏移素数对与首次反转上界](First-Reversal-Fixed-Shifts.pdf) | 在 $[2^{40},2^{40}+2^{30}]$ 上逐个实数起点给出首次反超上界，并从单侧平均缺额推出全起点上界的充分条件。 |
| [2 · 固定两支素数对的平均缺额](Fixed-Branch-Mean-Deficit.pdf) | 用相邻命中底数的间距刻画平均缺额，给出多个连续高度区间上的零缺额证书。 |
| [3 · 底数充足时，两支素数对仍会同时变稀](Joint-Prime-Windows-reading.pdf) · [原版与附件](joint-window-archive/README.md) | 对 $2^{18},2^{19},\ldots,2^{30}$ 十三个固定高度逐窗计数，考察底数充足时两支同时低于各自门槛的情形。 |
| [4 · 4.5μ 门槛最后一次失守的高度](Last-Deficit-Window.pdf) | 精确定位有限范围中的临界高度 $X_*$，并指出使最差窗口重新达标的素数对。 |
| [5 · 固定两支素数对的短区间缺额](Fixed-Branch-Deficit-Middle-Correlations.pdf) | 把含有深缺额的区块数与中心化的中距离相关联系起来，给出推出平均缺额上界的充分条件。 |
| [6 · 固定两支的算术抵消](Fixed-Branch-Cancellation.pdf) | 在 $[2^{16},2^{27}]$ 上给出 $S_X-V_X$ 的负上界，分离有限分母同余模型的贡献和真素数余项。 |
| [7 · 随高度平均的真实配对偏差](Height-Averaged-Prime-Pairs.pdf) | 把深缺额归约到随高度平均的真实配对偏差，并将连续零缺额证书向右接到 $17\cdot2^{28}$。 |

## 已覆盖的高度与开放问题

令 $P(t,H)$ 为 $(t,t+H]$ 中两支的合计，窗口长度在积分中固定。研究量为

$$
D_{4.5}(X)=\frac{1}{X}\int_X^{2X}\max\{4.5\mu-P(t,H),0\}^2\,dt.
$$

第 4 篇和第 7 篇在 $2^{32}$ 处衔接。它们共同给出每个实数 $X\in[X_*,17\cdot2^{28}]$ 及每个 $t\in[X,2X]$ 上的 $P(t,H)\ge 4.5\mu$，因此整段都有 $D_{4.5}(X)=0$。这里 $X_*\approx 1\,094\,643\,035.932871$ 满足 $X_*(\log X_*)^3=3\,141\,666^2$，右端为 $4\,563\,402\,752$。第 2 篇还给出了一个与此范围分开的较高区间。

第 7 篇令 $F(Y)=S_Y-V_Y$、$M(X)=X/(HL)$。若能对每个充分大的 $X$ 证明 $\int_X^{2X} F(Y)\,dY\ll X M(X)$，就能推出 $D_{4.5}(X)\ll H/L$。真素数的这一平均估计及全高度深缺额上界仍待证明。

**English summary.** These notes count both fixed affine prime-pair branches $(p,6p\pm1)$, with multiplicity when both partners are prime. The last-window and height-averaging certificates join at $2^{32}$ and cover every real height from $X_*$ to $17\cdot2^{28}$. The final note gives a sufficient signed mean estimate for the all-large-height deficit bound. That arithmetic estimate remains open.

## 复核附件

六份原版 PDF 可直接下载。第 3 篇提供八页正文阅读版，其带附件的完整原版可由[六个分卷复原](joint-window-archive/README.md)。第 5 篇原稿直接附有 `verify.py` 和 `checks.json`，其余六篇原稿各附一份 `verification.zip`。每份附件请解到各自的目录，避免同名脚本互相覆盖。部分早期笔记还随附特定引理的 Lean 源码和审计记录。

例如，安装 64 位 Python、PyMuPDF、NumPy 和 Numba 后，在本目录运行以下命令，可以核对第 7 篇的归档证书。附件内的 `README.md` 另有从头重建两份素数计数表的步骤。

```sh
python -m pymupdf embed-extract Height-Averaged-Prime-Pairs.pdf -name verification.zip -output verification.zip
python -m zipfile -e verification.zip height-evidence
cd height-evidence
python verify_ledgers.py
```

[主论文与复现说明](../../README.md) · [全仓库 SHA-256 校验清单](../../SHA256SUMS)
