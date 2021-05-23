# Linux本身提供了dos2unix和unix2dos两个命令来实现Windows和Linux文件的转换。

# 单文件：
dos2unix 1.sh

# 多文件：
dos2unix filename1, filename2

# 批量：
find /apps/cws -name "*.sh" -exec dos2unix {} \;

# 文件夹里的所有文件：
find /apps/cws -name "*" -exec dos2unix {} \;

# 用法：dos2unix [选项] [文件 ...] [-n 输入文件 输出文件 ...]
#  --allow-chown         允许修改文件所有者
#  -ascii                只转换换行符（默认）
#  -iso                  在 DOS 和 ISO-8859-1 字符集之间转换
#    -1252               使用Windows 1252 编码页（西欧）
#    -437                使用DOS 437 编码页（US）（默认）
#    -850                使用DOS 850 编码页（西欧）
#    -860                使用DOS 860 编码页（葡萄牙）
#    -863                使用DOS 863 编码页（加拿大法語）
#    -865                使用DOS 865 编码页（北欧）
#  -7                    转换8 位字符到7 位空间
#  -b, --keep-bom         保留UTF-8 BOM头
#  -c, --convmode        转换模式
#    convmode            ascii、7bit、iso或mac，默认为ascii
#  -f, --force           强制转换二进制文件
#  -h, --help            显示本说明文字
#  -i, --info[=FLAGS]    显示文件信息
#    文件 ...            需要分析的文件
#  -k, --keepdate        保留输出文件时间
#  -L, --license         显示软件协议
#  -l, --newline         加入额外的换行符
#  -m, --add-bom         添加UTF-8 BOM头（默认为UTF-8）
#  -n, --newfile         写入新文件
#    infile              新文件模式中的原始文件
#    outfile             新文件模式中的输出文件
#  --no-allow-chown      不允许修改文件所有者（默认选项）
#  -o, --oldfile         写入原文件（默认）
#    file ...            旧文件模式中要转换的文件
#  -q, --quiet           安静模式，不显示所有警告
#  -r, --remove-bom         移除UTF-8 BOM头（默认）
#  -s, --safe            跳过二进制文件(默认)
#  -u,  --keep-utf16     保留UTF-16编码
#  -ul, --assume-utf16le 假定输入文件格式为UTF-16LE
#  -ub, --assume-utf16be 假定输入文件格式为UTF-16BE
#  -v,  --verbose        显示更多信息
#  -F, --follow-symlink  根据符号链接转换其目标文件
#  -R, --replace-symlink 取代符号链接为转换后的文件
#                          (原链接目标文件保持不变)
#  -S, --skip-symlink    保持符号链接及其目标不变（默认）
#  -V, --version         显示版本号