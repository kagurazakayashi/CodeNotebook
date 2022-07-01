pacman -S gcc autoconf automake make ncurses-devel libiconv-devel
# https://fossies.org/linux/misc/
wget https://fossies.org/linux/misc/minicom-2.8.tar.bz2
tar -jxvf minicom-2.8.tar.bz2
cd minicom-2.8
mkdir tmp
./configure --enable-lock-dir=/tmp
make -j`grep -c ^processor /proc/cpuinfo`
make install
# 配置
minicom -s
# 运行(自动保存日志到home)
minicom -D /dev/ttyS4 -c on -C ~/minicom_log_$(date +%Y%m%d_%H%M%S).log
# 在 Windows Terminal 中运行
# 创建上述命令到文件 ~/com.sh
chmod +x ~/com.sh
# 新建 Windows Terminal 配置文件，命令行：
# C:\tools\msys64\usr\bin\sh.exe --login ~/com.sh


# 快捷键
# C-A　两次按下C-A将发送一个C-A命令到远程系统。如果你把"转义字符"
# 换成了C-A以外的什么字符，则对该字符的工作方式也类似。
# A　切换"Add　Linefeed"为on/off。若为on，则每上回车键在屏幕上
# 显示之前，都要加上一个linefeed。
# B　为你提供一个回卷(scroll　back)的缓冲区。可以按u上卷，按d下卷，
# 按b上翻一页，按f下翻一页。也可用箭头键和翻页键。可用s或S键
# (大小写敏感)在缓冲区中查找文字串，按N键查找该串的下一次出现。
# 按c进入引用模式，出现文字光标，你就可以按Enter键指定起始行。
# 然后回卷模式将会结束，带有前缀'>'的内容将被发送。
# C　清屏。
# D　拨一个号，或转向拨号目录。
# E　切换本地回显为on/off　(若你的minicom版本支持)。
# F　将break信号送modem。
# G　运行脚本(Go)。运行一个登录脚本。
# H　挂断。
# I　切换光标键在普通和应用模式间发送的转义序列的类型(另参下面　
# 关于状态行的注释)。
# J　跳至shell。返回时，整个屏幕将被刷新(redrawn)。
# K　清屏，运行kermit,返回时刷新屏幕。
# L　文件捕获开关。打开时，所有到屏幕的输出也将被捕获到文件中。
# M　发送modem初始化串。若你online，且DCD线设为on，则modem被初始化
# 前将要求你进行确认。
# O　配置minicom。转到配置菜单。
# P　通信参数。允许你改变bps速率，奇偶校验和位数。　
# Q　不复位modem就退出minicom。如果改变了macros，而且未存盘，
# 会提供你一个save的机会。
# R　接收文件。从各种协议(外部)中进行选择。若filename选择窗口和下
# 载目录提示可用，会出现一个要求选择下载目录的窗口。否则将使用
# Filenames　and　Paths菜单中定义的下载目录。
# S　发送文件。选择你在接收命令中使用的协议。如果你未使文件名选择
# 窗口可用(在File　Transfer　Protocols菜单中设置)，你将只能在一
# 个对话框窗口中写文件名。若将其设为可用，将弹出一个窗口，显示
# 你的上传目录中的文件名。可用空格键为文件名加上或取消标记，用
# 光标键或j/k键上下移动光标。被选的文件名将高亮显示。　目录名在
# 方括号中显示，两次按下空格键可以在目录树中上下移动。最后，按
# Enter发送文件，或按ESC键退出。
# T　选择终端模拟：ANSI(彩色)或VT100。此处还可改变退格键，打开或
# 关闭状态行。
# W　切换linewrap为on/off。
# X　退出minicom，复位modem。如果改变了macros，而且未存盘，会提供　
# 你一个save的机会。
# Z　弹出help屏幕。
