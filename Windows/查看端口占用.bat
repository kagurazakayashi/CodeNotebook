@REM 查看端口的占用情况:
netstat -ano | findstr :80
@REM -a: 显示所有连接和监听端口。
@REM -n: 显示数字格式的地址和端口号。
@REM -o: 显示关联的 PID（进程 ID）。
@REM TCP    0.0.0.0:3399             0.0.0.0:0              LISTENING       1234 ← PID

@REM 查看 PID（进程 ID）来确定哪个程序占用了该端口:
tasklist /fi "PID eq 1234"

@REM PowerShell
Get-NetTCPConnection -LocalPort 3399
