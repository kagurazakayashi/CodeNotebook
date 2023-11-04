# 使用 rclone 命令行管理 Cloudflare R2 对象存储

# 安装
curl https://rclone.org/install.sh | sudo bash

# 确保您正在运行 rclone v1.59 或更高版本
rclone version

# 配置文件在哪
rclone config file
# Configuration file doesn't exist, but rclone will use this path:
# C:\Users\yashi\AppData\Roaming\rclone\rclone.conf
# 创建配置文件
rclone config

# 配置文件内容，第一行是命令中用的名称：
# [r2]
# type = s3
# provider = Cloudflare
# access_key_id = ***
# secret_access_key = ***
# endpoint = https://<accountid>.r2.cloudflarestorage.com
# acl = private
# 如果您使用具有对象级权限的令牌，则需要将 no_check_bucket = true 添加到配置中以避免错误。

# 列出所有存储桶（ : 根需要管理员权限）
rclone lsd r2:
#   -1 2023-11-04 12:32:06        -1 aaa
#   -1 2023-11-04 20:38:42        -1 test  <- r2:test
#   -1 2023-10-31 21:31:59        -1 bbb

# 创建新桶（需要管理员权限）
rclone mkdir r2:test

# 删除空桶（需要管理员权限）
rclone rmdir r2:test

# 本地文件夹：
# pic
#  │  1.png
#  │  2.png
#  │  3.png
#  │
#  └─ pic2
#          1.png
#          2.png
#          3.png

# 将文件从源复制到目标，跳过相同的文件。
rclone copy "1.png" r2:test

# 列出该桶所有内部目录文件
# （r2: 根会列出所有桶所有文件，巨大输出，需要管理员权限）
rclone tree r2:test
# /
# └── 1.png

# 上传本地目录，跳过相同的文件。
rclone copy "pic" r2:test -v
# -v 显示进度

# 列出该桶所有内部目录文件
rclone tree r2:test
# /
# ├── 1.png
# ├── 2.png
# ├── 3.png
# └── pic2
#     ├── 1.png
#     ├── 2.png
#     └── 3.png
# 1 directories, 6 files

# 列出对象列表:
rclone ls r2:test
#   1371367 1.png
#   1093888 2.png
#   1467651 3.png
#   1371367 pic2/1.png
#   1093888 pic2/2.png
#   1467651 pic2/3.png

# 计算对象存储总量:
rclone size r2:test
# Total objects: 6 (6)
# Total size: 7.501 MiB (7865812 Byte)

# 下载对象到本地（默认覆盖）
rclone copy "r2:test/1.png" .

# 删除文件
rclone delete "r2:test/1.png"

# 列出该桶所有内部目录文件
rclone tree r2:test
# /
# ├── 2.png
# ├── 3.png
# └── pic2
#     ├── 1.png
#     ├── 2.png
#     └── 3.png

# 删除目录
rclone delete "r2:test/pic"

# 列出该桶所有内部目录文件
rclone tree r2:test
# /
# ├── 2.png
# └── 3.png

# 将输入定向到桶中文件（可配合管道使用）
echo "Hello, World!" | rclone rcat "r2:test/test.txt"

# 直接输出桶中文件（可配合管道使用）
rclone cat "r2:test/test.txt"
# "Hello, World!"

# 输出到xz压缩包
rclone cat "r2:test/test.txt" | xz -z -e -9 -T 0 -v -c >"test.txt.xz"

# 新建目录
rclone mkdir "r2:test/dir1"

# rmdir 删除路径中的空目录。
# rmdirs 删除路径包括子文件夹的空目录。
rclone rmdirs "r2:test/dir1"

# 清空存储桶
rclone delete r2:test

# 更多
rclone --help
# Available Commands:
#   about       从远程获取配额信息。
#   authorize   远程授权。
#   backend     运行特定于后端的命令。
#   bisync      在两条路径之间执行双向同步。
#   cat         连接任何文件并将它们发送到标准输出。
#   check       检查源和目标中的文件是否匹配。
#   checksum    根据 SUM 文件检查源中的文件。
#   cleanup     如果可能的话，清理遥控器。
#   completion  给定 shell 的输出完成脚本。
#   config      进入交互式配置会话。
#   copy        将文件从源复制到目标，跳过相同的文件。
#   copyto      将文件从源复制到目标，跳过相同的文件。
#   copyurl     将 url 内容复制到 dest。
#   cryptcheck  Cryptcheck 检查加密远程的完整性。
#   cryptdecode Cryptdecode 返回未加密的文件名。
#   dedupe      交互式查找重复的文件名并删除/重命名它们。
#   delete      删除路径中的文件。
#   deletefile  从远程删除单个文件。
#   gendocs     将 rclone 的 markdown 文档输出到提供的目录。
#   hashsum     为路径中的所有对象生成哈希和文件。
#   help        显示 rclone 命令、标志和后端的帮助。
#   link        生成文件/文件夹的公共链接。
#   listremotes 列出配置文件中并在环境变量中定义的所有遥控器。
#   ls          列出路径中的对象及其大小和路径。
#   lsd         列出路径中的所有目录/容器/存储桶。
#   lsf         列出remote:path 中的目录和对象，格式为解析。
#   lsjson      以 JSON 格式列出路径中的目录和对象。
#   lsl         列出路径中的对象以及修改时间、大小和路径。
#   md5sum      为路径中的所有对象生成 md5sum 文件。
#   mkdir       如果路径尚不存在，请创建该路径。
#   mount       将远程作为文件系统安装在安装点上。
#   move        将文件从源移动到目标。
#   moveto      将文件或目录从源移动到目标。
#   ncdu        探索具有基于文本的用户界面的遥控器。
#   obscure     在 rclone 配置文件中使用的模糊密码。
#   purge       删除路径及其所有内容。
#   rc          针对正在运行的 rclone 运行命令。
#   rcat        将标准输入复制到远程文件。
#   rcd         运行 rclone 仅侦听远程控制命令。
#   rmdir       删除路径中的空目录。
#   rmdirs      删除路径下的空目录。
#   selfupdate  更新 rclone 二进制文件。
#   serve       通过协议为远程提供服务。
#   settier     更改远程对象的存储类别/层。
#   sha1sum     为路径中的所有对象生成 sha1sum 文件。
#   size        打印remote:path 中对象的总大小和数量。
#   sync        使源和目标相同，仅修改目标。
#   test        运行测试命令
#   touch       创建新文件或更改文件修改时间。
#   tree        像时尚一样在树中列出遥控器的内容。
#   version     显示版本号。