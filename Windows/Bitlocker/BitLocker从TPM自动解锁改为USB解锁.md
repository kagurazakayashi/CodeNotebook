# BitLocker：TPM 自动解锁 → USB Startup Key

## 目标

当前系统盘 C: 使用：

```text
TPM
````

自动解锁。

希望改成：

```text
USB Startup Key
```

并停止使用 TPM 作为日常 BitLocker 启动保护器。

不需要解密并重新加密整个磁盘。

---

# 一、查看现有保护器

管理员 CMD：

```cmd
manage-bde -protectors -get C:
```

典型状态：

```text
TPM
Numerical Password
```

其中：

```text
TPM
```

负责当前自动启动。

```text
Numerical Password
```

通常是 48 位 Recovery Key。

不要删除恢复密钥。

---

# 二、准备 USB

假设 USB 盘符：

```text
E:
```

建议使用普通 FAT32 USB Mass Storage。

---

# 三、先添加 USB Startup Key

管理员 CMD：

```cmd
manage-bde -protectors -add C: -startupkey E:\
```

然后：

```cmd
manage-bde -protectors -get C:
```

应该看到：

```text
TPM
External Key
Numerical Password
```

此时：

```text
TPM
```

与：

```text
External Key
```

是两个独立保护器。

这不是：

```text
TPM + USB
```

双因素组合。

---

# 四、确认 USB Key 已成功创建

检查 USB 是否出现：

```text
{GUID}.BEK
```

并确认：

```cmd
manage-bde -protectors -get C:
```

存在：

```text
External Key
```

以及：

```text
Numerical Password
```

---

# 五、删除 TPM 保护器

建议按具体 ID 删除。

先查看：

```cmd
manage-bde -protectors -get C:
```

例如：

```text
TPM:
    ID: {AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE}
```

执行：

```cmd
manage-bde -protectors -delete C: -id {AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE}
```

也可以按类型删除：

```cmd
manage-bde -protectors -delete C: -type TPM
```

但存在多个 TPM 类保护器时，按 ID 删除更安全。

---

# 六、最终推荐结构

```text
External Key
Numerical Password
```

含义：

```text
USB Startup Key
↓
正常启动

USB 无法使用
↓
BitLocker Recovery
↓
48 位恢复密钥
```

---

# 七、不要误用 TPMAndStartupKey

不要把：

```text
StartupKey
```

和：

```text
TPMAndStartupKey
```

混淆。

## StartupKey

```text
USB only
```

## TPMAndStartupKey

```text
TPM + USB
```

也就是说：

```text
TPMAndStartupKey
```

仍然依赖 TPM。

如果目的是彻底停止用 TPM 解锁，应使用：

```cmd
manage-bde -protectors -add C: -StartupKey E:\
```

而不是 TPMAndStartupKey。

---

# 八、修改前后的安全原则

不要按照：

```text
先删 TPM
→ 再创建 USB
```

的顺序操作。

正确顺序：

```text
创建 USB Key
↓
确认 External Key 存在
↓
确认 Recovery Key 存在
↓
删除 TPM
↓
测试启动
```

这样即使 USB 配置发生问题，仍有 Recovery Key 可以恢复。

````

---

# BitLocker：USB Startup Key → TPM 自动解锁 

BitLocker从USB启动密钥改回TPM自动解锁

## 目标

当前 Windows 系统盘使用：

```text
USB Startup Key
````

解锁。

希望改回：

```text
TPM 自动解锁
```

即：

```text
开机
↓
TPM 验证启动环境
↓
自动释放 BitLocker 密钥
↓
Windows 正常启动
```

不需要解密并重新加密整个系统盘。

---

# 一、确认 TPM 正常

PowerShell：

```powershell
Get-Tpm
```

正常至少应显示：

```text
TpmPresent : True
TpmReady   : True
```

如果：

```text
TpmPresent : False
```

则 Windows 当前无法使用 TPM。

---

# 二、查看现有 BitLocker 保护器

管理员 CMD：

```cmd
manage-bde -protectors -get C:
```

例如：

```text
External Key
Numerical Password
```

其中：

```text
External Key
```

是 USB Startup Key。

```text
Numerical Password
```

是恢复密钥。

---

# 三、添加 TPM 保护器

执行：

```cmd
manage-bde -protectors -add C: -TPM
```

然后检查：

```cmd
manage-bde -protectors -get C:
```

应该变成：

```text
TPM
External Key
Numerical Password
```

---

# 四、先不要删除 USB Key

此时先拔掉 USB，然后重启电脑。

如果：

```text
无需 USB
无需输入 Recovery Key
Windows 正常启动
```

说明 TPM 自动解锁已经正常工作。

---

# 五、删除 USB External Key

进入 Windows 后：

```cmd
manage-bde -protectors -get C:
```

找到：

```text
External Key:
    ID: {AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE}
```

执行：

```cmd
manage-bde -protectors -delete C: -id {AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE}
```

不要误删：

```text
Numerical Password
```

---

# 六、最终推荐结构

```text
TPM
Numerical Password
```

工作逻辑：

```text
正常启动
↓
TPM 自动解锁
↓
Windows

TPM / PCR / UEFI 启动环境异常
↓
BitLocker Recovery
↓
输入 48 位恢复密钥
```

---

# 七、TPM、TPM+PIN、TPM+USB 的区别

## TPM

```text
TPM 自动解锁
无需人工干预
```

添加：

```cmd
manage-bde -protectors -add C: -TPM
```

---

## TPM + PIN

```text
TPM
+
人工输入 PIN
```

安全性高于纯 TPM，但不能无人值守启动。

---

## TPM + Startup Key

```text
TPM
+
USB Startup Key
```

并不是纯 TPM 自动启动。

因此，如果目标是完全自动：

```text
TPM
```

即可。

---

# 八、修改 BIOS 前暂停 BitLocker

以下操作可能改变 TPM PCR 测量值：

```text
修改 Secure Boot
修改 UEFI / CSM
升级 BIOS
修改 TPM / PTT / fTPM
修改启动顺序
更换部分硬件
```

修改之前建议：

```cmd
manage-bde -protectors -disable C:
```

完成修改并正常进入 Windows 后：

```cmd
manage-bde -protectors -enable C:
```

这不会解密系统盘，只是暂时暂停启动保护。

---

# 九、最安全的迁移原则

正确：

```text
保留 USB
↓
添加 TPM
↓
拔掉 USB 测试 TPM
↓
TPM 正常
↓
删除 External Key
```

不要：

```text
先删除 USB
↓
再配置 TPM
```

任何保护器迁移都应该遵循：

> 先增加新的可用保护器，验证成功以后，再删除旧保护器。
