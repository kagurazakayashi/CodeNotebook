openssl req -new -x509 -days 365 -nodes -config san.cnf -keyout key.pem -out cert.pem

# 使用这个新生成的包含 SAN 的证书，Go 程序应该不再显示错误  tls: failed to verify certificate: x509: certificate relies on legacy Common Name field, use SANs instead 。
# 确保你的客户端和服务端程序的证书路径更新到新生成的 cert.pem 和 key.pem。这样，你的 TLS 连接应该能够正常建立，不再因为缺少 SAN 而出错。
