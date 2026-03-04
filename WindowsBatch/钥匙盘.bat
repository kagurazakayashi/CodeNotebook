REM 在任意多个盘符中:

@ECHO OFF
SET PWD=YashiKey
FOR %%Z in (A,B,C,D,E,F,G,H,I) do (
    IF EXIST %%Z:\sys.key (
        FOR /f %%X in (%%Z:\sys.key) do (
            IF "%%X" equ "%PWD%" (
                SET PWD=
                EXIT 0
            )
        )
    )
)
SET PWD=
rundll32.exe user32.dll LockWorkStation


REM 指定位置的密钥文件:

@ECHO OFF
SET PWD=YashiKey
FOR /F %%i IN ('TYPE C:\syskey\sys.key') DO (
    SET VAL=%%i
)
IF "%VAL%" EQU "%PWD%" (
    SET PWD=
    SET VAL=
    EXIT 0
)
SET PWD=
SET VAL=
rundll32.exe user32.dll LockWorkStation