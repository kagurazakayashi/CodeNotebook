# VisualStudio找不到标准库
**stdio.h No such file or directory**

注册表 
`计算机\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows Kits\Installed Roots`

检查 KitsRoot10 的内容是不是缺少 (x86)

<https://zhuanlan.zhihu.com/p/546006389>

vs2022 安装路径下，一堆props文件中，有一个 `Microsoft.Cpp.WindowsSDK.props` 文件，默认路径在 `C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Microsoft\VC\v170`

其中有两行指向了sdk的获取路径

```xml
<UniversalCRTSdkDir_10 Condition="'$(UniversalCRTSdkDir_10)' == ''">$(Registry:HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots@KitsRoot10)</UniversalCRTSdkDir_10>
<UniversalCRTSdkDir_10 Condition="'$(UniversalCRTSdkDir_10)' == ''">$(Registry:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Kits\Installed Roots@KitsRoot10)</UniversalCRTSdkDir_10>

<WindowsSdkDir_81 Condition="'$(WindowsSdkDir_81)' == ''">$(Registry:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.1@InstallationFolder)</WindowsSdkDir_81>
<WindowsSdkDir_81 Condition="'$(WindowsSdkDir_81)' == ''">$(Registry:HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v8.1@InstallationFolder)</WindowsSdkDir_81>
```

分别是SDK 10 和 SDK 8.1 对应的注册表路径。

到注册表中，找到对应的键值，修改为正确的路径。

在我电脑上，KitsRoot10 所指向的路径，是 `C:\Program Files\Windows Kits 10\`
