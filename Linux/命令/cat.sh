# cat  concatenate (v.连接)
# 连接一个或多个文件，输出到指定文件。
# cat [文件列表] > [输出文件]

# 把 file1.txt file2.txt 连接在一起，保存在 file3.txt 当中：
cat file1.txt file2.txt > file3.txt

# 没有指定目的文件，输出到标准输出设备。
# 仅输出这两个文件的内容：
cat file1.txt file2.txt

# 没有指定源文件，从标准输入设备输入。
cat > file4.txt
# 此时会进入输入状态，按 Ctrl+D 输入文件结束符结束输入。