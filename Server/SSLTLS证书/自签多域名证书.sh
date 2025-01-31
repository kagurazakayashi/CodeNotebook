sudo vim /etc/pki/tls/openssl.cnf #:

[req]
default_bits            = 8192
distinguished_name      = req_distinguished_name
req_extensions          = v3_req

[ req_distinguished_name ]
countryName                     = Country Name (2 letter code)
countryName_default             = CN
countryName_min                 = 2
countryName_max                 = 2

stateOrProvinceName             = State or Province Name (full name)
stateOrProvinceName_default     = BJ

localityName                    = Locality Name (eg, city)

0.organizationName              = Organization Name (eg, company)
0.organizationName_default      = Kagurazaka

# we can do this but it is not needed normally :-)
#1.organizationName             = Second Organization Name (eg, company)
#1.organizationName_default     = World Wide Web Pty Ltd

organizationalUnitName          = Organizational Unit Name (eg, section)
organizationalUnitName_default  = Yashi

commonName                      = Common Name (e.g. server FQDN or YOUR name)
commonName_default              = KagurazakaYashi
commonName_max                  = 64

emailAddress                    = Email Address
emailAddress_default            = cxchope@163.com
emailAddress_max                = 64

# SET-ex3                       = SET extension number 3

[ v3_req ]

# Extensions to add to a certificate request

basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @SubjectAlternativename

[SubjectAlternativename]
DNS.1 = localhost
DNS.2 = 127.0.0.1
DNS.3 = 192.168.*
DNS.4 = 168.254.251.*
DNS.5 = uuu.moe
DNS.6 = *.uuu.moe
DNS.7 = miyabi.moe
DNS.8 = *.miyabi.moe
DNS.9 = yoooooooooo.com
DNS.10 = *.yoooooooooo.com
DNS.11 = uuumoe.com
DNS.12 = *.uuumoe.com

# /////

# 创建CA私钥
openssl genrsa -out yashi_ca.key 8192
# 创建CSR文件
# 注意这里指定了openssl.cnf，使用了上面我们创建的，因为默认是没有`san`。
openssl req -new -out yashi_ca.csr -key yashi_ca.key -config ./openssl.cnf -subj "/C=CN/ST=BJ/L=Beijing/O=Kagurazaka/OU=Yashi/CN=KagurazakaYashiSign CA/emailAddress=cxchope@163.com"
# 我们可以使用下面的命令来查看CSR包含的信息：
openssl req -text -noout -in yashi_ca.csr

# 自签名并创建证书
openssl x509 -req -days 3650 -in yashi_ca.csr -signkey yashi_ca.key -out yashi_ca.crt -extensions v3_req -extfile ./openssl.cnf

# 上面只是把ca证书给生成出来了
# 创建客户端私钥
openssl genrsa -out yashi_client.key 8192
# 创建证书请求文件CSR
openssl req -new -key yashi_client.key -out yashi_client.csr -config ./openssl.cnf -extensions v3_req -subj "/C=CN/ST=BJ/L=Beijing/O=Kagurazaka/OU=Yashi/CN=*.uuu.moe/emailAddress=cxchope@163.com"
# 查看签名请求文件信息
openssl req -in yashi_client.csr -text
# 利用ca.crt来签署client.csr
openssl x509 -req -sha256 -extfile openssl.cnf -CA yashi_ca.crt -CAkey yashi_ca.key -CAcreateserial -in yashi_client.csr -out yashi_client.crt

# 查看证书信息
openssl x509 -in yashi_client.crt -text
# 验证签发证书是否有效
openssl verify -CAfile yashi_ca.crt yashi_client.crt
# 转换证书给Nginx使用
openssl x509 -in yashi_client.crt -out yashi_client.pem -outform PEM
# 转 IIS 格式
openssl pkcs12 -export -out yashi_client.pfx -inkey yashi_client.key -in yashi_client.pem -certfile yashi_ca.crt

# https://blog.csdn.net/u013066244/article/details/78725842
