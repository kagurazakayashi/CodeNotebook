# 导出Hyper-V虚拟机

# 重启服务，不要在有正在运行 VM 的机器上执行。
Restart-Service vmms

# 虚拟机名称，可以先列出：
Get-VM

# 导出 VM：
Export-VM -Name "YourVMName" -Path "D:\VMExports"

# 导出日志在：
# 事件查看器 → 应用程序和服务日志 → Microsoft → Windows → Hyper-V-VMMS
