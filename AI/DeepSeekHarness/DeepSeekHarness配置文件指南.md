# DeepSeek Harness 配置文件指南

以「`.yaml` 带详细注释」的方式讲解 DeepSeek Harness 的完整配置体系：配置文件有哪些、如何分层叠加、patch 语法怎么写、settings / credentials / .env 各自管什么。

## 一、配置文件全景

所有用户数据都在 `$DSH_HOME` 下（默认 `~/.dsh`，可用环境变量 `DSH_HOME` 覆盖）。

| 文件 | 作用 | 热重载 |
|---|---|---|
| `$DSH_HOME/profiles/<name>/cordis.yml` | 空根配置，组合的起点。**dsh 每次启动自动重写，不要手动编辑** | - |
| `$DSH_HOME/profiles/<name>/package.json` | profile 清单：`dependencies` + `dsh.profile.bundles`（配置层顺序） | 否 |
| `$DSH_HOME/profiles/<name>/cordis.patch.yml` | **profile 用户 patch 层**（本指南核心） | 是 |
| `$DSH_HOME/profiles/<name>/pnpm-workspace.yaml` | pnpm 设置（插件安装用） | 否 |
| `$DSH_HOME/cordis.patch.yml` | **home 级 patch 层**：对所有 profile 生效 | 是 |
| `$DSH_HOME/settings.yaml` | 用户设置文档（模型、提供商等） | 是 |
| `$DSH_HOME/.credentials.yaml` | 凭据库（API Key，权限 0600） | 是 |
| `<cwd>/.env`、`$DSH_HOME/.env` | 环境变量层（有 bootstrap 保护名单） | 否 |

### 配置层叠加顺序（由低到高，后者覆盖前者）

```
1. dsh.profile.bundles 中各组合包的 patch 层（随安装，不可直接改）
2. profile 的 cordis.patch.yml（用户 patch 层）
3. $DSH_HOME/cordis.patch.yml（home 级，机器级偏好）
4. --patch <path> 启动参数覆盖层（一次性）
```

## 二、核心：cordis.patch.yml 语法

`cordis.patch.yml` 是一个**顶层 YAML 数组**，每项是一个 patch 条目。`!!js` 表达式可以在 config 里使用，条目激活时求值。

```yaml
# ──────────────────────────────────────────────────────────────
# cordis.patch.yml —— 用户 patch 层
# 位置：$DSH_HOME/profiles/<name>/cordis.patch.yml（单 profile）
#       $DSH_HOME/cordis.patch.yml（所有 profile 生效，优先级更高）
#
# 顶层必须是一个数组（列表）。每个条目对「行」（row）做三种操作之一：
#   1. 覆盖（id 定位，替换整行 config）
#   2. 禁用（id 定位，disabled: true）
#   3. 插入（insert 新行）
# 匹配不到任何行的条目只会告警并跳过，不会报错。
# ──────────────────────────────────────────────────────────────

# ── 操作 1：覆盖一行配置 ──────────────────────────────────────
# 定位：id 必须是组合树中已存在的行 id。
# 重要：config 是「整块替换」，不是深合并！
#   例如覆盖 agent-default-model 时，config 里必须写全所有想保留的键。
- id: agent-default-model          # 目标行 id
  name: '@deepseek-ai/dsh-agent-default-model'   # 可选：校验名字一致，不一致则跳过
  config:                          # 替换该行的整个 config
    provider: deepseek-official
    model: deepseek-v4-pro         # 把默认模型从 flash 换成 pro

# ── 操作 2：禁用（或启用）一行 ────────────────────────────────
# disabled 也是「覆盖」的一种：其他键保持不变，仅翻转开关。
- id: skill-badge                  # 例如启用一个默认禁用的行
  disabled: false

- id: web                          # 禁用整个 web 搜索能力（连工具都会失效）
  disabled: true

# ── 操作 3：插入新行（顶层） ──────────────────────────────────
# insert 数组里的每个条目：id 必须全局唯一，name 是 npm 包名。
- insert:
    - id: my-extra-tool            # 新行 id（供后续层继续 patch）
      name: '@my-scope/my-bundle-plugin'   # 插件包名（bundles 中需已安装）
      config:
        someOption: true

# ── 操作 4：插入到 group 内部 ─────────────────────────────────
# 某些行是 group（其 config 是子行数组），例如 base 的根插入层。
# 用法：给 insert 条目同时写 id，指向一个 group 行。
- id: tools                        # 目标 group 行 id
  insert:
    - id: my-tool-extra
      name: '@deepseek-ai/dsh-tool-web'
      config: {}

# ── !!js 表达式 ────────────────────────────────────────────────
# config 的值可以用 !!js 写 JS 表达式，条目激活时求值一次：
#   可用：process.env、dshHomePath()、ctx.<service>、process.platform、process.cwd()
- id: sandbox-policy
  config:
    mode: !!js process.env.DSH_PERMISSION_MODE ?? 'workspace-write'
    workspaceRoot: !!js process.cwd()

- id: session-persistence-jsonl
  config:
    root: !!js dshHomePath('sessions')   # 展开为 $DSH_HOME/sessions

- id: bash-sandbox
  disabled: !!js process.platform === 'win32'   # 平台条件开关

# 注：--dump-config 输出中 !!js 原样打印、不求值，方便检查表达式本身。
```

### 常用行 id 速查（来自 dsh-base + dsh-web-app 组合层）

| 行 id | 包 | 常见用途 |
|---|---|---|
| `agent-default-model` | dsh-agent-default-model | 默认 provider / model |
| `system-prompt` | dsh-system-prompt | persona 文本 |
| `sandbox-policy` | dsh-sandbox-policy | 文件沙箱模式、workspace 根 |
| `approval` | dsh-user-approval | 审批策略（ask / never） |
| `permission` | dsh-permission-presets | 三档权限预设 |
| `webserver` | dsh-host-webserver | host / port（web 模式） |
| `session-query-sqlite` | dsh-session-query-sqlite | 全文搜索开关（`openAt`） |
| `tool-web` / `web` / `web-search-deepseek` | dsh-tool-web / dsh-web | web 搜索/抓取能力 |
| `session-telemetry-otel` | dsh-session-telemetry-otel | 遥测（默认 DISABLED） |
| `llm-deepseek` | dsh-llm-deepseek | DeepSeek 适配器入口行 |
| `agent-loop` | dsh-agent-loop | 启动时自动创建的 agents |
| `fs-sandbox` | dsh-fs-sandbox | 沙箱文件系统 provider（可钉住 workspace） |
| `tools` | dsh-tools | 工具呈现模式 |

> 完整行 id 列表：跑 `dsh --profile <name> --dump-default-config` 查看（见第五节）。

## 三、profile 清单：package.json

```jsonc
// $DSH_HOME/profiles/<name>/package.json
// 由 `dsh plugin` 自动维护；一般不需要手改。
{
  "name": "dsh-profile-tui",            // 自动生成：dsh-profile-<name>
  "private": true,
  "dependencies": {
    // 树外插件依赖，由 `dsh plugin add` 写入
    "@my-scope/my-bundle-plugin": "^1.0.0"
  },
  "dsh": {
    "profile": {
      "bundles": [
        // 配置层顺序（先列先应用，后面覆盖前面）：
        "@deepseek-ai/dsh-base",        // 内置基础层
        "@my-scope/my-bundle-plugin"    // 声明了 dsh.bundle 的插件自动加入
      ]
    }
  }
}
```

## 四、settings.yaml：用户设置文档

```yaml
# ──────────────────────────────────────────────────────────────
# $DSH_HOME/settings.yaml
# 每个顶层键是一个「命名空间段落」，由对应插件注册。
# 外部编辑热发布（约 100ms debounce）；web 的 Models 页面也写这个文件。
# 解析失败时保留上一次的好文档并告警，不会拖垮进程。
# ──────────────────────────────────────────────────────────────

# 段落 1：DeepSeek 官方适配器（行 id: llm-deepseek 的注册段）
# 所有字段均可选；缺省用包内默认值。
llm-deepseek:
  # API Key 的凭据引用名（对应 .credentials.yaml 或环境变量）
  apiKeyEnv: DEEPSEEK_API_KEY
  # 覆盖端点（默认 https://api.deepseek.com；$DEEPSEEK_BASE_URL 环境变量优先）
  baseURL: https://api.deepseek.com
  # 思考模式：enabled / disabled
  thinking: enabled
  # 推理强度：off / high / max（thinking: disabled 时只能 off）
  reasoningEffort: high
  # 单次请求最大输出 token（正整数）
  maxTokens: 8192
  # 上下文窗口（正整数；决定自动压缩阈值）
  defaultContextWindow: 131072
  # 模型目录（id 唯一；决定选择器里能选哪些模型）
  models:
    - id: deepseek-v4-flash
      name: DeepSeek-V4-Flash
      contextWindow: 131072
    - id: deepseek-v4-pro
      name: DeepSeek-V4-Pro
      contextWindow: 131072
      description: 更强的推理模型
  # 流式空闲超时（毫秒）
  streamIdleTimeoutMs: 120000
  # 重试策略（缺省用全局 dsh-llm-retry）
  retryPolicy:
    maxAttempts: 3

# 段落 2：pi-ai 多提供商（行 id: llm-pi-ai；未配置时零路由、选择器里不出现）
# 本段结构为示例性质（未从本机源码逐字段验证），以 Models 页面实际写出的为准：
llm-pi-ai:
  providers:
    - id: my-provider
      # ... 提供商档案与凭据引用
```

## 五、.credentials.yaml：凭据库

```yaml
# ──────────────────────────────────────────────────────────────
# $DSH_HOME/.credentials.yaml
# 严格「凭据引用 -> 非空字符串」映射，不是 dotenv。
# 权限必须是 0600（POSIX 下 group/other 有位会被拒绝启动；Windows 跳过检查）。
# 写操作只 patch 自己那一个 key，注释与其余格式保留。
# ──────────────────────────────────────────────────────────────
DEEPSEEK_API_KEY: sk-xxxxxxxx    # 供 llm-deepseek 段 apiKeyEnv 引用
# MY_OTHER_KEY: xxx              # 移除某个凭据：删掉这行即可
```

### 凭据解析优先级（高 → 低）

```
1. 继承的进程环境（只读，最高：CI secret、容器 -e）
2. $DSH_HOME/.credentials.yaml（可写，Models 页面写这里）
3. <cwd>/.env（项目回退）
4. $DSH_HOME/.env（用户回退）
```

环境变量被继承层占用时，往凭据文件写同名 key 会报错（防止「写了却没效果」）。

## 六、.env 文件

```bash
# <cwd>/.env 与 $DSH_HOME/.env
# 加载顺序：继承环境 > 项目 .env > home .env；已存在的变量不被覆盖。
# 注意：文件名后缀是 .env（不是 .env.yaml），格式是 dotenv。

# 可以放：API Key、普通业务变量
DEEPSEEK_API_KEY=sk-xxxx

# 不可以放（bootstrap 保护名单，放了会启动报错）：
#   - 所有 DSH_ 前缀变量（DSH_HOME、DSH_PERMISSION_MODE 等）
#   - PATH / HOME / USERPROFILE / SHELL / NODE_OPTIONS / EDITOR ...
#   - HTTP_PROXY / HTTPS_PROXY / ALL_PROXY / NO_PROXY
#   - DEEPSEEK_BASE_URL / DEEPSEEK_SEARCH_BASE_URL
#   - SSL_CERT_FILE / NODE_TLS_REJECT_UNAUTHORIZED ...
# 这些只能从「启动进程的继承环境」提供。
```

## 七、pnpm-workspace.yaml（profile 目录内）

```yaml
# $DSH_HOME/profiles/<name>/pnpm-workspace.yaml
# 由 dsh 首次初始化自动生成；一般不用改。
packages:
  - .

nodeLinker: hoisted
autoInstallPeers: false

# git 托管插件（git+ / github: / .git）需要构建时，把 pnpm 报错
# 打印的精确 key 加到下面（allowBuilds 是 pnpm 10 的写法示例）：
# onlyBuiltDependencies:
#   - some-native-package
```

## 八、环境变量速查（env seams）

| 变量 | 作用 | 出处 |
|---|---|---|
| `DSH_HOME` | 覆盖 Harness home（默认 `~/.dsh`） | 启动器 |
| `DSH_PERMISSION_MODE` | 权限档：`read-only` / `workspace-write` / `danger-full-access` | sandbox-policy / approval 行 |
| `DSH_TOOLS_MODE` | 工具呈现：`native` / `code` / `both`（临时 seam） | tools 行 |
| `DSH_TELEMETRY_MODE` | `FULL` / `FEEDBACK_ONLY`（默认 DISABLED） | session-telemetry-otel |
| `DSH_TELEMETRY_OTLP_URL` | 覆盖遥测上报端点 | 同上 |
| `DSH_TELEMETRY_DISABLED` | 任意非空值（含 `'0'`）即禁用遥测 | 启动器补丁 |
| `DSH_WEB_SEARCH_PROVIDER` / `DSH_WEB_FETCH_PROVIDER` | 指定 web 搜索/抓取提供商 | dsh-web 服务 |
| `DEEPSEEK_API_KEY` | DeepSeek API Key（也可存凭据库） | llm-deepseek / web-search |
| `DEEPSEEK_BASE_URL` / `DEEPSEEK_SEARCH_BASE_URL` | 覆盖端点（仅继承环境可用，.env 禁止） | 适配器 |
| `DSH_WEB_URL` / `DSH_WEB_MODE` | 运行时注入 bash 的变量（模型可见） | web-runtime / shell-env |

## 九、如何验证配置

```bash
# 只打印 bundle 层（不含用户层；cordis.patch.yml 坏了时的恢复诊断）
dsh --profile web --dump-default-config

# 打印完整组合结果（含 profile/home 用户层与 --patch），
# 输出是带 `# == 来源文件` 注释分组的合法 YAML，!!js 原样打印
dsh --profile web --dump-config

# 启动器逐层打警告：某条 patch 匹配不到任何行时会打印
#   dsh: [<layer>] patch: entry "xxx" not found
```

组合结果 = 生效配置。改完 `cordis.patch.yml` 后，长驻界面（web）会热重载；`settings.yaml`、`.credentials.yaml` 同样热发布，无需重启。

## 来源

- 本机安装的 DSH 实现源码（`@deepseek-ai/dsh@0.1.0-rc.6`）：
  - patch 算法与 dump 渲染：`B:\TMP\_npx\1e7f6d9597241db0\node_modules\@deepseek-ai\dsh-app-boot\lib\index.js`
  - 环境分层加载：同上（`loadLayeredEnv`、bootstrap 保护名单）
  - 行 id 全表：`B:\TMP\_npx\1e7f6d9597241db0\node_modules\@deepseek-ai\dsh-base\cordis.patch.yml` 与 `dsh-web-app\cordis.patch.yml`
  - settings 文档：`B:\TMP\_npx\1e7f6d9597241db0\node_modules\@deepseek-ai\dsh-settings-file\lib\index.js`
  - 凭据文档：`B:\TMP\_npx\1e7f6d9597241db0\node_modules\@deepseek-ai\dsh-credentials-local\lib\index.js`
  - llm-deepseek 设置段 schema：`B:\TMP\_npx\1e7f6d9597241db0\node_modules\@deepseek-ai\dsh-llm-deepseek\lib\index.js`
