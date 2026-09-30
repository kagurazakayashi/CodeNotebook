# 技能总目录（`.agents/skills`）

本目录是**本仓库自带的个人 Skill 存放处**：每个子目录即一个技能，入口固定为该目录下的 `SKILL.md`。

## 目录

| 分类             | Skill                                                                           | 用途                                                                                                                            | 典型触发语                                                      | 可执行脚本                         |
| ---------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- | ---------------------------------- |
| 文档处理         | [yashi-md-table-format](yashi-md-table-format/SKILL.md)                         | Markdown 表格按显示宽度对齐（全角占 2 格），保留每列对齐方式；禁止手工拼空格                                                    | 表格对齐、整理表格、格式化表格                                  | `scripts/md_table_format.py`       |
| 文档处理         | [yashi-opencc-convert](yashi-opencc-convert/SKILL.md)                           | 基于 OpenCC 的中文简繁转换，支持台湾/香港繁体与日本新字体，默认自动判断方向                                                     | 简体转繁体、转成台湾繁体、统一简繁                              | `scripts/opencc_convert.py`        |
| 文档处理         | [yashi-encoding-convert](yashi-encoding-convert/SKILL.md)                       | 文本编码转换，自动识别 ANSI/GBK、Big5、Shift-JIS、UTF-16 等并转 UTF-8，支持就地改写                                             | 读取乱码文件、以 GBK 保存、转成 UTF-8                           | `scripts/encoding_convert.py`      |
| 终端与命令       | [yashi-rtk-token-saver](yashi-rtk-token-saver/SKILL.md)                         | 用 `rtk` 包装终端命令以压缩输出、节省 60–90% token；本环境未启用自动改写 hook，须显式加前缀                                    | 跑测试、构建、lint、看 git 状态/差异/日志                       | 无（命令包装器 `rtk`）             |
| DeepSeek Harness | [yashi-dsh-update](yashi-dsh-update/SKILL.md)                                   | 一句话更新 dsh 全局包与 `$DSH_HOME/profiles` 下所有插件，补依赖、处理不兼容插件并实测 `dsh web` 启停                            | 更新 dsh、dsh web 起不来、插件依赖未安装                        | 无（用 `.cmd`，`.ps1` 被策略拦截） |
| DeepSeek Harness | [yashi-dsh-config-sync](yashi-dsh-config-sync/SKILL.md)                         | dsh 配置一句话导出/导入（settings、profiles、插件配置、agent 预设），导入自动补依赖并实测启停；**不含环境变量**                 | 导出/备份/迁移/恢复 dsh 配置                                    | `scripts/dsh_config_sync.py`       |
| DeepSeek Harness | [yashi-dsh-env-sync](yashi-dsh-env-sync/SKILL.md)                               | dsh 环境变量（API key）一句话导出/导入 ini，扫描配置中的 `apiKeyEnv` / `process.env.X` 引用，Windows 走 `setx`                  | 备份 dsh 的 API key、检查 key 是否配齐                          | `scripts/dsh_env_sync.py`          |
| 环境与配置迁移   | [yashi-opencode-config-portability](yashi-opencode-config-portability/SKILL.md) | 打包 `~/.config/opencode` 与 `~/.agents` 为 `opencode_config.7z`，一句话导入/导出，跨 Windows/macOS/Linux；**本技能内禁用 rtk** | 导出/导入/迁移 opencode 设置                                    | 无（7z + node 校验）               |
| 联网与 MCP       | [yashi-mcp-proxy-injection](yashi-mcp-proxy-injection/SKILL.md)                 | 为读取网址/境外搜索的本地 MCP 服务器注入代理的通用方法论（HTTP CONNECT 或 SOCKS5，地址走环境变量）；**动手前先问用户**          | MCP `fetch failed`、chromium 超时、`npm update -g` 后补丁被覆盖 | 无（补丁方法论）                   |
| 信息查询         | [yashi-github-read-contributions](yashi-github-read-contributions/SKILL.md)     | 读取任意 GitHub 用户的 contributions 热力图，分析活跃度、首个无贡献日期、连续贡献天数                                           | 贡献图、连续提交天数                                            | 无（内建 `webfetch`）              |
| 信息查询         | [yashi-windows-check-update](yashi-windows-check-update/SKILL.md)               | 从 Microsoft 发布健康页与 Update Catalog 提取 Windows 11/10/Server 最新功能更新的 KB 信息与下载链接                             | 获取 Windows 11 25H2 x64 最新更新                               | 无（取下载链接需 Playwright MCP）  |
| 日常生活         | [yashi-dida-cli](yashi-dida-cli/SKILL.md)                                       | 用 `dida`（`@suibiji/dida-cli`）管理滴答清单的任务、清单、标签、习惯、专注与倒数日；未登录时提醒用户自行登录                    | 建一个滴答任务、列出我的清单、给习惯打卡                        | 无（CLI `dida`）                   |

## 分类索引

- **文档处理**：`yashi-md-table-format`、`yashi-opencc-convert`、`yashi-encoding-convert`
- **终端与命令**：`yashi-rtk-token-saver`
- **DeepSeek Harness（dsh）**：`yashi-dsh-update`、`yashi-dsh-config-sync`、`yashi-dsh-env-sync`
- **环境与配置迁移**：`yashi-opencode-config-portability`
- **联网与 MCP**：`yashi-mcp-proxy-injection`
- **信息查询**：`yashi-github-read-contributions`、`yashi-windows-check-update`
- **日常生活**：`yashi-dida-cli`

## 联动关系

- dsh 迁移 = **配置 zip + 环境变量 ini 两份都要**：`yashi-dsh-config-sync` 的导出不含任何环境变量，密钥需靠 `yashi-dsh-env-sync` 单独恢复；后者可直接吃前者导出的 zip 作为变量名来源（`--from-archive`）。
- `yashi-dsh-config-sync` 导入后若依赖或插件有问题，转 `yashi-dsh-update` 修复。
- 涉及网络的技能（`yashi-dsh-*`、`yashi-mcp-proxy-injection`）都以**先询问用户是否走代理、走哪个代理**为前提。
- `yashi-rtk-token-saver` 与 `yashi-opencode-config-portability` 互斥：后者范围内所有命令必须直接执行，不能加 `rtk` 前缀。
- `yashi-md-table-format` 是本目录所有 Markdown 产出的默认工友——包括本文件。
