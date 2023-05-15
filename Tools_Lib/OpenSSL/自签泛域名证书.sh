# 自签泛域名证书
# 安装OpenSSL
apt install openssl openssl-devel -y
cp /usr/lib/ssl/openssl.cnf /etc/pki/tls/openssl.cnf
vim /etc/pki/tls/openssl.cnf
# 将如下配置的注释放开,低版本的OpenSSL不支持，可以不放开注释
# [ req ]
# req_extensions = v3_req # The extensions to add to a certificate request
# [ v3_req ]

# Extensions to add to a certificate request
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
# 添加如下行
subjectAltname = @SubjectAlternativename
# 同时增加如下信息
[SubjectAlternativename]
DNS.1 = uuu.moe
DNS.2 = *.uuu.moe

# 开始创建CA证书
mkdir ~/ssl
cd ~/ssl
# 创建CA私钥
openssl genrsa -out CA.key 8192
# 制作CA公钥
# openssl req -sha256 -new -x509 -days 36500 -key CA.key -out CA.crt -config /etc/pki/tls/openssl.cnf
# Country Name (2 letter code) [XX]:CN
# State or Province Name (full name) []:BJ
# Locality Name (eg, city) [Default City]:Beijing
# Organization Name (eg, company) [Default Company Ltd]:Kagurazaka      
# Organizational Unit Name (eg, section) []:Yashi
# Common Name (eg, your name or your server's hostname) []:KagurazakaYashiSign CA
# Email Address []:cxchope@163.com
openssl req -sha256 -new -x509 -days 36500 -key CA.key -out CA.crt -config /etc/pki/tls/openssl.cnf -subj "/C=CN/ST=BJ/L=Beijing/O=Kagurazaka/OU=Yashi/CN=KagurazakaYashiSign CA/emailAddress=cxchope@163.com"

# 自签发泛域名证书
# 生成密钥
openssl genrsa -out uuu.moe.key 8192
# 生成证书签发请求
openssl req -new -sha256 -key uuu.moe.key -out uuu.moe.csr -config /etc/pki/tls/openssl.cnf -subj "/C=CN/ST=BJ/L=Beijing/O=Kagurazaka/OU=Yashi/CN=*.uuu.moe/emailAddress=cxchope@163.com"
# 查看签名请求文件信息
openssl req -in uuu.moe.csr -text
# 使用自签署的CA，签署crt
openssl ca -in uuu.moe.csr -md sha256 -days 36500 -out uuu.moe.crt -cert CA.crt -keyfile CA.key -config /etc/pki/tls/openssl.cnf
# 遇到报错: demoCA/index.txt: No such file or directory :
# touch demoCA/index.txt
# 遇到报错: demoCA/serial: No such file or directory
# echo "01" > demoCA/serial
# 遇到报错: Unable to load number from ./demoCA/serial
# echo "01" > demoCA/serial

# Sign the certificate? [y/n]:y
# 1 out of 1 certificate requests certified, commit? [y/n]y

# 检查部署是否正常
cat demoCA/index.txt
cat demoCA/serial
# 注：同一个域名不能签署多次；由于签署了*.uuu.moe，且已经被记录，因此不能再次被签署。除非删除该记录。
# 注：注意index.txt文件和serial文件的关系。serial文件内容为index.txt文件内容行数加1。

# 查看证书信息
openssl x509 -in uuu.moe.crt -text
# 验证签发证书是否有效
openssl verify -CAfile CA.crt uuu.moe.crt

# 转换证书给Nginx使用
openssl x509 -in uuu.moe.crt -out uuu.moe.pem -outform PEM

# 转 IIS 格式
openssl pkcs12 -export -out uuu.moe.pfx -inkey uuu.moe.key -in uuu.moe.pem -certfile CA.crt

# ls
# CA.crt
# CA.key
# uuu.moe.crt
# uuu.moe.csr
# uuu.moe.key
# uuu.moe.pem
# uuu.moe.pfx

# https://www.cnblogs.com/layzer/articles/openssl.html
