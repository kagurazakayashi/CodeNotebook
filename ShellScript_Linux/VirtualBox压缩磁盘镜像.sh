# 其他磁盘格式转 vdi
VBoxManage clonehd "source.vmdk" "cloned.vdi" --format vdi
# vdi压缩
VBoxManage modifyhd cloned.vdi --compact
# 转换成其他磁盘格式
VBoxManage clonehd "cloned.vdi" "compressed.vmdk" --format vmdk
# vmdk 直接压缩
vmware-vdiskmanager -k disk.vmdk

# 批量转换格式
for %%i in (*.vdi) do ( "%ProgramFiles%\Oracle\VirtualBox\VboxManage.exe" clonehd %%i %%~ni.vhd --format=VHD)

# 批量压缩
for %%i in (*.vdi) do ( "%ProgramFiles%\Oracle\VirtualBox\VboxManage.exe" modifyhd %%i --compact)
