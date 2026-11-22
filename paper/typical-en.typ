#import "layout.typ": *
#sub[Typical first contacts and a single averaged reading]
Allow the starting parameter $M$ to vary with normalized Lebesgue measure on $[X,2X]$, and write $bb(E)_X$ for this uniform average. Set $T(M)=(B_*(M)-M)/H_M$, let $Q(X)$ be the total signed prime-pair count up to $X$, and put $A_(M)(v)=ell^2 P_(M)(v H_M)/H_M$. For clarity attach the parameter $M$ to each $C_q$ in a reading and write $D_(M)(z)=(6M)/ell (C_(4,M)(M+z H_M)-C_(6,M)(M+z H_M))$.

#lead[Theorem 4A.][Fix $b>0$. As $X$ tends to infinity, $T(M)->b$ in probability if and only if, for every fixed $v>0$, $A_(M)(v)->2v/(b^2 log 2)$ in probability. Either assertion forces the global prime-pair asymptotic with coefficient $2/(b^2 log 2)$. More generally, for any fixed $z>0$ and $kappa>=0$,]
$ bb(E)_X D_(M)(z) -> 1/(log 2)-kappa z^2/2
  quad arrow.l.r.double quad ((log X)^2 Q(X))/X -> kappa. $ <averagedinverse>
In particular a global prime-pair law is equivalent to a mean signed reading at *one* scaled distance. The typical-contact conclusion concerns fluctuations between different starting heights and has a stronger local input.

For the local-count-to-contact direction, use a finite mesh in $0<=v<=Z$. Convergence in probability at its finitely many points and monotonicity give locally uniform convergence in probability to the continuous linear function, by first fixing the mesh and then refining it. Partial summation and the same first-root argument as in @firstprofile give the typical contact law.

Conversely suppose the contact law holds but some local reading fails to converge in probability. Along a sequence of dyadic shells there is a set of starting parameters of measure at least $alpha X$, $alpha>0$, on which that reading stays a fixed distance from its proposed limit. For each fixed rational $s$ the map $M|->M+s H_M$ has derivative $1+O_(s)(H_X/X)$ on the shell and moves either endpoint by $O_(s)(H_X)=o(X)$. Hence at this translated parameter the contact law still holds in probability. Enumerate the rationals. Passing to a sufficiently fast increasing subsequence of shells, select a failing point $M_j$ where the translated contact is within $1/j$ of $b$ for each of the first $j$ rational translations. The union of the excluded sets may be taken to occupy less than $alpha X/2$ by the finite union bound at each step.

Every subsequential measure limit along these centers has bounded density by §11. The argument for @sliding gives that identity at all rational translations. Its left side is continuous in $s$ by continuity of translation in $L^1$ for the ramp kernel. The identity extends to all real translations. The multiplier argument forces the constant density, contradicting failure of the original reading at $M_j$. This proves the probability equivalence.

#pagebreak()
#sub[What survives averaging over the starting height]
Write $sum^dagger$ for the two branches $n,6n plus.minus 1$ with both entries prime, counted with sign multiplicity. The unconditional identity behind @averagedinverse is
$ bb(E)_X D_(M)(z) = 1/(log 2)
  - z^2/(2X) sum_(X<n<=2X)^dagger (log n)^2 +o_(z)(1). $ <onepointmean>
Indeed @fourmass and @pairreduction give $D_(M)(z)=1/(log 2)- integral_((0,z]) t dd A_(M)(t)+o_(z)(1)$ uniformly for $X<=M<=2X$ as $X$ grows. A given prime pair at $n$ contributes to the averaged integral the quantity $1/X$ times
$ integral_({M in [X,2X] : 0<n-M<=z H_M}) ((log M)^2 (n-M))/(H_M^2) dd M . $
Except within $O_(z)(H_X)$ of the shell ends, change variables to $u=(n-M)/H_n$. Uniformly for bounded $u$, $H_M/H_n=1+O_(z)(H_X/X)$ and $(log M)/(log n)=1+O_(z)(H_X/X)$. The allowed $u$ range is trapped between intervals from zero to $z(1 plus.minus O_(z)(H_X/X))$. The integral is thus $(log n)^2(z^2/2+O_(z)(H_X/X))$. The total of its errors after division by $X$, including both boundary strips by the trivial count of integers there, is $O_(z)(H_X (log X)^2/X)=o(1)$. This proves @onepointmean.

A global asymptotic gives the corresponding dyadic shell asymptotic by subtraction, and conversely dyadic summation down to $sqrt X$ recovers the global count. On a dyadic shell $(log n)^2/(log X)^2$ tends uniformly to one. This proves @averagedinverse, also for $kappa=0$. Under the typical local law the normalized moment converges in probability and is uniformly bounded at fixed $z$ by the sieve bound. Its mean therefore converges, yielding the global consequence of Theorem 4A.

#sub[An exact criterion for an upper bound of the right order]
There exists a uniform finite $C$ with $B_*(M)<=M+C H_M$ for all sufficiently large $M$ if and only if there are fixed $a,d>0$ such that $P_(M)(a H_M)>=d H_M/ell^2$ at all such $M$. Necessity was proved in §11. For sufficiency choose $s>1/(d log 2)$ and apply the count lower bound at $M'=M+s H_M$. For large $M$, its whole interval is inside $(M,M+(s+a+1)H_M]$ and every scaled displacement is at least $s$. The integral of $t dd A_(M)(t)$ there has liminf at least $s d>1/(log 2)$. The signed difference is negative by the endpoint, forcing a contact by continuity.

#pagebreak()
