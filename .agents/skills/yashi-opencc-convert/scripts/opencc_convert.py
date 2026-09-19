#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
opencc_convert.py — 中文简繁转换工具 (基于 OpenCC)

使用 OpenCC 进行中文简繁转换, 支持简体↔繁体、以及台湾/香港/日本汉字变体。
默认「自动检测方向」: 文本含繁体字 → 转为简体; 全为简体 → 转为繁体。

用法 (核心: 管道输入/输出 + -w 就地改写, 对 AI 调用最友好):
    # 1) 就地改写文件中的文本 (AI 最常用, 无需处理 stdout)
    python opencc_convert.py -w notes.md

    # 2) heredoc 管道粘贴文本 → 转换结果直接输出到 stdout
    python opencc_convert.py <<'EOF'
    中文简体测试
    EOF

    # 3) 管道: 从 stdin 读入, 输出到 stdout (cat / echo 等均可)
    cat text.txt | python opencc_convert.py

    # 4) 读取文件, 结果输出到 stdout
    python opencc_convert.py notes.md

    # 5) 输出到指定文件
    python opencc_convert.py notes.md -o notes_trad.md

    # 6) 显式指定转换集 / 目标地区
    python opencc_convert.py -f s2t   notes.md   # 简体 → 繁体 (标准)
    python opencc_convert.py -f t2s   notes.md   # 繁体 → 简体
    python opencc_convert.py -f s2twp notes.md   # 简体 → 台湾繁体 (含短语)
    python opencc_convert.py --to tw  notes.md   # 快捷: 转台湾繁体
    python opencc_convert.py --to cn  notes.md   # 快捷: 转简体

    # 7) 在 Python 中作为模块直接调用
    import opencc_convert
    text = opencc_convert.convert_text(原文)     # 返回转换后的文本

转换集说明 (OpenCC):
    s2t    简体 → 繁体 (标准)     t2s    繁体 → 简体
    s2tw   简体 → 台湾繁体       tw2s   台湾繁体 → 简体
    s2hk   简体 → 香港繁体       hk2s   香港繁体 → 简体
    s2twp  简体 → 台湾繁体(含短语) tw2sp  台湾繁体 → 简体(含短语)
    t2tw   繁体 → 台湾繁体       t2hk   繁体 → 香港繁体
    t2jp   繁体 → 日本新字体     jp2t   日本新字体 → 繁体
    auto   自动检测方向 (默认)

依赖: opencc-python-reimplemented
    python -m pip install opencc-python-reimplemented
"""

import argparse
import sys
from pathlib import Path

try:
    import opencc
except ImportError:
    print("错误: 未安装 opencc-python-reimplemented, 请先运行:", file=sys.stderr)
    print("  python -m pip install opencc-python-reimplemented", file=sys.stderr)
    sys.exit(1)

# ---------------------------------------------------------------------------
# 常量
# ---------------------------------------------------------------------------

VALID_CONFIGS = (
    "s2t", "t2s", "s2tw", "tw2s", "s2hk", "hk2s",
    "s2twp", "tw2sp", "t2tw", "t2hk", "t2jp", "jp2t", "auto",
)

# --to 快捷地区映射: 目标地区 → 默认转换集
REGION_MAP = {
    "cn": "t2s",     # 转简体
    "tw": "s2twp",   # 转台湾繁体 (含短语)
    "hk": "s2hk",    # 转香港繁体
    "jp": "t2jp",    # 转日本新字体 (输入须为繁体)
}

_CACHE = {}


def _get_converter(config: str):
    """获取 (并缓存) OpenCC 转换器, 避免重复加载词典。"""
    if config not in _CACHE:
        _CACHE[config] = opencc.OpenCC(config)
    return _CACHE[config]


# ---------------------------------------------------------------------------
# 核心转换
# ---------------------------------------------------------------------------

def convert_text(text: str, config: str = "auto") -> str:
    """将文本按指定转换集转换; config='auto' 时自动检测方向。

    自动检测规则: 用 t2s 试转, 若结果与原文不同说明含繁体字符 → 转简体;
    否则视为简体文本 → 转繁体。空文本原样返回。
    """
    if not text:
        return text
    if config == "auto":
        t2s = _get_converter("t2s")
        if t2s.convert(text) != text:
            return t2s.convert(text)
        return _get_converter("s2t").convert(text)
    return _get_converter(config).convert(text)


# ---------------------------------------------------------------------------
# 命令行入口
# ---------------------------------------------------------------------------

def main() -> None:
    ap = argparse.ArgumentParser(
        description="中文简繁转换: 基于 OpenCC, 默认自动检测方向。",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    ap.add_argument("file", nargs="?", help="输入文本文件 (缺省从 stdin 读取)")
    ap.add_argument("-o", "--output", help="输出文件 (缺省输出到 stdout)")
    ap.add_argument("-w", "--write", action="store_true",
                    help="就地改写输入文件")
    ap.add_argument("-f", "--from", dest="from_config",
                    choices=VALID_CONFIGS, default="auto",
                    help="OpenCC 转换集 (默认 auto 自动检测方向)")
    ap.add_argument("--to", dest="to_region", choices=tuple(REGION_MAP),
                    help="快捷指定目标地区: cn/tw/hk/jp")
    args = ap.parse_args()

    if args.from_config != "auto" and args.to_region:
        ap.error("-f/--from 与 --to 不能同时使用")

    config = REGION_MAP[args.to_region] if args.to_region else args.from_config

    if args.file:
        text = Path(args.file).read_text(encoding="utf-8")
    else:
        text = sys.stdin.read()

    result = convert_text(text, config)

    if hasattr(sys.stdout, "reconfigure"):          # Windows 下避免 GBK 编码问题
        sys.stdout.reconfigure(encoding="utf-8")

    if args.write and args.file:
        Path(args.file).write_text(result, encoding="utf-8")
        print(f"已转换并就地改写: {args.file}")
    elif args.output:
        Path(args.output).write_text(result, encoding="utf-8")
        print(f"已写入: {args.output}")
    else:
        sys.stdout.write(result)


if __name__ == "__main__":
    main()
