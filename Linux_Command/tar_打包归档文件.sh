# tar 命令
# tape archive 磁带文档
# 最初用于建立磁带备份系统。
# 建立新文档，把指定的文件存放于新文档中。
tar [选项] <tar文件名> <文件列表/目录>
# [选项]
# c (create)建立新文档，存储指定文件
# v (verbose)命令以长方式运行，每个文件名在复制到文档时都会显示。
# f ()存档到文件而不是磁带机
# t 浏览文档中存储的文件清单
# x 取出文档中存储的文件
# z 建立使用 gzip 压缩的新文档

# 举例
# 把当前所有 *.txt 文件存储到文档 text.tar
tar cvf text.tar *.txt
# 把目录打包，包括所有子目录和文件
tar cvf text.tar text
# 看看里面有哪些文件
tar tvf text.tar
# 取出里面的文件到当前目录
tar xvf text.tar
# 建立 gzip 压缩的新文档 tar.gz
tar czvf text.tar.gz text
# 解压 tar.gz
tar xzvf text.tar.gz