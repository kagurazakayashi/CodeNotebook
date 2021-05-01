# 更新软件包数据库和基本软件包：
pacman -Syu
# 然后退出
# 从“开始”菜单运行“ MSYS2 MSYS”。使用以下命令更新其余的基本软件包：
pacman -Su

# 您可能需要安装一些工具和mingw-w64 GCC才能开始编译：
pacman -S --needed base-devel mingw-w64-x86_64-toolchain
# 要使用mingw-w64 GCC开始构建，请关闭此窗口并从“开始”菜单运行“ MSYS MinGW 64位”。