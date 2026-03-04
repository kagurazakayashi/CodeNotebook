# Debian 12 Bookworm 升级 Debian 13 Trixie

apt update && apt upgrade -y && apt full-upgrade -y && apt autoclean && apt autoremove -y

sed -i 's/bookworm/trixie/g' /etc/apt/sources.list /etc/apt/sources.list.d/*.{list,sources} 2>/dev/null

apt update && apt upgrade -y && apt full-upgrade -y

# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=debian
update-grub
grub-install /dev/sdX
update-grub

reboot

lsb_release -a
apt autoclean && apt autoremove -y

# https://u.sb/debian-upgrade-13/
