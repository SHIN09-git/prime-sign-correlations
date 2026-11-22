#import "layout.typ": *
#import "transition-equations.typ" as e
= Isolating one prespecified affine prime pattern
Fix $k>=2$ distinct, pairwise nonproportional integral forms $f_i(n)=a_i n+b_i$, $a_i>=1$, including $f_0(n)=n$. Let $P(X)$ count positive integers $n<=X$ at which all forms are prime. Choose $c>0$ so $c max_i a_i<1/3$. Take $0<s<1$ sufficiently close to 1 that $(1-s)max_i abs(b_i)<1/3$ and $w(s)>0$ below. Both choices are fixed as the real parameter $X$ grows. Use the same excess bit as in §9 and form the unnormalized logarithmic mass
#e.affine
#e.w
#lead[Theorem 5.][For any fixed $kappa>=0$ the two limits in @tupleequiv are equivalent. A single shell with these fixed parameters suffices. No zeta-zero or prime-tuple conjecture is used in the equivalence.]
#e.equiv
For sufficiently large $X$ all windows have length below $log 2$ and below 1. A positive bit is exactly the presence of one prime power. If the common base point yields integers $n,m_i$ in the respective windows, then $abs(m_i-Q_i n)<Q_i c$ and $abs(Q_i n-f_i(n))=abs(b_i)abs(n/X-1)$. Since $s X<n<=r X$, their sum is below 1. Hence $m_i=f_i(n)$.

For a fixed candidate $n$ the log intervals around $log(f_i(n)/Q_i)$ all have length $h=log r$. Their uncut common length is the positive part of $h$ minus the spread of their right endpoints, with the positive part applied to the whole difference. Distinct $n$ give disjoint intervals. Put $t=n/X$ and $u_i=b_i/a_i$. The endpoint displacements from $log n$ are $log(1+u_i/n)-log(1+u_i/X)=u_i(1/t-1)/X+O(X^(-2))$ uniformly for $s<=t<=1$. Thus their overlap is $w(t)/X+O(X^(-2))$. Clipping the two shell edges affects $O(1)$ candidates and $O(1/X)$ mass. The weighted sum over all prime-power patterns equals $X J(X)+O(1)$. Each proper-power exception in one form has $O(sqrt(X))$ possible preimages, by summing over exponents. We obtain
$ X J(X) = sum_(s X<n<=X, "all "f_i(n)" prime") w(n/X)+O(sqrt(X)). $ <weightedsum>

#pagebreak()
= A stable converse from one scalar reading
For a cumulative counting function $A$, Stieltjes integration by parts identifies the weighted sum with the operator
#e.operator
For $sigma>0$ use the norm $norm(A)_(sigma,X)=sup_(0<y<=X) abs(A(y))/y^sigma$ on functions vanishing near zero. The two terms subtracted in @operator have nonnegative coefficients because $w'(t)=D/t^2>=0$. Their total norm at this scale is at most
$ s^sigma w(s)+integral_s^1 t^sigma w'(t)dd t = w(1)-sigma integral_s^1 t^(sigma-1)w(t)dd t <w(1). $
The triangle inequality gives the inverse stability bound
$ norm(A)_(sigma,X) <= norm(cal(T)A)_(sigma,X)/(sigma integral_s^1 t^(sigma-1)w(t)dd t). $ <stability>

For the forward implication of @tupleequiv insert $P(y)=(kappa+o(1))y/(log y)^k$ into @operator. The ratios $(log X)/(log(t X))$ tend to one uniformly on $[s,1]$, and the leading coefficient is $kappa W$. Conversely a bounded normalized reading gives $P(X)-P(s X) << X/(log X)^k$ by @weightedsum and $w(s)>0$. Add these bounds geometrically down to $sqrt X$ and use the trivial bound below it. Thus $P(X)(log X)^k/X$ is bounded. Set $A(y)=P(y)-kappa y/(log y)^k$ at large $y$ and extend it boundedly, vanishing near zero. The asserted reading gives $cal(T)A=o(X/(log X)^k)$. The limsup of $abs(A(X))(log X)^k/X$ is at most itself times $(w(1)-W)/w(1)<1$, using @operator and uniformity in $t$. This limsup must vanish.

#sub[Sophie Germain primes]
Take $f_0(n)=n$, $f_1(n)=2n+1$, $c=1/8$ and $s=7/8$. Then $Q_1=2+1/X$, $w(t)=5/8-1/(2t)$ and $W=5/64-(log(8/7))/2$. The prediction $kappa=2C_2$ in the single reading is equivalent to the full conjectured asymptotic for Sophie Germain primes [12]. The choice $n,n+2$ with $s=31/32$ gives the twin-prime counterpart. Gallagher [13] deduces a Poisson law from averaged information on prime tuples at interval length comparable to $log X$. The present schedule keeps the integer offsets resolvable and admits the reverse implication for one specified tuple.

At $X=2^20$ the Sophie Germain shell contains 840 prime pairs. A direct intersection of all observed sign intervals gives the normalized two-excess frequency in $(0.000544201296,0.000544201297)$. Separate enumeration of the prescribed affine forms gives the same enclosure. The code also checks three simultaneous forms and includes a shell with zero triples.

#pagebreak()
= A finite-height comparison in the many-prime regime
Write $F_(h,U,Y)(a)$ for the joint sign frequency averaged on $U<=y<=U+Y$ at lag $a$. The following inequality only uses zeros in a finite band to measure the effect of near or exact relations. Fix $0<eta<=1/4$ and set
#e.band
Here $L=log(1/h)$. Index the positive ordinates in $[T_-,T_+]$ with multiplicity. Put $u_i=abs(b_h(gamma_i))/sqrt(V_h)$. A signed word consists of ordered letters $(i_l,epsilon_l)$ with signs $plus.minus 1$. It is balanced when its positive and negative counts agree separately for each index. Its frequency is $omega=sum_l epsilon_l gamma_(i_l)$. Include nonbalanced words of frequency zero with multiplier one in the following nonnegative quantity.
Write $cal(U)_j$ for the set of unbalanced words of length $j$.
#e.defect
#lead[Theorem 6.][For sufficiently small $h$, uniformly in $U,Y>=1$ and $a>=0$ with $abs(K_h(a))<=V_h/2$, the finite-height error satisfies]
#e.finitetime
This is an inequality without any independence assumption. To infer the prime-power sign coefficient one must make its right hand side $o(1/L)$. For example $cal(D)<=L^(-12)$ suffices. In that case @finiteclt and §§3–6 yield the same coefficient at fixed positive ratios and bounded displacements, taking $h$ and $Y$ to their limits together.

A simpler sufficient condition uses $Delta=min(1,min_(0<norm(v)_1<=2k) abs(sum_i v_i gamma_i))$, where $v$ has integer coordinates. If $Delta>0$, the sufficient averaging length is
$ Y>=exp(4k L)/Delta. $ <horizon>
Qualitative linear independence counted with multiplicity makes each finite gap positive. This expression retains the actual gap and need not be numerically feasible. If along a sequence of widths $Delta>=exp(-C k L)$ for a fixed $C$, one may take $log Y>=L^(3+epsilon)$ for any fixed $epsilon>0$, choosing $5eta<epsilon$. This sparse-coefficient gap is an additional assumption. Under Lamzouri's ELI [14] and simple zeros, a different concrete regime is $h=(log Y)^(-beta)$ for any fixed $0<beta<1$. Indeed $2k<=N(T_+)$ and ELI gives $Delta >>_epsilon exp(-T_+^(1+epsilon))$. Choose $beta(1+epsilon)<1$ so this exponent and $k L$ are $o(log Y)$. Leung's QLI [1, Conj. 10.1] controls a fixed moment order with order-dependent constants. We do not invoke uniformity in increasing orders from it.

#pagebreak()
= Moments of the finite spectral sum
Let $Z$ be the two-coordinate standardized sum from the band on the actual finite time interval. Let $Z^*$ replace each labeled positive ordinate phase by an independent uniform circle variable. Its conjugate uses the conjugate phase. At multiplicities these are independent *labels* only in this comparison model. For $norm(t)_infinity<=R$ write $T=t dot Z$, $T^*=t dot Z^*$. On expanding the $j$th power, each signed coefficient before multiplying across letters has modulus at most $2R u_i$. Balanced words have equal contributions. Every other word averages to zero in the comparison model, and has time average of modulus at most $min(1,2/(Y abs(omega)))$ in the actual interval, including the zero-frequency convention. The sum of absolute moment discrepancies divided by $j!$ up to order $2k$ is consequently at most $cal(D)$.

The independent summands of $T^*$ are centered and bounded in modulus by $4R u_i$, where $sum_i u_i^2<=1/2$. The usual exponential bound for a bounded centered symmetric variable follows from $cosh v<=exp(v^2/2)$. Multiplication and integration of the resulting Gaussian tail give $bb(E) abs(T^*)^(2k)<=(C R sqrt(k))^(2k)$. Taylor expansion of $e^(i T)$ through degree $2k-1$ has remainder bounded by $abs(T)^(2k)/(2k)!$. The time moment of even order is controlled by its comparison moment and the word discrepancy already included. Stirling's bound yields, uniformly on the Fourier square,
$ abs(phi_Z(t)-phi_(Z^*)(t)) << (C R/sqrt(k))^(2k)+cal(D). $ <momentdiff>
The first term decreases faster than any fixed inverse power of $L$. The zero count and the bound on $b_h$ give $sum_i u_i << h^(-1/2)sqrt(L)(1+log L)$ by splitting at $1/h$ and integrating $(log x)/x$ above it up to $T_+$. Under @horizon each nonbalanced multiplier is at most $2/(Y Delta)$. The absolute coefficients of all words of length $j$ sum to at most $(4R sum_i u_i)^j$. Hence $cal(D)<=exp(3k L)/(Y Delta)$ for large $L$, which proves the stated sufficient condition.

#sub[Discarded ordinates on actual time intervals]
On unit time intervals the Gaussian cell bound of §4 controls logarithmic mean square uniformly in the translate. Below $T_-$ each frequency coefficient is $O(h)$ and each unit frequency cell contains $O(log(2+T_-))$ labels. The squared norm is $O(h^2 T_- log^2(2+T_-))$. Above $T_+$ the dyadic norm sum is $O((log T_+)/sqrt(T_+))$ before squaring. The elementary correction in $D_h(y)$ is $O(h e^(-5y/2))$ for $y>=1$, by differencing $log(1-e^(-2y))$. Dividing by $V_h$ gives a mean-square discarded error $O(L^(-11))$ in each coordinate. Cover arbitrary $Y>=1$ by unit intervals. The same bounds, split at $1/h$, give a uniform normalized second moment $O(L)$ for the full band sum.

#pagebreak()
= From moment comparison to a measured sign
The comparison covariance differs from the full canonical matrix by $O(L^(-11))$ entrywise, using the zero count on the omitted ranges. Since $abs(K_h(a))<=V_h/2$, its eigenvalues stay bounded away from zero. As in §5, Bentkus's inequality bounds the error for any rectangle or translated quadrant by $O(sqrt(h/L))$. Replacing its Gaussian covariance by the full matrix changes the probability by $O(L^(-11))$.

For completeness take $s_0=L^(-1-eta)$ and $M_0=L^2$. Chebyshev bounds the lost mass in truncating the band vector to the square of radius $M_0$ by $O(L^(-3))$. Enlarging or shrinking test rectangles by $s_0$ in each direction accommodates the discarded ordinates except for mass $O(L^(-11)/s_0^2)$. For the comparison Gaussian each coordinate strip of width $O(s_0)$ has probability $O(s_0)$.

To transfer bounded rectangles in the truncated square, choose a nonnegative Schwartz probability density on $RR^2$ whose Fourier transform is supported in the unit square. The squared absolute value of the inverse transform of a smooth bump in the half-square, normalized to integrate to one, supplies such a density. Dilate it to Fourier radius $R$. The resulting spatial tail outside the square of radius $s_0$ is $O_j((R s_0)^(-j))=O_eta(L^(-3))$ by choosing $j$ sufficiently large. Convolving the indicators of the enlarged and contracted rectangles gives an upper and a lower bound for the original indicator up to this tail. Their Fourier transforms are supported on the Fourier square and bounded by $O(M_0^2)$, since the rectangle has this area. Fourier inversion and @momentdiff thus cost at most $O(M_0^2 R^2)((C R/sqrt(k))^(2k)+cal(D))$. All comparison-boundary strips are absorbed by the Gaussian estimate above. The remaining terms give @finiteclt.

At lags $log 4$ and $log 6$ the full covariance matrices meet the required eigenvalue bound for small $h$. Whenever the defect is at most $L^(-12)$, the measured difference has the asymptotic
$ F_(h,U,Y)(log 4)-F_(h,U,Y)(log 6)
  =-(log 2)/(4pi L)+o(1/L), $
uniformly in $U>=1$. In particular it applies to the same initial point $U=log 3$ used in Theorem 4. Under its finite-band condition the observed ordering has reversed by base height $3e^Y$. Under the qualitative hypothesis of §2 alone the infinite-time limit implies eventual reversal at each sufficiently small fixed width. The elementary lower bound in @location remains available in either case.

#pagebreak()
