# 检查网站证书还有多久到期检查网站证书还有多久到期 保存为 UTF8 BOM
Write-Host "SSL 证书到期检查程序"
for ($i = 60; $i -gt 0; $i--) {
    Write-Host -NoNewline "$i 秒后开始..."  # 输出不换行
    Start-Sleep -Seconds 1
    Write-Host -NoNewline "`r"  # 回到行首，清除当前输出
}

# 导入Windows Forms库来弹出警告框
Add-Type -AssemblyName "System.Windows.Forms"

# 要检查的域名
$domains = @("tongdy.com", "mytongdy.com", "iaqtongdy.com", "uuu.moe", "yashi.moe", "miyabi.moe", "masae.moe", "yoooooooooo.com", "uuumoe.com")
# 剩余多少天警告
$warningThreshold = 15
# 代理服务器
$proxyAddress = "192.168.1.45"

foreach ($domain in $domains) {
    try {
        # 判断是否通过代理访问
        $useProxy = $domain.StartsWith('@')
        if ($useProxy) {
            # 去掉@前缀以获取实际域名
            $domain = $domain.Substring(1)
        }
        Write-Host "检查域名: $domain $(if ($useProxy) { "(通过代理: $proxyAddress)" })"

        # 获取服务器证书
        $tcpConnection = New-Object System.Net.Sockets.TcpClient
        if ($useProxy) {
            # 通过代理连接
            $tcpConnection.Connect($proxyAddress, 443)  # 使用代理地址
        }
        else {
            # 不使用代理直接连接
            $tcpConnection.Connect($domain, 443)
        }
        $stream = $tcpConnection.GetStream()
        $sslStream = New-Object System.Net.Security.SslStream($stream, $false, { param($sender, $certificate, $chain, $sslPolicyErrors) $true })
        $sslStream.AuthenticateAsClient($domain)

        # 获取证书信息
        $certificate = $sslStream.RemoteCertificate
        Write-Host "证书发行者: $($certificate.Issuer)"
        $expirationDate = $certificate.GetExpirationDateString()  # 获取证书到期日期
        Write-Host "有效期到: $expirationDate"
        $expirationDate = [datetime]::Parse($expirationDate)

        # 计算证书剩余有效期
        $daysRemaining = ($expirationDate - (Get-Date)).Days
        Write-Host "剩余有效期: $daysRemaining 天"

        # 输出证书信息
        Write-Host ""

        # 判断是否即将到期
        if ($daysRemaining -le $warningThreshold) {
            # 弹出警告框
            [System.Windows.Forms.MessageBox]::Show("证书将在 $daysRemaining 天内到期！有效期到: $expirationDate", "域名 $domain 证书到期警告", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning) | Out-Null
        }
    }
    catch {
        Write-Host "无法连接到 $domain 或获取证书信息。错误：$($_.Exception.Message)"
        [System.Windows.Forms.MessageBox]::Show("$($_.Exception.Message)", "$domain", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    }
    finally {
        # 确保关闭连接
        $sslStream.Close()
        $tcpConnection.Close()
    }
}

for ($i = 10; $i -gt 0; $i--) {
    Write-Host -NoNewline "$i 秒后退出..."  # 输出不换行
    Start-Sleep -Seconds 1
    Write-Host -NoNewline "`r"  # 回到行首，清除当前输出
}
