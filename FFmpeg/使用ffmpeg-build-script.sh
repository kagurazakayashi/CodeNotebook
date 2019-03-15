# https://github.com/markus-perl/ffmpeg-build-script
# Debian and Ubuntu
sudo apt-get install build-essential curl g++
# Fedora
sudo dnf install @development-tools

# Start
git clone https://github.com/markus-perl/ffmpeg-build-script.git
cd ffmpeg-build-script
./build-ffmpeg --cleanup
# 可能需要代理
./build-ffmpeg --build


# 错误 pkg-config GNU libiconv not in use but included ：
vim build-ffmpeg
# pkg-config 编译命令加上 --with-libiconv=gnu


# ERROR: aom >= 1.0.0 not found using pkg-config
git clone https://aomedia.googlesource.com/aom
cd aom
rm -rf CMakeCache.txt CMakeFiles
mkdir -p ../aom_build
cd ../aom_build
/mnt/d/install/ffmpeg-build-script/workspace/bin/cmake ../aom
make
make install
cp aom.pc /mnt/d/install/ffmpeg-build-script/workspace/lib/pkgconfig/aom.pc