"""Directed enclosures of the finite-width prime trace and its zero expansion."""
import argparse
from fractions import Fraction
from hashlib import sha256
import json
from math import isqrt
from pathlib import Path
from urllib.request import urlopen

import flint
from flint import acb, arb, ctx, fmpq

COMMIT = "1cea164bd25696723c376c48aaa677fbea7ea188"
DATA_URL = ("https://raw.githubusercontent.com/SHIN09-git/dyadic-prime-mean-square/"
            + COMMIT + "/replication/zeros-20000.tsv")
FILE_HASH = "33be171305b7d3237d68eecd3efb0aa34d967a1db78871e0a400549db4fe7a13"
GRID_HASH = "4c34dc77993cf26ca8efd2f53699d9afa85226af193c3566afcca5ec023db67f"
GRID = 10**10
T = 20000
N = 22491
DEC = 10**9
CASES = [(2, 0), (2, Fraction(1, 2)), (2, 1), (3, 0), (4, 0),
         (6, 0), (8, 0), (9, 0), (10, 0)]


def bounded(left, right):
    return left.union(right)


def decimal_bounds(b):
    a = (b.lower()*DEC).floor().unique_fmpz()
    c = (b.upper()*DEC).ceil().unique_fmpz()
    if a is None or c is None:
        raise ArithmeticError("Ambiguous outward grid point")
    return [int(a), int(c)]


def ar(x):
    f = Fraction(x)
    return arb(fmpq(f.numerator, f.denominator))


def lamb(n):
    p = next((j for j in range(2, isqrt(n)+1) if n % j == 0), n)
    if n < 2:
        return arb(0)
    while n % p == 0:
        n //= p
    return arb(p).log() if n == 1 else arb(0)


def hardy_sign(t):
    half = t/2
    theta = acb(fmpq(1,4),half).lgamma().imag - half*arb.pi().log()
    z = acb(0,theta).exp()*acb(fmpq(1,2),t).zeta()
    if z.imag.contains(0) and (z.real > 0 or z.real < 0):
        return 1 if z.real > 0 else -1
    raise ArithmeticError("Hardy Z endpoint sign unresolved")


def brackets(path, verify):
    data = path.read_bytes() if path else urlopen(DATA_URL, timeout=90).read()
    if sha256(data).hexdigest() != FILE_HASH:
        raise ValueError("Published data digest mismatch")
    grid_hash = sha256()
    result = []
    previous = 0
    for line in data.decode("ascii").splitlines():
        if not line or line.startswith("#"):
            continue
        idx, ball = line.split("\t")
        center = Fraction(ball.split()[0].lstrip("["))
        k = (center.numerator*GRID)//center.denominator
        left, right = ar(Fraction(k-1, GRID)), ar(Fraction(k+2, GRID))
        if int(idx) != len(result)+1 or k-1 <= previous:
            raise ValueError("Unordered or overlapping brackets")
        if verify and hardy_sign(left)*hardy_sign(right) != -1:
            raise ArithmeticError("Missing sign change")
        previous = k+2
        grid_hash.update(f"{k-1}\n".encode("ascii"))
        result.append(left.union(right))
    if (grid_hash.hexdigest() != GRID_HASH or len(result) != N+1
            or not (result[-2] < T and result[-1] > T)
            or arb(T).zeta_nzeros() != N):
        raise ArithmeticError("Certified ordinate grid verification failed")
    return result[:-1]


def weight(h, t):
    # This expression is used only inside the known support.
    u = abs(t)
    return (u/2).exp() * (h-u).expm1()


def smooth(t):
    return (t/2).exp() - (-t/2).exp()/(2*t).expm1()


def trace(n, shift, h, cells):
    a = arb(n).log() + ar(shift)*h
    total = arb(0)
    width = h/cells
    # H and the two monotone branches of w are independently enclosed.
    for j in range(-cells, cells):
        left, right = j*width, (j+1)*width
        wk = bounded(weight(h,left), weight(h,right))
        arch = bounded(smooth(a+left), smooth(a+right))
        total += width*wk*arch
    if not (a-h > 0 and (a+h).exp() < 32):
        raise ValueError("Prime enumeration cutoff insufficient")
    for m in range(2,32):
        dist = -ar(shift)*h if m == n else arb(m).log()-a
        if abs(dist) > h:
            continue
        if not abs(dist) <= h:
            raise ArithmeticError("Ambiguous support endpoint")
        total -= lamb(m)/arb(m).sqrt()*weight(h,dist)
    return total


def verify(args):
    ctx.prec = args.bits
    h = ar(Fraction(1,32))
    roots = brackets(args.zeros, args.verify_brackets)
    e = (h/2).exp()
    weights = [2*((e-1)**2+4*e*(g*h/2).sin()**2)/(g*g+ar(Fraction(1,4))) for g in roots]
    # Partial summation, N(t) <= t log(t)/(2 pi) for t >= 20000.
    tail = 2*(1+e)**2*((arb(T).log()+1)/(arb.pi()*T)-ar(Fraction(N,T*T)))
    if not tail > 0:
        raise ArithmeticError("Unexpected tail bound")
    remainder = arb(0, tail.upper())
    rows = []
    for n, shift in CASES:
        a = arb(n).log()+ar(shift)*h
        partial = sum((w*(g*a).cos() for g,w in zip(roots,weights)),arb(0))
        spectral = partial+remainder
        direct = trace(n, shift, h, args.cells)
        if not spectral.contains(direct):
            raise ArithmeticError(f"Independent enclosures disagree at {n}, {shift}")
        if not ((direct > 0 and spectral > 0) or (direct < 0 and spectral < 0)):
            raise ArithmeticError(f"Cross-check cannot resolve the sign at {n}, {shift}")
        rows.append({"n":n, "tau":str(shift), "direct":decimal_bounds(direct),
                     "spectral":decimal_bounds(spectral), "common_sign":"+" if direct > 0 else "-"})
    return {"quantity":"canonical K_h(log n + tau*h)", "h":"1/32", "endpoint_scale":DEC,
            "precision_bits":args.bits, "panels_each_side":args.cells, "truncation":T,
            "positive_ordinates":N, "source_sha256":FILE_HASH,
            "rational_bracket_sha256":GRID_HASH, "tail_bound":decimal_bounds(tail),
            "fresh_hardy_signs":args.verify_brackets, "flint":flint.__FLINT_VERSION__,
            "python_flint":flint.__version__, "rows":rows}


if __name__ == "__main__":
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--zeros", type=Path, help="local copy of the pinned TSV, otherwise fetched")
    p.add_argument("--verify-brackets", action="store_true", help="repeat all 44,984 Hardy Z endpoint checks")
    p.add_argument("--bits", type=int, default=160)
    p.add_argument("--cells", type=int, default=512)
    p.add_argument("--json", type=Path)
    args=p.parse_args()
    if args.bits<96 or args.cells<1:
        p.error("use at least 96 bits and a positive mesh size")
    output=json.dumps(verify(args),indent=2)+"\n"
    if args.json:
        args.json.write_text(output, encoding="ascii",newline="\n")
    else:
        print(output,end="")
