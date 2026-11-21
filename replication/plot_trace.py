"""Illustrate the exact prime trace. Numerical certificates are in certify.py."""
import argparse
from math import exp, expm1, log, sqrt
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from numpy.polynomial.legendre import leggauss


def prime_weight(n):
    for p in range(2,n+1):
        if n%p==0:
            q=n
            while q%p==0:
                q//=p
            return log(p) if q==1 else 0
    return 0


def kernel(q,h):
    a=np.log(q)
    nodes,weights=QUADRATURE
    value=np.zeros_like(a)
    for side in (-1,1):
        for v,c in zip(nodes,weights):
            t=side*h*(1+v)/2
            window=exp(abs(t)/2)*expm1(h-abs(t))
            s=a+t
            arch=np.exp(s/2)-np.exp(-s/2)/np.expm1(2*s)
            value+=c*h/2*window*arch
    for n in range(2, int(max(q)*exp(h))+1):
        delta=np.abs(log(n)-a)
        taper=np.exp(delta/2)*np.expm1(np.maximum(h-delta,0))
        value-=prime_weight(n)/sqrt(n)*taper
    return value


QUADRATURE=leggauss(24)


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("output", type=Path)
    args=p.parse_args()
    plt.rcParams.update({"font.family":"DejaVu Sans","font.size":8,"svg.hashsalt":"prime-sign-lags"})
    fig,(left,right)=plt.subplots(1,2,figsize=(6.8,2.18),gridspec_kw={"width_ratios":[1.16,1]})
    h=1/32
    x=np.linspace(1.65,10.2,1700)
    left.plot(x,kernel(x,h)/expm1(h),color="#165d64",lw=1.8)
    left.axhline(0,color="#899397",lw=.6)
    left.set(xlabel="dilation q",ylabel=r"$K_h(\log q)/(e^h-1)$",xticks=[2,3,4,5,6,7,8,9,10])
    left.set_title("Fixed window width h = 1/32",loc="left",fontsize=8.4)
    t=np.linspace(-1.4,1.4,330)
    for h,color,dash in [(1/32,"#a14d2b","-"),(1/256,"#125963","--")]:
        y=-sqrt(2)*kernel(2*np.exp(h*t),h)/(expm1(h)*log(2))
        right.plot(t,y,dash,color=color,lw=1.6,label=f"h = 1/{round(1/h)}")
    right.plot(t,np.maximum(1-np.abs(t),0),":",color="#343a42",lw=1.4,label="limit")
    right.set(xlabel=r"displacement $\tau$",ylabel="normalized depth",xticks=[-1,0,1])
    right.set_title("Local profile at q = 2",loc="left",fontsize=8.4)
    right.legend(frameon=False,fontsize=6.8,loc="upper right",handlelength=1.8)
    for ax in (left,right):
        ax.spines[["top","right"]].set_visible(False)
        ax.grid(axis="y",color="#dce3e3",linewidth=.6)
    fig.tight_layout(pad=.5,w_pad=1.25)
    with args.output.open("w",encoding="utf-8",newline="\n") as f:
        fig.savefig(f,format="svg",metadata={"Date":None})
    plt.close(fig)


if __name__=="__main__":
    main()
