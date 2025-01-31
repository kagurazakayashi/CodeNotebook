# 安装 MongoDB 客户端工具

# MongoDB 官方 GPG 密钥
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

# 添加 MongoDB 官方软件源 (Ubuntu/Debian)
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# 更新并安装 MongoDB 客户端工具
apt update
apt install mongodb-mongosh -y
# 安装完成后，运行以下命令检查版本
mongosh --version

# 连接到 MongoDB
mongosh mongodb://root:example@172.18.0.50:27017/admin
# test>
