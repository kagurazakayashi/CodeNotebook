## hdiutil create 命令详解

**hdiutil create: create a disk image (创建磁盘映像)**

**Usage (用法):** `hdiutil create <sizespec> <imagepath>`

* **Size specifiers (大小指定符):**
* `-size < ?? | ??b | ??k | ??m | ??g | ??t | ??p | ??e >` (指定大小：字节/KB/MB/GB/TB/PB/EB)
* `-sectors <count>` (扇区数)
* `-megabytes <count>` (兆字节数)

---

### Image options (映像选项)

* `-library <MKDrivers>` (库文件)
* `-layout <layout> [GPTSPUD or per -fs]` (布局 [默认为 GPTSPUD 或根据文件系统确定])
* **MBRSPUD** - 单个分区 - 主引导记录分区图
* **SPUD** - 单个分区 - Apple分区图
* **UNIVERSAL CD** - CD/DVD
* **NONE** - 无分区图
* **GPTSPUD** - 单个分区 - GUID分区图
* **SPCD** - 单个分区 - CD/DVD
* **UNIVERSAL HD** - 硬盘
* **ISOCD** - 单个分区 - 带ISO数据的CD/DVD

* `-partitionType <partitionType> [per -fs]` (分区类型 [根据文件系统确定])
* `-align <sector alignment> [8 sectors]` (扇区对齐 [默认8扇区])
* `-ov` (覆盖已存在的同名文件)

---

### Filesystem options (文件系统选项)

* `-fs <filesystem>` (文件系统)
* **UDF** - Universal Disk Format (通用磁盘格式)
* **MS-DOS FAT12** - MS-DOS (FAT12)
* **MS-DOS** - MS-DOS (FAT)
* **MS-DOS FAT16** - MS-DOS (FAT16)
* **MS-DOS FAT32** - MS-DOS (FAT32)
* **HFS+** - Mac OS Extended (Mac OS 扩展格式)
* **Case-sensitive HFS+** - Mac OS Extended (Case-sensitive) (Mac OS 扩展格式，区分大小写)
* **Case-sensitive Journaled HFS+** - Mac OS Extended (Case-sensitive, Journaled) (Mac OS 扩展格式，区分大小写，日志式)
* **Journaled HFS+** - Mac OS Extended (Journaled) (Mac OS 扩展格式，日志式)
* **ExFAT** - ExFAT
* **Case-sensitive APFS** - APFS (Case-sensitive) (APFS，区分大小写)
* **APFS** - APFS

* `-volname <volumename> ["untitled"]` (卷名 [默认为 "untitled"])
* `-stretch < ?? | ?b | ??k | ??m | ??g | ??t | ??p | ??e > (HFS+)` (可拉伸大小 [仅限HFS+])

---

### New Blank Image options (新建空白映像选项)

* `-type <image type> [UDIF]` (映像类型 [默认为 UDIF])
* **SPARSEBUNDLE** - 稀疏捆绑磁盘映像
* **SPARSE** - 稀疏磁盘映像
* **UDIF** - 读/写磁盘映像
* **UDTO** - DVD/CD主映像

* `-[no]spotlight` - **do (not) create a Spotlight™ index** ( (不) 创建 Spotlight™ 索引)

---

### Image from Folder options (从文件夹创建映像选项)

* `-srcfolder <source folder>` (源文件夹)
* `-[no]spotlight` - **do (not) create a Spotlight™ index** ( (不) 创建 Spotlight™ 索引)
* `-[no]anyowners` - **do (not) attempt to preserve owners** ( (不) 尝试保留所有者权限)
* `-[no]skipunreadable` - **do (not) skip unreadable objects [no]** ( (不) 跳过不可读对象 [默认不跳过])
* `-[no]atomic` - **do (not) copy to temp location and then rename [yes]** ( (不) 先拷贝到临时位置再重命名 [默认是])
* `-srcowners on|off|any|auto [auto]` (源所有者设置)
* **on**: enable owners on source (在源上启用所有者)
* **off**: disable owners on source (在源上禁用所有者)
* **any**: leave owners state on source unchanged (保持源上的所有者状态不变)
* **auto**: enable owners if source is a volume (如果源是一个卷，则启用所有者)

* `-format <image type> [UDZO]` (格式/映像类型 [默认为 UDZO])
* **UDRO** - 只读
* **UDCO** - 已压缩(ADC)
* **UDZO** - 压缩
* **UDBZ** - **compressed (bzip2), deprecated** (压缩 (bzip2)，已弃用)
* **ULFO** - 已压缩(lzfse)
* **ULMO** - 已压缩(lzma)
* **UFBI** - 整个设备
* **IPOD** - iPod映像
* **UDSB** - sparsebundle (稀疏捆绑)
* **UDSP** - 稀疏
* **UDRW** - 读/写
* **UDTO** - DVD/CD主映像
* **UNIV** - 混合映像(HFS+/ISO/UDF)

---

### Image from Device options (从设备创建映像选项)

> **Note: Filesystem options (-fs, -volname, -stretch) ignored with -srcdevice** (注：使用 -srcdevice 时，文件系统选项将被忽略)

* `-srcdevice <source dev node, e.g. disk1, disk2s1>` (源设备节点，例如 disk1)
* `-format <image type> [UDZO]` (格式/映像类型)
* (同上，包括 UDRO, UDCO, UDZO, UDBZ, ULFO, ULMO, UFBI, IPOD, UDSB, UDSP, UDRW, UDTO)


* `-segmentSize < ?? | ??b | ??k | ??m | ??g | ??t | ??p | ??e > (deprecated)` (分段大小 [已弃用])
* (sectors, bytes, KiB, MiB, GiB, TiB, PiB, EiB)

---

### Attach options (挂载选项)

* `-attach` - **attach image after creation** (创建后自动挂载映像)

---

### Common options (通用选项)

* `-encryption <crypto method>` (加密方式)
* **AES-128** - 128位AES加密
* **AES-256** - 256位AES加密（建议）


* `-stdinpass` (从标准输入读取密码)
* `-agentpass` (使用密码代理/密钥链获取密码)
* `-certificate <path-to-cert-file>` (证书文件路径)
* `-pubkey <public-key-hash>[,pkh2,...]` (公钥哈希)
* `-imagekey <key>=<value>` (映像键值对参数)
* `-tgtimagekey <key>=<value>` (目标映像键值对参数)
* `-plist` (以 XML plist 格式输出结果)
* `-puppetstrings` (输出傀儡字符串/便于脚本解析)
* `-verbose` (显示详细运行信息)
* `-debug` (显示调试信息)
* `-quiet` (静默模式，不显示输出)
