# DeepSeek Harness CLI 启动参数

记录两条启动链路的参数面：

- `npx @deepseek-ai/dsh`（不带 `web`）：官方 CLI 入口（`@deepseek-ai/dsh/lib/bin.js`）。
- `dsh-tui`（`@deepseek-harness-tui/dsh-tui` 0.9.0）：终端 TUI 的直达命令，双态启动器，最终委托 `dsh --profile dsh-tui` 启动。

## 参数分层

与 `dsh web` 一致，参数分两层：

- **启动器层**：由 `dsh` 入口（`@deepseek-ai/dsh/lib/bin.js`）解析。
- **应用层**：启动器无法识别的第一个 token 起，剩余参数原样透传给所启动 profile 的应用自己解析。

启动器 flag 必须写在最前。

## 一、启动器层自有参数

| 参数 | 说明 |
|---|---|
| `--profile <name>` | 启动 `$DSH_HOME/profiles/<name>` 下的 profile；根命令下**必需**（不带会报错 `--profile <name> is required`） |
| `--patch <path>` | 额外补丁覆盖层，应用在 profile 层之后；可重复 |
| `--dump-config` | 打印组合后的配置树（含用户层与 `--patch`）并退出 |
| `--dump-default-config` | 打印 bundle 层（不含用户层）并退出 |
| `-V, --version` | 输出版本号 |
| `--help` | 打印启动器自己的帮助 |
| `[args...]` | 剩余参数原样透传给所启动 profile 的应用自己解析 |

## 二、子命令

| 子命令 | 说明 |
|---|---|
| `web` | `--profile web` 的别名，参数见《DeepSeekHarnessWeb启动参数.md》 |
| `plugin --profile <name> <pnpm args...>` | 在 profile 目录内转发给 pnpm 管理插件（`add <pkg>`、`remove <pkg>`、`why <pkg>` 等）；profile 首次使用自动初始化，并自动把声明了 `dsh.bundle` 的依赖收进 bundle 层 |

## 三、透传给 profile 应用层的参数

- **headless**（一次性任务）：
  - 位置参数 `[task...]`：任务文本，多个词自动用空格连接；**必填**（缺失或纯空白会报错）
  - `-h, --help`
- **web**：`--host`、`--port`、`--trusted-host`、`-h, --help`（默认 `127.0.0.1:3080`，详见《DeepSeekHarnessWeb启动参数.md》）
- **tui**（终端应用，profile 名 `dsh-tui`；以下已按本机 `@deepseek-harness-tui/dsh-tui` 0.9.0 的 bin/dsh-tui.js 验证）：
  - 启动方式：`dsh-tui`（全局瘦壳 → 委托 profile 副本）或 `dsh --profile dsh-tui`（直接启动，等价）。
  - `dsh-tui` 启动器自己拦截：`--resume [<id>]`、`-c`、`--continue`、`--resume=<id>`（恢复会话；缺 id 时读取 `~/.dsh-tui/resume.txt`（旧 `~/.dsh-cc/resume.txt`）记录的最后目标，经环境变量 `DSH_TUI_RESUME_SESSION` 传给应用）。
  - 位置参数（绝对路径 / URL / 已存在的路径）：作为工作区目标，经环境变量 `DSH_TUI_WORKSPACE_TARGET` 传入。
  - 其余参数原样透传给 `dsh --profile dsh-tui`，再由 dsh 启动器 / 应用层处理。
  - 环境变量：`DSH_TUI_LANG`、`DSH_TUI_THEME`、`DSH_TUI_PERSONA`、`DSH_TUI_PRESET`、`DSH_TUI_DISABLE_MOUSE`、`DSH_TUI_DEBUG`、`DSH_TUI_COMPACT_RATIO`、`DSH_TUI_COMPACT_RETAIN`、`DSH_TUI_RENDER_LOG`、`DSH_TUI_SESSION_ROOT`、`DSH_TUI_WORKSPACE`；旧名 `CC_TUI_*` / `DSH_CC_*` 已更名，设置时打印告警且不再生效。
  - 首次运行：自动自举 `dsh plugin --profile dsh-tui add @deepseek-harness-tui/dsh-tui@<版本>`，无需手工创建 profile。

## 四、解析顺序与限制

- 启动器 flag 必须写在最前：`dsh --profile web --port 8080` 中 `--port` 归 web 应用；`dsh --profile web --help` 打印的是 web 应用的帮助，`dsh --help` 才是启动器的帮助。
- `--dump-config` 与 `--dump-default-config` 互斥。
- dump 模式不接受应用参数；`--dump-default-config` 不接受 `--patch`。
- `--patch` 必须带路径。
- 父级选项不能与 `web`/`plugin` 子命令混用。
- 运行目录即默认 workspace 根。
- `web`、`headless` profile 首次使用自动从模板初始化；其他 profile 需通过 `dsh plugin` 创建（例外：`dsh-tui` 直达命令首次运行自动自举 `dsh-tui` profile）。

## 五、常见用法示例

```bash
# 查看启动器自己的帮助 / 版本
npx @deepseek-ai/dsh --help
npx @deepseek-ai/dsh -V

# 启动 web 界面（--port 属于 web 应用）
npx @deepseek-ai/dsh --profile web --port 8080

# 一次性任务：运行一个新会话，打印最终答案后退出
npx @deepseek-ai/dsh --profile headless "run the tests"

# 启动终端 TUI（dsh-tui 直达命令；首次运行自动初始化 dsh-tui profile）
dsh-tui

# 恢复终端会话（--resume 等由 dsh-tui 启动器拦截；等价于 dsh --profile dsh-tui）
dsh-tui --resume <id>
dsh-tui -c

# 打印组合配置树后退出（不启动应用）
npx @deepseek-ai/dsh --profile web --dump-config
npx @deepseek-ai/dsh --profile web --dump-default-config

# 叠加额外补丁层启动
npx @deepseek-ai/dsh --profile web --patch extra.yml

# 管理 profile 插件（转发给 pnpm）
npx @deepseek-ai/dsh plugin --profile dsh-tui add <package>
npx @deepseek-ai/dsh plugin --profile dsh-tui remove <package>
npx @deepseek-ai/dsh plugin --profile web why <package>
```
