"""Independent CRT reconstruction, real-ball cosine sums, and signed ledger checks."""
from fractions import Fraction
from functools import lru_cache
import json
from math import gcd, isqrt, lcm, prod
from pathlib import Path

from flint import arb, ctx

ROOT = Path(__file__).resolve().parent


def check(condition, message):
    if not condition:
        raise ArithmeticError(message)


@lru_cache(maxsize=None)
def factors(n):
    p = 2
    primes = []
    while p*p <= n:
        if n % p == 0:
            primes.append(p)
            n //= p
            if n % p == 0:
                return None
        p += 1 if p == 2 else 2
    if n > 1:
        primes.append(n)
    return tuple(primes)


def mob(n):
    ps = factors(n)
    return 0 if ps is None else (-1)**len(ps)


@lru_cache(maxsize=None)
def split_mask(a, left, right):
    return sum(mob(s)*mob(t) for s in range(1, a+1) if left % s == 0 and a % s == 0
               for t in range(1, a+1) if right % t == 0 and lcm(s, t) == a)


def rational_weight(q):
    return mob(q)*prod(Fraction(p, p-(1 if p < 5 else 2)) for p in factors(q))


def ball(r):
    return arb(r.numerator)/r.denominator


def crt_roots(q, Y):
    """Lift z(6z-1)=0 prime by prime. Return z itself, in [0,q)."""
    residues, mod = [0], 1
    for p in factors(q):
        choices = (0,) if p < 5 else (0, pow(6, -1, p))
        residues = [r+mod*((choice-r)*pow(mod, -1, p) % p)
                    for r in residues for choice in choices]
        mod *= p
    return [z for z in residues if min(gcd(z, q), q//gcd(z, q)) > Y]


def smooth(j, J, R0):
    if J <= j <= 2*J:
        return arb(1)
    distance = arb(min(abs(j-J), abs(j-2*J)))/J
    v = 1-distance*R0
    if v < 0:
        return arb(0)
    p, q = (-1/v).exp(), (-1/(1-v)).exp()
    return p/(p+q)


def integer_floor(x):
    return int(x.floor().unique_fmpz())


def compare_shift(case, row, scale):
    K, J, c = case["exponent"], case["J"], case["c"]
    Z = 2**K
    L = K*arb(2).log()
    V = c*integer_floor(arb(Z).sqrt()*L**(arb(3)/4)/2)
    Y = integer_floor((L**(arb(99)/400)*arb(J).sqrt()).exp())
    eta = L**(-arb(3)/10)/arb(V).sqrt()
    R0 = L**(arb(1)/20)
    H = -((-8*V**2)//(Z*J))
    check([V, Y, H, integer_floor(H/(2*L**(arb(1)/40)))] ==
          [case["V"], case["Y_floor"], case["H"], case["T"]], "geometry")
    weights = {j: smooth(j, J, R0) for j in range(1, 3*J)}
    mask = [(a, [j for j in weights if j % a == 0 and weights[j] > 0])
            for a in range(1, 3*J) if mob(a)]
    sums = {k: arb(0) for k in ("net", "pair_abs", "inner_abs", "far", "rem_net", "large_mask",
                                 "rem_pair_abs", "without_den_mu")}
    discrepancy = [arb(0) for _ in range(4)]
    d = row["d"]
    terms = rem_count = far_evals = 0
    for q in range(V+1, 2*V+1-d):
        q2, Q = q+d, q*(q+d)
        if not mob(q)*mob(q2):
            continue
        pair = arb(0)
        remainder = arb(0)
        for a, js in mask:
            check(split_mask(a, gcd(a, q), gcd(a, q2)) == (mob(a) if Q % a == 0 else 0),
                  "two-denominator Mobius expansion including shared primes")
        w = ball(rational_weight(q)*rational_weight(q2))
        right = crt_roots(q2, Y)
        if not right:
            continue
        for z in crt_roots(q, Y):
            for z2 in right:
                A = z*q2-z2*q
                cos = {j: weights[j]*(arb(2*((A*j) % Q))/Q).cos_pi()
                       for j in weights if weights[j] > 0}
                for a, js in mask:
                    if Q % a or not js:
                        continue
                    v = mob(a)*w*sum((cos[j] for j in js), arb(0))
                    # Center directly modulo qq', independently of n and n'.
                    b = (a*A+Q//2) % Q-Q//2
                    if arb(J*abs(b))/Q > a*L.root(16):
                        sums["far"] += v
                        far_evals += len(js)
                        continue
                    terms += 1
                    pair += v
                    if gcd(q, d) <= case["G_floor"] and a > case["A_floor"]:
                        sums["large_mask"] += v
                    if arb(abs(b))/Q <= eta:
                        sums["inner_abs"] += abs(v)
                        continue
                    t, rest = divmod(b*(6*b-a*d), Q)
                    check(not rest, "product determinant from the two CRT roots")
                    if t <= 0 or isqrt(6*t)**2 == 6*t or gcd(q, d) > case["G_floor"] or a > case["A_floor"]:
                        continue
                    rem_count += 1
                    remainder += v
                    for i in range(1, 5):
                        hits = sum(4*J*abs(b-x*Q) <= a*i*Q for x in range(-4, 5))
                        discrepancy[i-1] += mob(a)*w*(arb(hits)/a-arb(i)/(2*J))
        sums["net"] += pair
        sums["without_den_mu"] += mob(q)*mob(q2)*pair
        sums["pair_abs"] += abs(pair)
        sums["rem_net"] += remainder
        sums["rem_pair_abs"] += abs(remainder)
    check((terms, rem_count) == (row["terms"], row["rem_count"]), "actual root counts")
    eps = arb(far_evals)*(3*case["hmax"]+1)/scale
    near_eps = arb(row["evals"])*(3*case["hmax"]+1)/scale
    for key, value in sums.items():
        check(abs(value-arb(row[key])/scale**2) <= (eps if key == "far" else near_eps),
              f"independent cosine sums: {key}")
    den = 2*J*lcm(*range(1, 3*J+1))*scale**2
    eps_d = arb(2*rem_count)*(2*case["hmax"]+1)/scale
    for i, val in enumerate(discrepancy):
        check(abs(val-arb(row["discrepancy"][i])/den) <= eps_d if rem_count else val == 0,
              "integer-lift signed discrepancy")
    return terms


def check_all(data):
    scale = data["scale"]
    for case in data["records"]:
        J, T, V = case["J"], case["T"], case["V"]
        L = case["exponent"]*arb(2).log()
        den = arb(V*T*T*J)*L.sqrt()
        rows = case["shifts"]
        check([r["d"] for r in rows] == list(range(432, min(V, T), 432)), "all shifts")
        for r in rows:
            check(r["plus"]+r["minus"] == r["net"] and r["plus"]-r["minus"] == r["without_den_mu"],
                  "denominator signs")
            check(r["net"]+r["far"] == r["direct"] and abs(r["net"]) <= r["pair_abs"],
                  "coprime-numerator recombination")
            check(abs(r["rem_net"]) <= r["rem_pair_abs"], "remaining denominator contributions")
            check(sum(r[k] for k in ("rem_net", "large_gcd", "large_mask", "ordinary_inner",
                                     "finite_discriminant")) == r["net"], "disjoint groups")
        for key, (lo, hi) in case["metrics"].items():
            total = sum(864*(T-r["d"])*r[key] for r in rows)
            terms = sum(864*(T-r["d"])*r["evals"] for r in rows)
            val = arb(total)/(scale**2*den)
            err = arb(terms)*(3*case["hmax"]+1)/(scale*den)
            check(arb(lo)/10**9 <= val-err and val+err <= arb(hi)/10**9, "outward decimal bounds")


def common_row():
    d, k, l = 432, 19854, 324
    result = []
    weighted = []
    for q, m, n, mm, nn in ((115273, 19, 6067, 317, 365),
                             (117689, 143, 823, 43, 2747)):
        check(m*n == q and mm*nn == q+d and gcd(q, d) == 1, "example denominators")
        r, s = pow(6*m, -1, n), pow(6*mm, -1, nn)
        R = n*nn
        check(k == (r*nn-s*n+R//2) % R-R//2 and 6*m*mm*k-R*l == d, "same k and l")
        check(6*k*l > isqrt(6*k*l)**2, "nonsquare discriminant")
        sign = mob(q)*mob(q+d)
        check(sign != 0 and abs(Fraction(k, R))*5 < Fraction(1, 4), "positive cosines through j=5")
        result.append(sign)
        L = 22*arb(2).log()
        K = sum(smooth(j, 2, L.root(20))*(arb(2*j*k)/R).cos_pi() for j in range(1, 6))/2
        weighted.append(ball(rational_weight(q)*rational_weight(q+d))*K)
    check(result == [-1, 1], "opposite actual signs on one Pell row")
    for value, cited in zip([*weighted, sum(weighted)], ["-3.51851", "3.00512", "-0.51339"]):
        check(abs(value-arb(cited)) < arb("0.000005"), "signed example rounding")


def peeling():
    def coeff(q, j):
        ans = [arb(0), arb(0)]
        for z in crt_roots(q, 0):
            sn, cs = (arb(2*((j*z) % q))/q).sin_cos_pi()
            ans[0] += cs
            ans[1] += sn
        return [v*ball(rational_weight(q)) for v in ans]
    for q in range(2, 160):
        if not mob(q):
            continue
        for s in range(2, 13):
            if q % s:
                continue
            for i in (1, 2, 3, 6):
                x, y = coeff(q, i*s), coeff(q//s, i)
                c = ball(rational_weight(s))*2**sum(p > 3 for p in factors(s))
                check(all(v.overlaps(w*c) for v, w in zip(x, y)), "peeling without coprimality")


if __name__ == "__main__":
    ctx.prec = 192
    payload = json.loads((ROOT/"rows.json").read_text(encoding="utf-8"))
    check_all(payload)
    common_row()
    peeling()
    cases = payload["records"]
    checks = [(cases[1], s) for s in cases[1]["shifts"]]
    checks += [(cases[4], cases[4]["shifts"][0]), (cases[5], cases[5]["shifts"][-1])]
    total = sum(compare_shift(c, s, payload["scale"]) for c, s in checks)
    print(f"{len(cases)} complete ledgers, {len(checks)} independent shift sums, "
          f"{total} near root/mask terms, one exact opposite-sign denominator pair of pairs.")
