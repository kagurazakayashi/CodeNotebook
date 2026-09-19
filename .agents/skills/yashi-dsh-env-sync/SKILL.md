---
name: yashi-dsh-env-sync
description: 一句话导出/导入 DeepSeek Harness（dsh）的环境变量（API key 等）——自动扫描 $DSH_HOME/settings.yaml、各 profile 的 cordis.patch.yml 与 package.json、以及插件配置里所有 apiKeyEnv / process.env.X / ${VAR} 引用，导出到 ini 文件备份/迁移；或从 ini 导入恢复（Windows setx 写入用户环境，新终端生效；也可输出 shell / powershell export 语句）。支持直接用 config-sync 导出的 zip 作为变量名来源（--from-archive），与 yashi-dsh-config-sync 联动：配置导出不含环境变量，密钥靠本脚本恢复。适用于「导出 dsh 环境变量」「备份 API key」「迁移 dsh 到新机器需要恢复 key」「从 ini 导入环境变量」「dsh 换机器后 API key 恢复」「检查 dsh 的 key 是否配齐」等场景。
---

<!--
触发示例：
- 导出 dsh 用到的环境变量（API key）到 ini
- 把 dsh 的 API key 备份一下
- 从 ini 恢复 dsh 的环境变量
- 迁移 dsh 配置时一起导出环境变量
- 检查 dsh 的 API key 是否都配好了
-->

# yashi-dsh-env-sync — DeepSeek Harness 环境变量导入 / 导出

## 核心规则（先读）

1. **先问范围（导出、导入都要）**：不要默认全导，先跑 `python $E list` 列出发现到的变量名
   （值打码），再让用户挑：
   - 全部 —— 默认；
   - 补上 `settings.yaml` 未引用的变量 —— 导出时加 `-w A B`；
   - 只恢复其中几个 —— 导入时加 `--only A B`；
   - 迁移场景不知道要哪些 —— 用 `--from-archive <config-sync 的 zip>` 反查。
   用户答完再执行，并在汇报里说明这次带了哪些变量。
2. **脚本位置**：相对本 SKILL.md 是 `scripts/dsh_env_sync.py`；
   完整路径 `~/.agents/skills/yashi-dsh-env-sync/scripts/dsh_env_sync.py`。
   纯标准库、无第三方依赖，直接 `python <脚本>` 运行。
3. **导出的 ini 是敏感文件**（含明文 API key）：放私有位置（如 `~/dsh-env-backup.ini`），
   不要提交 git、不要明文共享、不要放进 dsh 配置 zip。
4. **输出默认打码**：`list` / `--dry-run` 只显示 `AQ.f*******90` 形式；确需明文用 `--show-values`。
5. **setx 只对新进程生效**：导入后当前终端读不到，必须**重开终端 / 重启 dsh**。
6. **联动**：`yashi-dsh-config-sync` 导出的配置包里**没有**环境变量，
   完整迁移 = config-sync 导配置 + 本脚本导 ini。反向也可用
   `--from-archive <config-sync 的 zip>` 直接从包里发现「需要哪些变量名」。

## 命令速查

```powershell
$E = "$HOME/.agents/skills/yashi-dsh-env-sync/scripts/dsh_env_sync.py"
$OUT = "<备份目录>"    # 占位：U 盘 / 网络盘 / 任意目录，按需替换

# 1) 列出 dsh 用到的环境变量名（值打码）
python $E list
# 迁移场景：直接从配置包里发现需要哪些变量
python $E list --from-archive "$OUT\dsh-config.zip"

# 2) 导出到 ini（默认 ~/dsh-env-backup.ini）
python $E export
python $E export -o "$OUT\dsh-env-backup.ini"
python $E export -w OPENAI_API_KEY ANTHROPIC_API_KEY    # 补充 settings.yaml 未引用的

# 3) 导入（Windows setx 写用户环境）
python $E import -i "$OUT\dsh-env-backup.ini" --dry-run
python $E import -i "$OUT\dsh-env-backup.ini"
python $E import -i ... --only DEEPSEEK_API_KEY          # 只恢复某几个
python $E import -i ... --format powershell              # 不写注册表，只输出 $env: 语句
python $E import -i ... --format shell                   # 输出 export 语句（Git Bash / macOS / Linux）

# 4) 体检：ini 与当前环境对比
python $E check -i "$OUT\dsh-env-backup.ini"
python $E check                                          # 不传 ini 则只查「引用到的变量在不在」
```

## 工作流

### 导出
```powershell
python $E list          # 先看会发现哪些变量、哪些当前没设置
# 有「未设置」的变量时提醒用户：它们可能是别处（系统环境/其他用户）设置的，或确实缺失
python $E export -o <ini 路径>
```
汇报：**导出了几个变量、ini 路径、哪些被跳过**，并强调「ini 含明文密钥，注意保管」。

### 导入
```powershell
python $E import -i <ini> --dry-run     # 先预览（打码）
python $E import -i <ini>               # 正式写入
python $E check  -i <ini>               # 可选：再核对一次
```
汇报：写入了几个、失败几个、**提醒重开终端 / 重启 dsh 才生效**。
非 Windows 或不想改注册表时用 `--format powershell` / `--format shell`。

### 与 config-sync 的迁移联动
```powershell
# 新机器上，配置已导入但还没恢复密钥：
python $E list --from-archive <config-sync 的 zip>   # 看这个配置需要哪些 key
python $E import -i <ini>                            # 用导出好的 ini 恢复
```

## 自动发现的来源

| 来源 | 抓什么 |
|---|---|
| `$DSH_HOME/settings.yaml` | `apiKeyEnv: XXX`、`*Env: XXX`（llm-pi-ai 各 provider 等） |
| `$DSH_HOME/profiles/*/cordis.patch.yml` | `process.env.X`、`${X}`、`apiKeyEnv` |
| `$DSH_HOME/profiles/*/package.json` | `dsh` 段的 `*Env` 字段 |
| `$DSH_HOME/*.json` / `*.yaml` | 插件配置里的同类引用 |
| `--from-archive <zip>` | 包内 `manifest.json` 的 `envVarsReferenced` + 包内上述文件 |
| `--whitelist A B` | 手工补充；默认白名单含 `DSH_HOME` |

## ini 格式（标准 configparser，`[dsh]` 段）

```ini
[dsh]
DEEPSEEK_API_KEY = sk-xxxx
GEMINI_API_KEY = AQ.xxxx
MOONSHOT_API_KEY = sk-xxxx
```

## 常见坑

| 现象 | 原因 | 处理 |
|---|---|---|
| 导入后当前终端仍读不到 | `setx` 只对新进程生效 | 重开终端 / 重启 dsh；或重开后再 `python $E list` |
| `list` 显示某变量「未设置」 | 当前进程环境没有（可能只在系统/其他用户环境） | 用 `-w` 显式加名并在当前 shell 里先设好值；或先 `setx` |
| 值太长被截断 | `setx` 有 1024 字符上限 | 用 `--format powershell` 注入，或在启动 dsh 的终端里 `$env:X="..."` |
| 非 Windows 上 `import` 失败 | `setx` 是 Windows 命令 | 用 `--format shell` / `--format powershell` 输出后注入 |
| 忘了某个 key | settings.yaml 未引用它 | `export` 时加 `-w` 补充 |
| 导入后 dsh 仍报缺 key | 变量名对不上 | `check -i <ini>` 看「不一致/缺失」，再用 `--only` 逐个修 |
| 只想确认配没配齐 | —— | `python $E check`（不需要 ini） |
