TITLE GPG使用Yubikey

ECHO 可以在 Kleopatra 中管理，装 https://www.gpg4win.org/get-gpg4win.html
"C:\Program Files (x86)\Gpg4win\bin\kleopatra.exe"

SET gpg="C:\Program Files (x86)\GnuPG\bin\gpg.exe"

ECHO 列出现有密钥
%gpg% -k

ECHO 编辑卡
%gpg% --edit-card
ECHO 以管理员权限
admin
ECHO 清除卡中原来的所有GPG数据和密码
factory-reset
ECHO 修改密码(4→3→2→1)
passwd
ECHO 修改持有者
name
ECHO 修改网上的这个公钥地址URL
url

ECHO 新建密钥
%gpg% --full-generate-key
ECHO 选 RSA and RSA , Y5只能 RSA, 用4096
ECHO 多久到期,最多10年,默认0不限
ECHO Real name: 名称
ECHO Email address: 邮箱
ECHO Comment: 昵称
ECHO 晃动鼠标增加随机性

ECHO 添加子密钥, 要用 rsa4096
%gpg% --quick-add-key 4C2A05BE0B052815A2CDA4E7384FAFC8A5AF9476 rsa4096 auth
@REM 签名sign (S)ign: sign some data (like a file) (DSA/RSA/ECC)
@REM 认证certify (C)ertify: sign a key (this is called certification)
@REM 验证auth (A)uthenticate: authenticate yourself to a computer (for example, logging in) (rsa4096/ed25519)
@REM 加密encrypt (E)ncrypt: encrypt data (Elgamal/RSA/ECC)

ECHO 编辑密钥
%gpg% --edit-key 4C2A05BE0B052815A2CDA4E7384FAFC8A5AF9476
ECHO 添加其他用户名邮箱
adduid
ECHO 添加一个照片(240x288,小于等于5KB,建议10%清晰度压缩)
addphoto
ECHO 选择默认子密钥
key 0
ECHO 转移前先备份私钥！
ECHO 将密钥转移到 (1) Signature key
keytocard
ECHO 选择/取消选择其他子密钥
key 1
keytocard
ECHO 将密钥转移到 (2) Encryption key
ECHO 取消选择1
key 1
ECHO 选择2
key 2
ECHO 将密钥转移到 (3) Authentication key
keytocard
