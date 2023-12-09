sudo apt install git libgoogle-glog-dev libgtk-3-dev libglib2.0-dev libjsoncpp-dev g++ meson libsigc++-2.0-dev -y
git clone https://github.com/iptux-src/iptux.git
cd iptux
meson builddir
ninja -C builddir
sudo ninja -C builddir install
iptux

# 防火墙
sudo firewall-cmd --zone=public --add-port=2425/tcp --permanent
sudo firewall-cmd --zone=public --add-port=2425/udp --permanent
sudo firewall-cmd --reload

# 开机启动
sudo ln -s /usr/local/share/applications/io.github.iptux_src.iptux.desktop /etc/xdg/autostart/io.github.iptux_src.iptux.desktop
# 放到桌面
sudo ln -s /usr/local/share/applications/io.github.iptux_src.iptux.desktop ~/桌面/io.github.iptux_src.iptux.desktop

# iptux: error while loading shared libraries: libiptux-core.so.0: cannot open shared object file: No such file or directory #298
sudo /sbin/ldconfig -v
