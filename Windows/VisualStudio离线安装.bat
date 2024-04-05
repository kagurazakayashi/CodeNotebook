@REM 创建 Visual Studio 本地缓存
@REM 创建包含所有功能的完整中文版本地缓存
vs_enterprise.exe --layout vs-D:\VisualStudioEnterprise2022Layout --lang zh-CN --all
@REM 包含其他语言
vs_enterprise.exe --layout D:\VisualStudioEnterprise2022Layout --lang zh-CN --lang zh-TW --lang en-US --lang ja-JP --all

@REM 创建后更新
@REM 出现较新版本时，可以通过互联网再次更新本地缓存，在原参数后面，添加“--useLatestInstaller”参数传递给引导程序，将其配置为最新的可用安装程序。
vs_enterprise.exe --layout D:\VisualStudioEnterprise2022Layout --lang zh-CN --lang zh-TW --lang en-US --lang ja-JP --useLatestInstaller --all

@REM 更新后删除旧版本
@REM 在“Archive”文件夹中，有一个或多个名为“GUID”的文件夹，其中每个都包含已过时的目录清单。
vs_enterprise.exe --layout D:\VisualStudioEnterprise2022Layout --clean D:\VisualStudioEnterprise2022Layout\Archive\1cd70189-fc55-4583-8ad8-a2711e928325\Catalog.json

@REM 修复文件
@REM 使用 --fix 执行与 --verify 相同的验证，并尝试修复标识的问题。
vs_enterprise.exe --layout D:\VisualStudioEnterprise2022Layout --fix


@REM 非内网环境单机安装
vs_enterprise.exe --noweb


@REM 内网服务器建立安装目录
@REM 将互联网电脑下载的本地缓存，通过移动硬盘复制到内网的网络共享文件夹，以便户可以从其他客户端计算机运行。网络地址一般为：\\server\share\layoutdirectory

@REM 修改共享文件夹下面的response.json 文件中的“channelUri”条目，将更新位置配置为指向共享文件夹。届时，内网中安装vs的计算机可以自动从该共享文件夹中更新程序。
@REM "channelUri": "\\\\server\\share\\layoutdirectory\\ChannelManifest.json"

@REM 内网安装
@REM 在客户端计算机以管理员身份运行PowerShell，输入以下命令
\\server\share\layoutdirectory\vs_enterprise.exe --noweb
@REM 在安装界面的上方最右侧的“安装位置”中，勾选“下载缓存”下方的“安装后保留下载缓存”。

@REM https://blog.csdn.net/weixin_45661908/article/details/123357078


@REM 社区版强制要求登录，不能完全离线使用
