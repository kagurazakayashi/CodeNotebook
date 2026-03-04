TITLE Bitlocker解锁

@REM 列出卷装入点
mountvol

@REM 解锁 BitLocker
manage-bde -unlock M: -Password
manage-bde -unlock \\?\Volume{00000000-0000-0000-0000-000000000000}\ -RecoveryPassword 123456-123456-123456-123456-123456-123456-123456-123456
@REM -RecoveryPassword 恢复代码解锁
@REM -Password 密码解锁

@REM 以后自动解锁
manage-bde -autounlock -enable E:\
manage-bde -autounlock -enable \\?\Volume{00000000-0000-0000-0000-000000000000}\

@REM 取消自动解锁
manage-bde -autounlock -disable E:\
manage-bde -autounlock -disable \\?\Volume{00000000-0000-0000-0000-000000000000}\

manage-bde -unlock \\?\Volume{00000000-0000-0000-0000-010000000000}\ -RecoveryPassword 123456-123456-123456-123456-123456-123456-123456-123456

@REM 禁用
manage-bde -protectors -disable C:

@REM 彻底解密
manage-bde -off C:
@REM 看解密状态
manage-bde -status C:
