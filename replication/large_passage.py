"""Certified first passages near 1/(6 delta) by a segmented prime-power sieve.

At M=2^k and delta=1/(6M), the ratio-4 integral equals (k-1) log(1+delta)
up to (33/32)M. Each ratio-6 event in this region comes from 6n-1 or 6n+1.
"""
import argparse
from bisect import bisect_left
from hashlib import sha256
import json
from math import isqrt
from pathlib import Path

from flint import arb, ctx, fmpq


def prime_list(cap):
    bits=bytearray([1])*(cap+1)
    bits[:2]=bytes(2)
    for p in range(2,isqrt(cap)+1):
        if bits[p]:
            bits[p*p::p]=bytes((cap-p*p)//p+1)
    return [p for p,v in enumerate(bits) if v]


def proper_powers(primes, lower, upper):
    values=[]
    for p in primes:
        v=p*p
        if v>upper:
            break
        while v<lower:
            v*=p
        while v<=upper:
            values.append(v)
            v*=p
    return sorted(values)


def segment(lo,hi,primes,powers):
    """Mark primes and proper powers on the half-open integer segment [lo, hi)."""
    out=bytearray([1])*(hi-lo)
    for p in primes:
        if p*p>=hi:
            break
        start=max(p*p, lo + (-lo)%p) - lo
        if start<len(out):
            out[start::p]=bytes(1+(len(out)-1-start)//p)
    for n in (0, 1):
        if lo <= n < hi:
            out[n-lo] = 0
    for v in powers[bisect_left(powers,lo):bisect_left(powers,hi)]:
        out[v-lo]=1
    return out


def affine_segment(lo,hi,primes,residues,powers,sign):
    """Separate residue sieve directly on n for 6n+sign."""
    out=bytearray([1])*(hi-lo)
    for p,r in zip(primes,residues):
        if p*p>6*(hi-1)+sign:
            break
        if r is None:
            continue
        start=(r-lo)%p
        if start<len(out):
            out[start::p]=bytes(1+(len(out)-1-start)//p)
    for v in powers[bisect_left(powers,6*lo+sign):bisect_left(powers,6*hi+sign)]:
        if (v-sign)%6==0:
            out[(v-sign)//6-lo]=1
    return out


def common_indices(a,b):
    """Intersect two byte masks in one integer operation, then visit their set bytes."""
    v=(int.from_bytes(a,'little') & int.from_bytes(b,'little')).to_bytes(len(a),'little')
    off=v.find(b'\x01')
    while off>=0:
        yield off
        off=v.find(b'\x01',off+1)


def outward(x,scale):
    lo=(x.lower()*scale).floor().unique_fmpz()
    hi=(x.upper()*scale).ceil().unique_fmpz()
    if lo is None or hi is None:
        raise ArithmeticError("Ambiguous rounding")
    return [int(lo),int(hi)]


def crossing(k,block,method):
    M=2**k
    stop=33*M//32
    primes=prime_list(isqrt(6*stop+7)+2)
    small=proper_powers(primes,M,stop+1)
    large=proper_powers(primes,6*M-1,6*stop+7)
    residues={sg:[(-sg*pow(6,-1,p))%p if p>3 else None for p in primes] for sg in (-1,1)}
    r=arb(fmpq(6*M+1,6*M))
    remaining=(k-1)*r.log()
    pair_count=0
    digest=sha256()
    for lo in range(M+1,stop+1,block):
        hi=min(lo+block,stop+1)
        a=segment(lo,hi,primes,small)
        if method=='contiguous':
            b=segment(6*lo-1,6*(hi-1)+2,primes,large)
            negative,positive=b[::6],b[2::6]
        else:
            negative=affine_segment(lo,hi,primes,residues[-1],large,-1)
            positive=affine_segment(lo,hi,primes,residues[1],large,1)
        events=sorted([(u,-1) for u in common_indices(a,negative)]+[(u,1) for u in common_indices(a,positive)])
        for off,sg in events:
            n=lo+off
            multiple=6*n
            left=arb(fmpq(max(multiple,multiple+sg),6))/r
            right=arb(fmpq(min(multiple,multiple+sg),6))
            if not left<right:
                raise ArithmeticError("Nonpositive event")
            length=(right/left).log()
            pair_count+=1
            digest.update(f"{n},{sg}\n".encode('ascii'))
            if remaining < length:
                root=left*remaining.exp()
                if not (left<root and root<right and root<stop):
                    raise ArithmeticError("Not an interior first passage")
                bracket=outward(root,10**8)
                if bracket[1]-bracket[0]!=1:
                    raise ArithmeticError("The root was not isolated")
                # Independently check the sign at the two rational reported endpoints.
                for j,k0 in enumerate(bracket):
                    gap=remaining-(arb(fmpq(k0,10**8))/left).log()
                    if not (gap>0 if j==0 else gap<0):
                        raise ArithmeticError("Endpoint sign failed")
                H=arb(M).sqrt()*arb(M).log()**fmpq(3,2)
                return {"M_exponent":k,"M":M,"crossing":bracket,
                        "scaled_overshoot":outward((root-M)/H,10**9),
                        "last_n":n,"last_sign":sg,"overlap_events":pair_count,
                        "event_prefix_sha256":digest.hexdigest()}
            if not remaining>length:
                raise ArithmeticError("Potential tie at an event endpoint")
            remaining-=length
    raise ArithmeticError(f"Crossing beyond guaranteed sieve window at 2^{k}")


if __name__=="__main__":
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--bits",type=int,default=128)
    p.add_argument("--block",type=int,default=2**18)
    p.add_argument("--method",choices=('contiguous','affine'),default='contiguous')
    p.add_argument("--json",type=Path)
    args=p.parse_args()
    if args.bits<96 or args.block<1:
        p.error("use at least 96 bits and a positive block size")
    ctx.prec=args.bits
    data={"bits":args.bits,"block_size":args.block,"method":args.method,
          "crossing_scale":10**8,"overshoot_scale":10**9,
          "rows":[crossing(k,args.block,args.method) for k in (24,26,28,30,32,34,36)]}
    s=json.dumps(data,indent=2)+"\n"
    if args.json:
        args.json.write_text(s,encoding="ascii",newline="\n")
    else:
        print(s,end="")
