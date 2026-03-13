# 从文件夹创建dmg高压缩
sudo hdiutil create -srcfolder "/Library/Developer" -format ULMO -ov -scrub -verbose -volname "Developer" "/Volumes/T500G/Developer.dmg"
# -srcfolder: 指定源文件夹路径。
# -format ULMO: 关键参数。ULMO 代表使用 LZMA 压缩算法的只读磁盘映像。它的压缩率远高于磁盘工具默认的 UDZO (zlib)。
# -ov: 如果目标文件名已存在，直接覆盖（Overwrite）。
# -scrub: 非常重要。它会在创建镜像前移除文件夹中一些不必要的临时元数据（如某些缓存），能微弱提升压缩效果并保持镜像干净。
# -volname: 设置挂载后在访达（Finder）中显示的卷名。

# 备份整个硬盘
sudo hdiutil create -srcdevice diskN -format ULMO "./my_disk_backup.dmg"
# -srcdevice diskN:
# 这是源设备路径。你需要把 diskN 替换为实际的磁盘标识符（例如 disk1, disk2s1 ）。 ls /dev/disk*
# 如何查找？ 在终端输入 diskutil list 查看你的硬盘列表，确认你要备份的磁盘编号。
# -format ULMO:
# 这是关键点。ULMO 使用的是 lzma 压缩算法，它是 hdiutil 支持的压缩率最高的格式（比常用的 UDZO 压缩效果更好，但压缩时间更长）。
# -encryption AES-256:
# 使用建议的 256位 AES 加密。执行命令后，系统会提示你输入并确认密码。
# ./my_disk_backup.dmg:
# 这是生成的映像文件存放路径及名称。


# 自用
# 备份系统数据
sudo hdiutil create -layout GPTSPUD -fs APFS -volname "Developer" -srcfolder "/Library/Developer" -nospotlight -anyowners -skipunreadable -noatomic -format ULMO -encryption AES-256 -verbose "/Volumes/bak/Developer.dmg"
# 备份整个硬盘
ls /dev/disk*
sudo hdiutil create -srcdevice diskN -format ULMO -encryption AES-256 -verbose "./my_disk_backup.dmg"
# 压缩一般文件夹
sudo hdiutil create -layout MBRSPUD -fs ExFAT -volname "data" -srcfolder "data" -nospotlight -noanyowners -noskipunreadable -noatomic -format ULMO -verbose "data.dmg"
