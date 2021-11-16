@REM 查看支持列表
go tool dist list
@REM Windows 下编译 Mac 和 Linux 64位可执行程序

@REM Mac
SET CGO_ENABLED=0
SET GOOS=darwin
SET GOARCH=amd64
go build main.go

@REM Linux
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=amd64
go build main.go

@REM GOOS：目标平台的操作系统（darwin、freebsd、linux、windows）
@REM GOARCH：目标平台的体系架构（386、amd64、arm）
@REM 交叉编译不支持 CGO 所以要禁用它