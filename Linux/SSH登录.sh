# 生成用于SSH的公钥和私钥
ssh-keygen -t rsa -b 4096 -C "cxchope@163.com"

# 导入公钥
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys

# 设置正确的文件和文件夹权限
chmod 0644 ~/.ssh
chmod 0644 ~/.ssh/authorized_keys
# chown -R yashi:yashi /home/yashi
# 开启SELinux时，还需要执行（root用户把/home改成/root）
restorecon -R -v /home

# 修改SSH配置文件，支持使用证书登录
vim /etc/ssh/sshd_config
# RSAAuthentication yes
# StrictModes no
# PubkeyAuthentication yes
# AuthorizedKeysFile .ssh/authorized_keys
# PasswordAuthentication no

# 重启SSH服务
systemctl restart sshd.service

# 登录
ssh -L 5999:localhost:5901 -i /Users/yashi/sshkey/yashi_bj1_yashi_rsa_key_201901.rsa.600 xxx.xxx.xxx.xxx -p xx -l yashi
# "D:\PUTTY\PUTTY.EXE" -i "D:\key\yashi_bj1_yashi_rsa_key_201901.ppk" yashi@xxx.xxx.xxx.xxx:xx

# 上传 github
cat ~/.ssh/id_rsa.pub | pbcopy
ssh -T git@github.com

# https://blog.csdn.net/long690276759/article/details/53535464
# https://www.cnblogs.com/chuyanfenfei/p/8035067.html
