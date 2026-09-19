#!/bin/bash
# SSH缓存密钥，防止每次都输入密码

PRIVATE_KEY_PATH="key.pem" # 私钥

# 检查是否已启动 ssh-agent
AGENT_SOCK=$(ls /tmp/ssh-*/agent.* 2>/dev/null | head -n 1)
if [ -n "$AGENT_SOCK" ] && [ -S "$AGENT_SOCK" ]; then
    # 如果找到可用的 ssh-agent，设置环境变量
    export SSH_AUTH_SOCK="$AGENT_SOCK"
    export SSH_AGENT_PID=$(basename $(dirname "$AGENT_SOCK") | cut -d'.' -f2)
else
    # 如果没有找到有效的 ssh-agent，启动新的 ssh-agent
    echo "ssh-agent 没有启动，正在启动..."
    eval "$(ssh-agent -s)"
    sleep 5
fi
echo "ssh-agent 已经启动: $SSH_AGENT_PID: $SSH_AUTH_SOCK"

# 检查私钥是否已加载
if ! ssh-add -l | grep "$(basename $PRIVATE_KEY_PATH)" > /dev/null 2>&1; then
    echo "开始加载私钥: $PRIVATE_KEY_PATH"
    ssh-add "$PRIVATE_KEY_PATH"
else
    echo "私钥已经加载: $PRIVATE_KEY_PATH"
fi

# 退出 ssh-agent
# ssh-agent -k
