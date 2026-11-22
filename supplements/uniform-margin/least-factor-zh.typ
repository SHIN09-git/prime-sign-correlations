#import "../../paper/layout.typ": sub
#import "least-factor-equations.typ" as q

= 平方根附近的最小素因子
固定 $0<tau<2/3$、$0<a<1/2$ 和一个符号 $sigma in {-1,1}$。取
#q.scale
以 $N_sigma$ 记区间 $I$ 中 $n$ 与 $6n+sigma$ 同为素数的整数 $n$ 的数量。以 $S_(sigma)(alpha)$ 记满足 $P^(-)(n(6n+sigma))>X^alpha$ 的整数 $n$ 的数量。这里 $P^(-)(m)$ 表示 $m$ 的最小素因子，两个计数均不加权。

#sub[定理 I　筛后合数候选的一致上界]
对每个 $0<=eta<=1/2-a$ 和所有充分大的实数 $X$，有
#q.endpoint
更一般地，对 $a<=alpha<=beta<=1/2$ 有
#q.band
隐常数对上述范围内的指数、起点、符号及宽度 $Y$ 一致。定理无条件成立。取 $tau<1/6$，即可覆盖第 1 节的临界宽度 $H$ 及其任意固定正倍数。

取 $a=1/4$，筛去所有不超过 $sqrt(X)$ 的素因子后，候选数与真素数对数相差 $O_(tau)(Y/ell^3)$。对固定 $A>=0$，若筛至 $sqrt(X)/ell^A$，取 $eta=A(log ell)/ell$，误差为 $O_(tau,A)(Y(1+log ell)/ell^3)$。在这两种截断下，误差都比目标量级 $Y/ell^2$ 小。若在 $I$ 上使用非负有界窗口权，绝对误差至多乘以权的上界。要推出原论文的上界，还须证明筛后的候选数有正的下界。

*需要计数的因子分解。* 若至少一个成员是合数，则两数乘积的最小素因子 $r$ 至多为 $sqrt(12X+1)$，且它整除某个合数成员。理由是两个成员都大于 $sqrt(12X+1)$，而合数的最小素因子至多等于自身的平方根。写该成员为 $r s$，其余因子 $s$ 及另一成员也均不含截断以下的素因子。对两指数之间的差值，只需考虑 $X^alpha<r<=X^beta$。对端点估计，范围是 $X^(1/2-eta)<r<=sqrt(12X+1)$。我们将证明，每个 $R<r<=2R$ 的区段贡献 $O_(tau,a)(Y/ell^3)$。覆盖这两个范围所需的区段数依次为 $O(1+(beta-alpha)ell)$ 和 $O(1+eta ell)$。

#pagebreak()
= 双曲线薄带中的剩余类
考虑正整数 $r,s$ 满足 $R<r<=2R$ 及 $U<r s<=U+Delta$，其中 $U asymp X$、$U+Delta asymp X$、$Delta asymp Y$。分解第一个成员时取 $(U,Delta)=(X,Y)$。分解第二个成员时取 $(6X+sigma,6Y)$。第 13 节所需参数满足 $X^a<=R<=4sqrt(X)$。固定模 $d$ 的两个剩余类，令 $B_(d)(i,j)$ 为 $r equiv i$、$s equiv j$ 的点数。置 $kappa=min(tau,a)/8$，则对所有 $d<=X^kappa$ 一致地有
#q.crt

*先数第二个坐标。* 在 $r equiv i$ 的数上，分别对 $A=U+Delta$ 及 $A=U$ 求 $floor((A/r-j)/d)$ 之和，再相减。线性项给出 $(Delta/d)sum 1/r$。沿第一个等差数列分部求和，得 $sum 1/r=(log 2)/d+O(1/R)$，实数端点仍适用。两个锯齿函数和中的常数项相消，剩下的是给每个中心化的小数部分和证明 $O(X^(1/3))$ 的估计。

当 $R<=2X^(1/3)$ 时，直接数 $O(1+R/d)$ 项即够。否则取 $K=floor(R/X^(1/3))$，写 $r=i+d m$。相位 $phi(m)=A/(d(i+d m))-j/d$ 在这一段上满足 $abs(phi''(m)) asymp A d/R^3$。由于 $d<R$，项数为 $O(R/d)$。对小数部分用 Erdős–Turán 偏差不等式，并对每个谐波 $h phi$、$1<=h<=K$ 用范德科普特二阶导数估计。若某个谐波的曲率大于一，直接计数即满足同一估计。对区间偏差积分即控制中心化小数部分之和，整数端点同样在内。分别对 $h^(-1/2)$、$h^(-3/2)$ 求和后，所得上界为常数乘以
#q.discrepancy
第一项来自频率截断。其余两项来自二阶导数估计中的曲率平方根乘以区间长度，以及曲率平方根的倒数。所选的 $K$ 使前两项均为 $O(X^(1/3))$。因 $R<=4sqrt(X)$，第三项为 $O(X^(1/4))$。剩余类估计得证。

若逐个 $r$ 对取整误差取绝对值，当 $r$ 接近 $sqrt(X)$ 时误差可达 $sqrt(X)$ 量级。利用倒数相位后，每个剩余类的这部分误差降至 $X^(1/3)$，在临界窗口内也能对一段幂次增长的模数求和。

#pagebreak()
= 三维上界筛
第 14 节的两种薄带分别使用多项式
#q.polys
第二种情形满足 $r s=6n+sigma$。当素数大于三时，它整除 $r s-sigma$ 等价于整除 $n$。为取上界，可以放宽 $r s equiv sigma mod 6$ 这一条件。取 $D=X^kappa$、$w=D^(1/40)<X^a$。第 13 节的每个候选分解都使相应的 $G_i$ 不含 $5<=p<=w$ 的素因子。

对 $p>=5$，禁用的剩余类对应于素数域中的 $r s=0$ 或 $r s=c$，其中 $c$ 非零。若 $r=0$，$s$ 的全部 $p$ 个取值均符合。每个非零 $r$ 对应两个取值 $0$ 和 $c/r$。因此
#q.gd
由中国剩余定理，无平方因子模数 $d$ 的禁用类数 $rho(d)$ 是各 $rho(p)$ 之积。满足 $d ∣ G_i$ 的点数以 $Delta (log 2)g(d)$ 为主项。根据第 14 节，余项 $E_d$ 的绝对值至多为常数乘以 $rho(d)(X^(1/3)+Delta/(d R))$。下式星号表示 $d$ 无平方因子且只含所筛的素数。由 $rho(d)<=d^2$、$3^(omega(d))<=d$ 得
#q.mass

对 $G_i$ 的值组成的多重集施行塞尔伯格上界筛，每个格点贡献一次。由筛的二次型得
#q.selberg
为估计 $J$，先暂时放开对 $d$ 大小的限制。所得完整和为 $product_(5<=p<=w)(1-g(p))^(-1) asymp (log w)^3$，这里用了默滕斯公式。将各项权重归一化后，素数被独立选入的概率为 $g(p)$。故 $log d$ 的期望为 $sum g(p)log p=3 log w+O(1)$。对充分大的 $X$，马尔可夫不等式说明至少一半权重满足 $d<=sqrt(D)=w^20$，从而 $J gt.double_(tau,a) ell^3$。代入余项估计，每个区段保留 $O_(tau,a)(Y/ell^3)$ 个候选，按第 13 节的区段求和即得定理 I。

*解析工具。* 经典偏差不等式可见 H. L. Montgomery，_Ten Lectures on the Interface Between Analytic Number Theory and Harmonic Analysis_，第 1 章。曲率估计见 #link("https://people.math.harvard.edu/~elkies/M229.19/vdc.pdf")[N. Elkies 讲义中的不等式 II]。所用塞尔伯格筛的精确形式见 #link("https://warwick.ac.uk/fac/sci/maths/people/staff/harper/elementarymethodsnotes1.pdf")[A. J. Harper，定理 2.7]。

#pagebreak()
= 长区间中的真实素数起点
#sub[定理 J　素数搭档或两个因子大小分离的搭档]
存在绝对常数 $0<b<1$、$0<gamma<1/12$，使每个符号及所有充分大的 $T$ 都有 $gt.double T/(log T)^2$ 个素数 $b T<p<=T$，其搭档或者为素数，或者满足
$ 6p+sigma=r s, quad T^(3/11)<r<T^(1/2-gamma), quad r<=s. $
其中 $r,s$ 均为素数，且 $s/r gt.double_b T^(2gamma)$。在 $[b T/2,T]$ 内存在测度为 $gt.double T$ 的一组实数起点 $x$，使临界窗口 $(x,x+H_x]$ 含有 $gt.double H_x/(log x)^2$ 个上述素数。这里 $H_x=sqrt(x)(log x)^(3/2)$。两种符号对应的起点集合可以不同。

对系数 $(6,sigma,1)$ 应用陈氏定理的线性形式。在 $p<=T$ 范围内至少有 $c_0 T/(log T)^2$ 个素数起点，其搭档为素数或两个素数之积，且每个素因子都大于 $T^(3/11)$。为减去 $p<=b T$，先直接计数 $p<=(b T)^(1/1000)$。对其余的 $n,6n+sigma$ 在 $b T$ 以内筛至 $(b T)^(1/1000)$。由第 8 节的剩余类数据，通常的二维上界筛给出 $O((b T)^(1/1000)+b T/(log(b T))^2)$，隐常数为绝对常数。事实上在长度为 $L$ 的区间只筛大于三的素数，无平方因子模数 $d$ 对应的余项为 $O(2^(omega(d)))$。取水平 $D=L^(1/8)$ 并筛至 $L^(1/1000)$，按第 15 节的论证取维数二，所得分母为 $gt.double (log L)^2$，余项之和为 $O(D^3)$。取足够小的 $b=2^(-m)$，即可保留原下界的一半。

对于其中仍满足 $r>=T^(1/2-gamma)$ 的双素因子搭档，将 $(b T,T]$ 分为若干 $(X,2X]$。这类数对在每个区间均计入 $S_(sigma)(1/2-gamma)-N_sigma$。在定理 I 中取 $a=1/4$，其总数为 $O((gamma+1/(log T))T/(log T)^2)$，隐常数可在选取 $gamma$ 前固定。因此取足够小的固定 $gamma>0$，便得到所述长区间下界。令 $h=H_(b T/2)$，用 $M(x)$ 表示 $(x,x+h]$ 中的计数。当 $T$ 充分大时，每个保留的素数 $p$ 贡献完整的一段 $[p-h,p) subset [b T/2,T]$。故 $M$ 在后一区间上的积分至少为 $c h T/(log T)^2$，其中 $c>0$。刚证明的局部上界筛给出 $M(x)<=C h/(log T)^2$。按 $M(x)$ 是否达到 $c h/(2(log T)^2)$ 拆分积分，即得达到该值的起点测度至少为 $c T/(2C)$。在此范围 $h<=H_x$ 且 $h asymp_b H_x$。

此外，对每个 $(T,2T]$ 和固定 $0<theta<1/4$，另有直接下界
#q.bv
每个与六互素的无平方因子模数只选出一个既约剩余类。Bombieri–Vinogradov 定理将直到 $D=sqrt(T)/(log T)^B$ 的总误差控制在 $O_(A)(T/(log T)^A)$ 内，其中 $B$ 取决于 $A$。因 $frac(log D,log(T^theta)) arrow.r 1/(2theta)>2$，一维下界筛 [6] 给出正系数。若筛至平方根，该比值趋于一，现有下界便不再为正。定理 J 的下界仍包含两个素因子大小分离的搭档。Lü、Wang 与 Wu 的莫比乌斯估计讨论平移 $p+2$ 上的整体和，该定理没有给出本文受限仿射数对上的估计。真素数对的统一下界仍待证明。

文献见 #link("https://arxiv.org/pdf/1906.05927")[Garcia 等，定理 6，转述 Friedlander 与 Iwaniec《Opera de Cribro》定理 25.11]，#link("https://personal.science.psu.edu/rcv4/Bombieri.pdf")[R. C. Vaughan 的 Bombieri–Vinogradov 定理讲义] 和 #link("https://arxiv.org/abs/2610.20242")[Lü、Wang、Wu，定理 1]。
