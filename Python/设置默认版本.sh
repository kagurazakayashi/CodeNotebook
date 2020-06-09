# MAC 修改为 Python3.x 为默认 :
# 查看默认 python 所在目录
which python
# 查看 Python3 所在目录
which python3
# 解除 Python2 的软链接
unlink /usr/local/bin/python
# 创建 Python3 软链接
ln -s /usr/local/bin/python3 /usr/local/bin/python
# pip
which pip
which pip3
unlink /usr/local/bin/pip
ln -s /usr/local/bin/pip3 /usr/local/bin/pip

# RHEL7 修复 yum 不工作
# File "/usr/bin/yum", line 30
#     except KeyboardInterrupt, e:
vim /usr/bin/yum
vim /usr/libexec/urlgrabber-ext-down
# 修改第一行,加入2
#!/usr/bin/python2

# RHEL8 Python3
ln -s /usr/bin/python3 /usr/bin/python
ln -s /usr/bin/pip3 /usr/bin/pip

# macOS
which python3
ls -al /usr/local/bin/python3
ls /usr/local/Cellar/python/3.7.7/bin/python3
# 1，首先打开终端,打开配置文件
open ~/.zshrc
# 2. 写入python的外部环境变量
export PATH=${PATH}:/usr/local/Cellar/python/3.7.7/bin/python3
# 3.重命名python（这步很重要，直接关系到默认启动的python版本是否修改）
alias python="/usr/local/bin/python3"
# 4.更新环境变量
source ~/.zshrc

# linux
which python
# /usr/bin/python
which python3
# /usr/bin/python3
unlink /usr/bin/python
ln -s /usr/bin/python3 /usr/bin/python