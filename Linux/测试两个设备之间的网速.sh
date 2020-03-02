# https://code.google.com/archive/p/iperf/downloads
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/iperf/iperf-3.0b5.tar.gz
tar zxvf iperf-3.0b5.tar.gz
cd iperf-3.0b5
./configure
make -j`grep -c ^processor /proc/cpuinfo`
make install

firewall-cmd --permanent --add-port=5201/tcp
firewall-cmd --reload

# 在 192.168.0.1 的这台服务器上，开启服务模式。
/usr/local/bin/iperf3 -s

# 然后在 192.168.0.2 这台机器上执行如下命令
/usr/local/bin/iperf3 -c 192.168.0.1