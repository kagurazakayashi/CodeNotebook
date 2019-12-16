# 解 tar
tar -xf dir.tar
# 创建 tar
tar -cf dir.tar dir

# 单文件压成 xz
xz -k -9 -T 0 -z a.tar
-k: 保留原文件
-9: 压缩比 0-9
-T 4: 4个线程进行压缩,0=尽可能多
# 解压 xz
xz -k -d a.xz
-k: 保留原文件
# 多文件压成 tar.xz
tar -Jcf dir.tar.xz dir
XZ="-9 -T 0" tar -Jcf dir.tar.xz dir
# 解压 tar.xz
tar -Jxf dir.tar.xz
# 查看 CPU 核心数
more /proc/cpuinfo |grep "physical id"|uniq|wc -l

# 创建 tar.gz
tar -czf all.tar.gz *.jpg
# 解压 tar.gz
tar -zxvf ×××.tar.gz

# 创建 tar.bz2
tar -cjf all.tar.bz2 *.jpg
# 解压 tar.bz2
tar -jxvf ×××.tar.bz2

# 创建 tar.Z
tar -cZf all.tar.Z *.jpg
# 解压 tar.Z
tar -xZf all.tar.Z

# 创建 zip
zip all.zip *.jpg
# 解压 zip
unzip all.zip

# 创建 rar (RARfor Linux)
rar a all *.jpg
# 解压 rar
unrar e all.rar

# 7za 7z
7za
x #解压
a #压缩
l #浏览
-mx9 #压缩比0-9
-v1000m #分卷
-p123456 #密码123456
-y #默认覆盖
-o/uz/a #解压到
-tzip #用zip格式，zip、7z、rar、cab、gzip、bzip2、tar
压缩包.7z
源文件/夹