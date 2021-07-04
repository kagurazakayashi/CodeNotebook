# 正在使用的内核
uname -a

# 系统中的全部内核
rpm -qa | grep kernel

# 删除多余的
yum remove kernel-*4.18.0-80.11.2*

# 使用新内核后必须重新编译虚拟机内核驱动