#import "layout.typ": *
#import "transition-equations.typ" as e
= When does the ordering first reverse?
Write $I_h(x)=bold(1)_(psi(e^h x)-psi(x)>(e^h-1)x)$. The cumulative joint excess mass and the first contact after the positive lead of ratio 4 at $B=4$ are
#e.diff
We take $inf emptyset=+infinity$. Both masses are continuous in $B$. Dividing both by $log(B/3)$ gives the measured frequencies and leaves their ordering intact. For the rest of §§9–12 put $delta=e^h-1$ and
#e.scale
Let $P_M(u)$ count primes $n$ in $(M,M+u]$ for which $6n+1$ is prime, plus the analogous count for $6n-1$. A prime satisfying both conditions contributes twice.

#lead[Theorem 4.][For every sufficiently small fixed positive $c$ and all sufficiently large real $M$, the first inequality in @location holds, including when the contact set is empty. The sharp limit in @location is equivalent to the local prime-pair law @pairlaw.]
#e.barrier
In fact every fixed $c<1/sqrt(16S log 2)$ is admissible in the lower bound. The additional hypothesis for the limit is
#e.local
We only use this hypothesis at fixed positive $v$ as $M$ tends to infinity. For either sign the two linear forms lose one residue class at 2 and 3, and two classes at larger primes. Each predicted singular series is $4C_2$ [12]. The lower bound in Theorem 4 uses elementary arithmetic and an upper-bound sieve. It requires no hypothesis on primes or zeta zeros.

There is also a converse obstruction. An upper bound $B_*(M)<=M+C H_M$ for all sufficiently large $M$ and some fixed $C$ would give $P_M(C H_M) >>_C H_M/ell^2$ in *every* such interval. In particular the global count of these signed prime pairs up to $X$ would be $>>_C X/(log X)^2$. The global prime-pair asymptotic, without its short-interval version, already implies the weaker conclusion $B_*(M)/M->1$.

#pagebreak()
= Arithmetic at the first overlap
In the range $3<=x<=(1+1/100)M$ the base window has length below one and below $log 2$. Its excess indicates the presence of a unique prime power $n$. If both windows contain prime powers $n,m$ then $abs(m-q n)<q delta x$. At $q=4$ this is less than $log 2<1$, so $m=4n$. Unique factorization gives $n=2^j$. Each complete base interval $(2^j/r,2^j)$ contributes $h$, with $r=1+delta$. Endpoint conventions do not affect integrals. Thus $C_4(4)=h$, and, uniformly for $0<=t<=M/100$,
$ C_4(M+t)=ell/(6M log 2)+O(1/M). $ <fourmass>

At $q=6$, $m=6n$ cannot be a prime power. There is no contribution through $x=M$. Just above $M$ the only possibilities are $m=6n+1$ and $6n-1$. Their prime bases are at least 5, whose logarithm exceeds the second length $6delta x<=1.01$. Each such mass suffices to trigger an excess. The two candidates differ by 2 and cannot both occur in the same second window for a fixed $x$. For one candidate the uncut overlap in logarithmic measure is
$ (h-abs(log(1 plus.minus 1/(6n))))_+ . $
The plus branch opens at $n>M$ and the minus branch at $n>M+1/6$. For $n=M+v$, $0<=v<=M/100+1$, Taylor's theorem gives $v/(6M^2)+O(M^(-2)+v^2/M^3)$ for each clipped weight. The shift of the minus opening is absorbed by $O(M^(-2))$.

For $0<=t<=Z H_M$, $Z$ fixed, cutting at the top clips at most two base candidates, at cost $O((t+1)/M^2)$. Summing the Taylor errors costs $O((t+1)/M^2+(t+1)^3/M^3)$. Replacing prime powers by primes also costs $o(ell/M)$. Indeed in a segment of length $O(t+1)$ near $M$ or $6M$, the number of proper powers is $O(t/sqrt(M)+log M+t(log M)/M^(2/3))$. Count squares separately, then apply the mean value theorem to each root of order $j>=3$, with $j=O(log M)$. Each discarded overlap weighs $O((t+1)/M^2)$. We have proved the unconditional reduction
#e.reduction

#pagebreak()
= A sieve bound and its converse
For the two forms $n,6n+1$, or $n,6n-1$, choose $z=sqrt(u)/(log u)^3$ on an interval of length $u$ starting at $M$, with $u<=M$. We use Selberg’s upper-bound sieve [16]. Let $nu(p)$ be the number of forbidden classes, one for 2 and 3 and two for all larger primes. On squarefree $d$ with primes up to $z$ extend $nu$ multiplicatively and put $g(d)=nu(d)/d$. The Chinese remainder theorem gives $u g(d)+O(nu(d))$ occurrences of divisibility. Majorize survivors by the square of the sum of $lambda_d$ over supported $d<=z$ dividing $n(6n plus.minus 1)$, with $lambda_1=1$. All counted prime pairs survive at these large starting points.

Put $j(p)=1/g(p)-1$, extended multiplicatively, and $J=sum_(l<=z)1/j(l)$ over the squarefree support. The main quadratic form per unit length diagonalizes as $sum_l j(l)y_l^2$, where $y_l=sum_(l | d)lambda_d g(d)$, by expanding $1/g("gcd"(d,e))$. Choose $y_l=mu(l)/(j(l)J)$. Möbius inversion gives $lambda_1=1$ and $abs(lambda_d)<=1$: in the numerator the sum over $e<=z/d$ coprime to $d$ is multiplied by $product_(p|d)(1+1/j(p))$, and every product of $e$ with a divisor of $d$ occurs in $J$. The main form is $1/J$. The total remainder is bounded by $(sum_(d<=z)tau(d))^2 << z^2(log(2z))^2$, since $nu("lcm"(d,e))<=tau(d)tau(e)$.

The Dirichlet series of the squarefree weights $1/j(l)$ is $zeta(1+v)^2 G(v)$ with $G(0)=1/S_1$, where $S_1=4C_2$ is the singular series for one sign. For $p>3$ its residual Euler factor is $(1-p^(-1-v))^2(1+2p^(-v)/(p-2))$. After expansion the linear coefficient in $p^(-v)$ is $O(p^(-2))$ and the next two are $O(p^(-2)),O(p^(-3))$. Thus the coefficients of $G$ are absolutely summable even at $v=-1/4$. Convolution with $sum_(n<=x)tau(n)/n=(log x)^2/2+O(log(2x))$ gives $J=(log z)^2/(2S_1)+O(log z)$. Summing the two sieve bounds yields $P_M(u)<=(8S+o(1))u/(log u)^2$ uniformly in the translate as $u$ grows.

Partition $(M,M+z_0 H_M]$ into a fixed number of equal intervals, $z_0>0$. If $u$ denotes one subinterval length, then $log u=ell/2+o(ell)$. Applying the bound on each piece, then taking the upper Riemann sums to the integral, gives a limsup of at most $16 S z_0^2$ for $ell^2/H_M^2 integral_((0,z_0 H_M]) v dd P_M(v)$. Monotonicity and @fourmass therefore exclude all contacts up to $M+z_0 H_M$ if $16 S z_0^2<1/(log 2)$. Conversely a contact by $M+C H_M$ forces $P_M(C H_M)>>_C H_M/ell^2$ by @pairreduction. Tiling $[X/2,X]$ with disjoint successive intervals of length $C H_M$ proves the global lower bound.

#pagebreak()
= The first-passage profile
Under @pairlaw the increasing functions $ell^2 P_M(v H_M)/H_M$ converge uniformly on every compact interval $0<=v<=Z$, by subdivision and continuity of $S v$. Partial summation now gives $ell^2/H_M^2 integral_((0,z H_M])v dd P_M(v) -> S z^2/2$ locally uniformly for $z>=0$. Together with @fourmass and @pairreduction this yields
#e.profile
The continuous limiting profile is positive below its unique positive root and negative above it. There is no contact between $4$ and $M$. Uniform convergence up to any point below the root excludes earlier contacts, and a single point above it forces a contact by continuity. This proves the location limit, including its constant. For the weaker global assertion, take any fixed $0<epsilon<1/100$. A global asymptotic with positive constant supplies $>>_epsilon M/ell^2$ pairs for $M+epsilon M/3<n<M+2epsilon M/3$. Each contributes $>>_epsilon 1/M$ before $(1+epsilon)M$. This outweighs @fourmass. Let $epsilon$ decrease to zero.

#sub[First crossings from exact counts]
For $delta=1/b$, the following are the first contacts after $B=4$. Each open decimal interval has width $10^(-8)$.

#table(columns:(.7fr,1.8fr,.7fr,1.8fr),align:center,inset:3.4pt,stroke:none,
 table.hline(),table.header([$b$],[First contact $B$],[$b$],[First contact $B$]),table.hline(stroke:.4pt),
 [32],[(7.97592246, 7.97592247)],[256],[(106.70775594, 106.70775595)],
 [64],[(22.76492957, 22.76492958)],[512],[(168.76281382, 168.76281383)],
 [128],[(48.66785923, 48.66785924)],[1024],[(312.91048562, 312.91048563)],table.hline())

On a common constant-count cell $[u,v]$ each joint excess set is an initial segment, ending at $c_4$ or $c_6$ after clipping. The signed mass at $x$ in this cell is its starting value $g$ plus $log(min(x,c_4)/min(x,c_6))$. It is monotone on each cell. Endpoint enclosures exclude every earlier contact. In the first crossing cell $c_4 e^g$ lies strictly between $c_4$ and $c_6$. A second calculation uses rational midpoints and separate prime-count prefix sums to check the two decimal endpoints. These are individual finite-width certificates. The asymptotic constant in @firstprofile depends on @pairlaw.

#pagebreak()
#sub[Why the sharp location determines the short-interval law]
In fact any finite positive limit $b$ of $(B_*(M)-M)/H_M$ as *all* real $M$ tend to infinity forces @pairlaw with density $2/(b^2 log 2)$. Consider the measures $mu_M$ which put mass $ell^2/H_M$ at each scaled displacement $(n-M)/H_M$ of a prime pair, with the two signs counted separately. On every fixed interval of scaled length $v>0$, the dimension-two sieve of §11 gives a limsup mass at most $32S v$, uniformly in fixed translations. Thus every sequence of $M$ tending to infinity has a vaguely converging subsequence, and every limit has a density $f$ on the line bounded by $32S$.

At the first contact the masses agree by continuity and $C_4(4)>0$. Apply @pairreduction at that contact. One may replace its scaled upper endpoint by $b$: for any fixed $epsilon>0$ the discrepancy is bounded by the mass of an interval of length $2epsilon$ around $b$, times a bounded weight. The sieve estimate makes its limsup $O(epsilon)$. The same reasoning applies at the translated starting parameter $M'=M+s H_M$ for each fixed real $s$, since $H_(M')/H_M->1$ and $(log M')/ell->1$. Vague convergence applies to the resulting interval tests because the limiting measure has no atoms at their ends. Every subsequential density therefore satisfies
$ integral_0^b v f(s+v) dd v =1/(log 2) quad (s in RR). $ <sliding>
Set $K_b(v)=v bold(1)_([0,b])(v)$. Its Fourier transform for the convention $e^(i xi v)$, at $xi!=0$, has numerator $e^(i b xi)(1-i b xi)-1$ and denominator $xi^2$. The reverse triangle inequality gives
$ abs(hat(K)_b(xi)) >= b^2/(1+sqrt(1+(b xi)^2)) . $ <symbol>
At zero its value is $b^2/2$. Subtract the constant $2/(b^2 log 2)$ from $f$. By @sliding, this difference has zero convolution with the reflected kernel. This is the uniqueness mechanism of Wiener’s Tauberian theorem [15]. Fourier transform in tempered distributions and divide any smooth compactly supported frequency test by the smooth, nowhere-vanishing multiplier. The difference is zero as a distribution. Every limit is therefore the same constant density, giving convergence on every scaled interval and proving the converse. If one defines the first strict overtake instead, take the infimum over $C_6(B)>C_4(B)$. A finite such infimum is an equality point by continuity and the initial lead. Under the local law the profile has strict signs on the two sides of its root. Thus the forward and reverse arguments, including the typical version below, also give the same equivalences for the first strict overtake. The bound in @symbol also quantifies the loss of one derivative when inverting the convolution in $L^2$ by Plancherel.

#pagebreak()
#include "typical-en.typ"
#sub[First passages at seven large heights]
For $M=2^k$ and $k=24,26,28,30,32,34,36$, we also enclose the first contact on the much finer relative width $1/(6M)$. Up to $33M/32$, the ratio-4 contribution has the exact value $(k-1)h$ once $B>=M$. Indeed $4delta B<=11/16<log 2$, so only aligned powers of 2 count, and the next one lies above $33M/32$. The ratio-6 mass starts at zero. Its eligible terms $n,6n plus.minus 1$ lie in separate log intervals in increasing order of $n$, with the minus sign first if both occur. Each second-window candidate has prime base at least 5 and $6delta B<=33/32<log 5$. Summing disjoint log overlaps until they exhaust the ratio-4 lead excludes every earlier contact.

#figure(image("passage.svg",width:100%),caption:[Measured cumulative lead and first contact. On the left the base endpoint is $M+floor(z H_M)$ at steps of $1/16$. The dashed curves give the short-interval pair-law prediction. On the right the vertical scale is enlarged. Decimal enclosure widths are smaller than the markers.])

At the highest tested height, $M=68 719 476 736$, the first contact lies strictly between 68,744,114,238.83330279 and 68,744,114,238.83330280. It occurs during the 195,443rd overlap, from $n=68 744 114 239$ and $6n-1$. The normalized overshoot is in $(0.753988674,0.753988675)$. For all seven heights the observed overshoot ranges from 0.750378 to 0.759008. The conjectural limit is about 0.739149. These measurements resolve the finite differences but leave their limiting behavior open.

One sieve marks a contiguous interval of possible images and reads the two required residue classes. A second sieve works directly on the primitive variable, striking one residue class per image and prime divisor. Both restore proper prime powers. The two runs use different block sizes and 128- and 192-bit ball arithmetic. They agree on the ordered event prefix, both decimal endpoints, and the 34 profile ordinates. The public data include the prefix digests and the rational decimal scales.

#pagebreak()
