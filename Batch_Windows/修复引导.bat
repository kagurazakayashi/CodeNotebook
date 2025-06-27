TITLE 修复引导 修复Windows引导 修复Boot Manager

@REM 系统不可用时进入WinRE：
@REM 启动菜单》疑难解答》高级选项》命令提示符
@REM 或者使用 Windows 安装 U 盘启动，进入 修复计算机 。


@REM 非 UEFI (自动):

@REM 修复主引导记录（MBR）
bootrec /fixmbr
@REM 修复引导扇区
bootrec /fixboot
@REM 扫描系统
bootrec /scanos
@REM 重新构建引导配置数据库（BCD）
bootrec /rebuildbcd
@REM BCD 手动重建（如果 rebuildbcd 失败）
bcdedit /export C:\BCD_Backup
attrib C:\Boot\BCD -h -r -s
del C:\Boot\BCD
bootrec /rebuildbcd

@REM 非 UEFI (手动)：

@REM 列出当前的引导信息
bcdedit /enum
@REM 先删除已有的 BCD，{current} 是当前的默认 Windows 启动项。
bcdedit /delete {current}
@REM 重新创建 BCD： C 需要替换为你的 Windows 安装盘符
bcdedit /create {ntldr} /d "Windows Boot Manager"
bcdedit /set {ntldr} device partition=C:
bcdedit /set {ntldr} path \bootmgr
bcdedit /displayorder {current} /addlast
bcdedit /set {current} device partition=C:
bcdedit /set {current} osdevice partition=C:
bcdedit /set {current} path \Windows\system32\winload.exe

@REM UEFI:

@REM 在命令提示符中执行：
diskpart
@REM 然后列出所有磁盘：
list disk
@REM 找到你的系统盘（通常是 Disk 0），然后选择它：
select disk 0
@REM 列出这个盘的所有分区:
list partition
@REM 找到 EFI 分区（通常是 100MB - 300MB，格式为 FAT32），选择它： X 是 EFI 分区的编号
select partition X
@REM 作为 S 盘挂载（重启后不会自动再挂载, 可以用 remove letter=S 手动取消挂载）
assign letter=S:
@REM 退出 diskpart
exit
@REM 现在修复 EFI 引导记录
cd /d S:\EFI\Microsoft\Boot\
bootrec /fixboot
bcdboot C:\Windows /s S: /f UEFI
@REM S:\ 是刚刚分配的 EFI 分区
@REM C:\Windows 是 Windows 安装目录（如果 Windows 安装在 ?:\Windows 需要修改）
@REM bcdboot 命令会重新生成 UEFI 引导配置

@REM 如果 bcdboot 不能修复，可以使用 bcdedit 手动创建
bcdedit /set {bootmgr} path \EFI\Microsoft\Boot\bootmgfw.efi


@REM 完全重建 Boot Manager

@REM 删除旧的 Boot Manager
cd /d S:\EFI\Microsoft\Boot\
attrib BCD -h -r -s
del BCD
@REM 重新创建 BCD
bcdboot C:\Windows /s S: /f UEFI
@REM 重新设置 EFI 启动项
bcdedit /set {bootmgr} path \EFI\Microsoft\Boot\bootmgfw.efi


@REM 修复成功后

@REM 分辨率太低：
regedit
@REM 导航到 HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
@REM 右键空白处，选择 新建 》 DWORD（32 位）值，命名为： EnableGOP ， 值设为 1

@REM 修改语言为简体中文
@REM 查看当前 Boot Manager 配置
bcdedit /enum
@REM Windows Boot Manager
@REM ---------------------
@REM identifier              {bootmgr}
@REM locale                  en-US 《

@REM 确保 Boot Manager 语言文件存在
@REM 先挂载 EFI 分区到 S
S:
cd /d S:\EFI\Microsoft\Boot\
@REM 检查语言文件
dir /s zh-CN
@REM 如果 zh-CN 文件夹不存在，你可以手动复制语言文件
mkdir S:\EFI\Microsoft\Boot\zh-CN
copy C:\Windows\Boot\Resources\zh-CN\bootres.dll S:\EFI\Microsoft\Boot\zh-CN\
@REM 修改 Boot Manager 语言为简体中文
bcdedit /set {bootmgr} locale zh-CN
@REM 单独修改某个 Windows 引导项的语言
bcdedit /set {current} locale zh-CN
