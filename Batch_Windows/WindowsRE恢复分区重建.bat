TITLE WinRE 恢复分区调整大小 重建恢复分区

ECHO 删除 WinRE

@REM Windows 更新 KB5034441 失败 0x80070643: Microsoft 更改了运行 Windows 恢复环境 (WinRE) 的电脑的更新方式。 WinRE 将使用每月累积更新进行更新。 此更改仅适用于从 Windows Update (WU) 和 Windows Server Update Services (WSUS) 获取更新的电脑。 此更改从 2023 年 6 月 27 日开始，适用于 Windows 11 版本 22H2 累积更新。某些电脑可能没有足够大的恢复分区来完成此更新。 因此，WinRE 更新可能会失败。您将收到错误消息“Windows 恢复环境服务失败。” 

ECHO 检查恢复分区信息
ReAgentc /info

ECHO 禁用WinRE
ReAgentc /disable

ECHO 缩小操作系统分区, 运行 diskpart :
diskpart

@REM 列出硬盘，找盘号，选择盘号
LIST DISK
SELECT DISK 0

@REM 列出分区，找分区，选择 C 所在分区
LIST PARTITION
SELECT PARTITION 3

@REM 缩小分区
@REM DESIRED=<N> 指定该卷需要减少的空间大小(MB)
@REM MINIMUM=<N> 指定该卷需要减少的最小空间量(MB)
SHRINK DESIRED=1024 MINIMUM=1024

@REM 选择并删除恢复分区
SELECT PARTITION 4
@REM OVERRIDE 使 DiskPart 能够删除任何分区，无论该分区属于何种类型。
DELETE PARTITION OVERRIDE

@REM 为恢复分区创建新的空白分区
@REM SIZE=<N> 分区大小MB, 未给定大小则占满后续所有。
CREATE PARTITION PRIMARY

@REM 格式化新的空白分区
FORMAT FAST FS=NTFS LABEL=WinRE

@REM 给新的空白分区设置一个盘符 T
ASSIGN LETTER=T

@REM 确认分区并退出
LIST VOL
EXIT

ECHO 创建 WinRE

ECHO 复制 Windows RE 文件到恢复分区
@REM https://learn.microsoft.com/zh-cn/windows-hardware/manufacture/desktop/deploy-windows-re?view=windows-11
MKDIR T:\Recovery\WindowsRE
COPY /h C:\Windows\System32\Recovery\Winre.wim T:\Recovery\WindowsRE

ECHO 配置 Windows RE 所在位置 和 Windows 系统所在位置
ReAgentc /setreimage /path T:\Recovery\WindowsRE /target C:\Windows

ECHO 标识恢复分区并隐藏驱动器号, 运行 diskpart :
diskpart

@REM 列出硬盘，找盘号，选择盘号
LIST DISK
SELECT DISK 0

@REM 列出分区，找分区，选择恢复分区
LIST PARTITION
SELECT PARTITION 4

@REM 删除驱动器号
REMOVE

@REM UEFI:
set id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
gpt attributes=0x8000000000000001

@REM BIOS:
set id=27

@REM 确认分区并退出
LIST VOL
EXIT

@REM 启用 Windows RE
ReAgentc /enable

@REM 查看 Windows RE 信息
ReAgentc /info
@REM Windows RE 状态: Enabled
