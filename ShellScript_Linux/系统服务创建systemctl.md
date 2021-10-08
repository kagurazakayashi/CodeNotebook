# CentOS 7 的 服务 systemctl 脚本位置
系统: `/usr/lib/systemd/system`
用户: `/usr/lib/systemd/user`

# 配置文件优先级
这三个目录的配置文件优先级依次从低到高，如果同一选项三个地方都配置了，优先级高的会覆盖优先级低的。 
1. `/lib/systemd/system`
2. `/run/systemd/system`
  - 这个目录一般是进程在运行时动态创建 unit 文件的目录，一般很少修改，除非是修改程序运行时的一些参数时，即 Session 级别的，才在这里做修改。
3. `/etc/systemd/system`
  - 如果我们想要修改系统默认的配置，比如 nginx.service，一般有两种方法：
  - 在此目录下创建 nginx.service 文件，里面写上我们自己的配置。
  - 在此目录下创建 nginx.service.d 目录，在这个目录里面新建任何以.conf 结尾的文件，然后写入我们自己的配置。推荐这种做法。

# 服务配置
```
[Unit]
# 服务的简单描述
Description=nginx - high performance web server
# 服务文档
Documentation=http://nginx.org/en/docs/
# 依赖，仅当依赖的服务启动之后再启动自定义的服务单元
After=network.target remote-fs.target nss-lookup.target

[Service]
# 启动类型 simple、forking、oneshot、notify、dbus
Type=forking
# pid 文件路径
PIDFile=/usr/local/nginx/logs/nginx.pid
# 启动前要做什么，nginx 测试了配置文件 -t
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf
# 启动
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
# 重载
ExecReload=/bin/kill -s HUP $MAINPID
# 停止
ExecStop=/bin/kill -s QUIT $MAINPID
# 给服务分配独立的临时空间
PrivateTmp=true
# 以指定用户启动
User=pi
Group=pi

[Install]
# 服务安装的用户模式，从字面上看，就是想要使用这个服务的有是谁？multi-user.target 就是指想要使用这个服务的目录是多用户。
WantedBy=multi-user.target
```
## Service
- `Type` : 启动类型 simple、forking、oneshot、notify、dbus
  - `simple`:（默认值）：systemd 认为该服务将立即启动，服务进程不会 fork。如果该服务要启动其他服务，不要使用此类型启动，除非该服务是 socket 激活型
  - `forking`: systemd 认为当该服务进程 fork，且父进程退出后服务启动成功。对于常规的守护进程（daemon），除非你确定此启动方式无法满足需求， 使用此类型启动即可。使用此启动类型应同时指定 PIDFile=，以便 systemd 能够跟踪服务的主进程。
  - `oneshot`: 这一选项适用于只执行一项任务、随后立即退出的服务。可能需要同时设置 `RemainAfterExit=yes` 使得 systemd 在服务进程退出之后仍然认为服务处于激活状态。
  - `notify`: 与 Type=simple 相同，但约定服务会在就绪后向 systemd 发送一个信号，这一通知的实现由 libsystemd-daemon.so 提供
  - `dbus`: 若以此方式启动，当指定的 BusName 出现在 DBus 系统总线上时，systemd 认为服务就绪。
- `Environment`: 环境变量（可以添加多个）eg : `Environment=REPO_REF=dev`
- `EnvironmentFile`: 可以在 ExecStart 等处使用 `$OPTIONS` 获得此处变量。
- Exec
  - `ExecReload`: 重启服务时执行的命令
  - `ExecStop`: 停止服务时执行的命令
  - `ExecStartPre`: 启动服务之前执行的命令
  - `ExecStartPost`: 启动服务之后执行的命令
  - `ExecStopPost`: 停止服务之后执行的命令
- `KillMode`: 定义 Systemd 如何停止 sshd 服务。
  - `control-group`（默认值）: 当前控制组里面的所有子进程，都会被杀掉
  - `process`: 只杀主进程
  - `mixed`: 主进程将收到 SIGTERM 信号，子进程收到 SIGKILL 信号
  - `none`: 没有进程会被杀掉，只是执行服务的 stop 命令。
- `Restart`: 定义了 sshd 退出后，Systemd 的重启方式。
  - `no`（默认值）: 退出后不会重启
  - `on-success`: 只有正常退出时（退出状态码为0），才会重启
  - `on-failure`: 非正常退出时（退出状态码非0），包括被信号终止和超时，才会重启
  - `on-abnormal`: 只有被信号终止和超时，才会重启
  - `on-abort`: 只有在收到没有捕捉到的信号终止时，才会重启
  - `on-watchdog`: 超时退出，才会重启
  - `always`: 不管是什么退出原因，总是重启
- `RestartSec=42s`
- `User=myuser`
- `Group=myuser`
- `WorkingDirectory`: `/.../` 工作目录

# 操作示例
每一个.target 实际上是链接到我们单位文件的集合，当我们执行 `systemctl enable nginx.service` 就会在 `/etc/systemd/system/multi-user.target.wants/` 目录下新建一个 `/usr/lib/systemd/system/nginx.service` 文件的链接。

# 常用的 service 操作
## 每一次修改ExecStart都需执行
`systemctl daemon-reload`
## 自启动
`systemctl enable nginx.service`
## 禁止自启动
`systemctl disable nginx.service`
## 启动服务
`systemctl start nginx.service`
## 停止服务
`systemctl stop nginx.service`
## 重启服务
`systemctl restart nginx.service`
## 查看Unit定义文件
`systemctl cat nginx.service`
## 编辑Unit定义文件
`systemctl edit nginx.service`
## 重新加载Unit定义文件
`systemctl reload nginx.service`
## 列出已启动的所有unit，就是已经被加载到内存中
`systemctl list-units`
## 列出系统已经安装的所有unit，包括那些没有被加载到内存中的unit
`systemctl list-unit-files`
## 查看服务的日志
`journalctl -u nginx.service`    # 还可以配合`-b`一起使用，只查看自本次系统启动以来的日志
## 查看所有target下的unit
`systemctl list-unit-files --type=target`
## 查看默认target，即默认的运行级别。对应于旧的`runlevel`命令
`systemctl get-default`
## 设置默认的target
`systemctl set-default multi-user.target`
## 查看某一target下的unit
`systemctl list-dependencies multi-user.target`
## 切换target，不属于新target的unit都会被停止
`systemctl isolate multi-user.target`
`systemctl poweroff`  # 关机
`systemctl reboot`    # 重启
`systemctl rescue`    # 进入rescue模式


[https://learnku.com/articles/34025]
[https://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html]