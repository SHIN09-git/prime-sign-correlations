#import "layout.typ": dd
#let count = [$ D_(h)(y) = e^(-y/2) (psi(e^(y+h))-psi(e^y)-(e^h-1)e^y). $ <count>]
#let density = [$ d_(h)(a) = lim_(Y->infinity) 1/Y integral_0^Y bold(1)_(D_(h)(y)>0) bold(1)_(D_(h)(y+a)>0) dd y. $ <density>]
#let inverse = [$ lim_(h->0^+) 2pi L (1/4-d_(h)(log q+tau h))
  = lambda(q)/sqrt(q) (1-abs(tau))_+. $ <inverse>]
#let energy = [$ J_h = sum_(gamma in E) m_gamma^2 min(h^2,gamma^(-2)), quad
  A_(E)(T)=sum_(gamma in E, gamma<=T) m_gamma^2. $ <energy>]
#let calibration = [$ S_(h)(n)=-sin(2pi(d_(h)(log n)-1/4)), quad
  hat(Lambda)_h(n)=sqrt(n/2)(log 2) (S_(h)(n))/(S_(h)(2)). $ <calibration>]
#let uniform = [$ max_(2<=n<=N) abs(hat(Lambda)_h(n)-Lambda(n))
  << N h + sqrt(N h L) + sqrt(N) J_h/h . $ <uniform>]
#let modes = [$ b_(h)(gamma) = (e^((1/2+i gamma) h)-1)/(1/2+i gamma)
  = integral_0^h e^(u/2)e^(i gamma u)dd u. $ <mode>]
#let kernel = [$ K_(h)(a)=sum_gamma abs(b_(h)(gamma))^2 e^(i gamma a), quad V_h=K_(h)(0). $ <kernel>]
#let arch = [$ H(t)=e^(t/2)-e^(-t/2)/(e^(2t)-1), quad
  w_(h)(t)=cases(e^(abs(t)/2)(e^(h-abs(t))-1) & abs(t)<=h, 0 & abs(t)>h). $ <arch>]
#let trace = [$ K_(h)(a)=integral_(-h)^h w_(h)(t)H(a+t)dd t
  -sum_(n>=2) (Lambda(n))/sqrt(n) w_(h)(log n-a). $ <trace>]
#let variance = [$ V_h=h(L+c_0)+O(h^2 L), quad
  c_0=1/pi integral_0^infinity (2(1-cos u))/u^2 log(u/(2pi))dd u. $ <variance>]
#let model = [$ abs(d_(h)(a)-1/4-1/(2pi)arcsin(K_(h)(a)/V_h))
  << sqrt(h/L) + J_h/(h L). $ <model>]
#let bound = [$ abs(sqrt(n) S_(h)(n)/c_h-Lambda(n))
  << n h + sqrt(n h L) + sqrt(n)J_h/h, quad c_h=(e^h-1)/V_h. $ <bound>]
