@REM 如果你想将 source.jpg 的所有元数据（包括 EXIF, IPTC, XMP 等）复制到 destination.jpg：
exiftool -tagsFromFile source.jpg destination.jpg

@REM 如果你只想针对性地复制 EXIF 和 IPTC，而不影响目标文件可能存在的其他信息（如 XMP 或 MakerNotes）：
exiftool -tagsFromFile source.jpg -exif:all -iptc:all destination.jpg

@REM 在处理复杂的元数据迁移时，建议使用 -all:all。这能确保嵌套的标签和不常见的元数据块也能被正确移动，并保留原始的组结构：
exiftool -tagsFromFile source.jpg -all:all destination.jpg

@REM 假设你有两个文件夹，src_dir 内存放带有信息的原图，dst_dir 内存放需要写入信息的图片（文件名一一对应）：
exiftool -tagsFromFile src_dir/%f.%e -all:all -ext jpg dst_dir
@REM %f 代表文件名，%e 代表扩展名。此命令会遍历 dst_dir 中的所有 JPG，并从 src_dir 寻找同名文件作为数据源。

@REM 如果你不想复制会导致图片显示异常的“方向”标签，可以排除它：
exiftool -tagsFromFile source.jpg -all:all --Orientation destination.jpg
