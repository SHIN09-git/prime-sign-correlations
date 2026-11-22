"""Plot certified upper bounds for entire dyadic parameter intervals."""
import argparse
from io import StringIO
import json
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--evidence", type=Path, default=Path("evidence"))
    parser.add_argument("--cover", type=Path)
    args = parser.parse_args()
    cover = json.loads((args.cover or args.evidence/"upper-cover.json").read_text("utf-8"))
    passages = json.loads((args.evidence/"large-passages.json").read_text("utf-8"))
    const = json.loads((args.evidence/"scale-transition.json").read_text("utf-8"))["constants"]
    b = sum(const["conditional_first_passage_constant"])/(2*const["scale"])
    rows = cover["dyadic_blocks"]
    exponents = [row["k"] for row in rows]
    values = [row["upper_millionths"]/cover["coefficient_unit"] for row in rows]

    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 8,
                         "svg.hashsalt": "prime-signs-upper-cover"})
    fig, ax = plt.subplots(figsize=(6.5, 2.24))
    ax.stairs(values, exponents+[exponents[-1]+1], baseline=None, color="#165760",
              linewidth=1.8, label="uniform certified upper bound")
    ax.axhline(b, color="#994724", linestyle="--", linewidth=1.1, label="local pair-law limit")
    ax.scatter([r["M_exponent"] for r in passages["rows"]],
               [sum(r["scaled_overshoot"])/(2*passages["overshoot_scale"]) for r in passages["rows"]],
               facecolors="white", edgecolors="#254a72", s=15, zorder=4, label="individual first contact")
    ax.set(xlabel=r"starting height $\log_2 M$", ylabel=r"$(B_*-M)/H_M$",
           xticks=list(range(exponents[0], exponents[-1]+2, 2)), yticks=[.75, .8, .85, .9, .95],
           xlim=(exponents[0]-.3, exponents[-1]+1.3), ylim=(.728, .98))
    ax.spines[["top", "right"]].set_visible(False)
    ax.set_axisbelow(True)
    ax.grid(axis="y", color="#dce4e4", linewidth=.6)
    ax.legend(loc="upper right", frameon=False, fontsize=7.1)
    fig.tight_layout(pad=.7)
    with StringIO() as stream:
        fig.savefig(stream, format="svg", metadata={"Date": None})
        text = "\n".join(line.rstrip() for line in stream.getvalue().splitlines())+"\n"
    args.output.write_text(text, encoding="utf-8", newline="\n")
    plt.close(fig)


if __name__ == "__main__":
    main()
