# openssl哈希

## 二进制 -> base64
openssl base64 -in pubkey.bin -out pubkey.pem
## base64 -> 二进制
openssl base64 -d -in pubkey.pem -out pubkey.bin

## 字符串 -> MD5
echo abc | openssl md5
## 文件 -> MD5
openssl md5 -in t.txt

## 字符串 -> SHA1
echo abc | openssl sha1
## 文件 -> SHA1
openssl sha1 -in t.txt
