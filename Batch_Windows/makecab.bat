@REM 语法
@REM makecab [/v[n]] [/d var=<value> ...] [/l <dir>] <source> [<destination>]
@REM makecab [/v[<n>]] [/d var=<value> ...] /f <directives_file> [...]
@REM 参数详解
@REM <source>
@REM 要压缩的文件。
@REM <destination>
@REM 压缩后的文件名，如果忽略，则将源文件名的最后一个字符改为下划线(_)作为为压缩文件名。
@REM /D var=value
@REM var：compressiontype 压缩类型，有：none、 mszip、 lzx
@REM compressionmemory 压缩率，在lzx类型下需指定：范围15--21
@REM value：指定值
@REM 例：
@REM cab最大压缩
makecab /d compressiontype=lzx /d compressionmemory=21 xxx.xxx
@REM 意思：以lzx压缩方式最高（21）压缩xxx.xxx文件
@REM /l <dir>
@REM 指定放置目标文件的位置（默认为当前目录）。
@REM /v[<n>]
@REM 设置调试参数 (0=无,...,3=完全)。
@REM 用法一
@REM a.先建立ddf文件(含设置及文件列表), 如：Sample.ddfb. 进入命令行格式 输入
makecab /f Sample.ddf
@REM 用法二
@REM a.先建立txt文件(文件列表)
makecab /f list.txt /d compressiontype=mszip /d compressionmemory=21 /d maxdisksize=1024000000 /d diskdirectorytemplate=dd* /d cabinetnametemplate=dd*.cab