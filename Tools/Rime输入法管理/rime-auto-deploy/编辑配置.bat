@echo off
setlocal

set BASEDIR=%~dp0
set CUSTOM_DIR=%BASEDIR%custom
set CUSTOM_TXT=%CUSTOM_DIR%\custom_phrase.txt

where codium >nul 2>nul
if %errorlevel%==0 (
    codium "%CUSTOM_DIR%"
    goto after_editor
)

where code >nul 2>nul
if %errorlevel%==0 (
    code "%CUSTOM_DIR%"
    goto after_editor
)

notepad "%CUSTOM_TXT%"

:after_editor
COPY /Y custom\* %APPDATA%\Rime\
TIMEOUT 3
exit /b 0
