# 作为系统服务运行
dnf install https://download.foldingathome.org/releases/public/release/fahclient/centos-6.7-64bit/v7.5/fahclient-7.5.1-1.x86_64.rpm
vim /etc/fahclient/config.xml
firewall-cmd --zone=public --add-port=36330/tcp --permanent
firewall-cmd --reload
systemctl restart FAHClient

# 从命令行运行
/usr/bin/FAHClient --help
# 使用config.xml进行配置：生成 config.xml
/usr/bin/FAHClient --configure
# 没有配置文件的配置（最小标志）：
/usr/bin/FAHClient --user=Anonymous --team=0 --passkey=1385yourpasskeyhere5924 --gpu=false --smp=true

# 代理
--proxy=127.0.0.1:1081 --proxy-enable=true


# https://foldingathome.org/support/faq/installation-guides/linux/command-line-options/