// 执行外部命令
// 这是一个运行 /usr/bin/grep foo bar.txt 的例子
int pid = [[NSProcessInfo processInfo] processIdentifier];
NSPipe *pipe = [NSPipe pipe];
NSFileHandle *file = pipe.fileHandleForReading;

NSTask *task = [[NSTask alloc] init];
task.launchPath = @"/usr/bin/grep";
task.arguments = @[@"foo", @"bar.txt"];
task.standardOutput = pipe;

[task launch];

NSData *data = [file readDataToEndOfFile];
[file closeFile];

NSString *grepOutput = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
NSLog (@"grep returned: %@", grepOutput);



// 命令：./symbolicatecrash ./test.crash /liveapp.crash > log.crash
NSTask *task = [[NSTask alloc] init];
// 需要提前知道symbolicatecrash的所在位置
[task setLaunchPath:@"/Users/user/Documents/./symbolicatecrash"];//设置调用路径
NSPipe *pipe = [NSPipe pipe];
[task setStandardOutput:pipe];
NSFileHandle *file = [pipe fileHandleForReading];
//设置参数
[task setArguments:[NSArray arrayWithObjects:@"./test.crash",@"./liveapp.crash",@">",@"log.crash" ,nil]];
[task launch];
//获取返回值并输出
NSData *data = [file readDataToEndOfFile];
NSString *string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
NSLog(@"%@", string);//打印执行输出
