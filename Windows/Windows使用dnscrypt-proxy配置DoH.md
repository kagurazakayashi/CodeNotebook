# Windows 使用 dnscrypt-proxy 配置 DoH

Windows 11 原生支持 DoH（DNS over HTTPS），Windows 10 则完全没有这套功能。
若要让 Windows 10 的**整个系统**都走加密 DNS，唯一可行的办法是在本机跑一个
DNS 转发代理，再把网卡的 DNS 服务器指向它。本文记录完整做法、踩过的坑与验证手段。

## 一、先确认系统是否支持系统级 DoH

Windows 10 没有系统级 DoH，无论 19045（22H2）还是更早版本。用以下命令可在几秒内确认：

```powershell
# 1. 是否存在 DoH 相关 cmdlet（Windows 11 才有 Add-DnsClientDohServerAddress 等）
Get-Command -Name '*Doh*' -ErrorAction SilentlyContinue

# 2. DnsClient 模块版本，以及它实际提供的命令清单
Get-Module -ListAvailable DnsClient | Select-Object Name, Version
Get-Command -Module DnsClient | Select-Object -ExpandProperty Name

# 3. netsh 是否存在 dns 上下文中的 DoH 子命令（Windows 11 有 netsh dns add encryption）
netsh dns

# 4. 是否已注册 DoH 模板（Windows 11 才有此注册表键）
Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\DohWellKnownServers'
```

Windows 10（19045.7663）实测结果：

| 检查项                          | Windows 10 (19045) | Windows 11 |
| ------------------------------- | ------------------ | ---------- |
| 本机是否支持系统级 DoH          | 否                 | 是         |
| `Add-DnsClientDohServerAddress` | 不存在             | 存在       |
| `netsh dns add encryption`      | 不存在             | 存在       |
| `DohWellKnownServers` 注册表键  | 不存在             | 存在       |

判定要点：**只要 DnsClient 模块里没有 `*-DnsClientDohServerAddress` 系列命令，
系统级 DoH 就没有任何写入位置**，不要在注册表里手工拼 DoH 配置。

## 二、方案原理

本地代理监听环回地址的 53 端口，系统把 DNS 指向该环回地址，代理再用 DoH 向公网查询。

```text
应用程序
   │  普通 DNS（明文，但只走本机环回，不出网卡）
   ▼
127.0.0.1:53 / [::1]:53        <- dnscrypt-proxy 在此监听
   │  DoH（HTTPS 加密，出网卡）
   ▼
223.5.5.5:443 / dns.google:443 / dns64.dns.google:443
```

配套的网卡 DNS 设置：主 DNS 指向代理，备 DNS 留作明文降级。

| 协议 | 主 DNS（走 DoH） | 备 DNS（明文降级） |
| ---- | ---------------- | ------------------ |
| IPv4 | `127.0.0.1`      | `223.5.5.5`        |
| IPv6 | `::1`            | `2400:3200::1`     |

这样代理正常时全程加密；代理未运行时 Windows 自动切到备 DNS，不会断网。

## 三、部署步骤

### 1. 下载 dnscrypt-proxy

```powershell
# 查询最新版本与 Windows 资源下载地址
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$r = Invoke-RestMethod -Uri 'https://api.github.com/repos/DNSCrypt/dnscrypt-proxy/releases/latest' `
     -UseBasicParsing -Headers @{'User-Agent'='PowerShell'}
$r.tag_name
$r.assets | Where-Object name -match 'win64' | Select-Object name, browser_download_url

# 下载并解压（示例版本 2.1.18）
$ver = '2.1.18'
$zip = "$env:TEMP\dnscrypt-proxy-win64-$ver.zip"
Invoke-WebRequest -UseBasicParsing -OutFile $zip `
  "https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/$ver/dnscrypt-proxy-win64-$ver.zip"
Expand-Archive $zip -DestinationPath "$env:TEMP\dnscrypt"
```

### 2. 安装到固定目录

程序本体只有单个 exe，放到服务账户可读写的位置即可，推荐 `C:\ProgramData\dnscrypt-proxy`。

```powershell
# 必须先建目录再复制，服务的工作目录就是 exe 所在目录
New-Item -ItemType Directory -Force -Path 'C:\ProgramData\dnscrypt-proxy' | Out-Null
Copy-Item "$env:TEMP\dnscrypt\win64\dnscrypt-proxy.exe" 'C:\ProgramData\dnscrypt-proxy\' -Force
& 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe' -version
```

### 3. 编写 dnscrypt-proxy.toml

关键配置项与说明（完整示例见文末附录）：

```toml
# 只监听环回，避免成为对外的开放解析器
listen_addresses = ['127.0.0.1:53', '[::1]:53']
max_clients = 250

# 只使用下方 [static] 中声明的服务器，不下载任何公共服务器列表
server_names = ['alidns-v4', 'google-v4', 'alidns-v6', 'google-dns64-v6']

ipv4_servers = true
ipv6_servers = true     # 需要启用，否则 IPv6 静态端点不会被使用
dnscrypt_servers = false
doh_servers = true
odoh_servers = false

# 静态 stamp 不含隐私声明，不要按这些条件过滤
require_dnssec = false
require_nolog = false
require_nofilter = false

force_tcp = false
http3 = false
timeout = 5000
keepalive = 30
cert_refresh_delay = 240

# 绝对不要用系统 DNS 做引导：系统 DNS 已指向本代理，会形成环路
ignore_system_dns = true
bootstrap_resolvers = ['223.5.5.5:53', '8.8.8.8:53']

# 开机等待网络就绪，探测一个普通 UDP 端点
netprobe_timeout = 60
netprobe_address = '223.5.5.5:53'
block_ipv6 = false

cache = true
cache_size = 4096
cache_min_ttl = 300
cache_max_ttl = 86400
cache_neg_min_ttl = 60
cache_neg_max_ttl = 600

# 日志（相对路径会落在本配置文件所在目录）
log_level = 2
log_file = 'dnscrypt-proxy.log'
log_file_latest = true

# 留空，全部上游都在 [static] 中静态声明，启动时无需联网下载
[sources]

# 静态 DoH 上游，使用 DNS stamp
[static]

  [static.'alidns-v4']
  stamp = 'sdns://AgAAAAAAAAAACTIyMy41LjUuNQAJMjIzLjUuNS41Ci9kbnMtcXVlcnk'
```

其中 `ignore_system_dns = true` 是关键：改完网卡 DNS 后，系统解析器指回本机，
若代理还去读系统 DNS 做引导就会死循环，必须显式指定 `bootstrap_resolvers`。

### 4. 注册为 Windows 服务并启动

```powershell
# 必须在 exe 所在目录执行，服务注册后工作目录即该目录
& 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe' -service install
& 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe' -service start

# 查看服务配置
sc.exe qc dnscrypt-proxy
Get-Service dnscrypt-proxy | Select-Object Name, Status, StartType
```

实测服务注册后的 `BINARY_PATH_NAME` 是：

```text
C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe -config dnscrypt-proxy.toml
```

注意配置名是**相对路径**，但服务的工作目录就是 exe 所在目录，
因此配置与日志都能正确定位（实测日志确实落在 `C:\ProgramData\dnscrypt-proxy\`）。
启动类型为 `Automatic`、账户为 `LocalSystem`，开机自动运行。

### 5. 设置网卡 DNS

先查出目标网卡的接口索引，再分别设置 IPv4 与 IPv6（两个地址族要分开调用）。

```powershell
# 查出正在使用、有默认路由的网卡
Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object Name, ifIndex, InterfaceDescription
Get-DnsClientServerAddress -InterfaceIndex 21 | Select-Object AddressFamily, ServerAddresses

# IPv4：主 DNS 用环回代理，备 DNS 用明文（降级用）
Set-DnsClientServerAddress -InterfaceIndex 21 -ServerAddresses @('127.0.0.1', '223.5.5.5')

# IPv6：同样主用环回代理，备 DNS 用明文
Set-DnsClientServerAddress -InterfaceIndex 21 -ServerAddresses @('::1', '2400:3200::1')

Clear-DnsClientCache

# 核对结果
netsh interface ipv4 show dnsservers name="网卡名称"
netsh interface ipv6 show dnsservers name="网卡名称"
```

注意 `Set-DnsClientServerAddress` 一次调用只会设置一个地址族，
混着传 IPv4 与 IPv6 地址可能报错，分开调用最稳。

## 四、DNS Stamp 编码（最容易踩的坑）

`dnscrypt-proxy` 的 `[static]` 段用 DNS stamp 描述上游，**不能直接写 URL**。

### 1. 结构

```text
protocol(1 字节) | props(8 字节小端) | LP(addr) | VLP(hashes) | LP(hostname) | LP(path)
```

- `protocol`：`0x01` = DNSCrypt，`0x02` = DoH，`0x03` = DoT，`0x04` = DoQ
- `props`：非正式属性位，1 = DNSSEC，2 = 无日志，4 = 无过滤
- `LP(x)`：先 1 字节长度，再跟内容；`VLP` 是一串 LP，以长度为 0 的 LP 结束
- 无证书哈希时，`VLP(hashes)` 就是单个 `0x00`
- 最终用 base64url（无填充）编码，加前缀 `sdns://`

### 2. 三条硬规则

| 规则                           | 后果                                                          |
| ------------------------------ | ------------------------------------------------------------- |
| `addr` 必须是裸 IP，不能带端口 | 写成 `223.5.5.5:443` 会报 `Invalid stamp (IP address)`        |
| IPv6 地址必须用方括号包裹      | 否则冒号会被当成端口分隔，同样报 `Invalid stamp (IP address)` |
| `hostname` 可以是 IP 字面量    | 这是能忠实还原 `https://223.5.5.5/dns-query` 这类模板的关键   |

前两条来自 `go-dnsstamps` 的 `validateAddrAndHostname`：

```go
// 只要 addr 里出现冒号且未被方括号包裹，就直接判定为非法 IP
if strings.ContainsRune(ip, ':') {
    return errors.New("Invalid stamp (IP address)")
}
```

**验证时最容易误判的地方**：报错信息叫 `Invalid stamp (IP address)`，
看起来像在说 hostname 不合法，实际卡住的是 `addr` 带端口。
排查时优先怀疑 `addr`。

### 3. 生成脚本

```powershell
# 生成 DoH 的 DNS stamp（sdns://）
# 结构：protocol(0x02=DoH) | props(8 字节小端) | LP(addr) | 0x00(空哈希) | LP(hostname) | LP(path)
function New-DohStamp {
    param(
        [string]$Addr,      # 连接地址，裸 IP；IPv6 用方括号包裹，如 [2400:3200::1]
        [string]$HostName,  # TLS 主机名，可为 IP 字面量或域名
        [string]$Path,      # DoH 路径，通常是 /dns-query
        [uint64]$Props = 0  # 属性位：1=DNSSEC，2=无日志，4=无过滤
    )
    $b = New-Object System.Collections.Generic.List[byte]
    $b.Add([byte]0x02)                              # 协议标识：DoH
    $b.AddRange([BitConverter]::GetBytes($Props))   # 属性位，8 字节小端
    # LP(addr)
    $t = [System.Text.Encoding]::ASCII.GetBytes($Addr)
    $b.Add([byte]$t.Length); $b.AddRange($t)
    $b.Add([byte]0x00)                              # 空证书哈希列表
    # LP(hostname)
    $t = [System.Text.Encoding]::ASCII.GetBytes($HostName)
    $b.Add([byte]$t.Length); $b.AddRange($t)
    # LP(path)
    $t = [System.Text.Encoding]::ASCII.GetBytes($Path)
    $b.Add([byte]$t.Length); $b.AddRange($t)
    # base64url 编码（把 + / 换成 - _，去掉补位 =）
    return 'sdns://' + [Convert]::ToBase64String($b.ToArray()).Replace('+','-').Replace('/','_').TrimEnd('=')
}

# 生成 4 个目标 stamp
New-DohStamp -Addr '223.5.5.5'              -HostName '223.5.5.5'        -Path '/dns-query'
New-DohStamp -Addr '8.8.8.8'                -HostName 'dns.google'       -Path '/dns-query'
New-DohStamp -Addr '[2400:3200::1]'         -HostName '223.5.5.5'        -Path '/dns-query'
New-DohStamp -Addr '[2001:4860:4860::8888]' -HostName 'dns64.dns.google' -Path '/dns-query'
```

生成的 4 个 stamp（可直接复用）：

| 名称            | 服务器地址           | DoH 模板                           |
| --------------- | -------------------- | ---------------------------------- |
| alidns-v4       | 223.5.5.5            | https://223.5.5.5/dns-query        |
| google-v4       | 8.8.8.8              | https://dns.google/dns-query       |
| alidns-v6       | 2400:3200::1         | https://223.5.5.5/dns-query        |
| google-dns64-v6 | 2001:4860:4860::8888 | https://dns64.dns.google/dns-query |

### 4. 踩过的 PowerShell 坑：`-shr` 移位会按位宽取模

用位移方式拆 `props` 的 8 个字节时，`7 -shr 32` 的结果不是 0 而是 7
（移位量按 32 取模），会让属性位字节错位。实测该错误产生的 stamp
在结构上仍然合法，只是含义变了，很难发现。

```powershell
# 错误写法：i = 4 时 8*$i = 32，7 -shr 32 仍得 7，多写了一个 0x07
for ($i = 0; $i -lt 8; $i++) { $b.Add([byte](($Props -shr (8*$i)) -band 0xFF)) }

# 正确写法：直接用 BitConverter 生成小端字节
$b.AddRange([BitConverter]::GetBytes([uint64]$Props))
```

### 5. 用已知 stamp 自测生成器

写生成器时，先用一个已知正确的 stamp 反验，确认编码逻辑无误再生成目标 stamp。

```powershell
# Cloudflare 的公开 DoH stamp，用于对照自测
$known = 'sdns://AgcAAAAAAAAABzEuMC4wLjEAEmRucy5jbG91ZGZsYXJlLmNvbQovZG5zLXF1ZXJ5'
$gen   = New-DohStamp -Addr '1.0.0.1' -HostName 'dns.cloudflare.com' -Path '/dns-query' -Props 7
$known -eq $gen   # 必须为 True，否则生成器不可信
```

### 6. 校验 stamp 与整份配置

`-check` 会解析配置并校验所有 stamp，是改配置后必跑的一步。

```powershell
# 校验整份配置
& 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe' `
  -config 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.toml' -check
# 成功时输出：Configuration successfully checked，退出码 0
```

单独验证一个 stamp 时，可以写一份只含单个服务器、监听高位端口的临时配置，
避免干扰正在运行的服务。

```powershell
# 临时配置：只测一个服务器，监听 53053 以免和正式服务抢 53 端口
$stamp = 'sdns://AgAAAAAAAAAACTIyMy41LjUuNQAJMjIzLjUuNS41Ci9kbnMtcXVlcnk'
@"
listen_addresses = ['127.0.0.1:53053']
server_names = ['t']
[sources]
[static]
  [static.'t']
  stamp = '$stamp'
"@ | Set-Content "$env:TEMP\stamp-test.toml" -Encoding ASCII

& 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe' `
  -config "$env:TEMP\stamp-test.toml" -check
```

## 五、53 端口被 ICS 占用时的共存办法

### 1. 现象

`Internet Connection Sharing (ICS)`（服务名 `SharedAccess`）会占用 `0.0.0.0:53`，
它同时是 Hyper-V `Default Switch` 与 WSL2 的 NAT 依赖，通常不能随便停掉。
被占用时启动本机 DNS 代理会报端口冲突。

```powershell
# 查看 53 端口占用
Get-NetUDPEndpoint -LocalPort 53 |
  Select-Object LocalAddress, OwningProcess,
    @{n='进程';e={(Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).ProcessName}}

# 反查是哪个服务
tasklist /svc /fi "PID eq <上一步的 PID>"
```

### 2. 共存方案：只绑环回地址

实测结论：**ICS 绑的是通配地址 `0.0.0.0:53`，仍然可以再绑 `127.0.0.1:53` 与 `[::1]:53`**。
发往环回的查询会优先交给更具体的绑定，两者互不干扰，
因此**不需要停掉 ICS**，也就不会影响 Hyper-V 与 WSL 的网络。

先用一段脚本确认环回能否绑定，再决定是共存还是停服务：

```powershell
# 测试能否在 ICS 占用 0.0.0.0:53 的情况下继续绑定环回地址
foreach ($pair in @(@('UDP','127.0.0.1'), @('UDP','::1'), @('TCP','127.0.0.1'))) {
    $proto = $pair[0]; $addr = $pair[1]
    try {
        if ($proto -eq 'UDP') {
            # IPv6 必须用 InterNetworkV6，用默认（IPv4）套接字绑 ::1
            # 会报 "An address incompatible with the requested protocol"，容易误判为端口冲突
            $family = if ($addr -eq '::1') {
                [System.Net.Sockets.AddressFamily]::InterNetworkV6
            } else {
                [System.Net.Sockets.AddressFamily]::InterNetwork
            }
            $c = New-Object System.Net.Sockets.UdpClient($family)
            $ip = [System.Net.IPAddress]::Parse($addr)
            $c.Client.Bind((New-Object System.Net.IPEndPoint($ip, 53)))
            Write-Output "$proto $addr :53 绑定成功"
            $c.Close()
        } else {
            $l = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Parse($addr), 53)
            $l.Start(); Write-Output "$proto $addr :53 绑定成功"; $l.Stop()
        }
    } catch {
        $m = $_.Exception.Message
        if ($_.Exception.InnerException) { $m = $_.Exception.InnerException.Message }
        Write-Output "$proto $addr :53 失败 -> $m"
    }
}
```

部署完成后的监听状态应当是三个不同进程/地址并存：

| 地址        | 归属             | 说明                   |
| ----------- | ---------------- | ---------------------- |
| `0.0.0.0`   | `svchost` (ICS)  | Hyper-V / WSL2 的 NAT  |
| `127.0.0.1` | `dnscrypt-proxy` | 本机 IPv4 加密解析入口 |
| `::1`       | `dnscrypt-proxy` | 本机 IPv6 加密解析入口 |

若确实需要停 ICS，可参考同目录的 `53DNS端口被系统服务占用.md`，
但停掉它会影响 Hyper-V 与 WSL 的网络，能共存就不要停。

## 六、主备 DNS 与降级验证

Windows 会优先使用网卡 DNS 列表中的第一项；只有当主 DNS 无响应时才会用备用项。
因此“主 = 环回代理、备 = 明文”既能保证代理正常时全程加密，又能在代理故障时不断网。

实测验证方法（临时停掉服务，观察是否自动降级）：

```powershell
# 1. 代理运行时的基准
Clear-DnsClientCache
Resolve-DnsName 'www.163.com' -Type A | Where-Object Type -eq 'A'

# 2. 停掉代理
Stop-Service dnscrypt-proxy -Force

# 3. 直查 127.0.0.1 应当失败（证明确实是本地代理在提供服务）
nslookup -type=A www.sohu.com 127.0.0.1

# 4. 系统解析应当仍然成功（证明已降级到明文备 DNS）
Clear-DnsClientCache
Resolve-DnsName 'www.sohu.com' -Type A | Where-Object Type -eq 'A'

# 5. 恢复服务
Start-Service dnscrypt-proxy
```

实测结果：

| 场景                     | 实测结果                                        |
| ------------------------ | ----------------------------------------------- |
| 代理运行中               | 解析正常，`www.163.com` -> 36.99.112.35 (23 ms) |
| 代理已停，直查 127.0.0.1 | 失败：`No response from server`                 |
| 代理已停，系统解析       | 正常，`www.sohu.com` -> 220.181.181.183 (7 ms)  |
| 代理重启后               | 恢复正常                                        |

## 七、确认 DoH 真的生效

不要只看“能解析”就认为 DoH 生效了，要确认解析流量确实走了 HTTPS 的 443 端口。

```powershell
# 触发一次新查询（先清缓存）
Clear-DnsClientCache
Resolve-DnsName 'www.aliyun.com' -Type A | Where-Object Type -eq 'A'
Start-Sleep -Milliseconds 500

# 查看代理进程与上游之间的加密连接
$dpid = (Get-Process dnscrypt-proxy | Select-Object -First 1).Id
Get-NetTCPConnection -State Established |
  Where-Object OwningProcess -eq $dpid |
  Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort
```

实测输出如下，证明 DNS 走的是 `223.5.5.5:443` 的 HTTPS 而不是明文的 53 端口：

```text
LocalAddress  LocalPort RemoteAddress RemotePort
------------  --------- ------------- ----------
192.168.1.45      25696 223.5.5.5            443
```

另外可以看代理日志，其中会记录每个上游的探活结果与延迟排序：

```powershell
Get-Content 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.log' -Tail 20
```

```text
[NOTICE] [alidns-v4] OK (DoH) - rtt: 10ms
[NOTICE] [alidns-v6] OK (DoH) - rtt: 44ms
[NOTICE] Server with the lowest initial latency: alidns-v4 (rtt: 10ms), live servers: 2
```

日志中出现 `dnscrypt-proxy is waiting for at least one server to be reachable`
表示所有上游都暂时不可达，通常是对外网络不通，而不是配置错误。

## 八、无 IPv6 连通性时的注意事项

如果网卡没有全局 IPv6 地址、也没有 IPv6 默认路由，那么 IPv6 类型的上游
（例如 `2400:3200::1`、`2001:4860:4860::8888`）实际上不可用，
配置里可以保留作为“以后有 IPv6 就自动生效”的储备，但要知道它们当下不工作。

```powershell
# 确认是否存在全局 IPv6 地址
Get-NetIPAddress -AddressFamily IPv6 |
  Where-Object { $_.IPAddress -notlike 'fe80*' -and $_.IPAddress -ne '::1' }

# 确认是否存在 IPv6 默认路由
Get-NetRoute -AddressFamily IPv6 | Where-Object DestinationPrefix -eq '::0/0'

# 逐个测试上游 443 端口连通性
(New-Object System.Net.Sockets.TcpClient).ConnectAsync('2400:3200::1', 443).Wait(3000)
```

实测：无全局 IPv6 地址、无 IPv6 默认路由时，两个 IPv6 上游 TCP 均不可达。
另外观察到日志里 IPv6 上游有时会报 `OK`，但单独隔离测试又失败，
其真实链路归属未能确认，**此项存疑，不要依赖 IPv6 上游的可用性**。

## 九、常用操作示例

```powershell
$exe = 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe'
$dir = 'C:\ProgramData\dnscrypt-proxy'

# 校验配置语法与所有 stamp
& $exe -config "$dir\dnscrypt-proxy.toml" -check

# 列出当前生效的服务器
& $exe -config "$dir\dnscrypt-proxy.toml" -list

# 通过代理解析一个域名（用于诊断上游是否好用）
& $exe -config "$dir\dnscrypt-proxy.toml" -resolve 'example.com,127.0.0.1:53'

# 打印 DoH 服务器证书链哈希（配合 stamp 的哈希固定功能时使用）
& $exe -config "$dir\dnscrypt-proxy.toml" -show-certs

# 服务控制
& $exe -service install     # 注册服务
& $exe -service start       # 启动
& $exe -service restart     # 重启（改配置后）
& $exe -service stop        # 停止
& $exe -service uninstall   # 卸载并移除服务

# 也可以直接用 PowerShell 控制
Restart-Service dnscrypt-proxy
Get-Service dnscrypt-proxy | Select-Object Name, Status, StartType

# 查看系统当前 DNS 设置
Get-DnsClientServerAddress | Where-Object { $_.ServerAddresses.Count -gt 0 } |
  Select-Object InterfaceAlias, InterfaceIndex, AddressFamily, ServerAddresses
```

## 十、回滚

```powershell
# 1. 恢复网卡原来的 DNS（把下面的地址换成自己的原始值）
Set-DnsClientServerAddress -InterfaceIndex 21 -ServerAddresses @('219.141.136.10', '219.141.140.10')

# 2. 清掉之前设置的静态 IPv6 DNS（如果有）
netsh interface ipv6 set dnsservers name="网卡名称" source=static address=none validate=no

Clear-DnsClientCache

# 3. 卸载服务并删除程序目录
& 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe' -service stop
& 'C:\ProgramData\dnscrypt-proxy\dnscrypt-proxy.exe' -service uninstall
Remove-Item 'C:\ProgramData\dnscrypt-proxy' -Recurse -Force
```

`Set-DnsClientServerAddress` 的 `-ResetServerAddresses` 参数会把地址族重置为
“自动获取”，在静态 IP 的网卡上会导致 DNS 清空，恢复原状时应直接写回原地址。

## 十一、完整配置示例

```toml
# dnscrypt-proxy 配置：环回 DoH 转发代理
listen_addresses = ['127.0.0.1:53', '[::1]:53']
max_clients = 250
server_names = ['alidns-v4', 'google-v4', 'alidns-v6', 'google-dns64-v6']

ipv4_servers = true
ipv6_servers = true
dnscrypt_servers = false
doh_servers = true
odoh_servers = false

require_dnssec = false
require_nolog = false
require_nofilter = false

force_tcp = false
http3 = false
timeout = 5000
keepalive = 30
cert_refresh_delay = 240

ignore_system_dns = true
bootstrap_resolvers = ['223.5.5.5:53', '8.8.8.8:53']
netprobe_timeout = 60
netprobe_address = '223.5.5.5:53'
block_ipv6 = false

cache = true
cache_size = 4096
cache_min_ttl = 300
cache_max_ttl = 86400
cache_neg_min_ttl = 60
cache_neg_max_ttl = 600

log_level = 2
log_file = 'dnscrypt-proxy.log'
log_file_latest = true
log_files_max_size = 5
log_files_max_age = 7
log_files_max_backups = 1

[sources]

[static]

  # 223.5.5.5 / https://223.5.5.5/dns-query
  [static.'alidns-v4']
  stamp = 'sdns://AgAAAAAAAAAACTIyMy41LjUuNQAJMjIzLjUuNS41Ci9kbnMtcXVlcnk'

  # 8.8.8.8 / https://dns.google/dns-query
  [static.'google-v4']
  stamp = 'sdns://AgAAAAAAAAAABzguOC44LjgACmRucy5nb29nbGUKL2Rucy1xdWVyeQ'

  # 2400:3200::1 / https://223.5.5.5/dns-query
  [static.'alidns-v6']
  stamp = 'sdns://AgAAAAAAAAAADlsyNDAwOjMyMDA6OjFdAAkyMjMuNS41LjUKL2Rucy1xdWVyeQ'

  # 2001:4860:4860::8888 / https://dns64.dns.google/dns-query
  [static.'google-dns64-v6']
  stamp = 'sdns://AgAAAAAAAAAAFlsyMDAxOjQ4NjA6NDg2MDo6ODg4OF0AEGRuczY0LmRucy5nb29nbGUKL2Rucy1xdWVyeQ'
```

## 十二、小结

- Windows 10 没有系统级 DoH，`*-DnsClientDohServerAddress` 不存在即为判据。
- 用 `dnscrypt-proxy` 监听环回 53 端口 + 网卡 DNS 指向环回，即可实现系统级加密解析。
- stamp 的 `addr` 字段必须是裸 IP，不能带端口；IPv6 要加方括号；
  `hostname` 允许是 IP 字面量，因此 `https://<IP>/dns-query` 这类模板可被忠实还原。
- ICS 占用 `0.0.0.0:53` 时无需停服务，直接在 `127.0.0.1:53` 与 `[::1]:53` 上共存即可。
- 主 DNS 指向环回、备 DNS 用明文，可在代理故障时避免断网。
- 验证加密是否生效要看 `Get-NetTCPConnection` 中是否出现指向上游 443 端口的连接。

## 参考来源

- dnscrypt-proxy 官方仓库：<https://github.com/DNSCrypt/dnscrypt-proxy>
- DNS stamp 规范实现（`validateAddrAndHostname` 校验逻辑出处）：<https://github.com/jedisct1/go-dnsstamps>
- 本文命令、配置与实测数据均来自本机 Windows 10 Pro 22H2（19045.7663）实际操作。
