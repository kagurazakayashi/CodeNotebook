@REM 安装 Hyper-V
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V /all /norestart
@REM 安装虚拟机平台
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
@REM 安装Linux子系统功能
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart


@REM 查看已经安装的子系统
wsl -l -v

@REM 开始转换 WSL2
wsl --set-version 子系统名称 2

@REM 设置默认版本为WSL 2
wsl.exe --set-default-version 2


@REM 错误：由于虚拟磁盘系统限制，无法完成请求的操作。虚拟硬盘文件必须是未压缩和未加密的文件，并且不能是稀疏文件。
@REM WslRegisterDistribution failed with error: 0xc03a001a
cd C:\Users\yashi\AppData\Local\Packages\TheDebianProject.DebianGNULinux_76v4gfsz19hv4
@REM 取消此文件夹的压缩状态。 yashi:用户名， TheDebian...:安装名


@REM 错误：参考的对象类型不支持尝试的操作
@REM 和 Proxifer 等软件端口冲突，可以直接重置并重启电脑：
netsh winsock reset
@REM 工具解决：需要梯子：
wget http://www.proxifier.com/tmp/Test20200228/NoLsp.exe
NoLsp.exe C:\windows\system32\wsl.exe
@REM https://zhuanlan.zhihu.com/p/151392411


@REM curl 错误：ping: socket: Operation not permitted
sudo setcap cap_net_raw+p /bin/ping


@REM 卸载
@REM 从程序管理中卸载系统，然后：
dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
dism.exe /online /disable-feature /featurename:Microsoft-Hyper-V /norestart