@REM BAT脚本判断文件是否存在

@echo off
@title copy sth to current filepath
mode con lines=5 cols=40

SET SourceFile=123.txt
SET GenFile1=456.txt

if exist %SourceFile% (
    if not exist %GenFile1% (
        copy %SourceFile% %GenFile1%
    ) else (
        echo %GenFile1% is exist!
    )
) else (
    echo %SourceFile% is not exist!
)

echo Success
pause

@REM https://blog.csdn.net/u011958166/article/details/81479944