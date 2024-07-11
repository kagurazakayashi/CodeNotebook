# https://hub.docker.com/r/cturra/ntp
docker pull cturra/ntp
docker run --name=ntp --net work --ip 172.18.0.123 --detach --publish=123:123/udp --restart=always --env=NTP_SERVERS="ntp.aliyun.com,ntp.tencent.com,cn.pool.ntp.org,time.apple.com,time.windows.com" cturra/ntp

# 远程服务器下载镜像导出
docker rmi cturra/ntp
docker pull cturra/ntp
docker save cturra/ntp | xz -z -e -9 -T 0 -v -c >ntp.tar.xz
docker rmi cturra/ntp
rm /ntp.tar.xz
# 本地服务器更新导入镜像
docker stop ntp
docker rm ntp
docker rmi cturra/ntp
xz -d ntp.tar.xz -c | docker image load
docker run --name=ntp --detach --publish=123:123/udp --restart=always --env=NTP_SERVERS="ntp.aliyun.com,ntp.tencent.com,cn.pool.ntp.org,time.apple.com,time.windows.com" cturra/ntp
