# 安装增强功能
yum update -y
yum groupinstall "Development Tools" -y
yum install kernel-headers kernel-devel gcc make elfutils-libelf-devel -y
mkdir /mnt/cd
mount -t auto /dev/cdrom /mnt/cd
cp -r /mnt/cd ~/vboxadditions
cd ~/vboxadditions
chmod +x ./VBoxLinuxAdditions.run
./VBoxLinuxAdditions.run
cd ~
eject
rm -rf ~/vboxadditions
reboot

# 挂载共享文件夹(非vbox自动挂载才需要)
mkdir /mnt/vbox
mount -t vboxsf wb /mnt/vbox
cd /mnt/vbox
ls
# 开机自动挂载
vi ~/.bashrc
# mount -t vboxsf wb /mnt/vbox
