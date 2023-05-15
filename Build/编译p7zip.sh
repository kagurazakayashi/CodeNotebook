yum install gcc-c++ -y
# https://sourceforge.net/projects/p7zip/
wget https://nchc.dl.sourceforge.net/project/p7zip/p7zip/16.02/p7zip_16.02_src_all.tar.bz2
tar -jxvf p7zip_16.02_src_all.tar.bz2
cd p7zip_16.02
make
make install

# 最新版二进制  https://7-zip.org/download.html
mkdir 7z
cd 7z
wget https://7-zip.org/a/7z2201-linux-x64.tar.xz
tar -Jxvf 7z2201-linux-x64.tar.xz
cp 7zz /usr/local/bin
cp 7zzs /usr/local/bin
ln -s /usr/local/bin/7zzs /usr/local/bin/7z
rm /bin/7z
ln -s /usr/local/bin/7zzs /bin/7z
