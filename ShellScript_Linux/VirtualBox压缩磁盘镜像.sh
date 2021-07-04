# 其他磁盘格式转 vdi
VBoxManage clonehd "source.vmdk" "cloned.vdi" --format vdi
# vdi压缩
VBoxManage modifyhd cloned.vdi --compact
# 转换成其他磁盘格式
VBoxManage clonehd "cloned.vdi" "compressed.vmdk" --format vmdk
# vmdk 直接压缩
vmware-vdiskmanager -k disk.vmdk

# vdi 批量压缩
for f in *.vdi; do echo $f;VBoxManage modifyhd $f --compact; done