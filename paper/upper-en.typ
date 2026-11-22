#import "layout.typ": *
#import "upper-equations.typ" as eq

#sub[An upper bound on a continuum of widths]
#lead[Theorem 4B.][With the windows and first contact of §9, every real starting parameter in the stated range satisfies]
#eq.finite
On $[2^14,2^40]$ the coefficient 0.961275 suffices. On $[2^23,2^40]$ it can be replaced by 0.792261, and on $[2^30,2^40]$ by 0.770345. All these conclusions include strict overtake by the indicated endpoint. They follow from an integer covering certificate with a finite upper endpoint.

Choose integers $4<=A<U<b<=D<=3A/2$ and let $M$ vary over the *closed* interval $[A,U]$. Put $h_M=log(1+1/(6M))$. In the following sum, each sign for which $n$ and $6n plus.minus 1$ are both prime contributes one term. A sufficient test for $C_(6,M)(b)>C_(4,M)(b)$ throughout that interval is
#eq.cert

For $x<=b$, simultaneous nonempty windows at ratio 4 imply $abs(m-4n)<4delta x<=1$ for an integer in each window. Hence $m=4n$ and both integers can be prime powers only if $n$ is a power of 2. Every such base interval contributes at most $h_M$. Since $(1+delta)b<=b+1/4$, an integer endpoint in the base window is at most $b$. Counting the powers from 4 upwards gives $(C_(4,M)(b))/h_M<=J_D$.

Take a prime-pair witness with $U<n<=b$. Its base prime and image prime each produce an excess throughout their common interval because the two window lengths are at most $1/4$ and $3/2$, respectively, whereas the corresponding prime logarithms are larger. The common interval ends at or before $n<=b$ and starts above 3. Different base primes have disjoint intervals, and the two candidate images for one base prime differ by 2. Thus no portion is used twice. The full log overlap divided by $h_M$ is the positive part of the left side of the next inequality. From $log(1+t)>=t/(1+t)$ for $t>=0$ and $-log(1-t)<=t/(1-t)$ for $0<=t<1$ we get $h_M>=1/(6U+1)$ and both absolute log shifts are at most $1/(6n-1)$. Consequently
#eq.fraction
The numerator $3(n-U)-1$ is positive. Summing proves the test. Omitting all pairs involving a proper prime power is legitimate in this lower estimate for $C_6$. Finally, if $b-A<=c H_A$, then $b<=M+c H_M$ for every $M$ in the cell, by monotonicity of $H_M$.

#pagebreak()
#sub[Computing and checking the cover]
In a dyadic block $[2^k,2^(k+1)]$ use the integer cell length $g=2^(floor(k/2)-2)$. For one parameter cell with left endpoint $A$ and $U=A+g$, each following integer bin $(a,a+g]$ records a pair count and the sum of $n-a$ over the same pairs. These two integers recover the weight in @witnesscert for any consecutive group of bins. Fix an integer cap $D$ on the grid, about $A+1.25H_A$, and verify $2D<=3A$ exactly. Using $J_D$ throughout, advance the endpoint $b$ to the first grid point for which the weight exceeds $3D J_D$. The increasing integer weight makes binary search valid.

To round the coefficient outwards, put $y=(A-2^k)/(A+2^k)$ and use $log A >= k(693147/10^6)+2y+2y^3/3$. The constant follows from the first eight positive terms of $2"atanh"(1/3)$. Each of the last two terms is rounded down to a millionth. With this rational lower bound $l$, the certificate checks $(b-A)^2<=c^2 A l^3$ by integer arithmetic. It takes the largest resulting coefficient over the block. Adjacent closed cells both certify their common endpoint.

#figure(image("upper-cover.svg",width:100%),caption:[Each step is a proved upper bound for every real parameter in its dyadic block. The points are the individual first passages from the second edition. The dashed line assumes the local prime-pair law.])

Starting at $2^14$, the cover consists of 12,581,376 cells. The cell giving the largest bound above $2^16$ has $A=79 296$, $U=79 360$, $D=93 760$ and $b=88 704$. Its 324 prime pairs give integer weight 4,272,462 against a strict threshold of 4,219,200. Lean checks the primality, distinctness and exact weight of this list. For the full cover, one sieve works on arithmetic progressions modulo 30 and another sieves the consecutive base and image integers directly. Each dyadic block has matching integer counts and moments in the two computations. A third program sets endpoints from the published coefficients, checks the strict margins in every cell and reconstructs the shared small-prime tables by Euler’s linear sieve. The public record gives each block’s digest and worst cell.

#pagebreak()
#sub[An all-height upper bound from a one-sided error estimate]
Let $Q$ be the two-branch global count of §12 and fix a smooth comparison $F$ with $(log x)^2 F'(x)->kappa>0$. One arithmetic choice is the sum of $4C_2 integral_2^x (dd t)/((log t)log(6t+sigma))$ over $sigma=plus.minus 1$. For errors smaller than $x/(log x)^3$, keeping the logarithms of the actual linear forms matters. Write $E=Q-F$, $ell=log M$ and $H=H_M$. For each fixed $z>0$ define the size of a downward excursion by
#eq.drift

#lead[Theorem 4C.][If $d_z<=d$ for every fixed $z>0$, with $0<=d<infinity$, then]
#eq.uniformdrift
In particular $abs(E(x))<=(a+o(1))sqrt(x/(log x))$ suffices with $d=2a$. At one fixed $z$, the weaker inequality $kappa z^2/2-z d_z>1/(log 2)$ already gives $B_*(M)<=M+z H$ for all sufficiently large $M$. These are additional hypotheses on the pair count.

Indeed the normalized moment of the error in @pairreduction is exactly
$ (ell^2)/(H^2) integral_M^(M+z H) (E(M+z H)-E(t))dd t. $
The moment from $F$ is $kappa z^2/2+o(1)$, since its derivative has the stated asymptotic uniformly over this interval. The lower limit of the total moment is at least $kappa z^2/2-z d_z$. By @fourmass, once it exceeds $1/(log 2)$ the ratio-6 mass is strictly larger at the endpoint. Solving the quadratic inequality proves @driftbound.

A coarser uniform conclusion is available under a coarser global estimate. Suppose $abs(E(x))<=Delta(x)$ with $Delta$ nondecreasing and $Delta(2M)ell^2=o(M)$. Then
#eq.coarse
To see this, put $T=C(H+ell^2 Delta(2M))$ with $C$ sufficiently large in terms of $kappa$. The derivative bound gives at least $kappa T/(8ell^2)-2Delta(2M)>=kappa T/(16ell^2)$ prime pairs between $M+T/2$ and $M+3T/4$. Each contributes at least $T/(5M)$ times $h_M$ before $M+T$, by the log estimate in @fractionupper with $U=M$ and the ceiling of the endpoint as cap. Meanwhile $(C_(4,M)(M+T))/h_M<=2ell/(log 2)$. Increasing $C$ makes the prime-pair contribution strictly larger. This proof also applies when $T/H$ grows. For example, a global bound $E(x)=O_(epsilon)(x^(1/2+epsilon))$ for each $epsilon>0$ gives $B_*(M)-M=O_(epsilon)(M^(1/2+epsilon))$. The usual global leading-term conjecture supplies no such error rate.

#pagebreak()
#sub[How many starting heights can the global count control?]
Let $bb(P)_X$ denote uniform probability on $[X,2X]$. Retain $S=8C_2$, $T(M)=(B_*(M)-M)/H_M$ and $A_M$ from §12. Suppose the dyadic prime-pair count satisfies $liminf_(X->infinity) ((log X)^2)/X (Q(2X)-Q(X))>=kappa>0$. Then
#eq.proportion
Under the global leading-term conjecture $kappa=S$, the choice $z=1$ gives a lower limiting proportion exceeding 0.0144. This establishes a critical-scale upper for a positive proportion of starting heights under a global input alone.

For the proof let $Y_(M)(z)=integral_((0,z])t dd A_(M)(t)$. The sieve of §11 bounds this moment by $16S z^2+o_(z)(1)$ uniformly as $M$ grows. From @onepointmean its dyadic mean has lower limit at least $kappa z^2/2$. If $Y_(M)(z)>c+epsilon$, the ratio-6 mass is larger by $M+z H_M$ for all sufficiently large $M$, using @pairreduction. Splitting the mean at $c+epsilon$, and sending $epsilon$ to zero, gives @positivefraction.

There is also a converse for this order of magnitude. If $bb(P)_X(T(M)<=z)$ has lower limit at least $rho>0$, then $Y_(M)(z)>=c-o_(z)(1)$ on that event. At first contact this follows by equality of both masses, and the moment increases up to $z$. The mean formula implies a lower limit of at least $2rho c/z^2$ for the normalized dyadic pair count. Thus some fixed critical-scale upper on a positive lower proportion of each dyadic shell is equivalent to a positive lower bound of the predicted order for the pair count in those shells. In particular even an unbounded sequence with $T(M)<=C$ would force infinitely many genuine prime pairs, by the local necessity in §11.

#sub[What ordinary sieving leaves unresolved]
For the three forms $n,6n-1,6n+1$ the Liouville sign vectors $(+1,-1,-1)$ and $(-1,+1,+1)$ both rule out the desired hit. Their midpoint is zero. This fits the general parity-obstruction analysis of Tao [17], which describes the limits of a class of sieve arguments. A prime multiplied by a different prime contributes zero to the von Mangoldt function, so an almost-prime conclusion alone cannot certify a ratio-6 overlap on this scale.

#pagebreak()
#sub[Six arcs that can be evaluated at the critical width]
Let $w$ be a fixed real smooth function of compact support in $(0,a)$, with $0<=w<=1$. Put $e(t)=exp(2pi i t)$ and $H=H_M$. Define two finite sums
#eq.sums
Their real cross product, multiplied by $2cos(2pi alpha)$, has integral over the unit circle equal to the smoothed two-sign prime-power count, by orthogonality. Let $tau=ell^(1/16)$ and take the six circular arcs of radius $tau/(6H)$ about $j/6$ for $j=0,dots,5$. Denote the integral of the real product $2cos(2pi alpha)op("Re")(S_1(alpha) overline(S_6(alpha)))$ over their *complement* by $R_(M)(w)$. Then the Riemann theorem and the smoothed explicit formula [4,5] give
#eq.arcs
Here both signs are counted for genuine primes on the left. The calculation uses only the ordinary zeta function.

For details, with $X=M$ or $6M$ take $Y/X=H/M$ and normalize the twist so that $abs(u)<=tau$. The explicit formula for the weight $w((t-X)/Y)e(u(t-X)/Y)$ gives
$ sum_n Lambda(n) w((n-X)/Y)e(u(n-X)/Y)
   =Y hat(w)(u) + O_(w)(sqrt(X)(log X)(1+abs(u))^2), $
where $hat(w)(u)=integral_RR w(v)e(u v)dd v$. For a zero $1/2+i gamma$ each Mellin integral has modulus at most a constant times
$ Y/sqrt(X) (1+abs(u))^2 min(1,(X/(Y(1+abs(gamma))))^2). $
The second bound follows by two integrations by parts in $log t$. The zero-counting bound sums this minimum to $O((X/Y)log(2X))$. The trivial zeros contribute $O_(w)(Y/X^3)$ since $X$ is large and the weight is supported away from 1.

Write $alpha=j/6+beta$ on the six arcs. The first sum is unchanged under these six translations. Summing the other factor over $j$ selects $m equiv sigma mod 6$ with coefficient $6e(sigma beta)$ for $sigma=plus.minus 1$. These residue classes together contain every prime power except powers of 2 and 3. Only $O(1)$ total von Mangoldt weight from those exceptions occurs in this short support. Replacing the two factors $e(sigma beta)$ by one costs $O_(w)(tau^2+tau)$ after integration, using $S_1(0),S_6(0)=O_(w)(H)$ and nonnegative weights. With $u=6H beta$, the main arc integral becomes $6H integral_(-tau)^tau abs(hat(w)(u))^2 dd u$. Integrated explicit-formula errors cost $O_(w)(H(tau^3/sqrt(ell)+tau^5/ell))=o(H)$. Plancherel now gives $6H norm(w)_2^2+o(H)$.

#pagebreak()
#sub[The remaining Fourier inequality]
In the full-circle count, the two smooth weights at a hit differ by $O_(w)(1/H)$. The number of proper powers in either support is $O_(w)(H/sqrt(M)+ell+H ell/M^(2/3))$ by §10. Each has at most two partners per form and contributes $O(ell^2)$, so their total is $o(H)$. For genuine pairs the product of logarithms equals $ell^2(1+O(1/ell))$ uniformly, and the sieve bounds their number by $O_(w)(H/ell^2)$. This completes @sixarcs.

The all-height critical upper would follow if some such $w$ and $epsilon>0$ satisfied
$ (R_(M)(w))/H >= -6 norm(w)_2^2+epsilon $ <remainderupper>
for every large $M$. Indeed @sixarcs yields a lower bound of the predicted order inside $(M,M+a H]$, and the uniform upper criterion in §12 applies. Conversely, that criterion gives fixed $a_0,d>0$ supplying at least $d H_M/ell^2$ pairs per interval of length $a_0 H_M$. Apply it at $M+H_M$ and choose a smooth weight equal to one on $[1,2+a_0]$. Its compact support can be taken inside $(0,3+a_0)$. This proves @remainderupper with a positive margin for all sufficiently large $M$.

Cauchy–Schwarz and Parseval alone bound $abs(R_(M)(w))$ by $O_(w)(H ell)$. Indeed the squared norm of either finite sum is a sum of squared prime weights, at most $O_(w)(H ell)$ by the untwisted smoothed estimate and $Lambda(n)<=O(ell)$ on the support. In fact @sixarcs, positivity and the upper-bound sieve already give $R_(M)(w)=O_(w)(H)$ and $liminf (R_(M)(w))/H>=-6 norm(w)_2^2$. The missing estimate is the strictly positive margin in @remainderupper.

#sub[A coarser upper from the zero frequencies]
The finite-time estimate of §§15–17 also gives an upper using a different arithmetic input. With the notation of §15, if the finite gap $Delta>0$, take $Y=(exp(4k L))/Delta$ and $U=log 3$. For sufficiently large $M$ the mean ratio-6 excess then exceeds the ratio-4 mean by $(log 2)/(4pi L)+o(1/L)$. Multiplying by $Y$ gives positive cumulative lead, hence $B_*(M)<=3 exp(Y)$. Under effective linear independence in the sense of Lamzouri and simple zeros, every fixed $epsilon>0$ gives, eventually,
$ B_*(M)<=3 exp(exp(M^(1+epsilon))). $
Indeed §15 allows $log Y=h_M^(-1/beta)$ for $1/beta=1+epsilon/2$, and $h_M^(-1/beta)=o(M^(1+epsilon))$. This all-height conclusion uses no conjecture about pairs. Its horizon is much longer than the critical window.

#pagebreak()
#sub[Resolving the singular series on a growing rational grid]
The six-arc calculation used the ordinary zeta function. The critical-line theorem for primitive Dirichlet characters [4,18] permits a larger grid. Let $q$ be the largest primorial at most $ell^(1/64)$, and retain $tau=ell^(1/16)$. Around each $j/q$ take an arc of radius $tau/(6H)$, for $0<=j<q$. These arcs are eventually disjoint. Denote by $R_M^*(w)$ the same real integral as before on the complement of this grid.

#lead[Theorem 4D.][Uniformly as the real starting height tends to infinity, the entire grid contributes $S H norm(w)_2^2 + o_(w)(H)$ with $S=8C_2$. In particular]
$ (ell^2)/H sum^dagger w((n-M)/H)^2 = S norm(w)_2^2 + (R_M^*(w))/H + o_(w)(1). $ <primorialmain>

To track the growing modulus, apply the smoothed explicit formula to a primitive character of conductor dividing $q$. The number of its nontrivial zeros in a unit interval at height $t$ is $O(log(q(2+abs(t))))$ [19, ch. 11]. The Mellin estimate on p. 21 then bounds the zero contribution by $O_(w)(sqrt(X)log(q X)(1+abs(u))^2)$, uniformly in the character. The leading term $Y hat(w)(u)$ occurs only for the principal character. For nonprincipal characters the trivial zeros may start at zero and have total contribution $O_(w)(Y/X)$. Passing from a primitive character to an induced one removes only powers of primes dividing $q$. In a support of endpoint ratio less than 2 their total weight is $O_(w)(log q)$. These estimates hold for both $(X,Y)=(M,H)$ and $(6M,6H)$.

By character orthogonality each reduced residue has main term $(Y hat(w)(u))/(phi(q))$ and the same error bound. An additive twist sums over at most $q$ residues. Nonunit prime powers again have total weight $O_(w)(log q)$. Write $c_(q)(v)=sum_(r mod q)^"red" e(v r/q)$ for the Ramanujan sum over units. At $alpha=j/q+beta$, $u=6H beta$, the two leading terms of the sums, after division by their common phase $e(6M beta)$, are
$ (H hat(w)(u)c_(q)(6j))/(phi(q)), quad (6H hat(w)(u)c_(q)(j))/(phi(q)). $
Each has error $O_(w)(q H(1+abs(u))^2/sqrt(ell))$. Replacing the cosine by its value at $j/q$ costs $O_(w)(q tau^2)$ after integration, since the untwisted sums bound the moduli by $O_(w)(H)$. Integrated over all arcs, the two cross errors and the product error cost
$ O_(w)(H(q^2 tau^3/sqrt(ell)+q^3 tau^5/ell))=o(H). $
The chosen exponents make this estimate uniform with $q$ growing.

#pagebreak()
#sub[The arithmetic factor and the remaining uniform estimate]
The main term on the grid is $H A_q integral_(-tau)^tau abs(hat(w)(u))^2 dd u$. Expand both Ramanujan sums and sum the additive characters over $j$. Orthogonality imposes $s equiv 6r+sigma mod q$ for the two signs $sigma=plus.minus 1$, with $r,s$ units. Thus
$ A_q=q/(phi(q)^2) sum_(sigma=plus.minus 1) \#\{r mod q : "gcd"(r,q)="gcd"(6r+sigma,q)=1\}. $
For a prime $p$ dividing $q$, the forbidden residues are $r equiv 0 mod p$ and $6r+sigma equiv 0 mod p$. At 2 and 3 only the first occurs. At larger primes the two residues are distinct. The Chinese remainder theorem therefore gives, for all sufficiently large $M$,
$ A_q=6 product_(p|q, p>3) (1-1/(p-1)^2) -> 8C_2=S. $
The Euler product converges absolutely. Plancherel gives the claimed grid integral. The same orthogonality and proper-power estimates as for @sixarcs give @primorialmain.

Consequently a uniform critical upper is equivalent to the existence of one fixed nonnegative smooth bump $w$ as above for which
$ liminf_(M->infinity) (R_M^*(w))/H > -S norm(w)_2^2. $
The proof translates the starting point by $H_M$ as on p. 22. For the sharp constant the precise equivalence is $T(M)->sqrt(2/(S log 2))$ if and only if $R_M^*(w)=o_(w)(H)$ for every such $w$, of arbitrary fixed support in the positive half-line. Indeed the local law in §12 gives convergence against $w^2$. In the other direction, approximate interval indicators from above and below by squares of smooth cutoffs. The sieve bounds the mass lost in endpoint strips of fixed scaled width $eta$ by $O(eta)$ in the limit. Sending $eta$ to zero gives the local law and then the sharp first-passage limit.

The arithmetic factor in this calculation comes from counting allowed residues at individual primes. Establishing the strict margin for the integral over the complement still requires a correlation estimate for actual primes.

#pagebreak()
