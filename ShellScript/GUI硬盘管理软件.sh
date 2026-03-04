# GUI硬盘管理软件
apt install gparted gnome-disk-utility partitionmanager lvm2 -y

### 1. **GParted**
# GParted 是一个功能强大的磁盘分区工具，支持多种文件系统的分区管理。
  sudo apt update
  sudo apt install gparted
# * **启动命令：**
  sudo gparted

### 2. **Disks (gnome-disk-utility)**
# 这是 GNOME 桌面环境中自带的磁盘管理工具，支持磁盘分区、格式化、挂载等基本操作。
  sudo apt update
  sudo apt install gnome-disk-utility
# * **启动命令：**
  gnome-disks

### 3. **KDE Partition Manager**
# 这是 KDE 桌面环境的磁盘管理工具，提供了类似 GParted 的功能。
  sudo apt update
  sudo apt install partitionmanager
# * **启动命令：**
  partitionmanager

### 4. **LVM GUI (LVM2)**
# LVM（Logical Volume Management）是一种逻辑卷管理工具，LVM GUI 提供了图形界面的方式来管理 LVM 卷。
  sudo apt update
  sudo apt install lvm2
# * **启动命令：**
  sudo lvm vgdisplay

### 5. **Cinnamon Disk Mounter (仅限Cinnamon桌面环境)**
# Cinnamon 桌面环境自带的磁盘管理工具，功能简单易用。
  sudo apt update
  sudo apt install cinnamon-desktop-environment
# 直接从 Cinnamon 的应用菜单启动。
