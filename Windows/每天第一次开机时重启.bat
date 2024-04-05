SET logfile=C:\autoreboot\autoreboot.txt 
FOR /F %%i IN ('DATE /T') DO (
    SET ntime=%%i
)
FOR /F %%i IN (%logfile%) DO (
    ECHO %%i
    IF "%%i" EQU "%ntime%" GOTO equal
    goto noequal
)
:noequal
TITLE "NEED REBOOT !"
ECHO %ntime% >%logfile%
ping 127.0.0.1
SHUTDOWN /R /F /D p:4:1
GOTO end
:equal
TITLE "OK EXIT ."
:end
