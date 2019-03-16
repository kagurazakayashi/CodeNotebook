str = "string"
# 1.字符串的迭代
for i in 0...(str.length)
    puts str[i]
end
# 2.字符串的迭代
str.each_char{|s|
    puts s
}
# 3.二进制数值
str.each_byte{|s|
    puts s
}
# 4.字符串的迭代"遇到n输出后自动换行"----没测试
str.each_line{|s|
    puts s
}
# https://www.cnblogs.com/ielse/p/10172899.html