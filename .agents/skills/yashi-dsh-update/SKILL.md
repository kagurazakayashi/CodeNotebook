---
name: yashi-dsh-update
description: 一句话更新 DeepSeek Harness（dsh）全家桶——npm 全局包（@deepseek-ai/dsh、@deepseek-harness-tui/dsh-tui）及 $DSH_HOME/profiles 下的所有 profile 插件，安装/补全缺失依赖（pnpm install + approve-builds），先修复 profile .npmrc 的 store-dir（dsh 更新功能会写坏，报 ERR_PNPM_UNEXPECTED_STORE），处理 git 依赖与不兼容插件，实测 `dsh web --port 3088` 启动（HTTP 401/303 校验）并整棵进程树退出、清理临时文件，最后输出当前全局包与插件信息表格。适用于「更新 dsh」「升级 DeepSeek Harness」「dsh 更新后启动失败」「dsh web 起不来」「插件依赖未安装」「pnpm install 报错」「ERR_PNPM_UNEXPECTED_STORE」「dsh-get-balance 不兼容」等场景。代理与端口已由用户固化（socks5://127.0.0.1:23332 或 http://127.0.0.1:23333 + strict-ssl=false；测试端口 3088），无需再问。
---

<!--
触发示例：
- 更新一下 DeepSeek Harness 和它的所有插件
- dsh 一键更新
- dsh web 启动失败了，帮我看看
- 更新 dsh 后测试 dsh web 能否启动
- 给我一份当前已安装的 dsh 插件信息表格
- 更新 dsh 报 ERR_PNPM_UNEXPECTED_STORE 了
-->

# yashi-dsh-update — DeepSeek Harness 一句话更新

## 核心规则（先读）

1. **代理（用户已固化，不必再问）**：所有下载操作统一走本机代理
   `socks5://127.0.0.1:23332` 或 `http://127.0.0.1:23333`（优先 socks5，失败换 http）。
   本机代理会 MITM 重签 TLS，npm/pnpm 报 `SELF_SIGNED_CERT_IN_CHAIN` 时：
   命令级临时设 `$env:npm_config_strict_ssl="false"`（只影响当前命令，**勿写入 .npmrc / 全局配置**）。
2. **先修 store-dir 再动依赖（dsh 更新功能会把 .npmrc 写坏）**：dsh 的「检查更新」功能会把
   `pnpm store path` 的实际值（`...\pnpm\store\v10\v10`）写进每个 profile 的 `.npmrc` 作为
   `store-dir`；而 pnpm 会在配置值后再追加一层 `v10`，于是期望路径变成 `...\store\v10\v10\v10`，
   报 `ERR_PNPM_UNEXPECTED_STORE: Unexpected store location`，更新直接失败。
   每次更新前先检查 `$DSH_HOME\profiles\<name>\.npmrc`（web、dsh-tui 都要查）：
   - 若 `store-dir` 以 `store\v10\v10` 结尾 → 改回
     `store-dir=C:\Users\yashi\AppData\Local\pnpm\store\v10`（去掉末尾 `\v10`；Windows 用反斜杠 `\`）；
   - 用 `pnpm store path` 验证，输出必须等于 `C:\Users\yashi\AppData\Local\pnpm\store\v10\v10`
     （与 `node_modules\.modules.yaml` 记录的 `storeDir` 一致）；
   - 中途再报 `ERR_PNPM_UNEXPECTED_STORE`：停止，重复上述修复后重试。
3. **新版 pnpm 没有 `--allow-scripts`**：直接跑会报
   `error: unexpected argument '--allow-scripts' found`。原生模块（node-pty / ssh2 / cloudflared /
   cpu-features 等）的构建许可可靠这两条：
   - `pnpm-workspace.yaml` 里的 `allowBuilds:`（正式配置项，值是 `包名: true`）；
   - 或装完后 `pnpm approve-builds --all`，再 `pnpm rebuild`。
   > `onlyBuiltDependencies` / `neverBuiltDependencies` 已被 `allowBuilds` 取代并**静默忽略**。
4. **`dsh` / `npm` / `pnpm` 一律用 `.cmd`**：dsh 的 shell 是 Windows PowerShell 5.1，
   `dsh.ps1` / `npm.ps1` 被执行策略拦截（`running scripts is disabled`）。写 `dsh.cmd` / `npm.cmd` / `pnpm.cmd`。
5. **优先排查「依赖没装」**：多数「启动失败」是 profile 的 `node_modules` 不全，先 `pnpm install`。
6. **不兼容插件先禁用再测**：临时在 `profiles\<name>\cordis.patch.yml` 里 `disabled: true`，
   测出 dsh web 能启动后再决定去留（能修就修，不能修保持禁用并说明原因）。
7. **测试进程必须整树清理**：`dsh.cmd` 只是包装器，node 是**孙进程**；
   只 kill 包装器会留下孤儿 node 继续占端口。用 `taskkill /F /T /PID <包装器 pid>`。
8. **端口（用户已固化）**：测试用 **3088**（`dsh web --port 3088 --no-open`）；
   3088 被占用就换一个空闲端口并在报告里说明。注意本机 3081 是正在跑的 GUI，勿动。
9. **更新默认升 `latest`**：dsh / dsh-tui 一律升到 `latest`（`npm.cmd -g install <包>@latest`），
   **不要**用 `@next`；只有用户明确要求「用 next / 要 rc」时才切，并在报告里写明这次切了 tag。
   例外：若当前已装版本高于 `latest` tag（例如装的 `next` 的 rc.2 而 latest 是 rc.1），
   **不要降级**，保持已装版本并说明。

## 环境速览

| 项 | 位置 / 值 |
|---|---|
| 全局 npm root | `C:\npm`（用 `npm.cmd root -g` 确认；本机 `npm prefix -g` 指向沙箱路径，装全局包必须显式 `--prefix C:/npm`） |
| dsh CLI | `dsh.cmd`（PATH 中；`.ps1` 被执行策略拦截，一律用 `.cmd`） |
| dsh-tui CLI | `dsh-tui.cmd`（同 dsh） |
| 所有 profile | `$DSH_HOME\profiles\<name>`：web、dsh-tui，**逐个遍历，不要硬编码新名字** |
| profile 插件清单 | `profiles\<name>\package.json` 的 `dependencies` + `dsh.profile.bundles` |
| profile 用户 patch | `profiles\<name>\cordis.patch.yml`（插件禁用、配置覆盖） |
| profile pnpm 配置 | `profiles\<name>\pnpm-workspace.yaml`（`allowBuilds` 等） |
| profile .npmrc 的 store-dir | 正确值 `C:\Users\yashi\AppData\Local\pnpm\store\v10`（被 dsh 写坏时会变成 `...\store\v10\v10`，见核心规则 2） |
| 代理 | `socks5://127.0.0.1:23332` 或 `http://127.0.0.1:23333`（用户固化） |
| dsh web 测试端口 | 3088（用户固化；3081 是本机 GUI，勿动） |
| TUI 状态目录 | `~\.dsh-tui`（独立于 `$DSH_HOME`，不属 profile） |

## 工作流

### 0. 修复各 profile 的 store-dir（必做，任何 pnpm 操作之前）
```powershell
# 对 web、dsh-tui 每个 profile：
$profiles = Get-ChildItem "$env:DSH_HOME\profiles" -Directory | Where-Object Name -ne 'node_modules'
foreach ($p in $profiles) {
  $npmrc = Join-Path $p.FullName '.npmrc'
  if (Test-Path $npmrc) {
    $c = Get-Content $npmrc -Raw
    if ($c -match 'store-dir=.*\\store\\v10\\v10\s*$') {
      ($c -replace 'store-dir=.*\\store\\v10\\v10', 'store-dir=C:\Users\yashi\AppData\Local\pnpm\store\v10') |
        Set-Content $npmrc -Encoding UTF8 -NoNewline
      Write-Output "已修复 store-dir: $($p.Name)"
    }
  }
  Push-Location $p.FullName
  Write-Output "store path: $(pnpm.cmd store path)"
  Pop-Location
}
# 预期 store path 均为 C:\Users\yashi\AppData\Local\pnpm\store\v10\v10
```

### 1. 设置代理（用户已固化，直接设，不用问）
```powershell
$env:HTTPS_PROXY = "http://127.0.0.1:23333"   # 或 socks5://127.0.0.1:23332
$env:HTTP_PROXY  = "http://127.0.0.1:23333"
$env:ALL_PROXY   = "http://127.0.0.1:23333"
$env:npm_config_strict_ssl = "false"          # 本机代理 MITM，仅命令级
```
连通性验证：`curl.exe -s -o NUL -w "%{http_code}" https://registry.npmjs.org --max-time 10`

### 2. 更新 npm 全局包
```powershell
dsh.cmd --version
npm.cmd -g list @deepseek-ai/dsh @deepseek-harness-tui/dsh-tui --depth=0
npm.cmd view @deepseek-ai/dsh dist-tags        # 只用来核对版本，不据此切 tag
npm.cmd view @deepseek-harness-tui/dsh-tui dist-tags

# 默认：升到 latest（等价于 npm.cmd -g update）
# 注意：本机全局前缀非默认位置，必须显式 --prefix C:/npm
npm.cmd install -g --prefix C:/npm @deepseek-ai/dsh@latest @deepseek-harness-tui/dsh-tui@latest
# 若当前版本 > latest tag（装的 next 且用户没要求切）：保持现状，不降级，说明原因
```
> `next` tag 只留给用户明确点名的情况；不要自发用 `@next`。
> 全局包更新**务必串行**执行（一次只跑一个 npm install），并发会互相清理导致 EPERM/ENOTEMPTY、
> 把 node_modules 和 .cmd shim 删坏，必须串行。

### 3. 补全各 profile 的插件依赖（重点）
先枚举真实存在的 profile（不要硬编码名字）：
```powershell
Get-ChildItem "$env:DSH_HOME\profiles" -Directory | Where-Object Name -ne 'node_modules'
```
逐个执行（每个 profile 都先跑第 0 步的 store-dir 修复）：
```powershell
foreach ($p in (Get-ChildItem "$env:DSH_HOME\profiles" -Directory | Where-Object Name -ne 'node_modules')) {
  Push-Location $p.FullName
  pnpm.cmd update --latest    # 升所有插件到最新（git 依赖也会重解析）
  pnpm.cmd install
  pnpm.cmd approve-builds --all      # 批准原生模块构建（新版 pnpm：替代 --allow-scripts）
  pnpm.cmd rebuild                   # 仅在上一步真的批准了包时才需要
  Pop-Location
}
```
> 若某 profile 的 `pnpm-workspace.yaml` 里 `allowBuilds` 已列好包名，`pnpm install` 会直接编译，无需额外步骤。
> pnpm 卡在 git 依赖网络解析时（`codeload.github.com` 直连/代理都可能挂起），
> 若依赖已装好、lockfile 未变，可跳过 install，直接 `pnpm.cmd outdated` 确认无更新后继续。

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
**已知问题（历史）**
- `dsh-get-balance` 曾因 `import { settingsNamespace } from "@deepseek-ai/dsh-settings"`（新版
  `dsh-settings` 只导出 `SettingsProvider` / `SettingsConflictError` / `redactSecrets`）导致
  `dsh web` 启动即崩：`SyntaxError: The requested module '@deepseek-ai/dsh-settings' does not provide
  an export named 'settingsNamespace'`。**已从依赖和 bundles 中卸载**，正常情况不应再出现；
  若又出现在依赖里，处理方式：在 `cordis.patch.yml` 追加禁用，测通后保持禁用并报告。
- `dshmarket` 只在注释/函数名里提到 `settingsNamespace`，**无实际影响**，不用动。

### 5. 实测 dsh web 启动
```powershell
# 用户固化端口 3088；被占用则换空闲端口（3081 是本机 GUI，勿用）
$port = 3088
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
- 无 token 访问返回 **401**、带 token 返回 **303** → 服务正常（用 `curl.exe` 验证）
- 出现 `SyntaxError` / `not provide an export named` / `Cannot find module` → 按第 4 步定位具体插件
- 出现插件「不允许多实例」报错 → 临时在该 profile 的 `cordis.patch.yml` 禁用该插件，
  测通后视情况恢复（能启用就启用并说明）

### 6. 退出测试进程 + 清理
```powershell
taskkill /F /T /PID $p.Id            # /T 关键：一并带走 node 孙进程
Start-Sleep -Seconds 2
netstat -ano | Select-String ":$port\s" | Select-String LISTENING   # 应为空
# 兜底：仍有 PID 在听就单独清掉
# Get-NetTCPConnection -LocalPort $port -State Listen | ForEach-Object { taskkill /F /PID $_.OwningProcess }
Remove-Item $log -ErrorAction SilentlyContinue
# 同时清理本次产生的临时文件（$env:TEMP 下的 *.log / *.json / *.txt 等）
# 临时改过 cordis.patch.yml 的话必须恢复（改前先备份）
```

### 7. 输出插件信息表格
报告中必须包含：
- **全局包**：更新前 → 更新后版本、是否成功
- **store-dir 修复**：哪些 profile 的 `.npmrc` 被写坏、已修复、`pnpm store path` 验证结果
- **各 profile**：profile 名、插件数、`pnpm install` 结果
- **插件表**：插件名 / 版本 / 来源（npm 或 git）/ 状态（✅正常 / ⚠️禁用 / 🔶待更新）
- **遇到的问题及处理**（问题、原因、处理方式）—— 尤其 ERR_PNPM_UNEXPECTED_STORE 与禁用插件的处理
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
| `ERR_PNPM_UNEXPECTED_STORE: Unexpected store location` | `.npmrc` 的 `store-dir` 被 dsh 更新功能写成实际 store 路径 `...\store\v10\v10`，pnpm 再追加 `v10` 算出 `...\store\v10\v10\v10` | 改回 `store-dir=C:\Users\yashi\AppData\Local\pnpm\store\v10`，`pnpm store path` 验证 = `...\store\v10\v10`（见核心规则 2） |
| `SELF_SIGNED_CERT_IN_CHAIN` | 本机代理 MITM 重签 TLS | 命令级 `$env:npm_config_strict_ssl="false"`，勿写全局配置 |
| `error: unexpected argument '--allow-scripts' found` | 新版 pnpm 已移除该参数 | 用 `pnpm approve-builds --all`；许可写进 `pnpm-workspace.yaml` 的 `allowBuilds:` |
| `File ... npm.ps1 cannot be loaded because running scripts is disabled` | PowerShell 执行策略拦截 `.ps1` shim | 改用 `npm.cmd` / `dsh.cmd` / `pnpm.cmd` |
| `dsh web` 启动即崩，日志有 `settingsNamespace` SyntaxError | 插件（如 dsh-get-balance）与新版 core 不兼容 | 若依赖里出现 dsh-get-balance：临时禁用 → 验证 → 保持禁用（详见第 4 步） |
| 全局包安装后 dsh / dsh-tui 命令消失、node_modules 残缺 | 多个 npm install 并发互相清理（EPERM/ENOTEMPTY） | 全局更新**串行**执行；已损坏则删残缺目录后逐个重装 |
| pnpm install 报 git 依赖无法访问 | 依赖记录 SSH 地址 | `git config --global url."https://github.com/".insteadOf "git@github.com:"`（先告知用户） |
| profile 插件全报找不到模块 | `node_modules` 几乎为空 | 在该 profile 目录 `pnpm install` |
| 原生模块运行时报缺 `.node` | 构建脚本被 pnpm 默认拒绝 | `pnpm approve-builds --all` → `pnpm rebuild` |
| 测试后端口仍被占用 | 只 kill 了 `dsh.cmd` 包装器，node 孙进程成孤儿 | `taskkill /F /T /PID`，必要时按端口反查 PID 再杀 |
| 端口被占用 | 之前测试进程未退出 | 换端口并说明；**不要占用 3081** |
| 插件「不允许多实例」 | 插件单例约束 | 临时禁用该插件测启动，通过后视情况恢复 |
| `pnpm` 提示 `pnpm` 字段被忽略 | 新版 pnpm 配置位置变了 | 正常；把 `onlyBuiltDependencies` 迁到 `pnpm-workspace.yaml` 的 `allowBuilds` |

## 环境备注

- shell 为 Windows PowerShell 5.1：`dsh`/`npm`/`pnpm` 用 `.cmd`；`curl` 用 `curl.exe`；
  临时目录用 `$env:TEMP`（不是 `/tmp`）。
- npm 全局根在 `C:\npm`（非 npm 默认 prefix）：更新必须显式 `--prefix C:/npm`；
  路径确认用 `npm.cmd root -g`。
- 路径符号：Windows 一律用反斜杠 `\`（如 `C:\Users\yashi\AppData\Local\pnpm\store\v10`）。
- 测试产生的运行数据（`storages/`、用量账本等）属正常持久数据，不清理。
