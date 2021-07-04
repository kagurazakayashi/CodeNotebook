git clone https://github.com/eclipse/paho.mqtt.c.git
cd paho.mqtt.c
make
sudo make install
sudo cp ./libpaho-mqtt3c.so /usr/lib/libpaho-mqtt3c.so.1
ldconfig
# 把 libpaho-mqtt3c.so 拷入文件夹，编译程序时：
gcc -o main -L./ main.c -l paho-mqtt3c