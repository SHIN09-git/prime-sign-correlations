"""Check the signed CRT classes and finite singular factors with exact integers."""

from fractions import Fraction
from math import gcd, prod


def check_residues(limit=48):
    compatible = 0
    for d in range(1, limit + 1):
        for v in range(1, limit + 1):
            modulus = d * v
            for sign in (-1, 1):
                direct = [
                    n for n in range(0, modulus, d)
                    if (6 * n + sign) % v == 0
                ]
                compatible_moduli = gcd(v, 6 * d) == 1
                if compatible_moduli:
                    inverse = pow(6 * d, -1, v) if v > 1 else 0
                    predicted = [d * ((-sign * inverse) % v)]
                else:
                    predicted = []
                assert direct == predicted, (d, v, sign, direct, predicted)
                compatible += len(direct)
    return 2 * limit**2, compatible


def check_singular_factors():
    primes = (2, 3, 5, 7, 11, 13)
    moduli = []
    for size in range(2, len(primes) + 1):
        factors = primes[:size]
        modulus = prod(factors)
        phi = prod(p - 1 for p in factors)
        per_sign = 3 * prod(1 - Fraction(1, (p - 1)**2)
                            for p in factors if p > 3)
        for sign in (-1, 1):
            count = sum(gcd(r, modulus) == gcd(6 * r + sign, modulus) == 1
                        for r in range(modulus))
            assert Fraction(modulus * count, phi**2) == per_sign
        moduli.append(modulus)
    return moduli


if __name__ == "__main__":
    instances, classes = check_residues()
    print(f"{instances} signed divisor cases, {classes} admissible classes")
    print("Primorials with the predicted factor for each sign:",
          ", ".join(map(str, check_singular_factors())))
