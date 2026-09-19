---
name: yashi-rtk-token-saver
description: 在终端执行开发命令时优先改用 rtk 包装，以压缩输出、节省 60-90% 的 LLM token。适用于 git / gh / glab / gt / cargo / go / golangci-lint / npm / npx / pnpm / bun / deno / python(pytest,ruff,mypy,pip,uv) / jest / vitest / playwright / ctest / tsc / eslint / prettier / next / prisma / dotnet / mvn / sbt / gradlew / docker / kubectl / oc / aws / psql / php(phpunit,phpstan,pest,pint 等) / ruby(rspec,rubocop,rake) 等命令，以及 ls / tree / cat / head / tail / grep / rg / find / wc / diff / json / log / env / deps 等文件操作。当需要运行测试、构建、lint、查看 git 状态/差异/日志、列目录、搜索文件内容、查看日志或 JSON 时使用。跨平台通用：Windows cmd.exe 与 Linux/macOS bash 均适用；由于本环境未启用 rtk 的自动改写 hook/插件，必须由 AI 显式手动加 rtk 前缀。
---
<!--
触发示例：
- 跑一下测试 / 运行 cargo test、pytest、npm test
- 构建项目 / cargo build、npm run build、next build
- 看看 git 状态 / git diff / git log / 提交并推送
- 列出目录、搜索某个关键字、读取某个文件
- 查看 docker 容器、kubectl pods、AWS 资源
- 跑 lint / tsc / eslint / ruff / clippy
- 执行任意会产生大量输出的命令
-->

# RTK Token Saver — 优先用 rtk 压缩命令输出

rtk（Rust Token Killer）是一个 CLI 代理：它在命令输出抵达 LLM 上下文前进行过滤、分组、截断、去重，平均节省 60-90% token，单条命令开销 <10ms。本机已手动安装，当前版本 0.49.0（`rtk --version` 可验证）。

## 核心规则

- 通过 `bash` 执行受支持命令时（无论 Windows cmd.exe 还是 Linux/macOS bash），**默认在命令前加 `rtk` 前缀**，例如 `git status` → `rtk git status`、`cargo test` → `rtk cargo test`。
- 本环境**未启用 rtk 的自动改写 hook/插件**（既未装 Claude Code 等的 hook，也未作为 opencode 插件），因此必须**显式手动**加 `rtk`，不能依赖透明改写。这一点在 Windows 与 Linux/macOS 下都成立。
- rtk **只改变输出的展示形式，不改变命令的实际行为与副作用**：`rtk git commit`、`rtk git push`、`rtk pip install` 等照常执行真实操作。
- rtk 对**未识别的子命令会原样透传（passthrough）**，所以加前缀总是安全的——最坏情况是没有节省，不会破坏命令。
- **shell 差异**：`rtk` 子命令本身跨平台一致，仅 shell 语法不同（注释 Windows cmd 用 `REM`、bash 用 `#`；路径分隔符、引号略有差别）。文件类命令（`rtk ls/tree/grep/find/read`）在 Linux/macOS 直接用原生工具；在 Windows 需要 PATH 中有对应工具（如 `grep`/`find` 走 ripgrep，可由 MSYS2 提供）。

## 命令映射速查（原始 → rtk）

| 类别            | 原始命令                                                                             | rtk 形式                                                                                                                                            |
| --------------- | ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| 文件            | `ls` / `tree`                                                                        | `rtk ls` / `rtk tree`                                                                                                                               |
| 文件            | `cat` / `head` / `tail`                                                              | `rtk read <file>`（默认全量；`-l minimal`/`-l aggressive` 过滤，`-m N` 限行数，`--tail-lines N` 只看末尾，`-n` 显示行号）                                 |
| 文件            | `grep` / `rg`                                                                        | `rtk grep "<pattern>" [path]` / `rtk rg ...`                                                                                                                 |
| 文件            | `find` / `fd`                                                                        | `rtk find ...`（接受原生 find 参数，如 `-name`、`-type`）                                                                                           |
| 文件            | `wc` / `diff`                                                                        | `rtk wc` / `rtk diff <a> <b>`                                                                                                                             |
| JSON/日志/环境  | `cat x.json`、`tail -f`、`env`、依赖树                                               | `rtk json <f>`（`--keys-only` 只看结构，`-d N` 限深）/ `rtk log <f>` / `rtk env [-f KEY]` / `rtk deps`                                                    |
| 下载            | `curl` / `wget`                                                                      | `rtk curl`（自动 JSON 检测+结构输出）/ `rtk wget`（去进度条）                                                                                       |
| Git             | `git status/diff/log/show/add/commit/checkout/push/pull/branch/fetch/stash/worktree` | `rtk git <子命令>`（支持 `-C <dir>`、`-c key=val` 等原生参数）                                                                                                   |
| GitHub/GitLab   | `gh`、`glab`、`gt`(Graphite)                                                         | `rtk gh ...` / `rtk glab ...` / `rtk gt ...`                                                                                                        |
| Rust            | `cargo test/build/check/clippy/nextest/install`                                      | `rtk cargo ...`                                                                                                                                     |
| Go              | `go test/build/vet`、`golangci-lint run`                                             | `rtk go ...` / `rtk golangci-lint run`                                                                                                              |
| Node 运行时     | `npm` / `npx` / `pnpm`、`bun` / `bunx`、`deno`                                       | `rtk npm ...` / `rtk npx ...` / `rtk pnpm ...` / `rtk bun ...` / `rtk bunx ...` / `rtk deno ...`                                                    |
| JS 测试         | `jest` / `vitest` / `playwright test` / CTest                                        | `rtk jest` / `rtk vitest` / `rtk playwright test` / `rtk ctest`                                                                                     |
| JS 构建/lint    | `tsc`、`eslint`、`prettier`、`next build`、`prisma`                                  | `rtk tsc`（分组报错）/ `rtk lint`（eslint 按规则分组）/ `rtk prettier` / `rtk format`（prettier/black/ruff format 通用）/ `rtk next` / `rtk prisma` |
| Python          | `pytest`、`ruff`、`mypy`、`pip`、`uv`                                                | `rtk pytest` / `rtk ruff ...` / `rtk mypy` / `rtk pip ...`（自动检测 uv）/ `rtk uv`                                                                 |
| Ruby            | `rspec`、`rubocop`、`rake test`                                                      | `rtk rspec` / `rtk rubocop` / `rtk rake test`                                                                                                       |
| PHP             | `php artisan`、`phpunit`、`phpstan`、`pest`、`paratest`、`ecs`、`pint`、`phpt`       | `rtk php ...` / `rtk phpunit` / `rtk phpstan` / `rtk pest` / `rtk paratest` / `rtk ecs` / `rtk pint` / `rtk phpt`                                   |
| .NET/Java/Scala | `dotnet build/test`、`mvn` / `mvnd`、`sbt`、Android `./gradlew`                      | `rtk dotnet ...` / `rtk mvn ...` / `rtk mvnd ...` / `rtk sbt ...` / `rtk gradlew ...`                                                               |
| SQL             | `sqlfluff lint`                                                                      | `rtk sqlfluff`                                                                                                                                      |
| 容器            | `docker ps/images/logs/compose`、`kubectl get/logs`、`oc`                            | `rtk docker ...` / `rtk kubectl ...` / `rtk oc ...`                                                                                                 |
| 云/DB           | `aws <service> ...`、`psql`                                                                   | `rtk aws ...`（强制 JSON 压缩）/ `rtk psql ...`（去边框压表）                                                                                       |

通用包装器（无专用过滤器时使用）：

- `rtk test <任意测试命令>` — 只显示失败（约 -90%），如 `rtk test bun test`。
- `rtk err <任意命令>` — 只显示错误/警告。
- `rtk summary <任意命令>` — 对长输出生成启发式摘要。
- `rtk smart <file>` — 对单个文件生成 2 行技术摘要（启发式，`-m <model>` 可换模型）。
- `rtk pipe -f <filter>` — Unix 管道模式：从 stdin 读取并应用过滤器（如 `cargo test 2>&1 | rtk pipe -f cargo-test`），`--passthrough` 不过滤。
- `rtk run <命令>` / `rtk proxy <命令>` — 原始执行（不过滤）；`proxy` 仍统计 token 节省，`run` 完全不追踪。

## 全局选项

- `--ultra-compact` — 更激进的内联紧凑格式（ASCII 图标、内联格式），进一步省 token。
- `-v` / `-vv` / `-vvv` — 提高 stderr 上的过滤细节（调试用，只能放在子命令前）。
- `--skip-env` — 为子进程设置 `SKIP_ENV_VALIDATION=1`（Next.js / tsc / lint / prisma）。

## 何时【不要】用 rtk

- **需要完整、精确、逐字的输出**（要解析全部行、复制原文、比对字节）：用原始命令，或 `rtk read <file>`（默认 level=none 全量输出），或 `rtk proxy <命令>`（不过滤但仍统计）。
- **交互式 / 需要 TTY 的命令**：如 `git rebase -i`、不带 `-m` 的 `git commit`（会打开编辑器）、需要输入确认或密码的命令、TUI 程序——直接用原始命令。
- **opencode 内置工具（Read / Grep / Glob）不会经过 rtk**。若希望在这些场景省 token，改用 `bash` 调用 `rtk read` / `rtk grep` / `rtk find`。
- 若过滤后的信息不足以判断，再用 `rtk proxy <命令>` 或原始命令获取完整输出。

## 失败/被过滤时：读取日志或 recall（不要重跑）

命令失败时，rtk 会把**完整未过滤输出**保存到日志并在结果尾部打印路径：

```
FAILED: 2/15 tests
[full output: <.../rtk/tee/...log>]
```

需要更多细节时，直接 `rtk read` 该日志文件，**不要重新执行命令**。

若输出被某个过滤器省略但带有内容哈希提示，可用 `rtk recall [hash]` 按哈希召回被过滤的输出（`--list` 列出已存条目，`--grep <regex>` 过滤召回内容，`--full` 取完整输出，`--from`/`--lines` 取片段）。恢复模式由 `rtk config recall` 控制（sqlite | tee | disabled）。

## 验证、统计与初始化（可选）

```bash
rtk --version
rtk gain
rtk gain -p
rtk discover -a -s 7
rtk cc-economics -a
rtk session
rtk config
```

- `rtk --version` — 确认已安装（当前 0.49.0，应保持较新）。
- `rtk gain` — 累计 token 节省统计；`-p` 仅当前项目。
- `rtk discover -a -s 7` — 找出过去 7 天本可被 rtk 优化却漏掉的命令。
- `rtk cc-economics` — Claude Code 花费（ccusage）vs rtk 节省分析；`-d/-w/-m/-a` 按日/周/月/全部，`-f json|csv` 可导出。
- `rtk session` — 查看 rtk 在 Claude Code 会话中的采用情况。
- `rtk config` — 显示/修改配置；`rtk config --create` 生成默认配置，`rtk config recall` 设恢复模式。
- `rtk telemetry` — 管理遥测同意（GDPR）。
- `rtk init` — 初始化 rtk 指令/hook：`-g` 装到全局；`--opencode` 安装 opencode 插件；`--gemini` 初始化 Gemini CLI；`--agent <agent>` 支持 claude / cursor / windsurf / cline / kilocode / antigravity / kimi。

> 名称冲突提示：crates.io 上另有一个名为 “rtk” 的 Rust Type Kit。若 `rtk gain` 报错，说明装错了包。
