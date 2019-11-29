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