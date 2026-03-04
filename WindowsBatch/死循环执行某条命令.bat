@REM bat死循环执行某条命令
@ECHO OFF
SET restartl=restart.log
DEL /F /Q %restartl%
SET restarti=0
:loop
FOR /f "delims=" %%t IN ('DATE /T') DO SET restartd=%%t
FOR /f "delims=" %%t IN ('TIME /T') DO SET restartt=%%t
SET restarts=START %restarti% : %restartd% %restartt%
TITLE %restarts%
ECHO.
ECHO %restarts%
ECHO %restarts% >>%restartl%
ECHO.
ECHO ON
START /LOW /WAIT /B ECHO =====COMMAND=====
@ECHO OFF
FOR /f "delims=" %%t IN ('DATE /T') DO SET restartd=%%t
FOR /f "delims=" %%t IN ('TIME /T') DO SET restartt=%%t
SET restarts=STOP %restarti% : %restartd% %restartt%
TITLE %restarts%
ECHO.
ECHO %restarts%
ECHO %restarts% >>%restartl%
ECHO.
SET /A restarti+=1
PING 127.0.0.1 -n 5 >nul 2>nul
GOTO loop
