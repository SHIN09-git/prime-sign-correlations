"""Independent segmented sieves for the prime pairs p, 6p-1 and p, 6p+1.

Each cell (a,a+g] returns the number of pairs and the sum of p-a, with
multiplicity if both signs work. All sieve indices and outputs are integers.
"""
from concurrent.futures import ThreadPoolExecutor
from math import isqrt

import numpy as np
from numba import njit


RESIDUES = np.array([1, 7, 11, 13, 17, 19, 23, 29], dtype=np.int64)


def divisor_primes(stop):
    limit = isqrt(6*stop + 1)
    sieve = bytearray([1]) * (limit + 1)
    sieve[:2] = bytes(2)
    for p in range(2, isqrt(limit) + 1):
        if sieve[p]:
            sieve[p*p::p] = bytes(1 + (limit-p*p)//p)
    return np.flatnonzero(np.frombuffer(sieve, dtype=np.uint8)).astype(np.int64)


def root_tables(primes):
    rows = []
    for slope, shift in [(30, 0), (180, -1), (180, 1)]:
        inverses = np.array([pow(slope, -1, int(p)) for p in primes], dtype=np.int64)
        intercepts = RESIDUES if slope == 30 else 6*RESIDUES + shift
        rows.append((-intercepts[:, None]*inverses[None, :]) % primes[None, :])
    return tuple(np.ascontiguousarray(table) for table in rows)


@njit(nogil=True, cache=True)
def _strike(mask, start, slope, intercept, roots, primes, phase):
    largest = slope*(start+len(mask)-1) + intercept
    for j in range(len(primes)):
        p = primes[j]
        if p*p > largest:
            break
        first = roots[j] - phase[j]
        if first < 0:
            first += p
        # Keep a prime that is itself one of the values of the progression.
        gap = p*p - (slope*(start+first) + intercept)
        if gap > 0:
            first += ((gap+slope*p-1)//(slope*p))*p
        for i in range(first, len(mask), p):
            mask[i] = 0


@njit(nogil=True, cache=True)
def _wheel_bins(lo, cells, g, primes, base_roots, minus_roots, plus_roots):
    counts = np.zeros(cells, dtype=np.int64)
    offsets = np.zeros(cells, dtype=np.int64)
    stop = lo+cells*g
    end_t = stop//30+1
    for start in range(lo//30, end_t, 65536):
        length = min(65536, end_t-start)
        phase = start % primes
        for j in range(len(RESIDUES)):
            r = RESIDUES[j]
            base = np.ones(length, dtype=np.uint8)
            _strike(base, start, 30, r, base_roots[j], primes, phase)
            for sign in (-1, 1):
                intercept = 6*r+sign
                if intercept % 5 == 0:
                    continue
                good = base.copy()
                roots = minus_roots[j] if sign < 0 else plus_roots[j]
                _strike(good, start, 180, intercept, roots, primes, phase)
                for i in range(length):
                    if good[i]:
                        n = 30*(start+i)+r
                        if lo < n <= stop:
                            cell = (n-lo-1)//g
                            counts[cell] += 1
                            offsets[cell] += n-(lo+cell*g)
    return counts, offsets


@njit(nogil=True, cache=True)
def _odd_segment(lo, hi, primes):
    first_odd = lo | 1
    good = np.ones((hi-first_odd)//2+1, dtype=np.uint8)
    for p in primes:
        if p == 2:
            continue
        if p*p > hi:
            break
        start = max(p*p, ((first_odd+p-1)//p)*p)
        if start % 2 == 0:
            start += p
        for j in range((start-first_odd)//2, len(good), p):
            good[j] = 0
    return first_odd, good


@njit(nogil=True, cache=True)
def _ordinary_bins(lo, cells, g, primes):
    # Independent enumeration on the original integer and image segments.
    counts = np.zeros(cells, dtype=np.int64)
    offsets = np.zeros(cells, dtype=np.int64)
    stop = lo+cells*g
    for start in range(lo+1, stop+1, 262144):
        last = min(start+262143, stop)
        first, base = _odd_segment(start, last, primes)
        first_image, images = _odd_segment(6*start-1, 6*last+1, primes)
        for j in range(len(base)):
            if base[j]:
                n = first+2*j
                image_index = (6*n-1-first_image)//2
                multiplicity = int(images[image_index]) + int(images[image_index+1])
                cell = (n-lo-1)//g
                counts[cell] += multiplicity
                offsets[cell] += multiplicity*(n-(lo+cell*g))
    return counts, offsets


def pair_bins(lo, cells, g, method, workers):
    stop = lo+cells*g
    if lo <= 5 or not (1 <= g <= 2**28) or stop > 2**44:
        raise ValueError("unsupported sieve range")
    primes = divisor_primes(stop)
    if method == "wheel":
        primes = primes[primes >= 7]
        tables = root_tables(primes)
        engine = lambda a, k: _wheel_bins(a, k, g, primes, *tables)
    elif method == "ordinary":
        engine = lambda a, k: _ordinary_bins(a, k, g, primes)
    else:
        raise ValueError(method)
    # Compile the selected specialization before starting worker threads.
    engine(lo, 1)
    chunk = max(1, (2**25)//g)
    tasks = [(lo+i*g, min(chunk, cells-i)) for i in range(0, cells, chunk)]
    with ThreadPoolExecutor(max_workers=workers) as pool:
        pieces = list(pool.map(lambda task: engine(*task), tasks))
    return tuple(np.concatenate([part[index] for part in pieces]) for index in (0, 1))
