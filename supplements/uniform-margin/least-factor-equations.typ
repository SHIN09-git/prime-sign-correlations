#let scale = $ ell=log X, quad X^(1/3+tau)<=Y<=X, quad I=(X,X+Y]. $
#let endpoint = $ 0 <= S_(sigma)(1/2-eta)-N_sigma
  lt.double_(tau,a) (eta+1/ell) Y/ell^2. $
#let band = $ 0 <= S_(sigma)(alpha)-S_(sigma)(beta)
  lt.double_(tau,a) (beta-alpha+1/ell) Y/ell^2. $
#let crt = $ B_(d)(i,j)=frac(Delta log 2,d^2)
  +O(X^(1/3)+Delta/(d R)). $
#let discrepancy = $ frac(R,d K) + sqrt(frac(A K,d R)) + sqrt(frac(R^3,A d)). $
#let polys = $ G_1(r,s)=r s(6r s+sigma), quad G_2(r,s)=r s(r s-sigma). $
#let gd = $ rho(p)=3p-2, quad g(p)=rho(p)/p^2, quad
  1-g(p)=(1-1/p)(1-2/p). $
#let mass = $ sum_(d<=D)^* 3^(omega(d)) abs(E_d)
  lt.double D^4 (X^(1/3)+Y X^(-a)) lt.double Y X^(-min(tau,a)/2). $
#let selberg = $ J=sum_(d<=sqrt(D))^* product_(p|d) frac(g(p),1-g(p)),
  quad B_"sift" <= frac(Delta log 2,J)+sum_(d<=D)^*3^(omega(d))abs(E_d). $
#let alt = $ 6p+sigma " prime", quad "or" quad
  6p+sigma=r s, quad T^(3/11)<r<T^(1/2-gamma), quad r<=s, $
#let bv = $ op("card"){p in (T,2T] : p " prime", P^(-)(6p+sigma)>T^theta}
  gt.double_theta T/(log T)^2. $
