@REM 证书打开方式
openssl x509 -in %1 -noout -text
C:\Windows\System32\rundll32.exe cryptext.dll,CryptExtOpenCER %1

@REM 私钥
openssl rsa -in %1 -text -noout
