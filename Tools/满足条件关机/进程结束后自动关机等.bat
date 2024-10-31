@echo off
setlocal
REM 进程结束自动关机  注意把文件改成 CRLF + ANSI 编码

:menu
REM 提示用户选择操作类型
cls
color 9F
title 进程监控电源操作 - 神楽坂雅詩
echo 请选择操作类型: 
echo 0. 显示通知
echo 1. 关机
echo 2. 重启
echo 3. 睡眠
echo 4. 休眠
echo 5. 注销
set /p action=请输入对应数字 (0-5): 

REM 验证选择是否有效，默认输入为0（显示通知）
if "%action%"=="" set action=0
if %action% lss 0 goto menu
if %action% gtr 5 goto menu

REM 让用户输入进程名称
set /p process_name=请输入进程名称(如`7zg.exe`): 
if "%process_name%"=="" goto error

REM 根据选择设置标题栏显示的操作
cls
color 07
if %action%==0 (
    set operation=显示通知
    title 当 %process_name% 进程退出后将显示通知
)
if %action%==1 (
    set operation=关机
    title 当 %process_name% 进程退出后将关机
)
if %action%==2 (
    set operation=重启
    title 当 %process_name% 进程退出后将重启
)
if %action%==3 (
    set operation=睡眠
    title 当 %process_name% 进程退出后将进入睡眠模式
)
if %action%==4 (
    set operation=休眠
    title 当 %process_name% 进程退出后将进入休眠模式
)
if %action%==5 (
    set operation=注销
    title 当 %process_name% 进程退出后将注销
)

REM 检测进程是否正在运行，循环检查直到进程退出
:check_process
tasklist | findstr /i %process_name% >nul
if %errorlevel%==0 (
    echo 进程 %process_name% 正在运行，等待退出...
    timeout /t 9
    goto check_process
)

REM 记录进程结束时间
for /f "tokens=1-2" %%a in ('echo %date% %time%') do set end_time=%%a %%b

REM 构建注释信息
set reason="进程监控电源操作: 进程 %process_name% 已退出, 结束时间: %end_time%, 操作: %operation%"
echo %reason%

REM 根据用户的选择执行相应操作
if %action%==0 (
    msg %username% 进程 %process_name% 已退出! 结束时间: %end_time%
)
if %action%==1 (
    shutdown /s /f /t 0 /c %reason%
)
if %action%==2 (
    shutdown /r /f /t 0 /c %reason%
)
if %action%==3 (
    rundll32.exe powrprof.dll,SetSuspendState 0,1,0
)
if %action%==4 (
    rundll32.exe powrprof.dll,SetSuspendState Hibernate
)
if %action%==5 (
    shutdown /l /c %reason%
)
goto end

:error
echo 输入无效，请输入一个进程名称！
goto menu

:end
title cmd
color
echo on