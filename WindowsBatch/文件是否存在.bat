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
ping -n 3 127.0.0.1 > nul