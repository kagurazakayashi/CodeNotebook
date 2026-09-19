#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
dsh_config_sync.py — DeepSeek Harness（dsh）配置一句话导入 / 导出。

设计目标
--------
* **导出**：把 ``$DSH_HOME`` 下所有「配置类」文件打包成一个 zip：
  主设置 ``settings.yaml``、用户全局指令 ``AGENTS.md``、自定义 agent 预设
  ``.agent-presets/``、各 profile 的 ``package.json`` / ``cordis.patch.yml`` /
  ``pnpm-workspace.yaml`` / ``.npmrc``，以及**插件自己的配置文件**
  （顶层 ``*.json`` / ``*.yaml`` / 插件配置子目录等，运行时自动发现）。
* **不导出**：
  - 环境变量（API key 等）——由 ``yashi-dsh-env-sync`` 用 ini 单独导入导出；
  - 敏感凭证（``.credentials.yaml`` / ``credentials.json`` / ``*.key`` / ``*.pem``
    / 含 ``_authToken`` 的 ``.npmrc``）——导入后重新登录或重填；
  - **所有导入后能自动下载/重建的东西**（``node_modules``、
    ``.dsh-module-fallback``、``pnpm-lock.yaml``、``cordis.yml``）；
  - 运行时数据（``sessions`` / ``storages`` / ``attachments`` / ``llm-deepseek``
    / 日志 / 回收站 / usage 账本）。
* **导入**：还原文件 → 逐 profile 自动补全依赖（``pnpm install`` +
  ``pnpm approve-builds --all``）→ 实测 ``dsh web`` 启动/停止 → 输出诊断，
  失败时给出可执行的排障建议（联动 ``yashi-dsh-update``）。

命令
----
::

    python dsh_config_sync.py export  [-o OUT.zip] [--home DIR] [--print]
    python dsh_config_sync.py inspect -i IN.zip
    python dsh_config_sync.py import  -i IN.zip [--home DIR] [--dry-run]
    python dsh_config_sync.py test    [--home DIR] [--port N]

纯标准库，无第三方依赖。
"""

from __future__ import annotations

import argparse
import fnmatch
import hashlib
import json
import os
import platform
import re
import shutil
import socket
import subprocess
import sys
import time
import urllib.error
import urllib.request
import zipfile
from datetime import datetime, timezone
from pathlib import Path

TOOL = "yashi-dsh-config-sync"
FORMAT_VERSION = 1
HOME_PREFIX = "dsh-home/"

# Windows 控制台默认不是 UTF-8，强制 UTF-8 输出避免中文乱码。
for _stream in (sys.stdout, sys.stderr):
    try:
        _stream.reconfigure(encoding="utf-8", errors="replace")  # type: ignore[attr-defined]
    except Exception:
        pass

# --------------------------------------------------------------------------
# 分类规则（改这里就能调整导出范围）
# --------------------------------------------------------------------------

#: 可自动重建/下载：任何位置出现这些目录名都跳过。
REBUILDABLE_DIRS = {
    "node_modules",
    ".dsh-module-fallback",
    ".pnpm-store",
    ".pnpm",
    "__pycache__",
    ".cache",
    "cache",
}

#: 可自动重建/生成的单个文件。
REBUILDABLE_FILES = {
    "pnpm-lock.yaml",
    "package-lock.json",
    "yarn.lock",
    "cordis.yml",          # 运行时由 bundle 层合成的产物
    ".DS_Store",
    "Thumbs.db",
    ".eslintcache",
}

#: 可自动重建的文件后缀。
REBUILDABLE_SUFFIXES = (".log", ".tmp", ".temp", ".pid", ".lock")

#: 运行时数据目录（非配置）。--with-data 可强制包含。
DATA_DIRS = {
    "sessions",            # 会话历史（JSONL）
    "storages",            # KV 持久化（storage-json 后端）
    "attachments",         # 图片等附件字节
    "llm-deepseek",        # 文件上传缓存 files-v3.json
    "trash",               # 回收站
    "task-board",          # 插件运行数据
    "dsh-usage",           # 用量账本
    "dsh-session-archive", # 归档会话
    "@wingsky-1",          # 插件运行数据
    "logs",
    "log",
    "tmp",
}

#: 敏感凭证文件（--with-secrets 可强制包含，默认绝不导出）。
SENSITIVE_FILES = {
    ".credentials.yaml",
    "credentials.yaml",
    "credentials.json",
    ".env",
    ".env.local",
    ".env.production",
    ".netrc",
    "_netrc",
    "id_rsa",
    "id_ed25519",
    "id_ecdsa",
}

#: 敏感文件后缀。
SENSITIVE_SUFFIXES = (".key", ".pem", ".p12", ".pfx", ".jks", ".keystore", ".ppk")

#: 文件名含这些片段即视为凭证（大小写不敏感）。
SENSITIVE_HINTS = ("secret", "password", "passwd", "api_key", "apikey", "access_token", "private_key")

#: $DSH_HOME 根下的已知配置**文件**（其余根文件视为「插件配置」一并导出并标注）。
KNOWN_ROOT_FILES = {
    "settings.yaml",
    "settings.yml",
    "AGENTS.md",
    "CLAUDE.md",
    "AGENTS.local.md",
    "CLAUDE.local.md",
    ".anonymous-user-id",
}

#: $DSH_HOME 根下的已知配置**目录**（递归导出）。
KNOWN_ROOT_DIRS = {".agent-presets"}

#: profile 目录里的配置文件白名单（其余文件按「插件/未知」处理）。
PROFILE_CONFIG_FILES = {"package.json", "cordis.patch.yml", "pnpm-workspace.yaml", ".npmrc"}

PROFILES_DIR = "profiles"

#: 环境变量引用扫描：settings.yaml / cordis.patch.yml 里常见的几种写法。
#: 每个模式只捕获「变量名」本身（键名一律用非捕获组，避免把 apiKeyEnv 当成变量）。
ENV_REF_PATTERNS = (
    re.compile(r"apiKeyEnv\s*:\s*([A-Za-z_][A-Za-z0-9_]*)"),
    re.compile(r"(?:[A-Za-z_][A-Za-z0-9_]*Env)\s*:\s*([A-Za-z_][A-Za-z0-9_]*)"),
    re.compile(r"process\.env\.([A-Za-z_][A-Za-z0-9_]*)"),
    re.compile(r"process\.env\[\s*[\"']([A-Za-z_][A-Za-z0-9_]*)[\"']\s*\]"),
    re.compile(r"\$\{([A-Za-z_][A-Za-z0-9_]*)\}"),
    re.compile(r"env\.([A-Z][A-Z0-9_]{2,})"),
)

#: 明显不是 dsh 相关、也不是环境变量的通用变量名，扫描时忽略。
ENV_NAME_IGNORE = {"PATH", "HOME", "TMP", "TEMP", "SHELL", "PWD", "USER", "OS", "LANG"}


# --------------------------------------------------------------------------
# 基础工具
# --------------------------------------------------------------------------

def log(*parts) -> None:
    print(*parts, flush=True)


def warn(msg: str) -> None:
    print(f"warn: {msg}", file=sys.stderr, flush=True)


def die(msg: str, code: int = 1):
    print(f"error: {msg}", file=sys.stderr, flush=True)
    sys.exit(code)


def resolve_dsh_home(cli_value: str | None = None) -> Path:
    """显式参数 > $DSH_HOME（非空白）> ~/.dsh，与 dsh-home-paths 的优先级一致。"""
    if cli_value:
        return Path(cli_value).expanduser().resolve()
    env = os.environ.get("DSH_HOME")
    if env and env.strip():
        return Path(env.strip()).expanduser().resolve()
    return (Path.home() / ".dsh").resolve()


def resolve_agents_home() -> Path:
    env = os.environ.get("DSH_AGENTS_HOME")
    if env and env.strip():
        return Path(env.strip()).expanduser().resolve()
    return (Path.home() / ".agents").resolve()


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def now_stamp() -> str:
    return datetime.now().strftime("%Y%m%d-%H%M%S")


def iso_now() -> str:
    return datetime.now(timezone.utc).astimezone().isoformat(timespec="seconds")


def dsh_version() -> str:
    exe = which_dsh()
    if not exe:
        return "unknown"
    try:
        out = subprocess.run(_cmd_wrap(exe, ["--version"]), capture_output=True, text=True, timeout=60)
        return (out.stdout or out.stderr).strip().splitlines()[0] if (out.stdout or out.stderr).strip() else "unknown"
    except Exception:
        return "unknown"


def which_dsh() -> str | None:
    return shutil.which("dsh") or shutil.which("dsh.cmd") or shutil.which("dsh.exe")


def which_pnpm() -> str | None:
    return shutil.which("pnpm") or shutil.which("pnpm.cmd") or shutil.which("pnpm.exe")


def _cmd_wrap(exe: str, args: list[str]) -> list[str]:
    """Windows 上 .cmd/.bat 需要通过 cmd.exe 启动。"""
    if os.name == "nt" and exe.lower().endswith((".cmd", ".bat")):
        return ["cmd.exe", "/c", exe, *args]
    return [exe, *args]


def run(exe: str, args: list[str], cwd: Path | None = None, env: dict | None = None,
        timeout: int = 900) -> tuple[int, str]:
    full = _cmd_wrap(exe, args)
    try:
        # stdin=DEVNULL：pnpm 的 approve-builds 等子命令在缺少 TTY 时会退化成交互式
        # 提问，若继承父进程 stdin 就会无限期等待输入（表现为「脚本卡死」）。关掉
        # stdin 让它直接失败，再由调用方按退出码处理。
        p = subprocess.run(full, cwd=str(cwd) if cwd else None, env=env,
                           stdin=subprocess.DEVNULL,
                           capture_output=True, text=True, timeout=timeout)
        return p.returncode, (p.stdout or "") + (p.stderr or "")
    except subprocess.TimeoutExpired:
        return 124, f"timeout after {timeout}s: {' '.join(full)}"
    except FileNotFoundError as e:
        return 127, f"not found: {e}"


# --------------------------------------------------------------------------
# 分类
# --------------------------------------------------------------------------

def is_sensitive_file(name: str) -> bool:
    low = name.lower()
    if low in SENSITIVE_FILES:
        return True
    if low.endswith(SENSITIVE_SUFFIXES):
        return True
    return any(h in low for h in SENSITIVE_HINTS)


def npmrc_has_credentials(path: Path) -> bool:
    """profile 的 .npmrc 可能带 _authToken / _password，那种也算凭证。"""
    try:
        text = path.read_text(encoding="utf-8", errors="ignore")
    except OSError:
        return False
    low = text.lower()
    return "_authtoken" in low or "_password" in low or "_auth " in low or ":_auth=" in low


def is_rebuildable_file(name: str, opts) -> bool:
    low = name.lower()
    if low in REBUILDABLE_FILES:
        return not opts.with_lockfiles
    return low.endswith(REBUILDABLE_SUFFIXES)


class ExportOptions:
    def __init__(self, with_lockfiles=False, with_secrets=False, with_data=False,
                 strict=False, with_agents=False, extra_exclude=None):
        self.with_lockfiles = with_lockfiles
        self.with_secrets = with_secrets
        self.with_data = with_data
        self.strict = strict
        self.with_agents = with_agents
        self.extra_exclude = extra_exclude or []


def _excluded_by_user(rel: str, opts: ExportOptions) -> bool:
    return any(fnmatch.fnmatch(rel, pat) or fnmatch.fnmatch("/" + rel, pat)
               for pat in opts.extra_exclude)


def known_at(rel: str) -> bool:
    """rel 是否是「已知的 dsh 配置」，否则算「推断的插件配置」。"""
    parts = rel.split("/")
    if len(parts) == 1:
        return parts[0] in KNOWN_ROOT_FILES
    if parts[0] in KNOWN_ROOT_DIRS or parts[0] in (".agent-presets",):
        return True
    if parts[0] == PROFILES_DIR and len(parts) == 3 and parts[2] in PROFILE_CONFIG_FILES:
        return True
    return False


def collect(home: Path, opts: ExportOptions):
    """遍历 $DSH_HOME，返回 (entries, skipped)。

    entries: [{"rel","size","sha256","known"}]；skipped: {类别: [rel, ...]}
    """
    entries: list[dict] = []
    skipped: dict[str, list[str]] = {"rebuildable": [], "sensitive": [], "data": [], "user-excluded": []}

    def add_file(f: Path, rel: str) -> None:
        if _excluded_by_user(rel, opts):
            skipped["user-excluded"].append(rel)
            return
        name = f.name
        if is_rebuildable_file(name, opts):
            skipped["rebuildable"].append(rel)
            return
        if not opts.with_secrets and is_sensitive_file(name):
            skipped["sensitive"].append(rel)
            return
        if not opts.with_secrets and name.lower() == ".npmrc" and npmrc_has_credentials(f):
            skipped["sensitive"].append(rel + " (含 _authToken)")
            return
        try:
            size = f.stat().st_size
        except OSError:
            return
        entries.append({"rel": rel, "size": size, "sha256": sha256_of(f), "known": known_at(rel)})

    def walk(d: Path, prefix: str, depth: int) -> None:
        try:
            children = sorted(d.iterdir(), key=lambda p: p.name)
        except OSError as e:
            warn(f"无法读取 {d}: {e}")
            return
        for child in children:
            rel = f"{prefix}/{child.name}" if prefix else child.name
            if child.is_dir() and not child.is_symlink():
                if child.name in REBUILDABLE_DIRS:
                    skipped["rebuildable"].append(rel + "/")
                    continue
                if child.name in DATA_DIRS:
                    if opts.with_data:
                        walk(child, rel, depth + 1)
                    else:
                        skipped["data"].append(rel + "/")
                    continue
                if _excluded_by_user(rel, opts):
                    skipped["user-excluded"].append(rel + "/")
                    continue
                # 推断模式（--strict）下，只走已知目录。
                if opts.strict and depth == 0 and child.name not in KNOWN_ROOT_DIRS and child.name != PROFILES_DIR:
                    if not (child.name.startswith(".agent")):
                        skipped["user-excluded"].append(rel + "/ (strict)")
                        continue
                walk(child, rel, depth + 1)
            elif child.is_file():
                add_file(child, rel)

    walk(home, "", 0)
    entries.sort(key=lambda e: e["rel"])
    return entries, skipped


def scan_env_refs(files: list[tuple[Path, str]]) -> list[str]:
    """从配置文件文本里扫出被引用的环境变量名。"""
    names: set[str] = set()
    for path, _rel in files:
        try:
            text = path.read_text(encoding="utf-8", errors="ignore")
        except OSError:
            continue
        for pat in ENV_REF_PATTERNS:
            for m in pat.finditer(text):
                for g in m.groups():
                    if not g or not g[0].isalpha() or len(g) < 3:
                        continue
                    if not re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", g):
                        continue
                    if g.upper() in ENV_NAME_IGNORE or g.endswith("Env"):
                        continue
                    names.add(g)
        if path.name == "package.json":
            try:
                doc = json.loads(text)
            except Exception:
                continue
            for key in ("dsh",):
                _collect_json_env(doc.get(key), names)
    return sorted(names)


def _collect_json_env(node, names: set) -> None:
    if isinstance(node, dict):
        for k, v in node.items():
            if isinstance(v, str) and ("apiKeyEnv" in k or k.endswith("Env")):
                if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", v):
                    names.add(v)
            else:
                _collect_json_env(v, names)
    elif isinstance(node, list):
        for it in node:
            _collect_json_env(it, names)


def profile_summary(home: Path) -> list[dict]:
    out = []
    pdir = home / PROFILES_DIR
    if not pdir.is_dir():
        return out
    for d in sorted(pdir.iterdir()):
        if not d.is_dir() or d.name in ("node_modules",):
            continue
        pkg = d / "package.json"
        info = {"name": d.name, "manifest": pkg.exists(), "bundles": [], "dependencies": {},
                "hasPatch": (d / "cordis.patch.yml").exists(),
                "hasWorkspace": (d / "pnpm-workspace.yaml").exists(),
                "nodeModules": (d / "node_modules").is_dir()}
        if pkg.exists():
            try:
                doc = json.loads(pkg.read_text(encoding="utf-8"))
                prof = (doc.get("dsh") or {}).get("profile") or {}
                info["bundles"] = prof.get("bundles") or []
                info["dependencies"] = sorted((doc.get("dependencies") or {}).keys())
            except Exception as e:
                info["manifestError"] = str(e)
        out.append(info)
    return out


# --------------------------------------------------------------------------
# export
# --------------------------------------------------------------------------

def cmd_export(args) -> int:
    home = resolve_dsh_home(args.home)
    if not home.is_dir():
        die(f"DSH_HOME 不存在: {home}")

    opts = ExportOptions(with_lockfiles=args.with_lockfiles, with_secrets=args.with_secrets,
                         with_data=args.with_data, strict=args.strict,
                         with_agents=args.with_agents,
                         extra_exclude=args.exclude or [])
    entries, skipped = collect(home, opts)

    # 收集待扫描环境变量引用的文件（本地路径）
    scan_targets: list[tuple[Path, str]] = []
    for e in entries:
        if e["rel"].endswith((".yaml", ".yml", ".json")):
            p = home / e["rel"]
            if p.is_file():
                scan_targets.append((p, e["rel"]))
    env_refs = scan_env_refs(scan_targets)

    agents_entries: list[dict] = []
    if opts.with_agents:
        ah = resolve_agents_home()
        skills = ah / "skills"
        if skills.is_dir():
            for f in sorted(skills.rglob("*")):
                if f.is_file() and "node_modules" not in f.parts:
                    rel = f.relative_to(ah).as_posix()
                    if _excluded_by_user(rel, opts) or is_sensitive_file(f.name):
                        skipped["sensitive"].append(f"agents:{rel}")
                        continue
                    agents_entries.append({"rel": rel, "size": f.stat().st_size,
                                           "sha256": sha256_of(f), "known": True})

    profiles = profile_summary(home)
    manifest = {
        "tool": TOOL,
        "formatVersion": FORMAT_VERSION,
        "createdAt": iso_now(),
        "host": {
            "os": platform.platform(),
            "python": platform.python_version(),
            "dshHome": str(home),
            "agentsHome": str(resolve_agents_home()) if opts.with_agents else None,
        },
        "dsh": {"version": dsh_version(), "cli": which_dsh()},
        "profiles": profiles,
        "envVarsReferenced": env_refs,
        "fileCount": len(entries) + len(agents_entries),
        "totalBytes": sum(e["size"] for e in entries) + sum(e["size"] for e in agents_entries),
        "files": entries,
        "agentsFiles": agents_entries,
        "excluded": {k: v for k, v in skipped.items() if v},
        "inferredFiles": [e["rel"] for e in entries if not e["known"]],
        "notes": [
            "导入后必须执行 pnpm install 补全依赖（导出不含 node_modules）。",
            "环境变量不在本包内，请用 yashi-dsh-env-sync 的 ini 恢复。",
            "凭证（.credentials.yaml / credentials.json / *_authToken）不在本包内，导入后重新登录。",
            "运行时数据（sessions/storages/attachments 等）不在本包内。",
        ],
    }

    if args.print or args.dry_run:
        log(f"DSH_HOME : {home}")
        log(f"dsh      : {manifest['dsh']['version']}")
        log(f"profiles : {', '.join(p['name'] for p in profiles) or '(none)'}")
        log(f"环境变量引用: {', '.join(env_refs) or '(none)'}")
        log("")
        log(f"将导出 {len(entries) + len(agents_entries)} 个文件"
            f"（{manifest['totalBytes']} bytes）：")
        for e in entries:
            tag = "  " if e["known"] else "* "
            log(f"  {tag}{e['rel']}")
        for e in agents_entries:
            log(f"   agents:{e['rel']}")
        log("")
        if manifest["inferredFiles"]:
            log(f"* = 自动推断的插件/未知配置（{len(manifest['inferredFiles'])} 个），"
                f"如不需要可用 --exclude 排除")
        for k, v in manifest["excluded"].items():
            log(f"排除[{k}]: {len(v)} 项")
        if args.print or args.dry_run:
            return 0

    out = Path(args.output).expanduser() if args.output else \
        Path.home() / f"dsh-config-export-{now_stamp()}.zip"
    out.parent.mkdir(parents=True, exist_ok=True)

    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED, compresslevel=9) as zf:
        zf.writestr("manifest.json", json.dumps(manifest, ensure_ascii=False, indent=2))
        for e in entries:
            zf.write(home / e["rel"], HOME_PREFIX + e["rel"])
        if agents_entries:
            ah = resolve_agents_home()
            for e in agents_entries:
                zf.write(ah / e["rel"], "agents-home/" + e["rel"])

    size = out.stat().st_size
    log(f"✅ 导出完成: {out}")
    log(f"   文件 {len(entries) + len(agents_entries)} 个，压缩包 {size} bytes")
    log(f"   dsh {manifest['dsh']['version']} | profiles: "
        f"{', '.join(p['name'] for p in profiles) or '(none)'}")
    if env_refs:
        log(f"   引用的环境变量（未导出，需 yashi-dsh-env-sync 恢复）: {', '.join(env_refs)}")
    if not opts.with_agents:
        log("   提示: 未包含 ~/.agents/skills（如需一并迁移请加 --with-agents）")
    return 0


# --------------------------------------------------------------------------
# inspect
# --------------------------------------------------------------------------

def load_archive(path: Path) -> tuple[zipfile.ZipFile, dict]:
    if not path.is_file():
        die(f"找不到导入包: {path}")
    try:
        zf = zipfile.ZipFile(path)
    except zipfile.BadZipFile as e:
        die(f"不是有效的 zip 包: {e}")
    try:
        manifest = json.loads(zf.read("manifest.json").decode("utf-8"))
    except KeyError:
        die("包内缺少 manifest.json（不是 yashi-dsh-config-sync 导出的包？）")
    return zf, manifest


def cmd_inspect(args) -> int:
    zf, m = load_archive(Path(args.input).expanduser())
    log(f"包      : {Path(args.input).expanduser()}")
    log(f"工具    : {m.get('tool')} (format v{m.get('formatVersion')})")
    log(f"导出时间: {m.get('createdAt')}")
    log(f"来源机器: {m.get('host', {}).get('os')} | DSH_HOME {m.get('host', {}).get('dshHome')}")
    log(f"dsh 版本: {m.get('dsh', {}).get('version')}")
    log("")
    log("profiles:")
    for p in m.get("profiles", []):
        deps = p.get("dependencies") or []
        log(f"  - {p['name']}: bundles={p.get('bundles')} deps={len(deps)}")
        for d in deps:
            log(f"      · {d}")
    log("")
    log(f"文件 {m.get('fileCount')} 个（{m.get('totalBytes')} bytes）:")
    for e in m.get("files", []):
        log(f"  {' ' if e.get('known') else '*'} {e['rel']} ({e['size']}B)")
    if m.get("agentsFiles"):
        log(f"~/.agents 文件 {len(m['agentsFiles'])} 个")
    if m.get("envVarsReferenced"):
        log("")
        log(f"引用的环境变量（包内不含值）: {', '.join(m['envVarsReferenced'])}")
    if m.get("excluded"):
        log("")
        log("导出时排除:")
        for k, v in m["excluded"].items():
            log(f"  {k}: {len(v)} 项")
    log("")
    log("包内实际条目:", len([n for n in zf.namelist() if not n.endswith('/')]))
    return 0


# --------------------------------------------------------------------------
# import
# --------------------------------------------------------------------------

def safe_extract(zf: zipfile.ZipFile, prefix: str, dest: Path) -> list[str]:
    """把 zip 中 prefix/ 下的条目解到 dest，防路径穿越。"""
    dest = dest.resolve()
    written = []
    for info in zf.infolist():
        if info.is_dir() or not info.filename.startswith(prefix):
            continue
        rel = info.filename[len(prefix):]
        if not rel:
            continue
        target = (dest / rel).resolve()
        if not str(target).startswith(str(dest)):
            warn(f"跳过可疑路径: {info.filename}")
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        with zf.open(info) as src, open(target, "wb") as dst:
            shutil.copyfileobj(src, dst)
        written.append(rel)
    return written


#: pnpm 生成 allowBuilds 段时留下的占位文本（要求用户手工改成布尔值）。
ALLOWBUILDS_PLACEHOLDER = "set this to true or false"

#: allowBuilds 段落内唯一合法的两种取值。
BOOL_LITERALS = {"true", "false"}


def repair_allow_builds(profile_dir: Path) -> list[str]:
    """修正 pnpm-workspace.yaml 中 allowBuilds 的非法值，返回被修正的依赖名。

    背景：pnpm 首次生成 ``allowBuilds:`` 段时会给每个待批准依赖写入占位文本
    ``set this to true or false``。用户没手工改成布尔值时，该值既不是 true 也不是
    false，pnpm 11 会判定构建脚本「未经批准」，令 ``pnpm install`` 直接以
    ``ERR_PNPM_IGNORED_BUILDS`` 退出（exit=1）。导出包会把这份「半成品」配置原样
    带走，于是每次导入都会踩到同一个坑。

    这里把非法值一律视为「同意构建」（true），与同段落中其它已批准的依赖保持一致；
    修正只写回 pnpm-workspace.yaml，不改动 package.json。返回被改写的依赖名列表，
    空列表表示无需修正（文件不存在、或取值已合法）。
    """
    ws = profile_dir / "pnpm-workspace.yaml"
    if not ws.is_file():
        return []
    try:
        # keepends=True 保留原换行与缩进，尽量做「最小改写」而不是重排 YAML。
        lines = ws.read_text(encoding="utf-8").splitlines(keepends=True)
    except OSError:
        return []

    fixed: list[str] = []
    in_block = False
    block_indent = 0
    for i, raw in enumerate(lines):
        stripped = raw.strip()
        if not stripped or stripped.startswith("#"):
            continue
        indent = len(raw) - len(raw.lstrip())
        # 缩进回退到 allowBuilds 同级或更浅 → 段落结束。
        if in_block and indent <= block_indent:
            in_block = False
        if stripped.startswith("allowBuilds:"):
            in_block = True
            block_indent = indent
            continue
        if not in_block or ":" not in stripped:
            continue
        key, _, value = stripped.partition(":")
        if value.strip().strip("'\"").lower() in BOOL_LITERALS:
            continue
        head, sep, _tail = raw.partition(":")
        eol = "\n" if raw.endswith("\n") else ""
        lines[i] = head + sep + " true" + eol
        fixed.append(key.strip().strip("'\""))

    if fixed:
        try:
            ws.write_text("".join(lines), encoding="utf-8")
        except OSError:
            return []
    return fixed


#: profile 里的 pnpm.cmd 是导出时留下的包装器（形如 ``call "C:\npm\pnpm.cmd" %*``）。
#: cmd.exe 会优先命中当前目录的同名文件，所以如果该绝对路径在换机器 / pnpm 搬迁后
#: 失效，dsh 在 profile 目录里调 pnpm 就会直接「找不到命令」。
PNPM_WRAPPER_RE = re.compile(r'([A-Za-z]:[\\/][^"\r\n]*?pnpm\.cmd)', re.IGNORECASE)


def check_pnpm_wrappers(home: Path) -> list[dict]:
    """检查各 profile 的 pnpm.cmd 指向是否存在，返回坏掉的包装器信息。

    每项形如 ``{"profile", "wrapper", "target", "pnpm"}``：target 是包装器里写死的
    pnpm 路径，pnpm 是本机实际可用的 pnpm（用于给出修复建议）。指向有效的包装器
    不会出现在结果里。
    """
    bad: list[dict] = []
    pdir = home / PROFILES_DIR
    if not pdir.is_dir():
        return bad
    for d in sorted(pdir.iterdir()):
        wrapper = d / "pnpm.cmd"
        if not d.is_dir() or not wrapper.is_file():
            continue
        try:
            text = wrapper.read_text(encoding="utf-8", errors="ignore")
        except OSError:
            continue
        m = PNPM_WRAPPER_RE.search(text)
        if not m or Path(m.group(1)).is_file():
            continue
        bad.append({"profile": d.name, "wrapper": str(wrapper),
                    "target": m.group(1), "pnpm": which_pnpm()})
    return bad


def wrapper_fix_tips(bad: list[dict]) -> list[str]:
    """把 check_pnpm_wrappers 的结果翻译成可直接执行的修复命令。"""
    tips: list[str] = []
    for item in bad:
        line = f"profiles/{item['profile']}/pnpm.cmd 指向不存在的 {item['target']}"
        real = item.get("pnpm")
        if real:
            line += f"（本机实际 pnpm: {real}）"
        tips.append(line)
        missing_dir = str(Path(item["target"]).parent)
        real_dir = str(Path(real).parent) if real else None
        if real_dir and real_dir != missing_dir:
            tips.append(f'修复：cmd.exe 执行 mklink /J "{missing_dir}" "{real_dir}"'
                        f'（junction 不需要管理员权限），或把 pnpm.cmd 里的路径改成 {real}')
        else:
            tips.append("修复：把 pnpm.cmd 里的路径改成本机真实的 pnpm 路径。")
    return tips


def install_profiles(home: Path, proxy: str | None = None, timeout: int = 1800) -> list[dict]:
    """逐 profile 补全依赖：pnpm install → approve-builds --all →（必要时）rebuild。"""
    pdir = home / PROFILES_DIR
    results: list[dict] = []
    pnpm = which_pnpm()
    env = os.environ.copy()
    if proxy:
        for k in ("HTTP_PROXY", "HTTPS_PROXY", "ALL_PROXY",
                  "http_proxy", "https_proxy", "all_proxy"):
            env[k] = proxy
        env["NO_PROXY"] = env.get("NO_PROXY", "127.0.0.1,localhost")
    if not pdir.is_dir():
        return results
    for d in sorted(pdir.iterdir()):
        if not d.is_dir() or d.name == "node_modules":
            continue
        if not (d / "package.json").exists():
            continue
        rec = {"profile": d.name, "dir": str(d), "install": None, "approve": None, "rebuild": None}
        if not pnpm:
            rec["install"] = {"exit": 127, "output": "pnpm 未找到；可改用 dsh plugin --profile <name> install"}
            results.append(rec)
            continue
        log(f"  → pnpm install @ {d}")
        fixed = repair_allow_builds(d)
        if fixed:
            rec["allowBuildsRepaired"] = fixed
            log(f"     ⚠️ 已自动修正 pnpm-workspace.yaml 的 allowBuilds 非法值: "
                f"{', '.join(fixed)} → true")
        code, out = run(pnpm, ["install"], cwd=d, env=env, timeout=timeout)
        # 兜底：pnpm 11 遇到「未批准的构建脚本」会以 ERR_PNPM_IGNORED_BUILDS 退出。
        # repair_allow_builds 已覆盖常见情形，这里再补跑一次 approve-builds 重装，
        # 应对 allowBuilds 段落缺失、或依赖自带 issue 等其它情况。
        if code != 0 and "IGNORED_BUILDS" in out:
            log(f"     ⚠️ {d.name}: 构建脚本未获批准，尝试 approve-builds --all 后重装…")
            run(pnpm, ["approve-builds", "--all"], cwd=d, env=env, timeout=600)
            code, out = run(pnpm, ["install"], cwd=d, env=env, timeout=timeout)
        rec["install"] = {"exit": code, "output": out}
        if code == 0:
            code2, out2 = run(pnpm, ["approve-builds", "--all"], cwd=d, env=env, timeout=600)
            rec["approve"] = {"exit": code2, "output": out2}
            if code2 == 0 and "no packages awaiting approval" not in out2.lower():
                log(f"  → 已批准原生模块构建，重跑 pnpm rebuild @ {d.name}")
                code3, out3 = run(pnpm, ["rebuild"], cwd=d, env=env, timeout=timeout)
                rec["rebuild"] = {"exit": code3, "output": out3}
        results.append(rec)
    return results


URL_RE = re.compile(r"http://[0-9a-zA-Z\.\-]+:(\d+)/\?token=([A-Za-z0-9_\-]+)")


def http_status(url: str, timeout: int = 10) -> int:
    class NoRedirect(urllib.request.HTTPRedirectHandler):
        def redirect_request(self, *a, **k):
            return None

    opener = urllib.request.build_opener(NoRedirect)
    try:
        with opener.open(urllib.request.Request(url, method="GET"), timeout=timeout) as r:
            return r.status
    except urllib.error.HTTPError as e:
        return e.code
    except Exception:
        return 0


def kill_tree(pid: int) -> None:
    """强杀一棵进程树（Windows: taskkill /T；POSIX: killpg）。"""
    if os.name == "nt":
        subprocess.run(["taskkill", "/F", "/T", "/PID", str(pid)],
                       capture_output=True, text=True)
    else:
        try:
            os.killpg(os.getpgid(pid), 9)
        except Exception:
            try:
                os.kill(pid, 9)
            except Exception:
                pass


def kill_pid(pid: int) -> None:
    if os.name == "nt":
        subprocess.run(["taskkill", "/F", "/PID", str(pid)], capture_output=True, text=True)
    else:
        try:
            os.kill(pid, 9)
        except Exception:
            pass


def port_open(port: int, host: str = "127.0.0.1") -> bool:
    if not port:
        return False
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.settimeout(1.0)
        return s.connect_ex((host, port)) == 0


def listener_pids(port: int) -> list[int]:
    """返回正在 LISTEN 该端口的 PID（Windows 用 netstat，其他用 lsof）。"""
    pids: list[int] = []
    try:
        if os.name == "nt":
            out = subprocess.run(["netstat", "-ano", "-p", "TCP"], capture_output=True,
                                 text=True, timeout=60).stdout
            for line in out.splitlines():
                parts = line.split()
                if len(parts) >= 5 and parts[3].upper() == "LISTENING" and parts[1].endswith(f":{port}"):
                    try:
                        pids.append(int(parts[4]))
                    except ValueError:
                        pass
        else:
            out = subprocess.run(["lsof", "-ti", f"tcp:{port}", "-sTCP:LISTEN"],
                                 capture_output=True, text=True, timeout=60).stdout
            pids = [int(x) for x in out.split() if x.strip().isdigit()]
    except Exception:
        pass
    return sorted(set(pids))


def stop_web(proc: subprocess.Popen, port: int) -> dict:
    """停止测试服务并确认端口释放。

    关键点：Windows 上 ``dsh`` 是 ``dsh.cmd``，node 是它的**孙进程**；
    只 terminate 包装器会留下孤儿 node 继续占用端口。所以先整棵树强杀，
    再用端口反查兜底。
    """
    info = {"stopped": False, "orphanPids": [], "portReleased": None}
    if proc.poll() is None:
        kill_tree(proc.pid)          # 趁 cmd.exe 还活着，一次带走整棵树
    try:
        proc.wait(timeout=15)
    except Exception:
        pass
    if port:
        deadline = time.time() + 10
        while time.time() < deadline and port_open(port):
            time.sleep(0.5)
        if port_open(port):
            for pid in listener_pids(port):
                info["orphanPids"].append(pid)
                kill_pid(pid)
            time.sleep(1)
        info["portReleased"] = not port_open(port)
    info["stopped"] = proc.poll() is not None and (info["portReleased"] is not False)
    return info


def start_and_test_web(home: Path, port: int, wait: int = 60,
                       proxy: str | None = None) -> dict:
    """启动 dsh web，验证端口与 HTTP，然后确保停止。返回诊断 dict。"""
    exe = which_dsh()
    if not exe:
        return {"ok": False, "stage": "locate", "error": "找不到 dsh 可执行文件（PATH 中没有 dsh）"}

    probe = port
    if probe:
        # 端口被占用则让 OS 选
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            try:
                s.bind(("127.0.0.1", probe))
            except OSError:
                warn(f"端口 {probe} 被占用，改用系统分配端口")
                probe = 0

    logfile = Path(os.environ.get("TEMP", "/tmp")) / f"dsh-config-sync-web-{now_stamp()}.log"
    env = os.environ.copy()
    env["DSH_HOME"] = str(home)
    home.mkdir(parents=True, exist_ok=True)
    if proxy:
        for k in ("HTTP_PROXY", "HTTPS_PROXY", "ALL_PROXY",
                  "http_proxy", "https_proxy", "all_proxy"):
            env[k] = proxy

    log(f"  → 启动 dsh web (DSH_HOME={home}, port={probe or 'auto'})")
    creationflags = 0
    kwargs = {}
    if os.name == "nt":
        creationflags = subprocess.CREATE_NEW_PROCESS_GROUP
    else:
        kwargs["start_new_session"] = True

    with open(logfile, "w+", encoding="utf-8", errors="replace") as fh:
        proc = subprocess.Popen(_cmd_wrap(exe, ["web", "--port", str(probe), "--no-open"]),
                                cwd=str(home), env=env, stdout=fh, stderr=subprocess.STDOUT,
                                creationflags=creationflags, **kwargs)
        result = {"ok": False, "pid": proc.pid, "port": probe, "log": str(logfile)}
        deadline = time.time() + wait
        url = token = None
        while time.time() < deadline:
            if proc.poll() is not None:
                break
            fh.flush()
            try:
                text = logfile.read_text(encoding="utf-8", errors="replace")
            except OSError:
                text = ""
            m = URL_RE.search(text)
            if m:
                url, token = m.group(0), m.group(2)
                result["port"] = int(m.group(1))
                break
            time.sleep(0.5)
        fh.flush()
        text = logfile.read_text(encoding="utf-8", errors="replace") if logfile.exists() else ""
        result["output"] = text.strip()

        if not url:
            result["stage"] = "startup"
            result["error"] = "启动超时或进程提前退出，未打印带 token 的 URL"
        else:
            base = f"http://127.0.0.1:{result['port']}/"
            code_no = http_status(base)
            code_yes = http_status(f"{base}?token={token}")
            result.update({"url": url, "httpNoToken": code_no, "httpWithToken": code_yes,
                           "stage": "http"})
            result["ok"] = code_no in (401, 403) and code_yes in (200, 302, 303)

        # 停止：整棵树强杀 + 端口兜底（见 stop_web 的说明）
        result.update(stop_web(proc, result.get("port") or 0))
    try:
        logfile.unlink()
    except OSError:
        pass
    return result


def diagnose(result: dict) -> list[str]:
    """把启动失败翻译成可执行的排障建议。"""
    out = (result.get("output") or "")
    tips = []
    if "does not provide an export named" in out or "SyntaxError" in out:
        m = re.search(r"Cannot find package '([^']+)'|from '([^']+)'|does not provide an export named '([^']+)'", out)
        tips.append("侦测到 ESM 导出/语法错误 → 多半是某个插件与新版 core 不兼容。"
                    "按 yashi-dsh-update 的「问题插件」流程在 profiles/<name>/cordis.patch.yml 里 "
                    "`- id: <plugin>` + `disabled: true` 临时禁用后重测。")
    if "Cannot find module" in out or "ERR_MODULE_NOT_FOUND" in out:
        tips.append("侦测到缺模块 → 依赖没装全：在对应 profile 目录重跑 `pnpm install`，"
                    "并确认 `pnpm approve-builds --all`（原生模块需要编译）。")
    if "EADDRINUSE" in out:
        tips.append("端口被占用 → 换端口或先结束占用进程。")
    if "no such file" in out.lower() or "ENOENT" in out:
        tips.append("缺文件 → 检查 settings.yaml / cordis.patch.yml 是否被完整还原。")
    if not tips:
        tips.append("查看上方日志；常见根因见 SKILL.md 的「常见坑」表。")
    return tips


def cmd_import(args) -> int:
    src = Path(args.input).expanduser()
    zf, manifest = load_archive(src)
    target = resolve_dsh_home(args.home)

    files = [n for n in zf.namelist() if n.startswith(HOME_PREFIX) and not n.endswith("/")]
    agents = [n for n in zf.namelist() if n.startswith("agents-home/") and not n.endswith("/")]

    log(f"导入源  : {src}")
    log(f"来源 dsh: {manifest.get('dsh', {}).get('version')}  ({manifest.get('createdAt')})")
    log(f"目标    : {target}")
    log(f"包内容  : dsh-home {len(files)} 个文件"
        + (f"，agents-home {len(agents)} 个文件" if agents else ""))
    log("")
    log("profiles:")
    for p in manifest.get("profiles", []):
        log(f"  - {p['name']}: bundles={p.get('bundles')} deps={len(p.get('dependencies') or [])}")
    if manifest.get("envVarsReferenced"):
        log("")
        log(f"⚠️  包内不含环境变量，导入后请用 yashi-dsh-env-sync 恢复: "
            f"{', '.join(manifest['envVarsReferenced'])}")

    if args.dry_run:
        log("")
        log("（--dry-run：以下为将写入的文件，未做任何修改）")
        for n in files:
            log(f"  {n}")
        return 0

    target.mkdir(parents=True, exist_ok=True)

    # 1) 备份将被覆盖的文件
    backup = Path.home() / f"dsh-config-backup-{now_stamp()}"
    backed = 0
    for n in files:
        rel = n[len(HOME_PREFIX):]
        existing = target / rel
        if existing.is_file():
            b = backup / HOME_PREFIX / rel
            b.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(existing, b)
            backed += 1
    if backed:
        log(f"① 已备份 {backed} 个将被覆盖的文件 → {backup}")

    # 2) 还原
    written = safe_extract(zf, HOME_PREFIX, target)
    log(f"② 已还原 {len(written)} 个文件 → {target}")
    if agents:
        ah = resolve_agents_home()
        aw = safe_extract(zf, "agents-home/", ah)
        log(f"   已还原 {len(aw)} 个 ~/.agents 文件 → {ah}")

    report: dict = {"manifest": manifest, "restored": written, "backup": str(backup) if backed else None}

    # 2.5) profile 的 pnpm.cmd 包装器指向检查（导出包会带上原机器的绝对路径）
    bad_wrappers = check_pnpm_wrappers(target)
    if bad_wrappers:
        report["pnpmWrappers"] = bad_wrappers
        log("   ⚠️ 发现失效的 pnpm.cmd 包装器：")
        for tip in wrapper_fix_tips(bad_wrappers):
            log(f"      {tip}")

    # 3) 补全依赖
    if args.no_install:
        log("③ 跳过依赖安装（--no-install）")
    else:
        log("③ 补全各 profile 依赖 (pnpm install + approve-builds)…")
        installs = install_profiles(target, proxy=args.proxy)
        report["installs"] = installs
        for rec in installs:
            st = (rec.get("install") or {}).get("exit")
            log(f"   {rec['profile']}: pnpm install exit={st}")
            if st not in (0, None):
                tail = "\n".join(((rec.get("install") or {}).get("output") or "").strip().splitlines()[-8:])
                log(f"      {tail}")
        bad = [r["profile"] for r in installs if (r.get("install") or {}).get("exit") not in (0,)]
        if bad:
            log(f"   ⚠️ 安装失败: {', '.join(bad)} → 检查网络/代理，或 git 依赖改用 HTTPS：")
            log('      git config --global url."https://github.com/".insteadOf "git@github.com:"')

    # 4) 实测启动
    if args.no_test:
        log("④ 跳过启动测试（--no-test）")
        return 0

    log("④ 实测 dsh web 启动/停止…")
    res = start_and_test_web(target, args.port, wait=args.wait, proxy=args.proxy)
    report["webTest"] = res
    if res.get("ok"):
        log(f"   ✅ 启动成功 http://127.0.0.1:{res['port']}/")
        log(f"      无 token → {res.get('httpNoToken')}，带 token → {res.get('httpWithToken')}")
    else:
        log(f"   ❌ 启动失败（stage={res.get('stage')}）")
        if res.get("output"):
            log("   ---- 日志尾部 ----")
            for line in res["output"].splitlines()[-25:]:
                log(f"   {line}")
            log("   ------------------")
        for t in diagnose(res):
            log(f"   💡 {t}")
    stop_note = f"   测试进程已停止: {res.get('stopped')}"
    if res.get("orphanPids"):
        stop_note += f"（另清理孤儿进程 {res['orphanPids']}）"
    if res.get("portReleased") is not None:
        stop_note += f"，端口已释放: {res.get('portReleased')}"
    log(stop_note)
    return 0 if res.get("ok") else 1


def cmd_test(args) -> int:
    home = resolve_dsh_home(args.home)
    log(f"DSH_HOME: {home}")
    # 先提示失效的 pnpm.cmd 包装器：它会让 dsh 在 profile 目录里调不到 pnpm，
    # 表现为插件装不上 / 启动报「找不到命令」，容易被误判成别的问题。
    for tip in wrapper_fix_tips(check_pnpm_wrappers(home)):
        log(f"⚠️ {tip}")
    res = start_and_test_web(home, args.port, wait=args.wait, proxy=args.proxy)
    if res.get("ok"):
        log(f"✅ dsh web 启动/停止正常 http://127.0.0.1:{res['port']}/"
            f" (no-token {res.get('httpNoToken')}, token {res.get('httpWithToken')})")
        return 0
    log(f"❌ 启动失败: stage={res.get('stage')} {res.get('error') or ''}")
    if res.get("output"):
        for line in res["output"].splitlines()[-25:]:
            log(f"   {line}")
    for t in diagnose(res):
        log(f"💡 {t}")
    return 1


# --------------------------------------------------------------------------
# CLI
# --------------------------------------------------------------------------

def main() -> int:
    ap = argparse.ArgumentParser(
        prog="dsh_config_sync.py",
        description="DeepSeek Harness（dsh）配置一句话导入/导出")
    sub = ap.add_subparsers(dest="cmd", required=True)

    pe = sub.add_parser("export", help="导出 dsh 配置为 zip")
    pe.add_argument("-o", "--output", help="输出 zip 路径（默认 ~/dsh-config-export-<时间>.zip）")
    pe.add_argument("--home", help="覆盖 $DSH_HOME")
    pe.add_argument("--print", action="store_true", help="只打印导出计划，不写文件")
    pe.add_argument("--dry-run", action="store_true", help="同 --print")
    pe.add_argument("--with-lockfiles", action="store_true", help="包含 pnpm-lock.yaml")
    pe.add_argument("--with-secrets", action="store_true", help="包含凭证文件（危险）")
    pe.add_argument("--with-data", action="store_true", help="包含 sessions/storages 等运行数据")
    pe.add_argument("--with-agents", action="store_true", help="同时导出 ~/.agents/skills")
    pe.add_argument("--strict", action="store_true", help="只导出已知配置，不含推断的插件配置")
    pe.add_argument("--exclude", action="append", help="额外排除的 glob（可重复）")
    pe.set_defaults(func=cmd_export)

    pi = sub.add_parser("inspect", help="查看导出包内容")
    pi.add_argument("-i", "--input", required=True)
    pi.set_defaults(func=cmd_inspect)

    pm = sub.add_parser("import", help="导入 dsh 配置并自动补依赖、实测启动")
    pm.add_argument("-i", "--input", required=True)
    pm.add_argument("--home", help="覆盖 $DSH_HOME")
    pm.add_argument("--dry-run", action="store_true", help="只预览不写入")
    pm.add_argument("--no-install", action="store_true", help="跳过 pnpm install")
    pm.add_argument("--no-test", action="store_true", help="跳过 dsh web 启动测试")
    pm.add_argument("--port", type=int, default=3089, help="启动测试端口（默认 3089，0=自动）")
    pm.add_argument("--wait", type=int, default=60, help="启动等待秒数（默认 60）")
    pm.add_argument("--proxy", help="为安装/测试设置 HTTP(S)_PROXY")
    pm.set_defaults(func=cmd_import)

    pt = sub.add_parser("test", help="单独实测 dsh web 启动/停止")
    pt.add_argument("--home", help="覆盖 $DSH_HOME")
    pt.add_argument("--port", type=int, default=3089)
    pt.add_argument("--wait", type=int, default=60)
    pt.add_argument("--proxy")
    pt.set_defaults(func=cmd_test)

    args = ap.parse_args()
    return args.func(args) or 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("\n已中断", file=sys.stderr)
        sys.exit(130)
