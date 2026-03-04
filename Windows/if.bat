@REM bat 脚本里面 if else if的写法
@REM bat if


@REM 第一种写法：最简单，就是写一行。
rem 写一行比较简洁，缺点是每一种判断内不方便写多条语句
set varA=B
if "%varA%"=="A" (echo %varA% is A) else if "%varA%"=="B" (echo %varA% is B) else (echo %varA% is C)


@REM 第二种写法：可读性好的语法是分行写
rem 在这种写法可读性好，也能执行多语句，但兼容性不太好
set varA=B
if "%varA%"=="A" (
    echo %varA% is A
    echo AAA
) else if "%varA%"=="B" (
    echo %varA% is B
    echo BBB
) else (
    echo %varA% is C
    echo CCC
)


@REM 第三种写法：可读性好的语法是分行写的加强版
rem 可读性好，兼容性好

setlocal EnableDelayedExpansion
set option=2
set sum=-1

if %option% == 3 ( 
  echo three 
  set /a sum=%option%*%option%*%option%
) ^
else if %option% == 2 ( 
  echo two 
  set /a sum=2*%option%
) ^
else if %option% == 1 ( 
  echo one 
  set /a sum=%option% 
) ^
else ( 
  echo zero 
  set /a sum=0 
)

echo sum = !sum!