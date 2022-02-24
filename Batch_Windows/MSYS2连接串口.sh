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