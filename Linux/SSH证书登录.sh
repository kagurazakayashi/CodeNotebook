# 私钥
vi id_rsa
# 公钥
vi id_rsa.pub
vi authorized_keys

# 登录
ssh 192.168.2.250 -p 22 -l yashi -i /Users/yashi/sshkey/us1_yashi.key

# 创建
ssh-keygen -t rsa -b 4096 -C ssh.rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0700 ~/.ssh
chmod 0644 ~/.ssh/authorized_keys
chattr +i ~/.ssh/authorized_keys
chown -R root:root /root
chown -R yashi:yashi /home/yashi

# ~/.ssh/authorized_keys
# ~/.ssh/id_rsa.pub

vim /etc/ssh/sshd_config
#禁用root账户登录，如果是用root用户登录请开启
PermitRootLogin yes

# 是否让 sshd 去检查用户家目录或相关档案的权限数据，
# 这是为了担心使用者将某些重要档案的权限设错，可能会导致一些问题所致。
# 例如使用者的 ~.ssh/ 权限设错时，某些特殊情况下会不许用户登入
StrictModes no

# 是否允许用户自行使用成对的密钥系统进行登入行为，仅针对 version 2。
# 至于自制的公钥数据就放置于用户家目录下的 .ssh/authorized_keys 内
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

# 有了证书登录了，就禁用密码登录吧，安全要紧
PasswordAuthentication no

systemctl restart sshd