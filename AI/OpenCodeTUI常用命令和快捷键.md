# OpenCode TUI 常用命令和快捷键

> 备忘整理自 [OpenCode 官方文档](https://opencode.ai/docs/)，最后更新：2026-06-01

> **平台键位对照**：`Super` = Win（Windows）/ Super（Linux）/ Cmd⌘（macOS）；`Alt` = Alt（Windows/Linux）/ Option⌥（macOS）

---

## 启动与基础

```bash
opencode                    # 在当前目录启动 TUI
opencode /path/to/project   # 在指定目录启动 TUI
```

- `@文件名` — 模糊搜索并引用项目中文件，文件内容自动加入上下文
- `!命令` — 以 `!` 开头直接执行 Shell 命令，输出作为工具结果加入对话

---

## 斜杠命令（输入 `/` 触发）

| 命令                       | 说明                                  | 默认快捷键 |
| -------------------------- | ------------------------------------- | ---------- |
| `/connect`                 | 添加/切换 AI 提供商                   |            |
| `/init`                    | 创建或更新项目 AGENTS.md              |            |
| `/help`                    | 显示帮助对话框                        |            |
| `/models`                  | 列出可用模型                          | `ctrl+x m` |
| `/themes`                  | 列出可用主题                          | `ctrl+x t` |
| `/editor`                  | 打开外部编辑器撰写消息                | `ctrl+x e` |
| `/new` 或 `/clear`         | 新建会话                              | `ctrl+x n` |
| `/sessions` 或 `/resume`   | 列出/切换会话                         | `ctrl+x l` |
| `/compact` 或 `/summarize` | 压缩当前会话上下文                    | `ctrl+x c` |
| `/undo`                    | 撤销上一条消息及文件变更              | `ctrl+x u` |
| `/redo`                    | 重做被撤销的消息                      | `ctrl+x r` |
| `/share`                   | 分享当前会话（生成链接）              |            |
| `/unshare`                 | 取消分享当前会话                      |            |
| `/export`                  | 导出会话为 Markdown，用外部编辑器打开 | `ctrl+x x` |
| `/details`                 | 切换工具执行详情显示                  |            |
| `/exit` 或 `/quit` 或 `/q` | 退出 OpenCode                         | `ctrl+x q` |
| `/thinking`                | 切换是否显示模型的推理过程            |            |

---

## 全局快捷键

> Leader 键默认为 `ctrl+x`，超时时间 `2000ms`（可在 `tui.json` 中修改 `leader_timeout`）

### 会话与会话导航

| 快捷键     | 功能                |
| ---------- | ------------------- |
| `ctrl+x n` | 新建会话            |
| `ctrl+x l` | 列出/切换会话       |
| `ctrl+r`   | 重命名当前会话      |
| `ctrl+d`   | 删除当前会话        |
| `Esc`      | 中断正在运行的会话  |
| `ctrl+x u` | 撤销最后一条消息    |
| `ctrl+x r` | 重做被撤销的消息    |
| `ctrl+x c` | 压缩会话上下文      |
| `ctrl+x g` | 会话时间线视图      |
| `ctrl+x x` | 导出会话为 Markdown |
| `ctrl+x y` | 复制消息            |

### 子会话导航（Subagent 模式）

| 快捷键     | 功能               |
| ---------- | ------------------ |
| `ctrl+x ↓` | 进入第一个子会话   |
| `→`        | 切换到下一个子会话 |
| `←`        | 切换到上一个子会话 |
| `↑`        | 返回父会话         |

### 模式切换

| 快捷键      | 功能                                        |
| ----------- | ------------------------------------------- |
| `Tab`       | 循环切换 Agent（如 Plan 模式 / Build 模式） |
| `Shift+Tab` | 反向循环切换 Agent                          |
| `ctrl+t`    | 循环切换模型变体                            |
| `ctrl+x a`  | Agent 列表                                  |
| `ctrl+x m`  | 模型列表                                    |
| `ctrl+a`    | 模型提供商列表                              |
| `ctrl+f`    | 收藏/取消收藏当前模型                       |
| `F2`        | 切换到最近使用的模型                        |
| `Shift+F2`  | 反向切换到最近使用的模型                    |

### 视图与界面

| 快捷键       | 功能                                         |
| ------------ | -------------------------------------------- |
| `ctrl+p`     | 打开命令面板（可搜索用户名显示、主题等设置） |
| `ctrl+x b`   | 切换侧边栏                                   |
| `ctrl+x s`   | 状态视图                                     |
| `ctrl+x t`   | 主题列表                                     |
| `ctrl+x h`   | 切换提示/隐藏内容显示                        |
| `ctrl+alt+k` | 切换 Which Key 提示                          |
| `ctrl+z`     | 挂起到后台（仅 Linux/macOS；Windows 上此键被禁用，改为输入框撤销） |

### 其他

| 快捷键                             | 功能                   |
| ---------------------------------- | ---------------------- |
| `ctrl+x e`                         | 外部编辑器打开消息编辑 |
| `ctrl+c` 或 `ctrl+d` 或 `ctrl+x q` | 退出 OpenCode          |
| `ctrl+x q`                         | 退出                   |

---

## 消息区域滚动

| 快捷键                    | 功能             |
| ------------------------- | ---------------- |
| `PageUp` / `ctrl+alt+b`   | 向上翻页         |
| `PageDown` / `ctrl+alt+f` | 向下翻页         |
| `ctrl+alt+y`              | 向上滚动一行     |
| `ctrl+alt+e`              | 向下滚动一行     |
| `ctrl+alt+u`              | 向上翻半页       |
| `ctrl+alt+d`              | 向下翻半页       |
| `ctrl+g` / `Home`         | 跳到第一条消息   |
| `ctrl+alt+g` / `End`      | 跳到最后一条消息 |

---

## 输入框快捷键（类 Emacs/Readline 风格）

### 光标移动

| 快捷键                       | 功能             |
| ---------------------------- | ---------------- |
| `←` / `ctrl+b`               | 光标左移一个字符 |
| `→` / `ctrl+f`               | 光标右移一个字符 |
| `↑`                          | 光标上移         |
| `↓`                          | 光标下移         |
| `ctrl+a`                     | 移到行首         |
| `ctrl+e`                     | 移到行尾         |
| `Home`                       | 移到输入框开头   |
| `End`                        | 移到输入框末尾   |
| `alt+b` / `alt+←` / `ctrl+←` | 光标左移一个词   |
| `alt+f` / `alt+→` / `ctrl+→` | 光标右移一个词   |
| `alt+a`                      | 移到视觉行首     |
| `alt+e`                      | 移到视觉行尾     |

### 文本选择

| 快捷键                        | 功能             |
| ----------------------------- | ---------------- |
| `Shift+←`                     | 向左选择字符     |
| `Shift+→`                     | 向右选择字符     |
| `Shift+↑`                     | 向上选择         |
| `Shift+↓`                     | 向下选择         |
| `ctrl+shift+a`                | 选择到行首       |
| `ctrl+shift+e`                | 选择到行尾       |
| `Shift+Home`                  | 选择到输入框开头 |
| `Shift+End`                   | 选择到输入框末尾 |
| `alt+shift+b` / `alt+shift+←` | 向左选择一词     |
| `alt+shift+f` / `alt+shift+→` | 向右选择一词     |
| `Super+a`                     | 全选（Win+a / Cmd⌘+a） |

### 删除与编辑

| 快捷键                                        | 功能               |
| --------------------------------------------- | ------------------ |
| `Backspace`                                   | 删除光标前一个字符 |
| `ctrl+d` / `Delete`                           | 删除光标处字符（macOS：`Fn+Delete` 为前向删除） |
| `ctrl+k`                                      | 删除从光标到行尾   |
| `ctrl+u`                                      | 删除从光标到行首   |
| `ctrl+shift+d`                                | 删除整行           |
| `ctrl+w` / `ctrl+Backspace` / `alt+Backspace` | 删除光标前一个词   |
| `alt+d` / `alt+Delete` / `ctrl+Delete`        | 删除光标后一个词   |
| `ctrl+-` / `Super+z`                          | 撤销（输入框内）；Win+z / Cmd⌘+z        |
| `ctrl+.` / `Super+Shift+z`                    | 重做（输入框内）；Win+Shift+z / Cmd⌘+Shift+z |

> **Windows**：`input_undo`（输入框撤销）额外支持 `ctrl+z`（因为 Windows 终端不支持 POSIX 挂起，故 `ctrl+z` 被重新映射为撤销）。`terminal_suspend`（挂起到后台）被强制设为 `none`。

### 提交与换行

| 快捷键                                                | 功能     |
| ----------------------------------------------------- | -------- |
| `Enter`                                               | 提交消息 |
| `Shift+Enter` / `ctrl+Enter` / `alt+Enter` / `ctrl+j` | 输入换行 |

> **Windows Terminal**：默认不发送 `Shift+Enter` 修饰键序列，需在 `settings.json` 中配置 `sendInput` 转义序列 `\u001b[13;2u`，详见[官方文档](https://opencode.ai/docs/keybinds/#shiftenter)。

### 历史与补全

| 快捷键         | 功能             |
| -------------- | ---------------- |
| `↑`            | 上一条历史消息   |
| `↓`            | 下一条历史消息   |
| `Tab`          | 自动补全确认     |
| `Esc`          | 隐藏自动补全弹窗 |
| `↑` / `ctrl+p` | 补全列表中上移   |
| `↓` / `ctrl+n` | 补全列表中下移   |
| `Enter`        | 选中当前补全项   |

### 其他输入操作

| 快捷键   | 功能                          |
| -------- | ----------------------------- |
| `ctrl+c` | 清空当前输入                  |
| `ctrl+v` | 粘贴                          |
| `ctrl+t` | 调换相邻字符位置              |
| `ctrl+g` | 取消弹窗 / 中止正在运行的响应 |

---

## 对话框快捷键

| 快捷键         | 功能                     |
| -------------- | ------------------------ |
| `↑` / `ctrl+p` | 选中项上移               |
| `↓` / `ctrl+n` | 选中项下移               |
| `PageUp`       | 选中列表上翻页           |
| `PageDown`     | 选中列表下翻页           |
| `Home`         | 跳到列表第一项           |
| `End`          | 跳到列表最后一项         |
| `Enter`        | 确认提交                 |
| `Space`        | 切换 MCP 开关 / 插件开关 |
| `ctrl+f`       | 权限提示全屏             |
| `Shift+i`      | 安装插件                 |

---

## 自定义配置文件

OpenCode TUI 的快捷键和外观可通过以下配置文件自定义：

- `tui.json`（或 `tui.jsonc`）— 主题、快捷键、滚动等 TUI 行为
- `opencode.json`（或 `opencode.jsonc`）— 服务端/运行时配置、自定义命令

自定义命令：

- Markdown 格式放于 `.opencode/commands/`（项目级）或 `~/.config/opencode/commands/`（全局）
- 也支持直接在 `opencode.json` 中以 JSON 定义

> 原文档链接：https://opencode.ai/docs/tui/ | https://opencode.ai/docs/keybinds/ | https://opencode.ai/docs/commands/
