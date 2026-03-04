@echo off
setlocal enabledelayedexpansion
TITLE 为用户取得用户文件夹所有权
REM 文件存储用 ANSI 编码 + CRLF 再执行
REM 修复当前用户文件夹（默认）所有文件权限为当前用户
REM fix_user_folder_permissions.bat
REM 修复指定路径所有文件权限为当前用户
REM fix_user_folder_permissions.bat "D:\yashi"

REM ========= 检查是否为管理员运行 =========
whoami /groups | find "S-1-5-32-544" >nul
if not %errorlevel%==0 (
    echo [!] 请以管理员权限运行本脚本。
    pause
    exit /b 1
)

REM ========= 参数解析：如果有传路径则使用，否则默认当前用户目录 =========
if "%~1"=="" (
    set "TARGET_FOLDER=%USERPROFILE%"
    echo [*] 未指定路径，默认操作当前用户文件夹：%TARGET_FOLDER%
) else (
    set "TARGET_FOLDER=%~1"
    echo [*] 将修复指定路径：%TARGET_FOLDER%
)

TITLE 为用户 %USERNAME% 取得 %TARGET_FOLDER% 所有权

set "BACKUP_FILE=%~dp0acl_backup_%USERNAME%_%DATE:/=-%_%TIME::=-%.txt"

REM ========= 检查路径是否存在 =========
if not exist "%TARGET_FOLDER%" (
    echo [!] 目标路径不存在：%TARGET_FOLDER%
    pause
    exit /b 1
)

echo.

REM ========= 备份 ACL =========
echo [+] 备份权限到：%BACKUP_FILE%
icacls "%TARGET_FOLDER%" /save "%BACKUP_FILE%" /T

if %errorlevel% NEQ 0 (
    echo [!] 权限备份失败，要终止执行请Ctrl+C。
    pause
)
echo [OK] 权限备份完成。
echo.

REM ========= 获取所有权 =========
echo [+] 获取所有权中...
takeown /F "%TARGET_FOLDER%" /R /D Y
echo [OK] 获取完成。
echo.

REM ========= 重设权限 =========
echo [+] 重置继承权限...
icacls "%TARGET_FOLDER%" /reset /T /C
echo [OK] 重置完成。
echo.

REM ========= 授权当前用户 =========
echo [+] 授予当前用户（%USERNAME%）完全控制权限...
icacls "%TARGET_FOLDER%" /grant %USERNAME%:F /T /C
echo [OK] 权限设置完成。
echo.

echo [OK] 权限修复完成！
echo     备份文件：%BACKUP_FILE%
echo     恢复命令：
echo     icacls "%TARGET_FOLDER%" /restore "%BACKUP_FILE%"
echo.
endlocal
pause
