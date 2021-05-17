# 在 Debian 10 上使用 UFW 来设置防火墙
ufw reload

# 输入下面的命令，安装ufw软件包：
sudo apt update
sudo apt install ufw

检查 UFW 的状态
# 安装过程不会自动激活防火墙，以避免服务器被锁住。你可以检查 UFW 的状态，输入：
sudo ufw status verbose
# 输出如下：
# Status: inactive

# 应用配置
# 列举出你系统上所有的应用配置，输入：
sudo ufw utf --help
# 例如，你想要获得 OpenSSH 配置，你可以使用：
sudo ufw app info OpenSSH

# 允许 SSH 连接
sudo ufw allow OpenSSH

# 允许端口 7722
sudo ufw allow 7722/tcp

# 启用 UFW
sudo ufw enable

# 允许 HTTP 连接：
sudo ufw allow http
# 除了使用http，你还可以使用端口号码，80：
sudo ufw allow 80/tcp
# 允许 HTTPS 连接：
sudo ufw allow https
# 你还可以使用端口号码,443：
sudo ufw allow 443/tcp

# 打开端口范围
# 允许端口从7100到7200同时支持tcp和udp，运行下面的命令：
sudo ufw allow 7100:7200/tcp
sudo ufw allow 7100:7200/udp

# 允许指定 IP 地址
# 想要允许指定 IP 地址访问所有的端口，使用ufw allow from命令，加上 IP 地址：
sudo ufw allow from 64.63.62.61

# 允许指定 IP 地址访问指定端口
# 想要允许指定端口，比如从你 IP 地址64.63.62.61的工作机器访问22端口,使用下面的命令：
sudo ufw allow from 64.63.62.61 to any port 22

# 允许子网
# 允许一个子网 IP 地址的访问和允许一个单个 IP 地址的访问，命令是一样的。唯一的不同是需要指定网络掩码。例如，如果你想要允许 IP 地址(192.168.1.1 到 192.168.1.254)，通过 3360(MySQL)，你可以使用这个命令：
sudo ufw allow from 192.168.1.0/24 to any port 3306

# 允许指定网络接口的连接
# 想要允许指定端口，比如指定网络接口eth2访问3360端口，使用allow in on 和 网络接口的名字：
sudo ufw allow in on eth2 to any port 3306

# 禁止连接
# 对于所有进来连接的默认的策略被设置为deny，它代表 UFW 将会屏蔽所有进来的连接，除非你指定打开连接。

# 比如说你打开了端口80和443，并且你的服务器处于来自23.24.25.0/24网络的攻击。想要禁止来自23.24.25.0/24的所有连接，使用下面的命令：
sudo ufw deny from 23.24.25.0/24

# 如果你仅仅像禁止从23.24.25.0/24对80和443端口的访问，使用：
sudo ufw deny from 23.24.25.0/24 to any port 80
sudo ufw deny from 23.24.25.0/24 to any port 443
# 编写禁止规则和编写允许规则是一样的。你只需要将allow替换成deny。

# 删除 UFW 规则
# 通过规则序号来删除，你需要找到你想删除的规则序号。想要这么做，运行下面的命令：
sudo ufw status numbered
# 想要删除规则，序号为3
sudo ufw delete 3
# 删除规则的第二种方法就是指定实际的规则。例如，如果你添加过一个打开端口8069的规则，你可以通过下面的命令删除它：
sudo ufw delete allow 8069

# 禁用 UFW
sudo ufw disable

# 重新启用 UFW
sudo ufw enable

# 重置 UFW
sudo ufw reset

# https://cloud.tencent.com/developer/article/1626614