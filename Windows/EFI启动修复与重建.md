# Windows：EFI / UEFI 启动修复与重建

## 适用场景

系统盘已经是 GPT，但出现：

- Windows Boot Manager 丢失
- EFI 启动文件损坏
- EFI 分区仍在，但 Windows 无法启动
- 更换磁盘 / 克隆磁盘后 EFI 启动失效

此时通常不应该再次使用 `MBR2GPT`。

正确工具主要是：

```text
BCDBOOT
````

---

# 一、进入 Windows 恢复环境

可以通过：

* Windows 安装 U 盘
* Windows Recovery Environment
* 高级启动选项

进入：

```text
修复计算机
→ 疑难解答
→ 高级选项
→ 命令提示符
```

---

# 二、找到 Windows 与 EFI 分区

```cmd
diskpart
list vol
```

一般：

## EFI System Partition

通常具有以下特征：

```text
FAT32
100 MB ～ 数百 MB
无盘符
```

## Windows 分区

通常是：

```text
NTFS
容量较大
```

注意：

在 WinRE 中 Windows 分区不一定是 `C:`。

可逐个检查：

```cmd
dir C:\Windows
dir D:\Windows
dir E:\Windows
```

直到找到真实 Windows 目录。

---

# 三、给 EFI 分区临时分配盘符

假设 EFI 是 Volume 2：

```cmd
diskpart
select volume 2
assign letter=S
exit
```

此时 EFI 分区临时成为：

```text
S:
```

---

# 四、重新创建 Windows UEFI 启动文件

假设 Windows 位于：

```text
C:\Windows
```

执行：

```cmd
bcdboot C:\Windows /s S: /f UEFI
```

成功通常显示：

```text
Boot files successfully created.
```

---

# 五、重启

进入 BIOS，确认：

```text
Boot Mode = UEFI
```

优先启动：

```text
Windows Boot Manager
```

---

# 六、EFI 分区已经被删除

如果 EFI System Partition 已不存在，需要：

1. 准备未分配空间
2. 新建 EFI System Partition
3. 格式化为 FAT32
4. 使用 `bcdboot` 重建启动文件

不建议在不确认磁盘布局的情况下直接复制通用 `diskpart` 删除/缩分区命令。

先使用：

```cmd
diskpart
list disk
select disk 0
list partition
list volume
```

确认实际磁盘布局后再操作。

---

# 七、MBR2GPT 与 BCDBOOT 的区别

## MBR2GPT

适用于：

```text
MBR
↓
GPT
+
Legacy BIOS
↓
UEFI
```

主要命令：

```cmd
mbr2gpt
```

---

## BCDBOOT

适用于：

```text
磁盘已经是 GPT
EFI 引导损坏 / 丢失
↓
重新生成 Windows Boot Manager
```

主要命令：

```cmd
bcdboot
```

因此：

> EFI 启动损坏时不要把 MBR2GPT 当作通用 EFI 修复工具。

````
