# 开机显示详细启动过程
vim /etc/default/grub # 通常改这个
vim /boot/grub/grub.conf
vim /boot/grub2/grub.cfg
grub2-mkconfig -o /etc/default/grub

# UEFI：
vim /boot/efi/EFI/系统名/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/系统名/grub.cfg

# 新版系统
vim /etc/grub.d/10_linux
quiet_boot="0"
quick_boot="0"
gfxpayload_dynamic="0"
vt_handoff="0"
# 应用更改
update-grub
grub-mkconfig -o /etc/default/grub
# 以上最终会生成 /etc/default/grub

# 开机画面关闭：
# 删除 rhgb quiet 。

# /usr/sbin/grub-mkconfig: 48: /etc/default/grub: function: not found
rm /etc/default/grub && grub-mkconfig -o /etc/default/grub

# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash" :
# quiet – 此选项告诉内核不产生任何输出(a.k.a.非详细模式)。如果在没有此选项的情况下启动，您将看到许多内核消息，例如驱动程序/模块激活，文件系统检查和错误。当您需要查找错误时，没有quiet参数可能很有用。
# splash – 此选项用于启动eye-candy “loading”屏幕，同时系统的所有核心部分都在后台加载。如果您禁用它并启用quiet，您将获得一个空白屏幕。
# nomodeset – 告诉内核在系统启动并运行之前不启动视频驱动程序。
