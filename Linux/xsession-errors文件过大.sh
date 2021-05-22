# 日志文件过大处理

# 方法1
# 在crontab中添加一个定时任务，定期检查.xsession-errors文件大小，如果超过某个阈值，就清空或者截断它
crontab -e  # 编辑crontab定时任务脚本
# 示例1：每隔15分钟检查一次，如果超过5g，就清空该文件：
*/15 * * * * [ $(du -k .xsession-errors | awk '{ print $1 }') -gt 5000000 ] && >/home/$(whoami)/.xsession-errors
# 示例2：做同样的检查，但是保留最后10000行：
*/15 * * * * [ $(du -k .xsession-errors | awk '{ print $1 }') -gt 5000000 ] && tail -10000 /home/$(whoami)/.xsession-errors > /home/$(whoami)/.xsession-errors

# 方法2
# 为.xsession-errors文件设置immutable属性，禁止写入此文件
sudo chattr +i .xsession-errors

# 方法3
# 通过软链接将日志转存到/dev/null中
rm .xsession-errors
ln -s /dev/null .xsession-errors
# 但是这个方法，在重启计算机的时候，这个符号链接就会被常规文件替换，并继续增长。为了避免这种情况出现，可以将以下内容添加到家目录的.bashrc中：
# 如果家目录下的.xsession-errors文件不是软链接，删除并重建软链接
if [ ! -h $HOME/.xsession-errors ]; then
    /bin/rm $HOME/.xsession-errors
    ln -s /dev/null $HOME/.xsession-errors
fi

# 方法4
# 编辑 /etc/X11/Xsession （X Window的配置文件），检索以下内容：
ERRFILE=$HOME/.xsession-errors
# 修改为：
ERRFILE=/dev/null
# 即：修改错误日志文件保存路径为/dev/null。
# 当然，也可以把日志保存在别的地方，比如tmpfs文件系统的分区（一般为/tmp目录）下。保存在这个目录下的文件会在重启系统后删除。但是这又回到了一开始的问题：我们的计算机可能很长时间不关机。

# https://blog.csdn.net/AsWeDo/article/details/90412801