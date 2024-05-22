@REM 语法
@REM MAKECAB [/v[n]] [/d var=<value> ...] [/l <dir>] <source> [<destination>]
@REM MAKECAB [/v[<n>]] [/d var=<value> ...] /f <directives_file> [...]
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
makecab /D CompressionType=LZX /D CompressionMemory=21 /L 目标目录 源文件路径
@REM 意思：以lzx压缩方式最高（21）压缩xxx.xxx文件
@REM /D CompressionType=LZX 表示使用 LZX 压缩算法，这是一种为了达到更高压缩比而设计的算法。
@REM /D CompressionMemory=21 设置使用最大的压缩字典大小（21代表32MB），这可以帮助达到更好的压缩率。
@REM /L 目标目录 是指定输出 .cab 文件的目录。
@REM 源文件路径 是你想要压缩的文件的路径。

@REM /l <dir>
@REM 指定放置目标文件的位置（默认为当前目录）。
@REM /v[<n>]
@REM 设置调试参数 (0=无,...,3=完全)。
@REM 用法一
@REM a.先建立ddf文件(含设置及文件列表), 如：Sample.ddfb. 进入命令行格式 输入
MAKECAB /F Sample.ddf
@REM 用法二
@REM a.先建立txt文件(文件列表)
MAKECAB /F list.txt /D compressiontype=mszip /D compressionmemory=21 /D maxdisksize=1024000000 /D diskdirectorytemplate=dd* /D cabinetnametemplate=dd*.cab

@REM 压缩多个文件
DIR /B >>name.txt
MAKECAB /F name.txt

@REM 解压缩
expand 源文件路径 -F:* 目标文件夹路径
@REM macOS 或 Linux
install cabextract
cabextract 源文件路径 -d 目标文件夹路径

@REM 单个 CAB 文件的最大大小通常限制为2GB。
@REM 文件内的单个文件大小限制为2GB。
