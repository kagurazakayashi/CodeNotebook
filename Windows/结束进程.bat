@REM 结束进程

@REM 任务名
TASKKILL /F /IM "cmd.exe" /T
WMIC PROCESS where name="cmd.exe" call terminate

@REM PID
TASKKILL /F /PID 33128 /T
WMIC PROCESS where ProcessId=33128 call terminate

@REM 查询父进程
WMIC PROCESS where ProcessId=33128 get ParentProcessId
WMIC PROCESS where name="cmd.exe" get ParentProcessId
