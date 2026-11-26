"""Signed near-root correlations on complete dyadic denominator intervals."""
import argparse
from collections import defaultdict
from dataclasses import dataclass
from functools import lru_cache
import json
from math import gcd, isqrt, lcm
from pathlib import Path

from flint import arb, ctx

from arithmetic import Arithmetic, bounds, certain_floor, require

B = 432
SCALE = 1 << 34
GRID = 1 << 45
CASES = ((16, 12, 1), (16, 12, 2), (20, 12, 2), (22, 10, 2),
         (22, 10, 4), (22, 14, 8))
METRICS = ("net", "pair_abs", "shift_abs", "without_den_mu", "plus", "minus",
           "inner_net", "inner_abs", "row_abs", "mixed_net", "square_net",
           "rem_net", "rem_pair_abs", "rem_shift_abs", "rem_without_den_mu",
           "large_gcd", "large_mask", "ordinary_inner", "finite_discriminant")


def step(t):
    if t <= 0:
        return arb(0)
    if t >= 1:
        return arb(1)
    ratio = (1/t - 1/(1-t)).exp()
    return 1/(1+ratio)


def psi(j, J, ramp):
    if J <= j <= 2*J:
        return arb(1)
    dist = J-j if j < J else j-2*J
    return step(1-arb(dist)*ramp/J)


def geometry(exponent, c, J):
    z = 1 << exponent
    L = arb(z).log()
    V = c*certain_floor(arb(z).sqrt()*(L**3).root(4)/2)
    H = -((-8*V**2)//(z*J))
    T = certain_floor(H/(2*L.root(40)))
    Y = certain_floor((L**(arb(99)/400)*arb(J).sqrt()).exp())
    eta = 1/(arb(V).sqrt()*L**(arb(3)/10))
    return L, V, H, T, Y, eta


def rounded(x):
    n = int((x.mid()+arb(1)/2).floor().unique_fmpz())
    require(abs(x-n) < 1, "Arb validates the coordinate rounding")
    return n


@lru_cache(maxsize=65536)
def phase(b, n):
    return (arb(2*b)/n).sin_cos_pi()


@dataclass
class Root:
    m: int
    n: int
    r: int
    wave: tuple


def root_table(ar, V, Y, numerators, amplitudes):
    rows = {}
    hmax = 0
    for q in range(V+1, 2*V+1):
        if not ar.mu[q]:
            continue
        selected = []
        for n in ar.divisors(q):
            m = q//n
            if min(m, n) > Y and gcd(6*m, n) == 1:
                selected.append((m, n, pow(6*m, -1, n)))
        if not selected:
            continue
        weight = arb(ar.mu[q])
        for p in ar.factors(q):
            weight *= arb(p)/(p-(1 if p <= 3 else 2))
        # A strict integer upper bound also works when the value is an integer.
        hmax = max(hmax, int(abs(weight).upper().ceil().unique_fmpz()))
        scales = [SCALE*weight*a for a in amplitudes]
        roots = []
        totals = [[0, 0] for _ in numerators]
        for m, n, r in selected:
            wave = []
            for i, (j, scale) in enumerate(zip(numerators, scales)):
                sn, cs = phase((j*r) % n, n)
                x, y = rounded(scale*cs), rounded(scale*sn)
                wave.append((x, y))
                totals[i][0] += x
                totals[i][1] += y
            roots.append(Root(m, n, r, tuple(wave)))
        rows[q] = (roots, totals, rounded(SCALE*weight))
    return rows, hmax


def quantized_test(p, q, value, lo):
    """Decide p/q <= value. Use an Arb comparison only within one grid cell."""
    n = p*GRID
    if n <= q*lo:
        return True
    if n >= q*(lo+1):
        return False
    delta = q*value-p
    require(delta > 0 or delta < 0, "phase cutoff decided")
    return bool(delta > 0)


def dot(v, w):
    return v[0]*w[0]+v[1]*w[1]


def pair_ledger(q, d, left, right, ar, masks, J, outer, outer_lo, eta, eta_lo, G, A, mult):
    Q = q*(q+d)
    chosen = [(a, inds, ar.mu[a]) for a, inds in masks if Q % a == 0]
    near = far = inner = inner_abs = square = evaluations = count = inner_count = square_count = 0
    by_row = defaultdict(int)
    row_counts = defaultdict(int)
    rem_net = rem_count = 0
    discrep = [0]*4
    excluded = [0]*4
    g = gcd(q, d)
    for v in left:
        for w in right:
            P, R = v.m*w.m, v.n*w.n
            raw = v.r*w.n-w.r*v.n
            vals = [dot(i, j) for i, j in zip(v.wave, w.wave)]
            require((6*P*raw-d) % R == 0, "unscaled inverse determinant")
            for a, inds, mu in chosen:
                k = (a*raw+R//2) % R-R//2
                value = mu*sum(vals[j] for j in inds)
                if not quantized_test(J*abs(k), a*R, outer, outer_lo):
                    far += value
                    continue
                l, rem = divmod(6*P*k-a*d, R)
                require(rem == 0, "lifted determinant")
                t, u = k*l, 12*P*k-a*d
                require(u*u-6*t*(2*q+d)**2 == (a*a-6*t)*d*d, "Pell identity")
                # k=0 and l=0 can occur in finite samples. Sign(u) selects the
                # quadratic branch even then (sign(k) suffices asymptotically).
                key = (a, t, (u > 0)-(u < 0))
                by_row[key] += value
                row_counts[key] += 1
                near += value
                count += 1
                evaluations += len(inds)
                inside = quantized_test(abs(k), R, eta, eta_lo)
                if inside:
                    inner += value
                    inner_abs += abs(value)
                    inner_count += 1
                square_row = t >= 0 and isqrt(6*t)**2 == 6*t
                if square_row:
                    square_count += 1
                    square += value
                if g > G:
                    excluded[0] += value
                elif a > A:
                    excluded[1] += value
                elif inside:
                    excluded[2] += value
                elif t <= 0 or square_row:
                    excluded[3] += value
                else:
                    rem_net += value
                    rem_count += 1
                    # Number of all integer lifts in the symmetric interval,
                    # minus its length, at u=i/4. Scale by 2*J*lcm(1,...,3J).
                    den, center = 4*J*R, 4*J*k
                    for i in range(1, 5):
                        radius = i*a*R
                        hits = (center+radius)//den+(radius-center)//den+1
                        discrep[i-1] += mu*(mult//a)*(2*J*hits-i*a)
    for (a, t, sign), multiplicity in row_counts.items():
        require(multiplicity <= 1 << (len(ar.factors(g))+len(ar.factors(a))),
                "CRT multiplicity bound on a fixed signed row")
    return (near, far, inner, inner_abs, square, count, evaluations, inner_count,
            square_count, by_row, rem_net, rem_count, discrep, excluded)


def scan(exponent, c, J):
    L, V, H, T, Y, eta = geometry(exponent, c, J)
    ar = Arithmetic(2*V)
    ramp, outer = L.root(20), L.root(16)
    G, A, mult = certain_floor(ramp), certain_floor(L.root(10)), lcm(*range(1, 3*J+1))
    eta_lo, outer_lo = certain_floor(eta*GRID), certain_floor(outer*GRID)
    weights = [(j, psi(j, J, ramp)) for j in range(1, 3*J+1)]
    numerators = [j for j, p in weights if p > 0]
    roots, hmax = root_table(ar, V, Y, numerators, [p.sqrt() for j, p in weights if p > 0])
    masks = [(a, [i for i, j in enumerate(numerators) if j % a == 0])
             for a in range(1, max(numerators)+1) if ar.mu[a]]
    masks = [(a, inds) for a, inds in masks if inds]
    hist = []
    witnesses = []
    for d in range(B, min(V, T), B):
        net = pair_abs = plus = minus = inner = inner_abs = square = direct = far = 0
        terms = evals = pairs = inner_count = square_count = 0
        rem_net = rem_abs = rem_unsigned = rem_count = 0
        discrep = [0]*4
        excluded = [0]*4
        grouped = {}
        for q, (left, total_l, weight_l) in roots.items():
            if q+d not in roots:
                continue
            right, total_r, weight_r = roots[q+d]
            result = pair_ledger(q, d, left, right, ar, masks, J, outer, outer_lo, eta, eta_lo, G, A, mult)
            (part, away, core, core_abs, sq, count, evaluations, ncore, nsq, by_row,
             remainder, nrem, pair_discrep, omitted) = result
            require(part == remainder+sum(omitted), "disjoint exclusions")
            for i, value in enumerate(omitted):
                excluded[i] += value
            Q = q*(q+d)
            independent = sum(dot(i, j) for num, i, j in zip(numerators, total_l, total_r)
                              if gcd(num, Q) == 1)
            require(part+away == independent, "all masks against direct coprime numerator sum")
            direct += independent
            far += away
            pair_abs += abs(part)
            net += part
            same = ar.mu[q] == ar.mu[q+d]
            if same:
                plus += part
            else:
                minus += part
            inner += core
            inner_abs += core_abs
            square += sq
            terms += count
            evals += evaluations
            inner_count += ncore
            square_count += nsq
            pairs += bool(by_row)
            rem_count += nrem
            rem_net += remainder
            rem_abs += abs(remainder)
            rem_unsigned += remainder if same else -remainder
            for i, value in enumerate(pair_discrep):
                discrep[i] += value*weight_l*weight_r
            for key, amount in by_row.items():
                if key not in grouped:
                    grouped[key] = [0, 0, 0, 0]
                item = grouped[key]
                item[0] += amount
                item[1] += 1
                item[2 if same else 3] = q
        require(direct == net+far and plus+minus == net, "shift sums")
        row_abs = sum(abs(v[0]) for v in grouped.values())
        mixed = [(key, v) for key, v in grouped.items() if v[2] and v[3]]
        for (a, t, sign), v in mixed:
            if a == 1 and t > 0 and isqrt(6*t)**2 != 6*t and len(witnesses) < 3:
                witnesses.append(dict(d=d, a=a, t=t, branch=sign, q_plus=v[2], q_minus=v[3]))
        hist.append(dict(d=d, pairs=pairs, terms=terms, evals=evals, inner_count=inner_count,
                         square_count=square_count, row_count=len(grouped),
                         repeated=sum(v[1] > 1 for v in grouped.values()), mixed_count=len(mixed),
                         net=net, pair_abs=pair_abs, shift_abs=abs(net), without_den_mu=plus-minus,
                         plus=plus, minus=minus, inner_net=inner, inner_abs=inner_abs,
                         square_net=square, far=far, direct=direct, row_abs=row_abs,
                         mixed_net=sum(v[0] for key, v in mixed), rem_count=rem_count,
                         rem_net=rem_net, rem_pair_abs=rem_abs, rem_shift_abs=abs(rem_net),
                         rem_without_den_mu=rem_unsigned, discrepancy=discrep,
                         large_gcd=excluded[0], large_mask=excluded[1], ordinary_inner=excluded[2],
                         finite_discriminant=excluded[3]))
    denominator = arb(V)*T*T*J*L.sqrt()
    def normalized(key):
        raw = sum(2*B*(T-r["d"])*r[key] for r in hist)
        count = sum(2*B*(T-r["d"])*r["evals"] for r in hist)
        mid = arb(raw)/(denominator*SCALE**2)
        err = arb(count)*(3*hmax+1)/(denominator*SCALE)
        return [bounds(mid-err)[0], bounds(mid+err)[1]]
    metrics = {key: normalized(key) for key in METRICS}
    disc_ranges = []
    for i in range(4):
        raw = sum(2*B*(T-s["d"])*s["discrepancy"][i] for s in hist)
        count = sum(2*B*(T-s["d"])*s["rem_count"] for s in hist)
        mid = arb(raw)/(2*mult*denominator*SCALE**2)
        err = arb(count)*2*(2*hmax+1)*J/(denominator*SCALE)
        disc_ranges.append([bounds(mid-err)[0], bounds(mid+err)[1]])
    return dict(exponent=exponent, c=c, J=J, V=V, H=H, T=T, Y_floor=Y,
                eta_enclosure=bounds(eta), numerators=numerators, hmax=hmax, active_q=len(roots),
                roots=sum(len(r[0]) for r in roots.values()), metrics=metrics, shifts=hist,
                witnesses=witnesses, G_floor=G, A_floor=A, discrepancy_quarters=disc_ranges)


def run(cases=CASES):
    ctx.prec = 160
    records = []
    for case in cases:
        record = scan(*case)
        print(case, record["V"], sum(h["terms"] for h in record["shifts"]),
              record["metrics"]["net"], flush=True)
        records.append(record)
    return dict(scale=SCALE, endpoint_unit=10**9, precision_bits=ctx.prec,
                b=B, records=records)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--case", type=int, nargs=3, metavar=("K", "c", "J"))
    args = parser.parse_args()
    payload = run([tuple(args.case)] if args.case else CASES)
    args.out.write_bytes((json.dumps(payload, indent=2)+"\n").encode("utf-8"))
