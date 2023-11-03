# RSA算法属于非对称加密算法，非对称加密算法需要两个秘钥：公开密钥(publickey)和私有秘钥(privatekey)。公开密钥和私有秘钥是一对，如果公开密钥对数据进行加密,只有用对应的私有秘钥才能解密。如果私有秘钥对数据进行加密那么只有用对应的公开密钥才能解密。因为加密解密使用的是两个不同的秘钥，所以这种算法叫做非对称加密算法。简单的说就是公钥加密私钥解密，私钥加密公钥解密。

# 1. 使用命令生成私钥
openssl genrsa -out rsa_private_key.pem 1024
# genrsa              生成密钥
# -out                输出到文件
# rsa_private_key.pem 文件名
# 1024                长度

# 2. 从私钥中提取公钥
# 因为公钥的生成，是基于私钥文件的。所以，需要先生成私钥，然后再执行下面的命令，生成公钥。先暂时假设已经生成好的私钥文件名称是：rsa_private_key.pem。那么，生成对应的公钥文件rsa_public_key.pub的命令是：
openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pub
# rsa                 提取公钥
# -in                 从文件中读入
# rsa_private_key.pem 文件名
# -pubout             输出
# -out                到文件
# rsa_public_key.pub  文件名

# https://newsn.net/say/openssl-rsa-pem.html

# 3. 使用公钥加密
openssl rsautl -encrypt -in readme.txt -inkey rsa_public_key.pub -pubin -out hello.enc
# rsautl             加解密
# -encrypt           加密
# -in                从文件输入
# readme.txt         文件名
# -inkey             输入的密钥
# rsa_public_key.pub 上一步生成的公钥
# -pubin             表名输入是公钥文件
# -out               输出到文件
# hello.en           输出文件名
# 利用 Shell 输出到 base64 做编码（不 -out 输出到文件）
openssl rsautl -encrypt -in readme.txt -inkey rsa_public_key.pub -pubin|base64

# 4. 使用私钥解密
openssl rsautl -decrypt -in hello.enc -inkey rsa_private_key.pem -out hello.txt
# -decrypt 解密
# -in      从文件输入 hello.enc 上一步生成的加密文件
# -inkey   输入的密钥 rsa_private_key.pem 上一步生成的私钥
# -out     输出到文件 hello.txt 输出的文件名

# https://cloud.tencent.com/developer/article/1503667