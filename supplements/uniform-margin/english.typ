#import "../../paper/layout.typ": layout, lead, sub
#import "equations.typ" as eq
#show: layout.with("en","The unresolved margin for affine prime pairs","The uniform prime-pair margin")
#set document(description:"A divisor expansion, trilinear savings, rough partners and a one-point obstruction for affine prime pairs in critical short intervals.")
#set text(size:11pt)
#set par(leading:.5em,spacing:.47em)
#lead[Research note.][The strict lower bound for genuine prime pairs at every large real starting point remains open. We isolate a signed sum, remove an explicit frequency range, prove a lower bound for rough partners, and construct weights attaining complete cancellation while retaining strong one-point estimates.]

= The critical interval
Put $ell=log X$, $H=sqrt(X)ell^(3/2)$ and $f=w^2$, with $w$ a fixed nonzero nonnegative smooth function of compact support in $(0,a)$. Write $I_f=integral_RR f(u) dif u$ and $C_2=product_(p>2)(1-1/(p-1)^2)$. The von Mangoldt function weights every prime power $p^j$ by $log p$. We study
#eq.mass
The upper bound sought in the parent paper [1, Theorem 4D] is equivalent to $liminf_(X->infinity) T_(X)(f)>0$ for some such weight. Indeed prime powers of exponent at least two contribute $o(1)$, and a translate of a smooth plateau covers the interval used in the converse. The constant $a$ may be any fixed positive number.

#sub[Theorem A. Divisor reduction]
Fix $0<delta<1/2$ and $beta>0$ and set
#eq.thresholds
In the star below both divisors belong to $(R,L]$, $d v>K$ and $gcd(v,6d)=1$. The bar means inverse modulo $v$, $"e"(t)=exp(2pi i t)$ and $hat(f)(xi)=integral_RR f(u)"e"(-u xi) dif u$. Define
#eq.remainder
#eq.reduction
Opposite frequencies are complex conjugates, so the remainder is real. Thus the missing assertion for at least one fixed $w$ is precisely
#eq.thresholds_margin
The zero-mode calculation uses the ordinary Riemann theorem, and the estimates in reduced progressions use the critical-line theorem for Dirichlet $L$-functions [2]. Sections 2–6 detail the analytic inputs.

#pagebreak()
= The zero mode in a finite rectangle
For large $X$ the support and both its affine images lie below $L$. For each sign $sigma=plus.minus 1$ expand both weights exactly. If $d|n$ and $v|(6n+sigma)$, then $gcd(v,6d)=1$, since every common prime factor would divide $sigma$. For compatible divisors write $n equiv d r_sigma mod d v$, where
#eq.divisor
Poisson summation of $f((n-X)/H)$ on this class gives, after division by $H$, a term $I_f/(d v)$ and the nonzero Fourier modes with phase $"e"(k(r_sigma/v-X/(d v)))$. For $v=1$ take $r_sigma=0$. Adding the signs gives the cosine from §1. All divisor sums are finite and the Fourier series for each pair converges absolutely.

#sub[Evaluation of the rectangular term]
For each $0<c<1/2$ the density per sign is
#eq.density
Write $U(y)=sum_(h<=y) (mu(h))/h$ and $V(y)=sum_(h<=y) a_h/h$. The classical Mertens consequence of the ordinary critical-line theorem gives $sum_(h<=y) mu(h)=O_(epsilon)(y^(1/2+epsilon))$ [3]. Partial summation and $1/(zeta(1+s))=s+O(s^2)$ give $U(y)=O_(c)(y^(-c))$ and $V(y)=1+O_(c)(y^(-c))$. The bounds extend to $0<y<1$ by setting the sums to zero.

Before multiplication by logarithms the double Dirichlet series for $(mu(d)mu(v))/(d v)$ with $gcd(v,6d)=1$, twisted by $d^(-s)v^(-t)$, equals $(G(s,t))/(zeta(1+s)zeta(1+t))$. For $u_p=p^(-1-s)$ and $v_p=p^(-1-t)$ the factors of $G$ are
#eq.localproduct
Write $G=sum g_(i j)i^(-s)j^(-t)$. Expanding the factors gives $sum |g_(i j)|(i j)^c(1+log(i j))^2<infinity$ for $c<1/2$, using a slightly larger exponent to absorb logarithms. The convolution in the rectangle is the sum of $g_(i j)$ times the two factors $V(L/i)-(log i)U(L/i)$ and $V(L/j)-(log j)U(L/j)$. The preceding absolute moment bounds the error by $O_(c)(L^(-c))$, including the product of the two errors. The constant is $G(0,0)=3 product_(p>3)(1-1/(p-1)^2)=4C_2$.

#pagebreak()
= Removing small divisors
#sub[Small products]
For $d v<=K$ the absolute, unnormalized discrepancy of one compatible class is $O_(f,N)((d v/H)^N)$ for any $N>0$. This follows by rapid Fourier decay including the prefactor $H/(d v)$. Also $sum_(d v<=K)|a_d a_v| lt.double K log^3(2K)$ by summing over $d$. After division by $H$ the whole range costs $O_(f,beta,A)(ell^(-A))$ for every fixed $A>0$.

#sub[One small divisor, with the other unrestricted]
For a reduced class $b$ modulo $q$, $q$ bounded by a fixed power of $log Z$, $Z asymp X$ and $Y asymp H$, the smoothed progression estimate is
#eq.oneprog
To see the error, the Mellin transform at $1/2+i t$ is $O_(f)((Y/sqrt(Z))(1+abs(t)Y/Z)^(-2))$ by two integrations by parts. The explicit formula and the unit-interval count $O(log(q(2+abs(t))))$ for the zeros of a primitive character give $O_(f)(sqrt(Z)log(q Z))$ upon summation [2,4]. The pole contributes $Y I_f$ for the principal character. The remaining archimedean terms are absorbed in this error. Inducing a character removes only powers above primes dividing $q$, of total weight $O_(f)(log(2q))$ on the support. Character orthogonality gives the display.

For use in the zero mode we also have, for each $0<c<1/2$ and $epsilon>0$,
#eq.marginal
The factor left after extracting $1/(zeta(1+s))$ is $product_(p|r)(1-p^(-1-s))^(-1)$. Convolve with $U,V$ as above. Its coefficient moment of order $c$, with a logarithmic factor, is $O_(c,epsilon)(r^epsilon)$ by the Euler product at a slightly larger exponent below $1$. Its value at zero is $r/(phi(r))$.

Fix $v<=R$ coprime to $6$. Summing the entire $d$-coordinate reconstructs $Lambda(n)$ on one reduced class modulo $v$, with zero-mode prediction $(H I_f A_(v)(L))/v$. For $gcd(v,6)>1$ both sums are empty. Fixing $d<=R$ instead reconstructs $Lambda(6n+sigma)$ on the class $sigma$ modulo $6d$, centered at $6X+sigma$ with length parameter $6H$. Its prediction is $(H I_f A_(6d)(L))/d$. In either case the total discrepancy after weighting and normalizing is $O_(f)((R log(2R))/sqrt(ell))$ plus a power-decaying term from the marginal formula. Intersections with $d v<=K$ cost less than any log power, and $R^2<K$ eventually. This proves Theorem A.

#pagebreak()
= A range of the genuine nonzero modes
#sub[Theorem B. A trilinear estimate]
Restrict the remainder in §1 to dyadic intervals $P<=d,v<2P$ and $T<=|k|<2T$, with $P>=sqrt(X)$, $T>=1$. Denote the result by $B(P,T)$. Then
#eq.bound
The same estimate, up to fixed factors, holds with adjacent divisor intervals of comparable lengths when both lower endpoints are at least $sqrt(X)$. Individual cutoffs at $L$ are allowed. The conditions $d v>K$ and $d,v>R$ are then automatic.

To prove it, expand the cosine and split the signs of $k$. Write $m=6d$, $n=v$ and insert the integral defining $hat(f)$. For each $u$ in its fixed support the phase is $plus.minus (|k| overline(m))/n$ with an additional term $-(6k(X+H u))/(m n)$. Its two first partial derivatives have absolute values at most constants times $T X/(m^2 n)$ and $T X/(m n^2)$. Apply Bettin–Chandee, Theorem 1 and Remark 1 [5], with coefficients supported on multiples of six in the first coordinate. Their three Euclidean norms are $O(ell/sqrt(P))$, $O(ell/sqrt(P))$ and $O(sqrt(T))$. The theorem's two terms before these norms are $(T P^2)^(7/20) P^(1/4)$ and $(T P^2)^(3/8)(T P)^(1/8)$ up to $(P^2 T)^epsilon$. The perturbation contributes the displayed square root. Integration against $|f(u)|$ completes the bound.

Summing the following range of dyadic blocks gives $o(1)$:
#eq.ranges
Here $gamma$ is positive and fixed. In the first range the square root costs $O(T^(1/2))$. The two power-saving exponents before $epsilon$ losses are $1/20-27gamma/20$ and $1/8-3gamma/2$. In the second range they are $1/20-17gamma/20$ and $1/8-gamma$. There are only $O(ell^2)$ such blocks.

#sub[Where the bound loses its saving]
At the balanced scale
#eq.natural
the Fourier argument $k H/(d v)$ stays of order one. The trilinear upper estimate here grows by a power of $P$. It gives no sign or positive margin for the total remaining sum. Different blocks could still cancel each other.

#pagebreak()
= Genuine primes with a rough partner
#sub[Theorem C. A lower bound in every critical interval]
Let $P^(-)(m)$ be the smallest prime divisor of $m>1$. For each sign $sigma in {-1,1}$ and each sufficiently large real $X$, the following estimate holds uniformly:
#eq.rough
In particular, there are at least a constant times $H/(ell log ell)$ distinct base primes in the support with this property, for each sign separately.

Apply the one-dimensional linear sieve [6] to the nonnegative sequence $f((n-X)/H)Lambda(n)$, removing the classes $6n+sigma equiv 0 mod p$ for $p<z$. The local density is $g(2)=g(3)=0$ and $g(p)=1/(p-1)$ for $p>3$. A squarefree modulus coprime to six selects exactly one reduced class. The progression estimate of §3 gives error $O_(f)(sqrt(X)ell)$ for each such modulus at the levels below. For one containing 2 or 3 the sifted class is empty. The product has sieve dimension one by Mertens' product formula and
#eq.sieve
Here $gamma_E$ is Euler's constant and the displayed lower sieve function applies for $2<s<4$. Choose $2<s<min(4,1/(2theta))$, then $D=z^s$ satisfies $D sqrt(X)ell=o(H/(log z))$. The sum of progression errors through level $D$ is therefore negligible. The lower sieve constant is positive and the upper sieve constant finite. This gives weighted Mangoldt mass comparable to $H/(log z)$.

There are $O_(f)(H/sqrt(X)+ell+H ell/X^(2/3))$ proper prime powers in the support. For squares count their possible roots, and for each of the $O(ell)$ larger exponents bound their number by $O_(f)(1+H/X^(2/3))$. Their weight is negligible. Since $log p=ell+o(1)$ uniformly, division gives the claim.

#sub[How many survivors must be prime?]
Pool the two signs, counting $(p,sigma)$ with weight $f((p-X)/H)$. The denominator of the surviving fraction has order $H/(ell log ell)$. The desired prime-pair numerator has order at least $H/ell^2$ precisely when the fraction with $6p+sigma$ prime is $gt.double (log ell)/ell$, uniformly in $X$. Prime partners always survive for large $X$. The lower bound for rough partners establishes the denominator. A lower bound for this fraction is still missing.

#pagebreak()
= Weights that erase every prime pair
#sub[Theorem D. A test of one-point information]
There are fixed integers $0<=c_p<=4$ for actual primes, with $c_p c_(6p+sigma)=0$ on every prime edge. At the same time, for every $B>0$, $0<eta<=1$, every dyadic block $[X,2X]$, every interval $I$ therein of length $Y>=X^eta$, each subinterval $J subset.eq I$, every Dirichlet character of modulus at most $X^B$, and every real $alpha$, one has
#eq.graphbound
The estimate holds for all sufficiently large dyadic $X$. Cutting at dyadic boundaries gives the corresponding critical-window bound even if the window crosses one such boundary.

Join two primes if the larger is $6p+1$ or $6p-1$ for the smaller prime $p$. Each vertex has at most two children and at most one parent, since the two inverse candidates differ by $1/3$. Give the primes independent labels uniform on $(0,1)$. Retain a vertex exactly when its label is the smallest in its closed neighborhood. Set $c_p=1+op("deg")(p)$ if retained and zero otherwise. Symmetry gives $EE c_p=1$. Adjacent vertices cannot both be retained, and isolated vertices have $c_p=1$.

Write $N(J)$ for the number of nonisolated primes in $J$. By the two-dimensional Selberg upper sieve [1, §11; 7], $N(I) lt.double_(eta) Y/ell^2$. Indeed count child pairs in $I$ and in the two parent preimages of $I$ of length $Y/6$. In all three ranges the two forms have at most two forbidden classes at a prime, and two for every prime above three. The translated-interval sieve bound is $O(Y/(log^2 Y))$. Thus at most $O_(eta)(Y/ell^2)$ prime weights in $I$ change. At the critical scale this is only an $O(1/ell)$ fraction of the primes. Even the rough-candidate counts of §5 change by at most $O_(f)(H/ell^2)$ when the base primes receive the marks.

The graph joining vertices at distance at most two has degree at most nine. A greedy ten-coloring yields independent centered variables within each color because their closed neighborhoods are disjoint. For fixed $J,chi,alpha$ apply Hoeffding's inequality to real and imaginary parts within each color, with individual bound $3 log(2X)$. A union over colors and parts gives a tail $O(exp(-c t^2/(N(J)ell^2)))$ if $N(J)>0$. Use $t=C_B ell sqrt((1+N(J))ell)$. There are $O(X^2)$ distinct integer intervals, $O(X^(2B+1))$ characters, and $O(X^4)$ points on a frequency mesh of spacing $X^(-4)$ modulo one. Choose $C_B$ so the exceptional probabilities are summable over dyadic $X$. The derivative bound $O(X^2 ell)$ fills the mesh. Borel–Cantelli and the countable intersection over positive integer $B$ give a single realization. The bound in terms of $N(J)$ applies to arbitrary subintervals; the estimate for $N(I)$ proves the theorem.

#pagebreak()
= What survives in the model
Set $b(p^j)=c_p log p$ for $j>=1$, and $b(n)=0$ otherwise. In any critical interval smoothing by a fixed bump costs only its bounded variation. The prime discrepancy from §6 is $O_(f)(sqrt(H ell))$ uniformly in additive frequency, including character twists of any fixed polynomial conductor range. Proper powers contribute $O_(f)(ell(H/sqrt(X)+ell+H ell/X^(2/3)))$ to each one-point transform. These errors are $o(H)$. The bound applies as well at $6X$ on a window of length $6H$.

On the primorial grid of [1, Theorem 4D] let $q<=ell^(1/64)$, $tau=ell^(1/16)$ as there. Its arcs have total length $O(q tau/H)$. Each genuine transform is $O_(w)(H)$ by the untwisted estimate; the marked transforms have the same bound. Replacing both factors changes the entire grid integral by $O_(w)(q tau sqrt(H ell))=o(H)$. Its main term is still $8C_2 H norm(w)_2^2$. On the full circle, orthogonality counts marked pairs; all prime edges have weight zero and terms with a proper power contribute $o(H)$ by §5 times $O(ell^2)$ per occurrence. Consequently its complementary integral satisfies
#eq.graphgrid

There is also a multiplicative interpretation. For each character,
#eq.euler
For $op("Re") s>1$ the product converges absolutely and its negative logarithmic derivative has coefficients $b(n)chi(n)$. The logarithmic difference there defines $G_chi$. Its first prime-power term is $sum_p (c_p-1)chi(p)p^(-s)$, locally uniformly convergent for $op("Re") s>1/2$ by §6 on full dyadic blocks and partial summation, including division by $log p$. Terms of prime-power degree at least two converge absolutely there. Thus the ratio extends as a holomorphic nonvanishing factor on that open half-plane and preserves the zeros and poles there. This construction changes Euler multiplicities. It supplies neither the ordinary Euler factors nor a functional equation for the modified series.

The model attains equality at the threshold using these one-point controls. Establishing strict inequality for the actual weights requires information that distinguishes them from the marked sequence. The divisor coefficients in §1 are one such distinction. The signed estimate that would complete the proof remains open.

#pagebreak()
= Sources and proof verification
#sub[Analytic sources]
[1] GPT-6.2 Astra and JIN HANZHE. _Sign correlations of primes in short intervals and their first reversal_, third edition (2026), §§11–12 and Theorem 4D. #link("https://github.com/SHIN09-git/prime-sign-correlations/tree/d62b69ce93b4b84372d731a57f56e03177558342")[Fixed revision].

[2] L. Alpöge, ordinary and Dirichlet critical-line theorems (2026). Verification materials collected by A. V. Sutherland. #link("https://math.mit.edu/~drew/grh/")[Checked statements and independent kernel checks].

[3] E. C. Titchmarsh, _The Theory of the Riemann Zeta-function_, 2nd ed., Theorem 14.25(C). See also Hu et al., _On a Mertens-type conjecture for number fields_. #link("https://doi.org/10.1017/S0305004124000306")[Article].

[4] D. Koukoulopoulos, _The Distribution of Prime Numbers_, AMS, ch. 11. #link("https://dms.umontreal.ca/~koukoulo/documents/publications/primes.pdf")[Author's text].

[5] S. Bettin and V. Chandee, _Trilinear forms with Kloosterman fractions_, Theorem 1 and Remark 1. #link("https://arxiv.org/abs/1502.00769")[Paper].

[6] T. Tao, _The linear sieve and Chen's theorem_, Theorem 2 and equations (10)–(11) (2015). #link("https://terrytao.wordpress.com/2015/01/29/254a-supplement-5-the-linear-sieve-and-chens-theorem-optional/")[Notes].

[7] K. Ford, _Sieve Methods_ (2023), Selberg's sieve. #link("https://ford126.web.illinois.edu/sieve2023.pdf")[Course notes]. For the classical obstruction see T. Tao, _A general parity problem obstruction_ (2014). #link("https://terrytao.wordpress.com/2014/11/21/a-general-parity-problem-obstruction/")[Article].

#sub[Formal verification]
The accompanying Lean 4 module proves the genuine finite divisor expansion for both signs, coprimality of the two moduli, exclusion of adjacent marked vertices, the exponent inequalities in §4, and the uniform positive-fraction equivalence in §5 given its two-sided denominator estimate. The analytic estimates, concentration and Euler-product continuation are proved in this note. The supplement's verification instructions identify each checked declaration.

#sub[Status]
This public research note records partial results. The all-height strict margin and the corresponding first-reversal upper bound at the critical scale remain open.
