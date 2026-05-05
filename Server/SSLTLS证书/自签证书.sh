# RSA 自签OTA

## 0. 创建基础文件
```bash
sudo -s
nano /etc/ssl/openssl.cnf
(改 dir = /etc/pki/CA)
mkdir -p /etc/pki/CA/newcerts
touch /etc/pki/CA/index.txt
echo "01" > /etc/pki/CA/serial
exit
```

## 1. 生成CA的私钥
```bash
#openssl genrsa -des3 -out ca.key 2048 (弃用des3)
openssl genrsa -aes256 -out ca.key 2048
Enter pass phrase for ca.key:(4-1023)
```

## 2. 生成CA公钥
`openssl req -new -x509 -days 18250 -key ca.key -out ca.crt`

```
Country Name (2 letter code) [AU]:CN
State or Province Name (full name) [Some-State]:Beijing
Locality Name (eg, city) []:Beijing
Organization Name (eg, company) [Internet Widgits Pty Ltd]:KagurazakaYashi
Organizational Unit Name (eg, section) []:IT
Common Name (e.g. server FQDN or YOUR name) []:KagurazakaYashi
Email Address []:
```

## 3. 生成证书私钥
```bash
#openssl genrsa -des3 -out ota.yashi.moe.pem 2048 (弃用des3)
openssl genrsa -aes256 -out ota.yashi.moe.pem 2048
Enter pass phrase for ota.yashi.moe.pem:(4-1023)
```

## 4. 将私钥解密生成key
`openssl rsa -in ota.yashi.moe.pem -out ota.yashi.moe.key`

## 5. 生成证书请求
`openssl req -new -key ota.yashi.moe.pem -out ota.yashi.moe.csr`

```
Country Name (2 letter code) [AU]:CN
State or Province Name (full name) [Some-State]:Beijing
Locality Name (eg, city) []:Beijing
Organization Name (eg, company) [Internet Widgits Pty Ltd]:KagurazakaYashi
Organizational Unit Name (eg, section) []:IT
Common Name (e.g. server FQDN or YOUR name) []:ota.yashi.moe
Email Address []:
```

## 6. 证书签名 18250 天
`openssl ca -policy policy_anything -days 18250 -cert ca.crt -keyfile ca.key -in ota.yashi.moe.csr -out ota.yashi.moe.crt`

## 7. 合并证书
`cat ota.yashi.moe.crt ca.crt > ota.yashi.moe.fullchain.pem`

## 8. 转 IIS 格式
`openssl pkcs12 -export -out ota.yashi.moe.pfx -inkey ota.yashi.moe.key -in ota.yashi.moe.fullchain.pem`

## 9. 输出
```bash
cat ota.yashi.moe.fullchain.pem
cat ota.yashi.moe.key
```

https://cloud.tencent.com/developer/article/1455228

# ECC 证书

## 1. 生成 ECC 私钥（secp256r1/secp384r1/secp521r1）
`openssl ecparam -name secp521r1 -genkey -noout -out ota.yashi.moe.key`

## 2. 生成证书签名请求（CSR）
`openssl req -new -key ota.yashi.moe.key -out ota.yashi.moe.csr`

## 3. 用 CA 签发证书（10 年有效期）
`openssl ca -policy policy_anything -days 3650 -cert ca.crt -keyfile ca.key -in ota.yashi.moe.csr -out ota.yashi.moe.crt`

## 4. 组合 fullchain 证书（用于 TLS）
`cat ota.yashi.moe.crt ca.crt > ota.yashi.moe.fullchain.pem`
