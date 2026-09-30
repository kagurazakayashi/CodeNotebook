# 无 TPM 的 Windows：使用 BitLocker USB Startup Key

`gpedit.msc`

计算机配置 → 管理模板 → Windows 组件 → BitLocker 驱动器加密 → 操作系统驱动器

找到并 启用：

启动时需要附加身份验证 (Require additional authentication at startup)

勾选：允许在不兼容 TPM 的电脑上启用 BitLocker
（Allow BitLocker without a compatible TPM）

点击确定。

## 启用 BitLocker（使用 USB 启动密钥）

1. 打开 控制面板 → 系统和安全 → BitLocker 驱动器加密：
2. 点击【启用 BitLocker】
3. 系统提示无 TPM，选择 使用 USB 启动密钥（Use a USB flash drive）
4. 插入 U 盘（此时 BitLocker 会将启动密钥保存在 U 盘根目录）
5. 选择密钥备份方式（建议保存到 Microsoft 帐户或另存密钥文件）
6. 选择加密方式（新设备推荐使用 XTS-AES，兼容建议 AES-CBC）
7. 点击开始加密。

## 目标

电脑没有 TPM：

```powershell
Get-Tpm
````

结果类似：

```text
TpmPresent : False
TpmReady   : False
```

希望：

```text
插着指定 U 盘
→ BitLocker 自动读取启动密钥
→ 不手动输入密码
→ 启动 Windows
```

这可以使用 BitLocker：

```text
Startup Key
External Key
.BEK 文件
```

实现。

---

# 一、Secure Boot 不等于 TPM

即使 BIOS 支持：

```text
UEFI
Secure Boot
PK
KEK
db
dbx
```

也不代表存在 TPM。

Secure Boot：

```text
验证启动程序签名
```

TPM：

```text
保存 / 保护密钥
记录 PCR 启动测量
帮助 BitLocker 自动释放密钥
```

两者是不同的技术。

完全可能：

```text
UEFI         √
Secure Boot  √
TPM          ×
```

---

# 二、检查当前 BitLocker 保护器

管理员 CMD：

```cmd
manage-bde -protectors -get C:
```

可能看到：

```text
Password
Numerical Password
```

或者其他保护器。

其中：

```text
Numerical Password
```

一般是 48 位 BitLocker Recovery Key。

建议始终保留一个恢复密钥保护器。

---

# 三、准备 USB U盘

推荐：

```text
普通 USB Mass Storage
FAT32
主板 UEFI 能在 Windows 启动前识别
```

假设 USB 盘符为：

```text
E:
```

---

# 四、添加 USB Startup Key

管理员 CMD：

```cmd
manage-bde -protectors -add C: -startupkey E:\
```

或者 PowerShell：

```powershell
Add-BitLockerKeyProtector `
  -MountPoint "C:" `
  -StartupKeyProtector `
  -StartupKeyPath "E:\"
```

然后检查：

```cmd
manage-bde -protectors -get C:
```

应该增加：

```text
External Key
```

U 盘中会生成类似：

```text
{GUID}.BEK
```

的隐藏启动密钥文件。

---

# 五、不要立即删除原有密码保护器

建议暂时保持：

```text
Password
External Key
Numerical Password
```

然后测试。

---

# 六、测试

## 测试 A：插着 USB

```text
USB 插入
↓
开机
↓
Windows Boot Manager 读取 .BEK
↓
BitLocker 解锁
↓
Windows 启动
```

理想情况下不需要输入密码。

---

## 测试 B：不插 USB

拔掉 U 盘再启动。

具体行为取决于当前 BitLocker 保护器与启动环境。

可能：

```text
要求输入 BitLocker 启动密码
```

也可能：

```text
进入 BitLocker Recovery
要求 48 位 Recovery Key
```

因此不要在验证之前删除现有密码保护器。

---

# 七、重要区别

## USB Only

```cmd
manage-bde -protectors -add C: -StartupKey E:\
```

含义：

```text
USB Startup Key
```

不依赖 TPM。

---

## TPM + USB

这不是 USB-only：

```text
TPMAndStartupKey
```

它表示：

```text
TPM
+
USB Startup Key
```

两者共同参与保护。

不要把它与纯 USB Startup Key 混淆。

---

# 八、安全注意事项

USB `.BEK` 文件本质上属于 BitLocker 启动凭据。

因此：

* 不要把 `.BEK` 放到公开位置
* 不要随意上传云盘
* 不要把启动 U 盘长期和电脑放在同一个包里
* 建议另行安全保存 48 位 Recovery Key
* 可以制作备用 USB Startup Key，但应妥善保管

如果电脑和启动 U 盘同时被盗，USB-only BitLocker 的实际保护效果会明显降低。

````
