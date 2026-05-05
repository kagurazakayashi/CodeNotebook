@echo off
setlocal enabledelayedexpansion

for /f "tokens=*" %%i in ('npm list -g --depth^=0 --parseable') do (
    set "fullPath=%%i"
    for %%a in ("!fullPath!") do set "pkgName=%%~nxa"
    
    if not "!pkgName!"=="npm" if not "!pkgName!"=="node_modules" (
        echo U: !pkgName!
        call npm uninstall -g !pkgName!
    )
)

echo.
pause
