/**
 * PM2 进程管理配置文件（ecosystem.config.js）
 *
 * 使用方法：
 *   pm2 start ecosystem.config.js                     # 默认（development）环境启动
 *   pm2 start ecosystem.config.js --env production    # 生产环境启动
 *   pm2 start ecosystem.config.js --only <app-name>   # 只启动指定应用
 *
 * 官网参考：https://pm2.keymetrics.io/docs/usage/application-declaration/
 */

module.exports = {
  // ============================================================
  // apps 数组：每个元素定义一个要管理的应用
  // ============================================================
  apps: [
    {
      // --------------------------------------------------
      // 基本信息
      // --------------------------------------------------

      /** 应用名称，显示在 pm2 list 中，也作为其他命令的标识 */
      name: "my-web-app",

      /** 启动脚本的入口文件路径（相对于 ecosystem.config.js 所在目录） */
      script: "./dist/server.js",

      /**
       * 传给脚本的命令行参数
       * 等价于：node ./dist/server.js --port 3000 --mode api
       */
      args: ["--port", "3000", "--mode", "api"],

      /**
       * 解释器（默认 "node"）
       * 也可以指定其他解释器，如 python、bash 等：
       *   interpreter: "/usr/bin/python3"
       */
      interpreter: "node",

      /**
       * 传给解释器的参数（在脚本路径之前）
       * 例如启用 ES Module、设置内存上限等：
       *   interpreter_args: "--require ts-node/register"
       *   interpreter_args: "--max-old-space-size=2048"
       */
      interpreter_args: "",

      /** 工作目录，应用进程的 cwd */
      cwd: "/var/www/my-app",

      // --------------------------------------------------
      // 进程数量与执行模式
      // --------------------------------------------------

      /**
       * 实例数量
       *   -1          ：不指定（与 1 效果相同，单实例）
       *   1           ：单实例
       *   2, 3, ...   ：固定数量实例
       *   "max"       ：等于 CPU 核心数
       *   "1+"        ：1 + CPU 核心数
       *
       * 【Win】Windows 下 instances 必须为 1
       */
      instances: "max",

      /**
       * 执行模式
       *   "fork"       ：单进程模式（所有平台可用，包括 Windows）
       *   "cluster"    ：集群模式，利用多核 CPU（仅 Linux/macOS）
       *
       * 【Win】Windows 下必须使用 "fork"
       */
      exec_mode: "cluster",

      /** 启动时是否追加实例到已有实例（而非替换），用于逐步扩容 */
      increment_var: "",

      /**
       * 当使用 cluster 模式时，PM2 默认使用轮询方式将连接分配给各实例，
       * 若设置为 true 则可让 Node.js 自身负责负载分配（仅限 Node 内部 server）
       */
      instance_var: "NODE_APP_INSTANCE",

      // --------------------------------------------------
      // 环境变量
      // --------------------------------------------------

      /** 所有环境共享的环境变量 */
      env: {
        NODE_ENV: "development",
        PORT: 3000,
        APP_NAME: "my-web-app",
      },

      /** 生产环境的环境变量（与 env 合并，同名项覆盖） */
      env_production: {
        NODE_ENV: "production",
        PORT: 80,
      },

      /** 预发布 / 灰度环境 */
      env_staging: {
        NODE_ENV: "staging",
        PORT: 8080,
      },

      /** 自定义其他环境（可任意命名） */
      env_test: {
        NODE_ENV: "test",
        PORT: 3001,
      },

      // --------------------------------------------------
      // 日志
      // --------------------------------------------------

      /**
       * 标准输出（stdout）日志文件路径
       * 不设置则默认写入 ~/.pm2/logs/<app-name>-out.log
       */
      out_file: "./logs/out.log",

      /**
       * 标准错误（stderr）日志文件路径
       * 不设置则默认写入 ~/.pm2/logs/<app-name>-error.log
       */
      error_file: "./logs/err.log",

      /**
       * 合并日志文件路径（同时包含 stdout 和 stderr）
       * 若设置了此选项，out_file 和 error_file 将被忽略，统一写入此文件
       */
      log_file: "./logs/combined.log",

      /**
       * 日志时间格式（moment.js 格式）
       * 设为 false 则不加时间戳
       */
      log_date_format: "YYYY-MM-DD HH:mm:ss Z",

      /**
       * 多实例时，是否将所有实例日志合并到同一个文件
       * true： 合并写入
       * false：每个实例各自追加 "-0", "-1" 等后缀的文件
       */
      merge_logs: true,

      /**
       * 是否将应用日志重定向到 PM2 自身的日志系统
       * false 时应用日志不会出现在 pm2 logs 中
       */
      log_type: "json",

      // --------------------------------------------------
      // 文件监听（热重载，开发用）
      // --------------------------------------------------

      /**
       * 是否监听文件变化并自动重启
       * 生产环境建议设为 false
       */
      watch: false,

      /**
       * 监听延迟（毫秒），防抖
       * 当文件变化后延迟指定时间再触发重启
       */
      watch_delay: 1000,

      /**
       * 忽略监听的文件 / 目录（glob 模式）
       * 避免监听 node_modules、日志文件等频繁变化的内容
       */
      ignore_watch: [
        "node_modules",
        "logs",
        "*.log",
        ".git",
      ],

      /**
       * 自定义监听的类型（默认只监听文件内容变化）
       * "watch_options" 中的设置参考 chokidar 库：
       *   persistent: true   持续监听
       *   ignoreInitial: true  忽略启动时的初始扫描
       *   usePolling: true   使用轮询（适用于 NFS/Docker 等场景）
       */
      // watch_options: {
      //   usePolling: true,
      //   interval: 1000,
      // },

      // --------------------------------------------------
      // 进程生命周期
      // --------------------------------------------------

      /** 进程启动超时（毫秒），超时则认为启动失败 */
      listen_timeout: 5000,

      /** 向进程发送 SIGKILL 之前的等待时间（毫秒），给应用一个优雅退出的机会 */
      kill_timeout: 5000,

      /**
       * 发送给进程的终止信号
       *   "SIGINT"  （默认，相当于 Ctrl+C）
       *   "SIGTERM" （终止信号）
       *   "SIGUSR1" / "SIGUSR2" 等自定义信号
       */
      kill_signal: "SIGINT",

      /**
       * 是否等待应用发送 "ready" 事件后才认为启动完成
       * 应用中使用：process.send('ready')
       */
      wait_ready: false,

      /**
       * PM2 关闭时是否停止该应用
       * 默认 true，设为 false 会让应用在 PM2 退出后继续运行
       */
      shutdown_with_message: true,

      // --------------------------------------------------
      // 自动重启策略
      // --------------------------------------------------

      /**
       * 进程异常退出时是否自动重启
       * true： 始终自动重启
       * false：不自动重启
       */
      autorestart: true,

      /**
       * 应用被视为"正常运行"的最短时间（毫秒）
       * 如果应用运行时间短于此值就退出，PM2 会认为异常并递增重启计数
       */
      min_uptime: "10s",

      /**
       * 最大异常重启次数
       * 如果在 min_uptime 时间段内重启超过此次数，PM2 将停止应用
       * 配合 min_uptime 使用，防止"死循环重启"
       */
      max_restarts: 10,

      /**
       * 异常重启之间的等待时间（毫秒）
       * 避免应用立即崩溃后 CPU 空转
       */
      restart_delay: 3000,

      /**
       * 内存超过此值时自动重启（支持 K/M/G 单位）
       * 例如 "500M"、"1G"
       * 【Win】行为可能不一致，建议谨慎使用
       */
      max_memory_restart: "500M",

      /**
       * 当进程超过指定 CPU 使用率（百分比）时自动重启
       * 需要配合 pm2-server-monit 使用
       */
      // max_cpu_restart: "90",

      /**
       * 每天在指定时间重启（cron 格式）
       * 例如 "0 3 * * *" 表示每天凌晨 3 点重启
       * 适用于需要定期释放内存的长时运行应用
       */
      cron_restart: "",

      /**
       * 进程退出码中哪些视为正常退出（不触发自动重启）
       * 默认 [0] 表示只有 0 为正常退出
       */
      exp_backoff_restart_delay: 100,

      // --------------------------------------------------
      // 部署（deploy 操作）
      // --------------------------------------------------

      /**
       * 当 PM2 版本升级后，是否将当前运行中的配置格式更新
       * 一般保持默认
       */
      filter_env: [],

      /**
       * PID 文件路径
       * PM2 会写入进程的 PID 到此文件
       */
      pid_file: "./logs/app.pid",

      /**
       * 在容器化环境中，重定向日志到 /dev/null 可以避免日志膨胀
       * 前提是你已经将日志通过其他方式收集（如 stdout 直接由 Docker 收集）
       */
      // out_file: "/dev/null",
      // error_file: "/dev/null",

      /**
       * 指定应用在来源控制（source control）中忽略的文件
       * 主要用于 pm2 deploy 过程中
       */
      source_map_support: true,

      /**
       * 是否使用 "V8 Inspector" 来调试
       * 设为 true 则等价于 node --inspect
       * 可指定端口：node_args: ["--inspect=9229"]
       */
      node_args: [],

      /**
       * 是否将进程绑定到特定 CPU（CPU 亲和性）
       * 例如 "0,2" 表示绑定到第 0 和第 2 个 CPU 核心
       * 仅在 cluster 模式下生效
       */
      vizion: true,

      /**
       * 实例间切换的负载策略（仅 cluster 模式）
       *   "round-robin"            轮询（默认，由 PM2 控制）
       *   设为 ""（空字符串）或删除此字段，则由操作系统分配
       */
      // listen: "0.0.0.0:3000",

      /**
       * 定义进程被标记为 online 之前需要打开的端口
       * 端口就绪后 PM2 才会记录为 online 状态
       */
      // port: 3000,

      /**
       * 设置用户 / 组身份运行该应用
       * 仅在以 root 启动 PM2 时有效
       */
      // uid: "www-data",
      // gid: "www-data",

      /**
       * 应用描述，供 pm2 show 和 Keymetrics 面板展示
       */
      // vizion: false,
    },

    // ==========================================================
    // 示例：第二个应用配置（同时管理多个应用）
    // ==========================================================
    {
      name: "my-worker",
      script: "./workers/email-worker.js",
      instances: 1,
      exec_mode: "fork",
      autorestart: true,
      watch: false,
      env: {
        NODE_ENV: "production",
        QUEUE_NAME: "email",
      },
      env_production: {
        NODE_ENV: "production",
      },
      max_memory_restart: "300M",
      error_file: "./logs/worker-err.log",
      out_file: "./logs/worker-out.log",
    },

    // ==========================================================
    // 示例：Python 应用
    // ==========================================================
    // {
    //   name: "my-python-service",
    //   script: "./python_service.py",
    //   interpreter: "/usr/bin/python3",
    //   interpreter_args: "-u",   // -u 让 stdout 不缓冲，日志实时输出
    //   exec_mode: "fork",
    //   instances: 1,
    //   autorestart: true,
    //   watch: false,
    // },

    // ==========================================================
    // 示例：Shell 脚本作为常驻进程
    // ==========================================================
    // {
    //   name: "my-cron-script",
    //   script: "./loop-task.sh",
    //   interpreter: "/bin/bash",
    //   exec_mode: "fork",
    //   instances: 1,
    //   autorestart: true,
    //   cron_restart: "0 */2 * * *",   // 每 2 小时重启一次
    // },

    // ==========================================================
    // 示例：TypeScript 应用（使用 ts-node 直接运行）
    // ==========================================================
    // {
    //   name: "my-ts-app",
    //   script: "./src/index.ts",
    //   interpreter: "node",
    //   interpreter_args: "--require ts-node/register --require tsconfig-paths/register",
    //   exec_mode: "fork",
    //   instances: 1,
    //   watch: true,
    //   ignore_watch: ["node_modules", "logs"],
    //   env: {
    //     NODE_ENV: "development",
    //   },
    // },
  ],

  // ============================================================
  // deploy：远程部署配置
  // 使用：pm2 deploy ecosystem.config.js production setup   # 首次部署
  //       pm2 deploy ecosystem.config.js production          # 后续更新
  // ============================================================
  deploy: {
    production: {
      /**
       * SSH 登录用户名
       * 建议使用专用部署用户而非 root
       */
      user: "deploy",

      /**
       * 服务器 IP 或域名，多台服务器用逗号分隔
       * host: ["192.168.1.100", "192.168.1.101"]
       */
      host: "192.168.1.100",

      /**
       * SSH 端口（默认 22）
       */
      port: "22",

      /**
       * SSH 私钥路径
       * 不设置则使用默认的 ~/.ssh/id_rsa
       */
      key: "~/.ssh/deploy_rsa",

      /**
       * Git 分支
       */
      ref: "origin/main",

      /**
       * Git 仓库地址
       * 支持 git@github 和 https 格式（https 需配置密码或 token）
       */
      repo: "git@github.com:username/my-app.git",

      /**
       * 目标服务器上的部署根目录
       * PM2 会自动创建 path/source、path/current 等子目录
       */
      path: "/var/www/my-app",

      /**
       * 部署前在本地执行的命令（在 git clone/pull 之前）
       * 可用于本地构建、跑测试等
       */
      "pre-deploy": "npm run build",

      /**
       * 部署后在服务器上执行的命令（在 git clone/pull 之后）
       * 这是最常用的钩子，用于安装依赖和重启应用
       */
      "post-deploy": "npm install --production && pm2 reload ecosystem.config.js --env production",

      /**
       * 完整部署 + 重启完成后在服务器上执行的命令
       */
      "post-setup": "pm2 start ecosystem.config.js --env production",

      /**
       * 设置前在服务器上执行的命令（首次 setup 时）
       * 如创建目录、安装系统依赖等
       */
      // "pre-setup": "apt update && apt install git -y",
    },

    // 灰度 / 预发布环境
    staging: {
      user: "deploy",
      host: "192.168.1.200",
      ref: "origin/develop",
      repo: "git@github.com:username/my-app.git",
      path: "/var/www/my-app-staging",
      "post-deploy": "npm install && pm2 reload ecosystem.config.js --env staging",
    },
  },
};
