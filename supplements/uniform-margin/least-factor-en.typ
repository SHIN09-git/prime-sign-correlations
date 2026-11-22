#import "../../paper/layout.typ": sub
#import "least-factor-equations.typ" as q

= The least prime factor near the square root
Fix $0<tau<2/3$ and $0<a<1/2$. Use the following scales and a fixed sign $sigma in {-1,1}$.
#q.scale
Write $N_sigma$ for the number of $n in I$ for which $n$ and $6n+sigma$ are prime. Write $S_(sigma)(alpha)$ for the number with $P^(-)(n(6n+sigma))>X^alpha$. Here $P^(-)(m)$ is the least prime factor of $m$. Both counts are unweighted.

#sub[Theorem I. Uniform bounds for composite survivors]
For every $0<=eta<=1/2-a$ and all sufficiently large real $X$,
#q.endpoint
More generally, for $a<=alpha<=beta<=1/2$ one has
#q.band
The constants are independent of the exponents in these ranges, the sign, the starting height and the width $Y$. The theorem is unconditional. It applies to the critical width $H$ of §1, and to every fixed positive multiple of $H$, by taking $tau<1/6$.

At cutoff $sqrt(X)$ the discrepancy from the true-pair count is $O_(tau)(Y/ell^3)$, taking for example $a=1/4$. At cutoff $sqrt(X)/ell^A$ for fixed $A>=0$ it is $O_(tau,A)(Y(1+log ell)/ell^3)$, since $eta=A(log ell)/ell$. Thus the approximation error is smaller than the target $Y/ell^2$ uniformly at these cutoffs. For any nonnegative bounded window weight supported in $I$, the absolute error is bounded by its supremum times the unweighted error. A positive lower bound for the surviving count at these cutoffs is still required.

*Factorizations to be counted.* If a survivor is composite in either entry, its least prime factor $r$ divides a composite entry and is at most $sqrt(12X+1)$ for large $X$. Indeed both entries exceed $sqrt(12X+1)$, and the smaller factor of a composite entry is at most its square root. Write the affected entry as $r s$. If both entries are composite either possible choice with the least factor suffices. The cofactor $s$ and the other entry also avoid every prime up to the cutoff. For the band estimate the range of $r$ is $(X^alpha,X^beta]$. For the endpoint estimate it is $(X^(1/2-eta),sqrt(12X+1)]$. We shall show that each interval $R<r<=2R$ in either covering contributes $O_(tau,a)(Y/ell^3)$. The respective numbers of intervals are $O(1+(beta-alpha)ell)$ and $O(1+eta ell)$.

#pagebreak()
= Residue classes in a thin product range
Consider $R<r<=2R$ and $U<r s<=U+Delta$ with $r,s$ positive integers, $U asymp X$, $U+Delta asymp X$ and $Delta asymp Y$. In the first orientation $(U,Delta)=(X,Y)$. In the second they are $(6X+sigma,6Y)$. The starting radii in §13 satisfy $X^a<=R<=4sqrt(X)$. Let $B_(d)(i,j)$ count pairs in two fixed classes $r equiv i$, $s equiv j$ modulo $d$. Uniformly for $d<=X^kappa$ with $kappa=min(tau,a)/8$,
#q.crt

*Counting the second coordinate.* For $A=U+Delta$ and $A=U$, subtract the sums of $floor((A/r-j)/d)$ over $r equiv i$. The linear terms give $(Delta/d)sum 1/r$. Partial summation in the first progression gives $sum 1/r=(log 2)/d+O(1/R)$, including real endpoints. The constant halves in the two sawtooth sums cancel. Thus the only remaining task is an $O(X^(1/3))$ estimate for each centered fractional-part sum.

For $R<=2X^(1/3)$ the trivial bound $O(1+R/d)$ suffices. Otherwise put $K=floor(R/X^(1/3))$ and write $r=i+d m$. The phase is $phi(m)=A/(d(i+d m))-j/d$. On the relevant range $abs(phi''(m)) asymp A d/R^3$, and the number of terms is $O(R/d)$ since $d<R$. Apply the Erdős–Turán discrepancy inequality to the fractional parts, and the second-derivative test to each harmonic $h phi$, $1<=h<=K$. If the curvature of a harmonic exceeds one, its trivial bound suffices for the same inequality. Integrating the interval discrepancy bounds the centered fractional-part sum, with the same estimate at integer endpoints. Summing $h^(-1/2)$ and $h^(-3/2)$ gives a constant times
#q.discrepancy
Here the first term bounds the discrepancy truncation. The other two come from the length times the square root of the curvature and its inverse square root. With the chosen $K$, the first two terms are $O(X^(1/3))$. The last is $O(X^(1/4))$ because $R<=4sqrt(X)$. This proves the residue estimate.

Counting the floor error separately for every $r$ would have cost order $sqrt(X)$ in a balanced block. The reciprocal phase reduces it to order $X^(1/3)$ per residue class. This leaves room to sum over sieve moduli that grow as a power of $X$ even in the critical interval.

#pagebreak()
= A three-dimensional upper sieve
On the two product ranges of §14 consider respectively
#q.polys
In the second orientation $r s=6n+sigma$. For primes above three, divisibility of $r s-sigma$ is the same as divisibility of $n$. Dropping the condition $r s equiv sigma mod 6$ only enlarges the upper bound. Every witness from §13 has the corresponding $G_i$ free of primes $5<=p<=w$, where $D=X^kappa$ and $w=D^(1/40)<X^a$.

For $p>=5$ the forbidden residues satisfy either $r s=0$ or $r s=c$ in the prime field for some nonzero $c$. At $r=0$ all $p$ values of $s$ work. For each nonzero $r$ exactly two do, namely $0$ and $c/r$. Hence
#q.gd
The Chinese remainder theorem multiplies the counts $rho(p)$ over squarefree $d$. For the number of pairs with $d ∣ G_i$ the main term is $Delta (log 2)g(d)$ and the error $E_d$ is at most a constant times $rho(d)(X^(1/3)+Delta/(d R))$ by §14. Stars below restrict $d$ to squarefree integers supported on the sieving primes. Since $rho(d)<=d^2$ and $3^(omega(d))<=d$,
#q.mass

Apply Selberg's upper-bound sieve to the multiset of values of $G_i$, with mass counted once per lattice point. Its quadratic form gives
#q.selberg
For completeness, the full sum defining $J$ before the size cutoff is imposed equals $product_(5<=p<=w)(1-g(p))^(-1) asymp (log w)^3$ by Mertens' formula. Under its normalized weights the primes are independently included with probabilities $g(p)$. The mean of $log d$ is therefore $sum g(p)log p=3 log w+O(1)$. Markov's inequality places at least half the weight at $d<=sqrt(D)=w^20$ for large $X$. Thus $J gt.double_(tau,a) ell^3$. The remainder estimate gives $O_(tau,a)(Y/ell^3)$ survivors per block. Summing the coverings in §13 proves Theorem I.

*Analytic references.* For the classical discrepancy inequality see H. L. Montgomery, _Ten Lectures on the Interface Between Analytic Number Theory and Harmonic Analysis_, ch. 1. For the curvature bound see #link("https://people.math.harvard.edu/~elkies/M229.19/vdc.pdf")[N. Elkies, _Exponential sums III_, inequality II]. The form of Selberg's inequality used here is in #link("https://warwick.ac.uk/fac/sci/maths/people/staff/harper/elementarymethodsnotes1.pdf")[A. J. Harper, _Elementary Analytic Methods_, Theorem 2.7].

#pagebreak()
= A long-interval test for genuine prime bases
#sub[Theorem J. Prime or separated semiprime partners]
There are absolute constants $b,gamma>0$, with $b<1$ and $gamma<1/12$, such that for each sign and all sufficiently large $T$ there are $gt.double T/(log T)^2$ primes $b T<p<=T$ satisfying
#q.alt
where $r,s$ are primes in the second alternative. In that alternative $s/r gt.double_b T^(2gamma)$. On a set of real starting points $x in [b T/2,T]$ of measure $gt.double T$, the critical window $(x,x+H_x]$ contains $gt.double H_x/(log x)^2$ primes from this same collection. Here $H_x=sqrt(x)(log x)^(3/2)$. The sets of good starting points can depend on the sign.

Apply the linear-forms version of Chen's theorem with coefficients $(6,sigma,1)$. It gives at least $c_0 T/(log T)^2$ prime bases up to $T$ whose partner is prime or a product of two primes, all its prime factors exceeding $T^(3/11)$. To remove $p<=b T$, count $p<=(b T)^(1/1000)$ trivially and apply the ordinary two-dimensional upper sieve to the remaining $n,6n+sigma$ up to $b T$ at $(b T)^(1/1000)$. The bound is $O((b T)^(1/1000)+b T/(log(b T))^2)$ with an absolute constant. Indeed on any interval of length $L$ the remainder for a squarefree modulus $d$ is $O(2^(omega(d)))$ when sieving primes above three. Take level $D=L^(1/8)$ and cutoff $L^(1/1000)$. The argument of §15 in dimension two gives denominator $gt.double (log L)^2$ and summed remainder $O(D^3)$. Choose $b=2^(-m)$ small enough that at least half the original lower bound remains.

For the remaining semiprimes with $r>=T^(1/2-gamma)$ subdivide $(b T,T]$ into dyadic intervals $(X,2X]$. Such pairs are counted in $S_(sigma)(1/2-gamma)-N_sigma$ for each interval. Theorem I with $a=1/4$, for example, bounds their total by $O((gamma+1/(log T))T/(log T)^2)$. The implied constant can be fixed before $gamma$ is chosen. A sufficiently small $gamma>0$ leaves the asserted lower bound. To pass to windows, put $h=H_(b T/2)$. Write $M(x)$ for the count of this collection in $(x,x+h]$. Each prime $p$ contributes the entire interval $[p-h,p) subset [b T/2,T]$ for large $T$. The integral of $M$ over the latter interval is thus at least $c h T/(log T)^2$ for some $c>0$. The local upper sieve just proved gives $M(x)<=C h/(log T)^2$. Splitting the integral at $M(x)=c h/(2(log T)^2)$ gives measure at least $c T/(2C)$ above that threshold. On this range $h<=H_x$ and $h asymp_b H_x$.

A separate direct lower bound on *every* dyadic interval is available for fixed $0<theta<1/4$.
#q.bv
For squarefree $d$ coprime to six the partner condition selects one reduced class. Bombieri–Vinogradov supplies total progression error $O_(A)(T/(log T)^A)$ up to $D=sqrt(T)/(log T)^B$ for suitable $B$. The dimension-one lower sieve [6] is positive since $frac(log D,log(T^theta)) arrow.r 1/(2theta)>2$. At the square-root cutoff this argument gives a ratio tending to one. It supplies no positive lower bound there. Chen's theorem in Theorem J still includes the separated semiprimes. The shifted-prime Möbius estimate of Lü, Wang and Wu concerns the unrestricted shift $p+2$. Its statement provides no estimate on this restricted affine class. The genuine-pair lower bound remains open.

See #link("https://arxiv.org/pdf/1906.05927")[Garcia–Luca–Shi–Udell, Theorem 6, quoting Friedlander–Iwaniec, _Opera de Cribro_, Thm. 25.11], #link("https://personal.science.psu.edu/rcv4/Bombieri.pdf")[R. C. Vaughan on Bombieri–Vinogradov] and #link("https://arxiv.org/abs/2610.20242")[Lü–Wang–Wu, Theorem 1].
