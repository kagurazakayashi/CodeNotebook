#!/bin/bash

###############################################################################
# Mastodon 每周清理脚本
#
# 主要功能：
#
#   清理超过 365 天的远程帖子正文 / Content Cache
#
# Mastodon 后台设置保持：
#
#   content_cache_retention_period=nil
#
# 不使用 Mastodon scheduler 自动 retention。
#
# 而是在这里直接调用：
#
#   Vacuum::StatusesVacuum.new(365.days).perform
#
# 这基本对应“远程内容保留 365 天”的内建 Vacuum 行为。
#
#
# !!! 重要警告 !!!
#
# 这是一个有数据损失风险的清理。
#
# 超过 365 天的远程帖子可能被本地数据库删除，即使：
#
#   - 你曾经喜欢过
#   - 你曾经转发过
#   - 你曾经收藏过
#   - 它属于旧的回复链
#
# 它不会向远程实例发送 Undo 来撤销以前的 Like / Boost。
#
# 因此，这里必须明确理解：
#
#   “删除本地缓存记录”
#
# 和：
#
#   “正常撤销 ActivityPub 操作”
#
# 不是同一件事情。
###############################################################################

set -u

CONTAINER="mastodon-web-1"

LOG_DIR="/var/log/yashi"
LOG_FILE="${LOG_DIR}/mastodonclean.log"

LOCK_FILE="/run/lock/mastodon-clean.lock"

mkdir -p "$LOG_DIR"

exec 9>"$LOCK_FILE"

if ! flock -n 9; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [每周清理] 检测到已有 Mastodon 清理任务正在运行，本次任务跳过。" >> "$LOG_FILE"
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
echo "              Mastodon 每周深度清理开始"
echo "======================================================================"
echo "时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo
echo "本次清理内容："
echo "  - 删除超过 365 天的远程 Content Cache"
echo "  - 清理因此产生的孤立媒体记录"
echo "  - 输出当前媒体使用情况"
echo
echo "警告：365 天 Content 清理具有不可逆的数据删除性质。"
echo "======================================================================"


###############################################################################
# 1. 清理超过 365 天的远程 Status
###############################################################################

echo
echo "【1/3】清理超过 365 天的远程 Content Cache"

run_command \
    docker exec \
    -e RAILS_ENV=production \
    "$CONTAINER" \
    bin/rails runner \
    '
puts "开始执行远程 Content Cache 365 天清理..."
puts "清理开始时间：#{Time.now}"
Vacuum::StatusesVacuum.new(365.days).perform
puts "远程 Content Cache 清理完成。"
puts "清理完成时间：#{Time.now}"
'


###############################################################################
# 2. 清理由 Status 删除后留下的 unattached media
#
# Status 被删除以后，部分 MediaAttachment 会变成 unattached。
#
# 使用 Mastodon 自己的 MediaAttachmentsVacuum 处理。
###############################################################################

echo
echo "【2/3】清理由 Content 清理产生的孤立媒体记录"

run_command \
    docker exec \
    -e RAILS_ENV=production \
    "$CONTAINER" \
    bin/rails runner \
    '
puts "开始清理孤立 MediaAttachment..."
Vacuum::MediaAttachmentsVacuum.new(7.days).perform
puts "MediaAttachment 清理完成。"
'


###############################################################################
# 3. 输出媒体使用情况
###############################################################################

echo
echo "【3/3】输出每周清理后的媒体使用情况"

run_command \
    docker exec \
    -e RAILS_ENV=production \
    "$CONTAINER" \
    bin/tootctl media usage


echo
echo "======================================================================"

if [ "$FAILED" -eq 0 ]; then
    echo "Mastodon 每周深度清理完成：全部任务执行成功"
else
    echo "Mastodon 每周深度清理完成：存在失败任务，请检查日志"
fi

echo "结束时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================================================"
echo

exit "$FAILED"
