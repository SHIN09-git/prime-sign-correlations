"""Logarithmic frequencies of actual excesses on bounded intervals.

The ratio of the two endpoints in a window is 33/32. All count jumps occur
on an integer grid after scaling the base point by 33*q. The only numerical
operations in the integral are enclosed using Arb.
"""
import argparse
from bisect import bisect_right
from collections import defaultdict
import json
from math import isqrt
from pathlib import Path

from flint import arb, ctx


def prime_powers(limit):
    sieve = bytearray([1]) * (limit + 1)
    sieve[:2] = bytes(2)
    for p in range(2, isqrt(limit) + 1):
        if sieve[p]:
            sieve[p*p::p] = bytes((limit-p*p)//p + 1)
    weights = []
    for p in range(2, limit + 1):
        if sieve[p]:
            logp = arb(p).log()
            m = p
            while m <= limit:
                weights.append((m, logp))
                m *= p
    return sorted(weights, key=lambda pair: pair[0])


def enclosed_probability(x):
    scale = 10**9
    lo = (scale*x.lower()).floor().unique_fmpz()
    hi = (scale*x.upper()).ceil().unique_fmpz()
    if lo is None or hi is None or int(hi)-int(lo) > 2:
        raise ArithmeticError("Precision insufficient to enclose a frequency")
    return [int(lo), int(hi)]


def integrate(q, lower, upper, weighted, locations, prefix):
    grid = 33*q
    first, last = grid*lower, grid*upper
    events = defaultdict(list)
    counts = [arb(0), arb(0)]
    for m, logp in weighted:
        if 32*m >= last:
            break
        for channel, entry, leave in ((0,32*q*m,33*q*m), (1,32*m,33*m)):
            if entry <= first < leave:
                counts[channel] += logp
            if first < entry < last:
                events[entry].append((channel, logp))
            if first < leave < last:
                events[leave].append((channel, -logp))
    mass = [arb(0) for _ in range(3)]
    checks = 0
    a = first
    for index, b in enumerate(sorted([*events, last])):
        if index % 257 == 0:
            # A separate evaluation at the rational midpoint of this cell.
            for factor, count in zip((1,q), counts):
                i = bisect_right(locations, factor*(a+b)//(2*grid))
                j = bisect_right(locations, 33*factor*(a+b)//(64*grid))
                if not count.overlaps(prefix[j]-prefix[i]):
                    raise ArithmeticError("Count disagrees with the direct prime-power sum")
            checks += 2
        caps = [32*grid*counts[0], 32*grid*counts[1]/q]
        caps.append(caps[0].min(caps[1]))
        for k, cap in enumerate(caps):
            cutoff = cap.min(arb(b)).max(arb(a))
            mass[k] += (cutoff/a).log()
        for channel, jump in events.get(b, ()):
            counts[channel] += jump
        a = b
    duration = (arb(upper)/lower).log()
    probs = [enclosed_probability(x/duration) for x in mass]
    return {"q":q, "base":[lower,upper], "constant_count_cells":len(events)+1,
            "separate_count_checks":checks, "first":probs[0], "second":probs[1],
            "joint":probs[2]}


def run(bits):
    ctx.prec = bits
    dilations = (2,4,6)
    ranges = ((512,16384),(16384,65536))
    weighted = prime_powers(33*max(dilations)*ranges[-1][1]//32)
    locations = [m for m,_ in weighted]
    prefix = [arb(0)]
    for _, weight in weighted:
        prefix.append(prefix[-1]+weight)
    rows = [integrate(q,a,b,weighted,locations,prefix) for a,b in ranges for q in dilations]
    for base in ranges:
        c = [r["first"] for r in rows if tuple(r["base"]) == base]
        if max(v[0] for v in c) > min(v[1] for v in c):
            raise ArithmeticError("The shared first window has inconsistent frequencies")
    return {"quantity":"finite logarithmic frequencies of actual weighted prime-count excesses",
            "window_ratio":"33/32", "endpoint_scale":10**9, "precision_bits":bits, "rows":rows}


if __name__ == "__main__":
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bits", type=int, default=160)
    parser.add_argument("--json", type=Path)
    args=parser.parse_args()
    if args.bits < 96:
        parser.error("use at least 96 bits")
    output=json.dumps(run(args.bits),indent=2)+"\n"
    if args.json:
        args.json.write_text(output,encoding="ascii",newline="\n")
    else:
        print(output,end="")
