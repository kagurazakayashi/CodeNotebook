@echo off

REM 循环用法见 for循环.bat

ECHO 此批处理文件确保生成的文件名总是五位数，不足的部分会用零填充：

setlocal enabledelayedexpansion
FOR /L %%G IN (0,100,1000) DO (
    SET "filename=0000%%G"
    SET "filename=!filename:~-5!"
    ECHO !filename!.txt
    IF %%G GEQ 1000 GOTO :eof
)

REM SET "filename=0000%%G" 将 filename 初始化为 "0000" 加上循环中的数字。例如，如果 %%G 是 100，filename 将被设置为 "0000100"。
REM SET "filename=!filename:~-5!" 通过截取字符串的最后五个字符来确保 filename 总是五位数。所以，如果 filename 是 "0000100"，这个命令会将其改为 "00100"。

REM 本循环输出 , 常规输出
REM 00000.txt , 0.txt
REM 00100.txt , 100.txt
REM 00200.txt , 200.txt
REM 00300.txt , 300.txt
REM 00400.txt , 400.txt
REM 00500.txt , 500.txt
REM 00600.txt , 600.txt
REM 00700.txt , 700.txt
REM 00800.txt , 800.txt
REM 00900.txt , 900.txt
REM 01000.txt , 1000.txt
