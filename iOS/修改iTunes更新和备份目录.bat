TITLE iTunes路径修改
MOVE "%UserProfile%\AppData\Roaming\Apple Computer" "D:\Apple Computer"
CD "%UserProfile%\AppData\Roaming"
MKLINK /D "Apple Computer" "D:\Apple Computer"
MOVE "C:\ProgramData\Apple Computer" "D:\Apple Computer ProgramData"
CD "C:\ProgramData"
MKLINK /D "Apple Computer" "D:\Apple Computer ProgramData"
