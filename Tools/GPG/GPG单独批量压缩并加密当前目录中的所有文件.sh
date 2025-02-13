#!/bin/bash
# GPG单独批量压缩并加密当前目录中的所有文件
# gpg 加密当前文件夹中的所有文件，不处理 .gpg 和 .sh 文件。在加密文件前先用 xz 压缩。

cd "源文件夹"

# 指定用于加密的 GPG 指纹
ENCRYPTION_FINGERPRINT="指定用于加密的 GPG 指纹"

# 指定加密给哪个指纹
RECIPIENT_FINGERPRINT="指定加密给哪个指纹"

# 目标文件夹
TO_DIR="/var/lib/docker/volumes/nginx_www/_data/default/tongdy.com"

# 遍历当前目录中的所有文件（排除 .gpg 和 .sh 文件）
for file in *; do
    # 跳过目录，跳过 .gpg 和 .sh 文件
    if [[ -d "$file" || "$file" == *.gpg || "$file" == *.sh ]]; then
        continue
    fi

    echo "处理文件: $file"

    # 定义加密后的文件名
    compressed_file="$file.xz"
    encrypted_file="$TO_DIR/$compressed_file.gpg"

    # 先删除已有的加密文件（确保替换）
    if [[ -f "$encrypted_file" ]]; then
        echo "删除已存在的加密文件: $encrypted_file"
        rm -vf "$encrypted_file"
    fi

    # 使用 xz 进行极限压缩（生成 .xz 文件）
    xz -z -e -9 -T 0 -v -k "$file"

    # 加密压缩后的文件
    gpg -v --encrypt --recipient "$RECIPIENT_FINGERPRINT" --local-user "$ENCRYPTION_FINGERPRINT" --output "$encrypted_file" "$compressed_file"

    # 删除临时的 .xz 压缩文件
    rm -vf "$compressed_file"

    echo "加密完成: $encrypted_file"
done

echo "所有文件已加密完成！"
