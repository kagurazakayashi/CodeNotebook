wget -Y on -e "http_proxy=http://127.0.0.1:9201" "www.google.com"
# -Y  是否使用代理
# -e  执行命令

curl -x 127.0.0.1:9201 www.google.com
# -x  设置代理，格式为host[:port]，port的缺省值为1080

curl --socks5-hostname 127.0.0.1:9201 www.google.com