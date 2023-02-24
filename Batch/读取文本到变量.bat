TITLE 批处理脚本读取文件内容赋值给一个变量

ECHO 方法一
FOR /f %%i IN (.\tmp.txt) DO (echo %%i)

ECHO 方法二
SET /P OEM=<tmp.txt
