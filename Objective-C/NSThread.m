// 主要用于讲解NSThread多线程的使用；
// 从线程创建与启动、线程的同步与锁、线程的交互、线程池等等四个方面简单的讲解一下iphone中的多线程编程；
 
// 一、线程创建与启动
// 线程创建主要有二种方式：
- (id)init; // designated initializer
- (id)initWithTarget:(id)target selector:(SEL)selector object:(id)argument;

// 当然，还有一种比较特殊，就是使用所谓的convenient method，这个方法可以直接生成一个线程并启动它，而且无需为线程的清理负责。这个方法的接口是：
// ?
+ (void)detachNewThreadSelector:(SEL)aSelector toTarget:(id)aTarget withObject:(id)anArgument
// 前两种方法创建后，需要手机启动，启动的方法是：
// ?
- (void)start;
　　
// 二、线程的同步与锁要说明线程的同步与锁，最好的例子可能就是多个窗口同时售票的售票系统了。iphone提供了NSCondition对象接口。查看NSCondition的接口说明可以看出，NSCondition是iphone下的锁对象，所以我们可以使用NSCondition实现iphone中的线程安全。这是来源于网上的一个例子：
// SellTicketsAppDelegate.h 文件
// SellTicketsAppDelegate.h
import <UIKit/UIKit.h>
 
@interface SellTicketsAppDelegate : NSObject <UIApplicationDelegate> {
int tickets;
int count;
NSThread* ticketsThreadone;
NSThread* ticketsThreadtwo;
NSCondition* ticketsCondition;
UIWindow *window;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@end


// SellTicketsAppDelegate.m 文件　　
// SellTicketsAppDelegate.m
import "SellTicketsAppDelegate.h"
 
@implementation SellTicketsAppDelegate
@synthesize window;
 
- (void)applicationDidFinishLaunching:(UIApplication *)application {
tickets = 100;
count = 0;
// 锁对象
ticketCondition = [[NSCondition alloc] init];
ticketsThreadone = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
[ticketsThreadone setName:@"Thread-1"];
[ticketsThreadone start];
 
 
ticketsThreadtwo = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
[ticketsThreadtwo setName:@"Thread-2"];
[ticketsThreadtwo start];
//[NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
// Override point for customization after application launch
[window makeKeyAndVisible];
 
}
 
- (void)run{
while (TRUE) {
　　// 上锁
　　[ticketsCondition lock];
　　if(tickets > 0){
　　　　[NSThread sleepForTimeInterval:0.5];
　　　　count = 100 - tickets;
　　　　NSLog(@"当前票数是:%d,售出:%d,线程名:%@",tickets,count,[[NSThread currentThread] name]);
　　　　tickets--;
　　}else{
　　　　break;
　　}
　　[ticketsCondition unlock];
　　}
}
 
- (void)dealloc {
[ticketsThreadone release];
[ticketsThreadtwo release];
[ticketsCondition release];
[window release];
[super dealloc];
}
@end


 
// 三、线程的交互线程在运行过程中，可能需要与其它线程进行通信，如在主线程中修改界面等等，可以使用如下接口
- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait


　
// 由于在本过程中，可能需要释放一些资源，则需要使用NSAutoreleasePool来进行管理,如：
 
- (void)startTheBackgroundJob {
NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
// to do something in your thread job
...
[self performSelectorOnMainThread:@selector(makeMyProgressBarMoving) withObject:nil waitUntilDone:NO];
[pool release];
}


　　
// 技术要点:一 线程创建与启动线程类 NSThread
// 包含如下线程操作方法:
 //返回当前线程
 + (NSThread *)currentThread;          
// 通过类方法创建一个线程
+ (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(id)argument;
// 判断是否为多线程
+ (BOOL)isMultiThreaded;

- (NSMutableDictionary *)threadDictionary;
+ (void)sleepUntilDate:(NSDate *)date;
+ (void)sleepForTimeInterval:(NSTimeInterval)ti;
// 退出线程
+ (void)exit;
// 线程属性值
+ (double)threadPriority ;+ (BOOL)setThreadPriority:(double)p ;
// 线程函数地址
+ (NSArray *)callStackReturnAddresses;
// 设置与返回线程名称
- (void)setName:(NSString *)n;
- (NSString *)name;
// 线程堆栈
- (NSUInteger)stackSize;
- (void)setStackSize:(NSUInteger)s;
// 判断当前线程是否为主线程
- (BOOL)isMainThread;+ (BOOL)isMainThread;
+ (NSThread *)mainThread;
// 线程对象初始化操作   (通过创建线程对象 ,需要 手工指定线程函数与各种属性)
- (id)init;
// 在线程对象初始化时创建一个线程(指定线程函数)
- (id)initWithTarget:(id)target selector:(SEL)selector object:(id)argument;
// 是否在执行
- (BOOL)isExecuting;
// 是否已经结束
- (BOOL)isFinished;
// 是否取消的
- (BOOL)isCancelled;
// 取消操作
- (void)cancel;
// 线程启动
- (void)start;
- (void)main;    // thread body method
// 推荐方式
// 通过类方法创建一个线程
+ (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(id)argument;
// 在线程对象初始化时创建一个线程(指定线程函数)
- (id)initWithTarget:(id)target selector:(SEL)selector object:(id)argument;
// 主要通过selector:(SEL)selector 指定个功能函数,系统使其与主线程分开运行,以达到多线程的效果.
// 以上方式创建线程,非类方法创建需要调用 start才能让线程真正运行起来.
// 当多个线程同时运行,就会出现访问资源的同步问题
// 二 线程同步操作
// IPHONE 使用NSCondition来进行线程同步,它是IPHONE的锁对象,用来保护当前访问的资源.
// 大致使用方法
NSCondition* mYLock = [[NSCondition alloc] init];
[mYLock lock]
// 资源....
[mYLock unLock];
[mYLock release];
// 三 线程的交互 使用线程对象的
- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait
// 进行交互操作主要是调用 主线程中指定的方法来执行一些相关操作
// 四 线程池 NSOperationNSInvocationOperation是 NSOperation的子类 具体使用代码
// 建立一个操作对象
NSInvocationOperation* theOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(myTaskMethod:) object:data];
// 将操作对象 加到系统已经的操作对列里, 这时候 myTaskMethod以一个线程的方式与主线程分开执行.
[[MyAppDelegate sharedOperationQueue] addOperation:theOp];
// 这个是真正运行在另外一个线程的“方法”
- (void)myTaskMethod:(id)data{
    // Perform the task.}
// 以上是使用系统操作对列,可以使用 NSOperationQueue创建自己的线程对列
NSOperationQueue *operationQueue; 
operationQueue = [[NSOperationQueue alloc] init]; //初始化操作队列
[operationQueue setMaxConcurrentOperationCount:n]; // 可以设置队列的个数 
[operationQueue addOperation:otherOper];
// 线程创建与撤销遵循 OC的内存管理规则.