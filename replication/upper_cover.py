"""Certify first-passage upper bounds for every real parameter in dyadic blocks.

The proof in the upper-bound supplement uses an integer count and first moment.
This program constructs a cover and rounds its worst normalized upper bound out.
"""
import argparse
from fractions import Fraction
from hashlib import sha256
import json
from math import isqrt
from pathlib import Path
import sys

import numpy as np

from upper_pair_bins import pair_bins


LOG_UNIT = 10**6
BOUND_UNIT = 10**6
LOG2_LOWER = 693147
# Positive terms of log(2) = 2 atanh(1/3) certify the fixed rational lower bound.
assert Fraction(LOG2_LOWER, LOG_UNIT) < 2*sum(
    Fraction(1, (2*j+1)*3**(2*j+1)) for j in range(8)
)


def log_lower(A, k):
    """A rational lower bound, in millionths, for log(A) in its dyadic block."""
    base = 1 << k
    t, d = A-base, A+base
    return (k*LOG2_LOWER + (2*LOG_UNIT*t)//d
            + (2*LOG_UNIT*t**3)//(3*d**3))


def cap_steps(A, k, g):
    # 7/10 exceeds log(2). The cap is chosen for efficiency and checked directly.
    raised = (A*(7*(k+1))**3 + 999)//1000
    h_upper = isqrt(raised)+1
    return (5*h_upper+4*g-1)//(4*g)


def outward_coefficient(length, A, log_num):
    numerator = (BOUND_UNIT*length)**2 * LOG_UNIT**3
    denominator = A * log_num**3
    return 1+isqrt((numerator-1)//denominator)


def check_band(k, counts, offsets, g):
    L, R = 1 << k, 2 << k
    cells = (R-L)//g
    # Python integers retain all moments even when the block-wide sum exceeds 64 bits.
    prefix_count, prefix_moment = [0], [0]
    for j, (number, offset) in enumerate(zip(counts, offsets, strict=True)):
        number, offset = int(number), int(offset)
        if not (0 <= number <= 2*g and number <= offset <= g*number):
            raise ArithmeticError("inconsistent integer bin")
        prefix_count.append(prefix_count[-1]+number)
        prefix_moment.append(prefix_moment[-1]+j*g*number+offset)
    biggest = 0
    worst_num, worst_den = -1, 1
    worst = None
    for j in range(cells):
        A = L+j*g
        U = A+g
        end_index = j+cap_steps(A, k, g)
        D = L+end_index*g
        if 2*D > 3*A or end_index >= len(prefix_count):
            raise ArithmeticError(f"outside the geometric range at {A}")
        J = D.bit_length()-2
        threshold = 3*D*J
        u_index = j+1
        ku, su = prefix_count[u_index], prefix_moment[u_index]
        shift = 3*(U-L)+1

        def weight(i):
            return 3*(prefix_moment[i]-su) - shift*(prefix_count[i]-ku)

        if weight(end_index) <= threshold:
            raise ArithmeticError(f"insufficient pair weight at {A}")
        left, right = u_index, end_index
        while right-left > 1:
            mid = (left+right)//2
            if weight(mid) > threshold:
                right = mid
            else:
                left = mid
        b = L+right*g
        length = b-A
        ell_floor = log_lower(A, k)
        ratio_num, ratio_den = length**2, A*ell_floor**3
        if ratio_num*worst_den > worst_num*ratio_den:
            worst_num, worst_den = ratio_num, ratio_den
            biggest = outward_coefficient(length, A, ell_floor)
            worst = {"A": A, "U": U, "D": D, "b": b, "prime_pairs": prefix_count[right]-ku,
                     "integer_weight": weight(right), "required_strict_threshold": threshold,
                     "log_lower_millionths": ell_floor}
    data = np.column_stack([counts, offsets]).astype("<u8", copy=False)
    return {"k": k, "left": L, "right": R, "grid_step": g, "parameter_cells": cells,
            "sieved_cells_including_halo": len(counts), "prime_pairs_in_main_block": prefix_count[cells],
            "upper_millionths": biggest, "worst_cell": worst,
            "count_offset_sha256": sha256(data.tobytes()).hexdigest()}


def certify(k, method, workers, save_dir):
    g = 1 << (k//2-2)
    L, R = 1 << k, 2 << k
    cells = (R-L)//g + cap_steps(R, k, g)
    counts, offsets = pair_bins(L, cells, g, method, workers)
    row = check_band(k, counts, offsets, g)
    if save_dir:
        save_dir.mkdir(exist_ok=True, parents=True)
        np.savez_compressed(save_dir / f"{method}-{k}.npz", counts=counts, offsets=offsets)
    return row


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--low", type=int, default=14, help="lower dyadic exponent, inclusive")
    parser.add_argument("--high", type=int, default=40, help="upper endpoint exponent, inclusive")
    parser.add_argument("--method", choices=["wheel", "ordinary"], default="wheel")
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--save-bins", type=Path)
    parser.add_argument("--json", type=Path)
    args = parser.parse_args()
    if not (14 <= args.low < args.high <= 42 and args.workers >= 1):
        parser.error("use 14 <= low < high <= 42 and a positive worker count")
    rows = []
    for k in range(args.low, args.high):
        row = certify(k, args.method, args.workers, args.save_bins)
        rows.append(row)
        print(f"[2^{k},2^{k+1}]  {row['parameter_cells']} cells  "
              f"upper {row['upper_millionths']}/{BOUND_UNIT}", file=sys.stderr, flush=True)
    result = {"coefficient_unit": BOUND_UNIT, "index_interval": [2**args.low, 2**args.high],
              "max_upper_millionths": max(row["upper_millionths"] for row in rows),
              "parameter_cells": sum(row["parameter_cells"] for row in rows), "dyadic_blocks": rows}
    output = json.dumps(result, indent=2)+"\n"
    if args.json:
        args.json.write_text(output, encoding="ascii", newline="\n")
    else:
        print(output, end="")


if __name__ == "__main__":
    main()
