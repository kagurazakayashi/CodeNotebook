NSString *path = NSHomeDirectory();
// 上面的代码得到的是应用程序目录的路径，在该目录下有三个文件夹：Documents、Library、temp以及一个.app包！
// 该目录下就是应用程序的沙盒，应用程序只能访问该目录下的文件夹！！！

// 请参考下面的例子：
// 1、
NSString *path1 = NSHomeDirectory();
NSLog(@"path1:%@", path1);
// path1:/Users/yuanjun/Library/Application Support/iPhone Simulator/4.2/Applications/172DB70A-145B-4575-A31E-D501AC6EA830

// 2、
NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
NSLog(@"path2:%@", path2);
// path2:/Users/yuanjun/Library/Application Support/iPhone Simulator/4.2/Applications/172DB70A-145B-4575-A31E-D501AC6EA830/Library/Caches

// 3、
NSString *path3 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
NSLog(@"path3:%@", path3);
// path3:/Users/yuanjun/Library/Application Support/iPhone Simulator/4.2/Applications/172DB70A-145B-4575-A31E-D501AC6EA830/Documents

// 4、
NSString *path4 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
NSLog(@"path4:%@", path4);
// path4:/Users/yuanjun/Library/Application Support/iPhone Simulator/4.2/Applications/172DB70A-145B-4575-A31E-D501AC6EA830/Documents

// 5、
NSString *path5 = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
NSLog(@"path5:%@", path5);
// path5:/Users/yuanjun/Library/Application Support/iPhone Simulator/4.2/Applications/172DB70A-145B-4575-A31E-D501AC6EA830/Library

// 6、
NSString *path6 = [NSHomeDirectory() stringByAppendingPathComponent:@"temp"];
NSLog(@"path6:%@", path6);
// path6:/Users/yuanjun/Library/Application Support/iPhone Simulator/4.2/Applications/172DB70A-145B-4575-A31E-D501AC6EA830/temp

// https://www.cnblogs.com/gaoxiao228/archive/2012/04/18/2455376.html

// APP 文件路径
NSString *const runPath = [[NSBundle mainBundle] bundlePath];
