# 创建用户并给予sudo权限.sh

# 使用 useradd 命令来创建一个新用户。你需要使用 -m 选项来为用户创建一个家目录。例如，如果你想创建一个用户名为 exampleuser 的用户，你可以使用以下命令：
sudo useradd -m exampleuser

# 创建用户后，你需要为其设置一个密码。使用 passwd 命令为新用户设置密码：
sudo passwd exampleuser

# 给予 sudo 权限
sudo usermod -aG wheel exampleuser

# 编辑 /etc/sudoers 文件
sudo visudo
# 在 visudo 编辑器中，找到类似这样的行（可能已经有了或需要你取消注释）：
# %wheel ALL=(ALL) ALL

# 查看信息
grep exampleuser /etc/passwd

# 修改用户的默认 shell
sudo usermod -s /usr/bin/bash exampleuser

# 删除一个用户，你可以使用 userdel 命令。如果你还想同时删除用户的家目录以及邮件目录，你可以使用 -r 选项。这是一个例子，展示如何删除用户名为 exampleuser 的用户：
sudo userdel -r exampleuser
