"""Exact checks of the two-parameter identity on signed, translated windows."""

from fractions import Fraction
from math import gcd, isqrt


def primes_through(limit):
    flags = bytearray([1]) * (limit + 1)
    flags[0:2] = bytes(2)
    for p in range(2, isqrt(limit) + 1):
        if flags[p]:
            flags[p*p::p] = bytes((limit - p*p) // p + 1)
    return [p for p, present in enumerate(flags) if present]


def factor_window(first, width, slope, intercept, primes):
    """Count factors with multiplicity on one affine progression, including repeats."""
    remaining = [slope * (first + i) + intercept for i in range(width)]
    counts = bytearray(width)
    for p in primes:
        if p*p > slope * (first + width - 1) + intercept:
            break
        if slope % p == 0:
            assert intercept % p
            continue
        root = (-intercept * pow(slope, -1, p) - first) % p
        for i in range(root, width, p):
            while remaining[i] % p == 0:
                remaining[i] //= p
                counts[i] += 1
    for i, cofactor in enumerate(remaining):
        counts[i] += cofactor > 1
    return counts


def prime_flags(first, last, primes):
    """Independent Eratosthenes sieve on a consecutive interval."""
    flags = bytearray([1]) * (last - first + 1)
    for p in primes:
        if p*p > last:
            break
        first_multiple = max(p*p, ((first + p - 1) // p) * p)
        if first_multiple <= last:
            flags[first_multiple-first::p] = bytes((last-first_multiple)//p+1)
    return flags


def check_window(x, width, primes, cutoff_product):
    first, last = x+1, x+width
    base = factor_window(first, width, 1, 0, primes)
    is_prime = prime_flags(first, last, primes)
    partner_first = 6*first-1
    partner = prime_flags(partner_first, 6*last+1, primes)
    counts = {}
    evidence = []
    for sign in (-1, 1):
        other = factor_window(first, width, 6, sign, primes)
        pairs = 0
        for i, (one, two) in enumerate(zip(base, other)):
            n = first+i
            m = 6*n+sign
            both_prime = bool(is_prime[i] and partner[m-partner_first])
            assert (one+two == 2) == both_prime
            if both_prime:
                pairs += 1
            if gcd(n, cutoff_product) == gcd(m, cutoff_product) == 1:
                degree = one+two
                counts[degree] = counts.get(degree, 0)+1
        evidence.append(pairs)
    total = sum(counts.values())
    true = sum(evidence)
    assert counts.get(2, 0) == true
    t = Fraction(1, 16)
    def value(u):
        return sum(weight*u**degree for degree, weight in counts.items())
    a, b = value(t), value(2*t)
    signed = (2*a-b/4)/t**2
    assert 0 <= true-signed <= 2*t*t*(total-true)
    assert (signed > 0) == (b/a < 8)
    six = {k: counts.get(k+2, 0) for k in range(6)}
    def polynomial(u):
        return sum(v*u**k for k, v in six.items())
    recovered = (6*polynomial(Fraction(1,6)) - 15*polynomial(Fraction(1,3))
                 + 20*polynomial(Fraction(1,2)) - 15*polynomial(Fraction(2,3))
                 + 6*polynomial(Fraction(5,6)) - polynomial(1))
    assert recovered == true
    print(f"{x:>10} {width:>8} {cutoff_product:>5} {evidence[0]:>7} "
          f"{evidence[1]:>7} {total:>8} {float(b/a):>10.6f}")


def main():
    # Exact endpoints. Widths approximate the critical scale for these three heights.
    windows = [(2**16, 9_400), (2**20, 52_800), (2**24, 278_000)]
    primes = primes_through(isqrt(6*max(x+w for x, w in windows)+1))
    print("         X    width     Q  minus    plus    rough      ratio")
    for x, width in windows:
        assert x < 2**400  # floor(X^(1/400)) = 1 for the stated heights
        for cutoff_product in (1, 2*3*5*7):
            check_window(x, width, primes, cutoff_product)


if __name__ == "__main__":
    main()
