//
//  main.m
//  Created by 神楽坂雅詩 on 2023/7/1.
//

#import <Cocoa/Cocoa.h>

#define kExeFile @"run.sh"
#define kOpen @"/usr/bin/open"
#define kTerminal @"/System/Applications/Utilities/Terminal.app"
#define kResources @"Contents/Resources"

// 执行外部命令
int main(int argc, const char * argv[]) {
    NSString *const runPath = [[NSBundle mainBundle] bundlePath];
    NSString *const exeRunPath = [NSString stringWithFormat:@"%@/%@", runPath, kResources];
    [runPath release];
    NSString *const exePath = [NSString stringWithFormat:@"%@/%@", exeRunPath, kExeFile];
    NSArray *const arguments = [NSArray arrayWithObjects:@"-a", kTerminal, @"--args", exePath, nil];
    [exePath release];
    NSTask *const task = [[NSTask alloc] init];
    [task setCurrentDirectoryPath: exeRunPath];
    [exeRunPath release];
    [task setLaunchPath: kOpen];
    [task setArguments: arguments];
    [arguments release];
    // [task launch];
    NSError* Error = nil;
    @try{
        BOOL Result = [task launchAndReturnError:&Error];
        if ( !Result )
        {
            NSLog(@"没有返回");
        }
        NSLog(@"运行成功");
    } @catch (NSException* e){
        NSLog(@"运行失败：%@",task.executableURL);
    }
    [task release];
    return 0;
}
