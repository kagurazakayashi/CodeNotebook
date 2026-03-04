param(
    [string]$TargetPath = $PSScriptRoot
)

Write-Host "开始清理: $TargetPath 下的所有空文件夹..." -ForegroundColor Cyan

# 确认路径存在
if (-Not (Test-Path -Path $TargetPath -PathType Container)) {
    Write-Host "错误: 路径不存在 -> $TargetPath" -ForegroundColor Red
    exit 1
}

# 查找并删除空文件夹
$emptyDirs = Get-ChildItem -Path $TargetPath -Directory -Recurse |
    Where-Object { $_.GetFileSystemInfos().Count -eq 0 }

if ($emptyDirs.Count -eq 0) {
    Write-Host "未发现空文件夹。" -ForegroundColor Yellow
} else {
    $emptyDirs | ForEach-Object {
        try {
            Remove-Item $_.FullName -Force
            Write-Host "已删除: $($_.FullName)" -ForegroundColor Green
        } catch {
            Write-Host "删除失败: $($_.FullName) - $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    Write-Host "清理完成，共删除 $($emptyDirs.Count) 个空文件夹。" -ForegroundColor Cyan
}
