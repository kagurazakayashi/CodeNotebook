nethogs # 按进程查看流量占用
iptraf  # 按连接/端口查看流量
ifstat  # 按设备查看流量
ethtool # 诊断工具
tcpdump # 抓包工具
ss      # 连接查看工具
dstat -nf
slurm
nload
bmon

# 1, 命令行有 vnstat，轻量， 支持统计~
# http://humdi.net/vnstat/
yum install vnstat -y
# 直接看
vnstat -l -i em1
# 安装看
# 假设网卡名为 eth0，该配置在 /etc/vnstat.conf 中，安装结束后初始化数据库
sudo vnstat -u -i eth0
vim /etc/vnstat.conf
# 修改单位： RateUnit 0
# 添加为开机启动
sudo update-rc.d vnstat enable
# 使用直接输入 vnstat
vnstat -l  # 或者 `--live` 实时流量
vnstat -h  # 显示小时流量
vnstat -d  # 显示日流量信息
vnstat -w  # 显示周流量信息
vnstat -m  # 显示月流量信息
vnstat -t  # 显示流量最高top10天
# 图形化输出可以使用 vnstati ，将月流量统计图输出到图片
vnstati -i eth0 - -months - -output /dir/month.png

# 2, Web 前端有 vnstatsvg，轻量，省流量，支持普通服务器，嵌入式系统还轻松支持集群。
# http://www.tinylab.org/compare-different-vnstat-frontend/