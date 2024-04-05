@REM 从安装盘还原
@REM ISO 需要和修复的系统具有相同的版本和语言
MKDIR D:\REP
@REM 创建镜像 D:\REP
ATTRIB E:\sources\install.wim
DISM.exe /Mount-Image /ImageFile:E:\sources\install.wim /Index:1 /ReadOnly /MountDir:D:\REP
@REM 使用“新镜像” REP 修复
DISM /Online /Cleanup-Image /RestoreHealth /Source:D:\REP\windows /LimitAccess
@REM 卸载已安装镜像，等待卸载成功后，删除C盘根目录下的REP文件夹
DISM.exe /Unmount-Image /MountDir:D:\REP /Discard
