echo 对当前文件夹及其子文件夹中的特定扩展名的所有文件进行操作 遍历文件处理

#!/bin/bash
find . -type f | while read -r file; do
    # 跳过脚本文件自身
    if [ "$(realpath "$file")" != "$script_path" ]; then
        # 获取文件目录和文件名
        file_dir="$(dirname "$file")"
        file_name="$(basename "$file")"
        file_base="${file_name%.*}"

        # 切换到文件所在目录并执行命令
        (cd "$file_dir" && \
        echo "当前目录: $(pwd)" && \
        echo "当前文件: $file_name 无扩展名: $file_base")
    fi
done
