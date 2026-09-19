#!/bin/bash

###############################################################################
# Mastodon 每月维护脚本
#
# 功能：
#
#   1. 删除缓存的所有远程 Custom Emoji
#   2. 清理从未真正与本站用户发生交互的无用远程账号
#   3. 输出媒体存储统计
#
#
# 注意：
#
# emoji purge --remote-only
#
# 没有“保留 N 天”的功能。
#
# 每次执行都会清除当前缓存的远程 Emoji。
#
# 它不会删除本站自己上传的 Custom Emoji。
###############################################################################

set -u

CONTAINER="mastodon-web-1"

LOG_DIR="/var/log/yashi"
LOG_FILE="${LOG_DIR}/mastodonclean.log"

LOCK_FILE="/run/lock/mastodon-clean.lock"

mkdir -p "$LOG_DIR"

exec 9>"$LOCK_FILE"

if ! flock -n 9; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [每月清理] 检测到已有 Mastodon 清理任务正在运行，本次任务跳过。" >> "$LOG_FILE"
    exit 0
fi

exec >> "$LOG_FILE" 2>&1

FAILED=0


run_command() {
    echo
    echo "----------------------------------------------------------------------"
    echo "开始执行：$*"
    echo "开始时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "----------------------------------------------------------------------"

    "$@"
    RC=$?

    if [ "$RC" -eq 0 ]; then
        echo "执行结果：成功"
    else
        echo "执行结果：失败"
        echo "退出代码：$RC"
        FAILED=1
    fi

    echo "完成时间：$(date '+%Y-%m-%d %H:%M:%S')"
}


echo
echo
echo "======================================================================"
echo "              Mastodon 每月维护开始"
echo "======================================================================"
echo "时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo
echo "本次任务："
echo "  - 清理全部远程 Custom Emoji 缓存"
echo "  - 清理无用远程账号"
echo "  - 输出媒体使用统计"
echo "======================================================================"


###############################################################################
# 1. 删除远程 Custom Emoji
#
# 必须使用 --remote-only。
#
# 如果不带 --remote-only，会连本站自定义 Emoji 一起删除。
###############################################################################

echo
echo "【1/3】清理远程 Custom Emoji"

run_command \
    docker exec \
    -e RAILS_ENV=production \
    "$CONTAINER" \
    bin/tootctl emoji purge \
    --remote-only


###############################################################################
# 2. 清理没有本地交互价值的远程账号
#
# accounts prune 与 accounts cull 不一样。
#
# prune：
#   针对从未真正与本站用户发生交互的远程账号记录。
#
# cull：
#   会主动访问远程服务器确认账号是否仍存在。
#
# cull 可能产生大量网络请求，所以这里不自动执行 cull。
###############################################################################

echo
echo "【2/3】清理无用远程账号记录"

run_command \
    docker exec \
    -e RAILS_ENV=production \
    "$CONTAINER" \
    bin/tootctl accounts prune


###############################################################################
# 3. 输出当前媒体使用情况
###############################################################################

echo
echo "【3/3】输出每月维护后的媒体使用情况"

run_command \
    docker exec \
    -e RAILS_ENV=production \
    "$CONTAINER" \
    bin/tootctl media usage


echo
echo "======================================================================"

if [ "$FAILED" -eq 0 ]; then
    echo "Mastodon 每月维护完成：全部任务执行成功"
else
    echo "Mastodon 每月维护完成：存在失败任务，请检查日志"
fi

echo "结束时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================================================"
echo

exit "$FAILED"
