TITLE EFS文件加密证书备份和恢复.bat

ECHO 备份
cipher /x B:\backup_efs_cert
cipher /y >B:\backup_efs_cert.txt

ECHO 恢复 (YOUR_PASSWORD 是你在导出 .pfx 文件时设置的密码)
certutil -f -user -p YOUR_PASSWORD -importpfx backup_efs_cert.pfx

ECHO 如果你没设密码，可直接使用
certutil -f -user -importpfx backup_efs_cert.pfx

ECHO 验证 EFS 是否恢复
cipher /y
REM 检查当前是否已载入你原来的 EFS 证书（Subject 应该显示你当时的用户信息）。

ECHO 该项不适于在指定状态下使用。:
ECHO 加密一个测试文件，并触发生成 EFS 密钥对。
TIME /T > B:\test.txt
cipher /e B:\test.txt
DEL B:\test.txt

ECHO GUI:
certmgr.msc
ECHO 左侧展开：个人 → 证书
ECHO 在右侧列表中，查找 “用于加密文件系统” 的证书
ECHO 它的“用途”一栏会显示：Encrypting File System
ECHO 颁发者一般是你的计算机名
ECHO 右键该证书 → 所有任务 → 导出
ECHO 进入“证书导出向导”：
ECHO 选择：是，导出私钥
ECHO 格式选：PKCS #12 (.PFX)，勾选“导出所有扩展属性”

