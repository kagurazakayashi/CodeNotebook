# 从电脑通过 USB 执行 Termux 命令（已 root 设备）

## 命令速查（置顶）

电脑端（PowerShell）：

```powershell
adb devices -l                                  # 确认设备（显示 device 即已授权）
adb shell su -c id                              # 以 root 执行简单命令
adb shell su 10316 -c id                        # 以 Termux 用户执行（pkg 必须用它）
adb shell su -c stat -c %u /data/data/com.termux/files/home   # 查 Termux 应用 uid（本机 10316）
adb shell su -c /data/data/com.termux/files/usr/bin/login     # 交互式登录（需真实终端，未实测）
```

脚本推送法（执行带空格/引号的复杂命令，绕开引号被剥）：

```powershell
adb push 脚本.sh /data/local/tmp/x.sh
adb shell su 10316 -c /data/data/com.termux/files/usr/bin/bash /data/local/tmp/x.sh
adb shell rm /data/local/tmp/x.sh
```

脚本模板（必须 LF 换行；su 启动不会注入 App 环境变量，需手动设置）：

```bash
#!/data/data/com.termux/files/usr/bin/bash
export PREFIX=/data/data/com.termux/files/usr
export HOME=/data/data/com.termux/files/home
export PATH=$PREFIX/bin:$PREFIX/bin/applets
export LD_LIBRARY_PATH=$PREFIX/lib
export TMPDIR=$PREFIX/tmp
. $PREFIX/etc/profile
# ↓ 实际命令写在这里
pkg list-installed | head -5
```

## 背景与结论

- 场景：Android 手机开启开发者模式 + USB 调试，经 USB 连到 Windows 电脑，想从电脑执行 Termux 命令。
- 本机环境：Windows 11 + ADB（platform-tools）；手机已 root（Magisk），Termux 为 Play 商店版。
- 结论：
  - Play 版 Termux 不可调试（not debuggable），`run-as` 方法不可用。
  - 设备已 root 时，可用 Magisk `su` 直接调用 Termux 的 bash 执行命令（本文方法，已实测）。
  - 未 root 设备应改用「SSH over USB」（见《Termux电脑SSH连接.md》）。

## 原理（为什么不能直接 adb shell）

1. `adb shell` 默认进入的是 Android 系统 shell（toybox/mksh），不是 Termux 环境。
2. Termux 的环境变量（PREFIX、HOME、PATH、LD_LIBRARY_PATH 等）由 Termux App 启动时注入；用 `su` 直接跑 Termux bash 时不会自带这些变量，必须手动设置。
3. `pkg`/`apt` 拒绝以 root 运行（Termux 安全限制），包管理操作需要 `su` 降级到 Termux 应用自身的 uid。
4. 复杂命令经「PowerShell → adb → 手机 shell → su」多层传递时引号会被逐层剥离，**可靠做法是把命令写成脚本推送执行**。

## 关键命令

### 1. 确认设备连接

```powershell
adb devices -l
# 输出末尾为 device 即已授权；unauthorized 需在手机上允许 USB 调试弹窗
```

### 2. 查询 Termux 应用 uid

```powershell
adb shell su -c stat -c %u /data/data/com.termux/files/home
# 本机输出 10316，即 Termux 以 uid 10316 运行
```

### 3. 执行单条简单命令（无空格、无引号）

```powershell
adb shell su -c id                 # 以 root 执行
adb shell su 10316 -c id           # 以 Termux uid 执行
adb shell su -c cat /data/data/com.termux/files/usr/etc/profile   # 查看文件
```

说明：`su -c` 会吃掉下一个参数作为命令，剩余参数透传给该命令（MagiskSU 特性），
因此命令与参数不带空格时可完全不用引号。

### 4. 执行复杂命令：脚本推送法（推荐，已实测）

先把命令写成本地脚本 `termux-cmd.sh`（必须 LF 换行）：

```bash
#!/data/data/com.termux/files/usr/bin/bash
# 手动设置 Termux 环境变量（su 执行时 App 不会注入环境）
export PREFIX=/data/data/com.termux/files/usr
export HOME=/data/data/com.termux/files/home
export PATH=$PREFIX/bin:$PREFIX/bin/applets
export LD_LIBRARY_PATH=$PREFIX/lib
export TMPDIR=$PREFIX/tmp

# 载入 Termux 配置（profile.d 下的初始化脚本）
. $PREFIX/etc/profile

# 以下写实际要执行的命令
uname -m
pkg list-installed | wc -l
pkg list-installed | head -5
```

推送到手机并执行：

```powershell
adb push termux-cmd.sh /data/local/tmp/termux-cmd.sh
adb shell su 10316 -c /data/data/com.termux/files/usr/bin/bash /data/local/tmp/termux-cmd.sh
adb shell rm /data/local/tmp/termux-cmd.sh      # 用完删除
```

实测输出示例（环境正常、pkg 可用）：

```text
uid     = 10316
user    = u0_a316
HOME    = /data/data/com.termux/files/home
PATH    = /data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets
arch    = aarch64
---- 已安裝套件數量 ----
91
```

### 5. 交互式登录（需要真实 TTY，未在自动化环境实测）

在自己电脑的终端（cmd/PowerShell）里执行：

```powershell
adb shell su -c /data/data/com.termux/files/usr/bin/login
```

注意：这样进入的是 root 的 Termux shell，`pkg` 仍会拒绝以 root 运行；
纯命令执行不受影响。

## 踩坑记录

| 现象 | 原因 | 解决 |
| --- | --- | --- |
| `run-as: package not debuggable: com.termux` | Play 版 Termux 不可调试，且新版 Android 下即使 root 也强制检查 | 改用 Magisk `su` |
| `Error: Cannot run 'pkg' command as root` | Termux 禁止 root 运行包管理器 | `su 10316 -c ...` 降级到应用 uid |
| `uname -m` 只输出 `Linux`、whoami 显示 shell | 引号被多层 shell 剥离，参数错位 | 用脚本推送法，避免嵌套引号 |
| 脚本执行报错或无输出 | Windows 写脚本默认 CRLF 换行 | 确保脚本为 LF 换行、UTF-8 |

## 来源

- Termux Wiki: Remote Access — https://wiki.termux.com/wiki/Remote_Access
- MagiskSU 用法以 `su -h` 输出为准（`-c` 传命令、`-s` 指定 shell、支持以 uid 登录）
