#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
DeepSeek Harness 設定備份 / 還原工具。

詳細說明請參閱同目錄的 README.md。
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Sequence

# =============================================================================
# 常數
# =============================================================================

# DSH 主目錄（~/.dsh）根目錄下，固定要備份的設定檔。
ROOT_FILES: List[str] = [
    "settings.yaml",
    "dsh-ssh.json",
    "dsh-notifier.json",
    "pet.json",
    "skin-center-active.json",
    ".anonymous-user-id",
    "AGENTS.md",
]

# DSH 主目錄根目錄下，要整份遞迴備份的資料夾。
ROOT_DIRS: List[str] = [
    ".agent-presets",
]

# 存在才備份的選用檔案（例如使用者自訂的 .env）。
OPTIONAL_ROOT_FILES: List[str] = [
    ".env",
]

# profile 目錄中一律略過的副檔名（pnpm / node 產生的 shim 或執行檔）。
EXCLUDED_SUFFIXES: tuple[str, ...] = (".cmd", ".ps1", ".exe")

# 預設要匯出的環境變數名稱（只匯出「確實存在」的變數）。
DEFAULT_ENV_NAMES: List[str] = [
    "DEEPSEEK_API_KEY",
    "GEMINI_API_KEY",
    "MOONSHOT_API_KEY",
    "ARK_API_KEY",
    "DASHSCOPE_API_KEY",
    "BRAVE_API_KEY",
    "XAI_API_KEY",
    "OPENAI_API_KEY",
    "ANTHROPIC_API_KEY",
    "GOOGLE_DEVELOPER_KNOWLEDGE_API_KEY",
    "MYMCP_PROXY_SERVER",
    "HTTP_PROXY",
    "HTTPS_PROXY",
    "ALL_PROXY",
    "NO_PROXY",
]

# 在 settings.yaml 中宣告「環境變數名稱」的設定鍵，用來自動偵測要備份的變數。
_ENV_KEY_PATTERN = re.compile(
    r"^\s*(?:apiKeyEnv|keyEnv|tokenEnv)\s*:\s*([A-Za-z_][A-Za-z0-9_]*)\s*$",
    flags=re.MULTILINE,
)


# =============================================================================
# 路徑與列舉輔助
# =============================================================================

def resolve_dsh_home(env: Dict[str, str]) -> Path:
    """解析 DeepSeek Harness 主目錄：DSH_HOME 優先，否則用 ~/.dsh。"""
    override: str = env.get("DSH_HOME", "").strip()
    if override:
        return Path(override).expanduser()
    return Path.home() / ".dsh"


def list_profiles(home: Path) -> List[str]:
    """列出 DSH 主目錄下所有含 package.json 的 profile 名稱（依名稱排序）。"""
    profiles_dir: Path = home / "profiles"
    if not profiles_dir.is_dir():
        return []
    return sorted(
        p.name
        for p in profiles_dir.iterdir()
        if p.is_dir() and (p / "package.json").is_file()
    )


def detect_env_names_from_settings(settings_path: Path) -> List[str]:
    """從 settings.yaml 偵測 apiKeyEnv / keyEnv / tokenEnv 指定的變數名稱。"""
    if not settings_path.is_file():
        return []
    text: str = settings_path.read_text(encoding="utf-8", errors="replace")
    seen: set[str] = set()
    result: List[str] = []
    for name in _ENV_KEY_PATTERN.findall(text):
        if name not in seen:
            seen.add(name)
            result.append(name)
    return result


def read_user_env_vars() -> Dict[str, str]:
    """讀取「持久」的使用者環境變數。

    Windows 上讀取 HKEY_CURRENT_USER\\Environment（這正是 `setx` 與還原時
    `[Environment]::SetEnvironmentVariable(..., 'User')` 寫入的位置）。只依賴
    `os.environ` 會漏掉「本機登入後才用 setx 寫入、但當前程序樹尚未重新載入」
    的變數（例如各 API Key）。其他平台直接回傳 os.environ。
    """
    if os.name != "nt":
        return dict(os.environ)
    result: Dict[str, str] = {}
    try:
        import winreg  # Windows 專屬標準庫，延遲匯入以維持跨平台可匯入。

        with winreg.OpenKey(
            winreg.HKEY_CURRENT_USER, "Environment", 0, winreg.KEY_READ
        ) as key:
            index: int = 0
            while True:
                try:
                    name, value, _ = winreg.EnumValue(key, index)
                except OSError:
                    break
                if isinstance(value, str):
                    result[name] = value
                index += 1
    except OSError:
        # 登錄檔不可用時退回程序環境。
        return dict(os.environ)
    return result


# =============================================================================
# 匯出
# =============================================================================

def collect_env_vars(
    env: Dict[str, str],
    extra_names: Sequence[str],
    exclude_names: Sequence[str],
    settings_path: Path,
) -> Dict[str, str]:
    """彙整要匯出的環境變數：預設清單 + settings 偵測 + 額外指定，再排除。"""
    names: List[str] = []
    for name in [*DEFAULT_ENV_NAMES, *detect_env_names_from_settings(settings_path), *extra_names]:
        if name not in names:
            names.append(name)
    exclude: set[str] = set(exclude_names)
    result: Dict[str, str] = {}
    for name in names:
        if name in exclude:
            continue
        if name in env:
            result[name] = env[name]
    return result


def read_profile_plugins(profile_dir: Path) -> Dict[str, object]:
    """讀取一個 profile 的外掛清單（dependencies 與 dsh.profile.bundles）。"""
    manifest: Path = profile_dir / "package.json"
    if not manifest.is_file():
        return {}
    data = json.loads(manifest.read_text(encoding="utf-8"))
    bundles = data.get("dsh", {}).get("profile", {}).get("bundles", [])
    return {
        "dependencies": data.get("dependencies", {}),
        "bundles": bundles,
    }


def copy_file_if_exists(src: Path, dst: Path) -> bool:
    """若來源檔案存在則複製，回傳是否真的複製。"""
    if src.is_file():
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
        return True
    return False


def copy_dir_if_exists(src: Path, dst: Path) -> bool:
    """若來源資料夾存在則整份遞迴複製，回傳是否真的複製。"""
    if src.is_dir():
        shutil.copytree(src, dst, dirs_exist_ok=True)
        return True
    return False


def copy_profile_tree(src: Path, dst: Path) -> int:
    """複製單一 profile 目錄，略過 node_modules 與產生的 shim 檔。"""
    count: int = 0
    for root, dirs, files in os.walk(src):
        # 就地修剪，避免進入龐大的 node_modules。
        dirs[:] = [d for d in dirs if d != "node_modules"]
        rel_root: Path = Path(root).relative_to(src)
        for name in files:
            rel: Path = rel_root / name
            if rel.suffix.lower() in EXCLUDED_SUFFIXES:
                continue
            target: Path = dst / rel
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(Path(root) / name, target)
            count += 1
    return count


def cmd_export(args: argparse.Namespace) -> int:
    """匯出模式：把選定的內容打包成自帶還原能力的資料夾。"""
    env: Dict[str, str] = dict(os.environ)
    home: Path = resolve_dsh_home(env)
    if not home.is_dir():
        print(f"[错误] 找不到 DeepSeek Harness 主目录：{home}")
        return 1

    do_files: bool = not args.no_files
    do_plugins: bool = not args.no_plugins
    do_env: bool = not args.no_env

    timestamp: str = datetime.now().strftime("%Y%m%d-%H%M%S")
    out_dir: Path = (
        Path(args.out).expanduser()
        if args.out
        else Path.cwd() / f"dsh-config-backup-{timestamp}"
    )
    out_dir.mkdir(parents=True, exist_ok=True)

    profiles: List[str] = list_profiles(home)
    copied_files: List[str] = []
    plugins_info: Dict[str, object] = {}
    env_vars: Dict[str, str] = {}

    # ---- 設定檔 ----
    if do_files:
        files_root: Path = out_dir / "files"
        files_root.mkdir(parents=True, exist_ok=True)
        for name in [*ROOT_FILES, *OPTIONAL_ROOT_FILES]:
            if copy_file_if_exists(home / name, files_root / name):
                copied_files.append(name)
        for name in ROOT_DIRS:
            if copy_dir_if_exists(home / name, files_root / name):
                copied_files.append(name + "/")
        for profile_name in profiles:
            profile_src: Path = home / "profiles" / profile_name
            count: int = copy_profile_tree(profile_src, files_root / "profiles" / profile_name)
            copied_files.append(f"profiles/{profile_name}/ ({count} 个文件)")
    else:
        print("[跳过] 已按 --no-files 要求，不导出配置文件。")

    # ---- 外掛清單 ----
    if do_plugins:
        for profile_name in profiles:
            plugins_info[profile_name] = read_profile_plugins(home / "profiles" / profile_name)
        (out_dir / "plugins.json").write_text(
            json.dumps(plugins_info, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
    else:
        print("[跳过] 已按 --no-plugins 要求，不导出插件列表。")

    # ---- 環境變數 ----
    if do_env:
        # 以持久使用者環境變數（登錄檔 User scope）為準，再合併當前程序環境
        # 補齊僅在本次工作階段存在的變數。
        env_source: Dict[str, str] = {**env, **read_user_env_vars()}
        env_vars = collect_env_vars(env_source, args.env, args.exclude_env, home / "settings.yaml")
        if env_vars:
            # ensure_ascii=True：讓 JSON 純 ASCII，避免還原時編碼歧異。
            (out_dir / "env.json").write_text(
                json.dumps(env_vars, ensure_ascii=True, indent=2) + "\n",
                encoding="utf-8",
            )
    else:
        print("[跳过] 已按 --no-env 要求，不导出环境变量。")

    # ---- 自帶還原能力：複製本腳本與 README 進備份資料夾 ----
    script_src: Path = Path(__file__).resolve()
    copy_file_if_exists(script_src, out_dir / script_src.name)
    copy_file_if_exists(script_src.parent / "README.md", out_dir / "README.md")

    # ---- 描述檔 ----
    manifest: Dict[str, object] = {
        "tool": "dsh_config_tool.py",
        "generated_at": datetime.now().isoformat(timespec="seconds"),
        "source_home": str(home),
        "profiles": profiles,
        "env_var_names": sorted(env_vars.keys()),
        "items": {
            "files": do_files,
            "plugins": do_plugins,
            "env": do_env,
        },
    }
    (out_dir / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )

    # ---- 摘要 ----
    print()
    print("========== DeepSeek Harness 配置导出完成 ==========")
    print(f"导出目录 : {out_dir}")
    print(f"主目录   : {home}")
    if do_files:
        print(f"配置文件 : {len(copied_files)} 项")
        for item in copied_files:
            print(f"    - {item}")
    else:
        print("配置文件 : （未导出）")
    print(f"Profile  : {len(profiles)} 个：{', '.join(profiles) if profiles else '（无）'}")
    if do_env:
        if env_vars:
            print(f"环境变量 : {len(env_vars)} 个（仅列出名称，不显示值）")
            for name in sorted(env_vars.keys()):
                print(f"    - {name}")
        else:
            print("环境变量 : （无匹配变量，未导出）")
    else:
        print("环境变量 : （未导出）")
    print("已附带   : dsh_config_tool.py + README.md（备份可自还原）")
    print()
    print("提示：在目标机器运行「python dsh_config_tool.py restore --from <本目录>」即可还原。")
    if env_vars:
        print("警告：env.json 内含明文 API Key，请妥善保管，勿上传公开位置。")
    return 0


# =============================================================================
# 還原
# =============================================================================

def merge_copy(src: Path, dst: Path) -> int:
    """把 src 整棵樹合併複製到 dst（覆蓋同名檔），回傳複製的檔案數。"""
    count: int = 0
    for item in sorted(src.rglob("*")):
        rel: Path = item.relative_to(src)
        target: Path = dst / rel
        if item.is_dir():
            target.mkdir(parents=True, exist_ok=True)
        elif item.is_file():
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(item, target)
            count += 1
    return count


def ps_literal(value: str) -> str:
    """把字串轉成 PowerShell 單引號字面值（內部單引號加倍）。"""
    return "'" + value.replace("'", "''") + "'"


def restore_env_vars(env_vars: Dict[str, str]) -> None:
    """把環境變數寫回使用者環境（僅支援 Windows）。"""
    if os.name != "nt":
        print("[警告] 环境变量还原目前仅支持 Windows，已跳过。")
        return
    if not env_vars:
        print("[跳过] env.json 没有任何环境变量。")
        return

    lines: List[str] = ["$ErrorActionPreference = 'Stop'"]
    for name, value in env_vars.items():
        lines.append(
            f"[Environment]::SetEnvironmentVariable({ps_literal(name)}, {ps_literal(value)}, 'User')"
        )
    script: str = "\n".join(lines) + "\n"

    tmp = tempfile.NamedTemporaryFile(
        mode="w", suffix=".ps1", delete=False, encoding="utf-8"
    )
    try:
        tmp.write(script)
        tmp.close()
        result = subprocess.run(
            ["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", tmp.name],
            check=False,
        )
        if result.returncode != 0:
            print("[错误] 环境变量还原失败。")
            return
        print(f"[完成] 已还原 {len(env_vars)} 个环境变量。")
    finally:
        os.unlink(tmp.name)


def install_profile_plugins(profiles: Sequence[str]) -> None:
    """透過 `dsh plugin --profile <name> install` 安裝每個 profile 的外掛。"""
    for name in profiles:
        print(f"[安装] 正在安装 profile「{name}」的插件 ...")
        result = subprocess.run(
            ["dsh", "plugin", "--profile", name, "install"],
            shell=(os.name == "nt"),
            check=False,
        )
        if result.returncode != 0:
            print(f"[警告] profile「{name}」插件安装失败（退出码 {result.returncode}）。")
        else:
            print(f"[完成] profile「{name}」插件安装成功。")


def cmd_restore(args: argparse.Namespace) -> int:
    """還原模式：從備份資料夾還原選定的內容。"""
    backup_dir: Path = Path(args.from_).expanduser()
    if not backup_dir.is_dir():
        print(f"[错误] 备份目录不存在：{backup_dir}")
        return 1

    do_files: bool = not args.no_files
    do_plugins: bool = not args.no_plugins
    do_env: bool = not args.no_env

    env: Dict[str, str] = dict(os.environ)
    home: Path = Path(args.home).expanduser() if args.home else resolve_dsh_home(env)
    home.mkdir(parents=True, exist_ok=True)

    # ---- 設定檔 ----
    if do_files:
        files_root: Path = backup_dir / "files"
        if files_root.is_dir():
            count: int = merge_copy(files_root, home)
            print(f"[完成] 已还原 {count} 个配置文件到 {home}")
        else:
            print("[警告] 备份目录缺少 files/ 子目录，已跳过配置文件还原。")
    else:
        print("[跳过] 已按 --no-files 要求，不还原配置文件。")

    # ---- 環境變數 ----
    if do_env:
        env_json: Path = backup_dir / "env.json"
        if env_json.is_file():
            env_vars: Dict[str, str] = json.loads(env_json.read_text(encoding="utf-8"))
            restore_env_vars(env_vars)
        else:
            print("[跳过] 备份目录没有 env.json，已跳过环境变量还原。")
    else:
        print("[跳过] 已按 --no-env 要求，不还原环境变量。")

    # ---- 外掛 ----
    if do_plugins:
        profiles: List[str] = []
        manifest_path: Path = backup_dir / "manifest.json"
        if manifest_path.is_file():
            data = json.loads(manifest_path.read_text(encoding="utf-8"))
            profiles = list(data.get("profiles", []))
        if profiles:
            install_profile_plugins(profiles)
        else:
            print("[警告] 未在 manifest.json 找到 profile 列表，已跳过插件安装。")
    else:
        print("[跳过] 已按 --no-plugins 要求，不重新安装插件。")

    print()
    print("========== 还原完成 ==========")
    return 0


# =============================================================================
# 互動選單
# =============================================================================

def _prompt(text: str) -> str:
    """讀取一行輸入；EOF（例如管線輸入）時回傳空字串以安全退出。"""
    try:
        value: str = input(text)
    except (EOFError, KeyboardInterrupt):
        return ""
    # 去除可能由管線輸入帶入的 UTF-8 BOM 與首尾空白。
    return value.lstrip("\ufeff").strip()


def _choose_items(action: str, labels: Sequence[str]) -> set[int]:
    """讓使用者勾選要處理的內容項目，回傳選中編號集合（空集合表示全部）。"""
    print()
    print(f"请选择要{action}的内容（输入编号，空格或逗号分隔；留空 = 全部）：")
    for index, label in enumerate(labels, start=1):
        print(f"  [{index}] {label}")
    raw: str = _prompt("> ").strip()
    if not raw:
        return set()
    selected: set[int] = {int(d) for d in re.findall(r"[1-3]", raw)}
    if not selected:
        print("[提示] 没有有效的选择，默认全部。")
        return set()
    return selected


def _menu_export() -> int:
    """互動選單的「匯出」分支。"""
    selected: set[int] = _choose_items("导出", ["配置文件", "插件列表", "环境变量"])
    out_raw: str = _prompt("导出目录（留空 = 当前目录 dsh-config-backup-<时间戳>）：").strip()
    args = argparse.Namespace(
        out=out_raw or None,
        env=[],
        exclude_env=[],
        no_files=bool(selected) and 1 not in selected,
        no_plugins=bool(selected) and 2 not in selected,
        no_env=bool(selected) and 3 not in selected,
    )
    return cmd_export(args)


def _menu_import() -> int:
    """互動選單的「匯入」分支。"""
    selected: set[int] = _choose_items("导入", ["配置文件", "插件（重新安装）", "环境变量"])
    src_raw: str = _prompt("备份文件夹路径：").strip()
    if not src_raw:
        print("[取消] 未提供备份文件夹路径。")
        return 1
    args = argparse.Namespace(
        from_=src_raw,
        home=None,
        no_files=bool(selected) and 1 not in selected,
        no_plugins=bool(selected) and 2 not in selected,
        no_env=bool(selected) and 3 not in selected,
    )
    return cmd_restore(args)


def interactive_menu() -> int:
    """無參數啟動時顯示互動選單，選擇匯入 / 匯出與內容項目。"""
    print()
    print("========== DeepSeek Harness 配置备份 / 还原工具 ==========")
    print("  [1] 导出（备份配置到文件夹）")
    print("  [2] 导入（从备份文件夹还原配置）")
    print("  [0] 退出")
    choice: str = _prompt("请选择操作 (1/2/0)：").strip()
    if choice == "1":
        return _menu_export()
    if choice == "2":
        return _menu_import()
    print("已退出。")
    return 0


# =============================================================================
# CLI
# =============================================================================

def build_parser() -> argparse.ArgumentParser:
    """建立命令列解析器。"""
    parser = argparse.ArgumentParser(
        prog="dsh_config_tool.py",
        description="DeepSeek Harness 配置备份 / 还原工具（无参数运行时进入交互选单）",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    export = sub.add_parser("export", help="导出配置到文件夹（自带本脚本与 README，可独立还原）")
    export.add_argument("--out", help="导出目录（默认：当前目录下 dsh-config-backup-<时间戳>）")
    export.add_argument("--env", action="append", default=[], metavar="NAME",
                        help="额外导出的环境变量名（可重复）")
    export.add_argument("--exclude-env", action="append", default=[], metavar="NAME",
                        help="排除的环境变量名（可重复）")
    export.add_argument("--no-files", action="store_true", help="不导出配置文件")
    export.add_argument("--no-plugins", action="store_true", help="不导出插件列表")
    export.add_argument("--no-env", action="store_true", help="不导出环境变量")
    export.set_defaults(func=cmd_export)

    restore = sub.add_parser("restore", help="从备份文件夹还原配置")
    restore.add_argument("--from", dest="from_", required=True, metavar="DIR",
                         help="备份文件夹路径")
    restore.add_argument("--home", help="还原到的 DSH 主目录（默认：DSH_HOME 或 ~/.dsh）")
    restore.add_argument("--no-files", action="store_true", help="不还原配置文件")
    restore.add_argument("--no-plugins", action="store_true", help="不重新安装插件")
    restore.add_argument("--no-env", action="store_true", help="不还原环境变量")
    restore.set_defaults(func=cmd_restore)

    return parser


def main(argv: Optional[Sequence[str]] = None) -> int:
    """程式進入點：無參數時進入互動選單，否則解析子命令。"""
    args_list: List[str] = list(sys.argv[1:] if argv is None else argv)
    if not args_list:
        return interactive_menu()
    parser = build_parser()
    args = parser.parse_args(args_list)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
