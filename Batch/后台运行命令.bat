@echo off
TITLE 后台运行命令

rem 启动 Python 脚本并在后台运行
start /B python your_script.py

rem 等待 5 秒钟
timeout /t 5 /nobreak > nul

rem 停止 Python 脚本
taskkill /IM python.exe /F

echo Python 脚本已停止.

TITLE 这会结束所有 python.exe ，如果不想：

@echo off
rem 启动 notepad.exe，并为其指定一个窗口标题
start "MyNotepad" /B notepad.exe

rem 等待 5 秒钟
timeout /t 5 /nobreak > nul

rem 使用窗口标题来结束指定的进程
taskkill /FI "WINDOWTITLE eq MyNotepad" /F

echo 程序已停止.
