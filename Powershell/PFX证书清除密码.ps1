# PFX证书清除密码，将当前文件夹中的所有pfx解密。
# 注意编码保存成 UTF-8-BOM

# 当前目录路径
$directory = Get-Location

# 创建用于保存无密码版本的输出文件夹（如果不存在则创建）
$outputFolder = Join-Path $directory "Unprotected_PFX"
if (-not (Test-Path $outputFolder)) {
    New-Item -Path $outputFolder -ItemType Directory
}

# 获取当前目录下所有的 .pfx 文件（不包括子目录）
$pfxFiles = Get-ChildItem -Path $directory -Filter *.pfx -File

# 遍历每一个 .pfx 文件
foreach ($pfxFile in $pfxFiles) {
    Write-Host "正在处理: $($pfxFile.FullName)"

    # 提示输入原始 .pfx 文件的密码
    $pfxPassword = Read-Host "请输入密码用于解密 $($pfxFile.Name)" -AsSecureString

    # 创建证书对象并导入 .pfx 文件
    $pfxCert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
    try {
        $pfxCert.Import($pfxFile.FullName, $pfxPassword, "Exportable,PersistKeySet")
    } catch {
        Write-Host "解密失败：$($pfxFile.Name)，请检查密码是否正确。"
        continue
    }

    # 无密码导出路径
    $outputPath = Join-Path $outputFolder "$($pfxFile.BaseName)-unprotected.pfx"

    # 导出证书为无密码版本
    $bytes = $pfxCert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx, $null)

    # 保存到新的无密码的 .pfx 文件
    [System.IO.File]::WriteAllBytes($outputPath, $bytes)

    Write-Host "✅ 已导出无密码版本：$outputPath"
}

Write-Host "所有操作完成。"
