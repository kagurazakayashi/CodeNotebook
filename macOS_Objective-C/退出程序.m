// 退出程序
// NSApp是一个保存应用程序对象的全局变量.[NSApplication sharedApplication]返回应用程序对象,如果这是第一次调用,则创建它,然后返回它
// -terminate:这不会简单地退出应用程序.-applicationShouldTerminate:如果实现,它将调用app delegate的方法.根据返回代码,代表可以取消终止或推迟决定.如果决定延期,则应用程序将以特殊模式运行,等待它.
// 如果应用程序(最终)终止,NSApplication将发布NSApplicationWillTerminateNotification通知.如果app delegate实现-applicationWillTerminate:,那么将通过发布该通知来调用该代理.代表可以做一些最后的清理工作.除了委托之外,该通知的任意其他观察者可能希望有机会进行清理.
[NSApp terminate:self];
[NSApp terminate:nil];
[[NSApplication sharedApplication] terminate:self];

// 呼叫exit(0)没有提供任何机会:
exit(0);
