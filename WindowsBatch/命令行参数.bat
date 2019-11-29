REM 批处理文件本身
echo %0
REM 第一个参数
echo %1
REM 第二个参数
echo %2
REM 从第一个参数开始的所有参数
echo %*

REM 批参数(%n)的替代已被增强语法
REM 删除引号(\")，扩充 %1
echo %~1
REM 将 %1 扩充到一个完全合格的路径名
echo %~f1
REM 仅将 %1 扩充到一个驱动器号
echo %~d1
REM 仅将 %1 扩充到一个路径
echo %~p1
REM 仅将 %1 扩充到一个文件名
echo %~n1
REM 仅将 %1 扩充到一个文件扩展名
echo %~x1
REM 扩充的路径指含有短名
echo %~s1
REM 将 %1 扩充到文件属性
echo %~a1
REM 将 %1 扩充到文件的日期/时间
echo %~t1
REM 将 %1 扩充到文件的大小
echo %~z1
REM 查找列在 PATH 环境变量的目录，并将 %1扩充到找到的第一个完全合格的名称。如果环境变量名未被定义，或者没有找到文件，此组合键会扩充到空字符串
echo %~$PATH : 1

REM 可以组合修定符来取得多重结果
REM 只将 %1 扩展到驱动器号和路径
echo %~dp1
REM 只将 %1 扩展到文件名和扩展名
echo %~nx1
REM 在列在 PATH 环境变量中的目录里查找 %1，并扩展到找到的第一个文件的驱动器号和路径。
echo %~dp$PATH:1 - 
REM 将 %1 扩展到类似 DIR 的输出行。
echo %~ftza1

REM SHIFT : 移位
shift [/n]
REM n 的取值是[0,8],且为整数；[/n]为可选参数，当赋予n某个值时，就意味着命令从第n个参数开始移位；当n赋予的值为0,1或不带有任何命令选项的 shift时，则表示批处理文件中替换参数左移一个位置，后面的替换参数陆续填补上去，直至可替换参数为空。

REM https://blog.csdn.net/yunnying/article/details/12010779