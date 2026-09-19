# DeepSeek Harness Web 启动参数

记录 `npx @deepseek-ai/dsh web` 命令支持的参数。

## 参数分层

参数分两层：**启动器（launcher）层**和 **web 应用层**（透传参数）。

- 启动器层：由 `dsh` 入口（`@deepseek-ai/dsh/lib/bin.js`）解析，`web` 是 `--profile web` 的硬编码别名。
- Web 应用层：剩余参数原样透传给 web 应用，由 `web-startup` 提供方（`@deepseek-ai/dsh-web-app/lib/startup.js`）解析。

## 一、启动器层参数（`dsh web` 子命令自身）

| 参数 | 说明 |
|---|---|
| `--patch <path>` | 额外的 patch 覆盖层，应用在 profile 层之后；**可重复**（如 `--patch a.yml --patch b.yml`） |
| `--dump-config` | 打印组合后的 web-profile 配置树（含用户层和 `--patch`）并退出 |
| `--dump-default-config` | 打印 web profile 的 bundle 层（不含用户层）并退出 |
| `[args...]` | 剩余参数原样透传给 web 应用自己解析 |

限制：

- `web` 子命令关闭了自身的帮助选项，`dsh web --help` 打印的是 **web 应用自己的帮助**（而不是启动器的）。
- `--dump-config` 与 `--dump-default-config` 互斥，不能同时使用。
- 父级选项（`--profile`、`--patch`、`--dump-config`、`--dump-default-config`）不能与 `web` 子命令混用。

## 二、Web 应用层参数（跟随在 `dsh web` 之后）

| 参数 | 说明 |
|---|---|
| `-h, --help` | 显示 web 应用自己的帮助 |
| `--host <host>` | 绑定主机；默认 `127.0.0.1` |
| `--port <port>` | 监听端口；默认 `3080`；必须为纯数字，传 `0` 让系统选一个空闲端口 |
| `--trusted-host <authority...>` | 额外的可信 authority（host 或 `host:port`），供 `/api` 浏览器信任栅栏接受；**可重复**且一次可传多个 |

校验规则：

- `--host 0.0.0.0` 会被**有意拒绝**并报错（安全原因：会把远程代码执行暴露到网络，报错信息建议改用 `127.0.0.1`）。
- `--port` 非纯数字会报错。

## 三、常见用法示例

```bash
# 默认配置启动（127.0.0.1:3080）
npx @deepseek-ai/dsh web

# 换端口启动
npx @deepseek-ai/dsh web --port 8080

# 由系统分配空闲端口
npx @deepseek-ai/dsh web --port 0

# 指定绑定主机并添加可信主机
npx @deepseek-ai/dsh web --host 127.0.0.1 --trusted-host app.internal

# 添加多个可信主机（两种写法等价）
npx @deepseek-ai/dsh web --trusted-host app.internal app2.internal
npx @deepseek-ai/dsh web --trusted-host app.internal --trusted-host app2.internal

# 查看 web 应用自身的帮助
npx @deepseek-ai/dsh web --help

# 打印组合配置树后退出（不启动服务器）
npx @deepseek-ai/dsh web --dump-config
npx @deepseek-ai/dsh web --dump-default-config

# 叠加额外补丁层
npx @deepseek-ai/dsh web --patch extra.yml

# 完整示例：指定端口 + 多个补丁层 + 可信主机
npx @deepseek-ai/dsh web --port 9000 --patch a.yml --patch b.yml --trusted-host 192.168.1.5
```
