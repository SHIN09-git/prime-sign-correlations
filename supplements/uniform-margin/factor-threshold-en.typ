#import "../../paper/layout.typ": sub

= The six possible limiting ratios
Fix the smooth weight $f$ and retain $Q$, $A_X$ and $U_X$ from §11. For an integer $j$ write $M_(j)(X)$ for the mass of rough pairs with $Omega(F_(sigma)(n))<=j$, including squareful pairs. Let $r$ be the smallest $j$ for which $liminf_(X->infinity) frac(M_(j)(X),U_X)>0$. Theorem E and the upper sieve ensure $2<=r<=7$. For large $X$, every rough product is less than $X^(801/400)$ and all its prime factors exceed $X^(1/400)$. Thus $2,...,800$ is a fixed ambient set of factor counts, as in the finite-sum formulation in Lean.

#sub[Theorem H. The limiting ratio determines the uniform factor count]
For $0<t<=1/3$ put $V_(f)(t)=limsup_(X->infinity) frac(A_(X)(2t),A_(X)(t))$. Then
$ 2^r <= V_(f)(t) <= 2^r+C_f t, quad
   lim_(t arrow.r 0^(+)) V_(f)(t)=2^r in {4,8,16,32,64,128}. $
The constant can be taken as $2^(r+1)/c$ for any eventual lower bound $c>0$ for $frac(M_(r)(X),U_X)$. In particular the upper bound $128+O_(f)(t)$ holds unconditionally. The limits are taken in the indicated order.

*Upper bound.* By choice of $r$, one has $A_(X)(t)>=c t^r U_X$ for all large $X$. In $A_(X)(2t)$, each pair with at most $r$ factors contributes at most $2^r$ times its contribution to $A_(X)(t)$. Each remaining pair contributes at most $(2t)^(r+1)$ times its window weight. Consequently
$ A_(X)(2t)<=2^r A_(X)(t)+(2t)^(r+1)U_X. $
Division gives the claimed upper bound, uniformly in $X$ and in the displayed range of $t$.

*Lower bound.* For $r>2$ take a sequence of starting heights tending to infinity on which $frac(M_(r-1)(X),U_X)$ tends to zero. Such a sequence exists by minimality, including the possibility that the numerator vanishes. For $r=2$ the smaller stratum is empty. Each remaining pair gains a factor of at least $2^r$ when the parameter doubles. For each fixed $t$,
$ A_(X)(2t)>=2^r(A_(X)(t)-M_(r-1)(X)). $
On this sequence $frac(M_(r-1)(X),A_(X)(t))$ tends to zero because $A_(X)(t)>=c t^r U_X$. This proves the lower bound for the upper limit in $X$. Now send $t$ to zero.

The original critical upper bound is equivalent to the occurrence of the value four for at least one fixed $f$. Theorem H excludes every intermediate real value between four and eight. Identifying which of the six values is attained for an actual window weight still requires an estimate for the distribution of the factor counts.
