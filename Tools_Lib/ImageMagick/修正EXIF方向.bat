@REM 查看当前 EXIF 旋转方向
magick identify -format "%[EXIF:Orientation]" your_image.jpg
@REM 这会输出当前的旋转方向标记，例如1表示正向

@REM 修改 EXIF 方向标记：使用以下命令将 EXIF 中的旋转标记改为“1”(正向)
exiftool -Orientation=1 -n your_image.jpg
@REM ExifTool 通常会创建一个备份文件 your_image.jpg_original。如果不需要备份，可以添加 -overwrite_original 参数

ECHO | N | 翻转方向     | 镜像方向           |
ECHO |---|--------------|--------------------|
ECHO | 1 | 正常         | 无镜像             |
ECHO | 2 | 正常         | 水平镜像(左右翻转) |
ECHO | 3 | 旋转 180 度  | 无镜像             |
ECHO | 4 | 旋转 180 度  | 垂直镜像(上下翻转) |
ECHO | 5 | 顺时针 90 度 | 水平镜像(左右翻转) |
ECHO | 6 | 顺时针 90 度 | 无镜像             |
ECHO | 7 | 逆时针 90 度 | 水平镜像(左右翻转) |
ECHO | 8 | 逆时针 90 度 | 无镜像             |
