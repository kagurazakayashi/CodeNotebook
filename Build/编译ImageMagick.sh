# 编译ImageMagick
# http://ftp.nluug.nl/pub/ImageMagick/
wget ftp://ftp.nluug.nl/pub/ImageMagick/ImageMagick.tar.xz
tar -Jxvf ImageMagick.tar.xz
cd ImageMagick-7.0.10-29
# sudo apt-get install libmagick++-dev # 不要安装(选择n),把需要的依赖包复制下来,把其中名称中包含magick关键字的依赖包删除
mkdir build
cd build
../configure --prefix=/usr/local/imagemagick
make -j`grep -c ^processor /proc/cpuinfo`
sudo make install

rm /usr/bin/convert
ln -s /usr/local/imagemagick/bin/magick /usr/bin/convert 
rm /bin/convert
ln -s /usr/local/imagemagick/bin/magick /bin/convert

# gcc编译时如有警告,需要定义下面的宏
#  -DMAGICKCORE_HDRI_ENABLE=0 -DMAGICKCORE_QUANTUM_DEPTH=16

# so文件需要将so加入到LD_LIBRARY_PATH环境变量中
# 设置ImageMagick环境变量
# LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/imagemagick/lib
#在PATH=最后加上
# /usr/local/imagemagick/bin

# https://blog.csdn.net/kmblack1/article/details/79278724
