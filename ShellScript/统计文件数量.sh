# 查看当前目录下的文件数量（不包含子目录中的文件）
ls -l|grep "^-"| wc -l

# 查看当前目录下的文件数量（包含子目录中的文件） 注意：R，代表子目录
ls -lR|grep "^-"| wc -l

# 查看当前目录下的文件夹目录个数（不包含子目录中的目录），同上述理，如果需要查看子目录的，加上R
ls -l|grep "^d"| wc -l

# 查询当前路径下的指定前缀名的目录下的所有文件数量
# 例如：统计所有以“20161124”开头的目录下的全部文件数量
ls -lR 20161124*/|grep "^-"| wc -l

# 对每个命令参数做一下说明备注：
ls -l
# 该命令表示以长列表输出指定目录下的信息（未指定则表示当前目录），R代表子目录中的“文件”，这个“文件”指的是目录、链接、设备文件等的总称

# grep "^d"表示目录，"^-"表示文件

wc -l
# 表示统计输出信息的行数，因为经过前面的过滤已经只剩下普通文件，一个目录或文件对应一行，所以统计的信息的行数也就是目录或文件的个数