# Windows 10/11 原生 OpenSSH 服务

Windows 10（1809+）和 Windows 11 已内置 OpenSSH 客户端和服务器，无需安装第三方软件。

## 安装 OpenSSH 服务器

### 方式一：系统设置（推荐）

打开 **设置 → 应用 → 可选功能 → 添加可选功能**，搜索 `OpenSSH 服务器`，点击安装。

### 方式二：PowerShell（管理员）

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

## 启动与设置自启

以**管理员**身份运行 PowerShell：

```powershell
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
```

## 防火墙放行端口 22

首次配置时通常需要手动放行：

```powershell
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

## 配置文件位置

| 用途 | 路径 |
|------|------|
| 服务器配置 | `%programdata%\ssh\sshd_config` |
| 全局已知主机 | `%programdata%\ssh\ssh_known_hosts` |
| 用户密钥目录 | `%userprofile%\.ssh\` |
| 管理员公钥文件 | `%programdata%\ssh\administrators_authorized_keys` |

## 编辑 sshd_config

以管理员身份用记事本打开配置文件：

```cmd
notepad "%programdata%\ssh\sshd_config"
```

### 常用配置项

```ini
# 监听端口（默认 22）
Port 22

# 允许密钥认证（使用密钥对登录）
PubkeyAuthentication yes

# 允许密码认证（建议配置好密钥后关闭）
PasswordAuthentication yes

# 允许 root（Administrators 组）登录
PermitRootLogin yes

# 严格模式：是否检查用户目录及密钥文件权限
# Windows 建议关闭，因为 Windows 权限模型与 Linux 不同
StrictModes no

# 公钥文件路径
AuthorizedKeysFile .ssh/authorized_keys

# 空闲超时断开（秒 * 次数）
ClientAliveInterval 600
ClientAliveCountMax 2
```

修改配置后重启服务：

```cmd
net stop sshd && net start sshd
```

## 生成 SSH 密钥对

在 PowerShell 或 CMD 中执行：

```powershell
ssh-keygen -t ed25519 -a 128 -C "yashi@Windows-PC" -f "$env:userprofile\.ssh\id_ed25519"
```

参数说明：
- `-t ed25519`：使用 Ed25519 算法（更安全、更短）
- `-a 128`：提高 KDF 轮数，加密私钥时更抗暴力破解
- `-C`：注释标签，方便辨识
- `-f`：指定输出文件路径

生成的密钥文件：
- `id_ed25519` —— 私钥（自己保管，切勿泄露）
- `id_ed25519.pub` —— 公钥（部署到服务器）

也可使用 RSA：

```powershell
ssh-keygen -m PEM -t rsa -b 4096 -C "yashi@Windows-PC" -f "$env:userprofile\.ssh\id_rsa"
```

## 配置证书登录

### 普通用户

将公钥追加到用户的 `authorized_keys`：

```powershell
cat $env:userprofile\.ssh\id_ed25519.pub >> $env:userprofile\.ssh\authorized_keys
```

### Administrators 组成员

Windows 对管理员账户有特殊处理 —— 公钥需写入 `administrators_authorized_keys`：

```cmd
COPY "C:\Users\用户名\.ssh\id_ed25519.pub" "C:\ProgramData\ssh\administrators_authorized_keys"
```

然后修正文件权限（必须，否则 sshd 会拒绝使用该文件）：

```cmd
icacls.exe "C:\ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"
```

## 验证与测试

从另一台机器（或本机）测试证书登录：

```cmd
ssh 用户名@目标IP -p 22 -i "C:\Users\用户名\.ssh\id_ed25519"
```

确认证书登录正常后，建议关闭密码登录：

```ini
PasswordAuthentication no
```

然后重启 sshd 服务生效。

---

微软官方文档：
<https://learn.microsoft.com/zh-cn/windows-server/administration/openssh/openssh_server_configuration>
<https://learn.microsoft.com/zh-cn/windows-server/administration/openssh/openssh_keymanagement>
