# 第一步安装依赖
yum install -y autoconf automake cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel

# 添加环境变量

export PKG_CONFIG_PATH=/usr/local/lib/:/usr/local/lib/pkgconfig
echo $PKG_CONFIG_PATH

# SDL库
wget http://libsdl.org/release/SDL2-2.0.10.tar.gz
tar zxvf SDL2-2.0.10.tar.gz
cd SDL2-2.0.10
./configure --prefix=/usr
make -j`grep -c ^processor /proc/cpuinfo`
make install

# 安装Yasm (enable-shared)
git clone --depth 1 git://github.com/yasm/yasm.git
cd yasm
autoreconf -fiv
./configure
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean

# 安装libmp3（--enable-libmp3lame）
wget http://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
tar xzvf lame-3.100.tar.gz
cd lame-3.100
./configure
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean

# 编译nasm (x264)
wget https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.bz2
tar -xjf nasm-2.14.02.tar.bz2
cd nasm-2.14.02
./configure
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean

# 编译yasm (x264)
# http://yasm.tortall.net/Download.html
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar -zxvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean

# 编译fdk-aac (--enable-libfdk-aac --enable-nonfree)
# https://sourceforge.net/projects/opencore-amr/files/fdk-aac/
curl https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-2.0.1.tar.gz/download -o fdk-aac-2.0.1.tar.gz
tar -zxvf fdk-aac-2.0.1.tar.gz
cd fdk-aac-2.0.1
./configure
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean

# 安装x265 (--enable-libx265)
hg clone https://bitbucket.org/multicoreware/x265
hg checkout 0.8
cd x265/build/linux
./make-Makefiles.bash
# 这里将 LOG_CU_STATISTICS　设置为ON，然后，按下“c”，实现configure，按下“q”退出
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean

# freetype
# http://www.freetype.org/download.html
wget https://download.savannah.gnu.org/releases/freetype/freetype-2.10.0.tar.bz2
tar xvf freetype-2.10.0.tar.bz2
cd freetype-2.10.0
./configure # --prefix=/usr
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean

# zlib
# http://www.zlib.net/
wget http://www.zlib.net/zlib-1.2.11.tar.gz
tar -zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure # --prefix=/usr
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean


# 下载x264并编译（--enable-libx264 --enable-gpl）
git clone https://code.videolan.org/videolan/x264.git
cd x264
./configure --prefix=/usr --enable-libfreetype --enable-shared --enable-static
make -j`grep -c ^processor /proc/cpuinfo`
make install
make distclean

# 安装ffmpeg
ldconfig
wget https://ffmpeg.org/releases/ffmpeg-4.2.2.tar.bz2
tar xvf ffmpeg-4.2.2.tar.bz2
cd ffmpeg-4.2.2
./configure --prefix=/usr/local/ffmpeg/ --enable-shared --enable-libmp3lame --enable-libx264 --enable-gpl --enable-libfreetype --enable-libfdk-aac --enable-nonfree --enable-libx265 --enable-libfontconfig --enable-yasm --enable-pic
make -j`grep -c ^processor /proc/cpuinfo`
make install
make clean && make distclean

# 为 ffmpeg 加入环境变量
vim /etc/profile
export PATH="/usr/local/ffmpeg/bin:$PATH"

# 软连接
chmod +x /usr/local/ffmpeg/bin/ff*
ln -s /usr/local/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg
ln -s /usr/local/ffmpeg/bin/ffplay /usr/bin/ffplay
ln -s /usr/local/ffmpeg/bin/ffprobe /usr/bin/ffprobe
ln -s /usr/local/ffmpeg/bin/ffserver /usr/bin/ffserver
ls /usr/bin/ff*
chmod +x /usr/bin/ff*

# 故障：

# WARNING: using libx264 without pkg-config
# (此路径为.pc文件所在路径)，可使用
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
echo $PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/lib/:/usr/local/lib/pkgconfig

# error while loading shared libraries: libavdevice.so.57
vi /etc/ld.so.conf
# 加入：/usr/local/ffmpeg/lib
# 执行
ldconfig

# 编译 ffmpeg 失败 : x264_bit_depth
# 降低 ffmpeg 版本
wget https://www.ffmpeg.org/releases/ffmpeg-3.4.7.tar.bz2
tar xvf ffmpeg-3.4.7.tar.bz2
cd ffmpeg-3.4.7
./configure --prefix=/usr/local/ffmpeg/ --enable-shared --enable-libmp3lame --enable-libx264 --enable-gpl
make
make install
make distclean

# 还不行降低 x264 版本
wget ftp://ftp.videolan.org/pub/x264/snapshots/x264-snapshot-20180730-2245-stable.tar.bz2
tar xvf x264-snapshot-20180730-2245-stable.tar.bz2
cd x264-snapshot-20180730-2245-stable
make clean && make distclean
./configure --prefix=/usr --enable-shared
make && make install
ldconfig

# 备忘：有回去编译新版又成功了的情况


# 安装ffmpeg-php
# 下载：https://sourceforge.net/projects/ffmpeg-php/files/ffmpeg-php/
curl https://sourceforge.net/projects/ffmpeg-php/files/ffmpeg-php/0.6.0/ffmpeg-php-0.6.0.tbz2/download -o ffmpeg-php-0.6.0.tbz2
tar -jxvf ffmpeg-php-0.6.0.tbz2
cd ffmpeg-php-0.6.0
# （--with-php-config 改成php安装目录）
./configure --with-php-config=/www/server/php/73/bin/php
make
make install
# php配置文件加入  extension=ffmpeg.so  启这两个函数proc_open,proc_get_status。找到 disable_functions 将里面的这两个函数去掉就行了（坑之所在）
# 重启php。在 phpinfo()中查看有无ffmpeg信息。
cat INSTALL