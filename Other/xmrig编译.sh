sudo apt install git build-essential cmake libuv1-dev libmicrohttpd-dev -y

git clone https://github.com/open-mpi/hwloc.git
cd hwloc
./autogen.sh
./configure
make
sudo make install

git clone https://github.com/libuv/libuv.git
cd libuv
./autogen.sh
./configure
make
make check
sudo make install

git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib64/libuv.a -DUV_LIBRARY=/usr/local/lib/libuv.a
make