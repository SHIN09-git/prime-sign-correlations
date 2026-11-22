"""Restore the published original PDF, including its embedded verification archive."""
import argparse
import hashlib
from pathlib import Path
from urllib.request import urlopen


SOURCE = Path(__file__).resolve().parent
REMOTE = "https://raw.githubusercontent.com/SHIN09-git/prime-sign-correlations/main/supplements/fixed-branch-deficit/joint-window-archive/"
FILENAME = "Joint-Prime-Windows.pdf"
SIZE = 18840787
SHA256 = "bbd513d6c8a9dea011e858bf19da831e78f32c712532bbe563c7a7e73ed01865"
PARTS = [
    ("part-01.bin", "5f4e242ab22748cfe584f814fb709eab9b80b4fa44249e6dc373c528181f9440"),
    ("part-02.bin", "76bae4274675b8dd8766f8a477fbd29be5211fe6c358734c3fef091834381ada"),
    ("part-03.bin", "048c6598644c712db28f0e7320bd34e1830f13643b25cda54e0a0d7726986a80"),
    ("part-04.bin", "faa3b34d711ee11603fa0b0d926a271807ed7e96dfbd18c1232f5232cd39da3d"),
    ("part-05.bin", "06c3c65f4a06bbd925a612d1feaaf6632d16611dea3009afc70624afe6533ef8"),
    ("part-06.bin", "a464431e8155069da7e0ae88ebf209bd8ff068373427f5791babda22a6d16d3f"),
]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--download", action="store_true", help="read the six parts from the public GitHub archive")
    parser.add_argument("--output", type=Path, default=Path(FILENAME), help="destination for the original PDF")
    args = parser.parse_args()
    document = bytearray()
    for name, expected in PARTS:
        if args.download:
            with urlopen(REMOTE + name, timeout=90) as response:
                part = response.read()
        else:
            part = (SOURCE / name).read_bytes()
        if hashlib.sha256(part).hexdigest() != expected:
            parser.exit(1, f"SHA-256 mismatch for {name}\n")
        document.extend(part)
    if len(document) != SIZE or hashlib.sha256(document).hexdigest() != SHA256:
        parser.exit(1, "The assembled bytes do not match the original PDF.\n")
    try:
        output = args.output.open("xb")
    except FileExistsError:
        if args.output.read_bytes() != document:
            parser.exit(1, f"{args.output} already exists with different contents. Use --output to choose another path.\n")
    else:
        try:
            with output:
                output.write(document)
        except BaseException:
            args.output.unlink(missing_ok=True)
            raise
    print(f"{SHA256}  {args.output}")


if __name__ == "__main__":
    main()
