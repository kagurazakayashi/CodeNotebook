# 对字符串‘abc’进行AES加密，使用密钥123，输出结果以base64编码格式给出：
echo abc | openssl aes-128-cbc -k 123 -base64
# 解密：
echo U2FsdGVkX18ynIbzARm15nG/JA2dhN4mtiotwD7jt4g= | openssl aes-128-cbc -d -k 123 -base64
