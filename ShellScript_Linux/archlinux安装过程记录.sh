# 虚拟机安装 Arch Linux 记录，已经预先分好区
cd /dev
ls sd* mapper
cryptsetup open sdb1 root
# Enter passphrase for sdb1:
fsck -t ext4 /dev/mapper/root
mount mapper/root /mnt
mkdir -p /mnt/boot/efi
mount sda2 /mnt/boot/
mount sda1 /mnt/boot/efi
cryptsetup open sdc1 home
# cryptsetup open sdd1 swap  先不用交换
cryptsetup open sde1 var
cryptsetup open sdf1 tmp
# cryptsetup open sdg1 usr  分这个会导致 Root device mounted successfully, but /sbin/init does not exist.
cryptsetup open sdg1 data # 改为数据区
cryptsetup open sdh1 srv
cryptsetup open sdi1 opt
cd mapper
# mkdir / && mount root /
mkdir /mnt/home && mount var /mnt/home
mkdir /mnt/var && mount var /mnt/var
mkdir /mnt/tmp && mount tmp /mnt/tmp
# mkdir /mnt/usr && mount usr /mnt/usr
mkdir /mnt/data && mount usr /mnt/data # 改为数据区
mkdir /mnt/srv && mount srv /mnt/srv
mkdir /mnt/opt && mount opt /mnt/opt
vim /etc/pacman.d/mirrorlist
# Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch
pacman -Sy
pacstrap /mnt linux linux-firmware linux-headers base base-devel vim bash-completion iwd net-tools dhcpcd networkmanager dbus
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt 
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# hwclock --systohc
# timedatectl status
vim /etc/locale.gen
## 将这两项取消注释
# en_US.UTF-8 UTF-8
# zh_CN.UTF-8 UTF-8
locale-gen
vim /etc/locale.conf
# # 加入
# LANG=en_US.UTF-8
vim /etc/hostsname #主机名
vim /etc/hosts
# 127.0.0.1    localhost
# ::1          localhost
# hostsname    hostsname.localdomain hostsname
passwd
vim /etc/crypttab
# ...
vim /etc/mkinitcpio.conf # +encrypt
# HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt filesystems fsck)
pacman -S grub efibootmgr efivar intel-ucode parted os-prober # amd-ucode
vim /etc/default/grub
GRUB_CMDLINE_LINUX="cryptdevice=UUID=b1a9ebfa-196a-4366-973c-6c61361c372d:root root=/dev/mapper/root"
grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/efi/grub/grub.cfg
mkinitcpio -P
exit 
umount -R /mnt

pacman -S xorg sddm lightdm lightdm-gtk-greeter xfce4 xfce4-goodies ttf-dejavu ttf-droid ttf-hack ttf-font-awesome otf-font-awesome ttf-lato ttf-liberation ttf-linux-libertine ttf-opensans ttf-roboto ttf-ubuntu-font-family ttf-hannom noto-fonts noto-fonts-extra noto-fonts-emoji  noto-fonts-cjk adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts adobe-source-han-sans-cn-fonts adobe-source-han-sans-hk-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts wqy-zenhei wqy-microhei alsa-utils pulseaudio pulseaudio-bluetooth cups

systemctl enable sddm
systemctl enable dhcpcd

cp /etc/X11/xinit/xinitrc ~/.xinitrc
echo "exec startxfce4" >>~/.xinitrc
