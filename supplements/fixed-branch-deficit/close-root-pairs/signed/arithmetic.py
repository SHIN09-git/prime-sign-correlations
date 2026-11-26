"""Squarefree factorizations and outward rounding used by the signed-window replay."""
from math import isqrt


def require(test, message):
    if not test:
        raise ArithmeticError(message)


def certain_floor(value):
    integer = value.floor().unique_fmpz()
    require(integer is not None, "floor decided by the real ball")
    return int(integer)


def bounds(value, unit=10**9):
    require(value.is_finite(), "finite numerical enclosure")
    scaled = value*unit
    return [int(scaled.lower().floor().unique_fmpz()),
            int(scaled.upper().ceil().unique_fmpz())]


class Arithmetic:
    def __init__(self, maximum):
        self.spf = list(range(maximum+1))
        for p in range(2, isqrt(maximum)+1):
            if self.spf[p] == p:
                for i in range(p*p, maximum+1, p):
                    if self.spf[i] == i:
                        self.spf[i] = p
        self.mu = [0, 1]+[0]*(maximum-1)
        for n in range(2, maximum+1):
            p = self.spf[n]
            self.mu[n] = 0 if n//p % p == 0 else -self.mu[n//p]

    def factors(self, n):
        require(self.mu[n] != 0, "squarefree input")
        primes = []
        while n > 1:
            p = self.spf[n]
            primes.append(p)
            n //= p
        return primes

    def divisors(self, n):
        divisors = [1]
        for p in self.factors(n):
            divisors.extend([d*p for d in divisors])
        return divisors
