#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
dsh_env_sync.py — DeepSeek Harness（dsh）环境变量导入 / 导出（ini 格式）。

为什么单独一个脚本
------------------
``yashi-dsh-config-sync`` 导出配置时**故意不含环境变量**（API key 等），
所以密钥要靠本脚本单独备份/恢复。两者配合才是完整的迁移：

    config-sync 导出配置 zip  +  env-sync 导出 ~/dsh-env-backup.ini

功能
----
``list``
    列出 dsh 用到的环境变量名（默认不显示值）。
``export``
    把发现的环境变量**值**写入 ini（``[dsh]`` 段）。
``import``
    从 ini 恢复：Windows 走 ``setx`` 写用户环境（新终端生效），
    其他平台/需要时输出 ``export`` 语句。
``check``
    对比 ini 与当前环境，列出缺失/不一致的变量。

变量从哪来（自动发现）
----------------------
1. ``$DSH_HOME/settings.yaml`` 里的 ``apiKeyEnv:`` / ``*Env:`` 值；
2. ``$DSH_HOME/profiles/*/cordis.patch.yml``、``profiles/*/package.json``
   里的 ``process.env.X`` / ``${X}`` / ``apiKeyEnv`` 引用；
3. ``$DSH_HOME`` 顶层 ``*.json`` / ``*.yaml`` 插件配置里的同类引用；
4. ``--from-archive <config-sync 导出的 zip>``：直接读包内 manifest 的
   ``envVarsReferenced`` 并扫描包内配置（**迁移到新机器时的推荐用法**）；
5. ``--whitelist A B`` 手工补充（以及默认白名单 ``DSH_HOME``）。

安全
----
* 导出的 ini 含**明文密钥**：请放私有位置，不要提交 git / 明文共享。
* 所有 ``list`` / ``--dry-run`` 输出默认**打码**，``--show-values`` 才显示真值。

纯标准库，无第三方依赖。
"""

from __future__ import annotations

import argparse
import configparser
import json
import os
import platform
import re
import stat
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path

# Windows 控制台默认不是 UTF-8，强制 UTF-8 输出避免中文乱码。
for _stream in (sys.stdout, sys.stderr):
    try:
        _stream.reconfigure(encoding="utf-8", errors="replace")  # type: ignore[attr-defined]
    except Exception:
        pass

SECTION = "dsh"
DEFAULT_WHITELIST = ["DSH_HOME"]
SETX_MAX_VALUE = 1024          # setx 的已知长度上限，超了会被截断

#: 变量名必须是合法标识符，避免把垃圾写进环境。
NAME_RE = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")

#: 明显与 dsh 无关的通用名，扫描时忽略。
IGNORE_NAMES = {"PATH", "HOME", "TMP", "TEMP", "SHELL", "PWD", "USER", "OS", "LANG",
                "TERM", "HOSTNAME", "PYTHONPATH", "PATHEXT", "COMSPEC", "WINDIR"}

ENV_REF_PATTERNS = (
    re.compile(r"apiKeyEnv\s*:\s*([A-Za-z_][A-Za-z0-9_]*)"),
    re.compile(r"(?:[A-Za-z_][A-Za-z0-9_]*Env)\s*:\s*([A-Za-z_][A-Za-z0-9_]*)"),
    re.compile(r"process\.env\.([A-Za-z_][A-Za-z0-9_]*)"),
    re.compile(r"process\.env\[\s*[\"']([A-Za-z_][A-Za-z0-9_]*)[\"']\s*\]"),
    re.compile(r"\$\{([A-Za-z_][A-Za-z0-9_]*)\}"),
    re.compile(r"env\.([A-Z][A-Z0-9_]{2,})"),
)

#: config-sync 导出包里，相对 $DSH_HOME 的扫描位置。
ARCHIVE_SCAN_GLOBS = ("settings.yaml", "*.json", "*.yaml", "*.yml",
                      "profiles/*/cordis.patch.yml", "profiles/*/package.json",
                      "profiles/*/pnpm-workspace.yaml")


def log(*parts) -> None:
    print(*parts, flush=True)


def warn(msg: str) -> None:
    print(f"warn: {msg}", file=sys.stderr, flush=True)


def resolve_dsh_home(cli_value: str | None = None) -> Path:
    if cli_value:
        return Path(cli_value).expanduser().resolve()
    env = os.environ.get("DSH_HOME")
    if env and env.strip():
        return Path(env.strip()).expanduser().resolve()
    return (Path.home() / ".dsh").resolve()


def mask(value: str) -> str:
    """密钥打码：保留前 4 后 2 位，其余用 *。"""
    if value is None:
        return ""
    if len(value) <= 8:
        return "*" * len(value)
    return f"{value[:4]}{'*' * (len(value) - 6)}{value[-2:]}"


def scan_text_for_names(text: str, names: set[str]) -> None:
    for pat in ENV_REF_PATTERNS:
        for m in pat.finditer(text):
            for g in m.groups():
                if not g or len(g) < 3 or not NAME_RE.match(g):
                    continue
                if g.upper() in IGNORE_NAMES or g.endswith("Env"):
                    continue
                names.add(g)


def scan_json_for_names(node, names: set[str]) -> None:
    if isinstance(node, dict):
        for k, v in node.items():
            if isinstance(v, str) and ("apiKeyEnv" in k or k.endswith("Env")) and NAME_RE.match(v):
                names.add(v)
            else:
                scan_json_for_names(v, names)
    elif isinstance(node, list):
        for it in node:
            scan_json_for_names(it, names)


def names_from_home(home: Path, names: set[str]) -> list[str]:
    """扫描本地 $DSH_HOME 得到环境变量名。返回扫描过的文件相对路径列表。"""
    scanned: list[str] = []
    candidates: list[Path] = []
    docs = [home / "settings.yaml", home / "settings.yml"]
    candidates += [p for p in docs if p.is_file()]
    candidates += sorted(home.glob("*.json")) + sorted(home.glob("*.yaml")) + sorted(home.glob("*.yml"))
    profiles = home / "profiles"
    if profiles.is_dir():
        for d in sorted(profiles.iterdir()):
            if d.is_dir() and d.name != "node_modules":
                for f in ("cordis.patch.yml", "package.json", "pnpm-workspace.yaml"):
                    if (d / f).is_file():
                        candidates.append(d / f)

    for p in candidates:
        try:
            text = p.read_text(encoding="utf-8", errors="ignore")
        except OSError:
            continue
        scanned.append(str(p.relative_to(home)) if p.is_relative_to(home) else str(p))
        scan_text_for_names(text, names)
        if p.suffix == ".json":
            try:
                scan_json_for_names(json.loads(text), names)
            except Exception:
                pass
    return scanned


def names_from_archive(archive: Path, names: set[str]) -> tuple[list[str], list[str]]:
    """扫描 config-sync 导出的 zip。返回 (扫描过的条目, manifest 里的引用)。"""
    scanned: list[str] = []
    manifest_refs: list[str] = []
    if not archive.is_file():
        warn(f"找不到导出包: {archive}")
        return scanned, manifest_refs
    try:
        zf = zipfile.ZipFile(archive)
    except zipfile.BadZipFile as e:
        warn(f"不是有效的 zip: {e}")
        return scanned, manifest_refs

    with zf:
        if "manifest.json" in zf.namelist():
            try:
                man = json.loads(zf.read("manifest.json").decode("utf-8"))
                manifest_refs = list(man.get("envVarsReferenced") or [])
                names.update(manifest_refs)
            except Exception:
                pass

        import fnmatch
        for info in zf.infolist():
            if info.is_dir() or not info.filename.startswith("dsh-home/"):
                continue
            rel = info.filename[len("dsh-home/"):]
            if not any(fnmatch.fnmatch(rel, g) for g in ARCHIVE_SCAN_GLOBS):
                continue
            try:
                text = zf.read(info).decode("utf-8", errors="ignore")
            except Exception:
                continue
            scanned.append(rel)
            scan_text_for_names(text, names)
            if rel.endswith(".json"):
                try:
                    scan_json_for_names(json.loads(text), names)
                except Exception:
                    pass
    return scanned, manifest_refs


def discover(args) -> tuple[list[str], dict]:
    """汇总所有来源，返回 (排序后的变量名, 诊断信息)。"""
    names: set[str] = set(DEFAULT_WHITELIST)
    info: dict = {"scanned": [], "manifestRefs": [], "sources": []}

    home = resolve_dsh_home(getattr(args, "home", None))
    info["home"] = str(home)
    if home.is_dir():
        scanned = names_from_home(home, names)
        info["scanned"] += scanned
        if scanned:
            info["sources"].append(f"$DSH_HOME ({len(scanned)} 个文件)")
    else:
        warn(f"$DSH_HOME 不存在: {home}")

    if getattr(args, "from_archive", None):
        scanned, refs = names_from_archive(Path(args.from_archive).expanduser(), names)
        info["scanned"] += [f"arch:{s}" for s in scanned]
        info["manifestRefs"] = refs
        info["sources"].append(f"导出包 ({len(scanned)} 个文件)")

    for w in getattr(args, "whitelist", None) or []:
        if NAME_RE.match(w):
            names.add(w)
        else:
            warn(f"忽略非法变量名: {w}")

    for n in sorted(names):
        if not NAME_RE.match(n):
            names.discard(n)
    return sorted(names), info


def cmd_list(args) -> int:
    names, info = discover(args)
    log(f"DSH_HOME: {info['home']}")
    if info["sources"]:
        log(f"扫描来源: {', '.join(info['sources'])}")
    log(f"发现 {len(names)} 个环境变量：")
    for n in names:
        v = os.environ.get(n)
        state = "已设置" if v else "未设置"
        shown = f"  = {mask(v)}" if v else ""
        log(f"  {n:<28} [{state}]{shown}")
    unset = [n for n in names if not os.environ.get(n)]
    if unset:
        log("")
        log(f"⚠️  当前进程环境里没有: {', '.join(unset)}")
        log("    （可能在系统环境/其它用户下，或确实缺失；导出前可用 setx 或 $env: 设置）")
    return 0


def write_ini(path: Path, values: dict[str, str]) -> None:
    cp = configparser.ConfigParser()
    cp.optionxform = str          # 保留变量名大小写
    cp.add_section(SECTION)
    for k in sorted(values):
        cp.set(SECTION, k, values[k])
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as f:
        cp.write(f)
    # 尽量收紧权限（POSIX 有效；Windows 上 ACL 默认已限当前用户）
    try:
        if os.name != "nt":
            path.chmod(stat.S_IRUSR | stat.S_IWUSR)
    except OSError:
        pass


def cmd_export(args) -> int:
    names, info = discover(args)
    values: dict[str, str] = {}
    missing: list[str] = []
    for n in names:
        v = os.environ.get(n)
        if v is not None and (v.strip() or args.include_empty):
            values[n] = v
        else:
            missing.append(n)

    out = Path(args.output).expanduser()
    if not values:
        warn("没有可导出的变量（全部未在当前环境设置）")
        return 1
    write_ini(out, values)

    log(f"✅ 已导出 {len(values)} 个变量 → {out}")
    for n in sorted(values):
        log(f"   {n} = {mask(values[n])}")
    if missing:
        log("")
        log(f"⚠️  跳过（当前环境未设置）: {', '.join(missing)}")
    log("")
    log("🔒 该 ini 含明文密钥：请放在私有位置，不要提交 git 或明文共享。")
    log("   迁移到新机器后：python dsh_env_sync.py import -i <该 ini>")
    return 0


def load_ini(path: Path) -> dict[str, str]:
    if not path.is_file():
        print(f"error: 找不到 ini: {path}", file=sys.stderr)
        sys.exit(1)
    cp = configparser.ConfigParser()
    cp.optionxform = str
    cp.read(path, encoding="utf-8")
    if not cp.has_section(SECTION):
        print(f"error: ini 缺少 [{SECTION}] 段", file=sys.stderr)
        sys.exit(1)
    return {k: v for k, v in cp.items(SECTION) if NAME_RE.match(k)}


def emit_shell(values: dict[str, str], shell: str) -> None:
    for k in sorted(values):
        v = values[k].replace('"', '\\"')
        if shell == "powershell":
            log(f'$env:{k} = "{v}"')
        else:
            log(f'export {k}="{v}"')


def setx(name: str, value: str) -> tuple[bool, str]:
    try:
        r = subprocess.run(["setx", name, value], capture_output=True, text=True, timeout=60)
    except Exception as e:                                  # pragma: no cover
        return False, str(e)
    if r.returncode != 0:
        return False, (r.stderr or r.stdout).strip()
    return True, ""


def cmd_import(args) -> int:
    values = load_ini(Path(args.input).expanduser())
    if args.only:
        keep = {n for n in args.only}
        values = {k: v for k, v in values.items() if k in keep}

    diff = {k: v for k, v in values.items() if os.environ.get(k) != v}

    if args.format == "shell" or args.format == "powershell":
        emit_shell(values, args.format)
        print(f"# 共 {len(values)} 个变量；{len(diff)} 个与当前环境不同", file=sys.stderr)
        print("# 复制上面几行到对应 shell 执行，或写进启动 dsh 的终端配置。", file=sys.stderr)
        return 0

    if args.dry_run:
        log(f"（--dry-run 预览 {len(values)} 个变量，未写入）")
        for k in sorted(values):
            mark = "更新" if k in diff else "已是该值"
            shown = values[k] if args.show_values else mask(values[k])
            log(f"  [{mark}] {k} = {shown}")
        return 0

    if platform.system().lower() != "windows":
        warn("非 Windows 平台：请用 --format shell / --format powershell 输出后注入环境")
        return 1

    log(f"将写入 {len(values)} 个变量到 Windows 用户环境（setx，新开终端生效）")
    ok, failed, truncated = 0, [], []
    for k in sorted(values):
        v = values[k]
        if len(v) >= SETX_MAX_VALUE:
            truncated.append(f"{k}({len(v)} 字符)")
        good, err = setx(k, v)
        if good:
            ok += 1
            log(f"  ✅ {k} = {v if args.show_values else mask(v)}")
        else:
            failed.append(k)
            log(f"  ❌ {k}: {err}")

    log("")
    log(f"完成：成功 {ok}/{len(values)}")
    if truncated:
        log(f"⚠️  以下值超过 setx {SETX_MAX_VALUE} 字符上限，可能被截断: {', '.join(truncated)}")
        log("   → 改用 --format powershell 注入，或直接在启动 dsh 的终端里 export")
    if failed:
        log(f"⚠️  失败: {', '.join(failed)}")
    log("⚠️  setx 只对**新开**的进程生效：当前终端读不到，需重开终端 / 重启 dsh。")
    log("   验证: python dsh_env_sync.py list")
    return 0 if not failed else 1


def cmd_check(args) -> int:
    if args.input:
        values = load_ini(Path(args.input).expanduser())
    else:
        names, _info = discover(args)
        values = {n: os.environ.get(n, "") for n in names}

    missing, mismatch, same = [], [], []
    for k, v in sorted(values.items()):
        cur = os.environ.get(k)
        if cur is None:
            missing.append(k)
        elif cur != v:
            mismatch.append(k)
        else:
            same.append(k)

    log(f"检查 {len(values)} 个变量：一致 {len(same)}，不一致 {len(mismatch)}，缺失 {len(missing)}")
    for k in mismatch:
        log(f"  ⚠️  {k}: 当前={mask(os.environ.get(k, ''))} 期望={mask(values[k])}")
    for k in missing:
        log(f"  ❌ {k}: 当前环境没有该变量")
    if missing or mismatch:
        log("")
        log("修复: python dsh_env_sync.py import -i <ini>   （然后重开终端）")
        return 1
    log("✅ 全部一致")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(
        prog="dsh_env_sync.py",
        description="DeepSeek Harness 环境变量导入/导出（ini）")
    sub = ap.add_subparsers(dest="cmd", required=True)

    def common(p):
        p.add_argument("--home", help="覆盖 $DSH_HOME")
        p.add_argument("--from-archive", help="从 config-sync 导出的 zip 里发现变量名")
        p.add_argument("-w", "--whitelist", nargs="*", help="额外变量名（空格分隔）")

    pl = sub.add_parser("list", help="列出 dsh 用到的环境变量名（值打码）")
    common(pl)
    pl.set_defaults(func=cmd_list)

    pe = sub.add_parser("export", help="导出环境变量值到 ini")
    common(pe)
    pe.add_argument("-o", "--output", default=str(Path.home() / "dsh-env-backup.ini"))
    pe.add_argument("--include-empty", action="store_true", help="连空值一起导出")
    pe.set_defaults(func=cmd_export)

    pi = sub.add_parser("import", help="从 ini 恢复环境变量")
    pi.add_argument("-i", "--input", required=True)
    pi.add_argument("--format", choices=["setx", "shell", "powershell"], default="setx",
                    help="setx=写 Windows 用户环境；shell/powershell=输出 export 语句")
    pi.add_argument("--dry-run", action="store_true", help="只预览不写入")
    pi.add_argument("--show-values", action="store_true", help="显示明文值（默认打码）")
    pi.add_argument("--only", nargs="*", help="只导入这些变量")
    pi.set_defaults(func=cmd_import)

    pc = sub.add_parser("check", help="对比 ini 与当前环境")
    common(pc)
    pc.add_argument("-i", "--input", help="ini 路径；省略则与发现到的变量名对比")
    pc.set_defaults(func=cmd_check)

    args = ap.parse_args()
    return args.func(args) or 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("\n已中断", file=sys.stderr)
        sys.exit(130)
