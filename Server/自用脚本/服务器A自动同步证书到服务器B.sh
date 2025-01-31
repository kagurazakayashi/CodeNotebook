#!/bin/bash
# 服务器A使用SSH自动同步证书到服务器B

# 配置部分
PRIVATE_KEY_PATH="/server/ssl/sshkey.pem" # 私钥
REMOTE_USER="root" # 用户名
REMOTE_HOST="192.168.1.234" # 服务器

# 文件传输列表 (格式: "本地文件路径 目标路径")
FILES_TO_TRANSFER=(
    "/var/lib/docker/volumes/nginx_conf/_data/fullchain.pem /var/lib/docker/volumes/nginx_conf/_data/fullchain.pem"
    "/var/lib/docker/volumes/nginx_conf/_data/privkey.pem /var/lib/docker/volumes/nginx_conf/_data/privkey.pem"
)

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

# 文件传输逻辑
echo "开始传输文件..."
for FILE_PAIR in "${FILES_TO_TRANSFER[@]}"; do
    LOCAL_FILE=$(echo $FILE_PAIR | awk '{print $1}')
    REMOTE_FILE=$(echo $FILE_PAIR | awk '{print $2}')
    
    echo "上传文件 $LOCAL_FILE 到 $REMOTE_USER@$REMOTE_HOST:$REMOTE_FILE..."
    scp -i "$PRIVATE_KEY_PATH" "$LOCAL_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_FILE"
    
    if [ $? -eq 0 ]; then
        echo "文件传输成功: $LOCAL_FILE -> $REMOTE_USER@$REMOTE_HOST:$REMOTE_FILE"
    else
        echo "文件传输失败: $LOCAL_FILE -> $REMOTE_USER@$REMOTE_HOST:$REMOTE_FILE"
    fi
done

echo "文件传输脚本结束。"

# 重启远程服务器上的 Docker 容器
DOCKER_CONTAINER_NAME="nginx"

echo "重载 Docker 容器: $DOCKER_CONTAINER_NAME 于 $REMOTE_HOST..."
ssh -i "$PRIVATE_KEY_PATH" "$REMOTE_USER@$REMOTE_HOST" << EOF
docker exec $DOCKER_CONTAINER_NAME nginx -s reload
EOF

if [ $? -eq 0 ]; then
    echo "$REMOTE_HOST 上的 Docker 容器 '$DOCKER_CONTAINER_NAME' 已成功重载。"
else
    echo "$REMOTE_HOST 上的 Docker 容器 '$DOCKER_CONTAINER_NAME' 重载失败。"
fi

# 退出 ssh-agent
# ssh-agent -k
