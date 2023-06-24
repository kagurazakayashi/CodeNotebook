sudo apt install git libgoogle-glog-dev libgtk-3-dev libglib2.0-dev libjsoncpp-dev g++ meson libsigc++-2.0-dev -y
git clone git://github.com/iptux-src/iptux.git
cd iptux
meson builddir
ninja -C builddir
sudo ninja -C builddir install
iptux