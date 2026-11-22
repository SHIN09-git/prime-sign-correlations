"""Directed verification of a first sign reversal and the affine prime-tuple window."""
import argparse
from bisect import bisect_right
from collections import defaultdict
from fractions import Fraction as F
import json
from math import isqrt
from pathlib import Path

from flint import arb, ctx, fmpq


def ball(value):
    value = F(value)
    return arb(fmpq(value.numerator, value.denominator))


def enclosure(value, scale):
    lower = (value.lower()*scale).floor().unique_fmpz()
    upper = (value.upper()*scale).ceil().unique_fmpz()
    if lower is None or upper is None:
        raise ArithmeticError("Cannot select outward decimal endpoints")
    return [int(lower), int(upper)]


def prime_tables(limit):
    primes = bytearray([1]) * (limit+1)
    primes[:2] = bytes(2)
    for p in range(2,isqrt(limit)+1):
        if primes[p]:
            primes[p*p::p] = bytes((limit-p*p)//p+1)
    base = {}
    for p in range(2,limit+1):
        if primes[p]:
            n = p
            while n <= limit:
                base[n] = p
                n *= p
    return primes, base, sorted(base)


def first_reversal(den, bound, base, powers):
    # x in [3,B], common widths 1+1/den. The integral at 4 equals h exactly.
    scales = (1,4,6)
    grid = 12*(den+1)
    start, stop = 4*grid, bound*grid
    counts = [arb(0),arb(0),arb(0)]
    events = defaultdict(list)
    logs = {}
    for n in powers[:bisect_right(powers,6*bound*(den+1)//den)]:
        p = base[n]
        if p not in logs:
            logs[p] = arb(p).log()
        for j,q in enumerate(scales):
            entry, leave = (12//q)*den*n, (grid//q)*n
            if entry <= start < leave:
                counts[j] += logs[p]
            if start < entry < stop:
                events[entry].append((j,logs[p]))
            if start < leave < stop:
                events[leave].append((j,-logs[p]))
    diff = ball(F(den+1,den)).log()
    a = start
    for count,b in enumerate(sorted([*events,stop]),1):
        lo,hi = arb(a),arb(b)
        caps = [(den*grid*mass/q).min(hi).max(lo) for q,mass in zip(scales,counts)]
        c4,c6 = caps[0].min(caps[1]),caps[0].min(caps[2])
        new = diff + (c4/c6).log()
        if new < 0:
            root = c4*diff.exp()
            if not (diff > 0 and c4 < root and root < c6):
                raise ArithmeticError("Crossing is outside the decreasing portion")
            bounds = enclosure(root/grid,10**8)
            if bounds[1]-bounds[0] != 1:
                raise ArithmeticError("First crossing not isolated on the decimal grid")
            return {"width_denominator":den,"first_crossing":bounds,
                    "grid_cell":[a,b,grid],"cells_checked":count}
        if not new > 0:
            raise ArithmeticError(f"Undecided endpoint at width 1/{den}, grid coordinate {b}")
        diff = new
        for j,delta in events.get(b,()):
            counts[j] += delta
        a = b
    raise ArithmeticError(f"No crossing below {bound} for width 1/{den}")


def endpoint_difference(den,upper,base,powers):
    # Independently recompute both integrals by prefix differences at rational
    # midpoints, using separate jump partitions and the precise upper endpoint.
    lower,r = F(3),F(den+1,den)
    needed = powers[:bisect_right(powers,int(6*r*upper))]
    prefix=[arb(0)]
    logp={}
    for n in needed:
        p=base[n]
        if p not in logp:
            logp[p]=arb(p).log()
        prefix.append(prefix[-1]+logp[p])
    def psi(x):
        return prefix[bisect_right(needed,int(x))]
    def measured(q):
        cuts={lower,upper}
        for scale in (1,q):
            for m in needed:
                if m>r*scale*upper:
                    break
                for z in (F(m,scale), F(m,scale)/r):
                    if lower < z < upper:
                        cuts.add(z)
        cuts=sorted(cuts)
        area=arb(0)
        for a,b in zip(cuts,cuts[1:]):
            mid=(a+b)/2
            bounds=[den*(psi(r*scale*mid)-psi(scale*mid))/scale for scale in (1,q)]
            cap=ball(b).min(bounds[0]).min(bounds[1]).max(ball(a))
            area+=(cap/ball(a)).log()
        return area
    return measured(4)-measured(6)


def affine_test(X,s,forms,primes,base,powers):
    c=F(1,8)
    r=1+c/X
    qs=[a+F(b,X) for a,b in forms]
    A,B=s*X,F(X)
    streams=[]
    for q in qs:
        intervals=[]
        for m in powers[bisect_right(powers,int(A*q)):bisect_right(powers,int(B*q*r))]:
            l=max(A,F(m)/(q*r))
            u=min(B,F(m)/q)
            if l<u:
                intervals.append((l,u,m))
        streams.append(intervals)
    idx=[0]*len(forms)
    actual=arb(0)
    observed=[]
    while all(i<len(a) for i,a in zip(idx,streams)):
        cells=[stream[i] for stream,i in zip(streams,idx)]
        lo=max(a for a,_,_ in cells)
        hi=min(b for _,b,_ in cells)
        if lo<hi:
            ns=tuple(m for _,_,m in cells)
            if tuple(a*ns[0]+b for a,b in forms)!=ns:
                raise ArithmeticError("Unexpected affine pattern")
            observed.append(ns[0])
            actual+=ball(hi/lo).log()
        for j,(_,end,_) in enumerate(cells):
            if end==hi:
                idx[j]+=1
    us=[F(b,a) for a,b in forms]
    D=max(us)-min(us)
    weighted=arb(0)
    direct=arb(0)
    pair_count=0
    pp_count=0
    selected=[]
    for n in range(int(A)+1,int(r*B)+1):
        ms=[a*n+b for a,b in forms]
        if not all(m in base for m in ms):
            continue
        l=max([A]+[F(m)/(q*r) for m,q in zip(ms,qs)])
        u=min([B]+[F(m)/q for m,q in zip(ms,qs)])
        if l<u:
            direct+=ball(u/l).log()
            selected.append(n)
        if n<=X:
            pp_count+=1
            if all(primes[m] for m in ms):
                pair_count+=1
                weighted+=ball(c+D-D*F(X,n))
    if observed!=selected or not direct.overlaps(actual):
        raise ArithmeticError("Support sweep disagrees with the tuple enumeration")
    scale=10**12
    raw=actual/ball(1/s).log()
    return {"X":X,"s":str(s),"forms":forms,"prime_tuples":pair_count,
            "prime_power_tuples":pp_count,"overlap_cells":len(observed),
            "frequency":enclosure(raw,scale),
            "scaled_frequency":enclosure(raw*arb(X).log()**len(forms),scale),
            "X_mass_minus_weighted_prime_sum":enclosure(X*actual-weighted,scale)}


def predicted_constants(primes, cutoff=1000000):
    partial=arb(1)
    for p in range(3,cutoff+1):
        if primes[p]:
            partial*=1-arb(1)/(p-1)**2
    # The omitted product lies between 1-sum_{n>cutoff} 1/(n-1)^2 and 1.
    twin=(partial*(1-arb(1)/(cutoff-1))).union(partial)
    S=8*twin
    w=ball(F(5,64))-ball(F(8,7)).log()/2
    return {"prime_cutoff":cutoff,"scale":10**9,"C2":enclosure(twin,10**9),
            "unconditional_liminf_lower_constant":enclosure(1/(16*S*arb(2).log()).sqrt(),10**9),
            "conditional_first_passage_constant":enclosure((2/(S*arb(2).log())).sqrt(),10**9),
            "conditional_Sophie_Germain_reading":enclosure(2*twin*w/ball(F(8,7)).log(),10**9)}


def run(bits):
    ctx.prec=bits
    sizes=(128,1024,16384,262144,1048576)
    widths=(32,64,128,256,512,1024)
    max_bound=48*max(widths)
    primes,base,powers=prime_tables(max(2*max(sizes)+4,7*max_bound))
    reversals=[]
    for den in widths:
        v=first_reversal(den,48*den,base,powers)
        lo,hi=[F(k,10**8) for k in v["first_crossing"]]
        if not endpoint_difference(den,lo,base,powers)>0 or not endpoint_difference(den,hi,base,powers)<0:
            raise ArithmeticError("Independent endpoint check failed")
        reversals.append(v)
    sets=[(F(7,8),[(1,0),(2,1)]),(F(31,32),[(1,0),(1,2),(2,1)])]
    affine=[affine_test(x,s,forms,primes,base,powers) for s,forms in sets for x in sizes]
    return {"precision_bits":bits,"crossing_endpoint_scale":10**8,"affine_endpoint_scale":10**12,
            "first_reversals":reversals,"affine_checks":affine,"constants":predicted_constants(primes)}


if __name__=="__main__":
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--bits",type=int,default=128)
    p.add_argument("--json",type=Path)
    args=p.parse_args()
    if args.bits<96:
        p.error("use at least 96 bits")
    data=json.dumps(run(args.bits),indent=2)+"\n"
    if args.json:
        args.json.write_text(data,encoding="ascii",newline="\n")
    else:
        print(data,end="")
