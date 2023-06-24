sudo apt install libncursesw5-dev autotools-dev autoconf automake build-essential -y
git clone https://github.com/htop-dev/htop.git
cd htop
./autogen.sh
./configure
make -j`grep -c ^processor /proc/cpuinfo`
sudo make install
