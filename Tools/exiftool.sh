# 支持的数据类型
exiftool -h

# 查询相关命令

# 查看所有信息
exiftool photo.jpg
# 查看所有元信息，包括重复和未知标签，并按小组排列
exiftool -a -u -g1 photo.jpg
# 查看图片尺寸
exiftool -s -ImageSize -ExposureTime photo.jpg
# 查看dir目录文件信息（不仅仅是图片）
exiftool -common dir
# 从两个图像文件打印所有信息。
exiftool -l  c.jpg d.jpg
# 从两个图像文件打印标准的佳能信息。
exiftool -l -canon c.jpg d.jpg

# 删除命令

# 有些相机会记录拍照时的GPS定位信息。如果你不希望别人看到使用该命令删除gps信息
exiftool -gps:all= photo.jpg
# 删除所有信息
exiftool -all= photo.jpg
# 删除EXIF以外的所有信息
exiftool -all= --exif:all photo.jpg

# 写入编辑命令

# 写入艺术家标签
exiftool -artist=标签名称 photo.jpg
# 写多个文件
exiftool -artist=标签名称 a.jpg b.jpg c.jpg
# 写在一个目录的所有文件 exiftoolTest为文件夹
exiftool -artist=标签名称  /exiftoolTest

# 批量处理EXIF信息

# 批量写入dirName目录艺术家标签
exiftool -artist=标签名称  /dirName
# 批量删除dirName及其子目录所有文件EXIF信息，-r表示递归处理子目录
exiftool -r -all= /dirName
# 批量删除dirName及其子目录所有文件gps信息
exiftool -gps:all= /dirName

# 这个命令显示指定文件的metadata的属性
mdls  photo.jpg

# https://www.jianshu.com/p/d76457799de1
