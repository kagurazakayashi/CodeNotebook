@REM 使用 cmd 编译 .sln 项目并设置为 Release 和 x64
@REM 搜索并打开 Developer Command Prompt for VS ****

@REM 运行以下命令检查 msbuild 是否可用
msbuild /version

@REM 编译 .sln 项目
msbuild your_project.sln /p:Configuration=Release /p:Platform=x64
@REM /p:Configuration=Release：设置为 Release 配置。
@REM /p:Platform=x64：将目标平台设置为 x64。

@REM 如果只需要编译某个特定项目，可以使用：
msbuild your_project.sln /t:ProjectName /p:Configuration=Release /p:Platform=x64

@REM 检查环境变量中的 Visual Studio 路径
ECHO %VSINSTALLDIR%
@REM C:\Program Files\Microsoft Visual Studio\2022\Community\

@REM 取出路径到变量
if "%VSINSTALLDIR%"=="" (
    echo 错误: 可能不在 Developer Command Prompt 中
    exit /b
)
for /f "tokens=4 delims=\" %%A in ("%VSINSTALLDIR%") do (
    set VS_VERSION=%%A
)