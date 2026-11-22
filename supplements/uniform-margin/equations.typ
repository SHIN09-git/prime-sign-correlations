#let dd = math.dif
#let mass = $ T_(X)(f) = 1/H sum_n f((n-X)/H) Lambda(n) (Lambda(6n-1)+Lambda(6n+1)). $
#let thresholds = $ L=ceil(13X), quad R=ell^(1/2-delta), quad K=H/ell^beta, quad a_d=-mu(d)log d. $
#let remainder = $ cal(E)_X = sum_(d,v)^star (a_d a_v)/(d v)
  sum_(k in ZZ, k!=0) 2 cos((2pi k overline(6d))/v) hat(f)((k H)/(d v)) "e"(-(k X)/(d v)). $
#let reduction = $ T_(X)(f)=8C_2 I_f + cal(E)_X + O_(f,delta,beta)(ell^(-delta)log ell). $
#let thresholds_margin = $ liminf_(X->infinity) cal(E)_X > -8C_2 I_f. $
#let divisor = $ Lambda(n)=sum_(d|n) a_d, quad (6d)r_sigma equiv -sigma mod v. $
#let density = $ sum_(d,v<=L, gcd(v,6d)=1) (a_d a_v)/(d v) = 4C_2+O_(c)(L^(-c)). $
#let localproduct = $ G_(p)(s,t)=cases((1-v_p)^(-1) & quad p<=3, 1-(u_p v_p)/((1-u_p)(1-v_p)) & quad p>3). $
#let oneprog = $ sum_(n equiv b mod q) f((n-Z)/Y) Lambda(n)
    = (Y I_f)/(phi(q)) + O_(f)(sqrt(Z)log(q Z)). $
#let marginal = $ A_(r)(L):= sum_(h<=L, gcd(h,r)=1) a_h/h
    = r/(phi(r))+O_(c,epsilon)(r^epsilon L^(-c)). $
#let bound = $ |B(P,T)| lt.double_(f,epsilon) ell^2 (P^2 T)^epsilon
   (1+(T X)/P^2)^(1/2) (T^(17/20)/P^(1/20) + T/P^(1/8)). $
#let ranges = $ P>=sqrt(X), quad 1<=T<=P^gamma, quad
  0<gamma<cases(1/27 & quad P^2<X T, 1/17 & quad P^2>=X T). $
#let natural = $ P asymp sqrt(X), quad T asymp P^2/H asymp P/ell^(3/2). $
#let rough = $ sum_(p " prime", P^(-)(6p+sigma)>=z) f((p-X)/H)
   asymp_(f,theta) H/(ell log ell), quad z=ell^theta, quad 0<theta<1/4. $
#let sieve = $ product_(p<z)(1-g(p)) tilde.op (4 exp(-gamma_E) C_2)/(log z),
   quad f_("lin")(s)=(2 exp(gamma_E)log(s-1))/s. $
#let graphbound = $ abs(sum_(p in J) (c_p-1) (log p) chi(p) "e"(p alpha))
    lt.double_(B,eta) sqrt(Y log X). $
#let graphgrid = $ (R_(X,b)^*(w))/H -> -8C_2 norm(w)_2^2. $
#let euler = $ L_(b)(s,chi)=product_p (1-chi(p)p^(-s))^(-c_p)
   =L(s,chi)exp(G_(chi)(s)). $
