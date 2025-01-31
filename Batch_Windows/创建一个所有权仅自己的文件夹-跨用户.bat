SET LOG=B:\ICACLS-B.LOG
DATE /T >%LOG%
TIME /T >>%LOG%
C:\Windows\System32\runas.exe /profile /user:yashi /savecred "C:\Windows\System32\cmd.exe /k C:\创建一个所有权仅自己的文件夹.bat"
TIMEOUT /T 3 /NOBREAK
C:\Windows\System32\runas.exe /profile /user:masae /savecred "C:\Windows\System32\cmd.exe /k C:\创建一个所有权仅自己的文件夹2.bat"
