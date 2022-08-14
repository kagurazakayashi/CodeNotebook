# 更改Linux下网卡速率速度
# 1.linux中安装ethtool工具
sudo apt-get install ethtool
# 2.查看网卡编号
ifconfig
# 3.查看需要更改的网卡信息
ethtool em1
# 4.更改自己需要的网卡速度，10M全双工：
sudo ethtool -s em1 autoneg off speed 10 duplex full
# 恢复自动
sudo ethtool -s em1 autoneg on

# ethtool使用
# ethtool ethX //查询ethX网口基本设置
# ethtool –h //显示ethtool的命令帮助(help)
# ethtool –i ethX //查询ethX网口的相关信息
# ethtool –d ethX //查询ethX网口注册性信息
# ethtool –r ethX //重置ethX网口到自适应模式
# ethtool –S ethX //查询ethX网口收发包统计
# ethtool –s ethX [speed 10|100|1000]/ //设置网口速率10/100/1000M
# [duplex half|full]/ //设置网口半/全双工
# [autoneg on|off]/ //设置网口是否自协商
# [port tp|aui|bnc|mii]/ //设置网口类型

# https://blog.csdn.net/hanshanbuleng/article/details/94594776

