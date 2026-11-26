# 带符号窗口的有限复算

本目录保留固定两支素数配对研究中的六组计算。每一项由两个模数、两端各一个同余根和一个筛因子组成。完整近相位和共有 3,007,962 项。它使用原研究的截点，正文第 6 节按新定理假设计算的整数表单列在上一级目录。

## 计算对象

取 $Z=2^K$、$L=\log Z$，分母区间为 $V<q<q+d\le2V$。其中 $V=c\lfloor\sqrt ZL^{3/4}/2\rfloor$、$H=\lceil 8V^2/(ZJ)\rceil$、$T=\lfloor H/(2L^{1/40})\rfloor$。移位 $d$ 取小于 $T$ 的正整数 $432h$。六组 $(K,c,J)$ 依次为 $(16,12,1),(16,12,2),(20,12,2),(22,10,2),(22,10,4),(22,14,8)$。

对两个无平方因子的模数 $q=mn$、$q+d=m'n'$，均保留两因子大于 $Y=\exp(L^{99/400}\sqrt J)$ 的根。置 $r=(6m)^{-1}\bmod n$，对另一端同样取 $r'$。筛因子 $a$ 无平方因子，整除 $q(q+d)$ 并至少整除一个有权的分子 $j$。令 $y$ 为 $a(r/n-r'/n')$ 模 1 在 $[-1/2,1/2)$ 中的代表元。完整近相位和取 $|y|\le aL^{1/16}/J$，其中的极近部分取 $|y|\le\eta=V^{-1/2}L^{-3/10}$。

分母权为 $w(q)=\mu(q)\prod_{p\mid q}p/(p-\nu_p)$，其中 $\nu_2=\nu_3=1$，其余 $\nu_p=2$。对给定的一项，程序合计 $a\mid j$、$1\le j\le3J$ 的 $\mu(a)w(q)w(q+d)\psi(j/J)\cos(2\pi j(r/n-r'/n'))$。平滑函数 $\psi$ 在 $J\le j\le2J$ 取 1，两侧在宽 $J/L^{1/20}$ 的范围内光滑减到 0。具体函数见 `rows.py` 的 `step` 与 `psi`。

六组参数均有 $\lfloor L^{1/20}\rfloor=\lfloor L^{1/10}\rfloor=1$。剩余组按顺序剔除 $\gcd(q,d)>L^{1/20}$、$a>L^{1/10}$、$|y|\le\eta$ 和 $t\le0$ 或 $6t$ 为平方的项，共余 666,742 项。$t$ 的定义见正文式（3）。

## 怎样读数据

[rows.json](rows.json) 的每个 `records` 条目对应一组 $(K,c,J)$。`shifts` 保存各移位的定点整数与计数。`metrics` 已除以 $\sqrt L$，两个整数端点分别是以 $10^{-9}$ 为单位向下、向上取整的界。

| 字段 | 读法 |
| --- | --- |
| `net, pair_abs, shift_abs` | 完整近相位净和、逐分母对合计后取绝对值、逐移位合计后取绝对值 |
| `plus, minus, without_den_mu` | 分母莫比乌斯乘积为正和为负两类各自的带符号贡献，以及去掉这一乘积后的和 |
| `row_abs, mixed_net` | 按 $(d,a,t,\operatorname{sgn}u)$ 合计后取绝对值，以及同组出现两种分母符号时的净和 |
| `inner_net, inner_abs, square_net` | 极近相位净和、极近相位逐项绝对值之和、$6t$ 为非负平方的近相位净和 |
| `large_gcd, large_mask, ordinary_inner, finite_discriminant` | 按上述顺序剔除的四组各自的净和 |
| `rem_net, rem_pair_abs, rem_shift_abs, rem_without_den_mu` | 对剩余组分别取净和、逐分母对取绝对值、逐移位取绝对值、去分母莫比乌斯符号 |
| `discrepancy_quarters` | 在剩余组上，取 $z=1/4,1/2,3/4,1$，比较以 $y$ 为中心、半径为 $az/J$ 的闭区间中整数的个数与区间长度，以 $w(q)w(q+d)\mu(a)/a$ 加权，再按移位归一化 |

三角函数用 Arb 实球计算，分子相位向量以 $2^{-34}$ 为单位存为整数。除 `discrepancy` 外，各移位的原始整数和乘以 $864(T-d)/(VT^2J\,2^{68}\sqrt L)$，即得到相应的归一化定点值。误差界计入 `metrics`。对 `discrepancy` 还须除以 $2\operatorname{lcm}(1,\ldots,3J)$。`direct` 按原分子互素条件直接计算全相位和，每个移位均有 `direct = net + far`。

## 复算

在本目录安装 python-flint 0.8.0 后，从全部分母重新生成数据，并与归档文件逐字节比较。以下命令适用于 Python 3.12。

```sh
python -m pip install python-flint==0.8.0
python -B verify.py
python -B rows.py --out replay.json
python -c "from pathlib import Path; assert Path('replay.json').read_bytes() == Path('rows.json').read_bytes()"
```

[verify.py](verify.py) 逐组核对归档恒等式，再用独立的模素数坐标和直接余弦求和复算七个完整移位，共 204,418 个近相位项。它还核对同一行列式上两对分母的莫比乌斯乘积符号相反的实例。[rows.py](rows.py) 负责六组数据的完整重建，公用算术函数见 [arithmetic.py](arithmetic.py)。
