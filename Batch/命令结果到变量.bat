@REM bat 将指令执行结果赋给变量 命令结果到变量

for /f "delims=" %%t in ('命令字符串') do set str=%%t
echo %str%

@REM 当命令字符串中含有%时，需要转义:

for /f "delims=" %%t in ('identify -format %%wx%%h demo.jpg') set str=%%t

@REM 如果中间有管道，需要使用转义符  ^ :

for /f "tokens=*" %%i in ('dir /b ^|find /v /c "SC00*" ') do set files_num=%%i

@REM https://blog.csdn.net/m0_50668851/article/details/111677971
