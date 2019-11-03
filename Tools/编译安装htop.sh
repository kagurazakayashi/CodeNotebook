yum install -y gcc ncurses-devel
wget http://sourceforge.net/projects/htop/files/latest/download
tar -zxf download
cd htop-1.0.2
./configure
make
make install