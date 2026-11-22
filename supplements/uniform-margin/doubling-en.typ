#import "../../paper/layout.typ": sub

= A test with completely multiplicative weights
#sub[Theorem G. A strict doubling threshold]
Let $Q$ be the product of primes at most $z=X^(1/400)$. On positive integers put $g_(u,Q)(m)=u^(Omega(m))$ if $gcd(m,Q)=1$, and zero otherwise. For each fixed starting height this weight is completely multiplicative. Write
$ A_(X)(u)=sum_(sigma=plus.minus 1) sum_n f((n-X)/H) g_(u,Q)(n) g_(u,Q)(6n+sigma). $
For fixed $0<u<=1$, Theorem E gives $A_(X)(u) gt.double_f u^7 H/ell^2$. An upper sieve for the full rough set gives $A_(X)(u) lt.double_f H/ell^2$. These bounds apply to the correlation itself. The sum defining it ranges over all integers in the window and includes squareful values and products with more than seven factors.

For some fixed $f$, the desired uniform critical upper bound is equivalent to the existence of a single fixed $0<t<=1/3$ such that
$ limsup_(X->infinity) frac(A_(X)(2t),A_(X)(t))<8. $
To see the constant, let $N_X$ denote the true-pair mass, without the logarithmic factors, and let $U_X$ be the mass of all pairs with both entries coprime to $Q$. All true pairs are counted for large $X$. Set
$ D_(X)(t)=(2 A_(X)(t)-frac(A_(X)(2t),4))/t^2. $
On a rough pair with excess $k=Omega(F_(sigma)(n))-2$ its contribution before the window weight is $2t^k-(2t)^k$. This equals one at $k=0$ and zero at $k=1$. For every $k>=2$ its negative lies in $[0,2t^2]$. In fact the penalty is $(2^k-2)t^k$, and its ratio at two successive indices is at most $3t<=1$. Consequently
$ 0 <= N_X-D_(X)(t) <= 2t^2 (U_X-N_X), quad U_X lt.double_f H/ell^2. $
If $N_X>=c H/ell^2$ uniformly, choose $t$ sufficiently small in terms of $c$ and the upper bound for $U_X$. Then $D_(X)(t) gt.double H/ell^2$. Conversely such a lower bound for $D_(X)(t)$ directly bounds $N_X$ below. For each fixed $t$ both bounds on $A_(X)(t)$ above hold, and $D_(X)(t)=frac(A_(X)(t),4t^2) (8-frac(A_(X)(2t),A_(X)(t)))$. This proves the equivalence, including the strict margin in the ratio.

*Removing the sieve cutoff at a varying parameter.* Take $Q=1$ in the definition and denote the resulting expression by $D_X^("all")(t)$. Now $U_X=O_(f)(H)$ by counting integers. The same pointwise proof gives
$ (ell^2/H) N_X = (ell^2/H) D_X^("all")(ell^(-2)) + O_(f)(ell^(-2)). $
The two completely multiplicative functions are $m arrow.r.bar t^(Omega(m))$ and $m arrow.r.bar (2t)^(Omega(m))$, with $t=ell^(-2)$. The parameter varies with the starting height. Neither this identity nor the two separate magnitude estimates for $A_X$ establish the strict ratio bound.
