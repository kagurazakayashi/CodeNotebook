# 回滚
rpm -qa |grep kernel
yum history list
yum history undo <123> -y
# 或重装
yum reinstall kernel-*