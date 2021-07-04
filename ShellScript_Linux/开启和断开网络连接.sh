# 查看网络状态，浏览列表
ifconfig
# 启动网络 enp0s3
ifup enp0s3
# 关闭网络 enp0s3
ifdown enp0s3
# 重启网络
sudo ifdown enp0s3 && sleep 1 && sudo ifup enp0s3