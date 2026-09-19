---
name: yashi-opencode-config-portability
description: 一句话导入或导出 opencode 的全部设置（备份/还原/迁移/同步 opencode 配置）。打包 ~/.config/opencode 与 ~/.agents 两个目录，使用 7z -mx9 压缩，默认文件名 opencode_config.7z，跨 Windows/macOS/Linux。导入/导出前先用标准 JSON.parse 校验配置文件（opencode.json 维持标准 JSON），结束后安全清理临时文件（含 token 的先覆盖再删除）。导入后自动检查 MCP 所需环境、MCP 可用性，以及导入的 skill 是否适配本机。Use when the user says 导出/备份/导入/还原/迁移/同步 opencode 设置 或 提到 opencode_config.7z。
---

# opencode 设置导入 / 导出

让用户用一句话完成 opencode 配置的备份、还原或跨机迁移。

## 重要：禁止使用 rtk

本 skill 中的所有命令（7z、node、npm、npx、certutil、shasum、setx 等）**必须直接执行，不得在前面添加 `rtk` 前缀**。rtk 会截断/转换输出，导致校验命令（哈希比对、JSON.parse 验证）结果失真，或使 7z 等外部工具的返回码被吞掉，从而误导判断并造成数据损坏。

## 打包范围

固定打包这两个目录（相对用户主目录，三平台路径一致）：

- `.config/opencode` —— opencode 主配置（`opencode.json`、`agents/`、`skills/`、`plugins/`、`package.json` 等）
- `.agents` —— 外部 skills 目录（`~/.agents/skills/**`）

排除项（导出时**不打包**，因为可在导入时重新下载 / 安装；这样既减小体积，又避免跨平台二进制不兼容）：

- 所有 `node_modules`（由 `npm install` 依据 `package.json` / `package-lock.json` 重建）
- `.venv` / `__pycache__` 等 Python 虚拟环境与缓存（uvx / uv 会按需重新拉取）
- `.cache`、`.turbo`、`.pnpm-store` 等各类下载缓存
- Playwright / 浏览器二进制（体积大、平台相关，导入后重新安装）
- 浏览器状态文件 `browser-state-*.json`（可能含有登录会话等敏感数据）
- 校验和文件 `*.sha256`（每次导出重新生成）
- 生成的压缩包本身 `opencode_config.7z` 与校验和文件 `opencode_config.7z.sha256`

务必保留 `package.json` 与 `package-lock.json`（锁定版本，保证导入端可复现安装），只排除由它们生成的产物。

默认文件名：`opencode_config.7z`。导入、导出均**默认覆盖**目标文件 / 已有设置，无需二次确认（这是本 skill 的既定行为；仅在检测到目标目录含有明显无关的大量用户数据时才提醒）。

## 主目录检测

- Windows (cmd)：`%USERPROFILE%`
- Windows (PowerShell) / macOS / Linux (bash/zsh)：`$HOME`

所有 7z 操作都应**先切换到主目录**再执行，使归档内路径为 `.config/opencode/...` 与 `.agents/...` 这样的相对路径，从而在任意机器上解压回主目录即可正确还原。

## 前置检查

确认 `7z`（p7zip / 7-Zip）已安装并在 PATH：

- Windows：`where 7z`（若无，提示安装 7-Zip 并将其目录加入 PATH，或用 `7z.exe` 全路径）
- macOS：`which 7z`（`brew install p7zip`）
- Linux：`which 7z`（`apt install p7zip-full` / `dnf install p7zip` 等）

若不可用，按当前操作系统给出安装方法后中止。

## 配置文件格式与 JSON 校验

本 skill 统一把 opencode 配置文件（`opencode.json` 等）维持为**标准 JSON**（不含注释、不含尾随逗号），以便任何工具都能用标准 `JSON.parse` 读取与校验，也避免内联脚本因 JSONC 语法而解析失败。

**校验时机（均必须执行）**：

- **导出前**：校验源 `~/.config/opencode/opencode.json`；不合法则先修复再打包，避免把坏配置备份出去。
- **导入后**（解压完成、重启 opencode 之前）：校验解压出的 `~/.config/opencode/opencode.json`，确保还原的配置可用。

校验命令（标准 `JSON.parse`，退出码非 0 即不合法；Unix 把 `USERPROFILE` 换成 `HOME`）：

```
node -e "JSON.parse(require('fs').readFileSync(process.env.USERPROFILE+'/.config/opencode/opencode.json','utf8'));console.log('opencode.json VALID')"
```

**校验失败的处理（转换为标准 JSON，先备份再改写）**：失败通常是遗留的尾随逗号或注释。

1. 先把原文件备份到临时目录（如 `<tmp>/opencode.json.bak`）。
2. 去除尾随逗号与多余空白行后用 `JSON.parse` 验证，通过再写回（此命令 cmd 内联安全，只改语法不动数据与其余格式；Unix 把 `USERPROFILE` 换成 `HOME`）：

```
node -e "const fs=require('fs');const f=process.env.USERPROFILE+'/.config/opencode/opencode.json';const raw=fs.readFileSync(f,'utf8');const t=raw.replace(/,(\s*[}\]])/g,'$1').replace(/^[ \t]+\r?\n/gm,'');JSON.parse(t);fs.writeFileSync(f,t);console.log('converted to standard JSON')"
```

3. 上面的转换命令只处理尾随逗号，不去注释。若配置里含 `//` 或 `/* */` 注释，用正则去注释会误伤字符串内的 `//`（如 URL），这种情况改用能识别字符串边界的转换脚本，写入临时 `.cjs` 文件运行，运行后按「清理临时文件」删除该临时脚本。
4. 转换后再次运行校验命令确认通过。校验未通过前，**不得**继续导出 / 导入或重启 opencode。

## 导出（备份）

导出时除 `.7z` 外还会生成两个辅助文件：
- `opencode_config.7z.sha256` — SHA256 校验和（导入时用于完整性校验）
- `opencode_config.env` — 环境变量清单与值（**打包入 .7z**，导入时用于还原 API 密钥等）

### 步骤 0：校验源配置（必须先执行）

按「配置文件格式与 JSON 校验」校验 `~/.config/opencode/opencode.json`。不合法则先转换为标准 JSON 并通过校验后，再进入下一步；否则中止。

### 步骤 1：生成环境变量文件

先从 `opencode.json` 提取所有 `{env:...}` 引用，再追加 `MYMCP_PROXY_SERVER`（MCP 代理补丁的统一入口变量，不在 opencode.json 中但补丁代码依赖它），从当前系统环境读取值并写入 `.env`：

Windows (cmd)，`workdir` 设为 `%USERPROFILE%`：

```
node -e "const fs=require('fs');const c=JSON.parse(fs.readFileSync('.config/opencode/opencode.json','utf8'));const s=JSON.stringify(c);const m=[...s.matchAll(/\{env:([A-Z_][A-Z0-9_]*)\}/g)];const vars=[...new Set(m.map(x=>x[1]))];vars.push('MYMCP_PROXY_SERVER');vars.sort();fs.writeFileSync('opencode_config.env',vars.map(v=>v+'='+(process.env[v]||'')).join('\r\n'))"
```

macOS / Linux (bash)，先 `cd "$HOME"`：

```
node -e "const fs=require('fs');const c=JSON.parse(fs.readFileSync('.config/opencode/opencode.json','utf8'));const s=JSON.stringify(c);const vars=[...new Set([...s.matchAll(/\{env:([A-Z_][A-Z0-9_]*)\}/g)].map(x=>x[1]))];vars.push('MYMCP_PROXY_SERVER');vars.sort();fs.writeFileSync('opencode_config.env',vars.map(v=>v+'='+(process.env[v]||'')).join('\n'))"
```

### 步骤 2：打包文件

在主目录下执行（`-mx9` 最高压缩，`-xr!` 递归排除）：

Windows (cmd)，`workdir` 设为 `%USERPROFILE%`：

```
7z a -mx9 -xr!node_modules -xr!.venv -xr!__pycache__ -xr!.cache -xr!.pnpm-store -xr!browser-state-*.json -xr!opencode_config.7z -xr!opencode_config.7z.sha256 "opencode_config.7z" ".config\opencode" ".agents" "opencode_config.env"
certutil -hashfile "opencode_config.7z" SHA256 | findstr /v "^$" | findstr /v "hash" > "opencode_config.7z.sha256"
```

macOS / Linux (bash)，先 `cd "$HOME"`：

```
7z a -mx9 '-xr!node_modules' '-xr!.venv' '-xr!__pycache__' '-xr!.cache' '-xr!.pnpm-store' '-xr!browser-state-*.json' '-xr!opencode_config.7z' '-xr!opencode_config.7z.sha256' opencode_config.7z .config/opencode .agents opencode_config.env
shasum -a 256 opencode_config.7z > opencode_config.7z.sha256
```

如发现其它体积大且可重新获取的产物目录，一并用 `-xr!<名称>` 排除。

- 若用户指定了其它输出路径 / 文件名，用其指定值替换 `opencode_config.7z`。
- 完成后报告归档绝对路径、文件大小、SHA256 校验和，以及提取到的环境变量列表（名称和是否获取到值）。
- SHA256 校验和文件 `opencode_config.7z.sha256` 与归档放在同一目录，导入时将用于完整性校验。

### 步骤 3：清理临时文件（必做）

打包完成后，按「清理临时文件（安全删除）」删除主目录下的 `opencode_config.env`（含 API 密钥，须先覆盖再删除）；若转换配置时留下了临时脚本 / 备份，一并按规则处理。保留最终产物 `opencode_config.7z` 与 `opencode_config.7z.sha256`。

## 导入（还原 / 迁移）

### 前置校验：SHA256 完整性检查（必须执行）

导入前**必须先**校验归档完整性，防止传输损坏或文件被篡改：

Windows (cmd)，`workdir` 设为归档所在目录：

```
for /f "delims=" %i in ('type "opencode_config.7z.sha256"') do echo %i | findstr /r "^[a-fA-F0-9]\{64\}$" && certutil -hashfile "opencode_config.7z" SHA256 | findstr /r "^[a-fA-F0-9]\{64\}$"
```

macOS / Linux (bash)：

```
shasum -a 256 -c opencode_config.7z.sha256
```

- 若校验**通过** → 继续下一步。
- 若校验**失败**（哈希不匹配）→ **立即中止**，警告用户文件可能已损坏或被篡改，不执行解压。提示用户重新获取归档或联系发布者。
- 若 `.sha256` 文件**不存在** → 警告用户「缺少校验文件，无法验证完整性」，**征求用户明确同意**后才继续解压。

### 解压

将归档解压回主目录，**覆盖全部**同名文件（`-aoa` = overwrite all existing files without prompt）：

Windows (cmd)，`workdir` 设为 `%USERPROFILE%`：

```
7z x -aoa "opencode_config.7z" -o"%USERPROFILE%"
```

macOS / Linux (bash)：

```
7z x -aoa opencode_config.7z -o"$HOME"
```

- 归档位置由用户指定；默认在当前目录或主目录寻找 `opencode_config.7z`。

### 校验解压出的配置（必须执行）

解压后立即按「配置文件格式与 JSON 校验」校验还原出的 `~/.config/opencode/opencode.json`。不合法则先转换为标准 JSON 并通过校验，再继续后续步骤与重启 opencode；否则明确告知用户配置有误。

### Thunderbird 进程检测与 MCP 自动启用

导入时检查 Thunderbird 是否正在运行，据此自动决定 `thunderbird-mail`（与 Thunderbird 相关的 `thunderbird-cli-mcp`）是否启用：

**检测命令**：

- Windows (cmd)：
  ```
  tasklist /fi "IMAGENAME eq thunderbird.exe" 2>nul | find /i "thunderbird.exe" >nul && echo RUNNING || echo NOT_RUNNING
  ```
- macOS / Linux (bash)：
  ```
  pgrep -x thunderbird >/dev/null 2>&1 && echo RUNNING || echo NOT_RUNNING
  ```

**处理逻辑**（用 Node 就地修改 `opencode.json`）：

若 Thunderbird **正在运行** → 自动将 `thunderbird-mail` MCP 的 `enabled` 设为 `true`：

```
node -e "const fs=require('fs');const p=process.env.USERPROFILE+'/.config/opencode/opencode.json';const c=JSON.parse(fs.readFileSync(p,'utf8'));if(c.mcp?.['thunderbird-mail']){c.mcp['thunderbird-mail'].enabled=true;fs.writeFileSync(p,JSON.stringify(c,null,2));console.log('thunderbird-mail enabled (Thunderbird is running)')}else{console.log('thunderbird-mail not found in config')}"
```

若 Thunderbird **未运行** → 确保 `enabled` 为 `false`：

```
node -e "const fs=require('fs');const p=process.env.USERPROFILE+'/.config/opencode/opencode.json';const c=JSON.parse(fs.readFileSync(p,'utf8'));if(c.mcp?.['thunderbird-mail']){c.mcp['thunderbird-mail'].enabled=false;fs.writeFileSync(p,JSON.stringify(c,null,2));console.log('thunderbird-mail disabled (Thunderbird is not running)')}"
```

- 若 `opencode.json` 中不存在 `thunderbird-mail` 条目，跳过不做任何修改。
- 处理完成后报告当前状态（已启用 / 已禁用 / 无此 MCP）。
- 此步骤在**校验解压出的配置之后**、**还原环境变量之前**执行。

### 运行时命令可用性检测与 MCP 自动启用/禁用

导入时检查 `dart`、`gopls` 命令是否在 PATH 中可用，据此自动决定对应 MCP 的启用状态：

**检测命令**：

- Windows (cmd)：
  ```
  where dart 2>nul >nul && echo DART_OK || echo DART_MISSING
  where gopls 2>nul >nul && echo GOPLS_OK || echo GOPLS_MISSING
  ```
- macOS / Linux (bash)：
  ```
  which dart >/dev/null 2>&1 && echo DART_OK || echo DART_MISSING
  which gopls >/dev/null 2>&1 && echo GOPLS_OK || echo GOPLS_MISSING
  ```

**处理逻辑**（用 Node 批量修改，`workdir` = 用户主目录）：

```
node -e "const fs=require('fs'),{execSync}=require('child_process');const p=process.env.USERPROFILE+'/.config/opencode/opencode.json';const c=JSON.parse(fs.readFileSync(p,'utf8'));const chk=name=>{try{execSync(process.platform==='win32'?'where '+name:'which '+name,{stdio:'ignore'});return true}catch{return false}};let changed=false;if(c.mcp?.['dart-mcp-server']){c.mcp['dart-mcp-server'].enabled=chk('dart');console.log('dart-mcp-server '+(c.mcp['dart-mcp-server'].enabled?'enabled':'disabled')+' (dart '+(c.mcp['dart-mcp-server'].enabled?'found':'not found')+')');changed=true}if(c.mcp?.['gopls']){c.mcp['gopls'].enabled=chk('gopls');console.log('gopls '+(c.mcp['gopls'].enabled?'enabled':'disabled')+' (gopls '+(c.mcp['gopls'].enabled?'found':'not found')+')');changed=true}if(changed)fs.writeFileSync(p,JSON.stringify(c,null,2));else console.log('no runtime-dependent MCPs found in config')"
```

- 若 `opencode.json` 中不存在对应条目，跳过不做任何修改。
- 处理完成后报告各 MCP 当前状态（已启用 / 已禁用 / 无此 MCP）。
- 此步骤在**校验解压出的配置之后**、**还原环境变量之前**执行，与 Thunderbird 检测并列。

### 还原环境变量

解压后，在 `%USERPROFILE%\opencode_config.env`（Windows）或 `$HOME/opencode_config.env`（Unix）应有环境变量文件。执行以下步骤：

1. 读取 `opencode_config.env` 内容，逐行解析 `VAR=value` 格式。
2. 逐条列出需要设置的环境变量，**标记哪些值为空**（导出时该变量未在当前系统设置）。
3. **值为空的变量**：提示用户手动填写（导入到新机器后，API 密钥需要重新获取）。
4. **有值的变量**：询问用户是否一并设置。**其中 `MYMCP_PROXY_SERVER` 应优先设置**——它是 brave-search、g-search、fetcher 三个 MCP 代理补丁的统一入口变量（优先级高于各补丁硬编码的 fallback 地址），只需这一个变量即可统一切换所有 MCP 的代理。对于用户确认的变量，用以下命令写入系统环境变量：

Windows (cmd)，以管理员权限运行：
```cmd
SETX VAR_NAME "value"
```

PowerShell（无需管理员，仅当前用户）：
```powershell
[Environment]::SetEnvironmentVariable('VAR_NAME', 'value', 'User')
```

macOS / Linux (bash)：
```bash
echo 'export VAR_NAME="value"' >> ~/.zshrc  # or ~/.bashrc
```

5. 设置完成后的环境变量在**下次 opencode 启动时**才会被读取，提醒用户重启 opencode。
6. `opencode_config.env` 含 API 密钥；在还原完成、且后续步骤（重装依赖等）不再需要读取它之后，按「清理临时文件（安全删除）」先覆盖再删除。

### 导入后重装依赖（重建导出时被排除的包）

因为导出时排除了所有可重新获取的包 / 产物，导入后必须重新安装它们：

1. **Node 依赖（本地项目）**：在 `~/.config/opencode` 及 `~/.agents` 下查找所有含 `package.json`（且缺少 `node_modules`）的目录，逐个执行安装。
    - 有 `package-lock.json` 时优先 `npm ci`（严格按锁文件复现）；否则 `npm install`。
 2. **Node MCP 部署**：遍历 `opencode.json` 中所有 `command` 为 `["node", ...]` 且使用绝对路径的 Node MCP，确保对应 npm 包已全局安装。
     - **需代理的**（brave-search、g-search、fetcher）：按 `yashi-mcp-proxy-injection` skill 部署：全局安装指定版本包、按 A/B 方法注入代理补丁、固化 `node` 启动路径、安装 undici / Chromium 等依赖（先询问用户是否打补丁及代理地址）。
     - **不需代理的**（encoding-aware-fs 等）：直接 `npm i -g <包名>`，无需注入补丁。注意 `encoding-aware-fs` 建议同时 `pip install chardet` 以提高编码检测准确率。
 3. **Python (uvx) MCP**：无需手动预装，uvx 首次启动对应服务时会自动下载。
    - 检查 `uvx --help` 确认 uv 就绪。
    - **路径修正**：若 `command` 中 `uvx` 使用的是旧机绝对路径（如 `C:\Users\...\Python\Python313\Scripts\uvx.exe`）而本机 uvx 实际在其它位置，优先改为 `"uvx"` 简洁形式（只要 uvx 在 PATH 中），无需硬编码绝对路径。同理 Unix 上 `/home/xxx/.local/bin/uvx` → `"uvx"`。
 4. **Playwright / 浏览器二进制**：若启用 `playwright` 或 `fetcher` 等依赖浏览器的 MCP，安装 Chromium：
    - 执行 `npx playwright install chromium`（在任何目录均可，自动使用 npm 缓存中的 playwright）。
    - `@playwright/mcp` 首次 npx 启动时也会自动处理。
    - 注意：`rtk` 等命令包装器可能无法正确传递 `npx playwright`（解析失败），此时应降级为直接调用原生 `npx playwright install chromium`。
 5. 安装过程中的报错逐项汇报并给出修复建议。
 6. **非 npm 注册表的 Node MCP（优先 npx，备选 GitHub 仓库）**：若 `npm i -g <pkg>` 报 E404，优先检查是否有替代的 npm/npx 包（如 `thunderbird-mcp` → `thunderbird-cli-mcp`，改用 `npx -y thunderbird-cli-mcp`）。若确无替代，则从源码仓库 clone：
     - 用 `git clone --depth 1 <repo_url> <npm_global>\<pkg_name>` 克隆到本机 npm 全局目录下（与其它全局包平级），或克隆到常规目录再修正路径。
     - 克隆后检查 `package.json`：若有 `dependencies` 则 `npm install`；`devDependencies` 可跳过。
     - 若包入口已在 `bin` 字段声明或直接为根目录 JS/CJS 文件，路径修正为 `<npm_global>\<pkg_name>\<entry_file>`。
     - git clone 可能遇 SSL 证书问题（代理环境常见），添加 `-c http.sslVerify=false`。

### 导入后校验（必须执行并汇报）

读取还原后的 `~/.config/opencode/opencode.json`，对其中 `enabled` 为 true 的每个 `mcp` 服务逐项检查：

1. **命令可用性**：`command[0]` 指向的可执行文件是否在 PATH 或存在。
   - 用 `where`（Windows）/ `which`（Unix）检查 `node` / `npx` / `dart` / `gopls` / `uvx` 等。
   - 缺失则指出需安装的运行时（Node.js、Python+uv、Dart SDK、gopls…）。
   - `encoding-aware-fs` 如已启用，额外检测 Python + chardet 是否可用（`python -c "import chardet"`），不可用时提示 `pip install chardet` 提高编码检测准确率。
  2. **绝对路径依赖**：`command` 里出现的绝对文件路径是否存在（如 `C:\npm\node_modules\...\index.js`、`mcp-bridge.cjs`）。
    - 跨平台迁移时这类 Windows 绝对路径通常需要按本机改写，明确列出需修改项。
    - **npm 全局包路径修复**：若配置中硬编码了 npm 全局 install 目录下的绝对路径（如 `C:\npm\node_modules\...`），可通过检测本机 opencode 自身位置来推断实际 npm 全局目录，进而批量修正或安装缺失的 MCP 包：
      - Windows (cmd)：`where opencode`，取 opencode 所在目录，其同级 `node_modules\` 即为本机 npm 全局包目录。例如 `C:\npm\opencode` → 全局包在 `C:\npm\node_modules\`；`%APPDATA%\npm\opencode` → 全局包在 `%APPDATA%\npm\node_modules\`。
      - macOS / Linux (bash)：`which opencode`，opencode 通常通过 npm 全局安装，其所在路径可推断 npm 全局 `node_modules/`（常见为 `/usr/local/lib/node_modules/` 或 npm prefix -g 输出）。辅助确认：`npm root -g`。
      - **路径修正流程**：将 MCP 配置中指向旧全局目录的绝对路径，替换为本机实际全局 `node_modules\` 下的对应路径；若本机全局目录下也没有该包，则提示用户 `npm i -g <包名>` 安装。
 3. **环境变量 / 密钥**：读取 `opencode_config.env` 与 `opencode.json` 对比：
     - 列出 `opencode.json` 中所有 `{env:...}` 引用的变量，以及 `MYMCP_PROXY_SERVER`（MCP 代理补丁的统一入口变量，不在 opencode.json 中但在 `.env` 中）。
     - 逐个检查当前系统环境变量是否已设置：Windows `ECHO %VAR%` / Unix `echo $VAR`。
     - 未设置的变量，若 `.env` 中有值则提示用户参考设置；若 `.env` 中也无值则提示用户手动填写。
4. **MCP 可用性**：在可能的情况下实际验证连通（例如触发一次对应 MCP 的最简调用，或提示用户重启 opencode 后用 `/mcp` 查看服务状态）。无法在当前会话内直连时，明确告知需重启验证。

再检查**导入的 skill 是否适配本机**：

- 遍历 `~/.agents/skills/**/SKILL.md` 与 `~/.config/opencode/skills/**/SKILL.md`。
- 检查 skill 中引用的工具 / 命令 / 绝对路径 / 平台假设（如仅限 Windows 的 `.bat`、特定盘符、特定二进制）在本机是否成立。
- 对不适用于当前操作系统或缺少依赖的 skill，逐条列出并说明原因与修复建议。

最后输出一份简明校验报告：可用项、需修复项（含具体命令 / 路径）、以及
校验报告末尾必须以三张表格汇总当前配置状态，并标注导入时的更改：

**表 1 — Agents**

| Agent | Temperature | Top P | Provider |
|-------|------------|-------|----------|
| ...   | ...        | ...   | ...      |

**表 2 — Models / Providers**

| Provider | 模型列表 |
|----------|---------|
| ...      | ...     |

**表 3 — MCP**

| 名称 | 启用 | 类型 | 导入更改 |
|------|------|------|---------|
| ...  | 是/否 | local/remote | （无修改 / 路径修正: C 盘→D 盘 / uvx 路径简化 / 代理补丁注入 / 自动禁用: dart 不可用 / 自动禁用: gopls 不可用 / 自动禁用: Thunderbird 未运行 等） |

输出时以最终的 `~/.config/opencode/opencode.json` 内容为准。“导入更改”列须写明导入过程中对该条目的实质性修改；无修改则写“无修改”

## 清理临时文件（安全删除）

导入与导出流程结束后，都必须删除过程中产生的所有临时文件，尤其是含密钥的文件，避免残留。

**规则**：

- **含 token 的临时文件**（如 `opencode_config.env`，内含各服务 API 密钥）：**先用随机数据覆盖再删除**，不可直接 `del` / `rm`（防止被恢复工具还原）。
- **不含敏感信息的临时文件**（配置转换的中间文件、临时脚本等）：直接删除即可（Windows `del /f`，Unix `rm -f`）。
- **最终产物不清理**：导出的 `opencode_config.7z`、`opencode_config.7z.sha256` 保留；配置转换生成的备份（`*.bak`）由用户决定去留。

**各场景待清理的临时文件**：

- **导出后**：主目录 `opencode_config.env`（已打包入 .7z，主目录副本须安全删除）。
- **导入后**（在还原环境变量、重装依赖等全部完成、不再需要读取密钥之后）：解压出的 `~/opencode_config.env` 须安全删除。

**安全删除命令**（node 覆盖后删除，跨平台一致；`workdir` = 主目录，即 Windows `%USERPROFILE%` / Unix `$HOME`）：

```
node -e "const fs=require('fs'),c=require('crypto');for(const f of ['opencode_config.env']){try{if(!fs.existsSync(f)){console.log('absent',f);continue}const n=fs.statSync(f).size+16;fs.writeFileSync(f,c.randomBytes(n));fs.writeFileSync(f,Buffer.alloc(n,0));fs.unlinkSync(f);console.log('shredded',f)}catch(e){console.log('ERR',f,e.message)}}"
```

- 若过程中生成了其它临时文件，把文件名加入上面的列表（一并安全删除），或对无敏感内容者直接删除。

## 说明

- 配置在 opencode 启动时一次性加载，导入后必须提醒用户**退出并重启 opencode** 才会生效。
- 导入会覆盖本机现有 opencode 设置，属预期行为；如用户希望保留旧配置，建议其先执行一次导出作为备份。
- **`MYMCP_PROXY_SERVER`** 是 brave-search、g-search、fetcher 三个 MCP 代理补丁的统一环境变量。补丁中的代理选取优先级为：`MYMCP_PROXY_SERVER` > 各 MCP 专用变量（`HTTPS_PROXY` / `GSEARCH_PROXY_SERVER` / `FETCHER_PROXY_SERVER`）> 硬编码 fallback 地址。导出时自动纳入 `.env`，导入时应优先提示用户设置此变量。
- **`encoding-aware-fs`** 是编码感知文件操作 MCP，不含网络调用故不需代理。其编码行为由项目级 `.encoding-converter.json` 控制（非全局配置，不参与导出/导入）；导入后各项目需单独创建该文件并配置 `sourceEncoding`。
