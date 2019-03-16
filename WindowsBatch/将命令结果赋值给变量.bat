for /F %%i in ('ndatetime.exe') do ( set datetime=%%i)
echo %datetime%