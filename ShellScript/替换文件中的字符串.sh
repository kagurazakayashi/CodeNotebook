# sed 替换文件中的字符串
echo "aaa aaa aaa" >test.txt

# 将 test.txt 文件中每行第一次出现的aaa用字符串bbb替换，然后将该文件内容输出到标准输出:
sed -e 's/aaa/bbb/' test.txt

# g 使得 sed 对文件中所有符合的字符串都被替换，然后将该文件内容输出到标准输出:
sed -e 's/aaa/bbb/g' test.txt

# 选项 i 使得 sed 修改文件
sed -i 's/aaa/bbb/g' test.txt

# 批量操作当前目录下以 t 开头的文件
sed -i 's/aaa/bbb/g' ./t*
sed -i 's/aaa/bbb/g' `grep aaa -rl --include="t*" ./`

# https://blog.csdn.net/ppdouble/article/details/51139887
