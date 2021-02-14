# 获取内容（百度主页的HTML代码）
curl www.baidu.com
# 下载文件
curl -O http://127.0.0.1/a.7z
# 下载文件并重命名
curl -o b.7z http://127.0.0.1/a.7z

# -v 可以跟踪URL的连接信息
curl -v www.baidu.com
# -i 把回应的头信息包含在内
curl -i www.baidu.com
# -I 只显示返回的头信息
curl -I www.baidu.com

# -u 带用户验证
curl -u username:password https://127.0.0.1/
curl -u username ftp://127.0.0.1/index.json
curl -u username:password ftp://127.0.0.1/index.json

# -d 带请求参数
curl -d 'user=yashi&password=yashi' http://127.0.0.1/index.php

# -X 指定请求方式
curl -X GET www.baidu.com
curl -X POST www.baidu.com
curl -XPOST www.baidu.com
curl -X DELETE www.baidu.com
curl -X PUT www.baidu.com

# curl 代理
# curl -x http://[user:password@]proxyhost[:port]/ url
curl -x http://127.0.0.1:1080 https://www.google.com
# curl -x socks5://[user:password@]proxyhost[:port]/ url
curl --socks5 127.0.0.1:1080 https://www.google.com

# -C - 断点续传
curl -C - -o b.7z http://127.0.0.1/a.7z
# 断点续传+多线程
curl --parallel --parallel-immediate -k -L -C - -o mysql-community-server-5.7.30-1.el7.x86_64.rpm https://cdn.mysql.com/Downloads/MySQL-5.7/mysql-community-server-5.7.30-1.el7.x86_64.rpm
