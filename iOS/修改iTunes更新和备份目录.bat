TITLE iTunes路径修改
REM 移动 %UserProfile%\AppData\Roaming\Apple Computer 到 D:\Apple Computer
CD %UserProfile%\AppData\Roaming
MKLINK /D "Apple Computer" "D:\Apple Computer"
