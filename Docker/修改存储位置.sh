systemctl stop docker
rsync -avz /var/lib/docker/ /data/docker
vim /usr/lib/systemd/system/docker.service
# ExecStart=/usr/bin/dockerd --graph=/data/docker --storage-driver=overlay --registry-mirror=https://jxus37ad.mirror.aliyuncs.com
# -graph=/data/docker ： docker新的存储位置
# --storage-driver=overlay ： 当前docker所使用的存储驱动
systemctl daemon-reload && systemctl restart docker