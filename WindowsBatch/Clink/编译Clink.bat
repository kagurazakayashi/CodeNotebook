@REM Developer Command Prompt for VS **** :
@REM COPY premake5 .build\premake5.exe
@REM New: .build\build.bat :
RD /S /Q vs%VS_VERSION%
if "%VSINSTALLDIR%"=="" (
    echo NO: Developer Command Prompt
    exit /b
)
for /f "tokens=4 delims=\" %%A in ("%VSINSTALLDIR%") do (
    set VS_VERSION=%%A
)
ECHO Visual Studio Version: %VS_VERSION%
CD ..
.build\premake5.exe vs%VS_VERSION%
CD .build\vs%VS_VERSION%
msbuild /version
msbuild clink.sln /p:Configuration=Release /p:Platform=x64 /m
CD ..
