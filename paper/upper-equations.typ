#import "layout.typ": dd

#let cert = [$ W(U,b)=sum_(U<n<=b)^dagger (3(n-U)-1), quad
   W(U,b)>3D J_D, quad J_D=floor(log_2 D)-1. $ <witnesscert>]
#let finite = [$ B_*(M)<=M+0.881768 H_M quad (2^16<=M<=2^40). $ <finiteupper>]
#let fraction = [$ 1-abs(log(1 plus.minus 1/(6n)))/h_M
 >= (6(n-U)-2)/(6n-1) >= (3(n-U)-1)/(3D). $ <fractionupper>]
#let drift = [$ d_z=limsup_(M->infinity) (ell^2)/H
  sup_(M<=t<=M+z H) (E(t)-E(M+z H))_+. $ <negativeexc>]
#let uniformdrift = [$ limsup_(M->infinity) (B_*(M)-M)/H_M
    <= (d+sqrt(d^2+2kappa/(log 2)))/kappa. $ <driftbound>]
#let coarse = [$ B_*(M)-M <<_kappa H_M+(log M)^2 Delta(2M). $ <coarseupper>]
#let proportion = [$ liminf_(X->infinity) bb(P)_X(T(M)<=z)
    >= (kappa z^2/2-c)/(16S z^2-c), quad z>sqrt(2c/kappa), quad c=1/(log 2). $ <positivefraction>]
#let sums = [$ S_1(alpha)=sum_n Lambda(n)w((n-M)/H)e(6n alpha), quad
 S_6(alpha)=sum_m Lambda(m)w((m-6M)/(6H))e(m alpha). $ <upperfouriersums>]
#let arcs = [$ (ell^2)/H sum^dagger w((n-M)/H)^2
   =6 norm(w)_2^2+(R_(M)(w))/H+o_(w)(1). $ <sixarcs>]
