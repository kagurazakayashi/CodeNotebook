# Hyper-V未配置为启用处理器资源控制

Get-WinEvent -FilterHashTable @{ProviderName="Microsoft-Windows-Hyper-V-Hypervisor"; ID=2} -MaxEvents 1

#    ProviderName:Microsoft-Windows-Hyper-V-Hypervisor

# TimeCreated                      Id LevelDisplayName Message
# -----------                      -- ---------------- -------
# 2025/4/23 9:58:39                 2 信息             Hypervisor scheduler type is 0x4.

bcdedit /set hypervisorschedulertype Classic

# 操作成功完成。
# 重启。
