openssl req -new -x509 -days 3650 -extensions v3_ca -keyout ca.key -out ca.crt
# 必须输入密码，最长1023
# Country Name (2 letter code) [AU]:CN
# State or Province Name (full name) [Some-State]:Beijing
# Locality Name (eg, city) []:Beijing
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:
# Organizational Unit Name (eg, section) []:
# Common Name (e.g. server FQDN or YOUR name) []: 主机名，域名或IP
# Email Address []:

# 创建服务端私钥 key
openssl genrsa -out server.key 2048
# 创建服务端证书请求文件 csr
openssl req -out server.csr -key server.key -new
# 创建根证书签名的服务端证书
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 3650
# Enter pass phrase for ca.key:输入密码，最长1023

# 创建客户端证书
openssl genrsa -out client.key 2048
openssl req -out client.csr -key client.key -new
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 3650