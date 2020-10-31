# 压缩文件以节省磁盘空间
# 可以和 tar 命令组合

# gzip [选项] <文件列表>
# d 解压缩文件，并去除文件名后的 .gz

# 举例
# 压缩文件 test.pdf，变成文件 test.pdf.gz (源文件被删除)
gzip test.pdf

# 压缩当前目录中的所有文件，不包括子目录中的文件
gzip *

# 解压缩文件 test.pdf.gz
gzip -d test.pdf.gz
# 或
gunzip test.pdf.gz