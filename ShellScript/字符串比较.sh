#!/bin/sh

#测试各种字符串比较操作。
#shell中对变量的值添加单引号，爽引号和不添加的区别：对类型来说是无关的，即不是添加了引号就变成了字符串类型，
#单引号不对相关量进行替换，如不对$符号解释成变量引用，从而用对应变量的值替代，双引号则会进行替代

A="$1"
B="$2"

echo "输入的原始值：A=$A,B=$B"

#判断字符串是否相等
if [ "$A" = "$B" ];then
echo "[ = ]"
fi

#判断字符串是否相等，与上面的=等价
if [ "$A" == "$B" ];then
echo "[ == ]"
fi

#注意:==的功能在[[]]和[]中的行为是不同的，如下

#如果$a以”a”开头(模式匹配)那么将为true
if [[ "$A" == a* ]];then
echo "[[ ==a* ]]"
fi

#如果$a等于a*(字符匹配),那么结果为true
if [[ "$A" == "a*" ]];then
echo "==/"a*/""
fi


#File globbing(通配) 和word splitting将会发生, 此时的a*会自动匹配到对应的当前以a开头的文件
#如在当前的目录中有个文件：add_crontab.sh,则下面会输出ok
#if [ "add_crontab.sh" == a* ];then
#echo "ok"
#fi
if [ "$A" == a* ];then
echo "[ ==a* ]"
fi

#如果$a等于a*(字符匹配),那么结果为true
if [ "$A" == "a*" ];then
echo "==/"a*/""
fi

#字符串不相等
if [ "$A" != "$B" ];then
echo "[ != ]"
fi

#字符串不相等
if [[ "$A" != "$B" ]];then
echo "[[ != ]]"
fi

#字符串不为空，长度不为0
if [ -n "$A" ];then
echo "[ -n ]"
fi

#字符串为空.就是长度为0.
if [ -z "$A" ];then
echo "[ -z ]"
fi

#需要转义<，否则认为是一个重定向符号
if [ $A /< $B ];then
echo "[ < ]"
fi

if [[ $A < $B ]];then
echo "[[ < ]]"
fi

#需要转义>，否则认为是一个重定向符号
if [ $A /> $B ];then
echo "[ > ]"
fi

if [[ $A > $B ]];then
echo "[[ > ]]"
fi

# https://blog.csdn.net/Mr_LeeHY/article/details/76383091