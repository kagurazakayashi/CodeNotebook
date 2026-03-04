TITLE 恢复默认权限

@REM 先取得当前目录的所有权（防止某些文件无法修改权限）
takeown /f . /r /d y

@REM 清除所有自定义 ACL 并恢复为继承父级权限
icacls . /reset /t /c /q
@REM /reset 清除自定义 ACL，恢复到继承模式
@REM /t 递归处理所有子目录和文件
@REM /c 遇到错误继续执行
@REM /q 静默模式

@REM 确保根目录本身也有默认继承权限
@REM 默认情况下，NTFS 数据盘会给 Administrators、SYSTEM、Users 设置权限。可以显式恢复：
icacls . /inheritance:e /q
icacls . /grant "SYSTEM:(OI)(CI)(F)" "Administrators:(OI)(CI)(F)" "Users:(OI)(CI)(RX)" /q
@REM (OI)(CI) 表示应用到文件和文件夹
@REM (F) 完全控制，(RX) 读和执行
@REM 这一步是防止根目录 ACL 本身也被改坏
@REM 这三个组是系统内置的，因此给权限后其他电脑上也有效。


@REM 清除旧权限：  /reset  /inheritance:r
@REM 追加权限不要覆盖现有：  /grant


@REM 只允许 yashi 和 masae 有权限用，而且是完全控制权限：
@REM 重置 ACL
icacls . /reset /t /c /q
@REM 关闭继承
icacls . /inheritance:r /q
@REM 授予 yashi 和 masae 完全控制, /t 递归应用到子目录和文件
icacls . /grant "yashi:(OI)(CI)(F)" "masae:(OI)(CI)(F)" /t /q
@REM 不需要 "SYSTEM:(OI)(CI)(F)" "Administrators:(OI)(CI)(F)"，另一台电脑的管理员也可以添加权限。


@REM 明确拒绝某个账户访问：
icacls . /deny "sbuser:(OI)(CI)(F)" /t /q
@REM (F) = Full Control（完全控制）
@REM (OI) = Object Inherit（继承到文件）
@REM (CI) = Container Inherit（继承到文件夹）
@REM /t = 递归所有子目录和文件
