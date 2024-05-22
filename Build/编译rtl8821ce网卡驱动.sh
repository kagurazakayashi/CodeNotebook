# 安装rtl8821ce驱动程序
# Error! The /var/lib/dkms/rtl8821ce/5.5.2.1/6.5.0-28-generic/x86_64/dkms.conf
sudo apt-get install --reinstall git dkms build-essential linux-headers-$(uname -r)
git clone https://github.com/tomaspinho/rtl8821ce
cd rtl8821ce
chmod +x dkms-install.sh
chmod +x dkms-remove.sh
sudo ./dkms-install.sh
