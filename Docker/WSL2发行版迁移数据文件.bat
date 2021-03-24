@REM 首先关闭docker

@REM 关闭所有发行版：
wsl --shutdown

@REM 将docker-desktop-data导出到D:\SoftwareData\wsl\docker-desktop-data\docker-desktop-data.tar（注意，原有的docker images不会一起导出）
wsl --export docker-desktop-data D:\SoftwareData\wsl\docker-desktop-data\docker-desktop-data.tar

@REM 注销docker-desktop-data：
wsl --unregister docker-desktop-data

@REM 重新导入docker-desktop-data到要存放的文件夹：D:\SoftwareData\wsl\docker-desktop-data\：
wsl --import docker-desktop-data D:\SoftwareData\wsl\docker-desktop-data\ D:\SoftwareData\wsl\docker-desktop-data\docker-desktop-data.tar --version 2

@REM 只需要迁移docker-desktop-data一个发行版就行，另外一个不用管，它占用空间很小。
@REM 完成以上操作后，原来的%LOCALAPPDATA%/Docker/wsl/data/ext4.vhdx就迁移到新目录了