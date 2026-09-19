---
name: yashi-dsh-config-sync
description: 一句话导出/导入 DeepSeek Harness（dsh）的完整配置——settings.yaml、用户全局 AGENTS.md、所有 profile（`profiles/*`）的 package.json / cordis.patch.yml / pnpm-workspace.yaml / .npmrc、.agent-presets 自定义预设，以及**插件自己的配置文件**（pet.json、dsh-ssh.json、dsh-notifier-status.json、dsh-cloud-sync/settings.json 等，按规则自动发现）。导入时自动补全所有可下载依赖（pnpm install + approve-builds）、自动修正 `pnpm-workspace.yaml` 里 allowBuilds 的半成品配置（占位文本导致的 ERR_PNPM_IGNORED_BUILDS）、检查 `profiles/*/pnpm.cmd` 包装器指向是否失效、自动实测 dsh web 启动/停止并给出排障建议，可联动 yashi-dsh-update（更新与修复插件）和 yashi-dsh-env-sync（环境变量 ini 导入导出）。导出**不含环境变量**（由 yashi-dsh-env-sync 单独处理）、不含敏感凭证、不含任何导入后能自动下载或重建的内容（node_modules、.dsh-module-fallback、pnpm-lock.yaml、cordis.yml）、不含 sessions/storages 等运行数据。适用于「导出 dsh 配置」「备份 dsh 配置」「迁移 dsh 到新机器」「导入 dsh 配置」「恢复 dsh 配置」「dsh 换电脑」等场景。
---

<!--
触发示例：
- 导出 dsh 的配置（settings、插件、插件配置）
- 把 dsh 配置备份一份 / 迁移到新电脑
- 导入之前导出的 dsh 配置
- 恢复 dsh 配置
- dsh 换机器了，怎么把配置带过去
-->

# yashi-dsh-config-sync — DeepSeek Harness 配置导入 / 导出

## 核心规则（先读）

1. **先问范围（导出、导入都要）**：不要默认全带，先用一句话让用户挑这次要哪些：
   - 基础配置（`settings.yaml`、`profiles/*`、插件配置、`.agent-presets`）—— **默认带**；
   - 用户全局 `AGENTS.md` —— **默认带**；
   - **环境变量 / API key** —— 不在本包里，改用 `yashi-dsh-env-sync`；
   - **skills**（`~/.agents/skills`）—— 默认不带，要就加 `--with-agents`；
   - **运行数据**（`sessions/`、`storages/` 等）—— 默认不带，要就加 `--with-data`；
   - **凭证**（`.credentials.yaml` 等）—— 默认不带，`--with-secrets`（危险，一般不要）；
   - 锁文件（`pnpm-lock.yaml`）—— 默认不带，要就加 `--with-lockfiles`。
   导入同理：先确认这次要还原哪些、要不要补依赖与实测（`--no-install` / `--no-test` 可跳过）。
2. **一句话跑脚本**：导出/导入都由 `scripts/dsh_config_sync.py` 完成，不要手工 `cp` 文件。
   脚本路径（相对本 SKILL.md）：`scripts/dsh_config_sync.py`；
   完整路径：`~/.agents/skills/yashi-dsh-config-sync/scripts/dsh_config_sync.py`。
3. **导出不含环境变量**：API key 等一律排除，由 `yashi-dsh-env-sync` 用 ini 单独恢复。
   脚本会在导出报告和导入报告里列出「引用了哪些环境变量」提醒你。
4. **导出不含敏感凭证**：`.credentials.yaml`、`credentials.json`、`*.key/*.pem`、
   含 `_authToken` 的 `.npmrc` 一律排除；导入后重新登录/重填即可。
5. **「能自动下载/重建的都不导出」**：`node_modules`、`profiles/node_modules`、
   `profiles/*/.dsh-module-fallback`、`pnpm-lock.yaml`、`cordis.yml` 全部排除，
   导入后靠 `pnpm install` + dsh 自身重建（已实测可自愈）。
6. **导入后必须自动补全 + 实测**：脚本默认会跑
   `pnpm install` → `pnpm approve-builds --all` →（有原生模块时）`pnpm rebuild`
   → 启动 `dsh web` 实测 → 停止并确认端口释放。不要只解压了事。
7. **配置半成品要自动修正**：`pnpm-workspace.yaml` 的 `allowBuilds:` 段落里若残留 pnpm 的
   占位文本 `set this to true or false`（导出包会原样带走这份「没填完」的配置），
   `pnpm install` 必然以 `ERR_PNPM_IGNORED_BUILDS` 秒退（exit=1）。脚本在安装前会自动把这类
   非法值改成 `true` 并打印告警；遇到此报错先看这条，不要当成网络/依赖问题排查。
8. **pnpm.cmd 指向要检查**：`profiles/*/pnpm.cmd` 是导出时留下的包装器，写死了原机器的 pnpm
   绝对路径（形如 `C:\npm\pnpm.cmd`）。cmd.exe 会优先命中当前目录的同名文件，一旦该路径失效，
   dsh 在 profile 目录里就调不到 pnpm。导入与 `test` 时脚本都会检查，并给出
   `mklink /J <失效目录> <真实 pnpm 目录>` 的修复建议（junction 不需要管理员权限）。
9. **代理必须先问用户**：任何网络操作（pnpm install / git 拉依赖）前先确认是否用代理、用哪个
   （本机候选 `socks5://192.168.255.1:23334` / `http://192.168.255.1:23334`，以用户指定为准），
   确认后用 `--proxy <url>` 传给脚本。
10. **联动**：插件不兼容/装不上 → `yashi-dsh-update`；环境变量 → `yashi-dsh-env-sync`。

## 环境速览

| 项                 | 位置 / 值                                                                        |
| ------------------ | -------------------------------------------------------------------------------- |
| dsh home           | `$DSH_HOME`；脚本优先级：`--home` > `$DSH_HOME` > `~/.dsh`                       |
| 共享 agent 根      | `~/.agents`（`$DSH_AGENTS_HOME`），skills 在 `~/.agents/skills/`                 |
| dsh CLI            | `dsh.cmd`（PowerShell 执行策略拦截 `.ps1`，调 dsh / npm / pnpm 一律用 `.cmd`）   |
| Python             | 直接用 PATH 里的 `python`；脚本纯标准库、无第三方依赖，不挑版本                  |
| pnpm               | 新版已移除 `--allow-scripts`，改用 `allowBuilds` / `pnpm approve-builds`         |
| pnpm 包装器        | `profiles/*/pnpm.cmd` 写死原机器路径，导入包会带过来；脚本会检查指向是否有效     |
| 本机真实 pnpm      | 以 `(Get-Command pnpm).Source` 为准（实测 `F:\npm\pnpm.cmd`），不一定是 `C:\npm` |
| profile            | 不预设清单：导出/导入都遍历 `profiles/*`，**所有 profile 的设置都会带上**        |
| dsh web 默认端口   | 3080（本机 GUI 跑在 **3081**，测试用 3089，别占用 3081）                         |
| 运行数据（不导出） | `sessions/` `storages/` `attachments/` `llm-deepseek/` `trash/`                  |

> shell 注意：dsh 的 pwsh 工具实际是 **Windows PowerShell 5.1**（实测 `$PSVersionTable`），
> 不是 pwsh 7 —— 脚本里避免使用仅 pwsh 7 支持的语法。

## 命令速查

```powershell
$S = "$HOME/.agents/skills/yashi-dsh-config-sync/scripts/dsh_config_sync.py"
$OUT = "<备份目录>"    # 占位：U 盘 / 网络盘 / 任意目录，按需替换

# 看会导出什么（不写文件）
python $S export --print

# 导出（默认 ~/dsh-config-export-<时间>.zip）
python $S export
python $S export -o "$OUT\dsh-config.zip"

# 查看一个导出包的内容
python $S inspect -i "$OUT\dsh-config.zip"

# 导入（默认：还原 → pnpm install → 实测 dsh web 启停）
python $S import -i "$OUT\dsh-config.zip"
python $S import -i "$OUT\dsh-config.zip" --dry-run        # 只预览
python $S import -i ... --no-install --no-test             # 只还原文件
python $S import -i ... --proxy socks5://192.168.255.1:23334 # 需要代理时

# 单纯实测当前配置能否启动 dsh web
python $S test --port 3089
```

可选开关：

| 开关               | 作用                                                                   |
| ------------------ | ---------------------------------------------------------------------- |
| `--with-agents`    | 同时导出/导入 `~/.agents/skills`（默认不含，见「与 opencode 的关系」） |
| `--with-lockfiles` | 带上 `pnpm-lock.yaml`（默认不带，靠 package.json 解析）                |
| `--with-data`      | 带上 sessions/storages 等运行数据（默认不带）                          |
| `--with-secrets`   | 带上凭证（**危险**，一般不要）                                         |
| `--strict`         | 只导已知配置，不含自动推断的插件配置                                   |
| `--exclude '模式'` | 额外排除（可重复）                                                     |
| `--home 目录`      | 覆盖 `$DSH_HOME`（测试/多 home 场景）                                  |

## 工作流

### 导出
1. 先 `--print` 看清单：确认「某插件的配置文件」被收进来了（会标 `*`）。
2. 若发现有不该带的（例如某插件的数据目录），加 `--exclude` 重跑。
3. 正式导出，向用户汇报：**zip 路径、文件数、dsh 版本、profiles、引用的环境变量**，
   并提醒「环境变量不在包里，需要 yashi-dsh-env-sync 一起导出」。

### 导入
1. 先 `inspect` 看来源包（哪个 dsh 版本、哪些 profile、引用哪些环境变量）。
2. **询问用户是否使用代理**（见核心规则 9），再决定是否传 `--proxy`。
3. 执行导入；脚本会自动：
   - 备份将被覆盖的文件到 `~/dsh-config-backup-<时间>/`；
   - 还原配置到 `$DSH_HOME`；
   - 检查 `profiles/*/pnpm.cmd` 的指向，失效则打印 `mklink /J` 修复建议；
   - 自动修正 `pnpm-workspace.yaml` 里 `allowBuilds:` 的非法值（占位文本 → `true`）；
   - 逐 profile 跑 `pnpm install` + `pnpm approve-builds --all`（有原生模块则再 `pnpm rebuild`），
     若仍报 `ERR_PNPM_IGNORED_BUILDS` 会自动补跑 `approve-builds` 并重装一次；
   - 在测试端口（默认 3089）启动 `dsh web --no-open`，验证「无 token 401 / 带 token 303」，
     然后强杀**整棵进程树**并确认端口释放。
4. 若启动失败：把脚本打印的日志尾部 + `💡` 建议转述给用户，并按建议处理（多数要转
   `yashi-dsh-update`，例如某插件与新版 core 不兼容 → 用 `cordis.patch.yml` 临时禁用）。
5. 若包里有 `envVarsReferenced`，提醒用户跑 `yashi-dsh-env-sync` 恢复密钥（见联动表）。
6. 若脚本打印了 `⚠️ 发现失效的 pnpm.cmd 包装器`，把 `mklink /J` 那一行原样给用户
   （junction 不需要管理员权限），避免 dsh 之后在 profile 目录里调不到 pnpm。

## 导出范围（脚本内置规则）

**会导出**

| 类别              | 内容                                                                                                                                                                                                          |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 主设置            | `settings.yaml`（模型、provider、插件 namespace 配置、UI 偏好）                                                                                                                                               |
| 用户全局指令      | `$DSH_HOME/AGENTS.md`（`CLAUDE.md`、`AGENTS.local.md` 同规则）                                                                                                                                                |
| 自定义 agent 预设 | `.agent-presets/`（递归）                                                                                                                                                                                     |
| 身份标识          | `.anonymous-user-id`                                                                                                                                                                                          |
| profile 配置      | `profiles/各 profile/package.json`、`cordis.patch.yml`、`pnpm-workspace.yaml`、`.npmrc`                                                                                                                       |
| **插件配置文件**  | `$DSH_HOME` 下**运行期自动发现**的其它配置文件：顶层 `*.json`/`*.yaml`（如 `pet.json`、`dsh-ssh.json`、`dsh-notifier-status.json`）与插件配置子目录（如 `dsh-cloud-sync/settings.json`），在报告里用 `*` 标注 |
| 可选              | `--with-agents` 时的 `~/.agents/skills/**`                                                                                                                                                                    |

**不会导出**

| 类别       | 内容                                                                                                                            | 原因                                      |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| 环境变量   | API key 等一切环境变量                                                                                                          | 由 `yashi-dsh-env-sync` 用 ini 单独处理   |
| 敏感凭证   | `.credentials.yaml`、`credentials.json`、`*.key/*.pem/*.p12`、含 `_authToken` 的 `.npmrc`                                       | 导入后重新登录/重填                       |
| 可自动重建 | `node_modules`、`profiles/node_modules`、`.dsh-module-fallback`、`pnpm-lock.yaml`、`cordis.yml`                                 | `pnpm install` / dsh 启动时自愈（已实测） |
| 运行数据   | `sessions/` `storages/` `attachments/` `llm-deepseek/` `trash/` `task-board/` `dsh-usage/` `dsh-session-archive/` `@wingsky-1/` | 会话历史/账本，不是配置                   |
| 日志临时   | `*.log` `*.tmp` `*.pid`                                                                                                         | 噪声                                      |

## 联动

| Skill                | SKILL.md 路径                                  | 何时用                                                               |
| -------------------- | ---------------------------------------------- | -------------------------------------------------------------------- |
| `yashi-dsh-env-sync` | `~/.agents/skills/yashi-dsh-env-sync/SKILL.md` | 导出/导入 API key 等环境变量（ini）；配置包不含密钥                  |
| `yashi-dsh-update`   | `~/.agents/skills/yashi-dsh-update/SKILL.md`   | 导入后插件装不上、dsh web 起不来、插件与 core 不兼容、需要更新全家桶 |

**完整迁移配方**：`config-sync 导出 zip` + `env-sync 导出 ini` →
新机器上 `config-sync 导入 zip` → `env-sync 导入 ini` → 重开终端 → `dsh web`。

## 常见坑

| 现象                                                          | 原因                                                                                                      | 处理                                                                                                        |
| ------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `--allow-scripts` 报 `unexpected argument`                    | 新版 pnpm 已移除该参数                                                                                    | 改用 `pnpm approve-builds --all`；构建许可写在 `pnpm-workspace.yaml` 的 `allowBuilds:`                      |
| `pnpm install` 秒退 exit=1，报 `ERR_PNPM_IGNORED_BUILDS`      | `allowBuilds:` 里残留占位文本 `set this to true or false`（非法布尔值）                                   | 脚本已自动改成 `true` 并告警；手工场景把该值改成 `true`/`false` 后重跑                                      |
| 导入时脚本长时间无输出、像卡死                                | (1) 调用方把输出缓冲了（别用 `Select-Object -Last`，用重定向到文件）(2) `approve-builds` 等子命令在等 std | 脚本已给所有子进程设 `stdin=DEVNULL`，不会再无限等待；看日志请重定向到文件后再读                            |
| `dsh` 在 profile 目录里调 pnpm 报找不到命令                   | `profiles/*/pnpm.cmd` 写死了失效路径，cmd.exe 优先命中当前目录同名文件                                    | 用 `mklink /J C:\npm F:\npm` 建 junction 指向真实 pnpm 目录（不需要管理员权限）；脚本会在导入/`test` 时提示 |
| 导入后插件全报找不到模块                                      | 忘了装依赖                                                                                                | 脚本已自动跑 `pnpm install`；手工场景在两个 profile 目录各跑一次                                            |
| `dsh web` 启动即崩，日志有 `does not provide an export named` | 某插件与新版 core 不兼容（如 dsh-get-balance 的 `settingsNamespace`）                                     | 按 `yashi-dsh-update`，在 `profiles/各 profile/cordis.patch.yml` 追加 `- id: 插件 id` + `disabled: true`    |
| pnpm install 报 git 依赖无法访问                              | 锁文件/依赖记录的是 `git@github.com:` SSH 地址                                                            | `git config --global url."https://github.com/".insteadOf "git@github.com:"`                                 |
| 启动测试「端口被占用」自动换端口                              | 3089 被别的进程占着                                                                                       | 正常降级行为；也可 `--port 0` 让系统分配                                                                    |
| 测试后仍有 node 进程残留                                      | 只 kill 了 `dsh.cmd` 包装器，node 是孙进程                                                                | 脚本已用 `taskkill /F /T` 整树清理 + 端口反查兜底；手工场景务必 `/T`                                        |
| 云同步/SSH 不可用                                             | `accessKeyId` 导出了但 secret 未导入                                                                      | 在插件设置页重填；`.credentials.yaml` 需重新登录                                                            |
| `~/.dsh-tui` 没被带上                                         | 它是 dsh-tui 自己的状态目录，不在 `$DSH_HOME`                                                             | 如需迁移 TUI 历史，单独备份 `~/.dsh-tui`（属数据，非配置）                                                  |

## 与 opencode / 其它 agent 的关系

`~/.agents/skills` 是 dsh 与 opencode 等共用的 skill 源。默认**不**打进 dsh 配置包，
以免和 `yashi-opencode-config-portability` 的产物重复。要连 skill 一起迁移时加 `--with-agents`。
