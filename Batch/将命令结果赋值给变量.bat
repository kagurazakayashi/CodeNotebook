FOR /F %%i IN ('ndatetime.exe') DO ( SET datetime=%%i)
ECHO %datetime%
