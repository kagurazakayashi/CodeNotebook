# sh大小写转换

# 使用 declare 命令转换大小写

declare -l lower="Turn ON"  # -l 小写 赋值到变量 lower
echo $lower
# turn on

declare -u upper="happy new year"  # -u 大写 赋值到变量 upper
echo $upper
# HAPPY NEW YEAR


# 使用 tr 替换命令转换大小写

# tr A-Z a-z 命令把大写字母 A 到大写字母 Z 之间的所有字符都转换为对应的小写字母。
echo "Come ON" | tr A-Z a-z
come on

# tr A-Z 5 命令则是把输入的所有大写字母都转为数字 5。
echo "Come ON" | tr A-Z 5
5ome 55

# tr a-z A-Z 命令把输入的所有小写字母转换为对应的大写字母。
echo "happy new year" | tr a-z A-Z
HAPPY NEW YEAR

# 也可以用 [:lower:] 来指定所有小写字母，用 [:upper:] 来指定所有大写字母。
echo "happy new year" | tr [:lower:] [:upper:]
HAPPY NEW YEAR

# tr hn HN 命令把小写字母 h 转换为大写字母 H，把小写字母 n 转换为大写字母 N。
echo "happy new year" | tr hn HN
Happy New year

# 当 SET1 参数提供的字符个数大于 SET2 参数提供的字符个数时，会把 SET1 多出来的字符都转换为 SET2 的最后一个字符。tr hnwr HN 命令演示了这一点，小写的 w 和 r 都转换为第二个参数最后的大写 N。
echo "happy new year" | tr hnwr HN
Happy NeN yeaN


# 用 ${parameter^^} 表达式转换为大写

value="Come ON"
echo ${value^^}
# COME ON
# 不会修改 value 变量自身的值。
echo $value
# Come ON

# 用 ${parameter,,} 表达式转换为小写
value="Come ON"
echo ${value,,}
# come on

# https://blog.csdn.net/weixin_39666782/article/details/111698041
