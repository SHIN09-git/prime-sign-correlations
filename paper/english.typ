#import "layout.typ": *
#import "equations.typ" as eq
#show: layout.with("en","Recovering prime powers from sign correlations in short intervals","Prime powers from sign correlations")

#text(weight:"bold")[Abstract.] We study the joint signs of the centered von Mangoldt counts on two short intervals whose left endpoints have fixed ratio $q>1$. After logarithmic averaging in the base point, the first-order deviation of the probability of two excesses from $1/4$ detects exactly the prime powers. At $q=p^k$ its coefficient is $-(log p)/(2pi sqrt(q))$. A displacement of order the window width gives an explicit triangular profile. A single reference ratio then recovers the von Mangoldt function uniformly on a growing range. The arithmetic sign results assume an independent family of zero ordinates with a quantified exceptional set. The exact formula for the multiplicity-counted spectral kernel uses only the Riemann theorem and the classical explicit formula.

= The two-window question
Write $psi(x)=sum_(n<=x) Lambda(n)$, where $Lambda(p^k)=log p$ for primes $p$, $k>=1$, and $Lambda(n)=0$ at the other integers. For $0<h<1$ define
#eq.count
The sign indicates whether the weighted count in $(x,e^h x]$ exceeds its length, with $x=e^y$. At log-separation $a$, the frequency of simultaneous excesses is
#eq.density
The inner limit is taken at fixed $h,a$. Write $L=log(1/h)$ and let $lambda(q)=Lambda(n)$ at an integer $q=n>=2$, with value zero at all other real $q>1$.

#lead[Theorem 1.][Under the hypothesis in §2, the limit in @density exists. For every fixed real $q>1$, uniformly on bounded sets of real $tau$,]
#eq.inverse
Here $u_+=max(u,0)$. At the ratios 2 and 4 the numerators agree, and the square roots in the denominators distinguish their strengths. At 6 the displayed coefficient vanishes. The two-limit assertion gives no sampling time for measuring a density at a prescribed precision.

#pagebreak()
= Zero hypotheses and uniform recovery
Use the Riemann theorem $rho=1/2+i gamma$ for every nontrivial zeta zero [4]. In sums over all ordinates we use both signs and count multiplicity. In sums over a set of distinct positive ordinates the multiplicity is written $m_gamma$.

#sub[Hypothesis on relations among ordinates]
Partition the distinct positive ordinates as $G union E$. Following the self-sufficient-ordinate viewpoint of Martin and Ng [11], the ordinates in $G$ are simple and rationally independent modulo the rational span of $E$. Explicitly, any finite rational combination of members of $G$ lying in that span has every coefficient zero. Impose the energy condition $J_h=o(h)$, where
#eq.energy
The usual linear independence hypothesis for the positive ordinates counted with multiplicity allows $E$ to be empty. Relations and multiple zeros are allowed inside $E$. The zero-location theorem alone does not establish the stated decomposition. The condition $A_E(T)=o(T)$ suffices for $J_h=o(h)$. Indeed the initial segment contributes at most $h^2 A_E(1/h)$. The dyadic intervals above $1/h$ contribute at most $sum_(j>=0)(2^j/h)^(-2) A_E(2^(j+1)/h)$. In particular $A_E(T)<<T^beta$, $0<=beta<1$, gives $J_h<<h^(2-beta)$.

#sub[A single calibration at 2]
For integer $n>=2$, form the following statistic solely from the two-excess densities and the scale $n$.
#eq.calibration
#lead[Theorem 2.][For sufficiently small $h$ the denominator is positive. Uniformly for integers $2<=N<=1/(4h)$, the recovery error satisfies]
#eq.uniform
Consequently recovery is uniform to $o(1)$ if $N h L->0$ and $sqrt(N)J_h/h->0$. For $E$ empty the first condition suffices. It also suffices when $A_E(T)<<sqrt(T)$. With error below $(log 2)/4$, the thresholds $(log 2)/2$ and $3(log n)/4$ distinguish prime powers and primes respectively. A proper prime power has $Lambda(n)<=(log n)/2$.

If the input densities are each perturbed by at most $eta$, the bound acquires $O(sqrt(N)L eta)$ provided $L eta$ is small enough. This is a stability estimate for errors supplied to the formula. It applies independently of how the densities were obtained.

#pagebreak()
= An exact covariance identity at positive lags
Define the window transform and its multiplicity-counted kernel by
#eq.modes
#eq.kernel
The kernel is real. The bound $abs(b_h(gamma))<<min(h,1/abs(gamma))$ follows from either expression in @mode. The Riemann–von Mangoldt count [6, Lemma 1] proves absolute convergence. Define, for positive arguments of $H$,
#eq.arch
#lead[Theorem 3.][For $a>h$, the canonical kernel satisfies the following exact identity. No independence or simplicity of zeros is used.]
#eq.trace
Write $B_h(a)$ for the integral in @trace. The sum over $n$ is finite. The mass of $w_h$ is $4(e^(h/2)-1)^2$, and $w_h(0)=e^h-1$.

#sub[Proof]
In the distribution sense on $t>0$ the explicit formula [5, Theorem 8] gives
$ -sum_gamma e^(i gamma t)/rho=e^(-t/2)(psi(e^t)-e^t+log(2pi)+1/2 log(1-e^(-2t))). $
Apply $partial_t+1/2$. The jumps of $psi(e^t)$ give point masses $Lambda(n)$ at $log n$. Differentiating the elementary terms yields
$ sum_gamma e^(i gamma t)=H(t)-sum_(n>=2) (Lambda(n))/sqrt(n) delta_(log n)(t). $ <distribution>
Local convergence of the original zero sum is justified in §4. The window autocorrelation is $w_h(t)$, since for $abs(t)<=h$ it equals $integral_0^(h-abs(t))e^(u+abs(t)/2)dd u$. Its Fourier transform at $gamma$ is $abs(b_h(gamma))^2$. Pair @distribution with the translated window at $a$. One may first mollify the window with a compactly supported probability density. The Fourier multipliers have modulus at most one. Absolute convergence on the spectral side and uniform convergence against the locally finite measure on the arithmetic side justify removal of the mollifier. This proves @trace, including windows with a mass at a zero-weight endpoint.

#pagebreak()
= The variance and the arithmetic limiting law
The asymptotic size of the variance fixes the coefficient in Theorem 1.
#eq.variance
For details, put $g(u)=2(1-cos u)/u^2$ with $g(0)=1$. Replacing $e^(u/2)$ by one in @mode changes $b_h$ by $O(h min(h,1/abs(gamma)))$, by direct integration below $1/h$ and integration by parts above it. Since $sum_gamma min(h^2,gamma^(-2))<<h L$ by the zero count, the variance changes by $O(h^2 L)$. For the flat window it is $2 integral_0^infinity h^2 g(h t) dd N(t)$, where $N$ counts the positive ordinates with multiplicity. Replace $dd N(t)$ by $(2pi)^(-1)log(t/(2pi))dd t$. The error after integration by parts is $O(h^2 L)$ because the counting remainder is $O(log(2+t))$ and $abs(g') (1+abs(log u))$ is integrable. The integral $integral_0^infinity g(u)dd u=pi$ follows by the Dirichlet integral. Changing variables now gives @variance.

#sub[From the zero expansion to observations at large base points]
For a dyadic block $R<=abs(gamma)<2R$ the sum of $abs(1/rho)$ in any unit frequency cell is $O((log R)/R)$. Majorize any unit time window by a translated Gaussian. On expanding the squared block sum the absolute Fourier weights between cells $j,k$ are $O(exp(-max(abs(j-k)-1,0)^2/4))$. Their row sums are bounded. The inequality $2a b<=a^2+b^2$ bounds the local squared norm by $O(R((log R)/R)^2)$. This includes multiplicities and partial blocks. Dyadic summation gives convergence in local $L^2$ uniformly in the translate. Its limit agrees a.e. at $t>0$ with the symmetric explicit formula by subsequence uniqueness.

Let $E_0(y)=e^(-y/2)(psi(e^y)-e^y)$. Then $D_h(y)=e^(h/2)E_0(y+h)-E_0(y)$. The elementary correction to $E_0$ vanishes at infinity. Thus the vector at two fixed shifts is approximated in logarithmic mean square by the finite zero sums with coefficients $-b_h(gamma)$. Kronecker–Weyl averaging puts their phases on the closure of the actual orbit with its Haar probability. Characters whose frequency is nonzero have zero time average. Approximation in mean square extends the statement to bounded Lipschitz tests of the pair and to its second moments.

In particular the actual logarithmic covariance equals $K_h(a)+2sum_(gamma>0)^"distinct" m_gamma(m_gamma-1) abs(b_h(gamma))^2 cos(gamma a)$. At $a=0$ its equality with $V_h$ for any one $h>0$ is equivalent to simplicity of all nontrivial zeros, since the exponential window makes every coefficient nonzero. This distinction matters when using @trace for arithmetic rather than canonical covariances.

#pagebreak()
= From the joint law to two signs
Under the hypothesis of §2, each good ordinate supplies an independent uniform unit-circle phase, independent of the entire exceptional phase vector. For any finite set of coordinates this follows from the character test for Haar measure on a torus. A character relation touching a good coordinate would contradict independence modulo the exceptional span. Cylinder functions then give the infinite-family statement. The exceptional coordinates have the Haar law of their own orbit closure. Each distinct nonzero frequency is orthogonal to every other positive frequency. Arbitrary internal relations therefore preserve the usual second-moment bound for this block. The energy condition ensures that good ordinates exist, since otherwise $J_h$ dominates a constant multiple of $V_h$.

One good phase with nonzero coefficient already gives an atomless one-dimensional marginal for each coordinate after convolution with the other phases. The boundary of the positive quadrant consequently has probability zero. Weak convergence from §4 identifies its probability with @density for every fixed $h,a$.

#sub[A quantitative quadrant comparison]
Uniformly whenever $abs(K_h(a))<=V_h/2$ and $h$ is sufficiently small,
#eq.model
To prove this, normalize both coordinates by $sqrt(V_h)$. The canonical covariance matrix has diagonal one and off-diagonal $K_h(a)/V_h$. Deleting the exceptional modes changes its entries by $O(J_h/V_h)$. The good sum therefore has covariance with eigenvalues in a fixed positive compact interval. Its independent vector summands are bounded in norm by $O(h/sqrt(V_h))$, and their total second moment is $O(1)$. After whitening, their summed third absolute moments are $O(sqrt(h/L))$. Bentkus's convex-set Berry–Esseen inequality [7] compares their sum to the Gaussian with the same covariance, uniformly over all translated quadrants. Apply it to finite truncations and pass to the $L^2$ limit. The covariance bounds persist for sufficiently large truncations.

The normalized exceptional vector has mean zero and second moment $O(J_h/V_h)$, with each repeated frequency grouped before squaring. By independence, condition on this vector and apply the uniform Gaussian comparison for the good sum. For a nondegenerate Gaussian, the second derivatives of a translated quadrant probability are bounded uniformly in the translation, by the $L^1$ norms of the second derivatives of its density. Taylor's theorem and the zero mean therefore cost $O(J_h/V_h)$. Restoring the deleted canonical covariance costs the same amount, by differentiating the Gaussian density in its matrix entries on a compact set of positive definite matrices. Finally the centered standard Gaussian quadrant probability is $1/4+arcsin(rho)/(2pi)$ at correlation $rho$, as follows by the angle subtended by two half-planes in a rotationally invariant plane. This proves @model.

#pagebreak()
= Reading the prime weights from the signs
Fix $q>1$ and bounded $tau$. For small $h$ the interval of support around $log q+tau h$ can meet only the mass at $log q$, if present. The smooth integral $B_h$ is $O_q(h^2)$ there. Uniformly for the stated displacements,
$ w_h(tau h)=h(1-abs(tau))_+ + O(h^2). $
Divide @trace by @variance and apply @model. The cubic error of $arcsin u=u+O(u^3)$ is negligible after multiplication by $L$. The Gaussian comparison contributes $O(sqrt(h L)+J_h/h)=o(1)$. This proves Theorem 1 including the boundary $abs(tau)=1$ and real ratios which are not prime powers.

#sub[Growing integer ranges]
If $2<=n<=N<=1/(4h)$ and $h$ is small, then $n(e^h-1)<1$ and $n(1-e^(-h))<1$. Hence the interval $(n e^(-h),n e^h)$ contains just the integer $n$. On its log window $abs(H)<<sqrt(n)$, so @trace gives, uniformly,
$ K_h(log n)=-(e^h-1)Lambda(n)/sqrt(n)+O(h^2 sqrt(n)). $ <isolated>
The bound $Lambda(n)/sqrt(n)<<1$ and @variance give $abs(K_h(log n))/V_h<1/2$ throughout this range for small $h$. Applying the sine in @calibration undoes the Gaussian arcsine exactly. Its Lipschitz bound propagates the error of @model, giving
#eq.bound
The sign convention is fixed by @isolated. In particular $S_h(2)/c_h=(log 2)/sqrt(2)+O(sqrt(h L)+J_h/h+h)$ stays positive. Put $A_n=sqrt(n) S_h(n)/c_h$. Then $hat(Lambda)_h(n)=(log 2) A_n/A_2$. The identity
$ (log 2) A_n-Lambda(n)A_2=(log 2)(A_n-Lambda(n))-Lambda(n)(A_2-log 2) $
and $Lambda(n)<=log n<<sqrt(N)$ give @uniform. This proves Theorem 2. A perturbation of size $eta$ in any input density changes $S_h$ by at most $2pi eta$. Division by $c_h$ costs $O(L)$, yielding the asserted stability at the same nonvanishing reference denominator.

For full linear independence one may take, for instance, $N=floor(1/(h L^2))$. The calculation uses two-excess frequencies only. It uses the known prime 2 to cancel the unknown marginal variance, even if that variance has not been measured.

#pagebreak()
= Numerical checks on the trace
At $h=1/32$ the table shows outward enclosures of $K_h(log n+tau h)$, rounded further outwards for display. The direct computation uses the prime side of @trace. The spectral computation uses a separate sum over zero ordinates and a rigorous bound on the entire omitted tail.

#figure(table(columns:(.50fr,.55fr,1.64fr,1.64fr),align:(right,right,center,center),stroke:none,inset:3.6pt,
table.hline(),table.header([$n$],[$tau$],[Direct trace],[Spectral enclosure]),table.hline(stroke:.45pt),
[2],[0],[$[-0.014392,-0.014387]$],[$[-0.015327,-0.013420]$],
[2],[$1/2$],[$[-0.006591,-0.006585]$],[$[-0.007542,-0.005634]$],
[2],[1],[$[0.001210,0.001216]$],[$[0.000251,0.002159]$],
[4],[0],[$[-0.009055,-0.009046]$],[$[-0.009993,-0.008086]$],
[6],[0],[$[0.002413,0.002424]$],[$[0.001464,0.003372]$],table.hline()),caption:[Canonical covariances. The finite-width values check the trace identity.])

#figure(image("trace.svg",width:99%),caption:[The canonical covariance divided by $e^h-1$ at a fixed width (left). Near ratio 2 the normalized dip approaches the triangular prediction (right).])

The direct check encloses $w_h$ and $H$ on each half-window by monotonicity. The other calculation uses the 22,491 positive ordinates below $T=20000$. Disjoint rational brackets come from opposite Hardy $Z$ signs, together with the zero count at $T$ [9]. Using $N(t)<=t log(t)/(2pi)$ for $t>=T$, partial summation bounds the absolute covariance tail by
$ 2(1+e^(h/2))^2 ((log T+1)/(pi T)-N(T)/T^2) < 0.000954. $
The counting inequality follows from [6, Lemma 1]. The verification scripts provide all nine test cases. These numerical checks concern the kernel at a fixed width. The signs of the prime-counting windows and their limiting densities enter the separate probabilistic argument in §5.

#pagebreak()
= Measuring the signs at finite height
The statistic in @density also admits a direct finite-volume evaluation. This calculation uses actual prime powers with their logarithmic weights. For a rational window ratio $r=33/32$ we evaluate
$ F_q(A,B)=1/(log(B/A)) integral_A^B bold(1)_(psi(r x)-psi(x)>(r-1)x) bold(1)_(psi(r q x)-psi(q x)>(r-1)q x) (dd x)/x. $ <finite>

For integer $q$ the two counts can jump only at $x=m$, $m/r$, $m/q$ or $m/(r q)$ for prime powers $m$. Multiplication by $33q$ puts these breakpoints on an integer grid. On an intervening cell $(u,v)$ let $s,t$ be the two constant weighted counts. Both windows have an excess precisely up to the cutoff
$ c=max(u,min(v,32s,32t/q)). $
The contribution to the numerator is $log(c/u)$, including an empty cell or a full cell. Endpoint choices have logarithmic measure zero. Sieving all prime powers up to $floor(r q B)$ and summing these cell integrals with directed ball arithmetic gives the following frequencies.

#figure(table(columns:(1.1fr,1fr,1fr,1fr),align:center,stroke:none,inset:5pt,
table.hline(),table.header([Base range $[A,B]$],[$q=2$],[$q=4$],[$q=6$]),table.hline(stroke:.45pt),
[$[2^9,2^14]$],[0.181675],[0.212266],[0.254054],
[$[2^14,2^16]$],[0.190440],[0.240567],[0.226125],table.hline()),
caption:[Measured joint excess frequencies, rounded to six decimal places. The archived intervals have width at most $10^(-9)$.])

The sign of $F_6(A,B)-1/4$ changes between the two ranges. In the larger range the frequency at ratio 6 is even lower than the frequency at the prime-power ratio 4. Thus the ordering of the observed frequencies at a single height can give a different impression from their limiting first-order coefficients. This is one reason the sampling-time question matters.

#pagebreak()
= Scope and references
Montgomery and Soundararajan [2] studied Gaussian prime counts in short intervals in a common finite-height regime. Leung [1] obtained the joint Gaussian law and secondary negative correlations for nearby short windows under RH and LI. In his normalization the center displacement is $t$ times the window width and Theorem 3.1 bounds its largest normalized center parameter by $delta^(-1/10)$. A fixed dilation here requires displacements of order $1/h$ and allows the localized prime masses in @trace to enter. Landau’s exponential sum already detects a prime-power multiplier through a linear statistic of zeta zeros [10, Eq. (1.1)]. Suzuki [3] exhibited the prime-power terms in a twice-integrated zeta explicit formula. The spectral atoms in @distribution and the Gaussian arcsine identity are classical. The object recovered here is the coefficient of a binary counting statistic at macroscopic ratios, together with its growing-range and perturbation estimates.

The coefficient and recovery theorems concern ordered limits. Removing the spectral independence condition for the two-excess observable or proving a quantitative common-limit theorem in $h$ and $Y$ would strengthen them. The exact spectral trace and the arithmetic multiplicity correction in §4 already hold with the Riemann theorem alone. The accompanying Lean project checks the window profile, the first-order sine transfer, the calibration bound, both arithmetic decision thresholds and the cell inequalities used in §8. It also derives the fixed-lag inverse limit from explicit trace, variance and Gaussian-comparison inputs. The zero expansion and the probabilistic estimates supplying those inputs are proved in the text. This preprint has not undergone external peer review.

#sub[References]
#set text(size:10.2pt)
#set par(spacing:.44em,leading:.52em)
[1] S.-K. Leung. Joint distribution of primes in multiple short intervals. _Advances in Mathematics_ (2026). #link("https://arxiv.org/abs/2401.04000")[arXiv:2401.04000].

[2] H. L. Montgomery and K. Soundararajan. Primes in short intervals. _Comm. Math. Phys._ *252* (2004), 589–617. #link("https://doi.org/10.1007/s00220-004-1222-4")[Journal].

[3] M. Suzuki. Aspects of the screw function corresponding to the Riemann zeta-function. _J. London Math. Soc._ (2023). #link("https://doi.org/10.1112/jlms.12785")[Journal].

[4] L. Alpöge. #link("https://alpo.ge/remark.pdf")[Proof announcement] (2026). Lean and Mathlib communities. #link("https://leanprover-community.github.io/blog/posts/riemann-hypothesis/")[Verification statement].

[5] T. Tao. 246B, Notes 4. The Riemann zeta function and the prime number theorem (2021), Theorem 8. #link("https://terrytao.wordpress.com/2021/02/12/246b-notes-4-the-riemann-zeta-function-and-the-prime-number-theorem/")[Notes].

[6] R. P. Brent, D. J. Platt and T. S. Trudgian. The mean square of the error term in the prime number theorem. _J. Number Theory_ *238* (2022), 740–762. #link("https://doi.org/10.1016/j.jnt.2021.09.016")[Journal].

[7] V. Bentkus. A Lyapunov-type bound in $RR^d$. _Theory Probab. Appl._ *49* (2005), 311–323. #link("https://doi.org/10.1137/S0040585X97981123")[Journal].

[8] A. Iksanov, Z. Kabluchko and A. Marynych. Almost periodic stochastic processes with applications to analytic number theory (2025). #link("https://arxiv.org/abs/2502.04969")[arXiv:2502.04969]. For related functional limiting laws.

[9] Dyadic prime mean-square project. Certified zero brackets and independent endpoint audit (2026), revision #link("https://github.com/SHIN09-git/dyadic-prime-mean-square/tree/1cea164bd25696723c376c48aaa677fbea7ea188")[1cea164].

[10] K. Ford and A. Zaharescu. On the distribution of imaginary parts of zeros of the Riemann zeta function. _J. reine angew. Math._ *579* (2005), 145–158. #link("https://arxiv.org/abs/math/0405459")[Paper].

[11] G. Martin and N. Ng. Inclusive prime number races. #link("https://arxiv.org/abs/1710.00088")[arXiv:1710.00088].
