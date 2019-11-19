# 整数比较
# 等于
if [ "$a" -eq "$b" ] then fi
# 不等于
if [ "$a" -ne "$b" ] then fi
# 大于
if [ "$a" -gt "$b" ] then fi
# 大于等于
if [ "$a" -ge "$b" ] then fi
# 小于
if [ "$a" -lt "$b" ] then fi
# 小于等于
if [ "$a" -le "$b" ] then fi
# 小于(需要双括号)
(("$a" < "$b"))
# 小于等于(需要双括号)
(("$a" <= "$b"))
# 大于(需要双括号)
(("$a" > "$b"))
# 大于等于(需要双括号)
(("$a" >= "$b"))

# 字符串比较( = == 等价)
if [ "$a" = "$b" ] then fi
if [ "$a" == "$b" ] then fi
# 比较两个字符串是否相等
if [ "$test"x = "test"x ]; then fi
# 1 使用单个等号
# 2 注意到等号两边各有一个空格：这是unix shell的要求
# 3 注意到"$test"x最后的x，这是特意安排的，因为当$test为空的时候，上面的表达式就变成了x = testx，显然是不相等的。而如果没有这个x，表达式就会报错：[: =: unary operator expected

# ==的功能在[[]]和[]中的行为是不同的
[[ $a == z* ]]   # 如果$a以"z"开头(模式匹配)那么将为true 
[[ $a == "z*" ]] # 如果$a等于z*(字符匹配),那么结果为true 
[ $a == z* ]     # File globbing 和word splitting将会发生 
[ "$a" == "z*" ] # 如果$a等于z*(字符匹配),那么结果为true

# https://blog.csdn.net/yf210yf/article/details/9207147