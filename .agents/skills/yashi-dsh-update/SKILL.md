---
name: yashi-dsh-update
description: 一句话更新 DeepSeek Harness（dsh）全家桶——npm 全局包（@deepseek-ai/dsh、@deepseek-harness-tui/dsh-tui）及 $DSH_HOME/profiles 下的所有 profile 插件，安装/补全缺失依赖（pnpm install + approve-builds），处理 git 依赖与不兼容插件（如 dsh-get-balance），实测 `dsh web` 启动（HTTP 401/303 校验）并整棵进程树退出、清理临时文件，最后输出当前全局包与插件信息表格。适用于「更新 dsh」「升级 DeepSeek Harness」「dsh 更新后启动失败」「dsh web 起不来」「插件依赖未安装」「pnpm install 报错」「dsh-get-balance 不兼容」等场景。注意：是否使用代理及用哪个代理必须先询问用户，不得擅自决定。
---

<!--
触发示例：
- 更新一下 DeepSeek Harness 和它的所有插件
- dsh 一键更新
- dsh web 启动失败了，帮我看看
- 更新 dsh 后测试 dsh web 能否启动
- 给我一份当前已安装的 dsh 插件信息表格
-->

# yashi-dsh-update — DeepSeek Harness 一句话更新

## 核心规则（先读）

1. **代理必须先问用户**：执行任何需要网络的操作（npm 更新、pnpm 安装、git clone）之前，先询问用户：
   - 是否需要使用代理？用哪个？（本机候选 `socks5://192.168.255.1:23334` 或 `http://192.168.255.1:23334`，
     以用户指定为准，**不要硬编码、不要默认开**）
   - 得到明确答复后再设置环境变量；不需要代理就完全不要设。
2. **新版 pnpm 没有 `--allow-scripts`**：直接跑会报
   `error: unexpected argument '--allow-scripts' found`。原生模块（node-pty / ssh2 / cloudflared /
   cpu-features 等）的构建许可靠这两条：
   - `pnpm-workspace.yaml` 里的 `allowBuilds:`（正式配置项，值是 `包名: true`）；
   - 或装完后 `pnpm approve-builds --all`，再 `pnpm rebuild`。
   > `onlyBuiltDependencies` / `neverBuiltDependencies` 已被 `allowBuilds` 取代并**静默忽略**。
3. **`dsh` / `npm` / `pnpm` 一律用 `.cmd`**：dsh 的 shell 是 Windows PowerShell 5.1，
   `dsh.ps1` / `npm.ps1` 被执行策略拦截（`running scripts is disabled`）。写 `dsh.cmd` / `npm.cmd` / `pnpm.cmd`。
4. **优先排查「依赖没装」**：多数「启动失败」是 profile 的 `node_modules` 不全，先 `pnpm install`。
5. **不兼容插件先禁用再测**：临时在 `profiles/<name>/cordis.patch.yml` 里 `disabled: true`，
   测出 dsh web 能启动后再决定去留（能修就修，不能修保持禁用并说明原因）。
6. **测试进程必须整树清理**：`dsh.cmd` 只是包装器，node 是**孙进程**；
   只 kill 包装器会留下孤儿 node 继续占端口。用 `taskkill /F /T /PID <包装器 pid>`。
7. **`dsh web` 默认端口 3080，本机 GUI 跑在 3081**：测试一律另选端口（推荐 3089），
   跑完确认端口已释放。
8. **更新默认升 `latest`**：dsh / dsh-tui 一律升到 `latest`（`npm.cmd -g install <包>@latest`），
   **不要**用 `@next`；只有用户明确要求「用 next / 要 rc」时才切，并在报告里写明这次切了 tag。

## 环境速览

| 项 | 位置 / 值 |
|---|---|
| 全局 npm root | 非默认位置时用 `npm.cmd root -g` 查，不要硬编码 |
| dsh CLI | `dsh.cmd`（PATH 中；`.ps1` 被执行策略拦截，一律用 `.cmd`） |
| dsh-tui CLI | `dsh-tui.cmd`（同 dsh） |
| 所有 profile | `$DSH_HOME/profiles/<name>`：**逐个遍历，不要硬编码名字** |
| profile 插件清单 | `profiles/<name>/package.json` 的 `dependencies` + `dsh.profile.bundles` |
| profile 用户 patch | `profiles/<name>/cordis.patch.yml`（插件禁用、配置覆盖） |
| profile pnpm 配置 | `profiles/<name>/pnpm-workspace.yaml`（`allowBuilds` 等） |
| dsh web 默认端口 | 3080（**本机 3081 是正在跑的 GUI，勿动**；测试用 3089） |
| TUI 状态目录 | `~/.dsh-tui`（独立于 `$DSH_HOME`，不属 profile） |

## 工作流

### 1. 先问代理（必做，网络操作前）
```text
询问用户：
  1) 本次更新是否使用代理？
  2) 用哪个代理（如 socks5://192.168.255.1:23334 / http://192.168.255.1:23334）？
```
得到答复后（**仅在需要时**）：
```powershell
$env:HTTPS_PROXY = "socks5://192.168.255.1:23334"
$env:HTTP_PROXY  = "socks5://192.168.255.1:23334"
$env:ALL_PROXY   = "socks5://192.168.255.1:23334"
```
连通性验证：`curl.exe -s -o NUL -w "%{http_code}" https://registry.npmjs.org --max-time 10`

### 2. 更新 npm 全局包
```powershell
dsh.cmd --version
npm.cmd -g list @deepseek-ai/dsh @deepseek-harness-tui/dsh-tui --depth=0
npm.cmd view @deepseek-ai/dsh dist-tags        # 只用来核对版本，不据此切 tag
npm.cmd view @deepseek-harness-tui/dsh-tui dist-tags

# 默认：升到 latest（等价于 npm.cmd -g update）
npm.cmd -g install @deepseek-ai/dsh@latest @deepseek-harness-tui/dsh-tui@latest
```
> `next` tag 只留给用户明确点名的情况；不要自发用 `@next`。

### 3. 补全各 profile 的插件依赖（重点）
先枚举真实存在的 profile（不要硬编码名字）：
```powershell
Get-ChildItem "$env:DSH_HOME\profiles" -Directory | Where-Object Name -ne 'node_modules'
```
逐个执行：
```powershell
foreach ($p in (Get-ChildItem "$env:DSH_HOME\profiles" -Directory | Where-Object Name -ne 'node_modules')) {
  Push-Location $p.FullName
  pnpm.cmd install
  pnpm.cmd approve-builds --all      # 批准原生模块构建（新版 pnpm：替代 --allow-scripts）
  pnpm.cmd rebuild                   # 仅在上一步真的批准了包时才需要
  Pop-Location
}
```
> 若某 profile 的 `pnpm-workspace.yaml` 里 `allowBuilds` 已列好包名，`pnpm install` 会直接编译，无需额外步骤。

**git 依赖不可达**（依赖记录 `git@github.com:` SSH 地址）：
```powershell
git ls-remote https://github.com/<owner>/<repo>.git HEAD    # 先验证 HTTPS 通
# 失败/需要重定向时（注意这是全局配置，会一直生效，必须先告知用户）：
git config --global url."https://github.com/".insteadOf "git@github.com:"
git config --global url."https://github.com/".insteadOf "ssh://git@github.com/"
# 之后重新 pnpm install
```

### 4. 排查不兼容插件
```powershell
# 插件里 import 了新版 core 已移除的导出
Select-String -Path "$env:DSH_HOME\profiles\*\node_modules\*\lib\*.js" -Pattern 'settingsNamespace' -ErrorAction SilentlyContinue

# 确认 core 侧到底导出了什么
$core = Split-Path (Get-Command dsh.cmd).Source
Get-ChildItem "$core\..\node_modules\@deepseek-ai\dsh-settings\lib\index.js" -ErrorAction SilentlyContinue |
  Select-String -Pattern '^export'
```
**已知问题（dsh-get-balance）**
- `dsh-get-balance@0.1.36` 仍 `import { settingsNamespace } from "@deepseek-ai/dsh-settings"`，
  而新版 `dsh-settings` 只导出 `SettingsProvider` / `SettingsConflictError` / `redactSecrets`。
- 现象：`dsh web` 启动即崩，日志
  `SyntaxError: The requested module '@deepseek-ai/dsh-settings' does not provide an export named 'settingsNamespace'`。
- 处理：在该 profile 的 `cordis.patch.yml` 追加禁用，测通后保持禁用，并在报告里写明待作者适配：
  ```yaml
  - id: dsh-get-balance
    disabled: true
  ```
- `dshmarket` 只在注释里提到 `settingsNamespace`，**无实际影响**，不用动。

### 5. 实测 dsh web 启动
```powershell
# 选一个空闲端口（本机 GUI 占 3081，勿用）
$port = 3089
$log  = Join-Path $env:TEMP "dsh-web-test.log"
Remove-Item $log -ErrorAction SilentlyContinue

$p = Start-Process -FilePath "cmd.exe" `
      -ArgumentList "/c","dsh.cmd web --port $port --no-open > `"$log`" 2>&1" `
      -PassThru -WindowStyle Hidden
Start-Sleep -Seconds 25
Get-Content $log
netstat -ano | Select-String ":$port\s" | Select-String LISTENING
```
判定标准：
- 日志出现 `dsh web: http://127.0.0.1:<port>/?token=...` → 启动成功
- 无 token 访问返回 **401**、带 token 返回 **303** → 服务正常（用 `curl.exe` 或 python 验证）
- 出现 `SyntaxError` / `not provide an export named` / `Cannot find module` → 按第 4 步定位具体插件

### 6. 退出测试进程 + 清理
```powershell
taskkill /F /T /PID $p.Id            # /T 关键：一并带走 node 孙进程
Start-Sleep -Seconds 2
netstat -ano | Select-String ":$port\s" | Select-String LISTENING   # 应为空
# 兜底：仍有 PID 在听就单独清掉
# Get-NetTCPConnection -LocalPort $port -State Listen | ForEach-Object { taskkill /F /PID $_.OwningProcess }
Remove-Item $log -ErrorAction SilentlyContinue
# 临时改过 cordis.patch.yml 的话必须恢复（改前先备份）
```

### 7. 输出插件信息表格
报告中必须包含：
- **全局包**：更新前 → 更新后版本、是否成功
- **各 profile**：profile 名、插件数、`pnpm install` 结果
- **插件表**：插件名 / 版本 / 来源（npm 或 git）/ 状态（✅正常 / ⚠️禁用 / 🔶待更新）
- **遇到的问题及处理**（问题、原因、处理方式）—— 尤其 dsh-get-balance 的禁用原因
- **测试结论**：`dsh web --port <port>` 启动结果、HTTP 状态码、端口是否已释放

## 联动

| Skill | SKILL.md 路径 | 何时用 |
|---|---|---|
| `yashi-dsh-config-sync` | `~/.agents/skills/yashi-dsh-config-sync/SKILL.md` | 插件清单/配置丢失或被改乱、要备份或迁移 dsh 配置、导入后补依赖与实测启停 |
| `yashi-dsh-env-sync` | `~/.agents/skills/yashi-dsh-env-sync/SKILL.md` | 启动正常但报缺 API key / 换机器后密钥要恢复 |

> 小技巧：只想验证「当前配置能否启动 dsh web」时，可直接用
> `python ~/.agents/skills/yashi-dsh-config-sync/scripts/dsh_config_sync.py test --port 3089`，
> 它已内置启动→校验→整树停止→端口释放检查。

## 常见坑

| 现象 | 原因 | 处理 |
|---|---|---|
| `error: unexpected argument '--allow-scripts' found` | 新版 pnpm 已移除该参数 | 用 `pnpm approve-builds --all`；许可写进 `pnpm-workspace.yaml` 的 `allowBuilds:` |
| `File ... npm.ps1 cannot be loaded because running scripts is disabled` | PowerShell 执行策略拦截 `.ps1` shim | 改用 `npm.cmd` / `dsh.cmd` / `pnpm.cmd` |
| `dsh web` 启动即崩，日志有 `settingsNamespace` SyntaxError | dsh-get-balance 与新版 core 不兼容 | 临时禁用 → 验证 → 保持禁用（详见第 4 步） |
| pnpm install 报 git 依赖无法访问 | 依赖记录 SSH 地址 | `git config --global url."https://github.com/".insteadOf "git@github.com:"`（先告知用户） |
| profile 插件全报找不到模块 | `node_modules` 几乎为空 | 在该 profile 目录 `pnpm install` |
| 原生模块运行时报缺 `.node` | 构建脚本被 pnpm 默认拒绝 | `pnpm approve-builds --all` → `pnpm rebuild` |
| 测试后端口仍被占用 | 只 kill 了 `dsh.cmd` 包装器，node 孙进程成孤儿 | `taskkill /F /T /PID`，必要时按端口反查 PID 再杀 |
| 端口被占用 | 之前测试进程未退出 | 换端口（如 3089）并说明；**不要占用 3081** |
| 插件「不允许多实例」 | 插件单例约束 | 临时禁用该插件测启动，通过后视情况恢复 |
| `pnpm` 提示 `pnpm` 字段被忽略 | 新版 pnpm 配置位置变了 | 正常；把 `onlyBuiltDependencies` 迁到 `pnpm-workspace.yaml` 的 `allowBuilds` |

## 环境备注

- shell 为 Windows PowerShell 5.1：`dsh`/`npm`/`pnpm` 用 `.cmd`；`curl` 用 `curl.exe`；
  临时目录用 `$env:TEMP`（不是 `/tmp`）。
- npm 全局根在非默认位置时，用 `npm.cmd -g update` 即可（路径可用 `npm.cmd root -g` 查）。
- 测试产生的运行数据（`storages/`、用量账本等）属正常持久数据，不清理。
