# AGENTS.md

> 提到 AGENT / AGENTS 文件时都指本文件（唯一一份）：项目概述、操作约定、技能索引与技能详细引导。

## 项目概述

这是雅诗的个人代码备忘录，即 **NotebookCode**。内容涵盖网络摘录、书籍笔记及原创代码与脚本。

## 目录结构

根目录按**编程语言/技术栈**分类，每个文件夹对应一种语言或平台。各文件夹内的代码文件使用与该语言对应的标准文件扩展名（如 `Python/` 下为 `.py`，`JavaScript/` 下为 `.js`，`ShellScript/` 下为 `.sh` 等）。

## 操作约定

- 每次修改仅针对当前文件，无需分析或修改其他文件。
- 创建和编辑文件时，不要参考其他文件。
- 除非用户主动要求，否则勿自动执行、编译。可以进行静态检查。
- 例外：skill 的 Python 脚本因缺包报错（`ModuleNotFoundError` / `ImportError`）时，自动 `python -m pip install <包名>` 后重跑；装不上再报告。

## 技能导航（`.agents/skills/`）

本仓库自带一套 `yashi-` 开头的技能，路径以**本文件所在目录为基准**（即 `.agents/skills/<name>/SKILL.md`），与全局 `~/.agents/skills/` 保持**双边一致**。
**用到时先读取对应 SKILL.md，按其流程执行**，不要凭记忆操作；各技能要点见下文「技能详细引导」，**以 `.agents/skills/` 目录实际内容为准**。

| Skill                               | SKILL.md 相对路径                                           | 用途                                                                          | 触发场景                                       |
| ----------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------------------------- | ---------------------------------------------- |
| `yashi-md-table-format`             | `.agents/skills/yashi-md-table-format/SKILL.md`             | Markdown 表格按显示宽度对齐（全角占 2 格），禁止手工拼空格                    | 生成/修改含表格的 .md 或代码注释               |
| `yashi-opencc-convert`              | `.agents/skills/yashi-opencc-convert/SKILL.md`              | 中文简繁转换（基于 OpenCC），禁止手工替换                                     | 简繁转换、统一地区用词                         |
| `yashi-encoding-convert`            | `.agents/skills/yashi-encoding-convert/SKILL.md`            | 文本编码转换（自动检测 GBK/GB18030/Big5/UTF-16/UTF-8 等）                     | 读取乱码文件、以指定编码保存/读取              |
| `yashi-mcp-proxy-injection`         | `.agents/skills/yashi-mcp-proxy-injection/SKILL.md`         | 为读取网址/境外搜索的本地 MCP 服务器注入代理                                  | MCP 联网失败、安装 fetch/browser/search 类 MCP |
| `yashi-rtk-token-saver`             | `.agents/skills/yashi-rtk-token-saver/SKILL.md`             | 终端命令用 `rtk` 包装以压缩输出、节省 token                                   | 跑测试/构建/lint/git 等输出量大的命令          |
| `yashi-dsh-update`                  | `.agents/skills/yashi-dsh-update/SKILL.md`                  | DeepSeek Harness 一句话更新（全局包 + profile 插件 + 实测 `dsh web` 启停）    | 「更新 dsh」「dsh web 起不来」                 |
| `yashi-dsh-config-sync`             | `.agents/skills/yashi-dsh-config-sync/SKILL.md`             | dsh 配置一句话导出/导入（配置 + 插件 + 插件配置，导入后自动补依赖并实测启停） | 「导出/备份/迁移/恢复 dsh 配置」               |
| `yashi-dsh-env-sync`                | `.agents/skills/yashi-dsh-env-sync/SKILL.md`                | dsh 环境变量（API key）一句话导出/导入（ini）                                 | 「备份 dsh 的 API key」「换机器恢复 key」      |
| `yashi-opencode-config-portability` | `.agents/skills/yashi-opencode-config-portability/SKILL.md` | opencode 全部设置一句话导入/导出（7z）                                        | 「导出/导入 opencode 设置」                    |
| `yashi-github-read-contributions`   | `.agents/skills/yashi-github-read-contributions/SKILL.md`   | 读取 GitHub 贡献热力图并分析活跃度                                            | 贡献图/贡献统计                                |
| `yashi-windows-check-update`        | `.agents/skills/yashi-windows-check-update/SKILL.md`        | 查询 Windows 最新功能更新（KB 信息与下载链接）                                | 获取 Windows 10/11/2025 最新更新               |

> 技能目录 `.agents/` 目前**未被 git 跟踪**（`git status` 显示为 `?? .agents/`）。是否纳入版本管理由用户决定。

---

## 常用指令（一句话直达）

用户经常只说一句话、不解释细节。匹配下表后**立即读取对应 SKILL.md 并按其流程执行**，不要反问流程；只在目标路径缺失、或需要确认代理/覆盖时提问。

| 用户可能会说                | 对应 Skill                          | 动作                                  |
| --------------------------- | ----------------------------------- | ------------------------------------- |
| 导出 dsh 配置到 `<目录>`          | `yashi-dsh-config-sync`             | `export -o <目录>\dsh-config-<时间>.zip`          |
| 导入 dsh 配置（从 `<zip>`）      | `yashi-dsh-config-sync`             | 先 `inspect -i <zip>`，再 `import -i <zip>`     |
| 导出 token / 环境变量到 `<目录>`  | `yashi-dsh-env-sync`                | `export -o <目录>\dsh-env-backup-<时间>.ini`      |
| 导入环境变量（从 `<ini>`）       | `yashi-dsh-env-sync`                | 先 `import -i <ini> --dry-run`，再正式导入 |
| 检查 dsh 的 key 配齐没有    | `yashi-dsh-env-sync`                | `list` 或 `check`                     |
| 更新 dsh / `dsh web` 起不来 | `yashi-dsh-update`                  | 按 SKILL.md 全流程                    |
| 导出 / 导入 opencode 设置   | `yashi-opencode-config-portability` | 打包 / 还原 `opencode_config.7z`      |

命令模板（`$S` = config-sync 脚本，`$E` = env-sync 脚本）：

```powershell
$S = "$HOME/.agents/skills/yashi-dsh-config-sync/scripts/dsh_config_sync.py"
$E = "$HOME/.agents/skills/yashi-dsh-env-sync/scripts/dsh_env_sync.py"

# 导出 dsh 配置（未指定目录时默认 B:\）
python $S export -o "B:\dsh-config-20260915-1600.zip"
# 导入 dsh 配置：先看来源清单，再还原（网络步骤前先问是否用代理）
python $S inspect -i "B:\dsh-config-20260915-1600.zip"
python $S import  -i "B:\dsh-config-20260915-1600.zip"

# 导出环境变量 / token（含明文密钥，未指定目录时默认 B:\）
python $E export -o "B:\dsh-env-backup-20260915-1600.ini"
# 导入环境变量（setx 写用户环境，需重开终端 / 重启 dsh 才生效）
python $E import -i "B:\dsh-env-backup-20260915-1600.ini"
```

约定：

- 未指定目标目录时默认写 `B:\`；文件名时间戳用导出当时的本地时间 `yyyyMMdd-HHmm`。
- 迁移 = 「配置 zip」+「环境变量 ini」两份都要：配置包里**不含任何环境变量**。
- `python $E list` 若把某变量标为「未设置」，说明当前进程环境里没有它，导出会缺值 —— 先提醒用户，并优先在设置过这些变量的终端里执行。
- 导入 dsh 配置前先 `inspect`；`pnpm install`、git 拉依赖等网络步骤前，先问用户是否走代理。
- 环境变量 ini 是明文密钥：不要提交 git、不要放进配置 zip、不要明文分享。

---

## 技能详细引导

下列要点以对应 SKILL.md 的完整流程为准；脚本路径按「该 SKILL.md 所在目录」拼接，不要假设当前工作目录。
环境支持技能自动发现（dsh / opencode）时，优先**直接加载技能**，效果与读文件相同。

### 文档处理

- **表格格式化**：含 Markdown 表格（包括代码注释里的表格文本）时，调用 `scripts/md_table_format.py` 格式化，**不要手工拼空格对齐**。
- **简繁转换**：调用 `scripts/opencc_convert.py`；目标地区不明确时用默认 auto。
- **文本编码转换**：读写非 UTF-8（ANSI/GBK/Big5…）文件时，调用 `scripts/encoding_convert.py`。

### 终端与命令

- **命令输出压缩**：执行输出量大的命令时**显式**加 `rtk` 前缀（`git status` → `rtk git status`）——本环境**未启用 rtk 的自动改写 hook**。
  rtk 只改变输出展示，未识别的子命令原样透传，加前缀总是安全的。
- **例外**：`yashi-opencode-config-portability` 相关命令**禁止**加 `rtk` —— 它会截断/转换输出，导致哈希比对、JSON 校验、7z 返回码失真。

### DeepSeek Harness（dsh）

- **更新 dsh 与插件**：`.ps1` 被执行策略拦截，调 npm/dsh/pnpm 一律用 `.cmd`；新版 pnpm 已移除 `--allow-scripts`，原生模块许可靠 `allowBuilds` / `pnpm approve-builds --all`。
- **配置导入 / 导出 / 迁移**：一句话跑 `scripts/dsh_config_sync.py`（export / import / inspect / test）；导入会自动补依赖并实测 `dsh web` 启停；**导出不含环境变量**。
- **环境变量导入 / 导出**：一句话跑 `scripts/dsh_env_sync.py`（list / export / import / check），与配置迁移配套使用。

### 开发工具与服务

- **MCP 代理注入**：**先询问用户**是否需要代理补丁、代理到哪个地址（默认 `http://127.0.0.1:23333`），确认后再执行注入，不要擅自打补丁。
- **opencode 设置迁移**：默认打包为 `opencode_config.7z`；该技能内所有命令**禁止**加 `rtk` 前缀。

### 信息查询

- **GitHub 贡献热力图**：无需额外工具，用 `webfetch` 读 `https://github.com/users/{username}/contributions` 纯文本端点。
- **Windows 更新检查**：提取下载链接需要 Playwright MCP 浏览器（Catalog 页面为 JS 动态加载）。

---

## 注意事项

- 所有备忘内容及注释使用中国简体中文。
- 所有代码应该有充足的行注释和文档注释。
- 创建备忘录文件时，应给予常见操作的各种示例。
- 不应该包含令牌等敏感信息。
- 生成 CMD 代码时，DOS 原生命令采用大写字母。
- 此仓库仅供个人备忘使用，非生产级项目。
- 网络摘录的内容应在底部标注来源。
- 部分 Windows 脚本（vbs、reg 等）以 ANSI 编码保存，中文可能在其他编辑器中显示为乱码。
