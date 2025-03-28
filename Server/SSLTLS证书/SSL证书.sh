# SSL 证书 自签名证书

# 1. 生成CA的私钥
openssl genrsa -des3 -out ca.key 4096 (弃用des3)
openssl genrsa -aes256 -out ca.key 4096
Enter pass phrase for ca.key:(4-1023)

# 2. 生成CA公钥
openssl req -new -x509 -days 18250 -key ca.key -out ca.crt

# 1、生成服务器私钥
openssl genrsa -out client.key 4096  # RSA
openssl ecparam -genkey -name secp384r1 -out client-ecc.key  # ECC
# secp256k1：比特币和以太坊等区块链系统使用的曲线
# prime256v1（又名 P-256）: NIST 推荐曲线，广泛用于 TLS 和加密协议
# secp384r1（又名 P-384）：NIST 推荐的更高安全性曲线
# secp521r1（又名 P-521）：更高位数的 NIST 曲线(IIS不支持)
# brainpoolP256r1, brainpoolP384r1, brainpoolP512r1：Brainpool 标准曲线，适用于对 NIST 曲线有信任问题的场景

# 2、生成证书签名请求（CSR）
openssl req -new -key client.key -out client.csr # RSA
openssl req -new -sha256 -key client-ecc.key -out client-ecc.csr  # ECC
# SHA-256：目前最常用，广泛支持，足够安全。
# SHA-384/SHA-512：比 SHA-256 更安全，但生成的签名更长，适用于高安全性需求。
# SHA3 系列：相较于 SHA-2 系列，在某些方面有更好的抗碰撞性，但 OpenSSL 并不总是默认启用。
# MD5 / SHA-1：已被认为不安全，不建议使用。
# Country Name (2 letter code) [AU]:JP
# State or Province Name (full name) [Some-State]:Tokyo
# Locality Name (eg, city) []:Tokyo
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:KagurazakaYashi
# Organizational Unit Name (eg, section) []:personal
# Common Name (e.g. server FQDN or YOUR name) []:uuu.moe  // 必填项：在这里填写域名

# 把 client.csr 请求给服务商 或 继续3.自签

# 3、使用上一步的证书签名请求签发证书
openssl x509 -req -days 365 -in client.csr -signkey client.key -out client.crt

# 以上一步
openssl req -new -x509 -newkey rsa:4096 -keyout client.key -out client.crt

# 转换为 IIS 用的
openssl pkcs12 -export -out client.pfx -inkey client.key -in client.crt



# IIS 转回 pem
openssl pkcs12 -in xxx.pfx -nodes -out server.pem
# 从.pem文件中导出私钥server.key
openssl rsa -in server.pem -out server.key
# 从.pem文件中导出证书server.crt
openssl x509 -in server.pem -out server.crt



# 指定域名

cp /etc/ssl/openssl.cnf ./
# 1.在 [ req ] 块下取消注释行 req_extensions = v3_req
# 2. 确保[ req_distinguished_name ]下没有 0.xxx 的标签，有的话把0.xxx的0. 去掉
# 3. 在 [ v3_req ] 块下增加一行 subjectAltName = @alt_names
# 4. 在文件末尾增加如下信息：
[ alt_names ]
DNS.1 = dev.yashi.moe
IP.1 = 192.168.2.100
# 注意有没有www是不一样的域名，我在做证书请求CSR文件的时候，有 IP 的需求，不过在交给厂商签名的时候，厂商建议不加入 IP ，说是现在的标准逐渐不支持这种做法，因此我就没加上 IP 了，如果厂商支持的话，这么做应该是可以的，因为自己签名试了一下。
# 使用私钥和配置文件生成证书请求CSR文件server.csr，没有修改配置文件的不用写配置文件的参数
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr -config ./openssl.cnf
# 生成CSR文件需要填写一些信息，Common Name填写主要域名，这个域名要在DNS.XX里
Country Name (2 letter code) [AU]:CN
State or Province Name (full name) [Some-State]:Beijing
Locality Name (eg, city) []:Beijing
Organization Name (eg, company) [Internet Widgits Pty Ltd]:KagurazakaYashi
Organizational Unit Name (eg, section) []:dev.yashi.moe
Common Name (e.g. server FQDN or YOUR name) []:dev.yashi.moe
Email Address []:cxchope@163.com
# 要生成用来前面CSR文件的根证书，首先创建CA目录
mkdir ./demoCA
mkdir demoCA/newcerts
touch demoCA/index.txt
touch demoCA/index.txt.attr
echo 01 > demoCA/serial
touch /home/yashi/.rnd
# 生成ca.key，并自签名生成ca.crt证书，需要填写密码两次，如1234，填写的Common Name要和上面生成CSR文件一致。其他步骤一样，建议还是按照CSR文件那样填写就好了。
openssl req -new -x509 -days 65536 -keyout ca.key -out ca.crt -config ./openssl.cnf
# 使用自签署的CA证书签署服务器CSR证书请求，输入密码，一直按y就好了：
openssl ca -in server.csr -out server.crt -cert ca.crt -keyfile ca.key -extensions v3_req -config ./openssl.cnf
# IIS
openssl pkcs12 -export -out client.pfx -inkey ca.key -in ca.crt
# 将ca.crt导入进来，这时候你用 https访问openssl.cnf里填写的DNS.XX 或 IP.XX 就不会跳出不安全提示了。

# https://www.cnblogs.com/liqingjht/p/6267563.html
# https://imlonghao.com/22.html
