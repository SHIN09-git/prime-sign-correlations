#import "layout.typ": *
#import "equations.typ" as eq
#show: layout.with("zh","从短区间素数误差的符号相关性恢复素数幂","短区间素数误差的符号相关性")

#text(weight:"bold")[摘要　] 对左端点之比为 $q>1$ 的两个短区间，只记录各自的加权素数计数是否超过区间长度。先沿左端点作对数平均，再令相对区间宽度趋零。本文证明，两个计数同时超额的概率偏离 $1/4$ 的一阶项恰在素数幂倍率出现。若 $q=p^k$，系数为 $-(log p)/(2pi sqrt(q))$。偏移窗口宽度的一定比例，系数按三角形轮廓变化。以倍率 2 作一次校准，可在增长的整数范围上一致恢复 von Mangoldt 函数。符号定理对零点纵坐标提出附加独立性假设，允许定量受控的例外集合。按重数计算的谱核具有精确迹公式，仅用黎曼定理和经典显式公式。

= 两个相距很远的窗口
记 $psi(x)=sum_(n<=x)Lambda(n)$。若 $n=p^k$，其中 $p$ 为素数、$k>=1$，则 $Lambda(n)=log p$。其余整数的权重为零。对 $0<h<1$ 定义
#eq.count
取 $x=e^y$。上式的正负表示窗口 $(x,e^h x]$ 内的加权计数是否多于区间长度。在对数坐标上把第二个窗口平移 $a$，记两个窗口同时超额的频率为
#eq.density
先固定 $h,a$ 求这个极限。下文令 $L=log(1/h)$。对整数 $q=n>=2$ 置 $lambda(q)=Lambda(n)$，对其余实数 $q>1$ 置 $lambda(q)=0$。

#lead[定理 1。][在第 2 节的零点假设下，@density 的极限存在。对每个固定实数 $q>1$，当实数 $tau$ 位于有界集时，一致地有]
#eq.inverse
这里 $u_+=max(u,0)$。例如倍率 2 和 4 分别给出 $(log 2)/sqrt(2)$ 和 $(log 2)/2$，倍率 6 的一阶系数为零。定理涉及两个有先后次序的极限。测量某个密度达到指定精度所需的采样长度仍待估计。

#pagebreak()
= 零点假设与一致恢复
由黎曼定理 [4]，每个非平凡零点都有形式 $rho=1/2+i gamma$。对全体纵坐标求和时，正、负纵坐标均按重数计入。对互异正纵坐标组成的集合求和时，用 $m_gamma$ 显式表示重数。

#sub[对纵坐标有理关系的假设]
将互异的正纵坐标分成 $G$ 和 $E$。要求 $G$ 中零点均为单零点，且 $G$ 中纵坐标模掉 $E$ 的有理线性张成空间后线性无关。换言之，若 $G$ 的一个有限有理线性组合落入该张成空间，其所有系数均为零。另外要求 $J_h=o(h)$，其中
#eq.energy
这里采用的独立零点子族与 Martin 和 Ng [11] 在素数竞赛中使用的思想相关。
通常的零点纵坐标线性无关猜想对按重数列出的全部正纵坐标作要求，此时可取 $E$ 为空。本文允许 $E$ 内部存在任意有理关系及重零点。黎曼定理只确定零点位置，这一分解的存在性仍属附加假设。如果 $A_E(T)=o(T)$，则 $J_h=o(h)$。事实上，$1/h$ 以下的贡献至多为 $h^2A_E(1/h)$，其上方逐次翻倍的频带贡献至多为 $sum_(j>=0)(2^j/h)^(-2) A_E(2^(j+1)/h)$。若 $A_E(T)<<T^beta$、$0<=beta<1$，则 $J_h<<h^(2-beta)$。

#sub[用倍率 2 校准]
对整数 $n>=2$，只用同时超额的密度及已知倍率，定义
#eq.calibration
#lead[定理 2。][当 $h$ 充分小时，分母为正。对整数 $2<=N<=1/(4h)$ 一致地有]
#eq.uniform
因此，当 $N h L->0$ 且 $sqrt(N)J_h/h->0$ 时，估计量以 $o(1)$ 的一致误差恢复 $Lambda$。在完全线性无关假设下，仅需第一个条件。若 $A_E(T)<<sqrt(T)$，也只需第一个条件。当误差小于 $(log 2)/4$ 时，分别以 $(log 2)/2$ 和 $3(log n)/4$ 为阈值，即可识别素数幂和素数。这用到了真素数幂满足 $Lambda(n)<=(log n)/2$。

若各输入密度还存在不超过 $eta$ 的误差，只要 $L eta$ 充分小，右侧增加 $O(sqrt(N)L eta)$。这个稳定性估计适用于任何给定精度的密度数据。

#pagebreak()
= 正平移处的精确协方差公式
窗口的傅里叶变换及按重数加权的谱核分别为
#eq.modes
#eq.kernel
由 @mode 的两种表示，$abs(b_h(gamma))<<min(h,1/abs(gamma))$。因此 Riemann–von Mangoldt 零点计数 [6，引理 1] 保证核级数绝对收敛。由正负纵坐标对称性，核为实值。对正实数取 $H$，并定义
#eq.arch
#lead[定理 3。][当 $a>h$ 时，下列精确公式成立。这里允许零点有重数，纵坐标之间也可以有有理关系。]
#eq.trace
把右边的积分记作 $B_h(a)$。求和中只有有限项非零。窗口核总质量为 $4(e^(h/2)-1)^2$，中心值 $w_h(0)=e^h-1$。

#sub[证明]
在 $t>0$ 上，经典显式公式 [5，定理 8] 给出分布恒等式
$ -sum_gamma e^(i gamma t)/rho=e^(-t/2)(psi(e^t)-e^t+log(2pi)+1/2 log(1-e^(-2t))). $
对两边作用 $partial_t+1/2$。阶梯函数 $psi(e^t)$ 的每次跳跃在 $log n$ 处给出质量 $Lambda(n)$，其余各项直接求导，从而有
$ sum_gamma e^(i gamma t)=H(t)-sum_(n>=2) (Lambda(n))/sqrt(n) delta_(log n)(t). $ <distribution>
原零点级数的局部收敛见第 4 节。指数窗口的自相关恰为 $w_h(t)$，因为当 $abs(t)<=h$ 时重叠积分为 $integral_0^(h-abs(t))e^(u+abs(t)/2)dd u$。其傅里叶变换在 $gamma$ 处等于 $abs(b_h(gamma))^2$。用以 $a$ 为中心的平移窗口测试 @distribution 即得 @trace。严格地说，先与紧支撑概率密度作光滑化。其傅里叶乘子的模至多为一。谱侧利用绝对收敛，算术侧利用测试函数一致收敛及测度局部有限，即可撤去光滑化。在窗口端点恰遇原子时，窗口端点的权重为零，公式同样成立。

#pagebreak()
= 方差尺度与实际计数的极限分布
决定定理 1 精确系数的方差渐近式为
#eq.variance
令 $g(u)=2(1-cos u)/u^2$，补充定义 $g(0)=1$。把 @mode 的 $e^(u/2)$ 替换成 1，$b_h$ 至多改变 $O(h min(h,1/abs(gamma)))$。在 $1/h$ 以下直接估计，更高频率用分部积分。由零点计数，$sum_gamma min(h^2,gamma^(-2))<<h L$，故方差至多改变 $O(h^2 L)$。平坦窗口的方差为 $2 integral_0^infinity h^2 g(h t)dd N(t)$，其中 $N(t)$ 统计正纵坐标且计重数。将 $dd N(t)$ 替换为 $(2pi)^(-1)log(t/(2pi))dd t$。计数余项为 $O(log(2+t))$，而 $abs(g')(1+abs(log u))$ 可积，故分部积分后的误差为 $O(h^2 L)$。由 Dirichlet 积分有 $integral_0^infinity g(u)dd u=pi$。换元即得 @variance。

#sub[从零点相位回到素数计数]
在 $R<=abs(gamma)<2R$ 的频带内，每个单位频格中 $abs(1/rho)$ 的和为 $O((log R)/R)$。取平移高斯函数控制任意单位时间窗口的示性函数，展开频带和的平方。第 $j,k$ 个频格间的傅里叶权重至多为 $O(exp(-max(abs(j-k)-1,0)^2/4))$，全部行和有界。用 $2a b<=a^2+b^2$，可将局部平方范数控制在 $O(R((log R)/R)^2)$ 内。重零点及不完整频带同样适用。对二倍频带求和可得局部 $L^2$ 收敛，对窗口平移一致。再取几乎处处收敛子列，与对称显式公式的逐点极限比较，即可识别第 3 节的展开。

记 $E_0(y)=e^(-y/2)(psi(e^y)-e^y)$，则 $D_h(y)=e^(h/2)E_0(y+h)-E_0(y)$。初等修正项在无穷远趋零。因此，两个固定平移处的向量可在对数均方意义下用系数为 $-b_h(gamma)$ 的有限零点和逼近。对有限相位作 Kronecker–Weyl 平均，得到真实相位轨道闭包上的 Haar 概率。其理由是频率非零的特征标时间平均为零。均方逼近将结论传给有界 Lipschitz 测试函数，也传给二阶矩。

特别地，实际的对数协方差等于 $K_h(a)+2sum_(gamma>0)^"distinct" m_gamma(m_gamma-1) abs(b_h(gamma))^2 cos(gamma a)$，附加项对互异正纵坐标求和。取 $a=0$，只需对某个 $h>0$ 有实际方差等于 $V_h$，就与所有非平凡零点均为单零点等价。这是因为指数窗口使每个 $b_h(gamma)$ 都非零。

#pagebreak()
= 从相位概率到两个符号
在第 2 节的假设下，每个 $G$ 中的纵坐标提供一个独立的均匀圆周相位，且它们与整个例外相位向量独立。对有限组坐标，这是环面 Haar 测度的特征标判据。任何涉及 $G$ 中坐标的特征标关系都会违反模例外张成空间的线性无关性。再用只依赖有限坐标的函数得到无限族结论。例外坐标具有它们自身轨道闭包上的 Haar 分布。不同正频率仍两两正交，故例外部分的二阶矩按重数平方求和即可控制。若 $G$ 为空，$J_h$ 将至少是 $V_h$ 的常数倍，与假设冲突。

任取一个正常相位，其系数非零，因此在每个坐标上都给出无原子的边际分布。与其余独立相位卷积后仍无原子。正象限的边界于是具有零概率。第 4 节的弱收敛证明对每个固定 $h,a$，实际对数密度 @density 存在，等于这个象限概率。

#sub[定量的正象限估计]
当 $h$ 充分小且 $abs(K_h(a))<=V_h/2$ 时，一致地有
#eq.model
把两个坐标除以 $sqrt(V_h)$。按重数的标准化协方差矩阵对角线为 1，非对角元为 $K_h(a)/V_h$。删去例外零点使各矩阵元改变 $O(J_h/V_h)$。正常部分的协方差特征值因此落在固定的正紧区间内。每个独立向量项的范数为 $O(h/sqrt(V_h))$，所有项的二阶矩之和为 $O(1)$。将协方差变为单位矩阵以后，三阶绝对矩之和为 $O(sqrt(h/L))$。Bentkus 的凸集 Berry–Esseen 不等式 [7] 将正常部分与同协方差高斯向量作比较，误差对全部平移象限一致。可先对充分高的有限截断使用该估计，再取 $L^2$ 极限，协方差的上下界在截断时仍可保持。

标准化后的例外向量均值为零，二阶矩为 $O(J_h/V_h)$，重数须在平方前合并。利用独立性对该向量取条件期望。对非退化高斯分布，平移象限概率的二阶偏导数，对全部平移一致有界，可用高斯密度二阶偏导的 $L^1$ 范数控制。Taylor 展开的一次项由零均值消失，余项为 $O(J_h/V_h)$。恢复删去的按重数协方差也只需同阶误差，这可在正定矩阵的紧集上对高斯密度的矩阵参数求导得到。最后，相关系数为 $rho$ 的标准二维高斯正象限概率为 $1/4+arcsin(rho)/(2pi)$。对旋转不变的标准平面高斯，只需计算两个半平面的夹角即可得到此式。于是 @model 得证。

#pagebreak()
= 从同时超额的频率恢复素数权重
固定 $q>1$，令 $tau$ 在有界集内变化。$h$ 充分小时，$log q+tau h$ 附近的窗口至多遇到 $log q$ 处的原子。平滑项 $B_h$ 为 $O_q(h^2)$。对上述位移一致地有
$ w_h(tau h)=h(1-abs(tau))_++O(h^2). $
将 @trace 除以 @variance，再代入 @model。$arcsin u=u+O(u^3)$ 的三次余项在乘 $L$ 后趋零，高斯近似给出的误差为 $O(sqrt(h L)+J_h/h)=o(1)$。这就证明了定理 1，也包括 $abs(tau)=1$ 以及倍率为非整数的情形。

#sub[整数倍率同时增长]
在 $2<=n<=N<=1/(4h)$、$h$ 充分小时，有 $n(e^h-1)<1$ 以及 $n(1-e^(-h))<1$。所以 $(n e^(-h),n e^h)$ 内仅含整数 $n$。在相应的对数窗口内，$abs(H)<<sqrt(n)$，从 @trace 得到一致估计
$ K_h(log n)=-(e^h-1)Lambda(n)/sqrt(n)+O(h^2 sqrt(n)). $ <isolated>
因为 $Lambda(n)/sqrt(n)<<1$，由 @variance，当 $h$ 充分小时，整个整数范围上的 $abs(K_h(log n))/V_h$ 都小于 $1/2$。取 @calibration 中的正弦恰好抵消高斯反正弦。用正弦的 Lipschitz 界传递 @model 的误差，得到
#eq.bound
式 @isolated 确定了负号。特别地，$S_h(2)/c_h=(log 2)/sqrt(2)+O(sqrt(h L)+J_h/h+h)$ 最终为正。置 $A_n=sqrt(n)S_h(n)/c_h$，则 $hat(Lambda)_h(n)=(log 2)A_n/A_2$。利用恒等式
$ (log 2)A_n-Lambda(n)A_2=(log 2)(A_n-Lambda(n))-Lambda(n)(A_2-log 2) $
以及 $Lambda(n)<=log n<<sqrt(N)$，即得 @uniform，定理 2 得证。输入密度变化 $eta$ 至多使 $S_h$ 变化 $2pi eta$，再除以 $c_h$ 最多放大 $O(L)$ 倍，就得到前述稳定性界。

完全线性无关时，可取 $N=floor(1/(h L^2))$。实际恢复仅需测量同时超额的频率，已知素数 2 消去了未知的边际方差。

#pagebreak()
= 谱侧与算术侧的数值核验
取 $h=1/32$。下表给出 $K_h(log n+tau h)$ 的两种独立包围区间，显示时的十进制端点再次向外取整。算术侧直接计算 @trace 。谱侧独立求零点和，并将所有未计算零点的尾部一次性包入误差。

#figure(table(columns:(.50fr,.55fr,1.64fr,1.64fr),align:(right,right,center,center),stroke:none,inset:3.6pt,
table.hline(),table.header([$n$],[$tau$],[算术侧区间],[谱侧区间]),table.hline(stroke:.45pt),
[2],[0],[$[-0.014392,-0.014387]$],[$[-0.015327,-0.013420]$],
[2],[$1/2$],[$[-0.006591,-0.006585]$],[$[-0.007542,-0.005634]$],
[2],[1],[$[0.001210,0.001216]$],[$[0.000251,0.002159]$],
[4],[0],[$[-0.009055,-0.009046]$],[$[-0.009993,-0.008086]$],
[6],[0],[$[0.002413,0.002424]$],[$[0.001464,0.003372]$],table.hline()),caption:[按重数计算的核。两种有限宽度核算检验的是精确迹公式。])

#figure(image("trace.svg",width:99%),caption:[左图在固定宽度下画出 $K_h/(e^h-1)$ 随倍率的变化。右图放大倍率 2 附近，窗口缩窄时归一化凹陷趋向三角形。])

算术侧利用单调性在每个半窗口分段包围 $w_h$ 与 $H$。谱侧使用高度 $T=20000$ 以下的 22,491 个正纵坐标。互不相交的有理区间端点上 Hardy $Z$ 函数异号，并用 $T$ 处的完整零点计数核对 [9]。由 [6，引理 1]，对 $t>=T$ 有 $N(t)<=t log(t)/(2pi)$，故分部求和得到协方差尾项的绝对上界
$ 2(1+e^(h/2))^2 ((log T+1)/(pi T)-N(T)/T^2)<0.000954. $
复算程序给出全部九组结果。这些区间检验固定宽度的核值。关于实际计数符号及其极限密度的理由见第 5 节。

#pagebreak()
= 在有限高度直接测量符号频率
对 @density 中的同一个观测量，也可以直接在有限范围上求值。取窗口倍率 $r=33/32$，使用实际素数幂和相应的对数权重，计算
$ F_q(A,B)=1/(log(B/A)) integral_A^B bold(1)_(psi(r x)-psi(x)>(r-1)x) bold(1)_(psi(r q x)-psi(q x)>(r-1)q x) (dd x)/x. $ <finite>

当 $q$ 为整数时，两个计数只可能在 $x=m$、$m/r$、$m/q$ 或 $m/(r q)$ 处跳变，其中 $m$ 是素数幂。乘以 $33q$ 后，所有断点均在整数格点上。设相邻断点间的开区间为 $(u,v)$，两个加权计数在其中恒为 $s,t$。两个窗口同时超额的部分止于
$ c=max(u,min(v,32s,32t/q)). $
这个小区间对分子的贡献恰为 $log(c/u)$，整段或空集也由同一公式处理。断点的对数测度为零。筛出不超过 $floor(r q B)$ 的全部素数幂，逐段以严格区间算术计算，得到下表。

#figure(table(columns:(1.1fr,1fr,1fr,1fr),align:center,stroke:none,inset:5pt,
table.hline(),table.header([底点范围 $[A,B]$],[$q=2$],[$q=4$],[$q=6$]),table.hline(stroke:.45pt),
[$[2^9,2^14]$],[0.181675],[0.212266],[0.254054],
[$[2^14,2^16]$],[0.190440],[0.240567],[0.226125],table.hline()),
caption:[实际计数同时超额的频率，表中保留六位小数。随稿数据给出宽度至多 $10^(-9)$ 的包围区间。])

倍率 6 的偏差 $F_6(A,B)-1/4$ 在两个范围内符号相反。在较高的范围里，倍率 6 的频率甚至低于素数幂倍率 4。因此，只看单个有限范围内观测频率的高低，可能会得到与极限一阶系数不同的排序。这说明研究达到指定精度所需的观测长度有实际意义。

#pagebreak()
= 与已有工作的关系及参考文献
Montgomery 和 Soundararajan [2] 研究了观测高度和区间长度共同变化时的短区间素数高斯分布。Leung [1] 在 RH 与 LI 下得到了邻近短区间的联合高斯律与次阶负相关。他的中心位移参数 $t$ 以窗口宽度为单位，定理 3.1 将中心参数的最大尺度限制在 $delta^(-1/10)$ 以内。本文固定倍率时，该参数为 $1/h$ 量级，此时 @trace 中的离散素数项进入主项。Landau 的指数和早已能从零点的线性统计量识别素数幂倍率 [10，式 (1.1)]。Suzuki [3] 在二次积分的 zeta 显式公式中已经写出了素数幂项。分布公式 @distribution 与高斯反正弦公式均为经典结果。本文研究相距固定倍率的两个计数仅保留正负号后能恢复什么，并估计可同时恢复的整数范围与输入误差。

符号定理使用有次序的两重极限。去掉符号观测量的独立性前提，或给出 $h$ 与 $Y$ 同时变化时的定量结论，均是更强的开放方向。精确谱核公式及第 4 节的实际协方差重数修正仅用黎曼定理。配套 Lean 工程核验窗口极限、正弦统计量的一阶转换、校准误差、两种算术阈值及第 8 节的分段不等式，并从迹公式、方差尺度及高斯比较三个解析输入推出固定倍率的反演极限。零点展开及提供这些输入的概率估计由正文证明。本稿为公开预印本，尚待独立同行评审。

#sub[参考文献]
[1] S.-K. Leung. Joint distribution of primes in multiple short intervals. _Advances in Mathematics_（2026）。#link("https://arxiv.org/abs/2401.04000")[arXiv:2401.04000]。

[2] H. L. Montgomery, K. Soundararajan. Primes in short intervals. _Comm. Math. Phys._ *252*（2004），589–617。#link("https://doi.org/10.1007/s00220-004-1222-4")[期刊论文]。

[3] M. Suzuki. Aspects of the screw function corresponding to the Riemann zeta-function. _J. London Math. Soc._（2023）。#link("https://doi.org/10.1112/jlms.12785")[期刊论文]。

[4] L. Alpöge。#link("https://alpo.ge/remark.pdf")[黎曼定理证明公告]（2026）。Lean 与 Mathlib 社群。#link("https://leanprover-community.github.io/blog/posts/riemann-hypothesis/")[核验声明]。

[5] T. Tao. 246B, Notes 4. The Riemann zeta function and the prime number theorem（2021），定理 8。#link("https://terrytao.wordpress.com/2021/02/12/246b-notes-4-the-riemann-zeta-function-and-the-prime-number-theorem/")[课程讲义]。

[6] R. P. Brent, D. J. Platt, T. S. Trudgian. The mean square of the error term in the prime number theorem. _J. Number Theory_ *238*（2022），740–762。#link("https://doi.org/10.1016/j.jnt.2021.09.016")[期刊论文]。

[7] V. Bentkus. A Lyapunov-type bound in $RR^d$. _Theory Probab. Appl._ *49*（2005），311–323。#link("https://doi.org/10.1137/S0040585X97981123")[期刊论文]。

[8] A. Iksanov, Z. Kabluchko, A. Marynych. Almost periodic stochastic processes with applications to analytic number theory（2025）。该文讨论相关的函数型极限分布。#link("https://arxiv.org/abs/2502.04969")[arXiv:2502.04969]。

[9] 二倍区间素数均方项目。经认证的零点有理区间与独立端点核验（2026），版本 #link("https://github.com/SHIN09-git/dyadic-prime-mean-square/tree/1cea164bd25696723c376c48aaa677fbea7ea188")[1cea164]。

[10] K. Ford 与 A. Zaharescu。On the distribution of imaginary parts of zeros of the Riemann zeta function。_J. reine angew. Math._ *579*（2005），145–158。#link("https://arxiv.org/abs/math/0405459")[论文]。

[11] G. Martin 与 N. Ng。Inclusive prime number races。#link("https://arxiv.org/abs/1710.00088")[arXiv:1710.00088]。
