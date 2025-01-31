Write-Host "PowerShell 倒计时继续"
for ($i = 60; $i -gt 0; $i--) {
    Write-Host -NoNewline "$i 秒后开始..."  # 输出不换行
    Start-Sleep -Seconds 1  # 休眠 1 秒
    # Start-Sleep -Milliseconds 1000  # 休眠 1 秒
    Write-Host -NoNewline "`r"  # 回到行首，清除当前输出
}
