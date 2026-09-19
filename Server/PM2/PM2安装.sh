#!/bin/bash
# PM2 —— Node.js 应用的进程管理工具
# 官网: https://pm2.keymetrics.io/

# ============================================================
# 一、安装 PM2
# ============================================================

# 前提：已安装 Node.js 和 npm
# 检查版本
node -v
npm -v

# Linux / macOS 安装（全局安装）
npm install pm2 -g

# 查看 PM2 版本，验证安装成功
pm2 -v

# ----------------
# 【Win】Windows 下安装说明：
#   1. 同样使用 npm install pm2 -g 全局安装
#   2. 但 Windows 不支持 PM2 的 cluster 模式（无法 fork 进程）
#   3. Windows 不支持开机自启（pm2 startup）
#   4. 建议 Windows 上用 PM2 仅作开发测试，生产环境务必使用 Linux
#   5. Windows 下替代方案：使用 nodemon 或直接用 node 运行
#   6. 如果 Windows 上安装了 WSL2，建议在 WSL2 内使用 PM2
# ----------------


# ============================================================
# 二、基本命令
# ============================================================

# 启动一个 Node.js 应用
pm2 start app.js

# 指定应用名称
pm2 start app.js --name "my-app"

# 启动并指定实例数（cluster 模式）
# 【Win】Windows 不支持 cluster 模式，以下命令仅限 Linux/macOS
pm2 start app.js -i 4 --name "my-app"
# -i 4      表示启动 4 个进程实例
# -i max    表示根据 CPU 核心数自动分配

# 查看所有进程列表
pm2 list
pm2 ls
pm2 status

# 停止某个进程
pm2 stop my-app
pm2 stop 0           # 按 ID 停止

# 重启某个进程
pm2 restart my-app
pm2 restart all      # 重启所有进程

# 重载（0 秒停机，适用于 cluster 模式，逐个重启进程）
# 【Win】Windows 不支持
pm2 reload my-app
pm2 reload all

# 删除某个进程（从 PM2 列表中移除）
pm2 delete my-app
pm2 delete 0         # 按 ID 删除
pm2 delete all       # 删除所有

# 查看进程详情
pm2 show my-app
pm2 describe my-app

# 查看日志
pm2 logs                # 实时查看所有日志
pm2 logs my-app         # 查看指定应用日志
pm2 logs my-app --lines 100   # 查看最近 100 行
pm2 logs --nostream     # 不实时跟踪，只输出当前日志

# 清空日志
pm2 flush
pm2 flush my-app

# 重置进程重启计数器
pm2 reset my-app

# 监控面板（实时 CPU、内存等）
pm2 monit

# ----------------
# 【Win】Windows 下 pm2 monit 可能无法正常渲染终端界面，
#   建议使用 pm2 list 或 pm2 show 查看状态
# ----------------


# ============================================================
# 三、配置文件
# ============================================================

# 详细配置文件示例见同目录下的 PM2配置示例.config.js

# 生成默认配置文件
pm2 ecosystem
# 或用简写
pm2 init

# 使用配置文件启动
pm2 start ecosystem.config.js

# 使用指定环境启动
pm2 start ecosystem.config.js --env production

# 只启动配置中的某个应用
pm2 start ecosystem.config.js --only my-app


# ============================================================
# 四、日志管理
# ============================================================

# 使用 pm2-logrotate 插件管理日志（自动分割、压缩、清理）
pm2 install pm2-logrotate

# 查看日志轮转配置
pm2 conf pm2-logrotate

# 设置日志文件最大大小（默认 10M）
pm2 set pm2-logrotate:max_size 50M

# 保留的日志文件数量（默认 30）
pm2 set pm2-logrotate:retain 7

# 是否压缩旧日志（默认 false）
pm2 set pm2-logrotate:compress true

# 日志轮转间隔（默认 "0 0 * * *" 即每天午夜）
pm2 set pm2-logrotate:rotateInterval "0 0 * * *"

# 轮转所有应用的日志（包括停止的）
pm2 set pm2-logrotate:rotateModule true

# 【Win】Windows 下 pm2-logrotate 行为可能不一致，建议手动管理日志


# ============================================================
# 五、开机自启（systemd）
# ============================================================

# 【Win】Windows 不支持 pm2 startup 开机自启功能
#   Windows 替代方案：
#     1. 使用 Windows 任务计划程序，触发器设为"系统启动时"
#     2. 操作设为：pm2 resurrect
#     3. 或用 winsw / nssm 将 PM2 注册为 Windows 服务

# --- Linux 配置开机自启 ---
# 生成启动脚本
pm2 startup

# 执行上面命令输出的那一行（通常类似）：
# sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u your_user --hp /home/your_user

# 保存当前进程列表（之后开机自动恢复）
pm2 save

# 检查开机自启状态
systemctl status pm2-$(whoami)

# 手动恢复保存的进程
pm2 resurrect

# 取消开机自启
pm2 unstartup systemd

# 清除保存的进程列表
pm2 cleardump
# 或
pm2 save --force  # 用空列表覆盖


# ============================================================
# 六、常用操作场景
# ============================================================

# --- 场景一：平滑更新（0 秒停机）---
# 【Win】不支持，仅限 Linux/macOS 的 cluster 模式
pm2 reload my-app

# --- 场景二：更新代码后重启 ---
git pull
npm install
pm2 restart my-app

# --- 场景三：查看进程资源占用 ---
pm2 monit
# 或查看所有进程的简要状态
pm2 list
pm2 show my-app

# --- 场景四：设置环境变量 ---
pm2 start app.js --env production
# 或
NODE_ENV=production pm2 start app.js
# 【Win】Windows 下环境变量语法不同：
#   cmd:  set NODE_ENV=production && pm2 start app.js
#   PowerShell:  $env:NODE_ENV="production"; pm2 start app.js

# --- 场景五：指定日志输出位置 ---
pm2 start app.js -o ./logs/out.log -e ./logs/err.log -l ./logs/combined.log
# -o  标准输出日志
# -e  错误日志
# -l  合并日志（同时包含 stdout 和 stderr）

# --- 场景六：限制重启次数（防止死循环重启）---
pm2 start app.js --max-restarts 10 --restart-delay 5000
# 如果 10 次异常重启后，PM2 将停止尝试

# --- 场景七：传递参数给应用 ---
pm2 start app.js -- arg1 arg2 arg3
# -- 后面的参数会传给你的 app.js 进程


# ============================================================
# 七、PM2 与 Docker 配合
# ============================================================

# Dockerfile 中集成 PM2（推荐在容器内使用）
# FROM node:18-alpine
# WORKDIR /app
# COPY . .
# RUN npm install && npm install pm2 -g
# EXPOSE 3000
# CMD ["pm2-runtime", "start", "ecosystem.config.js"]

# pm2-runtime 专为 Docker 设计，确保 PM2 作为 PID 1 运行
# 这样 Docker stop 的信号能正确传递给应用进程


# ============================================================
# 八、常用插件与模块管理
# ============================================================

# --- 安装插件（统一命令）---
pm2 install <模块名>

# --- 查看已安装的模块列表 ---
pm2 list
# 模块名称前带 "module:" 前缀的即为 PM2 插件

# --- 更新已安装的插件 ---
pm2 install <模块名>          # 重新安装即更新到最新版
# 或先卸载再安装：
pm2 uninstall <模块名>
pm2 install <模块名>

# --- 卸载插件 ---
pm2 uninstall <模块名>
# 示例：pm2 uninstall pm2-server-monit

# --- 查看模块的配置项 ---
pm2 conf <模块名>
# 示例：pm2 conf pm2-server-monit

# --- 设置模块的配置项 ---
pm2 set <模块名>:<配置键> <值>
# 示例：pm2 set pm2-server-monit:interval 5


# --- pm2-server-monit：服务器级监控（CPU、内存、磁盘、网络等）---
pm2 install pm2-server-monit

# 安装后在 pm2 list 中会看到 module:pm2-server-monit
# 使用 pm2 monit 即可看到服务器级资源使用情况（如下）：
#
# ┌─ Process List ───────────────────────┐  ┌─ Server Metrics ───────────────┐
# │[0] my-app                  online    │  │ CPU: 25%   MEM: 60%           │
# │[1] my-app                  online    │  │ Disk: 45%  NET: 1.2MB/s       │
# └──────────────────────────────────────┘  └───────────────────────────────┘

# 查看 server-monit 配置：
pm2 conf pm2-server-monit

# 常用配置项：
pm2 set pm2-server-monit:interval 5          # 采样间隔（秒），默认 5
pm2 set pm2-server-monit:disk  "/,/data"     # 监控的磁盘挂载点

# 如果 pm2 monit 无法显示面板，可以直接查看原始数据：
pm2 describe pm2-server-monit


# --- pm2-health：健康检查 HTTP 端点 ---
pm2 install pm2-health

# 安装后自动在 11222 端口启动 HTTP 服务，访问以下端点：
#
#   http://localhost:11222/health    → 应用健康状态 JSON
#   http://localhost:11222/metrics   → Prometheus 格式的指标
#
# 返回示例：
#  {"status":"healthy","apps":[{"name":"my-app","status":"online","cpu":5.2,"memory":120}]}

# 自定义健康检查端口：
pm2 set pm2-health:port 11222
pm2 set pm2-health:metrics true              # 是否暴露 /metrics（Prometheus）


# --- pm2-logrotate：日志轮转（详见第四节）---


# --- pm2-webshell：Web SSH 终端 ---
pm2 install pm2-webshell

# 安装后在浏览器中打开 http://[服务器IP]:8080 即可获得一个网页终端
# 注意：生产环境慎用，需做好认证和防火墙限制
pm2 set pm2-webshell:port 8080
# 【Win】Windows 下 pm2-webshell 不可用


# --- 其他实用模块 ---
# pm2-gelf          将日志发送到 Graylog（GELF 格式）
# pm2-slack         将 PM2 事件通知到 Slack
# pm2-profiler      性能分析（CPU、内存快照）
# pm2-server-monit  服务器指标暴露为 StatsD 格式


# ============================================================
# 九、Windows 与 Linux 功能差异总结
# ============================================================

# ┌──────────────────────────┬───────────────┬───────────────┐
# │ 功能                     │ Linux / macOS │   Windows     │
# ├──────────────────────────┼───────────────┼───────────────┤
# │ pm2 start / stop / list  │ 支持          │ 支持          │
# │ pm2 restart / delete     │ 支持          │ 支持          │
# │ pm2 logs / flush         │ 支持          │ 支持          │
# │ pm2 save / resurrect     │ 支持          │ 支持          │
# │ cluster 模式 (fork)      │ 支持          │ 不支持        │
# │ pm2 reload (0 秒停机)    │ 支持          │ 不支持        │
# │ pm2 startup (开机自启)   │ 支持          │ 不支持        │
# │ pm2 monit (监控面板)     │ 支持          │ 部分支持      │
# │ 信号处理 (SIGTERM 等)    │ 支持          │ 不支持        │
# │ ecosystem.config.js      │ 完整支持      │ 支持(fork)    │
# └──────────────────────────┴───────────────┴───────────────┘

# 来源: https://pm2.keymetrics.io/
