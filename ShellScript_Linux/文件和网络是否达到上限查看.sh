#!/bin/bash
# 检查文件描述符数量是否达到上限
# 检查 TCP 连接数是否达到上限

echo "当前用户已用文件描述符数量："
used_fd=$(lsof -u $(whoami) | wc -l)
echo "$used_fd"

echo ""

echo "当前用户文件描述符限制："
echo "软限制：$user_fd_limit"
ulimit -n
echo "硬限制：$user_fd_hard_limit"
ulimit -Hn

echo ""

echo "系统级别文件描述符限制：系统最大文件描述符数量："
cat /proc/sys/fs/file-max

echo ""

echo "当前系统使用的文件描述符数量："
cat /proc/sys/fs/file-nr | awk '{print $1}'

echo ""

echo "系统网络连接数量限制："
sysctl net.core.somaxconn

echo ""

echo "当前网络连接数量（ESTABLISHED）："
ss -s | grep -i estab | awk '{print $2}'

echo ""

echo "当前 TCP 连接跟踪表使用情况："
sysctl net.netfilter.nf_conntrack_count

echo ""

echo "TCP 连接跟踪表最大限制："
sysctl net.netfilter.nf_conntrack_max
