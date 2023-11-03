# 0. 创建基础文件
sudo -s
vim /etc/ssl/openssl.cnf
# (改 dir = /etc/pki/CA)
mkdir -p /etc/pki/CA/newcerts
touch /etc/pki/CA/index.txt
echo "01" > /etc/pki/CA/serial
exit

# 1. 生成CA的私钥
openssl genrsa -des3 -out ca.key 4096
Enter pass phrase for ca.key:(4-1023)

# 2. 生成CA公钥
openssl req -new -x509 -days 18250 -key ca.key -out ca.crt
# Country Name (2 letter code) [AU]:CN
# State or Province Name (full name) [Some-State]:Beijing
# Locality Name (eg, city) []:Beijing
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:
# Organizational Unit Name (eg, section) []:
# Common Name (e.g. server FQDN or YOUR name) []: 显示的证书签发机构
# Email Address []:

# 3. 生成证书私钥
openssl genrsa -des3 -out ota.uuu.moe.pem 4096
# Enter pass phrase for ota.uuu.moe.pem:(4-1023)

# 4. 将私钥解密生成key
openssl rsa -in ota.uuu.moe.pem -out ota.uuu.moe.key

# 5. 生成证书请求
openssl req -new -key ota.uuu.moe.pem -out ota.uuu.moe.csr
# Country Name (2 letter code) [AU]:CN
# State or Province Name (full name) [Some-State]:Beijing
# Locality Name (eg, city) []:Beijing
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:
# Organizational Unit Name (eg, section) []:
# Common Name (e.g. server FQDN or YOUR name) []:ota.uuu.moe 显示的适用域名
# Email Address []:

# 6. 证书签名 18250 天
sudo openssl ca -policy policy_anything -days 18250 -cert ca.crt -keyfile ca.key -in ota.uuu.moe.csr -out ota.uuu.moe.crt

# [!] ERROR:There is already a certificate for /C= ... :
sudo vim /etc/pki/CA/index.txt.attr
# >> unique_subject = no

# 7. 合并证书
cat ota.uuu.moe.crt ca.crt > ota.uuu.moe+ca.pem

# 8. 转 IIS 格式
openssl pkcs12 -export -out ota.uuu.moe.pfx -inkey ota.uuu.moe.key -in ota.uuu.moe+ca.pem
openssl pkcs12 -export -out ota.uuu.moe.pfx -inkey ota.uuu.moe.key -in ota.uuu.moe.pem -certfile ca.crt

# 9. 输出
cat ota.uuu.moe+ca.pem
cat ota.uuu.moe.key

https://cloud.tencent.com/developer/article/1455228