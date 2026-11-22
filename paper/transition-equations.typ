#import "layout.typ": dd
#let diff = [$ C_q(B)=integral_3^B I_h(x)I_h(q x) (dd x)/x, quad
  B_*(M)=inf {B>=4 : C_6(B)>=C_4(B)}. $ <passage>]
#let scale = [$ M=1/(6delta), quad ell=log M, quad H_M=sqrt(M)ell^(3/2). $ <overshoot>]
#let local = [$ (ell^2)/(H_M) P_M(v H_M) -> S v quad (v>0), quad
   S=8C_2, quad C_2=product_(p>2)^"primes" (1-1/(p-1)^2). $ <pairlaw>]
#let profile = [$ (6M)/ell (C_4(M+z H_M)-C_6(M+z H_M))
  -> 1/(log 2) - (S z^2)/2. $ <firstprofile>]
#let barrier = [$ B_*(M)>=M+c H_M, quad
  (B_*(M)-M)/(H_M) -> sqrt(2/(S log 2)). $ <location>]
#let reduction = [$ C_6(M+t)=1/(6M^2) integral_((0,t]) v dd P_M(v) + o(ell/M)
  quad (0<=t<=Z H_M). $ <pairreduction>]
#let affine = [$ r=1+c/X, quad Q_i=a_i+b_i/X, quad
  J(X)=integral_(s X)^X product_(i=0)^(k-1) I_(log r)(Q_i x) (dd x)/x. $ <affinesample>]
#let w = [$ D=max_i (b_i/a_i) - min_i (b_i/a_i), quad
 w(t)=c+D-D/t, quad W=integral_s^1 w(t)dd t. $ <affineweight>]
#let equiv = [$ ((log X)^k P(X))/X -> kappa quad arrow.l.r.double quad
 ((log X)^k J(X))/W -> kappa. $ <tupleequiv>]
#let operator = [$ (cal(T) A)(X)=w(1)A(X)-w(s)A(s X)
 -integral_s^1 w'(t)A(t X)dd t. $ <operator>]
#let band = [$ T_-=h^(-1)L^(-12), quad T_+=h^(-1)L^12, quad
 R=L^(1+2eta), quad k=ceil(L^(2+5eta)). $ <bandpar>]
#let defect = [$ cal(D)=sum_(j=1)^(2k) (2R)^j/(j!) sum_(w in cal(U)_j)
 (product_(l=1)^j u_(i_l)) min(1,2/(Y abs(omega))). $ <defect>]
#let finitetime = [$ abs(F_(h,U,Y)(a)-1/4-(arcsin(K_h(a)/V_h))/(2pi))
 <<_eta L^(-1-eta)+ L^(6+4eta) cal(D). $ <finiteclt>]
