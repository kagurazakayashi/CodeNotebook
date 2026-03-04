@echo off
setlocal enabledelayedexpansion
TITLE 移除文件夹及其子文件文件夹的自定义权限
REM 文件存储用 ANSI 编码 + CRLF 再执行

REM 读取第一个参数作为目标路径
set "target_dir=%~1"

REM 检查是否有传入参数
if "%target_dir%"=="" (
    echo [用法] remove-custom-permissions.bat ^<目标文件夹^>
    echo 示例：remove-custom-permissions.bat "C:\My\Folder"
    exit /b 1
)

REM 检查目标是否存在
if not exist "%target_dir%" (
    echo [错误] 目标文件夹不存在：%target_dir%
    exit /b 1
)

echo 正在移除自定义权限：%target_dir%
TITLE 移除 %target_dir% 及其子文件文件夹的自定义权限
echo -------------------------------------

REM 遍历所有文件并移除非继承权限
for /r "%target_dir%" %%F in (*) do (
    echo 处理文件：%%F
    icacls "%%F" /reset
)

REM 反向排序处理所有子文件夹
for /f "delims=" %%D in ('dir /ad /s /b "%target_dir%" ^| sort /R') do (
    echo 处理文件夹：%%D
    icacls "%%D" /reset
)

REM 最后处理根目录本身
echo 处理根文件夹：%target_dir%
icacls "%target_dir%" /reset

echo -------------------------------------
echo 完成。
pause
