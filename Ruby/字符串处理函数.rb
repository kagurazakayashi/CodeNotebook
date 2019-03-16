# 返回字符串的长度
str.length #=> integer

# 判断字符串中是否包含另一个串
str.include? other_str #=> true or false
"hello".include? "lo"   #=> true
"hello".include? "ol"   #=> false
"hello".include? ?h     #=> true

# 字符串插入
str.insert(index, other_str) #=> str
"abcd".insert(0, 'X')    #=> "Xabcd"
"abcd".insert(3, 'X')    #=> "abcXd"
"abcd".insert(4, 'X')    #=> "abcdX"
"abcd".insert(-3, 'X')
-3, 'X')   #=> "abXcd"
"abcd".insert(-1, 'X')   #=> "abcdX"

# 字符串分隔,默认分隔符为空格
str.split(pattern=$;, [limit]) #=> anArray
" now's the time".split        #=> ["now's", "the", "time"]
"1, 2.34,56, 7".split(%r{,\s*}) #=> ["1", "2.34", "56", "7"]
"hello".split(//)               #=> ["h", "e", "l", "l", "o"]
"hello".split(//, 3)            #=> ["h", "e", "llo"]
"hi mom".split(%r{\s*})         #=> ["h", "i", "m", "o", "m"]
"mellow yellow".split("ello")   #=> ["m", "w y", "w"]
"1,2,,3,4,,".split(',')         #=> ["1", "2", "", "3", "4"]
"1,2,,3,4,,".split(',', 4)      #=> ["1", "2", "", "3,4,,"]

# 字符串替换1
str.gsub(pattern, replacement) #=> new_str
str.gsub(pattern) {|match| block } #=> new_str
"hello".gsub(/[aeiou]/, '*')              #=> "h*ll*"     #将元音替换成*号
"hello".gsub(/([aeiou])/, '<\1>')         #=> "h<e>ll<o>"   #将元音加上尖括号,\1表示保留原有字符???
"hello".gsub(/./) {|s| s[0].to_s + ' '}   #=> "104 101 108 108 111 "
# 字符串替换2
str.replace(other_str) #=> str
s = "hello"         #=> "hello"
s.replace "world"   #=> "world"

# 字符串删除
str.delete([other_str]+) #=> new_str
"hello".delete "l","lo"        #=> "heo"
"hello".delete "lo"            #=> "he"
"hello".delete "aeiou", "^e"   #=> "hell"
"hello".delete "ej-m"          #=> "ho"

# 去掉前和后的空格
str.lstrip #=> new_str
" hello ".lstrip   #=> "hello "
"hello".lstrip       #=> "hello"

# 字符串匹配
str.match(pattern) #=> matchdata or nil

# 字符串反转
str.reverse #=> new_str
"stressed".reverse   #=> "desserts"

# 去掉重复的字符
str.squeeze([other_str]*) #=> new_str
"yellow moon".squeeze                  #=> "yelow mon" #默认去掉串中所有重复的字符
" now   is the".squeeze(" ")         #=> " now is the" #去掉串中重复的空格
"putters shoot balls".squeeze("m-z")   #=> "puters shot balls" #去掉指定范围内的重复字符

# 转化成数字
str.to_i #=> str
"12345".to_i             #=> 12345

# chomp和chop的区别:
# chomp:去掉字符串末尾的\n或\r
# chop:去掉字符串末尾的最后一个字符,不管是\n\r还是普通字符
"hello".chomp            #=> "hello"
"hello\n".chomp          #=> "hello"
"hello\r\n".chomp        #=> "hello"
"hello\n\r".chomp        #=> "hello\n"
"hello\r".chomp          #=> "hello"
"hello".chomp("llo")     #=> "he"

"string\r\n".chop   #=> "string"
"string\n\r".chop   #=> "string\n"
"string\n".chop     #=> "string"
"string".chop       #=> "strin"

# http://blog.163.com/ma95221@126/blog/static/2482210220100159515220/ 