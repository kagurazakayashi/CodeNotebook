@echo off
setlocal enabledelayedexpansion
TITLE 解压IntelRST快速存储驱动
for %%f in (SetupRST_*.exe) do (
    set "filename=%%~nf"
    echo %%f - !filename! ...
    %%f -extractdrivers !filename!
    echo.
)
echo OK
pause

@REM 下载: https://www.intel.cn/content/www/cn/zh/search.html?ws=text#q=%E5%BF%AB%E9%80%9F%E5%AD%98%E5%82%A8%E6%8A%80%E6%9C%AF%20%E9%A9%B1%E5%8A%A8%E7%A8%8B%E5%BA%8F%E5%AE%89%E8%A3%85%E8%BD%AF%E4%BB%B6&sort=relevancy
