"""Draw the measured sign lead and crossing location from the published enclosures."""
import argparse
from fractions import Fraction
from io import StringIO
import json
from math import log
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np


def midpoint(pair, unit):
    return (pair[0] + pair[1]) / (2 * unit)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--evidence", type=Path, default=Path("evidence"))
    args = parser.parse_args()

    def read(name):
        return json.loads((args.evidence / name).read_text(encoding="utf-8"))

    crossing = read("large-passages.json")
    data = read("passage-profile.json")
    bounds = read("scale-transition.json")["constants"]
    S = 8 * midpoint(bounds["C2"], bounds["scale"])
    b = midpoint(bounds["conditional_first_passage_constant"], bounds["scale"])

    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 7.5,
                         "svg.hashsalt": "prime-signs-first-passage-v2"})
    fig, (left, right) = plt.subplots(1, 2, figsize=(6.6, 2.38),
                                     gridspec_kw={"width_ratios": [1.2, 1]})
    colors = ("#165760", "#4977a0")
    for profile, color, marker in zip(data["profiles"], colors, ("o", "s")):
        x = [float(Fraction(p["z_grid"])) for p in profile["points"]]
        y = [midpoint(p["normalized_lead"], data["ordinate_scale"]) for p in profile["points"]]
        left.plot(x, y, color=color, marker=marker, ms=2.8, lw=1,
                  markerfacecolor="white" if marker == "o" else color,
                  label=rf"$M=2^{{{profile['M_exponent']}}}$")
    z = np.linspace(0, 1, 201)
    left.plot(z, 1/log(2) - S*z*z/2, "--", color="#994724", lw=1.2, label="pair-law profile")
    left.axhline(0, color="#566268", lw=.65)
    left.set(xlabel=r"scaled distance $z=(B-M)/H_M$", ylabel=r"$6M(C_4-C_6)/\log M$",
             yticks=[-1, 0, 1], xticks=[0, .25, .5, .75, 1])
    left.legend(loc="lower left", frameon=False, fontsize=6.6)
    left.set_title("Cumulative lead of ratio 4", loc="left", fontweight="bold", fontsize=8.7)

    rows = crossing["rows"]
    y = [midpoint(row["scaled_overshoot"], crossing["overshoot_scale"]) for row in rows]
    right.scatter([row["M_exponent"] for row in rows], y, color="#165760", s=18, zorder=3)
    right.axhline(b, color="#994724", lw=1.2, ls="--", label="pair-law limit")
    right.set(xlabel=r"height exponent $\log_2 M$", ylabel=r"$(B_*-M)/H_M$",
              xticks=[24, 28, 32, 36], yticks=[.735, .745, .755, .765], ylim=(.732, .765))
    right.legend(loc="upper right", frameon=False, fontsize=6.8)
    right.set_title("Location of first contact", loc="left", fontweight="bold", fontsize=8.7)
    for ax in (left, right):
        ax.spines[["top", "right"]].set_visible(False)
        ax.grid(axis="y", color="#dce4e4", lw=.6)
        ax.set_axisbelow(True)
    fig.tight_layout(pad=.7, w_pad=1.4)
    with StringIO() as stream:
        fig.savefig(stream, format="svg", metadata={"Date": None})
        svg = "\n".join(line.rstrip() for line in stream.getvalue().splitlines()) + "\n"
    args.output.write_text(svg, encoding="utf-8", newline="\n")
    plt.close(fig)


if __name__ == "__main__":
    main()
