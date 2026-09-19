#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
encoding_convert.py — 文本编码转换工具

读取任意编码的文本文件, 输出为指定编码(默认 UTF-8)。典型场景: AI 读取
ANSI(GBK) 等非 UTF-8 文件时先转成 UTF-8; 或将文本保存为特定编码(如 GBK)
供旧程序/旧设备使用。

用法 (核心: 管道输入/输出 + -w 就地改写, 对 AI 调用最友好):
    # 1) 读取 ANSI(GBK) 文件, 输出 UTF-8 到 stdout (AI 最常用)
    python encoding_convert.py notes.txt

    # 2) 就地改写: 将文件转成 UTF-8 保存 (自动检测原编码)
    python encoding_convert.py -w notes.txt

    # 3) 指定输入编码 (自动检测不可靠时, 如 Big5/日文)
    python encoding_convert.py -i big5 notes.txt

    # 4) 输出为指定编码 (如保存为 GBK 给旧程序)
    python encoding_convert.py -e gbk -o out.txt notes.txt
    python encoding_convert.py -w -e gbk notes.txt

    # 5) 管道: stdin 字节流 → stdout 字节流 (cat / heredoc 均可)
    cat notes.txt | python encoding_convert.py

    # 6) 输出 UTF-8 带 BOM (Windows 记事本兼容)
    python encoding_convert.py -e utf-8-sig -o out.txt notes.txt

    # 7) 在 Python 中作为模块直接调用
    import encoding_convert
    text = encoding_convert.decode_bytes(原始字节)         # 自动检测编码 → str
    data = encoding_convert.encode_text(text, "gbk")       # str → 指定编码 bytes
    data = encoding_convert.convert_bytes(原始字节)        # 检测输入编码 → UTF-8 bytes

编码说明:
    输入编码 -i/--input-encoding: 默认 auto 自动检测
        检测顺序: UTF-8(含BOM) → UTF-16/32(带BOM) → GB18030 → Big5 → Shift_JIS
                  → EUC-KR → Latin-1(兜底)
        常见中文 ANSI 文件即 GBK/GB2312, 由 GB18030 覆盖, 检测可靠;
        Big5/日文/韩文/西文建议显式指定, 避免误判——检测时会把所有
        能解码的候选编码列在 stderr 提示中, 供判断是否需要 -i。
    输出编码 -e/--encoding: 默认 utf-8 (可用 utf-8-sig 输出带 BOM)
    常用编码: utf-8, utf-8-sig, gb18030(含gbk/gb2312), big5, shift_jis,
              euc-kr, latin-1, cp1252, utf-16, utf-16le, utf-16be
    别名: ansi→gb18030  gbk/gb2312/cp936→gb18030  sjis→shift_jis
          latin1/iso-8859-1→latin-1  utf8→utf-8  utf16→utf-16

依赖: 无 (仅 Python 标准库 codecs)
"""

import argparse
import codecs
import sys
from pathlib import Path

# ---------------------------------------------------------------------------
# 常量
# ---------------------------------------------------------------------------

# 自动检测时的尝试顺序 (每个编码均要求严格解码成功)
DETECT_ORDER = ("gb18030", "big5", "shift_jis", "euc-kr")

# 常见编码别名 → 标准 codec 名
ENCODING_ALIASES = {
    "utf8": "utf-8", "utf_8": "utf-8",
    "ansi": "gb18030",
    "gbk": "gb18030", "gb2312": "gb18030", "cp936": "gb18030",
    "big5-hkscs": "big5hkscs",
    "sjis": "shift_jis",
    "latin1": "latin-1", "latin": "latin-1", "iso-8859-1": "latin-1",
    "windows-1252": "cp1252",
    "utf16": "utf-16", "utf16le": "utf-16le", "utf16be": "utf-16be",
}


def normalize_encoding(name: str) -> str:
    """将别名/大小写归一化为 Python codec 名, 并校验其有效。"""
    key = name.strip().lower().replace("_", "-")
    resolved = ENCODING_ALIASES.get(key, key)
    try:
        codecs.lookup(resolved)
    except LookupError:
        raise ValueError(f"未知编码: {name} (可尝试: utf-8, gb18030, big5, shift_jis, euc-kr, latin-1, cp1252, utf-16)")
    return resolved


# ---------------------------------------------------------------------------
# 编码检测
# ---------------------------------------------------------------------------

def _successful_candidates(data: bytes) -> list[str]:
    """返回能成功解码 data 的所有候选编码 (按 DETECT_ORDER 顺序)。

    GB18030 是双字节满映射, 任何 CJK 字节流几乎都能"成功"解码,
    所以单个编码的成功与否并不能证明语义正确——多候选列表供调用者
    判断是否需要 -i 显式指定。
    """
    return [enc for enc in DETECT_ORDER
            if _can_decode(data, enc)]


def _can_decode(data: bytes, enc: str) -> bool:
    try:
        data.decode(enc)
        return True
    except UnicodeDecodeError:
        return False


def detect_encoding(data: bytes) -> str:
    """自动检测字节流的文本编码 (确定性尝试, 无第三方依赖)。

    顺序: BOM → UTF-8 → 首个可解码的 CJK 候选(GB18030) → Latin-1 兑底。
    注: 中文 GBK/GB2312 文件由 GB18030 覆盖且检测可靠; Big5/日文/韩文
    建议显式 -i 指定 (GB18030 会"抢走"它们, 见 detect_candidates)。
    """
    if data.startswith(b"\xef\xbb\xbf"):
        return "utf-8-sig"
    if data.startswith((b"\xff\xfe\x00\x00", b"\x00\x00\xfe\xff")):
        return "utf-32"
    if data.startswith((b"\xff\xfe", b"\xfe\xff")):
        return "utf-16"
    try:
        data.decode("utf-8")
        return "utf-8"
    except UnicodeDecodeError:
        pass
    for enc in DETECT_ORDER:
        if _can_decode(data, enc):
            return enc
    return "latin-1"  # 兑底: Latin-1 可解码任意字节


# ---------------------------------------------------------------------------
# 核心转换
# ---------------------------------------------------------------------------

def decode_bytes(data: bytes, input_encoding: str = "auto") -> str:
    """将字节解码为 str。input_encoding='auto' 时自动检测。"""
    enc = detect_encoding(data) if input_encoding == "auto" else normalize_encoding(input_encoding)
    try:
        return data.decode(enc)
    except UnicodeDecodeError as e:
        raise ValueError(f"无法用 {enc} 解码输入 (第 {e.start} 字节附近非法序列); 请用 -i 显式指定输入编码") from e


def encode_text(text: str, output_encoding: str = "utf-8") -> bytes:
    """将 str 编码为字节。"""
    enc = normalize_encoding(output_encoding)
    return text.encode(enc)


def convert_bytes(data: bytes, input_encoding: str = "auto",
                  output_encoding: str = "utf-8") -> tuple[bytes, str, str]:
    """完整转换: 字节 → str → 字节。返回 (结果字节, 实际输入编码, 输出编码)。"""
    in_enc = detect_encoding(data) if input_encoding == "auto" else normalize_encoding(input_encoding)
    text = data.decode(in_enc)
    out_enc = normalize_encoding(output_encoding)
    return text.encode(out_enc), in_enc, out_enc


# ---------------------------------------------------------------------------
# 命令行入口
# ---------------------------------------------------------------------------

def main() -> None:
    ap = argparse.ArgumentParser(
        description="文本编码转换: 读取任意编码文本, 默认输出 UTF-8。",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    ap.add_argument("file", nargs="?", help="输入文本文件 (缺省从 stdin 读取)")
    ap.add_argument("-o", "--output", help="输出文件 (缺省输出到 stdout)")
    ap.add_argument("-w", "--write", action="store_true",
                    help="就地改写输入文件 (注意: 会改变文件本身的编码)")
    ap.add_argument("-i", "--input-encoding", default="auto",
                    help="输入编码, 默认 auto 自动检测 (如 gb18030/big5/shift_jis)")
    ap.add_argument("-e", "--encoding", default="utf-8",
                    help="输出编码, 默认 utf-8 (如 gbk/big5/utf-8-sig)")
    args = ap.parse_args()

    try:
        if args.file:
            raw = Path(args.file).read_bytes()
        else:
            raw = sys.stdin.buffer.read()

        out_bytes, in_enc, out_enc = convert_bytes(raw, args.input_encoding, args.encoding)

        if args.write and args.file:
            # 原子写: 先写临时文件再替换, 避免转换中断写坏原文件
            target = Path(args.file)
            tmp = target.with_name(target.name + ".tmp")
            tmp.write_bytes(out_bytes)
            tmp.replace(target)
            print(f"已转换并就地改写: {args.file} ({in_enc} → {out_enc})", file=sys.stderr)
        elif args.output:
            Path(args.output).write_bytes(out_bytes)
            print(f"已写入: {args.output} ({in_enc} → {out_enc})", file=sys.stderr)
        else:
            sys.stdout.buffer.write(out_bytes)
            if args.input_encoding == "auto":
                others = [e for e in _successful_candidates(raw) if e != in_enc]
                hint = f"# 输入编码自动检测: {in_enc}"
                if others:
                    hint += f" (另有可解码候选: {', '.join(others)}; 若结果乱码请用 -i 显式指定)"
                print(hint, file=sys.stderr)
    except (ValueError, UnicodeDecodeError) as e:
        print(f"错误: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
