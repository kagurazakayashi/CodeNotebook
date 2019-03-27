# 需求库
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar zxvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make
sudo make install
cd..
git clone https://git.ffmpeg.org/ffmpeg.git
# ffmpeg 编译
cd ./ffmpeg
mkdir host
./configure --prefix=./host --enable-shared --disable-doc
make
sudo make install
sudo cp ./host/lib/* /usr/bin/
./configure
make
sudo make install

git clone git://git.videolan.org/vlc.git
sudo ./bootstrap
# Successfully bootstrapped
yum install wayland-protocols lua liblua -y
./configure
