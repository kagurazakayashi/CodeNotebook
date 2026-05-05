#!/bin/bash

# 获取所有全局安装包的名称，排除 npm 本身和根目录
packages=$(npm list -g --depth=0 --parseable | awk -F/ '{print $NF}' | grep -vE "^npm$|^node_modules$")

if [ -z "$packages" ]; then
    echo "没有发现可卸载的全局 npm 包。"
    exit 0
fi

echo "准备卸载以下包:"
echo "$packages"
echo "--------------------------"

for pkg in $packages; do
    echo "正在卸载: $pkg ..."
    # 如果遇到权限问题，可以手动在运行脚本时加 sudo，或者在这里加 sudo
    npm uninstall -g "$pkg"
done

echo "清理完成！"
