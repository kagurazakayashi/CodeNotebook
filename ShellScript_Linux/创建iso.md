# 创建 iso

## 通用

`genisoimage -o "output.iso" -V "DISC" -iso-level 3 -udf -allow-limited-size "."`

不支持单文件大于 4G (虽然可以强制要求)

- `-o output.iso`：指定输出的 ISO 文件名。
- `-R`：启用 Rock Ridge (UNIX)文件扩展，支持 UNIX 权限。
- `-J`：启用 Joliet (微软)扩展，兼容 Windows。
  - 同时使用 -J 和 -R（推荐）这样可以在 Linux 和 Windows 上都支持长文件名。
- `-V "DISC"`：设置 ISO 卷标（Volume Label）。.
- `-iso-level`
- `-udf`：启用 UDF 文件系统，支持大于 4GB 的文件。
- `.`：表示当前目录中的所有文件。

## 现代

`xorriso -as mkisofs -o "/root/logsys_2023.iso" -V "DISC" -iso-level 3 "."`

- `--udf`: 前面两个 -
- 其他和上面一样

## 不同 `-iso-level` 选项的含义

| `-iso-level` | 文件名长度 | 目录深度 | 单个文件最大大小 | 说明 |
|--------------|------------|------------|----------------|--------------------------------|
| **1** (默认) | 8.3 格式 (`NAME.EXT`) | 8 级 | 2GB | 兼容最老的 ISO 9660 标准，不推荐 |
| **2** | 最长 31 个字符 | 8 级 | 2GB | 兼容 DOS/Windows，较老系统可读 |
| **3** | 最长 31 个字符 | 8 级 | **支持 >4GB 单文件** | **推荐**，如果有大文件 |
| **4 及以上** | **最长 255 个字符** | 无限制 | **支持 >4GB 单文件** | 适用于现代 Linux/Windows |

BIOS/UEFI 需要 2

## ISO 9660 标准要求卷标

- 最多 32 个字符
- 全大写，不能包含小写字母
- 不能包含特殊符号（如 -、_、空格）

更复杂的卷标，可以用 UDF 格式
