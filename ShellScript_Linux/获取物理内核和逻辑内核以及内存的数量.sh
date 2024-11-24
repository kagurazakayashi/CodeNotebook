#!/bin/bash
# core.sh

# 获取物理 CPU 插槽数
physical_sockets=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)

# 获取每个插槽核心数
cores_per_socket=$(grep "core id" /proc/cpuinfo | sort -u | wc -l)

# 计算物理内核数量
physical_cores=$((physical_sockets * cores_per_socket))

# 获取逻辑内核数量
logical_cores=$(nproc)

# 获取物理内存和虚拟内存大小
# 支持中文系统（内存/交换）和英文系统（Mem/Swap）
memory_info=$(free -g)

# 提取物理内存大小
physical_memory=$(echo "$memory_info" | grep -E "^(内存|Mem:)" | awk '{print $2}')

# 提取虚拟内存大小（Swap）
swap_memory=$(echo "$memory_info" | grep -E "^(交换|Swap:)" | awk '{print $2}')

# 如果物理内存为空，提示用户检查环境
if [ -z "$physical_memory" ]; then
    physical_memory="未知 (请检查系统语言或free命令输出)"
fi

# 如果虚拟内存为空，提示用户检查环境
if [ -z "$swap_memory" ]; then
    swap_memory="未知 (请检查系统语言或free命令输出)"
fi

# 输出结果
echo "物理内核: $physical_cores"
echo "逻辑内核: $logical_cores"
echo "内存大小: ${physical_memory} GB"
echo "分页大小: ${swap_memory} GB"
