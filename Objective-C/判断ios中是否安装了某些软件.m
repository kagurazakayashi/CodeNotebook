//如果想要准确的通过程序控制和发现本地安装的应用,目前只能在破解版的ios上开始显示，但是我们可以通过一些其他的途径获取到手机是否安装过某些应用。 Info.plist中添加URL Schemes ：*** 你访问的URL为：***:
// 从浏览器跳入到app中： （当系统中需要安装了该app，直接打开该app，若没有直接跳转到app下载页面。 暂时没好的解决方案，访问***:
//的同时，也打开app下载页面，使浏览器先操作***:
//，然后在打开app下载页面） 在AppDelegate中实现下面的方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
//从app跳入其他的app 这个方法判断手机中是否存在这个应用
[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"***://"]]
//如果返回YES则表示此应用在手机中安装过，反之则没有安装过. 还有一种，就是判断手机中有那些软件处于运行等待状态：
