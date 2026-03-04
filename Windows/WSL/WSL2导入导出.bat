@REM 关闭所有发行版
wsl --shutdown

@REM 查看当前已安装的所有 WSL 发行版
wsl --list --verbose

@REM 导出 WSL2 发行版
wsl --export Debian debian.tar
@REM 这个命令会将指定的 WSL 发行版导出为一个压缩的 .tar 文件

@REM 在其他电脑上 创建一个新的 WSL 发行版
@REM wsl --import <新发行版名称> <安装路径> <导入的 .tar 文件路径> <WSL版本>
wsl --import Debian C:\WSL\Debian debian.tar --version 2
@REM <安装路径> 是希望安装 WSL2 实例的目录，确保路径存在且有足够的空间存放该文件。

@REM 启动导入的发行版
wsl -d Debian
