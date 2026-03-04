# 到指定时间关机
# 参数为时间（支持 HH:mm 和 HH:mm:ss）
# 如果目标时间小于当前时间，计算为第二天
param(
    [string]$InputTime = "00:00:00" # 默认时间
)

# 检查输入时间格式（支持 HH:mm 和 HH:mm:ss）
if ($InputTime -notmatch "^\d{1,2}:\d{2}(:\d{2})?$") {
    Write-Host "时间格式错误，请使用 HH:mm 或 HH:mm:ss 格式（例如 17:00 或 17:00:30）。" -ForegroundColor Red
    exit
}

# 获取当前时间
$currentTime = Get-Date

# 设置目标时间
try {
    if ($InputTime -match "^\d{1,2}:\d{2}(:\d{2})?$") {
        # 解析输入时间（支持 HH:mm 或 HH:mm:ss）
        $timeParts = $InputTime.Split(":")
        $targetHour = [int]$timeParts[0]
        $targetMinute = [int]$timeParts[1]
        $targetSecond = if ($timeParts.Count -eq 3) { [int]$timeParts[2] } else { 0 }

        # 创建目标时间为今天
        $targetTime = Get-Date -Hour $targetHour -Minute $targetMinute -Second $targetSecond
    } else {
        throw "无效的时间格式。"
    }
} catch {
    Write-Host "无法解析输入时间，请确认格式为 HH:mm 或 HH:mm:ss。" -ForegroundColor Red
    exit
}

# 如果目标时间小于当前时间，计算为第二天
if ($targetTime -le $currentTime) {
    $targetTime = $targetTime.AddDays(1)
}

# 计算剩余秒数并减去 1 秒以避免额外时间显示
$secondsRemaining = [math]::Ceiling(($targetTime - $currentTime).TotalSeconds)

# 防止负值的意外情况
if ($secondsRemaining -lt 0) {
    Write-Host "剩余秒数无效，可能由于计算错误。" -ForegroundColor Red
    exit
}

# 显示剩余时间和目标时间
Write-Host "当前时间: $($currentTime.ToString("HH:mm:ss"))"
Write-Host "目标时间: $($targetTime.ToString("yyyy-MM-dd HH:mm:ss"))"
Write-Host "距离目标时间还有 $secondsRemaining 秒。"

# 执行关机命令
Start-Process -FilePath "shutdown.exe" -ArgumentList "/s /t $secondsRemaining"
