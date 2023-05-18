@REM EXE程序添加图标和详细信息(版本号,版权,公司信息等)
go get github.com/josephspurrier/goversioninfo/cmd/goversioninfo


@REM 将刚下载下来的 GoVersionInfo 的目录 resource 拷贝到我们的工程目录(main.go所在目录).并把目录中的 versioninfo.json 拷贝到与 main.go 同目录。
MKDIR resource
COPY %GOPATH%\pkg\mod\github.com\josephspurrier\goversioninfo@v1.4.0\testdata\resource\* resource\
MOVE resource\versioninfo.json .\

@REM 在main.go 的第一行添加
@REM //go:generate goversioninfo -icon=resource/icon.ico -manifest=resource/goversioninfo.exe.manifest

@REM 首先用 go generate 命令生成 resource.syso 资源文件
go generate
go build -o yourappname.exe -ldflags="-linkmode internal"
