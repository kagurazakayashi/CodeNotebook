# apk Alpine包管理器 apk (Alpine Package Keeper)

# 当前软件源位置
cat /etc/apk/repositories

# 更新软件源索引
apk update

# 查找软件
apk search 软件名
# 模糊搜索
apk search -v nginx

# 安装软件
apk add 软件名
# 安装指定版本
apk add nginx=1.24.0-r0
# 安装时避免缓存（ Docker RUN 时建议 ）
apk add --no-cache 软件名

# 卸载软件
apk del 软件名

# 更新所有已安装包
apk upgrade
# 只更新指定软件
apk upgrade nginx

# 清理缓存（容器场景常用）
rm -rf /var/cache/apk/*

# 查看已安装软件
apk info
# 查看某个软件信息
apk info nginx
# 查看依赖
apk info -R nginx

# 锁定软件版本防止升级
apk add nginx=1.24.0-r0
echo nginx >> /etc/apk/world

# 查看 Alpine 版本
cat /etc/alpine-release

# 修复依赖 / 重建 Alpine 所有安装记录
# cat /etc/apk/world
# 如果损坏可以：
apk fix

# 查看仓库签名 key
ls /etc/apk/keys/

# 只安装虚拟依赖（构建用）
apk add --virtual .build-deps gcc make musl-dev
# 构建完成后：
apk del .build-deps


# 生产环境建议
# 如果你是：

# 容器
# ARM 服务器
# NanoPi / Oracle ARM

# 边缘网关
# 建议：
# 用 stable 版本
# 用 --no-cache
# 不用 edge
# 固定版本构建镜像
