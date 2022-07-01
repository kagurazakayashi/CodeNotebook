wget -Y on -e "http_proxy=http://127.0.0.1:9201" "www.google.com"
# -Y  是否使用代理
# -e  执行命令

curl -x 127.0.0.1:9201 www.google.com
# -x  设置代理，格式为host[:port]，port的缺省值为1080

curl --socks5-hostname 127.0.0.1:9201 www.google.com


# wget 配置文件设置
vim ~/.wgetrc
use_proxy=yes
http_proxy=192.168.50.1:8888
https_proxy=192.168.50.1:8888

# curl 配置文件设置
vim .curlrc
proxy = "192.168.50.1:8888"
