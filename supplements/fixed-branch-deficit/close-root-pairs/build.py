"""Build both language versions, each with the same self-contained verification archive."""
import argparse
from io import BytesIO
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile, ZipInfo

import pymupdf
import typst


ROOT = Path(__file__).resolve().parent
TIMESTAMP = 1795651200  # 2026-11-26 00:00:00 UTC
DATE = "(D:20261126000000Z)"
MEMBERS = (
    "README.md", "build.py", "check_counts.py", "counts.json", "paper.typ",
    "signed/README.md", "signed/arithmetic.py", "signed/rows.json",
    "signed/rows.py", "signed/verify.py",
)


def verification_archive():
    buffer = BytesIO()
    with ZipFile(buffer, "w") as archive:
        for name in MEMBERS:
            item = ZipInfo(name, (2026, 11, 26, 0, 0, 0))
            item.create_system = 3
            item.external_attr = 0o100644 << 16
            data = (ROOT / name).read_bytes().replace(b"\r\n", b"\n")
            archive.writestr(item, data, compress_type=ZIP_DEFLATED, compresslevel=9)
    return buffer.getvalue()


def build(language, cjk, evidence):
    pdf, warnings = typst.compile_with_warnings(
        str(ROOT / "paper.typ"), root=str(ROOT),
        sys_inputs={"lang": language, "cjk": cjk}, timestamp=TIMESTAMP,
    )
    if warnings:
        raise RuntimeError("\n".join(str(warning) for warning in warnings))
    with pymupdf.open(stream=pdf, filetype="pdf") as document:
        stream = document.embfile_add(
            "verification.zip", evidence, desc="Source, finite counts and signed-window verification"
        )
        for key in ("CreationDate", "ModDate"):
            document.xref_set_key(stream, "Params/" + key, DATE)
        return document.tobytes(garbage=3, deflate=True, no_new_id=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out-dir", type=Path, default=ROOT)
    parser.add_argument("--cjk", default="SimSun", help="installed Chinese font family")
    args = parser.parse_args()
    args.out_dir.mkdir(parents=True, exist_ok=True)
    evidence = verification_archive()
    for language in ("en", "zh"):
        target = args.out_dir / f"close-root-pairs-{language}.pdf"
        target.write_bytes(build(language, args.cjk, evidence))
        print(target)
