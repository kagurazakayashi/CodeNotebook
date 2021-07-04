# 查看现有盘大小
fdisk -l

# 查看分区大小和文件系统类型
df -Th

# 扩容磁盘：
# 扩容分区 growpart <DeviceName> <PartionNumber>
# /dev/vda1 :
growpart /dev/vda 1

# 扩展文件系统 ( ext3 ext4 ) resize2fs <分区名称>
resize2fs /dev/vda1
# 扩展文件系统 ( xfs ) xfs_growfs <挂载点>
xfs_growfs /

# 查看云盘分区大小
df -h

# https://help.aliyun.com/document_detail/111738.html