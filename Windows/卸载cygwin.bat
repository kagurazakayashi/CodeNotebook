SET DIRECTORY_NAME="C:\cygwin64"
C:\windows\system32\TAKEOWN /f %DIRECTORY_NAME% /r /d y
C:\windows\system32\ICACLS %DIRECTORY_NAME% /grant administrators:F /t
PAUSE