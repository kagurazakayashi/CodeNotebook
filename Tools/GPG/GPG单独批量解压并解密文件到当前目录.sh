#!/bin/bash
# GPG单独批量解压并解密文件到当前目录
# 例如我拍的 FILES 配置是
# FILES=( ["file1.xz.gpg"]="hello.xz.gpg" )
# 那么它应该从 http://192.168.1.2/file1.xz.gpg 下载到 hello.xz.gpg 中。
# 在解密后，文件名应该是 hello.xz 。
# 在解压缩后，文件名应该是 hello 。

cd "源文件夹"

# 指定用于解密的 GPG 指纹
GPG_FINGERPRINT="指定用于解密的 GPG 指纹"

# 定义文件映射列表（远程文件 -> 本地保存文件）
declare -A FILES
FILES=(
    ["服务器文件名1.xz.gpg"]="本地文件名1.xz.gpg"
    ["服务器文件名2.xz.gpg"]="本地文件名2.xz.gpg"
)

# 服务器地址（/结尾）
BASE_URL="http://192.168.1.2/"

# 下载、解密并解压缩文件
for REMOTE_FILE in "${!FILES[@]}"; do
    LOCAL_FILE="${FILES[$REMOTE_FILE]}"
    echo "正在下载: $REMOTE_FILE -> $LOCAL_FILE"
    
    # 解析文件名和扩展名
    DECRYPTED_FILE="${LOCAL_FILE%.gpg}"
    UNCOMPRESSED_FILE="${DECRYPTED_FILE%.xz}"
    
    # 处理相关文件删除
    [ -f "$LOCAL_FILE" ] && rm -vf "$LOCAL_FILE"
    [ -f "$DECRYPTED_FILE" ] && rm -vf "$DECRYPTED_FILE"
    [ -f "$UNCOMPRESSED_FILE" ] && rm -vf "$UNCOMPRESSED_FILE"
    
    curl -v -o "$LOCAL_FILE" -L "$BASE_URL$REMOTE_FILE"
    if [ $? -eq 0 ]; then
        echo "$REMOTE_FILE 下载成功，保存为 $LOCAL_FILE。"
        
        # 解密文件
        gpg -v --recipient "$GPG_FINGERPRINT" --output "$DECRYPTED_FILE" --decrypt "$LOCAL_FILE"
        if [ $? -eq 0 ]; then
            echo "$LOCAL_FILE 解密成功，生成 $DECRYPTED_FILE。"
            rm -vf "$LOCAL_FILE"
            
            # 解压缩文件
            xz -d -v "$DECRYPTED_FILE"
            if [ $? -eq 0 ]; then
                echo "$DECRYPTED_FILE 解压缩成功，最终文件为 $UNCOMPRESSED_FILE。"
                rm -vf "$DECRYPTED_FILE"
            else
                echo "$DECRYPTED_FILE 解压缩失败。"
                rm -vf "$DECRYPTED_FILE"
            fi
        else
            echo "$LOCAL_FILE 解密失败。"
            rm -vf "$DECRYPTED_FILE"
        fi
    else
        echo "下载 $REMOTE_FILE 失败。"
    fi
done

# 文件替换后执行其他重载命令...
