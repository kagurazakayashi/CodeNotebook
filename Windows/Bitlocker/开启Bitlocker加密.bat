TITLE 开启 BitLocker 并使用密码解锁，同时保存恢复密钥
manage-bde -on M: -RecoveryPassword -Password -EncryptionMethod xts_aes256 -used
@REM M: → 目标驱动器号
@REM -on <驱动器号> → 启用加密（必须指定盘符）。
@REM -used → 只加密已使用的空间（更快，适合新磁盘）。
@REM -full → 全盘加密（更安全，适合已有数据的磁盘）。
@REM -RecoveryPassword → 自动生成并保存恢复密钥（默认会提示保存/打印）
@REM     可以结合 -RecoveryKey 保存到文件夹:
manage-bde -on M: -RecoveryPassword -RecoveryKey D:\RecoveryKeys
@REM     上面命令会在 D:\RecoveryKeys 下生成 .BEK 文件
@REM -Password → 使用用户自定义的密码解锁方式
@REM -EncryptionMethod xts_aes256 → 指定使用 XTS-AES 256 位 加密（比默认 AES 更安全）
@REM     有效的加密方法为: aes128、aes256、xts_aes128、xts_aes256。
@REM     aes128 → AES 128 位（CBC 模式，旧版）
@REM     aes256 → AES 256 位（CBC 模式，旧版）
@REM     xts_aes128 → XTS-AES 128 位（Win10/2016+ 默认推荐）
@REM     xts_aes256 → XTS-AES 256 位（安全性最高，稍慢）
@REM -TPM: 使用硬件 TPM 芯片 解锁。
manage-bde -on M: -TPM
@REM -StartupKey <路径> 把 USB 当作启动密钥。
manage-bde -on M: -StartupKey F:\
@REM -RecoveryKey <路径> 生成一个 USB 恢复密钥文件。
manage-bde -on M: -RecoveryKey F:\
@REM -PasswordProtector 添加额外的密码保护器（驱动器已加密时也能追加）。

@REM 加密系统驱动器，要 TPM + PIN + 恢复代码 ：
manage-bde -on M: -RecoveryPassword -TPMAndPIN -EncryptionMethod xts_aes256 -used

@REM 在现有加密卷上添加新的保护器: 把 -on 换成 -protectors -add
@REM 添加密码保护器
manage-bde -protectors -add M: -Password
@REM 添加恢复密码（48 位数字）
manage-bde -protectors -add M: -RecoveryPassword
@REM 添加恢复密钥文件（存放在 USB / 目录）
manage-bde -protectors -add M: -RecoveryKey F:\
@REM 添加 TPM 保护器（需要主机支持 TPM）
manage-bde -protectors -add M: -TPM
@REM 添加 USB 启动密钥保护器
manage-bde -protectors -add M: -StartupKey F:\

@REM 查看当前所有保护器
manage-bde -protectors -get M:
@REM 进度可以用下面的命令查看：
manage-bde -status M:

@REM 临时停用保护（不解密）
manage-bde -protectors -disable M:
@REM 可以用 -enable 恢复：
manage-bde -protectors -enable M:
@REM 关闭 BitLocker 并开始解密过程
manage-bde -off M:
@REM 使用 manage-bde 工具备份 BitLocker 恢复代码（48 位恢复密码）
manage-bde -protectors -get C:

ECHO 总结：
ECHO 第一次加密 → 用 manage-bde -on ...
ECHO 追加保护方式 → 用 manage-bde -protectors -add ...
ECHO 查看现有保护器 → 用 manage-bde -protectors -get ...
