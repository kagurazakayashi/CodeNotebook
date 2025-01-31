#!/bin/bash

# 使用方式：./git_time.sh 2024-01-01 "sync"

# 参数验证
if [ "$#" -ne 2 ]; then
    echo "用法: $0 <日期 (YYYY-MM-DD)> <提交消息>"
    exit 1
fi

# 提取参数
DATE=$1
MESSAGE=$2

# 生成随机分钟和秒数
MINUTE=$((RANDOM % 60))
SECOND=$((RANDOM % 60))

# 补零
if [ "$MINUTE" -lt 10 ]; then
    MINUTE="0$MINUTE"
fi
if [ "$SECOND" -lt 10 ]; then
    SECOND="0$SECOND"
fi

# 构造提交时间
GIT_COMMITTER_DATE="${DATE}T20:${MINUTE}:${SECOND}"
GIT_AUTHOR_DATE="${GIT_COMMITTER_DATE}"

# 设置环境变量
export GIT_COMMITTER_DATE
export GIT_AUTHOR_DATE

# 提交
git commit --date="$GIT_COMMITTER_DATE" -m "$MESSAGE"

# 清理环境变量
unset GIT_COMMITTER_DATE
unset GIT_AUTHOR_DATE
