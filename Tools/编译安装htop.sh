yum install -y gcc ncurses-devel
wget http://sourceforge.net/projects/htop/files/latest/download
mv download htop.tar.gz
tar -zxf htop.tar.gz
cd htop-1.0.2
./configure
make
make install