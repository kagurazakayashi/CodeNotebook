# 解决硬盘100%但读写0
1. 按下WIN+X，然后打开设备管理器；
2. 然后在设备管理器中，展开节点“IDE ATA/ATAPI控制器”→“标准SATA AHCI控制器”，右击选择“属性”；
3. 点击“详细信息”标签，将“属性”栏修改为“设备实例路径”，记录下它的路径；
4. 按下WIN+R调出运行，输入“regedit” 回车启动注册表编辑器，导航到“HKEY_LOCAL_MACHINE\System\CurrentControlSet\Enum\PCI\xxxxx\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties”（“xxxxx”是你刚刚记录的“设备实例路径”）；
5. 最后更改右窗格中的“MSISupported”键值，由1改为0；
6. 重新启动系统使之生效。