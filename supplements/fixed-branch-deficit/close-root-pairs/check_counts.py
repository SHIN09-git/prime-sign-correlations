"""Exhaustive close-pair counts for the six dyadic bands in the preprint."""
import argparse
from collections import Counter, defaultdict
from fractions import Fraction
from hashlib import sha256
import json
from math import gcd, isqrt, prod
from pathlib import Path


HERE = Path(__file__).resolve().parent
# Entries are (V, a, d, Y). Each V is a square so all four radii are rational.
CASES = ((1024, 1, 1, 6), (4096, 1, 1, 6), (16384, 1, 1, 6),
         (65536, 1, 1, 6), (16384, 2, 4, 8), (65536, 3, 6, 18))


def require(condition, message):
    if not condition:
        raise ArithmeticError(message)


def factor_trial(n):
    """Prime factors with multiplicity, independently of the divisor sieve."""
    factors = []
    p = 2
    while p*p <= n:
        while n % p == 0:
            factors.append(p)
            n //= p
        p += 1 if p == 2 else 2
    if n > 1:
        factors.append(n)
    return factors


def divisor_roots(V, Y):
    """Construct roots from the two factors and one modular inverse."""
    limit = 2*V
    spf = list(range(limit+1))
    for p in range(2, isqrt(limit)+1):
        if spf[p] == p:
            for i in range(p*p, limit+1, p):
                if spf[i] == i:
                    spf[i] = p
    table = {}
    for q in range(V+1, limit+1):
        divisors, u = [1], q
        while u > 1:
            p = spf[u]
            u //= p
            if u % p == 0:
                break
            divisors.extend([v*p for v in divisors])
        else:
            roots = []
            for n in divisors:
                m = q//n
                if min(m, n) > Y and gcd(n, 6) == 1:
                    roots.append((m, n, pow(6*m, -1, n)))
            if roots:
                table[q] = roots
    return table


def crt_roots(q, Y):
    """Lift choices 0 and 1/6 prime by prime, then recover m as gcd(z,q)."""
    primes = factor_trial(q)
    if len(set(primes)) != len(primes):
        return []
    residues, mod = [0], 1
    for p in primes:
        choices = (0,) if p in (2, 3) else (0, pow(6, -1, p))
        inv = pow(mod, -1, p)
        residues = [z+mod*(((c-z)*inv) % p) for z in residues for c in choices]
        mod *= p
    return [z for z in residues if min(gcd(z, q), q//gcd(z, q)) > Y]


def centered(a, n):
    return (a+n//2) % n-n//2


def by_factors(V, a, d, Y):
    table = divisor_roots(V, Y)
    records = []
    examined = 0
    for q, left in table.items():
        right = table.get(q+d, ())
        examined += len(left)*len(right)
        Q = q*(q+d)
        for m, n, r in left:
            for mm, nn, rr in right:
                R, P = n*nn, m*mm
                k = centered(a*(r*nn-rr*n), R)
                ell, rem = divmod(6*P*k-a*d, R)
                t = k*ell
                require(rem == 0 and t > 0 and 6*t != a*a, "determinant and nonzero norm")
                if Y >= 6*a*d and V > 20*d**4*(a*a+d*d):
                    require(isqrt(6*t)**2 != 6*t, "square-discriminant exclusion")
                if abs(k)*isqrt(V) > R:
                    continue
                b = P*k
                u = 12*b-a*d
                require(u*u-6*t*(2*q+d)**2 == (a*a-6*t)*d*d, "norm equation")
                require(b*(6*b-a*d) == t*Q, "integral phase coordinate")
                records.append((q, m*r, mm*rr, b, t))
    return examined, sorted(records)


def by_crt(V, a, d, Y):
    table = {q: crt_roots(q, Y) for q in range(V+1, 2*V+1)}
    records = []
    examined = 0
    for q in range(V+1, 2*V-d+1):
        Q = q*(q+d)
        left, right = table[q], table[q+d]
        examined += len(left)*len(right)
        for z in left:
            for zz in right:
                residue = (a*(z*(q+d)-zz*q)) % Q
                # The two algorithms use distinct denominators for centering.
                b = residue if 2*residue < Q else residue-Q
                if b*b*V <= Q*Q:
                    t, rem = divmod(b*(6*b-a*d), Q)
                    require(rem == 0, "quadratic expression from the CRT roots")
                    records.append((q, z, zz, b, t))
    return examined, sorted(records)


def summarize(V, a, d, Y):
    require(isqrt(V)**2 == V and Y >= a*d, "sample hypotheses")
    examined, records = by_factors(V, a, d, Y)
    require((examined, records) == by_crt(V, a, d, Y), "two complete enumerations disagree")
    radii = [Fraction(c, V) for c in (1, 4, 16)] + [Fraction(1, isqrt(V))]
    counts = [0]*len(radii)
    rows, multiplicities = defaultdict(set), Counter()
    digest = sha256()
    for q, z, zz, b, t in records:
        Q = q*(q+d)
        sig = 1 if 12*b > a*d else -1
        rows[t].add(q)
        multiplicities[q, t, sig] += 1
        for i, radius in enumerate(radii):
            if abs(b)*radius.denominator <= Q*radius.numerator:
                counts[i] += 1
        digest.update(f"{q},{z},{zz},{b},{t}\n".encode("ascii"))
    for t, qs in rows.items():
        norm = abs(a*a-6*t)*d*d
        divisor_count = prod(e+1 for e in Counter(factor_trial(norm)).values())
        require(len(qs) <= divisor_count, "dyadic denominator bound for fixed t")
    for (q, t, sig), size in multiplicities.items():
        omega = len(set(factor_trial(a)))+len(set(factor_trial(gcd(q, d))))
        require(size <= 2**omega, "CRT multiplicity")
    return dict(V=V, a=a, d=d, Y=Y, examined=examined,
                counts=counts, t_values=len(rows), records_sha256=digest.hexdigest())


def run():
    for q in range(2, 225):
        if any(q % (k*k) == 0 for k in range(2, isqrt(q)+1)):
            continue
        direct = [z for z in range(q) if z*(6*z-1) % q == 0 and min(gcd(z,q), q//gcd(z,q)) > 1]
        require(sorted(crt_roots(q, 1)) == direct, "brute-force polynomial roots")
    samples = [summarize(*params) for params in CASES]
    return dict(radii=["1/V", "4/V", "16/V", "1/sqrt(V)"], samples=samples)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, help="write a new JSON ledger; default verifies counts.json")
    args = parser.parse_args()
    data = run()
    encoded = (json.dumps(data, indent=2)+"\n").encode("utf-8")
    if args.out is None:
        require((HERE/"counts.json").read_bytes() == encoded, "archived counts and fingerprints")
    else:
        args.out.write_bytes(encoded)
    print(f"{len(CASES)} bands, {sum(r['examined'] for r in data['samples']):,} root pairs; "
          "the factor and CRT enumerations agree.")
