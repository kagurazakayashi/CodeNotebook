# 嚴重錯誤：您的開始功能表無法運作。我們將在您下次登入時嘗試修正此問題。
# 关键错误：你的开始菜单出现了问题。我们将尝试在你下一次登录时修复它。

# 修复 Windows 开始菜单
Get-AppXPackage -AllUsers | Foreach { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }

# https://www.zhihu.com/question/266218279/answer/324956810
