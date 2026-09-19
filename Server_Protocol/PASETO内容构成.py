"""
PASETO 令牌解析命令行工具
========================

读取 PASETO 令牌并调用 ``PASETO内容构成库`` 完成解析，将结果格式化输出到终端。
支持提供密钥解密 local 令牌。

用法
----

1) 命令行参数传入（令牌 + 可选密钥）::

    python PASETO内容构成.py "v2.public.eyJleHAiOi..."
    python PASETO内容构成.py -k <hex密钥> "v2.local.eyJ..."
    python PASETO内容构成.py -k <hex密钥> -i <hex隐性断言> "v3.local.eyJ..."

2) 管道传入::

    echo v2.public.eyJleHAiOi... | python PASETO内容构成.py
    echo v2.local.eyJ... | python PASETO内容构成.py -k <hex密钥>

3) 交互式输入::

    python PASETO内容构成.py

选项
----

``-k, --key KEY``          解密 local 令牌的 32 字节密钥（十六进制字符串）
``-i, --implicit DATA``    v3/v4 隐性断言（十六进制字符串，默认空）
``-h, --help``             显示帮助信息

输出内容
--------

- 令牌有效性及警告
- 令牌结构（段数、版本、用途、是否有 footer）
- 版本详情（是否支持隐性断言）
- 算法信息（风格 + 算法名）
- Payload 载荷（标准声明 + 自定义声明，含本地时间格式化）
- Footer 附加数据

依赖安装
--------

需要 ``PASETO内容构成库.py``（或通过 ``PYTHONPATH`` 可访问）。
仅做结构解析无需额外包。如需解密 local 令牌，按需安装：:

    pip install cryptography   # v1 / v3 local 解密
    pip install pynacl         # v2 / v4 local 解密
"""

import sys
import json

from PASETO内容构成库 import parse_paseto


# ──────────────────────────────────────────────────────────────────
# 终端格式化辅助函数
# ──────────────────────────────────────────────────────────────────


def _fmt_title(text: str) -> str:
    """生成带分隔线的大标题（用于顶级区块）。"""
    return f"\n{'=' * 50}\n  {text}\n{'=' * 50}"


def _fmt_section(text: str) -> str:
    """生成带分隔线的子标题（用于二级区块）。"""
    return f"\n{'─' * 50}\n  {text}\n{'─' * 50}"


def _print_entry(key: str, value, indent: int = 2) -> None:
    """递归打印任意深度的键值对，根据值类型采用不同展示策略。

    Args:
        key: 键名
        value: 键值，可为任意类型
        indent: 缩进空格数
    """
    prefix = " " * indent
    if isinstance(value, dict) and "label" in value and "value" in value:
        # 特殊处理标准声明条目：label/value/parsed/formatted
        label = value.get("label", key)
        raw_val = value.get("value")
        parsed = value.get("parsed")
        formatted = value.get("formatted")

        if raw_val is None:
            print(f"{prefix}{key}  ({label}): (无)")
        else:
            print(f"{prefix}{key}  ({label}): {raw_val}")
            # 若值本身是 JSON 字符串且已展开为 Python 对象，展示展开结果
            if parsed is not None and parsed != raw_val:
                print(f"{prefix}  └─ 展开: {json.dumps(parsed, ensure_ascii=False)}")
        if formatted:
            print(f"{prefix}  └─ 本地时间: {formatted}")
    elif isinstance(value, dict):
        print(f"{prefix}{key}:")
        for k, v in value.items():
            _print_entry(k, v, indent + 2)
    elif isinstance(value, list):
        print(f"{prefix}{key}:")
        for item in value:
            print(f"{prefix}  - {item}")
    elif value is None:
        print(f"{prefix}{key}: (无)")
    elif isinstance(value, bool):
        print(f"{prefix}{key}: {'是' if value else '否'}")
    else:
        print(f"{prefix}{key}: {value}")


# ──────────────────────────────────────────────────────────────────
# 帮助信息
# ──────────────────────────────────────────────────────────────────


def _print_help() -> None:
    """打印使用说明。"""
    print(__doc__)


# ──────────────────────────────────────────────────────────────────
# 格式化输出
# ──────────────────────────────────────────────────────────────────


def output(result: dict) -> None:
    """将 ``parse_paseto()`` 返回的字典格式化为可读文本并打印至 stdout。

    按区块依次输出：有效性 → 警告 → 令牌结构 → 版本详情 → 算法信息 →
    Payload 载荷 → Footer 附加数据。
    """
    raw = result["raw"]
    version_info = result["version_info"]
    algorithm = result["algorithm"]
    payload = result["payload"]
    footer = result["footer"]
    warnings = result.get("warnings", [])

    # ─── 顶部：有效性总览 ───
    print(_fmt_title("PASETO 令牌解析结果"))
    print(f"  有效性: {'有效' if result.get('valid') else '** 无效 **'}")

    # ─── 警告区块 ───
    if warnings:
        print(_fmt_section("⚠ 警告"))
        for w in warnings:
            print(f"  • {w}")

    # ─── 令牌结构概览 ───
    print(_fmt_section("令牌结构"))
    print(f"  原始段数: {raw.get('segment_count')} 段")
    print(f"  版本:     {raw.get('version')}")
    print(f"  用途:     {raw.get('purpose')}")
    has_footer = footer.get("present")
    print(f"  Footer:   {'有' if has_footer else '无'}")
    print(f"  格式:     {raw.get('version')}.{raw.get('purpose')}.<payload>"
          + (".<footer>" if has_footer else ""))

    # ─── 版本详情 ───
    if version_info:
        print(_fmt_section("版本详情"))
        for k, v in version_info.items():
            _print_entry(k, v)

    # ─── 算法信息 ───
    if algorithm:
        print(_fmt_section("算法信息"))
        for k, v in algorithm.items():
            _print_entry(k, v)

    # ─── Payload 载荷解析 ───
    print(_fmt_section("Payload 载荷"))
    if payload.get("decodable"):
        # 可解码（public 令牌 或 已解密的 local 令牌）
        note = payload.get("note")
        if note:
            print(f"  状态: {note}")
        else:
            print("  状态: 可解码（public 令牌，仅签名不加密）")

        claims = payload.get("claims")
        if claims is not None:
            print(f"  声明总数: {len(claims)} 项")

            # 标准声明（始终列出全部 7 项，缺失的显示"无"）
            std = payload.get("standard_claims")
            if std:
                print("\n  ┌─ 标准声明 ──────────────────────")
                for k, v in std.items():
                    label = v.get("label", k)
                    val = v.get("value")
                    parsed = v.get("parsed")
                    formatted = v.get("formatted")

                    if val is None:
                        print(f"  │ {k}  ({label}): (无)")
                    else:
                        print(f"  │ {k}  ({label}): {val}")
                        if parsed is not None and parsed != val:
                            print(f"  │   └─ 展开: {json.dumps(parsed, ensure_ascii=False)}")
                    if formatted:
                        print(f"  │   └─ 本地时间: {formatted}")
                print("  └──────────────────────────────────")

            # 自定义声明
            cust = payload.get("custom_claims")
            if cust:
                print("\n  ┌─ 自定义声明 ─────────────────────")
                for k, v in cust.items():
                    print(f"  │ {k} = {json.dumps(v, ensure_ascii=False)}")
                print("  └──────────────────────────────────")
        else:
            print("  (payload 解码后非有效 JSON)")
    else:
        # 不可解码（local 令牌且未提供密钥或解密失败）
        print("  状态: 不可解码（local 令牌，payload 已加密）")
        note = payload.get("note")
        if note:
            print(f"  说明: {note}")

        # local 令牌也列出标准声明占位，全部标记为"不可解码"
        std = payload.get("standard_claims")
        if std:
            print("\n  ┌─ 标准声明 ──────────────────────")
            for k, v in std.items():
                label = v.get("label", k)
                print(f"  │ {k}  ({label}): (不可解码)")
            print("  └──────────────────────────────────")

    # ─── Footer 附加数据 ───
    if has_footer:
        print(_fmt_section("Footer 附加数据"))
        note = footer.get("note")
        if note:
            print(f"  说明: {note}")
        parsed = footer.get("parsed")
        if isinstance(parsed, dict):
            print("  解析内容:")
            for k, v in parsed.items():
                print(f"    {k}: {json.dumps(v, ensure_ascii=False)}")
        else:
            print(f"  原始内容: {footer.get('raw')}")
            if parsed:
                print(f"  解码内容: {parsed}")
    else:
        print(_fmt_section("Footer 附加数据"))
        print("  (无)")

    print()


# ──────────────────────────────────────────────────────────────────
# 入口
# ──────────────────────────────────────────────────────────────────


def main() -> None:
    """程序入口：解析命令行参数 → 获取令牌 → 调用库解析 → 格式化输出。

    输入来源优先级（从高到低）：
    1. 命令行参数 ``sys.argv[1]``（令牌）
    2. 管道输入（非交互式 stdin）
    3. 交互式终端输入

    可选参数：
    ``-k`` / ``--key``：十六进制密钥字符串，用于解密 local 令牌
    ``-i`` / ``--implicit``：十六进制隐性断言字符串（v3/v4）
    """
    # ─── 解析命令行参数 ───
    token = None
    key = None
    implicit = b""
    args = sys.argv[1:]
    i = 0

    while i < len(args):
        arg = args[i]
        if arg in ("-h", "--help"):
            _print_help()
            sys.exit(0)
        elif arg in ("-k", "--key"):
            i += 1
            if i >= len(args):
                print("错误：-k/--key 需要提供一个十六进制密钥参数", file=sys.stderr)
                sys.exit(1)
            key = args[i]
        elif arg in ("-i", "--implicit"):
            i += 1
            if i >= len(args):
                print("错误：-i/--implicit 需要提供一个十六进制数据参数", file=sys.stderr)
                sys.exit(1)
            try:
                implicit = bytes.fromhex(args[i])
            except ValueError:
                print("错误：隐性断言必须为有效的十六进制字符串", file=sys.stderr)
                sys.exit(1)
        else:
            token = arg  # 第一个非选项参数视为令牌
        i += 1

    # ─── 获取令牌（管道 / 交互式） ───
    if token is None and not sys.stdin.isatty():
        # 管道输入
        token = sys.stdin.read().strip()

    if token is None:
        # 交互式输入
        print("PASETO 令牌解析器")
        print("请输入 PASETO 令牌（输入后按 Enter）：")
        try:
            token = sys.stdin.readline().strip()
        except (EOFError, KeyboardInterrupt):
            print("\n已取消")
            sys.exit(0)

    if not token:
        print("错误：未提供令牌", file=sys.stderr)
        sys.exit(1)

    # ─── 调用库解析 ───
    result = parse_paseto(token, key=key, implicit_assertion=implicit)
    output(result)


if __name__ == "__main__":
    main()
