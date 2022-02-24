sudo apt install samba-common-bin samba -y
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
sudo vim /etc/samba/smb.conf
# shift-g 跳到最后一行，加入如下语句：
# 在末尾加入如下内容

# 分享名称
[Pi]
    # 说明信息
    comment = Pi Storage
    # 可以访问的用户
    valid users = pi,root
    # 共享文件的路径,raspberry pi 会自动将连接到其上的外接存储设备挂载到/media/pi/目录下。
    path = /media/pi/
    # 可被其他人看到资源名称（非内容）
    browseable = yes
    # 可写
    writable = yes
    # 新建文件的权限为 664
    create mask = 0664
    # 新建目录的权限为 775
    directory mask = 0775


# 可以把配置文件中你不需要的分享名称删除，例如 [homes], [printers] 等。
# 测试配置文件是否有错误，根据提示做相应修改
testparm
# 添加登陆账户并创建密码，必须是 linux 已存在的用户
sudo smbpasswd -a pi
# 重启 samba 服务
sudo /etc/init.d/smbd restart && sudo /etc/init.d/nmbd restart

# https://www.cnblogs.com/shellstudio/p/10756419.html
# https://www.jianshu.com/p/5de3a2e688b4


# SMB 端口号
# TCP 139 NETBIOS 是一种传输层协议，旨在通过网络在Windows操作系统中使用。
sudo ufw allow 139/tcp
# TCP 445 是基于IP的SMB。这是较新的版本，可以在IP网络上正常使用SMB。
sudo ufw allow 445/tcp
# UDP 137 NetBIOS名称服务（NBNS）
sudo ufw allow 137/udp
# UDP 138 NetBIOS数据报
sudo ufw allow 138/udp
# https://blog.csdn.net/gengzhikui1992/article/details/89183302



# 苹果 afp 协议
sudo apt install netatalk -y
sudo vim /etc/netatalk/afp.conf
sudo systemctl restart netatalk
sudo ufw allow 548/tcp