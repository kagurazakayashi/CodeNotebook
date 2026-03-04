@REM 除字符串的前 9 个字符
setlocal enabledelayedexpansion 
@REM ↑ enabledelayedexpansion 处理 `!`

:: 示例字符串
set string=abcdefghij123456

:: 获取从第10个字符开始到最后的子字符串
set result=!string:~9!

echo 原字符串: %string%
echo 去除前9个字符后的字符串: %result%
pause
