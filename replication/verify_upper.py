"""Independently verify each uniform coefficient from saved prime-pair bin totals.

The verifier sets the largest admissible endpoint using the advertised coefficient.
It counts witnesses in a sliding interval and checks the strict inequality with
that endpoint itself as the cap. No producer search or prefix moments are used.
"""
import argparse
from bisect import bisect_right
from fractions import Fraction
from hashlib import sha256
import json
from math import isqrt
from pathlib import Path

import numpy as np


SCALE = 10**8
LOG2 = 69314718
assert Fraction(LOG2, SCALE) < 2*sum(
    Fraction(1, (2*j+1)*3**(2*j+1)) for j in range(12)
)


def lower_log(A, left, k):
    # log(A/left) = 2 atanh(t/d). Every omitted term is nonnegative.
    t, d = A-left, A+left
    return (k*LOG2 + (2*SCALE*t)//d + (2*SCALE*t**3)//(3*d**3)
            + (2*SCALE*t**5)//(5*d**5))


def check_divisor_tables(rows):
    from upper_pair_bins import divisor_primes

    stops = [r["left"]+r["sieved_cells_including_halo"]*r["grid_step"] for r in rows]
    largest = isqrt(6*max(stops)+1)
    # Euler's linear sieve marks every composite using its least prime divisor.
    composite = bytearray(largest+1)
    primes = []
    for n in range(2, largest+1):
        if not composite[n]:
            primes.append(n)
        for p in primes:
            multiple = n*p
            if multiple > largest:
                break
            composite[multiple] = 1
            if n % p == 0:
                break
    expected = np.asarray(primes, dtype=np.int64)
    for stop in stops:
        cutoff = bisect_right(primes, isqrt(6*stop+1))
        if not np.array_equal(divisor_primes(stop), expected[:cutoff]):
            raise ArithmeticError("strike-prime table differs from the linear sieve")
    return {"dyadic_tables": len(stops), "largest_divisor_cutoff": largest,
            "primes_through_cutoff": len(primes)}


def verify_band(row, path, coefficient_unit):
    k = row["k"]
    left, high, g = 2**k, 2**(k+1), row["grid_step"]
    if row["left"] != left or row["right"] != high or g <= 0 or (high-left) % g:
        raise ValueError("invalid dyadic partition")
    cells = (high-left)//g
    if row["parameter_cells"] != cells:
        raise ValueError("incorrect number of parameter cells")
    with np.load(path) as data:
        counts, offsets = data["counts"], data["offsets"]
    if counts.ndim != 1 or offsets.shape != counts.shape or len(counts) < cells+1:
        raise ValueError("invalid bin array")
    if row["sieved_cells_including_halo"] != len(counts):
        raise ValueError("incorrect halo length")
    packed = np.column_stack((counts, offsets)).astype("<u8", copy=False)
    if sha256(packed.tobytes()).hexdigest() != row["count_offset_sha256"]:
        raise ValueError("bin fingerprint mismatch")
    c2 = row["upper_millionths"]**2
    denominator = SCALE**3*(coefficient_unit*g)**2
    right, count, moment = 1, 0, 0
    minimum, minimum_at = None, None
    for j in range(cells):
        A = left+j*g
        U = A+g
        if j:
            if right < j+1:
                raise ArithmeticError("previous interval ended too early")
            count -= int(counts[j])
            moment -= int(offsets[j]) + g*count
        length_in_steps = isqrt((A*lower_log(A, left, k)**3*c2)//denominator)
        target = min(j+length_in_steps, j+A//(2*g), len(counts))
        if not (j+1 < target and right <= target):
            raise ArithmeticError(f"invalid or decreasing target at {A}")
        while right < target:
            many = int(counts[right])
            moment += (left+right*g-U)*many + int(offsets[right])
            count += many
            right += 1
        b = left+target*g
        J = b.bit_length()-2
        margin = 3*moment-count-3*b*J
        if margin <= 0:
            raise ArithmeticError(f"coefficient failed at {A}")
        if minimum is None or margin < minimum:
            minimum, minimum_at = margin, A
    return {"k": k, "cells": cells, "minimum_integer_margin": minimum, "at_A": minimum_at}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cover", type=Path, default=Path("evidence/upper-cover.json"))
    parser.add_argument("--bins", type=Path, required=True)
    parser.add_argument("--method", choices=("wheel", "ordinary"), default="wheel")
    parser.add_argument("--low", type=int, default=14)
    parser.add_argument("--high", type=int, default=40)
    parser.add_argument("--json", type=Path)
    args = parser.parse_args()
    cover = json.loads(args.cover.read_text("utf-8"))
    rows = [r for r in cover["dyadic_blocks"] if args.low <= r["k"] < args.high]
    if not rows or [r["k"] for r in rows] != list(range(args.low, args.high)):
        parser.error("the cover must contain the full requested range")
    checked = [verify_band(r, args.bins/f"{args.method}-{r['k']}.npz", cover["coefficient_unit"])
               for r in rows]
    result = {"checked_parameter_cells": sum(r["cells"] for r in checked),
              "strike_prime_check": check_divisor_tables(rows), "dyadic_blocks": checked}
    text = json.dumps(result, indent=2)+"\n"
    if args.json:
        args.json.write_text(text, encoding="ascii", newline="\n")
    else:
        print(text, end="")


if __name__ == "__main__":
    main()
