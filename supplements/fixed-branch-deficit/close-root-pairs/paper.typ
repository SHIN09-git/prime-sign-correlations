#let chinese = sys.inputs.at("lang", default: "en") == "zh"
#let p(en, zh) = if chinese { zh } else { en }
#let title-en = "Close pairs of roots of a reducible quadratic congruence at shifted moduli"
#let title-zh = "固定模数间距下可约二次同余根的近距离配对"
#let ink = rgb("#222b2c")
#let green = rgb("#245652")
#let rule = rgb("#b4c4c1")
#let small = rgb("#496361")
#let cjk = sys.inputs.at("cjk", default: "SimSun")
#let fonts = ("Libertinus Serif", cjk)
#set document(title: if chinese {title-zh} else {title-en}, author: "Codex",
  description: "A dyadic upper bound for close normalized roots of z(6z-1) at moduli q and q+d.")
#set page(paper: "a4", margin: (x: 22mm, top: 22mm, bottom: 21mm),
  header: context {set text(font: fonts, size: 8.8pt, fill: small)
    [#p[Fixed-branch prime pairs in short intervals][短区间中的固定两支素数对] #h(1fr)
    #p[Research note · November 2026][研究短稿 · 2026 年 11 月]]
    v(2pt); line(length: 100%, stroke: .45pt+rule)},
  footer: context {line(length: 100%, stroke: .45pt+rule); v(2pt)
    set text(font: fonts, size: 8.8pt, fill: small)
    [#p[Close roots at shifted moduli][固定模数间距下的近距离根对] #h(1fr) #counter(page).display("1")]})
#set text(font: fonts, size: if chinese {14.1pt} else {12.9pt},
  fill: ink, lang: if chinese {"zh"} else {"en"})
#set par(justify: false, leading: if chinese {.94em} else {.86em},
  spacing: if chinese {1.04em} else {1.02em})
#show math.equation.where(block: true): set block(above: .6em, below: .6em)
#let heading(en, zh) = {block(sticky: true, text(size: 18.5pt, weight: "bold", fill: green, p(en,zh))); v(4pt)}
#let sub(en, zh) = {v(2pt); block(sticky: true, text(size: 14pt, weight: "bold", fill: green, p(en,zh)))}
#let box(it) = block(width: 100%, fill: rgb("#f0f5f3"), stroke: (left: 1.4pt+green), inset: (x: 9pt, y: 6pt), it)
#let divs = $∣$
#let ref(url, name) = link(url, text(fill: green, name))
#let counts = json("counts.json").samples

#block(text(size: if chinese {22pt} else {22.5pt}, weight: "bold", fill: green, p(title-en,title-zh)))
#text(size: 10.5pt, fill: small)[Codex #h(1.1em) #p[26 November 2026][2026 年 11 月 26 日]]
#v(4pt)
#p[For squarefree moduli $q$ and $q+d$ in the same dyadic interval, consider roots of $z(6z-1) equiv 0$ divided by their respective moduli. Fix positive integers $d,a$ and a real $c>0$. Once small factors are removed, only $O_(a,d,c)(1)$ ordered root pairs per dyadic interval have multiplied phases within $c slash V$ of each other. We give a bound uniform in the multiplier, the shift and the radius. The argument counts denominators by a quadratic norm equation and counts their roots separately by congruences.][设无平方因子的两个模数 $q,q+d$ 位于同一倍增区间。对同余式 $z(6z-1) equiv 0$ 的根，分别用各自的模数作归一化。固定移位 $d$、正整数乘子 $a$ 和 $c>0$，排除含小因子的根后，每个倍增区间中，乘以 $a$ 后相位相距不超过 $c slash V$ 的有序根对只有 $O_(a,d,c)(1)$ 个。本文给出对乘子、移位和半径一致的上界。证明先用二次范数方程数分母，再用模坐标控制同一分母上的根数。]

#sub[1. The counting bound][1. 根对计数定理]
#p[Let $V>=2$, $1<=d<V$ and $a>=1$, with $a,d$ integers. For squarefree $q$, let $cal(R)(q;Y)$ consist of the integers $0<=z<q$ satisfying][设 $V>=2$，$a,d$ 为整数，$1<=d<V$、$a>=1$。对无平方因子的 $q$，记 $cal(R)(q;Y)$ 为满足下列条件的整数 $0<=z<q$]
$ q divs z(6z-1), quad m=gcd(z,q), quad n=q slash m, quad min(m,n)>Y. $
#p[For $0<=xi<=1 slash 2$, let $N_(a,d)(V,xi;Y)$ count all triples $(q,z,z')$ with $q'=q+d$, both moduli squarefree, $V<q<q'<=2V$, $z in cal(R)(q;Y)$, $z' in cal(R)(q';Y)$, and $norm(a(z slash q-z' slash q'))<=xi$. The double bars denote distance to the nearest integer. Write $tau$ for the number of positive divisors and $omega$ for the number of distinct prime divisors.][对 $0<=xi<=1 slash 2$，记 $N_(a,d)(V,xi;Y)$ 为满足下列条件的三元组 $(q,z,z')$ 个数。两模数 $q,q'=q+d$ 均无平方因子，$V<q<q'<=2V$，$z in cal(R)(q;Y)$、$z' in cal(R)(q';Y)$，且 $norm(a(z slash q-z' slash q'))<=xi$。双竖线表示到最近整数的距离。$tau$ 计正约数，$omega$ 计不同素因子。]

#box[#p[*Theorem 1.* Suppose $Y>=a d$. Set][*定理 1.* 设 $Y>=a d$，令]
$ T=floor(24V^2 xi^2+a d xi), quad M=max(a^2,6T). $
#p[Then][则有]
$ N_(a,d)(V,xi;Y) <= 2^(1+omega(a)+omega(d)) tau(d^2)
 sum_(1<=t<=T,6t!=a^2) tau(abs(a^2-6t))  quad (1) $
#p[and the sum on the right is at most $2M(1+log M)$. All logarithms are natural.][且右侧的约数和至多为 $2M(1+log M)$。文中对数均为自然对数。]]

#p[In particular, with an absolute implied constant and $X=1+a^2+V^2xi^2$,][特别地，取 $X=1+a^2+V^2xi^2$，以下隐常数为绝对常数]
$ N_(a,d)(V,xi;Y) ≪ 2^(omega(a)+omega(d))tau(d^2) X log(2X). quad (2) $
#p[Indeed $d<V$ gives $a d xi<=(a^2+V^2xi^2) slash 2$. Taking $xi=min(1 slash 2,c slash V)$ gives the bound in the abstract, uniformly in $Y>=a d$, since a circular distance never exceeds $1 slash 2$. The multiplier may share primes with either modulus.][这是因为 $d<V$ 给出 $a d xi<=(a^2+V^2xi^2) slash 2$。圆周距离至多为 $1 slash 2$，故取 $xi=min(1 slash 2,c slash V)$ 就得到摘要中的结论，对 $Y>=a d$ 一致。乘子可以与任一模数有公共素因子。]

#pagebreak()
#heading[2. The determinant of two roots][2. 两个根的行列式]
#p[At each prime $p>=5$ dividing $q$, the residue of $z$ is either $0$ or $6^(-1)$ modulo $p$. At 2 and 3 only zero is possible. As $q$ is squarefree, choosing the zero coordinates gives $m=gcd(z,q)$. The complementary product $n=q slash m$ satisfies $(6m,n)=1$. Conversely, for such a split with both factors greater than $Y$, the unique root is $z=m r$, where $0<=r<n$ is the inverse of $6m$ modulo $n$. Thus $z slash q=r slash n$. A prime dividing both moduli has a root coordinate on each side. Both choices enter the count.][若素数 $p>=5$ 整除 $q$，根的模 $p$ 坐标可以取 0 或 $6^(-1)$。在 2 和 3 处只能取 0。因 $q$ 无平方因子，取零坐标的素数之积为 $m=gcd(z,q)$，余下的乘积 $n=q slash m$ 满足 $(6m,n)=1$。反过来，对每个符合因子下界的这类分拆，取 $6m$ 模 $n$ 的逆元 $0<=r<n$，就得到唯一的根 $z=m r$，且 $z slash q=r slash n$。两端模数有公因子时，同一素数可在两端分别出现。]

#p[Write $q'=m'n'$ and use primed letters for its root. Put][写 $q'=m'n'$，其余相应量加上撇号。令]
$ P=m m', quad R=n n', quad Q=P R=q q', quad kappa=r n'-r'n. $
#p[From $6m r=1+n c$ and $6m'r'=1+n'c'$ we obtain $6P kappa=d+R(m'c-m c')$. Let $k$ be the representative of $a kappa$ modulo $R$ in $[-R slash 2,R slash 2)$ and put $y=k slash R$. The proximity test is exactly $abs(y)<=xi$. Some integer $l$ satisfies][由 $6m r=1+n c$、$6m'r'=1+n'c'$，得 $6P kappa=d+R(m'c-m c')$。将 $a kappa$ 模 $R$ 的代表元 $k$ 取在 $[-R slash 2,R slash 2)$，令 $y=k slash R$，相位条件即 $abs(y)<=xi$。存在整数 $l$ 使]
$ 6P k-R l=a d, quad t=k l=6Q y^2-a d y. quad (3) $
#p[All four factors exceed $a d$. Thus $R,6P>a d$, and $k,l$ are nonzero with the same sign. In particular, $1<=t<=T$ for each counted pair. Completing the square in (3) gives][四个因子都大于 $a d$，故 $R,6P>a d$，$k,l$ 均非零且同号。每个合格根对都给出 $1<=t<=T$。对（3）配方得到]
$ D=6t, quad v=2q+d, quad u=12P k-a d=12Q y-a d, $
$ u^2-D v^2=(a^2-D)d^2, quad u^2=4D Q+a^2d^2. quad (4) $
#p[For fixed $q,d,a,t$, the sign of $u$ determines $y$. These relations are necessary for a pair to be counted. For the upper bound we may count every solution of the norm equation and then bound the multiplicity of genuine roots.][给定 $q,d,a,t$ 后，$u$ 的符号决定 $y$。这些等式是实际根对须满足的必要条件。求上界时可以先数范数方程的全部解，再控制每个解对应的实际根数。]

#sub[The zero-norm case][零范数的排除]
#p[If $D=a^2$, then $u=plus.minus a v$. Hence $6P k=a q'$ or $6P k=-a q$. Cancelling $m'$ or $m$ gives $6k m=a n'$ or $6k m'=-a n$. Since $(m,n')$ and $(m',n)$ both divide $d=q'-q$, these alternatives force $m<=a d$ or $m'<=a d$. Each contradicts the factor cutoff. Thus $a^2-6t!=0$.][若 $D=a^2$，则 $u=plus.minus a v$，所以 $6P k=a q'$ 或 $6P k=-a q$。约去 $m'$ 或 $m$，得 $6k m=a n'$ 或 $6k m'=-a n$。因 $(m,n')$ 和 $(m',n)$ 都整除 $d=q'-q$，两种情形分别给出 $m<=a d$ 或 $m'<=a d$，均与因子下界矛盾。故 $a^2-6t!=0$。]

#pagebreak()
#heading[3. Counting denominators and roots][3. 分母数与同一分母的根数]
#p[*Lemma 2.* For fixed $a,d,t$ arising in (3), the number of distinct denominator pairs $(q,q+d)$ in the band is at most $tau(abs(a^2-6t)d^2)$.][*引理 2.* 固定（3）中出现的 $a,d,t$，这段区间内不同分母对 $(q,q+d)$ 的个数至多为 $tau(abs(a^2-6t)d^2)$。]

#p[Write $N=(a^2-D)d^2!=0$. If $D=s^2$ is a square, the positive integer $abs(u)+s v$ divides $abs(N)$. Its value determines $abs(u)-s v$ and hence $v$. Suppose next that $D$ is nonsquare. The algebraic integer $gamma=abs(u)+v sqrt(D)$ in the real quadratic field $bb(Q)(sqrt(D))$ has norm $N$. The number of integral ideals of norm $abs(N)$ is at most $tau(abs(N))$. Indeed at a split rational prime $p$ there are $e+1$ choices for an ideal of norm $p^e$, and at an inert or ramified prime there is at most one. This uses unique factorization of ideals in the full ring of integers #ref("https://www.jmilne.org/math/CourseNotes/ANT.pdf", "[3]").][令 $N=(a^2-D)d^2!=0$。若 $D=s^2$ 为平方数，则正整数 $abs(u)+s v$ 整除 $abs(N)$。它决定 $abs(u)-s v$，继而决定 $v$。若 $D$ 非平方，实二次域 $bb(Q)(sqrt(D))$ 的代数整数 $gamma=abs(u)+v sqrt(D)$ 具有范数 $N$。范数为 $abs(N)$ 的整理想至多有 $tau(abs(N))$ 个。对分裂素数 $p$，范数为 $p^e$ 的理想有 $e+1$ 种，对惰性或分歧素数至多一种。这里用到全整数环中理想的唯一分解。#ref("https://www.jmilne.org/math/CourseNotes/ANT.pdf", "[3]")]

#p[The dyadic restriction gives at most one such $gamma$ per ideal. A nonempty set of roots implies $a d<sqrt(q)<=sqrt(2V)<=V$. From $V^2<Q<=4V^2$, $2V<v<=4V$ and (4),][每个理想在此倍增区间至多给出一个 $gamma$。若有实际根对，则 $a d<sqrt(q)<=sqrt(2V)<=V$。由 $V^2<Q<=4V^2$、$2V<v<=4V$ 和（4）得]
$ 4V sqrt(D)<gamma<=(4+sqrt(17))V sqrt(D). quad (5) $
#p[The ratio of two distinct generators of the same ideal and the same signed norm, ordered by their positive real values, is a norm-one unit $epsilon>1$. Its trace $epsilon+epsilon^(-1)$ is an integer at least 3. Thus $epsilon>=(3+sqrt(5)) slash 2>(4+sqrt(17)) slash 4$, contrary to (5). The value of $gamma$ determines $v$ and hence $q$. This proves the lemma, including nonsquare $D$ with a square factor.][同一理想中两个不同的正生成元若带符号的范数相同，大者除以小者是范数为 1 的单位 $epsilon>1$。其迹 $epsilon+epsilon^(-1)$ 为至少 3 的整数，故 $epsilon>=(3+sqrt(5)) slash 2>(4+sqrt(17)) slash 4$，与（5）矛盾。$gamma$ 决定 $v$ 及 $q$，引理得证。非平方的 $D$ 可以含平方因子。]

#sub[Root multiplicity and the end of the proof][根的重数与定理的证明]
#p[Put $g=(q,q')$ and $M_0=q q' slash g$. Prescribing $y$ modulo one fixes the following residue modulo the squarefree integer $M_0$:][令 $g=(q,q')$、$M_0=q q' slash g$。给定 $y mod 1$，就确定了下式在无平方因子模数 $M_0$ 下的余类]
$ a((q' slash g)z-(q slash g)z') quad (mod M_0). quad (6) $
#p[At $p$ dividing only one modulus and not $a$, (6) fixes that root coordinate. At $p divs g$, $p$ not dividing $a$, either coordinate determines the other, so at most two choices remain. At $p divs a$ there are at most two choices on a single end and four on a common prime. The Chinese remainder theorem therefore gives at most $2^(omega(a)+omega(g))$ pairs for prescribed $q$ and $y$. For a given $t$ there are two possible signs of $u$. Now $g divs d$ and $tau(abs(N))<=tau(d^2)tau(abs(a^2-6t))$, proving (1). Each positive integer $|a^2-6t|<=M$ occurs at most twice, and $sum_(n<=M)tau(n)<=M(1+log M)$. This proves (2).][若 $p$ 只整除一端且不整除 $a$，则（6）确定该端的坐标。若 $p divs g$ 且不整除 $a$，给定一端便确定另一端，至多两种。若 $p divs a$，单端的素数至多有两种选择，共有素数至多四种。由中国剩余定理，给定 $q,y$ 的根对数至多为 $2^(omega(a)+omega(g))$。固定 $t$ 时 $u$ 有两个符号。由 $g divs d$ 及 $tau(abs(N))<=tau(d^2)tau(abs(a^2-6t))$ 得（1）。每个正整数 $abs(a^2-6t)<=M$ 至多出现两次，又 $sum_(n<=M)tau(n)<=M(1+log M)$，即得（2）。]

#pagebreak()
#heading[4. Square discriminants and small factors][4. 平方判别数与小因子]
#p[*Proposition 3.* If $Y>=6a d$ and $V>20d^4(a^2+d^2)$, the actual root pairs have nonsquare $6t$ throughout $abs(y)<=1 slash 2$.][*命题 3.* 若 $Y>=6a d$ 且 $V>20d^4(a^2+d^2)$，则在整个 $abs(y)<=1 slash 2$ 范围内，实际根对的 $6t$ 均非平方数。]

#p[Suppose $D=s^2$. The zero-norm case was excluded above. Since $D=36Q y^2-6a d y<=36V^2+3a d$, we have $1<=s<=7V$. The nonzero integer $i=abs(u)-s v$ satisfies][假设 $D=s^2$，零范数情形已在第 2 节排除。由 $D=36Q y^2-6a d y<=36V^2+3a d$ 得 $1<=s<=7V$。非零整数 $i=abs(u)-s v$ 满足]
$ i(2s v+i)=(a^2-s^2)d^2, quad
 1<=abs(i)<=frac(a^2 d^2,2V)+frac(s d^2,2V). $
#p[The first term is less than $1 slash 2$. Hence $s>=V slash d^2$ and $abs(i)<=4d^2$. Reducing the equality modulo $s$ gives $s divs a^2d^2-i^2$. The absolute value on the right is at most $a^2d^2+16d^4<V slash d^2$. Consequently $i^2=a^2d^2$, and substitution gives $i=-a d$ and $s=2a v slash d$. Solving $12Q y-a d=plus.minus(s v-a d)$ leaves only][右边第一项小于 $1 slash 2$，故 $s>=V slash d^2$ 且 $abs(i)<=4d^2$。对等式模 $s$ 化简，得 $s divs a^2d^2-i^2$，而右侧绝对值至多为 $a^2d^2+16d^4<V slash d^2$。所以 $i^2=a^2d^2$。代回给出 $i=-a d$、$s=2a v slash d$。解 $12Q y-a d=plus.minus(s v-a d)$，只余两种可能]
$ y=-frac(2a,3d) quad #p("or","或") quad y=frac(2a,3d)+frac(a d,6Q). quad (7) $
#p[In the first case, any prime dividing $n$ but not $3a d$ cannot divide $n'$ since $(n,n') divs d$. It survives in the reduced denominator of $a(r slash n-r' slash n')$, contradicting (7) modulo one. Thus $n divs 3a d$, since $n$ is squarefree. In the second case use $r slash n-1 slash (6q)=c slash (6m)$, where $(c,6m)=1$. The difference of the two corrections is $d slash (6Q)$. Hence $a(c slash (6m)-c' slash (6m')) equiv 2a slash (3d) mod 1$. A prime dividing $m$ but not $6a d$ survives in this reduced denominator, since $(m,m') divs d$. We get $m divs 6a d$. Both cases contradict the cutoff.][第一种情形中，整除 $n$ 而不整除 $3a d$ 的素数不能整除 $n'$，因为 $(n,n') divs d$。它必在 $a(r slash n-r' slash n')$ 的最简分母中，与（7）模 1 的值矛盾。因此无平方因子的 $n$ 整除 $3a d$。第二种情形用 $r slash n-1 slash (6q)=c slash (6m)$，其中 $(c,6m)=1$。两端修正项的差为 $d slash (6Q)$，故 $a(c slash (6m)-c' slash (6m')) equiv 2a slash (3d) mod 1$。整除 $m$ 而不整除 $6a d$ 的素数必留在左侧最简分母中，因为 $(m,m') divs d$。所以 $m divs 6a d$。两种可能均与因子下界矛盾。]

#sub[Why exclude small factors?][为何须排除小因子]
#p[Even nonzero roots can give a positive-density family of near matches if $m=1$ is allowed. Take $a=1$, $d=6$, $q equiv 1 (mod 6)$ and $q'=q+6$, with both moduli squarefree. The inverse of 6 is $z=(5q+1) slash 6$, and the difference of the two normalized roots is exactly $1 slash (q q')$. There are $≫V$ such denominator pairs in a large dyadic interval. Indeed the density is $(1 slash 6)product_(p>=5,p thin "prime")(1-2 slash p^2)>0$. The finite product follows by the Chinese remainder theorem, and primes $p>B$ remove at most $O(V sum_(p>B)p^(-2)+sqrt(V))$ integers. This example also explains why deleting only the zero root would leave a different counting problem.][若允许 $m=1$，即使只取非零根，也会出现正密度的极近配对。取 $a=1$、$d=6$、$q equiv 1 (mod 6)$、$q'=q+6$，两模数均无平方因子。$6$ 的模逆元是 $z=(5q+1) slash 6$，两端归一化根之差恰为 $1 slash (q q')$。在大倍增区间中，这样的分母对有 $≫V$ 个。其密度为 $(1 slash 6)product_(p>=5,p thin "为素数")(1-2 slash p^2)>0$。有限素数的乘积由中国剩余定理给出，大素数 $p>B$ 至多剔除 $O(V sum_(p>B)p^(-2)+sqrt(V))$ 个整数。因此，只删去零根仍会留下这一族配对。]

#pagebreak()
#heading[5. A weighted consequence for the prime-pair model][5. 素数配对模型中的加权推论]
#p[The motivating problem counts primes $p$ for which $6p-1$ or $6p+1$ is also prime, counting both hits when applicable #ref("https://github.com/SHIN09-git/prime-sign-correlations/tree/41b4fc6b14bbd1160314276bf4e6f5eb13c1522a/supplements/fixed-branch-deficit", "[5]"). Möbius expansions give up to two choices at each prime of a squarefree modulus and hence to the roots in Section 1. The following consequence is stated directly for these roots.][原问题对素数 $p$ 分别检查 $6p-1$ 和 $6p+1$ 是否为素数，两支命中时计两次。#ref("https://github.com/SHIN09-git/prime-sign-correlations/tree/41b4fc6b14bbd1160314276bf4e6f5eb13c1522a/supplements/fixed-branch-deficit", "[5]") 莫比乌斯展开在无平方因子模数的每个素因子上给出至多两种选择，得到第 1 节的根。以下推论直接对根对陈述。]

#p[*Corollary 4.* Write $L=log Z$, $L_2=log L$, $V asymp sqrt(Z)L^(3 slash 4)$, $b>=1$ a fixed integer, $2<=A,U<=L^C$ and $Y>=A b U$. In each shift $d=b h$ sum any subset of the triples counted by $N_(a,d)(V,xi;Y)$, with coefficients satisfying $abs(w)<=L_2^4 slash a$ up to a fixed factor. Define the absolute contribution][*推论 4.* 记 $L=log Z$、$L_2=log L$、$V asymp sqrt(Z)L^(3 slash 4)$。固定正整数 $b$，令 $2<=A,U<=L^C$、$Y>=A b U$。在每个移位 $d=b h$，可取 $N_(a,d)(V,xi;Y)$ 中任意一组根对，系数满足 $abs(w)≪L_2^4 slash a$，隐常数固定。定义绝对贡献]
$ cal(A)(xi)=frac(1,V U)sum_(1<=h<U)sum_(1<=a<=A)sum_("selected") abs(w). $
#p[For all sufficiently large $Z$ and all $0<=xi<=1 slash 2$, one has][则对所有充分大的 $Z$ 和所有 $0<=xi<=1 slash 2$ 有]
#box[$ cal(A)(xi)≪ L L_2^11 (V xi^2+(1+A^2) slash V). quad (W) $]
#p[In (2), $log(2X)≪L$. The sum of $2^(omega(a)) slash a$ for $a<=A$ is $O((1+log A)^2)$ by $2^(omega(a))<=tau(a)$. For the shift factors, let $tau_6(n)$ count ordered factorizations into six positive integers. Comparing at prime powers gives $2^(omega(d))tau(d^2)<=tau_6(d)$ and $tau_6(b h)<=tau_6(b)tau_6(h)$. Summing five harmonic series gives $sum_(h<U)tau_6(h)≪U(1+log U)^5$. These bounds prove (W). The implied constant can depend on $b,C$, the coefficient bound and the fixed comparability constants for $V$.][在（2）中 $log(2X)≪L$。由 $2^(omega(a))<=tau(a)$ 得 $sum_(a<=A)2^(omega(a)) slash a≪(1+log A)^2$。令 $tau_6(n)$ 计正整数的六个有序因子分解。在素数幂上比较可得 $2^(omega(d))tau(d^2)<=tau_6(d)$ 且 $tau_6(b h)<=tau_6(b)tau_6(h)$。求和五次调和级数，得 $sum_(h<U)tau_6(h)≪U(1+log U)^5$。合并即得（W）。隐常数可依赖 $b,C$、系数界和 $V$ 的固定比较常数。]

#p[In the motivating sum $b=432$. The two denominator weights are $mu(q)h(q)$ and $mu(q')h(q')$, with $h(q)=product_(p divs q)p slash (p-nu_p)$, $nu_2=nu_3=1$ and $nu_p=2$ otherwise. Mertens' product bound gives $h(q)≪L_2^2$ (split primes at $log(3q)$). A bounded smooth average over multiples of $a$ in $1<=j<=3J$, normalized by $J$, costs $O(1 slash a)$. The additional sieve sign $mu(a)$ and a bounded triangular shift weight are allowed. Thus the radius][在原和中 $b=432$，两端分母权为 $mu(q)h(q)$、$mu(q')h(q')$，其中 $h(q)=product_(p divs q)p slash (p-nu_p)$，$nu_2=nu_3=1$，其余为 2。在 $log(3q)$ 处分开素因子并使用 Mertens 乘积界，得 $h(q)≪L_2^2$。在 $1<=j<=3J$ 中对 $a$ 的倍数作有界光滑平均并除以 $J$，得到的核为 $O(1 slash a)$。额外的筛符号 $mu(a)$ 与有界三角移位权也符合假设。因而取半径]
$ xi=V^(-1 slash 2)L^(-3 slash 10) quad => quad cal(A)(xi)≪L^(2 slash 5)L_2^11=o(sqrt(L)). $
#p[This removes the extreme near-phase contribution at the target scale. At the fixed centre $3Z slash 2$, the wider signed phase range remains to be bounded. The corresponding bound for maximal prefix sums over the denominators and the uniform mean bound for actual prime pairs remain open.][这部分极近相位的总量低于目标量级。在固定中心 $3Z slash 2$，较宽相位范围内的带符号和仍待估计。原问题中的分母短和最大前缀均方界，以及真实素数配对的全高度一致平均上界，均待证明。]

#pagebreak()
#heading[6. Exact finite counts and related work][6. 有限区间的精确计数与相关文献]
#p[The table counts all ordered root pairs in each full interval $V<q<q+d<=2V$ for the displayed parameters. The four columns are cumulative counts at the indicated radii. The multiplier $a$ is unrestricted by divisibility of $q(q+d)$.][下表对指定参数及完整区间 $V<q<q+d<=2V$ 枚举所有有序根对。后四列是相应半径以内的累计数，此处不要求 $a$ 整除 $q(q+d)$。]
#align(center, table(columns: (auto,auto,auto,auto,auto,auto,auto,auto), align: right,
  inset: (x: 5pt, y: 4.1pt), stroke: none,
  table.hline(stroke: .7pt+green), [$V$],[$a$],[$d$],[$Y$],[$1 slash V$],[$4 slash V$],[$16 slash V$],[$1 slash sqrt(V)$],
  table.hline(stroke: .4pt+rule),
  ..counts.map(r=>([#r.V],[#r.a],[#r.d],[#r.Y],..r.counts.map(n=>[#n]))).flatten(),
  table.hline(stroke: .5pt+green)))
#p[The first enumeration splits $q=m n$ and inverts $6m$ modulo $n$. The second lifts all polynomial roots by the Chinese remainder theorem. It counts proximity with $B$, the centered residue of $a(z q'-z' q)$ modulo $Q=q q'$, and computes $t=B(6B-a d) slash Q$. The two methods examine 182,000 candidate pairs across the six bands. Their complete sorted records agree at $xi=1 slash sqrt(V)$ and their counts agree at all four radii. All comparisons use integers. Run `python check_counts.py` to repeat the table and verify its fingerprints.][第一种枚举分解 $q=m n$ 并计算 $6m$ 模 $n$ 的逆元。第二种用中国剩余定理合成多项式的全部根，再取 $a(z q'-z'q)$ 模 $Q=q q'$ 的居中余数 $B$，由 $t=B(6B-a d) slash Q$ 独立计算行列式乘积。两种方法在六组区间中各检查 182,000 个候选根对。在 $xi=1 slash sqrt(V)$ 处，全部排序记录逐项相同，四个半径上的计数也全部相同。所有判定均使用整数。运行 `python check_counts.py` 可重算表格并核对记录的指纹。]

#p[The supplementary archive also contains the original six finite signed-window computations. Those runs used a different factor cutoff, which can be smaller than $a d$. They illustrate cancellation in the motivating problem. The table above uses the hypotheses of Theorem 1.][随稿附件另收录原来的六组有限带符号窗口计算。它们使用另一因子截点，可以小于 $a d$，用于观察原问题中的抵消。本页表格单独按定理 1 的假设生成。]

#sub[Context and sources][文献与研究来源]
#p[Dartyge and Martin study exponential sums over roots of reducible polynomials, summed over a modulus variable [1]. Marklof and Welsh obtain pair-correlation laws for roots of $x^2 equiv D (mod m)$ for a different discriminant family [2]. Here both moduli must occur at a prescribed shift and both factors attached to each root exceed a cutoff. The quadratic ideal argument in Section 3 uses classical norm and unit theory [3, 4].][Dartyge 与 Martin 研究对一个模数变量求和的可约多项式同余根指数和 [1]。Marklof 与 Welsh 对另一判别数族的 $x^2 equiv D (mod m)$ 建立根的成对关联律 [2]。本文固定两个模数之差，并对每个根的两个因子都设下界。第 3 节的二次域论证使用经典的理想范数和单位理论 [3, 4]。]
#block({
  set text(size: if chinese {11.2pt} else {10.7pt})
  set par(spacing: .55em, leading: .56em)
  [#ref("https://arxiv.org/abs/1802.09090", "[1] C. Dartyge & G. Martin, Exponential sums with reducible polynomials.") #emph[Discrete Analysis] 2019, Paper 15.

  #ref("https://arxiv.org/abs/2105.02854", "[2] J. Marklof & M. Welsh, Fine-scale distribution of roots of quadratic congruences.") #emph[Duke Math. J.] 172 (2023), 2303–2364.

  #ref("https://www.jmilne.org/math/CourseNotes/ANT.pdf", "[3] J. S. Milne, Algebraic Number Theory, v3.08 (2020), Chap. 3.")

  #ref("https://math.stanford.edu/~conrad/154Page/handouts/genpell.pdf", "[4] B. Conrad, Generalized Pell equation, Math 154, Stanford University.")

  #ref("https://github.com/SHIN09-git/prime-sign-correlations/tree/41b4fc6b14bbd1160314276bf4e6f5eb13c1522a/supplements/fixed-branch-deficit", "[5] GPT-6.2 Astra & JIN HANZHE, Fixed-branch prime pairs in short intervals (2026).")]
})
#p[This continuation was prepared with OpenAI Codex in the research project cited in [5]. The proof and finite computations are supplied with their sources.][本篇由 OpenAI Codex 按文献 [5] 项目的研究方向续作，证明原稿与有限计算的源码随稿公开。]
