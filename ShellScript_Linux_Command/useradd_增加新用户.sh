# 增加新用户 user01
useradd user01
# 该命令会：
# - 在 `/etc/passwd` 文件中建立没有密码的用户项目。
# - 为用户指定用户 ID 。缺省的 ID 大于或等于 100 或 500 ，并大于其它所用用户 ID 。
# - 把用户加入到响应的组中。缺省建立与用户名相同的组。
# - 建立用户主目录，并把 `/etc/skel` 的内容复制到目录中。

# useradd 命令的选项
# -u 指定新用户的 ID 。
useradd -u 10001 user01
# -g 指定新用户的组。
useradd -g users user01
# -d 指定新用户的主目录。
useradd -d /other/home/directory user01

# 改变 useradd 命令的缺省设置
# 使用 -D 选项改变 useradd 命令的缺省设置
# 使用 -b 选项改变主目录的缺省路径
useradd -D -b /users
# 使用 -g 选项改变缺省的组
useradd -D -g users

# 默认无密码，要为新建的用户设定密码
passwd user01