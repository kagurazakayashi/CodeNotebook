# Linux 查看环境变量
echo $PATH
# login shell 系统变量 全局系统环境变量
cat /etc/profile
# login shell 用户变量 按读取优先级排序
cat ~/.bash_profile
cat ~/.bash_login
cat ~/.profile
# non-login shell 系统变量 全局系统环境变量
cat /etc/bash.bashrc
# non-login shell 用户变量 用户定义的环境变量
cat ~/.bashrc
# 修改上述文件之后重新加载（加载某个脚本文件）
source /etc/profile
# 显示当前的环境变量
printenv          #列出全部环境变量
printenv PATH     #...:...:...
printenv USER     #root
printenv LOGNAME  #root
printenv MAIL     #/var/spool/mail/root
printenv HOSTNAME #KYS-VPC-RH5
printenv HISTSIZE #1000
printenv INPUTRC  #/etc/inputrc
printenv HISTSIZE #1000
# 常用环境变量
printenv DISPLAY #/root/.bash_history
printenv EDITOR  #当前文本编辑器
printenv SHELL   #本机shell名
printenv HOME    #主目录路径
printenv LANG    #语言字符集和排序
printenv PWD     #当前的工作目录
printenv OLD_PWD #之前的工作目录
printenv PAGER   #用于分页输出的程序名
printenv PATH    #冒号分隔的目录列表（环境）
printenv PS1     #提示符字符串1
printenv TERM    #终端类型名
printenv TZ      #时区
printenv USER    #用户名
# 设置临时环境变量
ENV_A=abc
echo $ENV_A
# export [-fnp][变量名称]=[变量设置值]
export ENV_A
# -f 　代表[变量名称]中为函数名称。
# -n 　删除指定的变量。变量实际上并未删除，只是不会输出到后续指令的执行环境中。
# -p 　列出所有的shell赋予程序的环境变量。