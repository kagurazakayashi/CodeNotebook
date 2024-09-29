TITLE iTunes路径总体修改
MOVE "%UserProfile%\AppData\Roaming\Apple Computer" "D:\Apple Computer"
CD "%UserProfile%\AppData\Roaming"
MKLINK /D "Apple Computer" "D:\Apple Computer"
MOVE "C:\ProgramData\Apple Computer" "D:\Apple Computer ProgramData"
CD "C:\ProgramData"
MKLINK /D "Apple Computer" "D:\Apple Computer ProgramData"

ECHO 分别修改 iPhone Software Updates
CD "%UserProfile%\AppData\Roaming\Apple Computer\iTunes"
MKDIR "D:\Apple Computer\iTunes\iPhone Software Updates"
MKLINK /D "iPhone Software Updates" "D:\Apple Computer\iTunes\iPhone Software Updates"

ECHO 分别修改 Backup
CD "%UserProfile%\AppData\Roaming\Apple Computer\MobileSync"
MKDIR "D:\Apple Computer\MobileSync\Backup"
MKLINK /D "Backup" "D:\Apple Computer\MobileSync\Backup"
