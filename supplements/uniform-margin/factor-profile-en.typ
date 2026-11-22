#import "../../paper/layout.typ": sub

= Seven prime factors in a critical interval
#sub[Theorem E. A local lower bound for almost-prime pairs]
Write $F_(sigma)(n)=n(6n+sigma)$, $sigma in {-1,1}$, and $z=X^(1/400)$. For each fixed $0<=b<c$, in $J=(X+b H,X+c H]$ one has, for each sign separately,
$ op("card"){n in J ∩ NN : mu^2(F_(sigma)(n))=1, P^(-)(F_(sigma)(n))>z, Omega(F_(sigma)(n))<=7}
  asymp_(b,c) H/ell^2. $
Here $Omega$ counts prime factors with multiplicity and $P^(-)$ is the least prime factor. The constants are uniform in the real starting height. The assertion also holds with the weight $f$ of §1, with constants depending on $f$. The proof uses the weighted sieve, independently of the critical-line hypotheses in earlier sections.

*Local sieve data.* Set $Y=(c-b)H$. For squarefree $d$, the number of admissible residues for $d ∣ F_(sigma)(n)$ is the multiplicative function $rho(d)$ with $rho(2)=rho(3)=1$ and $rho(p)=2$ for $p>3$. Counting residues in the translated interval gives $Y rho(d)/d+R_d$, where $abs(R_d)<=rho(d)$. With $D=Y/(log Y)^20$,
$ sum_(d<D) mu^2(d) 4^(omega(d)) abs(R_d) lt.double D(log(2D))^7 lt.double Y/(log Y)^13. $
Indeed $8^(omega(d))=tau_8(d)$ on squarefree integers. The eightfold divisor sum bound follows by summing over the first seven factors. Mertens' product formula gives sieve dimension two, since the product of $1-rho(p)/p$ up to $u$ is asymptotic to $4C_2 e^(-2gamma_E)/(log u)^2$. The corresponding product over $s<=p<u$ has the dimension-two upper bound with relative factor $1+O(1/(log s))$ by the same formula with its classical remainder.

*Weighted lower sieve.* Every element $F_(sigma)(n)$ is positive and $O_(c)(X^2)<Y^4$ eventually. Thus the normalized level is one, the size exponent is four and the dimension is two. Apply the general weighted sieve in Booker–Browning [8, §3, (6)] with these parameters. Their Table 1 at $(kappa,h)=(2,4)$ gives seven; $h$ enters (6) only through the size bound. Their auxiliary code searches $v<200$, so the resulting count $gt.double Y/(log Y)^2$ excludes primes up to $Y^(1/v)>z$. The floor error above is uniform under translation. The two-dimensional upper sieve [7] at $z$ gives the reverse estimate; its sieving level may be taken as any fixed sufficiently large power of $z$ within $D$ (for example $z^20$).

*Removal of square divisors.* The two factors are coprime. For each factor, primes $z<p<=X^(1/3)$ with $p^2$ dividing it contribute $O(Y/z+X^(1/3))$ by residue counting. For larger primes write the affected factor as $k p^2$, $k lt.double X^(1/3)$. Its values lie in an interval of length $O(Y)$ at height comparable to $X$. For each $k$, the interval for $p$ has length $O(Y/sqrt(X k))$, giving $O(X^(1/3)+Y/X^(1/3))$ possibilities altogether. Both errors are $o(Y/ell^2)$. For smooth $f$ use its bounded support for the upper bound and a fixed subinterval on which it is bounded below for the lower bound.

#pagebreak()
= Extracting the mass of true prime pairs
For each candidate of Theorem E let $k=Omega(F_(sigma)(n))-2$. Since both factors exceed one, $k in {0,1,2,3,4,5}$ and $k=0$ precisely when both are prime. Conversely every genuine pair in the window belongs to the candidates for large $X$. Pool both signs with weight $f((n-X)/H)$ and write $a_k$ for the mass in stratum $k$ divided by the total $R_X$. Thus $sum_(k=0)^5 a_k=1$, $R_X asymp_f H/ell^2$, and the exact true-pair mass is $R_X a_0$. In the notation of §1, $T_(X)(f)=(1+o(1))(ell^2/H) R_X a_0+o(1)$ by the prime-power estimate of §5. All quantities $a_k$ below depend on $X$.

#sub[Theorem F. Two positive evaluations]
Set $G_(X)(t)=sum_(k=0)^5 a_k t^k$ and $L_(X)(t)=2G_(X)(t)-G_(X)(2t)$. For $0<t<=1/3$,
$ 0 <= a_0-L_(X)(t) <= 2t^2 (1-a_0). $
The linear term cancels identically. For $k=2,3,4,5$ the remaining coefficients in $a_0-L_(X)(t)$ are $2t^2,6t^3,14t^4,30t^5$. Each lies in $[0,2t^2]$. The upper bound is attained by distributions supported on $k=0,2$. In particular
$ max(0,L_(X)(t)) <= a_0 <= (L_(X)(t)+2t^2)/(1+2t^2). $
At $t=1/16$ the absolute error is at most $1/128$. For some fixed weight, a uniform positive lower bound on $a_0$ is equivalent to the existence of a single fixed $0<t<=1/3$ with $liminf_(X->infinity) L_(X)(t)>0$. Indeed, given a positive lower bound $c$ on $a_0$ for large $X$, take $2t^2<c$. The converse uses $L_(X)(t)<=a_0$.

#sub[An exact identity at six real arguments]
The sixth forward difference of any polynomial of degree at most five vanishes. With step $1/6$ and $G_(X)(1)=1$, this gives
$ a_0 = 6 G_(X)(1/6)-15 G_(X)(1/3)+20 G_(X)(1/2)
        -15 G_(X)(2/3)+6 G_(X)(5/6)-1. $
Every $G_(X)(s)$ in this expression is a weighted sum over actual integers; for $0<s<=1$ it is at least $s^5$. The signs in the identity prevent those individual lower bounds from controlling $a_0$. The degree-five distribution $G_(X)(s)=s$ illustrates this algebraically. It has $L_(X)(t)=0$ for every $t$. It is an example about the information in an estimate; it makes no assertion about the factorization of the actual integers.

#pagebreak()
= Testing a two-point correlation input
Put $xi=exp(2pi i/6)$. Orthogonality of the sixth roots of unity on $k=0,...,5$ gives
$ 6a_0=1+2 op("Re")G_(X)(xi)+2 op("Re")G_(X)(xi^2)+G_(X)(-1). $
The last term is the mean of $lambda(n)lambda(6n+sigma)$ on the actual candidates, where $lambda(m)=(-1)^(Omega(m))$. The subtraction of two in the definition of $k$ leaves the parity unchanged. The other terms detect the residues of the same factor count modulo six and three. The constant term in this identity comes from the denominator supplied by Theorem E.

*Why the marginal laws do not suffice.* Consider equal mass at $k=0,1$ and, in a second distribution, equal mass at $k=3,4$. Their distributions modulo two coincide, as do their distributions modulo three. Their masses at zero are $1/2$ and $0$. The event selecting the true pairs is the intersection of even $k$ with $3 ∣ k$. Separate marginal data allow its mass to be as low as $max(0,op("Pr")(k " even")+op("Pr")(3 ∣ k)-1)$. Here $Pr$ uses the normalized candidate weights. Control of their joint distribution could improve this lower bound.

*What a full-interval correlation controls.* The quantitative affine Liouville theorem in [9] gives an unrestricted partial sum along $n,6n+sigma$ of size $O(X/(log X)^eta)$ for some $eta>0$. Translate $n$ by one for the negative sign if nonnegative intercepts are required. Subtracting two endpoint bounds in a critical window gives the same error size. Relative to $H/ell^2$, this bound is of order $sqrt(X)ell^(1/2-eta)$, which tends to infinity for every fixed $eta$. The cutoff, squarefree requirement and seven-factor condition also restrict the summation set. The global input thus supplies no bound of the requisite scale for the three terms in this identity.

*Remaining assertion.* For at least one fixed smooth weight, the desired upper bound for first reversal is equivalent to $liminf_(X->infinity) a_(0)(X)>0$. Theorem E supplies the correct-order denominator on each sign individually. The two-value inequality in §9 gives a sufficient signed estimate at one fixed $t$ and rules out any contribution of the three-factor class to that estimate. Its uniform positivity is unproved.

#sub[Sources for §§8–10]
[8] A. R. Booker and T. D. Browning, _Square-free values of reducible polynomials_, Discrete Analysis 2016:8, §3, §5.3 and Table 1. #link("https://doi.org/10.19086/da.732")[Article] · #link("https://arxiv.org/abs/1511.00601")[Parameter table and source code]. The translated count uses their general weighted sieve with independently checked local data.

[9] OpenAI, _Ordinary two-point correlations of multiplicative functions_, September 2026, Theorem 1.1. #link("https://github.com/openai/math/tree/main/preprints/Ordinary-two-point-correlations-of-multiplicative-functions-September-24-2026")[Preprint].
