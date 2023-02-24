TITLE 批处理if比较字符串
ECHO 使用equ比较字符串
set str1=hello
set str2=word
 
if %str1% equ %str2% goto equal
echo %str1% 不等于 %str2%
goto end
 
:equal
echo %str1% 等于 %str2%
 
:end
pause


@REM 实例：运行批处理提示用户输入命令，根据不同的命令打印不同的提示。如下：

@echo off
rem 字符串比较
echo add    —— 添加数据
echo update —— 更新数据
echo 输入命令：
set /p command=
 
if "%command%" equ "add" goto add
if "%command%" equ "update" goto update
echo 暂不支持 %command% 命令
goto end
 
:add
echo 添加数据成功
goto end
 
:update
echo 更新数据成功
 
:end
echo finished
pause

@REM https://www.hxstrive.com/article/799.htm