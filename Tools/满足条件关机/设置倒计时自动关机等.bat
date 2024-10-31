@echo off
setlocal
REM 倒计时自动关机  注意把文件改成 CRLF + ANSI 编码

:menu
REM 提示用户选择操作类型
cls
color 9F
title 定时电源操作 - 神楽坂雅詩
echo 请选择操作类型: 
echo 0. 显示通知(默认)
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

:input
REM 提示用户输入小时、分钟、秒，默认输入为0
set /p hour=请输入倒计时的小时数 (默认0):
if "%hour%"=="" set hour=0
set /p minute=请输入倒计时的分钟数 (默认0):
if "%minute%"=="" set minute=0
set /p second=请输入倒计时的秒数 (默认0):
if "%second%"=="" set second=0

REM 验证输入是否为数字
for /L %%i in (0,1,9) do (
    echo %hour%|findstr /r "[^0-9]" >nul && goto error
    echo %minute%|findstr /r "[^0-9]" >nul && goto error
    echo %second%|findstr /r "[^0-9]" >nul && goto error
)

REM 将时间转换为秒
set /a total_seconds=(%hour%*3600) + (%minute%*60) + %second%

REM 根据选择配置显示
if %action%==0 (
    set operation=显示通知
)
if %action%==1 (
    set operation=关机
)
if %action%==2 (
    set operation=重启
)
if %action%==3 (
    set operation=睡眠
)
if %action%==4 (
    set operation=休眠
)
if %action%==5 (
    set operation=注销
)
title 定时电源操作:%operation%
REM 记录开始时间
for /f "tokens=1-2" %%a in ('echo %date%_%time%') do set start_time=%%a %%b
cls
color

REM 开始倒计时并显示剩余时间
:countdown
if %total_seconds% LEQ 0 goto action
set /a hours=%total_seconds% / 3600
set /a minutes=(%total_seconds% %% 3600) / 60
set /a seconds=%total_seconds% %% 60

echo %operation%剩余时间: %hours% 小时 %minutes% 分钟 %seconds% 秒
timeout /t 1 >nul
set /a total_seconds=%total_seconds%-1
goto countdown

:action
REM 记录结束时间
for /f "tokens=1-2" %%a in ('echo %date%_%time%') do set end_time=%%a %%b

REM 计算倒计时时间
set /a countdown_time=(%hour%*3600) + (%minute%*60) + %second%
set /a countdown_hours=%countdown_time% / 3600
set /a countdown_minutes=(%countdown_time% %% 3600) / 60
set /a countdown_seconds=%countdown_time% %% 60

REM 构建注释信息
set reason="定时电源操作: %operation%, 开始时间: %start_time%, 结束时间: %end_time%, 倒计时时间: %countdown_hours%小时 %countdown_minutes%分钟 %countdown_seconds%秒"
echo %reason%

REM 根据用户的选择执行相应操作
if %action%==0 (
    msg %username% 倒计时结束！
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
echo 输入的时间无效，请输入有效的数字！
goto input

:end
title cmd
color
echo on