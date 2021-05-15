# 添加源
vim /etc/apt/sources.list
# deb https://mirrors.tuna.tsinghua.edu.cn/debian-security stretch/updates main

# 已有tuna也要加：
# deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free

# 查看当前版本
java -version

# 切换版本
update-alternatives --config java