"""Certify the signed cumulative lead at integer heights before and after first contact."""
import argparse
from fractions import Fraction
import json
from math import isqrt
from pathlib import Path

from flint import arb, ctx, fmpq

from large_passage import affine_segment, common_indices, outward, prime_list, proper_powers, segment


def profile(exponent, method, block):
    M = 2**exponent
    ell = arb(M).log()
    H = arb(M).sqrt() * ell * ell.sqrt()
    heights = [M + int((H*j/16).floor().unique_fmpz()) for j in range(17)]
    if 32*heights[-1] > 33*M:
        raise ValueError("The exact ratio-4 formula requires a shorter range")
    primes = prime_list(isqrt(6*heights[-1] + 1) + 2)
    base_powers = proper_powers(primes, M, heights[-1])
    image_powers = proper_powers(primes, 6*M - 1, 6*heights[-1] + 1)
    residues = {sign: [(-sign*pow(6, -1, p)) % p if p > 3 else None for p in primes]
                for sign in (-1, 1)}
    h = arb(fmpq(6*M + 1, 6*M)).log()
    lead = (exponent - 1)*h
    rows = []
    previous = M
    for j, height in enumerate(heights):
        for lo in range(previous + 1, height + 1, block):
            hi = min(lo + block, height + 1)
            base = segment(lo, hi, primes, base_powers)
            if method == "contiguous":
                images = segment(6*lo - 1, 6*(hi - 1) + 2, primes, image_powers)
                candidates = {-1: images[::6], 1: images[2::6]}
            else:
                candidates = {sign: affine_segment(lo, hi, primes, residues[sign], image_powers, sign)
                              for sign in (-1, 1)}
            for sign, candidate in candidates.items():
                for offset in common_indices(base, candidate):
                    n = lo + offset
                    # At an integer endpoint every overlap with n <= height is complete.
                    log_shift = arb(fmpq(sign, 6*n)).log1p()
                    lead -= h - abs(log_shift)
        rows.append({"z_grid": str(Fraction(j, 16)), "base_height": height,
                     "normalized_lead": outward(6*M*lead/ell, 10**9)})
        previous = height
    return {"M": M, "M_exponent": exponent, "points": rows}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bits", type=int, default=128)
    parser.add_argument("--block", type=int, default=2**18)
    parser.add_argument("--method", choices=("contiguous", "affine"), default="contiguous")
    parser.add_argument("--json", type=Path, required=True)
    args = parser.parse_args()
    if args.bits < 96 or args.block < 1:
        parser.error("use at least 96 bits and a positive block size")
    ctx.prec = args.bits
    result = {"bits": args.bits, "method": args.method, "block_size": args.block,
              "ordinate_scale": 10**9, "profiles": [profile(k, args.method, args.block) for k in (28, 32)]}
    args.json.write_text(json.dumps(result, indent=2) + "\n", encoding="ascii", newline="\n")


if __name__ == "__main__":
    main()
