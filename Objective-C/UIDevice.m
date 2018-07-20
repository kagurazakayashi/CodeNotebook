// 1. 判断是否是横向屏：
BOOL b=UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
// 获取设备uniqueIdentifier ：
[UIDevice currentDevice].uniqueIdentifier;，但在ios5中，它已被废弃。
     http://kensou.blog.51cto.com/3495587/655083
[[UIDevice currentDevice] systemName];
[[UIDevice currentDevice] systemVersion];//os version
[[UIDevice currentDevice] uniqueIdentifier];
[[UIDevice currentDevice] model];
[[UIDevice currentDevice] name];
/*
真机上结果：
System Name: iPhone OS
System Version: 4.2.1
Unique ID: 9b5ded78d5fa0ac96250f8b4af0e46f40b96ea6d
Model: iPhone
Name: “wwk”的 iPhone
模拟器上结果：
System Name: iPhone OS
System Version: 4.2
Unique ID: 21FFE0FF-429B-5D0B-96D2-EADCA3203260
Model: iPhone Simulator
Name: iPhone Simulator
uniqueIdentifier：iPhone通过，向几个硬件标识符和设备序列号应用内部散列算法，而生成这一标识符。
*/


// 2.电池事件通知及电池状态：电池水平是一个浮点值，从0.0完全放电，到1.0完全充满。

[NSLog:@"Battery level: %0.2f%", [[UIDevice currentDevice] batteryLevel] * 100];
NSArray *stateArray = [NSArray arrayWithObjects: @"Unknown", @"not plugged into a charging source", @"charging", @"full", nil];
[NSLog:@"Battery state: %@", [stateArray objectAtIndex:[[UIDevice currentDevice] batteryState]]];



// 获得更多设备信息：使用sysctlbyname(),sysctl()标准unix函数。
// 在sys/sysctl.h中提供了一些设备信息常量。要注意先要#include <sys/socket.h>。
// 具体的参考《秘籍2》14.3重新获得更多设备信息。
// hw.machine的值，第一代iPhone为(iPhone1,1)，iPhone3g为(iPhone1,2)，iPhone3gs为(iPhone2,1)，模拟器上为x86_64。


// 3.传感器。
//   启用接近传感器后，它检测前方是否存在一个大型物体，如果有，它会关闭屏幕，并发出一般性通知。当障碍物移走后，会重新打开屏幕。这可以防止在通知过程中，误用耳朵触碰按钮。
  还要防止一些保护套会影响传感器工作。

  [UIDevice currentDevice].proximityMonitoringEnabled=YES;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleStateChange:) name:@"UIDeviceProximityStateDidChangeNotification" object:nil];    


// 4.加速度。
//    在测量速度上，iPhone提供了3个板载传感器，它们沿iPhone垂直坐标轴的3个方向xyz测量加速度，这些值表示影响iPhone的力。

   [[UIAccelerometer sharedAccelerometer] setDelegate:self];//UIAccelerometerDelegate
   - (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float xx = -[acceleration x];
    float yy = [acceleration y];
    float angle = atan2(yy, xx);
    [arrow setTransform:CGAffineTransformMakeRotation(angle)];
}



// 5.检测设备方向：横线或纵向。
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications]; // not actually required but a good idea in case Apple changes this
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
//在viewController中重写shouldAutorotateToInterfaceOrientation

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) anOrientation
{
    return (anOrientation == UIDeviceOrientationPortrait || 
    anOrientation == UIDeviceOrientationLandscapeRight ||
    anOrientation == UIDeviceOrientationLandscapeLeft ||);
   //iPhone不建议使用UIDeviceOrientationPortraitUpsizeDown

}

- (void) orientationChanged: (id) sender
{
    NSLog(@"Orientation changed to %@", [UIDevice currentDevice].orientationString);//当前设备方向
}
// 两个内置的宏辅助判断方向

UIDeviceOrientationIsPortrait(anOrientation) 
UIDeviceOrientationIsLandscape(anOrientation)



// 6.摇晃检测  ShakeDetection。
//   响应链：响应链提供了层级对象，一个事件若被起始处的对象接收，它不会再被向下传递；否则，继续向下传递。
//   对象通常是通过[self becomeFirstResponder];声明自身为第一响应者。[self resignFirstResponder];声明退出第一响应者。第一响应者接收所有运动和触摸事件。
  - (BOOL)canBecomeFirstResponder {return YES;}
// 有如下3个运动回调函数可以被覆盖，它们定义在UIResponder中：

 - (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event 
 - (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event 
 - (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event 


// 7.磁盘空间
  NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fattributes = [fm fileSystemAttributesAtPath:NSHomeDirectory()];
   System space:[[fattributes objectForKey:NSFileSystemSize] longLongValue];
  System free space: [[fattributes objectForKey:NSFileSystemFreeSize] longLongValue];



// 8.iTunes通过在info.plist中列出的设备功能列表，确定一个程序是否可以下载到指定设备中并正常运行。


// 9.在AVAILABILITY.h文件中有版本宏定义，例如：__IPHONE_4_2
// 这个是os version还是sdk version，或者它们是相同的？
// http://www.opensource.apple.com/source/CarbonHeaders/CarbonHeaders-18.1/Availability.h


NSString* udid=[[UIDevice currentDevice] uniqueIdentifier];
    return udid;

//改为在最上层使用了一层button来响应点击事件
 /*
 else
 {
  NSString* systemVersion=[[UIDevice currentDevice] systemVersion];
  float floatVersion=[systemVersion floatValue];
  NSLog(@"systemVersion:%@,floatVersion:%f",systemVersion,floatVersion);
  if(floatVersion<5.0)
  {
   //in ios5，每层UIView均会响应touchesEnded，所以ios5不用这里向上调了。
   ret=[(ViewGroupWrap*)iSuperViewWrap handleTouch];
  }
 }
 */



// 11. coding区分iphone ipod & ipad 的几种方法
    //  (1)使用  UI_USER_INTERFACE_IDIOM() 进行区分 ,
             UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad    //ipad
             UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone    //iPhone

// (2）使用 UIDevice.model 进行区分 

    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
    }
    else {
        //iPad
    }

// (3)使用系统的一个函数sysctlbyname 来获取设备名称

- (NSString *) platformString
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    return @"";
}


//  参考    http://hi.baidu.com/songxiaoweiss/blog/item/c78162f869fc148c58ee9028.html


// 12.关于获取IMSI号  
    //  CoreTelephony.framework，
    //  头文件内容
     extern NSString* c*****t kCTSMSMessageReceivedNotification;
extern NSString* c*****t kCTSMSMessageReplaceReceivedNotification;
extern NSString* c*****t kCTSIMSupportSIMStatusNotInserted;
extern NSString* c*****t kCTSIMSupportSIMStatusReady; 
id CTTelephonyCenterGetDefault(void);
void CTTelephonyCenterAddObserver(id,id,CFNotificationCallback,NSString*,void*,int);
void CTTelephonyCenterRemoveObserver(id,id,NSString*,void*);
int CTSMSMessageGetUnreadCount(void); 
int CTSMSMessageGetRecordIdentifier(void * msg);
NSString * CTSIMSupportGetSIMStatus();   //获取sim卡状态，kCTSIMSupportSIMStatusNotInserted表示没有sim卡
NSString * CTSIMSupportCopyMobileSubscriberIdentity();  //获取imsi号码
id  CTSMSMessageCreate(void* unknow/*always 0*/,NSString* number,NSString* text);
void * CTSMSMessageCreateReply(void* unknow/*always 0*/,void * forwardTo,NSString* text); 
void* CTSMSMessageSend(id server,id msg); 
NSString *CTSMSMessageCopyAddress(void *, void *);
NSString *CTSMSMessageCopyText(void *, void *);


// 调用CTSIMSupportCopyMobileSubscriberIdentity能成功获取到IMSI号
// 用performSelector来逃过苹果的检查