TITLE 还原系统 修复系统 从安装盘还原
@REM ISO 需要和修复的系统具有相同的版本和语言
MKDIR D:\install
@REM 先查安装源里都有什么
DISM /Get-WimInfo /WimFile:I:\sources\install.wim
@REM 挂载需要的子镜像Index
DISM /Mount-Wim /WimFile:I:\sources\install.wim /Index:4 /MountDir:D:\install /ReadOnly
@REM 修复 D 中的系统
DISM /Image:D:\ /Cleanup-Image /RestoreHealth /Source:D:\install\Windows /LimitAccess
@REM 取消挂载 wim
DISM /Unmount-Wim /MountDir:D:\install /Discard
@REM 移除挂载点
RD D:\install

@REM 当前系统修复步骤

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


@REM 扫描USB连接的系统盘

@REM 扫描健康状况（仅检查，不修复）：
dism /Image:D:\ /Cleanup-Image /ScanHealth
@REM 检查损坏程度（查看是否可以修复）：
dism /Image:D:\ /Cleanup-Image /CheckHealth
@REM 执行修复操作：
dism /Image:D:\ /Cleanup-Image /RestoreHealth
@REM 辅助修复（SFC 扫描）
@REM DISM 修复的是系统组件库（WinSxS），而 SFC 修复的是具体的系统文件。在完成 DISM 修复后，建议运行脱机 SFC 扫描：
sfc /scannow /offbootdir=D:\ /offwindir=D:\windows
@REM /offbootdir：指向引导分区（通常和系统分区一致）。
@REM /offwindir：指向 Windows 目录的具体路径。

@REM 如果修复提示“找不到源文件”，执行带源修复命令：
dism /Image:D:\ /Cleanup-Image /RestoreHealth /Source:WIM:E:\sources\install.wim:1 /LimitAccess
@REM 先查安装源里都有什么
DISM /Get-WimInfo /WimFile:E:\sources\install.wim
