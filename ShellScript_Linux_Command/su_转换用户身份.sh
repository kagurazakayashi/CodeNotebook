# 转换用户身份，用不同的用户和组运行 Shell。
# su [<user>]
# 使用 exit 命令或 Ctrl+D 文件结束符返回到注册用户的 Shell。
# 管理员切换到普通用户不需要密码，反之需要

# 使用 yashi 身份操作
su yashi
# 查看当前工作路径
pwd
# /root
# 检查是否切换
whoami
# yashi

# 使用 yashi 身份操作，并使用 yashi 的环境
su - yashi
# 查看当前工作路径
pwd
# /home/yashi
# 检查是否切换
whoami
# yashi

# 切换到主管理员
su
su -
# 等同于
su root
su - root