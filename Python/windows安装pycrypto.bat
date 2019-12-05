REM 开始菜单中 x86_x64 Cross Tools Command Prompt for VS 2019
%comspec% /k "D:\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsx86_amd64.bat"
REM 输入命令，修改路径中的版本号
set CL=-FI"%VCINSTALLDIR%Tools\MSVC\14.23.28105\include\stdint.h"
REM 安装
pip install pycrypto