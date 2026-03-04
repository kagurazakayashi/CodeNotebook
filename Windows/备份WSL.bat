@REM 备份WSL
@REM 下载LxRunOffline
@REM https://github.com/DDoSolitary/LxRunOffline/releases
@REM 使用 LxRunOffline.exe -h 查看软件的命令，常用的命令如下：
@REM 已经安装的WSL
LxRunOffline.exe list 
@REM 还原WSL
LxRunOffline.exe install -n <wsl_name> -d <res_path> -f <back_path>
@REM 卸载WSL
LxRunOffline.exe uninstall -n <wsl_name>
@REM 备份WSL
LxRunOffline.exe export -n <wsl_name> -f <back_path>
@REM 启动一个WSL
LxRunOffline.exe run -n <wslname>

@REM 查看当前系统中存在的 WSL
LxRunOffline.exe list
@REM 开始备份
LxRunOffline.exe export -n Debian -f D:\DebianBackup.tar.gz
@REM -n: wsl的别名，就是之前用list查看的其中一个
@REM -f: 备份的路径，我这直接备份到当前路径backup.tar.gz

@REM 还原WSL
LxRunOffline.exe install -n Ubuntu -d C:\Users\*\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState -f D:\UbuntuBackup.tar.gz
@REM -n :为wsl起个名字
@REM -d: wsl的还原路径
@REM -f: 备份文件的路径

@REM 启动备份的WSL
LxRunOffline.exe run -n Ubuntu
@REM 每次需要在CMD中打开wsl，如果要点击Ubuntu图标直接启动，可以在新安装的系统重新安装的Ubuntu，先不要打开，先用LxRunOffline直接还原到安装目录就可以直接点击图标打开了。

@REM https://blog.csdn.net/code_peak/article/details/118770932