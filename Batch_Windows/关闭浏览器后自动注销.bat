@ECHO OFF
SETLOCAL enabledelayedexpansion
TITLE ChatGPT
ECHO 关闭浏览器后将自动登出并断开连接......
FOR /f "tokens=1 delims=\" %%a IN ('whoami') DO SET "CURRENT_USER=%%a"
START "ChatGPT" /MAX /D "C:\Program Files\Google\Chrome\Application" "chrome.exe" "https://chatgpt.com/" /WAIT
:waitloop
TIMEOUT /t 3 >nul
TASKLIST /V /FI "IMAGENAME eq chrome.exe" | FINDSTR /i "!CURRENT_USER!" >nul
IF %errorlevel%==0 GOTO waitloop
SHUTDOWN /L