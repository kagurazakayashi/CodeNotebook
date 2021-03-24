@ECHO OFF
SET PWD=yashitongdy
FOR %%Z in (A,B,C,D,E,F,G,H,I) do (
    IF EXIST %%Z:\sys.key (
        FOR /f %%X in (%%Z:\sys.key) do (
            IF "%%X" equ "%PWD%" (
                EXIT 0
            )
        )
    )
)
rundll32.exe user32.dll LockWorkStation