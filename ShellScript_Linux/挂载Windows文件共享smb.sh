#!/bin/bash
# 挂载Windows文件共享smb

# 安装必要的软件包
sudo apt update
sudo apt install samba cifs-utils -y

# 创建挂载点
sudo mkdir /mnt/smb

# 挂载共享文件夹
sudo mount.cifs //WINDOWS_IP/SHARE_NAME /mnt/smb -o username=WINDOWS_USERNAME,password=WINDOWS_PASSWORD
sudo mount.cifs //192.168.1.5/sharedir /mnt/smb -o username=yashi

# 挂载成功后，可以通过以下命令查看
df -h

# 访问挂载点
cd /mnt/smb
ls -ahl

# 上传文件到共享文件夹
cp /path/to/local/file /mnt/smb/

# 从共享文件夹下载文件
cp /mnt/smb/file /path/to/local/destination/

# 开机自动挂载
sudo nano /etc/fstab
# //WINDOWS_IP/SHARE_NAME /mnt/windows_share cifs username=WINDOWS_USERNAME,password=WINDOWS_PASSWORD,iocharset=utf8,vers=3.0 0 0

# 取消挂载
umount /mnt/smb
