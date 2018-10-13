@echo off & setlocal enabledelayedexpansion
set ws=%1%=16
set wn=%2%=1
set str=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@#$*()[]:;?-_=+
echo %str%
for /l %%a in (1,1,%wn%) do (
for /l %%b in (1,1,%ws%) do (
    set /a num=!random!%%77
    call set zf=%%str:~!num!,1%%
    set pw=!pw!!zf!
)
echo.
echo %%a:
echo !pw!
set pw=
)