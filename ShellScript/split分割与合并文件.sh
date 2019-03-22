# 把大文件分成每个 -b 10M 小文件，按数字明明分割文件 -d，数字 -a 6 位，前缀是 sc。
split -b 10M 0207.mp4 -d -a 6 sc

# split（选项）（file）PREFIX
# -b：值为每一输出档案的大小，单位为 byte。
# -C：每一输出档中，单行的最大 byte 数。
# -d：使用数字作为后缀。
# -l：值为每一输出档的列数大小。
# PREFIX:代表前导符，可作为切割文件的前导文件。

# 使用split命令将上面创建的date.file文件分割成大小为10KB的小文件：
split -b 10k date.file

# 文件被分割成多个带有字母的后缀文件，如果想用数字后缀可使用-d参数，同时可以使用-a length来指定后缀的长度：
split -b 10k date.file -d -a 3

# 为分割后的文件指定文件名的前缀：
split -b 10k date.file -d -a 3 split_file

# 使用-l选项根据文件的行数来分割文件，例如把文件分割成每个包含10行的小文件：
split -l 10 date.file

# 将split分割的文件合并成一个
cat x*>>y*
