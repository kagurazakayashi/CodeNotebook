TITLE 重置文件夹权限为只有自己能用

TITLE 0. 重置当前目录及子目录和文件 (/T) 的所有权限为默认值，继续处理所有错误并忽略权限问题 (/C)
icacls . /reset /T /C

TITLE 1. 设置当前文件夹及其子文件夹、文件的拥有者为 "yashi"：

@REM 将当前目录 (.) 及其所有子目录和文件 (/R) 的拥有者设置为当前用户，自动确认所有提示 (/D Y)
takeown /F . /R /D Y

@REM 将当前目录 (.) 及其所有子目录和文件 (/T) 的拥有者设置为用户 "yashi"
icacls . /setowner yashi /T

TITLE 2. 设置权限为 "yashi" 拥有完全控制权限，其他用户没有权限：

@REM 给予 "yashi" 用户对当前目录及其子目录和文件 (/T) 的完全控制权限 (F)
icacls . /grant yashi:F /T

@REM 移除当前目录及其子目录和文件 (/T) 的继承权限 (r)，防止其他权限继承到这些文件
icacls . /inheritance:r /T

@REM 删除 "everyone" 用户组在当前目录及其子目录和文件 (/T) 上的所有权限
icacls . /remove:g everyone /T
