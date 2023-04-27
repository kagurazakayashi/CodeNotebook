TITLE Windows端口占用情况

@REM 当前启动应用的所有的端口使用列表
netstat -ano

@REM 查找某一特定端口（端口号）
netstat -ano |findstr "2425"

@REM 查找端口号对应的进程名称（进程PID号）
tasklist /fi "PID eq 10312" 
tasklist |findstr "10312"
@REM PowerShell:
Get-Process -id 10312

@REM 杀掉进程（进程PID号或进程名称）
taskkill /f /t /im "10312"
taskkill /PID 10312
