# iPhone备份

## macOS

- `/Users/yashi/Library/Application Support/MobileSync/Backup`

### 挂载到移动硬盘

- `hdiutil attach "/Volumes/KYSHDD1TX2/iPhone12_20220430.sparseimage" -mountpoint "/Users/yashi/Library/Application Support/MobileSync/Backup"`

## Windows

- `C:\Users\yashi\AppData\Roaming\Apple Computer\MobileSync\Backup`
- `C:\Users\yashi\AppData\Roaming\Apple Computer\MobileSync`
- `C:\Users\yashi\Apple`

### 挂载到 D 盘

- `MKLINK /D "C:\Users\yashi\Apple\MobileSync" "D:\Apple Computer\MobileSync"`
