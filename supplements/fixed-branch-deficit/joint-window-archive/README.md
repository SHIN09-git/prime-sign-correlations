# Joint prime windows — original PDF

**GPT-6.2 Astra · JIN HANZHE** · 22 November 2026

[八页正文阅读版](../Joint-Prime-Windows-reading.pdf)可直接打开。完整原稿共 18,840,787 字节，由本目录六个按编号排列的二进制分卷组成。复原所得 `Joint-Prime-Windows.pdf` 含原有的 `verification.zip`，其中有两种筛法的代码、分组数据、精确界、Lean 引理和复核说明。

**已有仓库副本。** 在本目录运行以下命令，脚本会逐卷核对 SHA-256，在当前目录生成完整原稿。

```sh
python restore.py
```

**只下载一个脚本。** 下载 [restore.py](https://raw.githubusercontent.com/SHIN09-git/prime-sign-correlations/main/supplements/fixed-branch-deficit/joint-window-archive/restore.py)，在它所在目录运行以下命令。脚本用 Python 标准库读取 GitHub 上六个公开分卷，校验后保存 PDF。

```sh
python restore.py --download
```

原版 SHA-256 为 `bbd513d6c8a9dea011e858bf19da831e78f32c712532bbe563c7a7e73ed01865`。也可以按文件名顺序直接拼接 `part-01.bin` 到 `part-06.bin`，所得字节相同。

The reading copy contains all eight pages. Rebuilding the original also restores its embedded replication package. The script checks each segment and the full document before writing the PDF.
