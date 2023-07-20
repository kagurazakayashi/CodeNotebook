# 防止文件被修改 文件无法删除

# 限制：
chattr +i /home/wwwroot/yoursite/.user.ini
# 解除：
chattr -i /home/wwwroot/yoursite/.user.ini
# 移除所有限制
chattr -iaR /home/wwwroot/yoursite

chattr [-RV] [-+=AacDdijsSu] [-v version] 文件或目录
# 参数  描述
# －R  递归处理所有的文件及子目录。
# －V  详细显示修改内容，并打印输出。
# –   失效属性。
# +   激活属性。
# =   指定属性。
# A   Atime，告诉系统不要修改对这个文件的最后访问时间。
# S   Sync，一旦应用程序对这个文件执行了写操作，使系统立刻把修改的结果写到磁盘。
# a   Append Only，系统只允许在这个文件之后追加数据，不允许任何进程覆盖或截断这个文件。如果目录具有这个属性，系统将只允许在这个目录下建立和修改文件，而不允许删除任何文件。
# i   Immutable，系统不允许对这个文件进行任何的修改。如果目录具有这个属性，那么任何的进程只能修改目录之下的文件，不允许建立和删除文件。
# D   检查压缩文件中的错误。
# d   No dump，在进行文件系统备份时，dump程序将忽略这个文件。
# C   Compress，系统以透明的方式压缩这个文件。从这个文件读取时，返回的是解压之后的数据；而向这个文件中写入数据时，数据首先被压缩之后才写入磁盘。
# s   Secure Delete，让系统在删除这个文件时，使用0填充文件所在的区域。
# u   Undelete，当一个应用程序请求删除这个文件，系统会保留其数据块以便以后能够恢复删除这个文件。

# 用chattr命令防止系统中某个关键文件被修改：
chattr +i /etc/resolv.conf

# 用lsattr查询文件属性：
lsattr /etc/resolv.conf
# ----i-------- /etc/resolv.conf #显示如上

# 让某个文件只能往里面追加数据，但不能删除，适用于各种日志文件：
chattr +a /var/log/messages
