#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
md_table_format.py — Markdown 表格自动整理工具

按「显示宽度」重排表格列（全角字符占 2 格、半角字符占 1 格），使表格在
等宽字体下工整对齐，正确处理中英文混排，并保留每列的对齐方式。

宽度规则（基于 Unicode East Asian Width）:
    全角  F / W      → 2 格   如: 中文、日文假名、全角标点「、」、——
    半角  H / Na / N → 1 格   如: ASCII 字母、数字、半角标点 , . ( )
    模糊  A          → 默认 2 格 (中文环境下 ©、·、℃ 等按全角显示)
                       可用 --ambiguous-width 1 调整为半角

用法 (核心: 管道输入/输出 + -w 就地改写, 对 AI 调用最友好):
    # 1) 就地改写文件中的表格 (AI 最常用, 无需处理 stdout)
    python md_table_format.py -w notes.md

    # 2) heredoc 管道粘贴表格文本 → 整理结果直接输出到 stdout
    python md_table_format.py <<'EOF'
    | 名称 | 版本 |
    | --- | --- |
    | Python | 3.12 |
    EOF

    # 3) 管道: 从 stdin 读入, 输出到 stdout (cat / echo 等均可)
    cat notes.md | python md_table_format.py

    # 4) 读取文件, 结果输出到 stdout
    python md_table_format.py notes.md

    # 5) 输出到指定文件
    python md_table_format.py notes.md -o notes_fmt.md

    # 6) Ambiguous 字符(©·℃等)按半角 1 格处理
    python md_table_format.py --ambiguous-width 1 notes.md

    # 7) 在 Python 中作为模块直接调用
    import md_table_format
    text = md_table_format.format_md(原文)   # 返回整理后的完整文本

AI 调用建议:
    * 用「heredoc 管道或 -w 就地改写」而非手工拼空格, 避免列宽算错;
    * 在代码注释中生成表格时, 先写好表格文本再跑本工具格式化即可;
    * heredoc 的结束标记 EOF 须顶格书写。

处理说明:
    * 仅处理「标准 Markdown 表格」(第二行为分隔行: --- / :--- / ---: / :---:)
    * 表格以外的行原样输出, ``` 围栏代码块内部不会误处理
    * 分隔行冒号决定列对齐:  :--- 左对齐(默认)  ---: 右对齐  :---: 居中
    * 单元格内的转义竖线 \\| 不会被误切分; HTML 标签(如 <br>)不计入宽度
"""

import argparse
import re
import sys
import unicodedata
from pathlib import Path

# Windows 中文环境下 stdin/stdout 默认走 GBK，会引发两类问题：
#   1) --help 在 parse_args() 阶段就打印含 © 等字符的文档 -> UnicodeEncodeError 崩溃；
#   2) 管道传入的 UTF-8 文本被按 GBK 解码 -> 乱码。
# 因此在**导入期**就把三个流统一成 UTF-8（文件读写本来就是 UTF-8，保持一致）。
for _stream in (sys.stdin, sys.stdout, sys.stderr):
    try:
        _stream.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass

# ---------------------------------------------------------------------------
# 显示宽度计算
# ---------------------------------------------------------------------------

def char_width(ch: str, ambiguous_width: int = 2) -> int:
    """单个字符的显示宽度: 全角 2 格, 半角 1 格。"""
    eaw = unicodedata.east_asian_width(ch)
    if eaw in ("F", "W"):
        return 2
    if eaw == "A":
        return ambiguous_width
    return 1


_TAG_RE = re.compile(r"<[^>]*>")          # HTML 标签, 渲染时不可见, 不计宽度


def str_width(s: str, ambiguous_width: int = 2) -> int:
    """字符串显示宽度: 剔除 HTML 标签后逐字符累计。"""
    s = _TAG_RE.sub("", s)
    return sum(char_width(c, ambiguous_width) for c in s)


# ---------------------------------------------------------------------------
# 表格解析
# ---------------------------------------------------------------------------

# 分隔行: 仅由 - : | 和空白组成, 且至少含一个 '-'
_SEP_RE = re.compile(r"^\s*\|?\s*:?-+:?\s*(\|\s*:?-+:?\s*)*\|?\s*$")
# 未转义的竖线作为列分隔符
_CELL_SPLIT_RE = re.compile(r"(?<!\\)\|")


def looks_like_separator(line: str) -> bool:
    """判断是否为分隔行。"""
    return "-" in line and bool(_SEP_RE.match(line.strip()))


def split_row(line: str) -> list:
    """表格行 -> 单元格列表。去掉首尾 | 与单元格首尾空白。"""
    s = line.strip()
    if s.startswith("|"):
        s = s[1:]
    if s.endswith("|") and not s.endswith(r"\|"):
        s = s[:-1]
    return [c.strip() for c in _CELL_SPLIT_RE.split(s)]


def parse_separator(line: str) -> list:
    """分隔行 -> 每列对齐方式列表 ('left' / 'right' / 'center')。"""
    aligns = []
    for c in split_row(line):
        c = c.strip()
        left, right = c.startswith(":"), c.endswith(":")
        if left and right:
            aligns.append("center")
        elif right:
            aligns.append("right")
        else:
            aligns.append("left")
    return aligns


def is_table_row(line: str) -> bool:
    """表格数据行必须包含竖线。"""
    return "|" in line


# ---------------------------------------------------------------------------
# 输出构建
# ---------------------------------------------------------------------------

def format_cell(text: str, width: int, align: str) -> str:
    """按列宽与对齐方式补齐单个单元格 (按显示宽度计算)。"""
    diff = width - str_width(text)
    if diff <= 0:
        return text
    if align == "right":
        return " " * diff + text
    if align == "center":
        left = diff // 2
        return " " * left + text + " " * (diff - left)
    return text + " " * diff


def make_row(cells: list, widths: list, aligns: list) -> str:
    """生成一行: | a | b |"""
    return "| " + " | ".join(
        format_cell(c, w, a) for c, w, a in zip(cells, widths, aligns)
    ) + " |"


def make_separator(aligns: list, widths: list) -> str:
    """生成分隔行, 按对齐方式放置冒号。"""
    parts = []
    for a, w in zip(aligns, widths):
        dashes = "-" * w
        if a == "center":
            parts.append(":" + dashes + ":")
        elif a == "right":
            parts.append(dashes + ":")
        else:
            parts.append(dashes)          # 左对齐省略冒号, 保持原貌
    return "| " + " | ".join(parts) + " |"


# ---------------------------------------------------------------------------
# 主流程
# ---------------------------------------------------------------------------

def format_md(text: str, ambiguous_width: int = 2) -> str:
    """整理全文中的 Markdown 表格, 其余内容原样保留。"""
    lines = text.split("\n")
    out = []
    i, n = 0, len(lines)
    in_code = False

    while i < n:
        line = lines[i]
        stripped = line.strip()

        # 围栏代码块内不处理
        if stripped.startswith("```"):
            in_code = not in_code
            out.append(line)
            i += 1
            continue
        if in_code:
            out.append(line)
            i += 1
            continue

        # 表格头 + 分隔行 -> 收集整个表格
        if is_table_row(line) and i + 1 < n and looks_like_separator(lines[i + 1]):
            rows = [split_row(line)]
            aligns = parse_separator(lines[i + 1])
            j = i + 2
            while j < n and is_table_row(lines[j]):
                rows.append(split_row(lines[j]))
                j += 1

            # 统一列数 (缺列补空)
            ncols = max(len(r) for r in rows)
            rows = [r + [""] * (ncols - len(r)) for r in rows]
            if len(aligns) < ncols:
                aligns += ["left"] * (ncols - len(aligns))

            # 每列宽度 = 该列最大显示宽度 (至少 1)
            widths = [max(1, max(str_width(r[c], ambiguous_width) for r in rows))
                      for c in range(ncols)]

            out.append(make_row(rows[0], widths, aligns))          # 表头
            out.append(make_separator(aligns, widths))             # 分隔行
            out.extend(make_row(r, widths, aligns) for r in rows[1:])  # 数据行
            i = j
            continue

        out.append(line)
        i += 1

    return "\n".join(out)


# ---------------------------------------------------------------------------
# 命令行入口
# ---------------------------------------------------------------------------

def main() -> None:
    ap = argparse.ArgumentParser(
        description="自动整理 Markdown 表格: 按全角/半角显示宽度工整对齐。",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    ap.add_argument("file", nargs="?", help="输入 Markdown 文件 (缺省从 stdin 读取)")
    ap.add_argument("-o", "--output", help="输出文件 (缺省输出到 stdout)")
    ap.add_argument("-w", "--write", action="store_true",
                    help="就地改写输入文件")
    ap.add_argument("--ambiguous-width", type=int, choices=(1, 2), default=2,
                    help="Ambiguous 字符的显示宽度, 默认 2 (中文环境按全角)")
    args = ap.parse_args()

    if args.file:
        text = Path(args.file).read_text(encoding="utf-8")
    else:
        text = sys.stdin.read()

    result = format_md(text, args.ambiguous_width)

    if args.write and args.file:
        Path(args.file).write_text(result, encoding="utf-8")
        print(f"已整理并就地改写: {args.file}")
    elif args.output:
        Path(args.output).write_text(result, encoding="utf-8")
        print(f"已写入: {args.output}")
    else:
        sys.stdout.write(result)


if __name__ == "__main__":
    main()
