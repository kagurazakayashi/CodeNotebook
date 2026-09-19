#!/bin/bash
# 查看 Linux 端口占用情况的常用命令合集
# 来源：日常使用整理

# 方法一：使用 lsof（需要 root 权限查看所有进程的端口）
# 查看指定端口（例如 8080）被哪个进程占用
echo "=== lsof 查看指定端口 ==="
lsof -i :8080

# 查看所有 TCP 端口占用
echo "=== lsof 查看所有 TCP 端口 ==="
lsof -i tcp

# 查看所有监听中的端口
echo "=== lsof 查看所有监听端口 ==="
lsof -i -sTCP:LISTEN

# 方法二：使用 ss（推荐，比 netstat 更快）
# 查看所有 TCP 监听端口（显示进程名）
echo "=== ss 查看 TCP 监听端口（含进程名） ==="
ss -tlnp

# 查看所有 UDP 监听端口（显示进程名）
echo "=== ss 查看 UDP 监听端口（含进程名） ==="
ss -ulnp

# 查看所有监听端口（TCP + UDP）（显示进程名）
echo "=== ss 查看所有监听端口（TCP + UDP） ==="
ss -tulnp

# 查看指定端口的占用情况
echo "=== 查看 80 端口占用 ==="
ss -tlnp | grep ':80 '

# 方法三：使用 netstat（传统工具，部分发行版需额外安装 net-tools）
# 查看所有 TCP 监听端口
echo "=== netstat 查看 TCP 监听端口 ==="
netstat -tlnp

# 查看所有监听端口（TCP + UDP）
echo "=== netstat 查看所有监听端口（TCP + UDP） ==="
netstat -tulnp

# 查看指定端口
echo "=== netstat 查看 443 端口 ==="
netstat -tlnp | grep ':443 '

# 方法四：使用 fuser
# 查看指定端口被哪个进程占用（返回 PID）
echo "=== fuser 查看 8080 端口 ==="
fuser 8080/tcp

# 附带查看进程详情
echo "=== fuser 查看 8080 端口并附带进程详情 ==="
fuser -v 8080/tcp

# 方法五：使用 /proc 文件系统
# 直接读取 /proc/net/tcp 查看 TCP 连接（十六进制端口号，需转换）
echo "=== 读取 /proc/net/tcp 查看端口 16 进制表示 ==="
grep -v "rem_address" /proc/net/tcp | awk '{
    split($2, local, ":");
    port = strtonum("0x" local[2]);
    if (port == 8080) print $0;
}'

# 实战技巧：
# 1. 根据端口号杀进程：kill -9 $(lsof -t -i:8080)
# 2. 查看端口范围占用：ss -tlnp | awk '$4 ~ /:80..$/'
# 3. 持续监控端口变化：watch -n 1 'ss -tlnp | grep ":80 "'
