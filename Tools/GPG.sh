# 终止输入：
gpg
# MAC: ^D^D
# Windows：^Z

# 权限：
chown -R yashi:yashi ~/p && chmod -R -rw------- ~/p

# 解密：
gpg -o 1.txt --decrypt 1.txt.asc
# 加密：
gpg -ea -r li@outlook.com 1.txt
# (+a:文本输出)

# 签名：
gpg -u pgp@uuu.moe -o 1.txt.asc.sig --clearsign 1.txt.asc
# (--clearsign改-s:文件输出)
# 验证签名：
gpg --verify 1.txt.asc.sig
gpg --verify commons-codec-1.8-bin.tar.gz.asc commons-codec-1.8-bin.tar.gz

# 加密并签名：
gpg -o 1.txt.asc.sig -ser li@outlook.com -a 1.txt
# (-a:文本输出)
# 解签：
gpg -o 2.txt --decrypt 1.txt.asc.sig

# 生成单独签名文件：
gpg -o 1.txt.asc.sig -ab 1.txt.asc
# 验证单独签名：
gpg --verify 1.txt.asc.sig 1.txt.asc

导入钥：
# gpg --import --pinentry-mode=loopback mail.key
删除私钥：
# gpg --delete-secret-key newkey
删除公钥：
# gpg --delete-key newkey

# 更所有钥：
gpg --refresh-keys --keyserver hkp://hkps.pool.sks-keyservers.net

# 内存解：
gpg
# 内存加密：
gpg -ea -r li@li.tk
# 内存签名：
gpg -u pgp@uuu.moe --clearsign

# 加密并签名文件：
gpg -o file.doc.gpg -ser pgp@cc.cn -u pgp@cc.cn file.doc
# 解文件：
gpg -o file.doc --decrypt file.doc.gpg

# 循环签名多个文件：
for %i in (*.wmv) do gpg -o %i.gpg -ser pgp@cc.cn -u pgp@cc.cn %i

# 常用聊天加密脚本：
#!/bin/sh
name=$1
echo "the ${name} are great man!"

# 密钥服务器
hkps://hkps.pool.sks-keyservers.net
hkp://pool.sks-keyservers.net
hkp://keys.gnupg.net
hkp://pgp.mit.edu
hkp://pgp.uni-minz.de


# 语法：gpg [选项] [文件名]
# 签名、检查、加密或解密
# 默认的操作依输入数据而定

# 指令：

#  -s, --sign [文件名]        生成一份签名
#      --clearsign [文件名]   生成一份明文签名
#  -b, --detach-sign             生成一份分离的签名
#  -e, --encrypt                 加密数据
#  -c, --symmetric               仅使用对称加密
#  -d, --decrypt                 解密数据(默认)
#      --verify                  验证签名
#      --list-keys               列出密钥
#      --list-sigs               列出密钥和签名
#      --check-sigs              列出并检查密钥签名
#      --fingerprint             列出密钥和指纹
#  -K, --list-secret-keys        列出私钥
#      --gen-key                 生成一副新的密钥对
#      --delete-keys             从公钥钥匙环里删除密钥
#      --delete-secret-keys      从私钥钥匙环里删除密钥
#      --sign-key                为某把密钥添加签名
#      --lsign-key               为某把密钥添加本地签名
#      --edit-key                编辑某把密钥或为其添加签名
#      --gen-revoke              生成一份吊销证书
#      --export                  导出密钥
#      --send-keys               把密钥导出到某个公钥服务器上
#      --recv-keys               从公钥服务器上导入密钥
#      --search-keys             在公钥服务器上搜寻密钥
#      --refresh-keys            从公钥服务器更新所有的本地密钥
#      --import                  导入/合并密钥
#      --card-status             打印智能卡状态
#      --card-edit               更改智能卡上的数据
#      --change-pin              更改智能卡的 PIN
#      --update-trustdb          更新信任度数据库
#      --print-md 算法 [文件]
#                                使用指定的散列算法打印报文散列值

# 选项：

#  -a, --armor                   输出经 ASCII 封装
#  -r, --recipient 某甲        为收件者“某甲”加密
#  -u, --local-user              使用这个用户标识来签名或解密
#  -z N                          设定压缩等级为 N (0 表示不压缩)
#      --textmode                使用标准的文本模式
#  -o, --output                  指定输出文件
#  -v, --verbose                 详细模式
#  -n, --dry-run                 不做任何改变
#  -i, --interactive             覆盖前先询问
#      --openpgp                 行为严格遵循 OpenPGP 定义
#      --pgp2                    生成与 PGP 2.x 兼容的报文

# (请参考在线说明以获得所有命令和选项的完整清单)

# 范例：

#  -se -r Bob [文件名]          为 Bob 这个收件人签名及加密
#  --clearsign [文件名]         做出明文签名
#  --detach-sign [文件名]       做出分离式签名
#  --list-keys [某甲]           显示密钥
#  --fingerprint [某甲]         显示指纹


# Syntax: gpg [options] [files]
# Sign, check, encrypt or decrypt
# Default operation depends on the input data

# Commands:

#  -s, --sign                 make a signature
#      --clearsign            make a clear text signature
#  -b, --detach-sign          make a detached signature
#  -e, --encrypt              encrypt data
#  -c, --symmetric            encryption only with symmetric cipher
#  -d, --decrypt              decrypt data (default)
#      --verify               verify a signature
#  -k, --list-keys            list keys
#      --list-sigs            list keys and signatures
#      --check-sigs           list and check key signatures
#      --fingerprint          list keys and fingerprints
#  -K, --list-secret-keys     list secret keys
#      --gen-key              generate a new key pair
#      --gen-revoke           generate a revocation certificate
#      --delete-keys          remove keys from the public keyring
#      --delete-secret-keys   remove keys from the secret keyring
#      --sign-key             sign a key
#      --lsign-key            sign a key locally
#      --edit-key             sign or edit a key
#      --passwd               change a passphrase
#      --export               export keys
#      --send-keys            export keys to a key server
#      --recv-keys            import keys from a key server
#      --search-keys          search for keys on a key server
#      --refresh-keys         update all keys from a keyserver
#      --import               import/merge keys
#      --card-status          print the card status
#      --card-edit            change data on a card
#      --change-pin           change a card's PIN
#      --update-trustdb       update the trust database
#      --print-md             print message digests
#      --server               run in server mode

# Options:
 
#  -a, --armor                create ascii armored output
#  -r, --recipient USER-ID    encrypt for USER-ID
#  -u, --local-user USER-ID   use USER-ID to sign or decrypt
#  -z N                       set compress level to N (0 disables)
#      --textmode             use canonical text mode
#  -o, --output FILE          write output to FILE
#  -v, --verbose              verbose
#  -n, --dry-run              do not make any changes
#  -i, --interactive          prompt before overwriting
#      --openpgp              use strict OpenPGP behavior

# (See the man page for a complete listing of all commands and options)

# Examples:

#  -se -r Bob [file]          sign and encrypt for user Bob
#  --clearsign [file]         make a clear text signature
#  --detach-sign [file]       make a detached signature
#  --list-keys [names]        show keys
#  --fingerprint [names]      show fingerprints

# Please report bugs to <http://bugs.gnupg.org>.
