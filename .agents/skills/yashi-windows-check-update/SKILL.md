---
name: yashi-windows-check-update
description: 检查 Windows 11/10/Server 的最新功能更新，从 Microsoft 发布健康页面和 Update Catalog 提取 KB 信息及下载链接。适用于 x64/ARM64 架构。
---
<!--
提问示例：
- 获取 Windows10 22H2, Windows11 25H2, Windows2025 的 x64 最新功能更新，并整理到 list.txt。
- 获取 Windows 11 26H1 x64 的最新功能更新
- 获取 Windows 10 22H2 x64 的最新功能更新
- 获取 Windows Server 2025 x64 的最新功能更新
- 获取 Windows 10,11,2025 x64 的最新功能更新
- 获取 Windows 11 24H2 和 25H2 x64 的最新 B 更新
- 检查当前系统的最新更新（自动检测版本和架构）
-->

# Windows 更新包检查

## 前置条件

| 阶段 | 工具 | 说明 |
|------|------|------|
| 步骤 1–5（提取 KB 信息） | WebFetch | Microsoft Learn 和 Catalog 搜索页均为静态 HTML |
| 步骤 6（提取下载链接） | Playwright MCP 浏览器 | Catalog 的 DownloadDialog 通过 JS 动态加载 .msu 链接，WebFetch 无法获取 |

Playwright MCP 配置（`opencode.json` → `mcp`）：

```json
"playwright": {
  "enabled": true,
  "type": "local",
  "command": ["npx", "-y", "@playwright/mcp@latest", "--headless", "--viewport-size=1280x720"]
}
```

首次运行会自动下载 Chromium（约 150MB），配置后需重启 opencode。

---

## 步骤 0：检查 JS 执行能力（强制前置）

在开始任何步骤之前，先检查当前环境是否具备 **浏览器 JavaScript 执行能力**：

- 如果已有 `playwright_browser_navigate` 等 Playwright MCP 工具可用 → **继续执行**
- 如果**没有**这些工具 → **立即停止**，输出以下内容告知用户，不继续后续步骤：

> 当前环境缺少 Playwright MCP 浏览器工具，无法从 Microsoft Update Catalog 提取下载链接（DownloadDialog 需要 JS 动态加载）。
>
> 请在 `opencode.json` 的 `mcp` 中添加：
> ```json
> "playwright": {
>   "enabled": true,
>   "type": "local",
>   "command": ["npx", "-y", "@playwright/mcp@latest", "--headless", "--viewport-size=1280x720"]
> }
> ```
> 配置后重启 opencode 即可。首次运行会自动下载 Chromium（约 150MB）。

---

## 工作流程

### 1. 收集系统信息

从用户输入提取三项信息；未提供时用以下命令自动检测：

| 变量 | 说明 | 示例值 |
|------|------|--------|
| `$winVer` | 主版本号（年份 = Server） | `10`、`11`、`2025` |
| `$featureUpdate` | 功能更新代号 | `22H2`、`26H1` |
| `$arch` | CPU 架构 | `x64`、`ARM64` |

```powershell
$winVer = [regex]::Match((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ProductName, '\d+').Value
$featureUpdate = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion
$arch = if ($env:PROCESSOR_ARCHITEW6432) { $env:PROCESSOR_ARCHITEW6432 } else { $env:PROCESSOR_ARCHITECTURE }
```

### 2. 获取发布信息页面

所有 WebFetch 请求须使用 `Accept-Language: zh-CN` 以确保返回简体中文页面：

| `$winVer` | 页面 URL |
|-----------|----------|
| 年份（如 2025） | `https://learn.microsoft.com/zh-cn/windows/release-health/windows-server-release-info` |
| `10` | `https://learn.microsoft.com/zh-cn/windows/release-health/release-information` |
| `11` | `https://learn.microsoft.com/zh-cn/windows/release-health/windows11-release-information` |

### 3. 定位最新版本

- **Win10/11**：找到「发行历史记录」章节 → 找第一个条目如 `版本 26H1 (OS build 28000)` → 取该版本子表格
- **Server**：找到「发布历史记录」章节 → 在副标题中找最新年份（如 `Windows Server 2025`）

### 4. 提取更新条目

在版本子表格中按规则筛选：

1. 「服务选项」列 = `正式发布频道`（Win10/11）或 `LTSC`（Server）
2. 「更新类型」列：仅取后缀为 **B** 的最新条目
3. 若该 B 条目之前有 **OOB**（带外更新），一并收集
4. 若子表格缺少分类汇总表所列的最新 B 条目，以汇总表为准
5. 提取「知识库文章」列的 KB 编号文本（如 `KB5050009`，不要完整 URL）

### 5. 搜索 Catalog（WebFetch）

对每个 KB 访问：

```
https://www.catalog.update.microsoft.com/Search.aspx?q=KB5050009
```

在搜索结果中用 `$winVer` + `$featureUpdate` + `$arch` 筛选匹配行。

### 6. 提取下载链接（Playwright MCP 浏览器）

对每个 KB 按以下子步骤操作：

**6.1 导航**

```
browser_navigate → https://www.catalog.update.microsoft.com/Search.aspx?q=KB5050009
```

**6.2 点击 Download**

用 browser_snapshot 找到目标 row 的 Download 按钮 ref，通过 browser_click(ref) 点击。

**6.3 切换标签页**

点击后弹出新标签页 → `browser_tabs(action='select', index=1)`

**6.4 等待 JS 加载**

```
browser_wait_for(time=2)
```

**6.5 提取链接**

browser_snapshot → 从 link 元素的 `/url` 属性提取 `.msu` 直链，同时提取 SHA1/SHA256。

**SSU 过滤**：DownloadDialog 中可能出现两个 `.msu`，其中一个是系统自动处理的 SSU（文件名 KB 编号与目标不一致），**丢弃 SSU，只输出目标 KB 对应的 .msu**。

**6.6 关闭标签页，处理下一个**

```
browser_tabs(action='close', index=1)
```

### 7. 输出结果

```markdown
## 更新类型 日期 内部版本 KB号

- URL
  - SHA1: xxxx
  - SHA256: xxxx
```

标题格式（各字段间只能有一个空格）：`2026-05 B 2026-05-12 28000.2113 KB5089548`

---

## 关键注意点

1. **WebFetch 语言**：请求 Microsoft Learn 和 Catalog 页面时，一律指定 `Accept-Language: zh-CN`
2. **汇总表优先**：若版本次级表格中找不到汇总表所列的最新 B 条目，以分类汇总表数据为准
3. **架构匹配**：Catalog 页中架构可能以 `x64`/`amd64`、`ARM64`/`arm64` 等形式出现，匹配时大小写不敏感
4. **DownloadDialog 时机**：DownloadDialog.aspx 通过 ASP.NET AJAX 加载数据，需等待约 2 秒再 snapshot
5. **快照 ref 优先**：用 snapshot 中的 ref 定位元素，比文字匹配更可靠
6. **多版本隔离**：Win10 页面可能包含 Win11 表格，严格按用户指定的版本筛选
