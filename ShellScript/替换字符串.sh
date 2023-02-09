#sed替换字符串

# 一、基本的替换
# 命令格式1：sed 's/原字符串/新字符串/' 文件，没有“g”表示只替换第一个匹配到的字符串
# 命令格式2：sed 's/原字符串/新字符串/g' 文件
# sed 's/aaa/bbb/' 1.txt
echo aaaaaa | sed 's/aaa/bbb/' # bbbaaa
echo aaaaaa | sed 's/aaa/bbb/g' # bbbbbb
echo 111222aaa | sed 's/[0-9]/b/g' # bbbbbbaaa

# 二、替换某行内容
# 命令格式1：sed '行号c 新字符串' 文件
# 命令格式2：sed '起始行号，终止行号c 新字符串' 文件
echo aaaaaa | sed '1c bbb' # bbb
echo aaaaaa | sed '1,5c bbb' # 替换第1到5行

# 三、多条件替换
# 命令格式：sed -e 命令1 -e 命令2 -e 命令3

# 四、保存替换结果到文件中
# 命令格式：sed -i 命令
# 上述这些命令都只是将替换结果打印到屏幕上，如果想保存结果到文件中，就需要加上“-i”参数。
sed -i 's/aaa/bbb' 1.txt