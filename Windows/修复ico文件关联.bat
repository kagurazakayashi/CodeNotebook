TITLE 修复ico文件关联

assoc .ico=icofile
ftype icofile=%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen %1

assoc .cur=cursorfile
ftype cursorfile=%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen %1

assoc .ani=anifile
ftype anifile=%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen %1

ECHO 删除缩略图缓存
del /f /s /q /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
del /f /s /q /a "%LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db"

ECHO 重启 Windows 资源管理器
taskkill /f /im explorer.exe
start explorer.exe
