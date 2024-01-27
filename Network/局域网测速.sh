# 局域网测速

## 服务器
iperf3 -s
# -s:服务器  默认 TCP:5201

## 客户端
iperf3 -c 192.168.1.2 -b 100M -R
# -c:客户端  -b:以100Mbps为数据发送速率  -d:双向测试
# 不加 -R 测试上传，加 -R 测试下载

## Docker 启动， -s 及其开始是 iperf3 程序的参数
sudo docker run -d --name=iperf3-server -p 5201:5201 networkstatic/iperf3 -s
## Docker 停止
sudo docker stop iperf3-server && sudo docker rm iperf3-server

# 带宽性能测试

## 服务器
iperf -s -u
# -u:UDP  -s:服务器  默认 UDP:5001

## 客户端
iperf -c 192.168.1.2 -u -b 100M -t 10
# -c:客户端  -u:UDP -b:以100Mbps为数据发送速率 -t:10秒
# 看丢包率和实际带宽
