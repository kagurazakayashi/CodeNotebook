#!/bin/bash
# 字符串删除后几个字符 字符串中删除最后n个字符


echo "hello world" | rev | cut -c5- | rev
#     hello w
#           54321   


v="some string.rtf"
v2=${v::-4}
echo "$v --> $v2"
# some string.rtf --> some string


# https://www.php1.cn/detail/RuHeCong_Bash_Zh_db8a133a.html
