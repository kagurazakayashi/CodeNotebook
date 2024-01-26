@echo off

ECHO 此批处理文件将包含一个循环，从 0 开始，每次增加 100 ，当数值达到或超过 1000 时停止。

setlocal enabledelayedexpansion
FOR /L %%G IN (0,100,1000) DO (
    SET "filename=%%G"
    ECHO !filename!.txt
    IF %%G GEQ 1000 GOTO :eof
)

REM 输出：
REM 0.txt
REM 100.txt
REM 200.txt
REM 300.txt
REM 400.txt
REM 500.txt
REM 600.txt
REM 700.txt
REM 800.txt
REM 900.txt
REM 1000.txt
