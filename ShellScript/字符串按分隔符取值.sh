# 字符串按分隔符取值  shell 字符串分割

# | cut -d " " -f 1   空格分割取第一个
echo "aaa bbb ccc" | cut -d " " -f 1
# aaa

echo "aaa bbb ccc" | cut -d " " -f 2
# bbb

echo "aaa,bbb,ccc" | cut -d "," -f 3
# ccc

# 空格分割取第一个和第三个
echo "aaa bbb ccc" | cut -d " " -f 1,3
# aaa ccc

# 第二个之后所有
echo "aaa bbb ccc" | cut -d " " -f 2-
# bbb ccc

# 第一个到第三个
echo "aaa bbb ccc" | cut -d " " -f 1-3
# aaa bbb ccc

# 第一个到第二个 和第三个
echo "aaa bbb ccc" | cut -d " " -f 1-2,3
# aaa bbb ccc

# 只显示 /etc/passwd 的用户和 shell
cat /etc/passwd | cut -d ':' -f 1,7
# nobody:/usr/bin/false
# root:/bin/sh
