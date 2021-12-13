# https://go.dev/dl/ 下载
# 树莓派 4B 下载 linux-armv6l.tar.gz （ARMv6），linux-arm64.tar.gz 是适配 ARMv8
curl https://go.dev/dl/go1.16.11.linux-armv6l.tar.gz -o go.tar.gz
sudo tar -C /usr/local -xzf go.tar.gz -v
# 配置环境变量 ~/.bashrc  /  ~/.zshrc
export GOPATH=/home/pi/go
export PATH=/usr/local/go/bin:$PATH:$GOPATH/bin
