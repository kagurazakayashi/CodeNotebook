@echo off
for /f "skip=3 tokens=4" %%i in ('sc query %1') do set "zt=%%i" &goto :next
:next
if /i "%zt%"=="RUNNING" (
    net stop %1
) else (
    net start %1
)