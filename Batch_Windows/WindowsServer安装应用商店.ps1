# Microsoft Store 应用商店安装

# 使用 Edge 打开 https://store.rg-adguard.net/ 。
Start-Process "https://store.rg-adguard.net/"
# 切换到 ProductFamilyName 选项，输入 Microsoft.WindowsStore_8wekyb3d8bbwe 并点击右侧的勾。
Set-Clipboard -Value "Microsoft.WindowsStore_8wekyb3d8bbwe"
# 按处理器搜索（例如 x64） ，下载所有依赖
# 下载 Microsoft.WindowsStore_*_neutral_~_8wekyb3d8bbwe.msixbundle 。
# 使用 PowerShell 命令 Add-AppPackadge 安装。

Add-AppPackage Microsoft.VCLibs.140.00_14.0.33519.0_x64__8wekyb3d8bbwe.Appx
Add-AppPackage Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe.Appx
Add-AppPackage Microsoft.UI.Xaml.2.8_8.2501.31001.0_x64__8wekyb3d8bbwe.Appx
Add-AppPackage Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe.Appx
Add-AppPackage Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe.Appx
Add-AppPackage Microsoft.UI.Xaml.2.4_2.42007.9001.0_x64__8wekyb3d8bbwe.Appx
Add-AppPackage Microsoft.WindowsStore_22503.1401.4.0_neutral_~_8wekyb3d8bbwe.Msixbundle
wsreset -i
