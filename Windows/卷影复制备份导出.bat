TITLE 卷影复制备份硬盘 卷影复制备份导出

ECHO 通过以下命令列出所有的卷影副本:
vssadmin list shadows

ECHO 通过以下命令列出 C: 盘的卷影复制快照：
vssadmin list shadows /for=C:

ECHO 首先，使用 vssadmin 创建 C: 盘的卷影复制快照：
vssadmin create shadow /for=C:

ECHO 使用 wbadmin 创建备份映像（wbadmin 会选择 最新的卷影副本）：
wbadmin start backup -backupTarget:D:\Backup.vhdx -include:C: -allCritical -quiet
@REM -allCritical : 备份整个电脑  -quiet : 无需确认

ECHO 查看备份状态
wbadmin get status

ECHO 删除特定的卷影副本:
vssadmin delete shadows /Shadow={你的卷影ID}

ECHO 删除所有的卷影副本:
vssadmin delete shadows /all
