yum install gcc-c++ -y
wget https://nchc.dl.sourceforge.net/project/p7zip/p7zip/16.02/p7zip_16.02_src_all.tar.bz2
tar -jxvf p7zip_16.02_src_all.tar.bz2
cd p7zip_16.02
make
make install

# https://sourceforge.net/projects/p7zip/