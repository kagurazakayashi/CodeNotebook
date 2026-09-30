# MBR转GPT并切换UEFI

## 适用场景

当前 Windows 10：

- 系统盘使用 MBR 分区表
- BIOS 使用 Legacy / CSM 启动
- 主板支持 UEFI
- 希望在不重装 Windows 的情况下转换为 GPT + UEFI

Windows 10 自带 `MBR2GPT.exe`，通常可以无损转换。

---

## 一、确认系统盘编号

管理员 CMD：

```cmd
diskpart
list disk
exit
````

确认 Windows 所在硬盘，例如：

```text
Disk 0
```

以下示例假设系统盘为 `Disk 0`。

---

## 二、转换前验证

```cmd
mbr2gpt /validate /disk:0 /allowFullOS
```

如果显示：

```text
Validation completed successfully
```

说明磁盘布局满足转换条件。

---

## 三、执行转换

```cmd
mbr2gpt /convert /disk:0 /allowFullOS
```

正常过程可能看到：

```text
MBR2GPT: Trying to shrink the OS partition
MBR2GPT: Creating the EFI system partition
MBR2GPT: Installing the new boot files
MBR2GPT: Performing the layout conversion
MBR2GPT: Migrating default boot entry
MBR2GPT: Adding recovery boot entry
MBR2GPT: Fixing drive letter mapping
MBR2GPT: Conversion completed successfully
```

看到：

```text
Conversion completed successfully
```

说明：

* MBR → GPT 已完成
* EFI System Partition 已创建
* Windows UEFI 启动文件已安装

此时不要再次运行 `mbr2gpt`。

---

## 四、修改 BIOS / UEFI

转换完成后重启进入 BIOS。

将启动模式从：

```text
Legacy
CSM
Legacy + UEFI
```

改为：

```text
UEFI
```

如果存在以下设置，可考虑：

```text
CSM = Disabled
Legacy Boot = Disabled
Boot Mode = UEFI
```

启动项优先选择：

```text
Windows Boot Manager
```

而不是直接选择 SSD / HDD 型号。

---

## 五、Secure Boot

确认 UEFI 模式可以正常启动 Windows 后，可以再考虑启用：

```text
Secure Boot
```

Secure Boot 与 GPT / UEFI 是相关但不同的机制。

建议不要在第一次切换 UEFI 的同时一次性修改大量 BIOS 安全选项。

---

## 六、WinRE 报错处理

MBR2GPT 转换完成时有时会看到：

```text
Failed to update ReAgent.xml
please try to manually disable and enable WinRE
```

这通常不是 EFI 启动失败，而是 Windows Recovery Environment 配置没有同步更新。

正常进入 Windows 后，管理员 CMD：

```cmd
reagentc /info
```

然后：

```cmd
reagentc /disable
reagentc /enable
```

重新检查：

```cmd
reagentc /info
```

正常应显示：

```text
Windows RE status: Enabled
```

---

## 七、转换前建议

如果启用了 BitLocker，修改启动模式、Secure Boot、TPM 等设置之前，建议先：

```cmd
manage-bde -protectors -disable C:
```

修改完成并确认 Windows 能正常启动后：

```cmd
manage-bde -protectors -enable C:
```

注意：

`-disable` 只是暂时暂停 BitLocker 启动保护，不会解密整个磁盘。

---

## 八、重要提示

执行 `mbr2gpt /convert` 成功后：

* 硬盘已经变成 GPT
* 原 Legacy 启动方式通常无法继续启动 Windows
* 必须切换 BIOS 到 UEFI
* 不需要重新格式化系统盘
* 不需要重新安装 Windows

重要数据仍建议提前备份。

````
