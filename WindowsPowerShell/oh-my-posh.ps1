# 管理员权限启动 PowerShell

# 运行命令以安装 posh-git，这是 oh-my-posh 的依赖。
Install-Module posh-git -Scope CurrentUser

# 如果此前没有安装 NuGet 提供程序，则此时会提示安装 NuGet；如果此前没有开启执行任意脚本，此处也会提示执行脚本。如果没有权限执行脚本，可能需要先执行
Set-ExecutionPolicy Bypass #没有问题则不用执行

# 安装 oh-my-posh 本身
Install-Module oh-my-posh -Scope CurrentUser

# 启用模组并设置主题

# 启用模组
Import-Module oh-my-posh

# 主题
Set-Theme
# name: Agnoster

# 显示 profile 文件在哪
$profile

# 设置 profile 文件让它自动启用，修改 $profile ，写下：
notepad $profile # 没有就新建一个
Import-Module oh-my-posh
Set-Theme Agnoster

# 下载 PowerLine 字体：
# https://github.com/powerline/fonts
# 克隆这个仓库，然后在克隆出来的文件夹中找到 Install.ps1 文件，执行它
.\install.ps1

# 在 PowerShell 或者 PowerShell Core 的标题栏上右击选择“属性”，然后选择你想要设置的字体就可以立刻看到效果了。注意，PowerLine 字体都是带有 for PowerLine 后缀的。

# https://blog.walterlv.com/post/beautify-powershell-like-zsh.html#%E5%AE%89%E8%A3%85%E5%AD%97%E4%BD%93%E5%AE%89%E8%A3%85%E7%AC%AC%E4%B8%89%E6%96%B9-powershell