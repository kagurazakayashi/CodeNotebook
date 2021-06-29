# 中文

vim /etc/sysconfig/i18n

LANG="zh_CN.UTF-8"
SYSFONT="latarcyrheb-sun16"

vim /etc/locale.conf

LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN.UTF-8:zh_CN.GB2312:zh_CN"
SUPPORTED="zh_CN.UTF-8:zh_CN:zh:en_US.UTF-8:en_US:en"
SYSFONT="lat0-sun16"

# 或者

LANG="zh_CN.GB18030"
LANGUAGE="zh_CN.GB18030:zh_CN.GB2312:zh_CN"
SUPPORTED="zh_CN.UTF-8:zh_CN:zh:en_US.UTF-8:en_US:en"
SYSFONT="lat0-sun16"


# Ubuntu修改终端下的语言

# 一、首先查看是否安装了中文语言包
locale -a
# 查看是否有： zh_CN.utf8
# 如果没有，首先需要安装中文语言包，输入以下命令：
apt install language-pack-zh-hans -y
# 然后添加中文支持
locale-gen zh_CN.UTF-8

# 二、修改locale文件配置
vim /etc/default/locale
# 修改配置文件为：
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh:en_US:en"
LC_NUMERIC="zh_CN.UTF-8"
LC_TIME="zh_CN.UTF-8"
LC_MONETARY="zh_CN.UTF-8"
LC_PAPER="zh_CN.UTF-8"
LC_IDENTIFICATION="zh_CN.UTF-8"
LC_NAME="zh_CN.UTF-8"
LC_ADDRESS="zh_CN.UTF-8"
LC_TELEPHONE="zh_CN.UTF-8"
LC_MEASUREMENT="zh_CN.UTF-8"
LC_ALL=zh_CN.UTF-8

# 重启
reboot

# 原文链接：https://blog.csdn.net/BobYuan888/article/details/88662779