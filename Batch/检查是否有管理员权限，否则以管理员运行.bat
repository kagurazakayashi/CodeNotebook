::::::::::::::::::::::::::::::::::::::::::::::::::::::
::If user use Windows then Unlock the UAC at first
::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights
:::::::::::::::::::::::::::::::::::::::::
@ECHO off

CLS
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
CLS
ECHO.
ECHO **************************************
ECHO Please Note:
ECHO You must click Yes on the upcoming User Access Control pop-up window
ECHO to give this update privileges to run.
ECHO **************************************
PAUSE
if '%1'=='ELEV' (shift & goto gotPrivileges)  
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs"
exit /B

:gotPrivileges

setlocal & pushd .
::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Unlock UAC Done
::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ok

@REM https://answers.microsoft.com/zh-hans/protect/forum/all/%E5%BD%BB%E5%BA%95%E5%B9%B2%E6%8E%89%E8%BF%85/4ad24d8d-87e8-42fa-b3f8-c5f4f8707144