---
name: yashi-dida-cli
display_name: 滴答清单 CLI
description: >-
  用 `dida`（@suibiji/dida-cli）在终端管理滴答清单 dida365 的任务、清单、标签、习惯、专注与倒数日——
  涵盖 npm 全局安装/更新（代理 + strict-ssl + allow-scripts 的正确姿势）、OAuth 或 API 口令登录、
  以及查询与增删改的常用命令。适用于「更新 dida-cli」「列出我的清单/任务/标签/习惯/专注/倒数日」
  「建一个滴答任务」「dida 没登录怎么办」「dida auth login」」「按关键词搜滴答任务」「给习惯打卡」
  等场景。执行任何数据命令前先检查 `dida auth status`；未登录时提醒用户自行运行 `dida auth login`
  并暂停，不要代替用户登录。涉及 delete 等写操作前必须先向用户确认。
---

# 滴答清单 CLI（dida）

封装 [DIDA Open API v1](https://developer.dida365.com/docs#/openapi) 的命令行工具。
可执行名 `dida`，别名 `dida-cli`。

## 0. 前置检查（每次会话开始时）

```bash
dida --version     # 未安装时该命令会报 not recognized / command not found
dida auth status   # 已登录输出用户信息；未登录输出「未登录」
```

> **重要**：未登录时数据命令（如 `dida project list`）只打印
> `未找到 access token。请先运行 dida auth login 登录。`，但**退出码仍为 0**。
> 因此判断登录态必须看 stdout 文本，不能依赖 `$?` / exit code。

**未登录时**：告知用户自行执行 `dida auth login`（会打开浏览器走 OAuth PKCE），
然后**停止并等待**，不要代替用户跑登录命令、不要伪造 token。

无浏览器环境（WSL / SSH / 容器）时，用户可在滴答网页版
「头像 → 设置 → 账户与安全 → API 口令」创建 token，再执行
`dida auth token <token>`。

token 存储位置：`~/.config/dida-cli/config.json`（Windows 为
`C:\Users\<user>\.config\dida-cli\config.json`）。`dida auth logout` 清除。

## 1. 安装与更新

包名 `@suibiji/dida-cli`，用 npm 全局安装。

```bash
# 直连 registry 优先
npm -g install @suibiji/dida-cli@latest
```

直连失败（`ETIMEDOUT`、`ECONNREFUSED`、网络被墙、registry 500）**先询问用户代理地址**，
再用一次性参数走代理（不要写进全局 `.npmrc`）：

```bash
npm -g install @suibiji/dida-cli@latest \
  --proxy http://127.0.0.1:23333 \
  --https-proxy http://127.0.0.1:23333 \
  --strict-ssl=false
```

**allow-scripts 是必需的**：新版 npm（≥11）默认忽略依赖的生命周期脚本，
若包或其依赖需要 install 脚本会静默装不全。本机的允许列表在
`npm config get allow-scripts`（逗号分隔的包名列表）。

命令行传 `--allow-scripts` 会**整体覆盖** `.npmrc` 里的列表（并警告
`allow-scripts setting is being ignored because --allow-scripts was passed on the command line`），
所以必须把原有条目一起带上，末尾追加本包名：

```bash
npm config get allow-scripts   # 先读出已有列表
npm -g install @suibiji/dida-cli@latest \
  --allow-scripts="<原有的逗号分隔列表>,@suibiji/dida-cli"
```

装完务必验证：`dida --version`，再 `npm -g ls --depth=0 | grep dida`。
查询最新版：`npm view @suibiji/dida-cli version`。

## 2. 命令总览

所有命令都支持 `--json`（输出原始 API JSON，字段为 camelCase）；
细节以 `dida <command> --help` 为准。

| 域 | 命令 |
|----|------|
| 认证 | `auth login` / `auth token <t>` / `auth status` / `auth logout` |
| 任务 | `task get <projectId> <taskId>` / `create` / `update <taskId>` / `complete <projectId> <taskId>` / `delete <projectId> <taskId>` / `move` / `completed` / `filter` / `search [keywords]` / `comment list|add|delete` |
| 清单 | `project list` / `get <projectId>` / `data <projectId>` / `create` / `update <projectId>` / `delete <projectId>` / `group list|create|update|delete` / `column list|create|update` |
| 标签 | `tag list` / `tag create --name <n> --label <l>` |
| 习惯 | `habit get` / `list` / `create` / `update` / `checkin <habitId>` / `checkins` |
| 专注 | `focus get <focusId>` / `list` / `create` / `delete <focusId>` |
| 倒数日 | `countdown list` |

## 3. 常用配方

```bash
# 列出所有清单（拿 projectId 是其他命令的前提）
dida project list
dida project list --json

# 某清单下的未完成任务 + 分组
dida project data <projectId>

# 建任务
dida task create --title "买牛奶" --project <projectId>
dida task create --title "开会" --project <projectId> --priority 5 \
  --due-date "2026-03-10T09:00:00+0000" --tags 工作,紧急 \
  --reminders "TRIGGER:-PT15M" --items "准备议程,打印材料"

# 查/改/完成/删
dida task filter --projects <projectId> --priority 3,5 --status 0
dida task search "季度报告" --projects <projectId> --status 0
dida task completed --projects <projectId> \
  --start-date "2026-03-01T00:00:00+0000" --end-date "2026-03-09T23:59:59+0000"
dida task update <taskId> --id <taskId> --project <projectId> --title "新标题"
dida task complete <projectId> <taskId>

# 习惯打卡 / 专注记录
dida habit checkin <habitId> --stamp 20260424 --value 1
dida focus list --type pomodoro --from "2026-04-01T00:00:00+0800" --to "2026-04-07T23:59:59+0800"
```

## 4. 踩坑清单

1. **`task update` 三处都要 ID**：位置参数 `<taskId>`、`--id <taskId>`（body 必填）、
   `--project <projectId>` 缺一不可，只给位置参数会报错。
2. **日期格式分两类**：`task`/`habit` 用 `yyyy-MM-ddTHH:mm:ssZ`（如 `...+0000`）；
   `focus` 用 `yyyy-MM-ddTHH:mm:ss+ZZZZ`（本地时区偏移，如 `+0800`）。传错格式服务端静默返回空结果。
3. **`habit checkin`/`checkins` 用 `--stamp`/`--from`/`--to` 的 `YYYYMMDD`**（无分隔符），与 task 的 ISO 格式不同。
4. **priority**：`0`=无、`1`=低、`3`=中、`5`=高（**没有 2 和 4**）。
5. **status**：任务 `0` 未完成、`-1` 已放弃、`2` 已完成；`items[]` 的检查事项是 `0`/`1`。
6. **`--items`** 接受 JSON 数组或逗号分隔标题两种写法。
7. **`--reminders`** 每项须匹配 `TRIGGER(;RELATED=START|END)?:(-)?P[nY][nM][nW][nD][T[nH][nM][nS]]`，
   如 `TRIGGER:-PT60M`（参考点前 60 分钟）、`TRIGGER;RELATED=END:-PT15M`。
8. **`--repeat`** 用 `RRULE:FREQ=DAILY` 或 `ERULE:NAME=CUSTOM;BYDATE=...`，同一条里**不能混用** RRULE 与 ERULE。
9. **`focus list --type` 实际必填**：`--help` 里没标 required，但不传会直接
   `error: required option '--type <type>' not specified`；取值为 `pomodoro` 或 `timing`，
   两种要分别查。时间跨度上限 **30 天**，超出需分段。
10. **多数命令要先有 `projectId`**：`task get`/`complete`/`delete` 都要 projectId + taskId 两个参数，
    而 `task update` 只要 taskId 位置参数——不一致，别记混。
11. **`--tags` 与 `--tag` 拼写不同**：`task create/update/search` 用 `--tags`，`task filter` 用 `--tag`。
12. **`project create --desc`** 语义是清单描述，非任务内容。
13. 命令输出为中文，`--json` 才是稳定可解析的机器格式；需要脚本化消费时一律加 `--json`。
14. **空结果不是错误**：`未找到清单分组。` / `未找到标签。` / `没有习惯。` /
    `范围内没有专注记录。` / `没有任务符合筛选条件。` 都是正常空集，退出码 0——按成功处理。
15. **`task search` 必须带关键词位置参数**：只给 `--status 0` 这类条件而不传 `[keywords]`
    会返回 `未找到匹配的任务。`（服务端语义就是"空关键词=无结果"），别误判成登录或权限问题；
    想按条件列全部任务用 `task filter` 或 `project data <projectId>`。

## 5. 写操作安全

`task delete`、`project delete`、`project group delete`、`focus delete`、
`auth logout` 不可撤销。**执行前向用户复述目标 ID 与名称并等待确认**；
删除清单前先 `dida project data <projectId>` 展示将受影响的任务数量。
