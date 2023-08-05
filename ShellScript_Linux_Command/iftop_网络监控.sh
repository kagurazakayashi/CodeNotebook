sudo yum install iftop
sudo apt install iftop

# 源代码编译安装
sudo yum install libpcap libpcap-devel ncurses ncurses-devel flex byacc
wget "http://www.ex-parrot.com/~pdw/iftop/download/iftop-0.17.tar.gz"
tar zxvf iftop-0.17.tar.gz
cd iftop-0.17
./configure
make && make install

# 常用参数
iftop -i #指定需要检测的网卡， 如果有多个网络接口，则需要注意网络接口的选择，如：# iftop -i eth1
iftop -B #将输出以 byte 为单位显示网卡流量，默认是 bit
iftop -n #将输出的主机信息都通过 IP 显示，不进行 DNS 解析 
iftop -N #只显示连接端口号，不显示端口对应的服务名称
iftop -F #显示特定网段的网卡进出流量  如: iftop -F 192.168.85.0/24
iftop -h #帮助，显示参数信息
iftop -p #以混杂模式运行 iftop，此时 iftop 可以用作网络嗅探器
iftop -P #显示主机以及端口信息
iftop -m #设置输出界面中最上面的流量刻度最大值，流量刻度分 5 个大段显示  如：# iftop -m 100M
iftop -f #使用筛选码选择数据包来计数  如 iftop -f filter code
iftop -b #不显示流量图形条
iftop -c #指定可选的配置文件，如：iftop  -c config file
iftop -t #使用不带 ncurses 的文本界面，
iftop    # 以下两个是只和 -t 一起用的：
iftop    # -s num num 秒后打印一次文本输出然后退出，-t -s 60 组合使用，表示取 60 秒网络流量输出到终端
iftop    # -L num 打印的行数
iftop -f #参数支持 tcpdump 的语法，可以使用各种过滤条件。
