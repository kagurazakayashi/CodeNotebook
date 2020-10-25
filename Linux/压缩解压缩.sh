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
tar -c dir | xz -z -9 -e -T 48 >dir.tar.xz
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
# a：存档要添加的文件
# b：基准
# d:从存档中删除文件
# e：从档案中提取文件（不使用目录名）
# h：计算文件的哈希值
# i:显示有关支持格式的信息
# l：档案目录
# rn：重命名存档中的文件
# t：测试档案的完整性
# u:更新文件以存档
# x：提取具有完整路径的文件

# --：停止开关分析
# -ai[r[-|0]]{@listfile | !通配符}：包括存档文件
# -ax[r[-|0]]{@listfile | !通配符}：排除存档文件
# -ao{a|s|t|u}模式覆盖
# -an:禁用存档名称字段
# -bb[0-3]：设置输出日志级别
# -bd：禁用进度指示器
# -bs{o|e|p}{0|1|2}：为输出/错误/进度线设置输出流
# -bt：显示执行时间统计
# -i[r[-|0]]{@listfile | !通配符}：包括文件名
# -m{Parameters}：设置压缩方法
# -mmt[N]：设置CPU线程数
# -o{Directory}：设置输出目录
# -p{Password}：设置密码
# -r[-|0]：递归子目录
# -sa{a | e | s}：设置存档名称模式
# -scc{UTF-8 | WIN | DOS}：为控制台输入/输出设置字符集
# -scs{UTF-8 | UTF-16LE | UTF-16BE | WIN | DOS |{id}}：为列表文件设置字符集
# -scrc[CRC32 | CRC64 | SHA1 | SHA256 |*]：为x，e，h命令设置散列函数
# -sdel：压缩后删除文件
# -seml[.]：通过电子邮件发送存档文件
# -sfx[{name}]：创建sfx存档
# -si[{name}]：从stdin读取数据
# -slp：设置大页面模式
# -slt：显示l（List）命令的技术信息
# -snh：将硬链接存储为链接
# -snl：将符号链接存储为链接
# -存储NT安全信息
# -sns[-]：存储NTFS备用流
# -so：将数据写入stdout
# -spd：禁用文件名的通配符匹配
# -spe：为extract命令消除根文件夹的重复
# -spf:使用完全限定的文件路径
# -ssc[-]：设置敏感案例模式
# -ssw：压缩共享文件
# -stl：从最近修改的文件设置存档时间戳
# -stm{HexMask}：设置CPU线程关联掩码（十六进制数）
# -stx{Type}：排除存档类型
# -t{Type}：设置存档类型
# -u[-][p#][q#][r#][x#][y#][z#][！newArchiveName]：更新选项
# -v{Size}[b | k | m | g]：创建卷
# -w[{path}]：分配工作目录。空路径表示临时目录
# -x[r[-| 0]]{@listfile |！通配符}：排除文件名
# -y：假设所有查询都是

# 最大压缩
7za a "yashi.7z" "yashidir" -mx=9 -ms=64g -mf -mhc -mhcf -m0=LZMA2:a=2:d=31:fb=1024 -mmt -r
# -t7z -- 压缩文件的格式为7z
# -mx=9 -ms=200m -mf -mhc -mhcf -m0=LZMA:a=2:d=25:mf=bt4b:fb=64 -mmt
# -- 指定压缩算法选项
# -mx=9 -- 设置压缩等级为极限压缩（默认为：LZMA 最大算法、32 MB 字典大小、BT4b Match finder、单词大小为 64、BCJ2 过滤器）
# -ms=200m -- 开启固实模式，设置固实数据流大小为200MB。
# -mf -- 开启可执行文件压缩过滤器。
# -mhc -- 开启档案文件头压缩。
# -mhcf -- 开启档案文件头完全压缩。我所使用的7z版本为4.42>2.30。
# -m0=LZMA:a=2:d=25:mf=bt4b:fb=64
# -- 第一个备选压缩算法为LZMA，压缩等级为最大压缩，LZMA算法使用的字典大小为25(2MB的5次方)32MB，算法的匹配器为bt4b(所需要内存为d×9.5 + 34 MB)，压缩算法的紧凑字节为最大模式的64字节。
# -mmt -- 开启多线程模式。
# -r -- 递归到所有的子目录。