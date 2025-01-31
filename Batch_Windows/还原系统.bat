@REM 还原系统 修复系统 从安装盘还原
@REM ISO 需要和修复的系统具有相同的版本和语言
MKDIR D:\REP
@REM 创建镜像 D:\REP
ATTRIB E:\sources\install.wim
DISM.exe /Mount-Image /ImageFile:E:\sources\install.wim /Index:1 /ReadOnly /MountDir:D:\REP
@REM 使用“新镜像” REP 修复
DISM /Online /Cleanup-Image /RestoreHealth /Source:D:\REP\windows /LimitAccess
@REM 卸载已安装镜像，等待卸载成功后
DISM.exe /Unmount-Image /MountDir:D:\REP /Discard
@REM 删除REP文件夹
RD /S /Q D:\REP


@REM Dism修复步骤

@REM dism扫描全部系统文件
DISM /Online /Cleanup-image /Scanhealth
@REM 如果结果是“未检测到组件存储损坏 ”，说明完好，可以退出。

@REM sfc扫描受保护的系统文件
sfc /scannow
@REM 如果结果是“未找到任何完整性冲突”，可以退出。如果提示有文件修复，可以用如下命令查看哪些文件未能修复。
findstr /c:"[SR] Cannot repair member file" %windir%\Logs\CBS\CBS.log >"%userprofile%\Desktop\sfcdetails.txt"

@REM 检测系统文件的损坏程度
DISM /Online /Cleanup-image /Checkhealth

@REM 修复损坏的系统文件
DISM /Online /Cleanup-image /Restorehealth
