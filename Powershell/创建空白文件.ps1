# 创建空白文件 1GB
$outputPath = "D:\1GB.img"
$sizeBytes = 1073741824
$fs = [System.IO.File]::Open($outputPath, 'Create')
$fs.SetLength($sizeBytes)
$fs.Close()

# FAT16 单分区最大大小 2GB
# int32 最大值，大约 2GB - 1byte
$outputPath = "D:\2GB.img"
$sizeBytes = [int]::MaxValue
$fs = [System.IO.File]::Open($outputPath, 'Create')
$fs.SetLength($sizeBytes)
$fs.Close()

# 超过 int32 最大值用 long : 2GB 整
$outputPath = "D:\2GB.img"
$sizeGB = 2
$fs = [System.IO.File]::Open($outputPath, 'Create')
$fs.SetLength($sizeGB * 1024L * 1024L * 1024L) # 可以 long
$fs.Close()

# 创建软盘镜像
$outputPath = "C:\MyDisks\Floppy144.vfd"
$fs = [System.IO.File]::Open($outputPath, 'Create')
$fs.SetLength(1474560)  # 1.44MB
$fs.Close()
# imdisk 以软盘挂载 ( -t flp , 不加默认虚拟硬盘)
imdisk -a -t flp -f "C:\MyDisks\Floppy144.vfd" -m A: -o rw
Start-Sleep -Seconds 2
# 格式化成 FAT12 (format 会自动选择 FAT12，因为容量小于 4MB。)
format A: /FS:FAT /Q /Y /V:DISK144

# 取消挂载
imdisk -D -m A:

# 软盘设备通常仅支持以下标准容量：
# | 名称            | 容量（KB） | 容量（MB） | `SetLength` 字节数  | 文件系统（默认） | 备注                         |
# |-----------------|------------|------------|---------------------|------------------|------------------------------|
# | 5.25" DD (360K) | 360        | 0.35       | `368640`            | FAT12            | 40 tracks, 9 sectors/track   |
# | 3.5" DD (720K)  | 720        | 0.70       | `737280`            | FAT12            | 80 tracks, 9 sectors/track   |
# | 5.25" HD (1.2M) | 1200       | 1.17       | `1228800`           | FAT12            | 80 tracks, 15 sectors/track  |
# | 3.5" HD (1.44M) | 1440       | 1.41       | `1474560`           | FAT12            | 80 tracks, 18 sectors/track  |
# | 3.5" ED (2.88M) | 2880       | 2.81       | `2949120`           | FAT12 / FAT16    | 80 tracks, 36 sectors/track  |
# - 所有这些容量都是 512 字节/扇区 × 每面 × 每磁道 × 磁道数 得出的标准值；
# - ImDisk 只支持这些标准容量作为 -t flp 的有效挂载值；
# - 超出这个范围的 .vfd 文件（如 10MB、2GB）不能以“软盘”形式挂载，但可以用硬盘方式挂载。
