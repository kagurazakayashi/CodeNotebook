# DeepSeek Harness 管理 Profile 插件

记录 `npx @deepseek-ai/dsh plugin` 子命令的用法：安装、卸载、查询列表及常用文件路径。

## 命令形式

```bash
dsh plugin --profile <name> <pnpm args...>
```

- `--profile <name>`：**必需**，指定要管理的 profile。
- 后面的参数原样转发给 pnpm，在 profile 目录内执行（cwd = profile 目录）。
- 至少需要一个 pnpm 参数，否则报错。
- pnpm 不在 PATH 上时退出码 127。
- profile 首次使用时自动初始化（创建 `package.json`、`cordis.patch.yml`、`pnpm-workspace.yaml`）。
- 转发的是 pnpm 子命令，因此 pnpm 支持的操作（`add`、`remove`、`install`、`update`、`list`、`why` 等）均可使用。

## 安装

```bash
dsh plugin --profile tui add <package>
# 或：npx @deepseek-ai/dsh plugin --profile tui add <package>
```

安装要点：

- 安装成功后自动「对账」（reconcile）：解析结果中声明了 `dsh.bundle` 的依赖会**自动加入** `dsh.profile.bundles` 层栈（按依赖顺序追加）。
- 未声明 `dsh.bundle` 的依赖会警告：`installed as a plain dependency, not a profile layer`（作为普通库安装，不进配置层）。
- 相对路径 spec（`.`、`../plugin`、`file:`、`link:`）会被锚定到**调用目录**，避免在 profile 目录内解析导致自我链接（如 `add .` 从插件源码目录执行时会链接 profile 自身）。
- git 托管插件（`git+...`、`github:`、`.git`）依赖 `prepare` 脚本构建，pnpm 默认阻止：需在 profile 的 `pnpm-workspace.yaml` 里 `allowBuilds` 加入 pnpm 报错信息打印的精确 key，然后重跑。
- 一个 bundle 被列为配置层但未声明 `dsh.bundle` 属于错误配置，启动时 fail loud。

## 卸载

```bash
dsh plugin --profile tui remove <package>
```

- 转发给 `pnpm remove`。
- 退出码为 0 时自动对账：已卸载、或已不再声明 `dsh.bundle` 的包会从 `dsh.profile.bundles` 中移除。
- 安装时加入过 bundle 层的包，卸载后自动移出层栈。

## 查询列表

```bash
# 列出 profile 已安装的依赖
dsh plugin --profile tui list

# 查询某个包的依赖来源（为何被安装）
dsh plugin --profile tui why <package>
```

另外两个查看组合结果的手段（属于启动器，不属于 plugin）：

```bash
# 打印组合后的配置树（含用户层与 --patch），不启动应用
dsh --profile tui --dump-config

# 只打印 bundle 层（不含用户层）
dsh --profile tui --dump-default-config
```

## 常用文件路径

以下路径中 `$DSH_HOME` 默认是 `~/.dsh`（可用环境变量 `DSH_HOME` 覆盖）。

| 路径 | 说明 |
|---|---|
| `$DSH_HOME/profiles/<name>/` | profile 目录 |
| `$DSH_HOME/profiles/<name>/package.json` | profile 清单：`dependencies` 记录树外插件依赖，`dsh.profile.bundles` 记录配置层 bundle 列表（按顺序） |
| `$DSH_HOME/profiles/<name>/cordis.patch.yml` | profile 的用户 patch 层（长驻界面下热重载） |
| `$DSH_HOME/profiles/<name>/pnpm-workspace.yaml` | pnpm 设置（hoisted 布局）；git 插件构建需在此添加 `allowBuilds` |
| `$DSH_HOME/profiles/<name>/node_modules/` | pnpm 安装的树外插件实际位置 |
| `$DSH_HOME/profiles/node_modules/` | 安装包 fallback：每个随安装的 in-box 包一个 symlink，由 dsh 自动维护（`healProfilesModuleFallback`），不要手动改动 |
| `$DSH_HOME/cordis.patch.yml` | home 级用户 patch 层：对**所有** profile 生效，优先级高于 profile 自己的 `cordis.patch.yml` |

## 工作原理要点

- **bundle 解析顺序**：`dsh.profile.bundles` 中每个包先从 dsh 安装目录解析，再从 profile 的 `node_modules` 解析——in-box bundle 始终来自与运行中的 dsh 相同的安装，不采用 profile 本地副本。
- **配置层叠加顺序**（由低到高）：各 bundle 的 patch → profile 的 `cordis.patch.yml` → home 级 `cordis.patch.yml` → `--patch` 覆盖层。
- **profile 模板**（首次使用自动初始化）：
  - `web`：`@deepseek-ai/dsh-base` + `@deepseek-ai/dsh-web-app`
  - `headless`：`@deepseek-ai/dsh-base` + `@deepseek-ai/dsh-headless`
  - 其他名字：仅 `@deepseek-ai/dsh-base`（即「创建自定义 profile」= 用 `dsh plugin --profile <name> add <package>` 完成首次初始化）
- **profile 名限制**：不能为空，不能包含 `/` 或 `\`，不能是 `.`、`..`、`node_modules`。
- 初始化幂等：已存在的文件不会被覆盖，重复执行安全。

## 常见用法示例

```bash
# 初始化一个自定义 profile 并安装插件（首次 add 即完成初始化）
dsh plugin --profile tui add @some-scope/my-bundle-plugin

# 安装本地插件源码目录（相对路径锚定到当前目录）
cd /path/to/plugin-src
dsh plugin --profile tui add .

# 卸载插件（若其在 bundle 层中则自动移出）
dsh plugin --profile tui remove @some-scope/my-bundle-plugin

# 查看已安装依赖 / 依赖来源
dsh plugin --profile tui list
dsh plugin --profile tui why @deepseek-ai/dsh-base

# 依赖缺失时补装（resolveBundleDir 报错信息推荐的操作）
dsh plugin --profile tui install
```
